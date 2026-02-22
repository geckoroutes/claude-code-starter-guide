---
name: soc2-compliance
description: SOC 2 compliance patterns — access controls, data protection, audit logging, security practices
user-invokable: false
---

# SOC 2 Compliance

Apply these patterns when building features that handle user data, authentication, or sensitive operations.

## Trust Service Criteria (TSC)

SOC 2 audits evaluate five categories. Most SaaS products need Security + Availability + Confidentiality.

### 1. Security (Common Criteria — always required)
- **Access control**: Role-based (RBAC), least privilege, no shared accounts
- **Authentication**: MFA for admin, strong password policy, session timeout
- **Encryption**: TLS 1.2+ in transit, AES-256 at rest for sensitive data
- **Network security**: Firewall rules, no unnecessary open ports, VPN for admin access
- **Change management**: All changes via PR, code review required, no direct production edits
- **Vulnerability management**: Dependency scanning, security headers, OWASP Top 10

### 2. Availability
- **Uptime monitoring**: Health checks, status page, alerting
- **Backup strategy**: Automated backups, tested restores, offsite storage
- **Incident response**: Documented runbook, escalation path, post-mortem process
- **Capacity planning**: Auto-scaling or documented growth limits

### 3. Confidentiality
- **Data classification**: Know what's sensitive (PII, credentials, financial data)
- **Access logging**: Who accessed what, when (audit trail)
- **Data retention**: Define how long data is kept, automated deletion
- **Encryption**: Sensitive fields encrypted at rest (not just disk-level)

### 4. Processing Integrity
- **Input validation**: Server-side validation on all inputs
- **Error handling**: No stack traces in production, meaningful error messages
- **Data consistency**: Database transactions, idempotent operations
- **Monitoring**: Alert on anomalous data patterns

### 5. Privacy
- **Consent**: Explicit opt-in for data collection
- **Data minimization**: Only collect what's needed
- **Right to delete**: Users can request data deletion (GDPR Art. 17)
- **Privacy policy**: Clear, accessible, up-to-date

## Implementation Patterns

### Authentication
```
- Supabase Auth / NextAuth / similar managed auth
- Session-based with httpOnly secure cookies
- MFA for admin roles
- Password: min 8 chars, no common passwords
- Account lockout after 5 failed attempts
- Session timeout: 24h for users, 1h for admin
```

### Authorization (RBAC)
```
- Roles: admin, user, viewer (minimum viable)
- Permissions checked server-side (never trust client)
- Row-level security (Supabase RLS) where applicable
- API routes check auth before any data access
```

### Audit Logging
Every sensitive action should log:
```json
{
  "timestamp": "ISO 8601",
  "actor": "user_id or system",
  "action": "create|read|update|delete|login|export",
  "resource": "what was affected",
  "ip": "client IP",
  "result": "success|failure",
  "details": "additional context"
}
```
Store logs immutably (append-only table or external service). Retain for 1 year minimum.

### API Security
- Rate limiting on all endpoints (especially auth)
- CORS configured to specific origins (not `*`)
- CSRF protection on state-changing requests
- Input sanitization (prevent XSS, SQL injection)
- No sensitive data in URLs (use POST body or headers)
- API keys: rotatable, scoped, never in client-side code

### Data Protection
- Environment variables for secrets (never in code)
- `.env` files in `.gitignore`
- Database credentials rotated periodically
- Backups encrypted
- PII fields: consider encryption at application level

### Security Headers
```
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 0  (rely on CSP instead)
Content-Security-Policy: default-src 'self'; script-src 'self'
Strict-Transport-Security: max-age=31536000; includeSubDomains
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
```

### Dependency Management
- `npm audit` / `pip audit` in CI
- Dependabot or Renovate for automated updates
- Pin major versions, allow patch updates
- Review changelogs before major upgrades

## Quick Checklist for New Features

Before shipping any feature that touches user data:
- [ ] Auth check on the endpoint/page
- [ ] Input validation (server-side)
- [ ] Audit log entry for sensitive actions
- [ ] No secrets in client-side code
- [ ] Error messages don't leak internal details
- [ ] Rate limiting if publicly accessible
- [ ] Data retention policy considered

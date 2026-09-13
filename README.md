# Pseudoscience Threat Intelligence & Health Claim Linter

An evidence-based platform and automated compliance engine designed to counter health misinformation, unmask deceptive marketing, and verify health claims against scientific consensus and FDA/FTC regulatory standards.

---

## Key Features

1. **Claims Directory & Consensus Breakdown (`/claims`)**
   - Public repository of trending health and pseudoscience claims.
   - Plain-English scientific explanations detailing why unproven therapies fail or cause harm.
   - Hazard severity scores (1 to 5) and links to official FDA/FTC warning letters and enforcement actions.
   - Direct linkages to peer-reviewed clinical trials (PubMed / Cochrane).

2. **The Health Claim Compliance Linter (`/linter`)**
   - Real-time pre-publish linter ("Grammarly for Health Claims") for supplement brands, agencies, and copywriters.
   - Scans copy for illegal disease claims (FDA 21 CFR 101.93) and deceptive marketing (FTC Act Section 5).
   - Generates compliant structure/function rewrite suggestions (e.g., reframing disease treatment into normal physiological support).

3. **Community Submission Pipeline (`/reports/new`)**
   - Form for reporting suspicious claims found on TikTok, Meta ads, Instagram Reels, and forums.

4. **Developer REST API (`/api/v1`)**
   - `POST /api/v1/lint` — Programmatic text inspection returning compliance status, hazard scores, and compliant rewrite suggestions.
   - `GET /api/v1/claims` — List and filter indexed claims.
   - `GET /api/v1/claims/search?q=:query` — Search indexed claims by keyword.

---

## Tech Stack

- **Ruby:** 3.2.2 (pinned in `.ruby-version`)
- **Framework:** Ruby on Rails 7.2.3.2
- **Database:** PostgreSQL (with `pg` adapter)
- **Frontend & CSS:** Hotwire (Turbo + Stimulus) with Tailwind CSS
- **Testing:** RSpec Rails 7.1, FactoryBot, Faker (33 unit/request specs, 0 failures)

---

## Local Development Setup

### 1. Prerequisites
- Ruby 3.2.2
- PostgreSQL running locally

### 2. Installation
```bash
git clone git@github.com:PomodroizerLTD/pseudoscience.git
cd pseudoscience
bundle install
```

### 3. Database Setup & Seeding
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### 4. Running the Development Server
```bash
bin/dev
# Or directly:
bin/rails server -p 3000
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Running the Automated Test Suite

```bash
bundle exec rspec
```

---

## API Examples

### Check Copy for Prohibited Claims
```bash
curl -X POST http://localhost:3000/api/v1/lint \
  -H "Content-Type: application/json" \
  -d '{"text": "Our mushroom tincture cures clinical depression and eliminates cancer cells."}'
```

**Response:**
```json
{
  "status": "prohibited_claims",
  "risk_score": 5,
  "compliant": false,
  "summary": "Identified 2 compliance issue(s). Highest risk severity: 5/5.",
  "flagged_count": 2,
  "flagged_segments": [
    {
      "matched_text": "cures clinical depression",
      "category": "Illegal Disease Claim",
      "severity": 5,
      "regulation": "FDA 21 CFR 101.93 & FTC Act Section 5",
      "reason": "Dietary supplements and cosmetics cannot claim to cure, treat, mitigate, or reverse specific clinical diseases.",
      "suggested_replacement": "supports a balanced mood and mental well-being"
    },
    {
      "matched_text": "eliminates cancer",
      "category": "Illegal Disease Claim",
      "severity": 5,
      "regulation": "FDA 21 CFR 101.93 & FTC Act Section 5",
      "reason": "Dietary supplements and cosmetics cannot claim to cure, treat, mitigate, or reverse specific clinical diseases.",
      "suggested_replacement": "provides dietary antioxidant support for healthy cells"
    }
  ]
}
```

### Search Claims
```bash
curl "http://localhost:3000/api/v1/claims/search?q=bleach"
```

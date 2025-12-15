;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — jusys

(ecosystem
  (version "1.0.0")
  (name "jusys")
  (type "project")
  (purpose "*Privacy-First, GDPR-Compliant Application Auditing & Migration Planning Tool*")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "*Privacy-First, GDPR-Compliant Application Auditing & Migration Planning Tool*")
  (what-this-is-not "- NOT exempt from RSR compliance"))

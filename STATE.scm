;; SPDX-License-Identifier: AGPL-3.0-or-later
;; STATE.scm - Current project state

(define project-state
  `((metadata
      ((version . "0.1.0")
       (schema-version . "1")
       (created . "2026-01-02T19:45:00+00:00")
       (updated . "2026-01-02T19:45:00+00:00")
       (project . "System Observatory")
       (repo . "system-observatory")))

    (current-position
      ((phase . "Phase 0: Bootstrap")
       (overall-completion . 10)
       (working-features . ())))

    (route-to-mvp
      ((milestones
        ((v0.1 . ((items . ("Repo structure"
                            "README with scope"
                            "Contract dependencies identified"
                            "Language decision finalized"))))
         (v0.2 . ((items . ("Metrics schema"
                            "Run bundle ingestion format"
                            "Recommendation output format"))))
         (v0.3 . ((items . ("Metrics store implementation"
                            "Basic correlation engine"
                            "CLI commands"))))))))

    (blockers-and-issues
      ((critical . ())
       (high . ())
       (medium . ())
       (low . ())))

    (critical-next-actions
      ((immediate . ("Define metrics schema in system-tools-contracts"))
       (this-week . ("Elixir project scaffold"))
       (this-month . ("Metrics store MVP"))))

    (session-history
      ((("2026-01-02" . ((accomplishments . ("Initial repo creation"
                                              "README.adoc with scope and constraints"
                                              "ROADMAP.adoc with phased plan"
                                              "STATE.scm initialized"))))))))

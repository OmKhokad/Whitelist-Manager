;; Whitelist Manager Contract
;; A simple contract to manage and verify a list of approved addresses.

;; Owner constant
(define-constant contract-owner tx-sender)

;; Error constants
(define-constant err-owner-only (err u100))
(define-constant err-already-whitelisted (err u101))

;; Whitelist storage (principal - bool)
(define-map whitelist principal bool)

;; Function 1: Add to whitelist (only owner)
(define-public (add-to-whitelist (user principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-none (map-get? whitelist user)) err-already-whitelisted)
    (map-set whitelist user true)
    (ok true)
  )
)

;; Function 2: Check if an address is whitelisted
(define-read-only (is-whitelisted (user principal))
  (ok (default-to false (map-get? whitelist user)))
)

#!/usr/bin/env janet
# A simple finger client

(defn usage []
  (printf "usage: finger [user@domain.name]\n")
  (os/exit 1))

(defn query [arg]
  (var server (string/split "@" arg))
  (def user (in server 0))
  (var host nil)
  (try
    (set host (in server 1))
    ([_] (usage)))
  (with [conn (net/connect host 79 :stream)]
    (:write conn (string/format "%s\r\n" user))
    (def res (:read conn :all))
    (print res)))

(cond
  (= (length (dyn :args)) 2) (query (in (dyn :args) 1))
  (usage))

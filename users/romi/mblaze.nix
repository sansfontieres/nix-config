{pkgs, ...}: {
  xdg.configFile."mblaze/filter".text = ''
    text/plain: mflow -f
    text/html: w3m -dump -o display_link_number=1 -I $PIPE_CHARSET -T text/html
  '';

  xdg.configFile."mblaze/headers".text = ''
    Content-Type: text/plain; charset=UTF-8; format=flowed
  '';

  xdg.configFile."mblaze/profile".text = ''
    Sendmail: ${pkgs.msmtp}/bin/msmtp
    Sendmail-Args: --read-envelope-from --read-recipients
    Outbox: ~/tmp/mail/Drafts
    Local-Mailbox: romi <romi@grtsk.net>
    Alternate-Mailboxes: Romi Hervier <r@sansfontieres.com>, Romi Hervier <rh@grtsk.net>
    FQDN: sansfontieres.com
    Scan-Format: %-3n %c%u%r %19d %19f %t %2i%s
  '';

  xdg.configFile."mblaze/mlesskey".text = ''
    R shell mrep\n
    D shell mflag -S . && mrefile . $MAILDIR/Trash\n
    Y shell mflag -S . && mrefile . $MAILDIR/Archive\n
    O shell mshow -Hr > /tmp/m.eml && open /tmp/m.eml && pressany && rm /tmp/m.eml\n
    S shell mflag -S . && mseq -f | mseq -S\n
    s shell mflag -s . && mseq -f | mseq -S\n
    F shell mflag -F . && mseq -f | mseq -S\n
    f shell mflag -f . && mseq -f | mseq -S\n
  '';
}

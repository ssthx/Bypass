#!/data/data/com.termux/files/usr/bin/bash

TMP_FILE="/data/data/com.termux/files/usr/tmp/.exec_prot.sh"

base64 -d << 'EOF' > "$TMP_FILE"
CiMhL2RhdGEvZGF0YS9jb20udGVybXV4L2ZpbGVzL3Vzci9iaW4vYmFzaAoKIyBTZXUgY8OzZGlnbyBjb21wbGV0byB2aXJpYSBhcXVpCmVjaG8gIkV4ZWN1dGFuZG8gc2NyaXB0IGNvbSBwcm90ZcOnw6NvIGJhc2U2NC4uLiIK
EOF

chmod +x "$TMP_FILE"
su -c "$TMP_FILE"
rm -f "$TMP_FILE"

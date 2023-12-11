#!/bin/sh

cat >.git/hooks/pre-commit <<EOF
#!/bin/sh

# Generate SV files
mill r
git add thinpad_top.srcs
EOF

chmod +x .git/hooks/pre-commit

#!/usr/bin/env bash
(
cat <<EOF
agent.auto.register.key=${GO_AGENT_AUTOREGISTER_KEY}
agent.auto.register.resources=${GO_AGENT_AUTOREGISTER_RESOURCE}
agent.auto.register.hostname=${GO_AGENT_AUTOREGISTER_RESOURCE}_agent
EOF
) > $GO_AGENT_DIR/config/autoregister.properties

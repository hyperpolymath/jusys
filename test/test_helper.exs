# SPDX-License-Identifier: AGPL-3.0-or-later

# Stop application to prevent conflicts with test supervision
Application.stop(:jusys)

ExUnit.start()

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40892F2EB2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfKGNBO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:01:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNBO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:01:14 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAfQk-1idk0d0Uye-00B74F; Thu, 07 Nov 2019 14:00:31 +0100
Date:   Thu, 7 Nov 2019 14:00:29 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: add parallax ping sensors
Message-ID: <20191107130027.k2uo547xrfiuxgb7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:U8Bhu4Vf+4KzVDN7o7hwZXPSjh260AOQqJZxXo1LOYq9R7wx45l
 qnicUAjmKFHfet4tBWVuSROasrooJ/jiN46LNHswEIXeLVnUN7glkp4VpgR/Sn1RYDC7kD9
 TevZhF2xS/c0uONj+wFOiWRBuZWSs9TUpXBGGkeNEXqBDONi2jliQKZWPdxalt3+TgYcb39
 +0EOWafbZeC+SJC4ELJ9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7uSPIhWC6ns=:eGFlqo4N96XxVf0BxSzsKM
 9S48F5JPNhf2Zqu1arX8XktQ2tg688u1oGwiLzTZWQPSiUR1s1mre/Zfb0BhbSq5HxTNaiRH2
 iOwE4P713IPTnNujXHS7Tvyy+JATPfl8vGZj2N4PKFe0QUE9sCmla7gDWEhx6pwHJzj7HpxJF
 4ePuKHdm7oKT5l2uZ+xGBdbbLXRSspZcQ4k1KaXd1hTUcj2it8LgnQAakp3tPIBSFjjM3IIWI
 jmfcpenTyhMpSc/ofkcEsN94qOxPOTGf04+4UMj1Qimch9QPHsZoOhu4oDFXkcjvHSs6JyLxl
 Km3oY0UdoNe5Hk9DWOAp4kPwHU/IWEncMUwU53i4uUsPEAJXfrHBX7JIgOl2p7UEAHnFCFayP
 iaCLi7AMI8YStH/Mr/z+A3f2vT+pDbDAsDIYOrg8SH/SzBFF606CYXkn8SdnG5XiGQxzst5JJ
 CWGg8YAWmYHloaPhRPGv6z9oaK8s5IZkEUkTrI/Bn/dWa9/8rvndZMLWAEd9RGr/71iuRkThy
 D2kNS1PkFBGkoTJ+L21/SVtIx3dcOfGBWKU0rUUGx/CJnDsPxA9Ct4JccU2AGeQ4Wl7nggegh
 ExUzzlyGyqk9DdHi+JK1HsMQHzqfyeMwPenI2T3Y0IdVpQo7T07rF/Zdtx3gTJyBUxos04mxf
 3P32st9l0vLARle1URYRjJ5btNRR85j48MZPEVrlSeSoeNktplCPMcNpXL3K3/XZ3e92TxNqk
 gEAcEBmh8dstwu84DiejN3hM+O+lht7Jlenmlp1ZGKjg5rENWLlp4cTRlzDsSdxMAkvMtTCDx
 ghKQPadixhSaUSjWzovcPQw3eMTGUsZ4bK6wtapZ2PfLz3fBBt+USdaY0vAi4jF21ZlEE+aBf
 vSSlAcyCaq0IkZX6fI8g==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
are used for measuring distances.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/parallax-ping.yaml      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
new file mode 100644
index 000000000000..ab8dbdf4f04a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/parallax-ping.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parallax PING))) and LaserPING range finder
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  Bit-banging driver using one GPIO:
+  - ping-gpio is raised by the driver to start measurement
+  - direction of ping-gpio is then switched into input with an interrupt
+    for receiving distance value as PWM signal
+
+  Specifications about the devices can be found at:
+  http://parallax.com/sites/default/files/downloads/28041-LaserPING-2m-Rangefinder-Guide.pdf
+  http://parallax.com/sites/default/files/downloads/28015-PING-Documentation-v1.6.pdf
+
+properties:
+  compatible:
+    enum:
+      - parallax,ping
+      - parallax,laserping
+
+  ping-gpios:
+    description:
+      Definition of the GPIO for the triggering and echo (output and input)
+      This GPIO is set for about 5 us by the driver to tell the device it
+      should initiate the measurement cycle. Afterwards the GPIO is switched
+      to input direction with an interrupt. The device sets it and the
+      length of the input signal corresponds to the measured distance.
+      It needs to be an GPIO which is able to deliver an interrupt because
+      the time between two interrupts is measured in the driver.
+      See Documentation/devicetree/bindings/gpio/gpio.txt for information
+      on how to specify a consumer gpio.
+    maxItems: 1
+
+required:
+  - compatible
+  - ping-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    proximity {
+        compatible = "parallax,laserping";
+        ping-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.11.0

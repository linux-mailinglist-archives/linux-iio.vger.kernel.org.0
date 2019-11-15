Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13091FD73A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 08:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfKOHpA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 02:45:00 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:35675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfKOHpA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 02:45:00 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MK3iK-1iA0Jd1NOg-00LWk0; Fri, 15 Nov 2019 08:44:31 +0100
Date:   Fri, 15 Nov 2019 08:44:26 +0100
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
Subject: [PATCH v2 2/4] dt-bindings: add parallax ping sensors
Message-ID: <20191115074424.cnk3xleobvusfuci@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ytksLX1QdienrOpTyd8pjskwNFuwhg3DkSuEDjFDgmZ6NADYEu7
 fzIOm3+k4JWt4PdA1nSXgcTgX9UTwFXTXQFBjUpn1WKpR2WKWkl7gyONa3MLRSkLawxJaqE
 ih/2WEfG7qt07682hK8vGkTUZN0fDasSImpcBkpyhuMeVqhcPU9B2ZYrC0oghWdpYYS0OGh
 o5zSDzpRwH/20j2aQwH8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lwflk3bVUg8=:wQHblJLLecJ0Yw5syH/Ajc
 S5qowF2G8gIxUhXqzeBt4wonkXUt0h8VtvQQg56sZPC4wbitwM5JbyygehrR46krV8KyaNjMY
 SFz4R34zZnKMfvfnhnuRzK84ERHu8xBePfOz2W2Ht3GSt2VxmJXOGcW+F5zmMkL+IdHpJGJgB
 8tAsKFRk2+hETFpCM5qVzv3fLOO8/NxLG0PcjS3BxBjEEDRxuC9OAznV3Q2tC2YAKviwkflct
 XayQ/uyTrtOf0Ds7Z8FLNgSvd7BrHXMhA+lxbOUUi0jpu+N7UmhO/m9EM3+gQMA/AiFHQPAV3
 qPI46x4CfUvJOBkrPdScVZm7rBT2fn1PupJ/OlyJrqf5Suu0awlt5JJLKn6Gy4xdjyncKdir2
 0Mx0nxdOaGX++/IS8LGSHsz6sRgWQsegq4JgMlk7GtZ+k3PyKbP1bI7EhqNkXptVuBs/H6Csr
 Jmah4zukpA/JP43iwFe3AEPuGXCnBmSQpoIt7vJ1VqHL52Fkvy8PiRfQT6bRs8vfrSZ3FpL5X
 iuq75ypfe58c0UaYvx5Y41sS3DpwUxpbgWPkDWsgm6BCK0p0gEpa+7iJ7+J4tymyfuZ53qw/R
 4l8F0DR1d/LZSynuh1Q56c/PtfldhTrbPrKuxxhuq8ZlfIQrAGoq0Bf4WtrqnvzqWJxfLNOTC
 Elf+DU6asz0GfqzhEMzMxgDFc1tlBHT7Kf00s8b1/ODQtS1ocoM8/F1hRsEeYz5r2Zd6WBX/f
 Cl3eBhB+aB9RVJIxYgGJFfvigZyZHRsNc3t5VHkKoKssWc/wtqy082RKCEftIt7wTS9VXFa63
 zSI8im30ZHbQ7gkUC1fjNivFr5WE0aY7wa7Oa1RFxLu/r1HvMudvEw5o/11xpWWgF5fLeAiEG
 27oIZ1tjxd6anE4jXo8Q==
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
index 000000000000..a079c9921af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
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
+  - ping-gpios is raised by the driver to start measurement
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

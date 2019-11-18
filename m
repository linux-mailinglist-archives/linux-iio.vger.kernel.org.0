Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999BDFFF95
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 08:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKRHgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 02:36:49 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfKRHgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 02:36:49 -0500
Received: from localhost ([185.35.208.129]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnpP8-1i3dg71iXK-00pOvd; Mon, 18 Nov 2019 08:36:13 +0100
Date:   Mon, 18 Nov 2019 08:36:12 +0100
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
Subject: [PATCH v3 2/4] dt-bindings: add parallax ping sensors
Message-ID: <20191118073611.pvge47kgupu6omrf@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:yVseu36YheWCygoGq+ft3p0e0iu8fgGoKVfl3cImcfWXq7IcQ9v
 64IAheX8Irfb2fO312Ve/wzH2zy/MAH7M+GlZpMlrXI3zSCniIfWpiaD6/Skwy6o/TifgE9
 NzCq2LrIS+SsWfF+DB98Du8F691gjwNijTTZtEKyRkDS968omddwyzSGzj/oA2FMtBacECv
 bgNshXrgyCIa5aLeWs3+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DYhdsw6dcKk=:NqfLp2QdMcVk0WkrnIOvz5
 b6dteCGGPpVjdM/dysyfVLmCY+HICoFmMOMYrZoXxDGp/J/4yb0IPJL0ZEaw3y3pwk5ISwM7Y
 TmkMMQzkkrCGeMlbVxfozmx3eWunPL+FrQD8DzXIagziVyl8hNOHngXhXZ7rbHKOK8JE6Sucy
 6OcoHhP5AGR+VNi7081U3VFobDQ2/i8LKUjQ6dGtafMpkxG3KooDzfPk/h0/UJLEJIHylfy3h
 Lw3PYEpXOW67n71SdjaCAIQsvDvEO35x1CFdUbTb/+m++iLeM+jm1CMPYFq9Xr1PzXrYqubcT
 AwDF+H7rliM68BRXPl9fA3fi87mXaO3kLI6t2Fpj55UgFV7pHl+yUpU9VjsDfmbW/AYT0F8B/
 5M+Txa4cNfii5/0mWgeIGWg9EHLS8KhAhCj0XxzxJRGiHDu13z//D7iWD2CvOmEauHS6ds4Q2
 MO6yXeYkNCJVhgXEdK3iDK69tkJj4KrhmkZijmf6rajFkBld4oo9l93TeeutCW0ymArIeHIhX
 ELQ2BJM9y/guuhu0tEUzIbRz3hQzyaGluX0eazs+eU1VRq+Fjhh96Jhfaq9E0TV7vksI0mCzl
 A6a7CF7v3n4EI+JYIRMT+ReHZT8SaH4xMnbUM3tPbLkEosIwQsYqeoMSE5Hh/yVvsJOXWOuhV
 Sz6/9BAJDH7PTeC5AifoYx8a/V+U7cdMlFcgcIhrYdF4FtJbh7J6BPfyxr5kuFK0InzLs61oU
 AnGGuwmgmfvpia25DjhMhQyrUlCF9i7CkMXd95gvL6cxP7UD5J4X+g5OF4Se+JfZK5poopbZW
 UATJ90b8bz+1fBx0tEDkjAvsWfuLupffDHKJfVILz3NjC+7QhmwbDzKWdymUHAK4pSLdCfgAu
 HkjnhzY2BC22vtP699P7YSg4hrPHPxYgHy9Lu5wE4=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
are used for measuring distances.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Reviewed-by: Rob Herring <robh@kernel.org>
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

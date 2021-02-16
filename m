Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80831C734
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPIQZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 03:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBPIQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 03:16:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEFC06178C
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2021 00:14:25 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUw-0000SK-MI; Tue, 16 Feb 2021 09:14:18 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUv-0000xE-Fk; Tue, 16 Feb 2021 09:14:17 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: counter: add event-counter binding
Date:   Tue, 16 Feb 2021 09:13:55 +0100
Message-Id: <20210216081356.3577-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216081356.3577-1-o.rempel@pengutronix.de>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding for the event counter node

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/counter/interrupt-counter.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/interrupt-counter.yaml b/Documentation/devicetree/bindings/counter/interrupt-counter.yaml
new file mode 100644
index 000000000000..fd075d104631
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/interrupt-counter.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/interrupt-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Interrupt counter
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: |
+  A generic interrupt counter to measure interrupt frequency. It was developed
+  and used for agricultural devices to measure rotation speed of wheels or
+  other tools. Since the direction of rotation is not important, only one
+  signal line is needed.
+  Interrupts or gpios are required. If both are defined, the interrupt will
+  take precedence for counting interrupts.
+
+properties:
+  compatible:
+    const: interrupt-counter
+
+  interrupts:
+    maxItems: 1
+
+  gpios:
+    maxItems: 1
+
+required:
+  - compatible
+
+anyOf:
+  - required: [ interrupts-extended ]
+  - required: [ interrupts ]
+  - required: [ gpios ]
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    counter-0 {
+        compatible = "interrupt-counter";
+        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_RISING>;
+    };
+
+    counter-1 {
+        compatible = "interrupt-counter";
+        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    counter-2 {
+        compatible = "interrupt-counter";
+        interrupts-extended = <&gpio 2 IRQ_TYPE_EDGE_RISING>;
+        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+    };
+
+...
-- 
2.29.2


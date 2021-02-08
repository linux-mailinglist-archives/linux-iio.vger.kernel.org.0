Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88E313401
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 14:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBHNzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 08:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhBHNzT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 08:55:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC47C0617A7
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 05:53:55 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l96z7-0006qJ-Bq; Mon, 08 Feb 2021 14:53:49 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l96z6-0004pQ-Ja; Mon, 08 Feb 2021 14:53:48 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: counter: add event-counter binding
Date:   Mon,  8 Feb 2021 14:53:46 +0100
Message-Id: <20210208135347.18494-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208135347.18494-1-o.rempel@pengutronix.de>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
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
---
 .../bindings/counter/event-counter.yaml       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/event-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/event-counter.yaml b/Documentation/devicetree/bindings/counter/event-counter.yaml
new file mode 100644
index 000000000000..bd05c1b38f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/event-counter.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/event-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Event counter
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: |
+  A generic event counter to measure event frequency. It was developed and used
+  for agricultural devices to measure rotation speed of wheels or other tools.
+  Since the direction of rotation is not important, only one signal line is
+  needed.
+
+properties:
+  compatible:
+    const: event-counter
+
+  interrupts:
+    maxItems: 1
+
+  gpios:
+    description: Optional diagnostic interface to measure signal level
+    maxItems: 1
+
+required:
+  - compatible
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
+        compatible = "event-counter";
+        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_RISING>;
+    };
+
+    counter-1 {
+        compatible = "event-counter";
+        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    counter-2 {
+        compatible = "event-counter";
+        interrupts-extended = <&gpio 2 IRQ_TYPE_EDGE_RISING>;
+        gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+    };
+
+...
-- 
2.30.0


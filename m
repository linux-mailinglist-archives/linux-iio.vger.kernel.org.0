Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7043A300065
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbhAVK0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbhAVJet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 04:34:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329DC0617AA
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 01:34:08 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2spM-0003Hq-IH; Fri, 22 Jan 2021 10:34:00 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2spL-000478-PY; Fri, 22 Jan 2021 10:33:59 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: counter: add gpio-pulse-counter binding
Date:   Fri, 22 Jan 2021 10:33:56 +0100
Message-Id: <20210122093357.15750-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122093357.15750-1-o.rempel@pengutronix.de>
References: <20210122093357.15750-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding for GPIO based pulse counter node

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/counter/gpio-pulse-counter.yaml  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
new file mode 100644
index 000000000000..dfa93956f15c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-pulse-counter.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/gpio-pulse-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO base pulse counter
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+properties:
+  compatible:
+    const: virtual,gpio-pulse-counter
+
+  gpios:
+    maxItems: 1
+
+required:
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+
+    counter-0 {
+        compatible = "virtual,gpio-pulse-counter";
+        gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+    };
+
+    counter-1 {
+        compatible = "virtual,gpio-pulse-counter";
+        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
+
+...
-- 
2.30.0


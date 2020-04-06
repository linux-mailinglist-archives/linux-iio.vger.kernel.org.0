Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A919F956
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDFPyQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:54:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48375 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgDFPyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:54:15 -0400
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1D9A7200007;
        Mon,  6 Apr 2020 15:54:12 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 2/3] dt-bindings: counter: atmel-tcb-capture counter
Date:   Mon,  6 Apr 2020 17:53:19 +0200
Message-Id: <20200406155320.1291701-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
References: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Describe the devicetree binding for the ATMEL TCB counter. Each counter
blocks exposes three independent counters.

However, when configured in quadrature decoder, both channel <0> and <1>
are required for speed/position and rotation capture (yet only the
position is captured).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../bindings/counter/atmel-tcb-capture.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml

diff --git a/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml b/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml
new file mode 100644
index 000000000000..484b2942ad5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/atmel-tcb-capture.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel TCB Counter
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+properties:
+  compatible:
+    const: "atmel,tcb-capture"
+
+  reg:
+    description: TCB capture channel to register as counter device.
+      Each channel is independent therefore only one channel is
+      registered by default execpt for the QDEC mode where both TCB0's
+      channels <0> and  <1> are required.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tcb0: timer@f800c000 {
+        qdec: timer@0 {
+            compatible = "atmel,tcb-capture";
+            reg = <0>, <1>;
+        };
+    };
-- 
2.25.0


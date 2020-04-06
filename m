Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2019F973
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDFP6a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:58:30 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36043 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgDFP63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:58:29 -0400
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D216B20000E;
        Mon,  6 Apr 2020 15:58:26 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Date:   Mon,  6 Apr 2020 17:58:05 +0200
Message-Id: <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt binding for the counter variant of the rotary encoder driver.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
new file mode 100644
index 000000000000..a59f7c1faf0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rotary Encoder Counter
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+description:
+  Registers a Rotary encoder connected through a counter device.
+
+properties:
+  compatible:
+    const: rotary-encoder-counter
+
+  counter:
+    description: Phandle for the counter device providing rotary position.
+
+  linux-axis:
+    description: The input subsystem axis to map to this rotary encoder.
+    type: boolean
+
+  qdec-mode:
+    description: |
+      Quadrature decoder function to set in the counter device.
+      3: x1-PHA
+      4: x1-PHB
+      5: x2-PHA
+      6: x2-PHB
+      7: x4-PHA and PHB
+
+  steps:
+    description: Number of steps in a full turnaround of the encoder.
+      Only relevant for absolute axis. Defaults to 24 which is a typical
+      value for such devices.
+
+  relative-axis:
+    description: Register a relative axis rather than an absolute one.
+    type: boolean
+
+  rollover:
+    description: Automatic rollover when the rotary value becomes greater
+      than the specified steps or smaller than 0. For absolute axis only.
+    type: boolean
+
+  poll-interval:
+    description: Poll interval at which the position is read from the counter
+      device (default 500ms).
+
+required:
+  - compatible
+  - counter
+  - qdec-mode
+
+examples:
+  - |
+    rotary@0 {
+        compatible = "rotary-encoder-counter";
+
+        counter =<&qdec>;
+        qdec-mode = <7>;
+        relative-axis;
+    };
+...
-- 
2.25.0


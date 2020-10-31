Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49892A1959
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJaSPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgJaSPA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:15:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581352071A;
        Sat, 31 Oct 2020 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168099;
        bh=b6xwsrTqrL01OYwuXwqonMBb71GmaCiq8RUPWDCO/o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Li8Jm7v8bURv5b+Dyp28swb0/hNKZM3EzhHsFfIjh416nLhmoiriL4nLpDzKFGuXW
         h0RSTiNIsN6OkevcDn1QCa0velT23VCw9HXvXLGGVB0O20KoNX98Nw6ZdtPExjEMMd
         iHeftnTlBpamqopkYxKRONxI1KixscUIL3HRkdyQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 05/10] dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:12:37 +0000
Message-Id: <20201031181242.742301-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note this includes a fix in the example where we had *-mul instead of
*-mult.  The binding doc and driver agree that it should be *-mult

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../iio/afe/current-sense-amplifier.txt       | 26 ---------
 .../iio/afe/current-sense-amplifier.yaml      | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
deleted file mode 100644
index 821b61b8c542..000000000000
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Current Sense Amplifier
-=======================
-
-When an io-channel measures the output voltage from a current sense
-amplifier, the interesting measurement is almost always the current
-through the sense resistor, not the voltage output. This binding
-describes such a current sense circuit.
-
-Required properties:
-- compatible : "current-sense-amplifier"
-- io-channels : Channel node of a voltage io-channel.
-- sense-resistor-micro-ohms : The sense resistance in microohms.
-
-Optional properties:
-- sense-gain-mult: Amplifier gain multiplier. The default is <1>.
-- sense-gain-div: Amplifier gain divider. The default is <1>.
-
-Example:
-
-sysi {
-	compatible = "current-sense-amplifier";
-	io-channels = <&tiadc 0>;
-
-	sense-resistor-micro-ohms = <20000>;
-	sense-gain-mul = <50>;
-};
diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
new file mode 100644
index 000000000000..920bdd8d12d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Current Sense Amplifier
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  When an io-channel measures the output voltage from a current sense
+  amplifier, the interesting measurement is almost always the current
+  through the sense resistor, not the voltage output. This binding
+  describes such a current sense circuit.
+
+properties:
+  compatible:
+    const: current-sense-amplifier
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  sense-resistor-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The sense resistance.
+
+  sense-gain-mult:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Amplifier gain multiplier. The default is <1>.
+
+  sense-gain-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Amplifier gain divider. The default is <1>.
+
+required:
+  - compatible
+  - io-channels
+  - sense-resistor-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    sysi {
+        compatible = "current-sense-amplifier";
+        io-channels = <&tiadc 0>;
+
+        sense-resistor-micro-ohms = <20000>;
+        sense-gain-mult = <50>;
+    };
+...
-- 
2.28.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC725E94D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgIERcg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIERcb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C61F2098B;
        Sat,  5 Sep 2020 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327150;
        bh=FdK1l3fo6UgGdK6dGnHyf2ZFaNBIdLfR1npsQ9CW2AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvE8bDGVDBmqFZXu3j7udNuvaOBbL7oKUFk6V5Ro+z3R5ASA8rg4P8nYox60vE3JH
         9Kg6QxyHXjrX877Y9mz5xxfXHwBKEMwdSShrOg4FCXKOiNEelMWH1lM4F09GyphlQk
         DpjV9Enq6sc9rG8CDyeSZmr+sABUQxUEMAFfjIwM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 03/20] dt-bindings:iio:adc:st,stmpe-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:47 +0100
Message-Id: <20200905173004.216081-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Conversion from freeform text to yaml.
One oddity in this binding is that, for historical reasons it requires
the node name to be stmpe_adc.  I've put that in the decription field
but I'm not sure if there is a better way to specify this?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 .../bindings/iio/adc/st,stmpe-adc.yaml        | 45 +++++++++++++++++++
 .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ---------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
new file mode 100644
index 000000000000..9049c699152f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/st,stmpe-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC on an STMPE multifunction device.
+
+maintainers:
+  - Stefan Agner <stefan@agner.ch>
+
+description:
+  This ADC forms part of an ST microelectronics STMPE multifunction device .
+  The ADC is shared with the STMPE touchscreen. As a result some ADC related
+  settings are specified in the parent node.
+  The node name myst be stmpe_adc and should be a child node of the stmpe node
+  to which it belongs.
+
+properties:
+  compatible:
+    const: st,stmpe-adc
+
+  st,norequest-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bitmask specifying which ADC channels should _not_ be
+      requestable due to different usage (e.g. touch).
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    stmpe {
+        stmpe_adc {
+            compatible = "st,stmpe-adc";
+            st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
deleted file mode 100644
index 480e66422625..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-STMPE ADC driver
-----------------
-
-Required properties:
- - compatible: "st,stmpe-adc"
-
-Optional properties:
-Note that the ADC is shared with the STMPE touchscreen. ADC related settings
-have to be done in the mfd.
-- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
-  requestable due to different usage (e.g. touch)
-
-Node name must be stmpe_adc and should be child node of stmpe node to
-which it belongs.
-
-Example:
-
-	stmpe_adc {
-		compatible = "st,stmpe-adc";
-		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
-	};
-- 
2.28.0


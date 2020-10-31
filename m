Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF492A19EC
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgJaSwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8002920702;
        Sat, 31 Oct 2020 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170319;
        bh=dkhq8aeKyBrwS8VEAzZqhk9tRqNu7aZfA0D9vLmY4JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azppVyUOdHvR2GFBehbtQylQxl7id0OrrhSDozR4LePqJ3PeXAbXTAHGUne8tx8Hu
         Lqsh9OBNNJGOt1TFwj4jsUl+IDfN0v6HX5rIz4n68o21eGvDno54HtiaQF7jRelqAJ
         mT/6PBrnytkj1gni0gD44GfkLrZFbdJwC1UEqwiw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 22/46] dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:30 +0000
Message-Id: <20201031184854.745828-23-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not sure anyone would use this part primarily as an ALS,
given the time of flight laser also present, but I'll stick with the
original decision on where to put the binding.

Added interrupts property as the device has a GPIO interrupt even
if the driver is not currently using it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <manivannanece23@gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 .../bindings/iio/light/st,vl6180.yaml         | 45 +++++++++++++++++++
 .../devicetree/bindings/iio/light/vl6180.txt  | 15 -------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
new file mode 100644
index 000000000000..27c36ab7990d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/st,vl6180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicro VL6180 ALS, range and proximity sensor
+
+maintainers:
+  - Manivannan Sadhasivam <manivannanece23@gmail.com>
+  - Peter Meerwald-Stadler <pmeerw@pmeerw.net>
+
+description: |
+  Proximity sensing module incorporating time of flight sensor
+  Datasheet at https://www.st.com/resource/en/datasheet/vl6180x.pdf
+
+properties:
+  compatible:
+    const: st,vl6180
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@29 {
+            compatible = "st,vl6180";
+            reg = <0x29>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/vl6180.txt b/Documentation/devicetree/bindings/iio/light/vl6180.txt
deleted file mode 100644
index fb9137d85df9..000000000000
--- a/Documentation/devicetree/bindings/iio/light/vl6180.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-STMicro VL6180 -  ALS, range and proximity sensor
-
-Link to datasheet: https://www.st.com/resource/en/datasheet/vl6180x.pdf
-
-Required properties:
-
-	-compatible: should be "st,vl6180"
-	-reg: the I2C address of the sensor
-
-Example:
-
-vl6180@29 {
-	compatible = "st,vl6180";
-	reg = <0x29>;
-};
-- 
2.28.0


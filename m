Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799952A19F3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgJaSwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:05 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641DC20731;
        Sat, 31 Oct 2020 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170325;
        bh=YrwOjfuiPOuHCounAvfePwYGXB2gT4eZEuIKvYEc7c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyQUC0zTdEbfT9nILYzqIARV6f0rSPGxUSJ96Esh4cZrbMAdtd6+ZvsdgJT3HQl+H
         bQqc3L5Iv7djMQnV1s1wZFUZTYHVTgyVjMwxP6DNZAxBUQuE5w6FfuHxOE5KfxhuLu
         Wg/Li3pUyXkFcEPU8oq9M5m7+lNrNYKVwFfrWFXU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Neil Brown <neilb@suse.de>
Subject: [PATCH 26/46] dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format conversion
Date:   Sat, 31 Oct 2020 18:48:34 +0000
Message-Id: <20201031184854.745828-27-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Mostly a straight conversion, but the txt file had an oddity.
It documented a gpios property for what appeared to be in interrupt line.
There are mainline dts that have this as interrupts, so I've converted
it to that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Neil Brown <neilb@suse.de>
---
 .../bindings/iio/magnetometer/hmc5843.txt     | 21 ---------
 .../iio/magnetometer/honeywell,hmc5843.yaml   | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/hmc5843.txt b/Documentation/devicetree/bindings/iio/magnetometer/hmc5843.txt
deleted file mode 100644
index 8e191eef014e..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/hmc5843.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Honeywell HMC5843 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "honeywell,hmc5843"
-  Other models which are supported with driver are:
-	"honeywell,hmc5883"
-	"honeywell,hmc5883l"
-	"honeywell,hmc5983"
-  - reg : the I2C address of the magnetometer - typically 0x1e
-
-Optional properties:
-
-  - gpios : should be device tree identifier of the magnetometer DRDY pin
-
-Example:
-
-hmc5843@1e {
-        compatible = "honeywell,hmc5843"
-        reg = <0x1e>;
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/honeywell,hmc5843.yaml b/Documentation/devicetree/bindings/iio/magnetometer/honeywell,hmc5843.yaml
new file mode 100644
index 000000000000..5e778c98584e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/honeywell,hmc5843.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/honeywell,hmc5843.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell HMC5843 magnetometer sensor
+
+maintainers:
+  - Neil Brown <neilb@suse.de>
+
+properties:
+  compatible:
+    enum:
+      - honeywell,hmc5843
+      - honeywell,hmc5883
+      - honeywell,hmc5883l
+      - honeywell,hmc5983
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@1e {
+            compatible = "honeywell,hmc5843";
+            reg = <0x1e>;
+        };
+    };
+...
-- 
2.28.0


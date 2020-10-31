Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4632A19DD
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgJaSvs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B9E20729;
        Sat, 31 Oct 2020 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170307;
        bh=hvXOic1rUJfkQMhsWqepgHIYm8GKrgC2Efi+g7GSWbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8FEXIo2rPEjbSO6MfHDZBvWDAjtuLZxJu2JWwiZKUjXO3YOmzTDZiTPIv5Za4D2Q
         +8GSzVMnfSfEtVx5zkEEcb3TjHP3d3J+NTQGJC3A0WomNJZ1SjVSEaxgbcmSGK1HrS
         ipE5LrKCDTlJihP3R5narpIUKb8FbLUtIU4lPKEw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 14/46] dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:22 +0000
Message-Id: <20201031184854.745828-15-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding that we could move into trivial-devices.yaml
with a small loss of documentation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <mranostay@gmail.com>
---
 .../bindings/iio/light/apds9960.txt           | 21 ---------
 .../bindings/iio/light/avago,apds9960.yaml    | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
deleted file mode 100644
index c53ddb81c4aa..000000000000
--- a/Documentation/devicetree/bindings/iio/light/apds9960.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Avago APDS9960 gesture/RGB/ALS/proximity sensor
-
-https://www.avagotech.com/docs/AV02-4191EN
-
-Required properties:
-
-  - compatible: must be "avago,apds9960"
-  - reg: the I2c address of the sensor
-  - interrupts : the sole interrupt generated by the device
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt client
-  node bindings.
-
-Example:
-
-apds9960@39 {
-	compatible = "avago,apds9960";
-	reg = <0x39>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 1>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
new file mode 100644
index 000000000000..eae8c7327c0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
+
+maintainers:
+  - Matt Ranostay <mranostay@gmail.com>
+
+description: |
+  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
+
+properties:
+  compatible:
+    const: avago,apds9960
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
+        light-sensor@39 {
+            compatible = "avago,apds9960";
+            reg = <0x39>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <16 1>;
+        };
+    };
+...
-- 
2.28.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23FC2A17DF
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgJaNoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA7520723;
        Sat, 31 Oct 2020 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151853;
        bh=f0ljlD9NVU/ipOsXMONXzDvwaPlKWYj1V0G7XAPLgd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgpO95tweP+8YOpLANRlPWn8e1ltZepqAPc6gqzrgWbf91QA6oAj8OwnL5KI0DN5C
         5+L0YgkG88dkMf6zZsHdVn64SgmAOZKcFLaJkf/WLu+X52Uq5S2yDvBozMAIV+OzmB
         ehXoqvOxGvjvwp32wBhAxCnVcGPYmtikvuaPO1TQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: [PATCH v2 21/29] dt-bindings:iio:dac:maxim,max5821 yaml conversion
Date:   Sat, 31 Oct 2020 13:41:02 +0000
Message-Id: <20201031134110.724233-22-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple txt to yaml conversion for this binding description.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Philippe Reynes <tremyfr@yahoo.fr>
---
 .../devicetree/bindings/iio/dac/max5821.txt   | 14 ------
 .../bindings/iio/dac/maxim,max5821.yaml       | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/max5821.txt b/Documentation/devicetree/bindings/iio/dac/max5821.txt
deleted file mode 100644
index 54276ce8c971..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/max5821.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Maxim max5821 DAC device driver
-
-Required properties:
-	- compatible: Must be "maxim,max5821"
-	- reg: Should contain the DAC I2C address
-	- vref-supply: Phandle to the vref power supply
-
-Example:
-
-	max5821@38 {
-		compatible = "maxim,max5821";
-		reg = <0x38>;
-		vref-supply = <&reg_max5821>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
new file mode 100644
index 000000000000..c43fb5f3f8ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/maxim,max5821.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max5821 dual 10-bit DAC
+
+maintainers:
+  - Philippe Reynes <tremyfr@yahoo.fr>
+
+description: |
+  Datasheet publicly available at:
+  https://datasheets.maximintegrated.com/en/ds/MAX5821.pdf
+
+properties:
+  compatible:
+    const: maxim,max5821
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@38 {
+            compatible = "maxim,max5821";
+            reg = <0x38>;
+            vref-supply = <&reg_max5821>;
+        };
+    };
+...
-- 
2.28.0


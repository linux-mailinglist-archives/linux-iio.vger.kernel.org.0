Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0632A17C5
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgJaNny (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgJaNnx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4C9208B6;
        Sat, 31 Oct 2020 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151833;
        bh=ujB+gNbIBddOmypRoHh+IknbcWeTLN/b+n7eFidMIbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A424yOaNLMtJlRj7tlrwT4DeFbewyoz6EMq3gBRZTCKWleKhOybUmuS9ykZmFO08e
         LFP1VY4fHFTFPG2miSrSAoZTuHSDOa87/GkzL5JXJtWqFveBcc8limceVM8bOTO2yx
         9KoZ1LwaBOHEmY7c1LLKe7wYe1f5CVQ58LCpulGM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 08/29] dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:49 +0000
Message-Id: <20201031134110.724233-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One quirk in the txt file was that the xclr gpio was specified as
xclr-gpio rather than xclr-gpios. I've fixed that in the
yaml version.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Marek Vasut <marex@denx.de>
---
v2: Fixed description naming of xclr-gpios

 .../bindings/iio/pressure/hoperf,hp03.yaml    | 47 +++++++++++++++++++
 .../devicetree/bindings/iio/pressure/hp03.txt | 17 -------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
new file mode 100644
index 000000000000..69a3759e23db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/hoperf,hp03.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HopeRF HP03 digital pressure/temperature sensors
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+
+description: |
+  Digital pressure and temperature sensor with an I2C interface.
+
+properties:
+  compatible:
+    const: hoperf,hp03
+
+  reg:
+    maxItems: 1
+
+  xclr-gpios:
+    description:
+      The XCLR pin is a reset of the ADC in the chip, it must be pulled
+      HI before the conversion and readout of the value from the ADC
+      registers and pulled LO afterward.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@77 {
+            compatible = "hoperf,hp03";
+            reg = <0x77>;
+            xclr-gpios = <&portc 0 0x0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/pressure/hp03.txt b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
deleted file mode 100644
index 831dbee7a5c3..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/hp03.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-HopeRF HP03 digital pressure/temperature sensors
-
-Required properties:
-- compatible: must be "hoperf,hp03"
-- xclr-gpio: must be device tree identifier of the XCLR pin.
-             The XCLR pin is a reset of the ADC in the chip,
-             it must be pulled HI before the conversion and
-             readout of the value from the ADC registers and
-             pulled LO afterward.
-
-Example:
-
-hp03@77 {
-	compatible = "hoperf,hp03";
-	reg = <0x77>;
-	xclr-gpio = <&portc 0 0x0>;
-};
-- 
2.28.0


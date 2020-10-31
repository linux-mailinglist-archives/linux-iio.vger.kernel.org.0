Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A62A19C3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgJaSv3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSv3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADCB62071A;
        Sat, 31 Oct 2020 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170288;
        bh=MYhs3hNCLQomh8x5nP0aznfDVJVGlsc86c+feN2oOUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FudiSD2ifLVDRUJqLdKqZuIhdvk0ddC6tosNZ6I3aY3dmpr+hCzDRjsI9CUPTluOR
         ZJnVdMXruzWIME0O8+ll8Qwsq2OY0lMoW6s97lz/Z8G8yNATTnJbfSEI+HY4GXwB5V
         XkiRANIFTLs8j7FtLyNIMpdwMDQqjGGJlAScX81k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 01/46] dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
Date:   Sat, 31 Oct 2020 18:48:09 +0000
Message-Id: <20201031184854.745828-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding with a good description of why the spi-max-frequency is,
in practice not as high as the datasheet implies.  I've set the
maximum as per the value established in the description.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/resolver/ad2s90.txt          | 31 ----------
 .../bindings/iio/resolver/adi,ad2s90.yaml     | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
deleted file mode 100644
index 477d41fa6467..000000000000
--- a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Analog Devices AD2S90 Resolver-to-Digital Converter
-
-https://www.analog.com/en/products/ad2s90.html
-
-Required properties:
-  - compatible: should be "adi,ad2s90"
-  - reg: SPI chip select number for the device
-  - spi-max-frequency: set maximum clock frequency, must be 830000
-  - spi-cpol and spi-cpha:
-        Either SPI mode (0,0) or (1,1) must be used, so specify none or both of
-        spi-cpha, spi-cpol.
-
-See for more details:
-    Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Note about max frequency:
-    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
-    delay is expected between the application of a logic LO to CS and the
-    application of SCLK, as also specified. And since the delay is not
-    implemented in the spi code, to satisfy it, SCLK's period should be at most
-    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
-    roughly 830000Hz.
-
-Example:
-resolver@0 {
-	compatible = "adi,ad2s90";
-	reg = <0>;
-	spi-max-frequency = <830000>;
-	spi-cpol;
-	spi-cpha;
-};
diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
new file mode 100644
index 000000000000..81e4bdfc17c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/resolver/adi,ad2s90.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD2S90 Resolver-to-Digital Converter
+
+maintainers:
+  - Matheus Tavares <matheus.bernardino@usp.br>
+
+description: |
+  Datasheet: https://www.analog.com/en/products/ad2s90.html
+
+properties:
+  compatible:
+    const: adi,ad2s90
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 830000
+    description: |
+      Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
+      delay is expected between the application of a logic LO to CS and the
+      application of SCLK, as also specified. And since the delay is not
+      implemented in the spi code, to satisfy it, SCLK's period should be at
+      most 2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
+      roughly 830000Hz.
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+dependencies:
+  spi-cpol: [ spi-cpha ]
+  spi-cpha: [ spi-cpol ]
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        resolver@0 {
+            compatible = "adi,ad2s90";
+            reg = <0>;
+            spi-max-frequency = <830000>;
+            spi-cpol;
+            spi-cpha;
+        };
+    };
+...
-- 
2.28.0


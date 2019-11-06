Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F22F14A4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfKFLJt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 06:09:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46345 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfKFLJt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 06:09:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so12287101ljp.13;
        Wed, 06 Nov 2019 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBiQq0cp0ZT17akB6/sC+lRSuUfl0nsB/5VzUqPd+T8=;
        b=R/Fi+NoL82h7Q2vavAWzrwWakTmTnXksFiilzkGHuMb9a+zZdeHx1Q8I7OlK59el7z
         J37KsE/7uYwciOJglybMK0YjHaxJFdsXzfTFgoXbCECLIQs2Cz4wyfNkjRbY8mbDcfFe
         dpKSqs2LH2noWsvAPLDGTK1o7Vt5rPi15MOkv7wa/zWQTTJQV5WtQSjw/YyBRfeplUky
         1aZTcuokxb3z4fad7OsOal0DhiD42gUMv5sciG0ps+1VroxZIp2iwLgbnPxVkhTzl6oz
         Uk9V45TbbwR2M5eoivnCiVtkr4KG56bUW4OUljG03J5YO5OnI1n5L6jPD1dDId1/sQDu
         wMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBiQq0cp0ZT17akB6/sC+lRSuUfl0nsB/5VzUqPd+T8=;
        b=UHKCd0CFnQACSFGY6u67tjBCe54QULXf/8DcB8Ar5UG7w9e31u4hYHINiaV3D1l4O4
         o2I+oE+HIzT1M5/IzcLx+NLBaXC38ReeLDYUJIjQSAp2wgZC1WIhcKV2Imq7dImiLq9E
         2oLXFVCYBoHxHrXxgfzU9gMRXpZtXwDxC3Yy2EphJ1b3kKKj1+YwUEAfZg5e6/iSoX8C
         Or9oEJGMfvsyvbT7ei7BClMhaj7VZUhfRgLko9g1jvRUo0/ldRN3/PI7xOfyMdqMyo8Y
         Nk7/eIdEg8nv08/cvrrRmcFOvCrOMmxtnKGRwfaNa3ouy1hd3F/1O1jiOlWVORN8WpuQ
         jLHA==
X-Gm-Message-State: APjAAAVe1XMVDMcVVmN0MCsqdjQpKLQWY4r9K/FoOhLVCwZlvMXThrLw
        51VPSxs6lVFajWfoP5i564Y=
X-Google-Smtp-Source: APXvYqyDXDYNhpVNsYp9jqZengWs5rk612UYI/+JvjbanNu8z0v/fvEZOxcu2YeMIlzWy+q2giq70g==
X-Received: by 2002:a2e:7d17:: with SMTP id y23mr1534664ljc.228.1573038586060;
        Wed, 06 Nov 2019 03:09:46 -0800 (PST)
Received: from localhost.localdomain ([94.234.51.156])
        by smtp.gmail.com with ESMTPSA id i128sm12667229lfd.6.2019.11.06.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 03:09:45 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: adc: Migrate MCP3911 documentation to yaml
Date:   Wed,  6 Nov 2019 12:12:10 +0100
Message-Id: <20191106111210.6825-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rewrite bindings to use json-schema vocabulary.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- Remove descriptor for reg and spi-max-frequency (Rob)
    	- Write better description for clocks and vref-supply (Rob)
    	- Remove max-items for vref-supply

 .../devicetree/bindings/iio/adc/mcp3911.txt   | 30 --------
 .../bindings/iio/adc/microchip,mcp3911.yaml   | 71 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
deleted file mode 100644
index 3071f48fb30b..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Microchip MCP3911 Dual channel analog front end (ADC)
-
-Required properties:
- - compatible: Should be "microchip,mcp3911"
- - reg: SPI chip select number for the device
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-	 Documentation/devicetree/bindings/spi/spi-bus.txt.
-	 Max frequency for this chip is 20MHz.
-
-Optional properties:
- - clocks: Phandle and clock identifier for sampling clock
- - interrupt-parent: Phandle to the parent interrupt controller
- - interrupts: IRQ line for the ADC
- - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
-	same SPI bus. Valid values are 0-3. Defaults to 0.
- - vref-supply: Phandle to the external reference voltage supply.
-
-Example:
-adc@0 {
-	compatible = "microchip,mcp3911";
-	reg = <0>;
-	interrupt-parent = <&gpio5>;
-	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
-	spi-max-frequency = <20000000>;
-	microchip,device-addr = <0>;
-	vref-supply = <&vref_reg>;
-	clocks = <&xtal>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
new file mode 100644
index 000000000000..c73a374e614a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/bindings/iio/adc/microchip,mcp3911.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip MCP3911 Dual channel analog front end (ADC)
+
+maintainers:
+  - Marcus Folkesson <marcus.folkesson@gmail.com>
+  - Kent Gustavsson <nedo80@gmail.com>
+
+description: |
+  Bindings for the Microchip MCP3911 Dual channel ADC device. Datasheet can be
+  found here: https://ww1.microchip.com/downloads/en/DeviceDoc/20002286C.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3911
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    description: |
+      Phandle and clock identifier for external sampling clock.
+      If not specified, the internal crystal oscillator will be used.
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line of the ADC
+    maxItems: 1
+
+  microchip,device-addr:
+    description: Device address when multiple MCP3911 chips are present on the same SPI bus.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3]
+      - default: 0
+
+  vref-supply:
+    description: |
+      Phandle to the external reference voltage supply.
+      If not specified, the internal voltage reference (1.2V) will be used.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "microchip,mcp3911";
+        reg = <0>;
+        interrupt-parent = <&gpio5>;
+        interrupts = <15 2>;
+        spi-max-frequency = <20000000>;
+        microchip,device-addr = <0>;
+        vref-supply = <&vref_reg>;
+        clocks = <&xtal>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e51a68bf8ca8..fbccc9d450ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10723,7 +10723,7 @@ M:	Kent Gustavsson <kent@minoris.se>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/adc/mcp3911.c
-F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 
 MICROCHIP NAND DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
-- 
2.23.0


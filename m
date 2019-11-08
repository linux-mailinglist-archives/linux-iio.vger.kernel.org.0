Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398C1F4143
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 08:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfKHHWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 02:22:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40937 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHHWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 02:22:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so5082949ljg.7;
        Thu, 07 Nov 2019 23:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkCtc+gjAJeOiR3VEewsqnIjMxzUD5YQRYYW3XbrnTw=;
        b=BwJjM1ErgTpJ3mYWxQ8SN7UT/iggdJTxC9dF6RC9KUrm7YboBwaJrGQvwE80//ktMa
         u6ox2E4ycdC17DRAtuj1OJ2RtlPUUIiGtAOZrKf14VuG352vbp0fekNBljXYUh1mZWp+
         Jzx0WmNxaSaOsJ5Axlz/Mpr9yLnTfxJyjYqa55vDZiN0dm7bchCAttCGk3Qht0JewcIl
         uog0JtkiEbVKF+yblHwXlsP8+5hm/RHIkDTs/1HyQxD8ecaUdny8VUZ6ZvpATnXo8K/h
         qOHvPr1WP7xQADrkEHCl5u7H3ulQL6bN5/uQ2dG0oaFNj+h5AF4rd25/9iKjO6NY0g9P
         Zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkCtc+gjAJeOiR3VEewsqnIjMxzUD5YQRYYW3XbrnTw=;
        b=UB6gVvy6hARS3C/iNVU6C4w3f8qTl28jIETP9IjO5OcwFbMHYNZCH9yecD2zABboGl
         nLTCs+21FQ1Gc28TPdsTZgpyOj3Cu/EoLFswvs5vmmrNPkXUZMZaUGHNGU4RvhXmjWj3
         VWHRJRBOP5CNv2cRjav26t/4t27tY4KgTRnt0NNaLGx339yPC/dInk1PPEoOh9ctbPyG
         ybaLV5L4woORrWuaXafc0OasAc37N5FZjS8eewHS78JyQsz/nwDBJAVXHN58Af3YI0bN
         /0sVOsisSRUkIADzXXi0sOlECoJWujWRQK9oKzSnfly2Ez71SV3y56Th39FYrVHOeXgG
         Iy5w==
X-Gm-Message-State: APjAAAXfo8FadCQ9lGjvED1SKeDROpR/2clRAwyWbJDEA1xQT6s3z4Tq
        Y92wam7h7KPvNMFxEYl7D8w=
X-Google-Smtp-Source: APXvYqy50urygRpHH1X6/RWIKbC1aQR6d8Zi75O4y91/fKDeT/dW9ElERQUdc8iQrZxMPe4WNjgiqQ==
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr5299555ljn.65.1573197770958;
        Thu, 07 Nov 2019 23:22:50 -0800 (PST)
Received: from localhost.localdomain (c-5eea30e8-74736162.cust.telenor.se. [94.234.48.232])
        by smtp.gmail.com with ESMTPSA id e10sm2051736ljp.23.2019.11.07.23.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 23:22:50 -0800 (PST)
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
Subject: [PATCH v3] dt-bindings: iio: adc: Migrate MCP3911 documentation to yaml
Date:   Fri,  8 Nov 2019 08:25:30 +0100
Message-Id: <20191108072530.3499-1-marcus.folkesson@gmail.com>
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
index 000000000000..881059b80d61
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
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


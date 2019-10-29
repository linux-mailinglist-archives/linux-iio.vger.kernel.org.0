Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39705E913A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ2VJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 17:09:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53019 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ2VJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 17:09:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so4142363wmg.2;
        Tue, 29 Oct 2019 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUoGJwSxJZnzTzRzbKG9r3Bd5xV9RD8EdFVeCglJJKM=;
        b=M72u9xP651IDrqyAP1W9+3ztPWQmKEmEDM6woo81AXjKia2Qeazt06FsrzzkgmGm4t
         ZjYlC7K2KRKXNaIx2Aip93P/AaSajOo79uPHvO8icn3/XNQ7sQA4JYKctwD4xiyFEs36
         524KpAo5On1fiqLfg9tQRxWUGhOdfjkAQ2hdifcslaxWO7oLEcpjtGJc07SeETnRhTqh
         ra+L2/GP5WuXClQPc0KxoUnaAyb3tcEm/HKdkhGpksj/h2y7uWQjfwqsRYVnbN18G+oy
         463WQKbcLd60Q2vdyzKBLKStzIoafRICFiZnIhrXML/XoVQCx/Ea1dmbXGlBpx/tInim
         D/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUoGJwSxJZnzTzRzbKG9r3Bd5xV9RD8EdFVeCglJJKM=;
        b=dWPmvclxipkppZko5hhn8/M+2IhqJeIZTsQw+0zpiYsye/8U9KV6+mpnHQwkjQ82Cb
         raFJP9B4d4S8t2tzNn4ysRvWndfQfi6Qx8s+b2qEg9LZQd4Zq9fN7Nj9VNK2TsMdd5Av
         hWDD77Y9QH0F+g5ZcWTgFQZMc3ZNpptDeqc4FiAUDSTG3wNdyB22NUklIGRyyD6+X3Lm
         e1CTxcGzCxWzmrcITyTtWjyUshF2u9C2j3W/sYSg7FhFP+SpYHsk82Z1UM5hl/k95qGl
         CHJKvFGBrA8TxPA+cC+CVocIB9ZPs501muc6bDgbMnyY/AYrTDa6AQ2voLYjW5h0pNu5
         MVEA==
X-Gm-Message-State: APjAAAU5VcpFeuOxUsH70vXgNvWS2EcNmNww1/wgwxMIAN/C0fPUnooV
        EEeRqglMS4g4cWHSq4F5CVOBozMcX8HK73Yx
X-Google-Smtp-Source: APXvYqyfwDMQTLJ/uCGRK0UbAbP0pNbA3toLQOfF3euQOdDemoymiSE2k0pNHSW1SSAt/JngL1jh7w==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr6047627wmg.166.1572383349612;
        Tue, 29 Oct 2019 14:09:09 -0700 (PDT)
Received: from localhost.localdomain ([46.218.74.72])
        by smtp.gmail.com with ESMTPSA id f8sm4044206wmb.37.2019.10.29.14.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:09:08 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: iio: adc: Migrate MCP3911 documentation to yaml
Date:   Tue, 29 Oct 2019 22:11:42 +0100
Message-Id: <20191029211142.14650-1-marcus.folkesson@gmail.com>
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
 .../bindings/iio/adc/microchip,mcp3911.yaml   | 72 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 73 insertions(+), 31 deletions(-)
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
index 000000000000..bfcf6a5fb44e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -0,0 +1,72 @@
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
+    description: SPI chip select number for the device
+    maxItems: 1
+
+  spi-max-frequency:
+    description: |
+      Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt.
+    maximum: 20000000
+    maxItems: 1
+
+  clocks:
+    description: Phandle and clock identifier for sampling clock
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
+    description: Phandle to the external reference voltage supply.
+    maxItems: 1
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


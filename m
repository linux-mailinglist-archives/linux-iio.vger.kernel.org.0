Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4819E476
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgDDK1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 06:27:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40970 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDK1q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 06:27:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so11521352wrc.8;
        Sat, 04 Apr 2020 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eKih6FjvS7COYO30o3HFfIvnq7gBGzr/Z5TRQxkk1Js=;
        b=T4fs6URfTMMkZ58nZbKvih/9LwZ3LhYCyRbXeAohMQQ4T9dYz2r3ZiWknVAqSckEh/
         hQ3qIfXtZwqtL6KxsboiAi82o+DUnLkBMzRYRnT3JiRu+GRoxUQnRZZOUfPqRqavDUP1
         aarSCiwr2AxzJjHcDD5a3xJPhDVsDrz4fBo1s3ZQE2KHLQH0ZAU4CLZNfsCnbwk19CXg
         L4lLtUbGMIdQiwGShlJJaoOrImdJP37x40YxlbpmURRG2ggd6mdlEqeIQ1DbjmoisC6l
         h+8vatFLuBzt0IB9J/K/EOHFYIGpwS34d9iSxoNB3H0aaQD9LbAXif6F4VSDiuUUtr2j
         5Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eKih6FjvS7COYO30o3HFfIvnq7gBGzr/Z5TRQxkk1Js=;
        b=UbZQayt3xLQZhMbao/cXdx/wwbUKiPicLhp/5zdzC7esq453/bE3wRuzCZzHE6qScv
         +z5QTX/Hy87GO337StvoKwi2wCx51eC25OXCSnur/nZv5GrGyzR1NzL6Bt9cqM0SY1sm
         fp1qKhAceUgsSLzkLljCoV1YJDr0dZdQ9qlhJn63n6VSvmZZ3Zjcsy5EJoSVuCTR1uPq
         tiAu6F4Hft/KJA6l8428+mJR0DrT0cM3YwHkrxHX0GITkpSZl1jV6FJXeToQjISR/Cls
         qBLodFbzSWhzD7bJF3jizUXhPmcM8monBaU+HYgB3jBeipbbM+x4Z/Qqd9UIJd2sTI55
         umoA==
X-Gm-Message-State: AGi0PuZG0F8TrzxAbxbloAv5e+S7j2WhYNOhODCq+icSj2pbA4hy02G6
        KaGQJtUukjoe5+wANDwRsTc=
X-Google-Smtp-Source: APiQypK6M5sqe1F1zgunzHFxzuhblxRRlmJsO1vLTsy5WHG5SCE4pD/ApQ3p4mlNoz43NETzsUdbkg==
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr14222500wrr.10.1585996063988;
        Sat, 04 Apr 2020 03:27:43 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c18sm15833178wrx.5.2020.04.04.03.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 03:27:43 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: convert rockchip saradc bindings to yaml
Date:   Sat,  4 Apr 2020 12:27:28 +0200
Message-Id: <20200404102730.3295-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current dts files with 'saradc' nodes are manually verified.
In order to automate this process rockchip-saradc.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v2:
  Add reviewed by
  Fix irq.h already included in arm-gic.h
---
 .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
 .../bindings/iio/adc/rockchip-saradc.yaml          | 78 ++++++++++++++++++++++
 2 files changed, 78 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
deleted file mode 100644
index c2c50b598..000000000
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Rockchip Successive Approximation Register (SAR) A/D Converter bindings
-
-Required properties:
-- compatible: should be "rockchip,<name>-saradc" or "rockchip,rk3066-tsadc"
-   - "rockchip,saradc": for rk3188, rk3288
-   - "rockchip,rk3066-tsadc": for rk3036
-   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
-   - "rockchip,rk3399-saradc": for rk3399
-   - "rockchip,rv1108-saradc", "rockchip,rk3399-saradc": for rv1108
-
-- reg: physical base address of the controller and length of memory mapped
-       region.
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-              depends on the interrupt controller.
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk" for
-               the peripheral clock.
-- vref-supply: The regulator supply ADC reference voltage.
-- #io-channel-cells: Should be 1, see ../iio-bindings.txt
-
-Optional properties:
-- resets: Must contain an entry for each entry in reset-names if need support
-	  this option. See ../reset/reset.txt for details.
-- reset-names: Must include the name "saradc-apb".
-
-Example:
-	saradc: saradc@2006c000 {
-		compatible = "rockchip,saradc";
-		reg = <0x2006c000 0x100>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
-		clock-names = "saradc", "apb_pclk";
-		resets = <&cru SRST_SARADC>;
-		reset-names = "saradc-apb";
-		#io-channel-cells = <1>;
-		vref-supply = <&vcc18>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
new file mode 100644
index 000000000..9b9882323
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rockchip-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Successive Approximation Register (SAR) A/D Converter
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,saradc
+      - const: rockchip,rk3066-tsadc
+      - const: rockchip,rk3399-saradc
+      - items:
+          - enum:
+            - rockchip,rk3328-saradc
+            - rockchip,rv1108-saradc
+          - const: rockchip,rk3399-saradc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: converter clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: saradc
+      - const: apb_pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: saradc-apb
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vref-supply
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3288-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    saradc: saradc@2006c000 {
+      compatible = "rockchip,saradc";
+      reg = <0x2006c000 0x100>;
+      interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+      clock-names = "saradc", "apb_pclk";
+      resets = <&cru SRST_SARADC>;
+      reset-names = "saradc-apb";
+      vref-supply = <&vcc18>;
+      #io-channel-cells = <1>;
+    };
-- 
2.11.0


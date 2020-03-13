Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAF184814
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCMN3g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 09:29:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMN3g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 09:29:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so9945476wmc.4;
        Fri, 13 Mar 2020 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lEkfce6ps+UhmXb+c5fNG4aKtiEwyEYC75rMDl9C7ik=;
        b=lgLZJy0utG5SoquafA2HUHEAEzHi6MbriJ8r9wAgdDRgVB2UtbAZqIS9doBFyBn3qu
         Q2bNE2bCyi7HWDSFqYn8JmXEjvphB0AqR1ZNHDbsufLASftuPV69RiuqYldlc6/WN7Ha
         zR5lmfpQ7nri6Bca+EYYbwZ5kKoQhFK4gp95yK+5hWrYljn5dtHXRw0sAedWmvk/fGXX
         2tRzWrz68bGvC0eIpVNS8fkhSIiGMkNhXRDVw8IoG6JWL8vNqt2WKRdw6qeOwDtpEcVC
         ixNbQEOScjAkEd0eBflSBkhNSc/7DDrBk60Lniac6tGbGmJ0OjLgDfdN9w42I5//RhQl
         bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lEkfce6ps+UhmXb+c5fNG4aKtiEwyEYC75rMDl9C7ik=;
        b=VGFb7jX9zITq7B2H23XeFWGTZIYA4G26AfIa45JEGW26MwOrVYrZIfMWqnVcj3FzEm
         h5xQCTVmyBfuv9/69U8kETQwstpYHcRXwS8tlw/BnVdXdtL3VsTGEXENOnzXT35izw3O
         T2uViDgJZkz4f3BiudubxlGcoJCa4qK0HzWwcd9r9bt+HfVICWs5oaGWLosPfjn5DSYD
         Yo+SLYlwTV1u5Te13L+ncALGV9yaM86Rd3+raO0yF79pIBr1/ZA82l2L9N86vQkhg+M5
         JqbJThnhCxYL0EILREDVyCc5fss31/4eLz8+/srwmTIC2M7lMj6ycAaRfhkydmJ8asYe
         jGbg==
X-Gm-Message-State: ANhLgQ1UiLiAQtT9dlAmiXANg5R8egK2Sy8/PpkzG3FLKA8gMN6+SXk0
        ib0dr+Gfm7wYHU8aoPgOzps=
X-Google-Smtp-Source: ADFU+vuwLQmmZnIs6S6VI+FSvk9wQ+gnswe4ErfBUUselxUc9eSD+2hTZU+er34sHCdtoP1Bo4k4Mg==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr10866750wmc.15.1584106173975;
        Fri, 13 Mar 2020 06:29:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z19sm17576705wma.41.2020.03.13.06.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:29:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: iio: adc: convert rockchip saradc bindings to yaml
Date:   Fri, 13 Mar 2020 14:29:24 +0100
Message-Id: <20200313132926.10543-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current dts files with 'saradc' nodes are manually verified.
In order to automate this process rockchip-saradc.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
 .../bindings/iio/adc/rockchip-saradc.yaml          | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 37 deletions(-)
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
index 000000000..2908788b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -0,0 +1,79 @@
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
+    #include <dt-bindings/interrupt-controller/irq.h>
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


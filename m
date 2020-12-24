Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE52E26A6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 13:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLXMJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Dec 2020 07:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXMJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Dec 2020 07:09:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13009C06179C
        for <linux-iio@vger.kernel.org>; Thu, 24 Dec 2020 04:08:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so4236694lfa.13
        for <linux-iio@vger.kernel.org>; Thu, 24 Dec 2020 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXSOYUeE7WdWHcLL4T+VWHB8BL3Rv9V0zNuUHemp1v0=;
        b=HnePM8zASVjZLPWtYrzTorFE5bAuxHYbaUapsdC8cdZgRuRhaINVVkXilm3luA14Ao
         fvo5e+sNYMWLnLKFG4rDR6NrDeqSbeENa20ahyDqXA09ciq199fqrM7j7+yw2tPlstMj
         +b5+C+qrn2IYlAjlh273s0QTM00XZzO32+RY/IjgcKp/6rD8VHoiCrgZ6PyQiyiA60WG
         5JAPJxabQVQ0hRFZ0B0KT9DYD6z89g0tXOpa6aPwO1DVpCTnWF5Qp4mMJJhiLiNa7C2c
         UMjv2Zy7lI/VzEiEGWCC3Fi/PF4k8DQhBIUCw4MxO+F2gv//QDfdjJ4f70aCE6x2ZGPT
         g3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXSOYUeE7WdWHcLL4T+VWHB8BL3Rv9V0zNuUHemp1v0=;
        b=PgF4Jn7LOAyaEHXbLNM28SpEPnLl/q/Ugv2ph1OACueCv6Yng2jFAcRC95u5fGQQDY
         5vuK56m1DgstT1tpkrQXXN65WuFbt1X/B9zdo0dcF9reqHtaqSljdAjkhbeaEp92gWEQ
         WOXEjpbXyf2NFCqi6+B5+dXTDivL2QCHYLgu8CBS+67/NjS9dVoXpYXeG6BWbWaZZher
         ikfZipG1NeE73tOdm+zr9FQeaqfRO3Gy6NKaxe4V1fldMsAsADZIh77mbDcjFzGAiiX5
         xDHe/daMhHQpEwiR1x8L+jY+uUDUxvXhKdwieY6myeQ5T4DFCTJYWvsdpf4umw+Pb5bF
         UgOA==
X-Gm-Message-State: AOAM53097XPMazBrPysPq6Nwt3pl5NkM16SFq3mVusDj0kTyt7yZtA0t
        hcL4eQ78rSBIw3G5EJkW4YG72g==
X-Google-Smtp-Source: ABdhPJxHUmNxCvdN6f6RJGIi9xqib39gsgkBtH8zqVEhBE2rSV5+s3FnpT/NSwO4HuNvy/LJw92hAQ==
X-Received: by 2002:ac2:51af:: with SMTP id f15mr13393533lfk.592.1608811709401;
        Thu, 24 Dec 2020 04:08:29 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id r75sm3552242lff.97.2020.12.24.04.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 04:08:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2 v6] iio: accel: yamaha-yas530: Add DT bindings
Date:   Thu, 24 Dec 2020 13:08:19 +0100
Message-Id: <20201224120820.1120099-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the Yamaha YAS530
family of magnetometers/compass sensors.

Cc: devicetree@vger.kernel.org
Cc: phone-devel@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Bakker <xc-racer2@live.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Resend with the other patch. No changes.
ChangeLog v4->v5:
- Collect Rob's Reviewed-by tag.
ChangeLog v3->v4:
- Rename the bindings and file yas530 after the first
  introduced component in the family.
- Simplify conditional logic using the if: not: YAML
  constructions.
- Use the possibility to set a property to false to just
  remvove reset GPIOs and interrupts from variants that
  do not have them.
ChangeLog v2->v3:
- Restrict to cover the YAS53x variants, it turns out that
  YAS529 is a very different component from the others so
  keep that for a separate document when/if needed.
- Rename the file and binding yamaha,53x.yaml
- Use - if: clauses to restrict some properties.
- Fix some spelling mistakes.
- Restrict the nodename to be "magnetometer@[0-9a-f]"
ChangeLog v1->v2:
- Add Yamaha to the vendor list, I was surprised to find
  they were not yet listed.
---
 .../iio/magnetometer/yamaha,yas530.yaml       | 112 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
new file mode 100644
index 000000000000..4b0ef1ef5445
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/yamaha,yas530.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Yamaha YAS530 family of magnetometer sensors
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The Yamaha YAS530 magnetometers is a line of 3-axis magnetometers
+  first introduced by Yamaha in 2009 with the YAS530. They are successors
+  of Yamaha's first magnetometer YAS529. Over the years this magnetometer
+  has been miniaturized and appeared in a number of different variants.
+
+properties:
+  $nodename:
+    pattern: '^magnetometer@[0-9a-f]+$'
+
+  compatible:
+    items:
+      - enum:
+          - yamaha,yas530
+          - yamaha,yas532
+          - yamaha,yas533
+          - yamaha,yas535
+          - yamaha,yas536
+          - yamaha,yas537
+          - yamaha,yas539
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: The YAS530 sensor has a RSTN pin used to reset
+      the logic inside the sensor. This GPIO line should connect
+      to that pin and be marked as GPIO_ACTIVE_LOW.
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt for INT pin for interrupt generation.
+      The polarity, whether the interrupt is active on the rising
+      or the falling edge, is software-configurable in the hardware.
+
+  vdd-supply:
+    description: An optional regulator providing core power supply
+      on the VDD pin, typically 1.8 V or 3.0 V.
+
+  iovdd-supply:
+    description: An optional regulator providing I/O power supply
+      for the I2C interface on the IOVDD pin, typically 1.8 V.
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            items:
+              const: yamaha,yas530
+    then:
+      properties:
+        reset-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: yamaha,yas539
+    then:
+      properties:
+        interrupts: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c-0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@2e {
+          compatible = "yamaha,yas530";
+          reg = <0x2e>;
+          vdd-supply = <&ldo1_reg>;
+          iovdd-supply = <&ldo2_reg>;
+          reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
+          interrupts = <&gpio6 13 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+
+    i2c-1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@2e {
+          compatible = "yamaha,yas539";
+          reg = <0x2e>;
+          vdd-supply = <&ldo1_reg>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..0340674c72bd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1210,6 +1210,8 @@ patternProperties:
     description: Shenzhen Xunlong Software CO.,Limited
   "^xylon,.*":
     description: Xylon
+  "^yamaha,.*":
+    description: Yamaha Corporation
   "^ylm,.*":
     description: Shenzhen Yangliming Electronic Technology Co., Ltd.
   "^yna,.*":
-- 
2.29.2


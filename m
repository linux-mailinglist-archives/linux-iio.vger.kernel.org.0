Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73518376E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCLR1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:27:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCLR1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 13:27:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id a141so7271458wme.2;
        Thu, 12 Mar 2020 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=cVk2HL+kxXk7Atw8HmEIjfw8k4LlgSi0Jn8gtlJKgHoWup2Yd5XF6Fl8f9KzfDgRAu
         4SYskopDZtIcX81U77BXs5PG4S4RIRMjjUbzPuhuq8JeFRS6BWPH6R6VhGZmyH2a8J+6
         LGvdUIPxDNbprPetXrw38VflAWaBoHHALBLhfJrn9XPt+YSBP/rUHfw7NRRq8hHdVqTw
         SS9S1YbZSnsuEiK5sj96VoqKy3UO4MTb75u2ROjTTO8QqGWAZl2LWZFgdfq0X+7Zf3zC
         fDP8PJ7DzIV8JqfqTYpJb+yV49GsKjk92Q7FH8TaWTOoY65HDRIYk6Q2Jal79BppEb+T
         ylmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=D8spvneUrn4Zcv3fzHVw2F+46RdJb80VzejWRLjkHNBl1WuqDy5Ll7lU2fgpGjpn++
         9JCVJNHVXTxGeylw+CkJT7bOERoVdI0Pf5WvkDSNlvrEFxXOiQRw4X0xsE5vOjIo/sAi
         cT+hepqSU1ulXLUV4cA6mSnvjoSRq7ZRNWQHP6KI0xwmJihvLxHZr2jE1px2zEfupiQ/
         NIrA42g9HxX3BafZZkaCxfOiQIsr3yq1zVr6ogbQqqZlX95d/kJE8fflsRZezLqKSy7W
         QOpSy3CtrwlD+bhXxgdlVxiwhgkhQqldSDhU11ys8XdhC1Ud6GUgWzvwj99gOCT+hkTj
         srVQ==
X-Gm-Message-State: ANhLgQ0RisqbNb5Z9Ro3+SlFOGHdB5THRxOOk5igFCfyDWKJ2w0j9MSs
        BTHt0eJqOXcBJelkN1D0bA4=
X-Google-Smtp-Source: ADFU+vvLpARrQlN/+0++1RhBeG/jCbyY1pGG8gEUxOn4LHgTCwASBnZyTIyoszDHVWeoaOkEm0gP4g==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr5548646wmk.97.1584034028729;
        Thu, 12 Mar 2020 10:27:08 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6C4B.dip0.t-ipconnect.de. [91.63.108.75])
        by smtp.gmail.com with ESMTPSA id c11sm76254500wrp.51.2020.03.12.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:27:08 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        fabrice.gasnier@st.com, beniamin.bia@analog.com,
        linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
        fabrizio.castro@bp.renesas.com, info@metux.net,
        hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Thu, 12 Mar 2020 18:26:45 +0100
Message-Id: <20200312172649.13702-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312172649.13702-1-sravanhome@gmail.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..f5b8c73123c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MP2629 Battery Charger PMIC from Monolithic Power System.
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+description: |
+  MP2629 is an PMIC providing battery charging and power supply for smartphones,
+  Wireless camera and portable devices. Chip is contrlled over I2C.
+
+  The MFD device handles battery charger controller and ADC IIO device for
+  battery, system voltage
+
+properties:
+  compatible:
+    const: mps,mp2629
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@4b {
+            compatible = "mps,mp2629";
+            reg = <0x4b>;
+
+            interrupt-controller;
+            interrupt-parent = <&gpio2>;
+            #interrupt-cells = <2>;
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1


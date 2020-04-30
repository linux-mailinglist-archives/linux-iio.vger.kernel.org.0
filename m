Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961211C0113
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD3P6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3P6W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:58:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD0C035495;
        Thu, 30 Apr 2020 08:58:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so2468207wmb.4;
        Thu, 30 Apr 2020 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPPULoNFOiHN1wQeO/5XgTLf2n39COR44XZpOJQLw28=;
        b=QyNrwT+WNXchl+9yKQicG4Q3p56veqUYcTRzcIlqNU1z7zPsdYa/L7H1C6RbEn2ZjI
         7GI6LfwhnzkW9tc9htFUibUuZTSDXPMwXXAuSUBqb1Zq1E/QbFJ+7TWFtxl3vZqwJwOv
         ZHqzp+RbuvRGNofkpczTN+HogOVx7ydvXbc1WeVEJCx7oz+TjnY+H3pFqOqjYrTNcW7Y
         cworM0Q4P0+fN6GjDfTA3J6rr+hm0FR878ILWgXdPWXEtDA2H2ZJ/DGtVuuvONLjM6PK
         DOTqkGY+OvZ6T/x4qDIxX5CkS9w9P0o7Bc68pvxSKe3vfgdqiQFxuXYATydTBATDDlVT
         ++fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPPULoNFOiHN1wQeO/5XgTLf2n39COR44XZpOJQLw28=;
        b=FaDt1uV/IgJwuZ516BbO/Ok1Hi8gkbyGYGAQVatNShRf2ib8KWiziFsuK4La9a8peS
         b6TgqV4TY/0cXOdH6ShYIFcBNSdX01sOERKNB6+0cgjoXlyL+g7WpqhCgXFYutsiNxFR
         zo0+AyGzipyNZqOFG2TBRLcoadsBOxdgmj59OIvC5893UFQrdNbyyMAScJ08dO4pKab4
         H3vIi4hDopsMyCZ7QdyJ2qPOtxxhqKPtjD1GEt+lcR+44nrbH8PuxScmF1Y98aXzmYYJ
         VuC8NGXyovQevwfnPSxx+bBW+Zgeo31Wxzm6EHRda1MIGGXirt0/rEG4s5vyi9TbVcr3
         4XnA==
X-Gm-Message-State: AGi0Pubzop41TtfPMTeM0+s1U4oawZHPNSXqLFWHo+GKwDiHTIROiPyV
        2rlwpDzWn8b7+2IRm/oT/8g=
X-Google-Smtp-Source: APiQypJ06DFupF/Xb94Fv10hDtfNyoH65DEbcEDGvCnSx5MMfP8FGTMn+W/k6TY0AwEgN1w+0d89JA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr3848184wme.126.1588262299841;
        Thu, 30 Apr 2020 08:58:19 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id w8sm265410wrs.25.2020.04.30.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:58:19 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v11 1/6] dt-bindings: mfd: add document bindings for mp2629
Date:   Thu, 30 Apr 2020 17:58:05 +0200
Message-Id: <20200430155810.21383-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155810.21383-1-sravanhome@gmail.com>
References: <20200430155810.21383-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..f91acc42d652
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
+  MP2629 is a PMIC providing battery charging and power supply for smartphones,
+  wireless camera and portable devices. Chip is controlled over I2C.
+
+  The battery charge management device handles battery charger controller and
+  ADC IIO device for battery, system voltage
+
+properties:
+  compatible:
+    const: mps,mp2629
+
+  reg:
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
+additionalProperties: false
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


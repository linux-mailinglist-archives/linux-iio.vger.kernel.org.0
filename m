Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647F71A4B14
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 22:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDJUT7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 16:19:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34056 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJUT6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 16:19:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so5488012wme.1;
        Fri, 10 Apr 2020 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=tEWouepeOBnkwpGOvYEz72FlUXHzXWFMhxql50JZqcDON/x315NbHViA6ppKBr5Poa
         zh1WZ9Q8O3sqfwbOBab6gmrH+bVaGKADXNRSXixaUfBj1N/yN1WcNYRf380lHvpKDNZa
         reB2YwsyBe0grB3mGOyLrLLnEumj5DvGcu1D/e32iEdFn+xV5qgu9/FsGG1vuFUNrmGK
         LKAKEByoWdL7e7wAPwp1oPFtxhCYwPae2YWevpOR/Pz8Etqt4bcX1vXrWwPfHRTBTYfz
         3LhJe4OPyAu1lSp6AMh6PmRL4af1omXUM25UpAXh5GOluG8YwGo0nKLqbdPA1SlQ0OZF
         BT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=qs1yXaWemXy+gEn1REDjEK+O5OUsCuU5J831oFqKYoJIr+kbmWnSZOvI0AHfLjXQXg
         EgSGTnwwTi/KapAVQSuz3t9Wa5Kq/Bm7NF/5cowQhmMfIUbTWJa2OZ+ew+Nqmn2ddJ4Q
         zCRrAyokpg2kawFjPWh2bUl4jzi7c8zFYxoNhv/HeUi0A27w0YPrkakBwq2dB07BohNh
         TSQUuKgOics9IP4daKSskWr0oshtqj46Gw/8ysJ5GPwMj2kHLJDb3t0aSB/r1CtBaBPt
         U18facpuk6Xa75bb6Iz0QRFsiISo1b2+xMdl0/mXSmvVyhgowAtnSQlm8/bxQvcN32FG
         nFCw==
X-Gm-Message-State: AGi0PuYPt8HlHa2yCUBuhTn6db1+b0mMmBvALBt8+a4w6MTHSgcCypSy
        if560TnjejIUPfXHH5xsQ1ZAmGQ1aM4=
X-Google-Smtp-Source: APiQypIWWW1ti9/6J8Q77omeOkUuh/VAMSMmGIR1Dp/tkQ8kN9TBMyeB0vy9OKK3vFglkF1hBiEk9g==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr7123399wmj.13.1586549997247;
        Fri, 10 Apr 2020 13:19:57 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6388.dip0.t-ipconnect.de. [91.63.99.136])
        by smtp.gmail.com with ESMTPSA id n11sm4405187wrg.72.2020.04.10.13.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:19:56 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v7 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Fri, 10 Apr 2020 22:19:44 +0200
Message-Id: <20200410201948.1293-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410201948.1293-1-sravanhome@gmail.com>
References: <20200410201948.1293-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..e71c554802a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,60 @@
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
+  wireless camera and portable devices. Chip is contrlled over I2C.
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c@7e205000 {
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


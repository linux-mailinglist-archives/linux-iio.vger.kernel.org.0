Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFD1A6B6A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgDMRhJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732864AbgDMRhH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 13:37:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E90DC0A3BDC;
        Mon, 13 Apr 2020 10:37:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d27so1778724wra.1;
        Mon, 13 Apr 2020 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=fDIcoNZgVygOPRmNWeOwfJnxxU3kALx/SKQZvXWXOpsxNz3mnVkjGmjToWC+sc4ZEC
         NpIxAcNks+b8au4DkwXgIOyk0IM+WvQYu+3xo5xgLC5ugTCxRN3QL8XpSUvfpAng6g1p
         GIvZu/DnQAVzG8tuQ5Xkw4xj55uGAWtPYGlM/CYWP7Kmqlfbhe0r4iJyT74UtoTYqKiS
         2mbQi0q8a37wDWyVjGMwKtLkkpEBy+qlMM4H4786KHATyJhW6n7Q+V0jIh6VwarRWGEg
         vsKyqQtzAFybdjbDQ+lufu7i8ZoHSMcN65UJgsg8NWvAW/e3M/m+5GV4lvxdczW5HR0I
         HBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=qMedG7hLKKUR+ONTTcuxbAik+08XZqYyLDbQ+G77u6UpswAtCJ3b+GTNgFmTW602aM
         8yWO1Wwn4IhNvGkW4MdCBVaAbL4C0m/JjVCDOIuA1XRfxDUWWKUZyhmrtVkH1bufTq9f
         oWld8AKjJw+DgE0SsSlq6BJG2Ydo9mUf2cKJjgFlLQ89lj8QGuM/9RfBzkkyOR3MCooS
         j9reJ+3BULlgofUoWPFd2UDnYRO9vg6ln+4PF2Qo9IZyXFfCLjBMegFkJ4huAbKpccfX
         c9dIDOpGZ2T5lxO7eSMDan+AtDKbbt2AFkMKF/1B3plmYZnWgfYkabPnVlouaAucueD+
         VPvg==
X-Gm-Message-State: AGi0Puat+OuuMDpP/TnKE/HnuUiG1a0kssGKSEsrWrOekTbaUsfJH3qP
        YZiSgI/81fuIieS1/rKNvec=
X-Google-Smtp-Source: APiQypLUshspgNvpGiRKxHzyNuEL/PyESgSOmIqJqqQYJgFY2XZ9o8RUBgYg5ezzds4EUkh7cO0X4Q==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr15916660wrn.379.1586799426135;
        Mon, 13 Apr 2020 10:37:06 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id a205sm11141465wmh.29.2020.04.13.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:37:05 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v8 1/6] dt-bindings: mfd: add document bindings for mp2629
Date:   Mon, 13 Apr 2020 19:36:51 +0200
Message-Id: <20200413173656.28522-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413173656.28522-1-sravanhome@gmail.com>
References: <20200413173656.28522-1-sravanhome@gmail.com>
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


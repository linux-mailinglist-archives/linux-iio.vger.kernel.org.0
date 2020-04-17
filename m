Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FD1AD8EF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgDQIuZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729748AbgDQIuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 04:50:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF631C061A0F;
        Fri, 17 Apr 2020 01:50:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so889797wrw.7;
        Fri, 17 Apr 2020 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NCVZU/bSt76/hiidvSrjEJc/qNxlzUEMq/1bB2ttNxY=;
        b=W5OxyGuanL+7DSyVsNAI8cIt5HT0/VgXRrpMmjaQI1BDXmK8Yxs0x7vOR1XUp3quYc
         dzU6XZejFy5lC+HqWU6Ayq0VY2qjpzYddZdj4EKfHK/FScdaXBscgJ6cEzVkeOYkwck4
         1poskfy9VL94QkQPps57vIYyuPdLRkWCbAuDiOvL46aRJdEuHD5+ILOdfyhcGxQnHsrs
         qFkmPr1BtneHJaLZWAFF1BpG/FUYmIrNUeSghiZpeNsgw27deK342yxwrvg2ENc9ggvt
         xWpiwsbQ14O/qadvHmRhdzu+V76V4gfW8UnFj4auj7RpHkeuUGMzPbeWUFq/j6XjXpDT
         Nu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NCVZU/bSt76/hiidvSrjEJc/qNxlzUEMq/1bB2ttNxY=;
        b=FThjYW7yKVENIH7WG1y7LyCMCsk3e6ZwPY+4auqv9sNjnJQxQXnUrSF/C9GrBJ2lPy
         MHdos4D+NAMSH+wVX1xyN/8Tdoy1OZ+Q5/d/NEyRP9Qj3r3WhLZyfXXvatR3qEWGN4Lu
         WjYTqmni+pxwKSQ4m2f6+cyQ5A9dENDr4T9nzWaXqdENrrhs4T/LDPfSowvQEjrC8+ws
         JkDoDpy6O0tEZnHn/k28Jm+zs7li2z6D2Lo3twn6I+Wg7/8GE761XgOkX55cSND4pUSI
         bpb94FPAAVvmtbXN7sKEHGSFPA22Qd4UHI6TYCrBn1NwqIp8hfBF7XeJvqB+Hi77MZA1
         89uA==
X-Gm-Message-State: AGi0PuacyPwye3IQblDZfYCY2hFgjAR/JLqIlaCAL+7oyzNDJxLV1CoF
        1EhsPoqWvKyKpRMYYlw4Q9E=
X-Google-Smtp-Source: APiQypLNnUiUNRL2Gm0jcpPDvKlx5obVgmeRPznD72jGzYOq+Buea79ag2FNssV2gDbPWsWGvIdZVA==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr2641819wrt.407.1587113419736;
        Fri, 17 Apr 2020 01:50:19 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7443.dip0.t-ipconnect.de. [91.63.116.67])
        by smtp.gmail.com with ESMTPSA id l5sm6807527wmi.22.2020.04.17.01.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:50:19 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v10 1/6] dt-bindings: mfd: add document bindings for mp2629
Date:   Fri, 17 Apr 2020 10:49:58 +0200
Message-Id: <20200417085003.6124-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417085003.6124-1-sravanhome@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for mp2629 mfd driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 .../devicetree/bindings/mfd/mps,mp2629.yaml   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
new file mode 100644
index 000000000000..b25b29259d67
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
@@ -0,0 +1,61 @@
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c@7e205000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x7e205000 0x200>;
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


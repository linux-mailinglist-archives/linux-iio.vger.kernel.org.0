Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAD18581F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 02:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgCOBym (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Mar 2020 21:54:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38593 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgCOBym (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2020 21:54:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so14776539ljh.5;
        Sat, 14 Mar 2020 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=JUwop040gLiKIAwr/wO4yQPmhewu6svjiqYk8A98SJb06eqViIfO5fo/GzugnsbG0J
         hcuqQkAqB0A623J5OpNpk4YQKjePUYsW3l9fgrukoaCtR2K0rpRZvbYxZxkDc9SZX3cc
         8Vq9kj5Df6Zl1vPVIit5jEDtsVLOOs6mAreaYvQUdVBCOg0ZZc2OorVyFyRM3KcBDZQg
         nCd/9Tv8hMhEyqutPL9uxrQQ/Hj5Z5NR7KS5c24xwT5OaF73B7ukRGpUPE4bzDD9dXFn
         sPacRjkorP3XjH9YxGkb7AeqrtX888jlHqQqCEVP+ODDdN9XzypxsEFhtkNS+1fzWIae
         K5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=OOyzngNLD8P6cxSGDNuoG/pQJbuwrG6IJPDeU2jzaUvdkXz5pErX5XQ0y6yt34xXr2
         GqbRT9NVNXriCZ53a9DwFwRfZIf6gXUg23QZyJz4/9YpRiWDhiROMUKqPy+wn0h4sA6t
         0cSUPr787Osu/ym+JDsHkh1WLoIAUUV3thIep6ViWmtJivwtO7ahYHQoS6zRgKrgpR49
         eAQccrv9KTSLWML+a14WN2gNE97sp0ovLfr+WEtPueuMldRX1tPMIJ4nDnBGTGuihxXQ
         p8/mtFlAr2/bx6Gfu1Pnj4IEL2cta/0TlabYnqkAHPdimzH5co/megnqHJEbUzJItf/m
         hgXA==
X-Gm-Message-State: ANhLgQ0+PwSnY9xv+c/VGqZ8+eyhQFdTEOHxt1JRBeYE9wohrPuHKp9r
        Pnt/pY/41US63O1qh5RDCeLgLdOJkEo=
X-Google-Smtp-Source: ADFU+vu+LHDh3jXlJSxkrwyxND7tgM2Lw4qfJCoc6nDWHgNSm0RajY3Ww9rc+ZwTI9IFgI7kgs2/EQ==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr1571584wrs.364.1584230426552;
        Sat, 14 Mar 2020 17:00:26 -0700 (PDT)
Received: from localhost.localdomain (p5B3F731E.dip0.t-ipconnect.de. [91.63.115.30])
        by smtp.gmail.com with ESMTPSA id 7sm11394469wmf.20.2020.03.14.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 17:00:25 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Sun, 15 Mar 2020 01:00:09 +0100
Message-Id: <20200315000013.4440-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315000013.4440-1-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
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


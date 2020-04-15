Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF21AADD8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415581AbgDOQVW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415559AbgDOQUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:20:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F941C061A0C;
        Wed, 15 Apr 2020 09:20:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so251148wmc.0;
        Wed, 15 Apr 2020 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=aB+8LAPenu8u8j1QpgHPfqtPuw+2gk7m44m/yASBm7pHbXhE/pfhpizNu1p3P7UFv9
         am3QPD3QN4JqJbymGvLY2IyNNCapui35nO/wjAk7bgEBBWv+kq5+aYyNTNs15WXq2jJG
         hRjbMG2qnlciQcBi8HFzjotzGsB1D3vRYD+Z7YGDbGgcFzyuiakjoy+zAo0rihDzZteK
         OLV53B3F4+9XcGB4Qh2Etb4eIM8eaZfZBEZzv4t4xrvK8VkuRu+6Tx/gQ+hObroBYUVq
         BYgYPvecwi6otXKHaH9CmBLFfqfAryvVMKBqnSLZPr42tEwgP1R7QIbIAaiUuOVQEVjk
         99+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kaq0gyVDK71RemoPPD/qDBGyBcEjT8bXtwKNY1omfRQ=;
        b=TPdkQgd1fdIqNERZ/PsveuuGsepqOR3NsAZlHKtJF1J3rLKPlSlJgBhmTClt1pjylW
         V3qvZ09WjXuMLZvopDIUSaca+4sF3cYFQua/er24wdTBC83AvlDJPUoGQTmSUl5ZbkvA
         Duoj/s85JM2OA2TSnOY+lylK++CoJrUFKTUOCxIar2f8Xqc2ghiB1Em+/i+6RK3RDEQ/
         44uWByeuKhXr/TGeDtgOGTAp84l/K9XlHTRXjDUOjE5rz07KRUU2Jzl201c33yeVXcB7
         2rvRIsj7WPLTJmDTGhVJriTZVJk7eo5vfoyRFXIfowhfp5GsbrexHB+1EWeTDcErbksS
         Judw==
X-Gm-Message-State: AGi0PubFIj4Moz1CLCIbO4lJSeauSPEDQm5Pag0Z+omKLwT0qJAPfUgQ
        yjfGP3x/FZ5Ut+pJwC+Q4s4=
X-Google-Smtp-Source: APiQypK85StzSV6YhdZGFDOnj8XwLjnRbBVLo1rlb4at4q3Cl2x6KDIPfaGL+5DfyV1TfoM18T42+g==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr6166355wmc.107.1586967640041;
        Wed, 15 Apr 2020 09:20:40 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6CCC.dip0.t-ipconnect.de. [91.63.108.204])
        by smtp.gmail.com with ESMTPSA id 17sm102526wmo.2.2020.04.15.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:20:39 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v9 1/6] dt-bindings: mfd: add document bindings for mp2629
Date:   Wed, 15 Apr 2020 18:20:25 +0200
Message-Id: <20200415162030.16414-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415162030.16414-1-sravanhome@gmail.com>
References: <20200415162030.16414-1-sravanhome@gmail.com>
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


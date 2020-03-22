Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50B18ECE9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVWa3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:30:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40437 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgCVWa3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:30:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so6931374wmf.5;
        Sun, 22 Mar 2020 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=XtTdCQkpr+o6kyj73/aQkfTjIwMxz9y4AdHrLcVTm6dU7p02lHc2xghfjD/MNZzzJu
         k4jQxRVegQTIy4APZ/F6XwKw0PzQXisKO4VkiojrjUA/CF9dbRvtpBYvKfchEq5U5xh+
         UlNZXEvsQNIOapPVZClHmziLzIdz2e1g/AL6NPsbz27poj5nwoOHFWksZX5IfETxdzI6
         6PpiggwonuXKjDEmlu8p2yI/d+3Rsf3npJnREawz5jFPGjNE2aLObxdptKbnRvHpb/Nl
         uOGCxmLelQ2oyTQzpjLmAd/EOMDJvjBCPXJzGG7RSxJ7BVXvyZI9doMgArjBYSY+n7S5
         BaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1IoBnnxV2Y83h2tlBdWy/1+5bjdle9P7nqs3bJI3i8=;
        b=VlEbSVWwzgpTNBn7808lDn5WjjBOGZA29AEDnCOCquPCIzFE52sXziz9RQXC6ITqx9
         ZOKz2EELgV9kbuoXgSCQHzd6stsXK16DMWNTCtlLLCRKWuOcjxSaZgP89AXBwG7X1Ozq
         WQq5AJsdzRIrWxLvZXW7XIOnSIPaI0cM4DLj3UuFup+4W6EDHTXaYYY3XU/c/GKHse0s
         zm6jTvletz2Hp4lPONqBskR1VP6YtJW971xW9shn6jJP3P+QlVc6RIguVVKpldGCFfcS
         ihjrunDIr38Zgth0NzuLtC8VU2+TtrntW4OSL50UtokB/DPDkOpdh1gHGpptILoyp0aU
         aMxQ==
X-Gm-Message-State: ANhLgQ0vhohePvACvasw/UanLw6iAj2UiZ7LX1w+eEalMlpcIKb33TP8
        mwOYBXmvAgVAesedeteuuKU2X5uR0nI=
X-Google-Smtp-Source: ADFU+vt6WlMVjqpsPBPqnWoIiKd2ytsU9yzX0B0Smb/AF63Sc62fiu+9H+YrqMVCDAwy+28cuKiSSQ==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr24368421wmc.134.1584916226413;
        Sun, 22 Mar 2020 15:30:26 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id p13sm8060517wru.3.2020.03.22.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:30:25 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: mfd: add document bindings for mp2629
Date:   Sun, 22 Mar 2020 23:30:12 +0100
Message-Id: <20200322223016.11509-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322223016.11509-1-sravanhome@gmail.com>
References: <20200322223016.11509-1-sravanhome@gmail.com>
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


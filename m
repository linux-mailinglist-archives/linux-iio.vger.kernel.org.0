Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367E8322104
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 21:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBVU5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Feb 2021 15:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhBVU5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2021 15:57:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D7C061786;
        Mon, 22 Feb 2021 12:56:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so20518435wri.3;
        Mon, 22 Feb 2021 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hKA/RiZIFqx0Id47cIvsl+o0hc5VrrINM433W+yfZpQ=;
        b=Gz5ddlaldaWATuEiHzCckRx1AcZ1D2oqeP4t2GwJQzMbvF71lJO7IQdmOzVkKUjIHM
         BnTl9rS5rzJ5LtEW0hsL1J49fMPGJh2MEjar5N/7imtuyn+nBpjAoL+1y3nigOyZvYJt
         AMM/QfJ7yK56Xtp9OGOq3HWlNXa3gvwCmwKwOywVqw6vor6IZEq2ytt8miBZPQzt8Fkw
         WjaVjCgfQ/7+7FnZf97QB5II0NpzvoeNjzek487eQR5RUmlhchSyBrtWuljDx1GPwiHQ
         kTL5Prh9ATyRx0ciBto89ny/PN9CIQ1KdI6bHZyVFpvDsMBXRMrAgGyo1OOoNWcxPZRw
         wFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hKA/RiZIFqx0Id47cIvsl+o0hc5VrrINM433W+yfZpQ=;
        b=UCncpYqfb9SRW6wwy3fjWLAKXEq/81ZHKzCFTgFDtr/GNceRjmbHqV3nPEyaHbEBEU
         AIVle6yqKeuGlrVcoGhAGbqfIjrf67fFu13y7FQPKKjM5ZyenMG4yHOK69H+bsR4PZoy
         /Q1nRnk7KDjFLsnmr0vA4ezyu9cBtW8x87TXUXyb05Vi5oD43KSZcct5hF6RY3vjgpya
         hLxOWDFIg/seW7YbjI+03LdalrdZSKmFh4KukKKyzzbLz5MkDWzHrM4txUoEOVwkPgbB
         B8hFD9JCYtCj2xDlbjA4PxDvPTjoPjAoXEoPHLx5MwgYlzN2HmZ4WIcoTSv9M6aFxkMw
         0QYQ==
X-Gm-Message-State: AOAM530yiLoCf4b6OxQYV+Il1stU2qglmencwz2mZo9K9yt/xVF0eEjT
        oVCziHHjBKcLZ7C8foLh1Cw=
X-Google-Smtp-Source: ABdhPJx91TIGIVjh9mabNUmNVDbwIQbJ2oN1sdjk597HNtrck0vxdGhydheuavZwQ01zxEoGEiHAlg==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr16560904wrt.69.1614027391902;
        Mon, 22 Feb 2021 12:56:31 -0800 (PST)
Received: from pop-os.localdomain (cpc126866-lewi25-2-0-cust31.2-4.cable.virginm.net. [82.7.143.32])
        by smtp.gmail.com with ESMTPSA id m184sm482713wmf.15.2021.02.22.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:56:31 -0800 (PST)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Joe Sandom <joe.sandom@outlook.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Added AMS tsl2591 device tree binding
Date:   Mon, 22 Feb 2021 20:56:17 +0000
Message-Id: <20210222205617.25866-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222205617.25866-1-joe.g.sandom@gmail.com>
References: <20210222205617.25866-1-joe.g.sandom@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device tree binding for AMS/TAOS tsl2591 ambient light sensor.

This driver supports configuration via device tree and sysfs.
Supported channels for raw infrared light intensity,
raw combined light intensity and illuminance in lux.
The driver additionally supports iio events on lower and
upper thresholds.

This is a very-high sensitivity light-to-digital converter that
transforms light intensity into a digital signal.

Datasheet Available at: https://ams.com/tsl25911

Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
---
Changes in v4:
- Corrected id field to include vendor name in prefix

Notes:
- Previously incorrectly included binding in same patch as driver.
  This was pointed out by the maintainer and has now been changed to
  a patch series. Sorry for the confusion!
 
 .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
new file mode 100644
index 000000000000..596a3bc770f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/amstaos,tsl2591.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS/TAOS TSL2591 Ambient Light Sensor (ALS)
+
+maintainers:
+  - Joe Sandom <joe.sandom@outlook.com>
+
+description: |
+  AMS/TAOS TSL2591 is a very-high sensitivity
+  light-to-digital converter that transforms light intensity into a digital
+  signal.
+
+properties:
+  compatible:
+    const: amstaos,tsl2591
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt (INT:Pin 2) Active low. Should be set to IRQ_TYPE_EDGE_FALLING.
+      interrupt is used to detect if the light intensity has fallen below
+      or reached above the configured threshold values.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tsl2591@29 {
+            compatible = "amstaos,tsl2591";
+            reg = <0x29>;
+            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+       };
+    };
+...
-- 
2.17.1


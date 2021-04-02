Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838E5352496
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhDBAqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 20:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDBAqC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 20:46:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CCDC0613E6;
        Thu,  1 Apr 2021 17:46:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dm8so3912082edb.2;
        Thu, 01 Apr 2021 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JfC1PDLTjGgq4FuO/yOTTnEJyDeg5H42gMyos6XUO8I=;
        b=Tt3UoVGAKAUDY2nTPxnUgcWQyuaBxZnjBYguDTpWLJer4dw2rkzmT4d+4D7m4R6heA
         a0WlhuAYjzMq06SdPCqbm33v6IglBaPeC/FVh2g/G4JS74h7wXIy8r9tDnsaccHe/Wh9
         btQ74eYpJIm7QoGo3pedWWqNP4NxRhuKSbcaSlsr125cQEKibKblYlOMqF1evN3HfNuj
         bXIb+Fy80ba2X1+l+4VWoe96tJHd500Vg5RYLzIcYudmNsKA1n0zTYZ6pZCJaE0Itvqr
         WvEUfS0qDZ0jf5ZVht068oY4hIxM/KL7jUQH9jGf47sQ/hUynDCDJeqvuOkByPXw5sYi
         j0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JfC1PDLTjGgq4FuO/yOTTnEJyDeg5H42gMyos6XUO8I=;
        b=myA4cFkQ3ymCTaN+M25p9FMMM2zujxgcLo8Xuxle1islCp9QeX5ocWn3w05/AphjOQ
         3lWAQHjpiQbT1pj/Yf97V8oZhCJC4a0XEm6LeV+qJFZ5jBe2fQBSh1lq3p2YG9Gt7GaM
         OzA2MifkQBLpzUu+Wf6TlaHDrMgI18H+E94XTRKy49e9BBKJBCA1HJzcnF/ZANpKE4nM
         nm1hkXDN9OAe3iFCJayIw/H3ofNjBWjK9wO3qnqqZB16uE6q9zjlNt200Nx0XdBHV9ZM
         Q7YoO9ls7O24uGiAZur2/vK5WLY1MzK+4dcWAKX53pUyfFX1mUpKAhDJkRpMFTdQ5bUZ
         WUgg==
X-Gm-Message-State: AOAM532kbAvWuy551j6837BHi44L2j35FJ0+raBMLrHrG4RhrsRUuNC5
        cpuevhX8XG2Wx2NO98JGq2M=
X-Google-Smtp-Source: ABdhPJz/rie6WtnzVpQuRzGmAZ123du2w2dmWyLpWeCZ8PD+PGKsP51b/MsZVpxYik+d97FRD5HKIQ==
X-Received: by 2002:aa7:d792:: with SMTP id s18mr12681794edq.176.1617324360966;
        Thu, 01 Apr 2021 17:46:00 -0700 (PDT)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id d19sm4471621edr.45.2021.04.01.17.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 17:46:00 -0700 (PDT)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] Added AMS tsl2591 device tree binding
Date:   Fri,  2 Apr 2021 01:45:47 +0100
Message-Id: <20210402004548.20813-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402004548.20813-1-joe.g.sandom@gmail.com>
References: <20210402004548.20813-1-joe.g.sandom@gmail.com>
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

Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- No changes

Notes:
- Re-submitted to align the version with part 1 of the patch series

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
+  - Joe Sandom <joe.g.sandom@gmail.com>
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


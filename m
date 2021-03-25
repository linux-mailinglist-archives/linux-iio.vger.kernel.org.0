Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8E349C12
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCYWFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 18:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCYWFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 18:05:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9CC06174A;
        Thu, 25 Mar 2021 15:05:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bf3so4132382edb.6;
        Thu, 25 Mar 2021 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x98MpMVkvAgNwkPqVPR2pEnt8bqdPgOHJHzdHKg0xoo=;
        b=KmUNdr4oH7c8nkg3RQJnuPsc04evcmNVlLBRZEDqSJ2JqY30jsaSfySihth7txYq4R
         hIbi4GKeGVwVvrd5s9KyT7kP8A+9qp/Nw4halW1jClGXtfAX0kKNugV/CSNsY6Z0eZh8
         09OwGJxEaG8mbQRfSBbmPnm81tlV8nubRnLZxH8V9fflDpKTKbCbFpGLmCNKrA/CDaAd
         3Nj2PPDhL4ccQSNexNkg9q1r2y6L1inMCVZE7bGdBc7KpErws1ssEgnwSAaPB27R43Ml
         iw5/8CjbxQaq+BDXt4AJS+KZtduEv5CdL+bULN5C5g45gVpM0wZ8OmODMsUqVWa5Y3+Z
         zTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x98MpMVkvAgNwkPqVPR2pEnt8bqdPgOHJHzdHKg0xoo=;
        b=HdMx6Jll/U1bgzIqUD9/rbliZ00D2tdpLS8Nn0mxlhbwGekuTwWGeNYHX7TaIkR3s+
         sVTwbz7so+3FdtNgH2ntrDtVg0PcSFIAWzcUXh0NaluwnLhb4zNBqfTHFFoVvwfSVZ8a
         0ZG52R4DK2qHwE0kWdSQeHsgtHR1/WoVQhP+Vc4cE2mYLlLtuVELltfJPGryITyxAAXk
         nurDFeuFqFLtJaqjuNZsLU3dKJNnwF4MjPMgZIy1R2T7OAmuaPcj8RhpNqaBgvdkPrjL
         Sq8kKUIHSunexguZ+LACRNNGy93VcYrVmTSd/O6i+34SAOWCfTFR2+OO9M1PQw1BP8OY
         w2ng==
X-Gm-Message-State: AOAM530M1L16ZWQAZnP3O43CxoKcR/j4SQloaHwOpASqTkN0DeR+dUur
        MLNrn9NqifJiSiwtgMGTRac=
X-Google-Smtp-Source: ABdhPJwptJnKlineTUQJgcKW2JJkCQv2wqY7h2XYhotAnOhHEYnoy9xImoQ8nkr06HaYkbtCsTpJng==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr11252987edd.280.1616709922546;
        Thu, 25 Mar 2021 15:05:22 -0700 (PDT)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id i6sm2951726ejz.95.2021.03.25.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 15:05:22 -0700 (PDT)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] Added AMS tsl2591 device tree binding
Date:   Thu, 25 Mar 2021 22:05:04 +0000
Message-Id: <20210325220505.14507-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325220505.14507-1-joe.g.sandom@gmail.com>
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
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

Datasheet: https://ams.com/tsl25911#tab/documents

Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
---
Changes in v6:
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


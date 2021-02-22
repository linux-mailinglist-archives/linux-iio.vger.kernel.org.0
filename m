Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3020B32214A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 22:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBVVYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Feb 2021 16:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhBVVYE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2021 16:24:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA9C06174A;
        Mon, 22 Feb 2021 13:23:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n8so20518850wrm.10;
        Mon, 22 Feb 2021 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lLar19iHaupqecmjA2VUfAzq75h6j1/XaNyh9pqVsXg=;
        b=Rqhj5LG9qxxNPPbOjd3QVlwThOXlC/eQuWmDnUnTaRquQwsIlgkPjCm5BzGnNaroIO
         +NB1WF/KwKx73L4D0iWpWYsHG3uY8cYuZFL0uE+OlZ4tHbEIFYstRQ9Ch/yunJbGVU37
         T2H68HpE0O0+REbA6v4PiAR9VA5+u/wvFPP5bzpNqhQH5ejrvdDrmvmjsiuCMKr6gR6F
         s17LWzDCH7SNzs7KSQ0rNlnebeatznSTZ76l+vQekhzEUYLS4rpNKPCZAA4QaRmZ97rn
         Mnf90hnGNiaBs89vQhVTZaqUS+oe7OJ8XgjyRtQS79RAr2Cyagr17a+Mpi07zTpsumRo
         /8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lLar19iHaupqecmjA2VUfAzq75h6j1/XaNyh9pqVsXg=;
        b=WBpreW+kvWokyd8Ga2EjW5z6kW6zbiNmk1lIcnKSs3iZ5nqp38ILGXl3UFLwxyVjB4
         hFnw2KL+zTJeMbSx8jKYV8WbbBCqElatcEOe6jg1M0VgftxKI0iuCAnVq74DxdSNEBCC
         ajOUCzqsfiOFm52icFakosRb8hr43LafmZPaFXF6MIqNbFFO1UFnziRABbbp0tmL481H
         rgEdi9yOyfFfYDEDD4VlDqFgX9X11UYsYjO4l4Wkwd86jAGkJS5tJ6ByktmKPuoRcxhG
         P8waKBQ/sCZBVI1GvEe/4AF+caS9NDXBY9deBBApgvWrQDlUJRpT6i5ZS1VXwJ1HPfB/
         kMVA==
X-Gm-Message-State: AOAM532Qr61Zp1LT+C+7Bo3U7/fid/c1rtTTEhkfA6H8lesrbwfrCHrK
        KrZfztrwfIeNfhelDSn6aurBx+w+4ZY=
X-Google-Smtp-Source: ABdhPJwKAUQl3cl7EGfjOjaveWQdinhw338rdBKtU3x/hvuPKJaMnuX+YfbWFH6PW07t1RvC++QQSA==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr23109270wrs.220.1614029002505;
        Mon, 22 Feb 2021 13:23:22 -0800 (PST)
Received: from pop-os.localdomain (cpc126866-lewi25-2-0-cust31.2-4.cable.virginm.net. [82.7.143.32])
        by smtp.gmail.com with ESMTPSA id w4sm506164wmc.13.2021.02.22.13.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:23:22 -0800 (PST)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Joe Sandom <joe.sandom@outlook.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v4 2/2] Added AMS tsl2591 device tree binding
Date:   Mon, 22 Feb 2021 21:23:13 +0000
Message-Id: <20210222212313.29319-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222212313.29319-1-joe.g.sandom@gmail.com>
References: <20210222212313.29319-1-joe.g.sandom@gmail.com>
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

Reason for re-send;
- Maintainer email was outlook address, changed to gmail address as this
  is the email the patch is being sent from.
 
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA026349D7E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 01:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhCZAKz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 20:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCZAKv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 20:10:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84225C06174A;
        Thu, 25 Mar 2021 17:10:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so5794191ejj.7;
        Thu, 25 Mar 2021 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mT5OwuunEYDcF/A5QKQCRCMw6Xu5P0C3c2Xb7f+O/ng=;
        b=MqG4GcFp1T+4lHPq/FX8ydJ0fdBUNf6rHjM77y+5+aipCgqK6PVOeWXRicaSVpOy9H
         Ifx0EMe09J8m4AUANU8Jg740E0Ui/NEEsWGUJvVh3n4qOEgJEONvM5rqvv98H5MO/xqY
         ScjmlTsDCz+6zfA52aOoT8LHGbB6vbysRUy/TV95Zbv/7doEVXqIgsqlcZNhqqRzvF1X
         xiAWm0NzRs5KG8DPtJBZ4Fjxiy9xpik3YKyExRwjC+nV6slh3bBnii1O7PEP6kMC2wAQ
         x31sg3N/9o4ShFW8BmN6M4hzH/HQ5DpWRoxOjSCGYY/NoZva6Jo9Ih1h55s95M6IUQ2p
         gjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mT5OwuunEYDcF/A5QKQCRCMw6Xu5P0C3c2Xb7f+O/ng=;
        b=Z36gryMqEbUzlG75NbOFEo1qKXVDwQ2LSpE1nEwp4Ve+3IDrXemWVnrtkcn2HbEuOo
         BjASHQjYsEL9KeHR6c1FS2n8R8VwPov5CUzfGlteTEh3e31zC5HnxhvSDMTWjtxtRXME
         9ML7B0xQwZ7D1YAM3pu7QYgt3R96YfHKarNSbRAzZXb4gx43vjeLQexDlJRjlJ6f1F1C
         tYSwlxMiquSP7ol9AWtx7XL7KrMIwOmWGZU2UnOva2yS47lGIrflD+FbAPC5leYRLAQS
         nl57AOZgMKcmcNbmv+ymdWDV+9l921B03lTw2udM5+He1gD4Q/blGOX8GMffhLSrLxS4
         pRkQ==
X-Gm-Message-State: AOAM532I46FbmGerW6DvHcA/5zqwQTa95hvOk1FnqCH1q6qWVRIa7XsO
        h5wNpM823JYSTNvef0eq12Pbi+mdm90=
X-Google-Smtp-Source: ABdhPJxRGw6iIHJfZ0tyhdpb+2IeT4rWgEvtDxb8QJ/7f+PA4gi/aPuDsZZu+S2ELvy6c5JUQKRdTA==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr12299462ejd.533.1616717450281;
        Thu, 25 Mar 2021 17:10:50 -0700 (PDT)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id f16sm3103899ejb.3.2021.03.25.17.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:10:49 -0700 (PDT)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     robh@kernel.org
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v6 2/2] Added AMS tsl2591 device tree binding
Date:   Fri, 26 Mar 2021 00:10:45 +0000
Message-Id: <20210326001046.6588-1-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v6:
- No changes

Notes:
- Re-submitted to align the version with part 1 of the patch series
 
Reason for resend:
- Correctly pointed out that I forgot to add reviewed-by tag offered by Rob Herring

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


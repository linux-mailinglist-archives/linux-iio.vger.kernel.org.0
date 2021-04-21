Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E6367512
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbhDUWOm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 18:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhDUWOl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 18:14:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8467C06174A;
        Wed, 21 Apr 2021 15:14:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j5so41843994wrn.4;
        Wed, 21 Apr 2021 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzY05lpIFrdRwnqZ6hkJHNG+7jxCIw7jk7ar5gsFXVs=;
        b=pzQAiuHWzZA9UrIDh5ap5Q3QHI6eywQV8JwnaTxFYat3itGawtLapTYymSXM24OTmi
         hLNpsrIQmrm9pck96+G9c4iPsAN6XMih0YtNej1kfBx5VSQ+QUn7KJB51vZq3zQ3PmP9
         OIbvFXjja3yep7jtp0RAPh3+Oo0QEARTFMwTpQ2t7bAqaMD+kHHswRX9AhNhBneqh4jm
         YXP2yVdpyZQXOZUmfPb6DLQj3iYknBPXPWDe8oVyFVu8HFCujXnb093mKkTzAru4GzUJ
         m5jHSftXBAvwh7KZTu0aOjQaT5x2ob12TCrEVO4BNndXFJgbeZiNNbLjpWRiFV5PzW6A
         ubiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzY05lpIFrdRwnqZ6hkJHNG+7jxCIw7jk7ar5gsFXVs=;
        b=uXN5Z4fRwoxNYpF8NcRCOxmIOVp5owvRenmCDJR9hb0Yj2By1Ona7mkA7IhGYEWEEQ
         EQ+3dSOA1pUV7AFUEMsjrnC/mlr7D48a8KBOqxOK36uMVxS6c5wTgazl53ILSFIAoVjZ
         ZBuhCJeE02f8ltJKHDcxU/W6DJfq9A0BjoL/r/aXPGYlCqpbRZFlBewuKPu7ZGauE2uh
         Y3tCUmH3aoRVp5BAGcBeoLrTQj034XTKzK5f2pQqVebVSqBVSbzf9xkA0/NhyMLYJ8mu
         HndJTEmzM+LFmujW4GbAtKRmJGxpeh1p/RfPkO1wYCjxkTxjo3GIv4ds2CAcg9kUdFRF
         EnkA==
X-Gm-Message-State: AOAM531rehth8n32FEEuJoP7i6Prr5cIpZBcGG7qSyFskUlfVJzwr7XM
        8eM4Sa/TBkpl7GYlRxuxIPg=
X-Google-Smtp-Source: ABdhPJyyKNJLafavbzm85Zc222rkz14s6SwCuoPoJ6l99bbY0epelLIAnOdwbfThgT0QyGC+Ll6t4g==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr313575wrv.12.1619043246219;
        Wed, 21 Apr 2021 15:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:8534:a300:c838:4c72:29fc:1bb])
        by smtp.gmail.com with ESMTPSA id n18sm696409wrw.11.2021.04.21.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 15:14:05 -0700 (PDT)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] dt-bindings: iio: light: Added AMS tsl2591 device tree binding
Date:   Wed, 21 Apr 2021 23:13:30 +0100
Message-Id: <20210421221330.17007-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421221330.17007-1-joe.g.sandom@gmail.com>
References: <20210421221330.17007-1-joe.g.sandom@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v9:
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


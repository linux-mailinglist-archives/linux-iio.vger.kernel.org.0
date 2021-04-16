Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072A0362731
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbhDPRtn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPRtl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 13:49:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82069C061574;
        Fri, 16 Apr 2021 10:49:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so27453070wrw.10;
        Fri, 16 Apr 2021 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsbI71LAtu2EmNV/K2CkqD1WqSCd6Qg76YsSGFCewFg=;
        b=Q1Igkbx4N8NskCEHW2UdBTUvSzZkSbfC0bloCcWnBg/AZblyOKD1K3v3DBrdacyUyy
         xpOXJh4GPTLWp5ABQJ/eKJQ9AE9mlyTYLNfRqK2SeQW10gty2MPfklDbQaAvMo2Y1q1c
         DeL6dW6VPJt53p3/p7FdCuaHbspBvdT9n+44KTg/pRhQXKTd9fy9sslCDawtP1SRBnOT
         tEUdMYYuP8Giyu5EQvfaYv/JAEZh5qdKtkGrsymgz/W2eM49ITxYy4Z3g9HqH5UOJtpE
         E0bkUAQR0/DWHv9xW8fNz/MqD5TsD194AuipsfBa0RYW5pySWigTUuA21DZrOOF8Y2jm
         xwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsbI71LAtu2EmNV/K2CkqD1WqSCd6Qg76YsSGFCewFg=;
        b=DFmsq4u6epBix9+p/udvie5uKVgb4w6v6GzEF8XrgzhF2zPoJqUFiCZhohQN5pckSQ
         rom7HtCHHLZII8MIjGKuj88m6s0wXLAnaf9tJAVnw9ewljObAYv6x7bb6kkgyDkg2dph
         7oRALfB/WgFqLVKOjyEjWbt//dqIZXW4Dq9xiuPILFJa5SOiqflMWpCnpcpDWkFTOafi
         xg1XCjc4T/Q14kbX37VyOzgVqJmb9OqDghxJrY8OYXPnOiPTHyMANFwVW9e98tlNA556
         5hjHKuxDckx1YdZ6yglwUEgKw1ZuW0jjlh1Lb7fkhKIGykk4m9U77vL3ZDsDSYHkBygY
         M41g==
X-Gm-Message-State: AOAM531QafjKOxd51jWnsOs8rOPDwFj9NPckOLDAOboAD4zjpZfL+HD/
        0kegjdyXDRWy4r+pCjDVAmY=
X-Google-Smtp-Source: ABdhPJyg+ah70RIs7U8pUtKTuFDfhL9I7KI29E5eAYEZ0MNKcVcuQbSUZ8R6exDAei5PZMOABFg+1w==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr340265wri.303.1618595353357;
        Fri, 16 Apr 2021 10:49:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:8534:a300:74e9:62d:637a:9c4a])
        by smtp.gmail.com with ESMTPSA id c16sm11552926wrt.83.2021.04.16.10.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:49:13 -0700 (PDT)
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     jic23@kernel.org
Cc:     andy.shevchenko@gmail.com, Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] Added AMS tsl2591 device tree binding
Date:   Fri, 16 Apr 2021 18:49:02 +0100
Message-Id: <20210416174902.9036-2-joe.g.sandom@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416174902.9036-1-joe.g.sandom@gmail.com>
References: <20210416174902.9036-1-joe.g.sandom@gmail.com>
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
Changes in v8:
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


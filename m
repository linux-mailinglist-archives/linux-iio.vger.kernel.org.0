Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDD7BCF2D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Oct 2023 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjJHPtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Oct 2023 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjJHPtb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Oct 2023 11:49:31 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89BED
        for <linux-iio@vger.kernel.org>; Sun,  8 Oct 2023 08:49:29 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so2645284fac.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Oct 2023 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1696780168; x=1697384968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNFoZA1zZW25lllOuroNi5vtVqqnAR6Pi3h82umCIA0=;
        b=K6A4z8acZrpTvMv+zgaMPMtkTpBQM9Rm36Sc6Q4X/2rgtkJ7QHbOMDPjs1dTYLWc/r
         6EuyDKs7c/QMHb+OEdxnLkYfuUbXihSqnhWq4RDA7zR3Oa+RW5CGr3kWkG+yyqvHi4gu
         ElG+NUzEEOPaYpcCHrZIhaPp8CEtHfuqgh7J+PJMQG4EBx16c81DrGZ8ho/QtjZyCThe
         jEodg4SkgP59Bgi5jzcsdETpvHW1KJnab40q4OzeOegosGRSCjmMUYoQ/CfoJQTXtBq+
         5yf8JbPWqkt2QJmjXDn21JkIWVBmEuk1+Y1UXdzs195SeXxhRFm8UAEMpWut6U7r5FjW
         AYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696780168; x=1697384968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNFoZA1zZW25lllOuroNi5vtVqqnAR6Pi3h82umCIA0=;
        b=GVTe+gc9wOhZd6X/b+j2GPmq4vJfja3haM2r3chXs3gpIVSJkv8CrgmrKOGzHz/znW
         dW2gcPqPyKDTdFNWH+5/SrI18JM90LxGGSueYhpErnnMSCBGb7+e/OjeTsDuOEuPkfXa
         5Ar8U36W+b5vypYLB4ltK1th/I9WWBvAlnR2AtePpUGq3vqOZIHD36xVwk9HMiMmhCA9
         N9Ed493ygN4pn/ihKzlE6bW53u6NZlX7Tw48kAqcDf+J567BNVQOAzkURImypLXVbXJK
         bp7ooCUzWGUj2uvrAC5R+Clib0A3wS16MvZI1icQgs0NE+ANawua1H7pe6DC7ji01uhr
         SduQ==
X-Gm-Message-State: AOJu0YzGRBRUALLdo6rwsjJsH7lE/74l71PnAq9CpuJHmsiwX1iASCTe
        7s08tz5ug5yQCEUqbmRqLLyNww==
X-Google-Smtp-Source: AGHT+IFQLOBGkaHMmZgK6g6hooHkbLkh4BWJb0cto5MVI65HbfqcrKyNxGXFRUlDTYP88drtI+AZHg==
X-Received: by 2002:a05:6870:58e:b0:1bf:e1e9:a320 with SMTP id m14-20020a056870058e00b001bfe1e9a320mr16195606oap.13.1696780168680;
        Sun, 08 Oct 2023 08:49:28 -0700 (PDT)
Received: from localhost.localdomain (2403-580d-82f4-0-65d1-409f-dd8-4287.ip6.aussiebb.net. [2403:580d:82f4:0:65d1:409f:dd8:4287])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7905a000000b0068fc48fcaa8sm4723374pfo.155.2023.10.08.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 08:49:28 -0700 (PDT)
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Subject: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Date:   Mon,  9 Oct 2023 02:18:56 +1030
Message-Id: <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 .../bindings/iio/light/avago,apds9306.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
new file mode 100644
index 000000000000..e8bb897782fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9306.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS9306 Ambient Light Sensor
+
+maintainers:
+  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+
+description:
+  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
+
+properties:
+  compatible:
+    const: avago,apds9306
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator supply to the sensor
+
+  interrupts:
+    maxItems: 1
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
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@52 {
+            compatible = "avago,apds9306";
+            reg = <0x52>;
+            interrupt-parent = <&gpiof>;
+            interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.34.1


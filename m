Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED1583F43
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jul 2022 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiG1Mwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbiG1Mwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 08:52:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0E3FA34
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 05:52:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h188-20020a1c21c5000000b003a34ac64bdfso804076wmh.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2022 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ddwx/S/rr3l8QuO2Qk1cqiAwNWYY4De6PYJCA33Qb/0=;
        b=7ixXf0CLkR02KxaqXWbmDuzuP4Qy4B/UOa/CVJGxkfcwnaoCgSqs9g3T24oSG72y5R
         ae1gnat3/mmUWqo8roRGpAfMwlpTB4nqRJtD/S9HtTmRct8qVKI2GpRcTyei3qpYgxg7
         aZMlCdbGS5CZTO0+wM0fucmMIWnwhbMxiq9POhVHfOq7fP5cuPDF6gAowvxf5X2BImew
         4DPX4O6voVUvxL930MqcycPSmObisYe5edwk6duGvJvr5jlHLN8kvBNDAYrMCvc+iVOr
         /jBef2Pfby76L1nGp9HKO7m7YbU1x5EyEP8d7Rnjree8gZuloux4oSe78HxPfkE5apod
         pkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ddwx/S/rr3l8QuO2Qk1cqiAwNWYY4De6PYJCA33Qb/0=;
        b=5P9FMxyg4jwKWmIS1KJDBeHCFKx6CmR0D9QFkAALy1wh1T9B4W+FCGzDEdPotord1s
         FLbTt7nVoIFmLVozKugraE5gsien9WVnFPqjsK6vsADads2Q7xUZK5xlhKp1Bludonxy
         65K4FoXHCfuD1hm1yKs/J0t1LkSbZA392gRNMstCS3J2xIrwwMKxIwVWr0BwMBidwpbi
         6wtYqx5Tq+lyjAHGLo/0cIbDF95vxB58gkBv2gP03V2mRFM6Oq1sPe8qVNhslIYdfRcJ
         W8uToCg3G9O9OkqCGVifbW7Gse9GSCUyyJSnC32qvzJxqsGQHl+9djox/JEpDMdkWLMv
         odiA==
X-Gm-Message-State: AJIora9TwdK49giCFCBid6TCb+KmwaREzTttFxqVR6oC1+6tCEhOx/+W
        UXNqRFEe6ymr+wBf5Wgyd92Iig==
X-Google-Smtp-Source: AGRyM1sPJWTr/2qHso5hDAqEHLeU5R2V28eSqrexGl1EFzyVlRY/ncs7npLtzCBMs/Dq+RvSQVOnBw==
X-Received: by 2002:a05:600c:5120:b0:3a3:2ae4:fb20 with SMTP id o32-20020a05600c512000b003a32ae4fb20mr6315815wms.81.1659012748147;
        Thu, 28 Jul 2022 05:52:28 -0700 (PDT)
Received: from localhost.localdomain (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b0021eba590ad1sm977700wrw.90.2022.07.28.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 05:52:27 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v2 1/2] dt-binding: iio: time: add capture-tiecap.yaml
Date:   Thu, 28 Jul 2022 14:52:11 +0200
Message-Id: <20220728125212.76728-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728125212.76728-1-jpanis@baylibre.com>
References: <20220728125212.76728-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds a YAML binding for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../bindings/iio/time/capture-tiecap.yaml     | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml

diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
new file mode 100644
index 000000000000..5d66df90ba5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/time/capture-tiecap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Capture (eCAP) Module
+
+maintainers:
+  - Julien Panis <jpanis@baylibre.com>
+
+description: |
+  The eCAP module resources can be used to capture timestamps
+  on input signal events (falling/rising edges).
+
+properties:
+  compatible:
+    const: ti,am62-ecap-capture
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        bus@f0000 {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>;
+
+            ecap0: capture@23100000 { /* eCAP in capture mode on am62x */
+                compatible = "ti,am62-ecap-capture";
+                reg = <0x00 0x23100000 0x00 0x100>;
+                interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+                power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+                clocks = <&k3_clks 51 0>;
+                clock-names = "fck";
+            };
+        };
+    };
-- 
2.25.1


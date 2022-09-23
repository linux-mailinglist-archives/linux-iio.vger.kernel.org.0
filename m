Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D425E7CD7
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIWOYr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIWOYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 10:24:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FB18B2E
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 07:24:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c11so212330wrp.11
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=xrcWkJUP3nm7MJstQhMwJHDEEwDAjoc085IGOzNsloMoksD+agk6NOqgHwytT4gDfL
         PsXCECZq974mOc4YZT6ffuFMdF8NyeiwopoTo6eeGkNVz4v9Um/saOP1+LoqpUuq/9Bg
         3+XVzUhQcdWX11fF/XEOg48JJ4pE7Kl70oPVzF76I5nskzsgZTtzNomn7LUCmOk/6BXF
         6I/wGoeCnBQVh1EwSyl/cYoSc5qKif5D/rK6/86lqeZe+n8YFVWJ5nCIfPSeqbpplqYy
         5rntf0tm+mWF9uxMINvTEpVUsDxWeN4RfLqc8MHghbRrRTZfR66AgTQhS5pPyaK18Ncp
         BHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XKH4BzMgDzrWHlzYeBaOGmh1hYA825wk6UyMQwxMx4g=;
        b=j3GN7i23UAsOL921hfMCU9U5AcbfsBLF/aIHsWOJfQKF/ILSHuCqawLH6p3uKC476/
         BB222tt/mdrNpSvIqru3o4yj/r0Kz7KKf0gznmTA/hN9hbMUoIanAGSFhEHXDLZwEciw
         0WI8/IaSQmALsQFbwp3yIx7dRP1CsdohJQivZybOj5e7bVDSzbFVvnZ9ZuHLjA94/Ilo
         gEm4hK46wT1qs5aic6TITnmXCzDixeNyskq8d/lDkaAb6LaTW3zjYtQXEhvEDD55qNX4
         8k29fvZFL1SWYex5136en5eBSJpGmmkBhbYmLRrwSidjUlr4ws+GorI6yR/PRDk3JSDb
         x5Sw==
X-Gm-Message-State: ACrzQf3abDHNk2gHIbFKnXS1W0WWwdz9Fbs8OLOjw2U8de5DH+gf5eXc
        hzyMFliSW9JBRPQj1TmpCbOZWA==
X-Google-Smtp-Source: AMsMyM7rRGGbdu3NxRy1c4Yw9XMDlvqf15vWcs3QAgiQGmbsxMIHHkwd5ccket+sibkeIivUz7gZ6w==
X-Received: by 2002:a5d:5944:0:b0:22a:c2d1:e3fe with SMTP id e4-20020a5d5944000000b0022ac2d1e3femr5319219wri.261.1663943079780;
        Fri, 23 Sep 2022 07:24:39 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0022878c0cc5esm7444627wrw.69.2022.09.23.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:24:39 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v9 1/4] dt-bindings: counter: add ti,am62-ecap-capture.yaml
Date:   Fri, 23 Sep 2022 16:24:34 +0200
Message-Id: <20220923142437.271328-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923142437.271328-1-jpanis@baylibre.com>
References: <20220923142437.271328-1-jpanis@baylibre.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../counter/ti,am62-ecap-capture.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml

diff --git a/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml b/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
new file mode 100644
index 000000000000..4e0b2d2b303e
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/ti,am62-ecap-capture.yaml#
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
+        capture@23100000 { /* eCAP in capture mode on am62x */
+            compatible = "ti,am62-ecap-capture";
+            reg = <0x00 0x23100000 0x00 0x100>;
+            interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+            power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 51 0>;
+            clock-names = "fck";
+        };
+    };
-- 
2.37.3


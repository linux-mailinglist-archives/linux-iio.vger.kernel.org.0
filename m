Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0D5970C9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Aug 2022 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiHQOQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Aug 2022 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiHQOQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2022 10:16:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B95F216
        for <linux-iio@vger.kernel.org>; Wed, 17 Aug 2022 07:16:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1025245wms.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Aug 2022 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pqhA8o+boQJA8OSHBFOoAbjBpl0hxdmasRE4keRadHE=;
        b=tQWNW62u6NkzqthrlNOENPbDYyV7s12LK0Oin1xhgqb417Nu9ntPQrtyP966DEYmoC
         pmmLnkABLI3PteTwmCUMbivk5HsQbMIPyzSFrNHg87VMVU+W9AJ1N6BPgJ19hiNs4Nb/
         q61IiP41QzRBeV75JP5Lnf5hvar8M5mgn8827KqqsWL+A7pHAiXDv63/1JmvueUzw86Y
         7cIN/5tubmEJCsB2RTNNQMGKnWWci/U1MYSvRuVOOWEs2W7ZzfJEseEGESXWqEwpJUxG
         bFJax1EC20WYoTBZb/yg0r59q9tKIbwgQoV3p0GEeE1RWTsZepd8+2PuI+TgmozzOuPU
         kPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pqhA8o+boQJA8OSHBFOoAbjBpl0hxdmasRE4keRadHE=;
        b=rdypjbFFc6zmUKs3240sEUvZC8XtG6dVq91D3Ihpzuj7Yezo7SHlkPvpMNrAhYPq45
         MX6aW/EfwUKVu+9UwMKobgFmPVguOERjg88wyvn9ykpCw3oBBoH2pKE9SFHdfIYysZ6j
         z5YWKk6+Ed7LYqgMZIIPcAMJKtNsXaQ+WmGftfn7vhk8UmUdkOhT4fA1xaAHAvvL4Nlv
         DJWy6BdzWDIi0lYLZzUDxDz6wqisSuaWkzEAckVOiCIL7R/vze2f/TSSUk/qezyHhCxo
         vP7bCoNk6VdtMvQkGP8PhliqgYgYOHE5SI8jAhk+hobpHqf2w3pRXFtq7ovhbTRP4Ewb
         8sBQ==
X-Gm-Message-State: ACgBeo0yqJsKC/+n2psp5HJh2y9b917+mzgAA6Tr/qmHAnYEh1YnECvh
        XvkFKS0CofjRQVFhkGMFE5OiPg==
X-Google-Smtp-Source: AA6agR6Rsy8e4Xg1z2v389ZLj2u3kEioeQpIO38XkxHAtAkQ2Bmj7O6S/N7WCx6BlvBzM0RonCh1GA==
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr2361403wmq.71.1660745792303;
        Wed, 17 Aug 2022 07:16:32 -0700 (PDT)
Received: from localhost.localdomain (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm2416533wms.25.2022.08.17.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:16:31 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: counter: add ti,am62-ecap-capture.yaml
Date:   Wed, 17 Aug 2022 16:16:18 +0200
Message-Id: <20220817141620.256481-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817141620.256481-1-jpanis@baylibre.com>
References: <20220817141620.256481-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
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
2.25.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A958EDE4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiHJOHq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Aug 2022 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiHJOHq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Aug 2022 10:07:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497D6E2F6
        for <linux-iio@vger.kernel.org>; Wed, 10 Aug 2022 07:07:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n4so16121509wrp.10
        for <linux-iio@vger.kernel.org>; Wed, 10 Aug 2022 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pqhA8o+boQJA8OSHBFOoAbjBpl0hxdmasRE4keRadHE=;
        b=cTw+eVTyPlg5bzYxedeopN4BqOZpMeSPQWJvU78DKS+jhKJfslT4pMC4XUU/O/863n
         C+0yxkWzB//75y41NTcZgZEeEWdEBzAdZy2LMxgsMbjMvp16r2bdA4ZCFN5VLiZqrjcK
         yC5aa31sJdh6olAqmnuDtKQ2sdIs76SYH7JgAKKqxBR3HoMr9sPctN9pGYh5l0dVsvQE
         o956Rx7AMAQdzqszqEa/pIcfc/tC4Fn/0pSa9HLdSRVKzaxIcbod2juyE0+LWV212LP1
         qHxgjZeERN5vk3Vd3E+pYtfHK7ywlq4/dWf4/9A9/LSX0DywNzo6wVCFSHj5ifIE4OYg
         ZeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pqhA8o+boQJA8OSHBFOoAbjBpl0hxdmasRE4keRadHE=;
        b=AkkfyFmVITAAK+ie1pgaF55N+V6fMi5h1nATg8zszBZOX+GWMPpZQ7ua6zIJustXJW
         jrRnGw+ae5LPQz4OXI7SpSo4VPCeG6AYqfz9juI9DnPkQg8etwOh08+vdDLP2ryOCaUC
         VehNzFrGQ/NkXlCzqvEKCGuvX/S8OY0HNRkPokqeu9jr+dYBbvQWmU9HtXZKySc8cYO5
         meL5T8kxzJqGcqgkY0UncKX7otxNJzRJ+LDfFXiOTP0qMadjLuGn/CPwiVbx+c592GS6
         JaST/vmicD9UqWRzhmg5XgR+BVEJerGiqP87wZexCDMq7jQGDSU2ApgMC7qfbHKQwI/s
         XF4Q==
X-Gm-Message-State: ACgBeo25gNrszKJ5YPOie7AUPm9xdBsVJtXtJxaJ7Fo7N94h4Er4bZng
        1WVV9x56a7mrU0OVV8thpe8VZw==
X-Google-Smtp-Source: AA6agR7Au3nWd8WrJiE+4lhi3rDCe2+VabP8fkIHAszisl0dnDTnBDb7/9Wu5f4TS1TR4ua3rpOzGg==
X-Received: by 2002:adf:fdcb:0:b0:21f:ae9:bbd1 with SMTP id i11-20020adffdcb000000b0021f0ae9bbd1mr16199087wrs.506.1660140462630;
        Wed, 10 Aug 2022 07:07:42 -0700 (PDT)
Received: from localhost.localdomain (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm16258229wrj.47.2022.08.10.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:07:41 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-binding: counter: add ti,am62-ecap-capture.yaml
Date:   Wed, 10 Aug 2022 16:07:22 +0200
Message-Id: <20220810140724.182389-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810140724.182389-1-jpanis@baylibre.com>
References: <20220810140724.182389-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA45ED07A
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiI0WyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiI0WyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528C2B6D1D
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12803ac8113so15215782fac.8
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a7VLezTD0+GPejxCp7dPxU8OWFTrlgtVBSlhx4E+t6E=;
        b=ALHzBCs/dzoKPi+sqH/xuMWcZDQrOIux1rIdClKBDNjFRs/UYr3DOfkcXIP7JYI+RK
         8l7mj8YmpkwsLt3MQ1/fCsId/Z3n61miWc9/r6zmzbQsqqD0xcoiRjKa1APp32EA28WF
         WmlHZzkDUYZGATIxpyssGH4eD6wpRdAcZ/UlqVwgHCPGCi/jadv5cwy5woVgeT0onWDi
         7KpOmFRJzN2WpRzYXrB8GJPr7fwxKBdqaYbos3Tt/PmNT7wU6rtF3HYMbzL5I6PVb/bk
         3pySsR/BqUn6yycjnerJxMEMxkXH3zKA3YBXMIge+ONbHQ6ek2zxqtB4KEI3gsrMkT3P
         GZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a7VLezTD0+GPejxCp7dPxU8OWFTrlgtVBSlhx4E+t6E=;
        b=6/PyGNSGxeT8cqr+dGhL0nred62nbJIFGcz5/j0Cwmbd21GqHhPCD1gUWTmXI/Nh12
         OwVFzQUoTGAqiWUSOPkv2xF1jz7SF+sfZAUrxl09DOlPqPyDujku20aQRpoqbwTeN+fc
         egVxyh9mJGxqVIdyi31os15QRIx5XLOCnMT0vw+hLsZWiS1tz/o3+AKIXl0illsxeB1+
         5oFEPlbr75MvwOSj3pdJGJl+PDyz42Jc77gH0qIGv23wQqWqEvX67wrFeGvyloa81LrV
         tubY2iyRUwMkq/NRV4yKoJzrFV87VJRlrlDiwAOz4MpglDqZQUHhuohRfdHqmOghN0nv
         SIqw==
X-Gm-Message-State: ACrzQf3fOCctzEQRXJEY2aofXLQT/nvSWEy88BsdAvYh/XEBTBwwh6gi
        6udgWn5ib4JBSwv+akKXud7fT5dM6Fgura6y
X-Google-Smtp-Source: AMsMyM7rb0be+4Y7sLi173c3HACIYoOgg18OfObCT7IKGhqRvLdunxf9mWReo0ueMj6xA40KiHRbaw==
X-Received: by 2002:a05:6871:1d5:b0:12b:239:ef00 with SMTP id q21-20020a05687101d500b0012b0239ef00mr3534738oad.85.1664319253520;
        Tue, 27 Sep 2022 15:54:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 09/12] dt-bindings: counter: add ti,am62-ecap-capture.yaml
Date:   Tue, 27 Sep 2022 18:53:43 -0400
Message-Id: <33c27451f61b3a01d886da5e6bf6456088956439.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Julien Panis <jpanis@baylibre.com>

This commit adds a YAML binding for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220923142437.271328-2-jpanis@baylibre.com/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
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


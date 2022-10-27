Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986660FA77
	for <lists+linux-iio@lfdr.de>; Thu, 27 Oct 2022 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiJ0Oeg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Oct 2022 10:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiJ0Oee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2022 10:34:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE86559
        for <linux-iio@vger.kernel.org>; Thu, 27 Oct 2022 07:34:32 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x13so1436300qvn.6
        for <linux-iio@vger.kernel.org>; Thu, 27 Oct 2022 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZo8y3T1IwmVEyZfktrXan3as4gJ0RmGr8oerP5joyY=;
        b=Gx0nB6zxtpGH17ebvf0fGyH9Kf66KGlOwRBi4OOc/uRL0/ehmchmTLkQbLC9dK1Hkg
         GiC0MiVeFpZSky3YOe8a2VhE/SrsZCs/iM/z0VaCNpvFIDpbJUfI/F8mKmT33Wn7abGa
         chpRWlcQc3RVMq1RCj1XzvCe8of+vCQ1W/rsMr9634oYMoZkBvRl1Ns43IvHggq4A/P3
         goYLPlaI/EfEOZeTsFTmdUJ1mff/ESOu+onM8L5x9D44ZwxqnHI2wcnBKVz7ZAZSWVIu
         +WlmzwzJJNZVqbtGbpQHYVoffaCKbdHFNW9EjOcpf/lt7EmT70UcBVoBRTJlj/g23I7e
         fstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZo8y3T1IwmVEyZfktrXan3as4gJ0RmGr8oerP5joyY=;
        b=toYSY91E20qXWkBKNvPJ+HWmfcp6UPnjybcMgkXuCfWNPC/6UQjjrzBDSUSSqzh1oJ
         qAWXx7HnN4AYkX/niqYuN/uLwRt8beIEXxzu7ImELKH/u1ryTzUmIq+e+lfscYSOe4zi
         P07QyP8TtQZHz2p4VK5CShxyHsFvtcY3tovAxnY47xc1Zth/BX9T2eQISFhskIj6cSbj
         X14IwmJwY2offSdcPmQKzBa1O5T6ZKjL+lDodDh25irDxzX8jJ72Qpj8YC7fJUijjyX1
         PFUz6g+CJeL2JAbnf0s5KcQxTx8czkPtp13/FEXHn1DwBWKM3xupZkBUxf8PZvgGjYks
         z3wA==
X-Gm-Message-State: ACrzQf3O7vr3ZW8hA6e8ytY+sdssIfTZy+DoIEioDnLSflwwdMDGqSpd
        spFH6Ni1t70n9xgfhNSXXdeIDw==
X-Google-Smtp-Source: AMsMyM6w5pR1N+8+jwkfd3fB44RJoWs/BEJIBH6MzBKIAZFYWzpKrfgIgc/Io3BAA/QEfdpGzdUcig==
X-Received: by 2002:a05:6214:20e6:b0:4b1:996d:c1f2 with SMTP id 6-20020a05621420e600b004b1996dc1f2mr40924700qvk.11.1666881271116;
        Thu, 27 Oct 2022 07:34:31 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a444a00b006f9e103260dsm1076749qkp.91.2022.10.27.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:34:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: iio: adc: qcom,spmi-vadc: extend example
Date:   Thu, 27 Oct 2022 10:34:11 -0400
Message-Id: <20221027143411.277980-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cleanup existing example (generic node name for spmi, use 4-space
indentation) and add example for ADCv7 copied from
Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 94 ++++++++++++-------
 1 file changed, 62 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index a848df37db06..f1522196042d 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -236,42 +236,72 @@ additionalProperties: false
 
 examples:
   - |
-    spmi_bus {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      /* VADC node */
-      pmic_vadc: adc@3100 {
-        compatible = "qcom,spmi-vadc";
-        reg = <0x3100>;
-        interrupts = <0x0 0x31 0x0 0x1>;
+    spmi {
         #address-cells = <1>;
         #size-cells = <0>;
-        #io-channel-cells = <1>;
-
-        /* Channel node */
-        adc-chan@39 {
-          reg = <0x39>;
-          qcom,decimation = <512>;
-          qcom,ratiometric;
-          qcom,hw-settle-time = <200>;
-          qcom,avg-samples = <1>;
-          qcom,pre-scaling = <1 3>;
-        };
-
-        adc-chan@9 {
-          reg = <0x9>;
-        };
-
-        adc-chan@a {
-          reg = <0xa>;
+        /* VADC node */
+        pmic_vadc: adc@3100 {
+            compatible = "qcom,spmi-vadc";
+            reg = <0x3100>;
+            interrupts = <0x0 0x31 0x0 0x1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Channel node */
+            adc-chan@39 {
+                reg = <0x39>;
+                qcom,decimation = <512>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+                qcom,avg-samples = <1>;
+                qcom,pre-scaling = <1 3>;
+            };
+
+            adc-chan@9 {
+                reg = <0x9>;
+            };
+
+            adc-chan@a {
+                reg = <0xa>;
+            };
+
+            adc-chan@e {
+                reg = <0xe>;
+            };
+
+            adc-chan@f {
+                reg = <0xf>;
+            };
         };
+    };
 
-        adc-chan@e {
-          reg = <0xe>;
-        };
+  - |
+    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
 
-        adc-chan@f {
-          reg = <0xf>;
+    spmi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc7";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Other properties are omitted */
+            xo-therm@44 {
+                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+
+            conn-therm@47 {
+                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
         };
-      };
     };
-- 
2.34.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0E789A0F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjH0BAD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjH0A7a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6BCFA
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50091b91a83so3186455e87.3
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097964; x=1693702764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjW4ylzO3JtTT7kFnJy7UM1EVNTfgYpip/fK2M89nnA=;
        b=Qwcn4viHz9TYTNSV6wVszVXF6e9BQPpP+eaN4Z+zvgoiIwRrRXPSNvkJJIyQPL758p
         mEywqFU+vdNhV97gcnuWKbd0kZerfnY1tvmVVW8JYTMS0KvIT0JfBTFYg7/pALl+nsKl
         BmhuygRif/1VdHqs6gIyQCHVWh6UUcvwfUG/G7u7Hx01rRXxlVAcW4Wzfme3TBdlhpCn
         QLWpX5lBRzD5scuB1wT5IwoZETJel96zDbKNngkYwsqqKemB/HMdwC9UFt1oQPOJoHDE
         26DeQODGorZjqR66jZkU2U3aVjElF4TMGCiSmbFNNQ0farmD6xumr6C6UdwSwbGRQ0Nu
         qHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097964; x=1693702764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjW4ylzO3JtTT7kFnJy7UM1EVNTfgYpip/fK2M89nnA=;
        b=I60JFoNp1COiIaddLMDLoCj0Yqsbev6rpFXDrui6B1Z2Irr1UDNw4O7gX3MG7YKDCz
         KLG3xwS5BdOMT/nhk3/0Z7ScKNp7/ivfLqVejbfENp3z+Exc/3Si3nc7/8hAjOhwy7SE
         lGTleH6/VHfPPErB4QZI0BhtB3Nct0Bv6gytnYTDPvn1W8gkNzmJBUAohNur341v3HdU
         7qtT758F7n/GS73JmOdi5x/SkAd9AhI8zTdN7a4JmtkQZVrL2uwAgH/mh3s/cbWwGZPa
         ItjboPzMra4cK2LOk8vFEZ0dBOTDrtPVYMbm7EYkv7WKe2GHVo2jqlF/OMvgP6eTx9J0
         Qs3g==
X-Gm-Message-State: AOJu0YzoRxxp32EX5lTdF5pP2BDXwcDUjZXXjEXDsJqFGLszBBGlFGnW
        osNQT/8NQ6/wf1jICmCLOdURKQ==
X-Google-Smtp-Source: AGHT+IFwRYPvmJ8NJfWHi6Muugz6fnx7Fjay7imp78oq8M35zIaI6+K3KpFztiCZXhRUVVWgFmNF1A==
X-Received: by 2002:a19:381d:0:b0:500:96fc:129d with SMTP id f29-20020a19381d000000b0050096fc129dmr6990081lfa.14.1693097964681;
        Sat, 26 Aug 2023 17:59:24 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:24 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/38] dt-bindings: mfd: qcom-pm8xxx: add missing child nodes
Date:   Sun, 27 Aug 2023 03:58:44 +0300
Message-Id: <20230827005920.898719-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add gpio, keypad, led, mpps, pwrkey, vibrator and xoadc as possible
child nodes of qcom,pm8xxx, referencing existint schema files.

Cc: Lee Jones <lee@kernel.org>
Cc: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 9c51c1b19067..7fe3875a5996 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -43,13 +43,37 @@ properties:
   interrupt-controller: true
 
 patternProperties:
+  "gpio@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
+
+  "keypad@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/qcom,pm8921-keypad.yaml#
+
   "led@[0-9a-f]+$":
     type: object
     $ref: /schemas/leds/qcom,pm8058-led.yaml#
 
+  "mpps@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/pinctrl/qcom,pmic-mpp.yaml#
+
+  "pwrkey@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/qcom,pm8921-pwrkey.yaml#
+
   "rtc@[0-9a-f]+$":
     type: object
-    $ref: ../rtc/qcom-pm8xxx-rtc.yaml
+    $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#
+
+  "vibrator@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/qcom,pm8xxx-vib.yaml#
+
+  "xoadc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/qcom,pm8018-adc.yaml#
 
 required:
   - compatible
-- 
2.39.2


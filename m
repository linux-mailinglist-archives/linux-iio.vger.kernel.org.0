Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB8F641B1F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 07:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiLDGQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 01:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLDGQB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 01:16:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE091AF02
        for <linux-iio@vger.kernel.org>; Sat,  3 Dec 2022 22:15:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so149091lfz.4
        for <linux-iio@vger.kernel.org>; Sat, 03 Dec 2022 22:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df6YVGFXrCQjdb7F1t0OqSwRQMoyoPVorXWJgB9N0Gw=;
        b=ip0pRH9ZgyCCxqIea5mb94IYYnGOATrUp2fK757B19FVfbS1aRtv3knxji/ow4gjsu
         2gn//JvgXUxLfkXpnvrOzzVll6JeAV7BsSNpFiNg1pFcu5PCmPFcyJqK+8t1VW5bzjW/
         Q6BFaM6dsfWq6Q/BukGylhHurGWv2IDbOkmxam+7COfDjV9uqtqzkcPEDQaqKaJSqhqg
         SdoOpD5qd2mo5uiM+3L0tj9Hg/OJ76Zi2wvQ6eOaH9yrafCgiYX5nMBzUbQoduNGmoRu
         e54vuTcXPkm7PXJJCCzI5PUUq/fBb6ehp0RJmPBOzz4KCmNhXbMewOSf3Uzm7j8zTUGc
         fTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df6YVGFXrCQjdb7F1t0OqSwRQMoyoPVorXWJgB9N0Gw=;
        b=F/cS950D0ZrFlYOOQDtILJFgHQNfkrXPLMRAyWbdFQsJSCS6ZUlG+ZbHm6MjPGZ/0y
         94ui8r+JFGBPwn2WuL9nvX2b6xdXrDCWXkv5VJaiWue7Z5HKObJwU2NY8sUaA2zEvNEt
         821S86XyBdNfIqs09ApnO4G+GYlasI9EOE35m3KXMCfy0Fxn+TrfcxSzWxn623bjxQgj
         rBeFZeczc4l4POtj5jxXkZignXXuw8SRTwSlpA9ZSX4W2c3vv6xxkd0DPkt8spIIdYGh
         lh2mudW4a+KxFBeNt5i79vlIBLyEMPGvmW2/C1NJ+STy6LEKQrw+EDrs/m9RVg7hmF63
         BzoQ==
X-Gm-Message-State: ANoB5plXukrE+i7X7eJ3RKvh930yH4LM6aexqcyAC/hNyvJ2Fy+B1iVv
        BHrcxpnbeqyOLtPrjiEJ+ce/8g==
X-Google-Smtp-Source: AA0mqf7Q11sUZj4PtTwSu2gOGi5ajLI7WTGG2j9xoeuIlSuV7Vf6qURJIhlxKXEZxE70ARLycROp5A==
X-Received: by 2002:a05:6512:22c5:b0:4b5:5880:8359 with SMTP id g5-20020a05651222c500b004b558808359mr2148586lfu.425.1670134558191;
        Sat, 03 Dec 2022 22:15:58 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512110c00b0047f7722b73csm1650725lfg.142.2022.12.03.22.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 22:15:57 -0800 (PST)
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
        linux-leds@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: mfd: qcom-pm8xxx: add missing child nodes
Date:   Sun,  4 Dec 2022 08:15:53 +0200
Message-Id: <20221204061555.1355453-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
References: <20221204061555.1355453-1-dmitry.baryshkov@linaro.org>
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

Add gpio, keypad, led, mpps, pwrkey, vibrator and xoadc as possible
child nodes of qcom,pm8xxx, referencing existint schema files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 9acad9d326eb..7fe3875a5996 100644
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
-    $ref: "../rtc/qcom-pm8xxx-rtc.yaml"
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
2.35.1


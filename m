Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C4641B25
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 07:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLDGQF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 01:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLDGQB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 01:16:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AF41ADAA
        for <linux-iio@vger.kernel.org>; Sat,  3 Dec 2022 22:16:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s8so13763920lfc.8
        for <linux-iio@vger.kernel.org>; Sat, 03 Dec 2022 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOGoCPWDALPa2Pn54w5yy0V+BqkFOIiPQ9fSx1bZOe4=;
        b=Y3FwqUatqTRuVc3nHBjvmREuWmi3X+xOMpMBrrKQG1DYjT9iPfvSMQIR5JNOMpMC7q
         KHnpssjIHKjz8cUQYsQGvgn9FNykHxqTRglQjnPn3/qWq3aUUB5BDAUfrni7jcFypy3I
         lXnsxzBYmej+tqws8q7HBXSXf60WxiU22GLCmTsSGHGqfO6nGe4qD2K8j7kYJCVIaBm+
         oqVNykeK8WHlB8d9/fVXyabIn0JRLJnlDnoymyWXC3apJlG398qFIknd9USYmxF92oPm
         MaFRivtj4r/AkADTn2WyyVxynBOu9aWTCyro7sUidES64gJyxts5bfqojx1P+ydujILr
         wyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOGoCPWDALPa2Pn54w5yy0V+BqkFOIiPQ9fSx1bZOe4=;
        b=yQk9OOaVPbBl0K1SLPBn2c1qrCDkAcGwm8GqGTU39bFnYMcMqODBGFtF4GRpc2fSni
         QhCl1JqYYbMVfdGnD/J0JSD+JgPx8MJ/ChkfaCp0nvehKy6jVqEOO8TUVtM4U9ZDooEE
         oVmgVYDzWqDWtmjwy/QMrCTp9KEo4rCV5/Cg+06e1PEavR98Q7Ina6QeDezheZb/grYk
         YwEK7ydsjdcWtyKFmLtyX/3aMgQIRtirZpEen597Wiup1ENjuFOnaE4EHZgTtkF6VZHu
         80xHKhPa3NCSHKTH/iEk8HOsmR8CImqzbGIjU0ffqEwTEIrqEXyOb7F+CdF5x1H1oX0/
         XOHA==
X-Gm-Message-State: ANoB5pljx03/UMKe0bGdEvrTUb5xshOYtymggtVoMu0jH6EAwdC+DHth
        kAYSqdJLL5CLeiTSSPvatdRc8w==
X-Google-Smtp-Source: AA0mqf59WS4sfzM2/GgRRlg9L53R8IgfzGt7DRtXNFe2uCrr1RM7z5gXhw+m74yAYnibQriC/1RT6g==
X-Received: by 2002:a19:f610:0:b0:4b4:a536:f866 with SMTP id x16-20020a19f610000000b004b4a536f866mr23939407lfe.262.1670134559024;
        Sat, 03 Dec 2022 22:15:59 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512110c00b0047f7722b73csm1650725lfg.142.2022.12.03.22.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 22:15:58 -0800 (PST)
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
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: qcom,pm8018-adc: allow specifying MPP channels
Date:   Sun,  4 Dec 2022 08:15:54 +0200
Message-Id: <20221204061555.1355453-4-dmitry.baryshkov@linaro.org>
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

Several ADC channels are bound to the Multi Purpose Pins (MPPs). Allow
specifying such channels using the mppN device node (as used on apq8060
dragonboard).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
index d186b713d6a7..fee30e6ddd62 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
@@ -64,7 +64,7 @@ required:
   - adc-channel@f
 
 patternProperties:
-  "^(adc-channel@)[0-9a-f]$":
+  "^(adc-channel|mpp[0-9]+)@[0-9a-f]$":
     type: object
     description: |
       ADC channel specific configuration.
-- 
2.35.1


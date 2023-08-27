Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D0789E88
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjH0N0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjH0NZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBB1B1
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50043cf2e29so3567130e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142747; x=1693747547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDlULPpCaiOZl9KqGYW1vmjYvdhVYMx48DSYOBdmQVg=;
        b=DhWv1rm1ioeBtCmQWaCoWrjgq2mKczHYX1Dn+SkW6YPiG7rB7q51bKgq4rJtW+QFHM
         IjTkAN+YanySzVL45DzxPLJsv9n1A/I4r3VXHkns5Q4Zwo02U4vhi2zGJgk2RRDY30UF
         6tcg4A9sccNc2OVAZJ5IvyaR4hNX7f04lvVf5xXvsIjv7o+WwqsD/XSazVvA99Oqzvm7
         nD1QRJsoeDkLzdq5gcTpS+cLr359QQmJQyIvk7z7V2/fbnFRK2aLNyUdHkoWs9FrFIvp
         paP3/N/39VIByvw/qGZoNEFaRSbD9SVnhtn1K0F1X1SZbzx6SDVKt3m6MMOweIp037lI
         Rnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142747; x=1693747547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDlULPpCaiOZl9KqGYW1vmjYvdhVYMx48DSYOBdmQVg=;
        b=Hwc1vo7ePU6HvNCxLrxlquX3Hr5IWC7FQR51gJrRWvWfd15wEAcVEcsVhSHvxF2myD
         KJIO6gbl0wUZxj3jswDvPJWmghEqfAimxuLF2oq/l089SgySoVrNdtRqfWspCh7QucVV
         KkAbOPm4cAFsO0zJ4H9JFxbnBmcLtRoATeuxMFJg5kfif7CaZEhpcZsDCB67DXoUrvZA
         QV7ofh9EGz/3zkUmeKvTSD6RwdzXbqmCoOuE+yw/aYGZVlx7LmKFSouFn0uqCodCrat0
         bd4U/d94tdExRggUJS60pJ2mXZ6FAB62oW48HkZQqdiqrKbTrSFJ5kYxQZ1mcSHNq6yt
         hzqQ==
X-Gm-Message-State: AOJu0YwN6pj9MlXi6vrXAFuvDY1eb5Cgit10Y7wc33SGtHn/4B4hYydg
        oaqk8FtSPBvPlLnR3vUZJeF5Yw==
X-Google-Smtp-Source: AGHT+IHsZRq1RqRgSkF7zLgdEqWXLN9KsUMyvJAQIcDaV2HlsaqCd6W/wQJA3fWmlxBCvXwrEUnwGg==
X-Received: by 2002:a19:4f07:0:b0:500:9a29:bcb8 with SMTP id d7-20020a194f07000000b005009a29bcb8mr6737101lfb.4.1693142747568;
        Sun, 27 Aug 2023 06:25:47 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:47 -0700 (PDT)
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
Subject: [PATCH v5 25/37] ARM: dts: qcom: pm8058: use defined IRQ flags
Date:   Sun, 27 Aug 2023 16:25:13 +0300
Message-Id: <20230827132525.951475-26-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
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

Use symbolic names for IRQ flags instead of using the numeric values.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8058.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/pm8058.dtsi b/arch/arm/boot/dts/qcom/pm8058.dtsi
index 913a511719fa..3683d7b60918 100644
--- a/arch/arm/boot/dts/qcom/pm8058.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8058.dtsi
@@ -12,7 +12,8 @@ pwrkey@1c {
 			compatible = "qcom,pm8058-pwrkey";
 			reg = <0x1c>;
 			interrupt-parent = <&pm8058>;
-			interrupts = <50 1>, <51 1>;
+			interrupts = <50 IRQ_TYPE_EDGE_RISING>,
+				     <51 IRQ_TYPE_EDGE_RISING>;
 			debounce = <15625>;
 			pull-up;
 		};
@@ -61,7 +62,8 @@ pm8058_keypad: keypad@148 {
 			compatible = "qcom,pm8058-keypad";
 			reg = <0x148>;
 			interrupt-parent = <&pm8058>;
-			interrupts = <74 1>, <75 1>;
+			interrupts = <74 IRQ_TYPE_EDGE_RISING>,
+				     <75 IRQ_TYPE_EDGE_RISING>;
 			debounce = <15>;
 			scan-delay = <32>;
 			row-hold = <91500>;
@@ -135,7 +137,7 @@ rtc@1e8 {
 			compatible = "qcom,pm8058-rtc";
 			reg = <0x1e8>;
 			interrupt-parent = <&pm8058>;
-			interrupts = <39 1>;
+			interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 			allow-set-time;
 		};
 	};
-- 
2.39.2


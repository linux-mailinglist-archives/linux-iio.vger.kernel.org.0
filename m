Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E792FB13E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 07:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbhASGW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 01:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404024AbhASFuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 00:50:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3DC061796
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 21:49:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v67so27410246lfa.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twtRf4xOH0E0x9VRPwiTE28bCNXEVhaTsRzwx7xbrKw=;
        b=kl5i1oWzQb1oVX0NEE5kM2wUR+B6FGp2MwfQWdQ6K1e8IIwjEV/Tj7dxCqY1+Z3s6H
         mBthhV5TVJGClr9lGYt6QcPTxLqai2dqF7mrR5mI9z2aEwAz4x98gLQKwTtON3+TrieS
         bPS5FRK3nUjpnuBCfc+LPptyQadBKwOtx7UB7l+BKqQUd4429fd3nj0bFkFnhtHHnkct
         FCYDPJF1Urn7Ti7l/KWLHe5EXDt8rGKdPoZv9Q9qX4IkHILJxU0t0DYSjnS+0B4zoVr4
         s3G3LcPhS84WQjLGocNXdd0A4+TJ6eM039QYqTpK+6Vc5I64eyjXmKOqSzK2vNA1/PZ/
         Y1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twtRf4xOH0E0x9VRPwiTE28bCNXEVhaTsRzwx7xbrKw=;
        b=ARrlqv2xluZWuPrAE/RSX2XE4KKqFOBzMeXN0Fh+tj2PdTdh8D7ZKwa3UCgKFbHexb
         MAQ9gG+JoMyviOC1Z0f4kgxnx0a6h7BhoxmxznqIS0Znn8UQiyD25bVmjdqiWg3TSEqN
         FV1f7a7oVZr3Ov0N0rLPDCGS8le5hYkEh2G8D2LI1B2ZCqyRuo04an1yN6HUqM1iKB9/
         1WAd2QAgvvT9xCPmDqIkuXEnaV65QT/MHCuhetauKhDP7jff9wvLuaj7qTChmOROTOVf
         i4T8BtSwfYmbaODytYK8O9hANjktOKKf8IJ2x65HNuS5asX6nMyioyM1dYSr8ChS45+P
         Bz2w==
X-Gm-Message-State: AOAM530oMlXT4nMN0cQgxlHzzUtdvUJ2kYg8zsDXvRm4URgNZTwLL0pj
        xKSrugsYlXAn18Q8+kPY3Xg9wg==
X-Google-Smtp-Source: ABdhPJx1o1V6LvDaw5bCXIvS0bOow4piD7QhGSZt72JSqC16lG+Q//A8pXZnUuWZwpgADTVlDv6L8A==
X-Received: by 2002:ac2:4d8c:: with SMTP id g12mr1074045lfe.619.1611035339708;
        Mon, 18 Jan 2021 21:48:59 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.64])
        by smtp.gmail.com with ESMTPSA id j3sm2168207lfb.29.2021.01.18.21.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:48:59 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v12 3/5] arm64: dts: qcom: pm8150x: add definitions for adc-tm5 part
Date:   Tue, 19 Jan 2021 08:48:46 +0300
Message-Id: <20210119054848.592329-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Define adc-tm5 thermal monitoring part. Individual channes and thermal
zones are to be configured in per-device dts files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index a53eccf2b695..15e87153a194 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -97,6 +97,16 @@ die-temp@6 {
 			};
 		};
 
+		pm8150_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pm8150_rtc: rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index e112e8876db6..8e2f3250c914 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -95,6 +95,16 @@ chg-temp@9 {
 			};
 		};
 
+		pm8150b_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pm8150b_gpios: gpio@c000 {
 			compatible = "qcom,pm8150b-gpio";
 			reg = <0xc000>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 62139538b7d9..9f214ceec2b7 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -89,6 +89,16 @@ die-temp@6 {
 			};
 		};
 
+		pm8150l_adc_tm: adc-tm@3500 {
+			compatible = "qcom,spmi-adc-tm5";
+			reg = <0x3500>;
+			interrupts = <0x4 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pm8150l_gpios: gpio@c000 {
 			compatible = "qcom,pm8150l-gpio";
 			reg = <0xc000>;
-- 
2.29.2


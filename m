Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3FD2FA3E9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 16:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbhARPAS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 10:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405305AbhAROxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 09:53:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50499C061798
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so24480966lfo.1
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twtRf4xOH0E0x9VRPwiTE28bCNXEVhaTsRzwx7xbrKw=;
        b=lU9/SRoV03AHz32BTueW8Zs/Zu6BRhSiduSV+MHdg1QTt/JJmAQwq26pY1Z34uKvdW
         lYM/a65VpievswFTX8dByBheLQAZEj4FbGV0aBYDQw5TDb0Ni/rna8QYcNdBWG0CMW/Z
         R5uxxjuTbgQEjjv94bRAWN+pWHV5flmtkAz1OnvOpJFdNdpKx3NQR7JSrsmsbyIZpe/3
         hNBoGLeG9vMHJjsuYGdZ8wa6Jb9Qk1+xpNB4IhZDe8SPbb8IvE8n10suMMq4Cbbo3KEh
         wk5XvrMv0b56blQd2fcJamPXcTI05fH5wOX8s9g3zhZL2ZeuQIXzu03NVvt7RTZwrxio
         konA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twtRf4xOH0E0x9VRPwiTE28bCNXEVhaTsRzwx7xbrKw=;
        b=kdHKo7D6Wr0/XXyT+blmnz4DrKLXNfIA2QLIpolhjnqqbrAMmeos55P9l8ptSPMAwk
         vmHXkokyr5u8C2A9l40q4o7o1YnL6HMqFA/kBc6GWAasT1YAhjoo5THVXXjVcGcHTsQW
         8EHniUNMPjhssqX1d3CbtioMmNbxMF7ANPCEj5uRFlAKOY+NyqT2PbPu/v6yVRNczanf
         LTrO5hF68hHD7+lnSs5DSg/grHhBeMzDHZXWeLzV0nT/ytgpjcCwjaLBQzM9mTe41eD5
         83JCA1lTX4FjjBCBKzXVUqi7GRxXWAAJPLa/PzcNOStbub8KC6ucZhPrTPwry3U9xPDH
         bFZA==
X-Gm-Message-State: AOAM5320pBiuEjn00lBNWbpCULFhKmhpci96oHZ4a45hFkAHuuakm8Vl
        X9lCuLsYa8Gbt0mNMLL83PkDiOBOv6KJq9cd
X-Google-Smtp-Source: ABdhPJw+l/zHTcwB2eE+RS00Gi3MEAW05sPalQqS0+4YofrYw34klbw3EYWTZT1Mxu477IX9W01LYA==
X-Received: by 2002:a05:6512:70d:: with SMTP id b13mr11721704lfs.639.1610981528786;
        Mon, 18 Jan 2021 06:52:08 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.4])
        by smtp.gmail.com with ESMTPSA id h13sm1969697lfj.110.2021.01.18.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:52:08 -0800 (PST)
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
Subject: [PATCH v11 3/5] arm64: dts: qcom: pm8150x: add definitions for adc-tm5 part
Date:   Mon, 18 Jan 2021 17:51:58 +0300
Message-Id: <20210118145200.504951-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
References: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF9286098
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgJGNzG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgJGNy7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A26C0613D5
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l13so2046837ljg.10
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rflyFynNnBW4dG747SrCFXgcIAs909F2gibnTOq3B0k=;
        b=X6zvatvMf4NiPu34ajLdl+aiau0FB+MVkYYiN/IN+23Tw8W9zOmNQ+Yp4oMRFFRCzH
         WvDjUBcaq6iplnpjzLrTNXHL/xS8ZipyRvAYsFey9Q5xBavdVEAszpIMy9mK7wVwpuJF
         dRjlCprFWIosR3nhzBA33JVJQrz7NMwPqjWJ9vXT9hqdaFx/xyABFvmXEwEHqGCOmw4J
         IdCjfSNziEY7Sus2glq14luYHC5AQkj6pc8qmNiKhw4cmPsfN1xl03h2FonCgL4z5+fx
         5ui3pp7b48rqf6j+Ig+PbcwMhMeZUXbhHUeQ6D63y+hI0GfQ3ak3rS5jMg0qmyHu7T6h
         6fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rflyFynNnBW4dG747SrCFXgcIAs909F2gibnTOq3B0k=;
        b=mc2Zi1V2GW98tjqF4zkZva4O8IHtJH+fotCWM8nDz1KfUnpmiJaEnS3jB59q0He8H6
         U89ywC+kYnH5lGYAnUW4apZIFVuDb7OEKv5Rl0HF/ezwdw217WVXZoA+jMhJfAL2snUq
         pMrtOQ58V3JVuDgQvclZ77lbM++O/1LsPt26ojmdpXi4qU+XXboCl5exGLu0cVftvUvZ
         AOA2Sx7GiAnp5dyH/2+pthTCDKHfkNZ3sSBQAzU8vUbeNywd0sHmWGJ11FJmN93OGWvm
         cMWI8/YjeyGZ2ECYojFW/QvTSzkOyXMTop2dyNxeJfXTNdLC0OsaWLfGMMvGd4F4Xy3F
         BmZg==
X-Gm-Message-State: AOAM531BWKiLfXiy+3jhTbqGC4jN8mb/jf3Bnew4Sl6skQSNBFueQfAu
        UvNC5HA/PBHEiNm7e91p7Ok/cw==
X-Google-Smtp-Source: ABdhPJw0Frf4dKYcuZRSRpgjB6cg+6sMyuXxfmxAbvdESqRl+2ZTytYa74aSogD9SIF0fR4ySrnl+w==
X-Received: by 2002:a2e:241a:: with SMTP id k26mr1176611ljk.58.1602078897104;
        Wed, 07 Oct 2020 06:54:57 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:56 -0700 (PDT)
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
Subject: [PATCH v7 08/10] arm64: dts: qcom: pm8150x: add definitions for adc-tm5 part
Date:   Wed,  7 Oct 2020 16:54:31 +0300
Message-Id: <20201007135433.1041979-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
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
index 1b6406927509..b1b518c6a2c9 100644
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
 		rtc@6000 {
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
2.28.0


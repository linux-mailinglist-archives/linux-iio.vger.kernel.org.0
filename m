Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17642CE637
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgLDC5n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 21:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgLDC5n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 21:57:43 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9644C094271
        for <linux-iio@vger.kernel.org>; Thu,  3 Dec 2020 18:55:48 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so4951335ljk.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Dec 2020 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npsFFsjWmPcNQLpFgdF7vTEr/fbtzWSA2WvHK+VX9Y8=;
        b=y6oI6KNiv5i2nOCS/ZDnUrSDdzRzW4B59lG4xHN0AIp20CVPSsAMgZdPWIURR+l0v1
         LXMm1JIBnd0SnaszpyFdKxFdhFAs+55BGR0fWES1tLNeQ4gOsdLB4KcMXAEfPprSVzAh
         GhOIEDxicarbWYg9FmYmYrMd8q9JhmzdgBOwmYpaWwfl9QbJBZiV294dud9m+qzIU3xt
         T02P4voCfQ5KpuTU1Cm8LCKFN7R4bb6mW9J+qtKJxUnO/8NdyzGWbOV6LU2HZq48B0RR
         Lymt9vHQQWdKh6Q1bxpfw19GjR19PhkXLR94FBmz+PKZnQKlo/ubbdiPwqDx1NW5Mq0U
         cHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npsFFsjWmPcNQLpFgdF7vTEr/fbtzWSA2WvHK+VX9Y8=;
        b=g3A7bUQWfcKzhUw187zEhyg113yeWW1/i2s05pilYV1xjy5gYxkmgELYqiFrHACRd/
         i1HcJ8HTHP83lLcxCRaywvxQew1RLx3o3yiURL8eKdru/YxjRLOXHuskxYZuv2S/T6Sp
         IIgYWKZdFCcFSYS7hLfioiV9BPcoYRL2fszqf7uc+M5wDyjAFbQ2f2wde8PYnFZP4LqU
         Ip2+yqmcLSbcrGX1iTo74sUg7AEScyjC8LGJZXHzhic5yPGG9Q4XfyXxibxJ18xnY5bm
         ph2Pt/xpgpou0CVwO7LX+uDc+7hsxOnlyuIKS5tDlszBaSfZVSCZZgBQGVMzvU7qYh+f
         B/QQ==
X-Gm-Message-State: AOAM530SbW//zHnAw6z2JqJK2IrnkGcLPN3ZCqvF4v+eWEXz9SZUTgn/
        YVGMfxa91+hZYimQpr54Ks/QuZSmBCmixw==
X-Google-Smtp-Source: ABdhPJyN+Xzigra6XFVJWNEbJJIBS6A+N0yjQUv2woGcqjUazKcfA9sGLDx6WaQsqFSZ+S9OjFZjRw==
X-Received: by 2002:a05:651c:315:: with SMTP id a21mr2256590ljp.229.1607050547298;
        Thu, 03 Dec 2020 18:55:47 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.117])
        by smtp.gmail.com with ESMTPSA id b8sm1131667ljo.68.2020.12.03.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:55:46 -0800 (PST)
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
Subject: [PATCH v10 15/15] arm64: dts: qrb5165-rb5: port thermal zone definitions
Date:   Fri,  4 Dec 2020 05:55:09 +0300
Message-Id: <20201204025509.1075506-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add thermal zones definitions basing on the downstream kernel.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 154 +++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 1528a865f1f8..6cb8688910a2 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -58,6 +58,77 @@ bt {
 
 	};
 
+	thermal-zones {
+		xo-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 0>;
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wifi-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 1>;
+			trips {
+				active-config0 {
+					temperature = <52000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		conn-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150b_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		skin-msm-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pm8150l-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+	};
+
 	vbat: vbat-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VBAT";
@@ -412,6 +483,89 @@ &i2c15 {
 	status = "okay";
 };
 
+&pm8150_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	wifi-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc {
+	conn-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc {
+	skin-msm-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pm8150l-therm@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150_adc ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	wifi-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pm8150b_adc_tm {
+	status = "okay";
+
+	conn-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pm8150l_adc_tm {
+	status = "okay";
+
+	skin-msm-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8150l-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pm8150_gpios {
 	gpio-reserved-ranges = <1 1>, <3 2>, <7 1>;
 	gpio-line-names =
-- 
2.29.2


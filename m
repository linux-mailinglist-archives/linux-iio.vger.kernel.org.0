Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE22690A3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgINPuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgINPtQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 11:49:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC3C061A29
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so112972ljm.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CC03M+x7WzOjKcfpKM/7Z3TYFx8LGGbrK10cnVo1oKc=;
        b=zhd3020dqPyJBjQg4xlw3WBmmfR26mvl74Eic04WkGjniO5M4kKO0oY23a030j+4K+
         17N1jxXYlfhtBDzSML/181oAqats8sVbGvkVNKx+khr4j0YQ0PjicVtERIgxWA/NVEh9
         3HayV7FbWkDOmDOcZE1Rr9RTZxzl2I/skjn1fzWDhD+GEXAQpmwCB2M3NplMpYkoUN61
         A6BOUyMyrvfYINVSAbqiSNcRno7w0wmJJmyx5RvZ8cJojHmXSXLsZ371+MXN0hHdhqvO
         eCwLX0CrOsSuXYjh1FlXLaK43iPkWXWMfRRTPSxkHXWdK4Vk3xjKDiROO1s//csEW28i
         kyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CC03M+x7WzOjKcfpKM/7Z3TYFx8LGGbrK10cnVo1oKc=;
        b=lO1xPEuxnh8pa1DzZ8aKObt/Sicm89ZsKapMcM3VTNT1mgbwBlnBztu6fcfQ3AjcFU
         r3rGhMQ3ivwyW4UoJ4MxdM/gLZwyiOVubyqHpxh2lT+/b/25YPWLm9awrT03tfkDfNUS
         subi6zvbqS9ETFeYmK6Y1nbcHi8/D4GLVroHVGrz0h23tfAz8oSunTNDpV3Iu9KKOdTp
         r22bqsrvORZ5qDCJTrZTbWGAUZH9dTbEldDWwE2CNIOT8Ww7aVBpDbMc3jZUmKla57Zt
         Cb/YzKbRGieAN06IZfQEK9XJkWoykHtqrkieygAWbKzA1oJgiyZUXD3hx1n70m6T1Ui8
         ihnA==
X-Gm-Message-State: AOAM533JScShzorjTlWLSvbs/2as5gS+puUXECqJymxz19Z3amDPYaU8
        4LHzIp5mB2GWHQKxTfMKrgffpw==
X-Google-Smtp-Source: ABdhPJz2vASekaU7iCRw1BahWLVfkQgGw4nQO3kE9PxUDfOIAnyC/nVOgX6NEi2SMgljUuLvzQseuQ==
X-Received: by 2002:a2e:330e:: with SMTP id d14mr5426194ljc.12.1600098523459;
        Mon, 14 Sep 2020 08:48:43 -0700 (PDT)
Received: from eriador.lan ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id f19sm3834650lfs.85.2020.09.14.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:48:42 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 9/9] arm64: dts: sm8250-mtp: add thermal zones using pmic's adc-tm5
Date:   Mon, 14 Sep 2020 18:48:09 +0300
Message-Id: <20200914154809.192174-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Port thermal zones definitions from msm-4.19 tree. Enable and add
channel configuration to PMIC's ADC-TM definitions. Declare thermal
zones and respective trip points.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 212 ++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 6e2f7ae1d621..d06207ac5593 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -24,6 +24,104 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	thermal-zones {
+		xo-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 0>;
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 1>;
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		mmw-pa1 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
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
+					type = "passive";
+				};
+			};
+		};
+
+		camera-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-msm-therm {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		mmw-pa2 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8150l_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -358,6 +456,120 @@ &cdsp {
 	firmware-name = "qcom/sm8250/cdsp.mbn";
 };
 
+&pm8150_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm1@4e {
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
+	camera-flash-therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-msm-therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm2@4f {
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
+		qcom,adc-channel = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm1@2 {
+		reg = <2>;
+		io-channels = <&pm8150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc_tm {
+	status = "okay";
+
+	conn-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc_tm {
+	status = "okay";
+
+	camera-flash-therm@0 {
+		reg = <0>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-msm-therm@1 {
+		reg = <1>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,adc-channel = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm2@2 {
+		reg = <2>;
+		io-channels = <&pm8150l_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.28.0


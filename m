Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976A8202C6C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgFUTgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgFUTgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:36:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA3C061794
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:36:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so8379496lfh.8
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ErXkZf7BLCpg6GnDRfFbSB9VliQZ1SaYRDHnOq2XmQ=;
        b=FxDenOYF/A25j1VglXtu1i1YXkjt6BN1uw/1Pl65aRzdJTSHJot639NR/ARSNVJ+F6
         xNRewo7x5sOg0i0gK1tOpUELDEI7C5+GzmFYMk5uzfLJjkLNGTYH17XazC6i2t+IE2s9
         RjHP5Acy/RY/JUnqyX6CcrvKUZoteZ/917pdCH9Yfc0tfYvTuCe0/madFMzUBJwHieKB
         4/OKykeF4H9qhdGcSPpGjuhzBpRDFQoPsA2hZ6MxmYBnctHwrURyAJD0l1cDWv6377HY
         0cQs5sjr9/M25+lNQ9jUFGBTutwEDU6L4Xipu/Clqz6X0vCh/s+dppWmDHLsz+zr50Ke
         LoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ErXkZf7BLCpg6GnDRfFbSB9VliQZ1SaYRDHnOq2XmQ=;
        b=lvuq9di5N+W2KhvJpwmF5GDrjRgEPFZI30BOjJ26bEzzslfBlU2cJRNOOcl21dOzie
         jVUMfh7rqZx7RnijurfpCDTapd12d1Z5PaW9Zt/RGnAZ6A6OSm0C01b6Iv+FqqrQnEXB
         zb70lK2DpCieymUr9XY0o7A0exxFiLdzfND5arI4XHloYOZtUVkEznFWtyEIFUNvGVzd
         NC3UsAySm4QM3LLMAWWXrmQvi3MEcCmvi0FuRCD2/407jz5zvYWrk19q2ikJ+OWFirdT
         6T0m8QgcF3cWCxHuPKopy6h6I9z5moTECtMxQRK1fOpu0PnN//aph+3GmZRWYCxpOFZU
         A51w==
X-Gm-Message-State: AOAM530V8tcINTN6+J6uOstzRlVuQV2F1jZOfG15+DdDjCw6I2AlKiHS
        C1oTPpkWIrDG18rjzY1bP5Ntnw==
X-Google-Smtp-Source: ABdhPJyHy+F4nl+WPicpa+P4vCnIRV8pPlgwelwB2C6R7uS7V56PUmE76u46+okaWvQiuchI0SfYgQ==
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr7842921lfr.35.1592768161337;
        Sun, 21 Jun 2020 12:36:01 -0700 (PDT)
Received: from eriador.lan ([188.162.65.109])
        by smtp.gmail.com with ESMTPSA id r13sm2917854lfp.80.2020.06.21.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:36:00 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: sm8250-dts: add thermal zones using pmic's adc-tm5
Date:   Sun, 21 Jun 2020 22:35:49 +0300
Message-Id: <20200621193549.2070434-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 237 ++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index aa37eb112d85..78f0cf582a9a 100644
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
@@ -355,6 +453,145 @@ vreg_l7f_1p8: ldo7 {
 	};
 };
 
+&pm8150_adc {
+	xo-therm@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin_therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa_therm1@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
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
+	camera_flash_therm@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin_msm_therm@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa_therm2@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150_adc ADC5_XO_THERM_100K_PU>,
+			<&pm8150_adc ADC5_AMUX_THM1_100K_PU>,
+			<&pm8150_adc ADC5_AMUX_THM2_100K_PU>;
+	io-channel-names = "xo-therm", "skin-therm", "pa-therm1";
+
+	xo-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_XO_THERM_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-therm@1 {
+		reg = <1>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm1@2 {
+		reg = <2>;
+		qcom,adc-channel = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150b_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+	io-channel-names = "conn-therm";
+
+	conn-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm8150l_adc_tm {
+	status = "okay";
+	io-channels = <&pm8150l_adc ADC5_AMUX_THM1_100K_PU>,
+			<&pm8150l_adc ADC5_AMUX_THM2_100K_PU>,
+			<&pm8150l_adc ADC5_AMUX_THM3_100K_PU>;
+	io-channel-names = "camera-flash-therm", "skin-msm-therm", "pa-therm2";
+
+	camera-flash-therm@0 {
+		reg = <0>;
+		qcom,adc-channel = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	skin-msm-therm@1 {
+		reg = <1>;
+		qcom,adc-channel = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+
+	pa-therm2@2 {
+		reg = <2>;
+		qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.27.0


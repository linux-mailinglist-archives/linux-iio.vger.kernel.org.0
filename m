Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374D74B0F1
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jul 2023 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjGGMar (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jul 2023 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGGMao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2023 08:30:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B32680
        for <linux-iio@vger.kernel.org>; Fri,  7 Jul 2023 05:30:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so27485011fa.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Jul 2023 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733035; x=1691325035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTSBGkbCdTiuLImTC/+Q/VqyS/BNdIlHaPBfQkN8Fbg=;
        b=X0mHk2nwAm0xIRsxPWOcmqo74FEyr3W9KrBwXBbmVCUzelHpCfL1boyOKefeLb65Bv
         ULwuwvhMr1F8s0FkXw6VyYHTbQnWvrFcPcPc6N0/xA5CMZGwpZ9WSS42MFAbfA+yw7m7
         CBkqigP2cyugtdnPoB0tEbfPHmef/hhss0L7u51x7bWHO2dHYCP2D7lCIZeTVUQ5IicA
         LmjG7PzU/hGl/JDHAZy5204VNiJC01PD73apE6gYM06zSvQx6vJnRDPMJzItm12lWVx1
         HtSMSzCRWFmN+GWWKv5KFgKTyPWOf3lpPzadPFBxFtws0Ca2UPa/6/ZjeHqIVWNyrYT2
         yEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733035; x=1691325035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTSBGkbCdTiuLImTC/+Q/VqyS/BNdIlHaPBfQkN8Fbg=;
        b=ROhiHsnTD7h9LMu802QTG8DtXD6j4/C4iTxpGRwM7jeDwoslXBtAM7fc4pzJMENli0
         1zmpl1H1Yp12LyveHBOEenraZlCkZZvOQ7TzOme0dqg7YGafSB+BBGrYTgXYIwX7o9jB
         /vh0mK9v7osj6QPwPw4nlQHQLrILuF0blChkrvU0hbtTGaY3IflxTCyX3Z9WAZpU54FQ
         FzUm4DIE5rpgptqNguQPPVuF2XAp+LaRyjJy8LAF6dygXwQqcfCW+v6ffU/glhAieFQ7
         GQ7o5EnHhvnhCSb+UVhkDEnxQ2ZXCf9LpWg1vi3jDL/UgscXDlQuNfk28yORgiEw2Sv7
         MbDA==
X-Gm-Message-State: ABy/qLa3piABEmlQlZXzmhOWqA/kB9RR5aluFyOpI+vh0ZR6fFTNkaVX
        JCh4JRL9qwvhSecl41iAgmPD+A==
X-Google-Smtp-Source: APBJJlFy3tzD5h45ARrNTXDkqtUYWCDJ2mAZYtRLy7+eWRoCdJFboNx6hUgnpec6EBha2RvS1liMdQ==
X-Received: by 2002:a2e:9d04:0:b0:2b6:e8a0:a7f8 with SMTP id t4-20020a2e9d04000000b002b6e8a0a7f8mr3481998lji.31.1688733034716;
        Fri, 07 Jul 2023 05:30:34 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8685000000b002b6ee99fff2sm756803lji.34.2023.07.07.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:30:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm8450-hdk: add ADC-TM thermal zones
Date:   Fri,  7 Jul 2023 15:30:27 +0300
Message-Id: <20230707123027.1510723-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add thermal zones controlled through the ADC-TM (ADC thermal monitoring)
PMIC interface. This includes several onboard sensors and the XO thermal
sensor.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 244 ++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index d07e402eaba3..4dfc964a4bb1 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -133,6 +133,120 @@ pmic_glink_sbu: endpoint {
 		};
 	};
 
+	thermal-zones {
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		rear-tof-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 5>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		skin-msm-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		therm1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 3>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		therm2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 6>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		usb-conn-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 7>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wide-rfc-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 4>;
+
+			trips {
+				active-config0 {
+					temperature = <75000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+
+		xo-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <50000>;
+					hysteresis = <4000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -607,6 +721,66 @@ &pmr735a_temp_alarm {
 	io-channel-names = "thermal";
 };
 
+&pmk8350_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	skin-msm-therm@1 {
+		reg = <1>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	camera-therm@2 {
+		reg = <2>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	therm1-therm@3 {
+		reg = <3>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	wide-rfc-therm@4 {
+		reg = <4>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	rear-tof-therm@5 {
+		reg = <5>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	therm2-therm@6 {
+		reg = <6>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_GPIO3_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	usb-conn-therm@7 {
+		reg = <7>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_AMUX_THM5_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pmk8350_vadc {
 	status = "okay";
 
@@ -615,20 +789,90 @@ channel@3 {
 		label = "pmk8350_die_temp";
 	};
 
+	channel@44 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "pmk8350_xo_therm";
+	};
+
 	channel@103 {
 		reg = <PM8350_ADC7_DIE_TEMP(1)>;
 		label = "pm8350_die_temp";
 	};
 
+	channel@144 {
+		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "skin_msm_temp";
+	};
+
+	channel@145 {
+		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "camera_temp";
+	};
+
+	channel@146 {
+		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "therm1_temp";
+	};
+
+	channel@147 {
+		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "wide_rfc_temp";
+	};
+
+	channel@148 {
+		reg = <PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "rear_tof_temp";
+	};
+
+	channel@14c {
+		reg = <PM8350_ADC7_GPIO3_100K_PU(1)>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "therm2_temp";
+	};
+
 	channel@303 {
 		reg = <PM8350B_ADC7_DIE_TEMP>;
 		label = "pm8350b_die_temp";
 	};
 
+	channel@348 {
+		reg = <PM8350B_ADC7_AMUX_THM5_100K_PU>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "usb_conn_temp";
+	};
+
 	channel@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 	};
+
+	channel@44a {
+		reg = <PMR735A_ADC7_GPIO1_100K_PU>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "qtm_w_temp";
+	};
+
+	channel@44b {
+		reg = <PMR735A_ADC7_GPIO2_100K_PU>;
+		qcom,hw-settle-time = <200>;
+		qcom,ratiometric;
+		label = "qtm_n_temp";
+	};
 };
 
 &remoteproc_adsp {
-- 
2.40.1


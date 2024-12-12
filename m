Return-Path: <linux-iio+bounces-13397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727679EF0C6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D3189CBD6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AD23EBFB;
	Thu, 12 Dec 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HnW1xJOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360323EA7D;
	Thu, 12 Dec 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019964; cv=none; b=Iy3s8vo761Iu5kXSwHZ05eOWP+45a9ut+3DnHGe20XXtK5mwnLpfB6ClaIcqr8Bb/4/8TGNl9SCD1TJIYR0EUIoNQ/IIrvEct1JMOjowqqGlQ2EHj5nKQe2Tp7YR5AkRDN5nutN26iqzPS5urT8OtrlE/7mF26QQkHxIW2eebdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019964; c=relaxed/simple;
	bh=TMSwrhFLavByCNsd4eRDFVMgopNn4ldvQRZdBnSZ19E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c7Sq7u30EHos4wzsUvZ4xw4zLtiIOVxJb44y9vnWmSODFYAh/eKFmJr9ZNCNVN/tPRIFUHrjJ1Gy5RxtDFaHES9bKmAnjOJawacuHETM8dVvoPFwV/t4Aa5O8JXMUAp/AKZY0H6ZtrhtO+h4ff1txeROC3n2fW/zn8V8dDNPZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HnW1xJOf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9kvmM031415;
	Thu, 12 Dec 2024 16:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uBaWmMgWuGsO//efGKtqnctXQX83mpfe4lKciwCDCu0=; b=HnW1xJOfR685wGP2
	Ys4jdKDKvm6tgDp9EHh06lyiW/w/7IRfO0GzaWoui2QkXnOfv2g0x2gwSFTmTz3l
	8j0fLc03pWDcoUPt5RNT/Whs10kC1pYUdC6QgLXQ837p1dJwUaDcuxUFJMZcYVyb
	N0gpzgvALpPvCDRoXI46MVJcS8wDeQ4cKVCOhzoNOCaIVPCkTr2d85PpnwSVNRBX
	Wa8ImFAzlOs0EFY53uAe6KYtPhY51zAtij8BU59lP3ilAQFoW2Rcm91rM8sClH8L
	Jxh1SfpzUr5wEd+2PRvx6QDW/dDNoCOQJN6LzeNq71N31IAPEOalwvQcq6SRrS2S
	+TzcZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fwgeh2g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGCNGT026621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:23 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:12:16 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 12 Dec 2024 21:41:24 +0530
Subject: [PATCH RFC v2 5/5] arm64: dts: qcom: sa8775p-pmics: Add support
 for MBG TM
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241212-mbg-v2-support-v2-5-3249a4339b6e@quicinc.com>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
In-Reply-To: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones
	<lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jprakash@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YG3slyoayL5r38_AmSP6CjmYjOpcdNvD
X-Proofpoint-ORIG-GUID: YG3slyoayL5r38_AmSP6CjmYjOpcdNvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=907 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120117

Add support for MBG TEMP peripheral for pm8775 sail pmics on SA8775P.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 116 ++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index e87f95e9ba9f59e3f067af0d5565b8e3ed4b37fc..eade5784f18629dc9f7ebf0257551bf96bea9a4c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -89,6 +89,58 @@ trip1 {
 				};
 			};
 		};
+
+		pm8775-mbg0-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pmm8654au_0_mbg_temp>;
+
+			trips {
+				trip0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pm8775-mbg1-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pmm8654au_1_mbg_temp>;
+
+			trips {
+				trip0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pm8775-mbg2-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pmm8654au_2_mbg_temp>;
+
+			trips {
+				trip0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pm8775-mbg3-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pmm8654au_3_mbg_temp>;
+
+			trips {
+				trip0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+			};
+		};
 	};
 
 	reboot-mode {
@@ -181,6 +233,22 @@ reboot_reason: reboot-reason@48 {
 		};
 	};
 
+	pmm8654au_sail_0: pmic@1 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_0_mbg_temp: temperature-sensor@d700 {
+			compatible = "qcom,spmi-pm8775-mbg-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_0_vadc PM8775_ADC5_GEN3_DIE_TEMP(0)>;
+			io-channel-names = "thermal";
+			interrupts = <0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_1: pmic@2 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x2 SPMI_USID>;
@@ -228,6 +296,22 @@ pmm8654au_1_gpios: gpio@8800 {
 		};
 	};
 
+	pmm8654au_sail_1: pmic@3 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_1_mbg_temp: temperature-sensor@d700 {
+			compatible = "qcom,spmi-pm8775-mbg-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_1_vadc PM8775_ADC5_GEN3_DIE_TEMP(2)>;
+			io-channel-names = "thermal";
+			interrupts = <0x3 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_2: pmic@4 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
@@ -275,6 +359,22 @@ pmm8654au_2_gpios: gpio@8800 {
 		};
 	};
 
+	pmm8654au_sail_2: pmic@5 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_2_mbg_temp: temperature-sensor@d700 {
+			compatible = "qcom,spmi-pm8775-mbg-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_2_vadc PM8775_ADC5_GEN3_DIE_TEMP(4)>;
+			io-channel-names = "thermal";
+			interrupts = <0x5 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_3: pmic@6 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x6 SPMI_USID>;
@@ -321,4 +421,20 @@ pmm8654au_3_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	pmm8654au_sail_3: pmic@7 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_3_mbg_temp: temperature-sensor@d700 {
+			compatible = "qcom,spmi-pm8775-mbg-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_3_vadc PM8775_ADC5_GEN3_DIE_TEMP(6)>;
+			io-channel-names = "thermal";
+			interrupts = <0x7 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
 };

-- 
2.25.1



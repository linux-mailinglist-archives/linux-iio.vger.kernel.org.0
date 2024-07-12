Return-Path: <linux-iio+bounces-7542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0C92FA93
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4B1F22B91
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2717166A;
	Fri, 12 Jul 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJTjXy04"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0B16F85B;
	Fri, 12 Jul 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788315; cv=none; b=gf+Defsj8HUgKLbdauZ+XsNSyj4DWrdArBg/F6FAPerqyVLMKWe032eePvI+8diCrqt3tqIyrmJdRFPxaFXUmMfjAuofVkGBX75y1zYmeJu/2y9dLZTcB4DTZgQi7kCqW7iElVN/qQyt9MZRvvP25B0R5GCLXAGErMh11lxwSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788315; c=relaxed/simple;
	bh=xT3vdgzfitnNc45nl9KNHLr746ozbECZ34w19TY+CLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a6odkT09twu/3EYxTUuzpyQLQotILpnVLZvIVXJ9IPzz+tmp3z7e5J5dH2RBXhzmXGonqLP28ux8KRdJcX24bRky+0Z6rLo19iUnAwcyv2Z9sHBgXrtn8QqLBfTqTGUF/ubUi7/AGvfLQkHQnV7GgLB/bjQ1+XDzgzi3xvwel+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJTjXy04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CBAer6007447;
	Fri, 12 Jul 2024 12:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LRIVKzH1hSjxSuvugXYotptQy+3/BurYv3ZsB9X2wks=; b=IJTjXy04IXXlH8yO
	yBJA8SrsIw4Gk9ZpePLi5+nOS+qRNnoUZyUSw17xA6Sdk+roi0qF9krwIBdmKEnD
	dRGyCYXeOHAx55URoqRtFL9A+8MeC41nFariZgHFxkSi7Xn6TRXnU4RfhX/cRL4F
	uoMU+fvP1rs+CGo3EGZGWs5Awf4gAFB8attTs/DiNfhMsZCeVGuBzpcb5EDvX6O9
	F5y28ulHmXYCzTqYqKe4OchZLg/lGuZ4mKJH2kyyhVOPhmGZihWZjYkPMByvJ1NS
	YZHc7hEhCYe9Yerji4YQ9Ao9v9auqOVS3ndHdD3tkNZdFtyCRhln+X0E00gF3hKP
	RyI4Og==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ac0gkh2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCirf0028069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:53 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:46 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Fri, 12 Jul 2024 18:13:32 +0530
Subject: [PATCH 5/5] ARM: dts: qcom: Add support for MBG TM for pm8775 on
 SA8775P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240712-mbg-tm-support-v1-5-7d78bec920ca@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
In-Reply-To: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Thara
 Gopinath" <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nYXH9ngSNr5YB03qH1V5mF878LG88bvj
X-Proofpoint-GUID: nYXH9ngSNr5YB03qH1V5mF878LG88bvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=823
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120086

Add support for MBG TM peripheral for pm8775 sail pmics on SA8775P.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 120 ++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index bd4f5f51e094..69910306885e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -89,6 +89,62 @@ trip1 {
 				};
 			};
 		};
+
+		pmm8654au_0_mbg_tm: pmm8654au_0_mbg_tz {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_0_tz>;
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
+		pmm8654au_1_mbg_tm: pmm8654au_1_mbg_tz {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_1_tz>;
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
+		pmm8654au_2_mbg_tm: pmm8654au_2_mbg_tz {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_2_tz>;
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
+		pmm8654au_3_mbg_tm: pmm8654au_3_mbg_tz {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_3_tz>;
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
@@ -180,6 +236,22 @@ reboot_reason: reboot-reason@48 {
 		};
 	};
 
+	pmm8654au_sail_0: pmic@1 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_0_tz: qcom,mbg-tm@d700 {
+			compatible = "qcom,spmi-mgb-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_0_adc PM8775_ADC5_GEN3_DIE_TEMP(0)>;
+			io-channel-names = "thermal";
+			interrupts-extended = <&spmi_bus 0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_1: pmic@2 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x2 SPMI_USID>;
@@ -226,6 +298,22 @@ pmm8654au_1_gpios: gpio@8800 {
 		};
 	};
 
+	pmm8654au_sail_1: pmic@3 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_1_tz: qcom,mbg-tm@d700 {
+			compatible = "qcom,spmi-mgb-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_1_adc PM8775_ADC5_GEN3_DIE_TEMP(2)>;
+			io-channel-names = "thermal";
+			interrupts-extended = <&spmi_bus 0x3 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_2: pmic@4 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
@@ -272,6 +360,22 @@ pmm8654au_2_gpios: gpio@8800 {
 		};
 	};
 
+	pmm8654au_sail_2: pmic@5 {
+		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmm8654au_2_tz: qcom,mbg-tm@d700 {
+			compatible = "qcom,spmi-mgb-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_2_adc PM8775_ADC5_GEN3_DIE_TEMP(4)>;
+			io-channel-names = "thermal";
+			interrupts-extended = <&spmi_bus 0x5 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
 	pmm8654au_3: pmic@6 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
 		reg = <0x6 SPMI_USID>;
@@ -317,4 +421,20 @@ pmm8654au_3_gpios: gpio@8800 {
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
+		pmm8654au_3_tz: qcom,mbg-tm@d700 {
+			compatible = "qcom,spmi-mgb-tm";
+			reg = <0xd700>;
+			io-channels = <&pmm8654au_3_adc PM8775_ADC5_GEN3_DIE_TEMP(6)>;
+			io-channel-names = "thermal";
+			interrupts-extended = <&spmi_bus 0x7 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
 };

-- 
2.25.1



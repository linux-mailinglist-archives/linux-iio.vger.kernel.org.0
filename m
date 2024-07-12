Return-Path: <linux-iio+bounces-7541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C68B92FA8F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E394FB2235A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24C16F855;
	Fri, 12 Jul 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eBIEwsE3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D16F85B;
	Fri, 12 Jul 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788307; cv=none; b=g5lHuvqBp0m9DsB5bYkE6u8cYHAMc7+9THOJp1aXI57TM/MrdCWCPDKGHxk0K74WmvO4cxA78rj8eNsLs2turq6jRR/p7E7qP2bfBBK4Pc9XeMI/0AU3S46pMZNG6gCNC7NPtRtaT8LpFQd0Xrt94w8g3bfK9kYpmdBoWmF4Cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788307; c=relaxed/simple;
	bh=/NnIWX63FeKLVuoHGgZe6A4FAbULEhPeW8E6yv8jWHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RkXsQEbOO/FNS781mZ5Xehy96iYHOpoJSxx44XWC3wa2pS+CDtom2joH9+uNWpkd3GcKIct6pkjMnSL19nvF4BT40Ti2LnKxQ7h9wdVBFUgkiHyW74RRtmdabS1VgplGwNQODQcrq0jwdluK+tLoR99Eplrz1minRSD0YUit3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eBIEwsE3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C7LhWS030226;
	Fri, 12 Jul 2024 12:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThRMC8FcCjQyzFvD1AUwqljCoPTz+CquU0rhPU6flz8=; b=eBIEwsE3OUWlpHFh
	gZAIXNZGffRpiArRkIHTsK1nHccfQd1feA68Kp7eZQNEJbSSNyu/epfzHWT3amux
	GOwwxDHpLHrSk08yT4KI6Z+xFCwn/Lap2sJQHOjjGFkwzGuv5tdexwfWYUP3TDNL
	fjrqPByvss/bCrcq266Iyp9Bwcsg+hm7CD7h22dIb3InyI7gez5+Y+jo6MZTUHOw
	fBgk81vsP0Iq2Q9LgHVZ3fzn9jCgKN5FYcLgf5qw2P+zrZOIXnH2LP+X0jjCRDy0
	FmnGAzBIB1yBARE5fEDFvtyIIyi4dJ5cOmY62kRhI+bYOqmJWFCM1s/N9Qrgxub9
	l6N/WA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ajbqteaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCikl0010100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:46 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:39 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Fri, 12 Jul 2024 18:13:31 +0530
Subject: [PATCH 4/5] ARM: dts: qcom: Add vadc support for pm8775 pmic on
 SA8775P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240712-mbg-tm-support-v1-4-7d78bec920ca@quicinc.com>
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
X-Proofpoint-GUID: ryM9PU3dxq8UJyvRcwGzmwAejAH0g0wz
X-Proofpoint-ORIG-GUID: ryM9PU3dxq8UJyvRcwGzmwAejAH0g0wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=989 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120086

Add support for reading the adc channels of pm8775 on SA8775P platforms.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 1369c3d43f86..bd4f5f51e094 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
  * Copyright (c) 2023, Linaro Limited
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/spmi/spmi.h>
 
@@ -105,6 +107,28 @@ pmm8654au_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_0_adc: vadc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts-extended = <&spmi_bus 0x0 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#io-channel-cells = <1>;
+
+			pmm8654au_0_die_temp {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(0)>;
+				label = "pmm8654au_0_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmm8654au_0_vph_pwr {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(0)>;
+				label = "pmm8654au_0_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_0_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -162,6 +186,28 @@ pmm8654au_1: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_1_adc: vadc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts-extended = <&spmi_bus 0x2 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#io-channel-cells = <1>;
+
+			pmm8654au_1_die_temp {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(2)>;
+				label = "pmm8654au_1_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmm8654au_1_vph_pwr {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(2)>;
+				label = "pmm8654au_1_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_1_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -186,6 +232,28 @@ pmm8654au_2: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_2_adc: vadc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts-extended = <&spmi_bus 0x4 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#io-channel-cells = <1>;
+
+			pmm8654au_2_die_temp {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(4)>;
+				label = "pmm8654au_2_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmm8654au_2_vph_pwr {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(4)>;
+				label = "pmm8654au_2_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_2_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -210,6 +278,28 @@ pmm8654au_3: pmic@6 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_3_adc: vadc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts-extended = <&spmi_bus 0x6 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#io-channel-cells = <1>;
+
+			pmm8654au_3_die_temp {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(6)>;
+				label = "pmm8654au_3_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			pmm8654au_3_vph_pwr {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(6)>;
+				label = "pmm8654au_3_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_3_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;

-- 
2.25.1



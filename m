Return-Path: <linux-iio+bounces-13396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36C9EF0E0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AD1895398
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262023E6F0;
	Thu, 12 Dec 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PskTcxEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72A23E6F1;
	Thu, 12 Dec 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019956; cv=none; b=WnskL1cisJa+Lb+UOyEv4IRQasEsQLHIRFIiBtGpWlb3vu8OP6u9THaHHE/dCnzEMGCTDhFp6Lg4P6p4S06TdHwFX8R375MpdIr2UDK3PIp1iLY/TnC69GDLIQK+JE7yC3XNDKMBD8EEJXtu8ukDzmAATjxT7LgHa1sIW2YtrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019956; c=relaxed/simple;
	bh=C/ledH03AoG9BmK3f45NBwR2yVVLvua+Rumf3pSCpw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fH1051WYC0khzL6t521zVLKz1cHHmOr/BHqcUqxjixhSTpQsqmzLKqMww+N6cohZ8y3YBdjyRGLmAMU3CwT/qaEt+4NAbUY/hK2P6bWYWxbF9hHVtnoaUXxIHizmur5wPu6A12HKrN94GHmHYwXjnE+i/ut+ZFQVWwEstg+bxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PskTcxEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC8GXs8019800;
	Thu, 12 Dec 2024 16:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OD8rhcSCxBpQx/06Ok3xSgKcEju9ercXCQXDEneIM1Q=; b=PskTcxEi4ihMY9Ri
	+NCJKTRVJoXjOWv7Ve3L5d7szMcpFJKB/mC1SDgG1RMz2Kb7LID8LB1a93gVvd69
	nQ+1KdKNPOMYh2jZIGMXUkA1yBC75ColpKPW1r6ofyMBQltbSe6N0rJOglA/l6A+
	sOYyaDR5zc37hOwQbqR4gQmXr7aWtnwdRTkH2BqUrdJFdMyr9EcIjwnEt6Gl3m6h
	65238RrKzAd8+w6R/A0SeVRmGBvfoTU5trn2QV8L3EnSBNIiR1HwvWQ4t/HHC1WY
	yj7WRMYfKNDZVDykGhET9kxilgymJ1GATK5WThrVxLBctlKGWy8WALTWdAdSHLS8
	mV3aGw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdyu4qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGCGv3015206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:16 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:12:08 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 12 Dec 2024 21:41:23 +0530
Subject: [PATCH RFC v2 4/5] arm64: dts: qcom: sa8775p-pmics: Add vadc
 support on SA8775P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241212-mbg-v2-support-v2-4-3249a4339b6e@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A6JudYIMO1r-_u5-Rs_QMTm_L-045FoA
X-Proofpoint-GUID: A6JudYIMO1r-_u5-Rs_QMTm_L-045FoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=998 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120117

Add support for reading the adc channels of pm8775 on SA8775P platforms.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 94 +++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..e87f95e9ba9f59e3f067af0d5565b8e3ed4b37fc 100644
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
 
@@ -105,6 +107,29 @@ pmm8654au_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_0_vadc: adc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x0 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(0)>;
+				label = "pmm8654au_0_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			channel@1 {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(0)>;
+				label = "pmm8654au_0_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_0_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -162,6 +187,29 @@ pmm8654au_1: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_1_vadc: adc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x2 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(2)>;
+				label = "pmm8654au_1_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			channel@1 {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(2)>;
+				label = "pmm8654au_1_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_1_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -186,6 +234,29 @@ pmm8654au_2: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_2_vadc: adc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x4 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(4)>;
+				label = "pmm8654au_2_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			channel@1 {
+				reg = <PM8775_ADC5_GEN3_VPH_PWR(4)>;
+				label = "pmm8654au_2_vph_pwr";
+				qcom,pre-scaling = <1 3>;
+			};
+		};
+
 		pmm8654au_2_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -210,6 +281,29 @@ pmm8654au_3: pmic@6 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_3_vadc: adc@8000 {
+			compatible = "qcom,spmi-adc5-gen3";
+			reg = <0x8000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x6 0x80 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adc-sdam0";
+			#thermal-sensor-cells = <1>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <PM8775_ADC5_GEN3_DIE_TEMP(6)>;
+				label = "pmm8654au_3_die_temp";
+				qcom,pre-scaling = <1 1>;
+			};
+
+			channel@1 {
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



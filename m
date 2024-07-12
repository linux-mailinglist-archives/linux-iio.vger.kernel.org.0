Return-Path: <linux-iio+bounces-7538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1E92FA7D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DCD1F22BD0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051F16F8E9;
	Fri, 12 Jul 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="me29irso"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9516F85A;
	Fri, 12 Jul 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788286; cv=none; b=MjrVroAV26ecWA/gZLI89D8wBhB03v9lgitQKtu1AKc7F5itvUorujRAdzq8QobqW9p9DcgsNktlohEXiWluCmOVbtsmdZ5EW35fQCjWqmyDWX/qNbGN+GF08FgWq18Bk/gGwXGJFBOX4tjAFf+aJh8ZAkGchgAAK/+RJ9FxbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788286; c=relaxed/simple;
	bh=uayfwc7zaHpay9gBZLMKZsr6recU8UX7T3703k1ppJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iZlbFrobNZmuoz6Qq1UQHqTeSwXAbdtANnzCojSBjQUUV4D0LqXHr0Hls6CjiCIG/u4nOJvzIfQndbSPASB8wDpwP5+CXBiwIJO4DguVDtLMAmsXLZ+YgP/mK+8hVBT7bh1W9YJqKh5s43zAMWbVK68tPHDCIQgeFCntHFLBaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=me29irso; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CCXPIC011771;
	Fri, 12 Jul 2024 12:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LFoJzH2tRLlH37n1tUXEvEFwJRnSHELZkaV25RncfhM=; b=me29irso1NHvGaQ5
	8yaOm3BbsgC5RBw2AkOLQwFMFzSG6uqMuZ0SUYYptNpwgxFQkGf43q+WXiVtfYaJ
	fAvsuXGYbAscoEAbWFiB4Ad6hbAvglFev67jvyVZ+LhH8jAKkZy2KAm1HfD5/f06
	2rIQAoulCabEHd8Pr3MawrQGtksKTz0ftoHLfUHIeSUfAT0OHiYxSex84IcROWPK
	JC5GuLIQjmmv6aquJJyFrDUq1D//pqvbrqbO4i3yp3F4ZxvaDnXqJWe0XIGUzYI0
	mZfVzwciGP0Ftqd4KiH/H5a0OHptMfOy4PEwTScG6imCWuO7AGE+Vc26flyOH12S
	Qdh2TQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwy8ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCiPXw024627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:25 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:18 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Fri, 12 Jul 2024 18:13:28 +0530
Subject: [PATCH 1/5] dt-bindings: iio: adc: Add ADC5 GEN3 Channel info for
 pm8775 PMIC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240712-mbg-tm-support-v1-1-7d78bec920ca@quicinc.com>
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
X-Proofpoint-GUID: q0CZ0Be9kE5wf-gzs1vTsJnwqvz-wVOo
X-Proofpoint-ORIG-GUID: q0CZ0Be9kE5wf-gzs1vTsJnwqvz-wVOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120086

Add definitions for ADC5 GEN3 virtual channels(combination of ADC channel
number and PMIC SID number) used by PM8775.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
new file mode 100644
index 000000000000..84ab07ed73cc
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8775_ADC for PMIC5 Gen3 */
+#define PM8775_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8775_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8775_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8775_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8775_ADC5_GEN3_AMUX1_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX1_THM)
+#define PM8775_ADC5_GEN3_AMUX2_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX2_THM)
+#define PM8775_ADC5_GEN3_AMUX3_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX3_THM)
+#define PM8775_ADC5_GEN3_AMUX4_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX4_THM)
+#define PM8775_ADC5_GEN3_AMUX5_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX5_THM)
+#define PM8775_ADC5_GEN3_AMUX6_THM(sid)			((sid) << 8 | ADC5_GEN3_AMUX6_THM)
+#define PM8775_ADC5_GEN3_AMUX1_GPIO9(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
+#define PM8775_ADC5_GEN3_AMUX2_GPIO10(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
+#define PM8775_ADC5_GEN3_AMUX3_GPIO11(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
+#define PM8775_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
+
+/* 100k pull-up2 */
+#define PM8775_ADC5_GEN3_AMUX1_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX2_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX3_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX4_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX5_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX6_THM_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX1_GPIO9_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX2_GPIO10_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX3_GPIO11_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
+#define PM8775_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
+
+#define PM8775_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8775_H */

-- 
2.25.1



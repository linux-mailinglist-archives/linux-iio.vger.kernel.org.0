Return-Path: <linux-iio+bounces-7537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0992FA75
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1721F22D50
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCCF16F29A;
	Fri, 12 Jul 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BxDa6o6O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8B16F27F;
	Fri, 12 Jul 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788282; cv=none; b=APBGx8DWk6k6JtuVYy5y2ueiot2zpcs2nLAMr0A+AJkdckvqBdKH/LeMto1k/wN0e179/RjvY/7/BTRF4/eSiu0VF5HkOuwvAxdlVseSStSZ49eZxU3tN22UJ7UaB2PIvci+Eic4anpxZcMfyYQ73hAQxOt36QsHk1aBl5zKwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788282; c=relaxed/simple;
	bh=I5R1YpFLj+1xVYcaR99oDalOPncEZz3IeFWnwO2V47k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cd9Sy8H1l8GeZPJ22JOrFkGHc1oF0dvLXbe+AHEkbyi3OFFaO3i9sMaOdc9Ikq3wMFHBRLoElIc4PGypVSSUK8+4jI7tp1BvLkgNsXEYG5v4ge15YWbypY0Dvdt0+v5Lnp0V9k63UZkaPYRO2Zy3Na/XjUoH8aWuookKvcsJUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BxDa6o6O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CBtih3013618;
	Fri, 12 Jul 2024 12:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ExS2aQcCxlOn2cHmjv/Q2j
	FpscdVVqvTa6wl372FPoc=; b=BxDa6o6ORxJZ7Prxz4hRTOiJiXqgxPHWe3O3oo
	ssnvo7Yhz6Mq+ed8Bfa1TC7Ohbm3v9F0L3s+yrak0RyF/LlnmAMMNUKPvFiMBqho
	Yg4VNQ3sAeWYd4yYAeh7eMdwIqYzA6SExYFYIw+hcx9wDz/a6UYLJ85muKMvEQ/Z
	k3AS5JHtcHoMlOYjPtPrDYacSZul0B8jlaJtctrNXHFObMGJAs1j3E3U7B1Rlrou
	pjEfk+RQEf0eSiEC6hgmV/ky3SPvXCYypjdg3OoAqD2mYZC13aN03NmpKP2i4alu
	wTRKEGXxSRDjXYwp5vAxAH/CoQHg07RmLT9r+ACTGbpCWD/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwy8y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCiI0n027789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:18 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:11 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 0/5] Add support for MBG Thermal monitoring device
Date: Fri, 12 Jul 2024 18:13:27 +0530
Message-ID: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAkkWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3dykdN2SXN3i0oKC/KISXfOkpDQj02QjE7NUQyWgpoKi1LTMCrC
 B0bG1tQDcKmf7YAAAAA==
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
X-Proofpoint-GUID: m2t4KPvkXn9t08N0QXNbFsbzk0LB8Xia
X-Proofpoint-ORIG-GUID: m2t4KPvkXn9t08N0QXNbFsbzk0LB8Xia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120086

Add bindings, driver and DT for the Qualcomm's MBG thermal
monitoring device.

Please note that this series is dependent on [1] which adds
ADC5-GEN3 support.

[1] https://lore.kernel.org/linux-iio/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (5):
      dt-bindings: iio: adc: Add ADC5 GEN3 Channel info for pm8775 PMIC
      dt-bindings: thermal: qcom: Add MBG thermal monitor bindings
      thermal: qcom: Add support for MBG Temp monitor
      ARM: dts: qcom: Add vadc support for pm8775 pmic on SA8775P
      ARM: dts: qcom: Add support for MBG TM for pm8775 on SA8775P

 .../bindings/thermal/qcom-spmi-mbg-tm.yaml         |  63 +++++
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        | 210 ++++++++++++++++
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 269 +++++++++++++++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           |  42 ++++
 6 files changed, 596 insertions(+)
---
base-commit: c27723304c1f6af79f7bece5edacace6a8d46167
change-id: 20240627-mbg-tm-support-7bbf25c246e1

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>



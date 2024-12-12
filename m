Return-Path: <linux-iio+bounces-13392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E809EEFD8
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A6E28AF4E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC0239BCE;
	Thu, 12 Dec 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PMDnBV4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E4226532;
	Thu, 12 Dec 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019929; cv=none; b=Tk8JpfjHWAitchmU5hqztQCBNyxPdOI5QuTQMc6kalUHA0nuxF5W1uPtIAM/9j6i0ldL64rLgvZtv+goAkXDrUDh/DuC3nu1gwypknDaGK0lbeY0Rl58OZUx6oGmmlZoVcxQKcddMZEm2kHwv6fajuh3+kb0fnL06us5vP1Xa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019929; c=relaxed/simple;
	bh=RKc9q4oKaAiJ0fpk+jm2ftDm2OoVeMmUiUjy2iExZz0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=DkA6Dqrs9YENT3H14RiVMAFCEMNm9qpxafMCtlKq4XoXK4d2AREQvH0pm1LCLJvnLQCO4s5f2wusRcmJqsWuQ/kOGVnwiZhjI0IJhgBPBemlim8BdFd6MTvr+cBD/cJhYMbVnhrAXxFEhPuvlQocUet91wTcHL6tVbnHgLqWFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PMDnBV4D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7Nkcv002102;
	Thu, 12 Dec 2024 16:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W2+8YHoW4dDCQrhVebO9nH
	g2s/Njlc/0a0q0Md0QYtE=; b=PMDnBV4DczRNrTffvhl2XwPy+l55yXOfx8/FC3
	kBBFMebzwQRMeSGbzYw0zryyBPNLEsIHcVInT8CRDukGweJoN8lgttHvBMUby2oa
	pVDjbGhTS0IkDd7FFpdFBUMHt/nXwfQ6HQutxCiQupzlMK7LkoLdTFZ6XpXIREWr
	zhk01uGroxhw9JuJ1OzTPmuo63tEns+B6t97JSazPIy0QMgDVRyibxFYd1iIHbn3
	5sjKnBQTS1HQdDn/AFz/p28Pei0W0C3hXEkrQ7Yvsya39doEUl6E0S16+EHDVT/Q
	ttsM0Fxgl1dRardKxK5wZOvLjH4FNVxcuQaeKq/HpwEWpTdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f0r9x04t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:11:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGBkdW027145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:11:46 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:11:38 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH RFC v2 0/5] Add support for MBG Thermal monitoring device
Date: Thu, 12 Dec 2024 21:41:19 +0530
Message-ID: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgLW2cC/y2M3QqCQBBGX0Xmuol1nSwlIgh6gG7Di3UcbS/8a
 VclEN+9xbo838c5C3hxVjzk0QJOZutt3wXQuwj4ZbpG0FaBQStNsVYZtmWDs0Y/DUPvRkyTqqb
 YkKoOCQRpcFLbzxZ8wuN+g+I3OnlPIT7+n1a8N1s8j85MbJQhRiEdI3GdYqmOCZ4kU3FGStXE1
 6Cz7XjPfXuBYl2/93/Kd7oAAAA=
X-Change-ID: 20241209-mbg-v2-support-63df41a40d53
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
X-Proofpoint-ORIG-GUID: 4jpDfv5AIGJJ2tZBPSDBwTB89Be4YD90
X-Proofpoint-GUID: 4jpDfv5AIGJJ2tZBPSDBwTB89Be4YD90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=840
 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120117

Add bindings, driver and DT for the Qualcomm's MBG thermal
monitoring device.

Please note that this series is dependent on [1] which adds
ADC5-GEN3 support.

[1] https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (5):
      dt-bindings: thermal: Add MBG thermal monitor support
      dt-bindings: mfd: qcom,spmi-pmic: Add MBG thermal monitor ref
      thermal: qcom: Add support for MBG thermal monitoring
      arm64: dts: qcom: sa8775p-pmics: Add vadc support on SA8775P
      arm64: dts: qcom: sa8775p-pmics: Add support for MBG TM

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/thermal/qcom-spmi-mbg-tm.yaml         |  86 ++++++++
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        | 210 ++++++++++++++++++
 drivers/thermal/qcom/Kconfig                       |  11 +
 drivers/thermal/qcom/Makefile                      |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c            | 245 +++++++++++++++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           |  41 ++++
 7 files changed, 598 insertions(+)
---
base-commit: b4ba0e91c6f0de7bebe1b9d209bebe9bd56daa42
change-id: 20241209-mbg-v2-support-63df41a40d53
prerequisite-message-id: <c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com>
prerequisite-patch-id: b4aee2e3887f478bdb7ef86519d4e2233a7e8600
prerequisite-patch-id: f1a62cf8dff80669a7b2cac238a033e92853ad38
prerequisite-patch-id: bc6d5a0b2448ed92c77ba0b13fb211ee605b58c7
prerequisite-patch-id: 80bfefa75a9ee0440cc6ad195e424e71bf3c91e9

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>



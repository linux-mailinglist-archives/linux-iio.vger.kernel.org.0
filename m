Return-Path: <linux-iio+bounces-13394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E153B9EEFF0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A69728D595
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664E23A59D;
	Thu, 12 Dec 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G+iUBLpN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A323A57D;
	Thu, 12 Dec 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019942; cv=none; b=rcLwEKF+b5zzVzChZ6x9gUa5F1V57/Rq7oIZGoApGPMjsS/tCtagB2wUIXENEmXhnPdIiZKfUroi6Ggx6g2/jYMtDc8zfA2Hg178SCXPExV+0ujfnonlwP/rbvj8BtG+8XlPNqASvjH3uTedyOXBfAjxniBV4K9xN9K2f423Upw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019942; c=relaxed/simple;
	bh=1TMME1kP2hfu/YZ05jUvk6Ycg32OMzIFV/Y/+2IkH60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JyTB/G28xWUk0SHiHkGmIXPG+3of5Iobloexoxa7W8mg5LXW4Gockrc1Y6cDS9QRs3aKd4N0c2foe3aTDAfFaHXtpeX5odqgNsab2RmwnGp8KAz938XeajecLfaIAiU7rOYA8o6JvOiltn8KuHOLOX8fx8NATPSKL3FAOgZWPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G+iUBLpN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCG1a4j015027;
	Thu, 12 Dec 2024 16:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ulvd3+cRywO2XnoW+tg4pqeltZkcuC5gOOFgXhwnpIE=; b=G+iUBLpN63o/XFSS
	HPGTM/UFust953igbTiaQoMcopRqJ9Vjh61xXzJC4BV4WJ0mrLNlbnxjKl9rhhjd
	eFDJZgoCV6lloCvVuIuF7Ws29Hd9rvAUrAYcpNzvUtcPx5JvSM+L+XxLEhpE1itc
	mbeGDtQAHOQVfKez+zrypY0KcO5P7WJiJbcl/9+t/ndYh/BWKw1IcEMN+GNaieY6
	IaAp6cpLBqQoahyuHjw+olaGJ1jt6FONcUS0nnbsdAGRtNAJwQcXlTRZ74FhFflG
	1fTWLYF7kX7t73LuyJ77GFcs8rkq0RXWzqXy/VhPxJy/1LUzykbcTOShP9RU5sXZ
	ug1zQg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpmtp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGC1Sj027258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:12:01 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:11:53 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 12 Dec 2024 21:41:21 +0530
Subject: [PATCH RFC v2 2/5] dt-bindings: mfd: qcom,spmi-pmic: Add MBG
 thermal monitor ref
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com>
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
X-Proofpoint-GUID: z1M2RHen855N6H25jugvgAbqhRmYxeNJ
X-Proofpoint-ORIG-GUID: z1M2RHen855N6H25jugvgAbqhRmYxeNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120117

Add reference to the newly added MBG thermal monitor bindings.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 11da55644262fada1bcd215943078330332156aa..3a1acb658960329e881d67e264d221764bcec57e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -209,6 +209,10 @@ patternProperties:
     $ref: /schemas/leds/backlight/qcom-wled.yaml#
     unevaluatedProperties: false
 
+  "temperature-sensor@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/thermal/qcom-spmi-mbg-tm.yaml#
+
 required:
   - compatible
   - reg

-- 
2.25.1



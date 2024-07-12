Return-Path: <linux-iio+bounces-7539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756392FA83
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC29282F97
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E616F838;
	Fri, 12 Jul 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RqvTvCyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEB17085C;
	Fri, 12 Jul 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788293; cv=none; b=N+bNt0kWgGWBVF7TIK4TFYTW0FqkTr4nsQrbSBtQIwyTgD/jySSriFglaeBohPit0KlH/RhRx5N1JBNZXLQRTW7y8zjqcEHs4WzUTlB3jHn40cZ1E+rf/dGH9xD9ocruAlb1woufedKZjBWIHvILAc4JvwixF7P0wdM3ZnT42Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788293; c=relaxed/simple;
	bh=250wnUWhO7i4Ntv3rP4BHshTKI009EVQV0bDgNfGDjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KaJ2mA4jbZsWBOKWrn7I/+9VWhMY31Q0c6NLq4NxoThIYsjXmvbsimkUUW2bnluSgGjTrdBOgzYiyOf0KoyJcRaIsheH+Jq6wbipuEFCZf4T04EgaAo993FMpudMKhgfoPEhtF83vIwOeditBq8vyzUK3Trr7mzEbVortactA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RqvTvCyZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C42PPt014055;
	Fri, 12 Jul 2024 12:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DTgoapDolPEDLSpj3zMasvqpzCe2tZ7FI7Phe2759dk=; b=RqvTvCyZuHw1Dgv9
	ddJIerxbYfD/FeVV/UWPlFyI5MB4Tm2f90rlaf1dHPjbrXezyTVhAuOwASLP326b
	t8KQZJjWJTzykSUP1zFUzOmQSa7ltpCqlN/54TuE3BYmLRRIDVPP0D2Aiub7GIFb
	KYYxEW1OgGDOknmItk6rq2BDMO3xnu9dytnLdATICgcpCiuqTZ4Wego3K8ohGFMF
	TURYozmipojK5o7xp8f++1DBqHsqXdYKJ80MsAKuPOuHobnuMq1RVsd4ftyVOAR/
	oJ4ANTNgBFzV5KCfET3d3v5vF8mAXRFPMnHFrpCedW4wSQF3bxkx1XQI/o0v3CfL
	8+26pg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409vydwghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCiWMP008379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:32 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:25 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Fri, 12 Jul 2024 18:13:29 +0530
Subject: [PATCH 2/5] dt-bindings: thermal: qcom: Add MBG thermal monitor
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
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
X-Proofpoint-GUID: Ji1j9zfevDxypHmgOoOtP1WJ36S28lpH
X-Proofpoint-ORIG-GUID: Ji1j9zfevDxypHmgOoOtP1WJ36S28lpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120086

Add bindings support for the MBG Temp alarm peripheral found on
pm8775 pmics.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
new file mode 100644
index 000000000000..9b6d1bc34a11
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
+
+maintainers:
+  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
+
+description: |
+  Qualcomm's thermal driver for the MBG thermal monitoring device.
+
+properties:
+  compatible:
+    const: qcom,spmi-mbg-tm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    description:
+      IIO channel specifier for the ADC channel, which reports
+      chip die temperature.
+
+  io-channel-names:
+    const: thermal
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - io-channels
+  - io-channel-names
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h>
+    spmi_bus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pm8775_sail_1_tz: qcom,mbg-tm@d700 {
+        compatible = "qcom,spmi-mbg-tm";
+        reg = <0xd700>;
+        interrupts = <0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+        io-channels = <&pm8775_1_adc PM8775_ADC5_GEN3_DIE_TEMP(1)>;
+        io-channel-names = "thermal";
+        #thermal-sensor-cells = <0>;
+      };
+    };
+...

-- 
2.25.1



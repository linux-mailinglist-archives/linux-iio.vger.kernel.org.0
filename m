Return-Path: <linux-iio+bounces-13393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441099EF0D6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99357171AB9
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AF23A1A3;
	Thu, 12 Dec 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GURF4VEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068F226532;
	Thu, 12 Dec 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019936; cv=none; b=Th7bVwd+YHlDnpZUgbUDVkwGfRBd803xUbmiWzXhTR/dS39fkSU2DJxYS3/qcpnXsCu//0TBW2OnqVjpD1WXniMdIZnwqCCjoicG3IPFkC6oErn0v/8sgfg5f1XHvLCKH8JIzv4nIEy4HgzxyrgQ4eR6+ql9UcE/5dVfd0z4UaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019936; c=relaxed/simple;
	bh=rd8fp4VsV4P2ptymQhw3Czw8pNECLpb/dwGUWYs4XKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pTluiBJvC+8U98Y3avj9aRiizOGERPq8cMYoyifAQFbfl9ufY9mor6ZhSJBVWc5UYXVqAnNv0Mw+HDMzk5iR39cetLXsE6QU+aeUAln91ah9VvBQKL9VLVvV4OTy2PBBLRm+5pt9JnRXB3GXWLy5uXlaiq9lCyKpm2/F+F7uQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GURF4VEB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCwg7i001149;
	Thu, 12 Dec 2024 16:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuIkjDGpJhJYcxij2AvgiY7SW1AjlBtYi3wg/so3dYU=; b=GURF4VEBlaxQuIsv
	46I4/FUurh2jAynoqg6PMu+Kpw2Ey5drJnybctP+j1rJF6UKMMqX9+ZL9qTGoBvw
	n5x+WWvBknlhdnPpkIOQwrcSobPP/e67rr4+UDBxRhCJOw+529QS4jAxaffUgt4a
	pWneim79xZm0dOREbEmSU14EAzdpVxw5niUpxSuNMmZHFOgMubM+iLTBg9WPbgNb
	ilNtXxeGp2HihIfoDJGA/eAxLFHVSILVzaPh/RHDF6PuQu2hxim7rQJS7XVkQVHd
	yuB3q2FHgr8Hj5sdWuzlkgD+DN2I6XwobXYLwk/6UCAhnWftKKgusZ57vRtDj3wE
	qWvTqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes21hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:11:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGBrSC026023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:11:53 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:11:46 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 12 Dec 2024 21:41:20 +0530
Subject: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
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
X-Proofpoint-GUID: fCpaz4gR5quQb4vlL5VxYxuuN3mmoKNV
X-Proofpoint-ORIG-GUID: fCpaz4gR5quQb4vlL5VxYxuuN3mmoKNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120117

Add PM8775 ADC5 GEN3 Channel info and bindings for the MBG Temp
alarm peripheral found on PM8775 pmic.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 86 ++++++++++++++++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 41 +++++++++++
 2 files changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..909373eb758e4a8b7c2bbd0022c56ab2e823ca13
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
@@ -0,0 +1,86 @@
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
+description:
+  Qualcomm's MBG(Master Bandgap) temperature alarm monitors the die
+  temperature and generates an interrupt if the PMIC die temperature is
+  over a set of programmable temperature thresholds. It allows monitoring
+  for both hot and cold, LVL1 and LVL2 thresholds, which makes it different
+  from the existing temp alarm peripheral. The interrupt comes over SPMI
+  and the MBG's fault status register gives details to understand whether
+  it is a hot/cold and LVL1/LVL2 violation.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: qcom,spmi-pm8775-mbg-tm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    items:
+      - description: ADC channel, which reports chip die temperature.
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
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmm8654au_0_tz: temperature-sensor@d700 {
+            compatible = "qcom,spmi-pm8775-mbg-tm";
+            reg = <0xd700>;
+            interrupts = <0x1 0xd7 0x0 IRQ_TYPE_EDGE_RISING>;
+            io-channels = <&pm8775_1_adc PM8775_ADC5_GEN3_DIE_TEMP(1)>;
+            io-channel-names = "thermal";
+            #thermal-sensor-cells = <0>;
+        };
+    };
+
+    thermal-zones {
+        pm8775-mbg0-thermal {
+            polling-delay-passive = <100>;
+            thermal-sensors = <&pmm8654au_0_tz>;
+
+            trips {
+                trip0 {
+                  temperature = <115000>;
+                  hysteresis = <5000>;
+                  type = "passive";
+                };
+            };
+        };
+    };
+...
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
new file mode 100644
index 0000000000000000000000000000000000000000..33f5454367777b10fda248476a0abd17da86ecf6
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h
@@ -0,0 +1,41 @@
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



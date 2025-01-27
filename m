Return-Path: <linux-iio+bounces-14618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CBA1D921
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EE118874E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9913AA2F;
	Mon, 27 Jan 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B2VcWm62"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B9747F;
	Mon, 27 Jan 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990754; cv=none; b=Bk7Hiw3dlWuT+IRKoylfVWxyPTpyUYRNkxCVsA+U+ljrQGj3h6lvwWbi3RSOi/cYKse+iTZn5HlAvGpbLu/WHxJRCkWsOxhAkdBpK+2dCXIWvZCcNxWeosK3AEl27/eQn0oSNAVELJCD5pbVBI48D5sYNWxAMYoF5W/ezX3p+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990754; c=relaxed/simple;
	bh=M5t2z94nIqTZzv1T+XcTjXfbnmDtgX/YLY0wcisK3ZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkilja5FSlv32DLHb5Fa7PpNtG1VccQhmm5eacnlJtYWpVIjNUp/ja0nwy82Tirifz7gjSzPIvhPlYI2Iz8HBXYaS0CfnTl2auPnvcoIhC5eRjgzKkCW6++tvcylJgRcKBZYhfBK5rBaLTtYlROT4YgS60sRVEcedgQaC3FjXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B2VcWm62; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDA0Pb005719;
	Mon, 27 Jan 2025 10:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mRkzD
	2a4IZ4zBZ34qLpIHDy9+iVbJIuaOVxCQbycr1s=; b=B2VcWm62xLhq3hZdD8caG
	ho22GfnGXO5Z3fKFjDsiyD34f5fG/VvBJAdnVfa2rhz3CxQYM5zqiVoZPCbb1DxB
	EbWNiQd6jg9uM4VjCWwiQ7JsVMUFf7h9fuPz8Yg/fKtTEhTu/t+BUK2o8fU/FK91
	CBw0RebZEHoq2fV8Qx1APHb4jJDsO1z7nZYwzpqvDDxpf5lp12sssW81oTlmZWIF
	hDKkzPfaPBGDcAXx8h17XDEjrOA14rP6CKpOm+z1M3dejinh73oDXvEjpqa4nDN9
	EkoTmccjjbADiDEk9DZZnLYvw1UyDSL/g8+/qlzS/nsci2JsKp6ZD/XKTozu5sqn
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e0qwjqbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:12:18 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFCH6J011025
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:12:17 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:12:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:12:17 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFC53N008403;
	Mon, 27 Jan 2025 10:12:08 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 04/16] dt-bindings: iio: adc: ad7768-1: add VMC output property
Date: Mon, 27 Jan 2025 12:12:05 -0300
Message-ID: <e17337bc3b0f2e95d3d4f7b6daa7755881e11fba.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Xn24c3WgnxXIF78n0Z8YaCXR3SumBz4B
X-Proofpoint-ORIG-GUID: Xn24c3WgnxXIF78n0Z8YaCXR3SumBz4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=807 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add adi,vcm-output to enable the configuration of the VCM output
circuit.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* New patch in v2.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml           | 10 ++++++++++
 include/dt-bindings/iio/adc/adi,ad7768-1.h       | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index da05c8448530..e26513a9469b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -59,6 +59,15 @@ properties:
       In the absence of this property, Synchronization over SPI will be
       enabled.
 
+  adi,vcm-output:
+    description: |
+      Configures the Common-Mode Voltage Output. The VCM is provided by an
+      amplifier external to the AD7768-1 and can be used as common-mode voltage
+      by the ADC. There are 8 output voltage options available, and the macros
+      for these values can be found at dt-bindings/iio/adi,ad7768-1.h
+    items:
+        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
   reset-gpios:
     maxItems: 1
 
@@ -132,6 +141,7 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
             vref-supply = <&adc_vref>;
+            adi,vcm-output = <AD7768_VCM_OUTPUT_AVDD1_AVSS_2>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
             adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bindings/iio/adc/adi,ad7768-1.h
new file mode 100644
index 000000000000..469ea724c0d5
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ADI_AD7768_1_H
+#define _DT_BINDINGS_ADI_AD7768_1_H
+
+/* Sets VCM output to (AVDD1 − AVSS)/2 */
+#define AD7768_VCM_OUTPUT_AVDD1_AVSS_2	0x00
+#define AD7768_VCM_OUTPUT_2_5V		0x01
+#define AD7768_VCM_OUTPUT_2_05V		0x02
+#define AD7768_VCM_OUTPUT_1_9V		0x03
+#define AD7768_VCM_OUTPUT_1_65V		0x04
+#define AD7768_VCM_OUTPUT_1_1V		0x05
+#define AD7768_VCM_OUTPUT_0_9V		0x06
+#define AD7768_VCM_OUTPUT_OFF		0x07
+
+#endif /* _DT_BINDINGS_ADI_AD7768_1_H */
-- 
2.34.1



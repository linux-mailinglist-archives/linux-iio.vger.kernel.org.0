Return-Path: <linux-iio+bounces-17961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1353A8628E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2018A1BA66AA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC3215F56;
	Fri, 11 Apr 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uVmdrZVK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7A214A93;
	Fri, 11 Apr 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387039; cv=none; b=nON3ghbXtD3HlYtC0oNbaoRAflN65/yFitbMJEcjBGu7BQUD3/1N6ExEGOEbBRJr/8EHad/bskebPuvywjLddNOnX7y9+aFwpLF34cYJroyk8B/bVoRHKMcIG+qv628i2uvQIKbrb8n+7rkUrbB0L8DdqxysC+ELe1iagovQGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387039; c=relaxed/simple;
	bh=DObl033uAjx3ZpR/wa7AR6FhFXRNRjv5z2Xbi6g4+Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oes37T29AvmX/lsd0IaM3YMUrrz6Sa9xuQcpaUocAgFQTLfZiIYwjmR8Sw3VAbacSMAzvx36bMiV/15mWsePEURBfrx1TBRm1OtmitMPonNHpmyhPe1C9dKN5DvKeK/oKmsW053c3Hoc1TwDDdVLzJcsrk16XsSGMSeUNDP3i8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uVmdrZVK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE9mv7002014;
	Fri, 11 Apr 2025 11:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zOTlz
	Vps1a848DaLzf0lvYpcdF4YBIy8MlQl1y1QW7U=; b=uVmdrZVKCKA8sibR5WdVr
	37n+lIzJIZOCBme14YPQa12O9utsdTwOPyyWYXM5XexM4H8nVp4UAX3OXiQCOq33
	J4JG1YScgrhiE904WVXZBOViijT1p7059yS5ozbzWrSdpBYCouo88E6ojq9lC2VR
	CSNvoasrYmY68mwnJ6F+7jRR4u+oNRogVOywz+I5Px4w3BWAcL20QIZS2zv/Q0UA
	Il88KV9NdGMJacub4aJh+pX6c8jwiXQVXi/xNMPd+Xzu1oj7aTbJy9g24rsy2M/g
	gfZPqY+mlYqvJW0m+NiqTweVZMneMoBWMgZGdXLGgUVauWJESdXhvJaum8t2txVG
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp16vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:57:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFux6k022234
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:56:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:56:59 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFugpk015446;
	Fri, 11 Apr 2025 11:56:44 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v5 04/14] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Fri, 11 Apr 2025 12:56:42 -0300
Message-ID: <82e1fcd3368bca410bef01c7888ac7a73131a646.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8oM4U9MghfXgvVwXND_P9J0cT5kxrs6T
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f93bcc cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: 8oM4U9MghfXgvVwXND_P9J0cT5kxrs6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* removed `regulator-min-microvolt` and `regulator-max-microvolt`. 

v4 Changes:
* replace "vcm_output" property name for "vcm-output". 

v3 Changes:
* VCM is now provided as a regulator within the device, instead of a 
  custom property.

v2 Changes:
* New patch in v2.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 6b318f05a69f..e4c433b16e55 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -70,6 +70,19 @@ properties:
       in any way, for example if the filter decimation rate changes.
       As the line is active low, it should be marked GPIO_ACTIVE_LOW.
 
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vcm-output:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
   reset-gpios:
     maxItems: 1
 
@@ -162,6 +175,12 @@ examples:
                 reg = <0>;
                 label = "channel_0";
             };
+
+            regulators {
+              vcm_reg: vcm-output {
+                regulator-name = "ad7768-1-vcm";
+              };
+            };
         };
     };
 ...
-- 
2.34.1



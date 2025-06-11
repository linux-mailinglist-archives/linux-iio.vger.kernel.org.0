Return-Path: <linux-iio+bounces-20420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94859AD548C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913F63A943E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A6327816B;
	Wed, 11 Jun 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rri60/Mt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207B276031;
	Wed, 11 Jun 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642628; cv=none; b=UkKu+6Knba/NYVpgwZlvUqvRE3drRdVJTw1DOhiRInGJxUyNrKMk1iFjOxiY1YKLJJ9yjbDdwD1qItPZKpZZ0h+bzJcPAo6rwCNxyDFcbRcJMGGW0fLuiZ4yO+gp8EW813BvSA6yM1ImcG8IueInPLu3mwDGAfndJIPE9r+c7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642628; c=relaxed/simple;
	bh=6wXPj3k7F6zPNEVboVly1kgYH2wpBaD9UWJd1/7Ypd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHbWrcbMSif6yByQp/3u+bTJFGut3sMbOSoJaZxViSv52UnKzOa3Njtn08G/E8+SkC0rVOrZGcamVWwvJM1HT+8JtnthdjHj4NWAjSJiI0NThvHEyzY5DeWf4xI9TtaQ7wdXax2A43a6hHJTQsFRKljvmlNHcLNLH3fjsb17BKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rri60/Mt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B91jv9016819;
	Wed, 11 Jun 2025 07:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ghi7p
	rkueFQ4yhfBRvwyQjSXBWCykKkz9WKhbqYCnCc=; b=rri60/MtcSs6ydmN5QJ7p
	S2jph5v61KUhUA7TytNBiE4jBjqkhfeLAyqLCPfScTHgCsx5pp458rx+YiVTflYO
	CB4YEasZyeLnp5IGDNBnWUpNJ59LkUsiCs4DQplZwqnq4N1b9JAFLwXrrTUfuy8w
	RAnuJaP0lrF9WkqgnT9B8DWrw3sMEG54fznQuxUb2kBloRLYJlhpNJBQxgy8Qjpn
	uNLVlWApuT/4dhncfW302QVZ2tggH0fUTgLLlSvGC9Oq98cBq4Jvn0+HcnA6sYaZ
	UMyyf0/UuW0hr0KQvY23xJGS+FjlZUTtuAwlK1MTrQnePeNjS8lB2eXdq5nah8wd
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4776tdgvn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:50:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBoIoZ031452
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:50:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 07:50:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:50:18 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBo2Z4008904;
	Wed, 11 Jun 2025 07:50:04 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 02/11] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Wed, 11 Jun 2025 08:50:01 -0300
Message-ID: <33c02a1fb9d839f62da5237f9476ccbf14271b6d.1749569957.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749569957.git.Jonathan.Santos@analog.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QSzX3iNm-04LBHaDBkpVcdBA4DKKaoXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMSBTYWx0ZWRfXyUpNugzuY5xA
 CCKpncPXTJTT8RCYpoP90IXUqsbwoAmrqcj21AAl+jXaWzhCnITSYRqE27gEH4uv93/V2/jC81X
 sGVEMMfFxfLDY1i2yUsfTSRaJd6YHHDizBppsII3XUxNBF2bGlLktIwaIBUk5Pt0fSJMeVoC+uV
 H582XU8N6ovhm4oUY+KL559cN1ePwOZ6o8R6RSdsYu8fpFcmQ5njtRPDh69AZF/lmCSMsdzQldv
 TNP3JHJE9CsDCARN53py+0m6H50QO2LEfplzFCHAftYuniVEVVGZ2f8vNjCldnlQm6ZdKSJ+N/8
 AFJFiZuYDssbvU3cQ/zuaP+/J00QvrM7yxWGKKBxkTwH1MYQwgMeQaGlDpnCU//tz5ywzi5BSvv
 aMEidk8KVCewm2B2fYDlPJDsjD7O5p/bBHz9TmGumNzGIsnikqcLvZeDEMjwqWc51CoAnY9F
X-Authority-Analysis: v=2.4 cv=BezY0qt2 c=1 sm=1 tr=0 ts=68496d7c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: QSzX3iNm-04LBHaDBkpVcdBA4DKKaoXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110101

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* None.

v10 Changes:
* none.

v9 Changes:
* none.

v8 Changes:
* none.

v7 Changes:
* none.

v6 Changes:
* None.

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
index 3ce59d4d065f..0e651820e2cf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -47,6 +47,19 @@ properties:
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
 
@@ -120,6 +133,12 @@ examples:
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



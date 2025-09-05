Return-Path: <linux-iio+bounces-23796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D1B46032
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F35C5CE9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032F371E95;
	Fri,  5 Sep 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QDUyiGVf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9483570BB;
	Fri,  5 Sep 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093572; cv=none; b=ox+Ag9I0LN250k873zknapgsWLTbBELRFbIi5NjjJO2Pcw7BC+oaxqO61LAYu3M6uhM0ziSMxZWlMAXKxzGoQlGwtofM8PMjLlbXLTpApLS0cA9LLzG6uXfnEfYx71l4loU07bAQnp1X2lD6K59khnTpYxJgFyZPzyPHFCkZmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093572; c=relaxed/simple;
	bh=mV4eTZc8oepfDI+CJWOMfSQdmOLvwHO5xmmggDr4zVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTbfabDQTBJbQRQmTte4BfGVMtdxfiYeYKsvPh0gWs/bJLAzujGUghhiVOZyxe2gG9QnYpZo3smiJqaWLXpoIV/qgl7xwXV1uLAiwxpXn3/SglPp6bbgRYNZg/CUYIqDRr4X6flIbhESH/vhVk9r972ehLregtva8K3654qpBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QDUyiGVf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585EsNYt031276;
	Fri, 5 Sep 2025 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hr4Xh
	Ra3laBfxkfZWPivJf9gY+F0BJGTnBiw/aE3HT4=; b=QDUyiGVfEinbfyRaHg7UQ
	K34l8DHPjpdhR6HnfT/2VW3OuozMQctGrmC1q2vpsXN23icQ1vw/wxeZ9Gt+zw5E
	CnRso2q6a+o9W0+qP/fTtbhZI14t6RSrP3LWWcjoQbPQwIdyXhZatZ3zWAM1Q7RR
	EFVRJrRUvG2j3AT8gmSMsRdSU/CFhbVSvm65u2YC35liAyj+8gy4J0MZXp/N/iOh
	AQqO19T8uPZJJJQzMaEMv5yteiY04qKBzbCFaI3kYryA/TQGrZyP6fIWo9tE096z
	d2vnQfDf0pQuSDcJ+l8h17RpyKBkHKMdTTikpnPS6ES+qdRN8QkWEc+EOijVlDO3
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48ypq4up97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:53:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 585FrEoa063282
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Sep 2025 11:53:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Sep
 2025 11:53:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Sep 2025 11:53:14 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 585Fr1E9020477;
	Fri, 5 Sep 2025 11:53:03 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <jonath4nns@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Fri, 5 Sep 2025 06:49:11 -0300
Message-ID: <46842d4cf2c1149bd64188f94c60ce5e4f3b2beb.1757001160.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757001160.git.Jonathan.Santos@analog.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oBoVmeeZ6BDZgRd8NbGd2qPnkT4jemLh
X-Proofpoint-GUID: oBoVmeeZ6BDZgRd8NbGd2qPnkT4jemLh
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68bb076b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=xlXPN06Ycv5ZlR7zcHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDAxNiBTYWx0ZWRfXxelUjDlwVzQb
 ZpxtTfI5hT0d6JFRMPWcTgUyKP7xqAkSJtZGJ5kO1VLxY7xa03CZMu2l4XKJhkI1lcKDZsBx2xa
 PzHMEzOmhEUxlDZjiWYRF8HkY3awg4hsyRCe7HPJMGaVoa892xno43ZlADlknhJYWFUB4R5Pvdm
 8CF9l2BuvGvheMgUjSjy54SZG/tHc2nj/lYuNoZBiERngdfSHn/UG+LsG20gy27S+jzDMqjaN/C
 U+7VtDMn08AajyFcIxk/2evaqEZmiILSD/buSsLWPi9MfUdt9Gch8LYYxZa9zYmN+oUOVO3BvYr
 j0CKCHBpZwlMeLdbuCbyfd7NqqHGH2F10apwyE7Wd/XPAJHDxrEUJKMSrOdbzF/MImyNnlh+PU0
 RiHYgQAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050016

Add compatibles for supported parts in the ad7768-1 family:
	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1

Add property and checks for AFF gain, supported by ADAQ7767-1
and ADAQ7769-1 parts:
	adi,aaf-gain-bp

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Renamed adi,gain-milli to adi,aaf-gain-bp. Now it represents basis points
  (one hundredth of a percent) as suggested by Krzysztof. Description was
  adjusted.
  Note: permille (1/1000) was also suggested as unit for this property.

v2 Changes:
* adi,aaf-gain property renamed to adi,gain-milli. Description was 
  simplified.
* default value add to adi,gain-milli.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index c06d0fc791d3..c2ad8e585586 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -4,18 +4,26 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD7768-1 ADC device driver
+title: Analog Devices AD7768-1 ADC family
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
 
 description: |
-  Datasheet at:
-    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
+  Analog Devices AD7768-1 24-Bit Single Channel Low Power sigma-delta ADC family
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7767-1.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7768-1.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7769-1.pdf
 
 properties:
   compatible:
-    const: adi,ad7768-1
+    enum:
+      - adi,ad7768-1
+      - adi,adaq7767-1
+      - adi,adaq7768-1
+      - adi,adaq7769-1
 
   reg:
     maxItems: 1
@@ -58,6 +66,19 @@ properties:
     description:
       ADC reference voltage supply
 
+  adi,aaf-gain-bp:
+    description: |
+       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF)
+       to the ADC input in basis points (one hundredth of a percent).
+       The hardware gain is determined by which input pin(s) the signal goes
+       through into the AAF. The possible connections are:
+       * For the ADAQ7767-1: Input connected to IN1±, IN2± or IN3±.
+       * For the ADAQ7769-1: OUT_PGA pin connected to IN1_AAF+, IN2_AAF+,
+         or IN3_AAF+.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [1430, 3640, 10000]
+    default: 10000
+
   adi,sync-in-gpios:
     maxItems: 1
     description:
@@ -147,6 +168,21 @@ patternProperties:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  # AAF Gain property only applies to ADAQ7767-1 and ADAQ7769-1 devices
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq7767-1
+              - adi,adaq7769-1
+    then:
+      required:
+        - adi,aaf-gain-bp
+    else:
+      properties:
+        adi,aaf-gain-bp: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



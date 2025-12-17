Return-Path: <linux-iio+bounces-27146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1465CC81EE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A8930A1824
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123883563EA;
	Wed, 17 Dec 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jPd1+6HN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EA3563D8;
	Wed, 17 Dec 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975393; cv=none; b=ZaH43+yqC/4NIcsCPkkGDbFNlvUZk8oH610okazN4EtrU1mN7m/rMefdBf3WLNz+yjwRO+yzyVuXzFRBYyYmfWdz8K1A6u+/imviWHDm+7JBI4HmNJ9302iW4QXKPY6q2umeUPDRYY+rvRkuOHzHw+s4j3Kov15Rhf5YN6VvLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975393; c=relaxed/simple;
	bh=rvmcza1ALn2eZSqB3BpQqy5KBqH70c9JJz5f4KDctv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQPNYH2xHqblfpajQVYtTYRL0KKVxA6g4Aw0zqAqr9mWP0SgJq+MXud0bxQx9xiaRoioUc8q16LW75So2Zou2B2igWi/reYYITxfxaK7P0/RRVyoyM1A/gqYVmSpEwi9cw49Tf/idakxRmGZVczo7tmzmh4QgVzybv20bLjNDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jPd1+6HN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHBWZlt3839417;
	Wed, 17 Dec 2025 07:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PV1MZ
	vNWiGUiHgzOz6h2QIFxJb0DAZiPKRJgs5F/Dvc=; b=jPd1+6HN2mhhsFTCa2ghV
	mOe3irq+HRP/5/+fkKuGXOTB/PGYEn/hLhFjNDSyf+LApsd7ZZhqCYiwSPg9LAIj
	derT2dMIu7QIW68EJRYxChk11gxV+IVCzr4l/cIRQl0ZpOl8rdAkSDq7nvPIfglY
	TPSzlKuVlugMjL64STabf7QKRiL+CNKYBO9GUou8jdxNXLJmX3pkKWxOAGsGVzOI
	sKYyCUF9zkyYbvg19CJRYT3R+5WKhCV9AtQZzwOTX8azeVW6LulkyUprjJbXyITV
	8eHItVUrx+Ia5FC/EBCKmo917CFKHScJ14jgVhYqcUwB1ZtP0CpcMmpaL0YEczDG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jj55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:42:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCgswU043078
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:42:54 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:42:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:42:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:42:54 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCgddq015738;
	Wed, 17 Dec 2025 07:42:41 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/5] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Wed, 17 Dec 2025 02:52:22 -0300
Message-ID: <091646c482e7f0f259e199c18a8f09a35f50f1da.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX1fLErD7XDiWc
 HVAirnHFxg8dgz6jBu/29b3FurpnzCSrG07hk+Fkz7P9CdyBcx9aOFx100edWY+P+xNisB5XKG7
 laFt2kdDYVQMz9NZOfiDKBgK3xZ0JZ/CQVNITkWdi4oN5eyrlFadR4so5aGXmsvPCcThhtLmmSG
 3wAri+u6Thn3kVIeH/B14qkkdTL7zFqeYrbNPmFZreKvkx6f/THDoA5NLpORZsPuMVk9wL0AWIe
 aekJcsMPYCdFb8OpRcmj0bO92nj5hfyviYDdxZ1heakfHs3cUme14aRu8IwGbO2qFW8J1Mf3CYs
 nmTyCNpPhdvRI0K1kqBvupep+erdvnOC7d2rxL6I7zOhBP+L+ak+D+usnOss/4EzAqL2L7rDmrx
 Xyb7oC25vI1cniAwfy269cGIEFd0zQ==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=6942a550 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=W-COrTu4jwGsOlXsrW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: arOmzTq6umB8hyCzeGhZDNDts0e_qQPT
X-Proofpoint-ORIG-GUID: arOmzTq6umB8hyCzeGhZDNDts0e_qQPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170098

Add compatibles for supported parts in the ad7768-1 family:
	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1

Add property and checks for AFF gain, supported by ADAQ7767-1
and ADAQ7769-1, and for PGA gain, supported by ADAQ7768-1
and ADAQ7769-1:
	adi,aaf-gain-bp
	pga-gpios

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* None.

v4 Changes:
* Inspired by [1], Included pga-gpios property for parts that support PGA gain.
  Before we were using the internal gpio controller to manage the PGA pins,
  but still exposing the controller for external use (causing possible conflicts).
  Using pga-gpios we can let the consumer define the pins to be used for PGA,
  even from the internal gpio controller (but not limited by that). The problem
  with that approach is the deadlock described in the last patch from this set.

v3 Changes:
* Renamed adi,gain-milli to adi,aaf-gain-bp. Now it represents basis points
  (one hundredth of a percent) as suggested by Krzysztof. Description was
  adjusted.
  Note: permille (1/1000) was also suggested as unit for this property.

v2 Changes:
* adi,aaf-gain property renamed to adi,gain-milli. Description was 
  simplified.
* default value add to adi,gain-milli.

[1]: https://lore.kernel.org/linux-iio/318c31e023ebe30cc99b8743e87e869bf5e1f12b.1760984107.git.marcelo.schmitt@analog.com/
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 64 +++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index c06d0fc791d3..dfa2d7fa9fb3 100644
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
@@ -58,6 +66,25 @@ properties:
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
+    enum: [1430, 3640, 10000]
+    default: 10000
+
+  pga-gpios:
+    description:
+      GAIN 0, GAIN1 and GAIN2 pins for gain selection. For devices that have
+      PGA configuration input pins, pga-gpios must be defined.
+    minItems: 3
+    maxItems: 3
+
   adi,sync-in-gpios:
     maxItems: 1
     description:
@@ -147,6 +174,35 @@ patternProperties:
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq7768-1
+              - adi,adaq7769-1
+    then:
+      required:
+        - pga-gpios
+    else:
+      properties:
+        pga-gpios: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



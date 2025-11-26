Return-Path: <linux-iio+bounces-26500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A446C8C1F4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10B5134FBF2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E233F39F;
	Wed, 26 Nov 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J9n3n15Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE731A072;
	Wed, 26 Nov 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194184; cv=none; b=EFZlcNx16MuVwAfNJomvH1DeMS+B4E6aSUUYExmaKdTmMWfTwLAaCwbNY2GWv7cbjlg7d10RoxMNeLCSk/Df+uxxiazuJTFdFZtNPz1hT+u3V4Zx5HIvnkjmANLO44A/eiRA7FLoIa+cyOQ2ZE1sI8g78b05m1vZTuRLnZFvRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194184; c=relaxed/simple;
	bh=Coi3ZFVE227bCTzWSLuy1VnbBp3+t62LhOGXIjoB9Hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDmegzuImIA2L3i101EmHS8Isnsm6LAUcBoxn1+t51N/TiwbpfkvqcjfLakmo4Hjs6Qgtxxe+gxovDA2UM93FEBELMBHwJFG7TGqbwzsjBFLtI7Y7fQEfSErZ2POqY2sG4aENoPK3nXGPXbsyARbanotN63FNXwmn/JldnVq8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J9n3n15Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQH0iHg3402813;
	Wed, 26 Nov 2025 16:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=drCae
	m2leCMDVQEAM4Vr+y9JnoPeaF2Ep+5+ZrhAnNM=; b=J9n3n15YM28s5puHUvnlM
	AgswpXvLJV9jkg3foofxVM0BG9GK7l4VlmlZYdzGKkssjQfgLHilu+B08UYnMpF6
	7JTxD5YI8BShQBpCmo1YtHX+9A/wRJK0KX9rG2zvcmGOaSDms97VNOLZjWBF+nsh
	J0MXMI//biDvmZhmBVfJ5CELMdeJ/JPQlu9S1+MroegCewtNzS+UoptbKdhelIMF
	tB1BfUl/b/wMz3HsfQ/ES2h90A4IXV6YlVhQjI+rCqu81k1Ks5UHqnxBTw3zV8nx
	6IPz2263D7/eVtD3eZAerHALMDhx1CyniUB+cEAsGGUCuoNU2auDJypRY0JEd7i5
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4anmrux8y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:56:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AQLuGdA024326
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 16:56:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 26 Nov
 2025 16:56:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Nov 2025 16:56:16 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AQLu3Jc002843;
	Wed, 26 Nov 2025 16:56:05 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 1/4] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Wed, 26 Nov 2025 18:56:02 -0300
Message-ID: <b2c005592b9788919fd32d4e8d7346e4be98d1a5.1764101647.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764101647.git.Jonathan.Santos@analog.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OCBTYWx0ZWRfX0Z+xJA3rOWxr
 p48YsMEjicXuTKtVd8vy7zZ/atts3NoJzWyYCwFcDmcksWJsI/DRWMj9Oay3ImDM/Yn+iPF36VL
 i+8T2JIoBTmW2WR92JEcQJGTo6FkCdKEbo3dQ8HanqJOQYkDr6qL9gXXqmSzjq31yDVTmv8f+zA
 fpzwerkK6X+ZCT1HdxwsdzojYul3KTpUkLO9YEP48of36B+PuHIX3K60KTSJ24KWg1We2L9uQ2T
 EtP2ByBpfEpq98sJunb69Exg9xofbXE/SvAEjU0QKnChwdgFXvUnouWiecxg+IGghevoi+L30su
 q9B5s/itTPXw78QaQDorCW4dDHDWNBcv5C+2BrEVk56leGXD12Z+E2qBA5Gw7Rg8Y3vYM0bZ2Y2
 kMANP+uEkNglKmNzwuucfAaedJvklA==
X-Proofpoint-GUID: TKVVarviLdBWFuqvbxA5noipKCdRLWD6
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=69277782 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=W-COrTu4jwGsOlXsrW0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: TKVVarviLdBWFuqvbxA5noipKCdRLWD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260178

Add compatibles for supported parts in the ad7768-1 family:
	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1

Add property and checks for AFF gain, supported by ADAQ7767-1
and ADAQ7769-1, and for PGA gain, supported by ADAQ7768-1
and ADAQ7769-1:
	adi,aaf-gain-bp
	pga-gpios

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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



Return-Path: <linux-iio+bounces-27776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914CD1EE9A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85C06308DEBB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB9396D1E;
	Wed, 14 Jan 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="o4ymhQ1h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A891E9906;
	Wed, 14 Jan 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394849; cv=none; b=K5SYG8QGIRaVz1XMKYE/rnDzqHR2vcJ/i7HJBBLYQkQEN5S676nj0aByirqJk6NV4H0qQ7fx+XJwI+4hOjk4+miwHwAeLL9joeR10jo1Vly8LYxeyIg/VTGoP7aO1cLcqg4hvLTeRo3NSPEKDezXqd3PnidLiFTDCuW4Yak9I0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394849; c=relaxed/simple;
	bh=/aHVDIXnr9itAbftGWN9dNkwxevji0IAr7PgxJgrugw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEIwI67rZJ+0cE4FwZxkUu0o8mAjDUh+WXPPBxy2mQ+u618L0opa05ii/3dmB5niGl+vfuC3p1AdCxPsyxtqV4ygpsCwN3MT39AOIvBySPIRoqcZamq/hjCU2726LwYEbWCx7Kwm7IGOkmJ+RTpRA3zJ5pipLEpfwlsfg5lGkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=o4ymhQ1h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4i653765687;
	Wed, 14 Jan 2026 07:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wHArj
	f0L12rAIUZsT8hem0qoTjAAzWIlJC2MoZKot8o=; b=o4ymhQ1hvKKEwZqsCsz9i
	wTJX79bgTJXotUCpfif5m3sfoJNZDQA6ezgAbqStqfNvMlUkzFqt+HykeD3lV7q0
	2JTwiujXhi7I93RXA/J8V8JPM0U6wi5cSrS86IOipqQtMTVKGY4uM+6boSGoQwPA
	o+aFcP9WMTYKLfhG88laGZLHsF5DLQQqNKNzYbszrCbgTRB+tKGX15LZVv3kRhK4
	Hw329FzkzZbAvle2DhA+i6pNn2807nDBib8jaYJ9oXLt1UZ23uPJvP9KtVDWMPTA
	y8QYwxm0Uhtj029rY83EGRwTxeDPPMoW+R0t4qRzzKw9L9prPiF1iKkTCIUJxt/b
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60ECl8lv061457
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:47:08 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:47:08 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60ECkqCu001731;
	Wed, 14 Jan 2026 07:46:54 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/5] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Wed, 14 Jan 2026 06:26:39 -0300
Message-ID: <3eefef5a7f41d15513101b00db65b1f769cdcc3c.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfXwrrWnO8wNCFU
 cVo732ewyhg8lVz6UwaCU5COMYglc30+1nFsfU4md2p3iPAOTGiYQiLdT9kQXSpf0JyRRey5vcq
 btvyZnaH6/VLe6Bkj/GXcCAXE2q5Eh4U8Ddg/KvF3e2D2988jFcbsgHHJCh2ASkEnMBOUd4IF5A
 nkoIwUDyt36OFSzhCgplWfXtKut2bgwAwaaPEMN3Gp6+cwh6hLOndm4piQccOH+Wbs0XciNlFHl
 5eV728yCJArJyc2YX0TqNptoetsk7PrTb8w+CmErKHs1LKS71YhKmVfne+CzytwkWzMFp37T8Ch
 hmTyR6Tc8VTYtdbvHjuesFkFdKIq5ARYkQ8UAEe/L99LNr7PQBaAlD39psLBIjGuEjyEgN8jOec
 je1RcFMja8kPHAOUfQLACcOUbuYKkyDSF3TsFC/8z5l+t4pAaGm61kZNbecLk9S/BVUIXLqq4d6
 CrY2bQs7i8o9voRw+Vg==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967904d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=W-COrTu4jwGsOlXsrW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: g0gd2atMvcpLIHiND-ER7wpjxwCvI5Hk
X-Proofpoint-GUID: g0gd2atMvcpLIHiND-ER7wpjxwCvI5Hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

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
v6 Changes:
* None.

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



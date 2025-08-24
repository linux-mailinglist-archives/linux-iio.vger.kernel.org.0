Return-Path: <linux-iio+bounces-23172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A6B32D71
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 06:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB9C1B28594
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 04:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDD1F3B9E;
	Sun, 24 Aug 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lcgY9Lj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C001EE03B;
	Sun, 24 Aug 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008623; cv=none; b=MKx3gYumbRU6k1T1yB2jo+dZw2PuP7qqm0EUooxWyXOBxd+l8MTPZLdCYmhHwzyADIjqneuKWDRLc4jsxZcwj+mr7M0LcXyFxREG3c1JAMaTciSzYHqcFHhwfvQAjZMAUQBXjMCFrb/dNfAKVrcV/HcTP2m7V0yUCfB/VZSrLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008623; c=relaxed/simple;
	bh=mRLErS0XUvhSrs6AY9iClAE+NlhevL6Bl8BehzaiqkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdEux5xI4TjYri59LMk6dZ3kvPOz/gwTLyF/I68+n4Fku7tRwbxwmGgvmpPjODRUqXWVbhQNLAmhXiqxNYEbA5Oe7WQ3zYOIcrv8Qebexcf4BLpRc7POnQCg9cVZ6JtQdmzDT8kbKWL80ioJrICNE3gHM6uOa43gkkQIb3ArKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lcgY9Lj4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57O2gKl9007920;
	Sun, 24 Aug 2025 00:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=3J5r5SU16qXqbse1H2yFXe+Os9F
	xjDTQCFJSox98S1k=; b=lcgY9Lj4y+p+WL65hyFSBzeRSUg3lrD+RrZzbh+ntZn
	cCf03GKEP5kc/42nQyLBhyLaLyLeQILR+KqhK70Tq3obOzDe/QsBYedQl/yY8Hz2
	V5I9rEhwI/GIuLn35CJXbXdZiUD6bx0ijQZPe+QKPrA4L8dT7gxBVV46WbTo7plV
	K3Q8FHWv+YvlaF/lkaKv+bekvORaXyvOQ+OixxKx21dbmVCCtYtefOLgYrJ7mCZL
	fS0RQHcuHF8EWKbHfqHVomwxZ49yu/ywW7oyIgPnNFniy8bO6/HVPKMEO9ho26nw
	xVp5tLjzPbJGCCEsCJUrxxr1iOswcmlvQfFDWjdrrxA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48q7g3uhks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Aug 2025 00:09:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57O49wGB051718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Aug 2025 00:09:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 24 Aug
 2025 00:09:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 24 Aug 2025 00:09:57 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57O49ibE006316;
	Sun, 24 Aug 2025 00:09:46 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Sun, 24 Aug 2025 01:09:43 -0300
Message-ID: <20250824040943.9385-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GVpV1RdbswFRc6WNhUyZezvaCVdJwcVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA1MSBTYWx0ZWRfX0ZCrj8J8E0BY
 mAK2nLUqcA7lgQkmJIFu3rHq2p9VRirmNiGxS9wRiXn8QEYDqcHG6s5tnOLCmBRxzMFnut2Qwhm
 Vxa+tRu1ANGdPTVu82ps0s0cvimlhQhoAmNUtN4dlM6gJhiAB4ohfAfN4vAQ13vJaqLCCV0yYNj
 d5L262Ir4ApIm7e7lZEzbGhlIEO5z5C+dTYzzOnpPCZONXF4D/B0/qBOBpGF/+UaRXC6WXTQg3w
 +YbAADaaUtkZ+L/rlrI968DDn40XPpOCwwz6e6xjpO6vkZw29BsKVM+vTI+ybtOtRJ7qhgmWLH+
 5yeWUY78S+ScDCPl02TeV1bNl3+9AbcfbWSKRtjPiwO2mu+2Ug5MAdVoBHoLOeZwQIE753x8yUo
 Xs3eKzGM
X-Proofpoint-GUID: GVpV1RdbswFRc6WNhUyZezvaCVdJwcVn
X-Authority-Analysis: v=2.4 cv=PNQP+eqC c=1 sm=1 tr=0 ts=68aa9097 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=dspUp55KPydKJtatIUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230051

Add compatibles for supported parts in the ad7768-1 family:
	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1

Add property and checks for AAF gain, supported by ADAQ7767-1
and ADAQ7769-1 parts:
	adi,gain-milli

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* adi,aaf-gain property renamed to adi,gain-milli. Description was 
  simplified.
* default value add to adi,gain-milli.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index c06d0fc791d3..0c39491f6179 100644
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
@@ -58,6 +66,18 @@ properties:
     description:
       ADC reference voltage supply
 
+  adi,gain-milli:
+    description: |
+       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF) to the
+       ADC input (in milli units). The hardware gain is determined by which input
+       pin(s) the signal goes through into the AAF. The possible connections are
+       * For the ADAQ7767-1: Input connected to IN1±, IN2± or IN3±.
+       * For the ADAQ7769-1: OUT_PGA pin connected to IN1_AAF+, IN2_AAF+,
+         or IN3_AAF+.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [143, 364, 1000]
+    default: 1000
+
   adi,sync-in-gpios:
     maxItems: 1
     description:
@@ -147,6 +167,21 @@ patternProperties:
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
+        - adi,gain-milli
+    else:
+      properties:
+        adi,gain-milli: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



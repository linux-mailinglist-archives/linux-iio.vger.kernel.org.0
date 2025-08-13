Return-Path: <linux-iio+bounces-22639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE58B23E72
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F02F1B630FF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F92701D1;
	Wed, 13 Aug 2025 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iVYrZHDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3AF26FA5E;
	Wed, 13 Aug 2025 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053352; cv=none; b=j7dN3Y9AqWbL1WctRNEjct+egWb1AlAs66tCHREsX0ANz8JOtjYMqbeociYdVyBBLakJd3O0AWLFMYZU8WW19Xu6z6vF38haFxJF5vPXglV1ejWusBrE195jaSAQPYtVmwQEchfV5PZxPHzGxemscDYlN1EWtl0yryA5HKn5/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053352; c=relaxed/simple;
	bh=vTou+iMVv1oXroCkuilRh0VYB3hW5wVPna68CHF68To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyhdTASe5B/7xnjGmQWJ4PFQyS3WkWuHihztF4DmqPHenDY9uy+MHtOwzlspw5plyCh2Al3mX2GXD/+/SOF34G4ZdyJz2ACoHygAjLZxAvMHq/v+bc+TsgvVU2RkY0s7PlWGbdeinidDe3dchiGL1slg2dx7jyw7pPAAul+5ZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iVYrZHDG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2OCYj001785;
	Tue, 12 Aug 2025 22:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Yu8MX
	rNAehD7xYFG709ZefO1unGBSwjSRhKodaFed20=; b=iVYrZHDGnjyk6qhHEvvuk
	idzUVLK+yoph93f9yjbV05eaQSSeZx5WfYQTih4aesv4BEeVl11GnTvj6x1JLJrI
	D6pPmlqrDU6grmO37JcEta4R0fKWemzv67h6Nw1Zd9ajqcvX4BFrIzZm3VvDFWNv
	VZGpX472nKe266Co+HeRmb4Uky7oGLnz8fZS8Akiva8Q1+YTi00FdXtNE8z+1UCT
	+kMXnK9etEPxZZ5yIJKH86jqI+YL6GysdHvqZCiKBNSxc2eHPaq2I3aBjgKgHE8v
	ORIUIGGpAbeBWSIff3lKXP7dUhUEdVgeGP0A5+Lz0+9DU7mNO4X+YlENX1AmfqCq
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48fjxk893h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 22:49:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57D2mxJe056061
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Aug 2025 22:48:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 22:48:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 22:48:59 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57D2mlUP032754;
	Tue, 12 Aug 2025 22:48:50 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported parts
Date: Tue, 12 Aug 2025 23:48:47 -0300
Message-ID: <ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXxmCfV7ZZK6ky
 8P4gau8C7L+mUi0i0rcENwOnt1EowJouTVBqVOgxq8NtKBYqcMDzBDKw+rd9uEe0G3INxKxg70i
 vUYxL4olzR+hDRI8iRjwcDqmWnJAi386PLf1iL4qTw0YXqILYJ8lkBsVThnegK0es1+RC/x6HGz
 t+tkn2T80qxWKLGV9jDaVInJ0PZovMiYBHW5bcVcDXFgfbGLnzVKOsSCul5ggLuSJtc70bsZcyV
 PX4FyvfBRNWCdaazEfo2VsejKgDXfK3P8aDeu6M2XBy+0Jv89V6A43QvbHcKHDY0a8ozFG1fI9B
 e0NWAWJ60KmQX/dfcT7aEHqLAfKrJnd2Ml/ufcbP1xzgbwww2QZvlp5oIxSPYiOpb2+77TmoHqe
 sDFbLa1W
X-Proofpoint-ORIG-GUID: X4XGwbjNH9DKckq1XgcJBujRAFI5qnr3
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=689bfd1c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=xlXPN06Ycv5ZlR7zcHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: X4XGwbjNH9DKckq1XgcJBujRAFI5qnr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Add compatibles for supported parts in the ad7768-1 family:
	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1

Add property and checks for AFF gain, supported by ADAQ7767-1
and ADAQ7769-1 parts:
	adi,aaf-gain

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index c06d0fc791d3..568a85e0d052 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -4,18 +4,26 @@
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices AD7768-1 ADC device driver
+title: Analog Devices AD7768-1 ADC family device driver
 
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
@@ -58,6 +66,23 @@ properties:
     description:
       ADC reference voltage supply
 
+  adi,aaf-gain:
+    description: |
+      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
+      ADC input, measured in milli-units. The AAF provides additional signal
+      rejection within the frequency range of fs ± f3dB, where fs is the sampling
+      frequency, and f3dB is the -3dB cutoff frequency. The specific values of
+      fs and f3dB, as well as the rejection intensity, depend on the digital
+      filter configuration.
+
+      This parameter is required for the ADAQ7767-1 and ADAQ7769-1 devices.
+      The gain is determined by the selected input pin:
+      * For the ADAQ7767-1: The input selection of IN1±, IN2± or IN3±.
+      * For the ADAQ7769-1: The connections of OUT_PGA to IN1_AAF+, IN2_AAF+,
+        or IN3_AAF+.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [143, 364, 1000]
+
   adi,sync-in-gpios:
     maxItems: 1
     description:
@@ -147,6 +172,21 @@ patternProperties:
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
+        - adi,aaf-gain
+    else:
+      properties:
+        adi,aaf-gain: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



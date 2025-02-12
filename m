Return-Path: <linux-iio+bounces-15460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE4A32E4E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B167A2449
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD16261396;
	Wed, 12 Feb 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FblSIiu6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B96260A4F;
	Wed, 12 Feb 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384210; cv=none; b=sJcffIrI7S7GcBdGbqWBWW4TDbY2AdRAd9+FlwA/eF0b/JU9t62R3+1SXqAWJDM64TtILchMDgHYxtB0Nmu8og/1pcS07TslJ2i/L6yOWM6IIrDGyO94ztTF3rxAMdT49yATT+TaekJFnW13EW/v4FUP7wmxH5awkOVl8qHtsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384210; c=relaxed/simple;
	bh=cUdo0hR1SxFvHRflLbtijd5qk5QC/Bd354r6plb6MyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGNHYA4Wv8+/kM6QQwLiiEF1HIU9QUpjk0KTVCRhCkog184WyscZdi/bExatwT5OAthwemPwA6I69C8hfJi0vyMcfEH4iCkq7VRPEFZfqneDm/TouCtILaWB9g+BfrPCLOc9i1XbIkKIkIiHpQbub4vvYZVkk8CqmYw1coLS1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FblSIiu6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFAvC0019256;
	Wed, 12 Feb 2025 13:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sRP87
	Qul6HtZYSdW8p/OVdXuHInPi/VjRFG8cNBDNmE=; b=FblSIiu6BMyeD9yzgQabY
	sAh4ex1el39GXSuOzl5hOiVKYq1Nz4qBF693Pa6nG7t3/RCJxq/EIC6uxPfT4z9s
	z+aeDJ3TiyoYItvZQZs3fGnEXBOrrAuyP8CD0e2ESWmIxu8cjGbXvj6Fo7FA5ZtX
	tg5FnY1gNODmP6xarqI4lVUJ9qXscB6+ONcOLSlQwgR+sTZKU4q7wQgzQzOYIwiB
	XohPEsYtXz8UQlZWnMBVnHGXVuBIayblKVfFNcsYaO5c9E/kBMZMkTeGVMnngQkJ
	DnQ2mFOQFaaA4zr1IP1CrAAP3dg4WjSi+SuSuwWwamNQsWAEd59XpnL1hzwp326u
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44rs9aa4gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:16:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51CIGWSJ041114
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:16:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:32 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIGGeo017453;
	Wed, 12 Feb 2025 13:16:19 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 03/17] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Wed, 12 Feb 2025 15:16:16 -0300
Message-ID: <4136b5259df75221fc314bcd4a57ecaeeab41a45.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vSTJySN6VMulKdrWh5ZDPsNl3W9Hc4o0
X-Authority-Analysis: v=2.4 cv=ZdznNtVA c=1 sm=1 tr=0 ts=67ace582 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=1BXouof-NqooHmoyBnsA:9 a=ll8Ng6K2x5dEghGH17xW:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: vSTJySN6VMulKdrWh5ZDPsNl3W9Hc4o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

In addition to GPIO synchronization, The AD7768-1 also supports
synchronization over SPI, which use is recommended when the GPIO
cannot provide a pulse synchronous with the base MCLK signal. It
consists of looping back the SYNC_OUT to the SYNC_IN pin and send
a command via SPI to trigger the synchronization.

Add a new trigger-sources property to enable synchronization over SPI
and future multiple devices support. This property references the
main device (or trigger provider) responsible for generating the
SYNC_OUT pulse to drive the SYNC_IN of device.

While at it, add description to the interrupts property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Fixed dt-bindings errors.
* Trigger-source is set as an alternative to sync-in-gpios, so we
  don't break the previous ABI.
* increased maxItems from trigger-sources to 2.

v2 Changes:
* Patch added as replacement for adi,sync-in-spi patch.
* addressed the request for a description to interrupts property.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3ce59d4d065f..4bcc9e20fab9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,19 @@ properties:
   clock-names:
     const: mclk
 
+  trigger-sources:
+    description:
+      Specifies the device responsible for driving the synchronization pin,
+      as an alternative to adi,sync-in-gpios. If the own device node is
+      referenced, The synchronization over SPI is enabled and the SYNC_OUT
+      output will drive the SYNC_IN pin.
+    maxItems: 2
+
   interrupts:
+    description:
+      Specifies the interrupt line associated with the ADC. This refers
+      to the DRDY (Data Ready) pin, which signals when conversion results are
+      available.
     maxItems: 1
 
   '#address-cells':
@@ -57,6 +69,9 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  "#trigger-source-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -65,7 +80,6 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
@@ -89,6 +103,13 @@ patternProperties:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - oneOf:
+      - required:
+          - trigger-sources
+          - "#trigger-source-cells"
+      - required:
+          - adi,sync-in-gpios
+
 unevaluatedProperties: false
 
 examples:
@@ -99,7 +120,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        adc@0 {
+        adc0: adc@0 {
             compatible = "adi,ad7768-1";
             reg = <0>;
             spi-max-frequency = <2000000>;
@@ -108,7 +129,8 @@ examples:
             vref-supply = <&adc_vref>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
-            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            trigger-sources = <&adc0 0>;
+            #trigger-source-cells = <0>;
             reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
             clocks = <&ad7768_mclk>;
             clock-names = "mclk";
-- 
2.34.1



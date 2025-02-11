Return-Path: <linux-iio+bounces-15376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A870A319BC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37CB3A7B3E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4F26A09C;
	Tue, 11 Feb 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A0uG0YU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B9268FE8;
	Tue, 11 Feb 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317641; cv=none; b=C/TUN8XgcHg/cI5aTutHv3ogxvK5CQ/vT7cgqt4w+0xw+kpJgzKSvivSuS+1q4yHgsqAIZX/BADH8VoRK4AH5pMhLQag/VPvdRz6uVLX0pTkuTUGD+WTYNv6mnsd5k7RtxDqowRSzgI3aBUINiXIXEotX2HJU93+LqIHJ23KYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317641; c=relaxed/simple;
	bh=cUdo0hR1SxFvHRflLbtijd5qk5QC/Bd354r6plb6MyY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QG968nxBpORxUmZFAQ1xTJidUemaEW8eVmHP7dYjaviS4ZMqXXLcztd3q1ikqIP702hC/IIKujcamoggLTeRRmjaWkFcHygG1uLAjX5Nqg78OmSj9oGd5sXSxejUFoo/GGTfwENJ2r97f9MwB8vUdmJbkBIheXxDX972Us9u4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A0uG0YU9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BIvZum028455;
	Tue, 11 Feb 2025 18:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=sRP87Qul6HtZYSdW8p/OVdXuHIn
	Pi/VjRFG8cNBDNmE=; b=A0uG0YU9vJPHlmkEzB1d68QoZ8TpYTKe7q54rBmD6qp
	0ozXR3XyICORoWkgv0fYahUH8jGqeqd3fPJ3CW9tr8JIAPyXE83abi0MJXPmDqBT
	0uEouuYf3trU9MOYxlzKO6fW/g3111xouriE7STIEtx9CGCatf7Ni9unbI5sO/BV
	lBRNyVMSKECXliNdo60OBINc+lUDObm8r592CeI5b0A5TVSastjrqtaagqEzA+2f
	4OGFbvferCJwyGnlXjrJ7M41IMOaVIn28JLY2px/vvvISt5PwaYqeaddX+R22dQK
	1EQ/YRf4BAVNdaNcG4XBvNCf3QaZK5cXpqCqNI+8+4A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p209ysmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:47:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNl4YR016993
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:47:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 18:47:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:47:04 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNkoLV009870;
	Tue, 11 Feb 2025 18:46:53 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 03/17] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Tue, 11 Feb 2025 20:46:50 -0300
Message-ID: <20250211234650.1008125-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YQfT9nIMELGKTt8woRl2Wj4sI6FFfAty
X-Proofpoint-GUID: YQfT9nIMELGKTt8woRl2Wj4sI6FFfAty
X-Authority-Analysis: v=2.4 cv=VPInn8PX c=1 sm=1 tr=0 ts=67abe179 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=1BXouof-NqooHmoyBnsA:9 a=ll8Ng6K2x5dEghGH17xW:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

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



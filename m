Return-Path: <linux-iio+bounces-16494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F9A55813
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3693B37FA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9327817C;
	Thu,  6 Mar 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qTEQ082Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571327814D;
	Thu,  6 Mar 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294897; cv=none; b=dHZot4JRLPmQg85hbxIuo9baVctX2zJjGIceLRUmNK2tpylwfGY/9MfEoE0K8jSp9YdxKXrYSs2WHj1smo/PWLqSAdrf3BradHueqchhqxIX8Ui1s8+dTmZsg6BIGKtW3qVf0BhOqu2GK6HElOCwzcx+yj55UmlKV3pfp324o+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294897; c=relaxed/simple;
	bh=zrZRc+SbouOjcSqL76REKNkmVAy/m9mWfpVBP+/U6wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrKBqVkxUILJNfgnpVW/s6sdzWf1wnKssliQnISDVew4FE6eRK/WDozv3F5X6CQlQ6mLPE6wbhAu+IJiiB1erT7fAPX5tIX187TLsj+x2d4oXgSoxDndxedDTsX7LX8qnniy1BETLfTw6Y7ocG9ZUFNt+C8ezwyDXU52dAFxwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qTEQ082Z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeBJ003108;
	Thu, 6 Mar 2025 16:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EuQFs
	WlKwnyVcooHtBoWpdbs4tk0p3riY+QlPn1uc8U=; b=qTEQ082ZYj4PVGfKEDW8P
	wvO1aglZ+9FTYhO1Y6COTyrCDya2Y6O/UWsq5+ipz9/sCrIuT2SFRsN6G9ZQF6Qa
	Rfte19CLLTQ8gyQywQdbpUJRwl2iCPWeqT7NOCjzRhjTdeNupl9FSxWLXhXmTR5S
	3XndEpYMPLfeHTOdcQyyYW5wUDGjmmwU20fGii5gLYAMdz3n+D19UmsPB1DjSL7S
	h/0xVIMIJz7LrTG713oz6PnA5PKmjLR9TyS0W+skkzhEqt6uOgPt/EXwwXYY+gh8
	zbISYOooBeVVw8b2dv4m/LzHGH2ud9sOaMV4wvgQKTDgHAXFDpDpw0bs/cIkpiDv
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 455wnuf8g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:01:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 526L1EJW031099
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:01:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 16:01:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:01:14 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L0whb011460;
	Thu, 6 Mar 2025 16:01:00 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 03/17] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Thu, 6 Mar 2025 18:00:56 -0300
Message-ID: <4136b5259df75221fc314bcd4a57ecaeeab41a45.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RV_zPSangsWcmFNWAW0m0b2XgaXBZxWV
X-Proofpoint-ORIG-GUID: RV_zPSangsWcmFNWAW0m0b2XgaXBZxWV
X-Authority-Analysis: v=2.4 cv=VNcnn8PX c=1 sm=1 tr=0 ts=67ca0d1b cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=1BXouof-NqooHmoyBnsA:9 a=ll8Ng6K2x5dEghGH17xW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

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
v4 Changes:
* none

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



Return-Path: <linux-iio+bounces-14616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73349A1D916
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1513165C42
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A00747F;
	Mon, 27 Jan 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OBPdZHIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D9130A54;
	Mon, 27 Jan 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990720; cv=none; b=RYy8wyjg8EzRqIc7mV4WPEEvtZm9x9Wqmp/Ppd0ZUPXHgHGOXNegh/ijHqe2sjQPp8lOkmWIjP8xcbc5V3xjXkaMK5f7mhGnfwG5gkkDISM9k+y8E8HT4FUXuRGnfZlq/wc9M2WgLr7vL1P1tbxjJn1gNCdqLpIIUpfr5R+F75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990720; c=relaxed/simple;
	bh=tkjodejIkyfZNAoTVHXViLIHzhjr/yjJ1j9QNx+4vLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtdOe4esbQcxMorQSdC7NuNNXYAjDmrIlkWyevlZNAH3Vjvug5KqETVscJjjxrLYnNq9lt9RwysqOdEXliW/eygyVm+Dcx8JyfBREg657JBwWKLKkMXYPssYKGrIaAPj9wTiSxT34h6PLV3y05PliDJ5lyZT65/gEfUc4lPTmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OBPdZHIe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWC0l005706;
	Mon, 27 Jan 2025 10:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NfKbi
	I33OeNLZTutYSVxoHASO0pm05PrlJM9gusd0Bc=; b=OBPdZHIeGzE6wLQ5a+KuV
	h/YZwM4NIrRorgJpLVb2QxLm1DmzcxBnAHRYqWN5xM2MSdUjn+NjRCrV7EELMXcs
	zuBeS85h4StW/coLMw0C338MtP/kDHc5GOQ0/qi5nX0YZStzR6LNFYqkKAexsGNY
	wbOq0E0PXbqly8Ruflwc91nhysRfsITbpJJ1OLUaFgQkaOczazCnzRIyjHhjdot4
	df4VSlowcdtY0LcSwrg7UUNM7lhrlEk5NTnqtzKvZuw+ZzAWMtV937wAKhUhFU2O
	OZEycx6Qdog0HJiy5BJ0bUnHigu2D/wmMHmzVnSOLzsT98fBj43pRkUf/4XcMNOq
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:11:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFBhDm038426
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:11:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:11:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:11:43 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFBWV0008377;
	Mon, 27 Jan 2025 10:11:34 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Mon, 27 Jan 2025 12:11:30 -0300
Message-ID: <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tlDx6rNcYe1G3efqfGDqc9fI8UHaUauD
X-Proofpoint-GUID: tlDx6rNcYe1G3efqfGDqc9fI8UHaUauD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

Add a new trigger-sources property to enable synchronization across
multiple devices. This property references the main device (or
trigger provider) responsible for generating the pulse to drive the
SYNC_IN of all devices in the setup.

In addition to GPIO synchronization, The AD7768-1 also supports
synchronization over SPI, which use is recommended when the GPIO
cannot provide a pulse synchronous with the base MCLK signal. It
consists of looping back the SYNC_OUT to the SYNC_IN pin and send
a command via SPI to trigger the synchronization.

SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
property. Since adi,sync-in-gpios is not long the only method, remove it
from required properties.

While at it, add description to the interrupt property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Patch added as replacement for adi,sync-in-spi patch.
* addressed the request for a description to interrupts property.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3ce59d4d065f..3e119cf1754b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,17 @@ properties:
   clock-names:
     const: mclk
 
+  trigger-sources:
+    description:
+      References the main device responsible for synchronization. In a single
+      device setup, reference the own node.
+    maxItems: 1
+
   interrupts:
+    description:
+      Specifies the interrupt line associated with the ADC. This refers
+      to the DRDY (Data Ready) pin, which signals when conversion results are
+      available.
     maxItems: 1
 
   '#address-cells':
@@ -46,6 +56,8 @@ properties:
       sampling. A pulse is always required if the configuration is changed
       in any way, for example if the filter decimation rate changes.
       As the line is active low, it should be marked GPIO_ACTIVE_LOW.
+      In the absence of this property, Synchronization over SPI will be
+      enabled.
 
   reset-gpios:
     maxItems: 1
@@ -57,6 +69,9 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  "#trigger-source-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -65,7 +80,8 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
+  - trigger-sources
+  - #trigger-source-cells
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
@@ -99,7 +115,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        adc@0 {
+        adc0: adc@0 {
             compatible = "adi,ad7768-1";
             reg = <0>;
             spi-max-frequency = <2000000>;
@@ -109,6 +125,8 @@ examples:
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
             adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            trigger-sources = <&adc0>;
+            #trigger-source-cells = <0>;
             reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
             clocks = <&ad7768_mclk>;
             clock-names = "mclk";
-- 
2.34.1



Return-Path: <linux-iio+bounces-17959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEB0A86270
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F3D4C12CA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6342144D5;
	Fri, 11 Apr 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h9Lmnlnk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45950213E81;
	Fri, 11 Apr 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387015; cv=none; b=GrwiOSpQsD9ik0yDYuaJE7JFKrp2ly1w43dFCzxlfzxcAkS0PG0B+hs/fkiQeAZ3wLauurSEZY3vZEJFRoeZuannBk+2RSUwT/gIQSLqrfOPO2ffQ+cbeiLPPuJuvTa9lNJ+R/B5atY2cuZU2DE7/MMW3oMKKMTenK1wzQ096Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387015; c=relaxed/simple;
	bh=8K80JYQL1xHDf/PZ9bGNltO01knsj7tDEqPwUBWNauA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXOZeEtixUOyA89I+3NHK8zpbbKexxs3ZXJrXYquIxDbxQ50UvWo1CY49tqEIWwi0EwlDjYsUm8RtzDWkvULcNEj0X+dBAEx0barkBCwBkus8W9luMpwj+WjyhgGA3gQZnHI6kJMUt+aLrWrPy6rGAjZy/pkJmFOmRL8VOxvbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h9Lmnlnk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE2DQY024382;
	Fri, 11 Apr 2025 11:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+t+5j
	eAKJyLQoc5YN0wGByHH9TdYjfvYpDfnaI5kibo=; b=h9Lmnlnk+fuXlG2mKR8O0
	uPLL6daW2djgB3LkCqyrMGIJup9IEbdKxgH0n2FpJANtDRn9PAPYHeZqpF2/E+Ky
	5iHDIJf9z07JGiWTVZes+Nwf9HDkWfDHrskP5Z/m1ugikqt/FztQVxXgIL4fBC6f
	7kpUpjtGKtyD+pW7+AphCEKCURs2GEqagAw009iuM8sEUW7R2nd3bI3C+YoNIulL
	cFKKNiZubhPpfJhLhPYr5XoFY8JWNBrkh3R2RfiAAeCqIqwbAYw6l/Utcs0WFxdk
	ivkMeBoi/BlwZfpgWaCKxj6UKPh12Wyq9hrMgEssYboTseZSBXozSkm3bXLeyfa6
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc6mj8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:56:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BFuaEX022196
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:56:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 11:56:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 11:56:35 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BFuHxr015439;
	Fri, 11 Apr 2025 11:56:20 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Fri, 11 Apr 2025 12:56:17 -0300
Message-ID: <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: klpx19_THYd733Yu5ga_N-ZpgLZ2kgdH
X-Proofpoint-ORIG-GUID: klpx19_THYd733Yu5ga_N-ZpgLZ2kgdH
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f93bb5 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=rALQYAMM0ZtNIrbvjz8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110101

In addition to GPIO synchronization, The AD7768-1 also supports
synchronization over SPI, which use is recommended when the GPIO
cannot provide a pulse synchronous with the base MCLK signal. It
consists of looping back the SYNC_OUT to the SYNC_IN pin and send
a command via SPI to trigger the synchronization.

Introduce the 'trigger-sources' property to support SPI-based
synchronization, along with additional optional entries for the SPI
offload trigger and the START signal via GPIO3.

While at it, add description to the interrupts property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* Include START pin and DRDY in the trigger-sources description.
* Fixed "#trigger-source-cells" value and description.
* sync-in-gpios is represented in the trigger-sources property.

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
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3ce59d4d065f..4c58dbe8f749 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,30 @@ properties:
   clock-names:
     const: mclk
 
+  trigger-sources:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 3
+    description: |
+      A list of phandles referencing trigger source devices or GPIOs.
+      Supports up to three entries, each representing a different type of
+      trigger:
+
+        - First entry specifies the device responsible for driving the
+          synchronization (SYNC_IN) pin, as an alternative to adi,sync-in-gpios.
+          This can be a `gpio-trigger` or another `ad7768-1` device. If the
+          device's own SYNC_OUT pin is internally connected to its SYNC_IN pin,
+          reference the device itself or omit this property.
+        - Second entry optionally defines a GPIO3 pin used as a START signal trigger.
+        - Third entry specifies a GPIO line to act as a trigger for SPI offload.
+
+      Use the accompanying trigger source cell to identify the type of each entry.
+
   interrupts:
+    description:
+      Specifies the interrupt line associated with the ADC. This refers
+      to the DRDY (Data Ready) pin, which signals when conversion results are
+      available.
     maxItems: 1
 
   '#address-cells':
@@ -57,6 +80,15 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  "#trigger-source-cells":
+    description: |
+      Indicates the trigger source type for each entry:
+      0 = Synchronization GPIO-based trigger
+      1 = Synchronization device trigger (e.g., another ad7768-1)
+      2 = GPIO3 pin acting as START signal
+      3 = DRDY pin acting as SPI offload trigger
+    const: 1
+
 required:
   - compatible
   - reg
@@ -65,7 +97,6 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
@@ -99,7 +130,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        adc@0 {
+        adc0: adc@0 {
             compatible = "adi,ad7768-1";
             reg = <0>;
             spi-max-frequency = <2000000>;
@@ -108,7 +139,8 @@ examples:
             vref-supply = <&adc_vref>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
-            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            trigger-sources = <&adc0 1>;
+            #trigger-source-cells = <1>;
             reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
             clocks = <&ad7768_mclk>;
             clock-names = "mclk";
-- 
2.34.1



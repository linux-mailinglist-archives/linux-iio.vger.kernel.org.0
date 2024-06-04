Return-Path: <linux-iio+bounces-5793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F348FBF3A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B37D1C223DE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A114C5AE;
	Tue,  4 Jun 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lkQdQptW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF514C58A;
	Tue,  4 Jun 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541069; cv=none; b=LsGyz4QmNknfB5kM3+G2e+C93Z83W531sLoH3l6Y2g4KYViMKKBEydAyqWdCqk8eFiHVJOROtEgzG/c29rshSFYVhw+CpMrw4kpbUUklU8VX7k+6nLl94fsTRnN1zrtNMFRQ1nJA3ZpGzdp/iuhr9GAzmuESyr22Rq4afz01qDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541069; c=relaxed/simple;
	bh=ivPwrYTq+vRnj37RSY64wulzYjdkOp5wkXzYaqR7tDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceZ39YsKf4wtf+x7y0zmvSNMoEezjvTMLCwgZbOiKU4ibjqyAvvPu/SImvtGvrWuLrNA/2xzIA4hgiiv8HYsgJmdpjqf62+MoPUYjXo1Gn92GeTPhxZ/00dN7VL9jfc83GsoTHRvP5NyKC0VWOT2tHCfySls57OZE0F8MyhdCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lkQdQptW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454LiBfo024201;
	Tue, 4 Jun 2024 18:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zQbB8
	yW5qEMo220BkUS6kkHP95TQWPMU57n41F7KHHA=; b=lkQdQptWWi9NdpK2nOdv5
	7jGzGcAvW7Ez8R1jTEKd40OCxf8SDaoLOebMcySln24B1XhklIAlbSonH3xG1LZ1
	VDSQK2nvi2/C8B5jYNZvocG78AlTXvi2RBp9rtpeevtSXcViaLpnUGFV4WFEsWlL
	4X0EZuBvFn6sp4DKTigazXKhAo3kP4fkj7/NE6TVkIwfBYh3+uYihYs92cP27SWN
	QLfTBV/YlZwKbXtaPHUkg8mSJsOCRLebE7uDNlqmFWFfTGK7lmTDrvWcNrUSQ2Ld
	wUYjd9T71fMsa1+aovLUmHgryBsL4glkVYE+xHtTJoIrjAc7q0ejoj32f/IvPvtI
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yjb3r8597-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:44:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 454MiAbE025162
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 18:44:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jun 2024
 18:44:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Jun 2024 18:44:09 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 454MhsHH001223;
	Tue, 4 Jun 2024 18:43:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] dt-bindings: iio: adc: Add AD4000
Date: Tue, 4 Jun 2024 19:43:53 -0300
Message-ID: <b8a211e09c17f5a9f0a6aa6e11d6375ff398c918.1717539384.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: P_svA2_nYsDNLd9ZknOvEw70YmgonR9t
X-Proofpoint-ORIG-GUID: P_svA2_nYsDNLd9ZknOvEw70YmgonR9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040184

Add device tree documentation for AD4000 series of ADC devices.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Even though didn't pick all suggestions to the dt-bindings, I did pick most them
so kept David's Suggested-by tag.

 .../bindings/iio/adc/adi,ad4000.yaml          | 207 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
new file mode 100644
index 000000000000..7470d386906b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4000 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4000
+      - adi,ad4001
+      - adi,ad4002
+      - adi,ad4003
+      - adi,ad4004
+      - adi,ad4005
+      - adi,ad4006
+      - adi,ad4007
+      - adi,ad4008
+      - adi,ad4010
+      - adi,ad4011
+      - adi,ad4020
+      - adi,ad4021
+      - adi,ad4022
+      - adi,adaq4001
+      - adi,adaq4003
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
+
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ single, chain ]
+    description: |
+      This property indicates the SPI wiring configuration.
+
+      When this property is omitted, it is assumed that the device is using what
+      the datasheet calls "4-wire mode". This is the conventional SPI mode used
+      when there are multiple devices on the same bus. In this mode, the CNV
+      line is used to initiate the conversion and the SDI line is connected to
+      CS on the SPI controller.
+
+      When this property is present, it indicates that the device is using one
+      of the following alternative wiring configurations:
+
+      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
+        definition of 3-wire mode is NOT at all related to the standard
+        spi-3wire property!) This mode is often used when the ADC is the only
+        device on the bus. In this mode, SDI is connected to MOSI or to VIO, and
+        the CNV line can be connected to the CS line of the SPI controller or to
+        a GPIO, in which case the CS line of the controller is unused.
+      * chain: The datasheet calls this "chain mode". This mode is used to save
+        on wiring when multiple ADCs are used. In this mode, the SDI line of
+        one chip is tied to the SDO of the next chip in the chain and the SDI of
+        the last chip in the chain is tied to GND. Only the first chip in the
+        chain is connected to the SPI bus. The CNV line of all chips are tied
+        together. The CS line of the SPI controller can be used as the CNV line
+        only if it is active high.
+
+  '#daisy-chained-devices': true
+
+  vdd-supply:
+    description: A 1.8V supply that powers the chip (VDD).
+
+  vio-supply:
+    description:
+      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
+
+  ref-supply:
+    description:
+      A 2.5 to 5V supply for the external reference voltage (REF).
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). This input has multiple functions. It initiates
+      the conversions and selects the SPI mode of the device (chain or CS). In
+      'single' mode, this property is omitted if the CNV pin is connected to the
+      CS line of the SPI controller.
+    maxItems: 1
+
+  adi,high-z-input:
+    type: boolean
+    description:
+      High-Z mode allows the amplifier and RC filter in front of the ADC to be
+      chosen based on the signal bandwidth of interest, rather than the settling
+      requirements of the switched capacitor SAR ADC inputs.
+
+  adi,gain-milli:
+    description: |
+      The hardware gain applied to the ADC input (in milli units).
+      The gain provided by the ADC input scaler is defined by the hardware
+      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
+      If not present, default to 1000 (no actual gain applied).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [454, 909, 1000, 1900]
+    default: 1000
+
+  interrupts:
+    description:
+      The SDO pin can also function as a busy indicator. This node should be
+      connected to an interrupt that is triggered when the SDO line goes low
+      while the SDI line is high and the CNV line is low ('single' mode) or the
+      SDI line is low and the CNV line is high ('multi' mode); or when the SDO
+      line goes high while the SDI and CNV lines are high (chain mode),
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vio-supply
+  - ref-supply
+
+allOf:
+  # in '4-wire' mode, cnv-gpios is required, for other modes it is optional
+  - if:
+      not:
+        required:
+          - adi,spi-mode
+    then:
+      required:
+        - cnv-gpios
+  # chain mode has lower SCLK max rate
+  - if:
+      required:
+        - adi,spi-mode
+      properties:
+        adi,spi-mode:
+          const: chain
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 50000000 # for VIO > 2.7 V, 40000000 for VIO > 1.7 V
+      required:
+        - '#daisy-chained-devices'
+    else:
+      properties:
+        '#daisy-chained-devices': false
+  # Gain property only applies to ADAQ devices
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,adaq4001
+                - adi,adaq4003
+    then:
+      properties:
+        adi,gain-milli: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a AD devices */
+        adc@0 {
+            compatible = "adi,ad4020";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        /* Example for a ADAQ devices */
+        adc@0 {
+            compatible = "adi,adaq4003";
+            reg = <0>;
+            adi,spi-mode = "single";
+            spi-max-frequency = <80000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            adi,high-z-input;
+            adi,gain-milli = <454>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index bff979a507ba..1f052b9cd912 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1200,6 +1200,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 F:	drivers/iio/dac/ad3552r.c
 
+ANALOG DEVICES INC AD4000 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0



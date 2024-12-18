Return-Path: <linux-iio+bounces-13615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A489F68C0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E172416C958
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26AF1EBA07;
	Wed, 18 Dec 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sk7rybHr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FE1C5CA8;
	Wed, 18 Dec 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532692; cv=none; b=SPP3OmK/dKYw/ERtwTTNnx1C6zLhhG344u+htz0MbFLtkbXuSZjtJ9w8mT4ZluN3fegP6MXi64W9OlaBISvmmxm7dw+hkoN5mkXk0luZ7KPeraLOH6IjZ6eBXeEY1/SgW8i7p8I6rnEsF31fKZQHWjHAcki7j/his33O8uPSk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532692; c=relaxed/simple;
	bh=xHYSZzRSKFo8bRWysNVGNsKMtnwEJ8WCUpqFRpNt8xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP4BZeDiDpi469PHfP0F2OsQ3ZUay6yR0s03TmV6HGOQhjcicqx/HTJXEtUuqz/WhvmTv07lrLc9gHJgSoH19S9eeDJFrmrAoUGvOLK6EVWWM/gV+K3OiTyQGCjIN6nNva8qaMBQMeOzCsfCDx2CxFb+s8VjudMEX+T42y4vm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sk7rybHr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIEZ1pl012416;
	Wed, 18 Dec 2024 09:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=p9XLA
	gB7CIIKH4XSYHISubZKfiZ6WgEHzyML4CmNlX0=; b=sk7rybHrOYs/6GJjic69a
	5zBdDUcy0MZIFY6HL7QYhxzUM5Y8UiOJJEWTVIUvJe71wIG0mnGqDGfdHTl2/K3k
	1y3jFvL3xisBtqw5m8PYhWGDLgCCFARiZVU4Pzc4LqSVUGD3CZz+S/4qqqvueGUk
	bzOTfUHuVn1xV8ogqd8+luGqjz8TtfO/ot73IqEFt765mJX0Bfnxb3X8Lpgxnt+1
	GhFyFMfX7wx6YEDcDVtfTVuYdV/9hrg9jmx0KVp2jZAidtgim5O2aDViOgpCpafR
	ZDkZk1oaJQmW6tdKBIef+NvBC242uZLGKtIL3pxogUam7zMLiZgXUbKHrLDHPFf1
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43kv2814fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:37:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BIEbs6u028667
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Dec 2024 09:37:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 18 Dec
 2024 09:37:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 18 Dec 2024 09:37:54 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BIEbhPB030554;
	Wed, 18 Dec 2024 09:37:45 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <ana-maria.cusco@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [RFC PATCH 2/4] dt-bindings: iio: adc: Add AD4170
Date: Wed, 18 Dec 2024 11:37:42 -0300
Message-ID: <caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1734530280.git.marcelo.schmitt@analog.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KUF2UkC8QEpxBTP03TV4Zocnjio1dhbx
X-Proofpoint-GUID: KUF2UkC8QEpxBTP03TV4Zocnjio1dhbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180114

Add device tree documentation for AD4170 sigma-delta ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4170.yaml          | 473 ++++++++++++++++++
 1 file changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
new file mode 100644
index 000000000000..8c5defc614ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
@@ -0,0 +1,473 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4170 Analog to Digital Converter
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4170 Analog to Digital Converter.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4170
+
+  avss-supply:
+    description:
+      Referece voltage supply for AVDD. AVSS can be set below 0V to provide a
+      bipolar power supply to AD4170-4. Must be −2.625V at minimum, 0V maximum.
+      If not specified, this is assumed to be analog ground.
+
+  avdd-supply:
+    description:
+      A supply of 4.75V to 5.25V relative to AVSS that powers the chip (AVDD).
+
+  iovdd-supply:
+    description: 1.7V to 5.25V reference supply to the serial interface (IOVDD).
+
+  refin1p-supply:
+    description: REFIN+ supply that can be used as reference for conversion.
+
+  refin1n-supply:
+    description: REFIN- supply that can be used as reference for conversion.
+
+  refin2p-supply:
+    description: REFIN2+ supply that can be used as reference for conversion.
+
+  refin2n-supply:
+    description: REFIN2- supply that can be used as reference for conversion.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: |
+      Optional external clock source. Can include one clock source: external
+      clock or external crystal.
+
+  clock-names:
+    enum:
+      - ext-clk
+      - xtal
+
+  '#clock-cells':
+    const: 0
+
+  adi,gpio0-power-down-switch:
+    type: boolean
+    description:
+      Describes whether GPIO0 is used as a switch to disconnect bridge circuits
+      from AVSS. Pin defaults to GPIO if this property is not present.
+
+  adi,gpio1-power-down-switch:
+    type: boolean
+    description:
+      Describes whether GPIO1 is used as a switch to disconnect bridge circuits
+      from AVSS. Pin defaults to GPIO if this property is not present.
+
+  adi,vbias-pins:
+    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 9
+    items:
+      minimum: 0
+      maximum: 8
+
+  adi,dig-aux1:
+    description:
+      Describes whether DIG_AUX1 pin will operate as data ready output,
+      synchronization output signal (SYNC_OUT), or if it will be disabled.
+      A value of 0 indicates DIG_AUX1 pin disabled. High impedance.
+      A value of 1 indicates DIG_AUX1 is configured as ADC data ready output.
+      A value of 1 indicates DIG_AUX1 is configured as SYNC_OUT output.
+      If this property is absent, DIG_AUX1 pin is disabled.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2]
+    default: 0
+
+  adi,dig-aux2:
+    description:
+      Describes whether DIG_AUX2 pin will function as DAC LDAC input,
+      synchronization start input (START), or if it will be disabled.
+      A value of 0 indicates DIG_AUX2 pin is disabled. High impedance.
+      A value of 1 indicates DIG_AUX2 pin is configured as active-low LDAC input
+      for the DAC.
+      A value of 2 indicates DIG_AUX2 pin is configured as START input.
+      If this property is absent, DIG_AUX2 pin is disabled.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2]
+    default: 0
+
+  adi,sync-option:
+    description:
+      Describes how ADC conversions are going to be synchronized. A value of 1
+      indicates the SYNC_IN pin will function as a synchronization input that
+      allows the user to control the start of sampling by pulling SYNC_IN high.
+      Use option number 2 to set the alternate synchronization functionality
+      which allows per channel conversion start control when multiple channels
+      are enabled. Option number 0 disables synchronization.
+      A value of 0 indicates no synchronization. SYNC_IN pin disabled.
+      A value of 1 indicates standard synchronization functionality.
+      A value of 2 indicates alternate synchronization functionality.
+      If this property is absent, no synchronization is performed.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2]
+    default: 1
+
+  adi,excitation-pin-0:
+    description: |
+      Specifies the pin to apply excitation current 0 (IOUT0). Besides the
+      analog pins 0 to 8, the excitation current can be applied to GPIO pins.
+      17: Output excitation current IOUT0 to GPIO0.
+      18: Output excitation current IOUT0 to GPIO1.
+      19: Output excitation current IOUT0 to GPIO2.
+      20: Output excitation current IOUT0 to GPIO3.
+      If this property is absent, IOUT0 is not routed to any pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
+    default: 0
+
+  adi,excitation-pin-1:
+    description: |
+      Specifies the pin to apply excitation current 1 (IOUT1). Besides the
+      analog pins 0 to 8, the excitation current can be applied to GPIO pins.
+      17: Output excitation current IOUT1 to GPIO0.
+      18: Output excitation current IOUT1 to GPIO1.
+      19: Output excitation current IOUT1 to GPIO2.
+      20: Output excitation current IOUT1 to GPIO3.
+      If this property is absent, IOUT1 is not routed to any pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
+    default: 0
+
+  adi,excitation-pin-2:
+    description: |
+      Specifies the pin to apply excitation current 2 (IOUT2). Besides the
+      analog pins 0 to 8, the excitation current can be applied to GPIO pins.
+      17: Output excitation current IOUT2 to GPIO0.
+      18: Output excitation current IOUT2 to GPIO1.
+      19: Output excitation current IOUT2 to GPIO2.
+      20: Output excitation current IOUT2 to GPIO3.
+      If this property is absent, IOUT2 is not routed to any pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
+    default: 0
+
+  adi,excitation-pin-3:
+    description: |
+      Specifies the pin to apply excitation current 3 (IOUT3). Besides the
+      analog pins 0 to 8, the excitation current can be applied to GPIO pins.
+      17: Output excitation current IOUT3 to GPIO0.
+      18: Output excitation current IOUT3 to GPIO1.
+      19: Output excitation current IOUT3 to GPIO2.
+      20: Output excitation current IOUT3 to GPIO3.
+      If this property is absent, IOUT3 is not routed to any pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20]
+    default: 0
+
+  adi,excitation-current-0-microamp:
+    description: |
+      Excitation current in microamps to be applied to IOUT0 output pin
+      specified in adi,excitation-pin-0.
+    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+    default: 0
+
+  adi,excitation-current-1-microamp:
+    description: |
+      Excitation current in microamps to be applied to IOUT1 output pin
+      specified in adi,excitation-pin-1.
+    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+    default: 0
+
+  adi,excitation-current-2-microamp:
+    description: |
+      Excitation current in microamps to be applied to IOUT2 output pin
+      specified in adi,excitation-pin-2.
+    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+    default: 0
+
+  adi,excitation-current-3-microamp:
+    description: |
+      Excitation current in microamps to be applied to IOUT3 output pin
+      specified in adi,excitation-pin-3.
+    enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+    default: 0
+
+  adi,chop-iexc:
+    description: |
+      Specifies the chopping/swapping functionality for excitation currents.
+      0: No Chopping of Excitation Currents.
+      1: Chop/swap IOUT0 and IOUT1 (pair AB) excitation currents.
+      2: Chop/swap IOUT2 and IOUT3 (pair CD) excitation currents.
+      3: Chop/swap both pairs (pair AB and pair CD) of excitation currents.
+      If this property is absent, no chopping is performed.
+      There are macros for the above values in dt-bindings/iio/adi,ad4170.h.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
+    $ref: adc.yaml
+    type: object
+    unevaluatedProperties: false
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number. The device can have up to 16 channels numbered
+          from 0 to 15.
+        items:
+          minimum: 0
+          maximum: 15
+
+      diff-channels:
+        description: |
+          This property is used for defining the inputs of a differential
+          voltage channel. The first value is the positive input and the second
+          value is the negative input of the channel.
+
+          Besides the analog input pins AIN0 to AIN8, there are special inputs
+          that can be selected with the following values:
+            17: Temperature sensor input
+            18: (AVDD-AVSS)/5
+            19: (IOVDD-DGND)/5
+            20: DAC output
+            21: ALDO
+            22: DLDO
+            23: AVSS
+            24: DGND
+            25: REFIN+
+            26: REFIN-
+            27: REFIN2+
+            28: REFIN2-
+            29: REFOUT
+
+          There are macros for those values in dt-bindings/iio/adi,ad4170.h.
+
+        items:
+          minimum: 0
+          maximum: 31
+
+      single-channel: true
+
+      common-mode-channel: true
+
+      bipolar: true
+
+      adi,config-setup-number:
+        description: |
+          Specifies which of the 8 setups are used to configure the channel.
+          A setup comprises of: AFE, FILTER, FILTER_FS, MISC, OFFSET, and GAIN
+          registers. More than one channel can use the same configuration setup
+          number in which case they will share the settings of the above
+          mentioned registers.
+        items:
+          minimum: 0
+          maximum: 7
+
+      adi,chop-adc:
+        description: |
+          Specifies the chopping/swapping functionality for a channel setup.
+          Macros for adi,chop-adc values are available in
+          dt-bindings/iio/adi,ad4170.h. When enabled, the analog inputs are
+          continuously swapped and a conversion is generated for each time a
+          swap occurs. The analog input pins are connected in one direction,
+          sampled, swapped, sampled again, and then the conversion results are
+          averaged. The input swap minimizes system offset and offset drift.
+          This property also specifies whether AC excitation using 2 or 4 GPIOs
+          are going to be used.
+          0: No channel chop.
+          1: Chop/swap the channel inputs.
+          2: AC Excitation using 4 GPIOs.
+          3: AC Excitation using 2 GPIOs.
+          If this property is absent, no chopping is performed.
+        $ref: /schemas/types.yaml#/definitions/uint16
+        enum: [0, 1, 2, 3]
+        default: 0
+
+      adi,burnout-current-nanoamp:
+        description: |
+          Current in nanoamps to be applied for this channel. Burnout currents
+          are only active when the channel is selected for conversion.
+        enum: [0, 100, 2000, 10000]
+        default: 0
+
+      adi,buffered-negative:
+        description: Enable precharge buffer, full buffer, or skip reference
+          buffering of the negative voltage reference. Because the output
+          impedance of the source driving the voltage reference inputs may be
+          dynamic, RC combinations of those inputs can cause DC gain errors if
+          the reference inputs go unbuffered into the ADC. Enable reference
+          buffering if the provided reference source has dynamic high impedance
+          output.
+        enum: [0, 1, 2]
+        default: 0
+
+      adi,buffered-positive:
+        description: Enable precharge buffer, full buffer, or skip reference
+          buffering of the positive voltage reference. Because the output
+          impedance of the source driving the voltage reference inputs may be
+          dynamic, RC combinations of those inputs can cause DC gain errors if
+          the reference inputs go unbuffered into the ADC. Enable reference
+          buffering if the provided reference source has dynamic high impedance
+          output.
+        enum: [0, 1, 2]
+        default: 0
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the specific
+          channel. Valid values are:
+          0: Differential reference voltage REFIN+ - REFIN−.
+          1: Differential reference voltage REFIN2+ - REFIN2−.
+          2: Internal 2.5V referece (REFOUT) relative to AVSS.
+          3: Analog supply voltage (AVDD) relative relative AVSS.
+          If this field is left empty, the internal reference is selected.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1, 2, 3]
+        default: 2
+
+    required:
+      - reg
+      - adi,config-setup-number
+
+    allOf:
+      - oneOf:
+          - required: [single-channel]
+            properties:
+              diff-channels: false
+          - required: [diff-channels]
+            properties:
+              single-channel: false
+              common-mode-channel: false
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - iovdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/adc/adi,ad4170.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4170";
+            reg = <0>;
+            avdd-supply = <&avdd>;
+            iovdd-supply = <&iovdd>;
+            spi-max-frequency = <20000000>;
+            interrupt-parent = <&gpio_in>;
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+            adi,dig-aux1 = /bits/ 8 <1>;
+            adi,dig-aux2 = /bits/ 8 <0>;
+            adi,sync-option = /bits/ 8 <0>;
+            adi,excitation-pin-0 = <19>;
+            adi,excitation-current-0-microamp = <10>;
+            adi,excitation-pin-1 = <20>;
+            adi,excitation-current-1-microamp = <10>;
+            adi,chop-iexc = /bits/ 8 <1>;
+            adi,vbias-pins = <5 6>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS input range
+            // Fully differential. If AVSS < 0V, Fully differential true bipolar
+            channel@0 {
+                reg = <0>;
+                bipolar;
+                diff-channels = <AD4170_MAP_AIN0 AD4170_MAP_AIN1>;
+                adi,config-setup-number = <0>;
+                adi,reference-select = /bits/ 8 <3>;
+                adi,burnout-current-nanoamp = <100>;
+            };
+            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
+            // Peseudo-differential unipolar (fig. 2a)
+            channel@1 {
+                reg = <1>;
+                single-channel = <AD4170_MAP_AIN2>;
+                common-mode-channel = <AD4170_MAP_DGND>;
+                adi,config-setup-number = <1>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar (fig. 2b)
+            channel@2 {
+                reg = <2>;
+                bipolar;
+                single-channel = <AD4170_MAP_AIN3>;
+                common-mode-channel = <AD4170_MAP_REFOUT>;
+                adi,config-setup-number = <2>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
+            // Pseudo-differential true bipolar if AVSS < 0V (fig. 2c)
+            channel@3 {
+                reg = <3>;
+                bipolar;
+                single-channel = <AD4170_MAP_AIN4>;
+                common-mode-channel = <AD4170_MAP_DGND>;
+                adi,config-setup-number = <3>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN5 with respect to 2.5V throughout AVDD/REFOUT input range
+            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
+            channel@4 {
+                reg = <4>;
+                single-channel = <AD4170_MAP_AIN5>;
+                common-mode-channel = <AD4170_MAP_REFOUT>;
+                adi,config-setup-number = <4>;
+                adi,reference-select = /bits/ 8 <2>;
+            };
+            // Sample AIN6 with respect to REFIN+ throughout AVDD/AVSS input range
+            // Pseudo-differential unipolar
+            channel@5 {
+                reg = <5>;
+                single-channel = <AD4170_MAP_AIN6>;
+                common-mode-channel = <AD4170_MAP_REFIN1_P>;
+                adi,config-setup-number = <4>;
+                adi,reference-select = /bits/ 8 <2>;
+            };
+            // Sample AIN7 with respect to DGND throughout REFIN+/REFIN- input range
+            // Pseudo-differential bipolar
+            channel@6 {
+                reg = <6>;
+                bipolar;
+                diff-channels = <AD4170_MAP_AIN7 AD4170_MAP_DGND>;
+                adi,config-setup-number = <5>;
+                adi,reference-select = /bits/ 8 <0>;
+            };
+        };
+    };
+...
+
-- 
2.45.2



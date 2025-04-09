Return-Path: <linux-iio+bounces-17866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72CA824A4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C090F7B61FC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD35626656F;
	Wed,  9 Apr 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nwoShZpF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EC266565;
	Wed,  9 Apr 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201492; cv=none; b=b9yP4Dhk6xvgsDSfExWvyTooBHnPUFGZBO3b6jyoy4O3zsxisosW0RJQP43/h3hK7Q4d9zi2637QSBit49nqiKKHQkpGEQTnVj/Q5Bo0hFccP0isr7DP3puH4hABMGrsKDPIvIoISvTYeZnAmOUppROFwMSALr7ejZ+QE/LHTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201492; c=relaxed/simple;
	bh=QQpdP/15cOmBrlm28nL8N9uPhriBMqt+oEMMzljbTsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RElQFZZXGZLaUiw6DFWMetlxUF7wx9fnapcaGTUvwcoaC7B5Wqpv3H9CoTCQvEOnFOEsx0amC8DJ30fVyOrCZ4Db6TRSLU3JlL6y8V29Wa9eK47EK75ZimG+sQj6R8irZFWO39axoanNcolDpCTASgOsyzajCPKDkcBytuHjjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nwoShZpF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399CPra010114;
	Wed, 9 Apr 2025 08:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZiFY7
	m5mtzeMBrTBaTEl3Iv0dVHft9MAxEOZxhRG08A=; b=nwoShZpF4N6tvaDs5B35Z
	sUk0+LBHLVl+01mJgb8VudeWfxR1Pskn9auiTyu/RETon9J1HyHQ0JmPceCeucUF
	9hweH7bKAReubUhtgMtRukKqge1evD4nAbJvvO1MhjiAGNri/lKztenbnnY34lja
	f7Ss9vkeOiVdItdgE0vY82mDiBPFroypJK6PQ0ove9R9VOWy0Lvho6MSpPv2FPxI
	3pcVOzpabvjiKUpOv0bktUosX6bEsLCeabJuVNt/WO4Ey6c4YJrr9EmNfF6ao47h
	A28oISrDbad55xYaPdamilMFbrqVoYwKARislVmFZngIxHDvTp2syWOxa3hbDD6Z
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc66a92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:24:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 539COXWk052208
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:24:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 9 Apr 2025
 08:24:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:24:32 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539COJLO016900;
	Wed, 9 Apr 2025 08:24:22 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 1/7] dt-bindings: iio: adc: Add AD4170
Date: Wed, 9 Apr 2025 09:24:18 -0300
Message-ID: <d2f8e8227022afe411005882cfd269124cd81e01.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gjdeHZ1icUa02N4HoeNGR7_H0kNM5EHK
X-Proofpoint-ORIG-GUID: gjdeHZ1icUa02N4HoeNGR7_H0kNM5EHK
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f66702 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=WNIpHu94SUlyTeZhJcUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090074

Add device tree documentation for AD4170 and similar sigma-delta ADCs.
The AD4170 is a 24-bit, multichannel, sigma-delta ADC.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
The AD4170 design has features to aid interfacing with weigh scale and RTD
sensors that are expected to be setup with external circuitry for proper
sensor operation. A key characteristic of those sensors is that the circuit
they are in must be excited with a pair of signals. The external circuit
can be excited either by voltage supply or by AD4170 excitation signals.
The sensor can then be read through a different pair of lines that are
connected to AD4170 ADC.

 .../bindings/iio/adc/adi,ad4170.yaml          | 527 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 534 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
new file mode 100644
index 000000000000..93fe3b4648a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
@@ -0,0 +1,527 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4170 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converters.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4190-4.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4195-4.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+$defs:
+  sensor-node:
+    type: object
+    description: |
+      Common properties of external sensor circuitry connected to the ADC.
+
+    properties:
+      reg:
+        description:
+          Channel number. Connects the sensor to the channel with this number
+          of the device.
+        minimum: 1
+        maximum: 16
+
+      diff-channels:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        maxItems: 2
+        minItems: 2
+        description: |
+          ADC analog input pins to which the sensor circuit is connected.
+          The first value specifies the positive input pin, the second
+          specifies the negative input pin. See adc.yaml for details.
+
+      bipolar:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: If provided, the channel is to be used in bipolar mode.
+
+      adi,sensor-type:
+        description: Type of sensor connected to the device.
+        $ref: /schemas/types.yaml#/definitions/uint8
+
+      adi,ac-excited:
+        type: boolean
+        description: |
+          Whether the external circuit has to be AC or DC excited.
+
+      adi,excitation-pins:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: |
+          ADC pins used for external circuit excitation. Some applications
+          require optimum matching between excitation currents. Using excitation
+          current pairs minimizes the excitation current mismatch and the
+          excitation current drift matching on the ADC. Must describe either 1
+          or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
+
+      adi,excitation-current-microamp:
+        description: |
+          Excitation current in microamperes to be output to each excitation pin
+          specified by adi,excitation-pins property.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the specific
+          channel. Valid values are:
+          0: Differential reference voltage REFIN+ - REFIN−.
+          1: Differential reference voltage REFIN2+ - REFIN2−.
+          2: Internal 2.5V referece (REFOUT) relative to AVSS.
+          3: Analog supply voltage (AVDD) relative AVSS.
+          If this field is left empty, the first external reference is selected.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1, 2, 3]
+        default: 0
+
+    required:
+      - reg
+      - diff-channels
+      - bipolar
+      - adi,sensor-type
+      - adi,excitation-pins
+      - adi,reference-select
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4170
+      - adi,ad4190
+      - adi,ad4195
+
+  avss-supply:
+    description:
+      Referece voltage supply for AVSS. If provided, describes the magnitude
+      (absolute value) of the negative voltage supplied to the AVSS pin. Since
+      AVSS must be −2.625V minimum and 0V maximum, the declared supply voltage
+      must be between 0 and 2.65V. If not provided, AVSS is assumed to be at
+      system ground (0V).
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
+    description: REFIN- supply that can be used as reference for conversion. If
+      provided, describes the magnitude (absolute value) of the negative voltage
+      supplied to the REFIN- pin.
+
+  refin2p-supply:
+    description: REFIN2+ supply that can be used as reference for conversion.
+
+  refin2n-supply:
+    description: REFIN2- supply that can be used as reference for conversion. If
+      provided, describes the magnitude (absolute value) of the negative voltage
+      supplied to the REFIN2- pin.
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    description: |
+      Specify which pin should be configured as Data Ready interrupt.
+      Default if not supplied is sdo.
+    enum:
+      - sdo
+      - dig_aux1
+
+  clocks:
+    maxItems: 1
+    description:
+      Optional external clock source. Can specify either an external clock or
+      external crystal.
+
+  clock-names:
+    enum:
+      - ext-clk
+      - xtal
+
+  '#clock-cells':
+    const: 0
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is for the GPIO number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
+  ldac-gpios:
+    description:
+      GPIO connected to DIG_AUX2 pin to be used as LDAC toggle to control the
+      transfer of data from the DAC_INPUT_A register to the DAC.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    $ref: adc.yaml
+    type: object
+    unevaluatedProperties: false
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number.
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
+          17: Internal temperature sensor
+          18: (AVDD-AVSS)/5
+          19: (IOVDD-DGND)/5
+          20: DAC output
+          21: ALDO
+          22: DLDO
+          23: AVSS
+          24: DGND
+          25: REFIN+
+          26: REFIN-
+          27: REFIN2+
+          28: REFIN2-
+          29: REFOUT
+          For the internal temperature sensor, use the input number for both
+          inputs (i.e. diff-channels = <17 17>).
+        items:
+          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, 24, 25,
+                 26, 27, 28, 29]
+
+      single-channel: true
+
+      common-mode-channel: true
+
+      bipolar: true
+
+      adi,sensor-type:
+        description: Sensor type for direct ADC sensors.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        const: 0
+
+      adi,buffered-positive:
+        description: |
+          Enable precharge buffer, full buffer, or skip reference buffering of
+          the positive voltage reference. Because the output impedance of the
+          source driving the voltage reference inputs may be dynamic, RC
+          combinations of those inputs can cause DC gain errors if the reference
+          inputs go unbuffered into the ADC. Enable reference buffering if the
+          provided reference source has dynamic high impedance output. Note the
+          absolute voltage allowed on positive reference inputs (REFIN+,
+          REFIN2+) is from AVSS − 50 mV to AVDD + 50 mV when the reference
+          buffers are disabled but narrows to AVSS to AVDD when reference
+          buffering is enabled or in precharge mode.
+          0: Reference precharge buffer.
+          1: Full Buffer.
+          2: Bypass reference buffers (buffering disabled).
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1, 2]
+        default: 0
+
+      adi,buffered-negative:
+        description: |
+          Enable precharge buffer, full buffer, or skip reference buffering of
+          the negative voltage reference. Because the output impedance of the
+          source driving the voltage reference inputs may be dynamic, RC
+          combinations of those inputs can cause DC gain errors if the reference
+          inputs go unbuffered into the ADC. Enable reference buffering if the
+          provided reference source has dynamic high impedance output. Note the
+          absolute voltage allowed on negative reference inputs (REFIN-,
+          REFIN2-) is from AVSS − 50 mV to AVDD + 50 mV when the reference
+          buffers are disabled but narrows to AVSS to AVDD when reference
+          buffering is enabled or in precharge mode.
+          0: Reference precharge buffer.
+          1: Full Buffer.
+          2: Bypass reference buffers (buffering disabled).
+        $ref: /schemas/types.yaml#/definitions/uint8
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
+          3: Analog supply voltage (AVDD) relative AVSS.
+          If this field is left empty, the internal reference is selected.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1, 2, 3]
+        default: 2
+
+    required:
+      - reg
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
+  "^weighscale@":
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+
+    properties:
+      diff-channels: true
+      bipolar: true
+
+      adi,sensor-type:
+        description: Weigh scale sensor.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        const: 1
+
+      adi,excitation-pins:
+        description: |
+          ADC pins to use for weigh scale bridge circuit excitation. Must
+          describe either 1 or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 4
+        items:
+          minimum: 0
+          maximum: 20
+
+      adi,excitation-current-microamp:
+        description: |
+          Excitation current in microamperes to be output to each excitation pin
+          specified by adi,excitation-pins property. If not provided and
+          adi,ac-excited is true, use predefined ACX1, ACX1 negated, ACX2, and
+          ACX2 negated signals to AC excite the weigh scale bridge. Those
+          singals are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+
+      adi,power-down-switch-pin:
+        description: |
+          Number of the GPIO used as power-down switch for the bridge circuit.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1]
+
+  "^thermocouple@":
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+
+    properties:
+      diff-channels: true
+      bipolar: true
+
+      adi,sensor-type:
+        description: Thermocouple sensor.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        const: 2
+
+      adi,excitation-pins:
+        description: |
+          ADC pins to use for bridge circuit excitation. Must describe either 1
+          or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 4
+        items:
+          minimum: 0
+          maximum: 20
+
+      adi,excitation-current-microamp:
+        description: |
+          Excitation current in microamperes to be output to each excitation pin
+          specified by adi,excitation-pins property. If not provided and
+          adi,ac-excited is true, use predefined ACX1, ACX1 negated, ACX2, and
+          ACX2 negated signals to AC excite the bridge circuit. Those singals
+          are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+
+      adi,vbias:
+        type: boolean
+        description: |
+          For unbiased thermocouple applications, the voltage generated by the
+          thermocouple must be biased around some DC voltage. When present, this
+          property specifies a bias voltage of (AVDD + AVSS)/2 to be applied as
+          common-mode voltage for the sensor.
+
+      adi,power-down-switch-pin:
+        description: |
+          Number of the GPIO used as power-down switch for the bridge circuit.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1]
+
+  "^rtd@":
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+
+    properties:
+      diff-channels: true
+      bipolar: true
+
+      adi,sensor-type:
+        description: RTD sensor.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        const: 3
+
+      adi,excitation-pins:
+        description: |
+          ADC pins to use for RTD circuit excitation. Must describe a pair of
+          pins. E.g. <0 1>; <2 3>.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
+        items:
+          minimum: 0
+          maximum: 20
+
+      adi,excitation-current-microamp: true
+
+    required:
+      - adi,excitation-current-microamp
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - iovdd-supply
+  - spi-cpol
+  - spi-cpha
+
+allOf:
+  # Some devices don't have integrated DAC
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4190
+              - adi,ad4195
+    then:
+      properties:
+        ldac-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4170";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            spi-cpol;
+            spi-cpha;
+            avdd-supply = <&avdd>;
+            iovdd-supply = <&iovdd>;
+            interrupt-parent = <&gpio_in>;
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS input range
+            // Differential bipolar. If AVSS < 0V, differential true bipolar
+            channel@0 {
+                reg = <0>;
+                bipolar;
+                diff-channels = <0 1>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
+            // Pseudo-differential unipolar (fig. 2a)
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+                common-mode-channel = <24>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar (fig. 2b)
+            channel@2 {
+                reg = <2>;
+                bipolar;
+                single-channel = <3>;
+                common-mode-channel = <29>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar (fig. 2c)
+            channel@3 {
+                reg = <3>;
+                bipolar;
+                single-channel = <4>;
+                common-mode-channel = <24>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
+            channel@4 {
+                reg = <4>;
+                single-channel = <5>;
+                common-mode-channel = <29>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN- input range
+            // Pseudo-differential bipolar
+            channel@5 {
+                reg = <5>;
+                bipolar;
+                single-channel = <6>;
+                common-mode-channel = <29>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <0>;
+            };
+            // Weigh scale sensor
+            weighscale@6 {
+                reg = <6>;
+                bipolar;
+                diff-channels = <7 8>;
+                adi,sensor-type = /bits/ 8 <1>;
+                adi,ac-excited;
+                adi,excitation-pins = <17 18>, <19 20>;
+                adi,reference-select = /bits/ 8 <0>;
+            };
+        };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 030d90d38341..991b6e2e373a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1337,6 +1337,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
+ANALOG DEVICES INC AD4170 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
+
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
-- 
2.47.2



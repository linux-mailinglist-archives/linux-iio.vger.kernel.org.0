Return-Path: <linux-iio+bounces-18770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3AA9F0A1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D55A1309
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA226980C;
	Mon, 28 Apr 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iZBSE80O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284672673B7;
	Mon, 28 Apr 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843302; cv=none; b=tT6IgfHWdFcbLQzNMjBATL8KZSPnLDY3HkyCetoHdkO0cLiEWa4SvCGH7i2hSrN44m5WEc3GyW7Xyi0yRPMPzX8XC7Oujd2nLAuHstcK6Dh6w8Qgui43zOpLACnru3D/HShewM2hZW60JwQpIpFHTvIDuC9heMqG6xeBcsxFlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843302; c=relaxed/simple;
	bh=ocOux+Bgw1FRaRX7HrKb4TOUQBMYMgpopam+1Y6327k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXcq1QBsHaXUCjTZMWRRVC7QOOvNjCF43XpUzqk3JdxDY3ZEJKJO2meTgAflxGY/O7XVZoDISU3J6n0bOdEksWObv1Gqqmbe7XR90X1At9fDknDGeZf2XJa+5EFN0Y6TxBEZ1TI2KdM8BLHyazkpcT5UjMI+I4sOxJcl+LIzXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iZBSE80O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBimEb019160;
	Mon, 28 Apr 2025 08:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O2uzp
	UCuFfO1811EXJ7+Yi1TNfA8PakJAZurGXV+n+M=; b=iZBSE80OIdITGXTeUzHoJ
	P5v8jyCUxth1n12ALHf2hm3pCubD7JayCBrMZrOPKSHqe6iUB4pgihmRg1cd9jCq
	Sf+fbypPS269z1ibVDLPTOpPaMzGfbZ1G0lP+FqLZGgVc6XMMujoVK4KYbdZEB2g
	aURninFg8smAq8FTqmdGDNqk7X1YHNGwZqxkUTZ+VRYohIidtqv//juXuUxkfMjd
	e38pPAice9C5/iYy/CSwVNs7AFfTIs5/H7f70HqMuVgIOOmSxG5hSIs8x96FDup9
	tjfhE5jLoXJVwmtDBgLlNKntYj6HslHTrLkISuBWk16pGDLkowUWZGNWdZVTYpAg
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 468vd6wukw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:28:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53SCS3fd011777
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:28:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 28 Apr
 2025 08:28:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:28:02 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCRlwB032508;
	Mon, 28 Apr 2025 08:27:49 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/7] dt-bindings: iio: adc: Add AD4170
Date: Mon, 28 Apr 2025 09:27:46 -0300
Message-ID: <add7510bd4c9f83011ab949f4fae2c77f57fbc43.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9usvyA00_OUuKi29S4_lzOQPEsIfjB_x
X-Authority-Analysis: v=2.4 cv=b+Wy4sGx c=1 sm=1 tr=0 ts=680f7454 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=0xUbn-FgveO26dsu63oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMiBTYWx0ZWRfX2smSkMGzLIt4 D6kXEgEKLiYao7f8KOKFHcqxiptzJSorEHOYxtHSySDHZUxl8p2m0rfGn8DaY/dvehkzgpky5zQ a17k61m3VBOK6bAkVZIc/0JLuhvVOVs8yPX/Nr2O60TFMg/aS0yZF56RhKvO6Od+Y8g2N9CEJB0
 k928kyM34tBd7QEpeFN+21ng7fmUYZfL6vRDYKCaxwS1u68Q+vA8gE8/vbkPliKbkcKaHDoNLzU o9kZSbxtw0Bcgug4kidnbIgYlIRz3Z0m/yY0p9elNRE3aroHhI+BBpHLaiiig8v1o56oSITLNzu mWpo6DLiFx8+y5e+v4Gwhb+VkT7LaBA8Ffu0XEoXPsP+dXDs3lCea3EEBDu6voQot1yUrAMhQ8T
 /4pszitsMwJQ885Vo6lqQhqVCDlX5f852+jsNIthnBTlP6Zq/qD41r6b2nTz0jlxU4SWjFEa
X-Proofpoint-ORIG-GUID: 9usvyA00_OUuKi29S4_lzOQPEsIfjB_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280102

Add device tree documentation for AD4170 and similar sigma-delta ADCs.
The AD4170 is a 24-bit, multichannel, sigma-delta ADC.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
[device tree changes]
- Referenced adc.yaml from sensor-node.
- Merged property descriptions to reduce doc duplication.
- Every child node type is now in the example.
- Better described sensor-type property with a list of possible types.
- Updated adi,excitation-pins description to cover a use case I had overlooked.
- Added default to interrupt-names and to clock-names.
- Added support for clock-output-names
- Dropped '|' from descriptions when not needed.
- Added extra example
- 

 .../bindings/iio/adc/adi,ad4170.yaml          | 554 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
new file mode 100644
index 000000000000..679825be1f15
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
@@ -0,0 +1,554 @@
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
+    $ref: /schemas/iio/adc/adc.yaml#
+    description:
+      The AD4170 and similar designs have features to aid interfacing with weigh
+      scale, RTD, and thermocouple sensors. Each of those sensor types requires
+      either distinct wiring configuration or external circuitry for proper
+      sensor operation and can use different AD4170 functionality on their
+      setups. A key characteristic of those external sensors is that they must
+      be excited either by voltage supply or by AD4170 excitation signals. The
+      sensor can then be read through a pair of analog inputs. These properties
+      describe external sensor circuitry connected to the ADC.
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
+        description:
+          Defines the ADC input pins used to read sensor data. Only regular
+          analog input pins can be used.
+        items:
+          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]
+
+      bipolar: true
+
+      adi,sensor-type:
+        description: |
+          Type of sensor connected to the device. Depending on the sensor type
+          (weigh scale, RTD, or thermocouple) the values of sensor-node
+          properties have slightly different constraints. This property
+          specifies which particular external sensor is connected to the ADC so
+          the sensor-node properties can be properly parsed and verified. The
+          possible sensor types are:
+          0: weigh scale;
+          1: RTD;
+          2: thermocouple.
+        $ref: /schemas/types.yaml#/definitions/uint8
+
+      adi,reference-select:
+        description: |
+          Selects the reference source to use when converting on the specific
+          channel. Valid values are:
+          0: Differential reference voltage REFIN+ - REFIN−.
+          1: Differential reference voltage REFIN2+ - REFIN2−.
+          2: Internal 2.5V referece (REFOUT) relative to AVSS.
+          3: Analog supply voltage (AVDD) relative AVSS.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1, 2, 3]
+
+      adi,excitation-ac:
+        type: boolean
+        description:
+          Whether the external sensor has to be AC or DC excited.
+
+      adi,excitation-pins:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          Pins used to excite the sensor or external circuit that contains the
+          sensor. Thermocouples and RTD sensors are excited either with one
+          current source or with a pair of current sources to minimize the
+          excitation current mismatch and the excitation current drift matching
+          on the ADC. E.g. <0>; <1>; <0 1>. Load cell weigh scales may be
+          excited with one current source, a pair of excitation currents, or two
+          pairs of excitation currents. When four pins are defined, the first
+          two values specify the first pair and the last ones specify the second
+          pair of excitation currents. E.g. <0>; <0 1>; <0 1 2 3>.
+        items:
+          minimum: 0
+          maximum: 20
+
+      adi,excitation-current-microamp:
+        description:
+          Excitation current in microamperes to be output to each excitation pin
+          specified by adi,excitation-pins property. If not provided and
+          adi,excitation-ac is true, use predefined ACX1, ACX1 negated, ACX2,
+          and ACX2 negated signals to AC excite the bridge circuit. Those
+          singals are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,power-down-switch-pin:
+        description:
+          Number of the GPIO used as power-down switch for the bridge circuit.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        enum: [0, 1]
+
+      adi,vbias:
+        type: boolean
+        description:
+          For unbiased thermocouple applications, the voltage generated by the
+          thermocouple must be biased around some DC voltage. When present, this
+          property specifies a bias voltage of (AVDD + AVSS)/2 to be applied as
+          common-mode voltage for the sensor.
+
+    required:
+      - reg
+      - diff-channels
+      - bipolar
+      - adi,sensor-type
+      - adi,reference-select
+
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
+    description:
+      Specify which pin should be configured as Data Ready interrupt.
+    enum:
+      - sdo
+      - dig_aux1
+    default: sdo
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
+    default: ext-clk
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
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
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description:
+          The channel number.
+        minimum: 0
+        maximum: 15
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
+        default: 1
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
+        default: 1
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
+        const: 0
+
+      adi,excitation-pins: true
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
+        const: 1
+
+      adi,excitation-pins: true
+
+      adi,excitation-current-microamp: true
+
+    required:
+      - adi,excitation-pins
+      - adi,excitation-current-microamp
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
+    required:
+      - adi,excitation-pins
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
+            // Sample AIN0 with respect to DGND throughout AVDD/DGND input range
+            // Pseudo-differential unipolar
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+                common-mode-channel = <24>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Weigh scale sensor
+            weighscale@1 {
+                reg = <1>;
+                bipolar;
+                diff-channels = <1 2>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,reference-select = /bits/ 8 <0>;
+                adi,excitation-ac;
+                adi,excitation-pins = <19 20>;
+                adi,power-down-switch-pin = /bits/ 8 <0>;
+            };
+            // RTD sensor
+            rtd@2 {
+                reg = <2>;
+                bipolar;
+                diff-channels = <3 4>;
+                adi,sensor-type = /bits/ 8 <1>;
+                adi,reference-select = /bits/ 8 <0>;
+                adi,excitation-ac;
+                adi,excitation-pins = <5 6>;
+                adi,excitation-current-microamp = <500>;
+            };
+            // Thermocouple sensor
+            thermocouple@3 {
+                reg = <3>;
+                bipolar;
+                diff-channels = <7 8>;
+                adi,sensor-type = /bits/ 8 <2>;
+                adi,reference-select = /bits/ 8 <0>;
+                adi,excitation-pins = <18>;
+                adi,excitation-current-microamp = <500>;
+                adi,vbias;
+            };
+        };
+    };
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
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
+            // Pseudo-differential unipolar
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+                common-mode-channel = <24>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar
+            channel@2 {
+                reg = <2>;
+                bipolar;
+                single-channel = <3>;
+                common-mode-channel = <29>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar
+            channel@3 {
+                reg = <3>;
+                bipolar;
+                single-channel = <4>;
+                common-mode-channel = <24>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
+            channel@4 {
+                reg = <4>;
+                single-channel = <5>;
+                common-mode-channel = <29>;
+                adi,reference-select = /bits/ 8 <3>;
+            };
+            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN- input range
+            // Pseudo-differential bipolar
+            channel@5 {
+                reg = <5>;
+                bipolar;
+                single-channel = <6>;
+                common-mode-channel = <29>;
+                adi,reference-select = /bits/ 8 <0>;
+            };
+            // Weigh scale sensor
+            weighscale@6 {
+                reg = <6>;
+                bipolar;
+                diff-channels = <7 8>;
+                adi,reference-select = /bits/ 8 <0>;
+                adi,sensor-type = /bits/ 8 <0>;
+                adi,excitation-ac;
+                adi,excitation-pins = <17 18 19 20>;
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



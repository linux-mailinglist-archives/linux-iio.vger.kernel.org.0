Return-Path: <linux-iio+bounces-19486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D8AB54D3
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7287AC687
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E6268699;
	Tue, 13 May 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1vhiSDFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D87433C8;
	Tue, 13 May 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139661; cv=none; b=tRwqOeK4mKopF7ftEL65GzjmoQ7wG/TkR33170zWAIOSfS+Um1VLa8M48zCweCUGJ18ggyMSQ+u3qQqnv4bbBE666Qh2tMS0nv3iFdlVVInqDH/sxTxKGteb92XSOIrPwKGFPgUUp2d+UdLEBemDaVJR4DxOQ1r4b8FMCiyBvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139661; c=relaxed/simple;
	bh=imWSPaOXD9MeCqg/vjBPtip3n1AsC7/GDfvELLCNQ1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqoC3UfNqsNdQA4yzwSZtZ3Gyi7ryavBdacYG7CWLJH2UivNzVl2rcBGxdQEr/WC9kyCYQwZD9AktUv7Lf2wWHWs0AhWIUE6uCDLQYlYseyFVxnjNU5b633M7dnoh8gUyIfgBN/9ZEzyuBafaLwwcMYX4lPtB0t5iRBSBzcpMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1vhiSDFI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBMTUq007943;
	Tue, 13 May 2025 08:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/r5FV
	5HQTRpHspXnEoltgAt2Vpkpbz7Pm8vdzh3ZMSE=; b=1vhiSDFIfa667eN/DoyFn
	8nfxCgavFDhblF0UQ/BUx5VmLC6SHhxiWLbP2MBitkGxYmCkP6ylof1EWpMRQ7Zj
	dAvR+E7u8Nnp4U/XDwfnARFe8fL8XAcS2bDVOvV88ItW9Qm9F5h7bNZn07dVxFY+
	+QZF6NwewCpxjAfB8FK3yJ4buN06HgO+kxmRqktmiyfx1qQtzrUT6pQ65eF55m4H
	KVWUcgRiXa4z5aw90sWPBj1rtA9wk8uGGk1Nm5CtnMBc/xwuPYZ46Alo4glIvRt1
	uvgZQo6rZFPMdoh9UYNMd+spBHhAVbTi5awykfZDZ+XcnskehQLIa3KTkoAnsP7B
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46kx53aep0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:33:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCXvvE040937
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:33:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 May
 2025 08:33:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:33:57 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCXgHb007451;
	Tue, 13 May 2025 08:33:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Date: Tue, 13 May 2025 09:33:40 -0300
Message-ID: <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a4sw9VSF c=1 sm=1 tr=0 ts=68233c37 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=qjk4kMxMGZ-Z2-xVo1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: iB1SWDxRugx3S0CZhlzamogTx2ShpjVP
X-Proofpoint-GUID: iB1SWDxRugx3S0CZhlzamogTx2ShpjVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExOSBTYWx0ZWRfX+qd+qu7aCTwn
 eeRaz9+Cy+v3O1xh8MiINJ70HOt5xGBILowZW9IjU8eqBsTNDPnJ6YE5nKkBq8z9xqWGmBVSe9x
 /9On7ShJRrQIlWLrItHsZukip2EpT+70Cg3Td3G0U+w8erEISJxgL/Nus1tN2hrY7jIS+H/K+hm
 8ci2E4xbhfACvo+ZXL2ePMoOo+qML+OLYuu4pj1WjThz7aEwq+QMEQymhMy+NQX8/MjZ7Z41w4G
 kQ+Pgg3VvAHpZT4YdKJZNjD1xip9Y1Zuzs2JBoxSI6eFQoIPOdbSC1Yk8lh3tIbV5Jdl0bZJ2aB
 MK3hE9j14+9MHAzi7W9hlviXfsK3PPKh5t8LNO/UJpgpkiLdQHlCeTXoNVwHX+8ait6F51cm2TU
 Q7xrtoF/jRgVtMOYbTXXjvXC9Rl+yoxycnztORNwo0xyEzmyHvF7DZ8EvW8kQ0CFWc+6qNsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130119

Add device tree documentation for AD4170 and similar sigma-delta ADCs.
The AD4170 is a 24-bit, multichannel, sigma-delta ADC.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3

[device tree changes]
- Removed unneeded allOf.
- Removed occurences of adi,sensor-type type re-declaration.
- Created type for the AD4170 channels, allowing to avoid dt doc repetition.

 .../bindings/iio/adc/adi,ad4170.yaml          | 544 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
new file mode 100644
index 000000000000..0a06258b6631
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
@@ -0,0 +1,544 @@
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
+  ad4170-channel:
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description:
+      Common properties for configuring AD4170 channels.
+
+    properties:
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
+
+  sensor-node:
+    type: object
+    $ref: '#/$defs/ad4170-channel'
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
+    $ref: '#/$defs/ad4170-channel'
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
+    required:
+      - reg
+
+    oneOf:
+      - required: [single-channel]
+        properties:
+          diff-channels: false
+      - required: [diff-channels]
+        properties:
+          single-channel: false
+          common-mode-channel: false
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
index cc9582b14ced..0a8f2c7a139c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1346,6 +1346,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
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



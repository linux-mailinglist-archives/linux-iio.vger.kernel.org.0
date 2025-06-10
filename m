Return-Path: <linux-iio+bounces-20373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81ADAD43C6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5717D076
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EA265CAB;
	Tue, 10 Jun 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Beu408w8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADD26560C;
	Tue, 10 Jun 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587502; cv=none; b=Nfg5uG69J9+ldei6kjbU/j2n1enSplSFt4vMZwmhH7RM2EPwT+VVcvtxRyyG49ntago/cP9w9uBdsB2mgGNMxlAkh7euzat6U5RAIDEwJhQM56In1hcFFowlViNUZyUHCtqPW9/8FZNO6sX+mIOzrlhOB1Q2Ud+lQq6N7eKdmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587502; c=relaxed/simple;
	bh=L2HnyUZdQKv94TzgC8Hmv23ru/zdihrRP35Nhq+E25A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+xWAUkzxke6ouGV1MfsKkZUeTjU1oh1QmZtZHGV1Az6LBLuXiV6GH4UoSlsvOvLRM7NaZurkCpEEhF4h/QD4SCojI9MMFd5HQI86foi2dqfv5BiPsF0B1qQiCSOPCcpNmlGIvZsGCTVDtKV0Cx/nUn4+EGcRVnFKusb0AtS8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Beu408w8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIC13K012701;
	Tue, 10 Jun 2025 16:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xDcaW
	ulSI9Kxf4chNBrWlva4tNNO//i7Yb/8nwMtY7g=; b=Beu408w8fgaNkI+/Ct1oL
	p7CGwLjqEHe0ytbTENijOg4UQ7a8D8Kfe1LGf7Nm0qLhJAdcFqjEL6Ynl+oE27em
	46InVCnZ5D8CTZWYLQxkonGzidOJQc1dlIfdz2Qya4tbih7RWzVkL9nc8CoYsyAx
	njPRyXK/dA7LEXUlYBjcJndpecDPDkkvbOUEMze2XJBXyctrCrhumQUsHvdGRjNw
	IJi02QH/um6RfEAZHcNRUQ7vJqIwh/MqNnjyGnjt/7BIws5r/AuKraf5olnaMVKf
	l1cgV4EG7y9N/UjyJx+ZtZhqsRl5E/9WXfyyrNH7M7nWaJpUenRmts32q62yUYKT
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbk71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:31:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55AKVL1f040056
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:31:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:31:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:31:20 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKV4tp019875;
	Tue, 10 Jun 2025 16:31:07 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 01/11] dt-bindings: iio: adc: Add AD4170
Date: Tue, 10 Jun 2025 17:31:04 -0300
Message-ID: <4df9d4d0de83090300b6870afc8ae7b22279cd22.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: W80TTVqbHBjoSoewyrkbbIiTmRlCalGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX48YeRHqZm6Wz
 Ex6i5D9JbDHvEOnz+AjtWDVBaLul2Z5vJoGBlgENTX++Jgd5qkP/wdpUgciwRV74RfKL3Vp657w
 2wKupcB4BewneFvQNTwTD2QXZF7lxZlduk8SLpHKtb+jat7gkMRMXC+EwWyB1IcDHaAm1ISq2Uy
 Tu4+Swj0UHTgcD49AuOVhDZ4+ZIxMSHPDMxE4Eu4F4PdmsMu13BsnZuKcUWPFht0DbhC1y+h08R
 qU2ycHIpGBLSXKfDQs2T2tOeNVlvn0Yma4fYKqQiRTNvpt6yfoj5pGf+iEeK2G46rKv9ixtN30z
 xVL2mv7M6KwmoDqE2ALUHza16JKPpq+BTwdzVhRQ7axvzyYetQ4vlruA3Lm9j6WT3GQQUZNRPxg
 wduoGAhclqxFlD0fsEeVPmlH0z3FHU3F+yUdB21G2gYjmpsxTWUvVU7SgmD4RxH6HS4WDNZB
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=6848961a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=haS7VrJhTxLuUqK-jZ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: W80TTVqbHBjoSoewyrkbbIiTmRlCalGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

Add device tree documentation for AD4170 and similar sigma-delta ADCs.
The AD4170 is a 24-bit, multichannel, sigma-delta ADC.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Dropped interrupt maxItems constraint.
- Spelled out RC acronym in reference-buffer description.
- Require to specify interrupt-names when using interrupts.
- Added interrupt-names to the examples.
- Made adi,excitation-pin properties identical to adi,ad4130.
- Removed interrupt-parent props from the examples.

Proposing new types and ways of describing hardware for weigh scale load cells
and related sensors external to ADCs can lead to potential better description of
how those components connect to the ADC. However, we must use what already
exists for properties documenting features that are the same across different
devices. 

Maybe, we could use generic defs to define adi,excitation-current-n-microamp and
adi,excitation-pin and avoid repetition with those. Though, that triggers a
dt_binding_check warning. Also, having mixed notation (some prop declarations
using defines and others not) seems to not be desirable.

It looks like the only option left is making adi,excitation-pin properties
identical to adi,ad4130.

On one hand, dropping adi,excitation-pin defs and making those properties
identical to adi,ad4130 preserves their syntax and semantics accross
dt-bindings. OTOH, we end up with more text repetition in the doc.


 .../bindings/iio/adc/adi,ad4170.yaml          | 564 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
new file mode 100644
index 000000000000..e3249ec56a14
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
@@ -0,0 +1,564 @@
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
+  reference-buffer:
+    description: |
+      Enable precharge buffer, full buffer, or skip reference buffering of
+      the positive/negative voltage reference. Because the output impedance
+      of the source driving the voltage reference inputs may be dynamic,
+      resistive/capacitive combinations of those inputs can cause DC gain
+      errors if the reference inputs go unbuffered into the ADC. Enable
+      reference buffering if the provided reference source has dynamic high
+      impedance output. Note the absolute voltage allowed on REFINn+ and REFINn-
+      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buffers are
+      disabled but narrows to AVSS to AVDD when reference buffering is enabled
+      or in precharge mode. The valid options for this property are:
+      0: Reference precharge buffer.
+      1: Full reference buffering.
+      2: Bypass reference buffers (buffering disabled).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
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
+      Reference voltage supply for AVSS. If provided, describes the magnitude
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
+    description:
+      Interrupt for signaling the completion of conversion results. The data
+      ready signal (RDY) used as interrupt is by default provided on the SDO
+      pin. Alternatively, it can be provided on the DIG_AUX1 pin in which case
+      the chip disables the RDY function on SDO. Thus, there can be only one
+      data ready interrupt enabled at a time.
+
+  interrupt-names:
+    description:
+      Specify which pin should be configured as Data Ready interrupt.
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
+  adi,vbias-pins:
+    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 9
+    items:
+      minimum: 0
+      maximum: 8
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
+  # Require to specify the interrupt pin when using interrupts
+  - if:
+      required:
+        - interrupts
+    then:
+      required:
+        - interrupt-names
+
+  # If an external clock is set, the internal clock cannot go out and vice versa
+  - oneOf:
+      - required: [clocks]
+        properties:
+          '#clock-cells': false
+      - required: ['#clock-cells']
+        properties:
+          clocks: false
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    $ref: /schemas/iio/adc/adc.yaml#
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
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the
+          specific channel. Valid values are:
+          0: REFIN+/REFIN-
+          1: REFIN2+/REFIN2−
+          2: REFOUT/AVSS (internal reference)
+          3: AVDD/AVSS
+          If not specified, REFOUT/AVSS is used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 1
+
+      adi,positive-reference-buffer:
+        $ref: '#/$defs/reference-buffer'
+
+      adi,negative-reference-buffer:
+        $ref: '#/$defs/reference-buffer'
+
+      adi,sensor-type:
+        description:
+          The AD4170 and similar designs have features to aid interfacing with
+          load cell weigh scale, RTD, and thermocouple sensors. Each of those
+          sensor types requires either distinct wiring configuration or
+          external circuitry for proper sensor operation and can use different
+          ADC chip functionality on their setups. A key characteristic of those
+          external sensors is that they must be excited either by voltage supply
+          or by ADC chip excitation signals. The sensor can then be read through
+          a pair of analog inputs. This property specifies which particular
+          sensor type is connected to the ADC so it can be properly setup and
+          handled. Omit this property for conventional (not weigh scale, RTD, or
+          thermocouple) ADC channel setups.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [ weighscale, rtd, thermocouple ]
+
+      adi,excitation-pin-0:
+        description:
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 20
+        default: 0
+
+      adi,excitation-pin-1:
+        description:
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 20
+        default: 0
+
+      adi,excitation-pin-2:
+        description:
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 20
+        default: 0
+
+      adi,excitation-pin-3:
+        description:
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 20
+        default: 0
+
+      adi,excitation-current-0-microamp:
+        description:
+          Excitation current in microamperes to be applied to pin specified in
+          adi,excitation-pin-0 while this channel is active.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,excitation-current-1-microamp:
+        description:
+          Excitation current in microamperes to be applied to pin specified in
+          adi,excitation-pin-1 while this channel is active.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,excitation-current-2-microamp:
+        description:
+          Excitation current in microamperes to be applied to pin specified in
+          adi,excitation-pin-2 while this channel is active.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,excitation-current-3-microamp:
+        description:
+          Excitation current in microamperes to be applied to pin specified in
+          adi,excitation-pin-3 while this channel is active.
+        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
+        default: 0
+
+      adi,excitation-ac:
+        type: boolean
+        description:
+          Whether the external sensor has to be AC or DC excited. When omitted,
+          it is DC excited.
+
+    allOf:
+      - oneOf:
+          - required: [single-channel, common-mode-channel]
+            properties:
+              diff-channels: false
+          - required: [diff-channels]
+            properties:
+              single-channel: false
+              common-mode-channel: false
+      # Usual ADC channels don't need external circuitry excitation.
+      - if:
+          not:
+            required:
+              - adi,sensor-type
+        then:
+          properties:
+            adi,excitation-pin-0: false
+            adi,excitation-pin-1: false
+            adi,excitation-pin-2: false
+            adi,excitation-pin-3: false
+            adi,excitation-current-0-microamp: false
+            adi,excitation-current-1-microamp: false
+            adi,excitation-current-2-microamp: false
+            adi,excitation-current-3-microamp: false
+            adi,excitation-ac: false
+      # Weigh scale bridge AC excited with one pair of predefined signals.
+      - if:
+          allOf:
+            - properties:
+                adi,sensor-type:
+                  contains:
+                    const: weighscale
+            - required:
+                - adi,excitation-ac
+                - adi,excitation-pin-2
+                - adi,excitation-pin-3
+            - not:
+                required:
+                  - adi,excitation-current-2-microamp
+                  - adi,excitation-current-3-microamp
+        then:
+          properties:
+            adi,excitation-pin-2:
+              const: 19
+            adi,excitation-pin-3:
+              const: 20
+      # Weigh scale bridge AC excited with two pairs of predefined signals.
+      - if:
+          allOf:
+            - properties:
+                adi,sensor-type:
+                  contains:
+                    const: weighscale
+            - required:
+                - adi,excitation-ac
+                - adi,excitation-pin-0
+                - adi,excitation-pin-1
+                - adi,excitation-pin-2
+                - adi,excitation-pin-3
+            - not:
+                required:
+                  - adi,excitation-current-0-microamp
+                  - adi,excitation-current-1-microamp
+                  - adi,excitation-current-2-microamp
+                  - adi,excitation-current-3-microamp
+        then:
+          properties:
+            adi,excitation-pin-0:
+              const: 17
+            adi,excitation-pin-1:
+              const: 18
+            adi,excitation-pin-2:
+              const: 19
+            adi,excitation-pin-3:
+              const: 20
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - iovdd-supply
+  - spi-cpol
+  - spi-cpha
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
+            clocks = <&clk>;
+            clock-names = "xtal";
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "dig_aux1";
+            adi,vbias-pins = <7>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            // Sample AIN0 with respect to DGND throughout AVDD/DGND input range
+            // Pseudo-differential unipolar
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+                common-mode-channel = <24>;
+                adi,reference-select = <3>;
+            };
+            // Weigh scale sensor
+            channel@1 {
+                reg = <1>;
+                bipolar;
+                diff-channels = <1 2>;
+                adi,reference-select = <0>;
+                adi,positive-reference-buffer = <0>;
+                adi,negative-reference-buffer = <0>;
+                adi,sensor-type = "weighscale";
+                adi,excitation-pin-2 = <19>;
+                adi,excitation-pin-3 = <20>;
+                adi,excitation-ac;
+            };
+            // RTD sensor
+            channel@2 {
+                reg = <2>;
+                bipolar;
+                diff-channels = <3 4>;
+                adi,reference-select = <0>;
+                adi,sensor-type = "rtd";
+                adi,excitation-pin-0 = <5>;
+                adi,excitation-pin-1 = <6>;
+                adi,excitation-current-0-microamp = <500>;
+                adi,excitation-current-1-microamp = <500>;
+                adi,excitation-ac;
+            };
+            // Thermocouple sensor
+            channel@3 {
+                reg = <3>;
+                bipolar;
+                diff-channels = <7 8>;
+                adi,reference-select = <0>;
+                adi,sensor-type = "thermocouple";
+                adi,excitation-pin-0 = <18>;
+                adi,excitation-current-0-microamp = <500>;
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
+            #clock-cells = <0>;
+            clock-output-names = "ad4170-clk16mhz";
+            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "dig_aux1";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS input range
+            // Differential bipolar. If AVSS < 0V, differential true bipolar
+            channel@0 {
+                reg = <0>;
+                bipolar;
+                diff-channels = <0 1>;
+                adi,reference-select = <3>;
+            };
+            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
+            // Pseudo-differential unipolar
+            channel@1 {
+                reg = <1>;
+                single-channel = <2>;
+                common-mode-channel = <24>;
+                adi,reference-select = <3>;
+            };
+            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar
+            channel@2 {
+                reg = <2>;
+                bipolar;
+                single-channel = <3>;
+                common-mode-channel = <29>;
+                adi,reference-select = <3>;
+            };
+            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
+            // Pseudo-differential bipolar
+            channel@3 {
+                reg = <3>;
+                bipolar;
+                single-channel = <4>;
+                common-mode-channel = <24>;
+                adi,reference-select = <3>;
+            };
+            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS input range
+            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
+            channel@4 {
+                reg = <4>;
+                single-channel = <5>;
+                common-mode-channel = <29>;
+                adi,reference-select = <3>;
+            };
+            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN- input range
+            // Pseudo-differential bipolar
+            channel@5 {
+                reg = <5>;
+                bipolar;
+                single-channel = <6>;
+                common-mode-channel = <29>;
+                adi,reference-select = <0>;
+            };
+            // Weigh scale sensor
+            channel@6 {
+                reg = <6>;
+                bipolar;
+                diff-channels = <7 8>;
+                adi,reference-select = <0>;
+                adi,sensor-type = "weighscale";
+                adi,excitation-pin-0 = <17>;
+                adi,excitation-pin-1 = <18>;
+                adi,excitation-pin-2 = <19>;
+                adi,excitation-pin-3 = <20>;
+                adi,excitation-ac;
+            };
+        };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index abfd5ded8735..44735314a43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1392,6 +1392,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
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



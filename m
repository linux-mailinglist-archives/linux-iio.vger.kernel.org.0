Return-Path: <linux-iio+bounces-21813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30215B0C2D1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831643B29ED
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97D29B23E;
	Mon, 21 Jul 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mPJdcVXm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D58F5A;
	Mon, 21 Jul 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097121; cv=none; b=oexFUbZFqJ4wXilat9WD2Cgr5UF0e9rz/CHgElYJq8QgxiQghM20oBx3mQfRHudXwr6Ic/yhTXKDqjXq+yeLwiMgfrLG+ubnxOwlDEUSk5yWB4Bwn1XDjXXKq7w80/XSepxvTP7lR6Z7zDrvbJR+MOzXtLx0+KHVsjHBvZ3k/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097121; c=relaxed/simple;
	bh=Mtu4sydVVwA44pKiSAB2vEZtA88NYxuuc9S1FdKRag8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXhQzK0AYDFtykMS6B7Cmq0fBOuuPjcSCLpJVkkSRZGpu2GmwLH2wGFukYDM4Fsb186pTSCHWW+QI8SePy34s75FsMmHWQsfWFMzXtHIgZ/1nzeWQCgm0Cztp0ROvDp1gU9RlpS4ctoUibJf8YfkDUCehczvwZZ0o1HFNJzZjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mPJdcVXm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L7pSpY029805;
	Mon, 21 Jul 2025 07:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r11hO
	FN02frvqz5eMUA+zejBGDkqb4uv212FsNhxXpQ=; b=mPJdcVXmdG5eue0Kao7K2
	SIMCTzAF7N3ZrEmnvRB/CyndFytm6VD7XANkvjsjObpUzE4hhjxhzTUo16dOX2kd
	WJnqfCesGGbZLxTqwQHs2b70JKjjEifARwSxD1oMASx77+9eGZ5LiLQXhdgiGsB1
	MQEhwQCRWrmENP1uyd1LJoGKCD+zh6Z9dD3W0fLhd4qgk61+7grT29WnsahJap6+
	mjpw9yFWh+jnNG9egMEadVd4+r1rDSdnzQEBgq7H0UZOm/vmwz0QTvy8zUlRvTdr
	ULO716qoPzhjrK0QVcXqn+9qnSPtWpa4KjZfvlY+ESQUbW9uN8YVVMHl0Qma3Va+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 481e8a1vtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:25:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56LBPAuH033303
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Jul 2025 07:25:10 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 07:25:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 07:25:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 21 Jul 2025 07:25:09 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.210])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56LBOxBj007027;
	Mon, 21 Jul 2025 07:25:04 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/5] dt-bindings: iio: adc: add ade9000
Date: Mon, 21 Jul 2025 14:24:42 +0300
Message-ID: <20250721112455.23948-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721112455.23948-1-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RYI9r9zqec4M_Eq6DJS06qn52QkKjSQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMSBTYWx0ZWRfX2XQR85RgLBzn
 JaDfcNg/4A+Bvp/1E71MXTLAwLWvy+OmiXFIbgkRFjWTygcNj6AIBMgRRrryno7Nr5TiOsnRK5P
 hZwmLlUWxJssjh5PleDE6JN0Wg4azitA6OSPZYj59SztxDSLkQkJRxjt9Zz9dyD6ASe6T+BbT8b
 iNvWAkcCB3MKejjxKxuxDwbx1vHyG6bBvIrIJLmz3/RNnU/EPKZWh8TyjuDpw3AUkW+AEQSvv3M
 Rig2slLrUoF4RQN/qSl4850vYS27NGykm0SJ3yU6Z/LolmONXNklOuGh7L3jZ0zQxYT+x/Ru94I
 XKGOLeeKeJ4qZVSs9zIkmxHNo5ZmIP3fnUbV2zRjXHZjOy781MS5Ps2F4FvSeorrf5cuc93UuCC
 JQieNNFf0TfnHWnxzxWrhntoQlyHp5LTEu/COKpHl+p6Bb1ipU4vFDWJthtNCDvV1vhqN0JT
X-Authority-Analysis: v=2.4 cv=OdGYDgTY c=1 sm=1 tr=0 ts=687e2397 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=3FprAp7MOjnpz9ksV5oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: RYI9r9zqec4M_Eq6DJS06qn52QkKjSQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210101

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - move interrup-names near interrupts
 - remove properties related to the waveform buffer and make them runtime attributes
 - remove egy-time property and make it a runtime attribute.
 - remove wf-src and use filter_type in the driver.
 - add vref, vdd support.
 - use adc standard channels instead of phase channels.
 .../bindings/iio/adc/adi,ade9000.yaml         | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..0176252aae35
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ade9000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
+  quality monitoring device. Superior analog performance and a digital signal
+  processing (DSP) core enable accurate energy monitoring over a wide dynamic
+  range. An integrated high end reference ensures low drift over temperature
+  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
+  including a programmable gain amplifier (PGA) and an analog-to- digital
+  converter (ADC).
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ade9000
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: irq0
+      - const: irq1
+
+  reset-gpios:
+    description: |
+      Must be the device tree identifier of the RESET pin. As the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  vdd-supply: true
+
+  vref-supply: true
+
+patternProperties:
+  "^channel@[0-2]$":
+    $ref: /schemas/iio/adc/adc.yaml#
+    type: object
+
+    properties:
+      reg:
+        description: The channel number (0-2 for phases A, B, C)
+        minimum: 0
+        maximum: 2
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+  - interrupt-names
+  - vdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+          compatible = "adi,ade9000";
+          reg = <0>;
+          spi-max-frequency = <7000000>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+          interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>;
+          interrupt-names = "irq0", "irq1";
+          interrupt-parent = <&gpio>;
+          vdd-supply = <&vdd_reg>;
+
+          channel@0 {
+            reg = <0>;
+          };
+          channel@1 {
+            reg = <1>;
+          };
+          channel@2 {
+            reg = <2>;
+          };
+      };
+    };
-- 
2.49.0



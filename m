Return-Path: <linux-iio+bounces-21572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5064B02119
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E2AA62B9F
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629727A91D;
	Fri, 11 Jul 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BIoo57Bs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129227E054;
	Fri, 11 Jul 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249882; cv=none; b=jkJcLExzn6/8UiXgomF0PJ3Lhx6OxSleNQFSFySobo7SDu/ovkG0RGjUDsSDl3cyENmw0o4svPDQSdyeYG6qaI7vx0hW8lHmfLZnA0auklH/xUnK8maQqVeH7razuafBEzGJgsRVC9pX1BEk1CpfxSaVSlHDEYmilufIMh6v/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249882; c=relaxed/simple;
	bh=rMPl7osvpnDKIQsHWmkHxPuALl8UmId+rqkHr1SXsII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsFd7+dME2DHTzONzMFeVRq55ylF33xgRy/W5z38N8Z3XqexfNXwLiZT+IT52FHBBefb5nJpAdERW3NH19bo6p7VXLcvk25q8FGCWqUO4xHEsJaaEReZ8Id+1Pl00h0zSA7Ebp68i8uj/dYGoSDcPHLFI/+kAjaiajMWy+GU3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BIoo57Bs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAdTI2028522;
	Fri, 11 Jul 2025 09:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MxiLn
	2Dq3GFG355z0/Nng/qsnOYXFufcv0jLL3WMs8w=; b=BIoo57BsScLoD7yrIblyM
	AmKowQ+gkkQo3lh1FtDfN6pffX50OUITQryvPsN6ktiSMpfT+hwF4gUTD5YT0yH3
	NRnOYPeo9ykUeX/j+O+kuK0KQ95T3SrBTB3eZVZ6BsSsC+10Wek3SgyS3fDOgpBf
	VEz7+XfMj8aKsfhK4N7ELUppj6xV/nZW405YMPgIWLhCTlRlrt2Ss5tDClRtUUJR
	5jEa174EA82R2d+WW8wvOwujx+cmJEcSTxvPZxOJbbTNpwns8vl6lhCw3ORmVZ58
	+rOJAUTBVpiZ0yLB3UY4+o84b4NGbz8f7q8aBKy9WfvfvKfPDvqMqRsEAVbGtQiR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47t67qg6mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:03:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56BD3WT3026804
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Jul 2025 09:03:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 09:03:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 11 Jul 2025 09:03:32 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.132])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56BD3Jqs027484;
	Fri, 11 Jul 2025 09:03:26 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/3] dt-bindings: iio: adc: add ade9000
Date: Fri, 11 Jul 2025 16:02:36 +0300
Message-ID: <20250711130241.159143-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711130241.159143-1-antoniu.miclaus@analog.com>
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5MiBTYWx0ZWRfX8m0xBmwZPuPk
 SAhNZcj/uHxnAX7u5xLUiSX/ZhI+doDwuJLYvwSy5hfDIUca/TVf5fyxIWB8W1BmF+9rRCi6Nj1
 49TeMbOlOH+F88i446pZ1MnhRKRFeP4xVCroM8YcBSTwwgslF0xb08T0+qEVWtyNBYd9VpLTzI9
 pq/3s8lASpy89Jcbf+KRDR1zFySEfzvDvMX7SBDGGI2rdbyN7AYIofbtEAQxWvTrBmInHKWADFa
 BzhXkBQmMwwGEeVT7Cr8cnj97x84ViMQxu2CXRneBQL8SGeAz7tLL+ha561eSU0CK6PKp3FsS6E
 XM5Sl3hzqQaGgccBJkqdf2o2jMX1uKcPpPktSCwDJs2rczVzrC0fyYk54Sqp8Bv4ryKmMB1LIz7
 Mly7/YYVOOL6Ac0UIHWH8t595YweECb9/B103zVDcJGbzyS8HRjoipX/E3f3a3zENbfLdhV3
X-Proofpoint-GUID: fxzAegytvHms1fUkbp5wsjaGm3WSFtcq
X-Authority-Analysis: v=2.4 cv=eZc9f6EH c=1 sm=1 tr=0 ts=68710ba5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=FvKjBdGZVvLRywz4negA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: fxzAegytvHms1fUkbp5wsjaGm3WSFtcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=4 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=4 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110092

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/adc/adi,ade9000.yaml         | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..660dca4ea9b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,157 @@
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
+  reset-gpios:
+    description: |
+      Must be the device tree identifier of the RESET pin. As the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: irq0
+      - const: irq1
+
+  adi,wf-cap-en:
+    description: Enable fixed data rate for waveform buffer instead of resampled data
+    type: boolean
+
+  adi,wf-mode:
+    description: |
+      Waveform buffer filling and trigger mode.
+      0 - Stop when waveform buffer is full
+      1 - Continuous fill, stop only on enabled trigger events
+      2 - Continuous filling, center capture around enabled trigger events
+      3 - Streaming mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  adi,wf-src:
+    description: |
+      Waveform buffer data source selection.
+      0 - Sinc4 output, at 16 kSPS
+      1 - Reserved
+      2 - Sinc4 + IIR LPF output, at 4 kSPS
+      3 - Current and voltage channel waveform samples, processed by the DSP at 4 kSPS
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 3]
+
+  adi,wf-in-en:
+    description: Enable IN waveform samples readout from waveform buffer
+    type: boolean
+
+  adi,egy-time:
+    description: Energy accumulation time setting for energy registers
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+  - interrupt-names
+  - adi,wf-mode
+  - adi,wf-src
+
+additionalProperties: false
+
+patternProperties:
+  "^phase@[0-2]$":
+    type: object
+    description: |
+      Represents the external phases which are externally connected. Each phase
+      has a current, voltage and power component
+
+    properties:
+      reg:
+        description: |
+          The phase represented by a number
+          0 - Phase A
+          1 - Phase B
+          2 - Phase C
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ade9000";
+            reg = <0>;
+            spi-max-frequency = <7000000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "irq0", "irq1";
+            interrupt-parent = <&gpio>;
+
+            adi,wf-cap-en;
+            adi,wf-mode = <3>;
+            adi,wf-src = <3>;
+            adi,wf-in-en;
+
+            phase@0 {
+                reg = <0>;
+            };
+            phase@1 {
+                reg = <1>;
+            };
+            phase@2 {
+                reg = <2>;
+            };
+        };
+    };
+...
-- 
2.49.0



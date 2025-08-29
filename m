Return-Path: <linux-iio+bounces-23367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B1B3BA3C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A8EA20AA4
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3530C60A;
	Fri, 29 Aug 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jdFDjfXm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ACC229B1F;
	Fri, 29 Aug 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468383; cv=none; b=LWkjK46SiuS8uq0qVNAhKcz6NVsGBK4mD1uPptWKJd4PPOM5tfkWeQfH4kgZpU2dXxR2z7y3M+FVAcA4tgBOR36g5VROmBTSUxrsQLcuqhkafeZ7FuCBbBR3MeXh+tgROM3RiSM89Vbg4PfbnzhidzmFMU6SxgHCpNz5R16rGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468383; c=relaxed/simple;
	bh=3lzUKTizec/zKnMNluFoETLsmeQzPTvOo4e/7UFKuhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeF8sRdURohBsiQeS76InrICJGPGReBV5ErkHT9bbsjGhi7UYri/yFoeGvbza7QSiV8KwctKKsPqnKaAOSIgNgnnVjzhER2TUpSZb84Q02ONEXc3uBSAPuLJ8rX222wO4ckZyJD1YlsV8AKbaq3MB90OC71zZi1RjEszAo02RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jdFDjfXm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85N2O018095;
	Fri, 29 Aug 2025 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Lft+P
	+snCYViIEIkizTADQdMKCoLHzz8IhSiwCsRilA=; b=jdFDjfXmd26hcWiY0UkOe
	kl9MRtQ7+SLLQtd39/D5nNRD0XfmLUCLLPPmZIVKzWBgkaiPnin8Nb4K0SWfy1ku
	778Dpc0LJKpYl0vkTemBcjLEUQ77l1cT3sqyY5U40CRj7wfhroC3LcZye+xwZXRq
	NG0kjvK2HxpfKwPfG8ZJSzmSBFGNWNcr8aSLOK+9pK6WsAbhj+g0vc62B4mVrncN
	vjHgKJ7jbwTlfGbJ5MPfxGs3cJz5ObG2vu27oE6M5FSH7TV6Tw0AjQwu/eI4xoTc
	pN20mvA9ZIQYdGUWpQ0mrpY2PqWHqJtDl0U8KOFfMMoHV6eQ6yKqWUIVwZJl6Rm5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmag9ffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 07:52:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57TBqq31036263
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 07:52:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 07:52:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 07:52:52 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57TBqdAU017911;
	Fri, 29 Aug 2025 07:52:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 3/6] dt-bindings: iio: adc: add ade9000
Date: Fri, 29 Aug 2025 11:41:37 +0000
Message-ID: <20250829115227.47712-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115227.47712-1-antoniu.miclaus@analog.com>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfXxIVXPctve6rU
 8H6bSgUK9insszdGPzt5+gHRilCs3lrFbpaFDwKBP9ajBw+mHgt+LR9r9VVZrnFXqryOU6tC1LL
 pbioiisDcqATP3O5k/Y3XKbQj5XvHm8RcHTkKiu79tTIY2RrgQk5NDuyGB0GhEJRvF/sm0PSuNp
 PLYRGg93a/6l0h51OnVysy+3MY8zSgkfDsM6O0zu98jpGoHnh951X5iQ6oYDVb492D1M40YXDk/
 DUDJH9eQyQ8t+wGC3wiJvgcQ3deMyIktRoxZ1XyTL9gV3w+KFTndOcE+GUY5vdoAp73ZZHneYSL
 McYVvWGZMhsIiwbaZoNSYQExsrDpUBkmrBYs+5HIhGMzniYilwGugzXYPtbIp1Z8EeRnJ/BTRGx
 U+Lsila/
X-Proofpoint-ORIG-GUID: F5WURtojHFAeHQP5hQra5pa2oV_a4hVg
X-Proofpoint-GUID: F5WURtojHFAeHQP5hQra5pa2oV_a4hVg
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b19495 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=_AvCwROysrFvSXfO5EcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - fix title: remove "driver" from "High Performance, Polyphase Energy Metering driver"
 - improve interrupt-names property: change from free-form description to proper enum schema
   with items/enum structure and minItems constraint
 .../bindings/iio/adc/adi,ade9000.yaml         | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..6b6b9d7159db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
+  quality monitoring device. Superior analog performance and a digital signal
+  processing (DSP) core enable accurate energy monitoring over a wide dynamic
+  range. An integrated high end reference ensures low drift over temperature
+  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
+  including a programmable gain amplifier (PGA) and an analog-to-digital
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
+  spi-max-frequency:
+    maximum: 20000000
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      enum: [irq0, irq1, dready]
+    minItems: 1
+    maxItems: 3
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. As the line is
+      active low, it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  vdd-supply: true
+
+  vref-supply: true
+
+  clocks:
+    description: External clock source when not using crystal
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: clkin
+
+  "#clock-cells":
+    description:
+      ADE9000 can provide clock output via CLKOUT pin with external buffer.
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
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
+          #clock-cells = <0>;
+          reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+          interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>, <4 IRQ_TYPE_EDGE_FALLING>;
+          interrupt-names = "irq0", "irq1", "dready";
+          interrupt-parent = <&gpio>;
+          clocks = <&ext_clock_24576khz>;
+          clock-names = "clkin";
+          vdd-supply = <&vdd_reg>;
+      };
+    };
-- 
2.43.0



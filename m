Return-Path: <linux-iio+bounces-22457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6974B1EA07
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC933A99CE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9627EC99;
	Fri,  8 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fvXLT5h+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCB35898;
	Fri,  8 Aug 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662282; cv=none; b=LHhs67Nk1PnpWxc7Br5jjUxy0ojB4dVdzFjpAMQBrOjQj6TrKob1Hme7ZCG7J4H1tlLjKVlQAKI7QwAC0/NXmN549F751RUr4ffYUFPNJFodEowV5ghU2BD5lamosklPcsm9MQnsnHLgpjhpo7X5B4z8M4/nQUBKEN5Bz12Ug1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662282; c=relaxed/simple;
	bh=KAs8AHaKoZIQUHdO12/ubSD08/C4ZeWAt2aEgsInHrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVVBhOYc6wdHdHqXxG9zum8HxdpNkXCi4O1NGHMozwdgqEUp78bkWhVky6H/MgsRIUpsbM8osSNsEW5sEXoh03CdhtsylZhadneE06HWgsx2mKn6KHAAsgiotC+UPVUH8olmeXwK5BLZKkQfSc4XmX0MEtQPfDj+Eju/zzkyuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fvXLT5h+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DSKXX012268;
	Fri, 8 Aug 2025 10:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=W5J92
	kEHMxgIfPK4i+jw0Ktcv7hLsPEezmHa7yMVSUU=; b=fvXLT5h+PMtRwiX3SShjP
	7ZoUxb5YdaLNcrBwvujCWDBxCTg+HdrvqdUReHrytCOaNPX3cLLLVp/Yh9omQ/Hl
	4W5rrkzXC1UZG/w5AN9MI2VnHHVS4DBtnfwXAeqTaFh+C09uyUtbhNC0MLBwhR50
	Z8M3FPjUgkNLSFsjSysyKLju2tNyr9hXHYTinSRoqDjxGyeM5eGjPrECgnA7spgy
	3hcjD9HQnlC+CnzHqYRkoXb729XUR66cXD5g8ZqzHGHAarZLN0iG8A68H8bXdwh5
	TOjLWbn/6o3CdXFacTVUfzunolfCQt6GYCAUBK21qy7Dnx6FhRhSeD1Xi7akY7zw
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48d41gc0ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 10:11:05 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 578EB4BL062926
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Aug 2025 10:11:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 8 Aug
 2025 10:11:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 Aug 2025 10:11:03 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.94])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 578EAqfC014662;
	Fri, 8 Aug 2025 10:10:59 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/4] dt-bindings: iio: adc: add ade9000
Date: Fri, 8 Aug 2025 14:10:14 +0000
Message-ID: <20250808141020.4384-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808141020.4384-1-antoniu.miclaus@analog.com>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BsFJJYzOUiZAKeZGgblQBO2AHaqM8N8N
X-Proofpoint-GUID: BsFJJYzOUiZAKeZGgblQBO2AHaqM8N8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE3NiBTYWx0ZWRfX+hAno+eCtelk
 Fhri0bFweGwPkUMHmnJGHwR5Ta0ikOO1YMdXm2EvMguopqColKv78nK4KJbgXMPa4JL9XX4Rmv+
 Td8auYEZ8PQ5mljtnNeaRRZ7ab8F9ujFBSC3OEbu22IxQntcvV+sa1DWzYeaz9P7+P/J2hi+qVG
 H4InLGQDhml9KJ6/nCBJnfsPnH2meXs+uZcVYISNMXTd2dLLWo/siua7+YvDKQFbH/FhdfS+rZQ
 eHNvyBXWkzWQLBnzZDqc6dWSL2cDU7vuORorst/aRW0hh0QXs71ZcHCaqhe7OjR6Sc6gSkIf+iJ
 CerPfYBODZJLqhVChk5Dm0BDtuQdwJvTshomcbmx6//TI+j15KVA4woUmbiZvz+t7JIslwSvyiP
 5ejoii3u
X-Authority-Analysis: v=2.4 cv=Rq3FLDmK c=1 sm=1 tr=0 ts=68960579 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=bqcV9DLyIcn-n1PC1wcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070176

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - fix $id schema URL format
 - remove address/size-cells and channel subnodes
 - add dready interrupt support
 - add clock input/output support
 - simplify device tree structure
 .../bindings/iio/adc/adi,ade9000.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..07bc49acc920
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
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
+  spi-max-frequency:
+    maximum: 20000000
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: irq0
+      - const: irq1
+      - const: dready
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
+  clocks:
+    description: External clock source when not using crystal
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: clkin
+
+  "#clock-cells":
+    description: ADE9000 can provide clock output via CLKOUT pin with external buffer
+    const: 0
+
+  clock-output-names:
+    items:
+      - const: clkout
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
+          #clock-cells = <0>;
+          reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+          interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>, <4 IRQ_TYPE_EDGE_FALLING>;
+          interrupt-names = "irq0", "irq1", "dready";
+          interrupt-parent = <&gpio>;
+          /* Optional: external clock instead of crystal */
+          /* clocks = <&ext_clock_24576khz>; */
+          /* clock-names = "clkin"; */
+          clock-output-names = "clkout";
+          vdd-supply = <&vdd_reg>;
+      };
+    };
-- 
2.43.0



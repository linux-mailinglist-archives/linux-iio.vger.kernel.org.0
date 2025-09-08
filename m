Return-Path: <linux-iio+bounces-23881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C7B4857F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA11B20651
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42B2EBDD6;
	Mon,  8 Sep 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="d+b/de7v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87052E2EFC;
	Mon,  8 Sep 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316982; cv=none; b=LBRn1RPzRuT3Ng3FtGdOal4HDgeNHT3Ee++zAH66O3tb1qmiJLCyGlGRjedwo9M0PetBMzcQ5TMfKoeJeMInD5d9jBv8dXCSE2aC6UQptOy/aU4yVkZAf2VpXqF8Bl4Ojtitqde/ArvMzRngbfAknye+kfcAr+xiVvO6zpzeml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316982; c=relaxed/simple;
	bh=Jn6V+AEwc7CC0ffKiXzHfAqsC9IkRTzIzspx+OcmKq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emJs0M/13VyT4iXmjUrKAhwfX4gQQArBa4zy6TqG13KhGPIspHgwdXPEu+UPTnxz/eevStTKrhrn9rchHXfnzpnOf9ZW7Ouqd5b98iqIMY6j7nyMXyPdnireqcSyjBENo2AcvbIqmn9fQ5JSgkdSnILHOYXLufANtucGRueAjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=d+b/de7v; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588403RB005861;
	Mon, 8 Sep 2025 03:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nBmSj
	YinlLxzNCEpFHvdrYz5n9tRwrfunXazhluhcis=; b=d+b/de7vlkpFVNqROKIwy
	PqKHnPkBQ/0pYiKCghzgD4foXKX6gYPWA0ziib1Xth5p89ushokeYjUyHCAYDqKn
	HwEu9QJOSS/nNjpkuqcgylbMaLBjwWkbLjvnaku1m54FUxH3fh5D8ZLooxOmH4D1
	uoFUVThKwuZDgkGMArDYABU89gANO0PNDL7tZKKVGGMud5F5DsckrsVQzWfmC+dl
	F8+z3TJsD6M8yZIpHWz6gV6JjDxMe1w4y8/ClBZ/DUbF64x/WGVA4qSXqd/9KdRZ
	htrTlkorswYupjobO9QrlIHC4LpiqTw8bCQQOXsDWJOc0adl3yCpCgK+MCu3MyV2
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 491qqfgufu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887a9HH036463
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 03:36:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:36:09 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEf004718;
	Mon, 8 Sep 2025 03:36:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 3/6] dt-bindings: iio: adc: add ade9000
Date: Mon, 8 Sep 2025 07:35:23 +0000
Message-ID: <20250908073531.3639-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNSBTYWx0ZWRfX3WRkkJqiEKga
 qvbjou9iDBexdX86D8bTYsHxMxp0KuD1oVmh8ZXAzCy/YvBeuEbOuGaTZJxG9Jq7H+K3Ksq8pBq
 XXfWoNaTyVIMuiLdQNpP/H+/OU5EwOZXE49JK78DI9/18ubKtMjadKd0Py9ISwnkhzQMxHMs9Pk
 Z9whyqRVqRgm7WGJn+dvpuaTbuYS21VmQraN46WKMSKDt3hVDiW7qkvjGYj+OQhR7ciuRYnIgtA
 a0RQB5PpLk9k04XkyRyhammqPhOugmOocG/fWO3Z2oM+7UvFdryAcd/6gM2LaRnuxsDPGy7fivA
 TUI4/QTNnQzUY7mrPujW81SerokPhoC4sZmbPfUbELjxUP/DG3MtzG1Gl7aKEq7PhYN0wKWhHDq
 +/qgVeK2
X-Authority-Analysis: v=2.4 cv=EJkG00ZC c=1 sm=1 tr=0 ts=68be876a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=_AvCwROysrFvSXfO5EcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 5zFUPtNN0nj0dREVhNU9bZiq--7MoQZa
X-Proofpoint-GUID: 5zFUPtNN0nj0dREVhNU9bZiq--7MoQZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509080035

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - remove clock-names property and example usage
 .../bindings/iio/adc/adi,ade9000.yaml         | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..bd429552d568
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,95 @@
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
+          vdd-supply = <&vdd_reg>;
+      };
+    };
-- 
2.43.0



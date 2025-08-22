Return-Path: <linux-iio+bounces-23155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A5B3201D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304286265A1
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F627FD43;
	Fri, 22 Aug 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kTnc7spp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05C265623;
	Fri, 22 Aug 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878556; cv=none; b=N+IgBFsmdo/p13JWhpIKkCWqEMs7XWi1Pdl1S1u8w9wh3ycJABeA60N+WOn/Ldk2BNTzgeu12LaaGXS8TzWpaZhzE8kYHz40VsqxVbhoceYHIUtJnhHfYjZF298hVNwtlVAhnbbB9wJZ9RYZuJ14u2YHBBjuGNRYeMH+tNAMWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878556; c=relaxed/simple;
	bh=3Zei1DSwkNPV5Faqq+HUYq0Cw6F1eArsrPw6n1WrOEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myyNoW7/XRZk1DIxixqTBBtY7EFWVL+XaLQvh4gmzUkPRoljLiT2I/fyhm6AWz2iWyKkAsssHT5w8jTWXr+rPgUXqwtVgKlYstWQvTxAbllc423muGLCuGtl4DoOaONdytDFQMdi8oKUSKGUXQOivCfn/+t9eGVV4PNmhraqSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kTnc7spp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57METUDb023397;
	Fri, 22 Aug 2025 12:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IoVG+
	PCoJbfRxP5W6PYOWAtRrn3EOMllmajznPexEnM=; b=kTnc7sppUHwJKLhTh2g50
	JJHA+kOfxkPY1spMg7Ft/9QM4/ypaxaIqEzmWlDm3U9bqjHIMC7DT+7Eo6H7L7IM
	VW8usgME2mjHDDlAQeFZBY8TsUx4XrEAbtYWgvF5sovwb28ELGCs1L0QKVy+Q5LZ
	4ZTzSAyqqWemd2DoPsRbwdgt207LoJEC0yPG6E6RyMlrQlERM7F920vQAT9IJYHO
	239C51SSV8+9gWO756l/AMKNTcw3IFe2ta16yYcYCgQc+sKXcmaaQ2/Rmtp00Obb
	EfKesjY3Auuzx9P+CbrHC+cXAppIxp4iV1P6OlBc7jitLkaIFbI9T834qmsiT81q
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48ppn3sgkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2IKH058836
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 12:02:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:18 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263O000568;
	Fri, 22 Aug 2025 12:02:14 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 3/6] dt-bindings: iio: adc: add ade9000
Date: Fri, 22 Aug 2025 16:01:52 +0000
Message-ID: <20250822160157.5092-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822160157.5092-1-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA5NiBTYWx0ZWRfX9AiLSjtA5Euu
 OkImNmkmfpRSNLjW+jvkK8UsutEujkxUTHcA8x89TCSKxGdXsUzDBoYYT5IcaCblihrD10b04tv
 0M/cZETYnwcrN4aFf5dAXAOf61tGzlhdN2d4au7hgaANbpk0VZ7rMHyUFu17XghSmy1lRUVkGFN
 EpoaWxhWluvyQLHANHYp209fg26bvepsQQNfNVY5D4tpUCKR+qjwgR24xFwepC9v9qmGq0EDVdw
 gLFRyIQpxhBAfq2Lh5mjgjB+d7tGO3GO6JpS0L7HMwdX9JbVbdrL/aUMWqqL0YhBTuNM38oAFQH
 upBqD3gMwnFrgAXvv2WkmeAETSJZLeosD/s+iFhk7p7rWHEcG/wtNf+XKLbhJyf5lA8NKLaCQ7y
 lIJ9aosr7C9EI60UzWsI7Sw7YuwQfw==
X-Authority-Analysis: v=2.4 cv=frWFpF4f c=1 sm=1 tr=0 ts=68a8948b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=e6fWF6wrZI94LAapaBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: YCepNRAkM4sV01LD2fv9l1OjUFXDitL6
X-Proofpoint-ORIG-GUID: YCepNRAkM4sV01LD2fv9l1OjUFXDitL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508220096

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - remove clock-output-names property (simplified clock output)
 - make interrupts, reset-gpios, and interrupt-names optional (removed from required list)  
 - improve interrupt-names description to allow any subset of irq0, irq1, dready
 - fix typo in description ("ADE9000 s a" -> "ADE9000 is a")
 - fix spacing in description ("analog-to- digital" -> "analog-to-digital")
 - uncomment clock example in device tree example
 .../bindings/iio/adc/adi,ade9000.yaml         | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..a1513ad41651
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,97 @@
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
+    description: Optional interrupt names. Any subset of irq0, irq1, dready.
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



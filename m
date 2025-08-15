Return-Path: <linux-iio+bounces-22757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9EB27DB0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E97A240DF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D432FE58D;
	Fri, 15 Aug 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OomkCA79"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD62FDC33;
	Fri, 15 Aug 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251871; cv=none; b=IksmBp5DP3D8GdOdgJkysRbzqUsJITyxS1ndxYgewsCl5czYvFhmnJfFJ9JixCb+ksnkwu939mAS4F/IptliL3SiNopSRKADpqV0f6KLeBWymMI45joHDK0GZRXkHh4cSyWdYEsVE+Xe6Aeh9GdM+4QXiKpkbovvwD3b/9I/q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251871; c=relaxed/simple;
	bh=cMRtQs8cfZ6+5mCj9dYqRKNS7UxM9JCqwqEHTMHHLZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZhP01RFtdIUBypsXT4Cg6eKADI1JL8MZeuamvY5sAYPJhfD7CzR8l5Paz/+4xPEJdb22Swc7OKBm0NBzQO14ILL6SofPa0UdRXlK3wHyavZX/dA5GR+AR2PdD2LkqgKN0HBiPLPu1uSi5iWQ/Lp4Xmhd6NyOeflCRa6bFkjaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OomkCA79; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F8CTQe007622;
	Fri, 15 Aug 2025 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rdVPm
	PCRPC9Ijct0Xx3VySRYtBX9+zTf4aMdr3DmWzg=; b=OomkCA79WPo7fsVfGrpRd
	C1qjbByMAVT42JuLxLzL9Mug93MPKG52mbP7iSm7knuU0fUJd2EC1g2U832mSjbW
	xSeHrSiLEt/S6Ca4b59YxzbgC+aj6CTXNzhBCR2bdybGgsKFo7GJlvYlT1llNMe/
	X1IeqkR+pwhDZN34wc2/7bXHEoEBzV4YmnTh72dG6V6WI7bp/Tb/5U6P2mCGzUFV
	KZHi3F0uNjHEYetiPpg3vqnlsc/Wq3rEFrnJyQuImd4YX5IgMQjuuXY91CgoXWud
	ug5zfiyGgLUOuceEPWRJFtIJcncajetJD7H5xTWg2heDYEO+XdBDBFJ53REl7K8F
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48h51egp2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 05:57:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57F9vXdM034254
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Aug 2025 05:57:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 Aug 2025 05:57:33 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57F9vJiv027486;
	Fri, 15 Aug 2025 05:57:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 3/5] dt-bindings: iio: adc: add ade9000
Date: Fri, 15 Aug 2025 09:56:36 +0000
Message-ID: <20250815095713.9830-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815095713.9830-1-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=BNezrEQG c=1 sm=1 tr=0 ts=689f048e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=8b_J7m7iEcrdTsRiiqQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: Dg_hdnC_4EjpbW1jb06HQLbI8ehEZn5s
X-Proofpoint-ORIG-GUID: Dg_hdnC_4EjpbW1jb06HQLbI8ehEZn5s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDIyNCBTYWx0ZWRfX7JPc2gxdCMJb
 49T0ULGQ86ZWzudqckCY8p+6XbjGH3luiY/nXfVDDWgS5q6ghBx98vLUx8QrN96OitcQg/ONAW1
 ZsL2b3L+yPncv4EvATVNS0+ZMVN8VzZzwoNTDkpeHBfxSqyf3rflB669MuYrdZGV2zY4bCOxgiP
 uHKNQzPZeGNm5S8VeHRtVMSkm9sKbi1PASrbFuzkmMZbwbXGfuNObd1oIGrhfrIAystuxs2ysf9
 iFN21Kn30tRjcSqDdyR/uoiCpe7Un2F8kGN6g1uLzVJ1TIff1L7p5NiHHP54dNFno7MsycaLXML
 IzxoW1td67KJpynkceVatQeYhdzoNS8ueVYYi5GRQwYaGiQ5l/BQlcmkQon0vu52iCq0GkRlHUW
 Dx3CLvUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130224

Add devicetree bindings support for ade9000.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - improve description formatting (remove unnecessary pipe symbols)
 - move $ref to end and remove allOf section for cleaner structure
 .../bindings/iio/adc/adi,ade9000.yaml         | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
new file mode 100644
index 000000000000..bd374c0d57d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
@@ -0,0 +1,108 @@
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



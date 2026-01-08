Return-Path: <linux-iio+bounces-27552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F9D02D52
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF7DE3002D14
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC344B685;
	Thu,  8 Jan 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1IjPQGo9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F913FB22A;
	Thu,  8 Jan 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877154; cv=none; b=WYiHQ10WYuk5y4Nl8BbOZz0DSkn1rYr8MWWuhu1fiHUkJrjKVg/y6bKIuskefgDx6/bJ0IzGAZU/mn2+iGyTxhYd4dFkUONja8nk/C1l5/7l+eQThxpNaiGa+UZJa68oV3vakTajMGVWdiNKH5+uIuISGy4uXT40TAeA6P8TXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877154; c=relaxed/simple;
	bh=di1QNSZlZ73YeORmIBDjh7tZ2z+9Id2/QMJNfNh1Ao8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QREVe+JQB955E3wyMBuiaYavZEezxCYnEa42Y6q63MBYMhT3fdfc5mdwVDW/pCoW0GQfZU4efnCikdblTjTmiXrfWyHFggm0I25Typaquu9qo2UhDVlvyKL+7BlFtS1bbSIqBxHbOMkRI1ENJKzMbF4WTD9F+/QXjHetclRHNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1IjPQGo9; arc=none smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608CTiEv2385986;
	Thu, 8 Jan 2026 07:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=clcev
	mGfxB5F0HEIUTl8F/mXI7ZaC+MbGbwHAR0rF8w=; b=1IjPQGo9ONtHd1hGGKoTe
	HnxVgvJBZOgLeM86YAsN3+9g6f8DvZ3y+iDV9tQ3iXjlGKkUSX/39BBPR9Gm10+C
	q4afL9FEbb3fLfvBTL6FSmOJEXf2ZcLb7I7Y3fHtN+QMxtSFcedybVznvTdh8enh
	CWne5rez0k9nIVVuIHVjxnIswuP3AYsOsWNvtga+f7ceTx9WQjhpZwaGj8Ft6fHu
	GdUz06Nl5Bvsqk2TdcnxSEtMZ5isgLmoGZ5gCcksoL86UkHlHKoCLjQITLUN+9TM
	MzoQ7dmlcfvrV2kF50oU6fxiiPLmHkRLo6THm68vgSTEX+KmlaSq+NxlPqxoIeLB
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bjcmu86uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 07:58:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 608CwhYN033911
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Jan 2026 07:58:43 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 8 Jan 2026 07:58:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 8 Jan 2026 07:58:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 8 Jan 2026 07:58:43 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 608CwSiE012447;
	Thu, 8 Jan 2026 07:58:37 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 8 Jan 2026 13:58:23 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: Add max22007
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260108-max22007-dev-v2-1-2506c738784f@analog.com>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
In-Reply-To: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767877109; l=4953;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=di1QNSZlZ73YeORmIBDjh7tZ2z+9Id2/QMJNfNh1Ao8=;
 b=b+gycGiRiOmlgicBN1agGZq9vOrCGgHzg6jqNi+mrmRQ4xdpJwCB1/Iy+Wix3DtAOsShMd7dm
 c6LiXRu0vGeAaAmYYx2UCGn1cnS2LGMCZjKqe1Q70seTxrKTJhmo+bV
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MiBTYWx0ZWRfXyu5YHVC9TcDN
 o8tB1BdYZnZUnmNKdtRcUnuZJzrB9etFFZ7KeaChMZHdCl3KvEU3HtzMfYbLM8Ow5FWoFaeSrrY
 G2gjlJiq8slvyeWFBo/oz30pbmugHnoFfHP38vcvvTKbzzHO/XAqIGFe0DmmeEJCDIlb6FdnpD5
 lkGiXwve6sPRfaHz7QuEmAQmCemKTRnqbvpH9CEywaK1b22RHLl2CP8xE59207y6c2bJQhGnF42
 n5XnYjHq+de0bcJBDrz73EZkKYImvUYY0C8pOZkGlXBN/qdgWCgVezVGCWNHDv/apy1EURchPmi
 4fTOVXhTb2FrwXNm3Fb9zRv78bH6GQz5wB7AcE1Oa0yfJyoqHO6YC0veLdbvAkciBk3itgNH+9H
 uuyARvQmFYG52R3rzlMTKbEMT3QzsbKU74JMZXVSn5spizYXU3MfFTQG10xmRYdpNk6W2XzJpBt
 bEbhrJutifAiPN6P88Q==
X-Proofpoint-GUID: g1UhBNWHucPu78AAJ-qbby6w7YFgARRX
X-Authority-Analysis: v=2.4 cv=PP8COPqC c=1 sm=1 tr=0 ts=695faa05 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=5yLO_ytG1KKSPBdCm3cA:9
 a=QEXdDO2ut3YA:10 a=9pxso9FRmSwA:10 a=kMJE-xFm7jYA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: g1UhBNWHucPu78AAJ-qbby6w7YFgARRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080092

Devicetree bindings for MAX22007 4-channel 12-bit DAC that drives a
voltage or current output on each channel

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 136 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 143 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
new file mode 100644
index 000000000000..52c7c3217f90
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX22007 DAC
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description:
+  The MAX22007 is a quad-channel, 12-bit digital-to-analog converter (DAC)
+  with integrated precision output amplifiers and current output capability.
+  Each channel can be independently configured for voltage or current output.
+  Datasheet available at https://www.analog.com/en/products/max22007.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: adi,max22007
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 500000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd-supply:
+    description: Low-Voltage Power Supply from +2.7V to +5.5V.
+
+  hvdd-supply:
+    description:
+      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
+      the Output Channels.
+
+  hvss-supply:
+    description:
+      Optional Negative High-Voltage Power Supply from -2V to 0V for the Output
+      Channels. For most applications HVSS can be connected to GND (0V), but for
+      applications requiring output down to true 0V or 0mA, connect to a -2V supply.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Active low GPIO used for hardware reset.
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: /schemas/iio/dac/dac.yaml#
+    type: object
+    description:
+      Represents the external channels which are connected to the DAC.
+
+    properties:
+      reg:
+        description: Channel number
+        items:
+          minimum: 0
+          maximum: 3
+
+      adi,ch-func:
+        description:
+          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
+          output or CH_FUNC_CURRENT_OUTPUT for current output.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+
+    required:
+      - reg
+      - adi,ch-func
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - hvdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    vdd_reg: regulator-vdd {
+        compatible = "regulator-fixed";
+        regulator-name = "vdd-3v3";
+        regulator-min-microvolt = <3300000>;
+        regulator-max-microvolt = <3300000>;
+        regulator-always-on;
+    };
+
+    hvdd_reg: regulator-hvdd {
+        compatible = "regulator-fixed";
+        regulator-name = "hvdd-12v";
+        regulator-min-microvolt = <12000000>;
+        regulator-max-microvolt = <12000000>;
+        regulator-always-on;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,max22007";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vdd_reg>;
+            hvdd-supply = <&hvdd_reg>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 29340394ac9d..e1addbd21562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1593,6 +1593,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 F:	drivers/iio/dac/ad9739a.c
 
+ANALOG DEVICES INC MAX22007 DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0



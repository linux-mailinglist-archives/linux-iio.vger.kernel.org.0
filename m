Return-Path: <linux-iio+bounces-26800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD7CA823F
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A342932143FB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1179346E55;
	Fri,  5 Dec 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EZutgweg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419D3314CD;
	Fri,  5 Dec 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947580; cv=none; b=mK/UuCampxi9+ip7FSvORpAN4d7D1nWEvJjJeaJ94XNjX/3aS7+cI5DfZzRz48wPGKBb4/qWmuvLGGryLPrHUSzXudxLp+S/MmQ3DNJWh7JWRJI3LdFmeimGRaSnXTNCSe4ixeMrcok9b6cFtb0S/mIM/zqSxOtFRUeVnv/wWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947580; c=relaxed/simple;
	bh=8cFS9wcU9elYd9AHE97c9MMnPCepng2KGWXhBHTVzL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fnv7YeubFkvX8GnX1zmXb0iSfb/1LhrxlxGhBqyi5MN+E/NRIflsfwIqDqFSHmMLVBk9VyV2ptVJ8tAVPR5b4XBrW38SQdEJ8HcE4XChzbdBuHXkMVbFDu2H3RCPMhoN6BIKlw2jRmBfZsNhw50/brkH6SFvkgNIP5wmnSelsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EZutgweg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5BOHAB3489349;
	Fri, 5 Dec 2025 10:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wBTL3
	CQY6sFVZF8Ec8A5d+qydTwxqA18fim5T1p6c9A=; b=EZutgwegVwmdYm3rrI8Mj
	XS6kJUSpwvxW0ViEjPJBVI0dxfH0Ov2NKadnsNkxUqpU/jNGUDaFZ1Z/41zW2yWx
	oiX32OfluawWAtLduCSwDHysdnJGEKlQ7CMikeHBmPUYxlJiCE0ioDwFv9R/ty7R
	/tuYwqbzJkDuUpTAuPdWujlw9Mq76FqdEJUnee1Hj2XRbggLY4BfluYLYWny92e9
	rVwCWXCRc+q+3qyaXJcHezMP7mYgF3Yv/QxqVuFjJD2RrzPYFeR/8ibJDnjoy/A/
	cQow1GNd+R8oYt443oMZcNivEZFUInfIBzqXLjRQCm0PqMaPg/TS+5VZ/hmpBiUY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4auhvuv2gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:12:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5FCSTH033529
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 10:12:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 10:12:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 10:12:27 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5FC8SB029946;
	Fri, 5 Dec 2025 10:12:20 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 5 Dec 2025 16:12:02 +0100
Subject: [PATCH v3 1/9] dt-bindings: iio: adc: Add adi,ad4062
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-staging-ad4062-v3-1-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764947528; l=5088;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=8cFS9wcU9elYd9AHE97c9MMnPCepng2KGWXhBHTVzL8=;
 b=rwjsDJD4ZFlM7uRlzadRwnJ2RvzGK8u89+5x6yox9eQirSadOgIFw58f/QpSxdIp1bnzMrrDN
 /o6JagpkQF1DVjxDkRDnLh6HJRVdV+a4nTUlo28sumJOr48z4VlQzkF
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfX5TUakk26p82x
 A7PD3dUTvmVStF6m+2jjDsa4IibaVWqtB1Rz4iBh3s726lWeqNIOTXhNjvJmUuvajuRxm+UjTQS
 Bram//rHIxzwLoESci2yu4KcsxELTMLguVBcm1BU3Tu/OfW3J38nI4cnA5toFymxm7S1veNWCyn
 rHQ+L6Pd4ZzCEl3bGC7zD0gLCJbPM7SsqU7hvw/hHPra688zJN9LVlGSFoUOYEKXdo3f49rylY/
 nlsgcya/SUTmvyQWbIMZoefDmm8uFofknnDNtlrSo+i+Af7mW1JtbkNUZDY2c57N32Z8ndfc4H0
 0CBnb8R4sQhLSqkS1SdWk8qvoGC2FEJioHoX0sSr02PllcWx9k03ayrruGmzre9CRXNBAygcFpJ
 E0bTiJWEA7V5sfsvuTNDqXr01ibNzA==
X-Authority-Analysis: v=2.4 cv=Q+nfIo2a c=1 sm=1 tr=0 ts=6932f65d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=7dW3d56Owd-7Eugxv60A:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: lLAJ9WZ6-FUbcGzpA3oLnbVDb7R8nV9f
X-Proofpoint-GUID: lLAJ9WZ6-FUbcGzpA3oLnbVDb7R8nV9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050109

Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
monitor capabilities SAR ADCs. Each variant of the family differs in
resolution. The device contains two outputs (gp0, gp1). The outputs can
be configured for range of options, such as threshold and data ready.
The device uses a 2-wire I3C interface.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 124 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
new file mode 100644
index 0000000000000..a7a2ad761d1f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4062.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4062 ADC family device driver
+
+maintainers:
+  - Jorge Marques <jorge.marques@analog.com>
+
+description: |
+  Analog Devices AD4062 Single Channel Precision SAR ADC family
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4060.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4062.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4060
+      - adi,ad4062
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The interrupt pins are digital outputs that can be configured at runtime
+      as multiple interrupt signals. Each can be configured as GP_INTR, RDY,
+      DEV_EN, logic low, logic high and DEV_RDY (GP1 only). RDY is the
+      active-low data ready signal, indicates when new ADC data are ready to
+      read. DEV_EN synchronizes the enable and power-down states of signal
+      chain devices with the ADC sampling instant. DEV_RDY is an active-high
+      signal that indicates when the device is ready to accept serial interface
+      communications. In GP_INTR mode, the interrupt outputs one of the
+      threshold detection interrupt signals (MIN_INTR, MAX_INTR or either).
+    minItems: 1
+    items:
+      - description:
+          GP0 pin, cannot be configured as DEV_RDY.
+      - description:
+          GP1 pin, can be configured to any setting.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: gp0
+      - const: gp1
+
+  gpio-controller:
+    description:
+      Marks the device node as a GPIO controller. GPs not listed as interrupts
+      are exposed as a GPO.
+
+  '#gpio-cells':
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+  vdd-supply:
+    description: Analog power supply.
+
+  vio-supply:
+    description: Digital interface logic power supply.
+
+  ref-supply:
+    description:
+      Reference voltage to set the ADC full-scale range. If not present,
+      vdd-supply is used as the reference voltage.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vio-supply
+
+allOf:
+  - $ref: /schemas/i3c/i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        adc@0,2ee007c0000 {
+            reg = <0x0 0x2ee 0x7c0000>;
+            vdd-supply = <&vdd>;
+            vio-supply = <&vio>;
+            ref-supply = <&ref>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "gp0", "gp1";
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        adc@0,2ee007c0000 {
+            reg = <0x0 0x2ee 0x7c0000>;
+            vdd-supply = <&vdd>;
+            vio-supply = <&vio>;
+            ref-supply = <&ref>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d98efb1ad15..e22ba5ec8c849 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1432,6 +1432,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
+ANALOG DEVICES INC AD4062 DRIVER
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
+
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.51.1



Return-Path: <linux-iio+bounces-26409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E498C7F943
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6114E5358
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA42F7ACD;
	Mon, 24 Nov 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e692b7bh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A72E975F;
	Mon, 24 Nov 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975942; cv=none; b=WGZyawWcjfb21554WIFF6yW+7/6fV6U97+9mDlCo0Mv7uS2khGL1aujL7czRYU1+or0xysu6pEG4BA7zMffzRmU/I0Tft2VBH6/d49UStWlylmVBRVQSvrfmMiANNRzv5VMTlGiVPpBVQP4zT8kcK36PBXf7/UUG+RnikAK1Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975942; c=relaxed/simple;
	bh=aimic6kj2sqeybnlXxxmgqYOKreM6Xsl1lxRdNDh5rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Lf3YRf0Th0G5xKGHBstGom+vL+9y58Yfbla0Gr4Rzdy/mzge1pB/IfKRxEGVNbC7luh421eRGGTWGCu7juvCDhmEG15v97WvPpOdTXEm5jASYwdCHFXQtrquhxCUHFgO/t2e/Dm3xAQMvPGz0B1PrwKM+BudqMzhC5KPFGFp9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e692b7bh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO72rRs3692062;
	Mon, 24 Nov 2025 04:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1+k63
	l1rnim23b0NAkdD+DTOB1vy/YqvY+H9q5cXpiM=; b=e692b7bhq7xw8PQ2y2Jsx
	wD2byAhrhA9dThAH8aOv9YemnkakU+euESXmyeOqw1WS1xYlTGCgAFv1Y/2ZV6DW
	JZSTIxMs4VcF1XWSySputcVB/4qAqlMxTggIVr2WmCFoiVmnb1GO2wwjkK5Obko2
	h2ybUExkbsPRAPsUUMzBjIGrddc+rXhB+e1+LxwUu9yaBpfU73c/Mhkmi8qAEFnR
	k+Fy8sjYvy5QuROZG7tvqUejLt2hOzmHq8rzJY6ZUMfPwTEkr1mhUeHIUP0q62ii
	afWWO6dYcSm5H2fzph2WZB1t4QRxZ6SFOmpQo1WYc0TRth4zZJWsPwBUdTIs3I/S
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4akvcjmw7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 04:18:26 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AO9IP9m050879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Nov 2025 04:18:25 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 24 Nov 2025 04:18:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 24 Nov 2025 04:18:25 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.82])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AO9I8VK024016;
	Mon, 24 Nov 2025 04:18:18 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 24 Nov 2025 10:18:00 +0100
Subject: [PATCH v2 1/9] dt-bindings: iio: adc: Add adi,ad4062
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251124-staging-ad4062-v2-1-a375609afbb7@analog.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763975888; l=5123;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=aimic6kj2sqeybnlXxxmgqYOKreM6Xsl1lxRdNDh5rw=;
 b=8qUBq1a+HA6SOgh8zl/eDDPpOfmUWdRpkk25fNApLNHPRo0jw8f0HMJK/L0/M21AB6GJfFOQZ
 X6CZwC+ws6vA/tIPPx4K2mn7kczAqBCjpgj3G4zYrL008IWLt/iVOHU
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4MSBTYWx0ZWRfXz1bnTPtJGkZ9
 PRu1KwSr2PJe2SVEmiU+nMrRUasYAqjG7/IZRw30RHl2nShLLTPQdh2Zs5G9nibbRWGStjnZtNk
 PyjfHmt/p7z+rRgQO0MOWjKflqwDMzJE+tU62I9lbCm614rDaWq2Vt05Bwd9p8JDxCj8OQKcd7Z
 tkNNR105gsRWD86ZbOGdsh8irNZVMRMYARNGd+qu+LqzJ34YpvhtVhO3WQPJ64vX9FTYndLm+5s
 GajaHrszbCMUju/PZDjqit+tLzubLzV6qOuXnGSDm3wR5gRuutNFIbPl4I0QVVs5GXKLxxnAuAT
 Ad7P9lfTC5qQIltGpGnQ09nYLE1HEGSqAhlrkoZPaUtOhtzMCHyZS/H4cOBaVwsRo3IXsCA+JMm
 k/IZ0PBHs7uyIxXJdSIMXcD3IQ/s/w==
X-Authority-Analysis: v=2.4 cv=EqrfbCcA c=1 sm=1 tr=0 ts=692422e2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=7dW3d56Owd-7Eugxv60A:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 8oTHBlp9DO_FO_P1lCSlLoaRuM_fWyog
X-Proofpoint-GUID: 8oTHBlp9DO_FO_P1lCSlLoaRuM_fWyog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240081

Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
monitor capabilities SAR ADCs. Each variant of the family differs in
resolution. The device contains two outputs (gp0, gp1). The outputs can
be configured for range of options, such as threshold and data ready.
The device uses a 2-wire I3C interface.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 123 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
new file mode 100644
index 0000000000000..a25af66dd64d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
@@ -0,0 +1,123 @@
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
+          gp0, interrupt line for GP0 pin, cannot be configured as DEV_RDY.
+      - description:
+          gp1, interrupt line for GP1 pin, can be configured to any setting.
+
+  interrupt-names:
+    items:
+      - const: gp0
+      - const: gp1
+
+  gpio-controller:
+    description:
+      Marks the device node as a GPIO controller. GPs not listed in
+      interrupt-names are exposed as a GPO.
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



Return-Path: <linux-iio+bounces-25021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D1BD1CA0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1B418982B4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A32E92C0;
	Mon, 13 Oct 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Unp2aP/w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957D2E88B6;
	Mon, 13 Oct 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340558; cv=none; b=GLMNfztAyKtEfziPFonrEvyG4t2WkJhxTsWkVw4gJ3G9kerGWNmnRDDbQc0L+2g5lOfPj2+eIjRaZPML2D6X4oENM6N+pfmyxn68uI9VQ7WCRH2/2Zk8sguU9UcbcxlUI1890odv0lAtKpo51gr1m7P+1kUFYUhori3IMXp73Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340558; c=relaxed/simple;
	bh=zq4HJPH4Ik+VrMB3jcqaZGYWresdPxYsty42M68jY7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GRmODgUvmGXAES5RcSAytl1RVYsaJbgPd3Q+DToHRu2Dv8f3ire4dRCJxV2hKrTmnW/7uN5xPJJRnshbEAgdrP57ARD/m4lqGkZYJW2Tdu+z3MXo35zQMyOaj7LRuRZP8eYNFj6dz4C3JBe5x0Uex8CSeZucyx+o8piwX6LqcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Unp2aP/w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D3xRbi008597;
	Mon, 13 Oct 2025 03:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9KuYT
	UaBvHffgKSRdReIO44fW1IH7BW2farRK236LoM=; b=Unp2aP/wDZ+ti/A8q8mrO
	jGkbz6gL2RIkhIp085PaC51/i5X1Jx6Rq0d6yDAOOJWLoa2yHHcFj2+5/ffDmmDl
	eaXQEY6m8bm/ZTlTvsUB3IbgUQky+CooIyMft/3CndYtkMB1rKK5v5gdywU5U2UB
	LpcX7h3MPpPQYbW1rMCl4bAamjqJM9daWjwdY/tFJ03oiy6QeD0FsH9k30zanKot
	kLbrnTpd44MK0vToZfH5bptEub5PXy5331//0cbRDtebIsDVRF7hu7/SCtT8NA0H
	WpFCxV8s+ucvyl/Qp9TpN22iUHABOwo3YRk9WYQJYS+BEhjveR0MBA1InNrEp6xR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm508agh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:28:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59D7Swuf022856
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:28:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:28:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:28:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:28:57 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZ7013800;
	Mon, 13 Oct 2025 03:28:51 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:27:59 +0200
Subject: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
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
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=3739;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=zq4HJPH4Ik+VrMB3jcqaZGYWresdPxYsty42M68jY7Q=;
 b=JF/8DXxclaNzQF/SQ4zh0wPx2IluN0WOV2nckQx1MSD5AHmmEcIr+/dBfaAeS9R57FCuiBw5A
 axkF7965+hVCk4MLryoeN8U5xjtmU/3fGnOSRxT8dG8CH28v5UNgePG
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68ecaa3b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=rxM01w5YshE-YhStUuUA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfX/eldlg+o2QUs
 M4LIYD6S+3HlJIeQvyLTAyipuuEz85pOWRJju4SoDjin48BXQioOFOAtzn91719f9SiEeLWhI49
 JLC1UahKfqwym1mOyLwil3Z6tUhwAft14m+T6FmdvnFPr4U+zxj+qY4z9sTyvwyfFcdpwO8Wqu6
 myZxIXBzHZR8zmEf42HQ6h+DpJ4MXSJCrUNRkFhL6i4T7y5LaRqyxI70xTNr8SuiQB9sfEeorSa
 +gU2/32GGWXcD3fpcj8qPA6SJUWKSEf3SI+Yd6hpuEEcjPXah3lIryXfwi755fuptnngSKxDGRU
 eT5hTB4MWdoDPyBV3OTnAgYHzl9Fg/aZLNn3qNHLHj/hnnL54lpZEac/TXnu3yJI07Z8+ruaITS
 Wv9qRZ780V8vvRKfgyvZzjBfRhrqvA==
X-Proofpoint-GUID: 1yx3EDDicGaSwXZOKotEcleOvWIUskKY
X-Proofpoint-ORIG-GUID: 1yx3EDDicGaSwXZOKotEcleOvWIUskKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
monitor capabilities SAR ADCs. Each variant of the family differs in
granuality. The device contains two outputs (gp0, gp1). The outputs can
be configured for range of options, such as threshold and data ready.
The device uses a 2-wire I3C interface.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 83 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..dcf86088fc4f32de7ad681561a09bad2755af04c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
@@ -0,0 +1,83 @@
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
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: gp0
+        description: Signal coming from the GP0 pin.
+      - const: gp1
+        description: Signal coming from the GP1 pin.
+
+  vdd-supply:
+    description: Analog power supply.
+
+  vio-supply:
+    description: Digital interface logic power supply.
+
+  ref-supply:
+    description: |
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
+        ad4062: adc@0,2ee007c0000 {
+            reg = <0x0 0x2ee 0x7c0000>;
+            vdd-supply = <&vdd>;
+            vio-supply = <&vio>;
+            ref-supply = <&ref>;
+
+            gp1-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            gp0-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "gp0", "gp1";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f090c2f6e63a0d255a025885cc4573f5802ef159..afbfaeba5387b9fbfa9bf1443a059c47dd596d45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1400,6 +1400,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
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
2.49.0



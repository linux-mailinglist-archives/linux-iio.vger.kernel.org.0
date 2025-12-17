Return-Path: <linux-iio+bounces-27138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56247CC78CE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BE5A3085463
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF79341650;
	Wed, 17 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KEPwSgiv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9B33D6CE;
	Wed, 17 Dec 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973659; cv=none; b=fPHqIVhA9TXtV+v/RgN8v16oUtXVdzn9u/vugX9PRA/aRmFYOkYqHHi3icLF+NJMV86fweJ0RphpZykbTPoVb1/AFwvsZyWvbPVu0iWDczXiIBPYU6H/aqbqE9WKATiBs1/ElAGEqG0jTXaFVs4KGjY7w74YWPLFpFLXWpBThWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973659; c=relaxed/simple;
	bh=XMHgFlcph+hjiJBoruxvKS8ORHPLsT08GUu7BcsJ6w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=plGBWdw8Mr7pPqKPR7Hg46j4tz0M8u36OXU84MQ4JHexwkEe99z+SSwdx35gtjrlf6pvS7STFH92Eg50ViYuBULreo5COP8ceCtgW2sXfcXZ/F+lXOgboQSqE2f7+32mS3M62nB8BOHC77Mmphf8KS0pKsmoAUYi3cIh8s8SKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KEPwSgiv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAf3EL3838948;
	Wed, 17 Dec 2025 07:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=L+eIq
	togxlz1Wcn5tOARQmcvO0+cuebCV50KF8s+gGU=; b=KEPwSgivbzC1h06qDhAvq
	HE6NH8ECSFmo4hFM5silPHLTq9OqFJ3IKzn96Y/+75babhocn2nrcKLDzbF7XS6P
	oYPDu666NV9/yro6otrOcSrALHHFGgmcj9asd1Sdyy415rqlyOmN3jBiZoU5riw7
	FoJBFGi97a4kFmYh07vx6AxxLVUvmCWcjyV70EWfn+Lw0QWucOjTiJe1EKYKgCeM
	nUu3jnz9diuz08tHdU8DPwzrA+BY89AKi+kXzGlywuvUOIf1vbfq41nglKLyg5gY
	wbwY0XM7fXRiUhiebnuEirvR2bSi8F0d2MEJizEJqwvQtcfa4YFnlH3kjb9OGqtp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jeg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:13:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCDl8q041077
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:13:47 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:13:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:13:47 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUv7014815;
	Wed, 17 Dec 2025 07:13:40 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:24 +0100
Subject: [PATCH v4 1/9] dt-bindings: iio: adc: Add adi,ad4062
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-1-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=4736;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=XMHgFlcph+hjiJBoruxvKS8ORHPLsT08GUu7BcsJ6w0=;
 b=pJAqmwOOxZ5yFDLEHx1/4LjfZzQZWPVwIRzmpKbf4+5Mu8AUajGjEMWL050Jk79ek/uAoxLXu
 a8aXAOxh1GhCABcGFT+ShGvgMm58/T/+irUoV2s+1DlaN2A1kKc5d/C
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NCBTYWx0ZWRfX3eAa+ScZLljl
 8dTOaxXBhnKlSml6byxyTUse87M53eAoFrw/dnBXUtpus2ZHEZ53GF5OZPcZkeRZ2PZC7yK8MSr
 Wm0jS7E3enziUlgx+8hhj6opntNFrHDy0ILy5kHGMA6FpMj/Zy3IU0rdaCDdWTxIL2V1LnwTfJc
 FE/Iq621kYGkCvUUkZbpXP7/8W7IAIjJNFiNA6Q+e4Wr1ZRHFYL2W/XoCBtaLHJkXgXq2lMFGUQ
 xsiB/g5MzJ1qH9EImPAbq6MC4WX2CuAUISm4r+C5X896Ql3IibY/8d/j0UjGH3eiETdVjniedcy
 YbbMQoHw1oSw/jRVLhZrpmdisVxtHVrd+1gnGHIwKPF740/z6DmKWISEzjiGPCArJRwGQpwz+l+
 rLVjVq01f2XVy2RaLkyozdw5H7NNdw==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=69429e7c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=COXgcu1q7tYCwoEp4oAA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: PHjD3JXWfmEtTdbp81o3kVN4_3wFoPdn
X-Proofpoint-ORIG-GUID: PHjD3JXWfmEtTdbp81o3kVN4_3wFoPdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170094

Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
monitor capabilities SAR ADCs. Each variant of the family differs in
resolution. The device contains two outputs (gp0, gp1). The outputs can
be configured for range of options, such as threshold and data ready.
The device uses a 2-wire I3C interface.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 120 +++++++++++++++++++++
 MAINTAINERS                                        |   6 ++
 2 files changed, 126 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
new file mode 100644
index 0000000000000..eeb148081663c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
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
+      Two pins are available that can be configured as either a general purpose
+      digital output, device enable signal (used to synchronise other parts of
+      the signal chain with ADC sampling), device ready (GP1 only) or various
+      interrupt signals. If intended for use as a GPIO or device enable, will not
+      present here.
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
index 29340394ac9d7..bc1d6b2d0a11e 100644
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



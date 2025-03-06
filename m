Return-Path: <linux-iio+bounces-16473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73314A54CF1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670D63AF625
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7C170A23;
	Thu,  6 Mar 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RwcgJk3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F1156960;
	Thu,  6 Mar 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269898; cv=none; b=Yiq++J3Gc3sk47OSdl/WBBQiLn3EnHfDei8710CpzO4eVZT3FjvLbkp775Kv0Zhc/LDBegpfb0txQYUWv+dREOvTc7odwtHhHXfWEdbAlrWKzusoix9LxAu9Kogkkyi4RGoGXcaDakN1f2Q+FhatDypCmwQ2jABoCkEefzoKCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269898; c=relaxed/simple;
	bh=n3evAdrw8NhBZupO7CB86rFxf72ine59DlbjlpDvI2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QZK0ga2gmnnOKWL+nlMs1l/AcfNQqLXAiaVVcYAqddRRP2zLrB1EVdaMZOYvIo0dVg1MfQhQGqt9i/8ZcGMGX48Y5ncPEdV+mySi+uC5mNtrKvxKJ3y122ePZGN9CBqkWxi8uMBWuGuwyYPq0DsMtT+zzjvKsT2At3J/Kc9IETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RwcgJk3e; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526CCORT009815;
	Thu, 6 Mar 2025 09:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/ea1M
	p9kf8OygE9SY0tPH6JlchwJty4mLQRI7c88WWE=; b=RwcgJk3eRcswe8X/VYVyD
	Kyg0J8Q4PAVBAncoY2M4i6YeibSbz0TjvFecyCDKf3sTIineFsi48NcrRG8uoYUh
	Zz8Gw45rzU1u/FBx3XB3huOrVPJ/4hSYZunq4ekp8GyNIfzuWJKvjbEWQ5qzz4gX
	1QmWW7Ogb051mIG6YGVlKd9i0+W6xkxz98HDxsjEKXOqDGo2YDFFk5I/UwIRDArV
	FAy4D6UguGc0tviBmhooEn/mI7mfrdDz62ZYo75Zt1xnTBWj8+BBl9m7X2RDIPq3
	bWfBtdbeTgNobZmo3B0Rqoy/CufZ8izIN5pDewOSu0jiqN9Q/RVORMLxPgPnabbD
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 456j6dftgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:04:28 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526E4Rnp064958
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 09:04:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 09:04:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 09:04:26 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526E4CqT024033;
	Thu, 6 Mar 2025 09:04:21 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Thu, 6 Mar 2025 15:03:15 +0100
Subject: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
In-Reply-To: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741269851; l=3412;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=n3evAdrw8NhBZupO7CB86rFxf72ine59DlbjlpDvI2U=;
 b=cpQcI5XVYdf1oVt18cUbBSfrGecUOE6eYyyBOUk9u40dwVckcGxxCusg40X620AQDEUhVSZn7
 UEGepUnJNA+B41dFeJT3NjKgLaHTY/g9mLDgCUMncN0kxOpF9SuZkLN
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R+r5GcRX c=1 sm=1 tr=0 ts=67c9ab6c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=0CypkOm7ba8rlrjfvoEA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: 5wBbGz7A5rar3h7z8yEeYszR94OKaj18
X-Proofpoint-GUID: 5wBbGz7A5rar3h7z8yEeYszR94OKaj18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=6 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=6 mlxlogscore=999 impostorscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060107

Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
low-power with monitor capabilities SAR ADCs.
Contain selectable oversampling and sample rate, the latter for both
oversampling and monitor mode.
The monitor capability is exposed as an IIO threshold either direction
event.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 80 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4602f1f0184d58f33883852ff6d76933758825f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4052.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4052 ADC family device driver
+
+maintainers:
+  - Jorge Marques <jorge.marques@analog.com>
+
+description: |
+  Analog Devices AD4052 Single Channel Precision SAR ADC family
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4050
+      - adi,ad4052
+      - adi,ad4056
+      - adi,ad4058
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Reference clock
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: threshold events.
+      - description: device ready and data ready.
+
+  cnv-gpios:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 62500000
+
+  vdd-supply: true
+  vdd_1_8-supply: true
+  vio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4052";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
+                         <0 1 IRQ_TYPE_EDGE_RISING>;
+            cnv-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 06f122cb8bbd15a0076c229dfc89be0b5126f237..fef8adaee888d59e1aa3b3592dda5a8bea0b7677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1317,6 +1317,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
+ANALOG DEVICES INC AD4052 DRIVER
+M:	Jorge Marques <jorge.marques@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.48.1



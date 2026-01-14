Return-Path: <linux-iio+bounces-27788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C307D2027F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D4C0301D308
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0173A35A8;
	Wed, 14 Jan 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VTaN4h5Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F853A0B09;
	Wed, 14 Jan 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407510; cv=none; b=c19NFmIzpc0u8J+KTEi82g247Ak0BPP2QN9bjeC35Kk3CuAWgDSueczyOHWbkMHDinFwDKZEvyyqITwBIu4aAl6C099iZtNFH5zBqieakXcQSGb8eZ4inFQ+2LbBuKUGavtfv3MvHIJjbSHRop9s+CYfb2Pf37/HIeMzEF8ALlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407510; c=relaxed/simple;
	bh=cM/pSozUlh0F03Rifd3JdZjgJtyR6BKH3+9FVf+LNcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K0TOfgOP2aQL1xPbT1aYCvOyjFa7O0ucLFjfNe0wkc5VB1HmccEpaPxirdIlRLDAGp/QuR276lVQ8HdGMqKfLmABKos0HMiA+Oldgxae/ew3H8Msr7oI9KuA9L3/iMzPa4gu/XUp/z4XOXTjwCb36znKZKwrSNJ6c8c4s+b5YRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VTaN4h5Z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EGFbv33765820;
	Wed, 14 Jan 2026 11:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=M6dGC
	Quwiw8tJUQ+6HGk+lG3jCaj2mJpvvHeatD63V0=; b=VTaN4h5ZvqPuEcNKXNWHA
	Ak15GrX7lMJseBBFA1HIkUJhLCGC/r3aC4aPK6VQJn5VObojlDomLsMsw9C3x1Ku
	3hpnRF9qafEBOEBHYe/KzjpFJhqqWFS3hedpO1VyHCCqOW2Q/gaCl8Y8SLvT8uk/
	RysWekaqtNGye8zT3MULCZzkgo56hM/C2kTz3Z/g7LqNe9hmhyCCHiIX8VX2BH+8
	fNDDs0iyC7fTY7Axn5jjWXbW/aJtbuRGkl7k7TQnhCRAjWtakQE/Z99uFRFeLrnf
	FZY5SjfbSiie9UeS9pXxhU/EngzQt3fQKJqMTNSVG8wYijJaff/iJmrT0J66Xr7v
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau0bkk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 11:18:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EGI6al028130
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 11:18:06 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 11:18:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 11:18:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 11:18:06 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.126])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EGHmHV028201;
	Wed, 14 Jan 2026 11:18:00 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 14 Jan 2026 17:17:01 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: Add max22007
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260114-max22007-patch-v3-1-769298f50b8a@analog.com>
References: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
In-Reply-To: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, <gastmaier@gmail.com>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768407468; l=4492;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=cM/pSozUlh0F03Rifd3JdZjgJtyR6BKH3+9FVf+LNcA=;
 b=qJAVDpID+V/AEVV9qUA3sO1NccguroqZ8lLXhAtVdepwfXJrR3p3iS7tj2gJzr2cn7ohAsZjl
 CQznQ2PRwF7Drufwg3GiBiVeNE3Et2GRQGXJw8yF3J83An6xDylDOZA
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzNCBTYWx0ZWRfX5Uv5h1snG1qV
 6xQAdts0hPzrkSGj4nTrZgv5+pyJw0ujFl/cdktXHQjGyYeuvAGws7gMKALtvUB16af06vnofUc
 md1aKDdrCEopNZm9I2aYwZpkDE3xklb9HjsWnu+rhU76S/GJFg3qjGlhQn/Id6vBMNsz9TbknrE
 7VT+L/cJo0Tu4+ZC0q/K1kK3E67euqqcF82rQLlTa0oGozPWe0+GrvfDBE5LNyEQtVU1yOkwupI
 TlvFPHqgiiok4q0QwCfsc3ju0Mq7lu/lKl4ssSue8w9sHaNxr0hFSJLfK2A1lxsBI3j88ltYGd2
 lVnR/lCYbtG661MPIYrAr+n2LYocuWVvLcFDcziL5h0clE5mIZZ17AeEOtMM9xRFLymQ/dBFhdN
 Gk76iZvbwDpbWIAcDqcbgcwiO/5+u8AIZmh3nM8W0WOLxHSUBZAzBTEftfVb0FRdELSHCCTW5AH
 vzCQrxyqlrqYQ7hRxzg==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967c1c3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=5yLO_ytG1KKSPBdCm3cA:9
 a=QEXdDO2ut3YA:10 a=9pxso9FRmSwA:10 a=kMJE-xFm7jYA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: tB6ea68LAkA6F0lgcbklpfO1QWu99-17
X-Proofpoint-GUID: tB6ea68LAkA6F0lgcbklpfO1QWu99-17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140134

Devicetree bindings for MAX22007 4-channel
12-bit DAC that drives a voltage or current
output on each channel

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
 MAINTAINERS                                        |  15 +++
 2 files changed, 131 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
new file mode 100644
index 000000000000..c2f65d9e42d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX22007 DAC device driver
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
+      Negative High-Voltage Power Supply from -2V to 0V for the Output Channels.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO used for hardware reset of the device.
+
+patternProperties:
+  "^channel@[0-3]$":
+    allOf:
+      - $ref: /schemas/iio/dac/dac.yaml#
+      - type: object
+        description:
+          Represents the external channels which are connected to the DAC.
+          Channels not specified in the device tree will be powered off.
+
+        properties:
+          reg:
+            description: Channel number
+            maxItems: 1
+
+          adi,type:
+            description: Channel output type.
+            $ref: /schemas/types.yaml#/definitions/string
+            enum: [voltage, current]
+
+        required:
+          - reg
+          - adi,type
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required: [channel@0]
+  - required: [channel@1]
+  - required: [channel@2]
+  - required: [channel@3]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,max22007";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,type = "voltage";
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,type = "current";
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..c378d4b8f5ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1594,6 +1594,21 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 F:	drivers/iio/dac/ad9739a.c
 
+ANALOG DEVICES INC AD8460 DRIVER
+M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
+F:	drivers/iio/dac/ad8460.c
+
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



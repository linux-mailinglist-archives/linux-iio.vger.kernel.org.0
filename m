Return-Path: <linux-iio+bounces-5529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334B8D5E44
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 11:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2656B23071
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51881219;
	Fri, 31 May 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uPrMofPP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADE2032D;
	Fri, 31 May 2024 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147774; cv=none; b=FY2l94n2R8qi+KTnqFEMUuBsXhSQ0/AmzjiFKLn61LOCrGC0My9MAgRCZWfjq7qPf+AH6fTwqbXBewwdzsf3o924ZY3FrSlBb1DT/HdXZq/A0cMclbmPJsfMSbJtb74m8qm8Pq71Qu4nak5ZTCWm4pgJlvJWIi9uO42764GynM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147774; c=relaxed/simple;
	bh=EN3yAsbmjnvvPDgNC90DZ+p+kvaIL34JaNYFOwcvgsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIumBWxO3mGzMaDQDuG+5u3REmC09Lemj+gI7FGb1VJZWXnlBg141SdEU/XtDS7PN7JGWnYzhjNYRST/wawM7IkTcjRy6TEf4A+GspP+ii9EIGUT+CKl9pTu86uTVLeAWCKadyiyZPK43cPGyrhfjh3MO35iCLqFq/h+44qMblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uPrMofPP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V8p9aQ013187;
	Fri, 31 May 2024 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=t8hvnnR4gL7szMpPoyw0DjEfOAO
	Y0g/eXoIWy/G7HoQ=; b=uPrMofPPSilPfE8UMTu7ixypwlZ5OzY8OMzWMfs5Q0Q
	mUO/wtwIJ6HPa5qKKj5uuvQmokvFpKKTpK65JZ1uAqgEqFNyxu0J/eMfCbZm1UC4
	t48ArHNnw6npwW6ZL3uYGGymB8syQ1QxM3lp4dsqWsdMBvxfSAv9mNQ553M27nYf
	Uz5h+2lIiGpabuyIGvRp5Ej0z/ATQVH5DhNEBHPScal+OKc2ZLVgQXl4rxUafLJ5
	EU43PGhoroqSvs8YDH69KC+DrTTujU9SLfFcQWjQl5JyjkT2JaEz3Rw8Xj00hiIT
	YXmP4ItwYKIDcOylQpNUIIUy63yy5jdxr8zVJUx770A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yf60qh6rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:29:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44V9THKn046249
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 05:29:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 05:29:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 05:29:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 31 May 2024 05:29:16 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44V9T4nm001182;
	Fri, 31 May 2024 05:29:06 -0400
From: ranechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: ranechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: iio: adc: add a7779 doc
Date: Fri, 31 May 2024 12:26:59 +0300
Message-ID: <20240531092704.21255-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WIHj57tDlcTo0k9EgzQtG_-quuHgbV61
X-Proofpoint-GUID: WIHj57tDlcTo0k9EgzQtG_-quuHgbV61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310068

Add dt bindings for adc ad7779.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
 .../bindings/iio/adc/adi,ad7779.yaml          | 87 +++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
new file mode 100644
index 000000000000..0a57fda598e6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
+KernelVersion:  6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes. Only supported by
+		AD7771.
+
+		  * "sinc3"	- The digital sinc3 filter implements three main notches, one at
+				the maximum ODR (128 kHz or 32 kHz, depending on the
+				power mode) and another two at the ODR frequency selected to
+				stop noise aliasing into the pass band.
+
+		  * "sinc5"	- The sinc5 filter implements five notches, one at
+				the maximum ODR (128 kHz or 32 kHz, depending on the
+				power mode) and another four at the ODR frequency
+				selected to stop noise aliasing into the pass band.
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_type
+KernelVersion:  6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set the filter mode of the differential channel. The current sampling_frequency
+		is set according to the filter range. Only supported by AD7771.
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
new file mode 100644
index 000000000000..632e9ec0ab44
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD777X family 8-Channel, 24-Bit, Simultaneous Sampling ADCs
+
+maintainers:
+  - Ramona Nechita <ramona.nechita@analog.com>
+
+description: |
+  The AD777X family consist of 8-channel, simultaneous sampling analog-to-
+  digital converter (ADC). Eight full Σ-Δ ADCs are on-chip. The
+  AD7771 provides an ultralow input current to allow direct sensor
+  connection. Each input channel has a programmable gain stage
+  allowing gains of 1, 2, 4, and 8 to map lower amplitude sensor
+  outputs into the full-scale ADC input range, maximizing the
+  dynamic range of the signal chain.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7770.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7771.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7779.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7770
+      - adi,ad7771
+      - adi,ad7779
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency: true
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      ADC reference voltage supply
+
+  start-gpios:
+    description:
+      Pin that controls start synchronization pulse.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
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
+        adc@0 {
+          compatible = "adi,ad7779";
+          reg = <0>;
+          spi-max-frequency = <20000000>;
+          vref-supply = <&vref>;
+          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+          clocks = <&adc_clk>;
+        };
+    };
+...
-- 
2.43.0



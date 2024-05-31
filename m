Return-Path: <linux-iio+bounces-5538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F48D632B
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B1DB29E8C
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3C15B116;
	Fri, 31 May 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Mkk6SPnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815A15B0EB;
	Fri, 31 May 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162615; cv=none; b=knzD2l3ocORizMFONLE9MWNgx8D+KqXnwRhAouhhrAxfp8uO7AS83ocSZ6LjoGNyXl1S1A5J5mZu7HsLxbEtkODYnYUQJscfSJI+3HHS07QWecjEPP7Z32h6/kYsT0TCwx4nxdJZNk+EpzamonUMQO8LV2eTvO3XzAQNsCjbVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162615; c=relaxed/simple;
	bh=EN3yAsbmjnvvPDgNC90DZ+p+kvaIL34JaNYFOwcvgsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhEG+0C7u4oY78GPe8sUh3x4sdwtQSsar6cbC8GwFUkoAX4cRDDXMy+vpam5/Zp7Rv+ES4xVl4gVYAni0WMuRl0HzXquYeb7nx6E1hy8qiuq6PVxIm+FrjDGVIBY8yBp7pJuZtdt/CCqlEz36JgsZrX+kgUEA3vuaenftAJdu9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Mkk6SPnS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V7mcnW031851;
	Fri, 31 May 2024 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t8hvn
	nR4gL7szMpPoyw0DjEfOAOY0g/eXoIWy/G7HoQ=; b=Mkk6SPnSa0pkBMLuDkn3j
	Xge5Vyd0BpOTIJLAcImSoGW9Ob+uJ/SykkA+Jc/VuY4kAwWLfXR5Iz2ew0GFUVZO
	NfqeX4vJPA7nkwP6Yua/kxzjy9QXW5mewRWzJKD8OWkfRNApBFR0WAGEdkfiH9Co
	dHSZa5nGWYjUZec73vr4xkfGedn+/fBKD7mMIbwo6ebI2+HLfUib7wMmWaceZLSs
	by0uXKSY2FqfyniiOcgkNrsLYdI1/BGHstOhoI5/ojHowRA4p5TgnsTUU6/XP2wW
	c4QuHNHVLanKiXhUEoOc6AqM65uHIGo78MO5i1pqXLun2zKihYlAN3bco+PtsM8T
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yeddx7fcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:36:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44VDadmK064045
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 09:36:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 09:36:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 09:36:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 31 May 2024 09:36:37 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44VDaF87020041;
	Fri, 31 May 2024 09:36:29 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
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
Subject: [PATCH v3 1/1] dt-bindings: iio: adc: add a7779 doc
Date: Fri, 31 May 2024 16:35:52 +0300
Message-ID: <20240531133604.1380-2-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531133604.1380-1-ramona.nechita@analog.com>
References: <20240531133604.1380-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YVfwnGtMJP2R0bTZK6A60fAs0R7U31Ir
X-Proofpoint-ORIG-GUID: YVfwnGtMJP2R0bTZK6A60fAs0R7U31Ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405310100

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



Return-Path: <linux-iio+bounces-5169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358D8CC0CE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25771F23B7A
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B682497;
	Wed, 22 May 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YBGCOsGs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C22E419;
	Wed, 22 May 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379371; cv=none; b=uSDMphpQYdPlhVykjPDTGPfrmLbXzxbOv2dRR3ZNE7Vxka1z4YCeqBXbfQdnkLXw4oi0MyYHHtyymwzz0wo2RLADirolaaCNuikMmi6BHLJSANx9UncPcBzoAOc/UfQfLtap0bC7Y9WsFn5ZRCtiXUGnBkNHGVWwP22BP5q0GSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379371; c=relaxed/simple;
	bh=AylsLP65X8aXsqie5S2YlDUHlaH84sN449S9gHsNeNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UICOJzajl8aIpGpvFoOY9bShVrm1NWKPj1TyI6dGZxqqVTP50+P7Ekj516orU7hdnP/A5xs2Oi3YpbKsTGLnOAo5drDxv3gUo8Z5HQhaSPxKZw8CzsEgGbxUBTGHxvnklOlPnQUHzDnBKgRqzsHQTrlshMxIXowQ9i7zWuQTvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YBGCOsGs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M8dW4S001998;
	Wed, 22 May 2024 08:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=DKIM; bh=fPV+7rvFygyeWuVmJsu50ispp
	GbF3++ukyFG91/HleQ=; b=YBGCOsGsGnvkqamuy6nYrbjuSP4dy+oJegz/Rz6oS
	wwGNKUbe6kZ5ZhS7BNbxZ293P0HRE0XexJMjOzU+D81BzXnveUL08VDRRpz+0glk
	ycubP3YNZSYLtGuGFTv0FSBv7r90Nrk1+ntrMMCJ7/oBLzUurW8vdariMvdrE4qg
	BYwlTDfdlaJd4jEFvuuFaEnGXYX0cCKaG3yBWQycNPqdsg+yT/AMTFtb+4cuU3ox
	gBG81WaC5NlA7ycObr2DkU20xJvJ5vFyZI4ML9RBYcIP+GPG01wlnnXMsTYuhqUD
	1nLa9T4jN7l1v956tisvjhKmPSjeoYePb84N08vk7J6TA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3y9dd00kcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:02:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44MC2Vkt039734
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:02:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:02:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:02:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 08:02:30 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.137])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44MC2IO3019741;
	Wed, 22 May 2024 08:02:21 -0400
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
Subject: [PATCH] dt-bindings: iio: adc: add a7779 doc
Date: Wed, 22 May 2024 15:01:47 +0300
Message-ID: <20240522120208.18575-1-ramona.nechita@analog.com>
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
X-Proofpoint-ORIG-GUID: bnlzI0GHyRupb8EWAJshqisyv1A4vBVZ
X-Proofpoint-GUID: bnlzI0GHyRupb8EWAJshqisyv1A4vBVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220080

Add dt bindings for adc ad7779.

Signed-off-by: ranechita <ramona.nechita@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
 .../bindings/iio/adc/adi,ad7779.yaml          | 93 +++++++++++++++++++
 2 files changed, 116 insertions(+)
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
index 000000000000..7176674595fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -0,0 +1,93 @@
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
+  clock-names:
+    items:
+      - const: adc-clk
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
+  - clock-names
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
+          clock-names = "adc-clk";
+        };
+    };
+...
-- 
2.43.0



Return-Path: <linux-iio+bounces-5482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CD8D4694
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89844283E3B
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE9145354;
	Thu, 30 May 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SFmNCB+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03192144D19;
	Thu, 30 May 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055994; cv=none; b=KOQTR86qMqN3G8kmi6l2eJxnCH6+5muNn21+w3k4Sx8dPEnIoMkLNUZnILcGbqFuWG6n9Ae9NfUOccwQ/GmqQJwLTzCoupIACGPpD1lREElGGiInkkVJqiKjMXpthgmknxB4ck4iZTkDj4R+E8AINCon9z+GMsUF8qOTK8SXx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055994; c=relaxed/simple;
	bh=y34O+n2cvVg9mI48T2/50GEpCGRBxQck1cOVTU4jgkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TCyJ/JwuAgC71s5KU+N5CA0YaLsnvMTYcRxdKv40Hngn0v4vOBF6MefCuhjr62iQXqFb/uVjCCbGu/1u5w4bp4VSo2GgqTR4TgUtGTsLLWnN1ukV2zO1A/D7TH4Hzo9tCOwXy1W7x10myxRZYdtzgqlOs4cEwERdsHuBPKeMmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SFmNCB+x; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U3iAMq006282;
	Thu, 30 May 2024 03:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=epEtpMGIB0MJj90MgucXLQ+pdPs
	SY9Ub5laiXEvj9lI=; b=SFmNCB+x1f2vaWwqNQkGJdEUKn2oFSMR6noyntYhfyW
	rh66THRdjqgeiyZi5xUegv7oXrLHUpGsaA6FGt4BkkYm2h0tOXa23uSCdRc6kNVD
	eHQeFAiuPtW4R9aNs5LdIqpGokvLTtFNOCDq7dBkpBUWAAcCNRqOD5C7VJm/E52i
	Qgkoi3NJE2nK0EHHmAuzm5MZ6GqeofFLcdkEJzXxsM23zRbxXKQ0b+2jQnkELqAT
	mz1xTGCZ8dWg4q5/ytZaHq9zOZGsDm/voVdrTTiIGnosCR4CcqKXzyCw8z33jgEX
	zBXEx/kRkHxh0N9Pc5X48Y1XhSOxKvm/Hhvh7THHpgA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yehtj0scj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 03:59:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44U7xapo058364
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 03:59:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 03:59:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 03:59:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 30 May 2024 03:59:35 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44U7xMNn003065;
	Thu, 30 May 2024 03:59:24 -0400
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
Date: Thu, 30 May 2024 10:59:08 +0300
Message-ID: <20240530075914.28080-1-ramona.nechita@analog.com>
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
X-Proofpoint-GUID: Stg18O4oz10w7P7fLMJG8S8WU7zt_RAx
X-Proofpoint-ORIG-GUID: Stg18O4oz10w7P7fLMJG8S8WU7zt_RAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300058

Add dt bindings for adc ad7779.

Signed-off-by: ranechita <ramona.nechita@analog.com>
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



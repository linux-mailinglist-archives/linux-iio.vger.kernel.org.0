Return-Path: <linux-iio+bounces-7858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38393B45F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1959B23B35
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593C15CD7A;
	Wed, 24 Jul 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kdqn0RD8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544115CD74;
	Wed, 24 Jul 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836601; cv=none; b=HXoSTo1kvpjqZJ+q2ADcxIARKtjQPLD1IVwc72XfT8uvBwVnoaL7HeE1jAr9qH/yDXuh2kkIDsI2rWfjOpqkvmI+bWBhHnjmoZuyG2TrrDZK6veqJnc/rwcIXaO0Q32WTAKYC2bPExJZMTTeuM0/Zdfk0ZBcyOAz4/Jzomde55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836601; c=relaxed/simple;
	bh=V6IJXdwwbzbQkZkiTYsDSkZArE4aKFsCHVhaxKhZzUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy3Zp8WksKEkC6WRey51bvcuAP5kxubbs6v8bBryNx+HyEo9nqZ5Jgd7P2ZWtPNKm5QtnGVzC3NktvhXI3oP7Zj7A+LQqcWTXvJUuiGUIXRxbW7JMyVriodfkVidHXdFj7M03pSnD4uHA6hF3UXMviB2EUXIifLuQXR7U3F4GwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kdqn0RD8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OE1F2w017860;
	Wed, 24 Jul 2024 11:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=G61s2
	gXltmnCbGYhmVKdslBp1yi1BN6jjgQI+swq0Jg=; b=kdqn0RD8Myz8YFQBPUbZA
	JMJ57dag4Ig7lvJqaECTzy1qbtjjl1aBAc2pdtQDYksGoQFD3tqNIgUjdQKq91n1
	/MzI7ijmGwxS+UgNjnl8PyGe79p05y2sJjdGMq48cyb28OY9VfrVq3U5x9xZbtH1
	iJcfuaZbmuCSSKjgX1SON3RYCHPlhh2QKgZlZp2ASGgBe8xme5dVBRSW4pANxzni
	RAjOzII+vtdqFtZUslbSXJB5+f7G6bEWJMJG+OZ8M3TzkMFQMES5sHeL+8UJYdNi
	2t11oimwXsotkA2PNRmTa0oQH6WpCtQHfwFd3Kpzc/Z17UpjOd134f9y2Qb2/A6a
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40g732pts1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:56:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46OFuLRH046325
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jul 2024 11:56:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Jul 2024 11:56:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Jul 2024 11:56:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 24 Jul 2024 11:56:19 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46OFtP3Z002602;
	Wed, 24 Jul 2024 11:56:06 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Nuno Sa
	<nuno.sa@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        Liam Beguin <liambeguin@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: add a7779 doc
Date: Wed, 24 Jul 2024 18:54:39 +0300
Message-ID: <20240724155517.12470-3-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724155517.12470-1-ramona.nechita@analog.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: nx6lGGTVyV9KZvJ4N3z3n3ADKgQwMmia
X-Proofpoint-GUID: nx6lGGTVyV9KZvJ4N3z3n3ADKgQwMmia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240115

Add dt bindings for adc ad7779.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
new file mode 100644
index 000000000000..10a67644e915
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -0,0 +1,85 @@
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
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator to use as an external reference. If it does not exists the
+      internal reference will be used.
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
+          vref-supply = <&vref>;
+          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+          clocks = <&adc_clk>;
+        };
+    };
+...
-- 
2.43.0



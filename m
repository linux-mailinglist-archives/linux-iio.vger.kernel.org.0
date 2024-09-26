Return-Path: <linux-iio+bounces-9787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A439874D8
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D864A1F2721E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625A62171;
	Thu, 26 Sep 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RUGx57BY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582E1C687;
	Thu, 26 Sep 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358928; cv=none; b=LoRSY4rJ+UYhTaFhbHhSQx4+hDQdq6ryt+aAn4jZI5Kb0vrTUhtvqaO7zcrmqFdQ2VItLbXEDYSB09aOTtEW5dcWja18+RKxc2UbD+f1XB8Pk+wEU0hJw46LhfVIBCvJSY/51a4RQ0Tzagoxd7rLbu4kTtG2rzgnB17zgWH/WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358928; c=relaxed/simple;
	bh=q7N2bjAzwz6jmBYuTFZlXOND0jifu2DoiouiYc56z8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqsWYEw0+/fgU6eLE78VfxYGAO4fpV4jUb/EpHsH6M/vVq3OY7LqorMrkZk5sfJZjSWXem7ry/UEkYEYIMJ6fTiIvqLS9t/2HKrcpVOTAxaqAP2S6n8OmnqKbJ/QnL5sMKFy5z7kPeyVmOXNicaFypxWZYf+evBVHQS6ktewy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RUGx57BY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q9G3Ev030884;
	Thu, 26 Sep 2024 09:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lWFja
	TLFJZ+qVCmgODJd0mcIeBeStIa0may7itDYGCc=; b=RUGx57BYoXVbnMLI+xgwf
	QRZfXTLT2FT/1/cKwGvciJt5IZ+Dmmh/1Z5XNakIsjmjR0fjclKjGWo76aFTVH1X
	stgDx4ceZhVcRIXzu82Fcxw+Gie16r6N1ZaOPGFul1ozjMOlHqACyZOeNMk8xTwP
	m3A6IveK6mLklTQaN8inCoaxE+Gg0p16/awD26EZ0JMb09Zt1G/C9Y3nKwZ7gGCQ
	bTHQBf7VYWUBhrtE4VISQEOgHdYD3KnZT0sKH24QXaieM3IULpTNyzpohdTvU0Sl
	17RFTxykM+OUunb3ssxzlBHwsHQIB4ypPA1vb0k5iOJIWK49fwcUUvCk4FJChs9o
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41w4u110f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:55:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48QDswxm045776
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 09:54:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:54:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:54:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Sep 2024 09:54:58 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48QDsUFh028460;
	Thu, 26 Sep 2024 09:54:52 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Matteo Martelli
	<matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Ramona Nechita
	<ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: iio: adc: add a7779 doc
Date: Thu, 26 Sep 2024 16:53:55 +0300
Message-ID: <20240926135418.8342-2-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926135418.8342-1-ramona.nechita@analog.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jKSQF--soBEJurGd3jFgmVAOfbKT33zJ
X-Proofpoint-ORIG-GUID: jKSQF--soBEJurGd3jFgmVAOfbKT33zJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409260096

Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
family with eight full Σ-Δ ADCs on chip and ultra-low input
current to allow direct sensor connection.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
new file mode 100644
index 000000000000..044f92f39cfa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -0,0 +1,110 @@
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
+  avdd1-supply:
+    description: Front-End analog supply AVDD1. Can be used as conversion ref.
+
+  avdd2-supply:
+    description: AVDD2 Analog Supply from 2.2 V to 3.6 V.
+
+  avdd4-supply:
+    description: AVDD4 SAR Analog Supply and Reference Source.
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: |
+          adc_rdy: Interrupt line for DRDY signal which indicates the end of
+          conversion independently of the interface selected to read back the
+          Σ-∆ conversion.
+      - description: |
+          Alert: The chip includes self diagnostic features to guarantee the
+          correct operation. If an error is detected, the ALERT pin is pulled
+          high to generate an external interruption to the controller.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - adc_rdy
+        - alert
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
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad7779";
+          reg = <0>;
+          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+          interrupt-parent = <&intc>;
+          interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "adc_rdy";
+          clocks = <&adc_clk>;
+        };
+    };
+...
-- 
2.43.0



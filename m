Return-Path: <linux-iio+bounces-9462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392379768EC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD311C23725
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C161A2854;
	Thu, 12 Sep 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A5zCk07n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EF13D503;
	Thu, 12 Sep 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143456; cv=none; b=CbDtqkUTKtiICfMKB0g6wHcSzM5/ScD6pWWNRRwxwQvSrMQ+KxJU1LOqPW6JZcHgxRgd4vYFQYKolEmf3f5xzvNXtMJCB39nmuHzLJS6FjL1TYcaoSjz5TOVXZqAeImjTwOCJERUTgb7vB9o+LSuc4OGQbsMGCf7dzRhnlzamKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143456; c=relaxed/simple;
	bh=EZ5VgrzYWqn0EgdeV5/QaAh1ITg64JgFoBVVpNLdOvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e03K8XGTGT9NX0Bt4F94DEjag1qNcEHB6R8q8yMeqaHIspfary4KYyfz0I5Qznxbwon8XAMmjywdVSs63R9vAYeFgOH1dUDcdI6fCVk0o8XjcXH5jR5bqaDPMp6if7x/FoOXIsmGLyUz/YPRE35FgpilyBDYGVrdpS0772KOolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A5zCk07n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBICtc011535;
	Thu, 12 Sep 2024 08:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UkPbx
	m+dqBk1unCGWucpg6TFUPtrEpsDC6NGt+Lb38g=; b=A5zCk07nWRgwEhLeEIE89
	t76xCztJ6YD03xIPloMqY+s3Ukbv7a/MQlPGL6lZk4T8aRm1tfuTCyrKY7p+Yk8r
	IVL+A+Dt7uMutU5sp9sSdRBvaMFm9sZFA3r1tDKe/IZlUkPfBtZJZ8xfvkon3me7
	K4/Vdf7CQ1jg3K0tXb9c1sluH0Ijmhgrx6wC5iMfDj0vf7LxblOGumJEq9qnZqu3
	HuDxF7WBXIlZHRKD+Yws+dlvYuuTECaikYEQ8gd26/Ej9OsMjJ5IJgJvr+fdVSo3
	EDMEoBWHOp+fTWy00A3nJfbHLeTQx+HurAsqLiccaUvy9yoLkXqHfKyCfL5+ouHA
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41kya1863r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:17:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48CCHCwL012029
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Sep 2024 08:17:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 12 Sep
 2024 08:17:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Sep 2024 08:17:11 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com ([10.32.223.254])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48CCGg15009956;
	Thu, 12 Sep 2024 08:17:06 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nuno Sa
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Ramona Nechita
	<ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: add a7779 doc
Date: Thu, 12 Sep 2024 15:15:45 +0300
Message-ID: <20240912121609.13438-2-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912121609.13438-1-ramona.nechita@analog.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: iIinlky0IaAJSWQukaIerbmi5VUT-cWl
X-Proofpoint-GUID: iIinlky0IaAJSWQukaIerbmi5VUT-cWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409120088

Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
family with eight full Σ-Δ ADCs on chip and ultra-low input
current to allow direct sensor connection.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
new file mode 100644
index 000000000000..0ed5ec5dd8fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -0,0 +1,84 @@
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
+    description:
+      Interrupt line for DRDY signal which indicates the end of conversion
+      independently of the interface selected to read back the Σ-∆ conversion.
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



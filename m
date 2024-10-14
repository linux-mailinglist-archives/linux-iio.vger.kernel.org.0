Return-Path: <linux-iio+bounces-10569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB1A99CD79
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A52833C8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE617C77;
	Mon, 14 Oct 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a/oQ1WYO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308C1798C;
	Mon, 14 Oct 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916385; cv=none; b=L04YCVf6Ln2MkpGbcZ1k4uG4TDvMIH0iC5sYc1ZYUh8Mt7PCi0hUl5HOA5LnWYQ29jEgkvUSOIyU49aBsf/jOMq1gfsvmgiD0/H5nCdZv30iFGMO3Sflz+98+Y8/jEhzDcNzwFhbLNr5GK7uMyAaKrSJ58V6FAHPeeYYQzZw8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916385; c=relaxed/simple;
	bh=q7N2bjAzwz6jmBYuTFZlXOND0jifu2DoiouiYc56z8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqqaZ/RIOhj+QiDJXHDEjpR2sJ5XOCzs01W7GPajcI+LmXP0cfuyalDAGPDe1tekRPbg0cqlqKy8ar+umO1jOBNZwWdm9cI3nw024K7MM9DnwWiuP5BMTRjWjuJNkdgEh7JImMDDjKgFxhmrY52hawVH6XMl8twgyZmZqdCCYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a/oQ1WYO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9v8PA017513;
	Mon, 14 Oct 2024 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lWFja
	TLFJZ+qVCmgODJd0mcIeBeStIa0may7itDYGCc=; b=a/oQ1WYO7Rz8+XsgsIrYY
	bdokuivelGDe12x37JtoLfWMDvLA5RvriQ5EAaEadZuF0lwqsZMajTJ1pbGHmBnr
	SJny3NmsFL7rElTT9RPifmfWJY+aorIgLtCG+noaOl1is8A1TBLpKL7uJeRhc1uS
	tdcqklGr3o9aS7cOXqzMPeHBoqEM4q3NjWe+NLsZ5X4saxfJHdg+BVHVaYEDcEev
	ywUNPJXyI+RCO82vDqNze3q561pou6Kiwlg7YFbn0CxJNmFjgVRJmyvw3Tew5iu5
	dt5xMlMPVwa+9SIO7zMUEeTlJTiQCd1OC8ZXBX86Wrf6IBJ3ARqgwaYZZVZGO8mu
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42914arwmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 10:32:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49EEWhkE041585
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 10:32:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 14 Oct 2024 10:32:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 14 Oct 2024 10:32:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 10:32:43 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49EEW6bB014258;
	Mon, 14 Oct 2024 10:32:38 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
        Ana-Maria Cusco
	<ana-maria.cusco@analog.com>,
        George Mois <george.mois@analog.com>,
        "Ramona
 Alexandra Nechita" <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 1/3] dt-bindings: iio: adc: add a7779 doc
Date: Mon, 14 Oct 2024 17:31:58 +0300
Message-ID: <20241014143204.30195-2-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014143204.30195-1-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SzVkzzuaD6a8lcRv51O6KD3xB5M9TF-4
X-Proofpoint-ORIG-GUID: SzVkzzuaD6a8lcRv51O6KD3xB5M9TF-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140106

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



Return-Path: <linux-iio+bounces-6578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87290EB04
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4B280D09
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83893142E78;
	Wed, 19 Jun 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KbJlBMIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F511411D5;
	Wed, 19 Jun 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799770; cv=none; b=LF4MUS55XS6mS5s5kKXRyJc1cAeoxoZ/AU2f3yjxZBpn1HURmTJt+ReMhDJ7qTfh149DiW0E1Q915D/pNzjEJSHfelU+9Na93amXPCJVsNmjXoss1Mmi1SjJRgB/nj30FQOSVsnvsUgisJdZEN/rvjJwQuTHAY9+4sl66oWIp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799770; c=relaxed/simple;
	bh=p/TXh0Cc0A8idBflT14MkDr+diErp80p0XLgANjOJkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKzlkPinz41jxaK5DiHIYldHIO5YB3KqwGQD9dX+OhtlP8Ofkw2h1AfCNbL7GW/X4wHNjIu6PpkLKzN0VgEa2EV3zI5l3jiL1vylULq+NtjN+qXpSCudYpc2ZwdQ0gUxKN/+4W3OfXzonzw8lX0eV+CDvS3QdH6XgBtt2Iw+v2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KbJlBMIT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9PBg4028427;
	Wed, 19 Jun 2024 08:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MdzwG
	0VEmRocAsqibCKJjSDOfApOYxQOfvUxRnuDpCU=; b=KbJlBMITXHuLzvT/3F4nS
	euLHkOxyXxClnjFFDdL4ub7ZG+7o0RalGyrYKO3Ird8drsJqzO24fvphHpBNWNXd
	hAtFxd/PK9+20//wfTMEjPc1kOVpwG2QkFnmC/x/ZzN6yrb9KrOTRuAdDEmw/wSX
	MgM6vVmWdWiLpl/iTwlAD7gsU8PxHDhlDUiVPERiYG9mbwEMru/wwFo5cvRdv0wP
	NX45AUmX0EwTmi+C/QEbIKZsTBirs2LXaUM4+DSwoXfw79MI9HUaKkMKC+CuXkuS
	Z6qt499Crz2aSgK4l+P/7gCxGBDzLV6G2qajYLAYXkEEZprZn1NFPlu/ZbLgkbJJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8satjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:22:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45JCMRPj057252
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 08:22:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 19 Jun
 2024 08:22:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jun 2024 08:22:26 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45JCLWwA017121;
	Wed, 19 Jun 2024 08:22:18 -0400
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
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>, Maksim Kiselev <bigunclemax@gmail.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Okan Sahin
	<okan.sahin@analog.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: add a7779 doc
Date: Wed, 19 Jun 2024 15:20:44 +0300
Message-ID: <20240619122105.22642-2-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619122105.22642-1-ramona.nechita@analog.com>
References: <20240619122105.22642-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AomYQTzuoR_BJrjENTjqShqK-Yh_kBDZ
X-Proofpoint-ORIG-GUID: AomYQTzuoR_BJrjENTjqShqK-Yh_kBDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190092

Add dt bindings for adc ad7779.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
new file mode 100644
index 000000000000..f1eec656acec
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
+- |
+  #include <dt-bindings/gpio/gpio.h>
+  spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7779";
+        reg = <0>;
+        vref-supply = <&vref>;
+        start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+        reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+        clocks = <&adc_clk>;
+      };
+  };
+...
-- 
2.43.0



Return-Path: <linux-iio+bounces-20246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD2ACF2E2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A691B7AB3E0
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F4278E5D;
	Thu,  5 Jun 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Rm0iZ/qK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C623277819;
	Thu,  5 Jun 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136291; cv=none; b=dEmE5urjmjyy/p6b4s4xr7psAIVPhTWzdl1o2dWZNSGJWDIy1KVfXWwKERy/8lBFmSx4VWDYyuGdezhMxAorsDuPwuGI2e8mJ2ngb+JO3sENT1DgC9JwHa0ia8Te9POII3oRyuUtBo5+/9d9zbVsvKVRUisfAsve1R2rMiesH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136291; c=relaxed/simple;
	bh=5ByCBNtaK+LgpgvpKKzcfc261k1mNXaDpdqFzomi9iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFqyG06TPZFQskLdU6zXhq8Z029zIi6ZZFUhFC8+z//+jQxpahWUAJe9C4iaOKNVLp7QgAmfUesdLxq6hEwG5ggpWzJcr2DtcKosg5xBmPyjC8COXQF1aMaWXg60d0vRSWeS5yZ7Xu15dbTcuIHBgUxLbFfaos0eh4ybSqxRTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Rm0iZ/qK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DDGtV028924;
	Thu, 5 Jun 2025 11:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Sr4Gh
	eLiPdRY5QMddXSBzGUdMsfxWcpqgC1VQoc31yE=; b=Rm0iZ/qKFqSfOzejSVCDR
	VyLd5dP0c/uGHr8ktsK/yz61GHtOYCuiIKwbb5pVnV5t2SqZbSU60MbKOl4r6rE0
	widnhnjy/5rtaTya/KncR39ztEMIG0ZZi7JTJE7Vme7e9XW5CRv2LzYDaW5+gayE
	FYxoXfLsqHmSrhFx5eO18LuG/uNeKgVsGMQyiwylKUSeVKezTs43no1+x3zU3BOh
	MoA4rS2gQ8rGB9m4TycF7TNflrGAlgWZfIXM78m8cjMxXuqidhBTEI/EzeXhrOuz
	sDigyXq3Ajmlp1E2ECz1nfFe5NBqzKI8Ilvkx5k4dGaENrrO+54w4BZ88cAm1kKn
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j8jfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:11:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 555FB4d8046975
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Jun 2025 11:11:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:11:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 5 Jun 2025 11:11:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Jun 2025 11:11:02 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 555FA1ut027831;
	Thu, 5 Jun 2025 11:10:52 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Ioan
 Daniel" <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 4/5] dt-bindings: iio: adc: add ad7405
Date: Thu, 5 Jun 2025 18:09:42 +0300
Message-ID: <20250605150948.3091827-5-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NYvmfvo_RkRiIzrvC2T9MUcHw_PV3OCG
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=6841b389 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=KKAkSRfTAAAA:8 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NYvmfvo_RkRiIzrvC2T9MUcHw_PV3OCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEzMiBTYWx0ZWRfXwkMvfK0vVTcz
 fcXSoy1lQYPvXzhLtFNbLxGZsens18WbjjQ4ttxECuqEyldfbuEjr4GKNhQnyJ/qFH7XatzdcGR
 Ewg6I53KJmxsvT2rEBLOVWZgvd5JxnMapOlTTP1T9sWZuJlR4TAZOiI+9O5JupsfKRt1NgIcW5/
 oqWRczPfxMU8KzCjnmntUqhIFWG3O7pwB4Lfwhg/hTC5ctH3L5bow34PI9gXSf8FhzOF3+8bqVl
 FovXmamLWUaafkVGTTq4fC56aSn9XLwS4ZEAvt861mGgqhJDFC/iHuoq7zU1dj4yt7wbebzoo4D
 iX7WDJ2x3G+Cyd6oAMSQtM6JYbB/nos3X00jWvUu9LYVHLEbTZ7zmRZzR/sLher9HWqKiE2ncJ2
 iomOWn1oODRjo/0Cn84yw14PsuJLSPxC8Y3BSKyKKRyfrS9wysCCCRRW70R/mBVDRlAOQzFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050132

Add devicetree bindings for ad7405/adum770x family.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v7:
 - add Reviewed-by: tag
 .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
new file mode 100644
index 000000000000..57f097025705
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7405 family
+
+maintainers:
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+  - Pop Ioan Daniel <pop.ioan-daniel@analog.com>
+
+description: |
+  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
+  16-bit with a second-order Σ-Δ modulator that converts an analog input signal
+  into a high speed, single-bit data stream.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7405.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7405
+      - adi,adum7701
+      - adi,adum7702
+      - adi,adum7703
+
+  clocks:
+    maxItems: 1
+
+  vdd1-supply: true
+
+  vdd2-supply: true
+
+  io-backends:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - vdd1-supply
+  - vdd2-supply
+  - io-backends
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+        compatible = "adi,ad7405";
+        clocks = <&axi_clk_gen 0>;
+        vdd1-supply = <&vdd1>;
+        vdd2-supply = <&vdd2>;
+        io-backends = <&axi_adc>;
+    };
+...
-- 
2.34.1



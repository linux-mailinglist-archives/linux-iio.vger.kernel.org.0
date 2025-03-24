Return-Path: <linux-iio+bounces-17231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA91A6D70A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAB63A7E6A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9525DB0B;
	Mon, 24 Mar 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WdzHEhtC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB6AD24;
	Mon, 24 Mar 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807459; cv=none; b=kHGH1iYJiKn69TIpbe5YQr/zCDYtcgUDfoJojpohsPZsTWwOnRbAYsUuCKF45QJKsfLbv9QW6jejP5ytr/ReDZE9hQyTp7i0z5v+sK0d877W7AHJVvK1mlsYmzt8cE5rsZh6G20BUrbvDC2zL2oZQT6/h8AzpWJIa+HQ3rmJQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807459; c=relaxed/simple;
	bh=y2vLuUOaNW23Vn/y8DkDFJTAYRTtno1A5bPSLxNWZQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8VEtRCcw3Z1sQgi1kxrMaOeyisnKGx0hJIVA5sIISag8S6fXDpOtwI5dJwjrdkmyz4v1xkCby7HkE0caaJ2MnffQlrnk+hEnMMBQeGPZRBEhz7v1hqEkaERwg8M7izA6G9knA4c8CgoZsslJ+GctMmYUkXWaMwWST41qOm7byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WdzHEhtC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O55WS6032458;
	Mon, 24 Mar 2025 05:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=p9dei
	fXUnM0oYorHf6U+gjSrt/yAkn7mGhCreCwEXFM=; b=WdzHEhtCv+VZ2qVXv5p0/
	987RLz1sFssynplZ8K+3qGStRSF46BPMQlGQfPt3HsmyPzwgWHOk04G/c7Grg7v0
	qEyTgatEOArIzbBk5K9FfXC2V1vrC3iJiv8PQz0i3D0vmoCV24nCxHP4/lZsvShh
	tenmwl0oS86L9msrEvILAWSTvebcjW36gfdkQPMnH+IW9EmEdVQfQ9FjbwMWCHU5
	p394JeES6zlUsHnzqjqp20FKTLVVjYyELWD8QBQ/bM1pVVHSlVoFzHDUVXJEAhVP
	82TPXBFzFdWKuPdQz/xYfcRnQCur2wRAhSZMRSOvAd4bmyIJu04KRji5iCHDPDFI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45hq27a5p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:10:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O9Aa9j058978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:10:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 24 Mar
 2025 05:10:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:10:35 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y6D001058;
	Mon, 24 Mar 2025 05:10:27 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Ramona Alexandra Nechita
	<ramona.nechita@analog.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 4/5] dt-bindings: iio: adc: add ad7405
Date: Mon, 24 Mar 2025 11:07:59 +0200
Message-ID: <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: YQeHfJ_FoijthZ7tQ8h2wHNtSbspzRcg
X-Proofpoint-GUID: YQeHfJ_FoijthZ7tQ8h2wHNtSbspzRcg
X-Authority-Analysis: v=2.4 cv=DoZW+H/+ c=1 sm=1 tr=0 ts=67e1218d cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 .../bindings/iio/adc/adi,ad7405.yaml          | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
new file mode 100644
index 000000000000..e312fa0cdb05
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
@@ -0,0 +1,68 @@
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd1-supply: true
+
+  vdd2-supply: true
+
+  clocks:
+    maxitems: 1
+
+  io-backends:
+    maxItems: 1
+
+required:
+  - compatible
+  - vdd1-supply
+  - vdd2-supply
+  - clocks
+  - io-backends
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adc {
+       #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "adi,ad7405";
+        clocks = <&axi_clk_gen 0>;
+        vdd1-supply = <&vdd1>;
+        vdd2-supply = <&vdd2>;
+        io-backends = <&iio_backend>;
+    };
+...
\ No newline at end of file
-- 
2.34.1



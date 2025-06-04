Return-Path: <linux-iio+bounces-20206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C9DACDF48
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2FF1899635
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA628FABE;
	Wed,  4 Jun 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uEpNJ34p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B233DF;
	Wed,  4 Jun 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044163; cv=none; b=SDSyTRiy2RSKoqMuWC9D5yU5JAl4ttffKtzXCLMulzo1dwylaqtSV5PpxxVw+KVOPwY4BTd/HzSeJjPXMwelVZSX4QjKOP7qkMIsjH3XjadqjgMDRkqB6jyOkQO/FiS0SdOHImS/JyN0hTW6oTpExNF2ISoRFF5AfINwVUnPHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044163; c=relaxed/simple;
	bh=i4D1V8FFbbAl8HqUbgC5htGfbdURz5fJHtLugYhTQTA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpC++QZsA36oBxYFyO924vDpT0Z1N5yqwYczPjHpYyYC4vGNxanL+lx40G/Rlboc2Wnr/9Sg9xvs9czZxTEsIdvRmHUFp7LR7jO7WBqq65F76ma5PxRmpftq+Wr5Bed3jVQs6I+ws2LsZRxXCJ3+4q/5HHH4zxP8Yibkm9aXzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uEpNJ34p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554CLenJ030757;
	Wed, 4 Jun 2025 09:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TBAnR
	hov1+58E85smY4BftHM40ijCitXRyw4O5nRnLQ=; b=uEpNJ34py1yumSeHabVCm
	Gxwq7ne+7xc+AnAhV7/hUgzK4AffpOnc/+VrS7lLcgGyI7ysLy3Rj6y8i+kGlQQ4
	QW8Czll7lVRC4ssvH+uxGCrIw/vkgSHaNYexfWnr7KQVerFgPLVX95hJxTqeOpm1
	GotuAIlMM4F3Vfo8dvH4gU9kvhRGuzb24ouq9dypYZAAadKyrLsvqc2+k6kjwWjf
	3RfiGH3P3QWgrwNVfP1KSfjgfHNv+SZiTBPDNTJkQWZJm5oQ65hIAzeGqPDy0tdm
	DO+hRP1ZTmc0Vbxe16CrxtIa27efdigfanM/xTU4ffMSsHuyU8fgqNRBTPgokl6R
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vgcmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:35:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554DZZ57030313
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 09:35:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 09:35:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 09:35:33 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554DYVPa029277;
	Wed, 4 Jun 2025 09:35:26 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/5] dt-bindings: iio: adc: add ad7405
Date: Wed, 4 Jun 2025 16:34:06 +0300
Message-ID: <20250604133413.1528693-5-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfX4t1NH/6/2/h2
 vJuES6ESa3Xmz5BB2TNds48iTQKV14WoE5Mvn/PJzIU+2nBjKe4Kdse7AiBHEU9o7rokJoxB3Q6
 G5oWpHZcpQLdx1V8PN1XBdfekLipxxD8Laq32n2hBvTI5KMfDy6mOjYfCzuq7cjbpTmu01pj5Xm
 wbacFBuZQHxnNoqAi6IPtVN45leIPBTBEZtgYIIWPD+1s2WhkeP9mKiyR1igDsT+E2CFEWoHgfK
 24rSuOwvMkdkjNflJdqi8LzKMKj6Ky9rKpPY08XILVnzodERAyOxT4nZrFUl0wcsUyDBepYAT4V
 6dJAE4l6s8E03+HHeRw0+KaglLfuknECzgIBSOhQD95K4jjgLkupVGLZDosjz7Ct7FGOq6OnSe2
 Cup3JTRKCHfiB8ipT/tfoaMZiR8swXyg/ejMZ/LVlGnixPvfw8t1HOTGoDG2z8ILmkclwmff
X-Proofpoint-GUID: 1FYdpM9RH1uPaWuBhgh4WWnlD2QIWVlw
X-Proofpoint-ORIG-GUID: 1FYdpM9RH1uPaWuBhgh4WWnlD2QIWVlw
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=68404ba8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040103

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v6.
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



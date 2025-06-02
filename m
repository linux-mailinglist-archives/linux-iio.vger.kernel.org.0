Return-Path: <linux-iio+bounces-20146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD8ACAF63
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC25D3A5407
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C88221F37;
	Mon,  2 Jun 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j9tYzYGN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED6222575;
	Mon,  2 Jun 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871952; cv=none; b=JSb/GTnP5Yu+tf8weXt/Vyrfsp3Tm6ZYoQeioqc0LqPyIUwWVquyYx8GZG8L9GLE9i7DHG03Nbz9xY04BYSv5WXx44pSsT/+4aqTJJwebSZTd4HkXGIn08xuFh5pki8lFwMoVk/xCFnts5/xa9jXKVXpCVyRn53zuZXtH/icOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871952; c=relaxed/simple;
	bh=g/UFvYDDorQgk5mTNsk1c1TQInti6p7lLxa1Q+qH218=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/YjmnquF8a3oMGxRBlPFGOhNlkyW2g+Z8bVk/vRjgktRNw7NxNTE4TmiVx+J8lvOVqKRJA48MCo1093ePqoNCUsRcxg1wfkLfy/fl/HNGpokFbF4yn8nOrFsyXYgl8QZnb09hJy1y0jT19c9rfVkn5a51l1sgfAo3eXQ6K+Gas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j9tYzYGN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BBv5a026424;
	Mon, 2 Jun 2025 09:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Rfrje
	RErljXT4Mog3LyrKhBuiYW7lHoD6zJyMCluMDc=; b=j9tYzYGNhGS8KgipDW4cm
	YC61uH+wggPiI3mHDv1omLi//WcMQ8C3jQeBY4145fqURrtLb29f/nxJis5uPph5
	oR/+T3hyvKSQBDp8kJAhKRdJ7DkYmUvm2sjBCh6uEsq9fd5+AoLETcFuOEx0wEo/
	0CGLcicbqoDZA05kZdxGPUF25pJ+KqU2lmGTAwvUykFA271PhZJl/tcNWREZDUkQ
	nuypHv3NsC75Hnzs8NtYuMZ476bQf+Z9B0iKBCN+1bjH/yfvqipgKwiw/Efnk4h9
	rFAFrHUXsco23ba4tnox0d8fHBmM2ImB381VcQBDR4zYaxn0BjchCWLei/NeUXYH
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mjk16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 09:45:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552DjRiW037069
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 09:45:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 09:45:27 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552DiSJP010531;
	Mon, 2 Jun 2025 09:45:17 -0400
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
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Pop Ioan Daniel
	<pop.ioan-daniel@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/5] dt-bindings: iio: adc: add ad7405
Date: Mon, 2 Jun 2025 16:43:42 +0300
Message-ID: <20250602134349.1930891-5-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: p62pTw-1XkywInZ8XzsBw_iCyB8zEg5r
X-Proofpoint-ORIG-GUID: p62pTw-1XkywInZ8XzsBw_iCyB8zEg5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMSBTYWx0ZWRfXzV2ySb5vyCF7
 RsYmiYqWEgVMQqxXzRYGShCax7RC8tjdCz3ynx4ga/F4O2f3P2G/tkSVyrCYinwDV48NkQKMnW8
 izRtRGrvbfPOgo6+Z0GGPH2kQd496SYu+b78HJSDt9uYfDwldQSQBQa8d1n6ESlBFsGhlaaQrz9
 mkzsdLtLAVPtKGAfuDF6ugYNYymvwM9M7ojdgGk39LUL5uR7GyEanfqA8P2Mm3g8icUIre4rKHI
 QE//ZOqbB2gnEVf2YkVlufJYrF5jdU43lFX0lzrwk7xKoxaBIOdAZgX/44v+HIehsa/oCnit89m
 18u3st/xU/LU4tzE2nvcSdZ5wZULlDzsnTzIIkL5LBkUVG6uBLELB6u6OplC844lS1xNyXdfV7s
 krDwev+X9kH3/qt5C7xzf9Tb7AHcCfyOQ2+9yZA+dm1g2eYbI7cgrBMg5Ni3A8EgW/h8UrM3
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683daaf8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020111

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v5:
 - create an example based on adi,ad7625.yaml that is very similar to this part
 - do not add Reviewed-by tag due to the change that I've made.
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



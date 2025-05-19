Return-Path: <linux-iio+bounces-19675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95CABC032
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846451892F88
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC6283FFB;
	Mon, 19 May 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DlLlz7ZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB0283152;
	Mon, 19 May 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663443; cv=none; b=KxPtA9O9hBCxMO1Orl6FF7xn/JfgJnVwk5a4EAhe/GEpNfCn+ZeM0OVOzt00/GFucp658w5PPv4tprkVlmcOQY8lTZcIUdSOBWVYU2XusGWnlwmYUxD7VJ3ImMa5aqTos1TwZVvZew8j2C86NzxySBPXCDf0KHPStSFhoxoUMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663443; c=relaxed/simple;
	bh=OKQLbxbISDh5KDh/idbjgz6tUjq9B2vCDTvCR12GsSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcb6TfIxlCspiiLQOOCsxI0ZrqVbXyirVcKYFNW5xT69FSK4G46NLa5oj2YH/ERLdrESPJdGkt3iobHc3b0Xc1jneL+igDNNry+BNJ44Wp/s0xA4yfZiX2Q/l1DsrpEogKyNxsifhTiU/I1uz7qBHojTv6PsmFUYbi5vm72dVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DlLlz7ZP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JCBbGA017336;
	Mon, 19 May 2025 10:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Riycv
	NRhRq8H5F+BahxTj1ImVkEP/f/mo9I5YT/Vn6M=; b=DlLlz7ZPQ7gwNMZxbQIJu
	iCN6nWGAhjN5z4iO/s+5xWHEjHPr+FcYk2DoKqDZjghBCUwPori4WuxYvEvGtzp9
	OSMg7PDq0JA4kG9ck3YZJtLe161CVS6BuzFXwpY3C530Uq6ZcWUNMoUkjm2UTrNU
	etrJSUrf7oCjH1iiRABHjQFBfvfe5oYUaRx+Y2FHbURP6L4wvZkaJ+BrP3GgEA7Y
	amzAt6dj242HJ4FtVc5AFdV5xftEUMfAtDHwJNZz6avev8lRwHjpbEI3zGvnlgT1
	mtpDmkgxlClgUUWEAVz3TtDXOdUH9hYQyhYJy+Bf6Oht51+kNr2w3KtBElGYFCXc
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46pqc586by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:03:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54JE3cgC026767
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:03:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 19 May
 2025 10:03:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:03:37 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPG016713;
	Mon, 19 May 2025 10:03:28 -0400
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
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] dt-bindings: iio: adc: add ad7405
Date: Mon, 19 May 2025 17:02:12 +0300
Message-ID: <20250519140220.81489-5-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SKZCVPvH c=1 sm=1 tr=0 ts=682b3a3b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfX41bnHkx/dyFg
 3TL/edPjeG2jKHjVa7QK+DW5snnHOxMJXooCxHGMoY2CZPCTc2paXNpwuZGha56eP2WJtqdx0b6
 Nn2groTwAhkxOSIo6utPql89l3kN4DiPt2larwZKwvDFYL+vVIXthB2x2X8Iz3oCbOd1rEm2esi
 1T4tzJUD5IMdRQUCx/8w0QpqOab+xy7hS3onGpyLi/JaMesCYkiAE8T+ximRJDTZa9ZCmula+dk
 2avoCFwe5LD9zxxLHjPU70LOEox+dLYW2u8ZSF0eIs1B9jVH0A84jUDqybENb4higl0sbH2pkNc
 N2e/xCejBAMCM3yMIP0hePqecgle31NB8rQ1r63P84n43C4l00xM/JrQ/+GtG9RHbC1CfrCKHET
 12IBP5cEDbz1Vg7EtUZ+48kc+tbjL79gBtp6gp5w3tGDFtEA7AM+w36pqVokAZXLUZ5YBrWq
X-Proofpoint-ORIG-GUID: cpwC3494UgSCRm71CUFecZvbWolzjEuv
X-Proofpoint-GUID: cpwC3494UgSCRm71CUFecZvbWolzjEuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190130

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v4.
 .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
new file mode 100644
index 000000000000..939de3bd6f26
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
+        io-backends = <&iio_backend>;
+    };
+...
-- 
2.34.1



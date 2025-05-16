Return-Path: <linux-iio+bounces-19593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65279AB9AB3
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CADF50447C
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7012367D5;
	Fri, 16 May 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z7zhu4Rr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95683236445;
	Fri, 16 May 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393191; cv=none; b=TGUZA9vRPfrRSNMMeR0TCdqeJzN3nfQmc3a4kytREnEvzUDRiNNrzh3lbLy0xGYFCW/QoI1hXVNOlxl/oTuhxeeQJAsAMfXtFPx9oiKlhlnOYfnsDrk3wnCzYbhzGKVGvAhEFJqZUvy8vYxAJZhGW4JiY9GhCzSzQCwvyp/5vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393191; c=relaxed/simple;
	bh=PUGb250iZt0noGJToKSIbpZHT4mePC5MCiRR382sU6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGziKlKxHDwJmJiRbmq8mcsIsWDX+WSSoxNwtcFjragJOXT8KTLVCmsZln6bgJvXsybcKoL277/5ra74fvPvyA8Yt38U/KZsCr5UcAq7gYczcGjKrab6pXIH2CnUBERczD3VVP/jjeuviAvTqpyd27UJulAbOhIVLKSXUFAtDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z7zhu4Rr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G90ow5016384;
	Fri, 16 May 2025 06:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KrJyf
	nXo9p+iNk+fhlsORQVNIFZgpomkbj8qttbkWlQ=; b=Z7zhu4Rrr2iUpx/SO62pC
	hfna0YiTqPHKxny5O1j+lu6RfUu4LdLnQvNWPQWhQRfyOvRK9Ji37kfJcczpL9kR
	eDTocy5NURA6jE9UTJT71NGTzsKmlLTbXkaSgM9WqSpdMUbjKzapz/N5SrMwQ/Ug
	0NbhRLxhcPGiQzgCxFt/EOhzPh2aahuFbHb8wgRysqDHRhF+K2Y5CCDAcBtbn8Eq
	6MP9TXij1AVOWEoUPtKdwfnzRuu230j453Zdl/mxRPWb+eiJW5bHnj1oHHUV/Q1E
	wpd5zNZzTn808oGEbgQiCUSSv2qvRrq6160QAwGSySEovbqkOj+GguoVRBbkyt5b
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn655ju7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 06:59:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54GAxGNr050082
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 06:59:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 16 May
 2025 06:59:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 06:59:16 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54GAwRHx006196;
	Fri, 16 May 2025 06:59:08 -0400
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
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Matteo
 Martelli <matteomartelli3@gmail.com>,
        Ioan Daniel
	<pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: iio: adc: add ad7405
Date: Fri, 16 May 2025 13:58:03 +0300
Message-ID: <20250516105810.3028541-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EtsiGCavoRD7woJCeVyXC5VL-MgIViZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwNCBTYWx0ZWRfXxzN1fEM1/UxT
 4VO1Z7DJo8Az9Z4anEiReDB0HTScgnxvL0IG1qVCG/J3Xzwib4nXY62RStHeYF6bNDIrysgqoey
 Pz6Ho6uoLS+VZ2RrbhHlcBe06W24f/XSudsPLodWHo/JRJQC6z/l0kBkolFP/34REVrBHO8Bucg
 Ns3MNsqLcSRmehDzHjFulJ/iww3xBKO48HeOfDBaBEs8ahHVay5D6SRu89nrZMVbSHqkIUX00a9
 JcrWAeWMPtegYy941QKBS+Uxh3IBHTiU0V+4zPmnji6525Dt/+LyiWFhzRO3s4AMcAEjoQRpKwo
 WUMfdcrE00xcfzJNUiCDJiEssQywfhmBIqmBbLymZAEUMg9+h6U0RW7KikT/RtJdGua+SJl4VMY
 BTIKl1hTpWiu2CvB+AJzPn6ucUyRaBlSaYWv0gA0A5sxoRBtJzarWCORbLuT6nd38qXVQhkV
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=68271a85 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: EtsiGCavoRD7woJCeVyXC5VL-MgIViZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160104

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v2:
 - fix properties: clocks issue
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



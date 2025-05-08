Return-Path: <linux-iio+bounces-19296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C1AAFA0E
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A859E1A87
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D02253EE;
	Thu,  8 May 2025 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zZm/md/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8B223DE1;
	Thu,  8 May 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707551; cv=none; b=L7FRV+CwoEJCSChxVNJefOGe9/N+YFzeSWXbKATlLTYT2qwuSVWpVq9gioRo74s/7Vje3K2x/514HPluiIuT+AMM3FzVGyQfar09+4Dq103NZ4uDo3O2Ewc3m/TNdZP4h7ZZgPCQwwp6GDZ1ueHR7C+B0fwJc8yT+a7JuB7V8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707551; c=relaxed/simple;
	bh=Tqq+ds2T097BlhJu6VZKIFexesFc/Se4hllVNLOjWSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOjj77MCpHk1jGoytVIEx0rwkwDxuKKGLs1jzRDEIoNW7TGINer/pcnXYS+ov/FaL/o6t2or5Bevv7IpwlgxiXqehJ3ybDtb4gXJhjt2G/Slphtd+z9AAlPPCUs1c4U7XtkDOMjHAyEsKd/+DPAQ3e/YS8I7lbxWJDZSKJ0f3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zZm/md/x; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54894rKa013536;
	Thu, 8 May 2025 08:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jXBRW
	aRx8lJDpRJefpKv/9YZiNvgPTrjqpVF9x2liDY=; b=zZm/md/xwTikIqzGwsji5
	q+9tPvb+OlBz8Qe9mSIrPIU0xMBG8El4HT04SecVmkmawAfjB83h9q7hkbTt57su
	Shnvng20m7sAaWvzLXzOsNnI7n4/P754sNZY0MAKQgQRtpccn6OmhX7Qw3wFAEU2
	DsKNhL/YV+kirpkcLio+2nzQldvG0tHESSG4QR6whxRXsf4pHzYreAfm/fDMSyww
	OcQFJQMTzM3LnYdoXF8iJd97C9YQwD3zKtZEEFcowy+Iv3Lt0qhPR4wz3VVdxUPn
	vvNSBioNuBijee8tnBZlBPhVHi0+aSq/47NK39NuDS0OddD1NxyJK2XSjS9RtJyO
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct1um7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:32:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548CW7Pn006295
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 08:32:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 08:32:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 08:32:07 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548CVFtf002317;
	Thu, 8 May 2025 08:31:59 -0400
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
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ramona
 Alexandra Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: add ad7405
Date: Thu, 8 May 2025 15:30:56 +0300
Message-ID: <20250508123107.3797042-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ca448 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=BlUfrHhC_0NcX1HyLxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: GUpfBeC2G7GbxXaue-ZSVK48bHfbil6i
X-Proofpoint-ORIG-GUID: GUpfBeC2G7GbxXaue-ZSVK48bHfbil6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMyBTYWx0ZWRfX5UcqVyOoAhXL
 qJRwvCa8rhBYnJ6lgdb5ADkbdM2eNKqnebg/KlygbKOLRyv/CgfSA5pU7rQpscKZUMk+F3O5Oki
 89/2CQNEcBnkFb0i4FfA2V7IPzjUFCmAdTVXJPXgswTQirZToYySP0nC2UDRJsAldRh8+d+9v7X
 q4oC7F14Q7cmaJENsbYTGe0Q4HQv0LCyhQtxY85Nzkoct5Z/7EObQpmiJpD30yuCMiGPtLjTTza
 UQu5otw8/xI2QoKYrLXfyIOrkdK/UGSZ+gj6MXGTzyCXMD9OfjNjtmqVAfQojgpD53Ds1e3XxZH
 Om2R5CC6SLRan7TskncKNX3hep2Wt7LdWssYK9ay9fnKC55Fd4Lz9C6Wx4qGdWGQyy5O2i45Apt
 /IhoHbA8T7LmJ512h313Rk4MGpiaQj9qAhxNHTE5wXLFmmXSKUqSoI+KftYI3DB4ZcgRMKTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=1
 mlxlogscore=999 priorityscore=1501 bulkscore=1 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080103

Add devicetree bindings for ad7405/adum770x family.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v2:
 - remove  #address-cells and #size-cells
 - add additionalProperties: false instead of unevaluatedProperties: false
 - remove #include <dt-bindings/interrupt-controller/irq.h>
   because it's not used
 - add new line at the end of the file
 - add mantainer
 .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
new file mode 100644
index 000000000000..8c30a712968d
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



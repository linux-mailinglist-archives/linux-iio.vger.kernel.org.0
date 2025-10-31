Return-Path: <linux-iio+bounces-25764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018BC260B0
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC318838BA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06A2F3C12;
	Fri, 31 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f1+QyxDu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631F2E8894;
	Fri, 31 Oct 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926678; cv=none; b=JoIgSy7Fb42IDGrkIJBRi1IWlgrgsVs+S4MtXedeas90wLoKSmgS7dKrIT+KNTexWZhB0pnZeTeSuq2W62Ag8QRvgKPyZfMeRgTzLZuCC/Mt/2itbj7y7Jaxa8L7VxBiR8pZJ18442gAjuTTxYVcIIBo1iUnB+ZaDAXYulpWz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926678; c=relaxed/simple;
	bh=V0/NUajnJeCrMjUrkPKgumE5MElJqu51qxpD/GH7n1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM1WeK7z349aoazqv+//YFfUxen/doC01/HUuTfghIIY8XqxyGwfFAfJXP+zkabT6jrrmNNVidjIdkhkNd6BcAfan+7XoVdliHx0ebsq2FzXBjxU9H3rtrWyLfnFBWN+YKUQfBsSnJj3yNMbLzuXlmJen+b7mdc7ZSmVjkzCxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f1+QyxDu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VFGBoN2390145;
	Fri, 31 Oct 2025 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kqyAP
	sC09TTOobFe7V+7cpVBoHxKuj6QvHdI3TC3/jA=; b=f1+QyxDu4fTaVpGGEy/9Y
	io3JG23lDjVuh4pvhGtr2/7ZaE58XBFtzjoAVlizzzweTq2ElYYSp2BANF4LXMDU
	O6nH25HN3LYG8JG6ZdMMYV9sOfAVAc1j5mqTh5EB1BqS5WLQQ1doiqawGKHiLLgl
	Ys9qUc2Ct+bNB7peOk1XyTsvt8CApwCdKBETxLSgzvKhJCk+ZRJTWq3vp6KGr9O8
	0w4hosn/3bbaa14Ec6N2fUpz/9xTyZvgcFiKS9hO/kRWf9USXrP5Qb/ktLQBVVhQ
	NBlmMQpY4j2FhJEF3rVKs5ErEmIZxOJ0n4ZD3eQjFuo5ZKHZFKZSNzyMhg+UUC0q
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a4yktg8c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:04:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59VG4XKg064668
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Oct 2025 12:04:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Oct 2025 12:04:32 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59VG4K1L006874;
	Fri, 31 Oct 2025 12:04:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/3] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 31 Oct 2025 16:04:03 +0000
Message-ID: <20251031160405.13286-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031160405.13286-1-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Qdks2GWj3_1P3eXhT31PEWuD9kbxLCxZ
X-Proofpoint-ORIG-GUID: Qdks2GWj3_1P3eXhT31PEWuD9kbxLCxZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NCBTYWx0ZWRfX8ocTBzoUDZWY
 b3v4gEIg0CxIJ46RZ5OLxdD2/DFUKPfUri0f12wbkD/kwTD7KcIrePPUlAKIcO4b03q/h3Vw4HD
 /QrjXaXAyRrU/QfQWidwfK8U9axmTrpK/p2b+re5dYpezVmOfDDUnblkeeUOd99Del7HQ91FTkp
 V5C2ebyA83QeoVW8C4j6HYB+EYNghGPrOZgMXxs2YcXOjIj7kKgHpclcBgVkE1D3Cint5VU0wk/
 og2mpHWDl9lt0vdPV7WvB5Ogm1gvAtajjPzJBp5zUMJ6zPnX1goTWp9L39p74chU0wPsDXy0ux0
 f22maiTa+LJn+cjcUXnCAug6Ed9WiEIuGd0Np3ulGWtx8QlVWkFC3MrBp9Am23NQXV6/D4HbovL
 Aw9jaM5JPIYvUxnCoVpuu2rX/iKq3g==
X-Authority-Analysis: v=2.4 cv=Uq1u9uwB c=1 sm=1 tr=0 ts=6904de12 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=fejBgCUCbQS8leEGmL4A:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310144

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..4cc21c93233c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass switches
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated bypass
+  switches controlled by two GPIO pins (VA and VB). The device supports four
+  operation modes:
+    - Internal Amplifier: VA=0, VB=0 - Signal passes through the internal LNA
+    - Internal Bypass: VA=1, VB=1 - Signal bypasses through internal path
+    - External Bypass A: VA=0, VB=1 - Signal routes through external bypass path A
+    - External Bypass B: VA=1, VB=0 - Signal routes through external bypass path B
+
+    https://www.analog.com/en/products/adl8113.html
+
+properties:
+  compatible:
+    const: adi,adl8113
+
+  vdd1-supply: true
+
+  vdd2-supply: true
+
+  vss2-supply: true
+
+  va-gpios:
+    description:
+      GPIO connected to the VA control pin. Must be specified as GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  vb-gpios:
+    description:
+      GPIO connected to the VB control pin. Must be specified as GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,initial-mode:
+    description: |
+      Initial operation mode after device initialization
+        0 - Internal Amplifier (default)
+        1 - Internal Bypass
+        2 - External Bypass A
+        3 - External Bypass B
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+
+required:
+  - compatible
+  - va-gpios
+  - vb-gpios
+  - vdd1-supply
+  - vdd2-supply
+  - vss2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    amplifier {
+        compatible = "adi,adl8113";
+        va-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+        vb-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+        adi,initial-mode = <0>;
+    };
+...
-- 
2.43.0



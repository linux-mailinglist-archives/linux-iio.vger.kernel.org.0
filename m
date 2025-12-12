Return-Path: <linux-iio+bounces-27054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C12CB92EB
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 16:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC97E3077E79
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4E3218A6;
	Fri, 12 Dec 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zM05Sq9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792C31ED9C;
	Fri, 12 Dec 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554168; cv=none; b=m5vYpGN0Z7OYPhkXRVqfsgvJDaC4C1jerGW+nd0mnvlM1fIdia9EkRE4pWynAzJYtPm+FKquQv2mR9sGICB/iCR8Jr9lkcUhozZM4gPklYOsmjORBAYMy9E168Wn1hl2nHm2usqBHEk/YviiuW+xAk/4RzwCbcgocThSHGSeESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554168; c=relaxed/simple;
	bh=b8AJHovfXvxmy6pHa2NrUD6n3G4cYRcEBVsG/J9gs8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmjzHRXpupY/H2RvoYmgLF+xUIN+WPqt1qIBbZxflR3N5Z1asApFe2gE6rMc60RUFon7ZfsJXq3F8MDus64ogwTkTSpUXEO4kX9RFtztgm39DwLGEgDo1eV8CH/jkvXJqm/GR1rtzymSvwOKEjlEM/fyunXyIRUq4OO5LvsvYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zM05Sq9o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCDETYn3817140;
	Fri, 12 Dec 2025 10:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Sv+jj
	b3Guc4stnz+E3ro+DHtywiEGxzZ+pjXeY7hCdA=; b=zM05Sq9oBf9xvTs1KW6C2
	1C8H2RA9mmKUhWkNP0Le6+7s9eGVJbbNtydDsV9APqySRZ3CL6DWXwSQFv9rFKKs
	vEwfu83uVYf+hsb6knQ1OvlbsKo1InHM0xyuQBCLfmRg6/Q9A3cgAoIlA4enK79s
	E/NRwUEN60xnS219Vu8nRauG4hAWfE6Fur9cR6w0oe6pnSCmUJk9j7NXZiOAyqZc
	NMD2vY74zGhuuM+ygXZyMhA27+TM4/zazt6ACJEfSTZ8MbnNb7D1WYtrVOsZlRli
	cAD51Uxz+6vm41mSVfmX7sjOPkxRwZPwf1r1NEXqethT3qKMo9F9/wJF8S3W0A5i
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b07r23r4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 10:42:30 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BCFgTFg049190
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Dec 2025 10:42:29 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 12 Dec 2025 10:42:29 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BCFg2oT020112;
	Fri, 12 Dec 2025 10:42:22 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
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
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 12 Dec 2025 17:38:25 +0200
Message-ID: <20251212153908.138422-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212153908.138422-1-antoniu.miclaus@analog.com>
References: <20251212153908.138422-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tLZ11hpEIKjgHbC7jO5TAL49s6MPIPf0
X-Authority-Analysis: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=693c37e7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=1yNy12B5puk2P9Y3jxYA:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDEyNCBTYWx0ZWRfX3RFmh2tAQb30
 fzyr5srMWdgMoeMjfGlKDz1yFRQFUHJU7qR5Mf3DNtnW17SM82Ztk5RqjKRJ+legvWsarGekM2u
 JPkDHET1wcW7Deyv+4xP6uLcMIzyN5q017bs0Bujbm9BandQ2otJOh2ZkVf1y7nyrVNjBpE++CI
 KbZW+T9djSRhFH+kwTFWsgkh1i6Rv9EqFzbnFduo7nhztqK24jMF+6owUePp9pjxFv4081JrtW1
 dLLhuGVV4LFwdLnFTUsuidte+3/Levx5RQaPH8sw2KNUvW3JdTX3KrI20Kfoj+OMK2SX9cYAEbm
 WOaDW00Zw4ogfOmeM/LF9goomoLyubhVzSkoUGugTz0fNXWnp/vSIOu9xRjWJQEkgoPbjRE/XN5
 KcMuys4Dwiu7rToOoi5YSCN7hpQ40w==
X-Proofpoint-GUID: tLZ11hpEIKjgHbC7jO5TAL49s6MPIPf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120124

Add devicetree bindings for the ADL8113 Low Noise Amplifier.

The bindings include support for specifying gain values of external
amplifiers connected to the two external bypass paths (A and B). These
optional properties allow the gain values to be selectable via the
hardwaregain attribute, enabling complete devicetree description of
the signal chain including external components.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - Enhanced commit message to describe the external bypass gains feature

 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..6b8491d18139
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,87 @@
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
+    - External Bypass A: VA=0, VB=1 - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
+    - External Bypass B: VA=1, VB=0 - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
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
+  ctrl-gpios:
+    items:
+      - description: VA control pin
+      - description: VB control pin
+
+  adi,external-bypass-a-gain-db:
+    description:
+      Gain in dB of external amplifier connected to bypass path A (OUT_A/IN_A).
+      When specified, this gain value becomes selectable via the hardwaregain
+      attribute and automatically routes through the external A path.
+
+  adi,external-bypass-b-gain-db:
+    description:
+      Gain in dB of external amplifier connected to bypass path B (OUT_B/IN_B).
+      When specified, this gain value becomes selectable via the hardwaregain
+      attribute and automatically routes through the external B path.
+
+required:
+  - compatible
+  - ctrl-gpios
+  - vdd1-supply
+  - vdd2-supply
+  - vss2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Basic configuration with only internal paths */
+    amplifier {
+        compatible = "adi,adl8113";
+        ctrl-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>,
+                     <&gpio 23 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Configuration with external bypass amplifiers */
+    amplifier {
+        compatible = "adi,adl8113";
+        ctrl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>,
+                     <&gpio 25 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+        adi,external-bypass-a-gain-db = <20>;  /* 20dB external amp on path A */
+        adi,external-bypass-b-gain-db = <6>;   /* 6dB external amp on path B */
+    };
+...
-- 
2.43.0



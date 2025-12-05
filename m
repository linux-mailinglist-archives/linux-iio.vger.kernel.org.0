Return-Path: <linux-iio+bounces-26795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8ECA80A3
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16FCA31201FC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248A32FA0F;
	Fri,  5 Dec 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1J6qb7fo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3F14A60C;
	Fri,  5 Dec 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945974; cv=none; b=JqF3Dnxr4ifFVG0QZErxrHxQQXJT2sGKTWDFwXuGs/QaETGeBbcDAQtihP3gbJv+BSLOyQ1F4/67djyr5PfETX+CgTDTgSFSIounJJVar68opHIruBymbSiyDmEXVPXrgUd0knqO6Z5c7loTOf2RVodUTEZfg4xUmskvUK/OjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945974; c=relaxed/simple;
	bh=dYsztzXz5PvFB7smJL3n6kXKahriYGaD0YGhxodeZGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6vd55mGLBVa0RIBdbmoje/kokVSn/t5M2qoS3rtPKQumX5uN1EIIa/NA7oPUr2Sh6TTGKD15WBE1rUUsFel2yx/bdg0pLw4g63nEhFifg2i6IY8tDGwTdlhQt5C2JefvqlHDW5h0ytjQ2P0c+O/mK9RGLxG8DwV8wJ4FuXcodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1J6qb7fo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5BYPOu3489322;
	Fri, 5 Dec 2025 09:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0IuZR
	chbEKw9VZfMlLgQiApoP6yXDV3dvZPt81rD2QA=; b=1J6qb7fomW3D7JmPHZce/
	dXJAVTbwJoI5rmuoz4txNIqa7493gsFcePD7n4Zi8AqJv+WtTCApf85PQg821/qr
	xvM6cVbvBbazvtak6jGw63CdXwMSRvIcJsy9tSbvVL6ihc7zV03a81uAYb5gVMRf
	ko7u6wvdvHcGoAz7qGH1JlnkSlcBrfDoQN3ple4JVy0NTvst82qbffF6Hh/rkyzf
	ajZzbIqlAtiA/tFzQDywoXwhl6YmqDmblhAbXaQKpkVNbSJbfaSDuBe0OalOVYKD
	KVOhC9tiTk/i9s9yhOmMnqZOIQkqrNmnCIWg0p9Y4DFtyQBy0ihe+ENQl2K75fcJ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4auhvuuxgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:45:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5Ejr6Z029913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:45:53 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:45:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:45:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:45:52 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5EjRaZ028130;
	Fri, 5 Dec 2025 09:45:45 -0500
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
Subject: [PATCH v6 1/2] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 5 Dec 2025 16:40:40 +0200
Message-ID: <20251205144058.1918-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205144058.1918-1-antoniu.miclaus@analog.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNiBTYWx0ZWRfX6ZtWfsE0nNvY
 uEgYZzG0AOJW5W6VbljW0k2Cp+3apu4EPfNjKSOlsYUmNg5LFoz8VR+mF20gIXARi+AKRQRgERh
 XPgELnaTXu4wglE9KkRqlBBmpTI86nvLvyZdKbXqhRGh+MhsS1YB/mzuXjF0f8m7UXhqVLPHQhG
 R3mjoVjEuSUS/PTuZ9KZKFcSMW/SxoDKHSXUtGH+DCy/ICq6MD/zwMeS66hRz5SlQBgSwkW3/z8
 LnTaAN1mnqTTdnSHgCbVKvg7+9yj6qaXv08bwXaXCUPCsDhuJ71gmdOuoqaIyVDUJTNW6uWlIw5
 5niyVRQ4Z1Ct69JH7asmeoWDasZYTwcsRJY3qr1cVpuBHprg+VISzHcKl1lmTGCrNDubWL4cmhV
 qpIQNo9mo+2b0M4vfWZ1qsPUL5Hmww==
X-Authority-Analysis: v=2.4 cv=Q+nfIo2a c=1 sm=1 tr=0 ts=6932f022 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=1yNy12B5puk2P9Y3jxYA:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: LvL6XtJkZYFaJZi0woR2zxpyph6dl9qm
X-Proofpoint-GUID: LvL6XtJkZYFaJZi0woR2zxpyph6dl9qm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050106

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - Use items list for ctrl-gpios instead of minItems/maxItems
 - Simplify ctrl-gpios item descriptions (remove GPIO_ACTIVE_HIGH mentions)
 - Remove maxItems (implied by items list)

 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..28b3738cb675
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



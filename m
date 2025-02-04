Return-Path: <linux-iio+bounces-14986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F9A27758
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0B93A6006
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBA421577D;
	Tue,  4 Feb 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VKDfSwYX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96082153CE;
	Tue,  4 Feb 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687105; cv=none; b=LLgpXubN/1X0o8zzdXkWdVN0ZqQcNkIIuKKK5WlfiveOlFzYWDn/ehYLJou1NFZ0Cnagsrf6llHKeSW1E5Sb9diNYYmZA3a+kNXm8LB+etHR6HCvCGq3njQZe8KzJep8TeH2Ick3NtqtrfxQElE2SfndltjCIGcq/7juOY3cI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687105; c=relaxed/simple;
	bh=X1KDd8I19lWMb2QrgTh4JsT84bmPcLQw1XUepdZsNfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwDW3cnnWxpidsQcxNuZpXPmUvwTG/duB7GnrizWeC7NIeHYX7YGyEcSKFetJUVyssiBSac8mtMW+0zOC8uekUpBW7C58BjV7rDSiu1GQkwTTecU1Ou8Yd4eIimxu83Oy95qnkFv66TUXLL/l2HceFQNnh4JZJupvUBcu89Miwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VKDfSwYX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GLphF002559;
	Tue, 4 Feb 2025 11:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S9JlC
	qdeEBGoGQeQcRX4353whzl+E5CJOBQNBgmLk3c=; b=VKDfSwYX7iuAKVXSmsrJ0
	sjMITiP0266kMqJd2WhAOLcO0qQW4+iAooC0me+ewsScHJs5l3h3NUA5s+OL5pSI
	I8knNWN1dM637WN1m8kdxCcpIOEKkbDRp5UZXPZJbmLk3jua7OcZy2XMXIh4o53E
	iU3En2hrUVRvEA66R+tIUFb/uvJOck2yd+mDum7Ejo0NFg6gPDN5RwXtb2voviaw
	AyYISABfzyFGLxenxF5v59Q+SqkxSbWjrI0cQVAxjzBU/BEOUoVL66q1hYTQfvLL
	Tt4dGldDTpWg0R/fGBw6In89MB8q3uVPZEfpidrj4n8sB+N0g9vODbn28tV3iaee
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44kpbmg24h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 11:38:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 514Gc4Ii047812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:38:04 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Feb 2025
 11:38:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 11:38:04 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514GbMFJ009577;
	Tue, 4 Feb 2025 11:37:55 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nuno Sa <nuno.sa@analog.com>,
        Ramona
 Gradinariu <ramona.gradinariu@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Paul
 Cercueil <paul@crapouillou.net>,
        David Lechner <dlechner@baylibre.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert Budai
	<robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
Date: Tue, 4 Feb 2025 16:36:08 +0200
Message-ID: <20250204143612.85939-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204143612.85939-1-robert.budai@analog.com>
References: <20250204143612.85939-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ojyBZwJinmzRDchQGJ6Y1VxQGknPDVrb
X-Proofpoint-ORIG-GUID: ojyBZwJinmzRDchQGJ6Y1VxQGknPDVrb
X-Authority-Analysis: v=2.4 cv=A5OWP7WG c=1 sm=1 tr=0 ts=67a2426d cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pUeHu85uJSMuaNPCY0MA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040127

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v6:
- applied blank line suggestions
- added clock-frequency dependency change suggestions
- yamllint corrections

 .../bindings/iio/imu/adi,adis16550.yaml       | 83 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000000..8750bb937979
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16550 and similar IMUs
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+  - Ramona Gradinariu <ramona.gradinariu@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16550
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 15000000
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  clocks:
+    description: If not provided, then the internal clock is used.
+    maxItems: 1
+
+  clock-frequency:
+    description: Clock frequency in Hz when an external clock is used.
+    oneOf:
+      - minimum: 1
+        maximum: 128
+      - minimum: 3000
+        maximum: 4500
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-cpha
+  - spi-cpol
+  - spi-max-frequency
+  - vdd-supply
+
+dependentRequired:
+  clock: [clock-frequency]
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+additionalProperties: false
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        imu@0 {
+            compatible = "adi,adis16550";
+            reg = <0>;
+            spi-max-frequency = <15000000>;
+            spi-cpol;
+            spi-cpha;
+            vdd-supply = <&vdd>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6247500cf427..8913e13dcaef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1452,6 +1452,15 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 F:	drivers/iio/imu/adis16475.c
 
+ANALOG DEVICES INC ADIS16550 DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
+
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.39.5



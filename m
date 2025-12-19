Return-Path: <linux-iio+bounces-27219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D614ACD086C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624C730EF205
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BC338F35;
	Fri, 19 Dec 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1YcN51yd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D523A562;
	Fri, 19 Dec 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158311; cv=none; b=art3QsIHi4W/FCWTCU9dY0FMJTSnRWO+jbRqkrNMDJ2Ps9L+o9YEjm64Ssv3zA3EN/H7EwAWv4hLiOJr/6JZ+AdnbXuD5xZeocy6HeI73in6ukDy3QEM5Ci6Gzi6Jo4JQtLsNwzmyxQ9Il6E0Lqb+F03nE2PM4QSogaTZJwkUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158311; c=relaxed/simple;
	bh=vK5zy7xUTMpm0dMt5vRRh+s1YkqE9I7fUDylbKIKScg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ASSLs5jiBsxUfakFgnr3HslQ0boVsmQsYsH0Zcp1Rn0vH2xmz8OKDRzQTv8jlg8oeWyyOqePG9x5mxRHclqI3hQrz+JtIylhxbiS9YiqSfRjknqiz4MHmScF4jkA0+xiSmNSBrqeT7yygQiezufVDvqsDYvBkbYhLN2gTygGcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1YcN51yd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJERHaI2185210;
	Fri, 19 Dec 2025 10:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7IVh4
	BZAUgoRydx+v+OWvTpEH3E2+kRfI3AOD1jxVUc=; b=1YcN51ydNmiJe+oTscU8Z
	Run+F8hig7ueM7cN1C+Cas/CIsK9O2N5uuasjKmslX5SHWl8QY+5ZKEtJSlxiNcE
	khuetQT6S8SmrPDbHlQwO3SvV9DlQEEqNXzZPGj9/6aeqqhHez9ckGKs7ZCHQnXH
	+LRCG+1IFjtXq6lMA+b88OaAHh63wf0CAmNeK7WVBsqK0Qsjea0FU+rWa5tO2gx/
	vswOFnn+anIQswg28rNORpluWjgDayjlEmjnACXh4qkJA97Tr2GKxmEot2AruIIX
	GNQd/e6nfFO8iApTbfjTf3TVFPEtmYwQOHwiz8mf3JDv6b8wDId4Zdzw7Tz2yGtQ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b4r3ucrvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 10:31:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BJFVW2h051281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Dec 2025 10:31:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 19 Dec 2025 10:31:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 19 Dec 2025 10:31:32 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BJFVIW3004160;
	Fri, 19 Dec 2025 10:31:26 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 19 Dec 2025 16:31:15 +0100
Subject: [PATCH 1/3] dt-bindings: iio: dac: Add max22007
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251219-max22007-dev-v1-1-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
In-Reply-To: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158278; l=4218;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=vK5zy7xUTMpm0dMt5vRRh+s1YkqE9I7fUDylbKIKScg=;
 b=HhJ/BJ01w2qBAfmVx6lvjI8mCcCJd6728XaVTIjQt4KcLXkrNreoFLDTBQWv2dWPgXWW3atLw
 RX7LSWLr9j5AIxK/b5uX3PkUo8FJFIMrcWgo6xTGMHxZMHz/nZhweBJ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69456fd6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=5yLO_ytG1KKSPBdCm3cA:9
 a=QEXdDO2ut3YA:10 a=9pxso9FRmSwA:10 a=kMJE-xFm7jYA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: JBJikc6jougt_z2vMaGwjUo-JyQxtDcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEzMCBTYWx0ZWRfXwwIWaBk+n2KO
 zUIfq8bFvDDGpspWcy9CPJwEZ24yEKf+lRr7y+KYfxUX58NG2fD/iYppwLlTp7X89w+KFv68wAJ
 XvpYQPSdIMemv4Xt7/8XMGmriAmQtSz0NnoOcR9IQTfOTNBr+X9X2qnJtqS1S0k0gCqdac1lqvj
 V0uXetfpJZqr88/vhL5XN5XX6GoYnX/aBc5xmxDxew+bTRDPu7xk3hNZRf0mnpP6Kiq1BhI0Dko
 ArQXVwifW77iI1k8Wx5a4RpNnIRkSUajO+DWniHXkcLjc1Hld3sYOn5W3X6za7aYwrk6zCdYel/
 5xS6I4K37jgQlKyVyerphHwIIFcWczQlXI/uKsBxn4sx//rh7G/HSjMT7liPC9pNrzYnyG7gffB
 l5E2KesyQ6skOl069vkI2sVbUlkCMFsmfLjVAfAxAmxo/yi2OVyS9xlURmpEqM7WpRaQeQdazc3
 NPUizUZvxpTiEuKfn8w==
X-Proofpoint-ORIG-GUID: JBJikc6jougt_z2vMaGwjUo-JyQxtDcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190130

Devicetree bindings for MAX22007 4-channel
12-bit DAC that drives a voltage or current
output on each channel

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 123 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
new file mode 100644
index 000000000000..c2f65d9e42d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX22007 DAC device driver
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description:
+  The MAX22007 is a quad-channel, 12-bit digital-to-analog converter (DAC)
+  with integrated precision output amplifiers and current output capability.
+  Each channel can be independently configured for voltage or current output.
+  Datasheet available at https://www.analog.com/en/products/max22007.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: adi,max22007
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 500000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd-supply:
+    description: Low-Voltage Power Supply from +2.7V to +5.5V.
+
+  hvdd-supply:
+    description:
+      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
+      the Output Channels.
+
+  hvss-supply:
+    description:
+      Negative High-Voltage Power Supply from -2V to 0V for the Output Channels.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO used for hardware reset of the device.
+
+patternProperties:
+  "^channel@[0-3]$":
+    allOf:
+      - $ref: /schemas/iio/dac/dac.yaml#
+      - type: object
+        description:
+          Represents the external channels which are connected to the DAC.
+          Channels not specified in the device tree will be powered off.
+
+        properties:
+          reg:
+            description: Channel number
+            maxItems: 1
+
+          adi,type:
+            description: Channel output type.
+            $ref: /schemas/types.yaml#/definitions/string
+            enum: [voltage, current]
+
+        required:
+          - reg
+          - adi,type
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required: [channel@0]
+  - required: [channel@1]
+  - required: [channel@2]
+  - required: [channel@3]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,max22007";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,type = "voltage";
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,type = "current";
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 29340394ac9d..e1addbd21562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1593,6 +1593,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 F:	drivers/iio/dac/ad9739a.c
 
+ANALOG DEVICES INC MAX22007 DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0



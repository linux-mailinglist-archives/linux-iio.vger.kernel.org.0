Return-Path: <linux-iio+bounces-17240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F88A6D918
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CFC16F13F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2525E814;
	Mon, 24 Mar 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PpoH5GVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E425E803;
	Mon, 24 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815458; cv=none; b=FvUywe44c0eq41MhqCSY8PTDomlUCjI6UU+nymRuNYCPtQ2So4e3cCJ1R00suwBpUqZOlvtCPVJChhnbQb+cLWqRV2swxhBuR+NNmDimYfvhox7j1s3M3YSJj8g/3jCo0tAo7ntHAbAwb4RLghaJ5emJMPfIWoS47Q9OX5aVXeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815458; c=relaxed/simple;
	bh=TinZklBMT/iKZQ9uXQx9l/AmDbOXUBblsln/dj7+SC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XKDHjoxQcko8udUWwkQSoDup2WLZm5LiqTIUrWKMhZn444qVc3fRLae6z28TOu5Gx9TXV6SeovjkR3aqvQVHnyQjgeWCHA78JBF1KPe/ljmN/VAyBSPwE6uBn8O6ceqmn5W/IilrUiur/6ECw5udtJ6YXY9wIp7GV5Y8wDtrQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PpoH5GVd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBC2VN015832;
	Mon, 24 Mar 2025 07:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=58ewA
	EIoaGt6Qb3u+lIyl8GC4sC5P9T9kCPdatwaoPE=; b=PpoH5GVd0SI94Pr74oaVv
	0dgSq5JVP6LwQUUTDMZcClDFo/ZhDeDLs/2AUG4pltsvo1Y2ny3JH6y1z4YIKh3p
	a4qNGszbT2Z7GwFCFn7QjrfLQ6h2m1RGxU4NKZ7pFEDTWnJDQdXP0onQhntQlST4
	3+Qi0zmgZISFZ9Mtwqyos7ddB9fGb8mlwX2Wmr6MUnTfmtr407CgLmh0+nCLOpVp
	qdKrdb3U5tuJ6T1SD0CtTEwsfFaPde/vWWqKkwx0qeerITSVmuXucCTsiO5SaX43
	cIso3cSk+KsHmK80GBSdNint/lZt7Sq/PAjjIhqhxxmxG6earmagGjG2y+8F3wC9
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k6af8252-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:24:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52OBO0YY052264
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 07:24:00 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:24:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:24:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:24:00 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.117.223.46])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52OBNb9j007643;
	Mon, 24 Mar 2025 07:23:53 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 24 Mar 2025 19:22:57 +0800
Subject: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250324-togreg-v2-3-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
In-Reply-To: <20250324-togreg-v2-0-f211d781923e@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742815405; l=4333;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=TinZklBMT/iKZQ9uXQx9l/AmDbOXUBblsln/dj7+SC8=;
 b=FWsTenPznvgRCHO2IwRXLrZKAGFqlIM+k6S3BhmrTZe6jsDL5Su/WCc2Y6JDGHOe9Ige9hCgm
 kp2aJVWdWstAaei1vBUHiKHfEBgHqGlv1JrSJxAvwM/7vLK9cDZQdmq
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bXmr8RsIQ2SAVnh_6R0skhsrwTY1eDE7
X-Proofpoint-GUID: bXmr8RsIQ2SAVnh_6R0skhsrwTY1eDE7
X-Authority-Analysis: v=2.4 cv=FPEbx/os c=1 sm=1 tr=0 ts=67e140d2 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=hZcF0UcvHcGr6ch5Xw0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240082

Document the AD3530R/AD3530, an 8-Channel, 16-bit Voltage Output DAC,
while the AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC.
These devices include software-programmable gain controls that provide
full-scale output spans of 2.5V or 5V for reference voltages of 2.5V.
They operate from a single supply voltage range of 2.7V to 5.5V and are
guaranteed to be monotonic by design. Additionally, these devices
features a 2.5V, 5ppm/°C internal reference, which is disabled by default.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 91 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e581472b50048bedda7422748035423b9b020382
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad3530r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD3530R and Similar DACs
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  The AD3530/AD3530R are low power, 8-channel, 16-bit, buffered voltage output,
+  digital-to-analog converters (DACs) that include software-programmable gain
+  controls that result in full-scale output spans of 2.5V or 5V for reference
+  voltages of 2.5V. The devices operate from single, 2.7V to 5.5V supply ranges
+  and are guaranteed monotonic by design. The AD3530R also offers a 2.5V,
+  5ppm/°C internal reference that is disabled by default.
+  Datasheet can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad3530_ad530r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad3530r
+      - adi,ad3531r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  vdd-supply:
+    description: Power Supply Input.
+
+  iovdd-supply:
+    description: Digital Power Supply Input.
+
+  ref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin.
+
+  reset-gpios:
+    description:
+      Active low signal that is falling edge sensitive. When it is deasserted,
+      the digital core initialization is performed and all DAC registers except
+      the Interface Configuration A register are reset to their default values.
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels. If
+      not present, the DAC channels are updated by Software LDAC.
+    maxItems: 1
+
+  adi,range-double:
+    description:
+      Configure the output range for all channels. If the property is present,
+      the output will range from 0V to 2Vref. If the property is not
+      present, the output will range from 0V to Vref.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            compatible = "adi,ad3530r";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            vdd-supply = <&vdd>;
+            iovdd-supply = <&iovdd>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3c31c74594ca1934c67e7aad0a179feeaa39bf..7862469226f52375adc219115ef68d03662127be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1295,6 +1295,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
 
 ANALOG DEVICES INC AD3552R DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>

-- 
2.34.1



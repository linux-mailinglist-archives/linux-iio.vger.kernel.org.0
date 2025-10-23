Return-Path: <linux-iio+bounces-25369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E9C009C9
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79380359C0F
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13930BB80;
	Thu, 23 Oct 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H4J0fnn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165A3019C4;
	Thu, 23 Oct 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217328; cv=none; b=q6tXLi1udXtFLr0xnqype7aJPt2lyCo2to9HDYRj2a2Ye4VL9oTq1CKnjtuZjYkIldYsPTqptYvP1rp6/HGenX9CKT8/pfhvn68VqSZHZWUAQqcj5SatgppRQF06YI+D7jDsYXM7LaXrgeSokHt2/+RmFxJTf9GJTPkmumZqeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217328; c=relaxed/simple;
	bh=0BSPG/8vxxnKWjulSgqfUyKDC+4ooPOY9auPa5vFXbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=omgyxflJ3J6VK+Sb9M6rwczTLifyXkFgJmQgnvfnI76Uwc/Mist8SZr/YQT+Wh5npwXw53Mf32A0799dyVTiNpEblSU5auug7DsdbbopwGE3b+X7UIlDchfhTrk5v22pqUl1aXzVwE3A7KPrOeI/Oqf4TNR5pExHHf+z9zamlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H4J0fnn+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAjwkv005538;
	Thu, 23 Oct 2025 07:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hq9w+
	Vw3YedLxRJZ4DRwokfEuIMZvTC5153hONKjIvs=; b=H4J0fnn+IjNk45BxUrpB5
	Bhd4WQsIOEG8OtprRyOw8LFfFiu2dEKZdvO/veIsowBxbsvQ7OYbRMJ4pfBzAPlG
	uIvcjVpRoX29ZNRiBUj//8CUHESyHq6XYpuZ2niGzXgd1J25efoo8SgU3D0GobGc
	n64IUWgyzDNPfXkx3X90p9h1Sbwok8Pkq4cJL5aJa92394epZpBQVFaf6e7ICPcC
	FZ8J8QtE51SuIKoWMz1KdQ2ROkTVAha88c0Y+j8stK8OWlqljMxUdVI1zZ6zEhS+
	59by6PeQEf0aiosUKVQf9B5p1fjTOIRdHOV7fpAa4sgfkHKzyVXYmfSbhoFaT8qG
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49xmgut3rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:01:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59NB1q6o015072
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 07:01:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Oct 2025 07:01:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Oct 2025 07:01:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Oct 2025 07:01:52 -0400
Received: from NSA-L02.ad.analog.com (NSA-L02.ad.analog.com [10.48.65.124])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59NB1equ027813;
	Thu, 23 Oct 2025 07:01:46 -0400
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Thu, 23 Oct 2025 14:01:37 +0300
Subject: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and similar
 devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
In-Reply-To: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.15-dev-52d38
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAwMCBTYWx0ZWRfXw07VfUPIdhsW
 Z0BONb0UkkNW5VWwDPlYxZE1RJNFHj7UIK8/DSXj1rDoGR9A7P6ifZIXbPsc4PO6TBNHuZMSKwf
 hj4VwnqVa6Xj1hXSUc0Kn6N4g98KBKnCT4eIou6610gTz6VB4cp/d9PiZ2oT70ovrj3qrUhDPLX
 FSN+yfbzdLV5zHkb3OkkWYG1UsZ6MGUcMjxnYq1W/eSgEdKP4rEMtsCsSjrrdz86AzNZ5Y/+bCW
 QztCL4keAcILFe6+trLdOG7aPTq8m6XD/xpCVliqw1jnvHvtP8EfPiRCs27z9+pwG7N/y5j0HXH
 HhGNoYvzV50vnB8Gjn0ec8x06N6lAndwGYFyertt4it2uu3XTqoM2r4dWrYDyKeylizaXPsXNlM
 iB2mOQ5HBEzV4QwrzRtlUUDtP4DYpg==
X-Proofpoint-GUID: Sz1Hek1dVaBPu9O5BSBGrL3LfTAvQ-Oj
X-Proofpoint-ORIG-GUID: Sz1Hek1dVaBPu9O5BSBGrL3LfTAvQ-Oj
X-Authority-Analysis: v=2.4 cv=BLS+bVQG c=1 sm=1 tr=0 ts=68fa0b21 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=6sdQMV2qbPr6H9Z-uYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220000

Add device tree binding documentation for the Analog Devices AD5446
family of Digital-to-Analog Converters and compatible devices from
Texas Instruments. There's both SPI and I2C interfaces and feature
resolutions ranging from 8-bit to 16-bit.

The binding covers 29 compatible devices including the AD5446 series,
AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
and TI DAC081s101/DAC101s101/DAC121s101 devices.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++++++++++
 MAINTAINERS                                        |   8 ++
 2 files changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
new file mode 100644
index 000000000000..90fc8ca053fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5446 and similar DACs
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  Digital to Analog Converter devices supporting both SPI and I2C interfaces.
+  These devices feature a range of resolutions from 8-bit to 16-bit.
+
+properties:
+  compatible:
+    oneOf:
+      - description: SPI DACs
+        enum:
+          - adi,ad5300
+          - adi,ad5310
+          - adi,ad5320
+          - adi,ad5444
+          - adi,ad5446
+          - adi,ad5450
+          - adi,ad5451
+          - adi,ad5452
+          - adi,ad5453
+          - adi,ad5512a
+          - adi,ad5541a
+          - adi,ad5542
+          - adi,ad5542a
+          - adi,ad5543
+          - adi,ad5553
+          - adi,ad5600
+          - adi,ad5601
+          - adi,ad5611
+          - adi,ad5621
+          - adi,ad5641
+          - adi,ad5620-2500
+          - adi,ad5620-1250
+          - adi,ad5640-2500
+          - adi,ad5640-1250
+          - adi,ad5660-2500
+          - adi,ad5660-1250
+          - adi,ad5662
+          - ti,dac081s101
+          - ti,dac101s101
+          - ti,dac121s101
+      - description: I2C DACs
+        enum:
+          - adi,ad5301
+          - adi,ad5311
+          - adi,ad5321
+          - adi,ad5602
+          - adi,ad5612
+          - adi,ad5622
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description:
+      Reference voltage supply. If not supplied, devices with internal
+      voltage reference will use that.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5300
+              - adi,ad5310
+              - adi,ad5320
+              - adi,ad5444
+              - adi,ad5446
+              - adi,ad5450
+              - adi,ad5451
+              - adi,ad5452
+              - adi,ad5453
+              - adi,ad5512a
+              - adi,ad5541a
+              - adi,ad5542
+              - adi,ad5542a
+              - adi,ad5543
+              - adi,ad5553
+              - adi,ad5600
+              - adi,ad5601
+              - adi,ad5611
+              - adi,ad5621
+              - adi,ad5641
+              - adi,ad5620-2500
+              - adi,ad5620-1250
+              - adi,ad5640-2500
+              - adi,ad5640-1250
+              - adi,ad5660-2500
+              - adi,ad5660-1250
+              - adi,ad5662
+              - ti,dac081s101
+              - ti,dac101s101
+              - ti,dac121s101
+    then:
+      allOf:
+        - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5446";
+            reg = <0>;
+            vcc-supply = <&dac_vref>;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@42 {
+            compatible = "adi,ad5622";
+            reg = <0x42>;
+            vcc-supply = <&dac_vref>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 940889b158eb..dae04c308975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/regulator/ad5398.c
 
+AD5456	DAC DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
+
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported

-- 
2.34.1



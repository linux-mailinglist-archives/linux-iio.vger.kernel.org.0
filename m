Return-Path: <linux-iio+bounces-17074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF6A683F3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 04:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEF41898C68
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140242505A4;
	Wed, 19 Mar 2025 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lCR29ME2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714D24F594;
	Wed, 19 Mar 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356147; cv=none; b=nGQUON0Pni3Ji6CTzJ6yPvBmxVkl1ST7Gm9uNtkRhRWeyCwyX/EhyA0YvmcfOszktliK3F5Mrc70UZgr9xeyXW5zNLt3gVni8YHR0CkSMvLSZ1sv4pU/fjebQxtttW1WETribizgecahSM/t7pZOQNN/vd3BMd8LT3DpchlwHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356147; c=relaxed/simple;
	bh=fqGaDi6CEGtr6aN5AoDCETxxq7c97/855AnwrPFBq3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EQlv/gd9GxAkbmPDr5wHv1jPtuwRJzY14NKx77UFcemdS5XnvHuxTf7ZoYLV0SoXwmHLDxNubhv3tUaHFcdSQjiCdHV6R0Suv5SyttNtfSt6DIOgyowBvRvfLOm0b8hZprVHzkimgOPUi0vgj/yd1L7uMmbY63590mXAlkf+rIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lCR29ME2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J31fjr018542;
	Tue, 18 Mar 2025 23:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g4H2F
	LVmNuJQQYv+Khttx/658O5YgAdDmmbY/EBDXGk=; b=lCR29ME2H+qiX+UUZChNc
	4z4hb+57CMWUyDOyqYB6wdFBups0WlkUbmbAkihIzbvEMGU/gdkFaWEX8mpblkfp
	x0t7KxVn0R2zqeFv/dvPSlArse5JGnr/xl7izE+vt/otW57qR0oPeppFE1mNDKOL
	aqDHBYhqKb+FTKaLATNQLdf6CSIC3U5hMbZQDlZ+mPl7vLX4tCtmQ9ohD7chhHlD
	GAgKzmRkrpH3Jzd6FLYbzncEM/PgBuCHh214qIRgtNjVu9V60k8rDFN0CvZwA+Cv
	5nghU38c2/CxgNBnQFskrajLEizMr+zEKqu04VwaI3CcSnYem3ehxrSSGmFLqu10
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45d6f9tr7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 23:48:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52J3mj5K013795
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 23:48:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Mar 2025 23:48:44 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52J3mIC3005894;
	Tue, 18 Mar 2025 23:48:34 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Wed, 19 Mar 2025 11:47:57 +0800
Subject: [PATCH 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250319-togreg-v1-3-d8244a502f2c@analog.com>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
In-Reply-To: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742356088; l=4199;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=fqGaDi6CEGtr6aN5AoDCETxxq7c97/855AnwrPFBq3c=;
 b=ry0t8lXj/tfI7t2LnwP0rpnpoPbjBmLFaxuzqA1nd6QTpxRVJ6qB4oRgZUdpKn0hxQ+4GnMZI
 HMNTcq68J90As8rbKGqg2RC2EAJTEoQk5pqTsr04oipHg0rmR+Km3sT
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: krB0krQdB-UkkP9HxPBgNzqj9fPK7csU
X-Authority-Analysis: v=2.4 cv=Fv4F/3rq c=1 sm=1 tr=0 ts=67da3e9e cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=BUQpAGyeIh8Ww08V4EUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: krB0krQdB-UkkP9HxPBgNzqj9fPK7csU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190023

The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
include software-programmable gain controls that provide full-scale
output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
be monotonic by design. Additionally, these devices features a 2.5V,
5ppm/°C internal reference, which is disabled by default.

This adds the documentation for ad3530r.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 89 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6b50dce38383c8eb0d2107bf4e44cd320776f481
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
@@ -0,0 +1,89 @@
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
+  The AD3530R/AD3530 are low power, 8-channel, 16-bit, buffered voltage output,
+  DACs that include a 2.5V internal reference (disabled by default), and a gain
+  bit field, resulting in a full-scale output span of 2.5V (gain = 1) or 5V
+  (gain = 2) for a reference voltage of 2.5V.
+  Datasheet can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2664fa.pdf
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
+  adi,double-output-range:
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



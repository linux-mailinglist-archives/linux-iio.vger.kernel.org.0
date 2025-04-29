Return-Path: <linux-iio+bounces-18804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010FA9FFAC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A217C7AAC6F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA929C34E;
	Tue, 29 Apr 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z+G7tD3d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1F29C32A;
	Tue, 29 Apr 2025 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893221; cv=none; b=ndArIecMTc+M9EsMz9um4qjaHziSHZPZPG2nLCgEWMAE07AeSgMbV1aOLTD4ZK0SddTE/hccb5WE6vGn6/pq5qvDVhosRcoUf9zwqocVoblT85qbKnkIa+bta3T+lEhALp66seYNLSmmSHU/HyH7QFMeZUpzJTbeQYo4VqLJnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893221; c=relaxed/simple;
	bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qrIWAN1GXgpHvf2j8xegDKdOXMHgMKjsW/mW0xUso4SuVqMD1s1AGmwRcFQwpaLbYlxfqOniX172fa9YGUnc4A0kXXeD9taGeIhD2tsPLizZvkcWQvHMsNcNbmLCSYSs+lbd76XC1xNe0Y0pXMfkYoirwjJ89Z+zq+HAjvVz36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z+G7tD3d; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKVgbM020322;
	Mon, 28 Apr 2025 22:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j8dHb
	lG2kykuHrTdQ0WkrIQkx1jSkONVGSqRAC6dk34=; b=Z+G7tD3dzGqDlLxESamGV
	wEmQUMMgUeb/YV2/DtuVnZTiiItMsuKanYz555bQPEq8Rmt0yIWz9s5BjxQhRHIi
	CJwyBEzrQi+uEVklItCr/VL8n+GI7nsC8Mhahi6bouJYnP3E5Xr2yFNox+Vb6uDv
	Y1l1q2iMWm8fK5FnAZdm3l+Eh3daENBVSDOpEJ5UKZoob8kNiV0xTOZVT3H7FT9D
	RblCdz6Be/JA2hd57Ae42VwjgG6xOyhTkvuZ+TJCB8/PSQQiRJZE2LxCQxfHmQKC
	LEzo4WQeBQh1kNU/v6a5jucGhJQpdvShHcNog5xK0YUQOIyV3A3dELHj2l6tQr/G
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46aamcau5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 22:20:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53T2K3Ej051544
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 22:20:03 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:20:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 22:20:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 22:20:03 -0400
Received: from LRADU-D01.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53T2JPCu007738;
	Mon, 28 Apr 2025 22:19:50 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 29 Apr 2025 10:19:17 +0800
Subject: [PATCH v7 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250429-togreg-v7-2-0af9c543b545@analog.com>
References: <20250429-togreg-v7-0-0af9c543b545@analog.com>
In-Reply-To: <20250429-togreg-v7-0-0af9c543b545@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745893165; l=4981;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
 b=Kja8yJFpPjIFHwyK0OdqD9YL+eg4Zl7X4JKAW7iTO3nZ9J2t3x34uOpSoWFpls6Pj7KDLS15j
 iWTIw7Q9SqxCGkp13w6L6ZtOJTwbhmH3DSylktNacg3eZufKhgWFaxj
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 26qm9-7zYNVA6sza1E-S9Yf8eX8M_ANT
X-Authority-Analysis: v=2.4 cv=BOuzrEQG c=1 sm=1 tr=0 ts=68103754 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=Mm4sZ1b9CvxOHCGzALoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 26qm9-7zYNVA6sza1E-S9Yf8eX8M_ANT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAxNSBTYWx0ZWRfX6ytRoL3aLFTo BZeTf7mlQuzO9QBwOVQfT59sHb3cQioh7oBoiQtrXpsKIKUobms9+PdlTarxsqw7bHGt88kPZbl JXOrRgSLtySZVYWJEUYFp3owNCA6NhCNhEJxOAtNP3Tor2RCrQkrwgYkEfv9BVFnlPUbWtmQ8dy
 Amb17ZxKyT0G0VILAmDqmDbNDeTabMEAWsjewZa6ckXvHzpm8fVhoRMjXxjLLIqR/8S6hFy/NKi RyXwXumrHa/rvlGNVFnH4pfTzCZpLTPV4Ik3Yc4FE3biCnx8OvU408ksoOsL5F/hDeACitPU5Oj lP/tysdGd2ApGySsAX9svMwMRCHtFI+gQFf/suHTd649JjvOAY6xC7FRewfXOomswj16dQ8szEm
 /fWHS63K7wEyMPl2h5hmhCMZPW9PUMjQ34dn54jbrtMS3yHTI/AjbifTaHXIHVIZNdBmlx1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290015

Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls. They provide full-scale output spans of 2.5V
or 5V for reference voltages of 2.5V. These devices operate on a single
2.7V to 5.5V supply and are guaranteed to be monotonic by design.
The "R" variants include a 2.5V, 5ppm/°C internal reference, which is
disabled by default.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 100 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a355d52a9d641e488fe291b97bc95ed115e96afd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
@@ -0,0 +1,100 @@
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
+  The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are low-power,
+  16-bit, buffered voltage output digital-to-analog converters (DACs) with
+  software-programmable gain controls, providing full-scale output spans of 2.5V
+  or 5V for reference voltages of 2.5V. These devices operate from a single 2.7V
+  to 5.5V supply and are guaranteed monotonic by design. The "R" variants
+  include a 2.5V, 5ppm/°C internal reference, which is disabled by default.
+  Datasheet can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad3530_ad530r.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad3531-ad3531r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad3530
+      - adi,ad3530r
+      - adi,ad3531
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
+  io-channels:
+    description:
+      ADC channel used to monitor internal die temperature, output voltages, and
+      current of a selected channel via the MUXOUT pin.
+    maxItems: 1
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
+      the output will range from 0V to 2Vref. If the property is not present,
+      the output will range from 0V to Vref.
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
+unevaluatedProperties: false
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
index 01079a189c93697c1db6b0ca4e54212d25589974..4ca59fc1bf25aa49fecf78a90b2e1b73f25a2c05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1300,6 +1300,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
 
+ANALOG DEVICES INC AD3530R DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+
 ANALOG DEVICES INC AD3552R DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1



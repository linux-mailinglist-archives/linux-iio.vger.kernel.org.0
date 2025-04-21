Return-Path: <linux-iio+bounces-18395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C276DA94BE8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 06:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B0F7A53B0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 04:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476525743F;
	Mon, 21 Apr 2025 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qnJdWWpf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC3255E4D;
	Mon, 21 Apr 2025 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209553; cv=none; b=e0ISJRZztijlHtYcMWK1LsZzHAtgi6byX+5oWV3lucnttn9jfW8joApWCbJ5U1f2NFH9fibgbIK2Lf/jzo55YNoVqdC+dhEUNxUvA8F6eH0KoYy8xuBuRIR8/2xRpsT27W4NCCvQHAW+ky2ghq5MQMHkdlAZZKYq3aLyfHvVrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209553; c=relaxed/simple;
	bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B2fX1Wtj9k9b+xwmxl3vMojTN+jm3f5vi06LnUvfkMfMmCx1LyBdghJCrWPo/y6kthBzA8ZX7zywtElU0BF0kjOFSOuZ6JBzL+e19Rs/yy6/27vaW9w9WMKkOwmLkC8rYJzaRCVVPJKIdi/9MMWXuVYnu3exphfZ9rpVrfoBfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qnJdWWpf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNW2x4022383;
	Mon, 21 Apr 2025 00:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j8dHb
	lG2kykuHrTdQ0WkrIQkx1jSkONVGSqRAC6dk34=; b=qnJdWWpfcMaTZW14ivXIG
	d0FW+6OHFW+3AAxSWSvl1jJM69S0Dwf05hpyuODdLSxmJf+T2oUOWHAoR1RVZfy2
	bwX5znfKL0Kpk300wP/7zt0G8qill1IR3yljxxpHquu071Ge08OgmrKk4GcCgXyK
	PmZgOAYmJXYVV/OP8y98SgRNsm3NelkZxbxFSH+P4R1Gfr5y+Z0i2m+kp03sdrsB
	Y8IThU8OBPo+VdTrjpdF11kIZ+2p2xWfK8xINiZkw8fS/F0UvXMh6qr//WS12E1x
	yWiHGI39+X4VjNDc1hKquLD0NiWD6UJuPyM/L7lsjY4YO4uHkmM6YU02V0o8d3wV
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4645p7emrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 00:25:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53L4PZ65018720
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Apr 2025 00:25:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 21 Apr
 2025 00:25:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Apr 2025 00:25:34 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53L4P3oh002018;
	Mon, 21 Apr 2025 00:25:24 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 21 Apr 2025 12:24:53 +0800
Subject: [PATCH v5 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250421-togreg-v5-2-94341574240f@analog.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
In-Reply-To: <20250421-togreg-v5-0-94341574240f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745209504; l=4981;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
 b=glBguZCWx0YZXViWhfv5WoQZcXahs8B5QxBadfnb+v1jakrc0Kl1k/wcR3G0zM+Lz455vXmRd
 hiI1SPoVKr4AjukybGzbBK8yTtFQ/0EVI46ZOfxeDRvHAFuXGTSMABq
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=D4VHKuRj c=1 sm=1 tr=0 ts=6805c8c0 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=Mm4sZ1b9CvxOHCGzALoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: PlMj7A_MEyZcv74M8Hq8VJKfq9hKS1b-
X-Proofpoint-ORIG-GUID: PlMj7A_MEyZcv74M8Hq8VJKfq9hKS1b-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210031

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



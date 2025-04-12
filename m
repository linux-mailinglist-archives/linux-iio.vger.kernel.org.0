Return-Path: <linux-iio+bounces-17992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FABA86B26
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E971B83306
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3581922E7;
	Sat, 12 Apr 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XeddvZy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9918BC06;
	Sat, 12 Apr 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744437520; cv=none; b=YJlWAecQjK1qSH2QEyEeSNLVBn2wxMRskYWAi51EH899ktgEs5vHU0heX3XQbENWVqiKn4ZmAuXJa/KUtbMlnZ8ujYXyOzAVYqc1khC0lh5N8NxsLgnp6UkevQs/KWeRg7vmZE8nPdLL7LvSZGVXH1XHWB5rFbnFT6S08WwV6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744437520; c=relaxed/simple;
	bh=OdMDjTI9vMElJGgf17HPgzk4xDIIwt+t97xdBkKZ4vU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MdyK9jz7YkzduRrKAxumwZ0UncZgxdy210uDoZYvjjpkKbjstFfgnExlSO8lEUYlFWFrkWCBzf+1risNut/ii6+0hBC6vxbablqGCUtme+cbl8J+KUbX5yEuB0wPAhWTSz8t45BDMWB+OTc4WwUgLZpjFfwiamef49ESZVnQdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XeddvZy4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C5PwQw006787;
	Sat, 12 Apr 2025 01:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l4+RD
	NFjb6wMjYUSFNX/a0HnGLcOY6Y6mP7e1MNAebo=; b=XeddvZy4oBBoXUeCsFKi0
	b41suN7p+u3CpHCKdtGHvOmB9biSA45C5/zY1Fb4uAApGTNjaFgzTZc5SSwHdZrf
	fa3WI9RRtJNtVinfkQTANYlACmM/e1FiypGxTMLIQVYqs7IMcbuBXRn/P0NdAypA
	m5+4TRbw/hgOKCPov9vBjYgFKh2Xmtbtb8NIGE5WvTPY4RWyI4V3z6PHDzIlCoyi
	4RWf6Vf1MEBgMHl+BT9T4u2Kn6yFJl4nJ8OSVZ2Xx2DfDq/5tDkcn3BxTPXPQ3uA
	RAWiaRFXdda20jBgByMdwY3a8PAgkF5xwxZIv58IRKJYhinbnqHj1GFT0xmLXgpo
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45yj17839h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 01:58:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53C5wLwG064405
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 12 Apr 2025 01:58:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 12 Apr 2025 01:58:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 12 Apr 2025 01:58:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 12 Apr 2025 01:58:20 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53C5vswW023609;
	Sat, 12 Apr 2025 01:58:14 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Sat, 12 Apr 2025 13:57:31 +0800
Subject: [PATCH v4 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250412-togreg-v4-2-cb9e5309b99d@analog.com>
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
In-Reply-To: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744437475; l=4929;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=OdMDjTI9vMElJGgf17HPgzk4xDIIwt+t97xdBkKZ4vU=;
 b=DeqgrOqG3nvKXdoqI/yMIYuiEhNyNrDFjRd00469Ad4x8EIc5Sk+R4QP2wxeXEm+lUMQlwB3U
 WFKdrvQ6ZwJDzqLoiy4kRK6bODcsT6D3/VUWjBwMPvBxrl23/rOwtDo
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UIPdHDfy c=1 sm=1 tr=0 ts=67fa00fe cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=Mm4sZ1b9CvxOHCGzALoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: x0xhKyL-khBJpqDhLdTYyJhFXir5n6rr
X-Proofpoint-ORIG-GUID: x0xhKyL-khBJpqDhLdTYyJhFXir5n6rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120042

Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls. They provide full-scale output spans of 2.5V
or 5V for reference voltages of 2.5V. These devices operate on a single
2.7V to 5.5V supply and are guaranteed to be monotonic by design.
The "R" variants include a 2.5V, 5ppm/°C internal reference, which is
disabled by default.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index ffdb3f21fc4fb35b349449afbb30fecd4fe72978..9deaf2561ade5b1319cef3cb31b997a4297c0cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1289,6 +1289,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
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



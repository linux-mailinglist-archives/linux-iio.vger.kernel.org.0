Return-Path: <linux-iio+bounces-18651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3BA9C9AE
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BB4E4E70
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8055253951;
	Fri, 25 Apr 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y719QJ4T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10524FC09;
	Fri, 25 Apr 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585745; cv=none; b=pJCOZhvkPiSgIfFtQPujQHbLSnMF1Irdwfjm9SRvR10UV66Dh3rIOAeP8JsAOO/BjOBB8cj8YkcmboFOldzbl3DGUJt4dihZnzVL46fFh6GxscjB2nf8N1WeVGYy3s1NpucEtf9UP4moS2zzNCGSdyCIqc8MhhsAC8oY/GBk4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585745; c=relaxed/simple;
	bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kBAEq4i7rPwbmzl3AJfkh/3kbtMQduvtIRBSe3wXirUm/XNuXCeGWhWTMrxULSDmcG/RpBTP9q7OVwQqAmVj8Es9ucI1ibga+o7XCW1FDDLsgkdyA0e3J0MTE9j/whadqXNT8v6iB8JwJ1uNu1DaLJWyWvrF4eO13jcMcD1wuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y719QJ4T; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCaNjo016633;
	Fri, 25 Apr 2025 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j8dHb
	lG2kykuHrTdQ0WkrIQkx1jSkONVGSqRAC6dk34=; b=y719QJ4T0fTCgHg3lKIQv
	vCXakdgmWYcPlpNLzgvVG+Jq8U7QDYzuozzVSOzPHisC+oKpVAklQriW78x5fgV1
	8bAKGIt6cuuPBPzyewvtHlczkZdAAYzdYjU1CHy9fbMxdf6ezG8FXowAQDIFgCEw
	U2uxBJA1cJwE8MwztIZW4cQ1DvTqoafZK1pAJEXvIk8IME8q8TkNdG+lkk4Losf8
	l7K0iJym5NIMHJoEmpDVT+wZ+ikZ1jBoJLRzSmku8w7M743ARrI+YtCdolyM2UDL
	QFVOVfYI5Jdcsw9cBaqe5ySYZg2A61YL3Vi4LJ3p7oIYHsIpLo8pDSMEjXuR37EW
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833ja4xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 08:55:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PCtRnw054027
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 08:55:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 08:55:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 08:55:27 -0400
Received: from LRADU-D01.ad.analog.com ([10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PCsub0019034;
	Fri, 25 Apr 2025 08:55:17 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 25 Apr 2025 20:54:47 +0800
Subject: [PATCH v6 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250425-togreg-v6-2-47b6f9878ae5@analog.com>
References: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
In-Reply-To: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745585696; l=4981;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=iWjl6l/so/q4SkT0NIpF43RFCXqWNXX4a/8xgOMrJ8Y=;
 b=oW9G29br3QGtWBOW8HLAd+ysn0dNHmukgY98eUR0exN6zNkf1AvaYN7RNod3qXsSNOhZnrw+t
 /53FfAFTMZ0CDZAHhTY24Q3WN1kxePS7efhJu0/vunUvdpVh2NGa7i/
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 2q3dEnPZFiOX_en-xgTWHpjFN2p_YHMG
X-Proofpoint-GUID: 2q3dEnPZFiOX_en-xgTWHpjFN2p_YHMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MyBTYWx0ZWRfX2smqw9tABCQz J/TbR6ORjY76Xfv0FuTNYDvf4rqons8QbvaSVhykbBmgRv7zVNSCOogqN+gww3FsQEJpfmQRv2T 5YBi66TsU4e2WZ/GB78ugtsOaT6oGhy9qQEAzsp1eZGA8PgnLhO47FCtoi/SRyj7Ag0XDkaqJpa
 rIB1JVwrd0KckiyBH16fmgrG4dl+AVl3W7n1cfvJZhyu6k1MbH990wVHcT19pmIY4gyYG3DPViB d7GzwlRlgLOEIdzAMqOE0BpBHYP2veBDaJ28tj/qSa5T5Hbf2+KCN5gUBMBu6i6WxsoqOsAKJeS xP0SqHxW3Nj9XEiUvTC5D1KfrwNpnj1S8GRtmekJW+trOr9cXRqQeRj9aDTSbUeUQG4MDWiCmI0
 aQI5Jb2wEVbDblaH5FWbryfDNduNL9zYoJkl/QJQp8hLhP+GWJKDm0WYzRR9K/u6uCctu/AD
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b8640 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=Mm4sZ1b9CvxOHCGzALoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250093

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



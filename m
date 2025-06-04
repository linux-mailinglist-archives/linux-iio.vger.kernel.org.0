Return-Path: <linux-iio+bounces-20216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8FACE4E0
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35514166C7A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373320E71E;
	Wed,  4 Jun 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZBKi84Wv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903B20DD40;
	Wed,  4 Jun 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065762; cv=none; b=ZTu4SVttVl8Z5550ZeQ+O9tlr79FrtvoRseeUh0jsVLMWrVzYqmBO8kpKuefo+H2RiFwi/ENyuTZp1y83sqHns6OEOtcHrJPYb5sayzVu96M9MT2r1nXFmOuwfT16LHWv/V/0k5kR8vWCpw59CSvtiElK+XSCJuatYvF/D7dmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065762; c=relaxed/simple;
	bh=Zq0HK+OrSJjWq9DQYIrjT5LRtSOKreJ/I3RDhj5tuq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f78/wQKSejL8Sqo/3TzKAuwOpGN7o1OOhTiEe0dtJnhy1grHrBRY669U2jJKSryl7G1G4uoFUdMZSZfyFHiyhBYNdQy+Yh50RwU/LGj+8cF/otQ5YaTWSub3W/oQWoRd66A1/C8IpE7iBVw8O/bxIbTggqbzLz9DuQ51j7/iSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZBKi84Wv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FYARY028855;
	Wed, 4 Jun 2025 15:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=L8Ll/
	W6DAvj7/hLj8sJbqcOHmMAtmuwTVjWiIGAUy0s=; b=ZBKi84WvofzNgcb5B5fPt
	LsM+5n7yT/ljW0MTLX/Eq1p+9EdGK8e5v6+/SqFP1nk7AJzDwdMxPDtK7VqA6n+/
	ahw6nCXQzyvzwpJE6HuXSOJYf9dWuFYmkXSSOkp/OJDGVB3yitRwr1LPXQ/fYeXc
	sxhkNs0+Ywhutx+SYtJ2p9WoX7NryuS7coCoDHfhVnbx6j8YZnt+AWbmHZt591ds
	bVK5Ek6MJQONFEnRTrVAKNInh/yccPMQSOEAtL52H8DWdoppRUBU+6JkXQredSRW
	JJGghGQPQrsac3OAU+7y4iNH6ppc+a3qjbf19ZXM5YrK6ZyQAg0W0qfwMohQ0qmZ
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j42bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:35:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554JZrkS043865
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:35:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:35:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:35:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:35:53 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JZYPx014308;
	Wed, 4 Jun 2025 15:35:36 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v10 02/12] dt-bindings: trigger-source: add generic GPIO trigger source
Date: Wed, 4 Jun 2025 16:35:34 -0300
Message-ID: <84b4f5a18fc1b1b724c96d269511f28e7475be0e.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: j3r5q3jasY81zHUU4l0d0DOlnyRPZDP7
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=6840a01a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=N_fad9SN1wWSt1MqymgA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: j3r5q3jasY81zHUU4l0d0DOlnyRPZDP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX8eQkHHi74Mo6
 /4RPy8DTgm66NUAnolT/6sW7Uavt5G1ZpkSEbJMyagPfacI73EzcKO8fOfxeYK1UwCOhF8YeBwN
 TwTMR2ZDdZ7evT1gCa9tWjpNzrFiKlu3SrSI86I8S3JkHJjMwRT7B02ylAMEkrL0dq52lio+Ech
 UvlpaJnGy7nuePbS8oBjrEXgU5+Ge6dF1Q2L/KzJ5NLhgsfQZ6NyV/ynXJ1RezyPH/S95jxR9Qu
 CRegx34NFcgk1bSMSplnqGWN2zaVr2+1I/eBSzP6G/1waJ9K0rjZXkkEXV5Xpp2IyWkQU76fFkF
 9BeQogCPxVuO8unxJ9XwjTC1XMUTUlOHRZUZlCCGGRdJ1JYKD/i7raDLzHPk2wuEwlDYNiZ/uGw
 ynjDo+IBIeo8hlvx5xGfVUofP+HDMboWflA1bZgwAs3YfSYDWYuGB2oYzYpY2wNQvAqdhCNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040155

Inspired by pwm-trigger, create a new binding for using a GPIO
line as a trigger source.

Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* None.

v9 Changes:
* No changes.

v8 Changes:
* No changes.

v7 Changes:
* File added to MAINTAINERS and Made trigger source generic to include both pwm and gpio.

v6 Changes:
* Changed description.
* Fixed typos and replaced GPIO pin with GPIO line.
* Added link reference for pwm-trigger.

v5 Changes:
* New patch in v5.
---
 .../bindings/trigger-source/gpio-trigger.yaml | 40 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml

diff --git a/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
new file mode 100644
index 000000000000..1331d153ee82
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/gpio-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic trigger source using GPIO
+
+description: A GPIO used as a trigger source.
+
+maintainers:
+  - Jonathan Santos <Jonathan.Santos@analog.com>
+
+properties:
+  compatible:
+    const: gpio-trigger
+
+  '#trigger-source-cells':
+    const: 0
+
+  gpios:
+    maxItems: 1
+    description: GPIO to be used as a trigger source.
+
+required:
+  - compatible
+  - '#trigger-source-cells'
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    trigger {
+        compatible = "gpio-trigger";
+        #trigger-source-cells = <0>;
+        gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c02d83560058..d5d14fc69ac0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24760,9 +24760,10 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRIGGER SOURCE - PWM
+TRIGGER SOURCE
 M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 
 TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
-- 
2.34.1



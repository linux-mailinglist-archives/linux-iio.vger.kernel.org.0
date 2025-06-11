Return-Path: <linux-iio+bounces-20419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B44AD5489
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1371890D48
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919F275858;
	Wed, 11 Jun 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KY//JX/o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F727702A;
	Wed, 11 Jun 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642621; cv=none; b=aHd/d8wBYSsG4VhlejspyHF0yk6e+xSYjzDUClPLQ3kpDDy6CBiN5fDbhxtrjgtP952WUFWeb775XIeJYtDFkOkDRqV1flqVfKnMoH+IwuzLcGCSq3Sz6JocVHg8AB4zGmk+RTpV1IVw1jC3QthivWecYSTgkMTEjflXtSVxZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642621; c=relaxed/simple;
	bh=r0ZLXd2q9hAiSdewdwZkWBSi7zPhVyockEPq26Z0yYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPPYAnK3qrDiMFR7bIvHNeiGfgyVRTh1S33XnnNPWruUsABvSxJIgoM2RFTErxDEUrrkpHprLo+S28GTRoAaDaTwpnaL3vh9VkfORB+CYidQfqVwex/OeND32RmNst/Zxq7gvj5A7h00bx5bcgAB0PGXTpq/NmOF+CDFiS04//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KY//JX/o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8vZPM018146;
	Wed, 11 Jun 2025 07:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DE0Zu
	QUCnXL5XrjPsGrBBDBfln2gHE0vziz09qKvg+8=; b=KY//JX/o149+vCcVkPSHY
	AgNNV9rW6BIXkNQQXJWxVI0B3gxb7WEQqJgqj7Z+xEYiArhxDCGmwiKJscHc0agu
	2idNNyUxXyuaVTPt0cY4qKlU2pXkOK4MrNkJeBQ71KTi0Pm4jMa057QIr7s4L4rZ
	uizelrftcJK5R2up3QJBlF9iaCt09v4N2K1djtPlzWbYzFh0rcIpYMMfdybipV6c
	/XwoN0KNtHQLxl8YaMDbApGtoEebPnIjgBgxsyi2lHi4/4T5InCxFg/C7lpZDQIF
	gEdwuLtD/Gi2pMc9+qnJIQGGUDsH9xBUPdq2/ySNteg7DGEsUU+vUhEj1G/jfRC/
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4776r9rvu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:50:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBo8Zq031425
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:50:08 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:50:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:50:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:50:08 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBnnPf008860;
	Wed, 11 Jun 2025 07:49:52 -0400
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
Subject: [PATCH v11 01/11] dt-bindings: trigger-source: add generic GPIO trigger source
Date: Wed, 11 Jun 2025 08:49:49 -0300
Message-ID: <c4a3a7c828c711b439d1893271b8376823176ea6.1749569957.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749569957.git.Jonathan.Santos@analog.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BEBUTqpSa_RzdcSp4j8_ZfOqZCRoif6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMCBTYWx0ZWRfXxDaYJpW8Fiwy
 4LXKFuacx58Y1s4FpugG5QDrC4bzQVMETsGcXdj7lI3nwbwf1IZRFOwt8YXUdgpR8HMJBN14jfX
 IMSCYes5n2paNxoSaThw0BsnQbYHAlkgGvaxJpQ15n3x6/jzXscHuHy/Gxh3tjNC67WOM6XAMNy
 K+Y/Kt9BDTH3wp1WWbThBtw2+G165zU+dgqRID2GbOzPPB0NZq2EanLWz/kFW7m9n7rJupnbndo
 zYs+okRbblW4i5TiY5zyjQ2K04ilZ5dPLehp1JoKI5nAFh6t0Nv50Kun5lKrHR41c1yS2YnguG/
 pjHOhcISDpu3GRRK+q6fqv0reNxjIZyON1FEPcypvoClAcngLr3zRFebOwXUzc1fNZLjm5epMof
 2W3f/3YIwh4T9pejBHswEEyNksKvSOrP9139VDSPZZJ2irXICuj0pFcDSF+rPEeCVsTAw7KV
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=68496d71 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=N_fad9SN1wWSt1MqymgA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BEBUTqpSa_RzdcSp4j8_ZfOqZCRoif6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110100

Inspired by pwm-trigger, create a new binding for using a GPIO
line as a trigger source.

Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* None.

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
index abfd5ded8735..b1f6b7c88ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25203,9 +25203,10 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRIGGER SOURCE - PWM
+TRIGGER SOURCE
 M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 
 TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
-- 
2.34.1



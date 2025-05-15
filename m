Return-Path: <linux-iio+bounces-19560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5271AB9143
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B2FA00A6C
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82429B786;
	Thu, 15 May 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DjZQi9TU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FC288512;
	Thu, 15 May 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343568; cv=none; b=Ys+ciLJeEY6513IVNYjFtjxengzDj/hZQFnKc5nHuJoQNiTVgEbBLZCLf89kBc+bp3HOFidKKczqWLUbzeZH6aGhmne63vj2knf3h+tKnf+ST+DHo+lOvyjMPiUT8xrlQSNdIYIzit/De0WkG7eOCSSp93/PfL1sUdo/8sBBrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343568; c=relaxed/simple;
	bh=f6a/lPSij0RjyhTy+hDJ4gOtEidaWllQ3+XFokkDuUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATUa0QPaA5eMtACs396OD5RgaIkIovvPCfIrFl9D3SJkw0iGOoThQMriYMhKihPN44OsKiiJujkZriOUjNTQfkeF2TmwQkvqciOr0pwyAZ6qqFw225owy2XSqmfrcPBjViN1FKAkBh5OT1hlNbjYhqL3nOUcgEszxsBjIvk0U3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DjZQi9TU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FIWILK013590;
	Thu, 15 May 2025 17:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WyXU6
	vq/LbxQbiHcZOACyqxGKExXmOB3Cn/3DMcYLCo=; b=DjZQi9TU0siByiswHxygE
	PF6oAHGTZwTGv3YCDK2kkf51YrXL+TshshGVlWttzFrZGOJYk1fTrUIq6LseOsFQ
	H2cBVFDbe1M5Q5VEpaK5Ix6K0mmGxeys+QXBIgUycF0ZBb7DCMJm18X+yK4/HGWg
	YyuxN0I3RJ/52CRgvLTuLnch5mkDUhQn2mW1RL6I7lzdOyPmSnfbqo6eG4zITmK5
	WNX3h3Qib9xjIlTBPmX0IogPtEfAo6v69ngqiAugps4PiEiAMz2/03RhXOSidbYf
	7jX/+WF0su2cuai0sPDMYEgRqmIT9fXIzrmdKeaCLxqPiW3bxUo7+SbM5vMFa5YQ
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46nnmr8pvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:12:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54FLCb7O024945
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:12:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 15 May
 2025 17:12:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 15 May 2025 17:12:36 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54FLCKo1018818;
	Thu, 15 May 2025 17:12:22 -0400
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
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 01/11] dt-bindings: trigger-source: add generic GPIO trigger source
Date: Thu, 15 May 2025 18:12:19 -0300
Message-ID: <2c65278d6b2f96bc5d3a473e5309a06c4af9b703.1747175187.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747175187.git.Jonathan.Santos@analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AYexH2XG c=1 sm=1 tr=0 ts=682658c6 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=N_fad9SN1wWSt1MqymgA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PVvPqMmgLKYLECP8nKrWzIj_GpykCvJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIwNyBTYWx0ZWRfX4nAPcu9WJFf1
 ErP5OpAv2vasek57rrkDSrW5zIstZz1EASiP6KR44UT/qkNQMglSm5Jx4LK/2p0DHVRojuFafC/
 L8CHZ7lMuw9MDiSrwdZhOaHwu7mFCuf+CW5WJUJDK/GkenwE4IgVRzO60U5GyXKHcnLNzl+Sojz
 02Pl2w3EeUqmqXZFasBjEZ/+dG3Y7b7Yh4aiDbV1Sb+gVvjAnEvVgVHiuCpMfuPW63MNsTmzQ9R
 9jCMbcOa5buUhRceNj66OE+xD4if0ZHu06NkpI/WYaZkGaHUMjb/1GUmGIw01SVYyIghWtcd6tS
 kXZNojHHUFYWBphqroGp6p5jLs4wyw/xmAEVQvavlLiDCV0r41GwzGCk0nwqaeinnbnZ6YBwNJg
 +qAgAm7nVRGQcxqUdXyqOMMR791Q+55RuhRxNwVmJdrZ4Ao8N3ZONIFPojkxn0pNA7r+FYW7
X-Proofpoint-GUID: PVvPqMmgLKYLECP8nKrWzIj_GpykCvJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150207

Inspired by pwm-trigger, create a new binding for using a GPIO
line as a trigger source.

Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index 01079a189c93..9b2e9a9dd8bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24569,9 +24569,10 @@ W:	https://github.com/srcres258/linux-doc
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



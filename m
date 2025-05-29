Return-Path: <linux-iio+bounces-20020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D0AC847C
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBFD16A40D
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360B21FF51;
	Thu, 29 May 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KyCX9d6W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382EC21E0BA;
	Thu, 29 May 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558946; cv=none; b=ZtoXYrhDtkS+glt96Nmmpe9NxppzAkpRW+rXxC7CYLgftmjfiq4yZuTegJjvTq56oSC1YB/c4pmTiHDMQoADb/5Wt4y0X6mb7jyzZWNi6ZN06l5ClRSZcMtvg7kY7gbPDQbTFx/JMGmeMFHCFjGz/aGmBOTMohE+EyrzcFMl21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558946; c=relaxed/simple;
	bh=MQyTYNiAkXrscTdQoTLlX/4X2SzcRHq/f7nVpb8liBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS3+yAQWFxt+WQVUzxV1SKPiVP+geyhkMkNP9j2Gjcx5S2iJzLwzMH6MX23+wTjyYGcEA1CkOFGteTFg6Usc2fiZGo8X2D6GeHmoBif8qgvOUiCeOhlzhx0Ok3U26buT46K3E8ECcXRNWUqMKbARd1qc6K/1YS3GqVj1Rw9qucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KyCX9d6W; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TJEPeT030185;
	Thu, 29 May 2025 18:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6hiu/
	PtcX6neBEMCNteexVEmN7wFDNuvXizg48HYND4=; b=KyCX9d6WjvljXioKkOJ/D
	gA6XyYkQv2znFOv63orKXGhKQA/OAue+9+2N1Jvdu3nHaWrnutB8KKiYTOkdS+K6
	voaVCJGc7J7Bm4FSAk2sn7bW6vkDLm5Eg5lNwz23gkWeXYfZHyrXD442Eo3gunwU
	S5K1IYwJWsI/qU0HzIxAdEYzdQgAlZhQ0CTMKmfjfbtaQxvZ2wNLAGxZjOaPchyR
	57RunbyxZcmmfzq/Q0I3W2L40EEp6y7BkKRt01HXCRNasefANHfRJeAKubkH5Wq+
	RSZapFZQOMEXPYRAR6MkwVmkdPYPbq5yykZBUJrO28mQefQfFAHATqSgybwCzCJs
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46xth6hrxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:48:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54TMmsXw008552
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:48:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:48:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:48:54 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMmYI5017129;
	Thu, 29 May 2025 18:48:37 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 02/12] dt-bindings: trigger-source: add generic GPIO trigger source
Date: Thu, 29 May 2025 19:48:32 -0300
Message-ID: <6e41e3a2abea8b825690cc4dddf7481db0f8aed0.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=CccI5Krl c=1 sm=1 tr=0 ts=6838e457 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=N_fad9SN1wWSt1MqymgA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LSWXcnOG0e4eNUGlOyHb4TNODC3i1EpF
X-Proofpoint-GUID: LSWXcnOG0e4eNUGlOyHb4TNODC3i1EpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfX273jR3toKSCI
 bd3zuem412xJgCU73N4cXeDr2aUz3ed60MbwJvmt5NoPX7mSXqnQbQtmB+wpXkZrnnSPnktvLBu
 VNrfJ/Sag9wruRgKSIRUKxqoMSDx5TDTrc9bVCu9k8bxsp5Cqp7NRJc2Wm1H/vnrw8x6b2Wn0zs
 F6aDmGkh9IVRhlmGGUrKIa3O1n5UN140r7lKxB3U/bR9Pr+bnpV508jcAQ1IffEDYk2I9X/GwiK
 YXOAiZJHb9/AheuX8qggeiTCpR6xmda4qoMF1Q9hfHgQ6L7Vq3nKv+Qrw9KhHetfLx+zn3QP+bX
 UWPiXB5rUELBqmLzMeIAcdJRNr4tqU1/D3PWjOT5NceigPasUYC9mme4g74a1zY+ohhP565UwwG
 ycRAbZH/KbS6vgX/VK6aAo2Y9sMthfMxBGLvxZoyKuhOZSZydh4IR0oX5cubY9vAS9+b9Gf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290222

Inspired by pwm-trigger, create a new binding for using a GPIO
line as a trigger source.

Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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



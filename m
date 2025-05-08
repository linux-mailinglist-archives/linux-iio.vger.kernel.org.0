Return-Path: <linux-iio+bounces-19320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF53AB00E2
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56259C19F1
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEAA284688;
	Thu,  8 May 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r+yXw4CT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD827EC97;
	Thu,  8 May 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723829; cv=none; b=Bmmj7T58eGj5AjVMACqdY6SbRQeG95VtVQwsNVMyiAosgGp01jn8MMSCHIs66tEMDvANR7UiJCoi5sCrdXxQcjR1UNorZ9J6Fz8BwtU6klM2B1isQw+mz4JieYvViRrj62krJl3v/sNhfL6O2sDvz2naIggZnSJhev6PMOZcgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723829; c=relaxed/simple;
	bh=m3I58HrDmlvoGElzpdwpTEUidcNDsJw1DG5TAUtrYD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkRCZuub+vLfwJoqrz8um611r9SxrRosF58YWweBW0UDA6Q4TitCeRmRw4lo1CS15dAKbriuEwW6fX1GvdhOqmt784g6ci8sKWvsloyxrcTmMDdlZT8tUzvuSSYTOeITdl6/wzbpI76vs/Bx/+YY6Vth2vaMLVozk26R4yhljWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r+yXw4CT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D9RS7023987;
	Thu, 8 May 2025 13:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2ezEa
	LB2hRO8T2W7HKZXEHo+sGui8Nd3NnjVrK7761c=; b=r+yXw4CTtzcfysUPrWblm
	KfW/ZEHVcWFCT4XJWwBihxcpntaqy5YOhO9TTQpKtnwgu91Lga6QxoMIr48amlgy
	pkLUXjD4vtXQctlBPbT52qoVRNaPVLmGY+6YmV0EOKUodltMTphg6ZaCw/lJU4Qr
	y0p3u1Exy/TvOvbwUSfkTwbwjxFAOO0MHNSa8BtmIVmDcosF+1fRRIULICEPK25W
	7F+ud4nidEUbO/2pVeaWbqS2TWcXfaVnstnCcCbmOeye0piXn2HfaRATxcfHaBSG
	Y1PYk2pQVYyf/xrotdxjLiD/6seX/IjN3GQYoUXGpF9bdo9nkJM8G51iGiq7nH6o
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpctb1gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:03:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548H3WpT022701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:03:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:03:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:03:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:03:32 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H3HLF015866;
	Thu, 8 May 2025 13:03:20 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v7 02/12] dt-bindings: trigger-source: add generic GPIO trigger source
Date: Thu, 8 May 2025 14:03:17 -0300
Message-ID: <f62bcaabde172e0b2880f7d05dce97d684cc04ca.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfX/8QaHkh6Puc5
 hT6h3VdAVis3oftVPWaPcyC0+WWRgpTGxQD/FH9nVuTh7N6JwVPcAv8V82k0JcnMLg9lvcuOwUJ
 gSEe3T1PHPqaBe7Rfbp2cfd7ZnzxgV67U2KU7WYdy8wseDkXgP7oVbduAjcbBu3riYuhSKL9hkw
 tzNDy/kfksQxn3etpWwImYU2ILZeZu4jiz7WM9I97GYUoQWD9TbfNKGLL5hVlKUmGaigQBkofT1
 kC1u8FVia6fIDvjlYHAODqZwMeKaygel2cLG92RENyX5cSQppb31DcR1OCbanpzo/y9VFRUVepG
 NZeHdVS9iZq9Td8NxfBpMFQXdxFEer7nRscsoG8le5EM4gkuTtjKvuPrSbYhNzOeuV9DSVqi02o
 FctiQFVDzYp/WSsvdzgP8MGsPzOGI083XIhitXRBiyOzio/XakUBOJf6l05epNgscPwKSwPi
X-Authority-Analysis: v=2.4 cv=Ur5jN/wB c=1 sm=1 tr=0 ts=681ce3e5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gEfo2CItAAAA:8
 a=NEAV23lmAAAA:8 a=gAnH3GRIAAAA:8 a=T3kYclMwKmv6rGiKBMkA:9
 a=IawgGOuG5U0WyFbmm1f5:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: lQJ-CaoQtafZnJJwe4hhuYsBL6BbWAB-
X-Proofpoint-ORIG-GUID: lQJ-CaoQtafZnJJwe4hhuYsBL6BbWAB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080149

Inspired by pwm-trigger, create a new binding for using a GPIO
line as a trigger source.

Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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



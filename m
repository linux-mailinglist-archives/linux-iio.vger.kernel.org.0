Return-Path: <linux-iio+bounces-18738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E49EA9E546
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC084189A544
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9E279EA;
	Mon, 28 Apr 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K62rzun0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044E35979;
	Mon, 28 Apr 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799161; cv=none; b=JbTeBeIGscD2j+3qeHZh40/3oHECohsEwI0Q6PGZ5fI5h/OznAu1hT8OmM8CKPBmuSGb4mmMRUtreE6HAA5c5I6ZlbSgRjYhoikY75NSU26fdosDUkzUlHod1leIHHm1Is9qjn3DBPDXcUm9uhiM5W/a1nKVMtcvNyBP+oCbSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799161; c=relaxed/simple;
	bh=ekJbCGWI10LbRKSRpmtQuGWnmUIqJ/QUtjvGvAttyqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sB4AmqFqrazLrVHNOsEnAdR6evof+WQ0SOEAek40BKnqNjgpTB5LPWGMUnGqSVbl8o2PcDnhFsJrwRmjZxZjVY8nARP6QnjVmwLjZSE/ayF7O8gsMVVEuOYA8OpCtjwFf2umMkgfKCME1csNpVlHLHKOzlmR0K9a2nHN/OpW56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K62rzun0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RLTG9W027668;
	Sun, 27 Apr 2025 20:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rbF0T
	toDjPBDiTJIKrRCPVLf4L7DQiV1/TUu/RXPAZE=; b=K62rzun0yK6YowuH5JZeh
	WoSGk3YTnd8UcV+2FVJFdzgxVGVcqor1if6JXViaUjmsakmAUYq3l8kHZa4nuJtv
	yBbhw1rPLqmYRgVNOxax1uba1hO5AdeTLoMjgvV5SCa5d+tSu6yiE+mvwuXrF8AT
	EFRxOOuB2LxakclanrMIzKqi4QIrszNRs8iITAVbuWuymjW7AUfEhoCJEH5EUqbh
	OQI7Py9CKM3b6ZjAsbOIOPzLsWuwuFqgf3AgEilnfmeJ6IBGrTHfIrrogpjf1HHY
	RN4VGQVMpwhSdCi7XTuvgXTB8UnMGKZvtTaLXI/BYViJCxkZBgCtJ45+Qwca1bXV
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcma9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:12:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0CW3X028808
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:12:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:12:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:12:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:12:32 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0CHJQ014439;
	Sun, 27 Apr 2025 20:12:19 -0400
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
Subject: [PATCH v6 02/11] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Sun, 27 Apr 2025 21:12:16 -0300
Message-ID: <128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfXy0hVxil0bB2w zpk5+70/lJC99Ge/gwFQghafu8q3xxpBP3jYlBreVhkq8hjHpYUEWtXJ3ly4gdikES5nhz7ib/9 wrYXkwtVDLIET63a1+wGCgU71aJwZkNYAzzJJRHL5xCQYiUV9k/TGU9DF7vJQ/fJOwwDbcKlejZ
 /t7WUOX2Yk0dGTFOYyaixjbj3N9uzUxX6NGTxVO8Hv346tDc+pfCFbOVLwZnivQYgvT/0xwa++E YH/u7rvE9090+vg7czS+0nKq/lfYGHyKPr1sM8rvhyYmmppmgkK3rxrOyHWudnFQPQb7y24TWch yTuIgdmQp7TsECtEBYdZcOpyGmZu5yNn/TCsH6AN/BbCFkfxymcPC9at7pH6MnRJOR828VG8unY
 0qE0ugnWJbEY4HKTF+VV8ORD8U3hHxt8H1N9zmxMNzuzlKZk87e1AOX/rr4cRvfmSXdKo5t1
X-Proofpoint-ORIG-GUID: yM0ILI6ewh8-TKa18JkkLv5fu0G9_rhZ
X-Proofpoint-GUID: yM0ILI6ewh8-TKa18JkkLv5fu0G9_rhZ
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec7f1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=o4psIgTgk-Asirc5avcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=950
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

In addition to GPIO synchronization, The AD7768-1 also supports
synchronization over SPI, which use is recommended when the GPIO
cannot provide a pulse synchronous with the base MCLK signal. It
consists of looping back the SYNC_OUT to the SYNC_IN pin and send
a command via SPI to trigger the synchronization.

Introduce the 'trigger-sources' property to enable SPI-based
synchronization via SYNC_OUT pin, along with additional optional
entries for GPIO3 and DRDY pins.

Also create #trigger-source-cells property to differentiate the trigger
sources provided by the ADC. To improve readability, create a
adi,ad7768-1.h header with the macros for the cell values.

While at it, add description to the interrupts property.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* Removed references to offload.
* Changed trigger-sources-cells description. Each cell value indicates
  a gpio line from the ADC.
* Added adi,ad7768-1.h header with macros for the trigger source cells.
* Removed offload trigger entry from trigger-sources.

v5 Changes:
* Include START pin and DRDY in the trigger-sources description.
* Fixed "#trigger-source-cells" value and description.
* sync-in-gpios is represented in the trigger-sources property.

v4 Changes:
* none

v3 Changes:
* Fixed dt-bindings errors.
* Trigger-source is set as an alternative to sync-in-gpios, so we
  don't break the previous ABI.
* increased maxItems from trigger-sources to 2.

v2 Changes:
* Patch added as replacement for adi,sync-in-spi patch.
* addressed the request for a description to interrupts property.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 31 ++++++++++++++++++-
 include/dt-bindings/iio/adc/adi,ad7768-1.h    | 10 ++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3ce59d4d065f..1f476aa15305 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,28 @@ properties:
   clock-names:
     const: mclk
 
+  trigger-sources:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 2
+    description: |
+      A list of phandles referencing trigger source providers. Each entry
+      represents a trigger source for the ADC:
+
+        - First entry specifies the device responsible for driving the
+          synchronization (SYNC_IN) pin, as an alternative to adi,sync-in-gpios.
+          This can be a `gpio-trigger` or another `ad7768-1` device. If the
+          device's own SYNC_OUT pin is internally connected to its SYNC_IN pin,
+          reference the device itself or omit this property.
+        - Second entry optionally defines a GPIO3 pin used as a START signal trigger.
+
+      Use the accompanying trigger source cell to identify the type of each entry.
+
   interrupts:
+    description:
+      Specifies the interrupt line associated with the ADC. This refers
+      to the DRDY (Data Ready) pin, which signals when conversion results are
+      available.
     maxItems: 1
 
   '#address-cells':
@@ -57,6 +78,15 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  "#trigger-source-cells":
+    description: |
+      Cell indicates the trigger output signal: 0 = SYNC_OUT, 1 = GPIO3,
+      2 = DRDY.
+
+      For better readability, macros for these values are available in
+      dt-bindings/iio/adc/adi,ad7768-1.h.
+    const: 1
+
 required:
   - compatible
   - reg
@@ -65,7 +95,6 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bindings/iio/adc/adi,ad7768-1.h
new file mode 100644
index 000000000000..34d92856a50b
--- /dev/null
+++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_ADI_AD7768_1_H
+#define _DT_BINDINGS_ADI_AD7768_1_H
+
+#define AD7768_TRIGGER_SOURCE_SYNC_OUT  0
+#define AD7768_TRIGGER_SOURCE_GPIO3     1
+#define AD7768_TRIGGER_SOURCE_DRDY      2
+
+#endif /* _DT_BINDINGS_ADI_AD7768_1_H */
-- 
2.34.1



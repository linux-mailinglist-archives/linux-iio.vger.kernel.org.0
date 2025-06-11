Return-Path: <linux-iio+bounces-20422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E6AD549A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927A817A148
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3327602F;
	Wed, 11 Jun 2025 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pSVBz8uP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD317275866;
	Wed, 11 Jun 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642659; cv=none; b=fBvY7NBXhGguJcKWb4pXSCo89xCOPJGBip4iCb7AYPkh+YQhIv3Z/zlNXnPViLdRGq+KYxJn5jNxoaaAGDkze3AYAQ+J1GnqZjjJqK/4GYW8JAwf9prQ/HSSJPOSjnIztJZHdWVqJ0XGpIz+5VJULu7QvqNbSWSUT6vrpCwqKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642659; c=relaxed/simple;
	bh=iy0uue1SqSo7V+9S0Rg04tqHvJNd+qP4UyWMjhhtumo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/uuUGEw6wzAEeRj2MW1UGTHAVifLdxyqnMIZiqi88VeXdkoQyjmzdu9Q/pN+z+tcsXWATAZxV3LI2nItCsa9NIn3NO09kf+cAN4/9KPFJwdZj6OSVWVN9J23zvga+LtUdHQKMgN5PTCRbGaPuBHCIlexXl/ZYL55ZNIKgIPq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pSVBz8uP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B91n2X016874;
	Wed, 11 Jun 2025 07:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5lyA2
	XG9Sx2RJiOrof+CNbHZwethyIjyCgedSIfa08c=; b=pSVBz8uP4hY1i/VVseXIZ
	29Bi+8SoXHdapGbQ6YeruqJIxQp6R2W8RU7gN32A+g4kyu4k3egQdnOYchtIyZbz
	UQBIoIWxl5QreR2ULBcYemB9uwuF1RgCqRtTxmNUpFpmQuoLM3jQOeilZ/QZloHN
	+ZTDWwNrrmUVWGUO3Czmpw2WgWnZQPBw3BjZuDTKfA6zio90kEDuuIj6ejblXjHx
	Z1JNnx8nGUTlIqQcE8aVqNBsAkocKUYBD/5YYHKg49/Sah6n7W+2vAA4j9HQoS7I
	lBJ4hPOR6YI12VeLDv6jB8n5YKP/4RgPrfNGpbjDDN1cDFQzYwzdeO1TJCATxyVg
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4776tdgvq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 07:50:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55BBooaV031547
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Jun 2025 07:50:50 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:50:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 11 Jun 2025 07:50:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 07:50:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55BBoRlw008917;
	Wed, 11 Jun 2025 07:50:30 -0400
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
 Dooley" <conor.dooley@microchip.com>,
        David Lechner <dlechner@baylirbe.com>
Subject: [PATCH v11 04/11] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Wed, 11 Jun 2025 08:50:27 -0300
Message-ID: <713fd786010c75858700efaec8bb285274e7057e.1749569957.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: cTfkuv2DsFkbkgBFocEmma5-oWWv-SDs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEwMSBTYWx0ZWRfX/o0SmZmkjZfP
 tYa26DtKiFn+XDiywh7GPBBnZUfu+R2Gurz3R8VcjjMoInT5xIZ7CUdL/OCVPmT/b9tBm2Mttz7
 dKLRm6HZ3zLA4BoSDuUB1gZLxVcBFpTPiEGnVbKtEC1XAo961H3S1DiTMXjduFYTHERz2BHANKh
 h8Wmk1rgupN78948nYofIcB/GGmxzkZwpdgHj9nmL9lRoN+wLYJE25eYecSq/WyNxRv+VRL/jAu
 EB6qURn0oZamcnmK1vCmNc2q3p3uYr7xhNCYXqcjGF2xxS97+6j0HcwvU/tH/kY84zXoBRt/+Qt
 btp0ntZFhEGMUSN2M22g8kiQ1tTVJpachPr8WjQTpauy9cJuKUILkloGyvlj26SgK/M8FV7+jZA
 VODjZaZpBhJVKKPgImpk6G27jmtX30Ptm6tArZZXeU9UcLH8KBMgxfiDbkk8il7EmCJgX/lF
X-Authority-Analysis: v=2.4 cv=BezY0qt2 c=1 sm=1 tr=0 ts=68496d9b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=3yuoaRSoAAAA:8
 a=Lq6TyEz25fwpf9jyvVMA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=2SAQt7U6PxkJVs8Pt8Bp:22
X-Proofpoint-ORIG-GUID: cTfkuv2DsFkbkgBFocEmma5-oWWv-SDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110101

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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <dlechner@baylirbe.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v11 Changes:
* None.

v10 Changes:
* None.

v9 Changes:
* No changes.

v8 Changes:
* No changes. I have decided to keep the 'dependencies' section header
  since Rob said it is ok for this case.

v7 Changes:
* added new file to the MAINTAINERS entry.
* Made interrupts description more concise.
* Added dependencies to constrain the use of trigger-sources and
  adi,sync-in-gpios properties at the same time.

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
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 39 ++++++++++++++++++-
 MAINTAINERS                                   |  1 +
 include/dt-bindings/iio/adc/adi,ad7768-1.h    | 10 +++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 89db6f56a379..c06d0fc791d3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -26,7 +26,26 @@ properties:
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
+      DRDY (Data Ready) pin, which signals conversion results are available.
     maxItems: 1
 
   '#address-cells':
@@ -70,6 +89,15 @@ properties:
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
   gpio-controller: true
 
   "#gpio-cells":
@@ -86,7 +114,16 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
+
+dependencies:
+  adi,sync-in-gpios:
+    not:
+      required:
+        - trigger-sources
+  trigger-sources:
+    not:
+      required:
+        - adi,sync-in-gpios
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
diff --git a/MAINTAINERS b/MAINTAINERS
index b1f6b7c88ba5..3eee0167f5cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,6 +1490,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
 F:	drivers/iio/adc/ad7768-1.c
+F:	include/dt-bindings/iio/adc/adi,ad7768-1.h
 
 ANALOG DEVICES INC AD7780 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
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



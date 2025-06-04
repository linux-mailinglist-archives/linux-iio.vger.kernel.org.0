Return-Path: <linux-iio+bounces-20217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665EACE4E4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC080172FED
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02D20FA81;
	Wed,  4 Jun 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="reJQ1Ylj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368720E030;
	Wed,  4 Jun 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065777; cv=none; b=ksg2qZlahy+DWF8Q9gvi03Vrfyy6WXk3/cSwyPTQcRro7GjPbKpnF5iArOVDxV/VfgJ+algzC6lY0ScETvlXOxxIBSi+kDh6LZy7mE6TXQiSoCPiBQTK9UdEqzsj8WLVQVIRx7UFIjkaUZko6mEdl/E+cjE3b3IUMadAebU1zPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065777; c=relaxed/simple;
	bh=+ky6sd3dK6hs6B/k7u+YHnGJnK84WYac1GmO4q4mPHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHPllqNPrXua0lCCVw33T4h2e9Nbz2AiN+1VNTWvvmf3DizVg4KNxL2Eevfge//y03/cJgrJjiLnOvgGol8Z7d8Twzm9ldik56XbUIDZoRkVQzFFqU5bVQKfMOYaAaKunQPUtCQ4gcs3EoGz7S/uEnjl2tyXrYp/f7HdswMzzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=reJQ1Ylj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FnMdI030463;
	Wed, 4 Jun 2025 15:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Es7Mm
	VP7EobEqFXrcz8F6z+vBlFqUB5hI63pr1Kex5Q=; b=reJQ1YljPe69WrsUrg4i0
	6Nxf/ywIfzzj1W8W5qFDkG0/TImiaq3857S3XPRUkwweb2AlTsUGPd9cDmuz1Z7A
	CsbGEOUqXhkVEVRXdblYpdS+J2q3RiZbqvU4Xw7YtUDyXQEDi1d/87DbvkoEuFzG
	qkcHqOdBcl2eE+u4ziofl54O96J7bim+bJ3+P45xWj9o1YaXe1cro+B5/ec8TsQ1
	Pyv4tpeYI9yV+oCenTba8n2PcKrA6k0GUNdgyEjeDpdj388GKF+4pskPGGkgFIEG
	BnJ8pom1jvjaa5Nwsl+ystzG4cNl8JH0XJ+hTGSZBPt7s2oJamX+OrYAtXHY0bS2
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vhvuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:36:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554Ja8ow043904
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:36:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:36:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:36:08 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JZl82014312;
	Wed, 4 Jun 2025 15:35:49 -0400
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
 Dooley <conor.dooley@microchip.com>,
        David Lechner <dlechner@baylirbe.com>
Subject: [PATCH v10 03/12] dt-bindings: iio: adc: ad7768-1: add trigger-sources property
Date: Wed, 4 Jun 2025 16:35:46 -0300
Message-ID: <0a03dd518d6542dc8cb0a43945ef3a3803bedf04.1749063024.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX6Nwgq/7fQF3B
 xdhWt4egWDHf0mYn9uWroPTBxlzMgGMxYQa+g8AgeJexgTyRJgP7xWhrjEETYxNvBTxcBj1jkS6
 hBqFM1TNtM4jXuErg21H296vn3pUQvBthmEElhlZZrVAk1MQJijvt27vQA2MCN5N5k0vhv9AT0s
 nsGiLvaCHteOm6FVDtk5JkYOt42QLQuUQf1rd3uPNdcarH5RDoHGc3EuGoDJZ/8CMVxAPCf7mAX
 SpeKHgBx9R3/dwNbEtFhvQFmIdQkOMecau8RXGEDzwANwuzEfuVGOnAr11SMfdVUHEbhgTra3jw
 Y8zPdPHXvE+hmPvV4eTCaC/6RqhRjMKeMXYU1X59Hqjawe+dhlbNdWu5WstB0DMUXiBBXx5GePy
 vUHjYyJL/vpI2tCaWrFLEWMYeW7rlKOnyurSBTss2+yxrX3SBBFyBcvXhBTezlXkhVYVIwLY
X-Proofpoint-GUID: QIIufNE8GfPSyjqyjjEYeAov-8fyLcve
X-Proofpoint-ORIG-GUID: QIIufNE8GfPSyjqyjjEYeAov-8fyLcve
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=6840a029 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=3yuoaRSoAAAA:8
 a=Lq6TyEz25fwpf9jyvVMA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=2SAQt7U6PxkJVs8Pt8Bp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

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
index 3ce59d4d065f..9a6df931edc3 100644
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
@@ -57,6 +76,15 @@ properties:
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
@@ -65,7 +93,16 @@ required:
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
index d5d14fc69ac0..426e63e761da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1452,6 +1452,7 @@ S:	Supported
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



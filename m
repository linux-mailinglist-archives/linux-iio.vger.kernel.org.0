Return-Path: <linux-iio+bounces-19369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21466AB112E
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BD84C7F3A
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED51290BB7;
	Fri,  9 May 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T2at88LC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C2290086;
	Fri,  9 May 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787844; cv=none; b=ipqrVpgguaaggky/wqUYhrp7fe4IcUzatZ9GlA/6wAwxTYy1yYm4w3Td+G6rlRk/01VUvcJ81rtti3vLOc621ITyzxIoDsk0Fs4UWS/KJNTozRxgv2TbY7T2ENh0csOH7n/hQiFXcsiyKAPotmIs3WCiLZcU7407GDDUVBRMZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787844; c=relaxed/simple;
	bh=qubHkTHqwzLNuJYk60y2mUVu+3vOdKCK4Nc5US7Rs0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgUcVa9OQDKY67V2Qqukazchd9gCNEnHjYx0QqT8YOiNKAUIsJFdLWAURN3ocuwnl4imaYV+16iS2Vt7ZThHrW7NF5YGgvBcBu616n8fvL+42Bq7x90EoualCThdtdptDbfqLK9Zb4kYS3vYVAJs/DKOVuzXteU28/retEP+g2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T2at88LC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Aekrc016323;
	Fri, 9 May 2025 06:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V6nUB
	iK97ge01WyM8HGRrWHPLChsICYJfFPGZA4Fk/0=; b=T2at88LCbNnUEyx0QloQb
	gVscEDxN8rB4ct56lnKDYpFKXPsb+sX9ROYL1wCz/sM81ekLE5FbacTTEjBnTOng
	1kIwXXvbVjWlF/qWmaFAj+TmEX01/wQ87H5C7YfKS+MrnCpMxsCDCaz1A3zBP5F+
	XR6diyPlZ5kMAlXj0rXDorklctbz20Bjz1U45V7m8Yz8MYVV4f0nhq1IqQsDqveO
	IIu4V9ou0ebjQgga6L5UoAtHW6Y0+o6ixSbDVx1y0veOUn298I2Zg5muA8MEYs9o
	SPiQOe8ycKmo/XIsFLarjQI8EA3b9cRG1Pvrhg6uS4WMnM3ollJE8gCGPlY39f4s
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46hg5tg0wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549Aoce2049059
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:50:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK18014223;
	Fri, 9 May 2025 06:50:34 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 08/10] dt-bindings: iio: adc: add ad4080
Date: Fri, 9 May 2025 13:50:17 +0300
Message-ID: <20250509105019.8887-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pzDibyhkoaPuDTgWboEFxaQ4i_4QCNyN
X-Proofpoint-ORIG-GUID: pzDibyhkoaPuDTgWboEFxaQ4i_4QCNyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNCBTYWx0ZWRfX6kOXwB8lbWcF
 SQTF7xqOFTRuaEdXVtq4gXFnczr5zfxqEnWCQdQqIergyrQ4AA4pWGukj1nt8Vk32k8dPchYxXV
 3SRvgVCjvxTdbA20VQS75pb4nOKKeXWD+OJXElWMaEC1EXTSBPhUGpvGGNl2/cgK73IT9DyhS4U
 fJ4Xh4ZeE8R23FlkmayOsUJLJytgLg7ZuWGZKA3TpSGlVQ9SEXib+HUtXFqBRIwzcLfOY9wu3kb
 4ucw3ZRFDHKmg8R2fuXYdB0SbHfOipy3gf6gMFFaYgyBOVqo1nhQoWd8OniO3SUJ8YyUIjja76E
 OFOL+I0jPxUtgj9IMYf6hq16dlvzujP7eU2/R7xqDFEDKdqU/CobbZ3KmPR950r5To4R+j8X6Ia
 ortWoQOfR/VDwx8sSg1GG7CTLY3SzhZPzUYXT/S1MuCzEt+88yHDCcNgm8KRcbMF3+hrFnne
X-Authority-Analysis: v=2.4 cv=eeE9f6EH c=1 sm=1 tr=0 ts=681dddff cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=P3hoaKw3YfnMoAj370EA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090104

Add devicetree bindings for ad4080 family.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 .../bindings/iio/adc/adi,ad4080.yaml          | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
new file mode 100644
index 000000000000..ed849ba1b77b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4080.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4080 20-Bit, 40 MSPS, Differential SAR ADC
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The AD4080 is a high speed, low noise, low distortion, 20-bit, Easy Drive,
+  successive approximation register (SAR) analog-to-digital converter (ADC).
+  Maintaining high performance (signal-to-noise and distortion (SINAD) ratio
+  > 90 dBFS) at signal frequencies in excess of 1 MHz enables the AD4080 to
+  service a wide variety of precision, wide bandwidth data acquisition
+  applications.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4080.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4080
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    description: Configuration of the SPI bus.
+    maximum: 50000000
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: cnv
+
+  vdd33-supply: true
+
+  vdd11-supply: true
+
+  vddldo-supply: true
+
+  iovdd-supply: true
+
+  vrefin-supply: true
+
+  io-backends:
+    maxItems: 1
+
+  adi,lvds-cnv-enable:
+    description: Enable the LVDS signal type on the CNV pin. Default is CMOS.
+    type: boolean
+
+  adi,num-lanes:
+    description:
+      Number of lanes on which the data is sent on the output (DA, DB pins).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vdd33-supply
+  - vrefin-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad4080";
+          reg = <0>;
+          spi-max-frequency = <10000000>;
+          vdd33-supply = <&vdd33>;
+          vddldo-supply = <&vddldo>;
+          vrefin-supply = <&vrefin>;
+          clocks = <&cnv>;
+          clock-names = "cnv";
+          io-backends = <&iio_backend>;
+        };
+    };
+...
-- 
2.49.0



Return-Path: <linux-iio+bounces-19579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84DAB97A2
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344A618973A0
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0EA230993;
	Fri, 16 May 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hhgAlXp2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071F22FAE1;
	Fri, 16 May 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384019; cv=none; b=rPOSNTKE8A4abw1cfQJDhSVrA0s8razpUSkGvUV75ofqjEBBiMe6PkJvwql20CXMyH9WKmOUv4CW2fSyMNwne15h6Z31wS19FmYNo+xTITDeyGVH+y2adE294K8gAX3xdGUIFaimVtPjEk3siYHgunYYbLns8VWWE4f4vDY1LWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384019; c=relaxed/simple;
	bh=1xGy41PBzlTZekwUqX/QKoC1rUJGaAtrasgQtx3pbBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfjnz+mOPGJSqxMrnyzq7tx4kpwFht2IJW83jSZe66iFperYc7eWFmir8xmAppdiI32iUFGHBLSqUaplYIdZrgGbKNCcQLa3UQOkTVly0AUQgnnwh6ukqeaW65tvSKtCvWgOiCuGOsV+DrlTPa6P2nZxshQcmhac0jIagOA3eMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hhgAlXp2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G4dOSe016366;
	Fri, 16 May 2025 04:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=q7NgU
	JXX5Ks4psOwbYOMNAw1fzeUGVLZFPCTR1rPn5k=; b=hhgAlXp2W90y8Iky6oqjy
	P5VZ9/KelwUEahb33miRXJ366Mhxvc2GV7tK7rLmR27aEi2etz2E7O6AHGivhXIB
	RXYm8A0RsmYz123I5cQenWQ/o27z8r4me8Zl/s+wp09bQy+KazYSQVjwABb/jnAB
	9YH4Dcy21SsA4h8HQVCtw8kttJgOKWWGqL0oC1rgQ23JknDTZarH5SH331N8gg3I
	+FOP1HGJwPAij+CCcyCfAic0GjtLapOx1FPJKFj/xid9hyu3QaK8SALgiuZEcVoG
	4JqD56Cmkb5z2u4OC+kWhT/aheLuaBZqe2yoW1eahy73F2Mg5cY4ld5fQnW2Cr7K
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn654vfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qs7T033639
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:54 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwm031549;
	Fri, 16 May 2025 04:26:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 08/10] dt-bindings: iio: adc: add ad4080
Date: Fri, 16 May 2025 11:26:28 +0300
Message-ID: <20250516082630.8236-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: h-lHookt7zlpaEV3RC15ba3hF29FzAPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfXzItGJeN7vF+k
 r2kU4lrRylyXjEucKur4ipgGKmF4d0cp4NU91eQGVnlmXkoXwvu5zx2EIq02nNJQ9zor/LYoYDn
 TRDTwBVdZdnjXweVeAuLKMxAL59IaZLxC63Y7L/rZGcHfUCSZcUg/mABJHtJKZiIxPZjngbXbul
 Uy9eNGyH9oIJq+LKsPh+4dow8PDx9WP9hgPvBCrOBesFiV2obYqS0b24X6e9DmB6jbzM9uVtjZe
 j+V4SS1IY113uL/Ui7t47sSffKfrt8mRnTYdWhcOJDhp8T3Tnyl7iGxJx6aJbEZz2YGEg3/r/Wg
 QO6+4QCEofTF7BMTvizjzQM+WRIfLoNsukzo9rWw6ODWBbZe1uqZvAV8LDIh4bJhLmcKOhTYpwq
 bwtiXf9RyUu8dbIIRT/ffuf3aHcfbjS4oHrpC6U7EKfSpT9z86t+13NEZ8Oh71U9sHlT0I7d
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=6826f6cf cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=s-jUAG74_yLYYRHcQYIA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: h-lHookt7zlpaEV3RC15ba3hF29FzAPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160079

Add devicetree bindings for ad4080 family.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - add MAINTAINERS changes.
 .../bindings/iio/adc/adi,ad4080.yaml          | 96 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 103 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index bd04375ab4a2..244a4510bbc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1317,6 +1317,13 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
 F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
+ANALOG DEVICES INC AD4080 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.49.0



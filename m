Return-Path: <linux-iio+bounces-15868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B2A3DBF0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D5D17E4AE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470C211A0B;
	Thu, 20 Feb 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s5UZm+ax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE11FAC49;
	Thu, 20 Feb 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059790; cv=none; b=Ir/4Vmmvskx+IWtrJ835gyEK9oe+eBA4UELb4OHjCCf0WRJHDfUigcVopycW/sxzk6OE9QLFlZo6I+PP+S/UkCp/Q+n9/NsmA70obJsoswugpqkIas19U1+mc8bayJErdFYhBGosVqzFx859Idjv/b6+FZ4PEfq6tgYxmFGN/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059790; c=relaxed/simple;
	bh=QWNEKoH2QEjiQK6SU/CJc8DFWNH35qu7JHPmK5EHYIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSlQx90g3AbwQvldY+wcWsPX5X99RcJ0EwDc2Hh/Qw+lR/0D9vUTVCiKWAxTjQePYvnOBSMrQYlQE5/3Dp4tlRKgjiEY5GpaKykeJ3YNFETtK3Doqno5C+gMYfaGaXMycckGPk0REmuRMCy2Rn5kA3NoQoDmlGZ3bQO7diTcwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s5UZm+ax; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBRB73005621;
	Thu, 20 Feb 2025 08:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tX91/
	l14DxAm7KRaGHIn4yfha6Xoqk0XoqttiB/WF5s=; b=s5UZm+axsaqqsBZiNY7Z+
	J2F/p0pykJOem8uVQ+vFYeuxiwrEdposQMwJ+MxH1e3TL5knWQ5kv0dpiCxJ00x+
	mHVDmSnhXd2OCQtcGz4NdZ/rbzNasQmnu/2fMBHEfv80N/t2IH4ZVsqkA3fpc0PO
	uizgiRgm1AFsXDpBZSGgAT7ix4L+zDrkeNNzmBig2aKfObb8++4yiTiOLcVJdfei
	bdU18OyH237hYV+0IBJjC6EftfFregX+bckDLJ9esaiK5OBh3l721/bWe03WYX1K
	Yu6ivJEJJs1MHQeTnJwFe+n0mzRP+DWFYkqvw4cLHa6IRro6Akyy+UXuYhXQxWpH
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x3hj0h0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:25 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuOwH054167
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:24 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxr1008409;
	Thu, 20 Feb 2025 08:56:18 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 12/14] dt-bindings: iio: adc: add ad4080
Date: Thu, 20 Feb 2025 15:54:22 +0200
Message-ID: <20250220135429.8615-13-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220135429.8615-1-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: zKF-T5ZqbqN4Wzf7c1kezAFMYOSFfbZa
X-Proofpoint-GUID: zKF-T5ZqbqN4Wzf7c1kezAFMYOSFfbZa
X-Authority-Analysis: v=2.4 cv=OJvd3TaB c=1 sm=1 tr=0 ts=67b73489 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=Hsn-j--P0uF4w0xjABcA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add devicetree bindings for ad4080 family.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/adc/adi,ad4080.yaml          | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
new file mode 100644
index 000000000000..e0ea712b8457
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -0,0 +1,92 @@
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
+    maximum: 50000000
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc-clk
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
+  adi,num-lanes:
+    description:
+      Nmber of lanes on which the data is sent on the output (DA, DB pins).
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
+  - vdd11-supply
+  - vddldo-supply
+  - iovdd-supply
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
+          vdd11-supply = <&vdd11>;
+          vddldo-supply = <&vddldo>;
+          iovdd-supply = <&iovdd>;
+          vrefin-supply = <&vrefin>;
+          clocks = <&adc_clk>;
+          clock-names = "adc-clk";
+        };
+    };
+...
-- 
2.48.1



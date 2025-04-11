Return-Path: <linux-iio+bounces-17940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54548A85D56
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8821BA6DC1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61902D3A94;
	Fri, 11 Apr 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BCQ6QQ8l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941512C3762;
	Fri, 11 Apr 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375016; cv=none; b=XbV2dErtnbDkukbPvEukwZmji9PmNyyRrRpdjGRx4+JqbEqvP4aOIN0D/Dqm2L8T8flTcNl/n+FteNR78eziozBqVas8P6pk8aHn3ldAq8DEyMcD7RxsZUIgCGTlQNZtErXDsv9X5FSURWcfF0LWAjFxajlOaQe11UnPJlm5Stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375016; c=relaxed/simple;
	bh=8qLnh7/So0OexlSQAAiMsNyTsvnN9yRxXcnaOWTqBBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUJDyiHkkUznWqy+sV8gdPaqMWwMipGqSHFEkAisnxIUqIorzbfuDRYeVX7gwr34l28STJcHE4nD1C1pyozZNgIuN9rCKAKysqD2vzJ8rV7x5j+fUVKGvbGiWmui9RtnwaJ9fxi/e/1qSjaC6X4qlEDqX1EBMofV3JQXVw0X3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BCQ6QQ8l; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BA5YuJ015128;
	Fri, 11 Apr 2025 08:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ncRKE
	jTqv96HX03RpvI2Xcu4oG6DGhOts/p/Rigq8HI=; b=BCQ6QQ8llI3Zt7xs1Plbk
	11xrstMCfbvRypaTjPakJCTH0akxog81PiXRlAz5ABqCNok0PGUSHpUU9bKH1cy+
	dHwn1KAB+BIRTAOGtDSjdc1pObjYUcQ148DoBIgF3IiOgRHsnaU+50obLTeNfSSJ
	SbnBeLr5tqZ6u6nHIEgQsBda0cgzhgYz+/FfzglaBK7POm02oj4Q1WxqbVuccVbc
	euWSYh8b9BjwR5n8ZrGC1SzXZPl0gE9IC1KSwics532Xcs0zXB51o2fCStk3cDfY
	lUEsZOKh9Efm0owLJP30LOhyYGimNOCa774XL5zYmSEHwoJICKhVSlRwoAsvlBUd
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6u56g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCaocV005179
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 08:36:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:50 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPW006015;
	Fri, 11 Apr 2025 08:36:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 12/13] dt-bindings: iio: adc: add ad4080
Date: Fri, 11 Apr 2025 15:36:26 +0300
Message-ID: <20250411123627.6114-13-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: kTaCkRq-Noj83tWjEqczuHxzWzvWvjYq
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f90ce4 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=Qzz6MW7Cwu5hLuZ9AiUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: kTaCkRq-Noj83tWjEqczuHxzWzvWvjYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add devicetree bindings for ad4080 family.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - add descripton for spi bus
 - use actual pin for clock name
 - fix typo in num lanes description
 - add iio-backends
 - don't make all supplies mandatory
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



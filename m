Return-Path: <linux-iio+bounces-18965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4AAA6D4C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5CC7A651B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53E230BE0;
	Fri,  2 May 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XvELZt0O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FD22DFAA;
	Fri,  2 May 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176384; cv=none; b=IXwc3ah5xaqiPd3GM3NgHKsv9C/MWPfm0+4DysCTQaz/xq0TGlyZw+GrtwYH4+BmPmg3AVOLADmRaWSc/Nc1C7SoiNpcw7t6hFb81QlJydNA9fmNMuT6pmjTgoRAH7He1j3PFOY7BO61lxNQ/y7dmii7UNYlgQv+xEz2p80Fib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176384; c=relaxed/simple;
	bh=+L9TdB69Fenku1dq/7kJ8upSIBITWqDJqSf7ikOY2oI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8r6CXoQR+HrfhWwfW0792Y2JlnC6aO2uwDkImAYzjQbNgA5/go89Oy83eo4sMSLmwCz14ynnJnxtdIm5V/FHtIj0Q1s4gRINPPIzifNOnGKgPzJSFUrlkB1PLVyFiWbUkEs+mWv5TVQwWOqTYBvLQXuap2+TPOzJMyDaKYO1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XvELZt0O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5426mqti008008;
	Fri, 2 May 2025 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sB6E7
	pZJ0yf4niDXJ7YeapOtQBSYppJHAjgfKPErpWI=; b=XvELZt0OAwpEIyL70duuT
	egZBGFmy83fUqy5/oxvpqBbMORqDqbMoI4908n1zgUTGyMSDjXafwrWlAYOA9P+Y
	H2MqpxAQJGjNNo+DdvVyk8Xef2xYA6IMockfgyB8tsP8SIKuAQZzCvjZMZ9uiIyL
	5l/oT4A1i2OXxASl1FUeA9FTzbFE+jvxQBdyBVYq/bNJGCoKLt4ZTu5EwWJPw+sG
	zdHAhaPF6nDZWfg8Q3V+XlSIzk5jW9pwSYFDPXUO9APWrn6rgPykedVTqTgQzWoC
	fsdISFQr9Kc7/Ou9or6LkNnppuZfZscgsMfVaa70uPriIoe4bzmgoLbGTQm4AYgM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6u1kwwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5428xcV0029965
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7R015723;
	Fri, 2 May 2025 04:59:35 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 08/10] dt-bindings: iio: adc: add ad4080
Date: Fri, 2 May 2025 11:59:03 +0300
Message-ID: <20250502085905.24926-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RuDFLDmK c=1 sm=1 tr=0 ts=6814897b cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=tzrCRXNhpX36lL6KDSgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: IGXk4EEUCEd1doQ67Sqs5AyELOmDxPRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX4Owx/H5yAmLy PzAdBN0jZWExE7PEtmtJ14p6Me6vMdM1MDCrmhJfqG3gWfHIyM5iGDf713mv7JA4XBgmeiN9Xgo MHX6ZNY9RvLYcV0GofMP3giQuFUJvmO1VhSGbO1vb1G6dw2zNJaksi5SbxylrZG8Wk3RLfUEDyt
 QAwh+//pwX246/jrDCqJD9ICFzIfazwnKEyi/zSORWgtEke4nylNBW5Z3RPleLyegcv4xWZVstS 1Fw8gC/hxgmpAjzo75o7x3sTEcG/581ihI5mlbKa+qOK9k/RM0pA68p96CAb2CUiA83Jw8VsIUH GuqMZEQxYDmF3IYmxKvqqRq5seD0ccgQkikqrvCdj0nvxLmX3PuqlARMS2dxFl5rrqWsaDsyOU8
 kbHj0+Bf43teLA5bqW4f3gM88PEqRIubDjyVriicxjoDgdRKOwSUogPqCb0m0zkbJOKt6BI6
X-Proofpoint-ORIG-GUID: IGXk4EEUCEd1doQ67Sqs5AyELOmDxPRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add devicetree bindings for ad4080 family.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
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



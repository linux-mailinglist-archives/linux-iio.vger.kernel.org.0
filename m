Return-Path: <linux-iio+bounces-23293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28946B35787
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5818A6847A3
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656C2FE575;
	Tue, 26 Aug 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hfFfw22i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9924501C;
	Tue, 26 Aug 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197956; cv=none; b=TTsPHVK6iuTSxDz6wedXlvoqMj9Kivzgw1BMKjmQY28ztvWTWauakY0C+NUBKHg8yHuGVZ/j4yDwDL1Pb0qy//qSaicz1IbxeJHQIjHLmmBy+55oG3rMC3h1tMjaBEcKR90nlujOYrePYCu0RcChwGHS8SaOp6ll5nWq3z8po64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197956; c=relaxed/simple;
	bh=stdMr8RC7SFNe+g+pvdH1pC1x80cRjIk3IkEm0HpelM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfD0SKQ4UQ5s4KJtCRB8pqIJ2sgnrpkjkYDoTpl2SK9yaF1Co7djFHbKkX4ACaIZeYAtm9rLxfBA4MAgU2TtvnZzitX3sTFPnmGJTbBbTCfST42RwXxafvRmBWIAB6Eo6Nn4hwiHmtNoduOyeGCXsPWt/EQFoemMRSfYcTjuhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hfFfw22i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q745cl018208;
	Tue, 26 Aug 2025 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P5T04
	j3zkdmuBMYzAoHnHaGPNh4LIbVlHCCLxSSUdrM=; b=hfFfw22i4Z93PTaBtRE42
	5OL5Ax09RS6fp3XNjghFIqnP9z13w597FvPI2RxEtCWMnfXkf/mDjlKkHY0gI0yI
	/R4Nyv7RNWnBcx1bdK6mjyUfUhy98KQDmE/NTMDv7cXH9LtWV2o+IsHIHH5FIIBn
	uYyDgvT9MPYu0+ubB+YdV7Y2lq+oFXvD7BCdquiY94PQCTnLr4guUazNML/DyOsl
	Stt8FJ49+F1HqbtTgP6pMVvHSalkwf/DjGFbHAaLnAUoNkrVK+fUt1weRKEayA2A
	L3y4bGrWXbsrBFRvNok6Z2C/vtAIq3sCzCGm4559jfoY+ACtW8af2w9UYf9jSnVV
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafnwj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 04:45:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57Q8jc0l018641
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Aug 2025 04:45:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 Aug
 2025 04:45:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 04:45:38 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57Q8jHnw015527;
	Tue, 26 Aug 2025 04:45:31 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/4] dt-bindings: iio: adc: add IIO backend support
Date: Tue, 26 Aug 2025 01:13:50 +0300
Message-ID: <20250825221355.6214-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX31PQgaW+rmNa
 D7SbTrknBiJtW/xQzsfMdg6OPXB/n3hN5tK4R+eLSh4/CXttKhCdnXDGq9sYfyeeILqml3LxRD7
 VTCLgI6o9lxEfBnMKSZ5j0YCKAiUJX677E2YTDvM5OJVsZmsP96SDuEIewuw8Zw+6vuXLWlXRZW
 /Vn/Bb+kDyzgq/4+mfmM9kLLn8JzNEIMwdtyNTjg3FUNvRnWkeLImP79m69ha4K22vfmy+19qnu
 /zQoRW+5vb1LjJtjCVj+DO9AibPWQxCJNTvFE5fao8h5E8GY7m6UqGfjVd53B09zWB3oJhIqMsy
 c6XN5a67Wo7vcs3EfjPe4EqCe1K55uDPTLY8+Qa+BZM8I4fs8bDAdK+bhfO/Nnx078B1F/t6Q9C
 ocaVtsgP
X-Proofpoint-ORIG-GUID: qjmpU9_L3vzYJgKkdm9-Lc2ZKfzj7Q1Q
X-Proofpoint-GUID: qjmpU9_L3vzYJgKkdm9-Lc2ZKfzj7Q1Q
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68ad7433 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=vK1i7N8imb33MzeTDgYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Also add the adi,num-lanes property to set the number of lanes used by
AD7779.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
no changes in v6.
 .../bindings/iio/adc/adi,ad7779.yaml          | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
index 044f92f39cfa..ba3f7b2bd6cf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -80,11 +80,36 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
+  adi,num-lanes:
+    description:
+      Number of lanes on which the data is sent on the output when the data
+      output interface is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4]
+    default: 4
+
 required:
   - compatible
   - reg
   - clocks
-  - interrupts
+
+allOf:
+  - if:
+      not:
+        required:
+          - io-backends
+    then:
+      properties:
+        adi,num-lanes: false
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - io-backends
 
 unevaluatedProperties: false
 
@@ -107,4 +132,21 @@ examples:
           clocks = <&adc_clk>;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+          compatible = "adi,ad7779";
+          reg = <0>;
+          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
+          clocks = <&adc_clk>;
+          io-backends = <&iio_backend>;
+          adi,num-lanes = <4>;
+        };
+    };
 ...
-- 
2.47.2



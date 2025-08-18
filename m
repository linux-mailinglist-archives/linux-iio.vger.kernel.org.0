Return-Path: <linux-iio+bounces-22919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70099B2A482
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6DB1B24220
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457F320CC2;
	Mon, 18 Aug 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RRS3Pjas"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639283218C0;
	Mon, 18 Aug 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522870; cv=none; b=Gs9QKXECD7vNfRgUvQaTEMq/6hgbnmSEWEP6YxasQDY/1ddw6J6VmHHmJnB3xPqwP6aQnFqMozNmZCGxdR7wCrT9P08BRQcyLe7GPQOyQzhJFUDDXB+YV6qDjjdqlNcPj8jAouzv+vN3omOYcYWlPd7pusOspDdomPaRT+vLqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522870; c=relaxed/simple;
	bh=LTwc1h9JWgl6ubkagxeJA12/t3fyvSEJvLPL9f7veKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdmBRDenPM2Ea//ktsQA6XxpeNrzcIf+vAciijuBHfdtCLLuRtrAQtnLZUSO9Hlp8Y5XFU/X9ucFI0JsD1I8DeQq0QuJ9qi3cetzJ/jkdS+OmQfh63jphs38ZDzEfkFIca+Ax4oR51DPYxUX+kKSe45Y9IDnvSagczkc7nloq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RRS3Pjas; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBhxiT023167;
	Mon, 18 Aug 2025 09:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fQG3E
	pgwqRzwv8VRL2l5bktVIs3G6KJtsmLNx+BNKmI=; b=RRS3Pjas/+F87lZtzeo6N
	BbPm4TL0G4GQa/Ng5Yx0VRHobLTwl+wJoWbiaAI/ZxUVOLThPn12jrvAj53GBn3E
	P9ZJKbbthjZnbbUpU6D/E9C6FfKFTpe4kNFHTnjgWCgOUoZYLyDeqwQkgdNMB5pR
	PLfz1BUkfh/4aKI/6TMD6Gl8H0VP5cdsv2XWaB6ndl0lgJTN/gGEWKFNRv8GIq71
	dWre0bC8vRtQ1ZMC8+akHtAN6xciNXdtE/oigkvZ1WteFHtxN71PTXaOen+lec09
	wHITKouI75WCcEydL+G3df5NQ5jbnOjPeWVl9r2FIckNkOg+/drxBn0TJ2biUmYY
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48k8afe7rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 09:14:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57IDEDAQ011976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 09:14:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 09:14:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 09:14:13 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IDD8On008451;
	Mon, 18 Aug 2025 09:14:04 -0400
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
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v3 2/4] dt-bindings: iio: adc: add IIO backend support
Date: Mon, 18 Aug 2025 16:12:48 +0300
Message-ID: <20250818131253.8854-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDA0NiBTYWx0ZWRfX2oODDd2fmxEg
 mkxoREOI2Cev3GEZ7QMAexO2vp/Zm3RCGrWsDhHpZArPxW5FkGOPCm/GK6R7qsBLw07GtbWk4Yd
 8dHN3mkM4G9uplXYaW+Kg6bJ808KT07d01yKJJ94xpm6TcVvZVX+Urap/RIeJToCk8F8743I6Aw
 zclmyn27/TIr3Exzl9/maVnBDmZ/FcpXJ4O70c6GnmWsJWcL6tj7CIs3PSCB/yrjTvh+NELGVyO
 WBiLtFdH/Xfx6SQvCuapjOjzxLYHW8NfXyzrxaNTZJwG76zVmz5HGi03V56YkIu5VPihfpmK/tH
 MlWAA7f0TyXFNn/TddDELA3rUOkjD8uqw4CuEb0YAG2t7RbPuuokFjCIOmem5J9+u4MgxPYetfC
 Qcmsnxnk
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=68a32726 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=vK1i7N8imb33MzeTDgYA:9
X-Proofpoint-GUID: cPqHw2mLIY_TK9EVRq9Mc25pAL3hUYCj
X-Proofpoint-ORIG-GUID: cPqHw2mLIY_TK9EVRq9Mc25pAL3hUYCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508170046

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Also add the adi,num-lanes property to set the number of lanes used by
AD7779.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
index 044f92f39cfa..4a212c8bc9d3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -80,11 +80,27 @@ properties:
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
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - io-backends
 
 unevaluatedProperties: false
 
@@ -107,4 +123,21 @@ examples:
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



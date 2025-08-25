Return-Path: <linux-iio+bounces-23209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6FB33D34
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86DF7A7D0A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D72DF6E3;
	Mon, 25 Aug 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KND6goq9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618731A9F8F;
	Mon, 25 Aug 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119172; cv=none; b=jMrO7GcHc0jm4YLo748WNhPP0aUA42GanXPORWsmdpiWiZJn8qWA8U5wxffBZrLDtJfxjJuA21puCtYwh1bKdCkGze62CsMZc1ytUrsjvAXaJCNP39+Jt7LGFDFo5ac/o2g28FsaB3J5rbhhIkWhjkZQZT+gxMMLU0E5ChGNqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119172; c=relaxed/simple;
	bh=EdIhSMplJqn1dvkVFAqYH59dhlcVLWaCHL7fiFjgxZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCjaQe0GYYhklExFOAz9w/mpwcVvvjr9Q2Yf7YJvZagGjr22OSA0D7pfevhuCF3aWuC5go5YdZ4FosRKrseVaP83FqjD2IwlkWaR0tdbhnwN3k80I+P8bYZOat5PMSxVyR2484I7I9kQGMtst+FWeF/q1d6eY0aYxxoc1wsEe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KND6goq9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9sAug007925;
	Mon, 25 Aug 2025 06:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YPDkd
	KCckwLLxqt2JnKqv2DSnn/2KBKE2Lvaf89Pihw=; b=KND6goq92TWgwmoQOsvW3
	cv6pTlw7RfeRQL8Nm00Y2c9i6IkU2Dv66Hr+vE9NCdIuyJZRMQ9JPVt+bHBDo81t
	pgWEaVrJkS7MwgdAZ9hLH/ou97uXCxhwrzrRZxyjwr7WraLM5x4gJ0azJ0X/49hS
	hCZuqFbLhSiszXqy/sRz4Ubev/zaTqeKZs7dQyrdhbOKVn+cQi3jsY/Q84xgDKce
	fysDRAkXo75m45brmYOEultwt8InjOu0R5AiNZB96O0/9mkKjonG/ZRB38aKN1VY
	B5OawmjYxL0FII4edpK3lqCu+QRABffjLI7q5Kv4791aFgLlkIQ0/vZa/5zMwviM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48q7g40re5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:52:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57PAqZlW006401
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Aug 2025 06:52:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 25 Aug
 2025 06:52:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 25 Aug 2025 06:52:35 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.65.213.1])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57PAq609026383;
	Mon, 25 Aug 2025 06:52:28 -0400
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
Subject: [PATCH v5 2/4] dt-bindings: iio: adc: add IIO backend support
Date: Mon, 25 Aug 2025 13:51:17 +0300
Message-ID: <20250825105121.19848-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5vRbzI9zHtSr-NA8XDVLDw2xm0LE6tRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA1MSBTYWx0ZWRfXzR5OmTGQBM4o
 NzZZo8z21Ktuq9Jc/zmF53CTwi6+DiieAEE5NybHanw6kv1qgqbHWGWFwTTWMHychXz7LGQrfAv
 8sxCo+eg2DtQwYQcWvMMRpg+YCCQ73C4La+B8+F2Auodph5q3qfrXoXMDjkOUS4f2anbT41lA6e
 2XQl2bRrJi6nJDtdfe24gJzNCHfdnMqv4WcqxRMvHdSwDyovF3sgYzc07jaqPwzLIlh4Xly7p17
 UxIW0V4XYNRSZ06cJcwY/siAxucnlWqkJ7hpntg2E+rprTjG6jZXiRRyJJkRUy1GUJuBVbvrj89
 E/94aOOfQbjVvAxCy2BzIeVcs3DAtbDdj9+S9vTY8RFHH5OXUSlyNDxafTm6+UB0DCIK1IqOPHV
 45fHjMms
X-Proofpoint-GUID: 5vRbzI9zHtSr-NA8XDVLDw2xm0LE6tRT
X-Authority-Analysis: v=2.4 cv=PNQP+eqC c=1 sm=1 tr=0 ts=68ac4074 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=vK1i7N8imb33MzeTDgYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230051

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Also add the adi,num-lanes property to set the number of lanes used by
AD7779.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
no changes in v5.
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



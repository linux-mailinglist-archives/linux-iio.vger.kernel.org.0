Return-Path: <linux-iio+bounces-23045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEAB2DBFF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D95C566C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D092EE616;
	Wed, 20 Aug 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pneLz1ag"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7C27605C;
	Wed, 20 Aug 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691424; cv=none; b=BYpS4mBiy33HGsScAKIaFzxYJ6E6kpRmPxywyBUBMigJ4abMeZt8uWHiAXMzfH94APLtBwYiSL+d4DUNlVms3Oc1mYb9LVGzN+cC238YhY4Gi6C9Z5VCyP9uHeNUsakMqdDmo8ZWO7B59Vmdn08K5r8q6xPphs2gyNs/bswnoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691424; c=relaxed/simple;
	bh=6DVSW1b86Rsazl1faHqxTsS4ZQHj7kU+V64WxGV6UMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyvDTuC/xV5MyGDLdXv0ifhtTVa2hV0wvOxZrn9CvowIe0N8E2Xr0kAQera+/+qIQl3j7L7DquXsAgp907pBYkCagJGUxAa5X/36pRaWI6OGq7delAoYw5cHmN6DzFeNU7YEQE65Wdt/GoBCT40jWhD/40QHSW6TMrjwiwyV5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pneLz1ag; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA3cOh004349;
	Wed, 20 Aug 2025 08:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uuvof
	AA3L0xu8ZK2d7GUgFtboylj1xqQu0EZxfODhx8=; b=pneLz1agtpZ1ruyUNZ/wX
	z9t9w9unRGPnkZlBaGL/ieXKmq70SSBBxG0X6s5qYNX/DQULAq/ibP7A8shhqZgC
	HM/CjKhLfpuElTHFL0DD+QDdtYw6Rn44sYPkMHNf8eTs2atrdbV1k/9siHkJOwzV
	BCoEbJeVhDox3ohEVTRIADju9bvHgJUEyvShrLMA/f1PyRsPAOf3ndYY2WgK8LjB
	CcqIbZRtGYewFOqhv6quBt3iv+5vo7EsOw9/YHEDeWVkcptTURcec+eh3bqm4VlD
	hOOWI19EuHw/8KHFD3xK3NAic7gD26Ae6gMb0/ouO5EPOcbXwFHuDPHFa58vUILr
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0td3gtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57KC3OWD037342
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Aug 2025 08:03:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 Aug
 2025 08:03:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 Aug 2025 08:03:24 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57KC31n2020092;
	Wed, 20 Aug 2025 08:03:18 -0400
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
Subject: [PATCH v4 2/4] dt-bindings: iio: adc: add IIO backend support
Date: Wed, 20 Aug 2025 15:02:43 +0300
Message-ID: <20250820120247.3012-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bvAVxEai c=1 sm=1 tr=0 ts=68a5b98e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=k_RRbiLaOECQDL48JDUA:9 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: W7zzJ9gwtKXgyJVcIdOhymImS1YndAMM
X-Proofpoint-ORIG-GUID: W7zzJ9gwtKXgyJVcIdOhymImS1YndAMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX7qzns3J4Wd4F
 oFRBzC+Dg0OQ1Hy9dGuCEhXBd9A8+msyHvpm6/o4MWeb/6yCpKTqgnlropY8M0q7faeKcCj/5Eu
 iM4KB+mrthMrUyHqOcgPF9EHECYDNbD5bhmaGbj90rGg3jfunb0erGlqwevBeS8uqewsA0isEQ+
 AyXuRerI40+Hvx/yGvBjwzkrIx5kY0nWASPBWqwUuQw9/FxCa8AKe2L4UW4LdBnZfQKC08sgNzS
 EpqlTEBCzCTKcKGGvhg4bm1Qn+CE1+keuxxPl88Bm9muKykt1h59HafKmtkF1AEd+vQllekWAVP
 3y0DLPIXEf+8XyDOquHZ/ipIf7K+Ir6v+Al12YeuL+ObHsKxpJh9TcXqbsTc23L6u5AM9rsnHKx
 raL8UEREB5IrlL3mJyiSaarbrJ7YNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Also add the adi,num-lanes property to set the number of lanes used by
AD7779.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v4:
 - included previously omitted reviewers from earlier patches
 - modified the logic for handling adi,num-lanes in devicetree
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



Return-Path: <linux-iio+bounces-22097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04FB13BC9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B4C7A7CB6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD026CE27;
	Mon, 28 Jul 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z+2oZzYg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270526B2CE;
	Mon, 28 Jul 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710339; cv=none; b=UKuzRk2CS7XOTl/Ygw172LQSPOLU1EOjiByBUXGsXtpZl5r0xl1CM109646ImTNTO82RS7AWhGd0G5IllWEDVurdp/LLF6NGS8ij5Ro6QL4oMUXbDL/UMIH8lnuB8gFyO2csdE3QL5SoEnptJRuJCQvF72PektXC6vn3KZKAeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710339; c=relaxed/simple;
	bh=cu42jhqXz3slrPng9q/K81ypaI4RgXq6hiZiYfec3/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb3kUH0EWXuFmohpeYGXBsg7jGJhdPQ+uj75A2DGFa/zQkn4pe2QTKELj7cv98XlUaiRvx6wtq9WUr40tIz1lUpIOW0bT8z240iqw1FXFaghRfFzXDDCrLvpiFV258Aq9UzZ1b6TA/YoyVtSY78CvzqPM0ZKe3UQxat0deyyJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z+2oZzYg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SB5t6B030593;
	Mon, 28 Jul 2025 09:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EQAcB
	Tf6R7PEjmHply/DiEehAEp7J3k1aKz6H1iMs+Y=; b=z+2oZzYgT/vvsfPXquNUS
	3jEVLZSZBVX2mwd92G0bE0N6RroRzwXa14Y37toMyiu9848/PJ93p0dmWkr/9mDu
	nZUF8/QtwVU7PrOlOoJ/DYUeCJffX1H+FF78sWz94yuBhN3qeYl5aCeGOFPwTx5V
	OlZOrQDd7MDShk0zqUmZrUBmOCHNLnJTh5L11zMFxRmrmqubQ2Emm27V1ZIlqHrO
	Ixs/Es/g6d/3goDf966ct7MMp/XtDl0Z3ArcQLRYFKjwojIT/PMAo8VKwqnKOUlW
	oxlGvPgT9H6jQuJ2jAOfNCrJJjj4KGGRNbFK3WVe9UD2UHoQrrXTsOcb6TOCjNKV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 484ux78xyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:45:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56SDjE6V047150
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Jul 2025 09:45:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 28 Jul 2025 09:45:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 28 Jul 2025 09:45:14 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.169])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56SDitBU027767;
	Mon, 28 Jul 2025 09:45:10 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH 3/4] dt-bindings: iio: adc: Add IIO backend support
Date: Mon, 28 Jul 2025 16:43:35 +0300
Message-ID: <20250728134340.3644-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfXxxNjA9E58vyV
 Q9LfR5h6yiGnzTVcQXBHKYtl2NNvIyZdR5BQxTxN/MSN6kqirM3V13GDkqWlbX4qumMONiuH8Dk
 DaY8QWt7t8EphEF+BoRTOFTyb7j4V3FwBepi5qCOH7on7AKpPnyVMcYFR1pmqYWN83sqHFliLKO
 sqhewT09nN53I1/Ga1MNI0sw8832mQpNZ2uZLvTsYAFWYiu4H0HU7f6TX2nrM4fO2r69+s9WtgQ
 8TYRIKYS4yKIxu4grUVVZHuHFCmUS5Ohf4QZ2TH1RX2tzh+ucUBVDRfkUhJssdTXZOyYJpsgyab
 14DZ2f0ohw6KnPOKHoMoQt6ZKMD6hrnwbwWZFz5cbOFZxdNcyr0bPNinda/lMVk40AvolDwRmvZ
 uDZTzLgaY0HotYkeRgJnKasMHJ66i16xyIMlJrx3GnSBksNXmkYdS4/p2P4rDKzFqYO9DiWW
X-Proofpoint-GUID: shxde2TXDj2jnz1icG1wmrkLUjIRa8JH
X-Authority-Analysis: v=2.4 cv=fr3cZE4f c=1 sm=1 tr=0 ts=68877eec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=MQhCjyGKDezgxiCpAjcA:9
X-Proofpoint-ORIG-GUID: shxde2TXDj2jnz1icG1wmrkLUjIRa8JH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280101

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
index 044f92f39cfa..4adae4f0ec98 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -80,11 +80,19 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
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
 
@@ -107,4 +115,20 @@ examples:
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
+        };
+    };
 ...
-- 
2.47.2



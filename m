Return-Path: <linux-iio+bounces-22353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFFAB1CC86
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19C718C56B3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875502BD024;
	Wed,  6 Aug 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="plMxoEqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76829B229;
	Wed,  6 Aug 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508491; cv=none; b=M+9fdAPRMQgav2zCNIC8kw9HmwXTTjbcBWRHCnpYSUuTgE9qtkxyKKt7ROJDigPmvc0WbgBF1S0Hg2DLzBo/95pkIU8TgaumSOPQOhB8bqHzqisY4+Ezd+EfgXW/iWVIIqkLKnvD8lr9Bs/tppABxuqqmr/xTDWF3KRtxtlxB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508491; c=relaxed/simple;
	bh=CZr8UWR2gxOCnXePM9ri8Fb/vP9DksR7GamiwYQgh4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAW5fIf/ZUzGhf+G8Io1gzAV1mJl+zh72sB5KYkAb3tQjEJU6Ni4tW3fLrLF8RrtXc8yluJs5hHIDRKLIXelJryd02fh7ZL4GQL2YqdVJ/IzNRI2G3HLOdmaETmeRD469t8MP2MnRUVDnKy0/HAIv66qVG3eCUHauW9N0+8ZYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=plMxoEqi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576FMwA1013501;
	Wed, 6 Aug 2025 15:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nbDDz
	gv7TBHBsYQd2MOEwc7T0eMLljpXCpegeYNB6JY=; b=plMxoEqiI75VAMYVa8TF4
	PXRd2DRAX7woM70KYlbabeJk5cGjeU+xHieSMm5kf35eQNHqjIx+sQYvjbW7THTH
	U2TH8xBbq/cmxDRsxvZ++q2QLQ/8mvXqRNYl8Xz0MZMJCZXg0ml5C+rr7H7dy6qb
	Az5lAIk0PdBEME8k2clnVAc6f+yfhESJEsbTcqiCNBMyz+uKddBxUQWfHAcWmyfK
	MyD33066DNYHD5Elw4fBrhiVjwLA/VuX1ZING7cfJfY3kAojZeoNFJj64EdEMWhL
	v1JODdkJoSm+egRc8YG1nXOQv7flVXao0RWzaQiVALoBlbp07dAue50ceATDYYn7
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48bpw26a49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:27:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 576JRsPo053745
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Aug 2025 15:27:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 6 Aug
 2025 15:27:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 6 Aug 2025 15:27:54 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.132.255.77])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 576JQAa4004911;
	Wed, 6 Aug 2025 15:27:45 -0400
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
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: add IIO backend support
Date: Wed, 6 Aug 2025 22:24:59 +0300
Message-ID: <20250806192502.10120-3-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=I79lRMgg c=1 sm=1 tr=0 ts=6893acbb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=vK1i7N8imb33MzeTDgYA:9
X-Proofpoint-ORIG-GUID: jFYmqf8LLjY06GFeHS9_Tsek0Yb_sCxe
X-Proofpoint-GUID: jFYmqf8LLjY06GFeHS9_Tsek0Yb_sCxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE2MyBTYWx0ZWRfX7yGKSe7MK44V
 Wdete/Zvpg7aKARp4yV98dA2F+sBkPTo02XOuoBca3D9Fvz0pnz5pv+S/HqxX1gO57k8aBgIThb
 38o91cTfURHrYBrCmlY+ULGwmopiGbaSy2CJDqCbMu4UkWi3NDWFvEj/puvCQvi0hIugfe1Us8F
 HdHXPlyR1oxhXd+RLqW69+oOwyJr5ALSMhWy0VTxtLMgG60jRGKWiTuPxVArv4/paGw/iBpLNw6
 P8lerlma7zQf3ED2Jy9dSeCs62U4koqXGENR/Sb6D9UJRo6BwE6R4a4jUA9t0DvfK1r18CgfibQ
 UtLCEeKxyjCTMmThyJG4WAli+Wfzadg5Q+O+mjwBQGhYrAnLgS6FUr2DF126nzzeJ4kVv48NSWh
 tOwXtYcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508050163

Add the generic io-backends property to the AD7779 binding to enable
support for the IIO backend framework.

Also add the adi,num-lanes property to set the number of lanes used by
AD7779.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 .../bindings/iio/adc/adi,ad7779.yaml          | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
index 044f92f39cfa..4205ac29c824 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
@@ -80,11 +80,27 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
+  adi,num-lanes:
+    description: |
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
 
@@ -107,4 +123,20 @@ examples:
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



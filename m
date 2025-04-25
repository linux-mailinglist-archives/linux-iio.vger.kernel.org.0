Return-Path: <linux-iio+bounces-18639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78687A9C793
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B429E2F91
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DD2522BB;
	Fri, 25 Apr 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zdMUE7kI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83E2512D2;
	Fri, 25 Apr 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580372; cv=none; b=NlARuYijyaCWLbaJbtiOH7A1Lv5CMLcU2XyGB+Q+bZskHSK3NSSnntLwozhx6hlDvm35WrYuocj2SpiovEBHktknsAi2odHeyCq5WhUtz1gJo8mNuiIHpuHfSimGHo4QerdUtIODo+7es7TUHA124BAaBdg0rfDrn9/XwiQDy8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580372; c=relaxed/simple;
	bh=d5Ua307c1xd0Pkt4UIGYeadI1ECH0jl2nhydMIgjjwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwL96OLmsaw+RpWtj42iWQguw6D+5sXcCCeyCLol7jVp5VVHUwtijb3fLw7jXa9FJnHj4/W0iSFIqJVN0KBIaahhxpirE6Hq9/cgX7Efg028QO+OJI5HUJNFakXCN+LLj1+UbmLLVfEvgv/5pFdY93iJ1H718lryXdonJS0jhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zdMUE7kI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P83lnA014684;
	Fri, 25 Apr 2025 07:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SsQjs
	BT/cNlJu23C8I/q8gXSOBy7VKLUQA+ihcrY6zI=; b=zdMUE7kIMmOFkM9FA+ClJ
	d5moF/yn0yWUFTUTqP6O7nkVCJ6qSDscqJHqYHVJU68o3vtfC30HH2i5v+GEseKZ
	FqSvsjVvqOLZrt5vC+lwlh95n0zbJu0n47ghVMQ0txmsrHt4//H3hll0N4itixuH
	YlGZndAA2X99icu5oovqWnxTFyyJ3nkvFTfNf+nC794BE2PteI9U37Eted3ItmPO
	2sOynvl2CUoCIieTs6bXFTncqQf+hlhQXo0ifP03mEClkcaJyA/YpyHrbvwnqsRd
	nw7yIG2/T+xghShnruA+bMtDcd3ED7dAQZwK9q/ZUqJExCtnz2SxoXtZ/uUFn4Jq
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjwf1h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ7Z0049251
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:26:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:06 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjc2003881;
	Fri, 25 Apr 2025 07:26:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 10/11] dt-bindings: iio: adc: add ad4080
Date: Fri, 25 Apr 2025 14:25:37 +0300
Message-ID: <20250425112538.59792-11-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425112538.59792-1-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RZ-5QacY3H1Sb3nDbJ4hmVEZ5lvvcL-e
X-Authority-Analysis: v=2.4 cv=JMU7s9Kb c=1 sm=1 tr=0 ts=680b7150 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=Hsn-j--P0uF4w0xjABcA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: RZ-5QacY3H1Sb3nDbJ4hmVEZ5lvvcL-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX2Vn6to/BE2Rg zSK8Du5LrtkEjqDOuFlsRmriQOXb5gTOMVQ0NydDN1vhfbQTJG85oOTkRHw52l9vV9dK1DrCGeP GCRlNxfFqOEGzh537m3IYK7xqtOL0trBmuIdV+x/WHku6kDqrIgTdnCkfN6ojyXy6eXD48VKpei
 1iWTRTQZBWYEnbPoUjh2bqa99Tr4xvvMqukxBVRBgg9W+yRmZy980x+Ayv1IA1v2/iGrbwcQa0E SSafRU9cL186FaHCgnYJD8g/bO62tyrvumPGbRb8HesHO5YQnBh6T26Agx89+w7ehVtL4CwgyV6 uLk/apJg7iRK3hpOdLLh+Dp+Y7FYAdcuDF3oIVpMn6TEIGiQ/1it5ogkHkr4bXUflNy+m2QkGWv
 3gyb9KDiePfq4i64DCZSZY26QA20UDJF1hUd4V6bUdU+872eG5p5S46d6unfBflpN+kioKxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add devicetree bindings for ad4080 family.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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



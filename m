Return-Path: <linux-iio+bounces-12252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6569C8B62
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753BD1F25037
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DE1FAEE3;
	Thu, 14 Nov 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LlwHXgIw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505A1FAC50;
	Thu, 14 Nov 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589461; cv=none; b=KWvNg76yUoEveEGQqlWNf0RlAV5AKvg3vPFzKk+/nZxe26yANJ6C3VIMLnAE//btyXioE5heIAVHQ13aOlecbf8FeMHaafgP8xSL/vEa3/KFjCxHKl/PKmkNcno8FsrH9AXHQVlGAw02BprfRTBQibGCjjWMOYeAgCx3S5QaJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589461; c=relaxed/simple;
	bh=OHDK0gSaagvCSN4N1WoVnTQHvOS5rhOmfKh6C0tkpWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXntthsAlK2+MXhTa0wKZdGIVd2PhaUt4EyuvcqlgO3bd5dH4dMlCBtPNgmI4NzsutE68YIpaKp+OtY6Q0TUMCByGc2k4at4gORDVQ/tdtcReyFvemVLsm4ma6BOnp8FcISmAeXMcP/8IwSdTbsB+Aagc9g5PS1SXX8RyXnsUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LlwHXgIw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECKcKS001391;
	Thu, 14 Nov 2024 08:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rPVZ9
	cXtd/mtOUbGZ1hkvdo5jrXKFTO3gZj5XF5XDGY=; b=LlwHXgIwuo+9UJ8tsyRF8
	pVPkg+yzKNHvLc9qneBxqc7pdXq0rvi7Fd/H23si7kwyjf19oAVSXLnyrygvV2tA
	b9sdWaB42WyD7J3GxOfmUsMoUoFr+P2j4HEwyhf8g8BIrMyHx1XfMUmOCkdJjEMa
	Ce40CFrnkiRJ6MlElgweSE8Ez1QV86yjCuPm2iRWWOdb9U0li8EibWSjAmyFuj7L
	iAabSD1XMrX8rpJnwTmurOCiMrmXtc2x88WFyjqmseBwrMhn7HOC1h1hozh9dIyP
	OYKcCVj5cmRer+BViGd+r19Vs5IqXDmfTpdMZXjctYLboffJG6++zp4UC9FQLdox
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42wdrgs9sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:04:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AED42wC054384
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 08:04:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 08:04:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 08:04:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Nov 2024 08:04:02 -0500
Received: from CHEGBELI-L03.ad.analog.com (CHEGBELI-L03.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AED3hfl030605;
	Thu, 14 Nov 2024 08:03:58 -0500
From: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Ciprian Hegbeli
	<ciprian.hegbeli@analog.com>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382
Date: Thu, 14 Nov 2024 15:03:10 +0200
Message-ID: <20241114130340.7354-2-ciprian.hegbeli@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: I186iUXY6KeZn_IqZDrACXYgfC-pcP56
X-Proofpoint-GUID: I186iUXY6KeZn_IqZDrACXYgfC-pcP56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140102

The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
with integrated VCO ideally suited for LO generation for 5G applications
or data converter clock applications. The high performance
PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
high PFD frequency of 625MHz in integer mode that can achieve
ultralow in-band noise and integrated jitter. The ADF4382A can
generate frequencies in a fundamental octave range of 11.5 GHz to
21 GHz, thereby eliminating the need for sub-harmonic filters. The
divide by 2 and 4 output dividers on the part allow frequencies to
be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
respectively.

Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
---
 .../bindings/iio/frequency/adi,adf4382.yaml   | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
new file mode 100644
index 000000000000..44a29ac7a2e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adf4382.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADF4382 Microwave Wideband Synthesizer with Integrated VCO
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
+
+description: The ADF4382 is a high performance, ultralow jitter, Frac-N PLL with
+   integrated VCO ideally suited for LO generation for 5G applications
+   or data converter clock applications.
+
+   https://www.analog.com/en/products/adf4382a.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4382
+      - adi,adf4382a
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 75000000
+
+  clocks:
+    description: Clock to provide CLKIN reference clock signal.
+    maxItems: 1
+
+  clock-names:
+    description:
+      External clock that provides reference input frequency.
+    items:
+      - const: ref_clk
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  adi,charge-pump-microamp:
+    description:
+      The charge pump current that the external loop filter was designed for.
+      If this property is not specified, then the charge pump current is set to the
+      default 11100uA. The valid values are listed below. However, if the set value is
+      not supported, the driver will look for the closest valid charge pump current.
+    anyOf:
+      - enum: [790, 990, 1190, 1380, 1590, 1980, 2390, 2790, 3180, 3970, 4770, 5570, 6330, 7910, 9510, 11100]
+
+  adi,ref-divider:
+    description:
+      Input divider of the reference frequency, cannot be lower then 1 or
+      higher then 63.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 1
+      - maximum: 63
+      - default: 1
+    maxItems: 1
+
+  adi,ref-doubler-enable:
+    description:
+      Enables the doubling of the reference clock.
+    type: boolean
+    maxItems: 1
+
+  adi,bleed-word:
+    description:
+      A small programmable constant charge pump current, known as bleed current,
+      can be used to optimize the phase noise and fractional spurious signals
+      in fractional mode.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4095
+      - default: 0
+    maxItems: 1
+
+  adi,power-up-frequency:
+    description:
+      PLL tunes to the set frequency on probe or defaults to 2,305 GHz.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint64
+      - minimum: 687500000
+      - maximum: 22000000000
+      - default: 2305000000
+    maxItems: 1
+
+  adi,output-power-value:
+    description:
+      The output power amplitude level which will be applied for both channels
+      at startup.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 15
+      - default: 11
+    maxItems: 1
+
+  adi,spi-3wire-enable:
+    description:
+      Uses SPI in 3 wire mode, by default is uses 4 wire mode.
+    type: boolean
+    maxItems: 1
+
+  adi,cmos-3v3:
+    description:
+      Sets the SPI logic to 3.3V, by defautl it uses 1,8V.
+    type: boolean
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        frequency@0 {
+          compatible = "adi,adf4382";
+          reg = <0>;
+          spi-max-frequency = <1000000>;
+          clocks = <&adf4382_clkin>;
+          clock-names = "ref_clk";
+          adi,charge-pump-current = <15>;
+          adi,ref-divider = <1>;
+        };
+    };
+...
-- 
2.43.0



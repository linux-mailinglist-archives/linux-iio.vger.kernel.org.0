Return-Path: <linux-iio+bounces-24267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B66B86488
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A8560575
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E131BC97;
	Thu, 18 Sep 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bhQ6s9T9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64F208A7;
	Thu, 18 Sep 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217192; cv=none; b=nEaR4AX+mdp7Cm9o7hmAAV2cLI/7rEnRjSPAUB0mGsuD3PUFxoKITgF3uSp7XXJsvQMnSfnmEyWGVrN55DSCCTEUTmy0W0aiU2WYRDMTxodzS6Q0N/lyc6Yt0SKd4NxtrcLJyBIRMZwCVptxajNEW9qKXWNozEc3UuSeDvV01Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217192; c=relaxed/simple;
	bh=RzmjZZ37Hq6ApTfXAxgI1YJlCTL13uax0ZvP78abZro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEyGLpZoe9vX/NpjzaQ3eqDZcNavKWUVxuEgmPfzjTyKPCaXfDFFwSesqmyPukxC6/3NYzFRqNutJBQu8mfOoRHKhlkHni0I/cd7iixU0ZeB/J8ucyNC9WsyTLoW9YExfYV2/TPW6AkyJS+W/uVC26uqhcid8kf6uzkCPalAIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bhQ6s9T9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGFENl022817;
	Thu, 18 Sep 2025 13:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1sU26
	8u3ubhP9nyMcRxYl8CmkVsvWlSdOamOeWO7LD8=; b=bhQ6s9T9ZuLyT0ZffpkBS
	HvmopLdjdVRaA8zZ/kx50UxfQj4LqEo2f2BADrs6aRCQK8prh6YznkcnsZTpGxmN
	pqYof1QHJmluIHwHDTP7auyOKqSWBWkYvhzw5njCrL5Njr/ws+icIuiJ6Drra14C
	xV2UdAp48+/RMoy1iRy1WvO0xYB163Mxm7ym40YuhwJywKOTii1tlZ8moGIWgERg
	xraw84xaiWBTvahG5H3Fd+HVtvq6jM5naHetXz2pJhr0u9InFmxPpqw/g2gkp/bx
	3E0jLlV02NvksAJrMnhJIwKxaiFBNxlknyY/e4MwD0S+2sA9HwJUmav5Kb090J9m
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 497xre7v6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:39:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58IHdid8061832
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:39:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:39:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:39:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:39:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHdT8B022240;
	Thu, 18 Sep 2025 13:39:32 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Thu, 18 Sep 2025 14:39:29 -0300
Message-ID: <2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hl13B4nprSak4e3tKEdGMR9W0mVLAWfX
X-Authority-Analysis: v=2.4 cv=WZUMa1hX c=1 sm=1 tr=0 ts=68cc43e1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=0GKIfBuVSP7uAb9je7gA:9
 a=T57YGATm-mvNIQiK-QRR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0MCBTYWx0ZWRfX5bGg+Cqn1Pmm
 FtNP4YUF5mTkZig5WTL8YQuyuqdBrT8ZgDlNYLg3kdTAyMa7LEZJMO9FrXP4Dpmn2jhZhX0gTwe
 C+cTLh2cIxnARFWJ0kIK5wcssVae6B+K2a4zloYY6WE23HVv/IoKgPTRTqiiN49teDxrYBMB8z4
 V+3yGueDop8TfJ+BLaqFiNTIW3BKSLNLS5kJcvYDha3H9xoV5NDSe41vQbjjvdOoydTUc96P+Zn
 pCipDOtKp0iGnai40rOGHN4RGKVH6KPtxP5OoH4ZeMvNAIbUiTLiKb+Xt8014knL1DjnE/TCv9w
 EuL8eUGuuxEkX6zgob6LV2I3YQsPro50IELOUXs4EJaxUen2esKUY0nvCVez3CWuWxZj7FGZSvP
 Wpo6LVfh
X-Proofpoint-GUID: hl13B4nprSak4e3tKEdGMR9W0mVLAWfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170140

ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
PGA (programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2
- Use pattern to specify devices that require gain related properties.
- Disallow gain related properties for devices that don't come with embedded PGA.
- Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
- Updated PGA gain constants.

 .../bindings/iio/adc/adi,ad4030.yaml          | 65 +++++++++++++++++--
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 564b6f67a96e..bd43c617ae11 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -19,6 +19,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,6 +33,8 @@ properties:
       - adi,ad4630-24
       - adi,ad4632-16
       - adi,ad4632-24
+      - adi,adaq4216
+      - adi,adaq4224
 
   reg:
     maxItems: 1
@@ -54,6 +58,14 @@ properties:
     description:
       Internal buffered Reference. Used when ref-supply is not connected.
 
+  vddh-supply:
+    description:
+      PGIA Positive Power Supply.
+
+  vdd-fda-supply:
+    description:
+      FDA Positive Power Supply.
+
   cnv-gpios:
     description:
       The Convert Input (CNV). It initiates the sampling conversions.
@@ -64,6 +76,27 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pga-gpios:
+    description:
+      A0 and A1 pins for gain selection. For devices that have PGA configuration
+      input pins, pga-gpios should be defined if adi,gain-milli is absent.
+    minItems: 2
+    maxItems: 2
+
+  adi,pga-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if PGA control inputs are pin-strapped. The values
+      specify the gain per mille. For example, 333 means the input signal is
+      scaled by a 0.333 factor (i.e. attenuated to one third of it's original
+      magnitude). Possible values:
+      Gain 333 (A1=0, A0=0)
+      Gain 555 (A1=0, A0=1)
+      Gain 2222 (A1=1, A0=0)
+      Gain 6666 (A1=1, A0=1)
+      If defined, pga-gpios must be absent.
+    enum: [333, 555, 2222, 6666]
+
   pwms:
     description: PWM signal connected to the CNV pin.
     maxItems: 1
@@ -86,11 +119,33 @@ required:
   - vio-supply
   - cnv-gpios
 
-oneOf:
-  - required:
-      - ref-supply
-  - required:
-      - refin-supply
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+  # ADAQ devices require a gain property to indicate how hardware PGA is set
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: ^adi,adaq
+    then:
+      allOf:
+        - required: [vddh-supply, vdd-fda-supply]
+          properties:
+            ref-supply: false
+        - oneOf:
+            - required:
+                - adi,pga-value
+            - required:
+                - pga-gpios
+    else:
+      properties:
+        adi,pga-value: false
+        pga-gpios: false
+
 
 unevaluatedProperties: false
 
-- 
2.50.1



Return-Path: <linux-iio+bounces-6899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A3916CA7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FD51F2A28E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0117E8FA;
	Tue, 25 Jun 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4UJqdU8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB116D9D7;
	Tue, 25 Jun 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328247; cv=none; b=rCLBjUsBa4Xcsp+jjq5QIMcsvRRfskE/48ktWCDH3sfdKFdY/UaK+x5taSWN1m+zUqbuDHkah73nko4Mnq8brEAOxlAB/4PfyC8gZbZGrar7aptDAxYQ9ymA1WD3OWa2UPU+0kMGJ38Bk6z9RRJedoq+ncWS1P0qm5ZONEP/sIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328247; c=relaxed/simple;
	bh=SEgRh2he/c0jrH+hZ/ZnIugEZM15idbVPIlKJefZ9/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx0mgLN2H2GiRnvXoS9lx3Sn5rpVI+he+zAlgjmbayZLayYoGhRdjRCcFVD6yPTQ7nCZTo9qAKoC1sG9XQj50kBMF9pHr4wBHl/DRBC3YHgTtBoKvidw0U5CgoX4tHhNERW/YOSpAujbYTcgvwNioAIX7oXSC3/NbcgqGWs5/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4UJqdU8M; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PCh2qO013769;
	Tue, 25 Jun 2024 17:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NZ8/Dz1JVrFGzmhGpmh80APktGwadeW85LFTd9FdnFM=; b=4UJqdU8M9pYc01Hr
	QQIAq4OkVUAqLFykT1l2lNV+dMFGVdGwERDhgLNdE02tEEhbl2dAHL10rkK8CzxF
	zHZlVoZ1qr+uDzsY6aXdLlDITCIPJA+2ieoEfXtIHbzfgrW2btLUrf4t0LLDYh6s
	FhyNrP8eoDkGQCuU6CEaW+h2jFIPcV/texzinKwiZ/z2ORFSBt2sB8baWQ4Qldid
	tGbPnDiokHNf2avodxXFUZRiCHPYRal17skUxBv1X+C/DLwexYYbFolrWaqF3BgY
	lurSZEXq6kFgWW4HS+0LGypVTgEgzdYQT0k4LtZmRVztRvSIg0Ej3oxd/vQxPr62
	QbvLxw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jj9ypm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:10:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5015340045;
	Tue, 25 Jun 2024 17:10:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB3952207A9;
	Tue, 25 Jun 2024 17:09:30 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:09:30 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <alsa-devel@alsa-project.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/8] dt-bindings: iio: dfsdm: move to backend framework
Date: Tue, 25 Jun 2024 17:07:12 +0200
Message-ID: <20240625150717.1038212-5-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

Change the DFSDM binding to use the new IIO backend framework,
along with the adoption of IIO generic channels.
This binding change allows to add scaling support to the DFSDM.

Keep the legacy binding as deprecated for backward compatibility.

The io-backends property is supported only in generic IIO channel
binding.

- Channel description with the generic binding (Audio and Analog):

  Properties superseded by generic properties:
    st,adc-channels: becomes "reg" property in channel node
    st,adc-channel-names: becomes "label" property in channel node
  Properties moved to channel child node:
    st,adc-channel-types: becomes st,adc-channel-type
    st,adc-channel-clk-src, st,adc-alt-channel

- Analog binding:

  DFSDM filter channel is configured as an IIO backend consumer.
  Add io-backends property in channel child nodes.

  DFSDM is no more configured as a channel consumer from SD modulator.
  Use of io-channels in DFSDM node is deprecated.

- Audio binding:

  DFSDM audio DAI is configured as a channel consumer from DFSDM filter.
  No change compare to legacy.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 157 +++++++++++++++++-
 1 file changed, 151 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
index c1b1324fa132..1802120b16b0 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
@@ -102,9 +102,11 @@ patternProperties:
         items:
           minimum: 0
           maximum: 7
+        deprecated: true
 
       st,adc-channel-names:
         description: List of single-ended channel names.
+        deprecated: true
 
       st,filter-order:
         description: |
@@ -118,6 +120,12 @@ patternProperties:
       "#io-channel-cells":
         const: 1
 
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
       st,adc-channel-types:
         description: |
           Single-ended channel input type.
@@ -128,6 +136,7 @@ patternProperties:
         items:
           enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
         $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+        deprecated: true
 
       st,adc-channel-clk-src:
         description: |
@@ -139,6 +148,7 @@ patternProperties:
         items:
           enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
         $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+        deprecated: true
 
       st,adc-alt-channel:
         description:
@@ -147,6 +157,7 @@ patternProperties:
           If not set, channel n is connected to SPI input n.
           If set, channel n is connected to SPI input n + 1.
         type: boolean
+        deprecated: true
 
       st,filter0-sync:
         description:
@@ -165,11 +176,64 @@ patternProperties:
       - compatible
       - reg
       - interrupts
-      - st,adc-channels
-      - st,adc-channel-names
       - st,filter-order
       - "#io-channel-cells"
 
+    patternProperties:
+      "^channel@([0-9]|1[0-9])$":
+        type: object
+        $ref: adc.yaml
+        description: Represents the external channels which are connected to the DFSDM.
+
+        properties:
+          reg:
+            items:
+              minimum: 0
+              maximum: 8
+
+          label:
+            description:
+              Unique name to identify which channel this is.
+
+          st,adc-channel-type:
+            description: |
+              Single-ended channel input type.
+              - "SPI_R": SPI with data on rising edge (default)
+              - "SPI_F": SPI with data on falling edge
+              - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
+              - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
+            items:
+              enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
+            $ref: /schemas/types.yaml#/definitions/string
+
+          st,adc-channel-clk-src:
+            description: |
+              Conversion clock source.
+              - "CLKIN": external SPI clock (CLKIN x)
+              - "CLKOUT": internal SPI clock (CLKOUT) (default)
+              - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
+              - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
+            items:
+              enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
+            $ref: /schemas/types.yaml#/definitions/string
+
+          st,adc-alt-channel:
+            description:
+              Must be defined if two sigma delta modulators are
+              connected on same SPI input.
+              If not set, channel n is connected to SPI input n.
+              If set, channel n is connected to SPI input n + 1.
+            type: boolean
+
+          io-backends:
+            description:
+              Used to pipe external sigma delta modulator or internal ADC backend to DFSDM channel.
+
+        required:
+          - reg
+
+        additionalProperties: false
+
     allOf:
       - if:
           properties:
@@ -199,9 +263,19 @@ patternProperties:
               description:
                 From common IIO binding. Used to pipe external sigma delta
                 modulator or internal ADC output to DFSDM channel.
+              deprecated: true
 
-          required:
-            - io-channels
+          if:
+            required:
+              - st,adc-channels
+          then:
+            required:
+              - io-channels
+
+          patternProperties:
+            "^channel@([0-9]|1[0-9])$":
+              required:
+                - io-backends
 
       - if:
           properties:
@@ -294,7 +368,77 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
+      // Example 1: Audio use case with generic binding
       dfsdm0: filter@0 {
+        compatible = "st,stm32-dfsdm-dmic";
+        reg = <0>;
+        interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dmamux1 101 0x400 0x01>;
+        dma-names = "rx";
+        #io-channel-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        st,filter-order = <5>;
+
+        channel@1 {
+          reg = <1>;
+          label = "dmic0";
+          st,adc-channel-type = "SPI_R";
+          st,adc-channel-clk-src = "CLKOUT";
+          st,adc-alt-channel;
+        };
+
+        asoc_pdm0: dfsdm-dai {
+          compatible = "st,stm32h7-dfsdm-dai";
+          #sound-dai-cells = <0>;
+          io-channels = <&dfsdm0 0>;
+        };
+      };
+
+      // Example 1: Analog use case with generic binding
+      dfsdm1: filter@1 {
+        compatible = "st,stm32-dfsdm-adc";
+        reg = <1>;
+        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dmamux1 102 0x400 0x01>;
+        dma-names = "rx";
+        st,filter-order = <1>;
+        #io-channel-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@2 {
+          reg = <2>;
+          label = "in2";
+          st,adc-channel-type = "SPI_F";
+          st,adc-channel-clk-src = "CLKOUT";
+          st,adc-alt-channel;
+          io-backends = <&sd_adc2>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          label = "in3";
+          st,adc-channel-type = "SPI_R";
+          st,adc-channel-clk-src = "CLKOUT";
+          io-backends = <&sd_adc3>;
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    dfsdm_2: dfsdm@4400d000 {
+      compatible = "st,stm32mp1-dfsdm";
+      reg = <0x4400d000 0x800>;
+      clocks = <&rcc DFSDM_K>, <&rcc ADFSDM_K>;
+      clock-names = "dfsdm", "audio";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      // Example 3: Audio use case with legacy binding
+      dfsdm0_2: filter@0 {
         compatible = "st,stm32-dfsdm-dmic";
         reg = <0>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -307,14 +451,15 @@ examples:
         st,adc-channel-clk-src = "CLKOUT";
         st,filter-order = <5>;
 
-        asoc_pdm0: dfsdm-dai {
+        asoc_pdm0_2: dfsdm-dai {
           compatible = "st,stm32h7-dfsdm-dai";
           #sound-dai-cells = <0>;
           io-channels = <&dfsdm0 0>;
         };
       };
 
-      dfsdm_pdm1: filter@1 {
+      // Example 3: Analog use case with legacy binding
+      dfsdm1_2: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         reg = <1>;
         interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1



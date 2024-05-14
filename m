Return-Path: <linux-iio+bounces-5028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90238C4CCB
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ADB1C20EFC
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C1521379;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meZFgPOA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD491EA74;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671398; cv=none; b=CvlaYwq6D9eDqUxsW0AwB76ywcgGAbJ6Lfu7+92hmUShAZuQT5ZGG/Pxr6Yl2DtRseTqMUX+l6QNkk8nqpI5Pz/rhnlHGe4nrD2E5p7tfqi+aST0C4z6xtSEkV6kFMLPiq38mKKiYzQod0KqV4sSyFSgxpePpZ/7Bdrqax6McCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671398; c=relaxed/simple;
	bh=zaEJEqFp1Ws1CHROri/uabDM4S3ACnpXdJ0xP0CAMnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrsszuRR6AwlD2gIw34RDYgi9rKFe0bLYlZT0kaGfgKmfofpxcRVdYz1KstPK4LNOBN6zSNUPlWy2SdkV5GDso3/62JOOC8GJWstf3ASobDPMn2R0qQnEj2426s+4WBmtDNFtr+mrFv/DwHH3lider6rHF1dfSRh2nFqG5Xac3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meZFgPOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48622C4AF09;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=zaEJEqFp1Ws1CHROri/uabDM4S3ACnpXdJ0xP0CAMnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=meZFgPOAADuZyGNstP9SRDxwPbJCVNEL1Lt0co9KqYCBdDRHgbghkKbofTgRSEjpL
	 xBJWRhjMAeCmyxD0Rw5x6pTjYjVNbzQv4RzFazgr8GjCmZT6+AsNQ2dQt5pJZyrYdo
	 6KVECJ9EsssN44oUCL/rpDY+OExm/q1pbAL8izVszAvE0Rq6LWkGqAe9S43+s5miZX
	 dTrPFIUlgSpycdT7mSQ0qU9g+41vsaEZuPGOHB9lS26FRcGiw/sumcBtlH/b1k/JdV
	 yZuHIkG78syNDWcdGXuR1kIPcNRAIe1Jr1wzTVRMsBJquViQwqEmHPDYn+tdTb9+oD
	 +kvJkXQ5SkbiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B4DC04FFE;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:46 +0300
Subject: [PATCH v2 1/9] dt-bindings: adc: ad7173: add support for ad411x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-ad4111-v2-1-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=5913;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=D2kwAYDDqOjxW1jwARY/uw+7u4SlV0m6+b3TljLBV/M=;
 b=DvnhQwFQvdFqNeAF+913RDvnGxdhQALvKafmoUHAtdZziFBpNfELCw9tRRCpCJzt58BmlEV6/
 LrLPKdM+jC6CFpDuoL29qNEyjuMofF0P1OJb8muPQNPveD2q6XxqN9k
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.

AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
AD4111/AD4112 support current channels, usage is implemented by
 specifying channel reg values bigger than 15.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 118 ++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index ea6cfcd0aff4..6cc3514f5ed8 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -19,7 +19,18 @@ description: |
   primarily for measurement of signals close to DC but also delivers
   outstanding performance with input bandwidths out to ~10kHz.
 
+  Analog Devices AD411x ADC's:
+  The AD411X family encompasses a series of low power, low noise, 24-bit,
+  sigma-delta analog-to-digital converters that offer a versatile range of
+  specifications. They integrate an analog front end suitable for processing
+  fully differential/single-ended and bipolar voltage inputs.
+
   Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
@@ -31,6 +42,11 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad4111
+      - adi,ad4112
+      - adi,ad4114
+      - adi,ad4115
+      - adi,ad4116
       - adi,ad7172-2
       - adi,ad7172-4
       - adi,ad7173-8
@@ -129,6 +145,31 @@ patternProperties:
         maximum: 15
 
       diff-channels:
+        description: |
+          For using current channels specify select the current inputs
+           and enable the adi,current-channel property.
+
+          Family AD411x supports a dedicated VCOM voltage input.
+          To select it set the second channel to 16.
+            (VIN2, VCOM) -> diff-channels = <2 16>
+
+          There are special values that can be selected besides the voltage
+          analog inputs:
+            21: REF+
+            22: REF−
+          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
+            19: ((AVDD1 − AVSS)/5)+
+            20: ((AVDD1 − AVSS)/5)−
+          Supported only by AD4111, AD4112:
+            12: IIN3+
+            11: IIN3−
+            13: IIN2+
+            10: IIN2−
+            14: IIN1+
+             9: IIN1−
+            15: IIN0+
+             8: IIN0−
+
         items:
           minimum: 0
           maximum: 31
@@ -154,6 +195,23 @@ patternProperties:
           - avdd
         default: refout-avss
 
+      adi,current-channel:
+        description: |
+          Signal that the selected inputs are current channels.
+          Only available on AD4111 and AD4112.
+        type: boolean
+
+      adi,channel-type:
+        description:
+          Used to differentiate between different channel types as the device
+           register configurations are the same for all usage types.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - single-ended
+          - pseudo-differential
+          - differential
+        default: differential
+
     required:
       - reg
       - diff-channels
@@ -166,7 +224,6 @@ allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
-  # Other models have [0-3] channel registers
   - if:
       properties:
         compatible:
@@ -187,6 +244,37 @@ allOf:
                 - vref
                 - refout-avss
                 - avdd
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4114
+              - adi,ad4115
+              - adi,ad4116
+              - adi,ad7173-8
+              - adi,ad7175-8
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            reg:
+              maximum: 15
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7172-2
+              - adi,ad7175-2
+              - adi,ad7176-2
+              - adi,ad7177-2
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
             reg:
               maximum: 3
 
@@ -210,6 +298,34 @@ allOf:
           required:
             - adi,reference-select
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4111
+              - adi,ad4112
+              - adi,ad4114
+              - adi,ad4115
+              - adi,ad4116
+    then:
+      properties:
+        avdd2-supply: false
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,ad4111
+                - adi,ad4112
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,current-channel: false
+
   - if:
       anyOf:
         - required: [clock-names]

-- 
2.43.0




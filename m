Return-Path: <linux-iio+bounces-10681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E49A2026
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 12:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6730D1C249B0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF2D1DACAA;
	Thu, 17 Oct 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4bhryMC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A41D270B;
	Thu, 17 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161489; cv=none; b=eHr2vDGZNgyO6dB9uBNOahJOPaAzPTDkk8xPBQiRjZ3jueeFjf3lgTFP4es6bzjWxxbdTxQJVv79B2iNjcEF8DFVYMJGWhLphLjbdUw9i1zWBYNRaytJavCrcXGpw+fdsoIBxM72IRCqdLcOPhx2B1gxJ3t6GQbLNJQzob9VFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161489; c=relaxed/simple;
	bh=N2euFngJxSATLtEd1gk9xVj5LrqAKqRPTsHiiP8bK4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7EC6cxaawytFWahnZgdJYCIu2kEFFA2J5EKkTZ+RpdpSvv2KRgxxtkeTdYNogPcW4JF0d6u1oKxfQlBODgEC1IftbJ1oScWeq2+zsdzhq1RInYqr7RQ72EdzfufZzoz7RavlraiuBYAYQEaj61im10gXR8fqYRaNZxYxdSwmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4bhryMC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cafd36ed0so499705ad.3;
        Thu, 17 Oct 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729161487; x=1729766287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRpe7+vlo4mItbiWbHypDvhOSwkwoSf/8TTasmXOfh0=;
        b=i4bhryMC177PrexcbdYWRwaZGlqYfHDh33HqJAEUUZGAIUAP+nbcYvUTsHxXt6Rq+7
         pqiyZG/sRZF4YBmQkXKcpRl6ZyNtzTAwCexMW1JoEtcVS0Hfju9hWVwCij6/zKNWwZV0
         iJ35LYrDkSeCfgcr+6YH0M7kk+W1lR2j1/2QOWf+Mp+APu6OSwf/3lzin0xGdSPmms9F
         nOK9aBZD8A+Cfo5xvuw39+IhoKQGJyhKR3aB1VA2WHNO5Ln38IDBUNHNiJjKW5d1x0yB
         RX3ua0FpDVYNr7Mnw5QVm6WVmJLK90o15j6Nnj51Sl4wErPAyjLjAjbscE8tZsGwnfl+
         h1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729161487; x=1729766287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRpe7+vlo4mItbiWbHypDvhOSwkwoSf/8TTasmXOfh0=;
        b=SyYXWiH27ePULyqAPDiXHSaNzCczgAag8+GR5vzgAYIBWL/A8Rlrc/MVWxK3pGdZjl
         MOLL1TC8BdgcsZ5S+AicMP4MLj9LhSkf74t9gOZ6tQJhhxKImCAIHkp0UbwopxWeq2hE
         W5bFAWNsIHJ/gIy6ZEZ3hEZMcUMig+llFbfcLv3tRnvVQBFroNuusuwHc6xNEmvNMZZn
         0YwNiCgMLpN35MT5gNvxP128bVDQr7sv4pgp7l2urKyczwgtyNvgYoc30gyjCJ2wVVHI
         g3bQ59YmiQOcQLjsIXwqoFGspCIPCAMj6XK3iUEVF90ikukAfNh06lE0xRTCzBbp47U5
         4yYA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ayQIFoz2w9Ob9vlkYCqMS7jTM9ukjAlj0zERmkHIiBelWUyxgdITO4EeSTU2vziRBOinY5ZA104N@vger.kernel.org, AJvYcCXTQR3KDOMl+CYTB0IbUTTlXcAfgiBLs0T9eflLnrz4gtAnwtLluumkUE3ilKHCTxQi9KI6WfP9HYfndCzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwEZCQP2pKn9i7DesiVIi35IAXiC1/JGnmtNCf23pb0uaUfzm
	6Xyyf0DMlQ4M4ofSvzhr3MkgYPGnMnsQTETkfoJPuA+uDFXDGGvt
X-Google-Smtp-Source: AGHT+IFyxBVZYfW4nDKHl+At+1Io4C+ZSSAB5nQBOT29caRs+P5+Tf1jJzse3Kg76dQ4jkocBKzPbQ==
X-Received: by 2002:a17:902:c94d:b0:20c:5da8:47b8 with SMTP id d9443c01a7336-20d2fd43e1emr35416995ad.5.1729161487394;
        Thu, 17 Oct 2024 03:38:07 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d51esm41899025ad.104.2024.10.17.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:38:06 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 17 Oct 2024 18:36:44 +0800
Subject: [PATCH v3 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
In-Reply-To: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6303; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=N2euFngJxSATLtEd1gk9xVj5LrqAKqRPTsHiiP8bK4s=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDOkCL1kPbHLOEljXWZrw/9uG5mKZDfFtWmvX3m88s/Nr0
 4nZ8lWnOkpZGAQ5GGTFFFnOvH7Dmq/6cE/wb9cMmDmsTCBDGLg4BWAicgUM/2NU5on13z1wIWCr
 u2/6v6T8gA1bTocLe8Yf7baU23ZYJ4aRYfO2ObmfUvQ/GrKkNHV3xer+zPxV+f59apWQmv3F2Yf
 lNwMA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 195 +++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..af419a3335eb 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,189 @@ properties:
 
   vdd-supply: true
 
+  tyhx,dither:
+    description: Enable spread spectrum function.
+    type: boolean
+
+  tyhx,chop:
+    description: Enable chop function.
+    type: boolean
+
+  tyhx,odr:
+    description: |
+      Defines the sensor scanning period. The values range from 0x00 to 0x1F,
+      corresponding to the following periods.
+      Val: Period
+      0x00: Min (no idle time)
+      0x01: 2 ms
+      0x02: 4 ms
+      0x03: 6 ms
+      0x04: 8 ms
+      0x05: 10 ms
+      0x06: 14 ms
+      0x07: 18 ms
+      0x08: 22 ms
+      0x09: 26 ms
+      0x0A: 30 ms
+      0x0B: 34 ms
+      0x0C: 38 ms
+      0x0D: 42 ms
+      0x0E: 46 ms
+      0x0F: 50 ms
+      0x10: 56 ms
+      0x11: 62 ms
+      0x12: 68 ms
+      0x13: 74 ms
+      0x14: 80 ms
+      0x15: 90 ms
+      0x16: 100 ms
+      0x17: 200 ms
+      0x18: 300 ms
+      0x19: 400 ms
+      0x1A: 600 ms
+      0x1B: 800 ms
+      0x1C: 1000 ms
+      0x1D: 2000 ms
+      0x1E: 3000 ms
+      0x1F: 4000 ms
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x00
+    maximum: 0x1F
+
+  tyhx,range:
+    description: |
+      Defines the full-scale range for each channel.
+      The values correspond to the following full-scale ranges.
+      Val: Full Scale
+      0x0: 1.25pF
+      0x1: 2.5pF
+      0x2: 3.75pF
+      0x3: 5pF
+      0x4: 0.625pF
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,avg:
+    description: |
+      Defines the ADC averaging value for each channel.
+      The values correspond to the following averages.
+      Val: Avg Number
+      0x0: 1
+      0x1: 2
+      0x2: 4
+      0x3: 8
+      0x4: 16
+      0x5: 32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,osr:
+    description: |
+      Defines the ADC oversampling rate (OSR) for each channel.
+      The values correspond to the following OSR.
+      Val: OSR
+      0x0: 16
+      0x1: 32
+      0x2: 64
+      0x3: 128
+      0x4: 256
+      0x5: 512
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,sample-num:
+    description: |
+      Defines the ADC sample frequency.
+      The sample frequency can be calculated with the following formula:
+      Fsample = 1.0 / ( sample_num * 200ns ),
+      where `sample_num` is the value in the register in decimal.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x00
+    maximum: 0xFF
+
+  tyhx,integration-num:
+    description: The integration number should be the same as the `sample-num` above.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x00
+    maximum: 0xFF
+
+  tyhx,lp-alpha:
+    description: |
+      Defines the coefficient for the first-order low pass filter for each channel.
+      The values correspond to the following coefficients.
+      Val: Coefficient
+      0x0: 1
+      0x1: 1/2
+      0x2: 1/4
+      0x3: 1/8
+      0x4: 1/16
+      0x5: 1/32
+      0x6: 1/64
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,bl-up-alpha:
+    description: |
+      Defines the up coefficient of the first-order low pass filter for each channel.
+      The values correspond to the following coefficients.
+      Val: Coefficient
+      0x0: 0
+      0x1: 1
+      0x2: 1/2
+      0x3: 1/4
+      0x4: 1/8
+      0x5: 1/16
+      0x6: 1/32
+      0x7: 1/64
+      0x8: 1/128
+      0x9: 1/256
+      0xA: 1/512
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,bl-down-alpha:
+    description: |
+      Defines the down coefficient of the first-order low pass filter for each channel.
+      The values correspond to the following coefficients.
+      Val: Coefficient
+      0x0: 0
+      0x1: 1
+      0x2: 1/2
+      0x3: 1/4
+      0x4: 1/8
+      0x5: 1/16
+      0x6: 1/32
+      0x7: 1/64
+      0x8: 1/128
+      0x9: 1/256
+      0xA: 1/512
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  tyhx,drdy-interrupt:
+    description: Enable the interrupt function of each channel when the conversion is ready.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x00
+    maximum: 0x1F
+
+  tyhx,int-high-num:
+    description: Defines the Proximity persistency number (Near).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x1
+    maximum: 0xF
+
+  tyhx,int-low-num:
+    description: Defines the Proximity persistency number (Far).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x1
+    maximum: 0xF
+
   "#address-cells":
     const: 1
 
@@ -65,6 +248,18 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        tyhx,odr = <0x17>;
+        tyhx,range = <0x4 0x4 0x4 0x4 0x4>;
+        tyhx,avg = <0x3 0x3 0x3 0x0 0x0>;
+        tyhx,osr = <0x4 0x4 0x4 0x0 0x0>;
+        tyhx,sample-num = <0x65>;
+        tyhx,integration-num = <0x65>;
+        tyhx,lp-alpha = <0x2 0x2 0x2 0x2 0x2>;
+        tyhx,bl-up-alpha = <0x8 0x8 0x8 0x8 0x8>;
+        tyhx,bl-down-alpha = <0x1 0x1 0x1 0x1 0x1>;
+        tyhx,drdy-interrupt = <0x1F>;
+        tyhx,int-high-num = <0x1>;
+        tyhx,int-low-num = <0x1>;
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0



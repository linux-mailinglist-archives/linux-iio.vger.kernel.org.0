Return-Path: <linux-iio+bounces-7660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B618C9343CC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81DC1C21D19
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37402188CB8;
	Wed, 17 Jul 2024 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYQlx+GM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972B18757C;
	Wed, 17 Jul 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251557; cv=none; b=FCoFUuvT2xStQl/1FQSmN0hSEoxf62VsNrkq63xk4DfA3zPNySZwpeDvrRJ+dP8Ka5Lr735U0cI0lVw0UJBTWk1srWwTgjpTBGHQ/TUYPfJCtmzaVnLGk+4bjiHTzd8MFpOdobfhcg2Gmozsc2ODhOIvjljTSQunLU81AEIx2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251557; c=relaxed/simple;
	bh=MwH4ZbeVtJDn9nLY/Lcp4DnUPzjHuUxaI30Mjp+RPm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quylNe0Rc500RSD5WTy2Bf4kGs+lCPxxNqF84W9+mdebUiLbqfAFmX604XjD5VA1ErJv6TMUWBQaNcfpXxFM4yRI6MMjkjcOy0Kuc1+PRJYrTqzQV7oxay6J3PnwuxB/5hEhSTRMcVPLeW9lORMQW+gQ3Xgr7xMry69xvzRsZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYQlx+GM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso879195e9.1;
        Wed, 17 Jul 2024 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251554; x=1721856354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og7z13DastBZEYSjicgLUwM+3MEwA4uV60q45Xpmo0A=;
        b=AYQlx+GME3dBME2ldMRWQtfJ6tJvsBhyigyZwnCBMZ/WeOb5mseo336WZKfkLlETU8
         oNYxWMwmtnmdfy3pb3F4SStHJjpmuXdUwYrsyvv3kwyJMfC/9ExgerInPRyUrwB34neZ
         yfNwRWwEMpOfp7Y0rfAs3e1g2i/fwoIYJMBnlTXozVhpKoUQ+NQ1Xl0Tfsx/QSPr2wz9
         ywCdNOX+fbCvUm8FNNPtjMRUTiYwj4Y3oEugfSy50UzUt1KVivWOopqXYcgRDzI30QwQ
         3pZLMWVJamVP1loF+Um8Ey+nisImnuG0N/YMWWLoxbVF5PSwFCnPqqdAXN6mv8K8zf9X
         EwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251554; x=1721856354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og7z13DastBZEYSjicgLUwM+3MEwA4uV60q45Xpmo0A=;
        b=U723McabCSc/8vixmFVMmTR3FGaOSTpap9q6IX6dKX1APeDOQ7410cAYltvvng7/Yd
         On5a8voxar3/59KJ15IFZwc2X0hCYQQe0iAeUBr7KOnKAkUY55pkgAkI7FCPSw7U4o4J
         Sk6LcjzuP7vBqGIm8KvJmP2sOuhGkkgOZ3061tV8m68J3bAZNtYIKia43o7YRRxfrnyq
         iEK3IrKL1esgvk39abrLBcsyX0TaPLSletDQhVz1AzoLhLlr4o3xp5T7ecBzQrI01J0E
         GElvQFfBIdRMys7WV3nJpRrX3B0q/mTZltp/Dx0d9+/tAYlzB+Jqwc5PCeh+DdRG/yb4
         Cs6A==
X-Forwarded-Encrypted: i=1; AJvYcCUNJisQaMrGBIsHm1y8qhzdaqJsOKSCNobyVRrzmyOaT54rTjw+wAYnWkc17NpFU0PRDIyGx9L2zUsx/tnBE5e/9+OMvYz71wd12+lfwz8n6KEmpzIPWBsI05fXNQ3s30Izq03nw+nlBerLPeAsXj45Sp+WmpJAsILWZDZ99aWWHdu0hQ==
X-Gm-Message-State: AOJu0Yw3k4wLFaw9xHKcEAjL4DdVFSq8pn4ydd8Sw5jk2b/ZN2xEWJ4K
	v2CuTOZ5ZRygbDCqxH998VFlxjeUs8Obp/LwPJbboA9L0SgBwbAE
X-Google-Smtp-Source: AGHT+IFKkECmiZpqOalMmBkaR4AregsEXjfqJf+QJIIDLYKT32z681Qa7rZcKRcb40nV21PAaSloFw==
X-Received: by 2002:a05:600c:19cc:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-427c2d2d8fbmr21819195e9.25.1721251553808;
        Wed, 17 Jul 2024 14:25:53 -0700 (PDT)
Received: from spiri.. ([86.124.123.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b030bsm10532735e9.17.2024.07.17.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:25:53 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/4] dt-bindings: iio: adc: ad7192: Update clock config
Date: Thu, 18 Jul 2024 00:25:32 +0300
Message-Id: <20240717212535.8348-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717212535.8348-1-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock.

To configure external clock as either a crystal or a CMOS-compatible
clock, changing the register settings is necessary. Therefore, add clock
name xtal alongside mclk. By selecting one or the other, the register is
configured.

The presence of an external clock source is optional, not required. When
both clocks and clock-names properties are present, an external clock
source is used. If the intention is to use the internal clock, both
properties should be absent. Modify required properties accordingly.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index a03da9489ed9..c3adc32684cf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -39,11 +39,15 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description:
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
 
   clock-names:
-    items:
-      - const: mclk
+    enum:
+      - xtal
+      - mclk
 
   interrupts:
     maxItems: 1
@@ -135,8 +139,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
   - dvdd-supply
   - avdd-supply
@@ -157,6 +159,16 @@ allOf:
     then:
       patternProperties:
         "^channel@[0-9a-f]+$": false
+  - if:
+      anyOf:
+        - required:
+            - clocks
+        - required:
+            - clock-names
+    then:
+      required:
+        - clocks
+        - clock-names
 
 unevaluatedProperties: false
 
-- 
2.34.1



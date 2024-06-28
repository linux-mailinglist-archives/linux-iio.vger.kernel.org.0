Return-Path: <linux-iio+bounces-7010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395091C18F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139DB1F26AA7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0391C230B;
	Fri, 28 Jun 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dpm+Tdhk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4A1C2319
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586125; cv=none; b=OmEJ+WtdRc+Qn5XYD4ZdiBDL43hjBNwX92hBMzzaJ9KG4RueoJhdwDQXOV4YRotbGzK/10JUC4qlS4AvHHhLpIdJO5PdsW4q3IrfW2Mas9L4IwE6t+jOP660eGTofOZhT0ITaMsz4xVdBbSxJyQhMuEQOWSL/6zA1XhhkyDUavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586125; c=relaxed/simple;
	bh=6NkavYCS9KssnXRdhzuSjUIoOcS1DExNH94R1nY2LM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgKwXB3U19TR9mfPtvETvCAO/7dnoNI06ikYccS0TZMNQHtTBkbzNBpNxMFV2FRmFTZzA0+xh/qlGtCDZU2T7a1lIaA2+crMhzaLWN/EFyk3NE7fsgizm9LF6ZKnUIlkGD0x5/XiQ8Wv9fV225Uvro/x3TELTTCMYu3O9HT60AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dpm+Tdhk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42563a9fa58so5390205e9.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586122; x=1720190922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMkuNs3gcVUwYniv00+omCdhvDWOdn0nkqiQ69iJTAQ=;
        b=Dpm+TdhkkAcNb1Epwv7L6B827Q5BMjzBqr8tcnLtjiG8F0df1eGrijZfC2WlSNZ0VI
         gj6SfEyP0AL/0oTVWy59qwd96CFuoUKB3iggjrDIWDaU+zHXinnTfjuO6MsTNzNfMHdZ
         GjNTw3Q/Ug2jju3bXoVaVbdXFRCyLiNOD2BMZcFdUmuggjuDsKxW37KCvI0Sy2bavmHc
         BMUE57oRLMH05a8uHD2hCdlcOgkd7/WsIQdfSKKwnPVMq5KxTXfUF3RRCZiQ3FtYhWaO
         oKr8eJ1vycOuWWDiPpmRaQnAJOIlj/ZRh8dCbyD60QXZ5XvHk2FscT/Cilw8ExbvybJ/
         sy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586122; x=1720190922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMkuNs3gcVUwYniv00+omCdhvDWOdn0nkqiQ69iJTAQ=;
        b=LXvuVZCE5XSRilaCBIlaRK3AnEVhWZNeqCHXeBPYgnGI58wZKl4Jkuu8VJ0MkMkOFx
         YTssOoYx8vZ5EAuJKOy3lvDzFGnmWt22nRkcv4IQAgBRY02txlZZ6fBSfGpv7dczLGS8
         lhOf38/YJT9ZSQPeu02uo+BvzPrhQkceOBPJUsogC9D90rmixrecUP1dwc3GW5UV0FZ/
         qTZXq+364QtYk78RqPfoaFnU0ErppJd60UKDsEYvzUAyBTLx83ILlOjra3Zo9Bh9/iTO
         o/cfjqltuyaqR7VUb1w7qzTg4/QEPdgyw4NfGd/ex+hFDAPPm0xPQQ2CCh+CLJq4ZpMr
         bl3w==
X-Gm-Message-State: AOJu0YwyoqIu0Tru1NDPeLxfvTUP12sO0rHUp5NGuHz7HmiTWhuTamru
	3Pvswj7lYfK3NMrKcTH6UrRSAcuaAlAv5/FY+YtbbEcPOXeEln7xMPWsIy47fpo=
X-Google-Smtp-Source: AGHT+IGv7t12CAtqBhXhRtWXm5NI4VGvGPgv75bfLG43FiWdKz+JsYKTuXkHFmGZ6kYlz0q3drnk4A==
X-Received: by 2002:a05:600c:1c8f:b0:425:5eff:7182 with SMTP id 5b1f17b1804b1-4255eff7411mr52274695e9.31.1719586121796;
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:25 +0000
Subject: [PATCH v2 07/10] dt-bindings: iio: adc: adi,ad7606: add conditions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Since the driver supports several parts that present differences in
their layout and behaviour, it is necessary to describe the differences
from one chip to another.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 60 +++++++++++++++++++---
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 626782ea00b3..f825a2c19a06 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -52,10 +52,11 @@ properties:
 
   adi,conversion-start-gpios:
     description:
-      Must be the device tree identifier of the CONVST pin. This logic input is
-      used to initiate conversions on the analog input channels. As the line is
-      active high, it should be marked GPIO_ACTIVE_HIGH.
-    maxItems: 1
+      Must be the device tree identifier of the CONVST pin(s). This logic input
+      is used to initiate conversions on the analog input channels. As the line
+      is active high, it should be marked GPIO_ACTIVE_HIGH.
+    minItems: 1
+    maxItems: 2
 
   reset-gpios:
     description:
@@ -88,8 +89,11 @@ properties:
       is tied to a logic high, the analog input range is ±10V for all channels.
       On the AD760X, if this pin is tied to a logic low, the analog input range
       is ±5V for all channels. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
-    maxItems: 1
+      GPIO_ACTIVE_HIGH. On the AD7616, there are 2 pins, and if the 2 pins are
+      tied to a logic high, software mode is enabled, otherwise one of the 3
+      possible range values is selected.
+    minItems: 1
+    maxItems: 2
 
   adi,oversampling-ratio-gpios:
     description:
@@ -123,6 +127,50 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7616
+    then:
+      properties:
+        adi,first-data-gpios: false
+        standby-gpios: false
+        adi,range-gpios:
+          maxItems: 2
+    else:
+      properties:
+        adi,range-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7616
+    then:
+      properties:
+        adi,oversampling-ratio-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+    then:
+      properties:
+        adi,sw-mode: false
+    else:
+      properties:
+        adi,conversion-start-gpios:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1



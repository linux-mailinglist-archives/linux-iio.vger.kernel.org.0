Return-Path: <linux-iio+bounces-27243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04CCD1FE7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A092304D885
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615034A3B5;
	Fri, 19 Dec 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ClUwTzIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76E3446C9
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180021; cv=none; b=tmeRqR9MkOgaqBCHLCTC9bxM92XaHuBIT+QJZ2CKnfCz53AOyUf8T93pO+Cv5Ztx7nS+zrIYQwugh1AwdRRpfFxJtaMlHBmPd9AuEg7zX7R3YhJHT5iVbigMqcjZd6ONvZ+qDhufzMkhG9feynrSbpP6vCSPmvRwGIiVNeAJf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180021; c=relaxed/simple;
	bh=VQOPaqQmoNwtfxLbCSXG6BhStJUeMtFzJ0prIuJB4JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgxXLBI6WyXzjJn/GWU68c8nu+MJVouQTJucmKXYhsw3NshKsOTVFzM0/xxpvY6aX4Tc0pMLPflMweHgQR6yhYT6ULkSfJnVK5/qjnI3VJkDgY/hUaa+e5L5aKRneCBdYu2P9QAFhUZQmvp+VX80Af//OdbsTmdeTZFOOvVSBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ClUwTzIv; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7613db390so1315776a34.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180016; x=1766784816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQ9bA5wAd5cOLSdkvDwsJ4KZGTUhg22dy+q+3KzYnqw=;
        b=ClUwTzIv7D5PMbxN5U2hCpoVmQmiheLK+Ejx49ksbUV4lrOdVCjjAKSIT8+IHQyPup
         DRc/RNMyPy+F7GWPXZp0G27Ln1n8gdnJT2F7mUfmaeUZx7jSG90FIYeyYzGuyptEKiZU
         xAg3NajpQ1u1NrfvwxoouNCJuxsMyYsn/gCdO20tP5DGSdemiv27clgl6bXv7gPpFbUq
         qoVPyJunXV88TM6awOyQ5WZUKS22Jt8J3BDVyNcI+gNzR//ihSkHqw76NDWQshYj8HZC
         xJnee4+DRXmrw93yFkX4VV3+AIxtbLgDZTk/tADKOz3TLOxL2l8lhjcXyqHvjPfeiNwl
         GPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180016; x=1766784816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQ9bA5wAd5cOLSdkvDwsJ4KZGTUhg22dy+q+3KzYnqw=;
        b=nO/yvZgUGlsJ7rDxyZGhFeNeXxRCThMWbOp+k+CUVFcPobFMt+Gx04yaK2nDNh7uId
         5npysDvnPXtbjaIyCfhmuFuOohKbkzxVsSn94UIvuc68l46Lek9L1zdj3OuYB//xPooC
         KpKdF6e+upXouYixB9r6ukNvTwXhjqOZuP6BJ21D/zMvl53QbrSqZ1thj/xjxG039Q1y
         WjyekQn7qUwM9xPcJpk/IFqdDb7v4dJDJtdsJXhEsqhJn57Du8Rxj3L4AhW08VDBs5t0
         Y7zGDLwGnHJscKf37VEKW5iV0ZPffkIHSPfycd0mECocUUgXpUu3J8j1rA/M5wBLK/hr
         DXVA==
X-Forwarded-Encrypted: i=1; AJvYcCURbs2rDWGhA0o/OehnwJq5BQ/uVYbuQTP3M64SgwseKvkcQdjyv6jsX0GCso4VtYXXRH3yiOz13Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LErDvrz6LiLr91K5EIBuvOXDnDOYRo/WKezwOjrvHvycQ6MN
	myWuKw9mdB8T9/fgcqCFSVrDReDSSGoFrwROgkciTsGtDi3HgDTT7cSfbcU44KZzIgM=
X-Gm-Gg: AY/fxX7TGCqh0iYXw+70+W4mFMuZloxvUrCxh847rXO7SRxSXFFfDBd1QmeI6GEJQaf
	n7D+ogzsgrRpozElMVQA8/brYPWgMW3twticP2PkwSP8qQWqbl99O3GwRHuuijnNfSZioIj9kyy
	35xaP+hSfg+WwNiNNe5Vytn5YA5G6lk09DLYdwGNwNetXn1IxY+Ql2mP03C3ClLW7Cdyw0SIcmq
	SoxkiI+zYf6JY4WXiNtzzI8lk8B729pNcmYT2X5NVnj8S7WQxsgy4R2VzCptOfCRs6edib4GViC
	RZrVRHqUXixyfRp987l57SypJMV1OC8Mcq1ATsJ3i4qnQtYF7oo+MnZUY99soqVp+6kvRMH1Prq
	1gOI/pTvx6t09vwL5fNHq7OjA1VnxH/gnegdBZ5Uuq4ym8QDcoZ2+UOFm7FSm7aRtVmj495F4MT
	U8InIFQfmQNMW4Zw==
X-Google-Smtp-Source: AGHT+IHGyipb98La7XJE4vZ3dHFAmyXLQw9XZJ4q2W59l2gO7JhuowVl43/w0hKUEnQvJoe8SceFQQ==
X-Received: by 2002:a05:6830:43a4:b0:7c7:6da2:6d67 with SMTP id 46e09a7af769-7cc6689d9a3mr2725997a34.3.1766180016063;
        Fri, 19 Dec 2025 13:33:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:16 -0600
Subject: [PATCH v4 8/9] dt-bindings: iio: adc: adi,ad7380: add
 spi-rx-bus-width property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-8-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VQOPaqQmoNwtfxLbCSXG6BhStJUeMtFzJ0prIuJB4JY=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJdj8x4ylQ589TTfacs62zckqz2Ftiw2V77mJYWu/bgq
 w/+tYsyOhmNWRgYuRhkxRRZ3kjcnJfE13xtzo2MGTCDWJlApjBwcQrARJLt2f8nbY/dJ2r7o6ss
 aqLRboWsvRb9e99U77iS53ubY6mUBEOPqVcD02a3roS3N24zbC+ujhMqz5Jh/MkjxiJtcfnHlMk
 zTOdLLM6qrZzkWxf4b/7TiybBBQnTNrrILXS64F8a21++6a3oztkttS/P/PJa9mmt3ZJ7go9YGK
 QVH94TKUhMU21pEvn486BYRmiamG8kC/MrkZNrG34mu8/cmdIjn9nhFxlsvYL3yaz8pgk1N60zY
 ybYTUq7ZKXyVyug/ORLXquoxnCWU45HtvyU9NpcrtZutTmYpzHfwDhxwaWc/KrX8828t6Q+6d7x
 v+xx81Xus4eS252a1PkYrZYU7GRx23vIbk+pn92SNOXlAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-rx-bus-width property to describe how many SDO lines are wired
up on the ADC. These chips are simultaneous sampling ADCs and have one
SDO line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
* Change to use spi-rx-bus-width property instead of spi-lanes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6b..396e1a1aa805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,11 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-rx-bus-width:
+    maxItems: 4
+    items:
+      maximum: 1
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -160,6 +165,23 @@ patternProperties:
 unevaluatedProperties: false
 
 allOf:
+  # 2-channel chips only have two SDO lines
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7383
+            - adi,ad7384
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 2
+
   # pseudo-differential chips require common mode voltage supplies,
   # true differential chips don't use them
   - if:
@@ -284,6 +306,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0



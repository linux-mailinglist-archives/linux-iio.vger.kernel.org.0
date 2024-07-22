Return-Path: <linux-iio+bounces-7809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04493962F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AD61F21DBC
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A612C486;
	Mon, 22 Jul 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R/lL7+jc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DC6DD0D
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685696; cv=none; b=k8DaNLCAh+MapjSpH+fqc8QWiiiIQiuR7FJFn0FpYwyIdfwtKOOtsoC5tJ8Xl1hFXGtHh5mVyJcaSVicLK1pIfEOTtIBrI5jsbpXR5+afxQI3sbeoYN5K4cK9a7RG86a3dt06Fn30vr8UgJcibi8gd9qv4EqCgECfOsYnZy2YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685696; c=relaxed/simple;
	bh=ozoXhi7TZ5bg/WgwHNio76mZ8ob0TDKqwt97BXyhuUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx22pv95zPzOJcf8AvhhNrtyaKjHW9CsJFhk05yylXk2ysEk771NCDbZ+kO4t1RLNfvjXUr4WAVG9ZzEtx7JYukdV965Mzb8vaHOHi1H4EMKsFQ17CkU2NtthQUrhG7px8P+Pv+Si1ZqVrnzGF4NWgfZ5HSOfmMJxOsglsOSDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R/lL7+jc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-703ba2477bdso2237520a34.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685693; x=1722290493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbV2uifrWqiRQxhBCL8VB9LMdHewgwxJIKx2N6g6zvQ=;
        b=R/lL7+jcHaeV1mQQUNOhKAS5gl5OkVbk3qGw8/8HAKX6J4Q3sk8eQ3sUyp4FbTP8NC
         RnB3YAqK0DxJY5f4lKaI7fCnIj6aGKSlPRkqbUo3pMcpiUE3tbKAHi8FO+sRAniG29FC
         RzxocsvmlPUJvJzhU3qNW1baPuEoOfaXV1xACMd81fxXMcDo04Qq3NUuR0REwVRJe9qi
         TNzuvTevOd6bjtEeWTufiDI+PqRCXVvUxw26EvtWpURGgNzN+2dJOMitdCrxjt95uVny
         NvRTIO2pmue73UCWJORf30jxXDvsJ9XluqhGn39Z/yoQ09o6FpyUdz66iHhO6uQ0l60L
         r5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685693; x=1722290493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbV2uifrWqiRQxhBCL8VB9LMdHewgwxJIKx2N6g6zvQ=;
        b=qJgcaNYvtMl5EVKY3g8zwtPeNPTOXG4SMxtqHSfy7J0sODONqQiij7FEsj8wII9Llj
         zIUSqA7He7TOoqcP/R5+GAjfx15a0MXA4oZlxJBLaViJwYh924BxglLosZVoeVaAWhzt
         powhD7Sv7YHa0SIOwJ/7ujOraU/CNuarE4zPPoVAU5tCNMXMKfKafpO6Soushbf69Qw3
         dgrQps8gRJXDr5wKP6o/KaSvSqnKe9yqeyZsJLK0Sil8ROuqt8ZZyfJScO3qjPPDs9TQ
         K2n8vE6f7Iddq+dvPoVNX6RKYedsaZ/Lip68FLtK7KCCtCDBMnb/b1LJyG3rUpqBlPv1
         yzgg==
X-Forwarded-Encrypted: i=1; AJvYcCUUPIcDZ/0/F77h0Pm7vrxOKnU5c57kFCxLabTPWfeA47FIJX8armlPwawe1wKRzfUOKMApYjgLJYW1XUTJEak6gO/f96a+R+J5
X-Gm-Message-State: AOJu0Yz3V7D6DX4kkm5KohXV534BXZd8TEyGuXqF9rQF31NW8lBk49Oy
	o9/xmSXav9Beserrk8p0QGwuHFQAU/++f7WHPDIUt+7Noe0vjhPnRKZRAGTRxCI=
X-Google-Smtp-Source: AGHT+IGH4XrwdDU/5ZEcf8oBMum+Z6kRT3nANYPvUw3shGgmVjb0HG2TfD+RuB8Rpn5TQQUo/epIsw==
X-Received: by 2002:a05:6830:2a0e:b0:703:61ea:f289 with SMTP id 46e09a7af769-708fdbb4afdmr12042986a34.28.1721685693197;
        Mon, 22 Jul 2024 15:01:33 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 8/9] dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
Date: Mon, 22 Jul 2024 16:57:15 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-8-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

To enable capturing data at high rates, the AD7944 is frequently used
with the AXI SPI Engine IP core. This patch adds the properties needed
to describe the SPI offload configuration in the device tree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Dropped properties that should be SPI controller properties.

v2 changes:

This is a new patch that partially replaces "dt-bindings: iio: offload:
add binding for PWM/DMA triggered buffer".

In the previous review, it was suggested that having a separate binding
and object node for the offload was overcomplicated. So instead this
opts to use the proposed standard spi-offloads property as a flag to
allow the SPI periperhal node require additional properties that are
resources that are physically connected to the SPI offload.
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
index d17d184842d3..6533459add87 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -129,6 +129,9 @@ properties:
       line goes high while the SDI and CNV lines are high (chain mode),
     maxItems: 1
 
+  spi-offloads:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.43.0



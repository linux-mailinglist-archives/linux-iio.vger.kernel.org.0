Return-Path: <linux-iio+bounces-27651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C26D1493E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CC2D30336C2
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613B837F734;
	Mon, 12 Jan 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OGPsEen7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1832264C0
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240001; cv=none; b=PIMhjc6ZzhKwyfZKmX53JNNKMb0c28HLVykE6zzuOMeWYOC3ke5L8RT1L4CjZ5VHmEJ3Xpn8KNxxJzVsJxPHpiZM8mzlCArLxWnnbMLPXotqFGpTMNqOAKIPP63kbVsvnThUHlxZP8tDvr9E9PHrmaJ0Wy+ysR5m+zgOM2OgQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240001; c=relaxed/simple;
	bh=KlpbRpvD0BSmL1SYy0IyvDDu/2WAX2DYojcAy5Sk6+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mn+riN5svCrmqrBhLGTtqgwl45nkultsKrKSzjA1kYGHwd4JtkBVfWozyhgvphXVuP5u25MsZKEXuJSfQwl+JUvUMgIIQbcqt0vEY5aKtG64D58mH0fkPWLIQFmzVGv7TuumgY9RVG68yOTv9GNfMDMrdn/ncEPSV/7f6QeaFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OGPsEen7; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso4539135fac.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239996; x=1768844796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU6bnMq3EmI2XeZnFFH//hp7bqUfjnvQ/avju2H44Rw=;
        b=OGPsEen7nV4GBn6VqBGPEVVsdg/F8a+aukipfe0cujF8IIZMva+cXNxtV8BuSN7xwX
         QGqiTr5/MonkSUGJpq1Yd//ZR72GIrxzN2zbiv6BdBZOuiJhp3NXg7PlGVKbwjg5chGm
         9S4MqeNShB9h0cc9uFpqv/76rROI3epLlogoCdPsjFejyfKnnplCY2B8VC7CpQVweS7V
         B9Qu0CDhvogtenZlGSHFf9AfudIliGc4j2Rg/NKIEGfq/Lu5g17AjIZAjihvPJ8WrS7y
         GeIGqsrimCDwfJ4JLLKgY6uhve5N43YayMglGw4ArXluKc2lHFfrysYHRtnq1aOpKazs
         js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239996; x=1768844796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mU6bnMq3EmI2XeZnFFH//hp7bqUfjnvQ/avju2H44Rw=;
        b=Wu5aBCtBDY1dHbzv2HzddN2lY2OpcPJXQYhKwXEKskZ82mzdi5q/leEOQ0q54w6dvx
         oAeyk3RbZYYU5IsC9ldSQy7EJWPvI0THw8eWYBxsXsvFf5FlzpZztCtXxQOgbNa9TK3R
         MeluBvlbu3tIdw7QRPT/EOl3hddHXzd3KVFDvN6sRCCOAGrNZeIJW4G9AszNm9kOkvJc
         8E8niMoLCyKrujIMuaOrM3CSPnAQ6jB0Eaige03oCnwGIhvCUH3y0p2hCuJnlKP2nUaV
         ByFMEAwyJGBSgSZqiLpVbNsrF8ijRCKaKpKhXYuHDCJnWs+7x06m2dflCUmdzGlL5rLf
         3fhw==
X-Forwarded-Encrypted: i=1; AJvYcCX+vjhyFZOUBdJqQB5F0ZQbj7e2RVKQUlJP0yAOinbKkTQSKW2hxotL7I/ob7h0qTkNy1xqRmD1d+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdF5RCu/fRK7zo4R/CM6x17arZ6EskNURJKXeyUpnjCxmIpE0W
	HOZhgyAuVSrSa1J8ur8xpmaDi7PyyTMpcTA3mx5Lcn+HOHIqCNgyEKf4jhUQrgK2ns/ZqMlx157
	bFTIJ
X-Gm-Gg: AY/fxX68RafY+M+wi8DzoZ74ldoPLPPKuxP7kmB3Qnzb6NO8P9b/qOrAVdA3XEWYf8C
	FQtWA/zcxxlDaei1kjU/FGz5MiKzaEN5FUtFwFIfl5nHJEu1kd4bgeYiYq5R+yImzgrHOCnxGeU
	FMdyv+/tNF+CpikqX43lphiv7rk0hN7tQWM8Fnx5Qjt2CLYSGwebUvv6cU3kmiDmkGyHa7hOgVA
	twvb521gIn68tfzyz8k9wpoxCxYp1NaoaKOxj2oOvEqWiMDc/dlDEm5mfHaUZtxiayCXgwNV6vA
	1KtXyflDyJcOdwvOTLwEVE/1856McQL5AJ1ltu1oDNetF6DkBwysKsyjbHTvN9oSBRRuppL95/x
	Vy3fbU3X7ApiOAfI2WeMsFJwGwmye3sw5k0R+SuKV/+iWacH/DH/PYKf/o88f+kpPlaY8ljxou6
	4zPNlXjiz84FCmqfE=
X-Google-Smtp-Source: AGHT+IEoDfvB28hK9nvIn7bly6V8L98WTUCLULaRDTDsMotN3hhYZkKeJoYlkt8txzlE5PHsMwnoEA==
X-Received: by 2002:a05:6870:d150:b0:3e8:970e:d4f7 with SMTP id 586e51a60fabf-3ffc095696dmr9253589fac.11.1768239996408;
        Mon, 12 Jan 2026 09:46:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:24 -0600
Subject: [PATCH v5 6/9] spi: dt-bindings: adi,axi-spi-engine: add
 multi-lane support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-6-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KlpbRpvD0BSmL1SYy0IyvDDu/2WAX2DYojcAy5Sk6+M=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNYgNXHsHZkBPsP2wHJV6l7Q+Q4YK7WwSBEr
 xb1sQH57cSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzWAAKCRDCzCAB/wGP
 wJI2B/96Lv7i7q6RWevbLE8Rmrou7N4xap8Vn8Jff8Ps0Uvn3C4CAUrctWCdZcvNPsJEZqAjQ9S
 vh5wpwGsWM91OYZK7TgeBhfWxsQIp3EYma/HtpDjr79jp9hZg0j9WGH0KuRbCWbiYaXEpqMH1vM
 ogxcAKVXjr2l6YrbieImvZA8WFRiExDA6ZRff3wtnEIY7IJ0crxdZC1E6lC+CPa4t0HLO6D5+V0
 F6pl8zUWzk1wDZHJs5WeR9dVaXhRwQYWADcIWqcRX+1pS76NXbta819oX8NZGTOY57JuMWhrSlG
 +17xFPFU1CrQStpdhJXI5mtxkmWqMNwdIs0suUb+v0mU2Ara
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Extend the ADI AXI SPI engine binding for multiple data lanes. This SPI
controller has a capability to read multiple data words at the same
time (e.g. for use with simultaneous sampling ADCs). The current FPGA
implementation can support up to 8 data lanes at a time (depending on a
compile-time configuration option).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
- Update to use spi-{tx,rx}-bus-width properties.
---
 .../devicetree/bindings/spi/adi,axi-spi-engine.yaml       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index 4b3828eda6cb..0f2448371f17 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -70,6 +70,21 @@ required:
 
 unevaluatedProperties: false
 
+patternProperties:
+  "^.*@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
+      spi-tx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
 examples:
   - |
     spi@44a00000 {

-- 
2.43.0



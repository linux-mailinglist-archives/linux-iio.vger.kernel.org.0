Return-Path: <linux-iio+bounces-21087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA722AEC9B5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50837A47DF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF7325B2FC;
	Sat, 28 Jun 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IK/Tpf97"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B821D3DF
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751135052; cv=none; b=ims3WZD2aApx6iMsRnQBZmIqr1eIu92i5cBdJY1OGEd4rzUWJ8UdmeW8KyH0ifCFJrP55eA4F9GbVw4MrmrMgPIb4i+fP/GppNXilwceX6fouDNwy6QLwobwH6tGQdN8nNcl2yrp8eZ/vP1jmYh0cqcoGH7B7QCquHIK2E4NdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751135052; c=relaxed/simple;
	bh=Vn5+2bgtvfPS9qCqWhJMk22PfY3DVZYJGIAqAoBVIig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYPNJsVKSMjaiI/rCFHdmPZj2dw5pr4QYSil4ZIK202e0DOpK2lrS+6FbyuQviokxSweG226U318/r8jSFegiTiMpWxfO1Hmg+Dl9zt1MGGb2ddFpotNWFSRZetzpTtKtk/nWYX8DTUeAsLTtbdpLtastzbTR4PrikMW8kuHMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IK/Tpf97; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c27166ab3so678207a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751135050; x=1751739850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGEHW90gNNjHt5IztadQjOw1eB6HNXmwtaUXnz7Gm04=;
        b=IK/Tpf97VJZyPIEmDoYFIft1FKRyx0E3tctknqPpReCOnFu+auT4lAEA8ngjGyviuW
         y0MZ1yafBU2FsVoaK4aCmHEllEaxCM+ei9KztwQofsA8y6oPbwP2TqMCf+KzvECv86sc
         JAgllqUkW0YCk3ODUkfgZVlPxcmoAl9qUhBluSGhNO1QiVyE+7mPLara5bQkf8Yw+WUv
         46km5sfWkF084QzO5T1tlEjbxfXC+VucJziueNHEjxLNL5kkUO+9tp5qmnWWIfDQR45y
         AHBus3nFis93KWaUamVZje4aIYfGP5JP4kQpMqmmHDCs1a7gM3u+lPKL3Tv21lgNxTuD
         hGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751135050; x=1751739850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGEHW90gNNjHt5IztadQjOw1eB6HNXmwtaUXnz7Gm04=;
        b=TttTslxBMWaTZDPcax2neua3EN0J6rMUgF8IpV6zdavZJUfT8cEA/5+kI9XZDFp9cS
         pUuD2unSTSlUT6oFyEs72daTJudzYmIm8jaxt3stmSqNYVIMOPIxhWjf31cOGiioMuCF
         kycAo207NBictN7DHw39mmaEnATxv3S3lwyOULVQYLO0r5BDqK5KBIqJ++8sjYgoMXj+
         bTwfLVsw0JDTgllQK5Azlkrme7zE2mwXCJgnFvFqmfSKO6U05dO1yq0Zedk3DwkyfwWD
         0v+RrdXRZ1uyLvkyOwJ0sQ9YfzSP+fJk8P30H7ovbGgFCV02VFSjciv7/Viigm7qIrP8
         D8gg==
X-Gm-Message-State: AOJu0Yw/VyImWw6EbMx09PQdPnwA/fwt25IhdhI6axzL+3XW9YmEiLw4
	BzEuUG0PkKrfQsrj/ilDY0IxUZCStb0uC8E+yYrAw9bHpkc648+lgVYWWAqdywBks60=
X-Gm-Gg: ASbGnctT7eIt04lqGH/kGpfB03zilDf9AILx70b1FNqngko4qu20++jx2O8c4jhEwbR
	k8wJTELhTiNQYDQUG8H8DEZR8F2IC6LeShzI0reK+V0bsAuaNSDTTq5xIoRJIajGCY2gvoru4cS
	plW+xJn9lZiePIbMNZ8bXXJWTUE2hUA9OOHfx4AoasQFgkWgRvmF9OyaWsrgtp3DGh9r1Cb7FuF
	y8V90tJaDfIeaZbcw/NL24IxZMp5diJAAPyiL4FsiLK8+zlIXNKRPi2oeG4VtsJLfG+mJrBvgSV
	uHx/mzIvZGKoT5GDN3RM79OHipWQJgnGHj6ZPLeU68Ky878IhB4wOPT4RZRh1A1OEFZFXGgMazo
	J1jA=
X-Google-Smtp-Source: AGHT+IHNR8EJAaQnAdyzC2AU/eeGSrNjzrGwR3T8S8xZRtBcbASkDxeJixzR5DKOd1m+MZlAYjT58w==
X-Received: by 2002:a05:6830:4986:b0:72b:b8b9:9cc1 with SMTP id 46e09a7af769-73afc3abf6fmr5958119a34.5.1751135050048;
        Sat, 28 Jun 2025 11:24:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afafee682sm902248a34.1.2025.06.28.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:24:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 13:23:48 -0500
Subject: [PATCH 1/2] iio: proximity: vcnl3020: pass struct
 vcnl3020_property by pointer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-25-v1-1-5d99cf17790e@baylibre.com>
References: <20250628-iio-const-data-25-v1-0-5d99cf17790e@baylibre.com>
In-Reply-To: <20250628-iio-const-data-25-v1-0-5d99cf17790e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Vn5+2bgtvfPS9qCqWhJMk22PfY3DVZYJGIAqAoBVIig=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYDM7YwJIsTBC3/tgiqXNZ3ilb3pDfz8+ehcO3
 d5+FIc0vvWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAzOwAKCRDCzCAB/wGP
 wEowB/9L5Oh63yVqhswKGkbnLnmebYfPtLSEoMJGImWJ2RRP30Zz1EnUYKhe14LQBZQdGMYoUCj
 NB15Ir9bJRjsKfXbwI1mqJsKY2JwzjKdFRUKnY/B/cWZjsbrSOXpoBDzIxUnVtOf3eAOqTXLmND
 sZjelu2fLjYH72LZIChWTm3lnXJ9yja4HxgveZQnEKHxgIH+TIZFLh4vojdS6W+OmWFRD59kGfp
 86T5Uluzm3BCIvXKvW7kBTuiTGsc/KFM4MPlEmpDFrPtMMtDnLmVxtx6dO2b7CXS83j7CZUmCNZ
 6SkFtXZwJAhvjO5OxmhFDhJosmb5BSCNwDSp94SpEzKlO26l
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Pass struct vcnl3020_property by pointer instead of by value to avoid
copying the entire struct.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/vcnl3020.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 31e77d9e0c90e503e5e337f1ae7f17587624a785..234bdad543cc25e59ace336d2870356b9521f8c8 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -109,22 +109,22 @@ static struct vcnl3020_property vcnl3020_led_current_property = {
 };
 
 static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
-					   struct vcnl3020_property prop)
+					   struct vcnl3020_property *prop)
 {
 	int rc;
 	u32 val;
 
-	rc = device_property_read_u32(data->dev, prop.name, &val);
+	rc = device_property_read_u32(data->dev, prop->name, &val);
 	if (rc)
 		return 0;
 
-	if (prop.conversion_func)
-		prop.conversion_func(&val);
+	if (prop->conversion_func)
+		prop->conversion_func(&val);
 
-	rc = regmap_write(data->regmap, prop.reg, val);
+	rc = regmap_write(data->regmap, prop->reg, val);
 	if (rc) {
 		dev_err(data->dev, "Error (%d) setting property (%s)\n",
-			rc, prop.name);
+			rc, prop->name);
 	}
 
 	return rc;
@@ -153,7 +153,7 @@ static int vcnl3020_init(struct vcnl3020_data *data)
 	mutex_init(&data->lock);
 
 	return vcnl3020_get_and_apply_property(data,
-					       vcnl3020_led_current_property);
+					       &vcnl3020_led_current_property);
 };
 
 static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data *data)

-- 
2.43.0



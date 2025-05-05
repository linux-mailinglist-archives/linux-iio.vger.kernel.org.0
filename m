Return-Path: <linux-iio+bounces-19166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD644AA9C8B
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41DF1A80FD9
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAC274FC9;
	Mon,  5 May 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uIsPcyt+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6A27815F
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472958; cv=none; b=hHTTkkkCkAfrxeOpF/1lOthxtadhwJWDeK01UkKUxWFJR1JPxQHox2CZ7HquhO9Nb+Oc1awVvLRzqdH4TbkExsLHHIxFZFCfYTd9yNsw/jyKLNbkAJGI/FFQ39qICHi1Z+p4xA1ATqyAn7/gWf8IZp88hgXNR/b9wUDDuE3wwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472958; c=relaxed/simple;
	bh=46FnaE90tLBxRCsgLGiYxnx9s4tTrEUeD3vrzbcQCfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fccs2+ZnYJCwhUkQCdipFnsJhwCnn8gK9VdEzxNhLo4wKZZpYbXrv+9+JEQhxZrp/Q4jBw7zbDhZTDqN+ZRfuLpaLMsDslldk99EezIFHPW6u1+j4mltEHsCqSrKNiQrvxnx+rwqCLuuToQcM5bvejh9EsKzENxJ6ETDcPHL8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uIsPcyt+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bc3987a05so2947405a34.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472955; x=1747077755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li2/hC9aqMkGruMurzeAxLi14fOrM+JuKaP74aPQvcs=;
        b=uIsPcyt+3Kjk1IUGf+wHZQqzIFGmrCiMz9eB4w7VZiSeG7OQrhH4Rzgq+k2PWU5FAY
         i4qhXV5Lx9ufnV3e6axKFbtROkMc48zGp8mgxHIn5E7f0Dswg/sJ4IIfJ3M31sXn3lIR
         er49ksIyBK7Sph0PPw4YBE2oj1yRcPFrluRVDOyvo71u1GR3YLo7vb4SMulPCmhusOT9
         JEc0M9P7h7ZSFUJ5YFAJoQEp5hL7KfqAPh1sB/QgLGN5TdUCYcTnqdIeRZ2Oqyom2CO1
         mSPB0sV1u0VZzBxebc9xVr2jW2mKHksYcR2awiASHJSx9Cn1g03gL8cUj9AatUOlhClI
         nXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472955; x=1747077755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li2/hC9aqMkGruMurzeAxLi14fOrM+JuKaP74aPQvcs=;
        b=R2cH9aeBfv/YfhrSA3snWqlqG2gOpx/ZbFGmnCFYmcl25sX1va16KwJFPTENyzu5BK
         COYFVta6aYE78AVPNFCXSv7VXTcFC6w+0rp6SPfSDSE213CCRdxtTskwsnzqJTLy3iDP
         jZW5zlwJ3aKZt1aUNL4Jd2cntze6LMmymAGJEOF/YHiMb/rm+C0tfx2FK/bqTKaegjmd
         PGOf9+6UGpnzFmSqbLsY4A3SlHWvGVZkm4bZQ4elHkt6FoDfEOlC/CqVAdh4jdDKVQBc
         Kk/Y3MbD2QR4auYtrqzWt3Zy+UA56JDb1n3jgump8jfN8x9aPTnkT44fBuYFqOxn46PL
         M7uA==
X-Gm-Message-State: AOJu0YwcXIV1cz0L52c/tTL7MzhvritKsEGUYpd9QHb+Ax8ATVwPkfhp
	ZJ8LSLa5DbisbwTFD462DdUhbHVNFls+eBKyZjEWgMp+tuezKt+sgPyjxC6ILHE=
X-Gm-Gg: ASbGncsXFX1mX1XgBdmzU2riI6yyKwb4EYKl3DTN4yH5m3xD9VSKldgS0j4X0VB3kL6
	169ugLbS1tJ42QH3WctTaZbJOVxsBL0rzGfoNtmDjwYGW+aLMDjboiiO/DR39VUJKs0rp4HKMn2
	vgjyokShHyQ/yjMqLOQwxPlAa457h2B4ORrENUvhR7ID22RweZVT4DOu4fdTMAOIJposDY7kw+b
	n8D1JnKjO/VwQXoOmjOk6pHkImtcS/NL2dB4CY45i0LymmOM0XzTMIIaj9iDrQQWYotMwaiZCxc
	IT9PyhljyHdUSrW4SZbI+7c9N6mXnP4dLjx86Cfvs5vSLg==
X-Google-Smtp-Source: AGHT+IFiw8MeT5qMOlh54bhwhOJd1DflYH0//EODStEs82oMsHS5Uu1ubEr61aLthOm/Bqfk7wWeBw==
X-Received: by 2002:a9d:63ca:0:b0:72a:b2a:476 with SMTP id 46e09a7af769-73205e55856mr448998a34.3.1746472955483;
        Mon, 05 May 2025 12:22:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:39 -0500
Subject: [PATCH 12/14] iio: pressure: bmp280-spi: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-12-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=46FnaE90tLBxRCsgLGiYxnx9s4tTrEUeD3vrzbcQCfg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ/Z1e7pOjDqGglwcas9KlB6JuurNviYp6iXL
 cJkVG+Gv7qJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkP2QAKCRDCzCAB/wGP
 wExRCACdSXDOvkJhjL9Kn2moWV8iVRG/xMVnImasdrv5UKcXlYhkZmLsuLMjau84JB6yn89/swx
 rIlcPB7p6zJ7RGCjUWvIEn10HhNMvPr8EdvOl/HMkN4bfvlXp/lXhHTzCGC3IqMe1n2x49uFiX+
 iFMCp3eQ6pmeXjj5Swbgk3bJYLFiLh9rZIdXnY5GWBiitokGbMQsdlvcHdFjZk0/0wz74wYhYUt
 PRSdCxUJbX5CWSjN7iJhOFxFIMmxgT3JYuLYh2lYmZkkvbn5p9VrZTquUORlFczowOQHvSF1N26
 n62zO+5+KcCMmD0f7YuVsXjOpTmd4a+joFVkzvR3l+jau7oX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the bmp280 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Since no other SPI settings are changed, we can also remove the call to
spi_setup().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-spi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index c4fded3398da53e60d4bc775dba351e31688755f..3b90384f17d735777d4aaefbaca085aa0ed20db4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -81,14 +81,6 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	const struct bmp280_chip_info *chip_info;
 	struct regmap_bus const *bmp_regmap_bus;
 	struct regmap *regmap;
-	int ret;
-
-	spi->bits_per_word = 8;
-	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(&spi->dev, "spi_setup failed!\n");
-		return ret;
-	}
 
 	chip_info = spi_get_device_match_data(spi);
 

-- 
2.43.0



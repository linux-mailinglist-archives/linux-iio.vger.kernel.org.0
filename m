Return-Path: <linux-iio+bounces-17863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29514A820DE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D037AAC2F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3480225D52F;
	Wed,  9 Apr 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yFcxRibb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89A2528F0
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190304; cv=none; b=YAlUxCNIn/AUw3olhPZsfStJpzfJ+efnfkTAktRhrDM/vtFTUb0nzkHfJlivEsWBJaZTydTQA2bfK8IxIOvf/SxFcZofGygsoniJy44Nves9ySOPcR4uAA4nHVVUerT2K27B36FrR4B8YqDMxvLt3f+DuzcntNw2dU/lZw59N+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190304; c=relaxed/simple;
	bh=VGmVlLv/g0NSChA5cTCx5HI2+YgjvT8aXwQeEVYqWkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSOUMMkTKqX9sfef88EZWNBtV5UjIo3q1dGkHhQVekO4WP9G78vnLfCZybGYJYYG6o8hJB6zD4txEiFjtVZeIImk8PgwpBkfaUq+2H2N1L4HMjn8aflNw2856TbS3jggWYQvMy6AHrC1ecAmiqw61WkA0XnNe3CIPiDaPTtA2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yFcxRibb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so3098845e9.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744190300; x=1744795100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNsJvlRDFjThPSOtGOteiq+PCHwiQFN7KKK0wuA2YaI=;
        b=yFcxRibbiRPLTEKr8P7PzYqJSta1PzmE/3EvV9ZUgMQNN55yg9RyIDzfekoyR8jiNh
         E4ePOnN7eKcw0GoC/yLyioGTzKLa29DsZeFarpYCRt1bJdLG929RQA7Av8VOpV/Q04/A
         mmvWPBE0iWgTRIjdNgLGhZ26S784FGqaZVCoZdyjInqF1KXhl7qGKhJLCKILy/Ae+Fh4
         c94gFfvpwcKGyo1XaSE0azu0PzxU3Qmu4hYjntjhdpkLIsrmq06hC9/yNKsGBsgd4fpd
         cilVfRWZF7WTlwr4g4LV11gbg6fTfyxodXFNufgsIj2jIvEP4SZA+YbUcrEaQyykc8dC
         tLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190300; x=1744795100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNsJvlRDFjThPSOtGOteiq+PCHwiQFN7KKK0wuA2YaI=;
        b=DNtCAhEyD/vGgR5AoE7zX9TFAZpMY5z48RlWlPdA6W/Id+V2xGYDWkEBbMJNEqd0NJ
         4KgU7rY/nWexxk4jw/LGRYo3rF+3ZoqN6m+zUzeAxaN9equm91ZTFpGmi3jSvRCHVObW
         aM1+/PjvitlZnIQj1o8dDEyZusuf1Gh3iQn/RI/lIeK825t37pMg02Sw7m/TCFhdbL3M
         oJFA/X3mqU1rn5WOBWpPYUDHQ5mU6zxqhPllgBfMlnzX9trHLgxdhEGAG6tIaY9h3hYC
         88lmfDs280P7vFZppxHWVW20v/OOk7rNn6Z02MEhid16EkWBsZHEdglK2TQbPzvRGCiC
         DmUQ==
X-Gm-Message-State: AOJu0YxnIXtfmTLoNYcBCD1H0YoFgG8ZlfpCLlWAVzg7PdkVShtq/+Fu
	dPgXKVEohuUi6nsku0tZ4CWmvkYFtunXkayBr0X3+sfl3yhFE6aMNvXlkK9Edz8=
X-Gm-Gg: ASbGncs1kGf/fQLipxVDhzoPdWJqgp/Uz+KEiE5oqg4i2sjfsOw1o3qUa1OfPEnYryw
	w9VcUtnRNYImz3ving/YQL4ZRuL4g8hvHLz03aWQiisZ8aFcavkUhtyoCD5aBbHdHuKIPj/yI8w
	ZDvEfhjBVWQzO7LeVouwTrPcoZBTVwUQY1+NQTWvaK4unCjope02SwjNWkhsQei1bvBRHSGpRNg
	218zWz5wn+tEBVL+FPs+g0BKnnpAYlvmCQ0FrSZjbLnrLy+LorV8xr2mYVPfbfcAGY80fxWHUrI
	UAjyvyZCMQJ+K3kOgIDUCqmmx97Jd4iWwJQLCqMfcCJopAxTckTQw/XUepJ+EgjnIoT5QjP5pXk
	ut5zTHXd/yqNRy5dgzA==
X-Google-Smtp-Source: AGHT+IFT9E4x39vToBiKUhyXzFBNHuX1M+gngkWvQuAa7nVGL2fuwhZZLclr4C7DEzRMZaVvnYJ7CA==
X-Received: by 2002:a5d:5f93:0:b0:38d:e0a9:7e5e with SMTP id ffacd0b85a97d-39d820a3dc6mr4896719f8f.6.1744190299971;
        Wed, 09 Apr 2025 02:18:19 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938b7afsm1069482f8f.58.2025.04.09.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:18:19 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 09 Apr 2025 11:16:54 +0200
Subject: [PATCH v2 1/2] iio: dac: adi-axi-dac: fix bus read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ad3552r-fix-bus-read-v2-1-34d3b21e8ca0@baylibre.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
In-Reply-To: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=9pHPKsKzptvjYiQOA8UzTeuM77FIRRsobVc0fiDL1Ac=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/Zs13fbkTy0wpduvtApn7d1hVtBbc/ivRrvDYkGF6y
 cR+qaU7O0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExknxbD/xAO1WMX3uZO9Da8
 08VTts92WebTEwul8oTa5724+2ZhWirDPwtvq6+bT9hWZ9pbXcxe03hY2f3bOTvFxftqDAXca2Y
 94QQA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix bus read function.

Testing the driver, on a random basis, wrong reads was detected, mainly
by a wrong DAC chip ID read at first boot.
Before reading the expected value from the AXI regmap, need always to
wait for busy flag to be cleared.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 8ed5ad1fa24cef649056bc5f4ca80abbf28b9323..5ee077c58d7f9730aec8a9c9dff5b84108b3a47e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -760,6 +760,7 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ret;
+	u32 ival;
 
 	guard(mutex)(&st->lock);
 
@@ -772,6 +773,13 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	if (ret)
 		return ret;
 
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, ival,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+				10, 100 * KILO);
+	if (ret)
+		return ret;
+
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 

-- 
2.49.0



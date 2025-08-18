Return-Path: <linux-iio+bounces-22908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C9B29C1C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F19622D08
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C2302CC6;
	Mon, 18 Aug 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLvvc4PL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A9302755;
	Mon, 18 Aug 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505511; cv=none; b=bRZjuD6E12ZrGOrak8IuXQklltc2V3OjKOr91fgcid3KnBUtGVQMQv2zF+5A17d/g7WD8A7U4/w/6LjH/Tdl1f1uNrAwQbQoLJ6Qi6Y9Q63p/NaGuJjB5dTw6LJd44hEhLgEVEITBghy96dmyvx19vdJAkT7m0+poqmLAJZp/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505511; c=relaxed/simple;
	bh=q56W13AzKwbzEaeRaqr+B/VLzp9SOOb/l9+s+3Cmh7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK6gIvIVXmBqg7qms8E2hcDdkifgslEIbEuF/g0HuoM/ci5ouz82B8Z2l8L+GfWLbp01pDU2tXnHTXq3jhJm7o3rf6QGW7A3yABVPliOwkCdcEeA48j4ON0UN7jdL9EYsq/aD2+tnKU9p9ZZS2tjO6ACOv16ccpB/e2oMWEn5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLvvc4PL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so18261045e9.1;
        Mon, 18 Aug 2025 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505507; x=1756110307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S09Gsmq9Jw/lkHidEm9OsH6PCjryp6nuR1hhv0ESMqc=;
        b=OLvvc4PL7NXdIjjpuQwoeWLeqsn3hIO0N71ZMoyTKC2wCQ79CUe9ncvJksmHoeRdrf
         xHN7z+bxrlBZMPaCBiJHWZ4CXTOU5jHd+nP/d/HES80JsT97lobSYJPNvN4ckpAuUF/0
         /7cVE6evbD9WwUrdm3eN2Yy1GKnWfd7BG5rKAmNXwxHV/eLNaCqySs1Z+g6XE1nPtBrk
         iRt9n/ae1FdlEmDY+fDp+wRspBGEu8XNRle4IBmr5zxwPBVjrSQyhi0+b1DYfUNgeGYU
         eqpHQ1ua85qtI+KXp2dBd6YO1oBmVQIejWH/nPt9VhQHTK4jSpu7O6IElp0lSaMu0Uva
         6Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505507; x=1756110307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S09Gsmq9Jw/lkHidEm9OsH6PCjryp6nuR1hhv0ESMqc=;
        b=UlwxDrwyo0x44omyUw2UaUndvgzSKCHt0x0FSlENWjKKwnpFV9Ietkx56hoWaSo0U9
         RgywDxhpT2khN6IRVGvw7laG2PU9cSPKQhROCcopBCJkKSrUsw29sVT1DW6S6XaCnZ3z
         xFekqbJ2nE2/rk1M/7CWZeOMlIkwizwLKGgKglIdncJhQBvqnUcdoch2k4KCewyfVshY
         c/rVk8vB8QKYwBsEqkxAZkDtuMdZ0r4do5nHMVdayN9ekyoSyV4QpOwSmoqWU6CoI/sb
         DyMbhwm2mnXWZ+Tb1Bi0uzdA6UDIZWJRAv8ZfdIOoDJxZd5xerfG5YGf8nMR5+YHH//Z
         LGYw==
X-Forwarded-Encrypted: i=1; AJvYcCUk1iTiacDyGlGSovBSL5Hs5JJKwCbpfsKeEOHduIQGKZ8I+/u6HOnh2/eCPpabOoOKuduHadn545qE8o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZkcY5mVDMdD0jvaYGumD74+ShZCuHlaZiD0XVgpUeZxqw67i
	8QPn2Kz04N2GGm9i1/SOnIrWYXTtgNFfn6LFspjYqQPdPtAC7xxJFeZQfDhcmg==
X-Gm-Gg: ASbGncub/SV6oQaJ7oJDaD5+57lIxqaP+ws0IrjmOaMAT7HoUc1kAPguYKADPUfQP84
	zZRHRtFZwaFulZ6V2dShRqxMoWAQfoXeu+S/4RUzVjjMvIkXNhnSNwoXU2mWL0e2/kky6V+qAF0
	Jul1LJjy0XTnSk6LVXCknLScmT/fvJclB/c0z8JFT9WPp/zdauLL4BqOiTsFwJVt5qCvhwen28R
	LrQDxcDVcKQiluLb/C9ftTg/8NpDoeKmbEsqodFBBU9kYskfWPATEluOFTbT8LZ2WpSs7D6TZTJ
	+RfSidp2IPM0npIXYFKP4pLqCEFWWa2oWYy0CC0QwDGbn3ALnmOUUowVqb6ipUex56f7/I5dGJ+
	W7XMCQZiLSFDPkLCD5yminLR2jn0x+HTNInc9MK0=
X-Google-Smtp-Source: AGHT+IF0QvLkttdGl8/7pupcjBtOZfRQYqVa5crLKXkQhFVEnDWqjoubCi9WKrDRX2Xg2/upXx603A==
X-Received: by 2002:a05:600c:4f4c:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-45a27151246mr56303625e9.5.1755505506942;
        Mon, 18 Aug 2025 01:25:06 -0700 (PDT)
Received: from localhost.localdomain ([196.235.158.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223299ebsm126848085e9.23.2025.08.18.01.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:25:06 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v3 1/2] iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
Date: Mon, 18 Aug 2025 09:23:30 +0100
Message-ID: <20250818082409.543197-2-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818082409.543197-1-salah.triki@gmail.com>
References: <20250818082409.543197-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR()` and propagate the error if
necessary.

Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optional")
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..6cdc8ed53520 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3213,11 +3213,12 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0



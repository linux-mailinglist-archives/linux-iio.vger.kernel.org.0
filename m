Return-Path: <linux-iio+bounces-7513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71C92F0DA
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E261C21E67
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD919FA74;
	Thu, 11 Jul 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIGh13vn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2E19EED0;
	Thu, 11 Jul 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732582; cv=none; b=ickqUGbHhO5tlgxcLlUvzxnqyCtJto+n7jlxfGQnhRp7W+6XG19tDezO7i1o4yerTed3N2bvWQPTUmCRQiCOndvAwJSLnxx/C8yYac32lMtOpy10qRS0usAookW+tvtR0UpU2gxUOETctBJuISyp1OL2/lZ08hMdqZOoCmJUPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732582; c=relaxed/simple;
	bh=MBeTOc9YtaSE78apP7OyABkoi+w1f3Nn1NzMgGfoI4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDl+A3ZT575PVnop+eHZ3KHWyBknCfVNyuSig0Y4pUsoluRfNG+Naieov/ADCdVrO0gA6fd7rlQRbTCW6e9qwpwld5c+8u3AD5CjtOI+vNjLYOALiuSzHrM4fLK19nQmpO5CbUE//5jFcJn1xlNHCvlSsC73WHj9ZmNIUO89Xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIGh13vn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so1669764a12.3;
        Thu, 11 Jul 2024 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732579; x=1721337379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeeW8xyl27sE8Lugc1U1TAa9CA2UyB3BowAvCkxaT3Q=;
        b=NIGh13vnbJNh3MInUGILj3zQVtKqKw9cKRguco5E0UONyJVGPxZfIXTylfKIn2PKen
         36qkAzsSAD8alqyJZEJgmikQvJGxV3nNExGuhjF782v9mZRDnIUIYIdX8Z/9jgl1bLVb
         u9xpkwfeH+ybTl8dYnmG8xmmIYu8qVCwO+p8/h2niRvvuPKlEoHrmH8SmX7w+uxPHBXP
         CbG8iZO9GtP1OSqhHigM9YMQ5IJfZCbRKm+o/4OaLxC+UXogSCTuQRKg8BuXmkQuqKwA
         TP3vB7l83Ls230knnHqRkV6LomRpYUwgXvT2rjLg3CXfHbQiFyK4GBCm8jUdBVsOXM/7
         cj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732579; x=1721337379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeeW8xyl27sE8Lugc1U1TAa9CA2UyB3BowAvCkxaT3Q=;
        b=cSDJBHC6BzQ15V3sg5/a/Nr02+c6pfBxOrfpJRfpOYXwO9tCyPwPsiYtiVISZlSM8r
         ++sqspCjWvmIssG5ndeQ+nb22ukXhVRjzA4FXg+OsqEfFwJjsguFxYAIownY3iHVmW8E
         ggSfR+2MLWMlvS5ZDOeJsGW9LMebMTJUZXc03UasvmXRwZ2Bzi5yqRjyz/uPb+8sefmY
         Eo9jWXbo6csBa7D5p9vrJIS0x/oD3IW1jZM80PgrqisON5Bkg0mLYxPlPYdQx9+KjANP
         Ola+kCBdTAFfMJ4ZPY2qg2d/9Uaj0LLIuy/anGLGvCe4ltVaOS31mtYn/9lbDqH2gZ8m
         Kpgg==
X-Forwarded-Encrypted: i=1; AJvYcCV9V3z7iV00jscxT9IKQj+GHuztVNtB2sk9zdj81s/FnBsOBZXAyn6FFyAzp9me7OYEvF0lOpEhZ82HWbNFvg7qsP+6VACZIUET4Cekj/WbfkB/rskXG+/Nd3T/kHHJQpipbAedm3fA++Nht/qAcLvkz2ADTODj8Ncs0B40eZBhUbJ7wA==
X-Gm-Message-State: AOJu0YyW57MUwX8pUsyhJt+vVfEXvPnfxcwUuQGneG48Tq9xOA4YcdaD
	dYK+CJQZUuVCNgZgewwBY5YqsG1hYLPWSsFP4bS87BflMJzoHft8
X-Google-Smtp-Source: AGHT+IG4hpFl1A+ErxqxderxC0zFIovKeq1a1Zak+qKO4TxzK7+kM0NSROESPPLmZziZJ3u2LLlqJA==
X-Received: by 2002:a05:6402:1286:b0:57d:4f47:d9ee with SMTP id 4fb4d7f45d1cf-594bc7c88e8mr6402364a12.31.1720732579243;
        Thu, 11 Jul 2024 14:16:19 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:18 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] iio: pressure: bmp280: Fix waiting time for BMP3xx configuration
Date: Thu, 11 Jul 2024 23:15:50 +0200
Message-Id: <20240711211558.106327-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet, both pressure and temperature can go up to
oversampling x32. With this option, the maximum measurement time is not
80ms (this is for press x32 and temp x2), but it is 130ms nominal
(calculated from table 3.9.2) and since most of the maximum values
are around +15%, it is configured to 150ms.

Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index cc8553177977..3deaa57bb3f5 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1581,10 +1581,11 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 		/*
 		 * Waits for measurement before checking configuration error
-		 * flag. Selected longest measure time indicated in
-		 * section 3.9.1 in the datasheet.
+		 * flag. Selected longest measurement time, calculated from
+		 * formula in datasheet section 3.9.2 with an offset of ~+15%
+		 * as it seen as well in table 3.9.1.
 		 */
-		msleep(80);
+		msleep(150);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
-- 
2.25.1



Return-Path: <linux-iio+bounces-15097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A67A2B5B1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D94D1889159
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9623CF0C;
	Thu,  6 Feb 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cG9pwCnk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5523BF86
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882117; cv=none; b=eWdRgmT8JpELSPkEQu3gw235euEms/Mzc2g+YEYfrLW3w64H74Ue14Jky+7O1WkMu37ysPke+4aUg8fUilq1kzZo9PZ8ETkOeKrakySwFvLQ2eeS10dqtXB6hEjJ4Jua0/8Hh0LNkqMvpkCqTLnDCwgrcfwF8ltctP8+8CB5Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882117; c=relaxed/simple;
	bh=HaFWSgBdfXggpkPiEPQivtzXY7Xojib1tG2MzfPUdgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXGcb+WTHi4BSaCLQOK51+c5sGqDVEjkKjxN8DhWxWIQcMBtkVXJFJRBGKL5rYWyQp9xvyMdusuNK/YDeDJQ9Kw1QhqtInPsVpbpyHYNt6SObfqITn3wcUXHfi+qouq9sHmESKrklt3Fr3eqeaEmreOWa+G0+HVTCtbTxzS/uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cG9pwCnk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-724d1724657so1335025a34.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882114; x=1739486914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hnz0az7lntDGiOpb5KMBiHYUt+/ZN1SFQQir1JT9FNk=;
        b=cG9pwCnkAGhREeCpqTup5txOFp23jH8qzyvN/AXhPm+HsbSzH7nwbiISN9/J/pQjCT
         aRmMwKOEOaAH2ejG4ZtdJiNaTDSifLuDQRLdTOUVfGsHWnxRO1VUYIIVER9gzUJqTGoe
         zX+XAFX3q6RAYoScAzRqwFo2E7gjIhM4t7fzx3om1IKQ49qYCyGvgVsWmtMUjCPp3Abs
         E83O3ZRfdX3y3DWYApFxut4GWdUGhVZ3e4aBoGd8cyrqTO50Tt2elx+LSrqP/iQUh4w1
         /G20RwOZDyTyPs0ERRJSW6FzBeqGR2ZhJWGXJyvp3aDhzsAS5U/VhRHlFK17JXQwHREj
         5IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882114; x=1739486914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnz0az7lntDGiOpb5KMBiHYUt+/ZN1SFQQir1JT9FNk=;
        b=fwALFw6zCowuuZMWRR3lOy6ossfGHDRRbzSTQhDq6eTeXHsRrMFk0Gr2LK3xwQfj+U
         BGipppz0CgaHEZphiwFOzpgBOf5NACB+Ms1ugPHHINUnzvMzvs/bdTbLQ7kFnVOdHetl
         OqsaDoBHcNlsV7FOUDiiCC6fqg49weyiWJtryvyK+tqE2fWnzcxyg1dt35xKMBJojBS5
         QHnmUWMZ7qvqPXCWQO4XBfs68obBRThfsjDcXvsYNoeDc2/KOwRBDEdOI5laXfqHva5W
         UyP0izUSBXzndx50sLv458+xidz1Wyr2sAzUVrJO212J6u/ApN3jNwLYCFU28TxmaWAE
         nb/A==
X-Forwarded-Encrypted: i=1; AJvYcCWv9VsaiY+CKTRJJuq53YREV3KyDzA5Td/uct3zLgjIj9HGw+ZSwNJ46YSH2hJAzCT3KFluYlrpNl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3itPPAlm0G0jSg9nPxp/cJmjFk7KFMDAM1fHejNx2A2TNryI
	BHzunpWXkl/vAgWHnoVfvR73C+6JWC6fTwSMXT0IKhj5gz2e/eC00LQVfVtOyXI=
X-Gm-Gg: ASbGncstpPs5VCm3ZYtLcm3zsyS91fYz51xC6CRgp4GHF0AJa6tV/YLXTdu4iZw5Km5
	ZMygo21MHs7gpu+dpo4KhmkNgdMi4jOU1sqhflvYTT+cMmRhtKcohf4SqYSb4PEs7BfMHKiedjF
	UXJAdwOpzHsRK2JlE7At+xfi3zMdG70yO84XG94v/Yfzrlx4EFvnK+m3kuIal3i8nai1fRnPKrB
	GSCNVdJslRRagt0vgkhGnxR5H/EO92VAWz82RF8WyR6TLgBvsQtK96Jd+78QF/WjWxjoS+rTkZt
	Z9sF/5tg0zLdJA1KWN55gj1aUl+nQwqrBcoVIYCd+5mrR6Y=
X-Google-Smtp-Source: AGHT+IEVknGonsegy5S/Aw+PLXi2TjO/wnkH/rmRbYYU8mAcrJGwZvntuKEgjA/jQ79DrZ7uQxsojw==
X-Received: by 2002:a05:6830:3981:b0:70f:7375:e2b5 with SMTP id 46e09a7af769-726b8f3ab09mr416555a34.6.1738882113893;
        Thu, 06 Feb 2025 14:48:33 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:23 -0600
Subject: [PATCH v2 09/13] mmc: pwrseq_simple: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-9-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/core/pwrseq_simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 37cd858df0f4d7123683e1fe23a4c3fcd7817d13..4b47e6c3b04b99dc328a8b063665a76340a8e0d0 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -54,8 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		else
 			bitmap_zero(values, nvalues);
 
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       reset_gpios->info, values);
+		gpiod_multi_set_value_cansleep(reset_gpios, values);
 
 		bitmap_free(values);
 	}

-- 
2.43.0



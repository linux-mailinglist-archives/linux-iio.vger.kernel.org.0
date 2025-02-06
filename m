Return-Path: <linux-iio+bounces-15100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD720A2B5C2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69477188949F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358523CF12;
	Thu,  6 Feb 2025 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1sEwRXSP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7623E250
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882121; cv=none; b=sLtpaubWArKVNjImsQ1MYzcnJJ8A3JSIopA9v9jkA4KEmHJD3084239vlsJLO5cr1wmozOnbkI/KppzH2FbAfJRpp5J0Rqcgj/gkWEprZphobmSLRBS1zfxwtAgbF0bavuLpIO+fSFrya3fXRW1P3MOIIdWphqLPG7QDigbxoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882121; c=relaxed/simple;
	bh=QtC6oLxmw2DvbNfS+XsWeQUt9WZBo54DTtz6cY2CdFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZqDCvv7lU0f7GqcKQmJuMwE+cW2yH2p/3fIGoi+bs+KmQM3Ju/CKQdTiZxKW1y2y6S21+29EK9BKXPPrgbAhtRdcs5e82UYuVqQ2ROTkrf/n4BgpEg04kSUPcPqoveVsPVYeidAFIBkq/QJ2jKa4kUyyPfHOz7ZSX3vc9EwJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1sEwRXSP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb98b3b63dso379176b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882118; x=1739486918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rir37DR+dGjXzV88JkfAUftf+GWLKbTzx84djPKNaJM=;
        b=1sEwRXSPntOwPL0HtxKu1P9TX7+3wpt5WQsiyHQORN94tjNVCzbYGJvmZZiPuRVJON
         LEJ9kzfwBTaJ85prxenb1UydBZpqGC9lSXKqyw160PqQweRLqvnijFB3uYdYw2lsnQmS
         5sKotPh2YZK2VNWHK9TWNPYoUf7WwLhzknWMqCQ7RbbysDgucCyQLz7ZfUJWvMRCqt3A
         l9SQuE5ICQ+UhvT9g9Swjkd3gqz/31JuaM6vVNiGnODbxjGMUUKDDGienS5fG/F0kTsl
         E3iPtSor9mzm2ko7Lcmp+wKGqdl64Nhg6MAQlRzVogpQ1NczgfTiap67dK8vAQu5fwKi
         +Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882118; x=1739486918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rir37DR+dGjXzV88JkfAUftf+GWLKbTzx84djPKNaJM=;
        b=HgyzqwplFjw8aEMVBDGcYhlXh9mF++z/YnTRLXSD6lXkhglE0kfd/Dt0DOyGvAx1PU
         5xNLXF+lih10TTZB5Gejq5E6RziZ5w/RFfp+APmG70qmhpC8CMMoHW6Ll51NORA718DQ
         qyrGiQpo2DMlya4n+J1HUVzjUMw5abg7J9kTVwbNRAe5E2QqJymd9YoGEsVX0KaJbfI/
         E8J1hT96tD5BCrY7qKHgvA97TqHTmpYiC2cAcBZO3xS6JCI65jec9j3eZNz+NsbQRTV/
         dFgHNUYaRNMXC6NE7V6GsuAyh7Ko1IEwCkLejAlfIgidoA4FveCdPPPCT3txRfZ/FLLd
         Vfag==
X-Forwarded-Encrypted: i=1; AJvYcCVT892vh2SAAu+SLghIF4+dYqYv+Du2lzCBYrqccjU2DewVFrUmvZhZbU5Y/iF5u4xjjPKp83OgNqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpuyi0Yu5+Vr4FQZHu1LQhosJnE2YK8LD/Oj7+4pk549+kgaYC
	w0N4UfnswZerJYuLGrqMQpUgb8zyMf95NGhQSHa7doxZ2UFvkGUe2zB/r5WkQ7E=
X-Gm-Gg: ASbGnct/ysydVB5uWywsImVBE9Odo3fsoFitjbRnqXj02TZxlhWMfhksf9PJmLGjUxs
	3E2DkMiMIC+Be72TeoqNhIjg8WoXmt76ZFvQYhNo30rvGyn6Ix3auINLL5xmXJm+w5yhyZKi1mX
	MIy2PXTSBtQ54Bm85sxN9t9KBtHJmc/7OekcWJx761wWv9mq4wqpdQGQ/F6Gq7u4OWhTFjsi0bb
	qkuSe/gKDmhx20iZA1JyLferor7KeSo7KmyrboGiKBrtwrfpVxPDO/Uqb5IPrbPI4Uc0GA2gltx
	3WZLXvtWgN/KDrTClCksqGl070J0Ezv0Y0ORt25RvByA3sI=
X-Google-Smtp-Source: AGHT+IHg1dkR38vC+BOfsqdfTGHavmIhAar+M8vjgAZ97yt8yxkX/PgUDRgvY/W1hOK9akNHaGFBHA==
X-Received: by 2002:a05:6808:2f09:b0:3e4:d4ca:2774 with SMTP id 5614622812f47-3f392318adamr932419b6e.20.1738882118361;
        Thu, 06 Feb 2025 14:48:38 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:26 -0600
Subject: [PATCH v2 12/13] phy: mapphone-mdm6600: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-12-1c5f048f79c3@baylibre.com>
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

ddata->cmd_gpios->ndescs is validated to be equal to
PHY_MDM6600_NR_CMD_LINES during driver probe, so it will have the same
value as the previously hard-coded argument.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 152344e4f7e44de0f8ab1cae6ae01a1f1c5408e9..fd0e0cd1c1cfb10fb55ed271e47b6a0bf857028e 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -177,9 +177,7 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 
 	values[0] = val;
 
-	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc,
-				       ddata->cmd_gpios->info, values);
+	gpiod_multi_set_value_cansleep(ddata->cmd_gpios, values);
 }
 
 /**

-- 
2.43.0



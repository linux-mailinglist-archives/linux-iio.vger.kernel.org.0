Return-Path: <linux-iio+bounces-14790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A04A24407
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254D31881B24
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61961F892D;
	Fri, 31 Jan 2025 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s6wxqIkH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D431F8699
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355120; cv=none; b=ExzOcFxFlOQK79IjdypIwlckmN9krFdyqmZW6an1i5eweJRGBZyeor+8+ELcobIA/1YzgqN/+ei4PCY9soC4hlmUQiaUMAII4wBO6emst44dhp1AJWow6fTIpcAkOMqOUyDNPbjLlSJQO0JuoAVk3qC4TUhHLhBp5CjBZkL19Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355120; c=relaxed/simple;
	bh=rmBWKBYHCI+WuV2jjWYGUn7c5T236U0xlpQEPpz0oeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWjerb7oBRIoEbIImcgW3GmSxK8FRTExUyi1VXV5l53CBgwMTrMZsmOHfS9s1dDEc5Dc/FnOmH7dHVnQOlWBlQEmIMBGCBkK6vpCo6o0oA+/YqehD4NNmS7NhhP79Ezd/F/JTtJX0Yu4gVQ8R6dposJVmPaWDzIM+8dwhyATNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s6wxqIkH; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2adc2b6837eso662331fac.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355117; x=1738959917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzzIwzQtyYUR99JIrJ6how8p6bj9KukV10X1RHN4Hv8=;
        b=s6wxqIkH1D9BN7+dFKiVfTcWWUarvgFPerBjQBy2NCE81v48dt3r66cfJ5wtOQ/LiT
         PzJg2f0V1gkwEImOdpkVpgU8AM/RLxz5Yp8VdZT+gXb7II+fyULczC9ffD4/Rq0p+WEr
         X5lbmVf3N1WdV+WTfAOiA1ZdqYc8frmtJxKxmU/7Hv1rDXeiNfReGh2nl7dvUtOYPfrW
         QpIB/BIY4NB7jyxCkAPzlo0R+x8sTudxVaSVqlzpwMi0EpHUtGcDJVqkDoP4UGtxYXRg
         Q07OAtIcAT8tRFMvvVrQ60DJmzpBTFdHI8Q5YjebwR34OUPgteE5yDJftgmc9pUg+HwJ
         Tigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355117; x=1738959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzzIwzQtyYUR99JIrJ6how8p6bj9KukV10X1RHN4Hv8=;
        b=I237F841z+EmVgVHaSlIRdOx5TzoWgfalXvzwlCK1b1z14D5srbb0I7QuVOBsl6XoL
         BlcTga8goQ0r7a8EoYWeaKVabC+IDRWspt0nUNUuWIj31jWGcZ0QbxB7E2I1xG0AGrmq
         j+VjugUUMo5HFIi5CxePummDMTxbub4hf/axN3M7BMg8twIYE34h0yGN84anqiALl6Nb
         KUE5cfKRz4zoIzPG5I/MaQIC0k+vspml3GRcuLcS2+9hqjt2qwq5wlO+QJL8q/XG6mIt
         1jR5eno6qZesl2z1G0XsxTj/uMED4o8Ka/JBQQiMSSO9WR6DtwN7zVwp3k3nYKeUFdBv
         pdVw==
X-Forwarded-Encrypted: i=1; AJvYcCWMY4rF8Y169S1hsPgwF31eICs8W4pirtuHRw2NlUhVPBjGnc0/28MjsXHNSCaaLzqeehE3cQebd/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cFU/5jjRx0xfEpWjv+CJQ8o6US2ZTonJotz/IiDqO56/XDcm
	GWT5x37cvVtbjlv89Un3WPs7Q3Sf9CTGl/0H5b9BavDSxDItrdHbHQs7TZMaaSk=
X-Gm-Gg: ASbGncuBkuYv2K3xxm0A9dTbxupjgV2rwXF0RLkGYvx0O6V+QE3k+NQQLjA7y1+srCO
	CrfayRjROW69l0tkxfxvEqQX9lZlOA7hRxbL6kdVZ/gxdUWtmlBzuaElSnLP8Goo5YMzNf15kUk
	zDi0DNBlSL4rVZ85439N4RTGsnfS1qMiud4W/a9aZSIyyMhcdY9aEa4JEJhsvRlqh5o8seIKrUi
	ZB96kLrL1tBgv2rm5x+Pvt3WBedMga/6HKK1u3e5+yi7IQGvu2+r+pfG7m+B+vGK/5wLwBOMwU2
	6SdfRABh1BkawGXCpIKio/I4PfHsevSemGdMRNMw2yuctTM=
X-Google-Smtp-Source: AGHT+IERsKIHS0RESeT1aGghrd2e2VbJU3Jew/L2qRirwk6axnCtq0WNFwypLdr9E1c9DhZObl9GKw==
X-Received: by 2002:a05:6870:32cf:b0:29e:255e:9551 with SMTP id 586e51a60fabf-2b32ef5a830mr8108456fac.2.1738355117684;
        Fri, 31 Jan 2025 12:25:17 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:52 -0600
Subject: [PATCH 12/13] phy: mapphone-mdm6600: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-12-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
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

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

ddata->cmd_gpios->ndescs is validated to be equal to
PHY_MDM6600_NR_CMD_LINES during driver probe, so it will have the same
value as the previously hard-coded argument.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 152344e4f7e44de0f8ab1cae6ae01a1f1c5408e9..8243bab6ac3af2ee1394ef743aaad12a19c8ae36 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -177,9 +177,7 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 
 	values[0] = val;
 
-	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc,
-				       ddata->cmd_gpios->info, values);
+	gpiods_set_array_value_cansleep(ddata->cmd_gpios, values);
 }
 
 /**

-- 
2.43.0



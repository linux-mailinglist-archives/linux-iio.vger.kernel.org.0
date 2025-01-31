Return-Path: <linux-iio+bounces-14787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6FA243F6
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB061679E5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968D1F75B3;
	Fri, 31 Jan 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TvKooawx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301641F75A5
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355113; cv=none; b=KICjf9JrrR51XI2+p5N8XTqbn8wlqweC9R2HEvWch2i83uaNa+Q8I0BnBPgXNJtI8+apKk1xhGrOR/9VfMHp0RwjRwbi/gortrsydxUrbEHGHR+5bCza065rOJY+uVrlPLqoGls3jNF2sn9hrgx8aoYf4lxm7Oqsuru+NJC4BB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355113; c=relaxed/simple;
	bh=MK0Ks2Di2rJVvigp/s/vAkyxV2Ps9hTBvb2TEAom5M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQzRc0RaodosamFqvuUW/6aLzDmHQrO8VtkiHpAjynZ9AHk2YIZ+8ND4Wsuip6p2qyuNpTtg+ANvlQi2PLSF+ezR6oLzJMNw1jM6M2QXEEafbtKIFznBpth6wg4kUEsi/D451TVV1c2GFDzURohUyhePewj7f+4z9SRtbOWXBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TvKooawx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so689782eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355109; x=1738959909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwWNVnhNlJbHZ/NQhMSjzQrpqbMeo/6h41DdX1Qvb2w=;
        b=TvKooawxk3ek74wKtIXI5KaEKZulBtQxUrB6kT0RHQ8XQ5TNLQejFlCawjYv5dJxKP
         QmA0sG4JSA4gCGhiV44hp1U4iN0rC9D0ZGD6wp3VOQdc+WLXeUfK4cBDwc+pjyGzfk/7
         pIVDcxasgxQJ2GQFj2lxnW02DL477FldSm5uh+zU/Fgw1W+FRvpN4rRejYXzpHxzzQSq
         iCG1ZxCO27hKzZQIg5uybXovgC0OSu8/fCgzH4gIlDI1w2BuG2YhRlRuDEC39pO9u22J
         zfw/1OapEiNvUatIPZ5hKMapWz2jItA1s2EfzhfSeHtmWGsEuE8dHTerIIfQDTMKhuZ/
         0yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355109; x=1738959909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwWNVnhNlJbHZ/NQhMSjzQrpqbMeo/6h41DdX1Qvb2w=;
        b=VEe6/NoV6xQG0fZe3fdku9ip2HR9yKyta08ouyKXvQVMa/EjV09/59XwMTN7VQeMxJ
         7DidLaDZf+zYLqxc34OFS1PWaFhCodCEhNcwWIz5bLpm840gWj8hGuaLFctpZBEkkLCw
         wIsKa6W9IW8KMd4ZPj9tZVs/bxDuFww498mzwp30P4o91TQNDLq4OM4uRm9D4N7r+SvV
         +GJn7+A/WtqQGKwaKT5LQJ8vQGsT0t9oKfE/u+ij1v4OuOJU0Elyw9SC0oIga3zdp6v1
         StXcOZPw747WhQjlA2nnGNMnNjdvzFARd0r8diAOjA0nWC0nrX4i4N/XMl+nboCyaRSY
         IurA==
X-Forwarded-Encrypted: i=1; AJvYcCVNv6LFcZHTpucfhr8YQ9LxjJF7FGtVPEH7WlVVzNhSgnxdChv6wN5nD42jtXnNRXklINCqc/V6Anw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNepMvuLhZXeZ687+9jhREUz6Im1jWPr/0PmKD8ORs25J+w9Sw
	fLQXF8K9ET3ScpRYDS/yqg/rcWoJVgzBpkJ6SGIm2/mRPRDxkk/mj8JJIHri+Zg=
X-Gm-Gg: ASbGncuDfd5h+jrAgzubj2gvdglCpaAGtDADFXhmjKwkijaYGPVIQihl4TFVNZEelWB
	YQY4gBl5NKt5iofRE4/Nl5Qr47vsLOqF7eQB6F2iLLJyi4HvSosTfLTbjvXQXf3QQf+W6KppycN
	NVebQ8B0Rw4zYa+OJzkZPmVJwKwih3yeY3uuARs7dnUlSJcTZMWmE8nMyp2T0NPgk5O3bBD9o3B
	Ci7R3vR7ST5xhOka90ZPD4Lg2jaUF4DlsGxsIome+BUoVf1lsquFS7fy5y7qEJwnQlZkcr0YVkl
	GnDCsGIz0KesIP8n5TksvpPbt9PNv0p841LvebwnByXmAYc=
X-Google-Smtp-Source: AGHT+IHQyjQ8y3Rtu7NlfkeMw/zOxhLdOk/J2rb/TrRaSbO1InYUF9KwbynHBq+Y9XgpJsj8OqBDUw==
X-Received: by 2002:a05:6870:7186:b0:296:aef8:fe9a with SMTP id 586e51a60fabf-2b32efdc7b9mr8033858fac.7.1738355109312;
        Fri, 31 Jan 2025 12:25:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:49 -0600
Subject: [PATCH 09/13] mmc: pwrseq_simple: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-9-991c8ccb4d6e@baylibre.com>
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/core/pwrseq_simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 37cd858df0f4d7123683e1fe23a4c3fcd7817d13..b3a6d053c826741005f1484ad81df30b6bf75bbc 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -54,8 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		else
 			bitmap_zero(values, nvalues);
 
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       reset_gpios->info, values);
+		gpiods_set_array_value_cansleep(reset_gpios, values);
 
 		bitmap_free(values);
 	}

-- 
2.43.0



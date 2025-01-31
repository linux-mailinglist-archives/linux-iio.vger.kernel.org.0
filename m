Return-Path: <linux-iio+bounces-14789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956EA24402
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F61B18873B2
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988621F8673;
	Fri, 31 Jan 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K8giR6/e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1DC1F8677
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355118; cv=none; b=Xqb/ldFsQTpTro7HxxePPdOMvz2jMGZY4AwE0zw935zgSyAjudp4+89X6cfL/72V1qTSP1V9BQhYilj1nj3jJGBlxO20bm9vmUnkxp8ezs2dwSV/97ogi35fgpMZ5oOKZUbapxGmJDUYg6H/U2IkGbsnusm+17EqhpKkINogS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355118; c=relaxed/simple;
	bh=5lFciV6sDtnvvFQNJQrSdhN6LDbuB2QD+esDyLXoYWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGG3iWZJHFctJDskLNoWmpVWkJaQp+MFaIKEF7MlkFdO+BuMLDLotlQHnO9I04vGVwBtBtquFsUpkF1Lz5yofB4LNQdB2/U4kGjabUu5n5yP+jPcd/9LPmaYQ4RO7b3kIHULFtw/+Z52iT1whXTsF4NTPI1on5Z7FsazPP+FC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K8giR6/e; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71fbb0d035dso1387373a34.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355116; x=1738959916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59JJI4CO0oacXanEEbv/QOEs28IMbairlUQePRWumA8=;
        b=K8giR6/eb07WBP8z96Yn2P2K3obtSp8rW+Pob0UH8Ra4ZZdKYcomCZ3EHCvJt3zZJh
         BnmQb7b4tAB4gHRhk97QgDo4vASvBI49hBHnGYY9xkkJQyl8WRBdiH8brjJ8sTA3eJCM
         T/tAfGFulugaJ42LaF2c5YaS3Dl7i9RkLP8OcAgahoha86+w3Evrnth78oilenwTfgCR
         C6USuGEVz57oJMVDATFrFocZL9xfFtCeB97mx8BZzgVStlHYsJqw1G0AkzXPQPn/Da89
         nvwI7JmYZ8cTs5O0j9a2ryqinLe19Yo47Z80bCn4yTbCDRZqCBbFceQTYk4imyCfvwjB
         BMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355116; x=1738959916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59JJI4CO0oacXanEEbv/QOEs28IMbairlUQePRWumA8=;
        b=aSOLVx1CRMz/kFB9KRBzkZQAxFQLAy9I7OQJa+ycIdhBxXN6cxgwS4q6TZssaUaeyc
         eOQz1ctmWI34++E83xZvgvfHfOpYVP5SQV5+RIWzLtIoJyu5YDJyFd86l4WU5+lPJPDq
         700ajBZZimAY0FIGN+9eo4fLiY1hDu9S2I1gXQg9QuPdKW9D4tLm0tCtaeJo1UNdjNy1
         /2pkgUzNJ2l5rhLFxfapaGco4ZDAqMYL3y6jrEHbQQB17DaFZlY3An1BGx9W0AUleJVZ
         3gOhx4RVpi3rKDCAyRACMWtmxpIbSROiQBTPTk4ln2mpmOc8eQiINARDFjOzMs6zsvux
         B3WA==
X-Forwarded-Encrypted: i=1; AJvYcCVtq9pYxWFpjQpRmjxSV9ZdXMwoVoupy6zmlT44ry2spUtylze6BZhGY64crZrO/OHpF1/X+TCjIEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kF4f5H1Y6+t5mX9Xbdiu58paoD1KQu9h87gO1NkyO5t9kwOX
	n1UVHefIgPvfHVeJGLajfaADUqzi6xVohlawaR+0otW3qIYAJMRF8y+8Q3xVWDw=
X-Gm-Gg: ASbGncvbrKXuQpaqy/HG591qkghp2jArvNdOU0fWlW4IKBnvbu9ZYkCcUCMqqyLK/3O
	HKcFdxIrJBseTZChKKL3J+6nc6O/vr3mKw1hSmPFXsn7B6qWgERVi1zAJQNHet9LE4dsaZE8BiI
	Z6ngoDOch4hp/bBCczWNZdO1m7sbGd6pHC/EYtyiN6mq6CIRgjXD/9WNd8O36m3+Tj5vBi4fHN8
	B4LWboDhw0k49F6CbTPNVLobp93L4aznnho0FIf6Vp1PQdtSmjjeIple7txzcPGK7EJqgSD+BvW
	aTFZAhaJBPkvzvsJ7Z4Wztt6um7pbF4suBsUaynQZNdWst4=
X-Google-Smtp-Source: AGHT+IFrVMAfd3Y3wOZ0h4O9q45j+fMg4Vw3AAmlNZ9ZgYIq1KVZZxWHseA00ADe6a66eu+rR/ZJMg==
X-Received: by 2002:a05:6830:6805:b0:71d:eb02:baed with SMTP id 46e09a7af769-72656774376mr9460293a34.8.1738355115546;
        Fri, 31 Jan 2025 12:25:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:25:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:51 -0600
Subject: [PATCH 11/13] net: mdio: mux-gpio: use
 gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-11-991c8ccb4d6e@baylibre.com>
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
 drivers/net/mdio/mdio-mux-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-gpio.c b/drivers/net/mdio/mdio-mux-gpio.c
index ef77bd1abae984e5b1e51315de39cae33e0d063d..d7eaeadde2873977606bdcb5821dba18aa4a578f 100644
--- a/drivers/net/mdio/mdio-mux-gpio.c
+++ b/drivers/net/mdio/mdio-mux-gpio.c
@@ -30,8 +30,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 
 	values[0] = desired_child;
 
-	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       s->gpios->info, values);
+	gpiods_set_array_value_cansleep(s->gpios, values);
 
 	return 0;
 }

-- 
2.43.0



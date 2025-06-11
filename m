Return-Path: <linux-iio+bounces-20496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC77AD62C2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD4C1BC1A72
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D83256C9B;
	Wed, 11 Jun 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IrYxYQjx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B50255F27
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681748; cv=none; b=I4EKBa2m5hO32RWdOz4fV9TkpWANtnGeJvP7Qv9daau/Z+C4MyPvxjOtELIc2+BjB7zUE6tEDbzMNSCnwTJLgmDzyq4NJLEAiqRrPXnnXmByYA0IyyJjt/GaD9AUf3WawXdZR+5rmGKEXx+RaKFKuc1BFkadpfSwiDs/tyie9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681748; c=relaxed/simple;
	bh=5Dt8chRh9Q9zFfR+o0HlVC5RLtjfsBgIEofeyEgWWKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jl7E8YFdt3NF/phT2vEI95gly08Mu7oLafmlEdLkV56mSFpTzOQvvq/Q3t/ciG0MGaQt2WDaBA31KwxCFwfzlxWIWHlUQvX5bGlDEMacmDWhX6gW2HyDZr4hn1EhzlQIP2499/Udg3aAWRFW3G2/4nBgWB4lu9ldGpWoeEA89bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IrYxYQjx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-407aac76036so195386b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681746; x=1750286546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nA/Lk9tPGfFaI22ceEDpAoxrxXFiJ/9IsqCSjqV/LI=;
        b=IrYxYQjxKQ6N0cYXHDtkeiAcTUyPc2Hdr9r3KCHh1OOZMSYP+auroWnLS1jgogO95t
         liiuE8nbLoMFyITGBXy5tPNNYyGvduCyhI334I/bjsysLvxsRblMbSm8R/sHBbGAoN+W
         bo40h4iSxACTVLIjEIObrspCLkgk2yYEMPM9iY0piN07kTaVBIJhu/wPeWbcoRnYIjr8
         K/Ug6SIorGB/ei01hv8kc4E2YA5CS5KXiuMbq1qhrGBBsVv8rZiRdJJuu7rP5kZz3WF1
         LSjiE73xfkiCycJvNry+Th3tjYAvd4OIrbLysWXqzorWa/UzbXxEs7Tf/tKJwHjYzrir
         skrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681746; x=1750286546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nA/Lk9tPGfFaI22ceEDpAoxrxXFiJ/9IsqCSjqV/LI=;
        b=O8dcjnV5V2bfQMcDHxpsMIZOqDug1VHovutnUUe75iQhf+Dxw9QG45xz3mNzOMSHds
         ruFs26Q9LM+MXEseiSe7rxbRJesAEP1WH7gb9ojATc4ehskMssDm7V8hjRPaRfhi9z2k
         lTJ3TDtjAkpCK2Fe8SrQ0hiptRbGq6DGEcBQl9RhWsDd/qMeNApYQDs0cFFp492h72Wm
         HbOery4JnTrMDQJ0927utlt7me7SQtRFQm93rHgg6RYGFg0OJ1zCerNqB2DRpu28htxg
         l9uJRI6vXI9pyGCRwHJxWhu13Y+lbnpEvYEO599f7x7ZG0a9uYBJ8i3HYD1X3sbs3eJr
         hshA==
X-Gm-Message-State: AOJu0YxjKxXluL/+mr/iAnQnPo8wR5UGcle//897d1R1+er0bJu1HnR/
	oXnXmO+u8SKg9lnnOT1CpgmhfX1CzKQwvCgOaM2QCU08188amCTPoafBLZ0MItsuCms=
X-Gm-Gg: ASbGncu0RAkubIojPslM1DXj/3+IE/ubPwF+L2OKP15/Iu4ET1koi3okUsZzpR0tf3i
	75+YBt8EatvkrS+ezk2b9d/n7jJ/bhZijnXzYAj/T1O/2JR7N5QqCkTJ0+AEWYW+Zc4YTvCYCSA
	VOEt/qsM+Jisjy//jHfhdxQdLTRMKAd5olk4UxoFZ5Ru8T3XTahXjqLGLHjcK1ujjIlQjCYqh3D
	cNKtiHb4qWeQm4HuKcziLp6Dw+Kyun1juReH+QFpQLJgSXdlYjeEbKpxkL8lvUUruBVim/OuFSZ
	HTe9LUW4N8WbkG+6EBheWzJZQAvO1caMawEdYe94kHl4PUM8mBDxp5AsF5iX888V0/du
X-Google-Smtp-Source: AGHT+IG0W8cN0RBqzvza6bDhDRqg08z0+EUeK0uOjK7EVtYqqJLeVsRO4zcpkxGJblg1Kp+3B4rIBQ==
X-Received: by 2002:a05:6808:2186:b0:403:3c95:3684 with SMTP id 5614622812f47-40a66a419c9mr505006b6e.1.1749681746196;
        Wed, 11 Jun 2025 15:42:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:38:57 -0500
Subject: [PATCH 05/28] iio: adc: rockchip_saradc: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-5-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5Dt8chRh9Q9zFfR+o0HlVC5RLtjfsBgIEofeyEgWWKs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgWkPxj+ITtdzYFOhYRqZrV7rzI2N1a8bxnjv
 BHEMh8oTqiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFpAAKCRDCzCAB/wGP
 wPI1B/9lozodgbkP5rQVG6ALBHKR3d7hz5SMy/uywa3QBiiLmgj5QX1cAyGMFHI7hO3uO3aQSl/
 mDQT4eItTwkjzu/N/k2p6HIl0UyXa2lwFwPguAh6Fco94W+bqLyMiXXgd04TmGW4jedL9LbPCgY
 07pa9FRxuw8J6Kg4xZzUitsXeewyNtdFUuzGLvmvEY9oqh7A/1iuMLVZyNULwWAqpBbAvI4BDWY
 mrWqXne1TqcmnTZJBaLxnti67Z2+Kmlj8oL+TyU8uXKtKa9kYw2cN9r+8cjaEZt5I4qaauKXSq4
 I+XFZqyqUd67pwca8QgxuwJVoQn6LMRTdn54nn8A0dcTI+q1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/rockchip_saradc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 325e3747a1345c84cddcfe9a455da6ccf655447b..bd62daea0a3e5b879a8a970d107e3342fda7b8c0 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -404,12 +404,10 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	struct {
 		u16 values[SARADC_MAX_CHANNELS];
 		aligned_s64 timestamp;
-	} data;
+	} data = { };
 	int ret;
 	int i, j = 0;
 
-	memset(&data, 0, sizeof(data));
-
 	mutex_lock(&info->lock);
 
 	iio_for_each_active_channel(i_dev, i) {

-- 
2.43.0



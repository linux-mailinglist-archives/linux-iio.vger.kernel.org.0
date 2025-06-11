Return-Path: <linux-iio+bounces-20506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46165AD62D5
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4643AB5AB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8425F973;
	Wed, 11 Jun 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q3z29XvN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F225E44E
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681768; cv=none; b=Cot+wK6xPxqMnklBvK87w/ulhF6FqObNU67TMf/bfnbqh4bJhKpLS1cp5xdK/gwqm/vY72/wcLq0ZaFzmAnScEi7wbT92YdeKiV+IMg+cw3SLUIbQJhoCkRJF7kWHvmCXWda8PJUVCL9y24vJ4L+83kG8kSRjKnKRb0sSmicRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681768; c=relaxed/simple;
	bh=UJXbN0f/Sc264QMDW6dBftvYOYfvz10QBoW4bFVFUX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzCJXh1fYKvy7JLu+tYB2KqHs6vEiNgfM0kIxb3J1QopUTrcnhyJsJJYQECGsBHNtbbWId5qlZfKW8RVC7+lvER2kH5wEnZHfhCSVrTB+orBphrsVojKt/d0ccYOJuvydULOyHdUvBgn0tONtESRUho+eg+D2qfljrBr6i6cJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q3z29XvN; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7353779b10dso197502a34.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681766; x=1750286566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiF2DulFgRfRNMjiDxreAgm5rKmLlr34bZCxk6U0CK4=;
        b=Q3z29XvNp5CPueW+ysHJA0zxGCmZ+xPLQj8J3FXAD73TI06ToeZ5m+1Iu03xIb2HuF
         RYcGt87BdSdgMpvD6EOsN+p0cGLc2slUytSRH8476ut33Ra+yO/lw+Q/nB5R1vnbBdet
         PWs1x3LpOR3kx0wQAXehcrm++xYARaTS+zDQDSr02LALpNc/OH6gHFUbdVhozZW2s1Ky
         oNcXwm59fCDZ5kwu7Czuiit0F3/DJexXdhQZEweLxvgwTBwzURsouqPa5F8ZQEBP8owk
         Pma8powR/fuEF162ab48jG6rlr4/xG0J3LW7MUD9FYSYlYkLrRWKAXFrO3y6axm0qCku
         1iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681766; x=1750286566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiF2DulFgRfRNMjiDxreAgm5rKmLlr34bZCxk6U0CK4=;
        b=Fkg4kcPNXeYGyYo11OFei8XBSQAVtZcITKD2sn7kPhlN+S+J235n1KXIYDSDf0IC4D
         UPsd4wzj5YqcONywSf85elXE7cP/w3mGE70foapXYjVlyEfumcPfaWYtBl/jC6k1Prqo
         65BCmmLJQlXNkTuph1JyYSk+KRGRV9YDYn2RV2QudXEBPt4PdDdLwjQPy6jZNYEKtD+F
         piHk7Q+WT0g2zL3dcbVSVjB7PM+CQfjTpeuUZb7XonvN76zlVg5ccSYxc1txP6bbJUEC
         OUOdgKK5HvADPaqDT2Ey2ZXw6nm8xNp3B8ZKl1SDLmd5eQnxNfrSS8YvXn+AM7A6S16h
         Yhvw==
X-Gm-Message-State: AOJu0YxdFciN4+kOKa+MFQ5VZb/nMu7wSLqo7YgjPG7k0QAw2rwmdG88
	Vv0hplnf3CJsSm+A7QlyHLZWlcWzxeOksbbkZEaaN58JcB6g4f1/Bt1f9n9EKSOB3RA=
X-Gm-Gg: ASbGncuYEhC4+H9mhuWvFmsQ2NqXofodzX6TxLGFMAIA0izVUFSFQxtSGDbsAsBitXx
	rLvs22hsy7scan49hTP7OT5xtLSiKqlHh4YSoe0/QhRApEl41/sduEC5y3AyvWcccmgNxgro+e2
	aCQ6EIibDT637YHEirpfodOw6WOCHgDNCrgbe00lHu1i/BtC43JP+93XyvoK1Fjd//tKjoxNz5n
	FV8GoMH/cDAfwz0x949DGdd8CbWZ+nNLc8MinBz0FlLk48AE+B2kH4XdzdYDMhWsDoChkPu2QfD
	xtKuQjNGoPO4Ese/Kk+faQsRTJI2QoiAsYlVrywKF/9kPx9/LwOxgOqZRjtnws65kRj3Ulik1aR
	TjGw=
X-Google-Smtp-Source: AGHT+IGZSFpZmGlN0w2Un5vLT2W24kqk9q0DeivfstNV8sNtHQdO7UhGZijU6igQSf2A4dpARH8gnw==
X-Received: by 2002:a05:6808:3086:b0:403:3814:b2b1 with SMTP id 5614622812f47-40a5d081c0emr3858130b6e.10.1749681766169;
        Wed, 11 Jun 2025 15:42:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:07 -0500
Subject: [PATCH 15/28] iio: dac: ad3552r: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-15-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UJXbN0f/Sc264QMDW6dBftvYOYfvz10QBoW4bFVFUX4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXmmJnXqBUX52BnBQ8vdrjyxdthhoLPWdbRL
 R+WVVgUfXeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF5gAKCRDCzCAB/wGP
 wAHpB/9uvsuwsxPRCNHjRwNuY0qyeu9AO2EJoyNvSVzZWpvJJXh6el4lDtmSOYf7BNiSzxoL7GH
 ZA9fAXagxB/cnJd0lWxqHu6IllSBT9tS7KDugmBh+2loJ450FcplnrPuRlzFJx5QRs7XWieNUFB
 MXxCk/XXt6zIf+oAV23jZWywwUtyAzZ6IAh9PIHNdcMrm/xyZ/gKGv3UMTkLdL5rp5SJBwxh4cc
 00NEmMDVhDI8758T0v6AVJa5hRW1epfYSYXca9HF6od0VNpE0B2edgAefLgFuwdtJeZH/7Ms8qJ
 Qcdf79QFtQZEJjej/ETfZd9QxjJxo8qX5fR8v+r3taHVCkrk
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a44b163f318315cec179aa2ac9d66883a327ebb9..93c33bc3e1be438c2e10c1ca990d8046ba87c9d0 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -293,10 +293,9 @@ static irqreturn_t ad3552r_trigger_handler(int irq, void *p)
 	struct iio_buffer *buf = indio_dev->buffer;
 	struct ad3552r_desc *dac = iio_priv(indio_dev);
 	/* Maximum size of a scan */
-	u8 buff[AD3552R_MAX_CH * AD3552R_MAX_REG_SIZE];
+	u8 buff[AD3552R_MAX_CH * AD3552R_MAX_REG_SIZE] = { };
 	int err;
 
-	memset(buff, 0, sizeof(buff));
 	err = iio_pop_from_buffer(buf, buff);
 	if (err)
 		goto end;

-- 
2.43.0



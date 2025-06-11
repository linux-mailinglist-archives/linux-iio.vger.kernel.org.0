Return-Path: <linux-iio+bounces-20492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94ABAD62A4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6367A1BC19F5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357224DCF0;
	Wed, 11 Jun 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vmvDJ0m+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0924C07F
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681740; cv=none; b=sup8uH/MoNomu0iom0ic5Gn5kJPHj1ZgZnM7wUOuOBASB/ToHimKjQsn9F/1ThvQPXJGNprDTKr1poHLcQxmUfhkvTM/Mwerq81b6kUw6KWINkZrw/laD/PFqzk+On2ezkee0dqqOcyJchD9XbNMdQCGdXsEhh+gAMYRghEXlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681740; c=relaxed/simple;
	bh=OtTTIp23r83l4FPUg27mf0gCVgpkwXuq0SNiBdQqXRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hsn3f6kVUMsHHbrEbKFwNHNvBtKVR1y/Z2UEmfM4srPPixeixc0HGLoXTVyFhbR3uOe2nlQKatqYAJ7+wcFyRgV5rl7B1t8Fwo72nmumqXfZzpzdfNxO97b85BaDFcEEByjWXTHfOr+Ox2vW/VE7ZQtH7CzTp2it63yPCOeoxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vmvDJ0m+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-407a3c10d03so214118b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681736; x=1750286536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zveqOADtHS31WFyPmzToD+nPl3JZ4+wju2m9sYArtpc=;
        b=vmvDJ0m+jHLTV7MJragAAnc/SVyd+axrf3qKbkCzSRqYIuqhRijg+7SIGJYoQmV/2j
         7AqMHfaf1uJB5JQGN3Lp/NCCtHbGAKe1H2/cMC4AO7rjN4LBK105cHYGybJzkFrf7GG4
         6GB5mXNQz5mlwQkZjVb5y1m+cvSXevFokPY0trsDumJ7cvAnF1UVyw+iKYNZnYlIWNC9
         IPw7fYm2mwHYu0Q6ZTu0tHGi+Vq5+HrFu5QVOkg0uWKcUFpqf/l0G5fXeBVXcl8Vm+ze
         G5IU2V4OmYhf+CDrpq8/Rm/lZ6Swgq1o1/9MIwwjfDmW+p8vVbvSonWw+45XvY5AKhmh
         C9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681736; x=1750286536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zveqOADtHS31WFyPmzToD+nPl3JZ4+wju2m9sYArtpc=;
        b=Vku5szcqQd8SroPSKTIkY3vXT8hKg4SayyhuOsFmXgv7hEg/yjvIFSG1BIoOtgPpMG
         +jfLgnEiK4tOzF4sksPNzmq0f+xXb2ZTA7HzyQZWT8u7jwhfFmt+PgftThugmV2P5VLB
         4VSTZjH3afkLmcPdOvBZGgDcOqKob0lvZncjKfUfhrVhsQxc1+XH7cIxCgmSOhEo27Uf
         jzFAyKtIVmnvBpqH65QwgTDXcVKuFy7mA2bMBDgLnFrXHmCsSf0vi51Zv1902+H6rEco
         ajR0b4mri5QFPk/ipdyRKyBs52bHkg++BX+xXPJkketaSp9L6bxgQotDKhwCZ1I9ZcM7
         g/Kg==
X-Gm-Message-State: AOJu0Yzo12U282gP69qaMSpCckIG+bU7rLV5fflzGJ7Nrd92lTvKTqZo
	sTG6HlxMNcg6p1PsTtlhh3oaNEXCXwAk5wmrnAaEN+YagIWHD5UYuWsYX7kCfwd/7FQ=
X-Gm-Gg: ASbGncugbQe6hON8JWw/+nr6xCdLeb+rB9Ud4T+IzIKe5JD/c2iY/TsW4Nkcnki+IRk
	DWncKgs8AX1/DLTlKtNXGcKcWmaKdLAf5doG3f1CDvXcZzfsJ03nma2GxyfjOj3H5sLCF6Z5YJL
	5mevlYlQwlxx5JstDCULi0QJyLlijraUy6vjQx+68tYTUKZ9Gsauk75fcYAySSk2FOaicqk1u0A
	UwMN0iiozpIP102d6mDYSVSWwymaC/yvjp1o6cybe5J++yzEoUhy7l7jG0UdYyTSJG8SrXvVtJk
	Ii18+Kns9sBizskt3BHfd9ZWHWPbvt21JPbKyXPOvlXzbisxWdcVhXteTu15PSqLAXDV
X-Google-Smtp-Source: AGHT+IGIpzPnDrmzBmfsC4tKKskTV7D3wfzLsNC4g3WTLnbA1Yephi0RklISAXQUfRO/ncM9aBfPJg==
X-Received: by 2002:a05:6808:6a93:b0:403:3fb7:3870 with SMTP id 5614622812f47-40a66a5b32emr592491b6e.10.1749681736398;
        Wed, 11 Jun 2025 15:42:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:38:53 -0500
Subject: [PATCH 01/28] iio: accel: adxl372: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-1-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=OtTTIp23r83l4FPUg27mf0gCVgpkwXuq0SNiBdQqXRI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgWKKhpCfFTksDG9gr+9eawR0jxJfSx6dAJNM
 0SZmsoqdzqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFigAKCRDCzCAB/wGP
 wCJwB/4gUJ8t7UOdIfHCp1gF5oikHABa4eS0J2FUBt6zWTkee4P4bV5tDwfS1kcYHllaJBX/CtO
 7HxkjtZxmdIfL2tBgPZCBP8S01Mg+OXaLOQaEx17gLl45c23P1lCfWSYP+PhWq/8KoX2NIR7n4F
 9oees3ltMwkbduWFqU3iEDQB0oXjzl94CRk6aPeSRv1xieFkbXgD4FSutJmNiyViLOv2q4OqnYa
 4gaqd53Li0HDnpieOacuZPGeu3GoPzOXOtMsI7N1pk1zfWsrHFkxI3Yw04/HUQokzunQaFQaFF+
 HR9AsvwTdenSczLxmQcrifmcH2iDoIhYwK3xodh8KKtXzNMd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/adxl372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 961145b502934674e7655573b12121fffb2328db..46d518a2a029179bdd2cc2b9e98f09b6b9854fba 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -600,10 +600,9 @@ static int adxl372_get_status(struct adxl372_state *st,
 
 static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
 {
-	__be16	axis_sample[3];
+	__be16 axis_sample[3] = { };
 	int i = 0;
 
-	memset(axis_sample, 0, 3 * sizeof(__be16));
 	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
 		axis_sample[i++] = sample[0];
 	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))

-- 
2.43.0



Return-Path: <linux-iio+bounces-7359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A87928828
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D51C23B8F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C310149C42;
	Fri,  5 Jul 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoUO6whI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343C1474A5;
	Fri,  5 Jul 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180050; cv=none; b=AvVj/Sn8Oo7Cyzd5l2Wgt5SPWItq0TjshcRv5eoYk8UyANAUW+RJOV+z+cQhO2m+1Yp7sqeuOnSD18nUJpQgtlEIy3p4yPI+DCibrbGeY0faaAApARqCZNPl6KT5D4S0Papfk00U7tUsPKcSP9SC/n3SZSFUF/KMacL1QTqNGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180050; c=relaxed/simple;
	bh=xms28d9taT0xwLEGFXrjYG1coba2hO9+PZ7SEZ8/RNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvaezdhPrOIarN6hVRa52zaoVIaZMqbELcV6JDK6P2rj5valq+kwd85PotQ4/AQEF+okx+a2py6YIMtJdRxVtpE+tqAgUv0cv22+WRAOcGZcigMLTDir6cvLFQdpz7ZvShI8A4rq3qlqUJFnyvzOyBBw7NsQVDIOd7Yw6gHYo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoUO6whI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e96d4986bso1691240e87.3;
        Fri, 05 Jul 2024 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720180046; x=1720784846; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xms28d9taT0xwLEGFXrjYG1coba2hO9+PZ7SEZ8/RNg=;
        b=MoUO6whI2/qp25KauCXPmIUJBlvv+XsOC99kQkLxBWn+NAazBt9v3TZJ5X/6R2IYOv
         d8jO8l5+TXAMHZIFFOp0VBfQaIIZLo3afCVarcxaQvLe+v5/vBRIt6BKyXIMm3Xdz42S
         cqIvjgXaWKO5q4T+/r7Nis3n84GWfl70K+ZdArP7wVFac7ZdivVfmnIxliZchLO+SeGo
         B7rBrIYVl4+H4cB92x20OXXcicZDAlaCsKGwxI0EGTxJQhV9p2W/oqPm5VzkpODTgEcD
         ZQcrdsP4ueendauDgzLiBVPJWGde7VeMGDc0fXPyiXQLIxgKP2f3uQLz46NQyz09STeL
         JpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720180046; x=1720784846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xms28d9taT0xwLEGFXrjYG1coba2hO9+PZ7SEZ8/RNg=;
        b=CpXN7oWo6h+jb6r2ASm5CZOo9wQRSGmd+aBrKHx/O5Ae1HzFdOWCM07MtEJ4HYi0d6
         CppOmfsYZvRXnIZltjYD1w8ouuZj+PeCpdW+xeOFyEAnZh6msSZydAc3rvWh4VdUUyAT
         x6kFtP6zYOUpddCNnR1oIWK/Un1veoMmyDQDJNhlYyEswJ1nTvjwzsnCfYi0UAFssGX6
         YNEIpg4w2H4/JST/i5N9mtH5vk6ybrgBlRY6YyUNW49bffVkFcrIsWRwSu9v6jSsoqzd
         sYW5a0FHYJqHbNkft5jZ/Y4nF4ncQs4MoojDoCDYDiZwJI3vHWUeauJWKykMfOJxfLNd
         epqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbHI0XRqGUYukkpW1X8Ic+6gN8EXgU2N6r65yKC1PuYu4fTVll27a2oSI88Rr8CFsslfT/HhyPtrKXZQ8VqG3nbYJyulo1NGzRx50F
X-Gm-Message-State: AOJu0YwQFXpOeTWHTbK/yS7yNrW5UTN9wBmoXYrHmbZXsVr0wpvaHJe5
	s9iMMqIjAtHLgxRf9qSC1WEb9ujJAB99vYB1L7IQcnj0qYEcLtHf
X-Google-Smtp-Source: AGHT+IF0+lUjWw9EhBFKrOE4zaXVgzkR/0X1tbf634jBPSpb6+6LfKMESWMNlaDKaj7qZml7xCfhpQ==
X-Received: by 2002:ac2:42cc:0:b0:52c:cda0:18bf with SMTP id 2adb3069b0e04-52ea061aeeamr2904389e87.4.1720180046252;
        Fri, 05 Jul 2024 04:47:26 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367908768b4sm7169512f8f.79.2024.07.05.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:47:25 -0700 (PDT)
Message-ID: <f2c14cfbe8aecb3d87ab7bb8d00a5965742433fb.camel@gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad5755: drop redundant devm_kfree()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dan Robertson
 <dan@dlrobertson.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 05 Jul 2024 13:47:25 +0200
In-Reply-To: <20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
	 <20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 12:40 +0200, Krzysztof Kozlowski wrote:
> The driver calls ad5755_parse_fw() only from probe() function, so
> devm_kfree() during error path is not necessary and only makes code
> weirder.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>




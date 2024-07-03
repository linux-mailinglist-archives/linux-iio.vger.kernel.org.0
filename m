Return-Path: <linux-iio+bounces-7207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4999253CF
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC587284A2D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9C13210B;
	Wed,  3 Jul 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EmdcwCim"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6380130A4D
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988876; cv=none; b=ZTyYQswBG6cvYZihbuwqZCnMHpoArwkjgaMFpXVVFf8tkX6+7uORhxpQ2psYvorTtf0P8UgNOd7hVoB1vpzoV9/IjSJNntgMlh9AEZYlYZpzhupx60gyzHeXGLqQOwsdKzK5nAozxf5IdzFzFPC7Q69d1j4ToLUFBFIJVVza/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988876; c=relaxed/simple;
	bh=kBvPam+wtayiSsEsdaSLKUSxp572N6R2tEegVuUGmvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsJVHwyC8Vb8c7uIsB/a/SLLJZcvQMGIAcBsc63GOAXzisELhtSuUvGyeO8O7q5FZst9WAEmvE+JaOG2rqIEEDsVvIGwOMTqErMfw7apBbe9jR1gJQJEQcb8ww/vjgbGA2eI3vZCF8uEI0gWzpvrFZruqjeUbvgI0h10R5T/4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EmdcwCim; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80f5d511679so108410241.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988874; x=1720593674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+qfVxRO7lMpS4F3CssNI8YSPE1wk4OZAzwHLiNC6kY=;
        b=EmdcwCim1YOXEJdbayjVVT0+V8dWo6EOFKe9nz4UqBzqCx2n3WSJNx67oxYGosSoL3
         8tyxh34QPOuWU678IsCPjaNgYJBlCDVPs94ICazPsAYy9rEbFHbjwmdL5UICzu7KlBP4
         sJuvCaVSXnVYWs5dDB2zsHxxuj4uqR6NXkrsgGWKgM0Ha5wuguIFC3T+Vv7SH5hyLVWo
         d57TYhWASCfF6GLC1PIgezP7H81t9R9wsPZ8st0jYpk5enBk8lU86oa2hbeGWfM3Ciyg
         LYL8P5NF8hcq75m+rpywlSehzEu6uxD3cnVG/b61vkh98TafZwLN8t5/QBkLLI21h/0n
         /3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988874; x=1720593674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+qfVxRO7lMpS4F3CssNI8YSPE1wk4OZAzwHLiNC6kY=;
        b=LJ0IYrSBHsyBBjMY8IAkSXiYQvUGtaYIVuwqKhBUKeFYhU6NaUgqhWaGVe6sTjr0hM
         TwMYy9T/GwARULboSZ/UT+oDKLungeLvJhxkhABz647dtd/asdivwAG0qlhjjR/A0Ikn
         YjOUs1Z3Un/Nzi1kjc1wx3MSRQOM43SPPuzAgatMBRCoY/lm14wGK7Vv8pb/zgIjSoKP
         f64Wimrpwkwo5ERTaPTOk/rT60UgetIRcoyXNraObcc0715ODiQ2ECA3ywwLPr2uDFkR
         bZIVGwiEW9LiCUunhhqiBPC40R6S52ihKkbt6uTsCcgvVr1StlY8ofvaqEyUlcNH3/hR
         CPbw==
X-Gm-Message-State: AOJu0YwVOnX+WCQVU2RQkn6TMDYBn9EYF7trJE1pAU/FwSg1zV8MtIhQ
	ueZwKg3uezOr3uucf9yTdSKB8br8xlhrVx5IIY1sMhJFwh/S48mhuvB31OsXZWSyjE7sOEhHvmI
	wDjCK+4p1JpnrXck+VDjisv8LKN+0zoMbvN7kHg==
X-Google-Smtp-Source: AGHT+IH6Q0YmNOMEoKTlGeEUWjrK7NdshvcMztrcr/4H1N2bIOLPyNtsDH89Im/x3UHKPSOSeRr8A5vLzJZSUUt3OaY=
X-Received: by 2002:ac5:c806:0:b0:4ea:fea2:4b78 with SMTP id
 71dfb90a1353d-4f2a5318e04mr9726610e0c.0.1719988873784; Tue, 02 Jul 2024
 23:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-15-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-15-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:41:01 +0300
Message-ID: <CA+GgBR9U=qz6D2Q-shbauEEaRAF9db7qb-Vy7GiQQAGJw9LxoQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] iio: adc: ad7298: make use of iio_get_masklength()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:03=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_get_masklength() to access '.masklength' so it can be annotated
> as __private when there are no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad7298.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index c0430f71f592..0128436367db 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -109,7 +109,8 @@ static int ad7298_update_scan_mode(struct iio_dev *in=
dio_dev,
>         int scan_count;
>
>         /* Now compute overall size */
> -       scan_count =3D bitmap_weight(active_scan_mask, indio_dev->masklen=
gth);
> +       scan_count =3D bitmap_weight(active_scan_mask,
> +                                  iio_get_masklength(indio_dev));
>
>         command =3D AD7298_WRITE | st->ext_ref;
>
>
> --
> 2.45.2
>
>
>


Return-Path: <linux-iio+bounces-7204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFF19253A1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B12AB22046
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E888130A66;
	Wed,  3 Jul 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hJ3uWa75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C53412E1DB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988023; cv=none; b=LMxMXXWjY6uUzhAaNgZpIdD7Hq4kaq1sTDDzgHBdRBbymS/L0+pfMjrc2G+zknKM2VsSHj2FYell4n33og8vU4drFDl0P4aAh3nHganur5op/c1m7CPg4GiXG2bJAT/b90+XckXDxoJpBM9MZdYD+aNtzJxeQhw+JEKSEMW3CSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988023; c=relaxed/simple;
	bh=mNOyp5nt5YSj5nivXwurSKYbgySZf1yfj1skRNEAivk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8r1SeDQw0m9LB2HiL1CN8o0qq4m5dOqBvHnjPdSBKCr0pD+LNgOgFWjNtvNhYjlmQp89Q5RF1crStDgbefonVjMy9+zWgLLanWxXf2AbUKxv7nfBkD6+fE5Fwgj5i6Y5etgC3OqJSqlp7cVhMFkWSgC9R8ZY2CmRsqMJxeUNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hJ3uWa75; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80fe1e7ea8fso119277241.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719988020; x=1720592820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWNmlHwbvik2jfktevuXdcU+OyRMPbGqVNPwaYztXVo=;
        b=hJ3uWa7536jQIwY3t20da0Ij+LLH6nLjgxWkc+aB1M7bLcoONK42aQMjgtKNc6Tg3V
         sVydHsAz4GDgg3Yu1h4H1SxVfIOH4nVa7OZoXlQqRuzbSmnGm1qIlebJjgZa8C8m74/d
         VfIgEaWC3W0cF6P4+hScefVKFJhXBORzOGmLqgs5cohHuCWdo+EjV7jz6lGHjl4BIQv+
         alcDlDQJh/m994DMV3BqOaBy5gWhJ8O1tEPz1iUSoApIBY6dGaktl97ruiKbWu0/pU77
         gjCtnrZ5odGTvLHtt+q5UsIxAn4WHF2oru2sqdUaMiolJiujOti+wn0E6UQo6E4xqvxY
         DLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719988020; x=1720592820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWNmlHwbvik2jfktevuXdcU+OyRMPbGqVNPwaYztXVo=;
        b=CQ0a7DnCov4/zyrVkkRoNkH+X7RIoHVMzPdz0+JlJisQFGkghbjmXARyTMkqo5k2UR
         WlC9ZpfXTvEDDQ97K3mvUN7TjN0QmkpKppZmQia8y8bbZwr1iWIYubjYl8w0eZcUbIZ7
         q5QWOLFtlOvU0sBXVgk+RfdcUQ/sFCCeaajbFanPzpD5nc2oLGOqZ+k3H1sqAm/hH7jb
         gjPDLx5TAwGzT0rkiOevNIpP50Vcs9K/r0HoE8rIDO6NJxe9CLHf9EtDN3BYPnYxMf9a
         GRUJotd3jxIyILPBYGfH216lw3Hw2YmbcZuVeU04+WAwJTmobQbI7luZ6WHdeflpwQuU
         nU2g==
X-Gm-Message-State: AOJu0YyvtkX/70bFzwxXJCVXa3ezkqbADWDNlgsPR14A6UTaHaCkfz/p
	M9TFn3EeqPi4R7EXZl/zG404wNLLwWfwzctFzZ+a+s0NnPdnOfugFNNAQPytncojRc9DQvah9OQ
	Kyh1Uq9G5JVoXDj3pZP4VVv87JgjbmqikFV2AfQ==
X-Google-Smtp-Source: AGHT+IFUY3OQXhLxn/wAGRSfyMZhXQUVvO5Xb6CsftE08qTuXYM6tQItJApnb2zB5pS9urRkiT+bere4b5ywBs9xtFE=
X-Received: by 2002:a05:6102:5107:b0:48f:8cd0:832c with SMTP id
 ada2fe7eead31-48faef5ebfamr10426671137.0.1719988020151; Tue, 02 Jul 2024
 23:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-13-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-13-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:26:46 +0300
Message-ID: <CA+GgBR_Rn=phiaktV98LyaVaJjuwFRCdrPq23DyCMoWHOZgxjw@mail.gmail.com>
Subject: Re: [PATCH 13/20] iio: accel: stk8ba50: make use of iio_for_each_active_channel()
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
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there ar=
e
> no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/stk8ba50.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 6d3c7f444d21d..a32a77324e92d 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -330,8 +330,7 @@ static irqreturn_t stk8ba50_trigger_handler(int irq, =
void *p)
>                         goto err;
>                 }
>         } else {
> -               for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                                indio_dev->masklength) {
> +               iio_for_each_active_channel(indio_dev, bit) {
>                         ret =3D stk8ba50_read_accel(data,
>                                                   stk8ba50_channel_table[=
bit]);
>                         if (ret < 0)
>
> --
> 2.45.2
>
>
>


Return-Path: <linux-iio+bounces-7200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12192539C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BE7B2175E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D0130496;
	Wed,  3 Jul 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iih4tMJd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE761FFB
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987952; cv=none; b=acihNXK+Hz0+8RhHm7H6oyz6c+FPiDaQhZUKpjsGHLp0Qe1neOR3pGFMAWj970rQWLS+88KAHZknJdkn33ybXqKlewZ+Fpo40wfYG/csB3fDW1saoN5a5HLO7U51U0Q/qj5/unogAm3qA2VCE8hhgNstwIfqlKrqqU3lgxF0BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987952; c=relaxed/simple;
	bh=V8ELZwvPStHN7XtCJGOkalWpd40eiTtMCjpah1Ju8hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqNcJQH/LjopCPMTFEvoJZWJrQo52hOWLxxkAm4asjf7uYln8+DR7sQNOZ1faj9pbHcDO545u3PrCNFq6Sg17YDtEKSyn42c7p0Cr9p+bv/cQl/sVgEFYpN9ITGnWtJdu1Xvwec6lj0vNhPiTsZ/f21FuiGcQTfaURi+exHlino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iih4tMJd; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48f428e0740so175686137.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719987949; x=1720592749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFaaWFettnsz/DdIfBTX7g1ECK6NJ71HmUEH6b4ppNs=;
        b=Iih4tMJdV2aVhmpLlYw5ylpOliiuJDTYZkC7m8YiP7OHw6rSy3fzvKIvND6l3No7OR
         +E0uQl4w+w2fzL9AWm22tGxKs9+dY/Pm4g7D8H6y0DWPaB+FymLSAlecq9eK5Cm6YSO5
         rC33mitDmV2h+aW+l7fZtdQwtOkx+vcHN+8d8RRywzoyGbnhCbJdR/VgH8LIqb7kT4a/
         I88PslAy/nfqge8PRJ8zg5oFLNZM0ceHncen/s6RREFyIPAB9RPqk+nitNNLXaCrFOQy
         SD2lo9lJGs8/Hdw8LPTT1h0XGZx3bHBBNJJp+XGYvf5SRzZ42pZ3SG5/ogX3jwYeODyG
         xYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987949; x=1720592749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFaaWFettnsz/DdIfBTX7g1ECK6NJ71HmUEH6b4ppNs=;
        b=Enyi1DpaV+dcCKTwFyHyjeqy5ox2VUjHnRcpXJiG4qrWlUhhoZN+ngXLgjmNyf5/aj
         qoQkiBmeRHUuV/GeNjI2mgpIMVO7+dKdK3A6vXSq0fycAGe9fGgygiaXGbOabxxgGg/h
         FySzCJM4xZfe8cVDS5o738X7qYBhqcZUBRP4SOx3z9z3hIAkJqLFQq8owWwMRilGQFgJ
         tDKnHEWb7nsxWXLo6wzTzxCi/rwLKKPWSBHizhwIv8k7NMKkvVyJeDdZGV6qK5VH/1BT
         PwFe9jmWaeE/nX47hROocZsb3b9VfNzJqNdUubsqOsbI1ff9SYdQGlr4j4O1r6mI7xHj
         afBg==
X-Gm-Message-State: AOJu0YwPe8Cqm6acrdGS1KnVdI1MOaIZJndoA2qhRZCEO0wsKIIdWFH1
	D8hhTZiHOEbSHLXvH5AmLqBZxnjnt25S2O4gi4deue2tn5HvlvPztgeXw94B5hfJjYhvf4NzoQ+
	wqMSM8VytcF7+XvVjkOGDB+YihACQabYFfKBGjw==
X-Google-Smtp-Source: AGHT+IGObAsAdZCKi1a7+byYQ8mnkYslfL1K9ff4GGvlkclRQwUCAOn/metQfKX8+qRDQYMW+idWufXuEbjUv1x5+rw=
X-Received: by 2002:a05:6102:418e:b0:48f:df2c:6d5b with SMTP id
 ada2fe7eead31-48fdf2c7245mr723867137.2.1719987948849; Tue, 02 Jul 2024
 23:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com> <20240702-dev-iio-masklength-private-v1-9-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-9-98193bf536a6@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 3 Jul 2024 09:25:36 +0300
Message-ID: <CA+GgBR-x2RHT45Bp4D5VC66JAdZj_dcPRPVUbZMwALFXeA7m6g@mail.gmail.com>
Subject: Re: [PATCH 09/20] iio: accel: fxls8962af-core: make use of iio_for_each_active_channel()
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

On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there
> are no more direct users of it.
>

Reviewed-by: Alexandru Ardelean <aardelean@baylibre.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls=
8962af-core.c
> index 4fbc01bda62e4..7adb8937cb4b6 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -968,8 +968,7 @@ static int fxls8962af_fifo_flush(struct iio_dev *indi=
o_dev)
>                 int j, bit;
>
>                 j =3D 0;
> -               for_each_set_bit(bit, indio_dev->active_scan_mask,
> -                                indio_dev->masklength) {
> +               iio_for_each_active_channel(indio_dev, bit) {
>                         memcpy(&data->scan.channels[j++], &buffer[i * 3 +=
 bit],
>                                sizeof(data->scan.channels[0]));
>                 }
>
> --
> 2.45.2
>
>
>


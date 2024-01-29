Return-Path: <linux-iio+bounces-2029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFE841389
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F099728A6F5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14760B91;
	Mon, 29 Jan 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hwuprVcp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA6179AB
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556720; cv=none; b=h/R/+pt0+dirDUT+aePCxXhql5Ib9jav1A1dcd8tKt5gTu/pxRWc1aTCkKPUgFTwWv4zYzvRFT5doYVPwMYpZuQgGtrOhpwYvzIG0OAZIagsPbIWKqKOCN17soTCm0yaybsa1H17sEj8cZsjPBznWcJ3iEIk8dcl4hsccJQRtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556720; c=relaxed/simple;
	bh=IsB9JY/4AyjDEDK/QCSn5bRVf6sdMPgHiV31yELbmAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1if8i9l9BoGCurdb7rjA0omJs0xSrvcK0VkrcOhz4xjaFaptWaamr4EwX3CuKPuDKFiG22c6g4tyLKVyToxYnqrdylxpUOk06kunpl1qs28Z+BXy9Tfne76EaEDGXzY9D6mv41exTNosol3hq2UHflwCoTQjvf9RsCNYRaZKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hwuprVcp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso35737431fa.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706556714; x=1707161514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ9m1/F9S8yFHzEc2XLsfrTvCTLg95PwiYcPzfrZs1Y=;
        b=hwuprVcpL9KbL5FWEvgOzJ4WtD49Z2mB3cqO+9mVuZVtjlzyWzQQMgnSwvyXNUPdnI
         EIJn3awvfliePFHZFa8+Xk3vhQbmX+FmhyCnctkOg5ussmt9xBIo9LZ6ROpckJHrs9eM
         Gb1gLALA99MuyXxCf8a3S7upXv8CI10nwm7tXr9eFEWpcgHMzaEC3CJbx5IV0ucLQ+Qh
         /SSqdqK4a6AerB3xDbQw5KsTfPDzsAYj68fXmFONqrquhj3WU3lCzikZrJ4E5bEnMeAd
         Z38FBzsCGcznkbDIbX1uy7hMmoaW8xsvHzU139vedKXagsSc2l89Tmle/U/9FMoUlx+c
         l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556714; x=1707161514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ9m1/F9S8yFHzEc2XLsfrTvCTLg95PwiYcPzfrZs1Y=;
        b=a3rzflMi6O6RbYc934ty5iQdVjpIjN4YWnGp252a/T7jcf0YeltsOQlCZQa5P/fgPb
         20pdIl+8CDBljNLWh9HwMKPvjHrA7QEL19TBpciXhJUnh0KjnYLJD1lctg7rYpW7mFJt
         39zeMSW1WDyfcu0ucuYV0zd1QlQXmlGnsPaL8twN5VpfeMZtXpaG7FsyCOipX7NvWzsd
         rooDsHNkmBAnFj8qLVY1Zf6HnC3Ty6TWolnwW94FW6RM3P3MOMMmDupMQdVzbPamzd5P
         PkrjmUx4ydQKA2WMAgOlrv8goxekTn2KdthJXSjyNKT5IYmlYz8GE4Ah7V/o55SF196g
         1x/w==
X-Gm-Message-State: AOJu0YyJqWhN/DazptkG/E6UBLsGIk4PM8eIYFAuGAEnAkuBdEY6Ccbl
	l1u/MP9oSxnmBuSvPHvtCU3ltaagBSNVJsY2up2u2Jk1SwGRJk4ncad0Em86YULFL7j+DbJMKpm
	nyFyChn3c7KzPEu4yOHIbkJnahk1XRgEFGFbSxA==
X-Google-Smtp-Source: AGHT+IGlu3Tiw0qfV0S0tzXwqX/DkfK4vLT52WlR8EOqoCU/BIhR19RaJuUD1vdzsC5LVh4+FOq0hRyfxHc6Io8v9Jw=
X-Received: by 2002:a2e:a99e:0:b0:2cd:fafe:1893 with SMTP id
 x30-20020a2ea99e000000b002cdfafe1893mr5696137ljq.4.1706556709852; Mon, 29 Jan
 2024 11:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129174150.655088-1-dlechner@baylibre.com> <20240129174150.655088-3-dlechner@baylibre.com>
In-Reply-To: <20240129174150.655088-3-dlechner@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Jan 2024 13:31:38 -0600
Message-ID: <CAMknhBGEm6EOFf17xiYf0+h0JNS-NtfW3GnpsUc9e8PxCZ7tVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: don't use bool in FIELD_PREP
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:43=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Although this technically works, it is better to avoid using bool as
> a bit value.
>
> Fixes sparse warning:
>
>      drivers/iio/adc/ad7380.c:353:34: sparse: sparse: dubious: x & !y
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@i=
ntel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 44b8b18ab213..a4aa0db47720 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -350,7 +350,8 @@ static int ad7380_init(struct ad7380_state *st)
>         /* select internal or external reference voltage */
>         ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
>                                  AD7380_CONFIG1_REFSEL,
> -                                FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->=
vref));
> +                                FIELD_PREP(AD7380_CONFIG1_REFSEL,
> +                                           st->vref : 1 : 0));

Somehow managed to introduce a typo between testing and sending. :-(

Will send a v2 with the fix.

>         if (ret < 0)
>                 return ret;
>
> --
> 2.43.0
>


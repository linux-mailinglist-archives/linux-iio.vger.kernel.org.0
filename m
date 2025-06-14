Return-Path: <linux-iio+bounces-20667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A9AD9F80
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62A118995FD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDEA2E62DA;
	Sat, 14 Jun 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7BPwGbH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476128ECD1;
	Sat, 14 Jun 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749929610; cv=none; b=bzQKvW/KZuBePyDzjX61ZAXOvYSB3ljmt/BgwHYCBCmh13PGDVkKu+qXRaTVprWI4cZxTnJg6Pk6DEP8gbuuyYW0ptNmiG/hdLkXmxPRKvvD9A6IWc4fbBQCcLBPopIFCbbpdpjhTBxWtb4y/8+XuBagHtrrPLFdnzCTe/PipI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749929610; c=relaxed/simple;
	bh=OAVfKONggzU+dmKqGEkisjGgRwhcehITzHF2G+T0+/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+iKQAEuP6fqOpfLaXJlzbomlgbsJZxOha3qKOV12s6i3Sasc+j/v6pu+tNnzgsovtCd5s5i8xPw2tUz4gvN+rI/pe6LVtAAuySwc0hrfa6m+yzc0m+T+f7sZ6V1oBwcPsur74QFJfTOoKKDu8jdenyNE92KDa7iY6wLhL7UN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7BPwGbH; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52f404ddf3eso1924271e0c.2;
        Sat, 14 Jun 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749929607; x=1750534407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNGXpC5kas4n5SJyr8V6i+qiwzOxYpqyu8TzGGg4bK0=;
        b=K7BPwGbHbTDPuRiux2/8y+8uO4SM8z7CxkLOJGWwvMMKptNpqx+6deHUQgewOVNRrZ
         suonH2SLQwKXjmZcCaqjilR1uFsnskmhtJ8C4Mb1MbCbI/K+svJBBbleINa/2bgTilkv
         Zv5KgFRYwGxs66bn7fs4gDcCgbugOCmV58yqw78gMxOeTLSBA12ZNmjIyVrpmYdkyc93
         po5uGFi/6ZsblkzaKnKv6EzN4EKjvxWiwrJNBB+CTOtzgRD9xrQyVZ6Cg7peWgy4v/F1
         nePGGMphZAYtZ9C8ve6KmtzbEnV8px1hxEUSoK17YoQ4YV5JJa0y12N4hbqfyZZx9r2j
         9GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749929607; x=1750534407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNGXpC5kas4n5SJyr8V6i+qiwzOxYpqyu8TzGGg4bK0=;
        b=nW03SKUz4rNW2iVTUqgUzp/i+5MzgTkslHrDHe+vXxalXaKIVn4fxflYv1BdMs1ZE/
         YGtWqaFcAZ5yGcP6du1As4oc8REJDrgZwdxiMR96G0wC+vMC9byADOxS2F5yXGAEpHr8
         xZyk5D4BQsYarL8ZjmcG53ucZLxeely6s3RK1O4UgIM8wAjvVurOkBDK+9eAEBUJKcFY
         tW4iKGEwhnHHyfkaYryU5U9h4AEbZAZnXiy63E7dHAEFPLcUZZDIG6dR5VGDNY05CeYs
         i2pecvjVbA7t3POvOd2gUNZu1YCl3bdQGboPCf8ldMthAbcbP7ufppyRcM6p7gXQ5p1N
         Kwjg==
X-Forwarded-Encrypted: i=1; AJvYcCUCFDek7nHtY7hp4aarUPOpqBeZ8ESL8I4ZqCH62tWY4iAcY701pom/pSG8ctqB4ztmJ4pEuaWhmuyoZ81d@vger.kernel.org, AJvYcCW79iQvFPVddINHL141uWSQ1NQI1O64vkUsrj8KAZ+feXDxNWzWBK++335O2a91kow9ATSAwgxeaOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXj5rEd8maEWyAJuMptSx+E1X/6VAyoXwlgzAPe1RFFtAgfvu
	PBqVP+6H9AgxQBbPNvdNXWzgEl0ndZmaT5F67HycucgmXO9s2FhI39gqV20Yprq9vEiIi1hs9qW
	FpM92jNU5/LyBQ2bIwxoIt+X24JOBzGg=
X-Gm-Gg: ASbGnctY7pbFpx6krPbmK9ykIApXsoXnU0EeO5su/vYFfc3HqplhxxaZs0x17+vBVA3
	DvpfSNE9Lo3V1+v+RUrgEgzqAqrXgaTHa4So6JWTWSPRK/36V5wUGPsfgUZAQQOWsZZ5rsLX4QF
	XkY7cJUcKxcZ8x7o5enYWw/0qTZlNIQ5liWorUEkOUAm/UifLcLIoNAZRhKvfnkoZPl5OC
X-Google-Smtp-Source: AGHT+IHQnrU7gvoFdqovBLFEntI5ZkmO9ocDZdqzpWzXKWYeqVzxwq8p+gEidCrgqcf0dmnVqEWgGv13EzS8Y1NaFn0=
X-Received: by 2002:a05:6122:3c56:b0:531:39a3:e94a with SMTP id
 71dfb90a1353d-5314990a40emr3305712e0c.7.1749929607214; Sat, 14 Jun 2025
 12:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br> <84643f3fc87425e8c5019eede275791a20872b6b.camel@gmail.com>
In-Reply-To: <84643f3fc87425e8c5019eede275791a20872b6b.camel@gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 16:33:16 -0300
X-Gm-Features: AX0GCFuPE__RH8t0eijk0cCHgSSD6kemEnwAwjjLwzBIMK1qASsiBQ3lzVNUV1c
Message-ID: <CANZih_QY5ki3nCGDitE-6FAmDi_dgc04WE_QqvOFwJeu912SVQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:29=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
...
>
> Looks good. Just one comment from me...
>
> >  drivers/iio/accel/sca3000.c | 166 +++++++++++++++---------------------
> >  1 file changed, 68 insertions(+), 98 deletions(-)
> >
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index bfa8a3f5a92f..d41759c68fb4 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -281,24 +281,6 @@ static int sca3000_write_reg(struct sca3000_state =
*st, u8
> > address, u8 val)
> >       return spi_write(st->us, st->tx, 2);
> >  }
> >
>
> ...
>
> >
> >  static int sca3000_read_data(struct sca3000_state *st,
> >                            u8 reg_address_high,
> > -                          u8 *rx,
> >                            int len)
> >  {
> >       int ret;
> > @@ -974,18 +948,15 @@ static int sca3000_read_data(struct sca3000_state=
 *st,
> >                       .tx_buf =3D st->tx,
> >               }, {
> >                       .len =3D len,
> > -                     .rx_buf =3D rx,
> > +                     .rx_buf =3D st->rx,
> >               }
> >       };
> > -
> >       st->tx[0] =3D SCA3000_READ_REG(reg_address_high);
> > +
> >       ret =3D spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> > -     if (ret) {
> > +     if (ret)
> >               dev_err(&st->us->dev, "problem reading register\n");
> > -             return ret;
> > -     }
> > -
> > -     return 0;
> > +     return ret;
>
> Unless I'm missing something, the above seems unrelated to the rest of th=
e patch.
>
Oh, I can see why that might feel unrelated. Actually, this was
related to the first version of the patch which was focused on
removing the duplicated behavior of sca3000_read_data() and
sca3000_read_data_short(), unifying it in only one function. Also,
with Andy's suggestions we cleaned up the function as you're seeing
here. However, we later replaced all usages of
sca3000_read_data_short() by spi helpers, leaving just one place
calling sca3000_read_data(), so this change isn't as necessary as
before.

Do you think it's still a valid cleanup for this patch or would you
prefer moving it to a separated one?

Thanks,
Andrew


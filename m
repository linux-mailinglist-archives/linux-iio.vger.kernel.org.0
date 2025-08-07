Return-Path: <linux-iio+bounces-22411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5003B1DE9A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECA2584A31
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029B21147B;
	Thu,  7 Aug 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXyR353J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC328145B27;
	Thu,  7 Aug 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600618; cv=none; b=ojyh60A17taXpOWyakNiOjF48nVLKwuaS9WHOw8v7guvOaF3IN9POIwkKJLM+AUDZ3d7sYa7C3MND0btPje9LAIUYoVRHmRfh6rtVTf2fnungntpp1jM53StYHkMI/uRBG7CWv2YcnUONJGafy49m79rDe2184BqdV2GIe7+UFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600618; c=relaxed/simple;
	bh=C2ka/i9O4z/Lm6KCfODZilTG9xf2MEUZFp5/I6xqiuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WroutKtoBVyAHXgdaflTybSiWezbQQZW+EeRXqOTQ0jCGDus4ucHhk00auhch5J0TGi9dQIcKagFDjLMpNtF8Y7mS4k+b3HXkCBLBCNX2J1INsGXjEe5gY6TKhHFVoIK/H4lUPzkmgV1QjQbPUnIvdIB3vhA1cymQgCpbYFNQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXyR353J; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af66f444488so224226266b.0;
        Thu, 07 Aug 2025 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600615; x=1755205415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7gh6/dkJuAqQrETkPUriZg/rzrA25/MmM5b66PZwnY=;
        b=GXyR353JOqczLjt8t8ZzGykMSEX4y6aMm6WzOnu7E15GrfraHoe+9Mc3qGftjiS4fJ
         umQuRbn2QbP8wtOTp7hmySlEoiaP8/jeF3wHtV6hsIv6BKAr79UdSUtiVMnYKM4gKglN
         xkBCBvO0f6XWwUDXSNfIsWcLVrCnZXTe0aAfg7Ei9/aIIbdsV0zsHxa3B0JOEXR/8HJR
         KvxS+KonidZO/l1d3uqcNt1pjjpVmCkyfwj5bDlsRA5heqRR9WTYAxia1VJmB/5iiI8v
         qrPmUb0GZ70mJihBeBH8xaMUl/FcI0zt43yLRvlv08kfTroFDmAmu7Ds252MBexJmQsc
         vjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600615; x=1755205415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7gh6/dkJuAqQrETkPUriZg/rzrA25/MmM5b66PZwnY=;
        b=r0D1O7HhuvEFWeZTe5+rQjQ6TZgmHiXUDs1jQbR4KDdqIacKrlCMKehYvxERO/wAxH
         ZWA9nBG7G7vOuZZRg3DIpA08d2H6dgquwAx8/cp2ZOyGKUgo+2ssIY+0ijKa2/lDJ6sM
         ExO2FgPiVCLTo3xjmOOJPiueQq7Xu6q+8uHLhCnrVZZQc7kfucpwQMLynuGNFYCu0x3R
         6c8b+yYq9DnbxTRUs4ywvxNZXKttQTTljaQtrFarowhDx4p8ynYAnEFYhGhXjJecQ6wT
         VVXJnMbCaz2EejfX9vbaFrUFqYr7dsKAUSf3Awk6036xjdLY5TELvl65NmyqM3iYPaWh
         dY6g==
X-Forwarded-Encrypted: i=1; AJvYcCVi0TbDoW/SOw+FLlaBX/ib0ToK7GS3VJyBpmHuXFM2ZjGKkP7K/SyAukIciB56Qg+c1vYbICDRbCNl/3VC@vger.kernel.org, AJvYcCXbMLSK9MhpgB63yam/sXBh7qMAPfRbi1usRzqXawwV+4hoVWeWRElm5EqclCZNB6eQEiin7+UMFd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EvOoz4jFzVLb+ougqiVdiHaNX3qszz4JIZGPL6wa8915RSI6
	crwMldZyoAbFQM2tjSo8rhEC+vccJGFW/13iqwiPTrtLhQsk1QTzQTOxDgNiStzm3LQFCgfJkzf
	muhrpYPt7NqXVFbyFl1RBNM6BDU49+rI=
X-Gm-Gg: ASbGncs1OnmJPlNs9BhyGW9zvHoizxDB0c2ePcWgFIGdcULJEg7Fa16+3mh07IzkJ+z
	NtnEnm23Tc7gz16VYM3AU80Z857F67KmHRXu3SCgYqo4B3L4w0AyRzh2SgdyJ7A3MEhSASLGt5Y
	Q0ekyYKpNk1i0J3YB0H0XFbQSfGmbzr66qYVq/JwT/aIr4HSSI3O9D1bY+v497LQ6fIoiJPcxr4
	EqY1neCIQHHMwuKuSAGod2Q9iEH8LfQeAUQSyrbWQ==
X-Google-Smtp-Source: AGHT+IH5zrOcMUHWMxEqysuw2N+2xJn0qPbo/D8z/ljWKqKHFw5vJs6hKTLqhk5J93Nm8BjRIbj6ZiKGSaxY+NVJz5c=
X-Received: by 2002:a17:907:da4:b0:af9:3d0a:f38f with SMTP id
 a640c23a62f3a-af9c6086b26mr41580266b.0.1754600615167; Thu, 07 Aug 2025
 14:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJReTh-t5D45aZNV@pc> <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
 <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
In-Reply-To: <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:02:58 +0200
X-Gm-Features: Ac12FXzkTpOyXM6pkdEyyKM7WRhOKps98LBgWEFbwG0O6IBt0HKEVIuQ70Gdi_k
Message-ID: <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:01=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 7, 2025 at 6:03=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> > On 8/7/25 3:05 AM, Salah Triki wrote:

...

> > >       ret =3D __ad4170_read_sample(indio_dev, chan, val);
> > >       if (ret) {
> > > -             dev_err(dev, "failed to read sample: %d\n", ret);
> > > +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(re=
t));
> > >
> > >               ret2 =3D ad4170_set_channel_enable(st, chan->address, f=
alse);
> > >               if (ret2)
> > > -                     dev_err(dev, "failed to disable channel: %d\n",=
 ret2);
> > > +                     dev_err(dev, "failed to disable channel: %pe\n"=
, ERR_PTR(ret2));
> > >
> > >               return ret;
> > >       }
> >
> > Interesting, I didn't know we had this format specifier. But I think
> > this is something we would want to do kernel-wide or not at all to stay
> > consistent.
>
> I'm sorry but I didn't follow. This is a kernel-wide format specifier.
>
> > And if we are doing this in more places, it would make sense to have a =
new
> > format specifier for integer error values instead of casting them to
> > pointers.
>
> Will _very unlikely_ to happen. This has to be a C standard for that,
> otherwise you are suggesting to always have a kernel warning for each
> of these cases. The only way we can customize specifiers w/o
> introducing a compiler warnings is to continue (and still carefully)
> using %p extensions.

And to be clear: I am not in favour of this change exactly due to a
bit weird (for the reader) castings just for the sake of use of %pe.


--=20
With Best Regards,
Andy Shevchenko


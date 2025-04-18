Return-Path: <linux-iio+bounces-18245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139A7A937EF
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557C73BD255
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF427780F;
	Fri, 18 Apr 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKyKlJ1R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00F72741C8;
	Fri, 18 Apr 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982909; cv=none; b=IiFy1hHTMvDITIN9NOrB5wVrkqVHMdflrNRjj1Vrinm4rEHhWFHKHy477ts08wBcbpikOtRSyf+8lrU5AoalP4XpvV4Z7WlNm3Z+wEsVP6sEgta5WQ22fMAwMnLqCgL/fLKATIOsnOUJhe5chKIhhYODoaIOLHClHbWGpZljfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982909; c=relaxed/simple;
	bh=py3qpxPQ4hvohMsFadRBuBilUYS8IpwzxRxK3/vIQIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew1R+xJBXBcgLwiXHErBXf4jI5BphvgwQAo4FciKXaLDIdLUTFvooiVFtyR0PX/G0g+ouaH5tE1OUHzf8TPrXJZQLpTH5lN5MDa0N4LbPvuR/LnwizZqz/pz0kif5tAF34X3hFnjHms3mjYdliiMy685EYdI00nTqZBp8FY6nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKyKlJ1R; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ab588f32so25170081cf.2;
        Fri, 18 Apr 2025 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744982907; x=1745587707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2uvF1gnZo1hDkMDMb6IsHjvK5NSRplkTI6q5lCw7lg=;
        b=kKyKlJ1R/PglJ9mVlPAwkiU4I2pP148q458319+/oRuM2ysy1roHfOlz65RAnyPRN2
         TCZ+dS0W0o4winIwQYiypBJ38XyerG49ZzjcAjtm9rwoL6Yie4AScvExcTPVOMyf4Afg
         YD33ELpQXW2Ea/zkrfknqP2KqC8QpgW/Xgm1MX/B5ZpR5urTxp3NyY2A+tR4T+7llBkP
         xc3VYiDOwpWVFGBn4hM8vXcaGvEMuau2Z7tByrtsvAqn8bSKP2iLVKdyz9CRar3FddvE
         pHCedN2MajR4vYS5VX+RVitw76H1pIUega6W9PkQHUc209/DPFN8nARECC0jfuJJNonA
         Wzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744982907; x=1745587707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2uvF1gnZo1hDkMDMb6IsHjvK5NSRplkTI6q5lCw7lg=;
        b=wJT1OOy5hN9Xrp6Qzynz78VGFc3g56u+IW+lHgDl8C7r98kBkn7tIb1p0M1j/JhH/t
         Zv6H9YBapmgyYeWqoIWJAj5KKzr1+W2mtIdila5cyb6zKZG36Kl8b4un5wtpIcyUkbE0
         a2c0rmzZnbF+PYReP+349EvS03WwsxWf0YdIT/NO9fypU/XBE55/F5mSc6L6md8eL7YH
         GvxtJospUuINgGczHPA0jz90a6Z1kDUoVjFWSXZ4XN7OV3DD1b7vFWFuw7xlL12/cbQt
         UdlN84IJ6TIVPf0BJL+/bJlC8Op+XNxHVJ3wK5IZ6ze10NuOeiAnTp7viK0EE3zvzJiq
         5Vjw==
X-Forwarded-Encrypted: i=1; AJvYcCVd0ZyNzbuc+7/YJSqaTkRxEjMS0MnG7/QWWEmO2gTNxd3J92MKKCTfMgk9Bs2rOGKBZTOl94ldAdk=@vger.kernel.org, AJvYcCWP1yGiXiMDj6DjKkMrh7scbFGMRA6PPH0qtPI/6C7MYQJ73MU9Y7sCR/mT4s51ukJ7ULMyLoIN@vger.kernel.org, AJvYcCXYP21iQZN7ESLt4o+8PSfmz5Kf3adqW03tAS5kdqoYVXWXSEwEGFOXre/HLsen4NmU1juBqUFcw2Jof5c0@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2rePaQA8AvUFQ0atsR4Ml2wJzhd2gKDmcSokJNVLWRl8iPR7
	mfOCd1C1Q3aEEHwM9W6XW8+3xoNR7X87lIK66i5lfoUOmmSm2nWLLMMFv2Y9L9UvLf4Dud76t31
	vUvE4G2FF7januXSEGmZ4EYZlL80=
X-Gm-Gg: ASbGncvMAm/8NDim+f5y7xyk/8D64Fm/XUGiTnWTAaFYuHkvZ6a3ugSQ2eyJ9bD9eH+
	hAkGc9x0RSmjiGKVPv1s4cEiobX4jcRmhoE6hFSwrOTsYU27HniFktzvZN43z4hdNRfYhTMqmFW
	Iz9TIzab8+eGgwA7SrY3s69oZikBjubCQFYiUhSJqen2NBrt8G+wxr27sFDygcIDY=
X-Google-Smtp-Source: AGHT+IEmOwXK2LuFYh7mE9FoPBp/KZqYGGb32Mvs7/fzuBy/q27GbvhH+PteT6hbPJHJRDNP83snG0RBgbKpuhxHmk4=
X-Received: by 2002:ac8:5916:0:b0:477:1ee1:23d9 with SMTP id
 d75a77b69052e-47aec3a7331mr45873521cf.20.1744982906523; Fri, 18 Apr 2025
 06:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415182038.523186-1-gshahrouzi@gmail.com> <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
 <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com>
 <e8b24cf22c87e5b5ce0cc8919eca79f6e60ab6e3.camel@gmail.com>
 <CAKUZ0z+FKxHcYTYiGvrZ3RLiMKT1P4gtTdq8d7=+ZFC0RMQzqA@mail.gmail.com> <a32503d98ffe162f48de019fab1a37f86af1666e.camel@gmail.com>
In-Reply-To: <a32503d98ffe162f48de019fab1a37f86af1666e.camel@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 09:28:15 -0400
X-Gm-Features: ATxdqUFv8S2auULHx0FcuBh0UZ0zXdklaGc3PXDOV667MRhIxOk_A11J2oTI0ic
Message-ID: <CAKUZ0zJK0MtMBMWaUCsF62vxc87XoN0xhJLfCcUZ84XNX-kKVg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	sonic.zhang@analog.com, vapier@gentoo.org, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:46=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Thu, 2025-04-17 at 13:08 -0400, Gabriel Shahrouzi wrote:
> > On Thu, Apr 17, 2025 at 10:02=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > >
> > > On Thu, 2025-04-17 at 08:53 -0400, Gabriel Shahrouzi wrote:
> > > > On Thu, Apr 17, 2025 at 6:06=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > > >
> > > > > On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> > > > > > According to the datasheet on page 9 under the channel selectio=
n table,
> > > > > > all devices (AD7816/7/8) are able to use the channel marked as =
7. This
> > > > > > channel is used for diagnostic purposes by routing the internal=
 1.23V
> > > > > > bandgap source through the MUX to the input of the ADC.
> > > > > >
> > > > > > Replace checking for string equality with checking for the same=
 chip ID
> > > > > > to reduce time complexity.
> > > > > >
> > > > > > Group invalid channels for all devices together because they ar=
e
> > > > > > processed the same way.
> > > > > >
> > > > > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 =
devices")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> > > > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > > > > b/drivers/staging/iio/adc/ad7816.c
> > > > > > index 6c14d7bcdd675..d880fe0257697 100644
> > > > > > --- a/drivers/staging/iio/adc/ad7816.c
> > > > > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > > > > @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struc=
t device
> > > > > > *dev,
> > > > > >       if (ret)
> > > > > >               return ret;
> > > > > >
> > > > > > -     if (data > AD7816_CS_MAX && data !=3D AD7816_CS_MASK) {
> > > > > > -             dev_err(&chip->spi_dev->dev, "Invalid channel id =
%lu for
> > > > > > %s.\n",
> > > > > > -                     data, indio_dev->name);
> > > > > > -             return -EINVAL;
> > > > > > -     } else if (strcmp(indio_dev->name, "ad7818") =3D=3D 0 && =
data > 1) {
> > > > > > -             dev_err(&chip->spi_dev->dev,
> > > > > > -                     "Invalid channel id %lu for ad7818.\n", d=
ata);
> > > > > > -             return -EINVAL;
> > > > > > -     } else if (strcmp(indio_dev->name, "ad7816") =3D=3D 0 && =
data > 0) {
> > > > > > +     if (data !=3D AD7816_CS_MASK &&
> > > > > > +         (data > AD7816_CS_MAX ||
> > > > > > +         (chip->id =3D=3D ID_AD7818 && data > 1) ||
> > > > > > +         (chip->id =3D=3D ID_AD7816 && data > 0))) {
> > > > > >               dev_err(&chip->spi_dev->dev,
> > > > > > -                     "Invalid channel id %lu for ad7816.\n", d=
ata);
> > > > > > +                     "Invalid channel id %lu for %s.\n", data,=
 indio_dev-
> > > > > > > name);
> > > > > >               return -EINVAL;
> > > > > >       }
> > > > >
> > > > > Hmm, maybe I'm missing something but the code just looks the same=
 as before
> > > > > (from a functionality point of view)? I'm really not seeing any f=
ix...
> > > > I might have to change it for readability. From my understanding, i=
f
> > > > channel 7 is selected (AD7816_CS_MASK), it never enters the error p=
ath
> > > > whereas in the old code, if the chip were either ad7816 or ad7818, =
it would
> > > > end up returning an error because it skips all channels above eithe=
r 0
> > > > or 1.
> > >
> > > Ahh, right!
> > >
> > > One good refactor is to add a chip_info struct (renaming the existing=
 one) with
> > > let's say a name and max_channels. Then, the condition could be reduc=
ed to:
> > >
> > > if (data > st->chip->max_channel && data !=3D AD7816_CS_MASK {
> > >         dev_err(...);
> > >         return -EINVAL;
> > > }
> > Makes sense. I sent a V2 with the updates. Also included enum
> > ad7816_type as a member for chip_info but not sure if it is necessary.
> > Renamed the existing one to ad7816_state.
> > >
> > > Being this in staging, I guess we don't care much about having the fi=
x as the
> > > first patch to make it easier to backport.
> > In other words, combining the refactoring and fix into one patch is
> > fine but normally they would be split?
>
> Yes, in theory we want to have the fixes first before any refactor becaus=
e we might
> want to backport the fix and we do not want to backport more code than ne=
eded. Not
> totally sure but being this on staging we might not care that much about =
this.
Got it.
>
> - Nuno S=C3=A1
> >
> > >
> > > - Nuno S=C3=A1
> > >
> > > >
> > > > >
> > > > > Having said the above, not sure if grouping helps with readabilit=
y. But I do
> > > > > agree with moving from string comparison to use chip->id. And we =
also have
> > > > > redundants 'else'
> > > > >
> > > > > - Nuno S=C3=A1
> > > > >
>


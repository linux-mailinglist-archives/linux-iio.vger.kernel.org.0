Return-Path: <linux-iio+bounces-18217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A836A92382
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A1E1B60974
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38D2550DF;
	Thu, 17 Apr 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKmwGtAX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45919DF9A;
	Thu, 17 Apr 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909755; cv=none; b=KQCJWpeH5um9s0UOfkMcFmtT2C1PUa8orxSdmQnOodLtm6ZPdQ+rEdwBDw1MH9bknax2twdu2GRn/ndvtjmOQh8UvVgYBYMDru3er7SW76nYnZpZdEt8tgrAZzZnwml87muCwwdLZThOHrnmzHPWvXjugjP27oPxz6JZyPQrosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909755; c=relaxed/simple;
	bh=cL8O9si/E+RgkCImblOqbPznISwWiwgiE1yb1CY5L44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCFtBwU5YIdUywv62PP/dY8Eow3qhGRiskrYDImYilo2WQx27M03918hTTUnJNQM2n4DWIiKeMiiyuTotkmJBOkg3eFq+G+Z/KmJnrcxaq9Vuagfy797teeW6N10MNets0Iig6o8J6DQ1TORRQ8zq5Qk/FQzKZaFDSDfFyEuuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKmwGtAX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8efefec89so9521746d6.3;
        Thu, 17 Apr 2025 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744909753; x=1745514553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVRsxMaaoRzI3A0BHWMdKaDAL/C7tvFz+AMzRlmVe60=;
        b=KKmwGtAXjGUjDbLF0hmMsez/t03bAU/wnieHt3MnJvrtNytSuRxMxBaXysYJk60NV+
         JmsET0UDxd6qa5bqyHgOpWn3qEG2zvn5zeDjiGiEdzpJXWBaGP158qxB6DwpxLoV3dl4
         05AtF6bw2VBE9NdSR86SbEq5z2ybRwNZ1LHcM3HAM/0krQEvkXShxfYD0fxh0Y1+pZYy
         eNlTjqmKDKs+ZAUUpvOLwjk62SUGlQkNP6nMJFl7WFYzzXGfovrLApXBHow5sSeugQU8
         XF0Ry1kMl3MyT9UfRX3f6vMqVjYc+/w8SweYUNmC0MN2D5ZApuuOzgaV4F3dD5UVqiQ3
         IxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909753; x=1745514553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVRsxMaaoRzI3A0BHWMdKaDAL/C7tvFz+AMzRlmVe60=;
        b=KkCTVGuKnfIW6I/WY/8nXRjRc/bdOX+8x9P7k3ncE/eaxapenPMSlr4wWMNCcYZqWg
         61LKcDQW+DJ47U3PGR7O2RaRIRFIjLB+v+1C+P77t/rUFXwUkAoe6ynlw5W5/rQET0cA
         QnPynghCdFnn50BEwylCENwboZyA7h68ngtRQE+SRvSvtHWDhWhtpPoe41dIRB82/Wj4
         KHYXbBFiDjXddUFkyelIFvfQFU1LgBx2BQzhaefK6ZhM1mY9b9fj7mz/3akCGwjC2rJ5
         qmiV/aFzQ1e6GMG5Y/krGErghgz7k/L5/KWc/PXhS4jA+NHXDFT/a42ax+fc33lATGFc
         am1Q==
X-Forwarded-Encrypted: i=1; AJvYcCULBZuTKEONeEJT436HudJJKyQuHb5714iGxurZV9N71eyIsp5VsInMQeZM+WN4YYbHHXD1Q1El4+0h2LUU@vger.kernel.org, AJvYcCUO5XbttCM8Uml7O/+KgfmSa3+pmObmV4Nx3sBNafAFYn1dKhowtA5JEUYr+rYBd1qwokgL6tGQQYc=@vger.kernel.org, AJvYcCW2eO2GeWcyZpeeAwkT+3AXX9NiRasjSgl3t37Tlbbj9XL9Xz+Ck+8DC2IqUDxYqG2H2Qijv/Lb@vger.kernel.org
X-Gm-Message-State: AOJu0YxE364O54bOrnNOO8rRzlPHjoN8/cBR03XmPwAdOc6L3Hg58CYS
	+SV/xSYeC5yNxouf5PSMPKVEahsvQRilHvkZod5SxqA6quz0M50jBjTXnehh+slTwjYMK5B6h3y
	NHsJiV/21f8dN3uwDRD3BLvfU9RvmRp+sBGM=
X-Gm-Gg: ASbGncvJwbg23mrr2JqpF0UfKflVbpEgTvTmT3Yp5rZgfJH+30Z2/h2XzOLgW6NxxB3
	gXgxMsdYerxlJJyFdRQk88NKTkiJTD4xFkgfnRmkD3EparzDaGQE8i+HcQwnQY2E7LVS8jxt1RP
	5yvIiC5yVFH7mHHc3HViq/BF3doveOvmDbC4jycLr2kFYdjMoaEY8+zg==
X-Google-Smtp-Source: AGHT+IH3sgWNRxjJ7ML6vojQwEfQKL7ty9akA1LDmRGoufnBtH8OXUnb5G1KQUGP7NM/X1dbIaA6SvGTj/qLhpHImwk=
X-Received: by 2002:a05:622a:15d4:b0:476:8825:99bf with SMTP id
 d75a77b69052e-47ae9e5fcb5mr6420891cf.27.1744909752744; Thu, 17 Apr 2025
 10:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415182038.523186-1-gshahrouzi@gmail.com> <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
 <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com> <e8b24cf22c87e5b5ce0cc8919eca79f6e60ab6e3.camel@gmail.com>
In-Reply-To: <e8b24cf22c87e5b5ce0cc8919eca79f6e60ab6e3.camel@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 17 Apr 2025 13:08:00 -0400
X-Gm-Features: ATxdqUG5PIHgIXbjSs34LLkZR6qQAIThR_w05scHyE-4Vxq0gd7frAOFZ8J-594
Message-ID: <CAKUZ0z+FKxHcYTYiGvrZ3RLiMKT1P4gtTdq8d7=+ZFC0RMQzqA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	sonic.zhang@analog.com, vapier@gentoo.org, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:02=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> On Thu, 2025-04-17 at 08:53 -0400, Gabriel Shahrouzi wrote:
> > On Thu, Apr 17, 2025 at 6:06=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> > >
> > > On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> > > > According to the datasheet on page 9 under the channel selection ta=
ble,
> > > > all devices (AD7816/7/8) are able to use the channel marked as 7. T=
his
> > > > channel is used for diagnostic purposes by routing the internal 1.2=
3V
> > > > bandgap source through the MUX to the input of the ADC.
> > > >
> > > > Replace checking for string equality with checking for the same chi=
p ID
> > > > to reduce time complexity.
> > > >
> > > > Group invalid channels for all devices together because they are
> > > > processed the same way.
> > > >
> > > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devi=
ces")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > ---
> > > >  drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > > b/drivers/staging/iio/adc/ad7816.c
> > > > index 6c14d7bcdd675..d880fe0257697 100644
> > > > --- a/drivers/staging/iio/adc/ad7816.c
> > > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > > @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct de=
vice
> > > > *dev,
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     if (data > AD7816_CS_MAX && data !=3D AD7816_CS_MASK) {
> > > > -             dev_err(&chip->spi_dev->dev, "Invalid channel id %lu =
for
> > > > %s.\n",
> > > > -                     data, indio_dev->name);
> > > > -             return -EINVAL;
> > > > -     } else if (strcmp(indio_dev->name, "ad7818") =3D=3D 0 && data=
 > 1) {
> > > > -             dev_err(&chip->spi_dev->dev,
> > > > -                     "Invalid channel id %lu for ad7818.\n", data)=
;
> > > > -             return -EINVAL;
> > > > -     } else if (strcmp(indio_dev->name, "ad7816") =3D=3D 0 && data=
 > 0) {
> > > > +     if (data !=3D AD7816_CS_MASK &&
> > > > +         (data > AD7816_CS_MAX ||
> > > > +         (chip->id =3D=3D ID_AD7818 && data > 1) ||
> > > > +         (chip->id =3D=3D ID_AD7816 && data > 0))) {
> > > >               dev_err(&chip->spi_dev->dev,
> > > > -                     "Invalid channel id %lu for ad7816.\n", data)=
;
> > > > +                     "Invalid channel id %lu for %s.\n", data, ind=
io_dev-
> > > > > name);
> > > >               return -EINVAL;
> > > >       }
> > >
> > > Hmm, maybe I'm missing something but the code just looks the same as =
before
> > > (from a functionality point of view)? I'm really not seeing any fix..=
.
> > I might have to change it for readability. From my understanding, if
> > channel 7 is selected (AD7816_CS_MASK), it never enters the error path
> > whereas in the old code, if the chip were either ad7816 or ad7818, it w=
ould
> > end up returning an error because it skips all channels above either 0
> > or 1.
>
> Ahh, right!
>
> One good refactor is to add a chip_info struct (renaming the existing one=
) with
> let's say a name and max_channels. Then, the condition could be reduced t=
o:
>
> if (data > st->chip->max_channel && data !=3D AD7816_CS_MASK {
>         dev_err(...);
>         return -EINVAL;
> }
Makes sense. I sent a V2 with the updates. Also included enum
ad7816_type as a member for chip_info but not sure if it is necessary.
Renamed the existing one to ad7816_state.
>
> Being this in staging, I guess we don't care much about having the fix as=
 the
> first patch to make it easier to backport.
In other words, combining the refactoring and fix into one patch is
fine but normally they would be split?

>
> - Nuno S=C3=A1
>
> >
> > >
> > > Having said the above, not sure if grouping helps with readability. B=
ut I do
> > > agree with moving from string comparison to use chip->id. And we also=
 have
> > > redundants 'else'
> > >
> > > - Nuno S=C3=A1
> > >


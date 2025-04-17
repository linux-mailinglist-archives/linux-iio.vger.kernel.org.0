Return-Path: <linux-iio+bounces-18189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19945A91D01
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6573B8B05
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721A24290E;
	Thu, 17 Apr 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0najXf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E1199384;
	Thu, 17 Apr 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894413; cv=none; b=dRDOsVDoLQS47Od7mgnwy1SHHWQaOc2N+oyzRwWCkapU+DRL6Ln3ZQKFJFQbFOrn1ssvtTCSkSgC+Qd0BJp/9yPPM56edhTN3oyhRtVkGLdurIzajoRW2yH8x96L0PZrGayk9GD3Y9EBj11t/IpHNxq3ZColmGAmHcOpQda0X9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894413; c=relaxed/simple;
	bh=V6B+8U2UFhneiRVOZyseKWoyXNpM1iYOpJRLd/qajmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjaM9kRltaLdQdOngT14sq/8ASSvzlBQT3w+Pt7XkyK+/1PAHaw02A3yF7PLDsztWKRndaabuG3OWw8uFaPUZxF/6ZpCzWxX4NscOAsJFv1Pm8heeR1MgWLRd2jviSrAiD6C/ff+3pDo9tVBA5ynktvNfMdxhuG4FQofdRKw38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0najXf6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476805acddaso7472061cf.1;
        Thu, 17 Apr 2025 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744894410; x=1745499210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlVLziAvMwY2q0tZP9ngpJkek12c6+IDEyw24UOz9aY=;
        b=h0najXf68VlUGTkMQxh39+bXc91IKSqFuCF3x2pK+TQ7icgmGu5FQdLRC3PxDKkOCv
         HSN2tn82f810tTRFLh4rJnGG+AJELNig/QI8pXoZSu+k3prDr/mWh+JatRvxrYg04DJi
         RTYefCf0n6GZifYMd6+ba6O/Z10Xn9I2MfOARd21vfeSNNvZNo9/7IVtZi/zwCQ5qvo4
         9HZEWgwx2d2ER26YvgN4jTcas1oIMBw9YW0BWJlawWGy/EhJQZ1EkuITnFWufLhIsn+l
         /F3RlJ0Cet2uHS9xOm8+9c8CcNYtw/1fXRneADhLVG/fv9shWJhIvcNdQwVkOYmxfH1K
         t1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744894410; x=1745499210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlVLziAvMwY2q0tZP9ngpJkek12c6+IDEyw24UOz9aY=;
        b=o1qxUtzthzAu+rV0AYUgxwjvSaZqUPmFx0ZdyVH72hXWIWUmzJuUBIJdklV1ZkqCPG
         Er3kUQuPtHRWHX1a6rsantUvC3QcKTkA0//fmTDrMYpyUysak8U4sbzT6F+M0uFQd0K4
         NtTsSXPZT7BSfg75Lsn5y5Anfg7cQE8kbZWd1E9Bt7dgMY5wXtMUKxYCCK8cwZZVAsmj
         fPXOI0F8guUlp4c4H/nL5N/bwoxbSmYrDysI7DsWS0XqJ+beUhkBuWuu2aH7Qs5W2rqL
         +CS50DglB7tzbNgc6cAv4Q+y6/TtO35KlmPH2DtddnhyptmMKcH8z1Er1zNcF90kgcR7
         Fm9g==
X-Forwarded-Encrypted: i=1; AJvYcCUHIgClcsEHEMMkQh8zsE2sbwIiPZS9LKKWmQb/IH09FLuZiSga/SwLHVMpDAK9q8yQZYQsASceR40=@vger.kernel.org, AJvYcCV6raE+G2RuxEAW1U/963YlL5CtNe5G1EE5SuVcIHcVLfyqBXlN3UR2wowrADi2seXc/5rKl8S3pcv3Rygp@vger.kernel.org, AJvYcCXYMJdrI11JvTKZnM0XceJ8pDRs7O3R8d/oDzHh85KHr5RJuAI/GBf0wYsEPsgzbZcPgAYx5WFv@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGZehucTyS/tdMD4vzN4yl87Xuk/ThB8H8wZG14dbHKMs2O1D
	gP1TEPqnGVllP9EPXZSAnjigIC+vCa91qmCMl1sfNFMv7Ni9VcG//YqGwvb0iLEsXsDUR+Gtqxa
	YU8AM9zPSdR6GJT2SpxgA7Yx3njo=
X-Gm-Gg: ASbGncvTw0TxNSLyJXhal25KstJxKheWVO8Pzto58ATK0vm4NezybNIKL88J6gUQrtn
	RVStamCzyrzqpFJnZd1psdsaQ7P6N5zrwyI6kVQNuqUSoKh7IZdwOLQqHOT3h6toa9I1GQ0NSA5
	6JB1jFdbD6nS+/+QYkkPKlxySXQhFvMetKdB3sHxwLLvF/TUNkx23xJH8mi3KqD5c=
X-Google-Smtp-Source: AGHT+IFEjAoQPgnXW6t27//O1W+0o+CbqBiAp3geF0MsUU262k2xourjdT/yrRcBHz1zdq4ge4SLOhinWOa3F/k2BeI=
X-Received: by 2002:a05:622a:1349:b0:476:af18:239d with SMTP id
 d75a77b69052e-47ad813ba57mr76197351cf.51.1744894410435; Thu, 17 Apr 2025
 05:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415182038.523186-1-gshahrouzi@gmail.com> <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
In-Reply-To: <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 17 Apr 2025 08:53:00 -0400
X-Gm-Features: ATxdqUGK6KuhhM7Fj61ixiHKA90df-58_gkHsmQfZaA-QhOIG8h5HdACWar_0Fk
Message-ID: <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	sonic.zhang@analog.com, vapier@gentoo.org, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 6:06=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> > According to the datasheet on page 9 under the channel selection table,
> > all devices (AD7816/7/8) are able to use the channel marked as 7. This
> > channel is used for diagnostic purposes by routing the internal 1.23V
> > bandgap source through the MUX to the input of the ADC.
> >
> > Replace checking for string equality with checking for the same chip ID
> > to reduce time complexity.
> >
> > Group invalid channels for all devices together because they are
> > processed the same way.
> >
> > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index 6c14d7bcdd675..d880fe0257697 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct device=
 *dev,
> >       if (ret)
> >               return ret;
> >
> > -     if (data > AD7816_CS_MAX && data !=3D AD7816_CS_MASK) {
> > -             dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for
> > %s.\n",
> > -                     data, indio_dev->name);
> > -             return -EINVAL;
> > -     } else if (strcmp(indio_dev->name, "ad7818") =3D=3D 0 && data > 1=
) {
> > -             dev_err(&chip->spi_dev->dev,
> > -                     "Invalid channel id %lu for ad7818.\n", data);
> > -             return -EINVAL;
> > -     } else if (strcmp(indio_dev->name, "ad7816") =3D=3D 0 && data > 0=
) {
> > +     if (data !=3D AD7816_CS_MASK &&
> > +         (data > AD7816_CS_MAX ||
> > +         (chip->id =3D=3D ID_AD7818 && data > 1) ||
> > +         (chip->id =3D=3D ID_AD7816 && data > 0))) {
> >               dev_err(&chip->spi_dev->dev,
> > -                     "Invalid channel id %lu for ad7816.\n", data);
> > +                     "Invalid channel id %lu for %s.\n", data, indio_d=
ev-
> > >name);
> >               return -EINVAL;
> >       }
>
> Hmm, maybe I'm missing something but the code just looks the same as befo=
re
> (from a functionality point of view)? I'm really not seeing any fix...
I might have to change it for readability. From my understanding, if
channel 7 is selected (AD7816_CS_MASK), it never enters the error path
whereas in the old code, if the chip were either ad7816 or ad7818, it would
end up returning an error because it skips all channels above either 0
or 1.

>
> Having said the above, not sure if grouping helps with readability. But I=
 do
> agree with moving from string comparison to use chip->id. And we also hav=
e
> redundants 'else'
>
> - Nuno S=C3=A1
>


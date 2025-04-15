Return-Path: <linux-iio+bounces-18135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E63A8A049
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7E5445D80
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC661D9A41;
	Tue, 15 Apr 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku3wig1A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A01DC9A8;
	Tue, 15 Apr 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725264; cv=none; b=Fw3GFsMwhe0YvZgt16p4C/UcAyREW0fsIZT5jte7GQUOQ+WbXGRUrWbfjWMzSk6Jyx1+SKu3r0AUD6OyxG77At5hzKh4lkm5b77HrEI6F2h+7BYeV9rIAdnsXxVcFREUmgyMeDzQvAYI6OpG54Ok5fi1eS1gWuDBu5F5y4YqTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725264; c=relaxed/simple;
	bh=OrjfuIsLyMWBHpdPMqn3UuNzRJEMzPl4gvGx5zjyKQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qygIf2V/0RNfV9qy7C5u7ZBmw7Kvgw0ncTGrqb7AYDcOxdlYd7qUWZEpsnS2sEthc6b0N2BjXO81/OHY6fYzK5z7EsPyVAoqqIkp7EviR0uDpkHBBOq9U0ZqooePfXP+GwTgkVt/s5op/ctSePOUQnsOCoX9nPAEbohpVWKVbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku3wig1A; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47698757053so64454321cf.0;
        Tue, 15 Apr 2025 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744725262; x=1745330062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u/AmDRTyguVPS15vuo1k2JAoSJfdZVWVLXGNvKqIt0=;
        b=ku3wig1AiWHBNkRAJfejif03uN3tO2uDfduvHjk+/WRar3/mhNKf4tskEHF7PAmLec
         Xns4szP/HFvKooK01lO/uOr+Xx+BIU6/qJY3gcKKn3yO7Bw0lqShoXMC0UCSczJWB5fg
         eXAdTFkk+fiApgT5aqDBaw4HwHCl6FShBaRbsALMPVUYVay99fSmln/FwaRyHMPjZ7Cu
         F76RtTo8WG1M5xEb90CxeD6RwPHPhK7Wl5MFKaFY6hDFM2SznAthmfjLMJSc3CuS94zK
         uawmVZZ+HbxwTDWwq+jMqgJ3Bf3ZNR/GURPjwuKQH4NK9yn1lqAowYpQ3K9xTIM7CBYC
         BRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725262; x=1745330062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u/AmDRTyguVPS15vuo1k2JAoSJfdZVWVLXGNvKqIt0=;
        b=Dh2XmOzOApTxXb2P9aIw+KlfrJXAyCvQ6YtGg530rQcDEi0nWd/ZGSLGF3kYxI9/IE
         FztDlPIAxS7Qqnhu99dTLhBzd6BHWKFEG0GyBbJacWBwl/IVzJPN/olX9DKXQ4O2dRD0
         C/8htqLo829vjhFOTig0b+GBwuhugUtcYAFCzyPTSHdRQZFYwPepm7x5fe97g6Eh3myX
         7xwm1UNeonoCblvuzkR9x4CFGAMockMgWhddGx1PZ0gA2VjAP5HcPUI6JL4Vb4y54ofX
         U/HL69fNQXRVozGi4pX1sGH+ziR9wkrafTQSou7dl+uc7bUEf45R9u/WHL92TGFcJ4Yw
         OcZA==
X-Forwarded-Encrypted: i=1; AJvYcCUiHS2s+crOKWiBTt8m20XWdaxkImHB98GQ8dV1RLb23pHe+mI22DfpKTD3WX4uXNOT6pMohd7B0kQ=@vger.kernel.org, AJvYcCVj+KD9KsaOPVErVNw2BB1ecS/GqbFddxaN+OgkyxbBk+uGNxfSpfd4avaLMQyaXbVeHS7HoePzLteKYijG@vger.kernel.org, AJvYcCXd9swfJtQcwlgjeo1uX8oMAQdabY5mv772EY5ENGc/V/KFl/UBRZkt4PnBw5YiKYHA+tHJ/hQd@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQyPcSh6V4+Jza6iJUVtrSuaFDaPEb/Ab6xfyKjU5m4Qf6A+R
	nrsZkTVH5WAgLxBdEvY8jUEuS1smdXESKzvKgY4JW47tAh0KwLbOiTo9VFBDRylj9lq9GWI67q3
	aLDUSpLsdQ6BIa+M02MNMraUPhAY=
X-Gm-Gg: ASbGncuJSwTZHfpl7aUbODhJgZJLK23li3TCDlqGkGI0fxaejb1IkZGAQWm5tBbCgDt
	nVo9rLgemngdrSjlOv3n7jrxjCfvTmCe2btY3f2ZA8uG6AkDA86b4ZlkKiQwavm3n2AkLU3/PUS
	brFzPOSrVoCPcS8oqfKjDw2fwpl9M7cQPMnaOMY0ZtFO+ryUOj6sYxdClrIRfoGOk=
X-Google-Smtp-Source: AGHT+IFncftquQsvM6bfh/Y2dgpRTHBlyTEX3Cse3b1bJHNcdPkrggiROQdsJEycAmbcnvsivaFxwRd0WVtvqZwZ3eU=
X-Received: by 2002:ac8:5ac3:0:b0:478:e507:f6ec with SMTP id
 d75a77b69052e-47977562f45mr289779871cf.23.1744725261700; Tue, 15 Apr 2025
 06:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414154050.469482-1-gshahrouzi@gmail.com> <1fb5f1c5e61ce386cb431d48296e952bdd560a6c.camel@gmail.com>
In-Reply-To: <1fb5f1c5e61ce386cb431d48296e952bdd560a6c.camel@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Tue, 15 Apr 2025 09:54:00 -0400
X-Gm-Features: ATxdqUHDElwhcKQXFR5mLMfMHxqVt-H7NGE6w7tSv_4jShaz4NFmHUQo7t9FlX4
Message-ID: <CAKUZ0zLiP_w-4xOXfBDdZbm+M8yVYvd+A=M73fnRT_kMyWwk7Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: Correct conditional logic for store mode
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 5:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2025-04-14 at 11:40 -0400, Gabriel Shahrouzi wrote:
> > The mode setting logic in ad7816_store_mode was reversed due to
> > incorrect handling of the strcmp return value. strcmp returns 0 on
> > match, so the `if (strcmp(buf, "full"))` block executed when the
> > input was not "full".
> >
> > This resulted in "full" setting the mode to AD7816_PD (power-down) and
> > other inputs setting it to AD7816_FULL.
> >
> > Fix this by checking it against 0 to correctly check for "full" and
> > "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
> >
> > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
>
> LGTM, do you happen to have this device? It would more interesting to mov=
e this
> driver out of staging :)
Unfortunately, I do not have this device. However, I would still be
interested in contributing if possible. I was looking over
https://lore.kernel.org/all/20230716144024.30ded663@jic23-huawei/T/
where the goal seemed to be to modernize it by replacing the sysfs
interface with the iio channel. I also looked through the datasheet
and it seemed to be missing some stuff like a channel that can be
selected.
>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> > Changes since v3:
> >       - Tag stable@vger.kernel.org instead of an email CC
> >       - Use the correct version for patch
> > Changes since v2:
> >       - Add fixes tag that references commit that introduced the bug.
> >         - Replace sysfs_streq with strcmp.
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7816.c
> > b/drivers/staging/iio/adc/ad7816.c
> > index 6c14d7bcdd675..081b17f498638 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev=
,
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> >
> > -     if (strcmp(buf, "full")) {
> > +     if (strcmp(buf, "full") =3D=3D 0) {
> >               gpiod_set_value(chip->rdwr_pin, 1);
> >               chip->mode =3D AD7816_FULL;
> >       } else {


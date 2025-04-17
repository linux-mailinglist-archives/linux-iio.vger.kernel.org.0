Return-Path: <linux-iio+bounces-18191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1090A91F0C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3646119E69F4
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C31A08A8;
	Thu, 17 Apr 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlOvltn1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA828EA;
	Thu, 17 Apr 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898539; cv=none; b=fWuggRf5tlOA0vwq9BcUJnUVeNamxWknQJAGBGJJ+qc80FFO8bKIeJrHMjsNhfjM2azzR1TMnYpeEqmfLU/RE13UjJkYSacsVRn3o4+pNxmz7kmjDxEISv5e2TeXgnaZboKskNhxeuXVc2BGnhLlS5FEsRy4QiRvsD0Y3pZmMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898539; c=relaxed/simple;
	bh=DTOqT1+PTZJBISr8HA/bmXH4lG1FGpYPyWAzwLPEWEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skCk29CxZLxbK2jOCKzcdAf4ucUxNK/ZGhPSZShpit2PDCMXj5KwOgBb3iiOuvdvrIJ0pPZaP+Z6ZMynZ/ZC0oYukzDFEIiaxI/3b+O/9UMNGLMF5d202CeRx7h8cEZVY1fA2ffoT31enHFwrz+ZHSaSOJs2P2oT04WTj31Jzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlOvltn1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so14660275e9.1;
        Thu, 17 Apr 2025 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744898535; x=1745503335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A5M+PaEx9mKM/jp1AQJiBtjhvl/i2iXkXqHvC6WDNvQ=;
        b=JlOvltn1LXtU4Q/ZwVztabccO+J0+C0reKWFCDeKHz0xSJ0bGs4b+BRfPZinM9KxCy
         rQi6yefqhF9kfL2i2mGJ3jmiYY5M5RDEq+EzMvrXm4YU7FQefwgHSAdOYRfDs5Xu46q3
         kvZeq+DPPdSQXAkHjHO0a6mukdRAs9um/qOERqJ7Hrn6OGqFSjiJVej5i2P+z3X8my3c
         EgAXsga1NYWu4n2/yU/u0kztwD/6AB06LunoB0m/1OWXvlrLVX1vByXfC0WZgkUwRh4p
         NnWPzeg3ZeoiSq9jQvEgkBCJC13m0DI6H6meG+8TI43V95Au7Cy1ECbrjiDlpz4aqBFJ
         BLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898535; x=1745503335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5M+PaEx9mKM/jp1AQJiBtjhvl/i2iXkXqHvC6WDNvQ=;
        b=b0zgIyF7OkYTCmzVVOCbSvIxX6Z1ILZ9UecX68X56YVy06xikI2dz8ei3IAoQa9qr0
         Kn+/T7vbGwJg1A/bQJMz0fz6HrXd3QizxXTgTApbeDaIckDiiSu6ZrEho5LJIfbAJtnL
         CTgFw6HpVT0KJTYvzyCL4/DTzUDyeGogjwYNY3tyIUK5/b5VhRqvFYWS3xjM5p5HmKzw
         Vqurng+NuWz6wdQSuiubG8FBoV6CpBjiXF65whYkfeCHPtWVeh5SaSroxDeAsNsL45is
         iU/pLOh4gEk0IaUM3b2csNE4HyCvEhdvpf5p0iYk2Cfhs69ikYtbdABZn8AcLdq/d8rL
         zzpA==
X-Forwarded-Encrypted: i=1; AJvYcCUBNO7mV/cs2aHz+24lZCqefWDz65AKcD/noa47Xo7D8L0XljtFZPo9mNHRdW+rF0qfO6opAYjVG9ktmnIc@vger.kernel.org, AJvYcCVJEbNUOIs7a72FveF9gDsH5g49GIR5P6JmqP4n0WczCMbVknzH+9FvtMmfOxf7eqgg+nMVLq8P04M=@vger.kernel.org, AJvYcCWn0o2ZWJ+PYPc3rXd/DK3zfvBuwg7xidOCnpmVuqjzIVWZwON1WglH6REbLwOKEF/E9npAxFGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DoNszdg7leHnInpqSLkzg2X6wMYp0I7MM1yk4p0lfiF9p+Bk
	xQHyV6IAC95StbbsqfDO+FIRcGK96IW4gEpiYNbblfudqmpOZ+Ue
X-Gm-Gg: ASbGncuqOwA8XJqchmbNEi7qQTdqDyaYZLnoRR5bHEmWiuD58yOmBKwVIr74JvQmGU/
	UVpLBbZQ4/HJri/b9meHPC0X7RfjCZit3lEfPvP3o/b9vNGJcCGvMnUiCAyUFcx5FxeWdMSCo10
	3ak0Uufnp7Rq83j3BtMmO32xGmKWd2tKURdyg84xjitH6nCwWLOwg0rLNMqRIirIYl1zSAtiZHX
	/oug3XZ+7EA1LnGCRPGk+sjY3anT9V4XDu5W+PdCzIjYrFnoW12MfJ7vbdUvYx9Z6JMkj/lrnDd
	j8al6gMScNz2DiwUpDUMl1OHbI3xhUhhVokdtfk/GVI8/WEOSsRZGYfEaq6B0Sn9sK0tBPl6Oa5
	IAhK89Ouss+KE
X-Google-Smtp-Source: AGHT+IHqGFAC+bEXnpOU0lSmklsH2ZD4OjyvRqUVn11XS9rxZL/VuFPFv7nsOuSyizmkj3sssiGxvg==
X-Received: by 2002:a05:600c:3b88:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-440636a4008mr22042115e9.13.1744898534473;
        Thu, 17 Apr 2025 07:02:14 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b5abc3fsm55849605e9.37.2025.04.17.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:02:14 -0700 (PDT)
Message-ID: <e8b24cf22c87e5b5ce0cc8919eca79f6e60ab6e3.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	sonic.zhang@analog.com, vapier@gentoo.org, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Date: Thu, 17 Apr 2025 15:02:16 +0100
In-Reply-To: <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com>
References: <20250415182038.523186-1-gshahrouzi@gmail.com>
	 <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
	 <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 08:53 -0400, Gabriel Shahrouzi wrote:
> On Thu, Apr 17, 2025 at 6:06=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> > > According to the datasheet on page 9 under the channel selection tabl=
e,
> > > all devices (AD7816/7/8) are able to use the channel marked as 7. Thi=
s
> > > channel is used for diagnostic purposes by routing the internal 1.23V
> > > bandgap source through the MUX to the input of the ADC.
> > >=20
> > > Replace checking for string equality with checking for the same chip =
ID
> > > to reduce time complexity.
> > >=20
> > > Group invalid channels for all devices together because they are
> > > processed the same way.
> > >=20
> > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 device=
s")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > ---
> > > =C2=A0drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> > > =C2=A01 file changed, 5 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > b/drivers/staging/iio/adc/ad7816.c
> > > index 6c14d7bcdd675..d880fe0257697 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct devi=
ce
> > > *dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (data > AD7816_CS_MAX && data !=3D AD781=
6_CS_MASK) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for
> > > %s.\n",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data, indio_dev->nam=
e);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strcmp(indio_dev->name, "ad7818"=
) =3D=3D 0 && data > 1) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_err(&chip->spi_dev->dev,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel id =
%lu for ad7818.\n", data);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strcmp(indio_dev->name, "ad7816"=
) =3D=3D 0 && data > 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (data !=3D AD7816_CS_MASK &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (data > AD7816_CS_M=
AX ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (chip->id =3D=3D ID=
_AD7818 && data > 1) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (chip->id =3D=3D ID=
_AD7816 && data > 0))) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_err(&chip->spi_dev->dev,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel id =
%lu for ad7816.\n", data);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel id =
%lu for %s.\n", data, indio_dev-
> > > > name);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > Hmm, maybe I'm missing something but the code just looks the same as be=
fore
> > (from a functionality point of view)? I'm really not seeing any fix...
> I might have to change it for readability. From my understanding, if
> channel 7 is selected (AD7816_CS_MASK), it never enters the error path
> whereas in the old code, if the chip were either ad7816 or ad7818, it wou=
ld
> end up returning an error because it skips all channels above either 0
> or 1.

Ahh, right!

One good refactor is to add a chip_info struct (renaming the existing one) =
with
let's say a name and max_channels. Then, the condition could be reduced to:

if (data > st->chip->max_channel && data !=3D AD7816_CS_MASK {
	dev_err(...);
	return -EINVAL;
}

Being this in staging, I guess we don't care much about having the fix as t=
he
first patch to make it easier to backport.

- Nuno S=C3=A1

>=20
> >=20
> > Having said the above, not sure if grouping helps with readability. But=
 I do
> > agree with moving from string comparison to use chip->id. And we also h=
ave
> > redundants 'else'
> >=20
> > - Nuno S=C3=A1
> >=20


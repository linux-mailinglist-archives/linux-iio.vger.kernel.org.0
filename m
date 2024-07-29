Return-Path: <linux-iio+bounces-8023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA593F8D0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8861C21B2A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DB155342;
	Mon, 29 Jul 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v1s6ceId"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0754514601E
	for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265026; cv=none; b=R/nSsR75LU0aOwvnZG1EYEk1svzyZixQ5A19Gk4pgjQXGWhLL5+FUpAoqoSW0BfMVweWdk2K8BaUY25NJUP8AokIHzSXWgQG5utVKUcf7Q16I5R+52l9W9WG4b7JRseBJz5wdH0CAopqIVgtxWBYVligITZhhij29oXZ36vr9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265026; c=relaxed/simple;
	bh=a/th7pWI5bQUIwTB0KfEs6HOAE2XK39+zDpgBE4iri8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FhFxvm/rPPS+58cIEfNveNRI3Z3x5iBo6vBAKqlXMwcf1iyL61zMWL1/Em8U6FbcDlmr6hteDzqApnRWzHxn7RL+5KvSPbnlr2rvZe+phkmQEDfAjQ4RYwvvyrl3/QSHIdCVFQ3bTXf+UkpPx5HBZwcIg+IuRFOKgPhFedKoQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v1s6ceId; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281faefea9so5350695e9.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722265022; x=1722869822; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vd7eRTzF1aK+6J2h/+Ep32kwr+phgKio71VO1W2qNY=;
        b=v1s6ceIdh2+lEJWAtoBqV9S0FSNy4lnMJPudLdCFm/OrHX6cpVfNakhYFU3r4+I+NC
         Yt1Rgq9j+aYS6aNEXfviXjnsnRJvWTOdvskIuo1JLtQN/0KcXyYaHnKh07jn/04rBj45
         KKMexO31PqMuUh91kohKMyjhhLQIZrPdE3bvraTw6FVFrRE1Zkwu73JdQeXvS+Q+3xYI
         XVMPawVCGgzgUAlIwEpBZzLDOdpulDBMzFmSHEjdzreU17ucN5VjFvULevtvIbOftP/Y
         E6AcOX4NsAPfeUrkVbpEUrrp7R7ypBtDYq3Jz3PeQVwdnKkEI4eOb4/5Cwi5MW7voNji
         zkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265022; x=1722869822;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vd7eRTzF1aK+6J2h/+Ep32kwr+phgKio71VO1W2qNY=;
        b=HrkYYs6KbL9WLilNIyAvzwEs2XnHZgpjbt2pe1VXYG71fiWl2yAo9Ksne1Qsgq9wtu
         7zii+IC6kpQSfdcseXEyYqcOtvHvf19Tm7ZZTrBxfaVO3WnV9/M8xZgqBkhMJpoP7IH3
         Un7Vya7v+PilYRLd2ezg/4LWDA5wHvflp7FhHz00M4rvonyLOl3TYy63vkSDvUZYyBpH
         s6+SEKNwgxqK5jRk8330Ab7YmQ8ppYmNuTlCWLeUv/CTeLcpwejRJs6NvU6s7v+Ap+Sv
         BpGFOoIieh+QyTgucSNgofrgE04762QgMX2U3cQfwo9DyrwgGKlewO5s6su1jhj3+QuT
         eYrA==
X-Forwarded-Encrypted: i=1; AJvYcCXZK8E2zy6c5Rj3VNJYV/ktV7jd/jHTFsQ7VexGqGLTwKiOgVfh2H1GpaZngfnZTHf370JjglAnFytlua6EnIJwe0/mQKmfZleX
X-Gm-Message-State: AOJu0YygIm/yeyw+lcav+7HtbOc7K45NtFGs6zY0cTskch9ilRy+noya
	FBcrInw0e0q++O2RtuZlNtc7aRuJlix/houWxUB1gV3nV0+q+4ZVUxFYcCqXZko=
X-Google-Smtp-Source: AGHT+IFzLv4lcwHL+T71gA0LxoHfgjz/e+PpybnhNURIIz0UPjwNYnK5aq6g/n0SJEUL/vtiLg5uHA==
X-Received: by 2002:a05:600c:4e8f:b0:428:1fa1:7b92 with SMTP id 5b1f17b1804b1-4281fa17d79mr13520815e9.19.1722265022309;
        Mon, 29 Jul 2024 07:57:02 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573f935sm182618065e9.14.2024.07.29.07.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jul 2024 16:57:01 +0200
Message-Id: <D323ZW5IUH31.3JOFSGMRNKO1@baylibre.com>
Subject: Re: [PATCH RFC 4/5] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-4-fdc0610c23b0@baylibre.com>
 <20240629175558.031e07c1@jic23-huawei>
In-Reply-To: <20240629175558.031e07c1@jic23-huawei>

On Sat Jun 29, 2024 at 6:55 PM CEST, Jonathan Cameron wrote:
> On Thu, 27 Jun 2024 13:59:15 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
> > interleaved bit per bit on SDO line.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> > ---
> >  drivers/iio/adc/ad4030.c | 130 +++++++++++++++++++++++++++++++++++++++=
++++++--
> >  1 file changed, 126 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > index 1bcbcbd40a45..09d2f6d8cfe6 100644
> > --- a/drivers/iio/adc/ad4030.c
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -32,6 +32,8 @@
> >  #define AD4030_REG_PRODUCT_ID_H					0x05
> >  #define AD4030_REG_CHIP_GRADE					0x06
> >  #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0x10
> > +#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE		0x03
> > +#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE		0x00
> >  #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		GENMASK(7, 3)
> >  #define AD4030_REG_SCRATCH_PAD					0x0A
> >  #define AD4030_REG_SPI_REVISION					0x0B
> > @@ -391,7 +393,10 @@ static int ad4030_set_avg_frame_len(struct iio_dev=
 *dev, unsigned int avg_len)
> >  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
> >  					unsigned int mask)
> >  {
> > -	return mask & BIT(st->chip->num_channels);
> > +	if (st->chip->num_channels =3D=3D 1)
> > +		return mask & BIT(st->chip->num_channels);
> > +
> > +	return mask & GENMASK(st->chip->num_channels + 1, st->chip->num_chann=
els);
> >  }
> > =20
> >  static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long ma=
sk)
> > @@ -412,6 +417,45 @@ static int ad4030_set_mode(struct iio_dev *indio_d=
ev, unsigned long mask)
> >  				st->mode);
> >  }
> > =20
> > +/*
> > + * @brief Descramble 2 32bits numbers out of a 64bits. The bits are in=
terleaved: 1 bit for first
> line wrap at 80 chars unless good reason to be longer.
Sure.
> > + * number, 1 bit for the second, and so on...
>
> Do you have a reference for the alg used?=20
> Google fed me a bunch of options for a perfect unshuffle=20
> though it is probably microarch dependent.

I used this IIRC: https://stackoverflow.com/a/3233173
I adjusted the masks and shifts to get both the high and low parts of a
byte. I'm also doing both number at the same time.

> > + */
> > +static void ad4030_extract_interleaved(u8 *src, u32 *out)
> > +{
> > +	u8 h0, h1, l0, l1;
> > +	u32 out0, out1;
> > +	u8 *out0_raw =3D (u8 *)&out0;
> > +	u8 *out1_raw =3D (u8 *)&out1;
> > +
> > +	for (int i =3D 0; i < 4; i++) {
> > +		h0 =3D src[i * 2];
> > +		l1 =3D src[i * 2 + 1];
> > +		h1 =3D h0 << 1;
> > +		l0 =3D l1 >> 1;
> > +
> > +		h0 &=3D 0xAA;
> > +		l0 &=3D 0x55;
> > +		h1 &=3D 0xAA;
> > +		l1 &=3D 0x55;
> > +
> > +		h0 =3D (h0 | h0 << 001) & 0xCC;
> > +		h1 =3D (h1 | h1 << 001) & 0xCC;
> > +		l0 =3D (l0 | l0 >> 001) & 0x33;
> > +		l1 =3D (l1 | l1 >> 001) & 0x33;
> > +		h0 =3D (h0 | h0 << 002) & 0xF0;
> > +		h1 =3D (h1 | h1 << 002) & 0xF0;
> > +		l0 =3D (l0 | l0 >> 002) & 0x0F;
> > +		l1 =3D (l1 | l1 >> 002) & 0x0F;
> > +
> > +		out0_raw[i] =3D h0 | l0;
> > +		out1_raw[i] =3D h1 | l1;
> > +	}
> > +
> > +	out[0] =3D out0;
> > +	out[1] =3D out1;
> > +}

All the other comments will be fixed for V2.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre


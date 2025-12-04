Return-Path: <linux-iio+bounces-26779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18FCA59F5
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 23:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8CA30F196E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5C303C9A;
	Thu,  4 Dec 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0PVssdr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570482DCC08
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764887039; cv=none; b=PlVuMvsXptrOyBJQEh4zB+jAL9cZ3uKBzWmekNQqDJpQlNVk3KpgKlTyU55785b1HjDa2J3eX2DlA4RK/LLWfeyFqXGtcxo3mv56NyhEIWmeFTWRpJxMAfHAsz3JqPUNQauBdV1PQXJ+Mnfr11hY2/MUyGx2Crazl9QI2UJBJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764887039; c=relaxed/simple;
	bh=DdLkBWTvWR6t/4yis1/qibr2sKqSxf7KdZn7c3P0mDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHaZRy6mYHjbCiwj3cJQ5s9M5CTSM4L/YS5MoJ+6bqV8hFbGVeQSUCIRCkIeJGP7rqDbN3GVlUqS0ayQH+clIJZRA5jRl/FR1lr8ffsCU6nCxyGnQE1OabmT+S2wwDNWZJghS5vmdzQ9oH/OfdfJyoxQGPo6oKrqt+B2fXTO0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0PVssdr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so16481466b.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764887036; x=1765491836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7kJF25Q3ylLh9rrMMVKXnH1HNYjhOKvkB7STg7bm9A=;
        b=g0PVssdrfLNLo9cWFaquciAAxDApOIWeMnHjWgaZlpQC7bBDFiYYLYI6WPKrp42xGG
         nogUpkAB8gtbMMW/G++qv+HGnCRAKgcpEXHMtWwDtcJK6Tddcqvo4Y9Y5pXU3qx0Q4dJ
         6HPujmQuWHF7b1jAHtHpXDDTYivoJ2GL9dAcejMuPMNbH+puk8y5H13dvxNbgMT8jHHW
         xqWO47bVCGTgK9A4VJO+c6xhd5SJ7wtW3cjXJ/VCrGKt5wEg8YBkeXH2UuFUjfxm9+Z1
         eg04WUB0V6XGVg7VljB8HXnyxJofeSwTmJtxr/Tb2VCVsvdwAGftmvV13sqgmFMPizSJ
         AwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764887036; x=1765491836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7kJF25Q3ylLh9rrMMVKXnH1HNYjhOKvkB7STg7bm9A=;
        b=o/f6A3nBdutA1acuOMb/m3OQGYaIWi6FtjzweFxxmAZWXgKKTiAcwGasGLnBbwwPhg
         F+GHjE7p5yo6BBSQk5psyPUNiJTBbFg5j2iKyDJ0c+K6LSFwBbT7VwZHJhmS5wonQM6B
         C2MXephlufQ3z5hsCQYpIS/pRGZt0FKbZKtxEtTnqvPJsUq1mNWgBkmpaGOO7sG6/Auo
         CopOLg9vPTN9bQEvqtM/0JbQ7hpMx4Fps2Y5AXU9fR8fRlA+DBeZ5Z23OPWBaoHMXnMU
         tyK1/G8zNgnplmH84D1fGopQoJLXhO/oLMvaUqJP3ywXCHCycFppBuKzJn8m+oSj54zS
         mPBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfBWO1+k4jz9PG0TUfG3q63jaMoMGBSwwwLPH+kcWGf/CrUjnNawK6Kxygu1RsrJ9UblLLXjz9lEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeuf7UnrSojcfq6azQmjEBhQA6/H4+4lQA06zLsIryup4+kdJz
	kuuliVDzGknan2Ys0t9atVOon4Axr+w7YV/ljLdQfYpcuUHM4CmOlqqbsgoI1IB0WQqAbreQaVV
	avRC0eTWaGD7fUi12tc4wiBkEDxaAfHI=
X-Gm-Gg: ASbGncuU4umfOhAz8gC7bSeFwXgS9YAGt15sla5XI8ySAru539mRlHz74Lw5dUhrN5o
	A6NpFi5MgddbXJJ9tKUZ5mt+B+mZuh4IEW8wBZzanmi4XEyMymKG8qrz1N9bRTz33YcKExfXdkX
	ldhM3UfYJqfBxZP9uMGA8wkArbxwwPKXie/tlXN+OEENRfhcQMrCaKCLyenZSbUwSNa7F+XwsCJ
	5EvQd+8HabmWomI46xrj7jb8pZ6xjb4kGA/AK/LcE8TIYwE21PRqc4L+TYNYbzFc5SnIebbSo/d
	86ruFwYpjim4jN5CKKDF36a4HkjP8UpteF7QfEMklOyM8h14T6IMIfQKGR8iiPATtlH3di++X9Y
	lEFwkZA==
X-Google-Smtp-Source: AGHT+IGu+d4vyuMsd3dEhDQpsPPgCaoD5bBiEvI0kE1yXpu5bAk3jN94E00EwA3/8wViZNAKmIE4q44Wn6De4ECf+mM=
X-Received: by 2002:a17:907:96ac:b0:b76:f090:768c with SMTP id
 a640c23a62f3a-b79dc73cd2dmr807148366b.30.1764887035570; Thu, 04 Dec 2025
 14:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com> <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
 <aslj3klmv6heyyhgltzewkdze5p4c3hlkzfbxbfnzwwgd375gv@m6iqpst5sv6b>
 <aSgSsGSUuBtMOuro@smile.fi.intel.com> <zryqws2h2i4duejczo2rptwhlzhile7fa7brriqh2hmtarwjxn@cr2cyzymwpav>
 <aSn3PthKIvFAhDS6@smile.fi.intel.com> <fue274bpfgsytm5z25rdsawbfa2s4vu4ypoqrrmrx5dfe2jgdq@ocjqribzo5mn>
In-Reply-To: <fue274bpfgsytm5z25rdsawbfa2s4vu4ypoqrrmrx5dfe2jgdq@ocjqribzo5mn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 00:23:19 +0200
X-Gm-Features: AWmQ_bmRm4Q2kvw7yFW6pHsmzR-B857kT0dxLwv4TjE_3ffvQEr7-TA_4SKthPY
Message-ID: <CAHp75VfD=BXmN96HXw9deGDqBjmhqW8Jve8d-tH0BvsZ+nfFpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
To: Jorge Marques <gastmaier@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 11:37=E2=80=AFPM Jorge Marques <gastmaier@gmail.com>=
 wrote:
> On Fri, Nov 28, 2025 at 09:25:50PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 28, 2025 at 07:50:02PM +0100, Jorge Marques wrote:
> > > On Thu, Nov 27, 2025 at 10:58:24AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 26, 2025 at 12:40:00PM +0100, Jorge Marques wrote:
> > > > > On Mon, Nov 24, 2025 at 12:20:57PM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:

...

> > > > >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, =
int gain_int,
> > > > >                                       int gain_frac)
> > > > >   {
> > > > >   ...
> > > > >
> > > > >         if (gain > 1999970)
> > > >
> > > > But this magic should be changed to what you explained to me
> > > > (as in 0xffff/0x8000 with the proper precision, and this
> > > >  can be done in 32-bit space).
> > > >
> > > > Or even better
> > > >
> > > >   if (gain_int < 0 || gain_int > 1)
> > > >           return -EINVAL;
> > > >
> > > >   if (gain_int =3D=3D 1 && gain_frac > 0x7fff) // did I get this ri=
ght?
> > > >           return -EINVAL;
> >
> > > gain_frac would be 999999 max, or 999970 for the limit that fits in t=
he
> > > register after the math. I think > 1.999.970 is self explanatory.
> >
> > On the place of unprepared reader this is a complete magic number witho=
ut
> > scale, without understanding where it came from, etc.
> >
> > So, can you define it as a derivative from the other constants and with
> > a comment perhaps?
> >
> (my proposal is after all your comments below)
> > > > >                 return -EINVAL;
> > > > >
> > > > >         put_unaligned_be16(DIV_ROUND_CLOSEST_ULL((u64)gain * AD40=
62_MON_VAL_MIDDLE_POINT,
> > > > >                                                  MICRO),
> > > >
> > > > ...with temporary variable at minimum.
> > > >
> > > > But again, I still don't see the need for 64-bit space.
> > >
> > > Well, by dividing mon_val and micro values by a common divisor the
> > > operation fit in 32-bits:
> > >
> > >   static int ad4062_set_chan_calibscale(struct ad4062_state *st, int =
gain_int,
> > >                                         int gain_frac)
> > >   {
> >
> >       /* Divide numerator and denumerator by known great common divider=
 */
> >
> > >           const u32 mon_val =3D AD4062_MON_VAL_MIDDLE_POINT / 64;
> > >           const u32 micro =3D MICRO / 64;
> >
> > Yep, I suggested the same in another patch under review (not yours) for
> > the similar cases where we definitely may easily avoid overflow.
> >
> > Alternatively you can use gcd().
> >
> > >           put_unaligned_be16(DIV_ROUND_CLOSEST(gain * mon_val, micro)=
, st->buf.bytes);
> >
> > Btw, I think you can move this check up and save in a temporary variabl=
e which
> > might affect the binary size of the compiled object as accesses to the =
gain_int
> > and gain_frac will be grouped in the same place with potential of the r=
eusing
> > the CPU register(s)..
> >
> > >   }
> >
> I believe this is clear and fits all points:
>
>         /* Divide numerator and denumerator by known great common divider=
 */
>         const u32 mon_val =3D AD4062_MON_VAL_MIDDLE_POINT / 64;
>         const u32 micro =3D MICRO / 64;
>         const u32 gain_fp =3D gain_int * MICRO + gain_frac;
>         const u32 reg_val =3D DIV_ROUND_CLOSEST(gain_fp * mon_val, micro)=
;
>         int ret;
>
>         /* Checks if the gain is in range and the value fits the field */
>         if (gain_int < 0 || gain_int > 1 || reg_val > BIT(16) - 1)
>                 return -EINVAL;
>
>         put_unaligned_be16(reg_val, st->buf.bytes);
>
> Explains 64 value. Checks if is in range [0, 2), then if fits the
> register field for corner case of range (1.999970, 2) (0x10000). Full
> formula is in the previous method ad4062_get_chan_calibscale.

Yes, LGTM now, thanks.

> > > > >                            st->buf.bytes);
> > > > >
> > > > >         ret =3D regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> > > > >                                 &st->buf.be16, sizeof(st->buf.be1=
6));
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >
> > > > >         /* Enable scale if gain is not equal to one */
> > > > >         return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONF=
IG,
> > > > >                                   AD4062_REG_ADC_CONFIG_SCALE_EN_=
MSK,
> > > > >                                   FIELD_PREP(AD4062_REG_ADC_CONFI=
G_SCALE_EN_MSK,
> > > > >                                              !(gain_int =3D=3D 1 =
&& gain_frac =3D=3D 0)));
> > > > >   }
> > > > >
> > > > > To provide the enough resolution to compute every step (e.g., 0xF=
FFF and
> > > > > 0xFFFE) with the arbitrary user input.

--=20
With Best Regards,
Andy Shevchenko


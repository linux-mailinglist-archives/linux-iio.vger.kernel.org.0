Return-Path: <linux-iio+bounces-27660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D27D16E46
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 07:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCA1730101D5
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0983644CB;
	Tue, 13 Jan 2026 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyTqHz2U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083C32C933
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287033; cv=none; b=bLZ9suwO84c+83+kSiLDNZYJkQbZXstsfMbEmaHDR2EcAOlUoR7yC84P26ez6QapmThTc0I6VlvS6m/ArszE6haFStgXNRDlc3kNMlD5V+SP7WKoCTxN/JMkX5la5270g1nS+A7hnGiJ7PWVroRsGCLw+IOnS+t9gj7gVx/eCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287033; c=relaxed/simple;
	bh=vWWkI8Ucxv7LLsC4EwcqO0otoFPc0wLp32vKoD8J2lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwofmJaUgJGERv3Dg/v7O/NAwGw1G+yXhTTQFNgVxZaFIP4GX3enXNXqMW5X9zcAWM4C5xnnYUDOij7Xgh06RlI9MCtn1UGF02k0AO6lorTBBU34fjorBEGyCjDPojgp6qfxVjHRvWLvA45x8+LqFPGKoAHe23bcR2FKHwUy1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyTqHz2U; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso337907966b.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 22:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287030; x=1768891830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDFhHs1bZ2tXFlSAK9bO89iNUEo/gzgYCa9HumpSvtU=;
        b=OyTqHz2UJ5gF0nbcpvmiXsVxpOKwFBZPHllNFaar+NAna44jvrRk4ryHLw5TS7Bsu8
         f1KUKfACf9iufQCp41GfCZSgdiL9oiDIc0oXdzP+uXUC+lnarmFXG6AT3dQO1uWM/8UH
         xMDRNzVq7QJMoaOMtnaHbk4mDFU7AGA4r01p44Cq6QCJZsWeo21YGItX836I5yb7mUOT
         nbqiUWNqs7pB8QrMHHwJJNOfWqghoRBUVTiTJ6B3F9X2/ysx38AxmeOFfxRL3HAHAXCh
         iMfNskvPL1IaQgtFDyCtkGZU0toN9LDCD8g8MDoDh3dMuDXacC+r7LYPrM4cuc0+5LYx
         dq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287030; x=1768891830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDFhHs1bZ2tXFlSAK9bO89iNUEo/gzgYCa9HumpSvtU=;
        b=obh5oGxXbWgmdEsCzP510agXNA2mVVAg/MjkbtzyT+PNmV9f9neU7m40izHo7daO/Q
         HAqWmhXJhsp3TDlDrrLQvDR1tfRGSjf1XCYJMvRFf1NmQ75t61kczb5V+iSXEp408mi6
         hMBCXoMvxakD6nlPJxfOpbdpIkSF1UXvY3DelkiOIyAisH+TZsIduTuzB+dox1pkId/m
         L96ANbowf8ImNFo84Tm1Ny1Ubo0R+5fqBdb63zhuRWtBl2niJo6vfVwIbq1SW+qHZG9g
         1u8gbjbJXoj7uc984+Iw44hA47OHPQdV5ud4PV7eCbpw09g1yOh9pTg0shsAgpH7L6QS
         HUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7YDpHNU5MTvgWvyO57wwE4xr+xaK8U/TzF0r0Yf8LKeD8yHAdLsDhCp7LdKKie/H/NeReXVZKpwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tCf7eg18FJnLR7TdporL4H413/mU+N3df/7Iskoz/1gTqHe+
	nh5iC7mAGlylXk1DgljuDGHbRrag/+lvg/3KrWRH1Dsu18BSz43XywX9lGqwO8Ar7ojsJbNW+jf
	+t0YQ8br3jTjiCJc2AS+nHXi5fwMe36VUqp/0
X-Gm-Gg: AY/fxX4juziWkqEtZT3GaVKz0+TeECu30bIFeQe3c1mAg8yWX6Us6A8Bik5jetbLpJL
	G+oMwfxgbl7ufGSkFGDiUaBS07op/5Ttql9dx6yIghoxdnOqaf4jXZG+axf+Y7sOQOI8bl70V18
	cy/vN5dwrVM5AdZIJdKnlh9C0oD/fyPwQIUu3MZqENjzYDtoJcd0k1iAmX2CjljXNdrKmDHm0CX
	SbxK5Ru9QFSapd8gvxAe53K7djbDTrw4djnOGQXXqnvGCCCIKvc5VlD7TaMGhEX0n1oUICHCd9S
	HdJN8Jty6X33yoaY0O0NLlut3w7M2xZZAFmmYPZr57OvqnyxZaweaWokBa2Q2cQmlN+fXm0=
X-Google-Smtp-Source: AGHT+IHTMaEj1d79MXWnrtD/D1BiTaFbQG661Hd0qVzPt9MGhEU4KTKvVFDgrAZVOMIFGnSyzgcpUUFGM8BY5zo4wBU=
X-Received: by 2002:a17:907:705:b0:b83:73ee:9dc0 with SMTP id
 a640c23a62f3a-b8445177102mr1831267166b.65.1768287029999; Mon, 12 Jan 2026
 22:50:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
 <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
 <20251227155525.6d712f42@jic23-huawei> <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>
 <aWMG6+ORRTy4ll8d@JSANTO12-L01.ad.analog.com>
In-Reply-To: <aWMG6+ORRTy4ll8d@JSANTO12-L01.ad.analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Jan 2026 08:49:53 +0200
X-Gm-Features: AZwV_QhDHCn-yzHlTaIbM5IT9Av2UWj3kDnIDefGCsUzJc3Zki1Ju0XwfgtNBz0
Message-ID: <CAHp75Vffgz7mc4Z_KibtuuVCvBfVEYPG0iEPBXrEFzYkaymGKA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jonathan Santos <Jonathan.Santos@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:32=E2=80=AFAM Jonathan Santos <jonath4nns@gmail.c=
om> wrote:
> On 12/27, Andy Shevchenko wrote:
> > On Sat, Dec 27, 2025 at 5:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > > On Wed, 17 Dec 2025 02:52:45 -0300
> > > Jonathan Santos <Jonathan.Santos@analog.com> wrote:

...

> > > > +/*
> > > > + * Percentage and basis point units
> > > > + *
> > > > + * Basis points are 1/100th of a percent (1/100), commonly used in=
 finance,
> > > > + * engineering or other applications that require precise percenta=
ge
> > > > + * calculations.
> > > > + *
> > > > + * Examples:
> > > > + *   100% =3D 10000 basis points =3D BASIS_POINTS
> > > > + *   1%   =3D 100 basis points   =3D PERCENT
> > >
> > > I don't understand the final equality in these examples.
> > > The top line is as it says 10000 basis points but you have it equal
> > > to BASIS_POINTS?
> >
> > Also there are pp (percentage points) and others like per mille
> >
> > https://en.wikipedia.org/wiki/Percentage_point (see "Related units" sec=
tion).
>
> Hi, Andy. Thanks for the suggestions,but I am still questioning how
> the percentage points would be implemented, since it is defined as the
> difference between two percentages and we cannot use floating points.

My comment was more about the prefix (PER) and the naming (not
BASIS_POINTS, but something from PER*), and for the comprehension I
would rather see all three defined (pp is _not_ part of these as you
mentioned its semantics is different).

> Also, should we keep this approach of unit conversion?
> Example:
> value / PERCENT -> converts a value from percent to ratio
> value * PERCENT -> converts a value from ratio to percent
>
> Just to make sure it is consistent with the rest.

Sounds good at the first glance.

> > > > + */
> > > > +#define PERCENT              100UL
> > > > +#define BASIS_POINTS 10000UL

--=20
With Best Regards,
Andy Shevchenko


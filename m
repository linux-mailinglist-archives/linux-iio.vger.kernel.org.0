Return-Path: <linux-iio+bounces-22597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B4B21545
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B016FFB9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7626311C13;
	Mon, 11 Aug 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTrRW7lu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD12D4813
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940016; cv=none; b=C+NPHblNJz3MHlrAaakYKJgBJprJtYeo6SQiFT2q9+Q+JpzX54IpLeERTH2KRNo4dsHavRhnDPEAQ6y1QZMidZjedVfbh6UnXGw6/Gw2hfLjzll7mU7/hstDkue5SbrunaWmpxenoZBL2Wr7pOwk2ZNlrYsbSHhRj4y/JCZuJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940016; c=relaxed/simple;
	bh=3bIlRhwcI1+h7nv51j4VrkjENTzO/xLxR90wdBsqQQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR2uoSrDHFMFUNSGmcXR9S4o6lhP52T27Mt8xaG8paa8ptXy1gZZ+MSnHIOOipbSwUM8HILELJAurzsVThxN6AKRjjjuIC0VHyMgQikwObYZTKS1knCsAfhz60lhNniQwpxTDcnbNVQxF0ya9OMqCeIM2WfNi3SGrkpoyxhPXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTrRW7lu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso789937666b.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754940013; x=1755544813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpPp5bEZyU1lFhxZe99QopWjy0DQcPLOdlguwnbWoqA=;
        b=LTrRW7luQF/pFmMT70A2LIZP7if8MuoMKB9vyj/h0tdjEUR2S1Xy7w/Q0z2pYC9gJl
         XPDgME7N+BuwISjHldoTY1WpTGV1UcQp+p6HZHGCGkVBBbS9C7T9j82YvDOV7fT+DjZP
         4yN1Nehr8+tKUIp1mHt2+VN7da/qRR23n+QMq1OVUOYBV2OT1Rbwr2ickCwl/FoH01dv
         VP3ME5AgcqX9qO1TepgZzro6Rn9u8US2+y+jTLC5AM3U/A/hREHMrobyG7YpXsnCZxtL
         oQZP5umBdlPsnJ/M3qAvOvbONZfIkLok6z8q/UgtQbZKktSbF9MMRgzwqe4hGt0J6+6W
         SQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940013; x=1755544813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpPp5bEZyU1lFhxZe99QopWjy0DQcPLOdlguwnbWoqA=;
        b=czHtCjDJWJts+88HWnUEvnbsRSzRO041caiPpQHziM81HitOQrElBwb69iGdXHAADC
         /WPsC/nTvsV6J4WLKf98bS901UGNvChldzPyrOBoSleNzj95HV1Drnmn860vnNiOxqK9
         oy31MOpUAnOEk9kY5ogGVPuP2609Rw2y7LCaiIU013RFhGWcSktcotB+DwDqX680llem
         jy073Krm5lHbtZ0ZUnT98WXMl4pk5RHYzHbsdXWcf3wnEGFBJaZpK5WK8r7jxq1sS81D
         3F9FMBGBbU07RfY3VSZ//cSfJa6ITzPzoznrGWBp+Q1ofqNiW5qegVVnMeGEAPVWn1iK
         oVbA==
X-Forwarded-Encrypted: i=1; AJvYcCWfrxZAQ9wlIK0VE92V5bZY3I0bjRvvAoEyVrVgQuQe7vC07Wf/Rmq3r3zCY/wWnkx7/JvoH8Ma4Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqNICT1qVPyQiiuR9qt9nhoFlPbunW9b3bDh2yARaglKQXbtF
	BIS8WvPxdm9jfz4D53vFkOoFOXA5bxa93dkqkUavkxwWdWxNyogsSpUI9BYiXUgQIX5vEunZw+A
	fUvuLcdJQKtHFfzJ7cCdcpDsThvIc6Cg=
X-Gm-Gg: ASbGncs2c7TjrJteBQlHHiZdydHZ76FlCcGYOS/jnT1lR5INpZ9WR3yxdoRZa8i9I5i
	QSQ78mkfUL+X0opVp+5bZsR4cAKgOblmLLNkZwR7TkShAaFa44vKozHudG+QYt22Drgbvm1OJnW
	KH7kLs8ZKHk4j6pik1P2kFX+uDDvlCzd7uKA7C58ElWh58LICG4vgrS43UEG0rDFafRwLSq8bnS
	LTeHl2hPQ==
X-Google-Smtp-Source: AGHT+IHNFddxUfMnsR3OZaGALO5eW7GHSslcRvSB5FxfHD+/GjRM2EDGH4/EMm/rM9N62/mSXGOyziafSRq+gupbKt8=
X-Received: by 2002:a17:907:6d24:b0:af9:6065:fc84 with SMTP id
 a640c23a62f3a-afa1e02cf42mr63240366b.27.1754940013140; Mon, 11 Aug 2025
 12:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811155453.31525-1-hansg@kernel.org> <20250811155453.31525-2-hansg@kernel.org>
In-Reply-To: <20250811155453.31525-2-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:19:36 +0200
X-Gm-Features: Ac12FXyWE1WMF8t6vteUtgTPaVWR9XF18YK6AH-jRAq4cBhPhysK9KKuI4dS534
Message-ID: <CAHp75VckeZczX4yniOy30PFg7TZRJM2D=GJEKX8s2EAcBK9F9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] iio: consumers: Fix handling of negative channel
 scale in iio_convert_raw_to_processed()
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> There is an issue with the handling of negative channel scales
> in iio_convert_raw_to_processed_unlocked() when the channel-scale
> is of the IIO_VAL_INT_PLUS_[MICRO|NANO] type:
>
> Things work for channel-scale values > -1.0 and < 0.0 because of
> the use of signed values in:
>
>         *processed +=3D div_s64(raw64 * (s64)scale_val2 * scale, 1000000L=
L);
>
> Things will break however for scale values < -1.0. Lets for example say
> that raw =3D 2, (caller-provided)scale =3D 10 and (channel)scale_val =3D =
-1.5.
>
> The result should then be 2 * 10 * -1.5 =3D -30.
>
> channel-scale =3D -1.5 means scale_val =3D -1 and scale_val2 =3D 500000,
> now lets see what gets stored in processed:
>
> 1. *processed =3D raw64 * scale_val * scale;
> 2. *processed +=3D raw64 * scale_val2 * scale / 1000000LL;
>
> 1. Sets processed to 2 * -1 * 10 =3D -20
> 2. Adds 2 * 500000 * 10 / 1000000 =3D 10 to processed
>
> And the end result is processed =3D -20 + 10 =3D -10, which is not correc=
t.
>
> Fix this by always using the abs value of both scale_val and scale_val2
> and if either is negative multiply the end-result by -1.
>
> Note there seems to be an unwritten rule about negative
> IIO_VAL_INT_PLUS_[MICRO|NANO] values that:
>
> i.   values > -1.0 and < 0.0 are written as val=3D0 val2=3D-xxx
> ii.  values <=3D -1.0 are written as val=3D-xxx val2=3Dxxx
>
> But iio_format_value() will also correctly display a third option:
>
> iii. values <=3D -1.0 written as val=3D-xxx val2=3D-xxx
>
> Since iio_format_value() uses abs(val) when val2 < 0.
>
> This fix also makes iio_convert_raw_to_processed() properly handle
> channel-scales using this third option.

...

> +               switch (scale_type) {
> +               case IIO_VAL_INT_PLUS_MICRO: denominator =3D MICRO; break=
;
> +               case IIO_VAL_INT_PLUS_NANO: denominator =3D NANO; break;
> +               }

Now wondering if checkpatch et al. are happy with this style. Not a
big deal personally to me, but if we have warnings from the tools
perhaps it's better to avoid them.


--=20
With Best Regards,
Andy Shevchenko


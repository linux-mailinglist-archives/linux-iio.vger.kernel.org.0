Return-Path: <linux-iio+bounces-15933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E43A4083D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47516424F72
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16919D8AC;
	Sat, 22 Feb 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0m8KywF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3820AF98;
	Sat, 22 Feb 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226284; cv=none; b=PA8S4v4xsTZTCY2jHIJZmmSQAsbvtM4fbCwVNo78xC/TtcDzi4/JMfKLctWmsK9/U5YyWa+zFfQihRkoQwcaBx3cmRxWCOgACXmwBvagj8B3PzVatnDoPo+DSRx807LH+pX2T1OOtwChMDnCPHSYd4UXWERyZDU67kXkZP6WE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226284; c=relaxed/simple;
	bh=mLxhZTOj27R+dTNlE0OdxaRjvavfPa9bJxD6ENetFX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg9yvW5hz8O3gpuyRxSK52Bp4ugvJ5DNWVu2ah/J83PU8hiW3fRSBfaI99qGdl2SCv4X3ZhAdB63ObsO4Xd1mXuEnlPLQfmlzLR9RPnuSqUKRN7XzjJMhyn550mTDLBkNO+E3PQo1flh5Z24w8oA46OC1wMpbqZE8owyMW7OKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0m8KywF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so27712755e9.0;
        Sat, 22 Feb 2025 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226281; x=1740831081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNCCiP7RRRUyS4WfOdLncoGS7gW6wazUd+UuIMRSe4A=;
        b=R0m8KywF5tpMkwJKnPQk6zL4WL9PH2q7torvJKXvOfZo7/pNmkgULGaaw9zlzkhgUs
         TUuRjRdJ2Imp4Lg9i5W4xuxzJsIvYdp2TuinbBjNZMmYjBFzKloC8dFdCj9JTkQgVb0V
         HdzRwRGdXttZfuXFS9V4He1lkFXd2A1J7HECfQscIpo3uM0Sxi3bF2kPzPVXqemhEsKq
         wF6D5p3jLx+GvtVTrJQeqjY6x8ycGpoo+VL7tPJ8S3RxCGkf2bkKcq9nbMI5FOr+FkcV
         2D/HOjOW+j5ppTyUI+p5DJK57X4dMXDXhKoQW4nt6nbcob8LtMWXYONaTfAehA+la4zk
         R+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226281; x=1740831081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNCCiP7RRRUyS4WfOdLncoGS7gW6wazUd+UuIMRSe4A=;
        b=r+biJhGf9iC1y70N7xR9eCWsTRfwHbFl5sit4EK/9yn3g3fQDcVtpGJ63OYDapMewh
         N04+f2iiNgGXWDJd7no7sB2eNkMiLjEPDm2I/mvcgFUVH5WTfSUe3EDtEHUSb/+zGCjO
         noU3IRrQFNWIU7rxHXq/VDxYltZwSXR72zUGVBaYf1gHt7Q+oG1KaXUmN5NlqZClKGpP
         0z9ZNk7cRwQJ4BgQYeZC/Ikdxvxtwm2Y06bPveDkNdlp2ny4ycbhyFYswKBlQRXqOvXy
         oe/o1Q5vzs2UOsHv6rkkMTcorxeTyWe6QmtatSXhmGTS9U2cv2D0TOI4tHxAcCLnK/W6
         wq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2+S5PpivZvw2Ry2Uld9DnMeUbiJQOLqLsYeodzGerZsutF4o29trlEQVBYkqOUxe1pLYeBPosNqH@vger.kernel.org, AJvYcCXR5pZgDi+TXgTiGkwA/f0TLcVQ0V11BZidbLvDYPD2mFcciRRjySKGUwYOXsw5LrzUa/wHyh2RaMAiXTnm@vger.kernel.org, AJvYcCXVwKGxrNJKIqcxIQmBPh7kHISqx6jvaQ0ISytsOY0dfNWDCSGQ5cF61zYZMc0YHnlvimseGzWKxOzFors=@vger.kernel.org, AJvYcCXmm0bn3E3+sB24TnC3OP4OzQUTtYkIzVYrE0i09/H5zDcFS8YY9pJu/+AuFUAUsre1yg3FQzah1Eip@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7G+2X+YGNo6tmh2miNVpGUw2QBPgClJHLQaZWX0W3nKVczqk
	6d5DgRVSgOzVTI5BzNuSpyR6gU3uQvxTIua4ICjV2AT8PapTLH9M9AQUoz8tPdL41oZoMdcYtUF
	vYPPSRibPlKVdT4f1FuPl9iGEiLQ=
X-Gm-Gg: ASbGnctBrSMij1HlUYlNkQHfKmSeVAEnQnJJfLeUYJPnrHQDwcZOjQ0OG0JY3LlcVue
	TC9lArsF8h4DNvNxY6Iy0q4VD30ZM8CHvA8ZQURfeLBlZZx9kve9Pgvi8nYH8oQDnU5oeUu32rB
	1lEHdVinlL
X-Google-Smtp-Source: AGHT+IFH+v891imgr4v4woH90dELrHFhYpZLGiD6se33nDibAnm06EzmlPNU+a6OdoEHBxYADPJA99dPusBeaFT3bq0=
X-Received: by 2002:a05:600c:1d88:b0:439:8bc3:a6a3 with SMTP id
 5b1f17b1804b1-439af7fa4dbmr55192325e9.3.1740226280795; Sat, 22 Feb 2025
 04:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-3-clamor95@gmail.com>
 <20250216145445.1278b6ae@jic23-huawei> <CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
 <20250217142433.12183a17@jic23-huawei> <CAPVz0n23XYG4R6JhMd9qOoKW-PbJk53j-A3iRgb-znLHt5hm8w@mail.gmail.com>
 <20250222120537.13d2998e@jic23-huawei>
In-Reply-To: <20250222120537.13d2998e@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 14:11:09 +0200
X-Gm-Features: AWEUYZmt-0lFojV2uIbd5MnBI_kZ9O9BNsVpC_4D6Kv_RxzPIftV4C4KQaaXLuw
Message-ID: <CAPVz0n04RCb9DWVScBR00Zk+PQBwpnjKSbig2D6yr0-hoej1kQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:05 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 17 Feb 2025 16:32:33 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:24 =
Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > >
> > > Hi,
> > >
> > > > > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > > > > +                         struct iio_chan_spec const *chan, int=
 *val,
> > > > > > +                         int *val2, long mask)
> > > > > > +{
> > > > > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > > > > +     int ret, gain;
> > > > > > +
> > > > > > +     switch (mask) {
> > > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DAT=
A, &gain);
> > > > > > +             if (ret < 0)
> > > > > > +                     return ret;
> > > > > > +
> > > > > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK];
> > > > >
> > > > > I may have misinterpreted the other thread.  IS this value in lux=
?
> > > > > If it is make this channel IIO_CHAN_INFO_PROCESSED instead.
> > > > >
> > > >
> > > > This is actually a really good hint, I will check if this works out
> > > > and if yes, then definitely will use it. Thank you.
> > >
> > > From your other reply it seems we have no idea of the correct scaling=
.
> > > If that is the case, then channel type should be IIO_INTENSITY as
> > > I assume we also have no idea if the light sensitivity curve is
> > > matched to that required for illuminance (which approximates the
> > > sensitivity of the human eye). Various datasheets provide completely
> > > garbage conversion formulas btw so even if we have data this can
> > > be problematic. One recent sensor was using a green filter and
> > > saying illuminance in lux was 1.2 * green which was assuming their
> > > own definition of white light.
> > >
> > > Jonathan
> > >
> >
> > Then why IIO_LIGHT exists at all? If you state that datasheets provide
> > garbage formulas and sensors cannot be trusted and all is around human
> > eye, then why IIO_LIGHT is still the case? I did not recall any
> > drivers for human eyes (thank god). Please be more consistent. Thank
>
> It exists because some sensors do this correctly, or at least a good
> approximation to the standard sensitivity curves.  This is done two
> ways.
>
> 1. Good light frequency filtering in front of the sensor to compensate
>    for the difference in sensitivity between the measuring element
>    and that the standard curves.  CIE1931 (there are a few other standard=
s
>    but they are close enough that we don't care).
>    https://en.wikipedia.org/wiki/Illuminance
> 2. Multiple sensing elements. A common reason for this is to remove
>    bit of infrared that we don't want. Often the calculation is a
>    non linear combination of the various sensor outputs. Such a driver
>    usually presents several IIO_INTENSITY channels and a calculated
>    IIO_LIGHT channel.
>
> In both cases the datasheet tends to include a comparison the the
> CIE1931 etc standards. There will be small differences but that is
> very different from taking a sensor that is only sensitive to green
> and weighting it which is the example I gave above.
>
> These sensors will compensate for the different sensivity
> of the human eye to different wavelengths.  E.g. if you
> think blue and green light LEDs have the same brightness then
> the sensor will give close to the same output.
>
> Anyhow, light sensors are a hole I have gone far too deep in over
> the years. Key is some manufacturers provide insufficient information
> or take the view it is a problem for the integrator of the sensor
> to deal with. For those we do not pretend to know the answer and
> use intensity channels instead.
>

This is quite an explicit explanation. Thank you.

> Jonathan
>
>
> > you
> >
>


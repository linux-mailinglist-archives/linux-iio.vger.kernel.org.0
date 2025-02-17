Return-Path: <linux-iio+bounces-15707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B82A386A4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDA3B3DE4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670732206A1;
	Mon, 17 Feb 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1eBe6KB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866B21E0AC;
	Mon, 17 Feb 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802768; cv=none; b=r3D5IhchMow6QuGv8+8w0Wh/e324PIB+jb5m/Q5+Tm6sVM9ZYHLir6OG0bLaCC+ljtxXFZayL9dNfKtzZdjiC9gU9vE1Li3112Fu3vROnGKOIak7My/JyaLxG1Z/LdgK5DpQpK40RPCUydJZg1az5LZ1sRPTxc5Kv7xOsjw8KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802768; c=relaxed/simple;
	bh=sKDYaaq0c2Hp4wMC3ACBd8r0owlVinDETRyfmGlQwKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2+pswSzZGfJKaF8/RvSsvY5xn7vVUcrQN/fGxMcGwfexDKJVBH+2+b1qJh2NAXEAiUSLKjkxAzgGqoTH31hwMJe3vzvI5fkqSFehQGPwUx7QYMgAxcaKQ1eAWHN4dTFEZPYWsMJ8OBTCZBp1f7R4Hk6jtMpYszxmGzfIeU74X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1eBe6KB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so29320105e9.3;
        Mon, 17 Feb 2025 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739802765; x=1740407565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJzwx08la2C1SxI0rUWHh4fFWhyVFYwMb5Tu4Fyh7Zs=;
        b=c1eBe6KB4mPOnH0Tl7IL+dIFvAEc3woHKnLEHLFEWjbEcvBIDc4g1PcbWbyuPne84j
         AWlqWmXOQWxJ6Pzmp+i4BISZbGzr9Hp3zkEMdk/VNqQ4zzcxnBabe+TgqW6bDBGYb3Wa
         qOnviK3o5tr40WkW86d+eDwYgxxaiOQocKDg8ji4WLQ6A5mC6n58P2RoxCybFmvaFRC7
         2JusjgAXBubg/1nCEJ7cvZZMSNl2rB1d0rFdzbtWByyAB45/FbjwNqwz0ORzo/RBI1ZJ
         JjQA/J+nxtq/rHJLGI7cSOAWgUPrKhqbkrR6fH0bdzOlZ92e9Fe/bh/nggS6HM5kL9KY
         b2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802765; x=1740407565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJzwx08la2C1SxI0rUWHh4fFWhyVFYwMb5Tu4Fyh7Zs=;
        b=AKrspWe9BaPht7OsGUIaIGc+3I+TXv7GLmglg/OCRRG9pHdfpdUGuSrxRR8IDYSY8U
         rT0UEZiF2ABN/vvvkzK2s2LOidnLrw2rlPDVx4kNoO7b0VgNG127ra5cd2bgXqufeQyS
         TSKY/NFIks9r7CA/s2ZwhjbGU4AV/oPkYjvHHLbcdukkQ/vQx92JxnO3zBiQHXxic4Gv
         N8C7nghP43BactFW6v8IsEJxLoqmx7WgmzZ4H6p0m4ofD78lFIZ5LvdiYuiabbKOkmm0
         +t4PC/9sSm6Q82X+sKFXDHwL7h+OJPp2eiIQblX/SzTMp+VL9dC6Nm/8jMDpMWVYC33K
         ycTg==
X-Forwarded-Encrypted: i=1; AJvYcCUKKoYuUPd74GRw8bLJD9G05JiQQE0aHBH0t7DKCxsLFwmxam3CisrnPbxEDmp2YpDJqnhk65mZS9UA@vger.kernel.org, AJvYcCV/iQDkryorwDes2s5c5k8B2I2+AUX0h5qsC0IrIbxqMGt9872/PUYQA3N6tXmra/66B7YsddcO6lIdfdvO@vger.kernel.org, AJvYcCVYe2+Rb9QZbWcONKA55/4Gf4cyo7UzuBBJT2FQl5A1W405Y7sfC+TwoQQETcfrmwV1z0iyuOUTPjGS@vger.kernel.org, AJvYcCVvVI0dvVwdYTigD41pVhIgPKEw7MQTyBL2vbNPnNUUV0IHfpkOiv5yltlgVeuDvjrO7tZaz82emJfbgZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfwuVEWhwIBImU0mwI6hJFjAsKAjvNRTTjCryN/xx/cbV3l/L
	0QeFUKceNSjUl/qYbahqwgw2WfRd6XSZN3n5MQcdgSQgz0lDyd6SVoocm7A74LnsUdzHLsAbXoH
	ELpyjqHYJMp1Ftq0+0VVL1QqypSY=
X-Gm-Gg: ASbGnctKPvpYCkVaJtwZtKx/b+Vmah1hlNlvZzSgBIbmu4Y0lxlYDof35UMLXuNeXT2
	MW5NuFAHFlf4szdRMWol6uG+EY1JeKI3yNrUcKbosL4XhvZAkGRvHbA831z9lm3YH0qcuDKfQiQ
	==
X-Google-Smtp-Source: AGHT+IHkotc7KNaOQu4hykaxmy73N1UFvxrlJuvWdR0VFDlrYtSOr1Y7pSqV8NkMG1SW0Y6UTeTjOVvp5xMkPCwHlEU=
X-Received: by 2002:a05:600c:1c16:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-4396e6f6941mr99376525e9.14.1739802764627; Mon, 17 Feb 2025
 06:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-3-clamor95@gmail.com>
 <20250216145445.1278b6ae@jic23-huawei> <CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
 <20250217142433.12183a17@jic23-huawei>
In-Reply-To: <20250217142433.12183a17@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 17 Feb 2025 16:32:33 +0200
X-Gm-Features: AWEUYZnsbhDx1zkJQXC08y9cw8nR9CINmTm8UccEQKKlqKW9HbsUYo0iUdVD9Pw
Message-ID: <CAPVz0n23XYG4R6JhMd9qOoKW-PbJk53j-A3iRgb-znLHt5hm8w@mail.gmail.com>
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

=D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:24 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> Hi,
>
> > > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > > +                         struct iio_chan_spec const *chan, int *va=
l,
> > > > +                         int *val2, long mask)
> > > > +{
> > > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > > +     int ret, gain;
> > > > +
> > > > +     switch (mask) {
> > > > +     case IIO_CHAN_INFO_RAW:
> > > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA, &=
gain);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +
> > > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK];
> > >
> > > I may have misinterpreted the other thread.  IS this value in lux?
> > > If it is make this channel IIO_CHAN_INFO_PROCESSED instead.
> > >
> >
> > This is actually a really good hint, I will check if this works out
> > and if yes, then definitely will use it. Thank you.
>
> From your other reply it seems we have no idea of the correct scaling.
> If that is the case, then channel type should be IIO_INTENSITY as
> I assume we also have no idea if the light sensitivity curve is
> matched to that required for illuminance (which approximates the
> sensitivity of the human eye). Various datasheets provide completely
> garbage conversion formulas btw so even if we have data this can
> be problematic. One recent sensor was using a green filter and
> saying illuminance in lux was 1.2 * green which was assuming their
> own definition of white light.
>
> Jonathan
>

Then why IIO_LIGHT exists at all? If you state that datasheets provide
garbage formulas and sensors cannot be trusted and all is around human
eye, then why IIO_LIGHT is still the case? I did not recall any
drivers for human eyes (thank god). Please be more consistent. Thank
you


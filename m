Return-Path: <linux-iio+bounces-10866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F779A6917
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E1D1C2261A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A21F4FB5;
	Mon, 21 Oct 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BxinkhbI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090711F12EC
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515073; cv=none; b=ciW7xSabffzDOsANqZp+O8xpNtCVq7BbexDSLd2eSMYK/ReLZ6N4CbIMmGRBSJfuIuZcBugHrCM6toHSTU2GVIxVfl0YYIgyhGWBj5tN9snhWu25DTcnXjbCCY+YeeZXx/CS9liN0TBAPL6tWRFGLTrHIxeVgLt70nI6SYpPSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515073; c=relaxed/simple;
	bh=V94Ij3ae1rZVmL+jxKjTKUB+2p4lVCFw5V42wkRlmNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIWh6f0TGEOKeIcOamlaQzZvY+mtb/PH9jra8UvS4lgC0EK5DHN0k0YpJrTyDl2kLIa2iJnfEYGvZEQhajEI5ptU1kaUtRSsxSzMzQnTy7ntpB/M/8AsFrRbfQIsvZVK/MvPCZB/VoEmHrh4ByJpA+Ab0GaiXhrXB7joN0ibWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BxinkhbI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53a097aa3daso4142104e87.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515068; x=1730119868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4x0frPjt5/BOSJ9+yy/X3eM08JC+jz1BkqZ97LB2LU=;
        b=BxinkhbIolaZt7V0mXqJwX1rjsQq5gLUkpj0/0egfWJIczRp+6fczOr0/MloDhqncM
         oPL66Jwead4z/83KS3lQGCWG2r9xa2IM5mq3FNUDY+V0WwujlXUo8WK3jzyfIMOEMdeo
         a5/I9l2xjPh9+MauM35OH2Yklj6Xz3+0+30wYDvNUO2wBffp3Z11tx6UczFj7xOcTtf/
         lo5bt/v5jZpxxRVopqBV9k/Oag/Q5S1m3UcaOaMJc6ZI6tKz1KUcd2dhCBJXA+EaAihk
         jripIz+9Fw+89KcmYLyeItz+3aZQ0cfU2NNJMe/h5jgI/DH+u5w+/6I/XAJAH5ZaVT8M
         hPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515068; x=1730119868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4x0frPjt5/BOSJ9+yy/X3eM08JC+jz1BkqZ97LB2LU=;
        b=smr/umpJC7didYi8H9Q26AvTRLu74PoGqnLhtFdP1fyGDSHQfC6fifgjG32Ip7PtBI
         Jb7J/NDpG83VjCCw3giDRWTk6u+E03S82D7d9pHBQ0Sy8UTTFomzzfdKoRP/I75kmpnT
         zHf8smhJe6L79bWYBGyuljR7IiRwxKhvFD6+Rjx4azhOPoLFxzw6k4oYpxmptZcu2xLq
         PpEUQkRBcDJB1eZHflwoYYXnGHD7xXo9TGjNxWx9IdoH/Jd4YrlW3MjdY6cKfwFY+HIo
         0TqCdIo845mt/oG6eOEY5MU7qFU5uU1AO8dlhHAAKmzzhcD5dXpQfxatfBSP5n1mKnb2
         vWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWfK0szuDXzf/lnSawxF0gvXGBW6r5GUN5AHhCdEoiHFjEEuGg5JGU6sX5vTH7XnH05GQdTASX8Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5oVV87EWT2068QdYk8gkb+dyh4pzs4tefiHNVvKi73o1g4Pc6
	cEp3zaQp0B3N6SW0aZxqXNDcOBroEpmit9456u4Ini40Hp0Lqebuq6EO5/lh0V1aLQA6q/apiJc
	x1DGTJQQw2Vx2LklwB4bHC26ZFD8if26r/jBDCg==
X-Google-Smtp-Source: AGHT+IE+MWgG9ymZWSMfk2GnXFlKQTXntyhXseGsCdBrJgITVmJEdzAzJOSda4D1TD0k+L/IINSDoacMOfpYM6ib3uo=
X-Received: by 2002:a05:6512:1383:b0:539:d428:fbdd with SMTP id
 2adb3069b0e04-53a1546d2f9mr5522728e87.53.1729515068095; Mon, 21 Oct 2024
 05:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
 <20241021-ad7380-fix-supplies-v2-4-2ca551b3352a@baylibre.com> <037d7ebb4d037edb32f9d717e456ab545621ea94.camel@gmail.com>
In-Reply-To: <037d7ebb4d037edb32f9d717e456ab545621ea94.camel@gmail.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 21 Oct 2024 14:50:55 +0200
Message-ID: <CAEHHSvZxrt3cPmmLwNj9nts9KhBWg4CwnzWnoTXYJL30AbJBsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: ad7380: fix supplies for ad7380-4
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 21 oct. 2024 =C3=A0 13:18, Nuno S=C3=A1 <noname.nuno@gmail.com> a =
=C3=A9crit :
>
> On Mon, 2024-10-21 at 12:00 +0200, Julien Stephan wrote:
> > ad7380-4 is the only device in the family that does not have an interna=
l
> > reference. It uses "refin" as a required external reference.
> > All other devices in the family use "refio"" as an optional external
> > reference.
> >
> > Fixes: 737413da8704 ("iio: adc: ad7380: add support for ad738x-4 4 chan=
nels
> > variants")
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
>
> Hi Julien,
>
> Patch looks good. Sorry if this already came out in the previous version =
or in
> the other patchset you mention but shouldn't this fix come first in the s=
eries?
>

Hi Nuno,
That was my plan at first, but doing the
devm_regulator_get_enable_read_voltage() first, simplifies the next
changes ... and also eases the review :)

If needed I can do the rebase

Cheers
Julien

> Anyways, for the patch itself:
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
> >  drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > index
> > e257f78d63edd7910fcb936ec5344922f8e70b99..65096717f0dd3ea6a4ff7020bc544=
d62b84c
> > b8fd 100644
> > --- a/drivers/iio/adc/ad7380.c
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -89,6 +89,7 @@ struct ad7380_chip_info {
> >       bool has_mux;
> >       const char * const *supplies;
> >       unsigned int num_supplies;
> > +     bool external_ref_only;
> >       const char * const *vcm_supplies;
> >       unsigned int num_vcm_supplies;
> >       const unsigned long *available_scan_masks;
> > @@ -431,6 +432,7 @@ static const struct ad7380_chip_info ad7380_4_chip_=
info =3D
> > {
> >       .num_simult_channels =3D 4,
> >       .supplies =3D ad7380_supplies,
> >       .num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> > +     .external_ref_only =3D true,
> >       .available_scan_masks =3D ad7380_4_channel_scan_masks,
> >       .timing_specs =3D &ad7380_4_timing,
> >  };
> > @@ -1047,17 +1049,31 @@ static int ad7380_probe(struct spi_device *spi)
> >                                    "Failed to enable power supplies\n")=
;
> >       msleep(T_POWERUP_MS);
> >
> > -     /*
> > -      * If there is no REFIO supply, then it means that we are using
> > -      * the internal 2.5V reference, otherwise REFIO is reference volt=
age.
> > -      */
> > -     ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "refio"=
);
> > -     if (ret < 0 && ret !=3D -ENODEV)
> > -             return dev_err_probe(&spi->dev, ret,
> > -                                  "Failed to get refio regulator\n");
> > +     if (st->chip_info->external_ref_only) {
> > +             ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
> > +                                                          "refin");
> > +             if (ret < 0)
> > +                     return dev_err_probe(&spi->dev, ret,
> > +                                          "Failed to get refin
> > regulator\n");
> > +
> > +             st->vref_mv =3D ret / 1000;
> >
> > -     external_ref_en =3D ret !=3D -ENODEV;
> > -     st->vref_mv =3D external_ref_en ? ret / 1000 : AD7380_INTERNAL_RE=
F_MV;
> > +             /* these chips don't have a register bit for this */
> > +             external_ref_en =3D false;
> > +     } else {
> > +             /*
> > +              * If there is no REFIO supply, then it means that we are
> > using
> > +              * the internal reference, otherwise REFIO is reference
> > voltage.
> > +              */
> > +             ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
> > +                                                          "refio");
> > +             if (ret < 0 && ret !=3D -ENODEV)
> > +                     return dev_err_probe(&spi->dev, ret,
> > +                                          "Failed to get refio
> > regulator\n");
> > +
> > +             external_ref_en =3D ret !=3D -ENODEV;
> > +             st->vref_mv =3D external_ref_en ? ret / 1000 :
> > AD7380_INTERNAL_REF_MV;
> > +     }
> >
> >       if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
> >               return dev_err_probe(&spi->dev, -EINVAL,
> >
>


Return-Path: <linux-iio+bounces-3663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A038F88645F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 01:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EEE1F231FB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322B389;
	Fri, 22 Mar 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfI8V4G3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17076116
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067570; cv=none; b=ZXsJZuwUH99MRN7T9Vsxm6A/jXE9LfaZh2vqf/LT3Ls0qQDWisw7B5HObMFNdk6jEDOV5NAJhInAT9cemsTPw8HG+MRW4yPhB39m6iDZllMnYlIbNxKw2KyTTakLz1t19I6cycnb6AKCSO8nLMC8ZSHxmbCztzY95awoJnzQGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067570; c=relaxed/simple;
	bh=3NyE07jVlltZu9uXkueR9hRTE+EAxoi1jC/8SBKHTlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2eFZRWy11ioe/CL+/eLLFhmxf/UlENtNL/ZCTykYHRNbtLjxn3BWK9DK/lS6yPVsI/iwdMqdrvAPml/pT4EIOJqvHTV72M3ZVj/nAhkT5TTZPy89/nu5jziCn/0HQkBfgmX2ZiQevSu2QCm3me3bxNbjl1gNFlgd5Hg8Joq8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfI8V4G3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1617624276.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2024 17:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067568; x=1711672368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfhh3JG6TiZK8YLP9ybK+DwTAzB2uyFOYgJ/DBPSiC4=;
        b=dfI8V4G3kVNYGJN7cjxfTvBWW2LqFcbqzkZHqxv4s8OebhVJS5OgTXUVNQyaSl9NXd
         hGhvIR/MuLee2T8L5lb6yagwCeNjSqxKlx84T4V5suUC3PapQECDWpGYxXJt1+WRvaL7
         C61rjoYT3tNr2TgTNmtV4V5+bNwIbmKMr9e+fmS2vXzwKeVsHAqJRiM6x8nY6rXa+q+o
         nhHVeeLNSKhkS2LeODkBSyRfHDO04ATZsoHTcI6p3nZITkQSCrNPkS4mj6BPsP47bkRr
         j53blfSaVq00mU2BQnhpDMEBc+aZrW8KmxNpC2Z/svQIRIjwlYiPGkZICFQ1GVqdye5H
         CspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067568; x=1711672368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfhh3JG6TiZK8YLP9ybK+DwTAzB2uyFOYgJ/DBPSiC4=;
        b=U7gz/3oH6oywDqarAffZAGR/XuYScc+1VG5nhzrBsINVPcoFSA6MDqShLtI8Yp/VWW
         mmqD1fibLPIqb98TzdEnvC9BX+guCXCe7RGiakrz3SrttzwpzBSsKDKNxXLgLbHUqVUs
         tKvCv0/Y2WYxsZ4oNcE6o84V0mxVCDPpaUAp9uLFgjcrz+V+llU4atR7l/dThsOoTLEk
         w/wpD466wznDrABFDa1UDvFnoyhcAp1yp7g0JOzaDXxUYcUtqkoOB0Bo9dLkYHHmtac6
         MIOkd990aStGYsxS6lmOGCJCwsM5tw6sJKlklfrFRcV4uLZ6mjDeUuF0fFhJpj0HvL3N
         cO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7oPK4REu9+5ebh9Qgsl0IoMyCzVTvLjXhbaWnhny62Q3PMDBro1U+IAHuriYRfRpDopeqVxUnzJHNIZECI3WFPMNGFeb2hT8
X-Gm-Message-State: AOJu0Yzv6Pl5ldT0qzhus5+O0za+2hY+kYVMx2MMmDXlqMibkDfhDcvj
	FQslBZ+X4d8Uk/OW1Vsv9kGtY5OCSVB8kyTkWEiZmgC+kUtLBtH0TTLHcqSkE2xGBhT3pUsGeLf
	gmOGxH1mAizC60ch3gFnrmoYgU7xsKmFKKy/QvUfT
X-Google-Smtp-Source: AGHT+IHeuOP9bV931ATO9eA9I7kXDo+csPgRZ0vW38ApZzpxwwhz+jVUg3E7KTumx0T0QI2l6gnT2WoW0JeYoNiCK/I=
X-Received: by 2002:a25:d349:0:b0:dd1:7532:c0f3 with SMTP id
 e70-20020a25d349000000b00dd17532c0f3mr767000ybf.16.1711067567877; Thu, 21 Mar
 2024 17:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212713.257600-1-l.rubusch@gmail.com> <20240319212713.257600-2-l.rubusch@gmail.com>
 <7f349041-bf2f-434d-a9cd-a82ac902f613@kernel.org>
In-Reply-To: <7f349041-bf2f-434d-a9cd-a82ac902f613@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 22 Mar 2024 01:32:11 +0100
Message-ID: <CAFXKEHZr5S83sra6_eWPS+Hn03rFDPh5nmNHb9dfXYGjfpsx9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:37=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/03/2024 22:27, Lothar Rubusch wrote:
> > Adds the spi-3wire feature and adds general refactoring to the
>
> Add
>
> > iio driver.
> >
> > The patch moves driver wide constants and fields into the
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95
>
> > header. Thereby reduces redundant info struct definitions.
> > Allows to pass a function pointer from SPI/I2C specific probe,
> > and smaller refactorings. A regmap_update_bits() in the core
> > file replaces the regmap_write() to format_data.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---

Agree

> >  static int adxl345_spi_probe(struct spi_device *spi)
> >  {
> > +     const struct adxl345_chip_info *chip_data;
> >       struct regmap *regmap;
> >
> > +     /* Retrieve device name to pass it as driver specific data */
> > +     chip_data =3D device_get_match_data(&spi->dev);
> > +     if (!chip_data)
> > +             chip_data =3D (const struct adxl345_chip_info *) spi_get_=
device_id(spi)->driver_data;
>
> Are you sure you need the cast?
>
> And why aren't you using spi_get_device_match_data()?

Agree

> > +
> >       /* Bail out if max_speed_hz exceeds 5 MHz */
> >       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
> >               return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz =
exceeds 5 MHz\n",
> >                                    spi->max_speed_hz);
> >
> >       regmap =3D devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
> > -     if (IS_ERR(regmap))
> > -             return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error i=
nitializing regmap\n");
> > +     if (IS_ERR(regmap)) {
> > +             dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initiali=
zing spi regmap: %ld\n",
> > +                           PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
>
> Why are you changing correct code into incorrect?

I'll adjust that. It looks odd, I agree, but is this incorrect code? I foun=
d
similar code in the neighbor adxl313 accel driver. I may change/update
that then, too. Thank   you for the hints.

adxl313_i2c.c
72        if (IS_ERR(regmap)) {
73                dev_err(&client->dev, "Error initializing i2c regmap: %ld=
\n",
74                        PTR_ERR(regmap));
75                return PTR_ERR(regmap);
76        }

> > +     }
> >
> > -     return adxl345_core_probe(&spi->dev, regmap);
> > +     return adxl345_core_probe(&spi->dev, regmap, chip_data, &adxl345_=
spi_setup);
> >  }
>
>
> Best regards,
> Krzysztof
>


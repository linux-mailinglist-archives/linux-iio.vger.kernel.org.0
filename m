Return-Path: <linux-iio+bounces-3733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA6887CD4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Mar 2024 14:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC53C1F213E4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Mar 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE6717BC1;
	Sun, 24 Mar 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtoBhLlO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F61A38DA
	for <linux-iio@vger.kernel.org>; Sun, 24 Mar 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711286096; cv=none; b=SH/fOQW836DVTR1H1GJwCArEwqMCkN7NgZ2RPoRM5J/KDpe7oIT8XwYLkl0+rEuFW7KlsvtkC89nG0LhZxvmcgFNNlGC+9mcD0hTC49MZtC2skLZtTDv5ZGh4wlJKtF31qvnr92r6t8fb8F70qKVFqCf386F0TluvYOSlZ4b018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711286096; c=relaxed/simple;
	bh=tIE+eBcQdh/5mlKAQWBZqlcEkytyoDR6dvVJwKBwaWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdLmhcbNBH58vWMB1BVYzZpsCXQzY5X0SZLF7MC521G0YnPi/z7nfaOv0SnUWt6ipUPJ1Cp7W2tw3E1nCIjx4y5lyhjOBX0A5BAgdrLi/vecnx8CJk8vMeUn6KmVRP9Dzd2IgCObkFnDGJtdC7Nlai3V0I+5DRFuqDFTovH8fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtoBhLlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219BEC433F1;
	Sun, 24 Mar 2024 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711286095;
	bh=tIE+eBcQdh/5mlKAQWBZqlcEkytyoDR6dvVJwKBwaWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AtoBhLlOB2286BXS9ezLDR5t04JcrmmXpbV8bz170fzFdnvYwqEY5l1ru/T+ou9TM
	 WghQ6h9qHeROeIsy5Rc3AdeEQKisioBJ/UKR2WsPhc+5iFTKJjtzf1sUAWgIxDA9OI
	 BKXecW7sMI4mGmSwAieEsxWLqTGuSHmyV7/9xtzecqlH1qz9sNElneYFQK/7RMieKb
	 PJccFOZR40YpqljljPq8sz7NQsYQS3lrmiJDEofUAX/a0GWOYtPzex8nV5wE9+Ux1P
	 +dw9n7PZCNxJ06piWdFZ6ZivWgRJpg5dSHvCyM8cZd/23AOE3Oyt8rkYKM6aMX3rKr
	 OF8SVS2aJCXzg==
Date: Sun, 24 Mar 2024 13:14:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
Message-ID: <20240324131441.1d148869@jic23-huawei>
In-Reply-To: <CAFXKEHZr5S83sra6_eWPS+Hn03rFDPh5nmNHb9dfXYGjfpsx9g@mail.gmail.com>
References: <20240319212713.257600-1-l.rubusch@gmail.com>
	<20240319212713.257600-2-l.rubusch@gmail.com>
	<7f349041-bf2f-434d-a9cd-a82ac902f613@kernel.org>
	<CAFXKEHZr5S83sra6_eWPS+Hn03rFDPh5nmNHb9dfXYGjfpsx9g@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 01:32:11 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Wed, Mar 20, 2024 at 10:37=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >
> > On 19/03/2024 22:27, Lothar Rubusch wrote: =20
> > > Adds the spi-3wire feature and adds general refactoring to the =20
> >
> > Add
> > =20
> > > iio driver.
> > >
> > > The patch moves driver wide constants and fields into the =20
> >
> > Please do not use "This commit/patch/change", but imperative mood. See
> > longer explanation here:
> > https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/s=
ubmitting-patches.rst#L95
> > =20
> > > header. Thereby reduces redundant info struct definitions.
> > > Allows to pass a function pointer from SPI/I2C specific probe,
> > > and smaller refactorings. A regmap_update_bits() in the core
> > > file replaces the regmap_write() to format_data.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > --- =20
>=20
> Agree
>=20
> > >  static int adxl345_spi_probe(struct spi_device *spi)
> > >  {
> > > +     const struct adxl345_chip_info *chip_data;
> > >       struct regmap *regmap;
> > >
> > > +     /* Retrieve device name to pass it as driver specific data */
> > > +     chip_data =3D device_get_match_data(&spi->dev);
> > > +     if (!chip_data)
> > > +             chip_data =3D (const struct adxl345_chip_info *) spi_ge=
t_device_id(spi)->driver_data; =20
> >
> > Are you sure you need the cast?
> >
> > And why aren't you using spi_get_device_match_data()? =20
>=20
> Agree
>=20
> > > +
> > >       /* Bail out if max_speed_hz exceeds 5 MHz */
> > >       if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
> > >               return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d H=
z exceeds 5 MHz\n",
> > >                                    spi->max_speed_hz);
> > >
> > >       regmap =3D devm_regmap_init_spi(spi, &adxl345_spi_regmap_config=
);
> > > -     if (IS_ERR(regmap))
> > > -             return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error=
 initializing regmap\n");
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initia=
lizing spi regmap: %ld\n",
> > > +                           PTR_ERR(regmap));
> > > +             return PTR_ERR(regmap); =20
> >
> > Why are you changing correct code into incorrect? =20
>=20
> I'll adjust that. It looks odd, I agree, but is this incorrect code? I fo=
und
> similar code in the neighbor adxl313 accel driver. I may change/update
> that then, too. Thank   you for the hints.
>=20
> adxl313_i2c.c
> 72        if (IS_ERR(regmap)) {
> 73                dev_err(&client->dev, "Error initializing i2c regmap: %=
ld\n",
> 74                        PTR_ERR(regmap));
> 75                return PTR_ERR(regmap);
> 76        }

dev_err_probe() already pretty prints the error so no point in repeating it.
It also returns the error value so you can do it on one line. dev_err()
does neither of these things.

Likely that axl313_i2c.c could be converted to use dev_err_probe()
for all calls in the probe() function and anything only called as part of t=
hat.

Patches welcome.

Jonathan


>=20
> > > +     }
> > >
> > > -     return adxl345_core_probe(&spi->dev, regmap);
> > > +     return adxl345_core_probe(&spi->dev, regmap, chip_data, &adxl34=
5_spi_setup);
> > >  } =20
> >
> >
> > Best regards,
> > Krzysztof
> > =20



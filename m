Return-Path: <linux-iio+bounces-24628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37DBB09EF
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F21888799
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850DB3019C8;
	Wed,  1 Oct 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GjqxvwhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195423019B7
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327405; cv=none; b=UdnsRCxK8wYe00LGjyQJ20A8aUAJJQ4saZp0BQeNJ8xpYH6PP5QL9HlGae/TFY7h02D1jPEJRQlOdkXyXf9p6WQbiAlc/BoMHUulnAQSdbFzT54Od+D21bGh2Dale/ziBT4RPBQv99YyCOqj50PPg9IzTM81Wnj9RgHBNV6imeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327405; c=relaxed/simple;
	bh=szzmqeKsAUoV+Q6Y3jf7azCuZZXteVSq14yvGeqEKCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVR8DKhM9483PHDz6qCbCoz276TLdcKGY6u9dUmDtgR2DggcJuzjA221g96YKlzdpg9nCxmziIzmTiTSplKgafTyWFFBhnO7RLs/zGKpt5Vq2zWVvE2oCQCRhpFaK++x5wFEXuPWHtx1QFpb+8QAjzOXJl9MVbHEGVFjl9StLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GjqxvwhQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-367874aeeacso54005131fa.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759327401; x=1759932201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F+hUr7PuiDitSGDFbH2L30vHATzKos1tNbEgW2ByQw=;
        b=GjqxvwhQ5sIZ2cm+bpiDTnSm2sT/jFwuaI7KiZu1hhFTjSA9cXVqI8R184RKiAgFnT
         wbZS167oRtbXutOQMhxhwhjCfeA2LhedRViCP1hALTZRfr3gZddkevxNDTOlWVXsbcaP
         5EL4LUQuOYY4pnsRzfSuqpX1cNN/g6AaiNNUp33ieCelregx/Xtac4EgP1XdLsc4EMZG
         VBTIzK+4IVyBsaLJwLHPXQxg9eYY7sk9bNPtRjVMt9KxqVX6LMBWisNYY7zY2vLzkeAn
         oH8eeV6lk7Xetb//92nTU7xcq87OOA54OGutXUPz606481nyzLsdKOF68o+oP83lkM5R
         cxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327401; x=1759932201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F+hUr7PuiDitSGDFbH2L30vHATzKos1tNbEgW2ByQw=;
        b=taDP6hXJl4vDHwwES/wuufo0Djr2HAhcUexRgcfjKyfZvCJWkOAsoNJbLyEV2VtIcR
         ADQzsaw6wu/ZEbr1gKySPXkPLliT8VPcdZFsv5b+5dHqi1G/Y+fnb3nZ1caJHd1JHnk+
         TUNRXDBLqu7cNrC7AKr1xT02FbMzSJmRE2SPQ9F9KS4bLBrOkzMoKtSWFgZckXAGrYYo
         mOrVy428oe9Of/ke3pLM+x64ZLm2NbiFEGBKPFsn+I/ULACvh0ZZG46CKHS7ba+ElOP+
         pAy88IuT+HBCEIh1WwfNG7IKWbi2j8GNZd7eMjovFgvVsULD0U1mptLYewuhPhwbJ6lR
         3ykg==
X-Gm-Message-State: AOJu0Yy++goNomdG0Qov7Kt610sqWB3MMg5RvpBDyHNFkD7t7H01OpBq
	t+CcDRrAJzI5118DtMafKrtinCTgfaIMoSnrWWvjMeCqGq3SVQe+7Sj+1UL3800tUFvpmz8gsyO
	JVrIDAzjtVroT9cB03/OjKxajxz4g9PB10hh+tAMV5g==
X-Gm-Gg: ASbGncsJaFnuKUL3daAc7gDYdxR/ah1FubpPqXPXlNfNONC0Vp0CxM27kqWye36xDCX
	jOtEvkU/lH7NY6YPrlZbuLwBtHai8UqP2gxMP/ITKGBa08Ds2IuZM7njiBxN0vBGDrdWilq5Ver
	PkPFcAbNy0aNOc4l7zAQgiOx2gbfAIJN9Hor+Gzq2Gvf5TyZifcWjPBT2AbhpyGC56YqjaQcPcv
	UFyC7CNly1fawiSwBy1nC9Kcb6gmPY=
X-Google-Smtp-Source: AGHT+IGUOhVKtZZBo30NjuYbbFQbPDP8jkwpVX8fYAWQXYP0yAH59KHl2v2BijVaWTHdg6mlUdglrXMyOdNTFW+RIXY=
X-Received: by 2002:a05:651c:19a5:b0:337:e0e1:d11e with SMTP id
 38308e7fff4ca-373a73b4880mr10864191fa.18.1759327400926; Wed, 01 Oct 2025
 07:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
 <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
In-Reply-To: <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 Oct 2025 16:03:09 +0200
X-Gm-Features: AS18NWCAQofHIBjmN8qkDI5cPVVN4iUF4KyFBoYTrpleRFwu3IaeVciouW_aG7g
Message-ID: <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt <Marcelo.Schmitt@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:59=E2=80=AFAM Marilene Andrade Garcia
<marilene.agarcia@gmail.com> wrote:
>

This is looking very nice. Just one question still about the averaging
feature and a few suggestions to really polish it up.

> I have one remaining question related to the max_register attribute of th=
e
> regmap. The register regions that can be accessed are 0x00=E2=80=930x0c a=
nd
> 0x13=E2=80=930x1a. As suggested, I used max_register to set the upper lim=
it of the
> register region that can be accessed (0x1a). Beyond this address, there i=
s
> a reserved region that should not be used (0x1b=E2=80=930x1f). However, t=
here is
> also a reserved region that should not be used between addresses 0x0d=E2=
=80=930x12.
> Should I use something to mark this region in the regmap?

There is struct regmap_access_table that can be used with .rd_table
and .wr_table in the regmap config.

> +static int max14001_read(void *context, unsigned int reg, unsigned int *=
val)
> +{
> +       struct max14001_state *st =3D context;
> +       struct spi_transfer xfers[] =3D {
> +               {
> +                       .tx_buf =3D &st->spi_tx_buffer,
> +                       .len =3D sizeof(st->spi_tx_buffer),
> +                       .cs_change =3D 1,
> +               }, {
> +                       .rx_buf =3D &st->spi_rx_buffer,
> +                       .len =3D sizeof(st->spi_rx_buffer),
> +               },
> +       };
> +       int ret;
> +       unsigned int addr, data;
> +
> +       /*
> +        * Prepare SPI transmit buffer 16 bit-value and reverse bit order
> +        * to align with the LSB-first input on SDI port in order to meet
> +        * the device communication requirements. If the controller suppo=
rts
> +        * SPI_LSB_FIRST, this step will be handled by the SPI code.

s/code/controller/ or s/code/hardware/

> +        */
> +       addr =3D FIELD_PREP(MAX14001_MASK_ADDR, reg);
> +

...

> +static int max14001_write_single_reg(void *context, unsigned int reg, un=
signed int val)
> +{
> +       struct max14001_state *st =3D context;
> +       int ret;
> +
> +       /* Enable writing to the SPI register */

Always nice to put `.` at the end of the sentence in comments.

> +       ret =3D max14001_write(st, MAX14001_REG_WEN, MAX14001_REG_WEN_VAL=
UE_WRITE);
> +       if (ret)
> +               return ret;
> +

...

> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val, int *val2, long mask)
> +{
> +       struct max14001_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D regmap_read(st->regmap, MAX14001_REG_ADC, val);
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_AVERAGE_RAW:
> +               ret =3D regmap_read(st->regmap, MAX14001_REG_FADC, val);

I don't remember... did you give a reason why this should not be a
separate channel? Or just use REG_FADC as the raw value and forget
about REG_ADC? In any case we would want another attribute to control
the filter window size.

> +               if (ret)
> +                       return ret;
> +

...

> +static int max14001_probe(struct spi_device *spi)
> +{
> +       struct device *dev =3D &spi->dev;
> +       struct iio_dev *indio_dev;
> +       struct max14001_state *st;
> +       int ret =3D 0;
> +       bool use_ext_vrefin =3D false;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +       st->spi_hw_has_lsb_first =3D spi->mode & SPI_LSB_FIRST;
> +       st->chip_info =3D spi_get_device_match_data(spi);

To be extra-safe, we should check that this does not return NULL. I
think most drivers will return -EINVAL in that case.


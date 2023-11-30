Return-Path: <linux-iio+bounces-519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28FC7FFF76
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD961C20E5B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B159538;
	Thu, 30 Nov 2023 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rgrl6LR8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365910E2
	for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 15:30:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9ccf36b25so14844041fa.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 15:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701387052; x=1701991852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlkZfLy7XjVfeJnSAyVxLt4mO60J3JeK1Ayu4OTnn6g=;
        b=Rgrl6LR8zpZCooUNieWI3jD+Rfv1Qqm1fKKdaI+Q65R5bv8wc/EGFsuqmC5XorZokG
         er3Z1FJotq5XRS7Se/Gp/lgN+5yeZBHsMDLMiv4BL+n+3d9EYeLgsoq9aVytJ99v10QX
         COPyEAl0XrA1eLOSXWGlg//9n7FWb04XrQRxNfAENxOsrlX6de6I4mHFLBGmeM7Ye8BR
         7hsRPTGCwbmtbaxV+NpETD+76G8MxJojeIg+zx2uFqYEiGOOK+HI5u2115y/33nNMRec
         gOBhu5QNuCrR40bHEjqQA7G5yUN24QI958vVcfBH0H07gpIstst4Ky0fNbSjRtr0u+Sc
         KNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387052; x=1701991852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlkZfLy7XjVfeJnSAyVxLt4mO60J3JeK1Ayu4OTnn6g=;
        b=dAFsjSoH3tls6fa/RC8Rxa5m6ibUYv2swjDEgF+jXXHZdVka5vLX1xoISummfKIlgV
         H+9w7G7kg7pSIJHctZluFgnqOcoQkJog4i1uc80IQPk3mx/vNGzAyrg1EVC/WwAG8p8u
         +mZ6yp2m26rkehQEiiLiDNbV58EeBisrJtDNn7tHActvZJzB74XwHX3TP2MkzEOhjRya
         e/UYHJWGXsrsKQY0KdHnH4eFKI9qxi2gOHjpOJFYmvEUWuv4nY7K0nAtNPT7PmRbfLlH
         MWSYwseVtdJgQl7SRuUjoOs6/Tra3oXyOpWA97DUxMuZQaSYh3zYDYluetU0NoVPM52X
         qJrg==
X-Gm-Message-State: AOJu0YzRfvqoN/aNaj/KHv4MeebEgNsxky87a1uIY/TnrbM5FH29SOFA
	ivmTIiWjkRUYO5R2IwSBKfVLpimvgMiovLSfMS0Vcg==
X-Google-Smtp-Source: AGHT+IEXF8b8i2d8gUX/7XGbKeBhO5y4FoKURpNKXdVwOiELp1ycsJ9gIbh2TFOn8p7a8iYvPuGv0h95Jl3CjKO9auA=
X-Received: by 2002:a2e:6e14:0:b0:2c9:d862:c66b with SMTP id
 j20-20020a2e6e14000000b002c9d862c66bmr192908ljc.88.1701387051792; Thu, 30 Nov
 2023 15:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 30 Nov 2023 17:30:40 -0600
Message-ID: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
To: nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).

Missing a devicetree bindings patch before this one?

>
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.

Can you be more specific about what is actually breaking?

>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |   2 +-
>  drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++------------=
------
>  2 files changed, 157 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1e2b7a2c67c6..af56df63beff 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -275,7 +275,7 @@ config AD799X
>  config AD9467
>         tristate "Analog Devices AD9467 High Speed ADC driver"
>         depends on SPI
> -       depends on ADI_AXI_ADC
> +       select IIO_BACKEND
>         help
>           Say yes here to build support for Analog Devices:
>           * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 5db5690ccee8..8b0402e73ace 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c

<snip>

> +static int ad9467_buffer_get(struct iio_dev *indio_dev)

perhaps a more descriptive name: ad9467_buffer_setup_optional?

> +{
> +       struct device *dev =3D indio_dev->dev.parent;
> +       const char *dma_name;
> +
> +       if (!device_property_present(dev, "dmas"))
> +               return 0;
> +
> +       if (device_property_read_string(dev, "dma-names", &dma_name))
> +               dma_name =3D "rx";
> +
> +       return devm_iio_dmaengine_buffer_setup(dev, indio_dev, dma_name);

The device tree bindings for "adi,ad9467" don't include dma properties
(nor should they). Perhaps the DMA lookup should be a callback to the
backend? Or something similar to the SPI Engine offload that we are
working on?

> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
> -       const struct ad9467_chip_info *info;
> -       struct adi_axi_adc_conv *conv;
> +       struct iio_dev *indio_dev;
>         struct ad9467_state *st;
>         unsigned int id;
>         int ret;
>
> -       info =3D spi_get_device_match_data(spi);
> -       if (!info)
> -               return -ENODEV;
> -
> -       conv =3D devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
> -       if (IS_ERR(conv))
> -               return PTR_ERR(conv);
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
>
> -       st =3D adi_axi_adc_conv_priv(conv);
> +       st =3D iio_priv(indio_dev);
>         st->spi =3D spi;
>
> +       st->info =3D spi_get_device_match_data(spi);
> +       if (!st->info)
> +               return -ENODEV;
> +
>         st->clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
>         if (IS_ERR(st->clk))
>                 return PTR_ERR(st->clk);
> @@ -476,29 +522,39 @@ static int ad9467_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       conv->chip_info =3D &info->axi_adc_info;
> -
> -       ret =3D ad9467_scale_fill(conv);
> +       ret =3D ad9467_scale_fill(st);
>         if (ret)
>                 return ret;
>
>         id =3D ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
> -       if (id !=3D conv->chip_info->id) {
> +       if (id !=3D st->info->id) {
>                 dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected =
0x%X\n",
> -                       id, conv->chip_info->id);
> +                       id, st->info->id);
>                 return -ENODEV;
>         }
>
> -       conv->reg_access =3D ad9467_reg_access;
> -       conv->write_raw =3D ad9467_write_raw;
> -       conv->read_raw =3D ad9467_read_raw;
> -       conv->read_avail =3D ad9467_read_avail;
> -       conv->preenable_setup =3D ad9467_preenable_setup;
> +       indio_dev->name =3D st->info->name;
> +       indio_dev->channels =3D st->info->channels;
> +       indio_dev->num_channels =3D st->info->num_channels;
> +       indio_dev->info =3D &ad9467_info;
> +
> +       ret =3D ad9467_buffer_get(indio_dev);
> +       if (ret)
> +               return ret;
>
> -       st->output_mode =3D info->default_output_mode |
> -                         AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +       st->back =3D devm_iio_backend_get(&spi->dev, NULL);

Based on the descriptions given of IIO frontend and backend, I was
expecting this driver to be the backend since SPI is only used to
configure the chip while the adi-axi-adc driver is the one determining
the scan data format, providing the DMA (INDIO_BUFFER_HARDWARE), etc.

Also, from a devicetree "describe the hardware" mindset, it doesn't
seem like this chip (AD9467) should dictate a specific backend. I know
it doesn't make sense practlically for this chip to not use DMA given
the high sample rate, but why should the devicetree for this chip
require it when there is nothing intrensic about this chip itself
related to DMA?

> +       if (IS_ERR(st->back))
> +               return PTR_ERR(st->back);
>
> -       return 0;
> +       ret =3D iio_backend_enable(st->back);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ad9467_setup(st);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id ad9467_of_match[] =3D {
>
> --
> 2.42.1
>
>


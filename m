Return-Path: <linux-iio+bounces-887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510DD811349
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55371F217A5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4A2D632;
	Wed, 13 Dec 2023 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jEro79tA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0DD5
	for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 05:47:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so79988031fa.2
        for <linux-iio@vger.kernel.org>; Wed, 13 Dec 2023 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702475247; x=1703080047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFL6BGE30o5x5wyurnPSdPy6kQ7TCaOCLLGWZ54FCA0=;
        b=jEro79tAvB6nCmlWmyQSm4jCKUPZ+3Ifx9WNNMDFGxVRiJJlapwZTRlnIn43r/Ov/x
         Z4V56c62uBRl32det2AnaEUzdlpkv/v7yxjGLVUFLA2wVC5ONzA5YMnN2FWr/T9AQFLD
         ZVJLuN3weQ5N2S77+cbkRDC4HhbKLjHQqbv627DdCDVO2TmC9spf3O/n6VvyeMdgzLQt
         qZZXPWDnt7gav3vbhlDhdzLvB22VpsyFjV/cHaXUmMdjzmLnMPssWgoz0lyxpJ/S9WNA
         Awh/qCtv3V4OpobcXKUTfsQ28rrLL+2v4vtVfFB1XUP9h0qg3ROQAnlvro/x8sM2RGY1
         Vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475247; x=1703080047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFL6BGE30o5x5wyurnPSdPy6kQ7TCaOCLLGWZ54FCA0=;
        b=Eta4HyRmdMZRnzQD5/+8++GPLq7JaYh3UFP/6UBkv/boXVOLDChsFsb83MsEM0Sfv0
         sNMmsG98NJ5FUjrSBS5nQN92Iw5Dmm1wxXUH5eGNa+Vz0ehoaq8JpLA2yelGt4I3C9hS
         wk8K0bG8QIar9Qrv6DSZ1lkbIjJRfq9ee+aXfi+5/CJPE4wiOWKx7JsFrXgRrZRpyAZO
         RvrZVerF+E6BqcSroajYtMm9WTtNT12oiFJZ3uImbxfq2y1zp+rJB25UtliiyXFSTWWz
         YYgq9qyd+EAgq7f6vLp60bDYk8bE4mpnub3NQdXMzMuKCPVXr3mOMIWL0lyQBCDtQFFU
         XrEg==
X-Gm-Message-State: AOJu0YzoJaT4xKJPX6LYur+PE1jrYDSyy+mCP0DG1aAc4q8X/ZSDZB8r
	XPREPQLvF882nZV9sKD1D8/lHKkHzMl7zr7VhHLE0nnFFIlg0lb4ImVS4A==
X-Google-Smtp-Source: AGHT+IGUlZ7J445LIza6kgBg/FWi7wf6UqJSlXGc+2FgVm1SiS1QNpQhU/4idArCzM8Nw5M50iTgxdOMzbuMRqJSNu0=
X-Received: by 2002:a2e:a986:0:b0:2cb:2f69:26f9 with SMTP id
 x6-20020a2ea986000000b002cb2f6926f9mr3358968ljq.28.1702475247161; Wed, 13 Dec
 2023 05:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com> <5f7a1c60ccebe13ba6cdfa5d8f9632bc9b838137.camel@gmail.com>
In-Reply-To: <5f7a1c60ccebe13ba6cdfa5d8f9632bc9b838137.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 13 Dec 2023 14:47:16 +0100
Message-ID: <CAMknhBE6mPepiE=EYBj0ScU8SHXMhpO+D_kKBKFj6W+go_Jrxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:18=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2023-12-13 at 05:21 -0600, David Lechner wrote:
> > This adds a new driver for the AD7380 family ADCs.
> >
> > The driver currently implements basic support for the AD7380, AD7381,
> > AD7383, and AD7384 2-channel differential ADCs. Support for additional
> > single-ended and 4-channel chips that use the same register map as well
> > as additional features of the chip will be added in future patches.
> >
> > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v2 changes:
> > - Fixed CONFIG_AD7380 in Makefile
> > - rx_buf =3D st->scan_data.raw instead of rx_buf =3D &st->scan_data
> > - Moved iio_push_to_buffers_with_timestamp() outside of if statement
> > - Removed extra blank lines
> > - Renamed regulator disable function
> > - Dropped checking of adi,sdo-mode property (regardless of the actual
> >         wiring, we can always use 1-wire mode)
> > - Added available_scan_masks (we always sample two channels at the same=
 time
> >   so we need to let userspace know this)
> > - Added check for missing driver match data
> >
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  16 ++
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad7380.c | 464 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 482 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e2a998be5879..5a54620a31b8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -438,6 +438,7 @@ S:  Supported
> >  W:
> > https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/=
ad738x
> >  W:     https://ez.analog.com/linux-software-drivers
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > +F:     drivers/iio/adc/ad7380.c
> >
> >  AD7877 TOUCHSCREEN DRIVER
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 35f9867da12c..cbfd626712e3 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -122,6 +122,22 @@ config AD7298
> >           To compile this driver as a module, choose M here: the
> >           module will be called ad7298.
> >
> > +config AD7380
> > +       tristate "Analog Devices AD7380 ADC driver"
> > +       depends on SPI_MASTER
> > +       select IIO_BUFFER
> > +       select IIO_TRIGGER
> > +       select IIO_TRIGGERED_BUFFER
> > +       help
> > +         AD7380 is a family of simultaneous sampling ADCs that share t=
he same
> > +         SPI register map and have similar pinouts.
> > +
> > +         Say yes here to build support for Analog Devices AD7380 ADC a=
nd
> > +         similar chips.
> > +
> > +         To compile this driver as a module, choose M here: the module=
 will be
> > +         called ad7380.
> > +
> >  config AD7476
> >         tristate "Analog Devices AD7476 1-channel ADCs driver and other=
 similar
> > devices from AD and TI"
> >         depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index bee11d442af4..9c921c497655 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
> >  obj-$(CONFIG_AD7292) +=3D ad7292.o
> >  obj-$(CONFIG_AD7298) +=3D ad7298.o
> >  obj-$(CONFIG_AD7923) +=3D ad7923.o
> > +obj-$(CONFIG_AD7380) +=3D ad7380.o
> >  obj-$(CONFIG_AD7476) +=3D ad7476.o
> >  obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> >  obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > new file mode 100644
> > index 000000000000..b8025b636b67
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -0,0 +1,464 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD738x Simultaneous Sampling SAR ADCs
> > + *
> > + * Copyright 2017 Analog Devices Inc.
> > + * Copyright 2023 BayLibre, SAS
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/sysfs.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
>
> ...
>
> >
> > +static int ad7380_probe(struct spi_device *spi)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct ad7380_state *st;
> > +       int ret;
> > +
> > +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st =3D iio_priv(indio_dev);
> > +       st->spi =3D spi;
> > +       st->chip_info =3D spi_get_device_match_data(spi);
> > +       if (!st->chip_info)
> > +               return dev_err_probe(&spi->dev, -EINVAL, "missing match=
 data\n");
> > +
> > +       st->vref =3D devm_regulator_get_optional(&spi->dev, "refio");
> > +       if (IS_ERR(st->vref)) {
> > +               /*
> > +                * If there is no REFIO supply, then it means that we a=
re using
> > +                * the internal 2.5V reference.
> > +                */
> > +               if (PTR_ERR(st->vref) =3D=3D -ENODEV)
> > +                       st->vref =3D NULL;
> > +               else
> > +                       return dev_err_probe(&spi->dev, PTR_ERR(st->vre=
f),
> > +                                            "Failed to get refio regul=
ator\n");
> > +       }
> > +
> > +       if (st->vref) {
> > +               ret =3D regulator_enable(st->vref);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret =3D devm_add_action_or_reset(&spi->dev, ad7380_regu=
lator_disable,
> > +                                              st->vref);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       st->regmap =3D devm_regmap_init(&spi->dev, NULL, st, &ad7380_re=
gmap_config);
> > +       if (IS_ERR(st->regmap))
> > +               return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> > +                                    "failed to allocate register map\n=
");
>
> Still not using a regmap_bus... You could at least argue in the last vers=
ion why
> you're not doing it rather than ignoring the comment :).
>
> I'm asking for it because it already happened (in IIO) to me and I was as=
ked for
> implementing the bus. You also gain things like regmap core handling endi=
anism and
> formatting the work buffer for you (eg: regmap_bulk_read() could be more =
efficient),
>
> > +       indio_dev->channels =3D st->chip_info->channels;
> > +       indio_dev->num_channels =3D st->chip_info->num_channels;
> > +       indio_dev->dev.parent =3D &spi->dev;
>
> still not addressed...
>
> With at least the above (for the regmap_bus I'll leave the ultimate decis=
ion to
> Jonathan - not a deal breaker for me):
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
>
> - Nuno S=C3=A1
>

Sorry, I did not mean to ignore these. I just did a bad job of
double-checking that I addressed all comments before sending v2. :-(

If we need a v3, I will look into regmap_bus but at leas
superficially, I don't see much difference for this part, i.e not
really any case where bulk ops make sense and since it uses SPI bus
underneath, endianness isn't an issue.


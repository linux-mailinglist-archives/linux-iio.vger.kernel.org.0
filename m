Return-Path: <linux-iio+bounces-24131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818DB58FB7
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAEAD4E23FE
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B54A2820AC;
	Tue, 16 Sep 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID4R8V3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568928137A
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009500; cv=none; b=IopgandLmgBmSWD6XU04PuRFBZ49hdBY1sQq54pozP3E50s1aexynam7B8eb8sdFZuAvfdCptIz+fjz+DMpIp1bbbuJraMOhqWwoeLYKrIsIV2kEcZ7bE+ACci7KRNDWu5iZHp1NVgzkJ0a25hJnut9cpwp7UOcCC7ixmNaJaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009500; c=relaxed/simple;
	bh=DG0G0RV3AmR5fAsT4jCQ/z40LFy/AWJACOz2jnYDTbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQAYXGu7iLVx+9BlYtLNvmtcwibWrm2XDjgXlPemtOrbYWOwBJnczDIfVJnOsGPVj1pUyCxTqL9Na3AtnJyO+0OkAPxLwSIgkGFfAAprzkTHBe5pjwBPqCTYc7DpFqvOqgzi0m0oq5cU1gybeVoCPkfzwCCTWoFik39yuS5JDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID4R8V3p; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07e3a77b72so426767166b.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009497; x=1758614297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGkzswrycxBeHJVZMyHWQrwjX71uOJNEOBcuPlrAo5M=;
        b=ID4R8V3pAq4jOaHMHfMUktWcwZBoqXfYMgLmtuWyyLtQxw2P/zXRpLEWu8BH1r3o9F
         jNE4HvIsF6XyLyUhIrq5JP3VIWECAbjeHNuN1MGN5gTyPCu0n5XDNq/BzjRQ+11L6gI1
         J34ohmxEYqCglbpQ3ybDgRJ5ewiYMKGnEurr4pOkOQns/ILlujqzaWuAGaaCGEnL/0uI
         AoDQ+hJmw2Z36hnzHGZUOF0rOkANYBjujU686heBMM3Grawi/WK/pLzw9QAjTRZ2jooE
         XVjogY4vO8C7EP0XMNgUGsUiK2VtS50mcX2h41VzdEpg/bXFjxv+Wmxe8VWnJ+sKeFH1
         LVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009497; x=1758614297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGkzswrycxBeHJVZMyHWQrwjX71uOJNEOBcuPlrAo5M=;
        b=hitTqkfzV7yGn2u6S9rD7EHSjkb/YTbc0DPvKXslm2s8oo6ZmtrpQ+J+IUsVjgQdyF
         P9iAe/xXhWSa1wqeLFH14cnDE72UvU0lDsYeVZhYu+SdR7jQAFlsyglANF76IYLtHBBV
         kxbN1fmnS2K/iA+yXyAJS2jng/TU3HV0jcrjrVQzHdEE36PG/TpJh4+7BMUDLnALVGQn
         ORHBhMUUkm7YiB3DlViU3G9DDnB4huRkyAcz1Z8Vv2XZ2z8uj48nsWlBJRVWZ/0v8YW+
         HgMq51YGBq4v14F+nZAEb2tnGSO2uMJUDsboLJ6g3f6I5m/VqO9nzMfelP2k7zI7ZUkZ
         NBQA==
X-Gm-Message-State: AOJu0YyZeqhk23P61/TYyjWwQbqiLJC92sdRFoOtWqtTrSyEQmQvAQJS
	CXJNKAm/2obYfDYsO2QAhOQKPaIY4cptOQ59/BxtGzznE4GuoQ5SBggTo81GMMk/tEtMSmpK95e
	G77hbZw01+O0XGHSOeiTq90RRwrWqBBc=
X-Gm-Gg: ASbGncv4aUOtXBKGUAD+qm/y0ujzilXedo4A6lkKVJI75scHNvr4K8xgMctLxU7n0YL
	1YnDk7vLZsvq65b+u9r1GouAIZOXfVJkGQrYcZislUvDFi0GS6e5ci53Rzjtmtlewc2vmL8b2Gb
	a6ZKxZe9r1806+c3mPCyEdEeEZF1tinWYiIDQz6w+njfrFsXg1Cj+/iQBCn9iVehPOy064u1iW/
	Ox+We1bWDD1KCPpaA+MhLHxjA==
X-Google-Smtp-Source: AGHT+IFral83PqRO0oFA0nwAADsLdem/Y6OwUTho938r+mc+rTRLW/zzW4TNdo8+cb6TZ7QmrlG/7/Mr5jmEGgUT/oQ=
X-Received: by 2002:a17:907:74c:b0:b04:2697:9f60 with SMTP id
 a640c23a62f3a-b167fcd9200mr187650666b.13.1758009497066; Tue, 16 Sep 2025
 00:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757971454.git.marilene.agarcia@gmail.com> <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
In-Reply-To: <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 10:57:40 +0300
X-Gm-Features: AS18NWCljXfeEk1VNA27kohevOmouRYk8kIoC9zwMHwx8wKfR8g9z-Yuec4fG-Y
Message-ID: <CAHp75Vc84_b5OdVjC+Vup9R5v=d+30vho7kwihYff-L3KO3JqQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt <Marcelo.Schmitt@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:16=E2=80=AFAM Marilene Andrade Garcia
<marilene.agarcia@gmail.com> wrote:
>
> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-ran=
ge
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> more features, like a binary comparator, a filtered reading that can
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault featur=
e
> that can diagnose seven possible fault conditions. And an option to selec=
t
> an external or internal ADC voltage reference.
>
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - Filtered ADC average reading with the default configuration.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.

This version looks almost good to me, a few nit-picks below.

...

> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_MAX11100) +=3D max11100.o
>  obj-$(CONFIG_MAX1118) +=3D max1118.o
>  obj-$(CONFIG_MAX11205) +=3D max11205.o
>  obj-$(CONFIG_MAX11410) +=3D max11410.o
> +obj-$(CONFIG_MAX14001) +=3D max14001.o
>  obj-$(CONFIG_MAX1241) +=3D max1241.o
>  obj-$(CONFIG_MAX1363) +=3D max1363.o
>  obj-$(CONFIG_MAX34408) +=3D max34408.o

Please, keep it ordered.


...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/bits.h>

> +#include <linux/byteorder/generic.h>

This is wrong, should be asm/byteorder.h going after linux/* but
before linux/iio/* ones...

> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...here

asm/byteorder.h

> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

...

> +struct max14001_state {
> +       const struct max14001_chip_info *chip_info;
> +       struct spi_device *spi;
> +       struct regmap *regmap;
> +       int vref_mV;
> +       /*
> +        * lock protect against multiple concurrent accesses, RMW sequenc=
e,

Lock to protect...

> +        * and SPI transfer.
> +        */
> +       struct mutex lock;
> +       /*
> +        * The following buffers will be bit-reversed during device
> +        * communication, because the device transmits and receives data
> +        * LSB-first.
> +        * DMA (thus cache coherency maintenance) requires the transfer
> +        * buffers to live in their own cache lines.
> +        */
> +       __be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
> +       __be16 spi_rx_buffer;
> +};

...

> +static struct max14001_chip_info max14001_chip_info =3D {
> +       .name =3D "max14001",
> +};
> +
> +static struct max14001_chip_info max14002_chip_info =3D {
> +       .name =3D "max14002",
> +};

These can be moved closer to their first user (ID table?).

...

> +static int max14001_write(struct max14001_state *st, unsigned int reg, u=
nsigned int val)
> +{
> +       /*
> +        * Prepare SPI transmit buffer 16 bit-value big-endian format and
> +        * reverses bit order to align with the LSB-first input on SDI po=
rt

reverse

> +        * in order to meet the device communication requirements.
> +        */
> +       st->spi_tx_buffer =3D cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_MA=
SK_ADDR, reg) |
> +                                                FIELD_PREP(MAX14001_MASK=
_WR, 1) |
> +                                                FIELD_PREP(MAX14001_MASK=
_DATA, val)));
> +
> +       return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_b=
uffer));
> +}

...

> +static int max14001_probe(struct spi_device *spi)
> +{
> +       struct device *dev =3D &spi->dev;
> +       struct iio_dev *indio_dev;
> +       struct max14001_state *st;
> +       int ret, ext_vrefin =3D 0;

bool use_ext_vrefin =3D false;

> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +       st->chip_info =3D spi_get_device_match_data(spi);

> +       if (!st->chip_info)
> +               return dev_err_probe(dev, -ENODEV, "Failed to get match d=
ata\n");

Remove this check, it will be almost always a dead code. The developer
implementing a new device support won't be able to test the driver
anyway with properly given chip_info.

> +       indio_dev->name =3D st->chip_info->name;
> +       indio_dev->info =3D &max14001_info;
> +       indio_dev->channels =3D max14001_channel;
> +       indio_dev->num_channels =3D ARRAY_SIZE(max14001_channel);
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +       st->regmap =3D devm_regmap_init(dev, NULL, st, &max14001_regmap_c=
onfig);
> +       if (IS_ERR(st->regmap))
> +               return dev_err_probe(dev, PTR_ERR(st->regmap), "Failed to=
 initialize regmap\n");
> +
> +       ret =3D devm_mutex_init(dev, &st->lock);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_regulator_get_enable(dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable Vdd supp=
ly\n");
> +
> +       ret =3D devm_regulator_get_enable(dev, "vddl");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable Vddl sup=
ply\n");
> +
> +       ret =3D devm_regulator_get_enable_read_voltage(dev, "refin");
> +       if (ret < 0 && ret !=3D -ENODEV)
> +               return dev_err_probe(dev, ret, "Failed to get REFIN volta=
ge\n");
> +
> +       if (ret < 0)

if (ret =3D=3D -ENODEV) ?
It would be interesting out of curiosity to see bloat-o-meter output
for the original check and my proposal. I would choose one which gives
less code, but in case of equality, I would rather go with a more
explicit (my proposal) check.


> +               ret =3D 1250000;
> +       else
> +               ext_vrefin =3D 1;

use_ext_vrefin =3D true;

> +       st->vref_mV =3D ret / (MICRO / MILLI);
> +
> +       if (ext_vrefin) {

if (use_ext_vrefin) {

> +               /*
> +                * Configure the MAX14001/MAX14002 to use an external vol=
tage reference source
> +                * by setting the bit 5 of the configuration register

Missing period.

> +                */
> +               ret =3D regmap_update_bits(st->regmap, MAX14001_REG_CFG, =
MAX14001_REG_CFG_BIT_EXRF, MAX14001_REG_CFG_BIT_EXRF);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "Failed to set Ext=
ernal REFIN in Configuration Register\n");
> +       }
> +
> +       ret =3D max14001_disable_mv_fault(st);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to disable MV Faul=
t\n");
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}


--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E533E5A63
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhHJMuw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhHJMuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:50:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80DC0613D3;
        Tue, 10 Aug 2021 05:50:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so4156225pjn.4;
        Tue, 10 Aug 2021 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJJ/oLxgNHBZEDzCWs8ydO8BoNOUNRkg/djNHlTwyhc=;
        b=RqbzGJ2EljHTfkynsVwTFsWP+yfheO6qjj+QZRbcjoczrxOg9RjpyuhrAGPzGtxldK
         ISmCzYtzvg7kSnEBnrAElNCOYoyzDeiyo4B9B0QvBMMp2/9QB/PiKYDzKMdqtfDk2uzY
         thSb2TfQHmYRpFKn3KRf0e84AhVMg0Am8MMgtsVABnR2+tCBh5JIYgPVdUYSlbfx9y22
         e9e+r31LgDJ/qB3dPLkWsP/DsLnLEV2ByUuOsvW69n5Ml5ffVch6GMlh/7WdjXM6L46X
         4RzZt6+fC0KscmhuJiJ/rUgPOS3ImWVgByXyhUn/uOd4PGERKbV4xUUsAFuswSOOt7zi
         2hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJJ/oLxgNHBZEDzCWs8ydO8BoNOUNRkg/djNHlTwyhc=;
        b=W38T4TB/vlWZhfnFir5rCa0ESFxpy0zCHmNwmofnRxpCMCu7wM/etLHbDOT7T8IWYS
         xtbq3hRLM2612o2ml3lNF2FVy2LLP6fA/99+O7rEmpajY/HgoR9ZErZhhsDE6ejla4F2
         xk8pzJxykOUGF7MVkVnGxALLo+MP8kQPdBa8DDTCIZyMyIEo06Zk/dgDHDBJSd/S4BkV
         noMXqsKLkFChVtjQdrJncrnpKgCjUzSG0vtUvelVC6Rs/WFKe6ziXgVnA2m0JL+7Opes
         Pr5ue4IdtY8XpbUU5xP1yhy00ByNZRpUhGNH9Ybjc7H19yJaX1rVp5ONgYlEgMw/9b9H
         bejg==
X-Gm-Message-State: AOAM532eBGwuSGGzqY77MmKnIHTUhWrOXKSYoqUztJBwrl1gNZ0rAINJ
        aN89KLrVjdeRAsmd9U0ByvLvvNdPInjNsXwZSfc=
X-Google-Smtp-Source: ABdhPJyuuMMo1FhyD5wrm8N87cZTcufEtPEUN1sR8i/+DEeTcGemBSlQjNrFRXZ63zQTjAcPKKqvbyiSSuL7ffC3mqM=
X-Received: by 2002:a17:902:b713:b029:12b:b249:693f with SMTP id
 d19-20020a170902b713b029012bb249693fmr11178496pls.17.1628599828711; Tue, 10
 Aug 2021 05:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075745.160042-1-dmugil2000@gmail.com> <20210809075745.160042-3-dmugil2000@gmail.com>
In-Reply-To: <20210809075745.160042-3-dmugil2000@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:49:52 +0300
Message-ID: <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 9, 2021 at 10:59 AM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
>
> The AD5110/AD5112/AD5114 provide a nonvolatile solution
> for 128-/64-/32-position adjustment applications, offering
> guaranteed low resistor tolerance errors of =C2=B18% and up to
> =C2=B16 mA current density.

...

> +/*
> + * Analog Devices AD5110 digital potentiometer driver
> + *
> + * Copyright (C) 2021 Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/AD5110_5112_5114.pdf

> + *

Redundant blank line.

> + */

...

> +#define WIPER_RESISTANCE       70

Missed prefix?

...

> +static const struct iio_chan_spec ad5110_channels[] =3D {
> +       {
> +               .type =3D IIO_RESISTANCE,
> +               .output =3D 1,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_=
CHAN_INFO_OFFSET) |
> +                                       BIT(IIO_CHAN_INFO_SCALE) | BIT(II=
O_CHAN_INFO_ENABLE),
> +       }

+ comma.

> +};

...

> +       ret =3D i2c_master_send_dmasafe(data->client, data->buf, sizeof(d=
ata->buf));
> +       if (ret !=3D sizeof(data->buf)) {

> +               ret =3D -EIO;

Shadowed error code when ret < 0.

> +               goto error;
> +       }

...

> +       ret =3D i2c_master_send_dmasafe(data->client, data->buf, sizeof(d=
ata->buf));
> +       if (ret !=3D sizeof(data->buf))
> +               ret =3D -EIO;

Ditto.

> +       mutex_unlock(&data->lock);
> +
> +       return ret < 0 ? ret : 0;
> +}

...

> +       data->tol =3D data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> +       if (!(val & BIT(7)))
> +               data->tol *=3D -1;

Shouldn't you simple use corresponding sign_extend*()?

...

> +       ret =3D ad5110_write(data, AD5110_EEPROM_WR, 0);
> +       if (ret) {
> +               dev_err(&data->client->dev, "RDAC to EEPROM write failed\=
n");
> +               return ret;
> +       }


> +       msleep(20);

Each long sleeps like this must be explained.

...

> +static IIO_DEVICE_ATTR(store_eeprom, 0644,
> +                      ad5110_eeprom_read,
> +                      ad5110_eeprom_write, 0);

IIO_DEVICE_ATTR_RW() ?

...

> +static struct attribute *ad5110_attributes[] =3D {
> +       &iio_dev_attr_store_eeprom.dev_attr.attr,
> +       NULL,

No comma for a terminator line.

> +};

...

> +       data->cfg =3D device_get_match_data(dev);

> +       if (!data->cfg)
> +               data->cfg =3D &ad5110_cfg[i2c_match_id(ad5110_id, client)=
->driver_data];

Not sure this is not a dead code since you are using ->probe_new().

...

> +static struct i2c_driver ad5110_driver =3D {
> +       .driver =3D {
> +               .name   =3D "ad5110",
> +               .of_match_table =3D ad5110_of_match,
> +       },
> +       .probe_new      =3D ad5110_probe,
> +       .id_table       =3D ad5110_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(ad5110_driver);

--=20
With Best Regards,
Andy Shevchenko

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C913EC4C8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhHNTqH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNTqH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 15:46:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34AC061764;
        Sat, 14 Aug 2021 12:45:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so25975466pjr.1;
        Sat, 14 Aug 2021 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OadGIv82teYPe0CEeCTn/7jGhodznMIM9Ifjv7KBhrM=;
        b=GS7TheAwI9zWitWk5NwilDA/RFoctep8IdAxFkhuIu5eaHVDklHogQK5cxn0ViFYPF
         101nRHgFGS9j76ItqFyUeVtWcbypUXN/GxvFDQSxjDrTTwHafc5WK2X2CKQC8L98UrGt
         X89RKzbVGjtB+K0Y5wMwXxofbmi/+eiy6RwTsPHY7JBGODXwHen1bnOmRn50FPGQ6LWP
         zGCx+C7XY6VeBgSwEwmbEsqRRFn4KChggUJnlhvBmM1I1BHsO1IZzbBm6hShYvHWY42z
         bpAzvlCA0juxRduOUDXlmhh4aKw3khcYLKEkd9KQ34GNgXHVsgAv3Xfsyj0fS5AwztrL
         6qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OadGIv82teYPe0CEeCTn/7jGhodznMIM9Ifjv7KBhrM=;
        b=A0bYQ3j1KJzoNKjpWcfhUVstSsu9muU81b1mtEVA4l9ZLhYPOyFSKYrt/jTjVolVJ5
         y21WSiugbp+1Oif7twmEkibz7lDjNO33vpZyoPOAnBFq1tbTetI6w3tDY5XLz+VWDXKG
         IiXVnsd4WSORTxDgDdm40P71gO6dVia/2LtEDmoNTlHZMhPkgYVLMLKzHYp/UGVqJnek
         5L62n1YRdD69ee1VWfXAQtcZmP6NO4D/FQRr5ttdfckbee/hRnj9o/DZXKfSnmTpK/hJ
         a19Be568TC4U1eZVYdgNTRJMrc6A4g9KwjmJXrRJXVdujc7oAz8wYVgHAjlpVV4+uNVL
         ONCw==
X-Gm-Message-State: AOAM530sTnLZ89zV16z5G3tmhbRUnopEaMAIQlTWRcJdulC3IOrbhteh
        hSuaGY0sGE5oM7ENQel2M382hpctVAbhFbvp/C0=
X-Google-Smtp-Source: ABdhPJwcSss+iBLg1KogqOdf66gQ6iE3zI34PRLiEkGuL71OXiUPtp1agXDGLynsn14QXFYmpDdjl6h4n2KWHKP1Lg4=
X-Received: by 2002:a65:5ccd:: with SMTP id b13mr8011188pgt.203.1628970337854;
 Sat, 14 Aug 2021 12:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210814175607.48399-1-dmugil2000@gmail.com> <20210814175607.48399-3-dmugil2000@gmail.com>
In-Reply-To: <20210814175607.48399-3-dmugil2000@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 22:45:01 +0300
Message-ID: <CAHp75Ve+5sLv6cf88mOHnTpq5DeJ=37VDF9kacpZXVVk7KB8Qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: potentiometer: Add driver support for AD5110
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 14, 2021 at 8:57 PM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
>
> The AD5110/AD5112/AD5114 provide a nonvolatile solution
> for 128-/64-/32-position adjustment applications, offering
> guaranteed low resistor tolerance errors of =C2=B18% and up to
> =C2=B16 mA current density.

Looks good enough to me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD5110_5112_5114.pdf
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/iio/potentiometer/Kconfig  |  10 +
>  drivers/iio/potentiometer/Makefile |   1 +
>  drivers/iio/potentiometer/ad5110.c | 345 +++++++++++++++++++++++++++++
>  4 files changed, 362 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/ad5110.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..cf6e73b87b6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -452,6 +452,12 @@ S: Maintained
>  W:     https://parisc.wiki.kernel.org/index.php/AD1889
>  F:     sound/pci/ad1889.*
>
> +AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> +M:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Supported
> +F:     drivers/iio/potentiometer/ad5110.c
> +
>  AD525X ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
>  M:     Michael Hennerich <michael.hennerich@analog.com>
>  S:     Supported
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiomete=
r/Kconfig
> index 4cac0173db8b..832df8da2bc6 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -6,6 +6,16 @@
>
>  menu "Digital potentiometers"
>
> +config AD5110
> +       tristate "Analog Devices AD5110 and similar Digital Potentiometer=
 driver"
> +       depends on I2C
> +       help
> +         Say yes here to build support for the Analog Devices AD5110, AD=
5112
> +         and AD5114 digital potentiometer chip.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called ad5110.
> +
>  config AD5272
>         tristate "Analog Devices AD5272 and similar Digital Potentiometer=
 driver"
>         depends on I2C
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiomet=
er/Makefile
> index 091adf3cdd0b..5ebb8e3bbd76 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -4,6 +4,7 @@
>  #
>
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD5110) +=3D ad5110.o
>  obj-$(CONFIG_AD5272) +=3D ad5272.o
>  obj-$(CONFIG_DS1803) +=3D ds1803.o
>  obj-$(CONFIG_MAX5432) +=3D max5432.o
> diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiomet=
er/ad5110.c
> new file mode 100644
> index 000000000000..ae18f9e115b2
> --- /dev/null
> +++ b/drivers/iio/potentiometer/ad5110.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices AD5110 digital potentiometer driver
> + *
> + * Copyright (C) 2021 Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/da=
ta-sheets/AD5110_5112_5114.pdf
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* AD5110 commands */
> +#define AD5110_EEPROM_WR       1
> +#define AD5110_RDAC_WR         2
> +#define AD5110_SHUTDOWN        3
> +#define AD5110_RESET           4
> +#define AD5110_RDAC_RD         5
> +#define AD5110_EEPROM_RD       6
> +
> +/* AD5110_EEPROM_RD data */
> +#define AD5110_WIPER_POS       0
> +#define AD5110_RESISTOR_TOL    1
> +
> +#define AD5110_WIPER_RESISTANCE        70
> +
> +struct ad5110_cfg {
> +       int max_pos;
> +       int kohms;
> +       int shift;
> +};
> +
> +enum ad5110_type {
> +       AD5110_10,
> +       AD5110_80,
> +       AD5112_05,
> +       AD5112_10,
> +       AD5112_80,
> +       AD5114_10,
> +       AD5114_80,
> +};
> +
> +static const struct ad5110_cfg ad5110_cfg[] =3D {
> +       [AD5110_10] =3D { .max_pos =3D 128, .kohms =3D 10 },
> +       [AD5110_80] =3D { .max_pos =3D 128, .kohms =3D 80 },
> +       [AD5112_05] =3D { .max_pos =3D 64, .kohms =3D 5, .shift =3D 1 },
> +       [AD5112_10] =3D { .max_pos =3D 64, .kohms =3D 10, .shift =3D 1 },
> +       [AD5112_80] =3D { .max_pos =3D 64, .kohms =3D 80, .shift =3D 1 },
> +       [AD5114_10] =3D { .max_pos =3D 32, .kohms =3D 10, .shift =3D 2 },
> +       [AD5114_80] =3D { .max_pos =3D 32, .kohms =3D 80, .shift =3D 2 },
> +};
> +
> +struct ad5110_data {
> +       struct i2c_client       *client;
> +       s16                     tol;            /* resistor tolerance */
> +       bool                    enable;
> +       struct mutex            lock;
> +       const struct ad5110_cfg *cfg;
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       u8                      buf[2] ____cacheline_aligned;
> +};
> +
> +static const struct iio_chan_spec ad5110_channels[] =3D {
> +       {
> +               .type =3D IIO_RESISTANCE,
> +               .output =3D 1,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_=
CHAN_INFO_OFFSET) |
> +                                       BIT(IIO_CHAN_INFO_SCALE) | BIT(II=
O_CHAN_INFO_ENABLE),
> +       },
> +};
> +
> +static int ad5110_read(struct ad5110_data *data, u8 cmd, int *val)
> +{
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +       data->buf[0] =3D cmd;
> +       data->buf[1] =3D *val;
> +
> +       ret =3D i2c_master_send_dmasafe(data->client, data->buf, sizeof(d=
ata->buf));
> +       if (ret < 0) {
> +               goto error;
> +       } else if (ret !=3D sizeof(data->buf)) {
> +               ret =3D -EIO;
> +               goto error;
> +       }
> +
> +       ret =3D i2c_master_recv_dmasafe(data->client, data->buf, 1);
> +       if (ret < 0) {
> +               goto error;
> +       } else if (ret !=3D 1) {
> +               ret =3D -EIO;
> +               goto error;
> +       }
> +
> +       *val =3D data->buf[0];
> +       ret =3D 0;
> +
> +error:
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}
> +
> +static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
> +{
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +       data->buf[0] =3D cmd;
> +       data->buf[1] =3D val;
> +
> +       ret =3D i2c_master_send_dmasafe(data->client, data->buf, sizeof(d=
ata->buf));
> +       if (ret < 0) {
> +               goto error;
> +       } else if (ret !=3D sizeof(data->buf)) {
> +               ret =3D -EIO;
> +               goto error;
> +       }
> +
> +       ret =3D 0;
> +
> +error:
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}
> +
> +static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val=
)
> +{
> +       int ret;
> +
> +       ret =3D ad5110_read(data, cmd, &val);
> +       if (ret)
> +               return ret;
> +
> +       data->tol =3D data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> +       if (!(val & BIT(7)))
> +               data->tol *=3D -1;
> +
> +       return 0;
> +}
> +
> +static ssize_t store_eeprom_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5110_data *data =3D iio_priv(indio_dev);
> +       int val =3D AD5110_WIPER_POS;
> +       int ret;
> +
> +       ret =3D ad5110_read(data, AD5110_EEPROM_RD, &val);
> +       if (ret)
> +               return ret;
> +
> +       val =3D val >> data->cfg->shift;
> +       return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t store_eeprom_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t len)
> +{
> +       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct ad5110_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       ret =3D ad5110_write(data, AD5110_EEPROM_WR, 0);
> +       if (ret) {
> +               dev_err(&data->client->dev, "RDAC to EEPROM write failed\=
n");
> +               return ret;
> +       }
> +
> +       /* The storing of EEPROM data takes approximately 18 ms. */
> +       msleep(20);
> +
> +       return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(store_eeprom, 0);
> +
> +static struct attribute *ad5110_attributes[] =3D {
> +       &iio_dev_attr_store_eeprom.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ad5110_attribute_group =3D {
> +       .attrs =3D ad5110_attributes,
> +};
> +
> +static int ad5110_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan,
> +                          int *val, int *val2, long mask)
> +{
> +       struct ad5110_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D ad5110_read(data, AD5110_RDAC_RD, val);
> +               if (ret)
> +                       return ret;
> +
> +               *val =3D *val >> data->cfg->shift;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_OFFSET:
> +               *val =3D AD5110_WIPER_RESISTANCE * data->cfg->max_pos;
> +               *val2 =3D 1000 * data->cfg->kohms + data->tol;
> +               return IIO_VAL_FRACTIONAL;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D 1000 * data->cfg->kohms + data->tol;
> +               *val2 =3D data->cfg->max_pos;
> +               return IIO_VAL_FRACTIONAL;
> +       case IIO_CHAN_INFO_ENABLE:
> +               *val =3D data->enable;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int ad5110_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int val, int val2, long mask)
> +{
> +       struct ad5110_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (val > data->cfg->max_pos || val < 0)
> +                       return -EINVAL;
> +
> +               return ad5110_write(data, AD5110_RDAC_WR, val << data->cf=
g->shift);
> +       case IIO_CHAN_INFO_ENABLE:
> +               if (val < 0 || val > 1)
> +                       return -EINVAL;
> +               if (data->enable =3D=3D val)
> +                       return 0;
> +               ret =3D ad5110_write(data, AD5110_SHUTDOWN, val ? 0 : 1);
> +               if (ret)
> +                       return ret;
> +               data->enable =3D val;
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info ad5110_info =3D {
> +       .read_raw =3D ad5110_read_raw,
> +       .write_raw =3D ad5110_write_raw,
> +       .attrs =3D &ad5110_attribute_group,
> +};
> +
> +#define AD5110_COMPATIBLE(of_compatible, cfg) {        \
> +                       .compatible =3D of_compatible,    \
> +                       .data =3D &ad5110_cfg[cfg],       \
> +}
> +
> +static const struct of_device_id ad5110_of_match[] =3D {
> +       AD5110_COMPATIBLE("adi,ad5110-10", AD5110_10),
> +       AD5110_COMPATIBLE("adi,ad5110-80", AD5110_80),
> +       AD5110_COMPATIBLE("adi,ad5112-05", AD5112_05),
> +       AD5110_COMPATIBLE("adi,ad5112-10", AD5112_10),
> +       AD5110_COMPATIBLE("adi,ad5112-80", AD5112_80),
> +       AD5110_COMPATIBLE("adi,ad5114-10", AD5114_10),
> +       AD5110_COMPATIBLE("adi,ad5114-80", AD5114_80),
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ad5110_of_match);
> +
> +static const struct i2c_device_id ad5110_id[] =3D {
> +       { "ad5110-10", AD5110_10 },
> +       { "ad5110-80", AD5110_80 },
> +       { "ad5112-05", AD5112_05 },
> +       { "ad5112-10", AD5112_10 },
> +       { "ad5112-80", AD5112_80 },
> +       { "ad5114-10", AD5114_10 },
> +       { "ad5114-80", AD5114_80 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ad5110_id);
> +
> +static int ad5110_probe(struct i2c_client *client)
> +{
> +       struct device *dev =3D &client->dev;
> +       struct iio_dev *indio_dev;
> +       struct ad5110_data *data;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data =3D iio_priv(indio_dev);
> +       data->client =3D client;
> +       mutex_init(&data->lock);
> +       data->enable =3D 1;
> +       data->cfg =3D device_get_match_data(dev);
> +
> +       /* refresh RDAC register with EEPROM */
> +       ret =3D ad5110_write(data, AD5110_RESET, 0);
> +       if (ret) {
> +               dev_err(dev, "Refresh RDAC with EEPROM failed\n");
> +               return ret;
> +       }
> +
> +       ret =3D ad5110_resistor_tol(data, AD5110_EEPROM_RD, AD5110_RESIST=
OR_TOL);
> +       if (ret) {
> +               dev_err(dev, "Read resistor tolerance failed\n");
> +               return ret;
> +       }
> +
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->info =3D &ad5110_info;
> +       indio_dev->channels =3D ad5110_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(ad5110_channels);
> +       indio_dev->name =3D client->name;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct i2c_driver ad5110_driver =3D {
> +       .driver =3D {
> +               .name   =3D "ad5110",
> +               .of_match_table =3D ad5110_of_match,
> +       },
> +       .probe_new      =3D ad5110_probe,
> +       .id_table       =3D ad5110_id,
> +};
> +module_i2c_driver(ad5110_driver);
> +
> +MODULE_AUTHOR("Mugilraj Dhavachelvan <dmugil2000@gmail.com>");
> +MODULE_DESCRIPTION("AD5110 digital potentiometer");
> +MODULE_LICENSE("GPL v2");
> +
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko

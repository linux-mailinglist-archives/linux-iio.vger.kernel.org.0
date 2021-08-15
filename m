Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487E13EC994
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhHOOgz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 15 Aug 2021 10:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhHOOgy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 10:36:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2E960295;
        Sun, 15 Aug 2021 14:36:20 +0000 (UTC)
Date:   Sun, 15 Aug 2021 15:39:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v3 2/2] iio: potentiometer: Add driver support for
 AD5110
Message-ID: <20210815153918.3e2c7374@jic23-huawei>
In-Reply-To: <CAHp75Ve+5sLv6cf88mOHnTpq5DeJ=37VDF9kacpZXVVk7KB8Qg@mail.gmail.com>
References: <20210814175607.48399-1-dmugil2000@gmail.com>
        <20210814175607.48399-3-dmugil2000@gmail.com>
        <CAHp75Ve+5sLv6cf88mOHnTpq5DeJ=37VDF9kacpZXVVk7KB8Qg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Aug 2021 22:45:01 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 14, 2021 at 8:57 PM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
> >
> > The AD5110/AD5112/AD5114 provide a nonvolatile solution
> > for 128-/64-/32-position adjustment applications, offering
> > guaranteed low resistor tolerance errors of ±8% and up to
> > ±6 mA current density.  
> 
> Looks good enough to me, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied to the togreg branch of iio.git with a tiny tweak to drop one of the
pair of blank lines at the end of ad5110.c
Pushed out as testing to let 0-day poke at it before I expose it to
linux-next.

Thanks,

Jonathan

> 
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
> > Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > ---
> >  MAINTAINERS                        |   6 +
> >  drivers/iio/potentiometer/Kconfig  |  10 +
> >  drivers/iio/potentiometer/Makefile |   1 +
> >  drivers/iio/potentiometer/ad5110.c | 345 +++++++++++++++++++++++++++++
> >  4 files changed, 362 insertions(+)
> >  create mode 100644 drivers/iio/potentiometer/ad5110.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bd7aff0c120f..cf6e73b87b6e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -452,6 +452,12 @@ S: Maintained
> >  W:     https://parisc.wiki.kernel.org/index.php/AD1889
> >  F:     sound/pci/ad1889.*
> >
> > +AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> > +M:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > +L:     linux-iio@vger.kernel.org
> > +S:     Supported
> > +F:     drivers/iio/potentiometer/ad5110.c
> > +
> >  AD525X ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> >  M:     Michael Hennerich <michael.hennerich@analog.com>
> >  S:     Supported
> > diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> > index 4cac0173db8b..832df8da2bc6 100644
> > --- a/drivers/iio/potentiometer/Kconfig
> > +++ b/drivers/iio/potentiometer/Kconfig
> > @@ -6,6 +6,16 @@
> >
> >  menu "Digital potentiometers"
> >
> > +config AD5110
> > +       tristate "Analog Devices AD5110 and similar Digital Potentiometer driver"
> > +       depends on I2C
> > +       help
> > +         Say yes here to build support for the Analog Devices AD5110, AD5112
> > +         and AD5114 digital potentiometer chip.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called ad5110.
> > +
> >  config AD5272
> >         tristate "Analog Devices AD5272 and similar Digital Potentiometer driver"
> >         depends on I2C
> > diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> > index 091adf3cdd0b..5ebb8e3bbd76 100644
> > --- a/drivers/iio/potentiometer/Makefile
> > +++ b/drivers/iio/potentiometer/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  # When adding new entries keep the list in alphabetical order
> > +obj-$(CONFIG_AD5110) += ad5110.o
> >  obj-$(CONFIG_AD5272) += ad5272.o
> >  obj-$(CONFIG_DS1803) += ds1803.o
> >  obj-$(CONFIG_MAX5432) += max5432.o
> > diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
> > new file mode 100644
> > index 000000000000..ae18f9e115b2
> > --- /dev/null
> > +++ b/drivers/iio/potentiometer/ad5110.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Analog Devices AD5110 digital potentiometer driver
> > + *
> > + * Copyright (C) 2021 Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > + *
> > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +/* AD5110 commands */
> > +#define AD5110_EEPROM_WR       1
> > +#define AD5110_RDAC_WR         2
> > +#define AD5110_SHUTDOWN        3
> > +#define AD5110_RESET           4
> > +#define AD5110_RDAC_RD         5
> > +#define AD5110_EEPROM_RD       6
> > +
> > +/* AD5110_EEPROM_RD data */
> > +#define AD5110_WIPER_POS       0
> > +#define AD5110_RESISTOR_TOL    1
> > +
> > +#define AD5110_WIPER_RESISTANCE        70
> > +
> > +struct ad5110_cfg {
> > +       int max_pos;
> > +       int kohms;
> > +       int shift;
> > +};
> > +
> > +enum ad5110_type {
> > +       AD5110_10,
> > +       AD5110_80,
> > +       AD5112_05,
> > +       AD5112_10,
> > +       AD5112_80,
> > +       AD5114_10,
> > +       AD5114_80,
> > +};
> > +
> > +static const struct ad5110_cfg ad5110_cfg[] = {
> > +       [AD5110_10] = { .max_pos = 128, .kohms = 10 },
> > +       [AD5110_80] = { .max_pos = 128, .kohms = 80 },
> > +       [AD5112_05] = { .max_pos = 64, .kohms = 5, .shift = 1 },
> > +       [AD5112_10] = { .max_pos = 64, .kohms = 10, .shift = 1 },
> > +       [AD5112_80] = { .max_pos = 64, .kohms = 80, .shift = 1 },
> > +       [AD5114_10] = { .max_pos = 32, .kohms = 10, .shift = 2 },
> > +       [AD5114_80] = { .max_pos = 32, .kohms = 80, .shift = 2 },
> > +};
> > +
> > +struct ad5110_data {
> > +       struct i2c_client       *client;
> > +       s16                     tol;            /* resistor tolerance */
> > +       bool                    enable;
> > +       struct mutex            lock;
> > +       const struct ad5110_cfg *cfg;
> > +       /*
> > +        * DMA (thus cache coherency maintenance) requires the
> > +        * transfer buffers to live in their own cache lines.
> > +        */
> > +       u8                      buf[2] ____cacheline_aligned;
> > +};
> > +
> > +static const struct iio_chan_spec ad5110_channels[] = {
> > +       {
> > +               .type = IIO_RESISTANCE,
> > +               .output = 1,
> > +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET) |
> > +                                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_ENABLE),
> > +       },
> > +};
> > +
> > +static int ad5110_read(struct ad5110_data *data, u8 cmd, int *val)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&data->lock);
> > +       data->buf[0] = cmd;
> > +       data->buf[1] = *val;
> > +
> > +       ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
> > +       if (ret < 0) {
> > +               goto error;
> > +       } else if (ret != sizeof(data->buf)) {
> > +               ret = -EIO;
> > +               goto error;
> > +       }
> > +
> > +       ret = i2c_master_recv_dmasafe(data->client, data->buf, 1);
> > +       if (ret < 0) {
> > +               goto error;
> > +       } else if (ret != 1) {
> > +               ret = -EIO;
> > +               goto error;
> > +       }
> > +
> > +       *val = data->buf[0];
> > +       ret = 0;
> > +
> > +error:
> > +       mutex_unlock(&data->lock);
> > +       return ret;
> > +}
> > +
> > +static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&data->lock);
> > +       data->buf[0] = cmd;
> > +       data->buf[1] = val;
> > +
> > +       ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
> > +       if (ret < 0) {
> > +               goto error;
> > +       } else if (ret != sizeof(data->buf)) {
> > +               ret = -EIO;
> > +               goto error;
> > +       }
> > +
> > +       ret = 0;
> > +
> > +error:
> > +       mutex_unlock(&data->lock);
> > +       return ret;
> > +}
> > +
> > +static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val)
> > +{
> > +       int ret;
> > +
> > +       ret = ad5110_read(data, cmd, &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
> > +       if (!(val & BIT(7)))
> > +               data->tol *= -1;
> > +
> > +       return 0;
> > +}
> > +
> > +static ssize_t store_eeprom_show(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 char *buf)
> > +{
> > +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +       struct ad5110_data *data = iio_priv(indio_dev);
> > +       int val = AD5110_WIPER_POS;
> > +       int ret;
> > +
> > +       ret = ad5110_read(data, AD5110_EEPROM_RD, &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       val = val >> data->cfg->shift;
> > +       return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > +}
> > +
> > +static ssize_t store_eeprom_store(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  const char *buf, size_t len)
> > +{
> > +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +       struct ad5110_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
> > +       if (ret) {
> > +               dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
> > +               return ret;
> > +       }
> > +
> > +       /* The storing of EEPROM data takes approximately 18 ms. */
> > +       msleep(20);
> > +
> > +       return len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RW(store_eeprom, 0);
> > +
> > +static struct attribute *ad5110_attributes[] = {
> > +       &iio_dev_attr_store_eeprom.dev_attr.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group ad5110_attribute_group = {
> > +       .attrs = ad5110_attributes,
> > +};
> > +
> > +static int ad5110_read_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +       struct ad5110_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               ret = ad5110_read(data, AD5110_RDAC_RD, val);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               *val = *val >> data->cfg->shift;
> > +               return IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_OFFSET:
> > +               *val = AD5110_WIPER_RESISTANCE * data->cfg->max_pos;
> > +               *val2 = 1000 * data->cfg->kohms + data->tol;
> > +               return IIO_VAL_FRACTIONAL;
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = 1000 * data->cfg->kohms + data->tol;
> > +               *val2 = data->cfg->max_pos;
> > +               return IIO_VAL_FRACTIONAL;
> > +       case IIO_CHAN_INFO_ENABLE:
> > +               *val = data->enable;
> > +               return IIO_VAL_INT;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int ad5110_write_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int val, int val2, long mask)
> > +{
> > +       struct ad5110_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               if (val > data->cfg->max_pos || val < 0)
> > +                       return -EINVAL;
> > +
> > +               return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
> > +       case IIO_CHAN_INFO_ENABLE:
> > +               if (val < 0 || val > 1)
> > +                       return -EINVAL;
> > +               if (data->enable == val)
> > +                       return 0;
> > +               ret = ad5110_write(data, AD5110_SHUTDOWN, val ? 0 : 1);
> > +               if (ret)
> > +                       return ret;
> > +               data->enable = val;
> > +               return 0;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info ad5110_info = {
> > +       .read_raw = ad5110_read_raw,
> > +       .write_raw = ad5110_write_raw,
> > +       .attrs = &ad5110_attribute_group,
> > +};
> > +
> > +#define AD5110_COMPATIBLE(of_compatible, cfg) {        \
> > +                       .compatible = of_compatible,    \
> > +                       .data = &ad5110_cfg[cfg],       \
> > +}
> > +
> > +static const struct of_device_id ad5110_of_match[] = {
> > +       AD5110_COMPATIBLE("adi,ad5110-10", AD5110_10),
> > +       AD5110_COMPATIBLE("adi,ad5110-80", AD5110_80),
> > +       AD5110_COMPATIBLE("adi,ad5112-05", AD5112_05),
> > +       AD5110_COMPATIBLE("adi,ad5112-10", AD5112_10),
> > +       AD5110_COMPATIBLE("adi,ad5112-80", AD5112_80),
> > +       AD5110_COMPATIBLE("adi,ad5114-10", AD5114_10),
> > +       AD5110_COMPATIBLE("adi,ad5114-80", AD5114_80),
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad5110_of_match);
> > +
> > +static const struct i2c_device_id ad5110_id[] = {
> > +       { "ad5110-10", AD5110_10 },
> > +       { "ad5110-80", AD5110_80 },
> > +       { "ad5112-05", AD5112_05 },
> > +       { "ad5112-10", AD5112_10 },
> > +       { "ad5112-80", AD5112_80 },
> > +       { "ad5114-10", AD5114_10 },
> > +       { "ad5114-80", AD5114_80 },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ad5110_id);
> > +
> > +static int ad5110_probe(struct i2c_client *client)
> > +{
> > +       struct device *dev = &client->dev;
> > +       struct iio_dev *indio_dev;
> > +       struct ad5110_data *data;
> > +       int ret;
> > +
> > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       data = iio_priv(indio_dev);
> > +       data->client = client;
> > +       mutex_init(&data->lock);
> > +       data->enable = 1;
> > +       data->cfg = device_get_match_data(dev);
> > +
> > +       /* refresh RDAC register with EEPROM */
> > +       ret = ad5110_write(data, AD5110_RESET, 0);
> > +       if (ret) {
> > +               dev_err(dev, "Refresh RDAC with EEPROM failed\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = ad5110_resistor_tol(data, AD5110_EEPROM_RD, AD5110_RESISTOR_TOL);
> > +       if (ret) {
> > +               dev_err(dev, "Read resistor tolerance failed\n");
> > +               return ret;
> > +       }
> > +
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +       indio_dev->info = &ad5110_info;
> > +       indio_dev->channels = ad5110_channels;
> > +       indio_dev->num_channels = ARRAY_SIZE(ad5110_channels);
> > +       indio_dev->name = client->name;
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static struct i2c_driver ad5110_driver = {
> > +       .driver = {
> > +               .name   = "ad5110",
> > +               .of_match_table = ad5110_of_match,
> > +       },
> > +       .probe_new      = ad5110_probe,
> > +       .id_table       = ad5110_id,
> > +};
> > +module_i2c_driver(ad5110_driver);
> > +
> > +MODULE_AUTHOR("Mugilraj Dhavachelvan <dmugil2000@gmail.com>");
> > +MODULE_DESCRIPTION("AD5110 digital potentiometer");
> > +MODULE_LICENSE("GPL v2");
> > +
> > --
> > 2.25.1
> >  
> 
> 


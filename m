Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447E3FAC20
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhH2OKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhH2OKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:10:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFE260F25;
        Sun, 29 Aug 2021 14:09:17 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:12:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver support for ADXL313
Message-ID: <20210829151232.29cb1ee1@jic23-huawei>
In-Reply-To: <CACKVXZDpBXK-RRQy4OJ=i+mCFxP=LVBZe0GjAkg_GXZ8hCiSng@mail.gmail.com>
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
        <69f3b83eaf31d657cdb522839dc0102384d50681.1628713039.git.lucas.p.stankus@gmail.com>
        <CAHp75VeTWmegWR6viGOV=QYxTFnPcntG6pdKn=rVyvniHGTAog@mail.gmail.com>
        <CACKVXZDpBXK-RRQy4OJ=i+mCFxP=LVBZe0GjAkg_GXZ8hCiSng@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 17:01:43 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> On Thu, Aug 12, 2021 at 8:06 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Aug 12, 2021 at 12:19 AM Lucas Stankus
> > <lucas.p.stankus@gmail.com> wrote:  
> > >
> > > ADXL313 is a small, thin, low power, 3-axis accelerometer with high
> > > resolution measurement up to +/-4g. It includes an integrated 32-level
> > > FIFO and has activity and inactivity sensing capabilities.  
> >
> > Thanks for an update, my comments below.
> > After addressing them, feel free to add
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >  
> 
> Sorry for the late reply. I've addressed most of your comments for the
> v4, but the two I've commented below.
>

> >
> > Provide a kernel doc for the probe()
> >  
> 
> Is there some driver that did something similar that I can take
> inspiration from? I'm not sure where I should add this doc and how I
> should format it, so a north would be appreciated :)

https://elixir.bootlin.com/linux/latest/source/Documentation/doc-guide/kernel-doc.rst

In theory all exported functions should have kernel-doc, but in practice
we sometimes skip it for a function only intended to have one or two users.
However, in this case the "setup" parameter is sufficiently unusual that
it would be good to have detailed documents.  Make sure to run a test build
of the docs to pick up on any formatting issues.  That help file explains how
to do it.

> 
> > > +int adxl313_core_probe(struct device *dev,
> > > +                      struct regmap *regmap,
> > > +                      const char *name,
> > > +                      int (*interface_specific_setup)(struct device *,
> > > +                                                      struct regmap *))  
> >
> > Ditto for the "setup" name.
> >  
> > > +{
> > > +       struct adxl313_data *data;
> > > +       struct iio_dev *indio_dev;
> > > +       int ret;
> > > +
> > > +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > +       if (!indio_dev)
> > > +               return -ENOMEM;
> > > +
> > > +       data = iio_priv(indio_dev);
> > > +       data->regmap = regmap;
> > > +       mutex_init(&data->lock);
> > > +
> > > +       indio_dev->name = name;
> > > +       indio_dev->info = &adxl313_info;
> > > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > > +       indio_dev->channels = adxl313_channels;
> > > +       indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
> > > +
> > > +       ret = adxl313_setup(dev, data, interface_specific_setup);
> > > +       if (ret) {
> > > +               dev_err(dev, "ADXL313 setup failed\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       return devm_iio_device_register(dev, indio_dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(adxl313_core_probe);
> > > +
> > > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> > > new file mode 100644
> > > index 000000000000..517c6f1c43ad
> > > --- /dev/null
> > > +++ b/drivers/iio/accel/adxl313_i2c.c
> > > @@ -0,0 +1,65 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * ADXL313 3-Axis Digital Accelerometer
> > > + *
> > > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > > + *
> > > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > > + */
> > > +
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include "adxl313.h"
> > > +
> > > +static const struct regmap_config adxl313_i2c_regmap_config = {
> > > +       .reg_bits       = 8,
> > > +       .val_bits       = 8,
> > > +       .rd_table       = &adxl313_readable_regs_table,
> > > +       .wr_table       = &adxl313_writable_regs_table,
> > > +       .max_register   = 0x39,
> > > +};
> > > +
> > > +static int adxl313_i2c_probe(struct i2c_client *client)
> > > +{
> > > +       struct regmap *regmap;
> > > +
> > > +       regmap = devm_regmap_init_i2c(client, &adxl313_i2c_regmap_config);
> > > +       if (IS_ERR(regmap)) {
> > > +               dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> > > +                       PTR_ERR(regmap));
> > > +               return PTR_ERR(regmap);
> > > +       }
> > > +
> > > +       return adxl313_core_probe(&client->dev, regmap, client->name, NULL);
> > > +}
> > > +
> > > +static const struct i2c_device_id adxl313_i2c_id[] = {
> > > +       { "adxl313" },
> > > +       { }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
> > > +
> > > +static const struct of_device_id adxl313_of_match[] = {
> > > +       { .compatible = "adi,adxl313" },
> > > +       { }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, adxl313_of_match);
> > > +
> > > +static struct i2c_driver adxl313_i2c_driver = {
> > > +       .driver = {
> > > +               .name   = "adxl313_i2c",
> > > +               .of_match_table = adxl313_of_match,
> > > +       },
> > > +       .probe_new      = adxl313_i2c_probe,
> > > +       .id_table       = adxl313_i2c_id  
> >
> > + Comma
> >  
> > > +};
> > > +
> > > +module_i2c_driver(adxl313_i2c_driver);
> > > +
> > > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer I2C driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> > > new file mode 100644
> > > index 000000000000..4d625b1753a5
> > > --- /dev/null
> > > +++ b/drivers/iio/accel/adxl313_spi.c
> > > @@ -0,0 +1,91 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * ADXL313 3-Axis Digital Accelerometer
> > > + *
> > > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > > + *
> > > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#include "adxl313.h"
> > > +
> > > +static const struct regmap_config adxl313_spi_regmap_config = {
> > > +       .reg_bits       = 8,
> > > +       .val_bits       = 8,
> > > +       .rd_table       = &adxl313_readable_regs_table,
> > > +       .wr_table       = &adxl313_writable_regs_table,
> > > +       .max_register   = 0x39,
> > > +        /* Setting bits 7 and 6 enables multiple-byte read */
> > > +       .read_flag_mask = BIT(7) | BIT(6),
> > > +};
> > > +
> > > +static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
> > > +{
> > > +       struct spi_device *spi = container_of(dev, struct spi_device, dev);
> > > +       int ret;
> > > +
> > > +       if (spi->mode & SPI_3WIRE) {
> > > +               ret = regmap_write(regmap, ADXL313_REG_DATA_FORMAT,
> > > +                                  ADXL313_SPI_3WIRE);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       return regmap_update_bits(regmap, ADXL313_REG_POWER_CTL,
> > > +                                 ADXL313_I2C_DISABLE, ADXL313_I2C_DISABLE);
> > > +}
> > > +
> > > +static int adxl313_spi_probe(struct spi_device *spi)
> > > +{
> > > +       const struct spi_device_id *id = spi_get_device_id(spi);
> > > +       struct regmap *regmap;
> > > +       int ret;
> > > +
> > > +       spi->mode |= SPI_MODE_3;
> > > +       ret = spi_setup(spi);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> > > +       if (IS_ERR(regmap)) {
> > > +               dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> > > +                       PTR_ERR(regmap));
> > > +               return PTR_ERR(regmap);
> > > +       }
> > > +
> > > +       return adxl313_core_probe(&spi->dev, regmap, id->name,
> > > +                                 &adxl313_spi_setup);
> > > +}
> > > +
> > > +static const struct spi_device_id adxl313_spi_id[] = {
> > > +       { "adxl313" },
> > > +       { }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
> > > +
> > > +static const struct of_device_id adxl313_of_match[] = {
> > > +       { .compatible = "adi,adxl313" },
> > > +       { }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, adxl313_of_match);
> > > +
> > > +static struct spi_driver adxl313_spi_driver = {
> > > +       .driver = {
> > > +               .name   = "adxl313_spi",
> > > +               .of_match_table = adxl313_of_match,
> > > +       },
> > > +       .probe          = adxl313_spi_probe,
> > > +       .id_table       = adxl313_spi_id  
> >
> > + Comma
> >  
> > > +};
> > > +
> > > +module_spi_driver(adxl313_spi_driver);
> > > +
> > > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.32.0
> > >  
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D763DF3CC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 19:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhHCRTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 13:19:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3573 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhHCRTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 13:19:02 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfM652nYgz6DJsk;
        Wed,  4 Aug 2021 01:18:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 3 Aug 2021 19:18:47 +0200
Received: from localhost (10.210.169.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 18:18:46 +0100
Date:   Tue, 3 Aug 2021 18:18:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        <robh+dt@kernel.org>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: Add driver support for ADXL313
Message-ID: <20210803181818.00001743@Huawei.com>
In-Reply-To: <CACKVXZD9nnAYb1bHNp32dzoGE3xnBPd6NR=9PNXkPVBSaPpaKw@mail.gmail.com>
References: <cover.1627709571.git.lucas.p.stankus@gmail.com>
        <8f13da2603ebede1c8c2d89f4ec2d9900a331250.1627709571.git.lucas.p.stankus@gmail.com>
        <20210801191210.19044c90@jic23-huawei>
        <CACKVXZD9nnAYb1bHNp32dzoGE3xnBPd6NR=9PNXkPVBSaPpaKw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.87]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 14:15:53 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> On Sun, Aug 1, 2021 at 3:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 31 Jul 2021 17:36:48 -0300
> > Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
> >  
> > > ADXL313 is a small, thin, low power, 3-axis accelerometer with high
> > > resolution measurement up to +/-4g. It includes an integrated 32-level
> > > FIFO and has activity and inactivity sensing capabilities.
> > >
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > >
> > > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>  
> >
> > Very nice.  A few really minor things inline.
> >
> > Jonathan
> >  
> 
> Thanks for the feedback!
> 
> I'll change the minor things for the v2.
> 

...

> > > +
> > > +static int adxl313_setup(struct device *dev, struct adxl313_data *data)
> > > +{
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     /* Ensures the device is in a consistent state after start up */
> > > +     ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > > +                        ADXL313_SOFT_RESET);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (device_property_read_bool(dev, "spi-3wire")) {  
> >
> > Rather odd to see spi specific stuff in here.  Perhaps provide a callback to
> > common probe if it needs to be done at this point in bringing the device up.
> > However, I think you can just do this before calling the common_probe()
> >  
> 
> I'm doing this here because of the device reset, so whatever I write
> to the register before it would be overwritten in setup. The datasheet
> doesn't say that resetting the device is strictly necessary, but I
> figured it would be better to do so to force consistency.
> 
> If I drop the reset, I'd be able to do it before the core probe call
> and, from what I'm seeing here, the startup seems to be consistent
> without it. Do you think it's best to drop the device reset?
Ah. I'd missed that.  Fair enough.

In this case, I'd pass in a function pointer from the spi module. If the
function pointer is provided, call it to spi specific setup, if NULL
don't call it (so we don't need to provide an empty stub in the i2c side of things).

> 
> > > +             ret = regmap_write(data->regmap, ADXL313_REG_DATA_FORMAT,
> > > +                                ADXL313_SPI_3WIRE);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (regval != ADXL313_DEVID0) {
> > > +             dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> > > +     if (ret)
> > > +             return ret;
> > > +

...

> > > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> > > new file mode 100644
> > > index 000000000000..7c58c9ff8985
> > > --- /dev/null
> > > +++ b/drivers/iio/accel/adxl313_spi.c
> > > @@ -0,0 +1,74 @@
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
> > > +     .reg_bits       = 8,
> > > +     .val_bits       = 8,
> > > +     .rd_table       = &adxl313_readable_regs_table,
> > > +     .wr_table       = &adxl313_writable_regs_table,
> > > +     .max_register   = 0x39,
> > > +      /* Setting bits 7 and 6 enables multiple-byte read */
> > > +     .read_flag_mask = BIT(7) | BIT(6)
> > > +};
> > > +
> > > +static int adxl313_spi_probe(struct spi_device *spi)
> > > +{
> > > +     const struct spi_device_id *id = spi_get_device_id(spi);
> > > +     struct regmap *regmap;
> > > +     int ret;
> > > +
> > > +     regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> > > +                     PTR_ERR(regmap));
> > > +             return PTR_ERR(regmap);
> > > +     }
> > > +
> > > +     ret = adxl313_core_probe(&spi->dev, regmap, id->name);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     return regmap_update_bits(regmap, ADXL313_REG_POWER_CTL,
> > > +                               ADXL313_I2C_DISABLE, ADXL313_I2C_DISABLE);  
> >
> > Why is this only done after the rest of probe?  Needs a comment perhaps.
> > Normally I'd expect the core probe and hence exposure of the device
> > to userspace etc to be the last thing done.
> >  
> 
> I'm doing this here for the same reason as for the spi-3wire setup. So
> if I drop the reset in the probe, the bits could be updated before it.

Put that in the function that you pass as a pointer to core_probe() - then you
can do them both at the same time and at an appropriate point.


Jonathan

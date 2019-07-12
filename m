Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6591D6737C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGLQn2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 12:43:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51432 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfGLQn2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 12:43:28 -0400
Received: from pc-381.home (2a01cb0c80061e00e835b5cf688fec09.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:8006:1e00:e835:b5cf:688f:ec09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 69B69260701;
        Fri, 12 Jul 2019 17:43:26 +0100 (BST)
Date:   Fri, 12 Jul 2019 18:43:23 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v4 3/3] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Message-ID: <20190712184323.28547c44@pc-381.home>
In-Reply-To: <SN6PR12MB26553046898233A094DCC952AEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
        <f239834a6b8bd179094cdc19a3ac5ecaf807cee3.1562931742.git.vitor.soares@synopsys.com>
        <20190712181332.04f8b3da@linux.home>
        <SN6PR12MB26553046898233A094DCC952AEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Jul 2019 16:28:02 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> Date: Fri, Jul 12, 2019 at 17:14:29
> 
> > On Fri, 12 Jul 2019 13:53:30 +0200
> > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> >   
> > > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only in
> > > spi and i2c mode.
> > > 
> > > The LSM6DSO and LSM6DSR are also i3c capable so lets give i3c support to
> > > them.
> > > 
> > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > Changes in v4:
> > >   Remove hw_id variable
> > > 
> > > Changes in v3:
> > >   Remove unnecessary st_lsm6dsx_i3c_data table used to hold device name
> > >   Use st_lsm6dsx_probe new form
> > > 
> > > Changes in v2:
> > >   Add support for LSM6DSR
> > >   Set pm_ops to st_lsm6dsx_pm_ops
> > > 
> > >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> > >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 58 +++++++++++++++++++++++++++++
> > >  3 files changed, 66 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > > index 9e59297..6b5a73c 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > > @@ -1,11 +1,12 @@
> > >  
> > >  config IIO_ST_LSM6DSX
> > >  	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> > > -	depends on (I2C || SPI)
> > > +	depends on (I2C || SPI || I3C)
> > >  	select IIO_BUFFER
> > >  	select IIO_KFIFO_BUF
> > >  	select IIO_ST_LSM6DSX_I2C if (I2C)
> > >  	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> > > +	select IIO_ST_LSM6DSX_I3C if (I3C)
> > >  	help
> > >  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
> > >  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> > > @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
> > >  	tristate
> > >  	depends on IIO_ST_LSM6DSX
> > >  	select REGMAP_SPI
> > > +
> > > +config IIO_ST_LSM6DSX_I3C
> > > +	tristate
> > > +	depends on IIO_ST_LSM6DSX
> > > +	select REGMAP_I3C
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
> > > index e5f733c..c676965 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> > > +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> > > @@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
> > >  obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
> > >  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
> > >  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
> > > +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > new file mode 100644
> > > index 0000000..2e89524
> > > --- /dev/null
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > @@ -0,0 +1,58 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > > + *
> > > + * Author: Vitor Soares <vitor.soares@synopsys.com>
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/i3c/device.h>
> > > +#include <linux/i3c/master.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/of.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include "st_lsm6dsx.h"
> > > +
> > > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
> > > +	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > > +	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),  
> > 
> > I think you need an uintptr_t cast here:
> > 
> > 	I3C_DEVICE(0x0104, 0x006C, (void *)(uintptr_t)ST_LSM6DSO_ID),
> > 	I3C_DEVICE(0x0104, 0x006B, (void *)(uintptr_t)ST_LSM6DSR_ID),
> > 
> > otherwise gcc might complain that the integer and pointer do not have
> > the same size (on 64-bit architectures).  
> 
> I don't understand this part. Can you provide or point some background?

If you don't do that you'll get the following warning:

	warning: cast to 'void *' from smaller integer type 'int' [-Wint-to-void-pointer-cast]

> 
> >   
> > > +	{ /* sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> > > +
> > > +static const struct regmap_config st_lsm6dsx_i3c_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +};  
> > 
> > This can be moved ...
> >   
> > > +
> > > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > > +{  
> > 
> > ... here without the static and const qualifiers:  
> 
> I understand that can be move to here, but I don't understand the 
> advantages. Can you explain?

It reduces the variable scope (this variable is only needed in the
probe path) and avoids consuming space in the .bss section, though the
second point is not so important.

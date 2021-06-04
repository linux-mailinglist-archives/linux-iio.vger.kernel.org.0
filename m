Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701B39B4DF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFDIa3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 04:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFDIa3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Jun 2021 04:30:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037B5613AE;
        Fri,  4 Jun 2021 08:28:41 +0000 (UTC)
Date:   Fri, 4 Jun 2021 09:30:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adis: Cleanout unused headers
Message-ID: <20210604093027.39b5ab7e@jic23-huawei>
In-Reply-To: <CA+U=Dsrep+tQKsXQLCX5piJFpO1fZu3=mSe2W8620-iJsT8wgQ@mail.gmail.com>
References: <20210603193616.3708447-1-jic23@kernel.org>
        <CA+U=Dsrep+tQKsXQLCX5piJFpO1fZu3=mSe2W8620-iJsT8wgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Jun 2021 10:12:53 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Jun 3, 2021 at 10:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > 0-day recently added the include-what-you-use header checker and
> > it gave a warning on an adis patch.  As such I decided to
> > run it on all the adis drivers and see if it made sensible suggestions.
> >
> > Note this doesn't represent a complete list of what it suggested changing
> > as I filtered out a few on the basis they are standard headers used to
> > effectively include a bunch of other headers.
> >
> > Could split this into a patch per driver if people prefer.
> >
> > Note to anyone else trying this tool is that it is somewhat
> > of a loose cannon so you will be wanting to carefully check any
> > suggestions before proposing patches!
> >
> > I thought about also reorganising the headers whilst here, but
> > that would make this patch harder to read, or lead to another rather
> > noisy patch across most of the files.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Given it's trivial (hopefully) but I want some decent build coverage,
I've applied this to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/accel/adis16201.c         | 3 ---
> >  drivers/iio/accel/adis16209.c         | 3 ---
> >  drivers/iio/gyro/adis16136.c          | 5 -----
> >  drivers/iio/gyro/adis16260.c          | 5 -----
> >  drivers/iio/imu/adis.c                | 4 ----
> >  drivers/iio/imu/adis16400.c           | 7 -------
> >  drivers/iio/imu/adis16460.c           | 1 -
> >  drivers/iio/imu/adis16475.c           | 1 -
> >  drivers/iio/imu/adis16480.c           | 6 ------
> >  drivers/staging/iio/accel/adis16203.c | 6 ------
> >  drivers/staging/iio/accel/adis16240.c | 6 ------
> >  11 files changed, 47 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> > index fe225990de24..7a434e2884d4 100644
> > --- a/drivers/iio/accel/adis16201.c
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -8,10 +8,7 @@
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/mutex.h>
> > -#include <linux/slab.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/sysfs.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/imu/adis.h>
> > diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> > index 6c2d4a967de7..ac08e866d612 100644
> > --- a/drivers/iio/accel/adis16209.c
> > +++ b/drivers/iio/accel/adis16209.c
> > @@ -7,11 +7,8 @@
> >
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > -#include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/imu/adis.h>
> > diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> > index d248c8a4a924..36879f01e28c 100644
> > --- a/drivers/iio/gyro/adis16136.c
> > +++ b/drivers/iio/gyro/adis16136.c
> > @@ -6,19 +6,14 @@
> >   *   Author: Lars-Peter Clausen <lars@metafoo.de>
> >   */
> >
> > -#include <linux/interrupt.h>
> > -#include <linux/delay.h>
> > -#include <linux/mutex.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/module.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> >
> >  #include <linux/debugfs.h>
> > diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> > index 56f930bbd341..66b6b7bd5e1b 100644
> > --- a/drivers/iio/gyro/adis16260.c
> > +++ b/drivers/iio/gyro/adis16260.c
> > @@ -5,17 +5,12 @@
> >   * Copyright 2010 Analog Devices Inc.
> >   */
> >
> > -#include <linux/interrupt.h>
> > -#include <linux/mutex.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/sysfs.h>
> >  #include <linux/module.h>
> >
> >  #include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> >
> >  #define ADIS16260_STARTUP_DELAY        220 /* ms */
> > diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> > index 319b64b2fd88..a5b421f42287 100644
> > --- a/drivers/iio/imu/adis.c
> > +++ b/drivers/iio/imu/adis.c
> > @@ -12,14 +12,10 @@
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> >  #include <linux/module.h>
> >  #include <asm/unaligned.h>
> >
> >  #include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> >
> >  #define ADIS_MSC_CTRL_DATA_RDY_EN      BIT(2)
> > diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> > index cb8d3ffab6fc..641b4f7d066d 100644
> > --- a/drivers/iio/imu/adis16400.c
> > +++ b/drivers/iio/imu/adis16400.c
> > @@ -10,22 +10,15 @@
> >   * Copyright (c) 2011 Analog Devices Inc.
> >   */
> >
> > -#include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > -#include <linux/delay.h>
> > -#include <linux/mutex.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> > -#include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/bitops.h>
> >
> >  #include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/imu/adis.h>
> > diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> > index 73bf45e859b8..ba373d7aaa2b 100644
> > --- a/drivers/iio/imu/adis16460.c
> > +++ b/drivers/iio/imu/adis16460.c
> > @@ -5,7 +5,6 @@
> >   * Copyright 2019 Analog Devices Inc.
> >   */
> >
> > -#include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/spi/spi.h>
> >
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 5654c0c15426..d0e84e5dee6c 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/imu/adis.h>
> > -#include <linux/iio/sysfs.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/irq.h>
> >  #include <linux/lcm.h>
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index a9c21a5ae05a..9ec0e61b484f 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -9,24 +9,18 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/delay.h>
> >  #include <linux/math.h>
> > -#include <linux/mutex.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> >  #include <linux/module.h>
> >  #include <linux/lcm.h>
> >  #include <linux/swab.h>
> >  #include <linux/crc32.h>
> >
> >  #include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> > -#include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >
> >  #include <linux/debugfs.h>
> > diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> > index b68304da288b..1d3026dae827 100644
> > --- a/drivers/staging/iio/accel/adis16203.c
> > +++ b/drivers/staging/iio/accel/adis16203.c
> > @@ -5,20 +5,14 @@
> >   * Copyright 2010 Analog Devices Inc.
> >   */
> >
> > -#include <linux/delay.h>
> >  #include <linux/device.h>
> >
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/imu/adis.h>
> > -#include <linux/iio/sysfs.h>
> >
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/mutex.h>
> > -#include <linux/slab.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/sysfs.h>
> >
> >  #define ADIS16203_STARTUP_DELAY 220 /* ms */
> >
> > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > index 8d3afc6dc755..2a8aa83b8d9e 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -5,20 +5,14 @@
> >   * Copyright 2010 Analog Devices Inc.
> >   */
> >
> > -#include <linux/interrupt.h>
> > -#include <linux/irq.h>
> > -#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> >  #include <linux/sysfs.h>
> > -#include <linux/list.h>
> >  #include <linux/module.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> >
> >  #define ADIS16240_STARTUP_DELAY        220 /* ms */
> > --
> > 2.31.1
> >  


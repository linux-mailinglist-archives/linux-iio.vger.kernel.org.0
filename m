Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5848258A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhLaSfE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 31 Dec 2021 13:35:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhLaSfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 13:35:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C55A261811
        for <linux-iio@vger.kernel.org>; Fri, 31 Dec 2021 18:35:02 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id AA087C36AE9;
        Fri, 31 Dec 2021 18:34:59 +0000 (UTC)
Date:   Fri, 31 Dec 2021 18:40:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/13] iio:accel:mma7455_core: Move exports into MMA7455
 namespace
Message-ID: <20211231184041.63e74af9@jic23-huawei>
In-Reply-To: <20211231104147.n35r6hkdi7cljjss@pengutronix.de>
References: <20211230193331.283503-1-jic23@kernel.org>
        <20211230193331.283503-3-jic23@kernel.org>
        <20211231104147.n35r6hkdi7cljjss@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Dec 2021 11:41:47 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Thu, Dec 30, 2021 at 07:33:20PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > In order to avoid unnecessary pollution of the global symbol namespace
> > move the core mma7455 functions into an mma7455 specific namespace and
> > import that into the two bus modules.
> > 
> > For more information see https://lwn.net/Articles/760045/
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Hi Uwe,

> > ---
> >  drivers/iio/accel/mma7455_core.c | 6 +++---
> >  drivers/iio/accel/mma7455_i2c.c  | 1 +
> >  drivers/iio/accel/mma7455_spi.c  | 1 +
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
> > index e6739ba74edf..4ece5e83a8ab 100644
> > --- a/drivers/iio/accel/mma7455_core.c
> > +++ b/drivers/iio/accel/mma7455_core.c
> > @@ -238,7 +238,7 @@ const struct regmap_config mma7455_core_regmap = {
> >  	.val_bits = 8,
> >  	.max_register = MMA7455_REG_TW,
> >  };
> > -EXPORT_SYMBOL_GPL(mma7455_core_regmap);
> > +EXPORT_SYMBOL_NS_GPL(mma7455_core_regmap, MMA7455);
> >  
> >  int mma7455_core_probe(struct device *dev, struct regmap *regmap,
> >  		       const char *name)
> > @@ -293,7 +293,7 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
> >  
> >  	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(mma7455_core_probe);
> > +EXPORT_SYMBOL_NS_GPL(mma7455_core_probe, MMA7455);
> >  
> >  void mma7455_core_remove(struct device *dev)
> >  {
> > @@ -306,7 +306,7 @@ void mma7455_core_remove(struct device *dev)
> >  	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
> >  		     MMA7455_MCTL_MODE_STANDBY);
> >  }
> > -EXPORT_SYMBOL_GPL(mma7455_core_remove);
> > +EXPORT_SYMBOL_NS_GPL(mma7455_core_remove, MMA7455);  
> 
> There is a more subtile way to do this. Up to you to judge which you
> prefer:
> 
> 	#define DEFAULT_SYMBOL_NAMESPACE MMA7455
> 
> and then use plain EXPORT_SYMBOL_GPL. This way you automatically switch
> all export statements in this file. (The #define has to be before
> #include <linux/export.h>.)

There was some discussion around doing this via makefiles for the CXL
subsystem (I believe it is done with USB for historical reasons) and general
view was that explicit statement was preferred.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/drivers/cxl/core?h=next&id=affec782742e08a7469ef81d7d0a4ae9d1345dfd

Was the outcome of that discussion though right now I can't find
the thread that lead to that patch.

Argument there was that it can be helpful to have it really
obvious in the code that a symbol is only intended for
limited access.

> 
> >  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
> >  MODULE_DESCRIPTION("Freescale MMA7455L core accelerometer driver");
> > diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
> > index 8a5256516f9f..b7a3d5da8f87 100644
> > --- a/drivers/iio/accel/mma7455_i2c.c
> > +++ b/drivers/iio/accel/mma7455_i2c.c
> > @@ -61,3 +61,4 @@ module_i2c_driver(mma7455_i2c_driver);
> >  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
> >  MODULE_DESCRIPTION("Freescale MMA7455L I2C accelerometer driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(MMA7455);
> > diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_spi.c
> > index ecf690692dcc..cc17755a1026 100644
> > --- a/drivers/iio/accel/mma7455_spi.c
> > +++ b/drivers/iio/accel/mma7455_spi.c
> > @@ -49,3 +49,4 @@ module_spi_driver(mma7455_spi_driver);
> >  MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
> >  MODULE_DESCRIPTION("Freescale MMA7455L SPI accelerometer driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(MMA7455);  
> 
> If you put this into the header near the declaration of the functions
> exported in this namespace, you only need one instead of two.
> 
> Anyhow, I think this is much a question of personal taste which to
> prefer, so understand this mail just as a hint about alternatives, not a
> request to change.

Interesting point on this.  I'm not sure what preferred option will be
and the one thing we want to be is consistent so people know where to
look for these lines.

Let's see if we get any additional opinions on this. So far the only
header in tree that has one of these is the ltc2497 from your series a
while back.  So definitely not common yet...  Early days though ;)

Jonathan
> 
> Best regards and happy new year,
> Uwe
> 


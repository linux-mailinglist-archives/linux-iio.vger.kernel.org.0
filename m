Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C242DFCFB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgLUOni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 09:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgLUOni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Dec 2020 09:43:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4306822BEF;
        Mon, 21 Dec 2020 14:42:56 +0000 (UTC)
Date:   Mon, 21 Dec 2020 14:42:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Max Leiter <maxwell.leiter@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        blaz@mxxn.io, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:light:apds9960 add detection for MSHW0184 ACPI
 device in apds9960 driver
Message-ID: <20201221144255.5657887f@archlinux>
In-Reply-To: <CAJCx=gm2hbfRePezjEh14a=DENX2dj8gc+SW8T-1NDWQY4eSTg@mail.gmail.com>
References: <20201220015057.107246-1-maxwell.leiter@gmail.com>
        <CAJCx=gm2hbfRePezjEh14a=DENX2dj8gc+SW8T-1NDWQY4eSTg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Dec 2020 14:05:17 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, Dec 19, 2020 at 5:51 PM Max Leiter <maxwell.leiter@gmail.com> wrote:
> >
> > The device is used in the Microsoft Surface Book 3 and Surface Pro 7
> >
> > Signed-off-by: Max Leiter <maxwell.leiter@gmail.com>  
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/apds9960.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> > index 9afb3fcc74e6..20719141c03a 100644
> > --- a/drivers/iio/light/apds9960.c
> > +++ b/drivers/iio/light/apds9960.c
> > @@ -8,6 +8,7 @@
> >   * TODO: gesture + proximity calib offsets
> >   */
> >
> > +#include <linux/acpi.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > @@ -1113,6 +1114,12 @@ static const struct i2c_device_id apds9960_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, apds9960_id);
> >
> > +static const struct acpi_device_id apds9960_acpi_match[] = {
> > +       { "MSHW0184" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
> > +
> >  static const struct of_device_id apds9960_of_match[] = {
> >         { .compatible = "avago,apds9960" },
> >         { }
> > @@ -1124,6 +1131,7 @@ static struct i2c_driver apds9960_driver = {
> >                 .name   = APDS9960_DRV_NAME,
> >                 .of_match_table = apds9960_of_match,
> >                 .pm     = &apds9960_pm_ops,
> > +               .acpi_match_table = apds9960_acpi_match,
> >         },
> >         .probe          = apds9960_probe,
> >         .remove         = apds9960_remove,
> > --
> > 2.29.2
> >  


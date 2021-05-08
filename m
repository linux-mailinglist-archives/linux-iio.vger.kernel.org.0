Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06863772B1
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhEHPqA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHPp7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:45:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB060610C9;
        Sat,  8 May 2021 15:44:56 +0000 (UTC)
Date:   Sat, 8 May 2021 16:45:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: am2315: Remove ACPI support
Message-ID: <20210508164554.35d255a1@jic23-huawei>
In-Reply-To: <20210508162535.280ed498@jic23-huawei>
References: <20210504153746.2129428-1-linux@roeck-us.net>
        <CAHp75VfJ=7B3UBMns1fm7apDmCC4eakeumw4dJYdRXd5wEGkpQ@mail.gmail.com>
        <20210508162535.280ed498@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 8 May 2021 16:25:35 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 4 May 2021 18:41:02 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, May 4, 2021 at 6:37 PM Guenter Roeck <linux@roeck-us.net> wrote:  
> > >
> > > With CONFIG_ACPI=n and -Werror, 0-day reports:
> > >
> > > drivers/iio/humidity/am2315.c:259:36: error:
> > >         'am2315_acpi_id' defined but not used
> > >
> > > According to Andy Shevchenko, the ACPI ID used in this driver is fake
> > > and does not really exist. Remove it and with it ACPI support from
> > > the driver.    
> > 
> > As I have found zarro evidences, I agree with removal. We must not
> > create fake ACPI IDs on our owns. If anybody will find a device that
> > is using this broken ID for real, then we may add it back.
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> 
> Applied to the togreg branch of iio.git with the commit message changed to
> reflect PRP0001 still working with this gone.

Changed that commit message again, after realizing that there is
not of_device_id table in this driver currently so I don't think PRP0001
current works either.

> 
> Thanks,
> 
> Jonathan
> >   
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > v2: Instead of making am2315_acpi_id depend on CONFIG_ACPI,
> > >     remove ACPI support entirely.
> > >
> > >  drivers/iio/humidity/am2315.c | 9 ---------
> > >  1 file changed, 9 deletions(-)
> > >
> > > diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> > > index 23bc9c784ef4..8d7ec2f5acf8 100644
> > > --- a/drivers/iio/humidity/am2315.c
> > > +++ b/drivers/iio/humidity/am2315.c
> > > @@ -7,7 +7,6 @@
> > >   * 7-bit I2C address: 0x5C.
> > >   */
> > >
> > > -#include <linux/acpi.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/kernel.h>
> > > @@ -256,17 +255,9 @@ static const struct i2c_device_id am2315_i2c_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
> > >
> > > -static const struct acpi_device_id am2315_acpi_id[] = {
> > > -       {"AOS2315", 0},
> > > -       {}
> > > -};
> > > -
> > > -MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> > > -
> > >  static struct i2c_driver am2315_driver = {
> > >         .driver = {
> > >                 .name = "am2315",
> > > -               .acpi_match_table = ACPI_PTR(am2315_acpi_id),
> > >         },
> > >         .probe =            am2315_probe,
> > >         .id_table =         am2315_i2c_id,
> > > --
> > > 2.25.1
> > >    
> > 
> >   
> 


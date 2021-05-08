Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAA3772AD
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhEHPmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHPmN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:42:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3177B61261;
        Sat,  8 May 2021 15:41:10 +0000 (UTC)
Date:   Sat, 8 May 2021 16:42:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio:accel:stk8312: Remove ACPI support
Message-ID: <20210508164208.7481e013@jic23-huawei>
In-Reply-To: <CAHp75VdkQmrfpwj6tmEpNYcL0soRcGrhoOghiqJpVezyxZ68LQ@mail.gmail.com>
References: <20210506035659.765109-1-linux@roeck-us.net>
        <CAHp75VdkQmrfpwj6tmEpNYcL0soRcGrhoOghiqJpVezyxZ68LQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 May 2021 12:29:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, May 6, 2021 at 6:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > With CONFIG_ACPI=n, W=1 and -Werror, 0-day reports:
> >
> > drivers/iio/accel/stk8312.c:644:36: error:
> >         'stk8312_acpi_id' defined but not used
> >
> > Apparently STK8312 is not a valid ACPI ID. Remove it and with it
> > ACPI support from the stk8312 driver.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> For the record, point finger on me in case somebody complains about
> any of such patches.
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > There is another patch pending which makes whitespace changes in struct
> > acpi_device_id stk8312_acpi_id. This will result in a conflict if this
> > patch is applied. In that patch, it is claimed that the driver would
> > possibly only be used based on its ACPI ID (even though that ACPI device
> > ID is not official).
> > Link: https://patchwork.kernel.org/project/linux-iio/patch/20210401144226.225928-1-jic23@kernel.org/
> > I can not determine if that claim has any truth in it. Still, it appears
> > that the device ID is not an official device ID.

So this is a fun corner case and I suspect reflects most that the device isn't
in common use with mainline Linux outside of the hobbyist community.
The other type of ID in the driver was in capitals whereas those IDs are always
lowercase.  That rather implied that it had been copied over from the ACPI binding.

Anyhow, I've applied this with the commit message adjusted to suggest that if anyone
does want ACPI binding support for this and doesn't have control of a vendor ID
then they should add the of_match_table and use PRP0001.  

Jonathan

 
> >
> >  drivers/iio/accel/stk8312.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> > index 157d8faefb9e..2fc30cfe1457 100644
> > --- a/drivers/iio/accel/stk8312.c
> > +++ b/drivers/iio/accel/stk8312.c
> > @@ -7,7 +7,6 @@
> >   * IIO driver for STK8312; 7-bit I2C address: 0x3D.
> >   */
> >
> > -#include <linux/acpi.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -640,18 +639,10 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
> >
> > -static const struct acpi_device_id stk8312_acpi_id[] = {
> > -       {"STK8312", 0},
> > -       {}
> > -};
> > -
> > -MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
> > -
> >  static struct i2c_driver stk8312_driver = {
> >         .driver = {
> >                 .name = STK8312_DRIVER_NAME,
> >                 .pm = STK8312_PM_OPS,
> > -               .acpi_match_table = ACPI_PTR(stk8312_acpi_id),
> >         },
> >         .probe =            stk8312_probe,
> >         .remove =           stk8312_remove,
> > --
> > 2.25.1
> >  
> 
> 


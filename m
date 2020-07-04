Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9C2147B8
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGDR0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDR0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 13:26:14 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737BC061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 10:26:13 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1DC539E0049;
        Sat,  4 Jul 2020 18:26:10 +0100 (BST)
Date:   Sat, 4 Jul 2020 18:26:09 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Signed-off-by: Dan O'Donovan" <dan@emutex.com>
Subject: Re: [PATCH 15/23] iio:adc:ti-adc081c: Drop of_match_ptr and change
 to mod_devicetable.h
Message-ID: <20200704182609.694ef281@archlinux>
In-Reply-To: <20200704164505.32b92957@archlinux>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-16-jic23@kernel.org>
        <CAHp75VfMdv-VzHcbS75psjdWGOnR8bkO3vmE5Z82vAMiGZJYtQ@mail.gmail.com>
        <20200704164505.32b92957@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Jul 2020 16:45:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 30 Jun 2020 10:12:51 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Whilst this driver already supports explicit ACPI bindings we
> > > might as well also allow for PRP0001 based binding.
> > >
> > > I'm also keen to remove of_match_ptr from IIO drivers to avoid
> > > this (now) anti-pattern getting coppied into new drivers.
> > >    
> > 
> > Code LGTM, but see below.
> >   
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/adc/ti-adc081c.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> > > index 82e524b3db88..e00350e6503f 100644
> > > --- a/drivers/iio/adc/ti-adc081c.c
> > > +++ b/drivers/iio/adc/ti-adc081c.c
> > > @@ -18,7 +18,7 @@
> > >  #include <linux/err.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/module.h>
> > > -#include <linux/of.h>
> > > +#include <linux/mod_devicetable.h>
> > >  #include <linux/acpi.h>
> > >
> > >  #include <linux/iio/iio.h>
> > > @@ -230,7 +230,6 @@ static const struct i2c_device_id adc081c_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, adc081c_id);
> > >
> > > -#ifdef CONFIG_OF
> > >  static const struct of_device_id adc081c_of_match[] = {
> > >         { .compatible = "ti,adc081c" },
> > >         { .compatible = "ti,adc101c" },
> > > @@ -238,7 +237,6 @@ static const struct of_device_id adc081c_of_match[] = {
> > >         { }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> > > -#endif
> > >
> > >  #ifdef CONFIG_ACPI
> > >  static const struct acpi_device_id adc081c_acpi_match[] = {    
> > 
> > These IDs seem to me artificial (and non-official). Perhaps in a
> > separate patch remove them?
> > Or do we have confirmation (in writing) from TI that these are okay?  
> +CC Dan O'Donovan,
> 
> It seems highly unlikely these are 'official'.
> 
> Dan.  You added them, can you give us some background (admittedly
> 4 years ago so you may not recall!)
> 
> Unfortunately I was rather less aware of ACPI than I have become in
> the meantime, so let these in without questioning them.
> 
> If we have these out there in in the wild, we can still add a note
> to make it clear that people should avoid using them in future,
> or copying the approach in other drivers.
> 
As this is a separate issue (kind of) I've applied this patch and
we can address whether to remove the ACPI bindings separately.

Thanks,

Jonathan

> Jonathan
> 
> >   
> > > @@ -253,7 +251,7 @@ MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> > >  static struct i2c_driver adc081c_driver = {
> > >         .driver = {
> > >                 .name = "adc081c",
> > > -               .of_match_table = of_match_ptr(adc081c_of_match),
> > > +               .of_match_table = adc081c_of_match,
> > >                 .acpi_match_table = ACPI_PTR(adc081c_acpi_match),
> > >         },
> > >         .probe = adc081c_probe,
> > > --
> > > 2.27.0
> > >    
> > 
> >   
> 


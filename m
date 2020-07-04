Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D818214702
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGDPpJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 11:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDPpJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 11:45:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CA4208D5;
        Sat,  4 Jul 2020 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593877508;
        bh=dEt5eMrXO68U6gmvoFZthqo/kk1idbcW/5i97JPzx50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tciENyb3T0HCzu56z4fJ5jj5YkLwoTZ/2qMjEPpqUj4Hqz4ZqRxPVFdzTYkjdNaPp
         YAev8Pul5/5BWQxTWoarJmNkYvDiE8f3AZEnzRj4eDoswISoI8k/k2wrraJFcRZMFj
         K49rLLq27rhaMGQ3MEMAU6Gda0oB839BRfR8Pgfo=
Date:   Sat, 4 Jul 2020 16:45:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Signed-off-by: Dan O'Donovan" <dan@emutex.com>
Subject: Re: [PATCH 15/23] iio:adc:ti-adc081c: Drop of_match_ptr and change
 to mod_devicetable.h
Message-ID: <20200704164505.32b92957@archlinux>
In-Reply-To: <CAHp75VfMdv-VzHcbS75psjdWGOnR8bkO3vmE5Z82vAMiGZJYtQ@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-16-jic23@kernel.org>
        <CAHp75VfMdv-VzHcbS75psjdWGOnR8bkO3vmE5Z82vAMiGZJYtQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:12:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst this driver already supports explicit ACPI bindings we
> > might as well also allow for PRP0001 based binding.
> >
> > I'm also keen to remove of_match_ptr from IIO drivers to avoid
> > this (now) anti-pattern getting coppied into new drivers.
> >  
> 
> Code LGTM, but see below.
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/adc/ti-adc081c.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> > index 82e524b3db88..e00350e6503f 100644
> > --- a/drivers/iio/adc/ti-adc081c.c
> > +++ b/drivers/iio/adc/ti-adc081c.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> > -#include <linux/of.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/acpi.h>
> >
> >  #include <linux/iio/iio.h>
> > @@ -230,7 +230,6 @@ static const struct i2c_device_id adc081c_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, adc081c_id);
> >
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id adc081c_of_match[] = {
> >         { .compatible = "ti,adc081c" },
> >         { .compatible = "ti,adc101c" },
> > @@ -238,7 +237,6 @@ static const struct of_device_id adc081c_of_match[] = {
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> > -#endif
> >
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id adc081c_acpi_match[] = {  
> 
> These IDs seem to me artificial (and non-official). Perhaps in a
> separate patch remove them?
> Or do we have confirmation (in writing) from TI that these are okay?
+CC Dan O'Donovan,

It seems highly unlikely these are 'official'.

Dan.  You added them, can you give us some background (admittedly
4 years ago so you may not recall!)

Unfortunately I was rather less aware of ACPI than I have become in
the meantime, so let these in without questioning them.

If we have these out there in in the wild, we can still add a note
to make it clear that people should avoid using them in future,
or copying the approach in other drivers.

Jonathan

> 
> > @@ -253,7 +251,7 @@ MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> >  static struct i2c_driver adc081c_driver = {
> >         .driver = {
> >                 .name = "adc081c",
> > -               .of_match_table = of_match_ptr(adc081c_of_match),
> > +               .of_match_table = adc081c_of_match,
> >                 .acpi_match_table = ACPI_PTR(adc081c_acpi_match),
> >         },
> >         .probe = adc081c_probe,
> > --
> > 2.27.0
> >  
> 
> 


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6768321471F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGDPzD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 11:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDPzD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 11:55:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C8E2084C;
        Sat,  4 Jul 2020 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593878102;
        bh=0SU09PC0GJ4YKgvqM7p3joa+9my0RIq6eA6E04w3IP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2fHRfS1DEaVgZVfci7OtlHW/3Z0g24yNSfIzk8oT5at+H0Q0p+PvRsLgMkRUvDed
         irFz84YsOTP5Vta9MY1Xh8yVhiCeallXvJXC401N3nuhcI2yUcq9u1800YBo3JmYVF
         uwhWZgriuXyNydAIoJwrl9A+QJtNbnI+D5G+JMdY=
Date:   Sat, 4 Jul 2020 16:54:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 18/23] iio:adc:ti-adc108s102: Drop CONFIG_OF and
 of_match_ptr protections
Message-ID: <20200704165458.0fac4009@archlinux>
In-Reply-To: <CAHp75VeUqMHpF29RYwpRFACcs73pmtvpBt+nQL7V+J-_BJD0Tg@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-19-jic23@kernel.org>
        <CAHp75VeUqMHpF29RYwpRFACcs73pmtvpBt+nQL7V+J-_BJD0Tg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:20:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Although this driver has an explicit ACPI binding it is good to also
> > allow for PRP0001 use of the of_match_id table.
> >
> > I'm also trying to clean this (now) anti-pattern out of IIO to avoid
> > cut and paste into new drivers.
> >
> > Also add an include of mod_devicetable.h as the driver directly uses
> > struct of_device_id which is defined in there.
> >  
> 
> I think this is not needed. At least the commit message in this case
> is misleading.
> We have only one ID and ACPI already has it. So, there is no need for
> this patch from that perspective.

It would be a bit odd if non Intel boards used an Intel ID for a TI
part.  Particularly I as can't immediately find any public docs
of the ID.  Do you know if these are documented publicly anywhere?

I know we don't do this in an ideal fashion as we have an internal
registry but I don't think we publish it anywhere, but then we don't
really expect anyone else to use them. I'm not aware of us having
issued IDs for parts made by anyone other than ourselves.

So in general I'd rather we gave the option for using the dt binding
PRP0001 route in addition to the intel ACPI ID.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  drivers/iio/adc/ti-adc108s102.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> > index 9b9b27415c93..183b2245e89b 100644
> > --- a/drivers/iio/adc/ti-adc108s102.c
> > +++ b/drivers/iio/adc/ti-adc108s102.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > @@ -299,13 +300,11 @@ static int adc108s102_remove(struct spi_device *spi)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id adc108s102_of_match[] = {
> >         { .compatible = "ti,adc108s102" },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, adc108s102_of_match);
> > -#endif
> >
> >  #ifdef CONFIG_ACPI
> >  static const struct acpi_device_id adc108s102_acpi_ids[] = {
> > @@ -324,7 +323,7 @@ MODULE_DEVICE_TABLE(spi, adc108s102_id);
> >  static struct spi_driver adc108s102_driver = {
> >         .driver = {
> >                 .name   = "adc108s102",
> > -               .of_match_table = of_match_ptr(adc108s102_of_match),
> > +               .of_match_table = adc108s102_of_match,
> >                 .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
> >         },
> >         .probe          = adc108s102_probe,
> > --
> > 2.27.0
> >  
> 
> 


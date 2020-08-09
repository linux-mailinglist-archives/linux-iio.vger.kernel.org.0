Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6823FEAB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIOIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHIOIQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 10:08:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7085A206E9;
        Sun,  9 Aug 2020 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596982096;
        bh=AGK7prK7RbPsJywlY2lVQrAG/dPL/EXV1yU+vZe+aus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Be4KwpNx2pAtLSfkF1fnR4nFwKQR5fkOFfL/sl6QzUrqZQscJhGa2W4CiSU9ijvP2
         aCedH7QgoJm9inGG71omfOvtrf+9Rn/FYLR9oHJlNgv/6E2MJ5tD0V0/dD5g2wxpPH
         +Y8PJkRf1VWrn/4mk9QweBXNojR/Odcy33yyMhu0=
Date:   Sun, 9 Aug 2020 15:08:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 3/5] iio:adc:ti-adc108s102: Drop CONFIG_OF and
 of_match_ptr protections
Message-ID: <20200809150811.13cc9010@archlinux>
In-Reply-To: <CAHp75VcTQP=rX5Rg8LgUozi-xS4mSqisYawA1PHHL4BCZEhH5A@mail.gmail.com>
References: <20200721171444.825099-1-jic23@kernel.org>
        <20200721171444.825099-4-jic23@kernel.org>
        <CAHp75VcTQP=rX5Rg8LgUozi-xS4mSqisYawA1PHHL4BCZEhH5A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 21:31:36 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I'm trying to clean this (now) anti-pattern out of IIO to avoid
> > cut and paste into new drivers.
> >
> > Also add an include of mod_devicetable.h as the driver directly uses
> > struct of_device_id which is defined in there.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied,

Thanks,

J
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > v1->v2
> > * Drop reference to PRP0001 etc in this one as it has valid ACPI
> >   IDs.
> >
> > drivers/iio/adc/ti-adc108s102.c | 5 ++---
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


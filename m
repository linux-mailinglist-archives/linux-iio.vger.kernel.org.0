Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF96F214723
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGDP6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 11:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGDP6h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 11:58:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3C4206DF;
        Sat,  4 Jul 2020 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593878316;
        bh=ooUk91CLR+0KzOjYNRcj3yoOBos1dDeYRC4l/8QsrWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hOCksXZ1gFkR4t6XBzom+Kdq0XPTYqsEV9JtAC4oi+6+gxBEb7CudyHF5M1ACBR38
         TF6VHUIv670PN5vCjNedE4f4x1x1yGcPXm2iSN4N4LgJX30b9Cd+XiZHZj60RYfxne
         tYBVoe4Z9nNBMD/OWeyfxaXwLyj2HDiGQ0rHd42U=
Date:   Sat, 4 Jul 2020 16:58:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Re: [PATCH 19/23] iio:adc:ti-adc128s052: drop of_match_ptr
 protection
Message-ID: <20200704165832.5dafe051@archlinux>
In-Reply-To: <CAHp75Vfba8cJkhZVpRyspc7CgrmYy0BjvuBjb4==BFMsa-tCyg@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-20-jic23@kernel.org>
        <CAHp75Vfba8cJkhZVpRyspc7CgrmYy0BjvuBjb4==BFMsa-tCyg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jun 2020 10:22:45 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There is no real advantage in this and it prevents use of
> > ACPI PRP0001. I'm also trying to clear this out of IIO in general
> > to avoid copying in new drivers.
> >
> > Include mod_devicetable.h as we are using of_device_id in here so
> > including that header is best practice.  
> 
> Similar comment as per previous patch. ACPI has an official ID at
> least for one component. So, we encourage vendors to provide proper
> ID.

The problem is that not all vendors have an ACPI manufacturer ID
(or a PNP one). They could probably get one but smaller manufacturers
are never going to bother.

> That said, the commit message is misleading a bit here (it might be
> useful for the components which are not supported by existing ACPI ID.

I'm a bit dubious about encouraging people to use an Intel ID. If it
were issued by TI for a TI part that would be a different matter.

Obviously there is no problem with Intel issuing an ID, or anyone else
doing so.

Jonathan

> 
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > ---
> >  drivers/iio/adc/ti-adc128s052.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index c1552b0fee04..cc3fb2d1686a 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/err.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> > @@ -220,7 +221,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> >  static struct spi_driver adc128_driver = {
> >         .driver = {
> >                 .name = "adc128s052",
> > -               .of_match_table = of_match_ptr(adc128_of_match),
> > +               .of_match_table = adc128_of_match,
> >                 .acpi_match_table = ACPI_PTR(adc128_acpi_match),
> >         },
> >         .probe = adc128_probe,
> > --
> > 2.27.0
> >  
> 
> 


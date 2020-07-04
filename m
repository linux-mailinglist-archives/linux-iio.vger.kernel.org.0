Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789DD2147BD
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGDRbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDRbn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:31:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6615C20748;
        Sat,  4 Jul 2020 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883903;
        bh=SESePMpyVjYPzwPnRVcSGx/tBJ6O1jkAVKu8ZGZn0mQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OIEvo7fZbPVvNmbfHfzjp4Kth1sj2jrZM3y+OcwxugrjwcLdEvgO39M7zhgne8FWd
         SLrF6JbXEBtOJ4K0TNmWAVPoDeRokW3bb/z9T3s3F2oPHqWUV+XMoP+QpweKEbf45q
         SaQPI8AVF6i3FZaDKbwhYxOYNK/PI95RlBxQ2gkc=
Date:   Sat, 4 Jul 2020 18:31:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 20/23] iio:adc:ti-adc161s626: Drop of_match_ptr
 protection.
Message-ID: <20200704183139.36e1ebd8@archlinux>
In-Reply-To: <CAJCx=gmZcc=GPteUhcG6uC+Ezp5BkE5f=H-YGF=L+e9nwauQrA@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-21-jic23@kernel.org>
        <CAJCx=gmZcc=GPteUhcG6uC+Ezp5BkE5f=H-YGF=L+e9nwauQrA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 12:51:09 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Jun 28, 2020 at 5:39 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Dropping this allows use of ACPI PRP0001.
> >
> > I'm also looking to drop all of_match_ptr use in IIO in order to avoid
> > it getting cut and paste into new drivers in the future.
> >
> > Also add a direct include of mod_devicetable.h to reflect the use
> > of struct of_device_id.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.

Thanks,

Jonathan

> 
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/adc/ti-adc161s626.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> > index f27ca3161530..607791ffe7f0 100644
> > --- a/drivers/iio/adc/ti-adc161s626.c
> > +++ b/drivers/iio/adc/ti-adc161s626.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/init.h>
> >  #include <linux/err.h>
> >  #include <linux/spi/spi.h>
> > @@ -257,7 +258,7 @@ MODULE_DEVICE_TABLE(spi, ti_adc_id);
> >  static struct spi_driver ti_adc_driver = {
> >         .driver = {
> >                 .name   = TI_ADC_DRV_NAME,
> > -               .of_match_table = of_match_ptr(ti_adc_dt_ids),
> > +               .of_match_table = ti_adc_dt_ids,
> >         },
> >         .probe          = ti_adc_probe,
> >         .remove         = ti_adc_remove,
> > --
> > 2.27.0
> >  


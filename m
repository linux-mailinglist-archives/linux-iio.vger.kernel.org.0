Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD22147AC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGDRTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgGDRTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:19:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2555220737;
        Sat,  4 Jul 2020 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593883147;
        bh=OsxmT5cTxf5QNb+/jlVqNSKLTitmbDMAOhy+OIg771E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQLgB3Oh+4UzkmF9Z3OlTipiRcZ6enU0gNYtNG7pSvWliJeSNrCUFcrPQ4mgRGvAK
         OGJKzTX51oeAQ3BZujJFnU9zr1Bly3W7INPwbxIZiBwNlAIsMGKrGQlNWBkVLDbiL8
         Ui4QUS7+4ho06Dr+ihsH8GIalbGdcBjgSG5z/2L4=
Date:   Sat, 4 Jul 2020 18:19:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/23] iio:adc:max11100: Drop of_match_ptr protection /
 add mod_devicetable.h include
Message-ID: <20200704181903.0ad2b7c5@archlinux>
In-Reply-To: <20200629072809.fk2vve5ycdiwnkyk@uno.localdomain>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-11-jic23@kernel.org>
        <20200629072809.fk2vve5ycdiwnkyk@uno.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jun 2020 09:28:09 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Jonathan,
> On Sun, Jun 28, 2020 at 01:36:41PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Allows use of driver with ACPI PRP0001 base binding.
> > Mostly this is about trying to avoid cut and paste of this into new
> > drivers (it is a frequent review comment) rather than any
> > thought that this driver might get used on an ACPI platform.
> >
> > The mod_devicetable.h include is to encourage best practice of including
> > any header directly used within the code (here for of_match_id)
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> >  drivers/iio/adc/max11100.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> > index 57734f9742f6..77fcee1dddf7 100644
> > --- a/drivers/iio/adc/max11100.c
> > +++ b/drivers/iio/adc/max11100.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>  
> 
> If we want to keep the inclusion order alphabetically sorted,
> shouldn't mod_devicetable. come before module.h ?

I have no idea what the 'convention' on ordering of
underscores in the kernel is, so I did

git grep -A1 module\.h -- drivers/ | grep mod_devicetable\.h | wc
 116     232    7798
git grep -B1 module\.h -- drivers/ | grep mod_devicetable\.h | wc
 52     104    3694

Which I think means we have almost twice as many cases of
it being after module.h as before.  Still I'm going to cynically
decide to not care :)

> 
> That apart:
> Acked-by: Jacopo Mondi <jacopo@jmondi.org>
> 
Thanks,

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Jonathan

> Thanks
>    j
> 
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> >
> > @@ -161,7 +162,7 @@ MODULE_DEVICE_TABLE(of, max11100_ids);
> >  static struct spi_driver max11100_driver = {
> >  	.driver = {
> >  		.name	= "max11100",
> > -		.of_match_table = of_match_ptr(max11100_ids),
> > +		.of_match_table = max11100_ids,
> >  	},
> >  	.probe		= max11100_probe,
> >  	.remove		= max11100_remove,
> > --
> > 2.27.0
> >  


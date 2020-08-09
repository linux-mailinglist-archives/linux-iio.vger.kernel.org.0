Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE43923FEAC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIOJr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 10:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHIOJr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 10:09:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269BE206E9;
        Sun,  9 Aug 2020 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596982186;
        bh=u9nsiS9hAMftDRYwgB2jr/0G/Hl3f30oiduyvHJph7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNPihZo2URGp5LPWZy3gPrAUB0QrWh2+gH9U/Y7IajaceEAMRnOp0qYmIXmqImzLA
         DxRJokTLFoavpuuk/SVzRLTXRxEUHeuU1Wvn8IovSJkTBhzpL0zj2aq+eTwKYEKXjJ
         kmQsUoMW3N4K8hr8ibSE0vXtrtXzq6H8WgyMGVYo=
Date:   Sun, 9 Aug 2020 15:09:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/5] iio:adc:ti-adc081c: Drop ACPI ids that seem very
 unlikely to be official.
Message-ID: <20200809150943.3d40f0f4@archlinux>
In-Reply-To: <CAHp75VfPm0m=QwcYUx=iPLSmd2iK-dd5MswipAzqKDmYZBWO=Q@mail.gmail.com>
References: <20200721171444.825099-1-jic23@kernel.org>
        <20200721171444.825099-3-jic23@kernel.org>
        <CAHp75VfPm0m=QwcYUx=iPLSmd2iK-dd5MswipAzqKDmYZBWO=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 21:30:08 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > We have no known users of these in the wild.
> > it seems very unlikely these are real IDS having the form ADCXXXX  
> 
> IDS -> IDs
> 
> > as that ID is owned by Achnor Datacomm not TI.  
> 
> After addressing above typo fix,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied.

Thanks,

Jonathan

> 
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v1->v2
> > New patch
> >  drivers/iio/adc/ti-adc081c.c | 24 +-----------------------
> >  1 file changed, 1 insertion(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> > index 9426f70a8005..8bc04cfae465 100644
> > --- a/drivers/iio/adc/ti-adc081c.c
> > +++ b/drivers/iio/adc/ti-adc081c.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > -#include <linux/acpi.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> > @@ -153,17 +152,7 @@ static int adc081c_probe(struct i2c_client *client,
> >         if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> >                 return -EOPNOTSUPP;
> >
> > -       if (ACPI_COMPANION(&client->dev)) {
> > -               const struct acpi_device_id *ad_id;
> > -
> > -               ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
> > -                                         &client->dev);
> > -               if (!ad_id)
> > -                       return -ENODEV;
> > -               model = &adcxx1c_models[ad_id->driver_data];
> > -       } else {
> > -               model = &adcxx1c_models[id->driver_data];
> > -       }
> > +       model = &adcxx1c_models[id->driver_data];
> >
> >         iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
> >         if (!iio)
> > @@ -238,21 +227,10 @@ static const struct of_device_id adc081c_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> >
> > -#ifdef CONFIG_ACPI
> > -static const struct acpi_device_id adc081c_acpi_match[] = {
> > -       { "ADC081C", ADC081C },
> > -       { "ADC101C", ADC101C },
> > -       { "ADC121C", ADC121C },
> > -       { }
> > -};
> > -MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> > -#endif
> > -
> >  static struct i2c_driver adc081c_driver = {
> >         .driver = {
> >                 .name = "adc081c",
> >                 .of_match_table = adc081c_of_match,
> > -               .acpi_match_table = ACPI_PTR(adc081c_acpi_match),
> >         },
> >         .probe = adc081c_probe,
> >         .remove = adc081c_remove,
> > --
> > 2.27.0
> >  
> 
> 


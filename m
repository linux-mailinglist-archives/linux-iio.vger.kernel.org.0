Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D552456DD
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgHPJA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgHPJAX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:00:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A514E20674;
        Sun, 16 Aug 2020 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597568422;
        bh=frEIw9d6D2HDExTMI60AHaHyywjpFGkYRTpFrZJaBCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrb6V+etEIqbgEc2/rA/vCBN3+cVQ13BFanQOtsyHUEnwEsNdsNXkNDbQEDz+er+W
         0R4Flw7ChSY4zLr7wNgpo0zSOws6QEM1na83N/0Nhs9GUScDaLpfod+8/jr6vtggjH
         aA4UO7B062SK9gLaKWqIfRheh+jw5sLv6b/NIlwQ=
Date:   Sun, 16 Aug 2020 10:00:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v3] iio:adc:axp20x: Convert from OF to generic fw /
 device properties
Message-ID: <20200816100017.5c809bcb@archlinux>
In-Reply-To: <CAHp75VfLNRmEQ3L217H05My4+9Erhj9+EDd8ONX5bM+=gP5bwg@mail.gmail.com>
References: <20200809141305.205993-1-jic23@kernel.org>
        <CAHp75VfLNRmEQ3L217H05My4+9Erhj9+EDd8ONX5bM+=gP5bwg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 11:01:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 9, 2020 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst fairly unlikely anyone will ever use this driver with anything
> > other than DT, we are trying to move IIO over to the generic interfaces
> > where easy to do so.
> >
> > In this case this involved moving to generic check on presence
> > of fwnode, generic device_get_match_data() and dropping the of_match_ptr
> > protection.  Also relevant header changes to have property.h and
> > mod_devicetable.h only.
> >
> > Also drop the casting away of a const in favour of retaining
> > the const throughout.  
> 
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks.  Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with them.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Quentin Schulz <quentin.schulz@bootlin.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > V3 changes: Tidy up the commit message as suggested by
> > Andy Schevchenko.
> >
> > drivers/iio/adc/axp20x_adc.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index 798ff2d89691..3e0c0233b431 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -9,10 +9,10 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > -#include <linux/of.h>
> > -#include <linux/of_device.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/thermal.h>
> >
> > @@ -67,7 +67,7 @@ struct axp_data;
> >
> >  struct axp20x_adc_iio {
> >         struct regmap           *regmap;
> > -       struct axp_data         *data;
> > +       const struct axp_data   *data;
> >  };
> >
> >  enum axp20x_adc_channel_v {
> > @@ -670,15 +670,15 @@ static int axp20x_probe(struct platform_device *pdev)
> >         info->regmap = axp20x_dev->regmap;
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >
> > -       if (!pdev->dev.of_node) {
> > +       if (!dev_fwnode(&pdev->dev)) {
> >                 const struct platform_device_id *id;
> >
> >                 id = platform_get_device_id(pdev);
> > -               info->data = (struct axp_data *)id->driver_data;
> > +               info->data = (const struct axp_data *)id->driver_data;
> >         } else {
> >                 struct device *dev = &pdev->dev;
> >
> > -               info->data = (struct axp_data *)of_device_get_match_data(dev);
> > +               info->data = device_get_match_data(dev);
> >         }
> >
> >         indio_dev->name = platform_get_device_id(pdev)->name;
> > @@ -742,7 +742,7 @@ static int axp20x_remove(struct platform_device *pdev)
> >  static struct platform_driver axp20x_adc_driver = {
> >         .driver = {
> >                 .name = "axp20x-adc",
> > -               .of_match_table = of_match_ptr(axp20x_adc_of_match),
> > +               .of_match_table = axp20x_adc_of_match,
> >         },
> >         .id_table = axp20x_adc_id_match,
> >         .probe = axp20x_probe,
> > --
> > 2.28.0
> >  
> 
> 


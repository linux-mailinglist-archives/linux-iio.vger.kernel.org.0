Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30923532E
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHAQFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 12:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgHAQFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 12:05:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD8B206D4;
        Sat,  1 Aug 2020 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596297934;
        bh=vW/nC/AAxomOowUDa99B5YwQCZRyKOXDNcqrGOfEerE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRrny1QBOWumlSaZFW/QpXkHCuKbeCKgA790j+ENfR6T0H3lw2vDeGsk5DWsNGA3e
         uzJ618W2eAunokNml9NwqhoCj/kpHzjg2HKqp8Lis+WjgRZ6+S/K+x91vFBERtn9IE
         P4onTSxpa6O1nS6zc3hvX2Ru/XzfPTU65M44vM6s=
Date:   Sat, 1 Aug 2020 17:05:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Berghe, Darius" <Darius.Berghe@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Message-ID: <20200801170529.29caf1c3@archlinux>
In-Reply-To: <MWHPR03MB319956D095B2715835D0BF1A96730@MWHPR03MB3199.namprd03.prod.outlook.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
        <20200727135834.84093-3-darius.berghe@analog.com>
        <20200727182647.00002e3c@huawei.com>
        <MWHPR03MB319956D095B2715835D0BF1A96730@MWHPR03MB3199.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jul 2020 06:24:03 +0000
"Berghe, Darius" <Darius.Berghe@analog.com> wrote:

> Hi Jonathan,
> 
> Thanks for review, comments inline.
> 
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Sent: Monday, July 27, 2020 8:27 PM
> > To: Berghe, Darius <Darius.Berghe@analog.com>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; jic23@kernel.org; robh@kernel.org
> > Subject: Re: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
> > 
> > [External]
> > 
> > On Mon, 27 Jul 2020 16:58:33 +0300
> > Darius Berghe <darius.berghe@analog.com> wrote:
> >   
> > > Add compatible strings for these devices in the existing ltc2471
> > > driver.
> > >
> > > Signed-off-by: Darius Berghe <darius.berghe@analog.com>  
> > 
> > Hi Darius,
> > 
> > A few additional minor comments from me.
> >   
> > > ---
> > >  drivers/iio/adc/ltc2471.c | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> > > index e1c4e966524d..8c57203b1fe4 100644
> > > --- a/drivers/iio/adc/ltc2471.c
> > > +++ b/drivers/iio/adc/ltc2471.c
> > > @@ -1,5 +1,7 @@
> > >  /*
> > > - * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
> > > + * Driver for Linear Technology LTC2461, LTC2463, LTC2471 and LTC2473
> > > + voltage
> > > + * monitors.
> > > + * The LTC2463 is identical to the 2461, but reports a differential signal.
> > >   * The LTC2473 is identical to the 2471, but reports a differential signal.
> > >   *
> > >   * Copyright (C) 2017 Topic Embedded Products @@ -17,8 +19,10 @@
> > > #include <linux/mod_devicetable.h>
> > >
> > >  enum ltc2471_chips {
> > > +	ltc2461,
> > > +	ltc2463,
> > >  	ltc2471,
> > > -	ltc2473,
> > > +	ltc2473  
> > 
> > Why drop the comma?  We've just added two new devices. Seems possible
> > there may be more in the future!
> >   
> 
> Ok, will leave it there in v4.
> 
> > >  };
> > >
> > >  struct ltc2471_data {
> > > @@ -122,7 +126,7 @@ static int ltc2471_i2c_probe(struct i2c_client  
> > *client,  
> > >  	indio_dev->name = id->name;
> > >  	indio_dev->info = &ltc2471_info;
> > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > > -	if (id->driver_data == ltc2473)
> > > +	if (id->driver_data == ltc2473 || id->driver_data == ltc2463)  
> > If the only use of driver_data is going to be this check, then just set it to 2473
> > for the 2463 and 2473.  It's not uncommon to do this when we have a bunch
> > of devices that look the same to software.  
> 
> Yes the chips are similar but there is at least one feature which requires this level 
> of distinguishing them: the sampling rate (60sps for ltc2461/3 and selectable 208/833sps 
> for ltc2471/3). It's not used anywhere for now but I can see it being implemented
> as standard IIO dev attribute sampling frequency.

Fair enough.  Perhaps a note in the patch description so no one asks the question
on the next version?

> 
> >   
> > >  		indio_dev->channels = ltc2473_channel;
> > >  	else
> > >  		indio_dev->channels = ltc2471_channel; @@ -139,6 +143,8  
> > @@ static  
> > > int ltc2471_i2c_probe(struct i2c_client *client,  }
> > >
> > >  static const struct i2c_device_id ltc2471_i2c_id[] = {
> > > +	{ "ltc2461", ltc2461 },
> > > +	{ "ltc2463", ltc2463 },
> > >  	{ "ltc2471", ltc2471 },
> > >  	{ "ltc2473", ltc2473 },
> > >  	{}
> > > @@ -146,6 +152,8 @@ static const struct i2c_device_id ltc2471_i2c_id[]
> > > = {  MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
> > >
> > >  static const struct of_device_id ltc2471_of_match[] = {
> > > +	{ .compatible = "adi,ltc2461" },
> > > +	{ .compatible = "adi,ltc2463" },
> > >  	{ .compatible = "adi,ltc2471" },
> > >  	{ .compatible = "adi,ltc2473" },
> > >  	{}
> > > @@ -163,6 +171,6 @@ static struct i2c_driver ltc2471_i2c_driver = {
> > >
> > >  module_i2c_driver(ltc2471_i2c_driver);
> > >
> > > -MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
> > > +MODULE_DESCRIPTION("LTC2461/LTC2463/LTC2471/LTC2473 ADC  
> > driver");  
> > >  MODULE_AUTHOR("Topic Embedded Products");  MODULE_LICENSE("GPL  
> > v2");  
> 


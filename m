Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D373A1DD4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFITt4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 15:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITt4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 15:49:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01AD61376;
        Wed,  9 Jun 2021 19:47:59 +0000 (UTC)
Date:   Wed, 9 Jun 2021 20:49:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/9] iio: accel: bmc150: Don't make the remove
 function of the second accelerometer unregister itself
Message-ID: <20210609204953.5314cbd0@jic23-huawei>
In-Reply-To: <20210526175541.35db2461@jic23-huawei>
References: <20210523170103.176958-1-hdegoede@redhat.com>
        <20210523170103.176958-3-hdegoede@redhat.com>
        <20210526175541.35db2461@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 May 2021 17:55:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 23 May 2021 19:00:56 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > On machines with dual accelerometers described in a single ACPI fwnode,
> > the bmc150_accel_probe() instantiates a second i2c-client for the second
> > accelerometer.
> > 
> > A pointer to this manually instantiated second i2c-client is stored
> > inside the iio_dev's private-data through bmc150_set_second_device(),
> > so that the i2c-client can be unregistered from bmc150_accel_remove().
> > 
> > Before this commit bmc150_set_second_device() took only 1 argument so it
> > would store the pointer in private-data of the iio_dev belonging to the
> > manually instantiated i2c-client, leading to the bmc150_accel_remove()
> > call for the second_dev trying to unregister *itself* while it was
> > being removed, leading to a deadlock and rmmod hanging.
> > 
> > Change bmc150_set_second_device() to take 2 arguments: 1. The i2c-client
> > which is instantiating the second i2c-client for the 2nd accelerometer and
> > 2. The second-device pointer itself (which also is an i2c-client).
> > 
> > This will store the second_device pointer in the private data of the
> > iio_dev belonging to the (ACPI instantiated) i2c-client for the first
> > accelerometer and will make bmc150_accel_remove() unregister the
> > second_device i2c-client when called for the first client,
> > avoiding the deadlock.
> > 
> > Fixes: 5bfb3a4bd8f6 ("iio: accel: bmc150: Check for a second ACPI device for BOSC0200")
> > Cc: Jeremy Cline <jeremy@jcline.org>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> Patches 1 and 2 applied to the fixes-togreg branch of iio.git and marked for stable.
> The rest will have to wait for now.
Cycle has gone past rather quicker than expected, so I've changed
my mind on these two and pulled them across to the togreg branch
targeting 5.14.  That will mean the hit stable a little later (after 5.14-rc1)
but pretty much ensures the rest of the series makes it into 5.14

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 4 ++--
> >  drivers/iio/accel/bmc150-accel-i2c.c  | 2 +-
> >  drivers/iio/accel/bmc150-accel.h      | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 3a3f67930165..8ff358c37a81 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1815,11 +1815,11 @@ struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
> >  }
> >  EXPORT_SYMBOL_GPL(bmc150_get_second_device);
> >  
> > -void bmc150_set_second_device(struct i2c_client *client)
> > +void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev)
> >  {
> >  	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
> >  
> > -	data->second_device = client;
> > +	data->second_device = second_dev;
> >  }
> >  EXPORT_SYMBOL_GPL(bmc150_set_second_device);
> >  
> > diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> > index 69f709319484..2afaae0294ee 100644
> > --- a/drivers/iio/accel/bmc150-accel-i2c.c
> > +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> > @@ -70,7 +70,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
> >  
> >  		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> >  		if (!IS_ERR(second_dev))
> > -			bmc150_set_second_device(second_dev);
> > +			bmc150_set_second_device(client, second_dev);
> >  	}
> >  #endif
> >  
> > diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> > index 6024f15b9700..e30c1698f6fb 100644
> > --- a/drivers/iio/accel/bmc150-accel.h
> > +++ b/drivers/iio/accel/bmc150-accel.h
> > @@ -18,7 +18,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  			    const char *name, bool block_supported);
> >  int bmc150_accel_core_remove(struct device *dev);
> >  struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
> > -void bmc150_set_second_device(struct i2c_client *second_device);
> > +void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev);
> >  extern const struct dev_pm_ops bmc150_accel_pm_ops;
> >  extern const struct regmap_config bmc150_regmap_conf;
> >    
> 


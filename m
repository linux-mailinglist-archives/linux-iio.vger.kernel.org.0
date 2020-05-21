Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF621DD603
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgEUSbA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgEUSbA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:31:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6CE207D3;
        Thu, 21 May 2020 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590085859;
        bh=AqLKF3zevyYxXSz0Pxo3hQCsOdifZ/ID8n8/sQf1rJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awANiXB4wP23gHbQESWbezZdjDCzfg4EgP2Ypeh1rTLvAajzThzV74nM7G7aTOpCq
         CEn+Nt/tldhCUta0v/B7iHfFGLMAb3gXSJ8GhBIWyWTewchk0S1rbUBSFFAKlzK9eJ
         icxgFSKzIL48STYVxPx7zbi0GipRJ5pSR9GalOOA=
Date:   Thu, 21 May 2020 19:30:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 3/4] iio: imu: bmi160: added regulator support
Message-ID: <20200521193055.7ee7cf9c@archlinux>
In-Reply-To: <20200520071751.GD3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-4-jonathan.albrieux@gmail.com>
        <20200519185535.00003cb7@Huawei.com>
        <20200520071751.GD3361@ict14-OptiPlex-980>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 09:17:51 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> On Tue, May 19, 2020 at 06:55:35PM +0100, Jonathan Cameron wrote:
> > On Tue, 19 May 2020 09:50:59 +0200
> > Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> >   
> > > v2: fixed missing description  
> > 
> > Don't put change log here....  
> 
> Yep I will put it in the cover letter
> 
> > > 
> > > Add vdd-supply and vddio-supply support. Without this support vdd and vddio
> > > should be set to always-on in device tree  
> > 
> > Kind of the opposite.  If they are always on we don't have to provide them
> > in the device tree.
> >   
> 
> I wrote that because, testing on msm8916, without setting the regulators to
> always on they were controlled by other components and it happened that
> the line wasn't ready during probe causing failure to load the module.
> 
> I will try to reword based on your comment, thank you.

Ah. Understood.  I'd give that explicit example in the patch description.
I'd assumed this was the normal case of they weren't being described
at all in DT, whereas you case is more complex.

Jonathan

> 
> > A few trivial things inline.
> >   
> > > 
> > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > > ---  
> > 
> > Change log goes here so we don't end up keeping it in the git log.
> >   
> > >  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
> > >  drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++++++++++++++++++++++-
> > >  2 files changed, 28 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> > > index 621f5309d735..923c3b274fde 100644
> > > --- a/drivers/iio/imu/bmi160/bmi160.h
> > > +++ b/drivers/iio/imu/bmi160/bmi160.h
> > > @@ -3,10 +3,12 @@
> > >  #define BMI160_H_
> > >  
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  struct bmi160_data {
> > >  	struct regmap *regmap;
> > >  	struct iio_trigger *trig;
> > > +	struct regulator_bulk_data supplies[2];
> > >  };
> > >  
> > >  extern const struct regmap_config bmi160_regmap_config;
> > > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > > index 6af65d6f1d28..9bbe0d8e6720 100644
> > > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/of_irq.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/triggered_buffer.h>
> > > @@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> > >  	unsigned int val;
> > >  	struct device *dev = regmap_get_device(data->regmap);
> > >  
> > > +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > >  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -793,9 +800,17 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
> > >  static void bmi160_chip_uninit(void *data)
> > >  {
> > >  	struct bmi160_data *bmi_data = data;
> > > +	struct device *dev = regmap_get_device(bmi_data->regmap);
> > > +	int ret;
> > >  
> > >  	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
> > >  	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
> > > +
> > > +	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
> > > +				     bmi_data->supplies);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to disable regulators: %d\n", ret);
> > > +	}  
> > No need for brackets around a 1 line if block
> >   
> 
> Thank you, I didn't noticed that :-)
> 
> > 	if (ret)
> > 		dev_err(dev, "failed to disable regulators: %d\n", ret);
> >   
> > >  }
> > >  
> > >  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > > @@ -815,6 +830,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > >  	dev_set_drvdata(dev, indio_dev);
> > >  	data->regmap = regmap;
> > >  
> > > +	data->supplies[0].supply = "vdd";
> > > +	data->supplies[1].supply = "vddio";
> > > +	ret = devm_regulator_bulk_get(dev,
> > > +				      ARRAY_SIZE(data->supplies),
> > > +				      data->supplies);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > >  	ret = bmi160_chip_init(data, use_spi);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -853,6 +878,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > >  }
> > >  EXPORT_SYMBOL_GPL(bmi160_core_probe);
> > >  
> > > -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> > > +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");  
> > 
> > Good fix but shouldn't be in this patch.   Put it a separate patch on it's own.
> >   
> 
> Ok will separate this fix into another patch, thank you!
> 
> > >  MODULE_DESCRIPTION("Bosch BMI160 driver");
> > >  MODULE_LICENSE("GPL v2");  
> > 
> >   
> 
> Best regards,
> Jonathan Albrieux


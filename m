Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3552F007A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 15:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbhAIOWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 09:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbhAIOWX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 09:22:23 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F0A23A1C;
        Sat,  9 Jan 2021 14:21:40 +0000 (UTC)
Date:   Sat, 9 Jan 2021 14:21:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] iio: magnetometer: bmc150: Add rudimentary
 regulator support
Message-ID: <20210109142136.7057260c@archlinux>
In-Reply-To: <X/WR+/PDhLRk7Yek@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
        <20201202093322.77114-2-stephan@gerhold.net>
        <X/WR+/PDhLRk7Yek@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 Jan 2021 11:33:31 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> Hi Jonathan,
> 
> On Wed, Dec 02, 2020 at 10:33:20AM +0100, Stephan Gerhold wrote:
> > BMC150 needs VDD and VDDIO regulators that might need to be explicitly
> > enabled. Add some rudimentary support to obtain and enable these
> > regulators during probe() and disable them during remove()
> > or on the error path.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>  
> 
> I think we forgot about the bmc150_magn part of this patch series. :)
> 
> This is likely my mistake - I only sent a v2 for the bmg160 part of this
> patch series, but not for the bmc150_magn part (since it's not affected
> by the problem you mentioned for the bmg160 patch). Sorry for the confusion!
> 
> Should I re-send the bmc150_magn part (with or without some changes)?
Please resend. Don't think any changes are needed.

I tend to use the b4 tool to apply patches. I can pick individual
patches out of a series, but it's much easier to just pick up a full
series once it's ready.

Thanks,

Jonathan

> 
> Thanks!
> Stephan
> 
> > ---
> > This is mostly copy-paste of
> > 079c1c3f2082 ("iio: accel: bmc150-accel: Add rudimentary regulator support")
> > from Linus Walleij but for the BMC150 magnetometer driver.
> > ---
> >  drivers/iio/magnetometer/bmc150_magn.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index fa09fcab620a..b2f3129e1b4f 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include "bmc150_magn.h"
> >  
> > @@ -135,6 +136,7 @@ struct bmc150_magn_data {
> >  	 */
> >  	struct mutex mutex;
> >  	struct regmap *regmap;
> > +	struct regulator_bulk_data regulators[2];
> >  	struct iio_mount_matrix orientation;
> >  	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
> >  	s32 buffer[6];
> > @@ -692,12 +694,24 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
> >  	int ret, chip_id;
> >  	struct bmc150_magn_preset preset;
> >  
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> > +				    data->regulators);
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "Failed to enable regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +	/*
> > +	 * 3ms power-on time according to datasheet, let's better
> > +	 * be safe than sorry and set this delay to 5ms.
> > +	 */
> > +	msleep(5);
> > +
> >  	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
> >  					 false);
> >  	if (ret < 0) {
> >  		dev_err(data->dev,
> >  			"Failed to bring up device from suspend mode\n");
> > -		return ret;
> > +		goto err_regulator_disable;
> >  	}
> >  
> >  	ret = regmap_read(data->regmap, BMC150_MAGN_REG_CHIP_ID, &chip_id);
> > @@ -752,6 +766,8 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
> >  
> >  err_poweroff:
> >  	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> > +err_regulator_disable:
> > +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> >  	return ret;
> >  }
> >  
> > @@ -867,6 +883,13 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> >  	data->irq = irq;
> >  	data->dev = dev;
> >  
> > +	data->regulators[0].supply = "vdd";
> > +	data->regulators[1].supply = "vddio";
> > +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
> > +				      data->regulators);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to get regulators\n");
> > +
> >  	ret = iio_read_mount_matrix(dev, "mount-matrix",
> >  				&data->orientation);
> >  	if (ret)
> > @@ -984,6 +1007,7 @@ int bmc150_magn_remove(struct device *dev)
> >  	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> >  	mutex_unlock(&data->mutex);
> >  
> > +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(bmc150_magn_remove);
> > -- 
> > 2.29.2
> >   


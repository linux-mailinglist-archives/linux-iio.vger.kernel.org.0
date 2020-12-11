Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91F2D7E3C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406194AbgLKSkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 13:40:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:18108 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391319AbgLKSjr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 13:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607711814;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=n0ZAmmH9D9CDGDYMnyJLYA7Il7vUH7f1aPjp9QFWHPw=;
        b=iM2DjNpjiPF/WABZUvpMocl1f9u1OYptsticEJ8v81+5nNy0M0seL8fzo3Oq/+E5bF
        Ny5oVD5nwkK2a6G0o8NNUAL1tnDFNeyOuUKqvMyStOFz4A/5UIi+VxGYD+p4cyhxxgGW
        3UC4uBkVt82ItQyNqfRobY9L6TmlFEv72mY+60bAlcILSSbsagvtw62PW198EfVK6y+z
        TIAZjXY1c1Cae0bjhazQZv7eVFYtaI7or/3Wh7pdOv7eNN9KxxDQFy0Rv7lxNN8J6Aph
        W0IHNFOfbha2unwEwVvdEdjwMxm5Q1Cg0S89JbMXIG+aKnpxOcwV0fXRLaQ2biu+7wOV
        9Zqw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8jxIczFYoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.7.1 DYNA|AUTH)
        with ESMTPSA id 409b08wBBIak4dD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 19:36:46 +0100 (CET)
Date:   Fri, 11 Dec 2020 19:36:40 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] iio: gyro: bmg160: Add rudimentary regulator support
Message-ID: <X9O8OEHSZ40OhrB/@gerhold.net>
References: <20201202093322.77114-1-stephan@gerhold.net>
 <20201202093322.77114-4-stephan@gerhold.net>
 <20201205153848.697c77a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205153848.697c77a5@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Dec 05, 2020 at 03:38:48PM +0000, Jonathan Cameron wrote:
> On Wed,  2 Dec 2020 10:33:22 +0100
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> > enabled. Add some rudimentary support to obtain and enable these
> > regulators during probe() and disable them during remove()
> > or on the error path.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> This one is a bit tricky due to the extensive use of devm_ managed
> cleanup.  Normally I'd be very fussy about ensuring remove order
> is precise reverse of probe, but in this driver it isn't quite
> already, due to that chip_init being before the interrupt allocation.
> 
> Having said that I'd rather not make it worse.  Would you mind
> using automated clean up of the regulator_enable as well via
> devm_add_action_or_reset() call?
> 

Good point, devm_add_action_or_reset() definitely looks better for this
driver. I will send a v2 with just the bmg160 part shortly.

> As a side note, should we not have more cleanup of chip_init()
> in error paths, specifically putting the device into it's suspended
> mode?  Obviously nothing to do with your patch...
> 

I'm not sure. I guess when bmg160_chip_init() fails there is some kind
of communication problem or a problem with the chip. Chances are that
putting it back into suspend mode would also fail.

But I don't really know enough about the hardware to say more. :)

I have also fixed your other comments below in v2.

Thanks!
Stephan

> 
> > ---
> >  drivers/iio/gyro/bmg160_core.c | 38 +++++++++++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index 2d5015801a75..4baa4169c5a2 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include "bmg160.h"
> >  
> >  #define BMG160_IRQ_NAME		"bmg160_event"
> > @@ -92,6 +93,7 @@
> >  
> >  struct bmg160_data {
> >  	struct regmap *regmap;
> > +	struct regulator_bulk_data regulators[2];
> >  	struct iio_trigger *dready_trig;
> >  	struct iio_trigger *motion_trig;
> >  	struct iio_mount_matrix orientation;
> > @@ -1077,14 +1079,28 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  	data->irq = irq;
> >  	data->regmap = regmap;
> >  
> > +	data->regulators[0].supply = "vdd";
> > +	data->regulators[1].supply = "vddio";
> > +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
> > +				      data->regulators);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> > +
> >  	ret = iio_read_mount_matrix(dev, "mount-matrix",
> >  				&data->orientation);
> >  	if (ret)
> >  		return ret;
> 
> Why not put regulator get and enable together?  
> 
> >  
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> > +				    data->regulators);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> 
> If you were to use devm_add_action_or_reset() and a trivial wrapper
> the disable would be automated, simplifying the error handling etc.
> 
> >  	ret = bmg160_chip_init(data);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto err_regulator_disable;
> >  
> >  	mutex_init(&data->mutex);
> >  
> > @@ -1107,28 +1123,32 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  						BMG160_IRQ_NAME,
> >  						indio_dev);
> >  		if (ret)
> > -			return ret;
> > +			goto err_regulator_disable;
> >  
> >  		data->dready_trig = devm_iio_trigger_alloc(dev,
> >  							   "%s-dev%d",
> >  							   indio_dev->name,
> >  							   indio_dev->id);
> > -		if (!data->dready_trig)
> > -			return -ENOMEM;
> > +		if (!data->dready_trig) {
> > +			ret = -ENOMEM;
> > +			goto err_regulator_disable;
> > +		}
> >  
> >  		data->motion_trig = devm_iio_trigger_alloc(dev,
> >  							  "%s-any-motion-dev%d",
> >  							  indio_dev->name,
> >  							  indio_dev->id);
> > -		if (!data->motion_trig)
> > -			return -ENOMEM;
> > +		if (!data->motion_trig) {
> > +			ret = -ENOMEM;
> > +			goto err_regulator_disable;
> > +		}
> >  
> >  		data->dready_trig->dev.parent = dev;
> >  		data->dready_trig->ops = &bmg160_trigger_ops;
> >  		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> >  		ret = iio_trigger_register(data->dready_trig);
> >  		if (ret)
> > -			return ret;
> > +			goto err_regulator_disable;
> >  
> >  		data->motion_trig->dev.parent = dev;
> >  		data->motion_trig->ops = &bmg160_trigger_ops;
> > @@ -1174,6 +1194,8 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  		iio_trigger_unregister(data->dready_trig);
> >  	if (data->motion_trig)
> >  		iio_trigger_unregister(data->motion_trig);
> > +err_regulator_disable:
> > +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> >  
> >  	return ret;
> >  }
> > @@ -1200,6 +1222,8 @@ void bmg160_core_remove(struct device *dev)
> >  	mutex_lock(&data->mutex);
> >  	bmg160_set_mode(data, BMG160_MODE_DEEP_SUSPEND);
> >  	mutex_unlock(&data->mutex);
> > +
> > +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> >  }
> >  EXPORT_SYMBOL_GPL(bmg160_core_remove);
> >  
> 

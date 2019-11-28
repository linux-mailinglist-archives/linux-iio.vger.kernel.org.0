Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616FD10C627
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 10:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK1JsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 04:48:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38583 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK1JsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 04:48:00 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaGOq-0008AB-1G; Thu, 28 Nov 2019 10:47:48 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iaGOo-0006fx-F8; Thu, 28 Nov 2019 10:47:46 +0100
Date:   Thu, 28 Nov 2019 10:47:46 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad799x: add pm_ops to disable the device
 completely
Message-ID: <20191128094746.4a57vaqcex26lwpq@pengutronix.de>
References: <20191127114857.11862-1-m.felsch@pengutronix.de>
 <f54935dbda9df19f0301208f34132bf8a27aa55c.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54935dbda9df19f0301208f34132bf8a27aa55c.camel@analog.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:46:10 up 13 days,  1:04, 23 users,  load average: 0.13, 0.11,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Ardelean,

On 19-11-28 07:46, Ardelean, Alexandru wrote:
> On Wed, 2019-11-27 at 12:48 +0100, Marco Felsch wrote:
> > 
> > The device is always in a low-power state due to the hardware design. It
> > wakes up upon a conversion request and goes back into the low-power
> > state. The pm ops are added to disable the device completely and to free
> > the regulator. Disbaling the device completely should be not that
> > notable but freeing the regulator is important. Because if it is a shared
> > power-rail the regulator won't be disabled during suspend-to-ram/disk
> > and so all devices connected to that rail keeps on.
> > 
> 
> Hey,
> 
> Just one comment.
> Sorry for not catching this earlier.
> I sometimes miss things on review.

No worries.

> Thanks
> Alex
> 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Hi,
> > 
> > this v2 contains the comments made on [1].
> > 
> > [1] https://patchwork.kernel.org/cover/11149119/
> > 
> > v2:
> > - squash patch 2 & 3
> > - call regulator_disable() unconditional during suspend()
> > - drop dev_err() messages during suspend
> > - fix error path within resume()
> > ---
> >  drivers/iio/adc/ad799x.c | 60 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 54 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index f658012baad8..89e673423e47 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -167,6 +167,21 @@ static int ad799x_read_config(struct ad799x_state
> > *st)
> >  	}
> >  }
> >  
> > +static int ad799x_update_config(struct ad799x_state *st, u16 config)
> > +{
> > +	int ret;
> > +
> > +	ret = ad799x_write_config(st, config);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = ad799x_read_config(st);
> > +	if (ret < 0)
> > +		return ret;
> > +	st->config = ret;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * ad799x_trigger_handler() bh of trigger launched polling to ring
> > buffer
> >   *
> > @@ -808,13 +823,9 @@ static int ad799x_probe(struct i2c_client *client,
> >  	indio_dev->channels = st->chip_config->channel;
> >  	indio_dev->num_channels = chip_info->num_channels;
> >  
> > -	ret = ad799x_write_config(st, st->chip_config->default_config);
> > -	if (ret < 0)
> > -		goto error_disable_vref;
> > -	ret = ad799x_read_config(st);
> > -	if (ret < 0)
> > +	ret = ad799x_update_config(st, st->chip_config->default_config);
> > +	if (ret)
> >  		goto error_disable_vref;
> > -	st->config = ret;
> >  
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >  		&ad799x_trigger_handler, NULL);
> > @@ -864,6 +875,42 @@ static int ad799x_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused ad799x_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct ad799x_state *st = iio_priv(indio_dev);
> > +
> > +	regulator_disable(st->vref);
> > +	regulator_disable(st->reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused ad799x_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct ad799x_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regulator_enable(st->reg);
> > +	if (ret) {
> > +		dev_err(dev, "Unable to enable vcc regulator\n");
> > +		return ret;
> > +	}
> > +	ret = regulator_enable(st->vref);
> > +	if (ret) {
> > +		regulator_disable(st->reg);
> > +		dev_err(dev, "Unable to enable vref regulator\n");
> > +		return ret;
> > +	}
> > +	/* resync config */
> > +	ad799x_update_config(st, st->config);
> > +
> 
> [Again] Sorry for not catching this earlier.
> 
> Is it worth doing an error check here?
> Maybe
> 
> ret = ad799x_update_config(st, st->config);
> if (ret < 0) {
>    regulator_disable(st->vref);
>    regulator_disable(st->reg);
>    return ret;
> }

Good point, I will change that.

Regards,
  Marco 

> 
> 
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
> > +
> >  static const struct i2c_device_id ad799x_id[] = {
> >  	{ "ad7991", ad7991 },
> >  	{ "ad7995", ad7995 },
> > @@ -881,6 +928,7 @@ MODULE_DEVICE_TABLE(i2c, ad799x_id);
> >  static struct i2c_driver ad799x_driver = {
> >  	.driver = {
> >  		.name = "ad799x",
> > +		.pm = &ad799x_pm_ops,
> >  	},
> >  	.probe = ad799x_probe,
> >  	.remove = ad799x_remove,

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

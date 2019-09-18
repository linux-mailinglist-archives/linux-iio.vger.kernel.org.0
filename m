Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85828B5F56
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfIRIiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 04:38:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfIRIiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 04:38:05 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVTF-00008g-Lu; Wed, 18 Sep 2019 10:37:53 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVTE-0007Wm-DO; Wed, 18 Sep 2019 10:37:52 +0200
Date:   Wed, 18 Sep 2019 10:37:52 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Message-ID: <20190918083752.nj5vtmixzvisiukn@pengutronix.de>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
 <20190917160925.9791-4-m.felsch@pengutronix.de>
 <b09de11deacc5486fefdab0e69b94d14596e541f.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09de11deacc5486fefdab0e69b94d14596e541f.camel@analog.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:27:47 up 123 days, 14:45, 70 users,  load average: 0.00, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alex,

On 19-09-18 06:59, Ardelean, Alexandru wrote:
> On Tue, 2019-09-17 at 18:09 +0200, Marco Felsch wrote:
> > [External]
> > 
> 
> Comments inline
> 
> > The device is always in a low-power state due to the hardware design. It
> > wakes up upon a conversion request and goes back into the low-power
> > state. The pm ops are added to disable the device completely and to free
> > the regulator. Disbaling the device completely should be not that
> > notable but freeing the regulator is important. Because if it is a shared
> > power-rail the regulator won't be disabled during suspend-to-ram/disk
> > and so all devices connected to that rail keeps on.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/iio/adc/ad799x.c | 45 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index af5a2de9c22f..32d242ecb12c 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -875,6 +875,50 @@ static int ad799x_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused ad799x_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct ad799x_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regulator_disable(st->vref);
> > +	if (ret) {
> > +		dev_err(dev, "Unable to disable vref regulator\n");
> 
> Exiting here will leave st->reg undisabled.
> I don't know if this should do more that just disable the regulators.
> 
> I am not sure if we should print anything here if regulator_disable()
> errors. Usually (in this case) the system would go to sleep, and that's it.
> Errors would be more important in the ad799x_resume() case (than here).
> 
> But, if these messages are important, you could maybe print with
> "dev_warn()" instead of "dev_err()".
> I am not sure if errors when disabling regulators (in this case here)
> classify as errors (instead of warnings).

Yes, you're right. I will change that in such a case to disable the
regulators without checking the return val and I will change dev_err to
dev_dbg. IMHO a developer should be informed about such a case at least
during a debug session. This will help them to limit the possible
failures why a voltage rail can't be disabled.

Regards,
  Marco

> 
> > +		return ret;
> > +	}
> > +	ret = regulator_disable(st->reg);
> > +	if (ret) {
> > > +		dev_err(dev, "Unable to disable vcc regulator\n");
> > +		return ret;
> > +	}
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
> 
> Should there be a "regulator_disable(st->reg);" call here ?
> 
> > +		dev_err(dev, "Unable to enable vref regulator\n");
> > +		return ret;
> > +	}
> > +	/* resync config */
> > +	ad799x_update_config(st, st->config);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);
> > +
> >  static const struct i2c_device_id ad799x_id[] = {
> >  	{ "ad7991", ad7991 },
> >  	{ "ad7995", ad7995 },
> > @@ -892,6 +936,7 @@ MODULE_DEVICE_TABLE(i2c, ad799x_id);
> >  static struct i2c_driver ad799x_driver = {
> >  	.driver = {
> >  		.name = "ad799x",
> > +		.pm = &ad799x_pm_ops,
> >  	},
> >  	.probe = ad799x_probe,
> >  	.remove = ad799x_remove,

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0711D115698
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLFRgr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFRgr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:36:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141E621823;
        Fri,  6 Dec 2019 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575653806;
        bh=hnHK+EpI6z5B0S+9TWQxzTS+ZvDPhsqP7E3jjnQJnmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dKJaz29+MXzcceDCOlBN3xHKeYI+MCZo50gH1tJtCFm917ik9Fq2jpXp8JY53ro4L
         HRc4kBgn5N+OkwHI7LRH397RhEIG0ulXbUxq0efpDnKapAhKmL8/PPExMPNrtkVA4Z
         291CQX3XqQCUk8lbv02+GP1RNzyUzBkRaeu7e0ag=
Date:   Fri, 6 Dec 2019 17:36:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3] iio: adc: ad799x: add pm_ops to disable the device
 completely
Message-ID: <20191206173641.03b4d77a@archlinux>
In-Reply-To: <0c8fadc8ba308d19d44a4f4c9fa53dcedde5c047.camel@analog.com>
References: <20191129165314.18829-1-m.felsch@pengutronix.de>
        <20191201211153.6dae6f1a@archlinux>
        <0c8fadc8ba308d19d44a4f4c9fa53dcedde5c047.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 06:26:21 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-12-01 at 21:11 +0000, Jonathan Cameron wrote:
> > On Fri, 29 Nov 2019 17:53:14 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > The device is always in a low-power state due to the hardware design.
> > > It
> > > wakes up upon a conversion request and goes back into the low-power
> > > state. The pm ops are added to disable the device completely and to
> > > free
> > > the regulator. Disbaling the device completely should be not that
> > > notable but freeing the regulator is important. Because if it is a
> > > shared
> > > power-rail the regulator won't be disabled during suspend-to-ram/disk
> > > and so all devices connected to that rail keeps on.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>  
> > Looks fine to me, but I'd like to leave it a little longer for Alex
> > and anyone else who is interested to have time to take a look.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Thanks.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

thanks,

Jonathan

> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > Hi,
> > > 
> > > this v3 contains the comments made on [1].
> > > 
> > > [1] https://www.spinics.net/lists/linux-iio/msg48135.html
> > > 
> > > Changelog:
> > > v3:
> > > - add resync error check during resume
> > > 
> > > v2:
> > > - squash patch 2 & 3
> > > - call regulator_disable() unconditional during suspend()
> > > - drop dev_err() messages during suspend
> > > - fix error path within resume()
> > > ---
> > >  drivers/iio/adc/ad799x.c | 66 ++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 60 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > > index f658012baad8..ef013af1aec0 100644
> > > --- a/drivers/iio/adc/ad799x.c
> > > +++ b/drivers/iio/adc/ad799x.c
> > > @@ -167,6 +167,21 @@ static int ad799x_read_config(struct ad799x_state
> > > *st)
> > >  	}
> > >  }
> > >  
> > > +static int ad799x_update_config(struct ad799x_state *st, u16 config)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = ad799x_write_config(st, config);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	ret = ad799x_read_config(st);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	st->config = ret;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * ad799x_trigger_handler() bh of trigger launched polling to ring
> > > buffer
> > >   *
> > > @@ -808,13 +823,9 @@ static int ad799x_probe(struct i2c_client *client,
> > >  	indio_dev->channels = st->chip_config->channel;
> > >  	indio_dev->num_channels = chip_info->num_channels;
> > >  
> > > -	ret = ad799x_write_config(st, st->chip_config->default_config);
> > > -	if (ret < 0)
> > > -		goto error_disable_vref;
> > > -	ret = ad799x_read_config(st);
> > > -	if (ret < 0)
> > > +	ret = ad799x_update_config(st, st->chip_config->default_config);
> > > +	if (ret)
> > >  		goto error_disable_vref;
> > > -	st->config = ret;
> > >  
> > >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > >  		&ad799x_trigger_handler, NULL);
> > > @@ -864,6 +875,48 @@ static int ad799x_remove(struct i2c_client
> > > *client)
> > >  	return 0;
> > >  }
> > >  
> > > +static int __maybe_unused ad799x_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > +	struct ad799x_state *st = iio_priv(indio_dev);
> > > +
> > > +	regulator_disable(st->vref);
> > > +	regulator_disable(st->reg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused ad799x_resume(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > +	struct ad799x_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	ret = regulator_enable(st->reg);
> > > +	if (ret) {
> > > +		dev_err(dev, "Unable to enable vcc regulator\n");
> > > +		return ret;
> > > +	}
> > > +	ret = regulator_enable(st->vref);
> > > +	if (ret) {
> > > +		regulator_disable(st->reg);
> > > +		dev_err(dev, "Unable to enable vref regulator\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* resync config */
> > > +	ret = ad799x_update_config(st, st->config);
> > > +	if (ret) {
> > > +		regulator_disable(st->vref);
> > > +		regulator_disable(st->reg);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend,
> > > ad799x_resume);
> > > +
> > >  static const struct i2c_device_id ad799x_id[] = {
> > >  	{ "ad7991", ad7991 },
> > >  	{ "ad7995", ad7995 },
> > > @@ -881,6 +934,7 @@ MODULE_DEVICE_TABLE(i2c, ad799x_id);
> > >  static struct i2c_driver ad799x_driver = {
> > >  	.driver = {
> > >  		.name = "ad799x",
> > > +		.pm = &ad799x_pm_ops,
> > >  	},
> > >  	.probe = ad799x_probe,
> > >  	.remove = ad799x_remove,  


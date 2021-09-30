Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99041E39B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 00:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbhI3WEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 18:04:20 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38109 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhI3WEU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Sep 2021 18:04:20 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7798C240007;
        Thu, 30 Sep 2021 22:02:35 +0000 (UTC)
Date:   Fri, 1 Oct 2021 00:02:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] iio: adc: nau7802: convert probe to full device-managed
Message-ID: <YVYz+rY9euHC4lb4@piout.net>
References: <20210926154932.3287590-1-aardelean@deviqon.com>
 <20210930171023.2bf5a414@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930171023.2bf5a414@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/09/2021 17:10:23+0100, Jonathan Cameron wrote:
> On Sun, 26 Sep 2021 18:49:32 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
> 
> > This is a trivial conversion to device-managed functions.
> > The mutex_destroy() calls are redundant, as the data will be free'd anyway.
> > 
> > And the IRQ and IIO register functions both have device-managed
> > equivalents.
> > 
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> 
> +CC Maxime and Alexandre.
> 
> Looks simple enough to me that I won't wait on their replies to queue it up.
> Obviously feedback welcome though!
> 
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to see if it can find stuff we missed.
> 

This seems good to me too
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/adc/nau7802.c | 50 +++++++--------------------------------
> >  1 file changed, 9 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> > index bb70b51d25b1..976c235f3079 100644
> > --- a/drivers/iio/adc/nau7802.c
> > +++ b/drivers/iio/adc/nau7802.c
> > @@ -428,8 +428,6 @@ static int nau7802_probe(struct i2c_client *client,
> >  
> >  	st = iio_priv(indio_dev);
> >  
> > -	i2c_set_clientdata(client, indio_dev);
> > -
> >  	indio_dev->name = dev_name(&client->dev);
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->info = &nau7802_info;
> > @@ -495,13 +493,13 @@ static int nau7802_probe(struct i2c_client *client,
> >  	 * will enable them back when we will need them..
> >  	 */
> >  	if (client->irq) {
> > -		ret = request_threaded_irq(client->irq,
> > -				NULL,
> > -				nau7802_eoc_trigger,
> > -				IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> > -				IRQF_NO_AUTOEN,
> > -				client->dev.driver->name,
> > -				indio_dev);
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL,
> > +						nau7802_eoc_trigger,
> > +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> > +						IRQF_NO_AUTOEN,
> > +						client->dev.driver->name,
> > +						indio_dev);
> >  		if (ret) {
> >  			/*
> >  			 * What may happen here is that our IRQ controller is
> > @@ -526,7 +524,7 @@ static int nau7802_probe(struct i2c_client *client,
> >  		ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_CTRL2,
> >  					  NAU7802_CTRL2_CRS(st->sample_rate));
> >  		if (ret)
> > -			goto error_free_irq;
> > +			return ret;
> >  	}
> >  
> >  	/* Setup the ADC channels available on the board */
> > @@ -536,36 +534,7 @@ static int nau7802_probe(struct i2c_client *client,
> >  	mutex_init(&st->lock);
> >  	mutex_init(&st->data_lock);
> >  
> > -	ret = iio_device_register(indio_dev);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "Couldn't register the device.\n");
> > -		goto error_device_register;
> > -	}
> > -
> > -	return 0;
> > -
> > -error_device_register:
> > -	mutex_destroy(&st->lock);
> > -	mutex_destroy(&st->data_lock);
> > -error_free_irq:
> > -	if (client->irq)
> > -		free_irq(client->irq, indio_dev);
> > -
> > -	return ret;
> > -}
> > -
> > -static int nau7802_remove(struct i2c_client *client)
> > -{
> > -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > -	struct nau7802_state *st = iio_priv(indio_dev);
> > -
> > -	iio_device_unregister(indio_dev);
> > -	mutex_destroy(&st->lock);
> > -	mutex_destroy(&st->data_lock);
> > -	if (client->irq)
> > -		free_irq(client->irq, indio_dev);
> > -
> > -	return 0;
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >  
> >  static const struct i2c_device_id nau7802_i2c_id[] = {
> > @@ -582,7 +551,6 @@ MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
> >  
> >  static struct i2c_driver nau7802_driver = {
> >  	.probe = nau7802_probe,
> > -	.remove = nau7802_remove,
> >  	.id_table = nau7802_i2c_id,
> >  	.driver = {
> >  		   .name = "nau7802",
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

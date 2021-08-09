Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0721C3E4D2E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhHITk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 15:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234135AbhHITk0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Aug 2021 15:40:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3399761019;
        Mon,  9 Aug 2021 19:40:03 +0000 (UTC)
Date:   Mon, 9 Aug 2021 20:42:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Liam Beguin" <liambeguin@gmail.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
Message-ID: <20210809204253.357f97b2@jic23-huawei>
In-Reply-To: <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
        <20210808015659.2955443-4-liambeguin@gmail.com>
        <20210808173630.5c384a4b@jic23-huawei>
        <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
 > +
> > >  static int ad7949_spi_probe(struct spi_device *spi)
> > >  {
> > >  	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> > >  	struct device *dev = &spi->dev;
> > >  	const struct ad7949_adc_spec *spec;
> > >  	struct ad7949_adc_chip *ad7949_adc;
> > > +	struct ad7949_channel *ad7949_chan;
> > > +	struct fwnode_handle *child;
> > >  	struct iio_dev *indio_dev;
> > > +	int mode;
> > > +	u32 tmp;
> > >  	int ret;
> > > +	int i;
> > >  
> > >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
> > >  	if (!indio_dev) {
> > > @@ -343,16 +383,82 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
> > > +	/* Setup external voltage ref, buffered? */
> > > +	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
> > >  	if (IS_ERR(ad7949_adc->vref)) {
> > > -		dev_err(dev, "fail to request regulator\n");
> > > -		return PTR_ERR(ad7949_adc->vref);
> > > +		ret = PTR_ERR(ad7949_adc->vref);
> > > +		if (ret != -ENODEV)
> > > +			return ret;
> > > +		/* unbuffered? */
> > > +		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> > > +		if (IS_ERR(ad7949_adc->vref)) {
> > > +			ret = PTR_ERR(ad7949_adc->vref);
> > > +			if (ret != -ENODEV)
> > > +				return ret;
> > > +			/* Internal then */
> > > +			mode = AD7949_CFG_VAL_REF_INT_4096;
> > > +		} else {
> > > +			mode = AD7949_CFG_VAL_REF_EXT_TEMP;
> > > +		}
> > > +	} else {
> > > +		mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
> > >  	}
> > >  
> > > -	ret = regulator_enable(ad7949_adc->vref);
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "fail to enable regulator\n");
> > > -		return ret;
> > > +	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> > > +		ret = regulator_enable(ad7949_adc->vref);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "fail to enable regulator\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
> > > +					       ad7949_adc->vref);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ad7949_adc->channels = devm_kcalloc(dev, spec->num_channels,
> > > +					    sizeof(*ad7949_adc->channels),
> > > +					    GFP_KERNEL);
> > > +	if (!ad7949_adc->channels) {
> > > +		dev_err(dev, "unable to allocate ADC channels\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	/* Initialize all channel structures */
> > > +	for (i = 0; i < spec->num_channels; i++)
> > > +		ad7949_adc->channels[i].refsel = mode;
> > > +
> > > +	/* Read channel specific information form the devicetree */
> > > +	device_for_each_child_node(dev, child) {
> > > +		ret = fwnode_property_read_u32(child, "reg", &i);
> > > +		if (ret) {
> > > +			dev_err(dev, "missing reg property in %pfw\n", child);
> > > +			fwnode_handle_put(child);
> > > +			return ret;
> > > +		}
> > > +
> > > +		ad7949_chan = &ad7949_adc->channels[i];
> > > +
> > > +		ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
> > > +		if (ret < 0 && ret != -EINVAL) {
> > > +			dev_err(dev, "invalid internal reference in %pfw\n", child);
> > > +			fwnode_handle_put(child);
> > > +			return ret;
> > > +		}  
> 
> Hi Jonathan,
> 
> >
> > So if we are using external voltage, then we'd not expect this to exist.
> > ret != -EINVAL should deal with that. However, we then hit the following
> > switch
> > and temp isn't set to an appropriate value so we get the error.
> >
> > Am I missing something?  
> 
> You're right that using an external reference, will cause this to fail.
> My apologies, I've done a poor job of testing the last two revisions of
> this patch. I'll do better.
> 
> Since a regulator is also required when we're using an external source,
> I'll add a check for that. Something like this:
> 
> 	ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
> 	if (ret == -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> 		continue;
> 	} else if (ret < 0) {
> 		dev_err(dev, "invalid voltage reference in %pfw\n", child);
> 		fwnode_handle_put(child);
> 		return ret;
> 	}

Makes sense.

> 
> Given that we can now have a different scale for each channel based on
> the vref source, should BIT(IIO_CHAN_INFO_SCALE) be moved to
> .info_mask_separate in the channel definition?
Yes, good point.

Hopefully no one will notice the ABI change *crosses fingers*.

Jonathan

> 
> Thanks,
> Liam
> 
> >  
> > > +
> > > +		switch (tmp) {
> > > +		case 2500000:
> > > +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
> > > +			break;
> > > +		case 4096000:
> > > +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
> > > +			break;
> > > +		default:
> > > +			dev_err(dev, "unsupported internal voltage reference\n");
> > > +			fwnode_handle_put(child);
> > > +			return -EINVAL;
> > > +		}
> > >  	}
> > >  
> > >  	mutex_init(&ad7949_adc->lock);
> > > @@ -373,7 +479,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > >  
> > >  err:
> > >  	mutex_destroy(&ad7949_adc->lock);
> > > -	regulator_disable(ad7949_adc->vref);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -385,7 +490,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
> > >  
> > >  	iio_device_unregister(indio_dev);
> > >  	mutex_destroy(&ad7949_adc->lock);
> > > -	regulator_disable(ad7949_adc->vref);
> > >  
> > >  	return 0;
> > >  }  
> 


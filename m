Return-Path: <linux-iio+bounces-11654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA169B6DC3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0421F22B19
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379E1EB9FD;
	Wed, 30 Oct 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCTwIZne"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877D199FB1;
	Wed, 30 Oct 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320523; cv=none; b=VfVZcHQSrw7yCi9e6yK7KubRYKAJI5oXSVdzbxbozgRkqi0iR7RnABTE6gc4c+/Nb6e7V6vjphDNnfkheEZMHVYqTlOt9Lhx3lymKWuf5Qap8jfhcEFW/4+E5GIXn7Jk8N8elYW+DfYLcbIJzRGi6HjPKOFu3myubWhp6SDOLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320523; c=relaxed/simple;
	bh=43ROIMQBtkT2b268XPhwFJi+beswuD92eF7qUKl5Q/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhqdbxTJlrLl5SVbApCdCCLK/9OMWq+xpeWxids8qi9aWYQ2P2LMQ6opmbGdKJGomGDWq8WyIj+Sq0/n5MRSea6cKhXbyGdF16Zo2vB/9RW5s9UL2zwz3CEWrR9/LW3oTzoE7UKbAwkYFexNuugtUh/ZL1ydNoCVmNSORak0k3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCTwIZne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB1C4CECE;
	Wed, 30 Oct 2024 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730320523;
	bh=43ROIMQBtkT2b268XPhwFJi+beswuD92eF7qUKl5Q/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCTwIZne2Hfvnx7M6XgPeK7vJ6cHDOaFj3Lj0xEYYQXD0Q4mLjvXlgzg1I7OybtXU
	 w7rkuKRA8szqfRNB3eS18YQ2Lba2U2JZ4Vx5r8VwMwTOIS98b/Rb2DvSPIKHtw0Qj9
	 /L57aRPc3juIidentFXooBoQDE5v2FQeS3tFNz4I+jGjZX2A8V/D3HeyxxvsA9zxYB
	 FHgVwf+dH8/WmZR9lHRC8Pi1L9hGLfjQEEXYqzH/MPOl4yTX76saAW7pbj2jaqj8AM
	 b2lDsFlZzYH0RWYBEq7rP5s4koPx2Tlkmx7r8D5C/n0Pf/VmPZmA5Zqx6vZA3wq78J
	 HN8f3hlRoEnAg==
Date: Wed, 30 Oct 2024 20:35:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: chemical: bme680: add power management
Message-ID: <20241030203514.349d8142@jic23-huawei>
In-Reply-To: <ZyF8vtLiVUEHojl4@vamoirid-laptop>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-14-vassilisamir@gmail.com>
	<20241027103013.06daac42@jic23-huawei>
	<ZyF8vtLiVUEHojl4@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +
> > >  int bme680_core_probe(struct device *dev, struct regmap *regmap,
> > >  		      const char *name)
> > >  {
> > > @@ -1164,15 +1231,60 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
> > >  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > >  					      iio_pollfunc_store_time,
> > >  					      bme680_trigger_handler,
> > > -					      NULL);
> > > +					      &bme680_buffer_setup_ops);
> > >  	if (ret)
> > >  		return dev_err_probe(dev, ret,
> > >  				     "iio triggered buffer setup failed\n");
> > >  
> > > +	/* Enable runtime PM */
> > > +	pm_runtime_get_noresume(dev);
> > > +	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_set_active(dev);
> > > +	ret = devm_pm_runtime_enable(dev);  
> > 
> > Take a look at what this unwinds in the devm handler. You don't need to do
> > as much (or possibly anything) yourself.
> > 
> >   
> 
> Well, in general what I see that could probably be dropped here is the
> extra add_action_or_reset because of the devm_*. About the functions
> get_noresume() and put(), I feel that they could be dropped as well
> because the device registration will happen well before the autosuspend
> delay, but does it make sense to depend on something like this?

If you haven't enabled runtime pm yet all you need to do is set up the
current state  Shouldn't need the get etc as you don't care if it powers
down here anyway as you aren't talking to the device.
> 
> Cheers,
> Vasilis
> 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_put(dev);
> > > +
> > > +	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	return devm_iio_device_register(dev, indio_dev);
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
> > >  
> > > +static int bme680_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct bme680_data *data = iio_priv(indio_dev);
> > > +
> > > +	return regulator_bulk_disable(BME680_NUM_SUPPLIES, data->supplies);
> > > +}
> > > +
> > > +static int bme680_runtime_resume(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct bme680_data *data = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	fsleep(BME680_STARTUP_TIME_US);
> > > +
> > > +	ret = bme680_chip_config(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return bme680_gas_config(data);
> > > +}
> > > +
> > > +EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
> > > +			  bme680_runtime_resume, NULL);
> > > +
> > >  MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> > >  MODULE_DESCRIPTION("Bosch BME680 Driver");
> > >  MODULE_LICENSE("GPL v2");  
> >   



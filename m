Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4149F19E5EE
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDDOsy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgDDOsy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:48:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BC620731;
        Sat,  4 Apr 2020 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586011732;
        bh=Ml/kgPI9HrGjh2SgU+OdoR1GK0opQt5FXqJGCZYnGek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vlmdQIbbjOGNsY8qqY3VIJYV/wODRbE5F7tcoL9uQjP6IslmDn7pcbSMvr2sTnmnY
         mUSEe6CQVMN0dNcYtj+hyldCovHc2icFomj0FfMpXysBIuxZMAPYK4nsbbLiX73bza
         vLtneYxk2NHprPXDHsEq2kRKHpf5/K9JlZ/KX7hA=
Date:   Sat, 4 Apr 2020 15:48:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v5 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20200404154847.62a4a35e@archlinux>
In-Reply-To: <51d63f6b-a561-88f3-3718-b04539a7b3be@topic.nl>
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
        <20200324080309.12171-2-mike.looijmans@topic.nl>
        <20200328162044.7b9992c3@archlinux>
        <51d63f6b-a561-88f3-3718-b04539a7b3be@topic.nl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 10:07:00 +0200
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 28-03-2020 17:20, Jonathan Cameron wrote:
> > On Tue, 24 Mar 2020 09:03:08 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >   
> >> The BMI088 is a combined module with both accelerometer and gyroscope.
> >> This adds the accelerometer driver support for the SPI interface.
> >> The gyroscope part is already supported by the BMG160 driver.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> > 
> > Hi Mike,
> > 
> > A few tiny things from me.
> > 
> > For the sampling frequency, I wonder if we are better off going back
> > to the list of values, but then also using the read_avail infrastructure
> > to avoid having to carry them as a string as well?  
> 
> The frequency range is just a simple power-of-two formula, so my take 
> was that a table would just be a waste of memory and resources.
> 
> A table lookup costs more resources and requires more code in this case.

True, but the table is still there be it in string form  in order
to provide the 'available' list.

For reasons of simplicity in the IIO core, the read_avail callbacks
deal with tables of numbers like was originally the case here.


> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >>
> >> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> >> index 5d91a6dda894..7ed9c82b731b 100644
> >> --- a/drivers/iio/accel/Kconfig
> >> +++ b/drivers/iio/accel/Kconfig
> >> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
> >>   	tristate
> >>   	select REGMAP_SPI
> >>   
> >> +config BMI088_ACCEL
> >> +	tristate "Bosch BMI088 Accelerometer Driver"
> >> +	select IIO_BUFFER
> >> +	select IIO_TRIGGERED_BUFFER
> >> +	select REGMAP
> >> +	select BMI088_ACCEL_SPI
> >> +	help
> >> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
> >> +
> >> +	  This is a combo module with both accelerometer and gyroscope.
> >> +	  This driver is only implementing accelerometer part, which has
> >> +	  its own address and register map.
> >> +
> >> +config BMI088_ACCEL_SPI
> >> +	tristate
> >> +	select REGMAP_SPI
> >> +  
> > 
> > Hmm. So we list this driver even if SPI is disabled.  Generally we try
> > not to do that, as it makes for lots of things to pick on devices that
> > don't actually have an SPI bus.
> > 
> > Hence, please add a depends to the first Kconfig symbol so it's hidden
> > if no SPI.  When I2C is added it can become at least one of the two.
> >   
> 
> I'm okay with a depends on SPI. Adding the I2C support is not difficult, 
> but I don't want to release something into the kernel that I cannot test.

Agreed.  Just add the depends on SPI.  I was just looking forwards to yourself
or someone else adding I2C when they do have a platform to test it.


> 
> 
> > ...
> >   
> >> +
> >> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
> >> +					int *val, int *val2)
> >> +{
> >> +	unsigned int value;
> >> +	int ret;
> >> +
> >> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> >> +			  &value);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	value &= BMI088_ACCEL_MODE_ODR_MASK;
> >> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
> >> +		*val = 12;
> >> +		*val2 = 500000;
> >> +		ret = IIO_VAL_INT_PLUS_MICRO;
> >> +	} else {
> >> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
> >> +		*val2 = 0;
> >> +		ret = IIO_VAL_INT;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
> >> +{
> >> +	unsigned int value;
> >> +
> >> +	if (val < 12 || val > 1600)
> >> +		return -EINVAL;
> >> +
> >> +	value = fls(val) + 1;  
> > 
> > This leads to some 'novel' rounding to my mind.
> > 
> > (12,16] = 12.5
> > (16,32] = 25
> > (32,64] = 50
> > (64,128] = 100
> > 
> > Generally we want to go faster if anything when talking about sampling frequencies,
> > so I'd either like to see round up or precise value matching only.  
> 
> I went for simplicity. The driver reports an "avail" range, so users 
> should not expect other values like "70" to actually work. The above is 
> the shortest inversion of the get_sample_freq function.

That's a bold assumption to make about userspace doing what it should
and checking _avail before writing crazy values.   A not entirely stupid
optimization would be to write without checking _avail and only do the
handling of that if the write fails (indicating that whatever value was
provided by some user isn't fine).


> 
> Just wanted to make it so that obvious things would work, and I feared 
> that a range would require one to spec "100.000" in decimal format just 
> because of the existence of the 12.5 value. So the driver is a bit 
> forgiving in that specifying "12" or "13" will also work.
> 
> For a more exact match I could also add something like:
> 
> if (val > 13 && (25 << (value - BMI088_ACCEL_MODE_ODR_25 ) != val)
>     return -EINVAL;
> 
> this would return -EINVAL for values like "26" or "1599".

Given the way the IIO core works, it will be perfectly happy to present
you with precise values.  If the val == 12, then check the val2 == 5
For the rest just check if the val is correct and val2 == 0.

If decimal part is not provide val2 will be equal to 0.

I'm still falling on the side of thinking a table of values is simpler,
less bug prone (because it's just a case of linear search for a match)
and if you use read_avail callback can handle that case as well without
needing to repeat values.  Memory cost of the
table is tiny 8 * 4 * 2 = 64 bytes.

It's not exactly a huge list of possibilities.

Jonathan

> 
> >   
> >> +
> >> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> >> +				  BMI088_ACCEL_MODE_ODR_MASK, value);
> >> +}
> >> +  
> > 
> > ...
> >   
> >> +
> >> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >> +				 struct iio_chan_spec const *chan,
> >> +				 int *val, int *val2, long mask)
> >> +{
> >> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		switch (chan->type) {
> >> +		case IIO_TEMP:
> >> +			return bmi088_accel_get_temp(data, val);
> >> +		case IIO_ACCEL:
> >> +			ret = iio_device_claim_direct_mode(indio_dev);
> >> +			if (ret)
> >> +				return ret;
> >> +
> >> +			ret = bmi088_accel_get_axis(data, chan, val);
> >> +			iio_device_release_direct_mode(indio_dev);
> >> +			if (ret)
> >> +				return ret;
> >> +
> >> +			return IIO_VAL_INT;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +	case IIO_CHAN_INFO_OFFSET:
> >> +		switch (chan->type) {
> >> +		case IIO_TEMP:
> >> +			/* Offset applies before scale */
> >> +			*val = BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
> >> +			return IIO_VAL_INT;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val = 0;  
> > 
> > Why?  In error paths it's not used, and it's set in the other two paths.  
> 
> will remove
> 
> >   
> >> +		switch (chan->type) {
> >> +		case IIO_TEMP:
> >> +			/* 0.125 degrees per LSB */
> >> +			*val = BMI088_ACCEL_TEMP_UNIT;
> >> +			return IIO_VAL_INT;
> >> +		case IIO_ACCEL:
> >> +			ret = regmap_read(data->regmap,
> >> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
> >> +			if (ret)
> >> +				return ret;
> >> +
> >> +			*val2 = 15 - (*val & 0x3);
> >> +			*val = 3 * 980;
> >> +
> >> +			return IIO_VAL_FRACTIONAL_LOG2;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		mutex_lock(&data->mutex);
> >> +		ret = bmi088_accel_get_sample_freq(data, val, val2);
> >> +		mutex_unlock(&data->mutex);
> >> +		return ret;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +  
> > ...
> >   
> 
> 


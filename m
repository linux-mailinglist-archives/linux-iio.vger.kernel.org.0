Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960124AB0F2
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiBFR1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 12:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBFR1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 12:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C051C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 09:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD3D2B80E5A
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 17:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA428C340E9;
        Sun,  6 Feb 2022 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644168452;
        bh=3u4GFacxlCJufTMQMHS0MWKtrxCa8gACPQfETIBKpCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kS7qfkwbl+duXM1Mvr+uhNx0xSY2sAMqqHLMjdRfXrSXL1/y7AbKDQEAQOXGO3NbK
         JQG9ZBCo9vAmEz/KLdsiO9o8tJwxeTLnxuQoZwEEv5ayMlqz9FoKfbwiGNQMA42HjX
         wBMoA6j2I6NOm8ykuZjAn2lZX5ZyWiIlgupKnPGa015uFzBXw8jMoLvJ2oHjpMRG1/
         9cLXpDZQ8HLvUHC8goE8Vs7A4a0rMH1YCoxVwePHW8nlsyshiv/ATuGA5sXBs3r1es
         +cHUMX6VT39jim/NjoTBuWRv841XCIenbkg3xQte+O+rozH8tKPIaCOfb6qqmvQSbR
         FNZSsnntef1PQ==
Date:   Sun, 6 Feb 2022 17:34:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/17] staging:iio:adc:ad7280a: Switch to standard
 event control
Message-ID: <20220206173403.0a30d3f5@jic23-huawei>
In-Reply-To: <YbjXTPr3vjcCreAC@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-7-jic23@kernel.org>
        <YbjXTPr3vjcCreAC@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Dec 2021 14:41:32 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Neat, though some bits can be improved after moving out of staging.
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This driver had a slightly non standard events ABI but there seems
> > to be no reason for not doing it with the core support for rising and
> > falling events on the two types of channels.
> > 
> > In theory the events on different daisy chained chips could be at
> > different levels, but the driver has never supported this and it doesn't
> > seem likely to be used so let us ignore that option.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 198 ++++++++++++++----------------
> >  1 file changed, 95 insertions(+), 103 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 158a792c0bf8..0aeca39388cf 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -551,18 +551,34 @@ static const struct attribute_group ad7280_attrs_group = {
> >  	.attrs = ad7280_attributes,
> >  };
> >  
> > +static const struct iio_event_spec ad7280_events[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> > +	}, {
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +};
> > +
> >  static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
> >  {
> >  	chan->type = IIO_VOLTAGE;
> >  	chan->differential = 1;
> >  	chan->channel = i;
> >  	chan->channel2 = chan->channel + 1;
> > +	chan->event_spec = ad7280_events;
> > +	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> >  }
> >  
> >  static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
> >  {
> >  	chan->type = IIO_TEMP;
> >  	chan->channel = i;
> > +	chan->event_spec = ad7280_events;
> > +	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> >  }
> >  
> >  static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
> > @@ -732,88 +748,105 @@ static int ad7280_attr_init(struct ad7280_state *st)
> >  	return 0;
> >  }
> >  
> > -static ssize_t ad7280_read_channel_config(struct device *dev,
> > -					  struct device_attribute *attr,
> > -					  char *buf)
> > +static int ad7280a_read_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info, int *val, int *val2)
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ad7280_state *st = iio_priv(indio_dev);
> > -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > -	unsigned int val;
> >  
> > -	switch (this_attr->address) {
> > -	case AD7280A_CELL_OVERVOLTAGE_REG:
> > -		val = 1000 + (st->cell_threshhigh * 1568) / 100;
> > -		break;
> > -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> > -		val = 1000 + (st->cell_threshlow * 1568) / 100;
> > -		break;
> > -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> > -		val = (st->aux_threshhigh * 196) / 10;
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			*val = 1000 + (st->cell_threshhigh * 1568L) / 100;  
> Shouldn't the range multiplier for voltage threshhold be 1562L?
> This of course has nothing to do with this patch and should make no practical
> difference so can be changed after moving out of staging.
I'm going to take a guess at what is going on here having cynically just
accepted the original value at face value.
Range is stated as 1 to 4 V and 8 bits.
Now if we assume the range is inclusive, then first value 0 is taken
for 1V, so range is 
1000 + 255 * 15.68 = 4998.4mV
vs
1000 + 255 * 15.62 = 4983.1mv

So all depends on whether the range is inclusive or not...
"The AD7280A allows the user to set the overvoltage threshold to a value from
1 V to 5 V. The resolution of the overvoltage threshold is eight
bits, that is, 16 mV."

So who knows! I'm guessing this isn't very precise anyway given the datasheet
rounds it to 16mV.

> 
> > +			return IIO_VAL_INT;
> > +		case IIO_EV_DIR_FALLING:
> > +			*val = 1000 + (st->cell_threshlow * 1568L) / 100;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> >  		break;
> > -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> > -		val = (st->aux_threshlow * 196) / 10;
> > +	case IIO_TEMP:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			*val = ((st->aux_threshhigh) * 196L) / 10;
> > +			return IIO_VAL_INT;
> > +		case IIO_EV_DIR_FALLING:
> > +			*val = (st->aux_threshlow * 196L) / 10;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > -
> > -	return sprintf(buf, "%u\n", val);
> >  }
> >  
> > -static ssize_t ad7280_write_channel_config(struct device *dev,
> > -					   struct device_attribute *attr,
> > -					   const char *buf,
> > -					   size_t len)
> > +static int ad7280a_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ad7280_state *st = iio_priv(indio_dev);
> > -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > -
> > -	long val;
> > +	unsigned int addr;
> > +	long value;
> >  	int ret;
> >  
> > -	ret = kstrtol(buf, 10, &val);
> > -	if (ret)
> > -		return ret;
> > -
> > -	switch (this_attr->address) {
> > -	case AD7280A_CELL_OVERVOLTAGE_REG:
> > -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> > -		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> > -		break;
> > -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> > -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> > -		val = (val * 10) / 196; /* LSB 19.6mV */
> > -		break;
> > -	default:
> > -		return -EFAULT;
> > -	}
> > -
> > -	val = clamp(val, 0L, 0xFFL);
> > +	if (val2 != 0)
> > +		return -EINVAL;
> >  
> >  	mutex_lock(&st->lock);
> > -	switch (this_attr->address) {
> > -	case AD7280A_CELL_OVERVOLTAGE_REG:
> > -		st->cell_threshhigh = val;
> > -		break;
> > -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> > -		st->cell_threshlow = val;
> > -		break;
> > -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> > -		st->aux_threshhigh = val;
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> > +		value = clamp(value, 0L, 0xFFL);
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			addr = AD7280A_CELL_OVERVOLTAGE_REG;
> > +			st->cell_threshhigh = value;
> > +			break;
> > +		case IIO_EV_DIR_FALLING:
> > +			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
> > +			st->cell_threshlow = value;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> >  		break;
> > -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> > -		st->aux_threshlow = val;
> > +	case IIO_TEMP:
> > +		value = (val * 10) / 196; /* LSB 19.6mV */
> > +		value = clamp(value, 0L, 0xFFL);
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
> > +			st->aux_threshhigh = val;
> > +			break;
> > +		case IIO_EV_DIR_FALLING:
> > +			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
> > +			st->aux_threshlow = val;
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> >  		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto err_unlock;
> >  	}
> >  
> > -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> > -			   this_attr->address, 1, val);
> > -
> > +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr, 1, val);  
> Can't ad7280_state end up with inconsistent threshold value if device write
> fails for some reason?
> Should work well on normal operation so I guess there's no need to change it
> before graduation.

Maybe... It's more than possible that the write succeeded even if we got
an error.  However, from a purely nice code form point of view I agree with you
we should not really be setting the cached value until this has succeeded.

Given the change is straight forward (just move the write up and replicate
it in each entry in the switch statements before the = value; part
I'll do that now and add a note to the patch description.

> 
> > +err_unlock:
> >  	mutex_unlock(&st->lock);
> >  
> > -	return ret ? ret : len;
> > +	return ret;
> >  }
> >  
> >  static irqreturn_t ad7280_event_handler(int irq, void *private)
> > @@ -875,48 +908,6 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -/* Note: No need to fix checkpatch warning that reads:
> > - *	CHECK: spaces preferred around that '-' (ctx:VxV)
> > - * The function argument is stringified and doesn't need a fix
> > - */
> > -static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > -			     in_voltage-voltage_thresh_low_value,
> > -			     0644,
> > -			     ad7280_read_channel_config,
> > -			     ad7280_write_channel_config,
> > -			     AD7280A_CELL_UNDERVOLTAGE_REG);
> > -
> > -static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > -			     in_voltage-voltage_thresh_high_value,
> > -			     0644,
> > -			     ad7280_read_channel_config,
> > -			     ad7280_write_channel_config,
> > -			     AD7280A_CELL_OVERVOLTAGE_REG);
> > -
> > -static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> > -		       0644,
> > -		       ad7280_read_channel_config,
> > -		       ad7280_write_channel_config,
> > -		       AD7280A_AUX_ADC_UNDERVOLTAGE_REG);
> > -
> > -static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> > -		       0644,
> > -		       ad7280_read_channel_config,
> > -		       ad7280_write_channel_config,
> > -		       AD7280A_AUX_ADC_OVERVOLTAGE_REG);
> > -
> > -static struct attribute *ad7280_event_attributes[] = {
> > -	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
> > -	&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
> > -	&iio_dev_attr_in_temp_thresh_low_value.dev_attr.attr,
> > -	&iio_dev_attr_in_temp_thresh_high_value.dev_attr.attr,
> > -	NULL,
> > -};
> > -
> > -static const struct attribute_group ad7280_event_attrs_group = {
> > -	.attrs = ad7280_event_attributes,
> > -};
> > -
> >  static int ad7280_read_raw(struct iio_dev *indio_dev,
> >  			   struct iio_chan_spec const *chan,
> >  			   int *val,
> > @@ -956,7 +947,8 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
> >  
> >  static const struct iio_info ad7280_info = {
> >  	.read_raw = ad7280_read_raw,
> > -	.event_attrs = &ad7280_event_attrs_group,
> > +	.read_event_value = &ad7280a_read_thresh,
> > +	.write_event_value = &ad7280a_write_thresh,
> >  	.attrs = &ad7280_attrs_group,
> >  };
> >  
> > -- 
> > 2.34.1
> >   


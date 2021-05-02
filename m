Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476B9370F23
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 22:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhEBUuT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 16:50:19 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:55810 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBUuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 16:50:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 6D8AC123F6E;
        Sun,  2 May 2021 22:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619988562;
        bh=fgLT4hafJG+1PqcReTS+6XQ5YhwCIqYr+5981q2LEjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=9mDIUKhZ1C4j82HdjpnaZ5eP5boBX+gNzWdAjfhGbqkanrEGnSYsLkPU2S7KMgQrg
         IApOvN/fSYVbBbn2HeQg389y+HI19eXb2iGzkUyney1YwRN/7KpIRI+eJtYwSb51cW
         hKrO+eIh0MGa6U5vobijLxe/teCVLw0ExPcQMFvVOdyrNO04grGmpFY7JVDIQ0mRU3
         Z+CEGExD5EgYp0RKvMY1ggI8KsCcmMymU37ruLRxzB9ZHPqob3WlHAvuOwHY7D8FDv
         RLuRU6Jw3U5fek6ZtzARN0PnyJRMG1thjJPQaDPRzauHonRIuOj/ySXHHd/jixiPYg
         lsJDunVWYxJBw==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bUiyfDI6_iHy; Sun,  2 May 2021 22:48:50 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 8835111FFC7;
        Sun,  2 May 2021 22:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1619988530;
        bh=fgLT4hafJG+1PqcReTS+6XQ5YhwCIqYr+5981q2LEjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4N5d11RP8HjamgV4MFVVV0+vYY3iHIe8vDCG+lwXXDEHV4AQqgcmCoGRUhjqOcQF1
         YhZ0vb1D3+FqAvksXh1qxA1v+1vZXZ+j1sS6QEJYf3IInqD9WcoYR8T60IiBXvQDTn
         3X/L3luTHkAxGybe16Ng6ROJNcd4P8kU7BqLhifdhchU1pIogMG1Nzp/zFqihJFTsM
         bHQ/uCJCGp4zpiXwUYvya8wu8JWPVmRECmaOKR70T5eJwYVQXpbWsPc0rzqC7UeHbT
         zKm+PCz6RcrORsE/mlIgdsbXKNAT1PISYzxsNmHxs6lYAM2Fg4iqWjHNZSPI5tOAAy
         yFqmTA8Jxg+mQ==
Date:   Sun, 2 May 2021 20:48:47 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: driver for texas instruments ads7142
Message-ID: <20210502204846.GA32610@dev>
References: <bffbc2b24a869dc42307adf8e3fc71f08fcff6dd.1619892171.git.info@ministro.hu>
 <20210502181423.1712130b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210502181423.1712130b@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 02, 2021 at 06:14:23PM +0100, Jonathan Cameron wrote:
> On Sat, 1 May 2021 18:24:28 +0000
> Jozsef Horvath <info@ministro.hu> wrote:
> 
> > This is an iio driver for
> >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> > 
> > Operation modes supportedby the driver:
> >   When the 'ti,monitoring-mode' property is not present
> >     in the devicetree node definition, the driver initiates a single
> >     conversion in the device for each read request
> >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> >     This is a one-shot conversion, and it is called
> >     "Manual Mode" in the datasheet.
> > 
> >   When the 'ti,monitoring-mode' property is present
> >     in the devicetree node definition, the driver configures
> >     the device's digital window comparator and sets the device's
> >     data buffer operation mode to pre alert data mode.
> >     The driver reads the conversion result when the BUSY/RDY interrupt
> >     fires, and keeps the value until the next BUSY/RDY interrupt
> >     or the first read request
> >     (/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw).
> 
> Hi Jozsef.
> 
> Interesting device - somewhat like an impact sensor, but on a general
> purpose ADC.

Yes, but now I'm using as an ADC in my project.
In my point of view this is a general purpose ADC with monitoring features.

> 
> Hmm. This sounds rather unintuitive and also very much like a policy
> decision rather than anything to do with the hardware.  Hence it
> should almost certainly be in control of userspace and no via
> dt parameters.
> 

I think that, this operation modes are not generic enough to bring it to sysfs.

> The interrupt driven nature of the device implies that a polled interface
> such as sysfs is not appropriate to support this mode.
> 
> Based on the description you have given here and a quick look
> at the flow charts in the datasheet I would suggest.
> 1) Enable sysfs reads as manual mode only.
> 2) Implement the buffered part of an IIO driver.  This is what we use
>    for data where autonomous clocking is going on.

I'll check the buffered api.

> 3) Add triggers to represent the different autonomous modes.  In some
>    sense all the modes present can be considered be a series of
>    'capture now' signals that are being generated by the hardware in
>    response to some event'.
> 
> So you'd have a pre_alert_tigger, post_alert_trigger
> Stop_burst and start_burst are more interesting to handle because you
> will need something to actually start/stop them.  These could be done
> via a sysfs attribute for the trigger, or more complex schemes exist
> such as triggering them off another trigger... one or two of the SoC
> ADCs do that sort of thing.
> 
>  
> >     The digital window comparator and hysteresis parameters
> >     can be controlled by:
> >       - the devicetree definition of channel node
> >       - iio sysfs interfaces
> >     This is event driven conversion, and is called
> >     "Autonomous Mode with Pre Alert Data" in the datasheet.
> >     This mode can be used to wake up the system with the ALERT pin,
> >     in case when the monitored voltage level is out of the configured range.
> 
> Whilst it's fine to only enable the modes you want, we should think about how
> to ensure other modes can be supported.
> 

As I described above, I would keep the operation modes in dt, and
 'ti,monitoring-mode' can be an enum.

> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > ---
> Should only be one ---
> 
> comments inline.
> > ---
> >  MAINTAINERS                  |    6 +
> >  drivers/iio/adc/Kconfig      |   10 +
> >  drivers/iio/adc/Makefile     |    1 +
> >  
> > +config TI_ADS7142
> > +	tristate "Texas Instruments ADS7142 ADC driver"
> > +	depends on I2C
> > +	help
> > +	  This driver is for Texas Instruments ADS7142 Nanopower, Dual-Channel, Programmable Sensor Monitor.
> 
> Please keep to shorter lines in Kconfig files  < 80 chars preferred.

Ok, you are right.

> 
> > +	  Say 'Y' here if you wish to use it.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ti-ads7142.
> > + * Copyright (C) 2020 Jozsef Horvath <info@ministro.hu>
> > + *
> blank line not needed, plus maybe 2021 given when you are posting it?
> 
> > +}
> > +
> > +static int ti_ads7142_reg_read(const struct i2c_client *client, u8 reg,
> > +			       u8 *data)
> > +{
> > +	struct i2c_msg msg[2];
> Use c99 assignment to do this as something like.
> 
> 	struct i2c_msg msg[2] = {
> 		{
> 			.addr = client->addr,
> 			.len = 2,
> 			.buf = buf,
> 		}, {
> 			.addr = client->addr,
> 			.flags = I2C_M_RD,
> 			.len = 1,
> 			.buf = data,
> 		}
> }	;
> > +	u8 buf[2];
> 
> 	u8 buf[2] = { TI_..., reg };
> 

Ok, you are right

> > +static int ti_ads7142_data_buffer_read(const struct i2c_client *client,
> > +				       int length, void *data)
> > +{
> > +	struct i2c_msg msg;
> > +	int ret;
> > +
> > +	msg.addr = client->addr;
> > +	msg.flags = I2C_M_RD;
> > +	msg.len = length;
> > +	msg.buf = data;
> > +
> > +	ret = i2c_transfer(client->adapter, &msg, 1);
> 
> Looks very similar to an i2c_smbus_read_block_data call though I suppose it
> is a little odd to use mixture of smbus and non in one driver.
> 

I would use i2c_transfer, or i2c_master_recv could better.

> > +static int ti_ads7142_soft_reset(const struct i2c_client *client)
> > +{
> > +	struct i2c_msg msg;
> > +	u8 buf[2];
> u8 buf[2] = { TI_ADS7142_OC_GENERAL, 0x06 }; is more compact for no loss
> of readability.
> 

Ok, I'll do that

> > +	int ret;
> > +
> > +	buf[0] = TI_ADS7142_OC_GENERAL;
> > +	buf[1] = 0x06;
> > +
> > +	msg.addr = client->addr;
> > +	msg.flags = 0;
> > +	msg.len = 2;
> > +	msg.buf = buf;
> > +
> > +	ret = i2c_transfer(client->adapter, &msg, 1);
> 
> i2c_master_send() or even better isn't this just an open coded
> i2c_smbus_write_byte_data()

You are right, I'll change to i2c_master_send

> 
> 
> > +
> > +	return ret >= 0 ? 0 : ret;
> 
> if ret == 0 then something went wrong and we should report that.

You are right

> > +				channel->data.value = value;
> > +				*channel_collected |= 1 << channel_address;
> > +			}
> > +		}
> > +	} while (--data_buffer_status);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_do_work(struct iio_dev *indio_dev)
> 
> As mentioned below, these function needs a more informative name.

I'll change it to ..._do_monitoring_work, and create something like
 start_pre_alert_monitoring, start_post_alert_monitoring, etc

> > +static int ti_ads7142_read_channel_manual(struct iio_dev *indio_dev,
> > +					  int address, int *val)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	u16 data_buffer;
> > +	int ret;
> > +
> > +	if (address < 0 || address > 1)
> 
> I'm assuming there is no way we could get here with this not being true?
> If so drop it.  If it is possible, then add a comment as it seems like
> an odd thing to need to check.
> 

I'ts get called by iio_info.read_raw, so if it's not require to check, I'll remove it.

> > +static int ti_ads7142_read_channel_monitor(struct iio_dev *indio_dev,
> > +					   int address, int *val)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct ti_ads7142_channel *channel;
> > +	int ret;
> > +
> > +	if (address < 0 || address > 1)
> > +		return -EINVAL;
> > +
> > +	ret = ti_ads7142_address2channel(indio_dev, address, &channel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (!channel->data.status) {
> > +		ret = -EAGAIN;
> > +	} else {
> > +		*val = channel->data.value;
> > +		channel->data.status = 0;
> > +		ret = 0;
> 
> ret already is 0 so no need to set it.

You are right.

> > +static irqreturn_t ti_ads7142_ist(int irq, void *dev_id)
> > +{
> > +	struct iio_dev *indio_dev = dev_id;
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct ti_ads7142_channel *channel;
> > +	u8 low_flags;
> > +	u8 high_flags;
> > +	u8 seq_st;
> > +	int i;
> > +	int ret;
> > +	int channel_collected;
> > +	s64 timestamp = iio_get_time_ns(indio_dev);
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (!priv->config.monitoring_mode || !priv->monitor_pending) {
> > +		mutex_unlock(&priv->lock);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_SEQUENCE_STATUS, &seq_st);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: SEQUENCE_STATUS reg read error(%i)",
> > +			__func__, ret);
> > +		goto final;
> > +	}
> > +
> > +	if ((seq_st & TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK)
> > +	    != TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: SEQUENCE_STATUS error(%i)",
> > +			__func__, seq_st);
> > +		goto final;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_LOW_FLAGS,
> > +				  &low_flags);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: ALT_LOW_FLAGS reg read error(%i)",
> > +			__func__, ret);
> > +		goto final;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_HIGH_FLAGS,
> > +				  &high_flags);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: ALT_HIGH_FLAGS reg read error(%i)",
> > +			__func__, ret);
> > +		goto final;
> > +	}
> > +
> > +	channel_collected = 0;
> > +	ret = ti_ads7142_collect_channel_data(indio_dev, &channel_collected);
> > +	if (ret)
> > +		goto final;
> > +
> > +	if (!channel_collected)
> > +		goto final;
> > +
> > +	for (i = 0; i < priv->channel_count; i++) {
> > +		channel = &priv->channels[i];
> > +		if (!(channel_collected & (1 << channel->channel)))
> > +			continue;
> 
> Perhaps use a for_each_bit_set(i, channel_collected) to simplify this.
> 

I'll check it. Thank you.

> > +static int ti_ads7142_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long info)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = ti_ads7142_read_channel(indio_dev, chan->address, val);
> > +		if (!ret)
> 
> 		if (ret)
> 			return ret;
> 
> 		return IIO_VAL_INT;
> 
> Always have error cases out of line.  That consistency makes
> it easier to review.
> 

I dont like 'return' from 'case', but I can live with this. I'll change it.

> > +static int ti_ads7142_write_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int val, int val2, long mask)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		priv->config.n_clk = val;
> > +		if (priv->config.monitoring_mode)
> > +			ret = ti_ads7142_do_work(indio_dev);
> return ti_...
> 
> Early returns almost always easier to read.
> Note applies to lots of stuff above.
>

Ok, I'll fix it all
 
> > +static int ti_ads7142_read_event_config(struct iio_dev *indio_dev,
> > +					const struct iio_chan_spec *chan,
> > +					enum iio_event_type type,
> > +					enum iio_event_direction dir)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct ti_ads7142_channel *channel;
> > +	int ret;
> > +
> > +	if (!priv->config.monitoring_mode)
> > +		return -EINVAL;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	ret = ti_ads7142_address2channel(indio_dev, chan->address,
> > +					 &channel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (dir == IIO_EV_DIR_RISING)
> > +		ret = channel->config.alert_high ? 1 : 0;
> 
> Not fine using ret = channel->config.alert_high; directly?
> 

alert_high is bool, ret is int.
 I know, the 'true' value is 1, and its autmatically casted,
 but who knows the future...I would keep this, if possible.

> > +static int ti_ads7142_write_event_config(struct iio_dev *indio_dev,
> > +					 const struct iio_chan_spec *chan,
> > +					 enum iio_event_type type,
> > +					 enum iio_event_direction dir,
> > +					 int state)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct ti_ads7142_channel *channel;
> > +	bool have_to_do = false;
> > +	int ret;
> > +
> > +	if (!priv->config.monitoring_mode)
> > +		return -EINVAL;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	ret = ti_ads7142_address2channel(indio_dev, chan->address,
> > +					 &channel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (dir == IIO_EV_DIR_RISING) {
> > +		if (channel->config.alert_high != state) {
> > +			channel->config.alert_high = state;
> > +			have_to_do = true;
> > +		}
> > +	} else {
> > +		if (channel->config.alert_low != state) {
> > +			channel->config.alert_low = state;
> > +			have_to_do = true;
> > +		}
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +
> > +	if (have_to_do)
> > +		ret = ti_ads7142_do_work(indio_dev);
> that's going to need a better name as I have no idea what _do_work implies.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info ti_ads7142_iio_info = {
> 
> If interrupt is going to be optional, pick between two versions of struct iio_info
> so that we don't provide callbacks for the case where we have no interrupts.
> 

Ok, I'll do that.

> > +	.read_raw		= ti_ads7142_read_raw,
> > +	.write_raw		= ti_ads7142_write_raw,
> > +	.read_event_value	= ti_ads7142_read_event_value,
> > +	.write_event_value	= ti_ads7142_write_event_value,
> > +	.read_event_config	= ti_ads7142_read_event_config,
> > +	.write_event_config	= ti_ads7142_write_event_config,
> > +};
> > +
> > +static int ti_ads7142_parse_channel_config_of(struct device *dev,
> > +					      struct iio_dev *indio_dev)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct device_node *channel_node;
> > +	struct iio_chan_spec *iio_channels;
> > +	struct iio_chan_spec *iio_channel;
> > +	struct ti_ads7142_channel *ads_channel;
> > +	int channel_index = 0;
> > +	int ret;
> > +
> > +	priv->channel_count = of_get_available_child_count(dev->of_node);
> > +	if (!priv->channel_count) {
> > +		dev_err(dev, "dt: there is no channel definition");
> > +		return -ENODEV;
> > +	}
> > +
> > +	priv->channels = devm_kcalloc(dev, priv->channel_count,
> > +				      sizeof(*priv->channels),
> > +				      GFP_KERNEL);
> > +	if (!priv->channels)
> > +		return -ENOMEM;
> > +
> > +	indio_dev->num_channels = priv->channel_count;
> 
> Why do you need that in two places?
> 

You are right this is redundancy.

> > +	iio_channels = devm_kcalloc(dev, priv->channel_count,
> > +				    sizeof(*iio_channels),
> > +				    GFP_KERNEL);
> > +	if (!iio_channels)
> > +		return -ENOMEM;
> > +
> > +	indio_dev->channels = iio_channels;
> > +
> > +	for_each_available_child_of_node(dev->of_node, channel_node) {
> > +		ads_channel = &priv->channels[channel_index];
> > +
> > +		ret = of_property_read_u32(channel_node, "reg",
> > +					   &ads_channel->channel);
> > +		if (ret)
> > +			goto err;
> > +
> > +		iio_channel = &iio_channels[channel_index];
> > +		iio_channel->type = IIO_VOLTAGE;
> > +		iio_channel->indexed = 1;
> > +		iio_channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> > +						  | BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > +		if (!IS_ERR(priv->vref))
> Ah.  This somewhat explains the optional regulator.
> We have done this in a few old drivers because they initially were missing vref support
> and we couldn't break existing device tree bindings.  I'm not keen to see it
> done for a new driver.  Just make the vref-supply required.
> If it's a fixed voltage that is always on, then the device tree additions are
> trivial anyway.
> 

Ok, I'll do that.

> > +			iio_channel->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > +		iio_channel->scan_type.sign = 'u';
> > +		iio_channel->scan_type.realbits = 12;
> > +		iio_channel->scan_type.storagebits = 16;
> > +		iio_channel->scan_type.shift = 0;
> 
> No need to specify obvious default shift of 0.  Rely on the zeroed allocation.
> 
> > +		iio_channel->scan_type.endianness = IIO_CPU;
> > +		iio_channel->address = ads_channel->channel;
> > +		iio_channel->scan_index = ads_channel->channel;
> > +		iio_channel->channel = ads_channel->channel;
> > +		if (priv->config.monitoring_mode) {
> > +			iio_channel->event_spec = ti_ads7142_events;
> > +			iio_channel->num_event_specs = ARRAY_SIZE(ti_ads7142_events);
> > +		}
> > +
> > +		ads_channel->config.high_threshold = TI_ADS7142_THRESHOLD_MSK;
> > +		ret = of_property_read_u32(channel_node, "ti,threshold-rising",
> 
> These are usually considered a matter of userspace policy only.   Will need a strong
> argument for them to be in DT.

Ok, I'll remove this from dt.

> 
> > +					   &ads_channel->config.high_threshold);
> > +		ads_channel->config.alert_high = !ret;
> > +		ret = of_property_read_u32(channel_node, "ti,threshold-falling",
> > +					   &ads_channel->config.low_threshold);
> > +		ads_channel->config.alert_low = !ret;
> > +		ret = of_property_read_u32(channel_node, "ti,hysteresis",
> > +					   &ads_channel->config.hysteresis);
> > +		channel_index++;
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	of_node_put(channel_node);
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_parse_config_of(struct device *dev,
> > +				      struct iio_dev *indio_dev)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +
> > +	priv->config.osc_sel = of_property_read_bool(dev->of_node,
> > +						     "ti,osc-sel");
> 
> Please use generic device property access functions where possible.
> That basically gives us support on non OF based platforms for free.

Could you please explain this, I dont understand.

> 
> > +	of_property_read_u32(dev->of_node, "ti,n-clk", &priv->config.n_clk);
> > +	priv->config.monitoring_mode = of_property_read_bool(dev->of_node,
> > +							     "ti,monitoring-mode");
> > +
> > +	return ti_ads7142_parse_channel_config_of(dev, indio_dev);
> > +}
> > +
> > +static int ti_ads7142_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ti_ads7142_priv *priv;
> > +	int ret;
> > +
> > +	ret = ti_ads7142_soft_reset(client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	priv = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->dev.of_node = client->dev.of_node;
> 
> Both of the above are set by the iio core, so no need to set her.

Ok, thank you, I'll remove it.

>  
> > +	indio_dev->name = TI_ADS7142_NAME;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &ti_ads7142_iio_info;
> > +
> > +	mutex_init(&priv->lock);
> > +
> > +	priv->vref = devm_regulator_get_optional(&client->dev, "vref");
> 
> There isn't a vref pin on the device.  Vref is used in the datasheet
> but the pinout makes it clear it is actually avdd which is definitely
> not optional.

You are right, avdd is a better name.

> 
> > +	if (!IS_ERR(priv->vref)) {
> > +		ret = regulator_enable(priv->vref);
> > +		if (ret)
> > +			goto err;
> As you have simple handling of power in here, I would definitely look
> to use managed calls to disable the regulators.
> 
> 	devm_add_action_or_reset() is usual way of doing this.
> 
> If nothing else it will ensure that the unwind on removal is the mirror
> image of the setup on probe() and hence it is much easier to avoid any
> subtle race conditions.

Very good suggestion, thank you.

> 
> > +	}
> > +
> > +	priv->power = devm_regulator_get_optional(&client->dev, "power");
> 
> dvdd?  Not sure what else power could be.  Note that you should only
> use _get_optional() for regulators that really optional and may not be
> connected.  For cases where you simply can't control them and they aren't
> specified in the dts then devm_regulator_get() will supply a stub regulator
> that is always on.
>

Ok, I'll change it to dvdd and required property
 
> 
> > +	if (!IS_ERR(priv->power)) {
> > +		ret = regulator_enable(priv->power);
> > +		if (ret)
> > +			goto err_regulator;
> > +	}
> > +
> > +	ret = ti_ads7142_parse_config_of(&client->dev, indio_dev);
> > +	if (ret)
> > +		goto err_regulator;
> > +
> > +	if (!client->irq && priv->config.monitoring_mode) {
> 
> Given you can check this before you have to do any unwinding, move it
> earlier.

Ok, I'll do this.

> 
> > +		ret = -EINVAL;
> > +		dev_err(&client->dev, "Interrupt not specified\n");
> > +		goto err_regulator;
> > +	}
> > +	if (client->irq && priv->config.monitoring_mode) {
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, ti_ads7142_ist,
> > +						IRQF_ONESHOT | IRQF_SHARED,
> > +						dev_name(&client->dev),
> > +						indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "Unable to request IRQ %i",
> > +				client->irq);
> > +			goto err_regulator;
> > +		}
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "Failed to register iio device");
> > +		goto err_regulator;
> > +	}
> > +
> > +	ret = ti_ads7142_do_work(indio_dev);
> 
> As iio_device_register() is responsible for exposing userspace interfaces it
> is very rarely a good idea to do anything after it in probe()
> (some exceptions for runtime pm autosuspend setup as that can kick in later)
> 

Ok, I'll move it earlier.

> > +	if (!ret) {
> > +		dev_info(&client->dev, "%s is a %s device at address 0x%X",
> > +			 dev_name(&indio_dev->dev), indio_dev->name,
> > +			 client->addr);
> > +		return ret;
> Always have the error path out of line as it is much more consistent
> with what reviewers are expecting
> 
> 	if (ret)
> 		goto error_unregister()
> 
> 	return 0;
> 
> > +	}
> > +
> > +	iio_device_unregister(indio_dev);
> 
> 
> 
> > +
> > +err_regulator:
> > +	if (!IS_ERR(priv->vref))
> > +		regulator_disable(priv->vref);
> > +	if (!IS_ERR(priv->power))
> > +		regulator_disable(priv->power);
> > +err:
> > +	mutex_destroy(&priv->lock);
> We rarely bother with mutex_destroy() in paths where the driver is being
> removed as it is only useful for debugging use of mutexes after they have
> been removed.  That doesn't happen in these paths so it tends to just be
> noise to have a mutex_destroy().  This function is useful if you have a
> mutex inside something with a different lifespan from the device and
> like to enable mutex debugging.
> 

Ok, I'll remove it, thank you for the explanation.

> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +
> > +	if (!IS_ERR(priv->vref))
> > +		regulator_disable(priv->vref);
> If you'd not used _optional() above you could do these without worrying
> about whether the regulator was  there or not.
> 
> > +	if (!IS_ERR(priv->power))
> > +		regulator_disable(priv->power);
> > +	mutex_destroy(&priv->lock);
> > +	iio_device_unregister(indio_dev);
> 
> _remove should always look like the unwinding of probe - so
> I should be able to match items in reverse order.

Ok, I check it.

Thank you for the review and suggestions.

Best regards
Jozsef

> 
> > +
> > +	return 0;
> > +}
> > +
> > +module_i2c_driver(ti_ads7142_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> > +MODULE_DESCRIPTION("Texas Instruments TI_ADS7142 ADC driver");
> 
> 


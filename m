Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9BAFEC98
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKPOIx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 09:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKPOIx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 09:08:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77CB20700;
        Sat, 16 Nov 2019 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573913332;
        bh=K6jJzmy2TrOILsCo2E/gp9oUFsW+m5/GXOwqD9PYOy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eALBD7t9e87iDstSGl72jIs0OU//eufReQhcCV5DVyH8Q3vSzEBcoKeLjhpqjSpt3
         4qquQBHUWXShqxlDBSLJrox2uqylhc1bU52Uok+t5P/IYnMlh433/wJAm6DIbLxcxf
         9hbwzkibx8/0l6SLmCEYEv5C9qtq8tdDCvj+SctY=
Date:   Sat, 16 Nov 2019 14:08:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add driver support for AD5940
Message-ID: <20191116140846.1b094dc6@archlinux>
In-Reply-To: <58ef4da3-7640-767d-5f6b-c2c5c680cddb@gmail.com>
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
        <20191108130946.14740-2-songqiang1304521@gmail.com>
        <20191110165529.78a4714a@archlinux>
        <58ef4da3-7640-767d-5f6b-c2c5c680cddb@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 22:05:54 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:


> >> +static ssize_t ad5940_read_info(struct iio_dev *indio_dev,
> >> +				uintptr_t private,
> >> +				const struct iio_chan_spec *chan,
> >> +				char *buf)
> >> +{
> >> +	struct ad5940_state *st = iio_priv(indio_dev);
> >> +
> >> +	switch ((u32)private) {
> >> +	case AD5940_CHANNEL_NAME:  
> > 
> > What is the logic here in this magic define?
> >   
> 
> Do you mean this is not necessary? In this driver, 'ad5940_read_info' is
> only used in name reading, but I was thinking maybe there will be some
> other stuff to be reading from this in the future.

That might happen, but you may also extend this by providing more
callbacks.  Certainly don't put code in place to support things
that might be added.  Keep it simple.

> 
> >> +		return sprintf(buf, "%s\n",
> >> +			st->channel_config[chan->address].channel_name);
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +

...

> >> +static int ad5940_of_parse_channel_config(struct iio_dev *indio_dev,
> >> +					  struct device_node *np)
> >> +{
> >> +	struct ad5940_state *st = iio_priv(indio_dev);
> >> +	struct iio_chan_spec *chan;
> >> +	struct device_node *child;
> >> +	u32 channel, ain[2];
> >> +	int ret;
> >> +
> >> +	st->num_channels = of_get_available_child_count(np);
> >> +	if (!st->num_channels) {
> >> +		dev_err(indio_dev->dev.parent, "no channel children\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> >> +			    sizeof(*chan), GFP_KERNEL);
> >> +	if (!chan)
> >> +		return -ENOMEM;
> >> +
> >> +	st->channel_config = devm_kcalloc(indio_dev->dev.parent,
> >> +					  st->num_channels,
> >> +					  sizeof(*st->channel_config),
> >> +					  GFP_KERNEL);
> >> +	if (!st->channel_config)
> >> +		return -ENOMEM;
> >> +
> >> +	indio_dev->channels = chan;
> >> +	indio_dev->num_channels = st->num_channels;
> >> +
> >> +	for_each_available_child_of_node(np, child) {
> >> +		ret = of_property_read_u32(child, "reg", &channel);
> >> +		if (ret)
> >> +			goto err;
> >> +
> >> +		ret = of_property_read_u32_array(child, "diff-channels",
> >> +						 ain, 2);
> >> +		if (ret)
> >> +			goto err;
> >> +
> >> +		ret = of_property_read_string(child, "channel-name",
> >> +				&st->channel_config[channel].channel_name);
> >> +		if (ret)
> >> +			st->channel_config[channel].channel_name = "none-name";  
> > 
> > You have this as required I think in the dt properties.  If that is the case then
> > enforce it and refuse to load the driver if not supplied. Otherwise change
> > the dt docs to make it optional (which is probably better)
> >   
> 
> I prefer to have name required because a channel here is a combination
> of some input and some output. Without name, we will have to look into
> dt to see which input and which output is used in this channel.

Then don't make it optional.

> 
> >> +
> >> +		ret = ad5940_check_channel_indexes(indio_dev->dev.parent, ain);
> >> +		if (ret) {
> >> +			dev_err(indio_dev->dev.parent,
> >> +				"some input channel index does not exist: %d, %d, %d",
> >> +				channel, ain[0], ain[1]);
> >> +			goto err;
> >> +		}
> >> +
> >> +		st->channel_config[channel].ain = AD5940_CHANNEL_AINP(ain[0]) |
> >> +						  AD5940_CHANNEL_AINN(ain[1]);
> >> +
> >> +		*chan = ad5940_channel_template;
> >> +		chan->address = channel;
> >> +		chan->scan_index = channel;
> >> +		chan->channel = ain[0];
> >> +		chan->channel2 = ain[1];
> >> +
> >> +		chan++;
> >> +	}
> >> +
> >> +	return 0;
> >> +err:
> >> +	of_node_put(child);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int ad5940_config_polarity(struct ad5940_state *st, u32 polarity)
> >> +{
> >> +	u32 val;
> >> +
> >> +	if (polarity == IRQF_TRIGGER_RISING)
> >> +		val = AD5940_INTCPOL_POS;
> >> +	else
> >> +		val = AD5940_INTCPOL_NEG;
> >> +
> >> +	return ad5940_write_reg_mask(st, AD5940_REG_INTCPOL,
> >> +				     AD5940_INTCPOL_MSK, val);
> >> +}
> >> +
> >> +static int ad5940_config_int_io(struct ad5940_state *st, u8 int_io)
> >> +{
> >> +	int ret = 0;
> >> +
> >> +	if (int_io == 3)  
> > 
> > Switch statement preferred for matches like this.
> >   
> >> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
> >> +					    AD5940_GP0CON_3_MSK,
> >> +					    AD5940_GP0CON_3_INT);
> >> +	else if (int_io == 6)
> >> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
> >> +					    AD5940_GP0CON_6_MSK,
> >> +					    AD5940_GP0CON_6_INT);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return  ad5940_write_reg(st, AD5940_REG_GP0OEN, BIT(int_io));
> >> +}
> >> +
> >> +static const u32 ad5940_powerup_setting[][2] = {  
> > 
> > Hmm. This is not good practice when we have docs for the values.
> > If we can provide a breakdown into what is being set that would be
> > great.  I can't find docs immediately for some of these however...
> >   
> 
> We have docs for some of them, but not for all. I got some of the init
> register values from Analog's example code, which didn't explain much.
> I'll add comment to these values as much as I can.

Great.

Jonathan

> 
> yours,
> Song Qiang
> 
> >> +	{ 0x0908, 0x02c9 },
> >> +	{ 0x0c08, 0x206c },
> >> +	{ 0x21f0, 0x0010 },  
> > 
> > This one is is simply saying only 1 repeat conversion for example.
> > Add some defines and you can make that clear.
> >   
> >> +	{ 0x0410, 0x02c9 },
> >> +	{ 0x0a28, 0x0009 },
> >> +	{ 0x238c, 0x0104 },
> >> +	{ 0x0a04, 0x4859 },
> >> +	{ 0x0a04, 0xf27b },
> >> +	{ 0x0a00, 0x8009 },
> >> +	{ 0x22f0, 0x0000 },
> >> +	{ 0x2230, 0xde87a5af },
> >> +	{ 0x2250, 0x103f },
> >> +	{ 0x22b0, 0x203c },
> >> +	{ 0x2230, 0xde87a5a0 },
> >> +};
> >> +  
> 
> ...


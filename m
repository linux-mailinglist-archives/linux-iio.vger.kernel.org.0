Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982F0FC861
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNOGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 09:06:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfKNOGK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 09:06:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so2682982plk.6;
        Thu, 14 Nov 2019 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1vdrZflopLKHMkXUH0I+ULeg9UjV+kbPCLSECUJ7Zo=;
        b=pjOrbA7MxBTkeNmk2Sb7rIs16MsQaqt4ovBEblMIlrH8yj2ShtwnWPRmVlAWJsfQyV
         WPcw62MT99lkjFMt4F+f7WUsOkuUIVRThvM3kbhDSsBkUsCgf3rvBIy8wIP2sWoZdJV7
         vS06k9eR8OZDouXwCFgfZ2k2fNobi6uRJqKxCcouJfi7biN7Yk625mTxxX2oCtLSLjqw
         WLtN2rnyTF4mmHtsxkd2cisqmjZ1GhxnZ5tnq+MFIbZye/YOVLu/IwAbezwuT4ndFiEM
         LkuU1M9AfgZnIwCH+dnWKg7J5Ghq9mk+/OHrRHV+6GD2i1E3JFQ7VtnXx+jkZGDA/S/c
         pO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1vdrZflopLKHMkXUH0I+ULeg9UjV+kbPCLSECUJ7Zo=;
        b=nolIo/H7EnvFGALCGZ3N3yYTvZ1TcwZ60KWK9BLS0Bt9B0Tpq+zD6giwl5Q+xdB1bD
         5eKGbKzAPFv91N+cTZP2BaBbrtz7nfM6ex44tnbd7GFpDO1URYJDraCeHAYrwuQiogRW
         ITOW7L3/FgQbJpLJQajB46LTEniJ04x+gXBQA8Cd83QslRdTwZu1sAZert2UhcNnIePZ
         /4vGmoWeVWZ3Q7WSr74OGbZytP/tdpaPVPKV+wXcjtMOs8XhFw2+vHpoKaRfQ+WdtyDr
         2FT6bfqIj/1r4yMWmd6MqrK0uZSIO6XkKUAPdeUpHA0gPvRwWK/MLf1ly3U87f+t41Ne
         6Fmw==
X-Gm-Message-State: APjAAAUZOkFdwYArMd9YDOuWA+qIOdpVqzHzm5D+J9HXClKMGQnSQoOq
        Dzo3QNifu83k2wvOnYqjpxLcfylCZGo=
X-Google-Smtp-Source: APXvYqzTVZwfetl+5lRajHoSzOW9dsJwbMGD1taTrhltnGtOOwVAGsLE1xRY2+oA5T0lFyMDyOca1w==
X-Received: by 2002:a17:902:b584:: with SMTP id a4mr9550970pls.246.1573740367767;
        Thu, 14 Nov 2019 06:06:07 -0800 (PST)
Received: from [0.0.0.0] ([97.64.17.87])
        by smtp.gmail.com with ESMTPSA id s66sm9534427pfb.38.2019.11.14.06.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:06:07 -0800 (PST)
Subject: Re: [PATCH 2/3] iio: adc: add driver support for AD5940
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
 <20191108130946.14740-2-songqiang1304521@gmail.com>
 <20191110165529.78a4714a@archlinux>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <58ef4da3-7640-767d-5f6b-c2c5c680cddb@gmail.com>
Date:   Thu, 14 Nov 2019 22:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110165529.78a4714a@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/11/19 12:55 AM, Jonathan Cameron wrote:
> On Fri,  8 Nov 2019 21:09:45 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
>> The AD5940 is a high precision, low power analog front end (AFE)
>> designed for portable applications that require high precision,
>> electrochemical-based measurement techniques, such as amper-
>> ometric, voltammetric, or impedance measurements.
>>
>> Datasheet:
>> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5940.pdf
>>
>> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> 
> Nice little driver on the whole.  I'm guessing this is very much the 'first of
> many' patches to support this complex part.  Makes sense and keeps it manageable
> from a review point of view.
> 
> A few comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  .../ABI/testing/sysfs-bus-iio-adc-ad5940      |   7 +
>>  drivers/iio/adc/Kconfig                       |  10 +
>>  drivers/iio/adc/Makefile                      |   1 +
>>  drivers/iio/adc/ad5940.c                      | 679 ++++++++++++++++++
>>  4 files changed, 697 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad5940
>>  create mode 100644 drivers/iio/adc/ad5940.c
>>

...

>> +static int ad5940_write_reg_mask(struct ad5940_state *st, u16 addr,
>> +				 u32 mask, u32 data)
>> +{
>> +	u32 temp;
>> +	int ret;
>> +
>> +	ret = ad5940_read_reg(st, addr, &temp);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	temp &= ~mask;
>> +	temp |= data;
>> +
>> +	return ad5940_write_reg(st, addr, temp);
>> +}
>> +
>> +static ssize_t ad5940_read_info(struct iio_dev *indio_dev,
>> +				uintptr_t private,
>> +				const struct iio_chan_spec *chan,
>> +				char *buf)
>> +{
>> +	struct ad5940_state *st = iio_priv(indio_dev);
>> +
>> +	switch ((u32)private) {
>> +	case AD5940_CHANNEL_NAME:
> 
> What is the logic here in this magic define?
> 

Do you mean this is not necessary? In this driver, 'ad5940_read_info' is
only used in name reading, but I was thinking maybe there will be some
other stuff to be reading from this in the future.

>> +		return sprintf(buf, "%s\n",
>> +			st->channel_config[chan->address].channel_name);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info ad4590_ext_info[] = {
>> +	{
>> +		.name = "name",
> 
> This is defining new ABI.  I'm not necessarily against doing so but
> it needs a separate documentation patch so that it's easy to discuss.
> Documentation/ABI/testing/sysfs-bus-iio
> 
> We might want to think of a similar naming to the label we recently
> added for the device itself.
> 

I'll look into this and see if I can use 'label' instead.

>> +		.read = ad5940_read_info,
>> +		.private = AD5940_CHANNEL_NAME,
>> +		.shared = IIO_SEPARATE,
>> +	},
>> +	{ },
>> +};
>> +
>> +static const struct iio_chan_spec ad5940_channel_template = {
>> +	.type = IIO_VOLTAGE,
>> +	.differential = 1,
>> +	.indexed = 1,
>> +	.ext_info = ad4590_ext_info,
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +};
>> +
>> +static int ad5940_clear_ready(struct ad5940_state *st)
>> +{
>> +	int ret;
>> +
>> +	ret = ad5940_write_reg_mask(st, AD5940_REG_AFECON,
>> +				    AD5940_AFECON_ADCCONV_MSK,
>> +				    AD5940_AFECON_ADCCONV_DIS);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return ad5940_write_reg(st, AD5940_REG_INTCLR, AD5940_INTC_ADC);
>> +}
>> +
>> +static irqreturn_t ad5940_irq_handler(int irq, void *private)
>> +{
>> +	struct ad5940_state *st = private;
>> +	int ret;
>> +
>> +	ret = ad5940_clear_ready(st);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	complete(&st->complete);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int ad5940_scan_direct(struct ad5940_state *st, u32 mux, int *val)
>> +{
>> +	int ret;
>> +	u32 result;
>> +
>> +	mutex_lock(&st->lock);
>> +	ret = ad5940_write_reg_mask(st, AD5940_REG_ADCCON,
>> +				    AD5940_ADCCON_MUX_MSK, mux);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +
>> +	reinit_completion(&st->complete);
>> +	ret = ad5940_write_reg_mask(st, AD5940_REG_AFECON,
>> +				    AD5940_AFECON_ADCCONV_MSK,
>> +				    AD5940_AFECON_ADCCONV_EN);
>> +	if (ret < 0)
>> +		goto unlock_return;
>> +
>> +	ret = wait_for_completion_timeout(&st->complete,
>> +					  msecs_to_jiffies(1000));
>> +	if (!ret) {
>> +		ad5940_clear_ready(st);
>> +		ret = -ETIMEDOUT;
>> +		goto unlock_return;
>> +	}
>> +
>> +	ret = ad5940_read_reg(st, AD5940_REG_ADCDAT, &result);
>> +	mutex_unlock(&st->lock);
>> +	if (ret < 0)
>> +		return ret;
> 
> As you already have the unlock_return below on this occasion I would
> move the if (ret) inside the lock so all similar errors take a simpler
> exit path.  If this was the only case and you didn't have the handling
> I would agree with how you have done it.
> 
>> +	*val = result & 0xffff;
>> +
>> +	return 0;
>> +
>> +unlock_return:
>> +	mutex_unlock(&st->lock);
>> +	return ret;
>> +}
>> +
>> +static int ad5940_read_raw(struct iio_dev *indio_dev,
>> +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
>> +{
>> +	struct ad5940_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = ad5940_scan_direct(st,
>> +				st->channel_config[chan->address].ain,
>> +				val);
>> +		if (ret < 0)
>> +			return ret;
>> +		else
>> +			return IIO_VAL_INT;
> 		return IIO_VAL_INT;
> 
> 		Cleaner to only have the error path indented.
> 		if / else kind of implies some 'equality' of the two
> 		options.
> 
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = st->vref_mv;
>> +		*val2 = 16;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info ad5940_info = {
>> +	.read_raw = &ad5940_read_raw,
>> +};
>> +
>> +int cmp_u8(const void *a, const void *b)
>> +{
>> +	return (*(u8 *)a - *(u8 *)b);
>> +}
>> +
>> +static int ad5940_check_channel_indexes(struct device *dev, u32 *ain)
>> +{
>> +	const u8 channel_p[] = {
>> +		0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 18, 19,
>> +		20, 22, 23, 24, 25, 26, 31, 33, 35, 36
>> +	};
>> +	const u8 channel_n[] = {
>> +		0, 1, 2, 4, 5, 6, 7, 10, 11, 12, 14, 16, 17, 20
>> +	};
>> +	u8 *index;
>> +
>> +	index = (u8 *) bsearch(&ain[0], channel_p, ARRAY_SIZE(channel_p),
>> +				sizeof(u8), cmp_u8);
>> +	if (!index) {
>> +		dev_err(dev, "Positive input index not found.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	index = (u8 *) bsearch(&ain[1], channel_n, ARRAY_SIZE(channel_n),
>> +				sizeof(u8), cmp_u8);
>> +	if (!index) {
>> +		dev_err(dev, "negtive input index not found.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ad5940_of_parse_channel_config(struct iio_dev *indio_dev,
>> +					  struct device_node *np)
>> +{
>> +	struct ad5940_state *st = iio_priv(indio_dev);
>> +	struct iio_chan_spec *chan;
>> +	struct device_node *child;
>> +	u32 channel, ain[2];
>> +	int ret;
>> +
>> +	st->num_channels = of_get_available_child_count(np);
>> +	if (!st->num_channels) {
>> +		dev_err(indio_dev->dev.parent, "no channel children\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
>> +			    sizeof(*chan), GFP_KERNEL);
>> +	if (!chan)
>> +		return -ENOMEM;
>> +
>> +	st->channel_config = devm_kcalloc(indio_dev->dev.parent,
>> +					  st->num_channels,
>> +					  sizeof(*st->channel_config),
>> +					  GFP_KERNEL);
>> +	if (!st->channel_config)
>> +		return -ENOMEM;
>> +
>> +	indio_dev->channels = chan;
>> +	indio_dev->num_channels = st->num_channels;
>> +
>> +	for_each_available_child_of_node(np, child) {
>> +		ret = of_property_read_u32(child, "reg", &channel);
>> +		if (ret)
>> +			goto err;
>> +
>> +		ret = of_property_read_u32_array(child, "diff-channels",
>> +						 ain, 2);
>> +		if (ret)
>> +			goto err;
>> +
>> +		ret = of_property_read_string(child, "channel-name",
>> +				&st->channel_config[channel].channel_name);
>> +		if (ret)
>> +			st->channel_config[channel].channel_name = "none-name";
> 
> You have this as required I think in the dt properties.  If that is the case then
> enforce it and refuse to load the driver if not supplied. Otherwise change
> the dt docs to make it optional (which is probably better)
> 

I prefer to have name required because a channel here is a combination
of some input and some output. Without name, we will have to look into
dt to see which input and which output is used in this channel.

>> +
>> +		ret = ad5940_check_channel_indexes(indio_dev->dev.parent, ain);
>> +		if (ret) {
>> +			dev_err(indio_dev->dev.parent,
>> +				"some input channel index does not exist: %d, %d, %d",
>> +				channel, ain[0], ain[1]);
>> +			goto err;
>> +		}
>> +
>> +		st->channel_config[channel].ain = AD5940_CHANNEL_AINP(ain[0]) |
>> +						  AD5940_CHANNEL_AINN(ain[1]);
>> +
>> +		*chan = ad5940_channel_template;
>> +		chan->address = channel;
>> +		chan->scan_index = channel;
>> +		chan->channel = ain[0];
>> +		chan->channel2 = ain[1];
>> +
>> +		chan++;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	of_node_put(child);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ad5940_config_polarity(struct ad5940_state *st, u32 polarity)
>> +{
>> +	u32 val;
>> +
>> +	if (polarity == IRQF_TRIGGER_RISING)
>> +		val = AD5940_INTCPOL_POS;
>> +	else
>> +		val = AD5940_INTCPOL_NEG;
>> +
>> +	return ad5940_write_reg_mask(st, AD5940_REG_INTCPOL,
>> +				     AD5940_INTCPOL_MSK, val);
>> +}
>> +
>> +static int ad5940_config_int_io(struct ad5940_state *st, u8 int_io)
>> +{
>> +	int ret = 0;
>> +
>> +	if (int_io == 3)
> 
> Switch statement preferred for matches like this.
> 
>> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
>> +					    AD5940_GP0CON_3_MSK,
>> +					    AD5940_GP0CON_3_INT);
>> +	else if (int_io == 6)
>> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
>> +					    AD5940_GP0CON_6_MSK,
>> +					    AD5940_GP0CON_6_INT);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return  ad5940_write_reg(st, AD5940_REG_GP0OEN, BIT(int_io));
>> +}
>> +
>> +static const u32 ad5940_powerup_setting[][2] = {
> 
> Hmm. This is not good practice when we have docs for the values.
> If we can provide a breakdown into what is being set that would be
> great.  I can't find docs immediately for some of these however...
> 

We have docs for some of them, but not for all. I got some of the init
register values from Analog's example code, which didn't explain much.
I'll add comment to these values as much as I can.

yours,
Song Qiang

>> +	{ 0x0908, 0x02c9 },
>> +	{ 0x0c08, 0x206c },
>> +	{ 0x21f0, 0x0010 },
> 
> This one is is simply saying only 1 repeat conversion for example.
> Add some defines and you can make that clear.
> 
>> +	{ 0x0410, 0x02c9 },
>> +	{ 0x0a28, 0x0009 },
>> +	{ 0x238c, 0x0104 },
>> +	{ 0x0a04, 0x4859 },
>> +	{ 0x0a04, 0xf27b },
>> +	{ 0x0a00, 0x8009 },
>> +	{ 0x22f0, 0x0000 },
>> +	{ 0x2230, 0xde87a5af },
>> +	{ 0x2250, 0x103f },
>> +	{ 0x22b0, 0x203c },
>> +	{ 0x2230, 0xde87a5a0 },
>> +};
>> +

...

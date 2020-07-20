Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA4226152
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGTNw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 09:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgGTNw3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 09:52:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E52B222BF3;
        Mon, 20 Jul 2020 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595253148;
        bh=+gnwOM2az8B3fa+vUBkNuPzRDcAEiVPRuJCmHCsZTGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAwbiYny2LCKd9BP/++sNFTAqf/Q5iwzv4/BeCCbYDOrBEmTwn8DdSNzYHIGGDaIH
         LdQh3IGbokWVNG4izpbZD8ZmFVJLN2zr76z7wxZyqpdLLk9fekpHMVQ96f+ihwP3+Q
         2lhWN1KNXvLjcGoaTdmNnpeApVy0x01GdVpyCrUU=
Date:   Mon, 20 Jul 2020 14:52:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit
 ADC, DAC
Message-ID: <20200720145225.4f5d552b@archlinux>
In-Reply-To: <9bd0363c-e8fb-a36f-a107-0afd8f7851d0@metafoo.de>
References: <20200716072737.9535-1-cristian.pop@analog.com>
        <9bd0363c-e8fb-a36f-a107-0afd8f7851d0@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 11:25:36 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 7/16/20 9:27 AM, Cristian Pop wrote:
> > Implementation for 1-bit ADC (comparator) and a 1-bit DAC (switch)  
> 
> Very sneaky way of introducing a iio-gpio-proxy driver to be able to 
> access GPIOs through libiio ;). I'm not really a fan of the whole idea.
> 
> But either way I think this needs a better description of what 1-bit 
> converters are and how they are used.
I'll second that.  If we want to do this, I'd much rather seeing as
an explicit gpio to IIO bridge driver. 

If there is a comparator on an ADC pin, then the analog characteristics
of that need describing.  There might be some argument in favour if that
was done and hence we had scale etc provided for the channel.

Given this is really just putting a new interface on gpios please
cc the gpio maintainer / list for future versions.

Thanks,

Jonathan


> 
> >
> > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > ---
> >   drivers/iio/addac/one-bit-adc-dac.c | 229 ++++++++++++++++++++++++++++
> >   1 file changed, 229 insertions(+)
> >   create mode 100644 drivers/iio/addac/one-bit-adc-dac.c
> >
> > diff --git a/drivers/iio/addac/one-bit-adc-dac.c b/drivers/iio/addac/one-bit-adc-dac.c
> > new file mode 100644
> > index 000000000000..8e2a8a09fedb
> > --- /dev/null
> > +++ b/drivers/iio/addac/one-bit-adc-dac.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices ONE_BIT_ADC_DAC
> > + * Digital to Analog Converters driver
> > + *
> > + * Copyright 2019 Analog Devices Inc.

Probably update to 2020 or 2019-2020

> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio/consumer.h>
> > +
> > +enum ch_direction {
> > +	CH_IN,
> > +	CH_OUT,
> > +};
> > +
> > +struct one_bit_adc_dac_state {
> > +	struct platform_device  *pdev;
> > +	struct gpio_descs       *in_gpio_descs;
> > +	struct gpio_descs       *out_gpio_descs;
> > +};
> > +
> > + #define ONE_BIT_ADC_DAC_CHANNEL(idx, direction)			\
> > +	{								\
> > +		.type = IIO_VOLTAGE,					\
> > +		.indexed = 1,						\
> > +		.channel = idx,						\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +		.output = direction,					\
> > +	}

Macro only used in one place, I'd not bother with the macro.

> > +
> > +static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> > +{
> > +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> > +	int in_num_ch = 0, out_num_ch = 0;
> > +	int channel = chan->channel;
> > +
> > +	if (st->in_gpio_descs)
> > +		in_num_ch = st->in_gpio_descs->ndescs;
> > +
> > +	if (st->out_gpio_descs)
> > +		out_num_ch = st->out_gpio_descs->ndescs;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (channel < in_num_ch) {
> > +			*val = gpiod_get_value_cansleep(
> > +				st->in_gpio_descs->desc[channel]);
> > +		} else {
> > +			channel -= in_num_ch;
> > +			*val = gpiod_get_value_cansleep(
> > +				st->out_gpio_descs->desc[channel]);
> > +		}
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val,
> > +			    int val2,
> > +			    long info)
> > +{
> > +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> > +	int in_num_ch = 0, out_num_ch = 0;
> > +	int channel = chan->channel;
> > +
> > +	if (st->in_gpio_descs)
> > +		in_num_ch = st->in_gpio_descs->ndescs;
> > +
> > +	if (st->out_gpio_descs)
> > +		out_num_ch = st->out_gpio_descs->ndescs;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (channel < in_num_ch) {
> > +			gpiod_set_value_cansleep(
> > +				st->in_gpio_descs->desc[channel], val);  
> 
> How can we set a value on an input GPIO?
> 
> > +		} else {
> > +			channel -= in_num_ch;
> > +			gpiod_set_value_cansleep(
> > +				st->out_gpio_descs->desc[channel], val);
> > +		}
> > +
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info one_bit_adc_dac_info = {
> > +	.read_raw = &one_bit_adc_dac_read_raw,
> > +	.write_raw = &one_bit_adc_dac_write_raw,
> > +};
> > +
> > +static int one_bit_adc_dac_set_ch(struct iio_dev *indio_dev,
> > +					struct iio_chan_spec *channels,
> > +					const char *propname,
> > +					int num_ch,
> > +					enum ch_direction direction,
> > +					int offset)
> > +{
> > +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> > +	const char **gpio_names;
> > +	int ret, i;
> > +
> > +	if (num_ch <= 0)
> > +		return 0;
> > +
> > +	gpio_names = devm_kcalloc(indio_dev->dev.parent,
> > +					num_ch,
> > +					sizeof(char *),  
> sizeof(*gpio_names). It might be better to use normal kcalloc, kfree 
> here since you only use it in this function.

Definitely.

> > +					GFP_KERNEL);
> > +	if (!gpio_names)
> > +		return -ENOMEM;
> > +
> > +	ret = device_property_read_string_array(&st->pdev->dev,
> > +					propname,
> > +					gpio_names,
> > +					num_ch);
Take advantage of the new longer acceptable line length (100 chars)
to make some of these more readable.

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (i = 0; i < num_ch; i++) {
> > +		channels[i] = (struct iio_chan_spec)ONE_BIT_ADC_DAC_CHANNEL(i +
> > +							offset,
> > +							direction);
> > +		channels[i].extend_name = gpio_names[i];  
> I think we want to avoid using extend_name in new drivers because it 
> makes for a very clumsy ABI. We should add a label property like we have 
> for the device for channels to have a symbolic name of the channel.

Agreed. It keeps getting talked about, but no patches yet IIRC.

I'd expect separate indexing for input and output channels.
The in / out distinguishes them.

in_voltage0_raw
out_voltage0_raw etc


> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev)
> > +{
> > +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> > +	struct iio_chan_spec *channels;
> > +	int ret, in_num_ch = 0, out_num_ch = 0;
> > +
> > +	st->in_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
> > +						"in", GPIOD_IN);
> > +	if (IS_ERR(st->in_gpio_descs))
> > +		return PTR_ERR(st->in_gpio_descs);
> > +
> > +	if (st->in_gpio_descs)
> > +		in_num_ch = st->in_gpio_descs->ndescs;
> > +
> > +	st->out_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
> > +						"out", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->out_gpio_descs))
> > +		return PTR_ERR(st->out_gpio_descs);
> > +
> > +	if (st->out_gpio_descs)
> > +		out_num_ch = st->out_gpio_descs->ndescs;
> > +
> > +	channels = devm_kcalloc(indio_dev->dev.parent, (in_num_ch + out_num_ch),
> > +				sizeof(struct iio_chan_spec), GFP_KERNEL);  
> 
> sizeof(*channels) to avoid accidentally using the wrong type.
> 
> > +	if (!channels)
> > +		return -ENOMEM;
> > +
> > +	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[0],
> > +					"in-gpio-names", in_num_ch,
> > +					CH_IN, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[in_num_ch],
> > +					"out-gpio-names", out_num_ch,
> > +					CH_OUT, in_num_ch);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	indio_dev->channels = channels;
> > +	indio_dev->num_channels = in_num_ch + out_num_ch;
> > +
> > +	return 0;
> > +}
> > +
> > +static int one_bit_adc_dac_probe(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct one_bit_adc_dac_state *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->pdev = pdev;
> > +	indio_dev->dev.parent = &pdev->dev;  
> parent assignment should not be needed thanks to Alex's work.
> > +	indio_dev->name = "one-bit-adc-dac";
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &one_bit_adc_dac_info;
> > +
> > +	ret = one_bit_adc_dac_parse_dt(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, indio_dev);  
> 
> There does not seem to be a matching get_drvdata() anywhere so this is 
> not needed.
> 
> > +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > +}
> > +
> > +static const struct of_device_id one_bit_adc_dac_dt_match[] = {
> > +	{ .compatible = "adi,one-bit-adc-dac" },

This is definitely not ADI specific.  It also currently looks
like a policy thing rather than truely defined by the wiring.
Hence I'd kind of expect to see it instantiated via configfs
rather than a dt binding.

Note this would definitely need a dt binding doc if done this way.
My gut feeling is that as it stands, it would go nowhere.



> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
> > +
> > +static struct platform_driver one_bit_adc_dac_driver = {
> > +	.driver = {
> > +		.name = "one-bit-adc-dac",
> > +		.of_match_table = one_bit_adc_dac_dt_match,
> > +	},
> > +	.probe = one_bit_adc_dac_probe,
> > +};
> > +
> > +module_platform_driver(one_bit_adc_dac_driver);
> > +
> > +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices ONE_BIT_ADC_DAC");
> > +MODULE_LICENSE("GPL v2");  
> 
> 


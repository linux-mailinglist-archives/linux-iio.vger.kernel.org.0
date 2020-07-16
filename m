Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22459221FA2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgGPJZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 05:25:41 -0400
Received: from www381.your-server.de ([78.46.137.84]:34946 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPJZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 05:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u5afwLQ4bTJ2L6PgOK+WAAnynA84GEc3NeAsN62Ya1c=; b=QZD5YOJf93Gn9yw5UqCnh/iXWx
        TwMBFVZXlf/J45jEjXKTcSc0bhOmDyDVSZzrXo9g2ix90HrMmE6huHOwNoC0G7yffCmlGZFqtxks7
        X4PqRMVLwyT8KCakQxCw8qNb38RVz5sH0GqDMyL0kUxoGLnByjHwoqTZSlLIibk+a6L8ryGaL5Uas
        BmHhamjoyEuYj3kZgEBI5Q3lgNQUXavK9i6qwidpk97FadfaWDJrxAwTQBJsXJI2bJiwCPXuVgdH0
        Z8L+YnnHtT4qA8B9ckGtuBCHPwfreu5Gxgnu7jy1jZ2KBUppaFNbiroFbK3VSxh2k+leaHC4hOm8Y
        F6v/r+iQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jw092-0001FK-VR; Thu, 16 Jul 2020 11:25:37 +0200
Received: from [2a01:598:b880:d18a:2462:7ce5:9424:a9d7]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jw092-000Pau-Q1; Thu, 16 Jul 2020 11:25:36 +0200
Subject: Re: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit ADC,
 DAC
To:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20200716072737.9535-1-cristian.pop@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9bd0363c-e8fb-a36f-a107-0afd8f7851d0@metafoo.de>
Date:   Thu, 16 Jul 2020 11:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716072737.9535-1-cristian.pop@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.3/25874/Wed Jul 15 16:18:08 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/16/20 9:27 AM, Cristian Pop wrote:
> Implementation for 1-bit ADC (comparator) and a 1-bit DAC (switch)

Very sneaky way of introducing a iio-gpio-proxy driver to be able to 
access GPIOs through libiio ;). I'm not really a fan of the whole idea.

But either way I think this needs a better description of what 1-bit 
converters are and how they are used.

>
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>   drivers/iio/addac/one-bit-adc-dac.c | 229 ++++++++++++++++++++++++++++
>   1 file changed, 229 insertions(+)
>   create mode 100644 drivers/iio/addac/one-bit-adc-dac.c
>
> diff --git a/drivers/iio/addac/one-bit-adc-dac.c b/drivers/iio/addac/one-bit-adc-dac.c
> new file mode 100644
> index 000000000000..8e2a8a09fedb
> --- /dev/null
> +++ b/drivers/iio/addac/one-bit-adc-dac.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ONE_BIT_ADC_DAC
> + * Digital to Analog Converters driver
> + *
> + * Copyright 2019 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +
> +enum ch_direction {
> +	CH_IN,
> +	CH_OUT,
> +};
> +
> +struct one_bit_adc_dac_state {
> +	struct platform_device  *pdev;
> +	struct gpio_descs       *in_gpio_descs;
> +	struct gpio_descs       *out_gpio_descs;
> +};
> +
> + #define ONE_BIT_ADC_DAC_CHANNEL(idx, direction)			\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = idx,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.output = direction,					\
> +	}
> +
> +static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	int in_num_ch = 0, out_num_ch = 0;
> +	int channel = chan->channel;
> +
> +	if (st->in_gpio_descs)
> +		in_num_ch = st->in_gpio_descs->ndescs;
> +
> +	if (st->out_gpio_descs)
> +		out_num_ch = st->out_gpio_descs->ndescs;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel < in_num_ch) {
> +			*val = gpiod_get_value_cansleep(
> +				st->in_gpio_descs->desc[channel]);
> +		} else {
> +			channel -= in_num_ch;
> +			*val = gpiod_get_value_cansleep(
> +				st->out_gpio_descs->desc[channel]);
> +		}
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long info)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	int in_num_ch = 0, out_num_ch = 0;
> +	int channel = chan->channel;
> +
> +	if (st->in_gpio_descs)
> +		in_num_ch = st->in_gpio_descs->ndescs;
> +
> +	if (st->out_gpio_descs)
> +		out_num_ch = st->out_gpio_descs->ndescs;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel < in_num_ch) {
> +			gpiod_set_value_cansleep(
> +				st->in_gpio_descs->desc[channel], val);

How can we set a value on an input GPIO?

> +		} else {
> +			channel -= in_num_ch;
> +			gpiod_set_value_cansleep(
> +				st->out_gpio_descs->desc[channel], val);
> +		}
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info one_bit_adc_dac_info = {
> +	.read_raw = &one_bit_adc_dac_read_raw,
> +	.write_raw = &one_bit_adc_dac_write_raw,
> +};
> +
> +static int one_bit_adc_dac_set_ch(struct iio_dev *indio_dev,
> +					struct iio_chan_spec *channels,
> +					const char *propname,
> +					int num_ch,
> +					enum ch_direction direction,
> +					int offset)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	const char **gpio_names;
> +	int ret, i;
> +
> +	if (num_ch <= 0)
> +		return 0;
> +
> +	gpio_names = devm_kcalloc(indio_dev->dev.parent,
> +					num_ch,
> +					sizeof(char *),
sizeof(*gpio_names). It might be better to use normal kcalloc, kfree 
here since you only use it in this function.
> +					GFP_KERNEL);
> +	if (!gpio_names)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_string_array(&st->pdev->dev,
> +					propname,
> +					gpio_names,
> +					num_ch);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < num_ch; i++) {
> +		channels[i] = (struct iio_chan_spec)ONE_BIT_ADC_DAC_CHANNEL(i +
> +							offset,
> +							direction);
> +		channels[i].extend_name = gpio_names[i];
I think we want to avoid using extend_name in new drivers because it 
makes for a very clumsy ABI. We should add a label property like we have 
for the device for channels to have a symbolic name of the channel.
> +	}
> +
> +	return 0;
> +}
> +
> +static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels;
> +	int ret, in_num_ch = 0, out_num_ch = 0;
> +
> +	st->in_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
> +						"in", GPIOD_IN);
> +	if (IS_ERR(st->in_gpio_descs))
> +		return PTR_ERR(st->in_gpio_descs);
> +
> +	if (st->in_gpio_descs)
> +		in_num_ch = st->in_gpio_descs->ndescs;
> +
> +	st->out_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
> +						"out", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->out_gpio_descs))
> +		return PTR_ERR(st->out_gpio_descs);
> +
> +	if (st->out_gpio_descs)
> +		out_num_ch = st->out_gpio_descs->ndescs;
> +
> +	channels = devm_kcalloc(indio_dev->dev.parent, (in_num_ch + out_num_ch),
> +				sizeof(struct iio_chan_spec), GFP_KERNEL);

sizeof(*channels) to avoid accidentally using the wrong type.

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[0],
> +					"in-gpio-names", in_num_ch,
> +					CH_IN, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[in_num_ch],
> +					"out-gpio-names", out_num_ch,
> +					CH_OUT, in_num_ch);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = in_num_ch + out_num_ch;
> +
> +	return 0;
> +}
> +
> +static int one_bit_adc_dac_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct one_bit_adc_dac_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->pdev = pdev;
> +	indio_dev->dev.parent = &pdev->dev;
parent assignment should not be needed thanks to Alex's work.
> +	indio_dev->name = "one-bit-adc-dac";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &one_bit_adc_dac_info;
> +
> +	ret = one_bit_adc_dac_parse_dt(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);

There does not seem to be a matching get_drvdata() anywhere so this is 
not needed.

> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +}
> +
> +static const struct of_device_id one_bit_adc_dac_dt_match[] = {
> +	{ .compatible = "adi,one-bit-adc-dac" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
> +
> +static struct platform_driver one_bit_adc_dac_driver = {
> +	.driver = {
> +		.name = "one-bit-adc-dac",
> +		.of_match_table = one_bit_adc_dac_dt_match,
> +	},
> +	.probe = one_bit_adc_dac_probe,
> +};
> +
> +module_platform_driver(one_bit_adc_dac_driver);
> +
> +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ONE_BIT_ADC_DAC");
> +MODULE_LICENSE("GPL v2");



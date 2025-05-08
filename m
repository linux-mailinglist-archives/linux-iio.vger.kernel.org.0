Return-Path: <linux-iio+bounces-19331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E71AB0117
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191EA4A4CC7
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3871284674;
	Thu,  8 May 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lYOOKlQm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDE27EC97
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724115; cv=none; b=rGlZ0buv0axoeFLlGC9PlC7T5e2Q++hmxI9xiPZ0oizmtgV7jmpx5JmasRq0P00m1zJsRNSnNFetQroO6jocw1kKU3Pq4f5DNhDQOGaTlYTYpDt/6xQLBKDSw6kIZF4J6lnVfqazeBtSXlIoEb/x3/37EeFcU73kujBveb5Hzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724115; c=relaxed/simple;
	bh=em1tBnp4kQIsPEMpgWGL3qmfzkLWzjP/R1DFPNhDwXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ra/Jfb2Khp0MQvUg6ZjJ/qiBL80alm8yUY+MSZ7TVTTAdfz+73ZJv/b2DZHoB0gIltDuoZdVqlJeIeAJzGc/DnHr8UoqJCyDRKaA/QxU8mq8jpC/Ax9Cm/8XAYFtUqbZZjDFnziQ96hnany2k8eaIBBrVayF3hda0SvEgrjEYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lYOOKlQm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so499145fac.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746724112; x=1747328912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2YwqdISc2dwotWslccRbFlYjhHoFULc/EFeRMMYP7A=;
        b=lYOOKlQmtgsy4J3ZTuYOhUEQxkwC9HYDx7ESXr6Fn8+AzW+gzq7nbEhpN6iGBFIz8y
         L5ZeI16IdnUnrlTTdl0U4u2tOMcTCVrLc4KPMPpcd8c+IehkPhE+o0M45T6vUrcPAO+h
         +aELMCf9umy5IBakpiV4JHzVWlZen0XfowxwwzzJ1EQJf1sN7Ct2mZ9LIirY3fHxOkku
         FFUnFigmB6BPksnOhSxQScE/5IvUvOh45kNd+FaOcHL0iVqB4pO2r15KjzziMpC81ZMN
         rJ4OWBdj0jS0Bpr78kcfRMJrsnZ0lclr1XvnRacCJ5IyGlS7pbLiyTHaVLH2ySsbqRSz
         66hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746724112; x=1747328912;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2YwqdISc2dwotWslccRbFlYjhHoFULc/EFeRMMYP7A=;
        b=Z63EkfYod8aompeY56Ce36qCKBYePwBhc85blSC0SfUIlW6hFq+elb3aNxUw4L1NDW
         tPAqgu/YCetRzxubni4V0hexmauJ1oqhUxqnKyQnLPWNkFeZxABt1x30G6JsY/qiFoT+
         sGO+/cdqDnkQrEZ7XEG4w6TUKzX2GEkllFWwxndMUOekYQPLi0SvZCMeOIIkr1AKJNwz
         9xaNnpV0zD3licQQPvbr5xvnD8eMmbXlxfHstdHEZKG0grQH3wuJ2Gywg6IyGDVL/Yr3
         BtSR8IREMAFijqcnvVIiRdgXnPKdwY55iURNCNke/zYIowj/BkfDmjpEPeZE59PzIBWy
         VJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVIG3/+/XFO8AL+hgdm/MmxWc0MIi3rH4YV2jf6EHy+EiOLQQcYcOQS2uXYTRBZJmlhSGSPs5fpBps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBchMRjrI29fp9SAZixOW0nysRCmXXzViEoaKrHlzVRGQmUhia
	U8cgYVErEATzMkSkvl2A3FKkyCEa+5iiP4uz23ghxOfXEfX/4pN3NDPhcuXTLDE=
X-Gm-Gg: ASbGncuXDhLe5pJrGP97X6A4t1e7xUHJVTYK9RsKDQwZ5M1UDInI4PM2sWiR5qDv8dt
	b+8NXqKNlwFhZbJHlKfS7c5pjF/CVgRqX5+hQBy1hKvc1DQXMw08T5Re1R3oFzxBsz7QYG6sbwW
	fxniDY5Pv/c46oCVR2yAnJjB6/OXI2x+7qWwqBNcKtOKCnjOBVa6PzM0qQ75bXgrDM1Yn7xkPai
	7bc+4qrnpafj60mTCDVxl2FaAxNRbKq/BN9gugXFcagHrqTkSsaWmfCJfLoUYBtolLmJR3eLWfk
	FLt3C94wF3+5boF3uI/7hRJ7Ac4sFVEW9f77M/LdAD95eweKJxhrNx7pZudAI3TEgXjJ+Ve5HRn
	hjGtnz7bDf7wRXUOW7w==
X-Google-Smtp-Source: AGHT+IEZ+CmWCUftoE4zJdFAG3HGArWNL3h8+sxMJvLhQ5GkZUsH+fOr4x43LX9y5yNz8F92yCwSuw==
X-Received: by 2002:a05:6871:5827:b0:2d9:45b7:8ff4 with SMTP id 586e51a60fabf-2dba44dc797mr180877fac.26.1746724111971;
        Thu, 08 May 2025 10:08:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba061c18fsm156268fac.9.2025.05.08.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 10:08:31 -0700 (PDT)
Message-ID: <4fb74419-51bf-4294-82bf-545504ad0c3f@baylibre.com>
Date: Thu, 8 May 2025 12:08:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7405: add ad7405 driver
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
 <20250508123107.3797042-5-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508123107.3797042-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/25 7:30 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

...

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..5fe36ce61819
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +const unsigned int ad7405_dec_rates[] = {
> +	4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};
> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	unsigned int max_rate;
> +	struct iio_chan_spec channel[];

Since there is only one channel, we can drop the [] here.

> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	/* lock to protect multiple accesses to the device registers */
> +	struct mutex lock;

This lock isn't used and can be removed.

> +	const struct ad7405_chip_info *info;
> +	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];
> +	unsigned int sample_frequency;
> +	unsigned int ref_frequency;
> +};
> +
> +static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
> +		st->sample_frequency_tbl[i] =
> +			DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);
> +}
> +
> +static int ad7405_set_sampling_rate(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int samp_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	unsigned int dec_rate, idx;
> +	int ret;
> +
> +	dec_rate = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, samp_rate);
> +
> +	idx = find_closest_descending(dec_rate, ad7405_dec_rates,
> +				      ARRAY_SIZE(ad7405_dec_rates));
> +
> +	dec_rate = ad7405_dec_rates[idx];
> +
> +	ret = iio_backend_oversampling_ratio_set(st->back, 0, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_frequency = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, dec_rate);
> +
> +	return 0;
> +}
> +
> +static int ad7405_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {

This is missing an implementation for IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET.

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sample_frequency;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 1)
> +			return -EINVAL;
> +		return ad7405_set_sampling_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*vals = st->sample_frequency_tbl;
> +			*length = ARRAY_SIZE(st->sample_frequency_tbl);
> +			*type = IIO_VAL_INT;
> +			return IIO_AVAIL_LIST;
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static void ad7405_clk_disable_unprepare(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static const struct iio_info ad7405_iio_info = {
> +	.read_raw = &ad7405_read_raw,
> +	.write_raw = &ad7405_write_raw,
> +	.read_avail = &ad7405_read_avail,
> +};
> +
> +#define AD7405_IIO_CHANNEL {							\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\

Would it make more sense to use IIO_CHAN_INFO_OVERSAMPLING_RATIO for controlling
the decimation rate and have IIO_CHAN_INFO_SAMP_FREQ be read-only?

Maybe also useful to have a read-only filter_type attribute to say that the
backend is providing a sinc3 filter?

> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET),					\
> +	.indexed = 1,								\
> +	.channel = 0,								\
> +	.channel2 = 1,								\
> +	.differential = 1,							\
> +	.scan_index = 0,							\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info = {
> +		.name = "AD7405",
> +		.channel = {
> +			AD7405_IIO_CHANNEL,
> +		},
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info = {
> +		.name = "ADUM7701",
> +		.channel = {
> +			AD7405_IIO_CHANNEL,
> +		},
> +};
> +
> +static const char * const ad7405_power_supplies[] = {
> +	"vdd1",	"vdd2",
> +};
> +
> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	const struct ad7405_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
> +					     ad7405_power_supplies);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = devm_add_action_or_reset(dev, ad7405_clk_disable_unprepare, clk);

devm_clk_get_enabled() already make sure the clock is disabled when the dirver
is removed, so this is not needed.

> +	if (ret)
> +		return ret;
> +
> +	st->ref_frequency = clk_get_rate(clk);
> +	if (!(st->ref_frequency))

Inner () not needed.

> +		return -EINVAL;
> +
> +	ad7405_fill_samp_freq_table(st);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = chip_info->name;
> +	indio_dev->channels = chip_info->channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad7405_iio_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret = iio_backend_chan_enable(st->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7405_set_sampling_rate(indio_dev, &indio_dev->channels[0],
> +				       chip_info->max_rate);

max_rate is never set, so will always be 0.

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id ad7405_of_match[] = {
> +	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
> +	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7702", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7703", .data = &adum7701_chip_info, },
> +	{ /* end of list */ },

	{ }

We standardized on this style in the IIO subsystem.

> +};
> +MODULE_DEVICE_TABLE(of, ad7405_of_match);
> +
> +static struct platform_driver ad7405_driver = {
> +	.driver = {
> +		.name = "ad7405",
> +		.owner = THIS_MODULE,
> +		.of_match_table = ad7405_of_match,
> +	},
> +	.probe = ad7405_probe,
> +};
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");



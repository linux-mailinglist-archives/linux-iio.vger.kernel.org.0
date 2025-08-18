Return-Path: <linux-iio+bounces-22927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E2B2AC77
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5F318A1A56
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8224DD01;
	Mon, 18 Aug 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vbhlxq45"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55461233727
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530128; cv=none; b=bbsG5b7jJP/V0RnuImqTZrnXXKqaUZ3R8YT78jnmYqUG+H6RZWv78ZxNxiRhNa+UpYwUHmaCeqooNbgzqmhufZQGsgSwLyjlnEh1rgy7v1d2P6MAt6PvtvhRqVBi82bs0dLJ+9O8wwdMw1bf0RYlbAYbdD1fmfsKcxY5VumG1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530128; c=relaxed/simple;
	bh=YUzSS0tMH4Lq6dvFjtrqpGRKZ3/fBTf3Sv/BZoWFalk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZACxEntpsPuJBS7rCoHkxiNYgCyvfZw8kSc55lbjHjor5dHZEMdyadpr4rVZ/Wjvc8tfh5LtM8nW5njCju9xTR3JwGtTPVPCGfleQ5GRGrjhuDVcArwrENkNGBDjojQYbUamImV9DgUQGP7Fj53Sk9/oBEy8V2Sm4H9kigjTF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vbhlxq45; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74382041c9eso2126706a34.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530125; x=1756134925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx5f0xAbVvUAkSbSeLOjDbq5b/QH3eN1AqJzxGe0lPg=;
        b=Vbhlxq451x67B+liVgebADFE7ImDp6Lx9XcWm++eOxngDIpvuW7F489XYtID3b8yFp
         0J33SgYjB62ImnY+hIGZ/xaGEc7W01z3X2hpvRQ2ecfZ8j9u9cZ6dIl6oT2UfbNjxKjd
         F7hiUD7jHjLYATyYmsdiESMclV4Y1AQbq/YKwEr1YGd/U9cYlqkLaAxe677aS/2VHNI+
         EsTqINM9pZvQwDsnEDwnBDKso9b3vUV+FoAfD4ivqwPHjOD+9nj12XXVIX8bxCUmattM
         LEEXpGP14mQy1hSkV16VCCrBPirEFmk+mIExJQmRDlS0jTyILkxEReSJfySxYRV/8WCv
         1VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530125; x=1756134925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rx5f0xAbVvUAkSbSeLOjDbq5b/QH3eN1AqJzxGe0lPg=;
        b=ufcXgyCcm+ajk5M7FoUK5pflfSk5kWN8YIcLPC52r2Mip9PEiT0lG8iEJR7s/n4sKw
         K2TmuBEpmRGgv1yr3Nh3viOQU+tw4pamW9wfocBqbXkEKTtKEsP2TceFjG9+KtdHL/7M
         Ia09bICItFGHTEt5sznFuFjJ6PgLK/W3oOvpw2baPtK+71t+tOxScgF3F0Grg1M4c/up
         hvJW6BaPLAFPGZDN42kxBOjwvdQUVmrpB6jqaPwezqiYjuqSeqpWnzt7BCSIxbg4DzJl
         mOwAvh6JM5aTvFyt/fKBmB3nSYKbd7ZtZccQmtyX1b7dXGESjFQkK9eSzEIw3KIX/eYW
         MVyg==
X-Forwarded-Encrypted: i=1; AJvYcCV56SHMALSw9/BNcaHKyUW0RAtn7sUwbF0lRQbz/PSJOclgnhX1PH9z4zSl7AaYAqzD1aiaLbwXGqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefPKDJTm3g52bQWgViLaYLvX20m64r5EbghWdAvpAwXU2pXsX
	iX3ru0snsqtJ/AwS1tN03D3QwOD5AsKOWiHPn0yTIp6mvbh1uSqpyiH9F6/3EFgsL6M=
X-Gm-Gg: ASbGnctGzzqU4lV4uiezCLuRa4T56lanl8rfbCPCzyoYILXW0D4003nNax7GM1TA+SW
	nUx58A1xpndaRxMev/JH31lFX7JVGFDms+/gsh7Bpzo1DX55tzTJlx7BdaR0m1Jx9EbdSj22Bp1
	LLxVFdOKnKsq5I6Q+Bqj/P4jjjCOsplR44OrIjw/tB7S3TVNdSj4hU8kuIyF7Rk8GrxhJ/nsmab
	pp0u+6yZYNXkf512RZVYhLQlFr083sSZDl2xOqY1qorIsNr3PtPageSTXCUlHhbMBY4lQWf1fvd
	/bEItrq7TsX60PLXCZwykWTc813E4j56z2xKFWYrJiZbC+At+trRC8EYRSlcr1y7j1mdhlFx0Qx
	rhZCTXIqtVoPEcml0rUSQKzRCKXucsd3/2hfmnIiGPosqU87GPZe3wuIKZS6DeXE19tDr3vKBVl
	Yyr/YwTTmP5g==
X-Google-Smtp-Source: AGHT+IHb9rH2wLfVz0O8elzP2+rT3F9w2k8wvdCdA9WSm2W7n0uohkYyH7F+p03AyGk3vMxrFUDpig==
X-Received: by 2002:a05:6830:2692:b0:741:924c:3f60 with SMTP id 46e09a7af769-74392487172mr8034059a34.20.1755530125226;
        Mon, 18 Aug 2025 08:15:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b4fesm1901272a34.30.2025.08.18.08.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:15:24 -0700 (PDT)
Message-ID: <eb9c06de-04e2-427f-9c04-eaaaf4837da6@baylibre.com>
Date: Mon, 18 Aug 2025 10:15:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: adc: update ad7779 to use IIO backend
To: Ioana Risteiu <Ioana.Risteiu@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
 <20250818131253.8854-5-Ioana.Risteiu@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818131253.8854-5-Ioana.Risteiu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 8:12 AM, Ioana Risteiu wrote:
> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  drivers/iio/adc/ad7779.c | 107 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index f7e681c0e8c0..abf3fff20dd4 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -31,6 +31,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> +#include <linux/iio/backend.h>

This should be grouped in alphabetical order with other
linux/iio/ includes.

> +
>  #define AD7779_SPI_READ_CMD			BIT(7)
>  
>  #define AD7779_DISABLE_SD			BIT(7)
> @@ -157,6 +159,8 @@ struct ad7779_state {
>  	u8			reg_rx_buf[3];
>  	u8			reg_tx_buf[3];
>  	u8			reset_buf[8];
> +
> +	struct iio_backend *back;

This field needs to be placed in the struct before
__aligned(IIO_DMA_MINALIGN) to avoid issues cache lines.

>  };
>  
>  static const char * const ad7779_filter_type[] = {
> @@ -630,12 +634,38 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
>  	return ret;
>  }
>  
> +static int ad7779_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +
> +	for (c = 0; c < AD7779_NUM_CHANNELS; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct iio_info ad7779_info = {
>  	.read_raw = ad7779_read_raw,
>  	.write_raw = ad7779_write_raw,
>  	.debugfs_reg_access = &ad7779_reg_access,
>  };
>  
> +static const struct iio_info ad7779_info_data = {
> +	.read_raw = ad7779_read_raw,
> +	.write_raw = ad7779_write_raw,
> +	.debugfs_reg_access = &ad7779_reg_access,
> +	.update_scan_mode = &ad7779_update_scan_mode,
> +};
> +
>  static const struct iio_enum ad7779_filter_enum = {
>  	.items = ad7779_filter_type,
>  	.num_items = ARRAY_SIZE(ad7779_filter_type),
> @@ -674,6 +704,7 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
>  
>  #define AD777x_CHAN_FILTER_S(index)					\
>  	AD777x_CHAN_S(index, ad7779_ext_filter)
> +

Unrelated blank line add (should not be in this patch).

>  static const struct iio_chan_spec ad7779_channels[] = {
>  	AD777x_CHAN_NO_FILTER_S(0),
>  	AD777x_CHAN_NO_FILTER_S(1),
> @@ -752,6 +783,44 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
>  	return 0;
>  }
>  
> +static int ad7779_set_data_lines(struct iio_dev *indio_dev,
> +				 unsigned int num_lanes)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DOUT_FORMAT_MSK,
> +				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
> +}
> +
> +static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> +{
> +	struct iio_chan_spec *channels;
> +	struct device *dev = &st->spi->dev;
> +
> +	channels = devm_kmemdup_array(dev, st->chip_info->channels,
> +					ARRAY_SIZE(ad7779_channels),
> +					sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)
> +		channels[i].scan_type.endianness = IIO_CPU;
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}
> +
>  static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
>  {
>  	int ret;
> @@ -796,6 +865,38 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
>  }
>  
> +static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret = -EINVAL;
> +	int num_lanes;
> +
> +	indio_dev->info = &ad7779_info_data;
> +
> +	ret = ad7779_setup_channels(indio_dev, st);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get iio backend");
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +

The usual way of doing this is to set num_lanes = 4 here.

> +	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
> +	if (ret)

It is best to not ignore all errors. So typically, we would have

	if (ret && ret != -EINVAL)
		return ret;

here. In the -EINVAL case, the default we set above will be used.

We should also validate that the value is 1, 2 or 4 so that later
calculations that use this are valid.

> +		return ad7779_set_data_lines(indio_dev, 4);
> +
> +	return ad7779_set_data_lines(indio_dev, num_lanes);

Then we don't have to have 2 calls to the same function.

> +}
> +
>  static int ad7779_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -848,7 +949,10 @@ static int ad7779_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
>  
> -	ret = ad7779_setup_without_backend(st, indio_dev);
> +	if (device_property_present(dev, "io-backends"))
> +		ret = ad7779_setup_backend(st, indio_dev);
> +	else
> +		ret = ad7779_setup_without_backend(st, indio_dev);
>  
>  	if (ret)
>  		return ret;
> @@ -943,3 +1047,4 @@ module_spi_driver(ad7779_driver);
>  MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");



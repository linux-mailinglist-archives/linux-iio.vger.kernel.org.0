Return-Path: <linux-iio+bounces-22983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FAB2C685
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E0B7A5838
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742DD2147E6;
	Tue, 19 Aug 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PGEkbVgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0996204F8C
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612344; cv=none; b=ilv2qp5h16VsTcvkFK/B8tes2iK4bJD0Eevau0mQp4OPkU6w07E1a9RkOSDLYYUpBrshLx2m7ctquVSVSlh59aJ0yRGPKg1EAmIDjqn/qJn6IyPyTt/vgGMKwXQ+ZDNqM55iBFP2+pcHGK8ih5NbrzTt0NIfyQibsuM0YKWLDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612344; c=relaxed/simple;
	bh=U9I9HNEp0+4Gz5xEHfaKauD4IVv3OHGVKeBcb/I6od0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQG9bxSGMPpP6S+FUGo8EYCq7HX2dEk9kaB+ACh6i36Z9nONP4SghRTXBGKtBgwlSC+I/abN6jh6oYi+Q1YCn2LmIqwmnrLCcRs6aArT6Pm3kWfMeLPiiyEkvTTz2gpDKbQwUHky+tWRZvOXOkTW9CoopySrZ7NcSnLIOBfIEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PGEkbVgu; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61c0b19b14bso648163eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755612341; x=1756217141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7IXcxSq366tXdmeyBNegwQEPnHuF26aW6nAQ3VNfA0=;
        b=PGEkbVgu9NXAXUDLDXtM2rXxeLtnpVrPAkcJ5mgjaXoeAgOUoCSjmFAs0GNdsbCy8y
         rh9PIohRWXp2prWZScagkpBdU/56QhfPQ458HsSIu8lnuSAxLw8e1TuCaNNdQaMLvw+x
         alkDOGMtLgeX5LDJK8HttvHJ8SgdspKuv5E0/ITZs2DmlV7L+/+SzkKnW9T3d4T/dfFs
         qoa1NU8v2m3U2NQEjhLW7OdXa5/Mw8VGzTiIUWjzx0QXhpkt45Q8C3Tf2piJxNzzhvMI
         J6BdE7tGcgSI+BGu6uLZERCgujRPjKOA4sziYzJYuO72rtLBRSqYBtI1G+mAUulwqQ1m
         MIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612341; x=1756217141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7IXcxSq366tXdmeyBNegwQEPnHuF26aW6nAQ3VNfA0=;
        b=EpKB/IrH6m56jxLHq2GPOsvqdksyqQnuoMttb/gnwgjTSU0lI6x1mocWk7YM8P8sWW
         LPECmUW7fixDPcYNCyhT31+LUIB1PLIAKZrBsYtx+iXLcaX7lOkeJgI0wsdYuzHPIrRx
         7vtWXUd3l4hXZKvu++Ehb1PRpj+FgcFhUZumWmdHzvtk3e2yry30DiEE7s73K2tRiB0k
         rLVcUv6XzBsSELuZulCjjYaZbOVKNzx/o+yvlJs3T4JxNPVKseOHofGNygryPPyQEbrV
         kdttMe/3LMi4sK3wtdY4K2E2l0nD2hq5+8Tikr1viBunecfn7LlcsRQPkkXrQiScFZ9f
         i2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWy+XbSodKADFkECRM2aaU2Z1SBxymcm6sBCctr7iBsyMMmgqvqPhBR5GVbKQJ5+/sjMFfUYRfhBtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIupqnS4EkGgFy/DkaBW1A78P3751Jo+MVtEKGjuC2jnYfFSoy
	mSvko0I2wKJEyffOYVcLRNYdsQJe8d+aJsGEw416mSlYVdetxi+xBTFSV8VbMg2Xy0s=
X-Gm-Gg: ASbGncuIXfRvW1yuqjWFUmkiMiq+TGuSyNkM+/UcvC3cz58j9MPPAjEx4ua61vQ7r3z
	UFmyJtueiwuO+C7HtwJjfWs4WGAA2fY4mpxlEGIY2CdgRaGuzoeLGXScvGAq7N3GADehR0QgoJu
	bFamKVisnPJPaE+f6qIMvYrLGe99jS8QLxB59vL9FdezHpZJqvRjDZA/a5cW+NT1XziXXabXEWW
	8DFiIuxryGgffYBO2we4Mrg0DORhDhPnumqRZbjeToFbIwx2Zkrnv0kfLvutC5t5f8wQsJlxoDp
	ej9mKD61t71AY7ui4H4YPmNPJQpI12xly6jWRHUkNw0yABnafUQhDNuPOrGWLPvMr4E07fD2lk+
	uXbytItrBMPjbViDL47pgAqKwZbuTA1bums3E2lOWAzZgUwKFNkaLVN9IgbHK1WyLH0nzCDY6As
	M=
X-Google-Smtp-Source: AGHT+IHjF7sm3BM6UqpsCOtViY+JAbenMV7/s4EAL5cMuLNS5sTyBZc8mLeIWMkrcU5gOa4R+PWZaQ==
X-Received: by 2002:a05:6820:2214:b0:61c:60:a68d with SMTP id 006d021491bc7-61d919f3ae6mr1887604eaf.6.1755612340610;
        Tue, 19 Aug 2025 07:05:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec14b3cesm1082668eaf.27.2025.08.19.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:05:40 -0700 (PDT)
Message-ID: <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
Date: Tue, 19 Aug 2025 09:05:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818183214.380847-7-bcollins@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:32 PM, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Use a filter_type[none, ema] for enabling the IIR filter.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 157 ++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 9b017820efc1..0ec47cbeb88c 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -31,6 +31,7 @@
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
>  #define MCP9600_SENSOR_CFG		0x05
>  #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
>  #define MCP9600_ALERT_CFG1		0x08
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> @@ -94,6 +95,27 @@ static const int mcp9600_tc_types[] = {
>  	[THERMOCOUPLE_TYPE_R] = 'R',
>  };
>  
> +enum mcp9600_filter {
> +	MCP9600_FILTER_TYPE_NONE,
> +	MCP9600_FILTER_TYPE_EMA,
> +};
> +
> +static const char * const mcp9600_filter_type[] = {
> +	[MCP9600_FILTER_TYPE_NONE] = "none",
> +	[MCP9600_FILTER_TYPE_EMA] = "ema",
> +};
> +
> +static const int mcp_iir_coefficients_avail[7][2] = {
> +	/* Level 0 is no filter */
> +	{ 0, 524549 },
> +	{ 0, 243901 },
> +	{ 0, 119994 },
> +	{ 0,  59761 },
> +	{ 0,  29851 },
> +	{ 0,  14922 },
> +	{ 0,   7461 },
> +};
> +
>  static const struct iio_event_spec mcp9600_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -118,7 +140,11 @@ static const struct iio_event_spec mcp9600_events[] = {
>  			.address = MCP9600_HOT_JUNCTION,		       \
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
>  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>  					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.info_mask_separate_available =                        \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +			.ext_info = mcp9600_ext_filter,			       \
>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
>  		},							       \
> @@ -134,6 +160,26 @@ static const struct iio_event_spec mcp9600_events[] = {
>  		},							       \
>  	}
>  
> +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan);
> +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      unsigned int mode);
> +
> +static const struct iio_enum mcp9600_filter_enum = {
> +	.items = mcp9600_filter_type,
> +	.num_items = ARRAY_SIZE(mcp9600_filter_type),
> +	.get = mcp9600_get_filter,
> +	.set = mcp9600_set_filter,
> +};
> +
> +static const struct iio_chan_spec_ext_info mcp9600_ext_filter[] = {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &mcp9600_filter_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			   &mcp9600_filter_enum),
> +	{ }
> +};
> +
>  static const struct iio_chan_spec mcp9600_channels[][2] = {
>  	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
>  	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
> @@ -161,6 +207,8 @@ struct mcp_chip_info {
>  struct mcp9600_data {
>  	struct i2c_client *client;
>  	u32 thermocouple_type;
> +	/* Filter enabled is 1-7, with 0 being off (filter_type none) */
> +	u8 filter_level;
>  };
>  
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -191,13 +239,45 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (data->filter_level == 0)
> +			return -EINVAL;

To implement Jonathan's request from v5, drop this error return.
We'll also need a separate bool data->is_filter_enabled field so
that we can keep the last set filter_level even when the filter
is disabled. (i.e. data->filter_level is never == 0).

This way, if you set the filter level, you can enable and disable
the filter via filter_type and still have the same filter level.

> +
> +		*val = mcp_iir_coefficients_avail[data->filter_level - 1][0];
> +		*val2 = mcp_iir_coefficients_avail[data->filter_level - 1][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (data->filter_level == 0)
> +			return -EINVAL;
> +
> +		*vals = (int *)mcp_iir_coefficients_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = 2 * ARRAY_SIZE(mcp_iir_coefficients_avail);
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -211,6 +291,7 @@ static int mcp9600_config(struct mcp9600_data *data)
>  
>  	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
>  			  mcp9600_type_map[data->thermocouple_type]);
> +	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level);

And change the logic here to:

	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->is_filter_enabled ?
		     data->filter_level : 0);

>  
>  	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
>  	if (ret < 0) {
> @@ -221,6 +302,79 @@ static int mcp9600_config(struct mcp9600_data *data)
>  	return 0;
>  }
>  
> +static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(mcp_iir_coefficients_avail); i++) {
> +			if (mcp_iir_coefficients_avail[i][0] == val &&
> +			    mcp_iir_coefficients_avail[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(mcp_iir_coefficients_avail))
> +			return -EINVAL;
> +
> +		data->filter_level = i + 1;
> +		return mcp9600_config(data);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +
> +	if (data->filter_level == 0)
> +		return MCP9600_FILTER_TYPE_NONE;
> +
> +	return MCP9600_FILTER_TYPE_EMA;
> +}
> +
> +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      unsigned int mode)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +
> +	switch (mode) {
> +	case MCP9600_FILTER_TYPE_NONE:
> +		data->filter_level = 0;

Don't touch data->filter_level here, just set data->is_filter_enabled = false.

> +		return mcp9600_config(data);
> +
> +	case MCP9600_FILTER_TYPE_EMA:
> +		if (data->filter_level == 0) {
> +			/* Minimum filter by default */
> +			data->filter_level = 1;

And similar, just set data->is_filter_enabled = true without changing filter_level.

> +			return mcp9600_config(data);
> +		}
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
>  {
>  	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
> @@ -358,6 +512,9 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
>  
>  static const struct iio_info mcp9600_info = {
>  	.read_raw = mcp9600_read_raw,
> +	.read_avail = mcp9600_read_avail,
> +	.write_raw = mcp9600_write_raw,
> +	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
>  	.read_event_config = mcp9600_read_event_config,
>  	.write_event_config = mcp9600_write_event_config,
>  	.read_event_value = mcp9600_read_thresh,



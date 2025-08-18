Return-Path: <linux-iio+bounces-22937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5FB2B00E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D837B2938
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F322517AC;
	Mon, 18 Aug 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDLT3/GZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B12848B1;
	Mon, 18 Aug 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540948; cv=none; b=KQg9lxMpZ+Ycs/zK+PrjjYjrSXWWP6NFoZmwLgotadMGMzT50d6w23lJgKz+Zzx0uDGreKiASHSiAuMmVWVT+Kgm55kgDB1BBz0a3t/ZnBx84irQDuNGibq1ZmwPRd9AwsCs0wOUprvb4atdF8upYq68+WprHZhq3BTk5vfdc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540948; c=relaxed/simple;
	bh=odLgDTeamPQYDBpCpYXj6ej/cyf7WDA70UFn23PbNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBAX/Wc7cU2GZN7RkLfD2yPSnOQCZ4CX6UPofvRErQEEhEuZJD6DbXZj13FrAPBhwFCzRTQP2Ru2SBEW/lkmmfGADylV9mHgLsel+lfjJeHqKt45yPNq7hPfCJU1XBZs/wNvbfABeSMTUdeAfx8yYH0KQgmX5DOTljuVcnrbiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDLT3/GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E2FC4CEEB;
	Mon, 18 Aug 2025 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540947;
	bh=odLgDTeamPQYDBpCpYXj6ej/cyf7WDA70UFn23PbNyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LDLT3/GZVR1EzeXpoEE3xp49aw8oqzunaYxMgZhp8Htoh0gGBQU6dvpnpEFeqorR0
	 eez38bta9rZPJF98Aic4El6OqxaFE0C/nUsThQrcoFYl+mcXGPGKQvfqNS98hhZw/9
	 kaH2lj+Rm2fPNDgMbGY3Ra0b7qTW5aDw4KuT3XTqbalrc/2Q5DhHQde1QVU4Xbn9f4
	 z1rll7srET4HelNsPmXKaKS7Lowz3PCvAaypUYsmvEMko9hWZzUp0j6C98BIbCqxws
	 Fg88+iAiYY8DPbakYkrHaprYLMACdE6DJVt15mKLePdXI9MTPDPaODKNQyRStZidr0
	 uWGvchF2RGfbA==
Date: Mon, 18 Aug 2025 19:15:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ben Collins
 <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250818191539.69e1882a@jic23-huawei>
In-Reply-To: <20250818035953.35216-6-bcollins@kernel.org>
References: <20250818035953.35216-1-bcollins@kernel.org>
	<20250818035953.35216-6-bcollins@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 23:59:53 -0400
Ben Collins <bcollins@kernel.org> wrote:

> From: Ben Collins <bcollins@watter.com>
> 
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Use a filter_type[none, ema] for enabling the IIR filter.
Hi Ben,

A few comments inline. You also need to send an additional patch to update
the filter_type docs in Documentation/ABI/testing/sysfs-bus-iio

Thanks,

Jonathan

> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 157 ++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index fa382a988a991..54bc657460e5d 100644
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

Probably just one space before \ is the most consistent choice.

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

shuffle the code around so you don't need a forward definition..
There is no particular reason I can see to have get and set later.

> +
> +static const struct iio_enum mcp9600_filter_enum = {
> +	.items = mcp9600_filter_type,
> +	.num_items = ARRAY_SIZE(mcp9600_filter_type),
> +	.get = mcp9600_get_filter,
> +	.set = mcp9600_set_filter,
> +};

>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -191,13 +239,45 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +

Unrelated changes. White space changes should not be mixed in a patch
doing anything significant.  If you want to do this, extra patch needed.

>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +
If you want the extra space put it in previous patch.

>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (data->filter_level == 0)

Return the current requested value. An error is just going to confuse
someone who tried to write this before enabling the filter and then
checked to see if the write was successful.

> +			return -EINVAL;
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
Don't block this.  It makes for a confusing interface.
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

That's the default so you shouldn't need a write_raw_get_fmt for this.

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
I'd use a separate enable flag for this.

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
> +		return mcp9600_config(data);
> +
> +	case MCP9600_FILTER_TYPE_EMA:
> +		if (data->filter_level == 0) {
> +			/* Minimum filter by default */
> +			data->filter_level = 1;
As above, I'd just let the user write it whenever they like
(default to 1 on boot) and then they have to see if it is
set to none to see whether it has an effect.

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



Return-Path: <linux-iio+bounces-22787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A8B28CBF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E820AC3FAC
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691828ECE1;
	Sat, 16 Aug 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/HHbTnV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8528E607;
	Sat, 16 Aug 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339312; cv=none; b=Kizh4IaAlv8bD4T10V7fk/etIw2AWWYhrKSjobapykKvzee5HXoGs9SlMFr7s0r8Skxj1wLGLEUAQa3nZejhjhMVWfPS852xMWew52o/zhcOd6fEuOpAlGu1bF/iGg6Jc/UcRwwPy72SDqvLVPAN8ZfZ8p0bIYn/YX6x1hgVsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339312; c=relaxed/simple;
	bh=z0ufMcym3P8lbUCGjA4fColIIiLdctpjv2CCx6NAb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvkkX+WufVF/TUAzZnsZGm3S4MHtxCkM4ESw9zag6F/3hHBsYmdNxeDta6OEL5hIpcwAeA4Xs5tEjMWGrio1rhwBYDHj3ONxOKEnx5quOB4pBUWKncmiG9kh7RflXTpXa3M83I2kg4xurgZtmk8cbR4hBwpzsf88dLbYFhAH+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/HHbTnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388EEC4CEF4;
	Sat, 16 Aug 2025 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339311;
	bh=z0ufMcym3P8lbUCGjA4fColIIiLdctpjv2CCx6NAb3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/HHbTnVJEMBiWI04GNKSOJXSUhKCQwasIJbCJ+gMWkJex9GDhO+e6RrUrhCTwNPN
	 Re4cPSCPmEfAUX2B6toYQ/bDTv8N0CjgG1GrXZ8oyr5o2XFn0XkGNHkMhEEoQuPLt0
	 eMUUIp1TpsLWoYU+SFBqFID76Z57cQTQZbdBoaORnaCO+c3uMcuIWDnkInLGhPGAqz
	 ecp2ksNyZY0RtoVo9VZdcXOqKtZiuBUlTSs7uFgI5gSM6UAap+k9Qlti9qdQ731BkB
	 +Myxiu6HxVMioFZlM4qQxBiBUdRKwiIXV52NghhaNWgtLfNVFLa0FZKYRNSp1sJuuI
	 edYJGfR2UUAJw==
Date: Sat, 16 Aug 2025 11:15:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250816111504.3ae0e3f3@jic23-huawei>
In-Reply-To: <20250815164627.22002-6-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-6-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:07 +0000
Ben Collins <bcollins@watter.com> wrote:

> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>

This needs a lot more description given these should be frequencies.
We identified recently that some other drivers have this wrong but
we should be looking to fix those if possible, not replicate it.

The infinite value does need some more discussion. Lets carry that
on in the v2 thread.

Jonathan


> ---
>  drivers/iio/temperature/mcp9600.c | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 361572a241f06..896520ddf6d3c 100644
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
> @@ -94,6 +95,10 @@ static const int mcp9600_tc_types[] = {
>  	[THERMOCOUPLE_TYPE_R] = 'R',
>  };
>  
> +static const int mcp_iir_coefficients_avail[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128,
> +};
> +
>  static const struct iio_event_spec mcp9600_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -118,7 +123,10 @@ static const struct iio_event_spec mcp9600_events[] = {
>  			.address = MCP9600_HOT_JUNCTION,		       \
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
>  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>  					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.info_mask_separate_available =                        \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
>  		},							       \
> @@ -161,6 +169,7 @@ struct mcp_chip_info {
>  struct mcp9600_data {
>  	struct i2c_client *client;
>  	u32 thermocouple_type;
> +	u8 filter_level; /* Chip default is 0 */
>  };
>  
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -191,13 +200,36 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
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
> +		*val = mcp_iir_coefficients_avail[data->filter_level];
> +		return IIO_VAL_INT;
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
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = mcp_iir_coefficients_avail;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(mcp_iir_coefficients_avail);
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -211,6 +243,7 @@ static int mcp9600_config(struct mcp9600_data *data)
>  
>  	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
>  			  mcp9600_type_map[data->thermocouple_type]);
> +	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level);
>  
>  	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
>  	if (ret < 0) {
> @@ -221,6 +254,43 @@ static int mcp9600_config(struct mcp9600_data *data)
>  	return 0;
>  }
>  
> +static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return IIO_VAL_INT;
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
> +			if (mcp_iir_coefficients_avail[i] == val)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(mcp_iir_coefficients_avail))
> +			return -EINVAL;
> +
> +		data->filter_level = i;
> +		return mcp9600_config(data);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
>  {
>  	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
> @@ -358,6 +428,9 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
>  
>  static const struct iio_info mcp9600_info = {
>  	.read_raw = mcp9600_read_raw,
> +	.read_avail = mcp9600_read_avail,
> +	.write_raw = mcp9600_write_raw,
> +	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
>  	.read_event_config = mcp9600_read_event_config,
>  	.write_event_config = mcp9600_write_event_config,
>  	.read_event_value = mcp9600_read_thresh,



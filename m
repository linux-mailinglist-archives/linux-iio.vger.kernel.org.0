Return-Path: <linux-iio+bounces-22786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A8B28CB3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC11B188541F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110228CF7A;
	Sat, 16 Aug 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH58IEp1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105F28BAA1;
	Sat, 16 Aug 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339093; cv=none; b=lAUb2jgzXGjfTXsdcpxgAhOqSpCQolrQmW2XTtS8N5HiYtKjLOHMzjYoe7Rzu/tjjSKQW1G09HQ3dZIOr06wtPS1h8o8rn2ZnYkMC+5UdrI0bMJ0Qds69M4MoRYMlQt2OJwyyKPfw+pCBCOmm89i73heokl6ptJF/j9iYaWUlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339093; c=relaxed/simple;
	bh=dLPQJvdWjRiW23Sx/pa6W0oENADGswiLJtMMHS12ad0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyB0KcZUhs/DMZxB86zWMD1l8qqZ0C1tStiM7IGgBYYJeHyHbhmWtO3QpK2gNhc8opskaKlwJ/1NTPSELRveod4cOEtnDCf2hQFj+YrDW1rcqMDpqyJINPJK7zI+/fWEjhQ6gaTeGkgn7F/vpa8uxyKTXs6jRiFRRUio19tYrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH58IEp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F5C4CEEF;
	Sat, 16 Aug 2025 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339093;
	bh=dLPQJvdWjRiW23Sx/pa6W0oENADGswiLJtMMHS12ad0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HH58IEp1xGsKw193Rt159L0ggHf74JjtVAqGz+/PiANIgdttbf2r48cOb2GW3aF8V
	 q5RgkLDCsLwIgLLBkXZcuxaJX0qGHzm6j8TNlHQ/eUqf4sJzsyla2k7tGzfkV4U2j0
	 UeX3VgMPa56WUrbHI+FuignXYt7nbvdD7TSjtBQiuaudYaw4lnTC+SOk/GTQxzhdVQ
	 fEmzMnWHd037UWoXtrftqk+lPYGDirXjt20Wa1B/81PYDcvdS1L9g8pc9oh0KN/3Qb
	 DNS5nGY7sRZB4Dp55EY3iDXgvatG93hKbIU6oqzpdDzxAroKPhGm2qM3XE+7NyU260
	 DLW8EY0I+hcfw==
Date: Sat, 16 Aug 2025 11:11:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
Message-ID: <20250816111125.65fcbb09@jic23-huawei>
In-Reply-To: <20250815164627.22002-5-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-5-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:06 +0000
Ben Collins <bcollins@watter.com> wrote:

> dt-bindings documentation for this driver claims to support
> thermocouple-type, but the driver does not actually make use of
> the property.
> 
> Implement usage of the property to configure the chip for the
> selected thermocouple-type.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
Hi Ben,

Just one trivial thing inline.

Thanks

Jonathan

> ---
>  drivers/iio/temperature/mcp9600.c | 69 +++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index c18ae17b6d82f..361572a241f06 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -22,11 +22,15 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
> +#include <dt-bindings/iio/temperature/thermocouple.h>
> +
>  /* MCP9600 registers */
>  #define MCP9600_HOT_JUNCTION		0x00
>  #define MCP9600_COLD_JUNCTION		0x02
>  #define MCP9600_STATUS			0x04
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
> +#define MCP9600_SENSOR_CFG		0x05
> +#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
>  #define MCP9600_ALERT_CFG1		0x08
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> @@ -66,6 +70,30 @@ static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
>  	[MCP9600_ALERT4] = "alert4",
>  };
>  
> +/* Map between dt-bindings enum and the chip's type value */
> +static const unsigned int mcp9600_type_map[] = {
> +	[THERMOCOUPLE_TYPE_K] = 0,
> +	[THERMOCOUPLE_TYPE_J] = 1,
> +	[THERMOCOUPLE_TYPE_T] = 2,
> +	[THERMOCOUPLE_TYPE_N] = 3,
> +	[THERMOCOUPLE_TYPE_S] = 4,
> +	[THERMOCOUPLE_TYPE_E] = 5,
> +	[THERMOCOUPLE_TYPE_B] = 6,
> +	[THERMOCOUPLE_TYPE_R] = 7,
> +};
> +
> +/* Map thermocouple type to a char for for iio info in sysfs */
> +static const int mcp9600_tc_types[] = {
> +	[THERMOCOUPLE_TYPE_K] = 'K',
> +	[THERMOCOUPLE_TYPE_J] = 'J',
> +	[THERMOCOUPLE_TYPE_T] = 'T',
> +	[THERMOCOUPLE_TYPE_N] = 'N',
> +	[THERMOCOUPLE_TYPE_S] = 'S',
> +	[THERMOCOUPLE_TYPE_E] = 'E',
> +	[THERMOCOUPLE_TYPE_B] = 'B',
> +	[THERMOCOUPLE_TYPE_R] = 'R',
> +};
> +
>  static const struct iio_event_spec mcp9600_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -89,6 +117,7 @@ static const struct iio_event_spec mcp9600_events[] = {
>  			.type = IIO_TEMP,				       \
>  			.address = MCP9600_HOT_JUNCTION,		       \
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> +					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
>  					      BIT(IIO_CHAN_INFO_SCALE),	       \
>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
> @@ -131,6 +160,7 @@ struct mcp_chip_info {
>  
>  struct mcp9600_data {
>  	struct i2c_client *client;
> +	u32 thermocouple_type;
>  };
>  
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -165,11 +195,32 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		*val = mcp9600_tc_types[data->thermocouple_type];
> +		return IIO_VAL_CHAR;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int mcp9600_config(struct mcp9600_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	u8 cfg;
> +
> +	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
> +			  mcp9600_type_map[data->thermocouple_type]);
> +
> +	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set sensor configuration\n");

Only called from probe so use return dev_err_probe() here


> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
>  {
>  	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
> @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  
> +	/* Accept type from dt with default of Type-K. */
> +	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	ret = device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);
> +	if (ret < 0 && ret != -EINVAL)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Error reading thermocouple-type property\n");
> +
> +	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Invalid thermocouple-type property %u.\n",
> +				     data->thermocouple_type);
> +
> +	/* Set initial config. */
> +	ret = mcp9600_config(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	ch_sel = mcp9600_probe_alerts(indio_dev);
>  	if (ch_sel < 0)
>  		return ch_sel;



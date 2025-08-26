Return-Path: <linux-iio+bounces-23314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52EB372DC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E1D4E2B86
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF931262FD8;
	Tue, 26 Aug 2025 19:09:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018F2D061A
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235347; cv=none; b=hokZ84nyHfM6U294q/lCP5xV7A0d9nxdGeCnrq3UAROENqr6eDvaC9uORb7p48yw3bo/FNQ3RyfdWNKxCRWTx8WCAOlrrWDB37NKbLZq0C2gv3dnhLxKz/eHDicpOahBUFdMcaODDI41eiBHH9i/1mRWSttWtDKkXLq2B2VKgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235347; c=relaxed/simple;
	bh=cXV4TB12PpOovVEA7AhNsgoljyctFjYKQ5z0jrglhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlg/Q6E5YvTmo1uNmSJcLcvPREKgI9TZHXShjDR2oFuOI6nw+p5gdbxqHsrW71OTIc4yWQPJDSTbE7GnaEAQ1WvtqjbQ7yzxHD23USOysqWc3dIGuHh0u0pTdA7hfiwN9q4I37VklkJFNIQOaLB3J/cTgrSc7Z4VKL+I7U4MRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 15:08:46 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025082614-inventive-gharial-c4a3f9@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-4-2ba676a52589@kernel.org>
 <45170936-3eeb-4b7a-b75b-560660979b72@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45170936-3eeb-4b7a-b75b-560660979b72@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 12:20:39PM -0500, David Lechner wrote:
> On 8/25/25 7:10 PM, Ben Collins wrote:
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> > to allow get/set of this value.
> > 
> > Use filter_type[none, ema] for enabling the IIR filter.
> > 
> > Signed-off-by: Ben Collins <bcollins@kernel.org>
> > ---
> >  drivers/iio/temperature/mcp9600.c | 147 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 147 insertions(+)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index aa42c2b1a369edbd36e0d6d6d1738ed0069fd990..d3309e30628ae5cdc74378403952ba285990f4c0 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -31,6 +31,7 @@
> >  #define MCP9600_STATUS_ALERT(x)		BIT(x)
> >  #define MCP9600_SENSOR_CFG		0x05
> >  #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> > +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
> >  #define MCP9600_ALERT_CFG1		0x08
> >  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
> >  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> > @@ -94,6 +95,27 @@ static const int mcp9600_tc_types[] = {
> >  	[THERMOCOUPLE_TYPE_R] = 'R',
> >  };
> >  
> > +enum mcp9600_filter {
> > +	MCP9600_FILTER_TYPE_NONE,
> > +	MCP9600_FILTER_TYPE_EMA,
> > +};
> > +
> > +static const char * const mcp9600_filter_type[] = {
> > +	[MCP9600_FILTER_TYPE_NONE] = "none",
> > +	[MCP9600_FILTER_TYPE_EMA] = "ema",
> > +};
> > +
> > +static const int mcp_iir_coefficients_avail[7][2] = {
> > +	/* Level 0 is no filter */
> > +	{ 0, 524549 },
> > +	{ 0, 243901 },
> > +	{ 0, 119994 },
> > +	{ 0,  59761 },
> > +	{ 0,  29851 },
> > +	{ 0,  14922 },
> > +	{ 0,   7461 },
> > +};
> > +
> >  static const struct iio_event_spec mcp9600_events[] = {
> >  	{
> >  		.type = IIO_EV_TYPE_THRESH,
> > @@ -119,6 +141,8 @@ struct mcp_chip_info {
> >  struct mcp9600_data {
> >  	struct i2c_client *client;
> >  	u32 thermocouple_type;
> > +	int filter_level;
> > +	int filter_enabled;
> >  };
> >  
> >  static int mcp9600_config(struct mcp9600_data *data)
> > @@ -129,6 +153,9 @@ static int mcp9600_config(struct mcp9600_data *data)
> >  
> >  	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
> >  			  mcp9600_type_map[data->thermocouple_type]);
> > +	/* The chip understands 0 as "none", and 1-7 as ema filter levels. */
> > +	if (data->filter_enabled)
> > +		FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level + 1);
> >  
> >  	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> >  	if (ret < 0) {
> > @@ -146,7 +173,11 @@ static int mcp9600_config(struct mcp9600_data *data)
> >  			.address = MCP9600_HOT_JUNCTION,		       \
> >  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> >  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
> > +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
> 
> Does the filter actually only apply to the hot junction and not the
> cold junction? There is a mismatch between this being info_mask_separate
> and the filter_type being IIO_SHARED_BY_ALL.
> 
> Not related to this patch, but the comment same applies to
> IIO_CHAN_INFO_THERMOCOUPLE_TYPE - I missed that in previous reviews.

The Thermocouple Sensor Configuration register only applies to the
thermocouple (hot-junction), which is what sets the filter and
thermocouple configuration.

More specifically, the filter formula applies to T-delta (thermocouple
hot-junction).

So these are correct.

> >  					      BIT(IIO_CHAN_INFO_SCALE),	       \
> > +			.info_mask_separate_available =                        \
> > +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> > +			.ext_info = mcp9600_ext_filter,			       \
> >  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
> >  			.num_event_specs = hj_num_ev,			       \
> >  		},							       \
> > @@ -162,6 +193,57 @@ static int mcp9600_config(struct mcp9600_data *data)
> >  		},							       \
> >  	}
> >  
> > +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +
> > +	return data->filter_enabled ? MCP9600_FILTER_TYPE_EMA :
> > +		MCP9600_FILTER_TYPE_NONE;
> > +}
> > +
> > +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      unsigned int mode)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	int new_type;
> 
> This variable name is a little confusing. It looks like it should
> rather be:
> 
> 	bool new_filter_enabled;

I can change that.

> > +
> > +	switch (mode) {
> > +	case MCP9600_FILTER_TYPE_NONE:
> > +		new_type = 0;
> > +		break;
> > +
> > +	case MCP9600_FILTER_TYPE_EMA:
> > +		new_type = 1;
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Do not reset the filter if we don't need to. */
> > +	if (data->filter_enabled == new_type)
> > +		return 0;
> > +
> > +	data->filter_enabled = new_type;
> > +	return mcp9600_config(data);
> > +}
> > +
> > +static const struct iio_enum mcp9600_filter_enum = {
> > +	.items = mcp9600_filter_type,
> > +	.num_items = ARRAY_SIZE(mcp9600_filter_type),
> > +	.get = mcp9600_get_filter,
> > +	.set = mcp9600_set_filter,
> > +};
> > +
> > +static const struct iio_chan_spec_ext_info mcp9600_ext_filter[] = {
> > +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &mcp9600_filter_enum),
> > +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> > +			   &mcp9600_filter_enum),
> > +	{ }
> > +};
> > +

I guess I need to make this IIO_SEPARATE/IIO_SHARED_BY_TYPE, but I need
to make sure it's only for the in_temp_raw and not in_temp_ambient_raw.

> >  static const struct iio_chan_spec mcp9600_channels[][2] = {
> >  	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
> >  	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
> > @@ -216,6 +298,69 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >  		*val = mcp9600_tc_types[data->thermocouple_type];
> >  		return IIO_VAL_CHAR;
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		if (!data->filter_enabled)
> > +			return IIO_VAL_EMPTY;
> 
> This brings us back to the earlier discussion of what should this
> be when the filter is disabled. Mathematically, it would be infinite.
> 
> I wonder if it would be reasonable to return "inf" here since many
> floating point parsers will already handle that as a valid value.

I'll defer to the other thread for further discussion on this.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF


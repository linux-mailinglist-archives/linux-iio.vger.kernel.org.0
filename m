Return-Path: <linux-iio+bounces-566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37156803163
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F58280E3D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4022EF3;
	Mon,  4 Dec 2023 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnZinK5m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BE1F958;
	Mon,  4 Dec 2023 11:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97401C433C8;
	Mon,  4 Dec 2023 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701688812;
	bh=ubI/7pQOd7V53UVsOax9+AcKaUtYTkzZ0icECZm7Eg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rnZinK5mxiEY+1IDGh/lIxpvni7dL0AjfFpal5GMZteEcIRS251AqfW5s0Grh/eQF
	 rI9hOAj/+hEP3BXp8h4zx4jY427wFcbJO+6fED1RY8itePezCleh5WcivwzYRxP0uU
	 Xyn4SCJ4XCBS69li5IkpUyK5Fn469G8ng7q6hA9Zr5McYz+zV39nfGhOk+WUYxoYIC
	 ZOG3XVI58nueJXhQ32ydmRq+htQXwYz3Bez2SNLLqN6BmaBW0M4SurkGxr/3h4ejWB
	 QuxVcAGjIa2Gck0kZnR0VothaOJhItuhAPFgh7sSVJ1LJoGJpZvR4fveqhVW3CxKNV
	 xpAZQ9upObQOw==
Date: Mon, 4 Dec 2023 11:20:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231204112001.7dff7066@jic23-huawei>
In-Reply-To: <20231127212726.77707-2-marex@denx.de>
References: <20231127212726.77707-1-marex@denx.de>
	<20231127212726.77707-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 22:26:53 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
Hi Marek,

Discussion around available on v5 made me look closer at that aspect.
You are providing all the available entries in the callback but they
shouldn't be exposed to actually read unless the *_available bitmap
bits corresponding to them are set.

If you like I can just rip the unused code out whilst applying?
Or if you'd prefer to send a v7 that's great too.

Otherwise everything looks good to me.

Jonathan

> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
> +
> +static int isl76682_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type,
> +			       int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			*vals = illuminance_scale_available;
> +			*length = ARRAY_SIZE(illuminance_scale_available);
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		case IIO_INTENSITY:
> +			*vals = intensity_scale_available;
> +			*length = ARRAY_SIZE(intensity_scale_available);
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_INT_TIME:

Never used.  So can just drop this case which tidies up the question
I h ad earlier on what the single entry array was conveying.

> +		*vals = integration_time_available;
> +		*length = ARRAY_SIZE(integration_time_available);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec isl76682_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),

Without setting	.info_mask_shared_by_all_available (unless we have a bug)
you won't see the available attributes for INT_TIME.

> +	}, {
> +		.type = IIO_INTENSITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static const struct iio_info isl76682_info = {
> +	.read_avail	= isl76682_read_avail,
> +	.read_raw	= isl76682_read_raw,
> +	.write_raw	= isl76682_write_raw,
> +};


> +static const struct i2c_device_id isl76682_id[] = {
> +	{ "isl76682" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, isl76682_id);
> +
> +static const struct of_device_id isl76682_of_match[] = {
> +	{ .compatible = "isil,isl76682" },
> +	{ }

Completely trivial but why { } here and {} in the similar
case above?  Pick one!

> +};
> +MODULE_DEVICE_TABLE(of, isl76682_of_match);



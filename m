Return-Path: <linux-iio+bounces-27449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D49CEC77E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5375300BD8B
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC32FFFB6;
	Wed, 31 Dec 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZnOwC6o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654182F90D8;
	Wed, 31 Dec 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205328; cv=none; b=ETk7jiU3j9hqAPNvt7hCxQCVbHx/341YZA8XJnlPIshu+e+TA3TWim8bqgudW5Oqw+fvqcyzYG1VqXbngxrx3KXswhXZvPmbbrqZcwFE7wKapHS92LhhrkCwGGxKRHkYeZ+q4h+ce3TqoVayBKJYegRvJ/KluDKYD5RBJd0orjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205328; c=relaxed/simple;
	bh=A1d9RAORZwu4IDSkx8Jgf0L0blgxSrsdFiT8Dr3rUJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVcztX4hsfdp2vivms8X6iPs56xd4jFJbHurZbUZAlKauptB3sPrV/fdpDKevP3zmB3AZkvxCQv9m+6KgnQIB7RGIHYeDy9TMcLtdfBG94g1gFACJ1I2ltdBYRoNbl4a7HVXHbvt/Qr10yKi/31kwJJxfvAQsiMqEGn5tZxDaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZnOwC6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DF0C113D0;
	Wed, 31 Dec 2025 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767205327;
	bh=A1d9RAORZwu4IDSkx8Jgf0L0blgxSrsdFiT8Dr3rUJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZnOwC6o1oNFODCt8cLcTW1a1xVQraUxvzh5Cl7kJNjVTcEyYZ7BV1ExrfZCWFfsl
	 ZIsITgesp3hFKFG3j+BIsl560LZvhA8zYyYl+HG6GSNeVggUmWN25786UU3GD5TKgT
	 FuWePRXgzx0ruzCnd3zpql4Ptr8bNuC69nTdocDL75SS6LD6PSaEiK85zTZaH/RbA4
	 eppGE1HELe+WCzbgckazXY+CYl/4KA8t2gB49riEAzSehgjQURVRQgkrjVz6kAgVYo
	 unocMsJBLZbp6joeiJvJW0557bCLjHNNvGFDygDItkdiVYDHgtqTBIhU+0Olq1VI3T
	 NH0qETNMkxjxA==
Date: Wed, 31 Dec 2025 18:21:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 5/6] staging: iio: ad9832: convert to iio channels
 and ext_info attrs
Message-ID: <20251231182158.2cc7d4da@jic23-huawei>
In-Reply-To: <20251230203459.28935-6-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-6-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 17:34:58 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Convert ad9832 from sysfs attributes to standard channel interface
> using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> device is a current source DAC with one output.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>

A couple of things inline.


> +
> @@ -230,42 +321,111 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,

> +	case AD9832_PINCTRL_EN:
> +		if (val != 1 && val != 0)
> +			return -EINVAL;
> +
> +		st->ctrl_ss &= ~AD9832_SELSRC;
> +		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, !val);
It's not particularly important as this pattern is common, but there is
FIELD_MODIFY() available to make the above a single thing without
needing the mask twice

> +
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> +						 st->ctrl_ss);
> +		ret = spi_sync(st->spi, &st->msg);
> +		if (ret)
> +			return ret;
> +
> +		st->pinctrl_en = val;
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> +
> +	return len;
>  }
>
> -static IIO_DEVICE_ATTR(out_altvoltage0_phasesymbol, 0200, NULL, ad9832_write, AD9832_PHASE_SYM);
> -static IIO_CONST_ATTR(out_altvoltage0_phase_scale, "0.0015339808"); /* 2PI/2^12 rad */
> +static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
> +	AD9832_CHAN_FREQ("frequency0", 0),
> +	AD9832_CHAN_FREQ("frequency1", 1),
> +	AD9832_CHAN_PHASE("phase0", 0),
> +	AD9832_CHAN_PHASE("phase1", 1),
> +	AD9832_CHAN_PHASE("phase2", 2),
> +	AD9832_CHAN_PHASE("phase3", 3),
> +	{ }
> +};
>  
> -static IIO_DEVICE_ATTR(out_altvoltage0_pincontrol_en, 0200, NULL, ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEVICE_ATTR(out_altvoltage0_out_enable, 0200, NULL, ad9832_write, AD9832_OUTPUT_EN);
> +static const struct iio_chan_spec ad9832_channels[] = {
> +	{
> +		.type = IIO_ALTCURRENT,
> +		.output = 1,
> +		.indexed = 1,
> +		.channel = 0,
> +		.ext_info = ad9832_ext_info,
> +	},
> +};
> +
> +static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
> +		       ad9832_show, ad9832_store, AD9832_FREQ_SYM);
> +static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
> +		       ad9832_show, ad9832_store, AD9832_PHASE_SYM);
Why not do these two via ext_info? 

> +static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,

This one can be done with standard ABI + infomask element at read_raw
so do it that way rather than via IIO_DEVICE_ATTR() which should be
used only when none of the standard stuff is possible because these
direct attr declarations hide things from internal kernel usage and
mean we have to much more carefully check them against ABI documentation.

> +		       ad9832_show, ad9832_store, AD9832_OUTPUT_EN);
> +
> +/*
> + * TODO: Convert to DT property when graduating from staging.
> + * Pin control configuration depends on hardware wiring.
> + */
> +static IIO_DEVICE_ATTR(out_altcurrent0_pincontrol_en, 0644,
> +		       ad9832_show, ad9832_store, AD9832_PINCTRL_EN);
>  
>  static struct attribute *ad9832_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase2.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phase3.dev_attr.attr,
> -	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> +	&iio_dev_attr_out_altcurrent0_frequency_symbol.dev_attr.attr,
> +	&iio_dev_attr_out_altcurrent0_phase_symbol.dev_attr.attr,
> +	&iio_dev_attr_out_altcurrent0_enable.dev_attr.attr,
> +	&iio_dev_attr_out_altcurrent0_pincontrol_en.dev_attr.attr,
>  	NULL,
>  };


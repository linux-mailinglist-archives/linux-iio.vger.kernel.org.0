Return-Path: <linux-iio+bounces-9842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9203989058
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A3D282312
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838E136352;
	Sat, 28 Sep 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwuRaJHD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2028DBC;
	Sat, 28 Sep 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540372; cv=none; b=WPCOQo+evORcXABGm17fvPSG+CpjTkSPP4mXqwqxWTAbPeGvgjzrPLT2NQFKF+Aggtk+XP9bItpvN2W4YhAKz3IXTc5pjE6UnnWAZh/Ah4DL16bTYN5W33Kv26ew4ik0443m/kPYfHWTopS59C0p0KYYIgKF1jbYjJ0sbpQvXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540372; c=relaxed/simple;
	bh=yLaEBV5HrNIfSreA+O6XQp63+uWgWpCzXP5GVMztOmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjm1+ii09LWdRinFNH01aGZIGQBAuq6cmkYHr7JkSvk9zT4exWc07nWZ3a75QN9VrODfzjKL1jV7ZppsSCeuv1vv8mmw5kZyketOnCd5ET5H+VUI1+Hg8O6t1tykXcPpOpUyFytKmSR6YkJ9ti5Vg8+oV9mtAoPL8YrV9hIHqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwuRaJHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACAEC4CEC3;
	Sat, 28 Sep 2024 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540371;
	bh=yLaEBV5HrNIfSreA+O6XQp63+uWgWpCzXP5GVMztOmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IwuRaJHDuEzp19+fIGcnwpfbojNBfnvtcLOdo4LsC974YQJotja50n9AihS5brVc3
	 6gEfUX6U6Z9HT5S91QcpN9YWg5SdFDOBDc8V4nIEgaq7Sm5J4+WYD1BG827uUXABG6
	 mGU5Lnc33zdlEOJtZaKPX5qAlrUcRnWANdf+RXKvhoaDrrYrUJit3TJrx4Qqja3Uv9
	 YhwZmabvnqu/a5XwnGyKcXkzE1N4RoQ5/M5p6/4xu0O7NLAEFfa7SXcMYteUjEltUQ
	 N/+ymRgLDWcQ//LTrs9kUpGEQll6bP3VUcY2XetkeNHMm6pk6C9Yhox0Y85dPlujAt
	 BWeYRzura+/Pw==
Date: Sat, 28 Sep 2024 17:19:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/10] iio: light: veml6030: use read_avail() for
 available attributes
Message-ID: <20240928171922.0caccaf3@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-6-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-6-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:54 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Drop custom attributes by using the standard read_avail() callback to
> read scale and integration time. When at it, define these attributes as
> available by all channels, as they affect the values of both the ALS and
> the WHITE channel.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier

Some comments inline

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 64 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 89c98bfc5191..a3190fab3add 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -58,25 +58,24 @@ struct veml6030_data {
>  	int cur_integration_time;
>  };
>  
> -/* Integration time available in seconds */
> -static IIO_CONST_ATTR(in_illuminance_integration_time_available,
> -				"0.025 0.05 0.1 0.2 0.4 0.8");
> +static const int veml6030_it_times[][2] = {
> +	{0, 25000},
Really minor but I'm trying to get IIO standardized on formatting for this
sort of array and I'd like not to introduce more instances of it
done without the extra spaces as it will just give more to clean up
at some point.

	{ 0, 25000 },
etc please.
> +	{0, 50000},
> +	{0, 100000},
> +	{0, 200000},
> +	{0, 400000},
> +	{0, 800000},
> +};
>  
>  /*
>   * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
>   * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
>   */
> -static IIO_CONST_ATTR(in_illuminance_scale_available,
> -				"0.125 0.25 1.0 2.0");
> -
> -static struct attribute *veml6030_attributes[] = {
> -	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> -	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group veml6030_attr_group = {
> -	.attrs = veml6030_attributes,
> +static const int veml6030_scale_vals[][2] = {
> +	{0, 125000},
> +	{0, 250000},
> +	{1, 0},
> +	{2, 0},

As above, add some spaces for minor readability improvement.

>  };
>  
>  /*
> @@ -197,9 +196,11 @@ static const struct iio_chan_spec veml6030_channels[] = {
>  		.type = IIO_LIGHT,
>  		.channel = CH_ALS,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_PROCESSED) |
> -				BIT(IIO_CHAN_INFO_INT_TIME) |
> -				BIT(IIO_CHAN_INFO_SCALE),
> +				BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					       BIT(IIO_CHAN_INFO_SCALE),
This bit is an ABI change and technically old code wasn't a bug, so
we don't really have a good enough reason to change it.  So Please
leave these as separate.

> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
That doesn't stop us sharing the available as that always was shared
in the attribute naming above.

>  		.event_spec = veml6030_event_spec,
>  		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
>  	},
> @@ -210,6 +211,10 @@ static const struct iio_chan_spec veml6030_channels[] = {
>  		.channel2 = IIO_MOD_LIGHT_BOTH,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					       BIT(IIO_CHAN_INFO_SCALE),
This confuses me.  Is it fixing a bug by effectively adding attributes for this
channel that were previously missing? If so we'll have to go with searpte
even though they are shared to avoid breaking the ABI for other channel.

> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  };
>  




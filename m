Return-Path: <linux-iio+bounces-7397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F31929818
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EC282053
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73620DCB;
	Sun,  7 Jul 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuHfne8S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF5210E4;
	Sun,  7 Jul 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720358057; cv=none; b=pCTsJdjCAYmCbZCT1qIQGXe6n+EwIVPga060ESTihQFvebEAczdrM2pTubPRrGhYmIuO3SCLwilI3INTWRRm9KMONcPzlMuQgxUG/+VCWU/HcbKRauBdffctCPfOBmXZdIE0K6bztI06POZ24bCNMsgDMfqVbo0FencxCyClLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720358057; c=relaxed/simple;
	bh=BBQT9o8bXWzBYLEg/2ibzEJ8MHtapLUOHuUVrNbntjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3RjQlVs6hwP9r4dn2hCPLyMi5ej2CIpUxSEiE7IyYnd2uwsYbCct5hpA+BkObNB6a8/t3b64jTEV+iz335AjZLhuV1hhTXcoR2eAyeZLBjQUnOMAjvJDlZ69qdmLO7qMpJBoUqL5y8C5CLyhZerNWz7t6Pmbjj32m1MDoRkbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuHfne8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408EC3277B;
	Sun,  7 Jul 2024 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720358056;
	bh=BBQT9o8bXWzBYLEg/2ibzEJ8MHtapLUOHuUVrNbntjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuHfne8SRi3T/moNEqYz6Wv/3dJWpoKHAzlBMZABwjIz/7VNxJfZbpg3Hnhx5SQan
	 Il7XwP9f/1UWO0dwkiSlfMHTewTowrGOaPszcOQR4q4/nIqlqsQO6+t3IIpsjpYter
	 fJ6s0Tv9NNMSJqGbLjTT1ctTXP9MqFgBjICMU306DJVoql8bhi54MhNLowDrDCSGZy
	 KCCYUH46POVgYcFVEN6oLQRwetzFyqm/Ub+PGwQjUOAHQgYblkXCoZuUPzezdU4gs6
	 wbvesqTN8IM27uD4gZoDJzVLK6t6l3QbLJvC0pZdA2lF07+8ZWjOOpZ/OVRJC59kPX
	 fuSWO81nUk6sg==
Date: Sun, 7 Jul 2024 14:14:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <20240707141410.16e6dbbe@jic23-huawei>
In-Reply-To: <ec349847cc994f3bd632e99b408a31e7c70581d0.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
	<ec349847cc994f3bd632e99b408a31e7c70581d0.1720176341.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 13:55:49 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

Typo in patch title. If nothing much else comes up I can fix whilst applying.

> The ROHM BU27034 light sensor has two data channels for measuring
> different frequencies of light. The result from these channels is
> combined into Lux value while the raw channel values are reported via
> intensity channels.
> 
> Both of the intensity channels have adjustable gain setting which
> impacts the scale of the raw channels. Eg, doubling the gain will double
> the values read from the raw channels, which halves the scale value. The
> integration time can also be set for the sensor. This does also have an
> impact to the scale of the intensity channels because increasing the
> integration time will also increase the values reported via the raw
> channels.
> 
> Impact of integration time to the scale and the fact that the scale value
> does not start from '1', can make it hard for a human reader to compute the
> gain values based on the scale.
> 
> Add read-only HARDWAREGAIN to help debugging.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Rest of this series looks good to me and I'm fine making appropriate tweaks
for stuff I identified whilst applying.

Will give a bit of time for DT maintainers to look at the renames and check
we haven't missed anything subtle there.

Jonathan


> 
> ---
> Revision history:
> v1 => v2:
>  - fix switch case fallthrough warning by adding explicit return
> ---
>  drivers/iio/light/rohm-bu27034.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> index ec4f9bef83f8..76711c3cdf7c 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -148,7 +148,8 @@ static const struct iio_itime_sel_mul bu27034_itimes[] = {
>  	.type = IIO_INTENSITY,						\
>  	.channel = BU27034_CHAN_##_name,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -			      BIT(IIO_CHAN_INFO_SCALE),			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
>  	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),		\
>  	.info_mask_shared_by_all_available =				\
> @@ -989,6 +990,13 @@ static int bu27034_read_raw(struct iio_dev *idev,
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = bu27034_get_gain(data, chan->channel, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		return bu27034_get_scale(data, chan->channel, val, val2);
>  
> @@ -1033,12 +1041,17 @@ static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan,
>  				     long mask)
>  {
> +	struct bu27034_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		dev_dbg(data->dev,
> +			"HARDWAREGAIN is read-only, use scale to set\n");
> +		return -EINVAL;
>  	default:
>  		return -EINVAL;
>  	}



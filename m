Return-Path: <linux-iio+bounces-4840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586C8BCF52
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0ECB24D36
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133778C90;
	Mon,  6 May 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OItFKT4M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E278C80;
	Mon,  6 May 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002786; cv=none; b=QdrghM+khqU54jcWUgzac5NTD7l/g7RGzdZQwWpj9d9BYr7Wgz+zUO7/mArvchwL91h/O1w2PGPsJov++1FAHS0TgVSy9XamgB2JVgBzr4ABS8vU9ZnNIMXUWXU4XvsmbBjCnSirjEDYeLvzccN5vysG90QXYJrJzx19m56wnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002786; c=relaxed/simple;
	bh=yPwj1hr3OMYbSTKe403YdJHAPaBBvoH2vaXPmlmDwEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nj811b2iqkzTEpDplAUsi26C6ARnKtmoW98mP9mD4omcCRRxsUToW29Jo1dmNflSK0/XVmNA5w4IkabC2v0tJWPiC5yiONVlzNQmbI6tPueU/5n+Wbfe2H9zsTnDGevhLZy/OtCg6kjwXk6Dq3h92wxd1BstemX2MeimtuJT7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OItFKT4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4FFC116B1;
	Mon,  6 May 2024 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002785;
	bh=yPwj1hr3OMYbSTKe403YdJHAPaBBvoH2vaXPmlmDwEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OItFKT4MZeD7ozMMo7ULjY1RUtVSY35cqcSuVv12qSnzFLFapp+1SxOGW6cBroani
	 zUKKtBw4+mkM9z3sSr15jn957GYcaxn49Vr/4xnkr3a4U6EI+JCiARx3EN2TReSBLd
	 4tLApt4zaLZ+1DJWU+VY+14Jzf4/KD1Ym/V7KyNYwM0fodtvhn6uKNalU+bpdLptOL
	 8qt57ujmeFQrWpXvvjJDMyr6aDsjWGG5IgjZMdZALGT3j4OHtJPpGNNqq/jDzNW3/Q
	 RsZ3kFKMkxCSiQgASbp224jiKYaUrtaUl1UddtENCG/xJ/O2TX8xsxGFqcAw6aBElO
	 5xzAj6RV6AHWg==
Date: Mon, 6 May 2024 14:39:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v7 6/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240506143928.40a7c908@jic23-huawei>
In-Reply-To: <20240430162946.589423-7-alisa.roman@analog.com>
References: <20240430162946.589423-1-alisa.roman@analog.com>
	<20240430162946.589423-7-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 19:29:46 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> dynamically configure them in the devicetree.
> 
> Also modify config AD7192 description for better scaling.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Hi Alisa-Dariana,

I only had one minor thing to add to the other reviews,

Thanks,

Jonathan

>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 3e797ff48086..0f6ecf953559 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
...

> +static int ad7194_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *ad7194_channels;
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec ad7194_chan = AD7193_CHANNEL(0, 0, 0);

I think you are only using these as templates that get copied?
If so declare them const.

> +	struct iio_chan_spec ad7194_chan_diff = AD7193_DIFF_CHANNEL(0, 0, 0, 0);
> +	struct iio_chan_spec ad7194_chan_temp = AD719x_TEMP_CHANNEL(0, 0);
> +	struct iio_chan_spec ad7194_chan_timestamp = IIO_CHAN_SOFT_TIMESTAMP(0);
> +	unsigned int num_channels, index = 0;
> +	u32 ain[2];
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD7194_CH_MAX_NR)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many channels: %u\n", num_channels);
> +
> +	num_channels += AD7194_CH_BASE_NR;
> +
> +	ad7194_channels = devm_kcalloc(dev, num_channels,
> +				       sizeof(*ad7194_channels), GFP_KERNEL);
> +	if (!ad7194_channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = ad7194_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node(dev, child) {

Andy pointed out the need for scoped here to avoid leaking the fwnode in error paths.

> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, ARRAY_SIZE(ain));
> +		if (ret == 0) {
> +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> +			if (ret)
> +				return ret;
> +
> +			ret = ad7194_validate_ain_channel(dev, ain[1]);
> +			if (ret)
> +				return ret;
> +
> +			*ad7194_channels = ad7194_chan_diff;
> +			ad7194_channels->scan_index = index++;
> +			ad7194_channels->channel = ain[0];
> +			ad7194_channels->channel2 = ain[1];
> +			ad7194_channels->address = AD7194_CH(ain[0], ain[1]);
> +		} else {
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &ain[0]);
> +			if (ret) {
> +				fwnode_handle_put(child);

With scoped variant above you can drop this one case of (currently correct)
release of the fwnode.

> +				return ret;
> +			}
> +
> +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> +			if (ret)
> +				return ret;
> +
> +			*ad7194_channels = ad7194_chan;
> +			ad7194_channels->scan_index = index++;
> +			ad7194_channels->channel = ain[0];
> +			ad7194_channels->address = AD7194_CH(ain[0], 0);
> +		}
> +		ad7194_channels++;
> +	}
> +
> +	*ad7194_channels = ad7194_chan_temp;
> +	ad7194_channels->scan_index = index++;
> +	ad7194_channels->address = AD7194_CH_TEMP;
> +	ad7194_channels++;
> +
> +	*ad7194_channels = ad7194_chan_timestamp;
> +	ad7194_channels->scan_index = index;
> +
> +	return 0;
> +}


Return-Path: <linux-iio+bounces-15951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC2A40940
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14F97A91FF
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77818DF6D;
	Sat, 22 Feb 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWoCIZef"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A713E02D;
	Sat, 22 Feb 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236329; cv=none; b=Ti8eQmh6IKviO8GNAlicjJMpI/oZZEtn1bNInFVYnQDRbRc9ih5+U7nwMmBy7dv+z/VrP7ovjFiS8oAic19QI09f6TUBly+dlJI8jX9Jeo/OTFkn3VPEIGxk4GWy2kJi0diaQvREnZBw1krDwOjebbYgKy8yS/0lzWlquUvU65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236329; c=relaxed/simple;
	bh=TpfFFU0H5oykoaqQnQwvxN9UPAcGES3SZeFaw9UbrBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5aaiNx40Jdojt3vG/0QXlS9aT/rrLdJCY+YiFYuoVP+71/EwVkYO7dR2nry6o/UrsL7C/H4xx1wCC+p1wL9xzv4ptMQeqDPp+xZgipB/BPzmb8opoGEX/9sPzJSVGUh0HLj2REXyUHur62yW39XUgisHC3UUQUY1xtfWOtIZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWoCIZef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D69C4CED1;
	Sat, 22 Feb 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740236329;
	bh=TpfFFU0H5oykoaqQnQwvxN9UPAcGES3SZeFaw9UbrBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rWoCIZefOU1UO3nUnPJlW//N842UPntwc1saI3CZZ//rlYphI0/FEff+RwcQyjygs
	 AaulvRAyWA5dXFMgSl/KaY+N2lhMGEZ3ocZT2rDUVxPSBES+fN2tZM8QuzlFxzYSx8
	 sJ+plnhCyV4gC290Hu6wlPFSYrkM5QExlXU/t1zXqIvCe+GFhIi9g1rWgcZcdsE4vq
	 4wJGeT468KKTB/9x+u3H94xKLVmvlyyifFqRenvLD2G32RAb4ugNnYxvTkW6xG4WFB
	 aknUBAvZXLa0da6/geedGAy87CFyt/YcqvjUeRHxxQMHhzcXbdFK5+cpUx+zkidr/O
	 5i06gZK5x3qzg==
Date: Sat, 22 Feb 2025 14:58:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Trevor Gamblin
 <tgamblin@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: fix out of bounds array access
Message-ID: <20250222145841.06b3417c@jic23-huawei>
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-1-57fef8c7a3fd@baylibre.com>
References: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
	<20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-1-57fef8c7a3fd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:17:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Fix some out of bounds array access of st->channels_cfg in the ad4695
> driver. This array only has elements for voltage channels, but it was
> also being accessed for the temperature channel in a few cases causing
> reading past the end of the array.
> 
> In some cases, this was harmless because the value was read but not
> used. However, the in_temp_sampling_frequency attribute shares code
> with the in_voltageY_sampling_frequency attributes and was trying to
> read the oversampling ratio from the st->channels_cfg array. This
> resulted in a garbage value being used in the calculation and the
> resulting in_temp_sampling_frequency value was incorrect.
> 
> To fix, make sure we always check that we are dealing with a voltage
> channel before accessing the st->channels_cfg array and use an
> oversampling ratio of 1 for the temperature channel (multiplicative
> identity value) since that channel doesn't support oversampling.
> 
> Fixes: 67d63185db79 ("iio: adc: ad4695: add offload-based oversampling support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This got a little fiddly as I applied the iio_device_claim_direct() patch
first and that includes making use of osr in calibbias for the voltage
channel. I switched that back to accessing it via cfg-> now there isn't a convenient
global copy in read_raw()


So with that tweak both patches applied to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad4695.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 3a1a6f96480fd383d32397f4d3c979069111c5c9..8721cbd2af34c53f0cea32e307b9ef2da46b0cfb 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -1035,12 +1035,14 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad4695_state *st = iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
> -	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
> -	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
> +	struct ad4695_channel_config *cfg;
>  	unsigned int reg_val;
>  	int ret, tmp;
>  	u8 realbits;
>  
> +	if (chan->type == IIO_VOLTAGE)
> +		cfg = &st->channels_cfg[chan->scan_index];
> +
>  	scan_type = iio_get_current_scan_type(indio_dev, chan);
>  	if (IS_ERR(scan_type))
>  		return PTR_ERR(scan_type);
> @@ -1169,6 +1171,10 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ: {
>  		struct pwm_state state;
> +		unsigned int osr = 1;
> +
> +		if (chan->type == IIO_VOLTAGE)
> +			osr = cfg->oversampling_ratio;
>  
>  		ret = pwm_get_state_hw(st->cnv_pwm, &state);
>  		if (ret)
> @@ -1261,7 +1267,10 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad4695_state *st = iio_priv(indio_dev);
>  	unsigned int reg_val;
> -	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
> +	unsigned int osr = 1;
> +
> +	if (chan->type == IIO_VOLTAGE)
> +		osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
>  
>  	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  		switch (mask) {
> @@ -1361,7 +1370,10 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
>  		},
>  	};
>  	struct ad4695_state *st = iio_priv(indio_dev);
> -	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
> +	unsigned int osr = 1;
> +
> +	if (chan->type == IIO_VOLTAGE)
> +		osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
> @@ -1713,7 +1725,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
>  
>  	for (i = 0; i < indio_dev->num_channels; i++) {
>  		struct iio_chan_spec *chan = &st->iio_chan[i];
> -		struct ad4695_channel_config *cfg = &st->channels_cfg[i];
> +		struct ad4695_channel_config *cfg;
>  
>  		/*
>  		 * NB: When using offload support, all channels need to have the
> @@ -1734,6 +1746,8 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_VOLTAGE)
>  			continue;
>  
> +		cfg = &st->channels_cfg[i];
> +
>  		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
>  		chan->info_mask_separate_available |=
>  			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> 



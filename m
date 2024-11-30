Return-Path: <linux-iio+bounces-12889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AB9DF2D4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B58281369
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB21A76A5;
	Sat, 30 Nov 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocn6HNVF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC8132103;
	Sat, 30 Nov 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993906; cv=none; b=UAE2VpJDfele7OUepIijjJ5O/Vr7k6HaHhPEcrxryv1wHsNgzVDDtWn+8tMcOjl7FJnKXNSW2oGdT0Oe+ZkiV3g8GtcpM6suxgGnhX2RcWCn7Fp/zSL08FqmO7D1DR2DUtHqnvrKXtd/5VU70LkEkNvsin2HIdqYEdkJKrUAyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993906; c=relaxed/simple;
	bh=BpVgzT7FdWl77Qo9oj7U6K3hkOGDi2LgFiUZtBKX5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATex9TnXuPn6VCj0rRvX3dKFss+KzAnZp8Y9WNureARvZkdP50qtAA2THc+FmTq7h/CrnxIrfRSplE+fOxYwYEhuz5fvvrrHdnmUkWCEUnFKdq5Ks38ddSzz1qd15E58y5ajTSuop6vKhnIu0jHH0IQevNwWv5h3CP+e8WQBRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocn6HNVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B6C4CECC;
	Sat, 30 Nov 2024 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993906;
	bh=BpVgzT7FdWl77Qo9oj7U6K3hkOGDi2LgFiUZtBKX5Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocn6HNVF5qnC5X206ebpTgt3GxrbhDNQlsB8PX47JALwajsjHqJ9AsFCiSgvjuzuT
	 5AUugAV9JY6DOoR/Uz5W/61L8MyXBJGKymbg//5BkvNBR9Af9u2+tYCkLRg2RXu/G/
	 GvZiMbmGpYtK67Om5kPV0skPMbwy8if/LJpb9fDrqlfayLWfqGqPLMW4oq9DWcyMia
	 v2eqJu8l0AIjbKsLPr4IGu2r1m+sfmO8WR5Qfx3capsP24JdRfLtxmZPN6aVqBnFeP
	 Dk8E6HYriOH/vxMiZ3LwPGMdPdaK7CdapUxh3U39xwvU/1/P/3n4GdcD3Qt1MMM6P8
	 G1OuZBSm7zHjA==
Date: Sat, 30 Nov 2024 19:11:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ad7173: add calibration support
Message-ID: <20241130191138.6305f23c@jic23-huawei>
In-Reply-To: <20241127-ad411x_calibration-v2-1-66412dac35aa@baylibre.com>
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
	<20241127-ad411x_calibration-v2-1-66412dac35aa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 10:06:13 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> The ad7173 family of chips has up to four calibration modes.
> 
> Internal zero scale: removes ADC core offset errors.
> Internal full scale: removes ADC core gain errors.
> System zero scale: reduces offset error to the order of channel noise.
> System full scale: reduces gain error to the order of channel noise.
> 
> All voltage channels will undergo an internal zero/full scale
> calibration at bootup.
> 
> System zero/full scale can be done after bootup using the newly created
> iio interface 'sys_calibration' and 'sys_calibration_mode'
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>


>  static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
> @@ -1213,6 +1329,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  	struct iio_chan_spec *chan_arr, *chan;
>  	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
>  	int ref_sel, ret, num_channels;
> +	u8 *calib_mode;
>  
>  	num_channels = device_get_child_node_count(dev);
>  
> @@ -1240,8 +1357,14 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  	if (!chans_st_arr)
>  		return -ENOMEM;
>  
> +	calib_mode = devm_kcalloc(dev, st->num_channels, sizeof(*st->syscalib_mode),
> +				  GFP_KERNEL);
As it is per channel, can we put it in struct ad7173_channel?

This driver already has a lot of small allocations. Avoiding an extra one would nice!

> +	if (!calib_mode)
> +		return -ENOMEM;
> +
>  	indio_dev->channels = chan_arr;
>  	st->channels = chans_st_arr;
> +	st->syscalib_mode = calib_mode;
>  
>  	if (st->info->has_temp) {
>  		chan_arr[chan_index] = ad7173_temp_iio_channel_template;
> 



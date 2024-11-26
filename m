Return-Path: <linux-iio+bounces-12699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC489D9D39
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07570B23F0F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5E1DD884;
	Tue, 26 Nov 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B924f5Lp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F591D63C1;
	Tue, 26 Nov 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644936; cv=none; b=eHZwqIRGZMzVTF3Q0r2UA5mJVWNjHC+zPvtJDHIfuCmrfL3T0jhmLMQ5YFtaC3N6mU2Yz+5uPMOKj9vQ23ZIDIhbbHg7FN6NzaySvTWnbRcojNs8iv5zd1EgIye9b4m/cz2pivgHkGaZOKQkcm3oB8ThfF312dOETHJhTIubVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644936; c=relaxed/simple;
	bh=J6qEmLV3tQU3xvocNaz4LckyMw+R0S0PCZzSGp+8HVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLIoSFhLiCQdFxx2xFxeZyFub1DUXrHdoqUY8ekigyDa5jLW2EHh5iyy4a1wuweGtUROmCBaykkxU24GOr9GvaCUxnmomuKZFTAJD7OJvA9bLse3mC+HDrErNekXCTd33rmAJVCh5aFeM4PWtA5ZVWGYlhJ+oj636rdhUED3xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B924f5Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED937C4CECF;
	Tue, 26 Nov 2024 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732644935;
	bh=J6qEmLV3tQU3xvocNaz4LckyMw+R0S0PCZzSGp+8HVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B924f5Lpx66IYeU0d/f94FZ9uhaCj83BitziesdMvZkQzOqTc85WcAo+YZF8sL7G2
	 4jyL1weCaF28cz/Ln8qWq3GOx5Uy725W02gJcyq3ePwRbZYTV3I5zoMZfY9+E/b/KV
	 Tyjk8zCnpJMWiwdhpszQXkOUJQUc5PCm+qoRRCCiSmuMFDs6rID+ztLeOriQ/DgK3V
	 aGIeE4/DMB7bRlcAynU+aVlIZpJmmq7M5wBd5Lz1UmSFvjg94Tc6UKP782xZMUnD9K
	 /Ztbm06P4XzT5qGfpIqzUFSFtJe1acazfPmCkp81EyzfceAxKdOC7xCkuEZCOOXonK
	 fAQ+CZjuPWWNg==
Date: Tue, 26 Nov 2024 18:15:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 1/9] iio: adc: ad7606: Fix hardcoded offset in the ADC
 channels
Message-ID: <20241126181522.12be94f6@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-1-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-1-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:23 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> When introducing num_adc_channels, I overlooked some new functions
> created in a meanwhile that had also the hardcoded offset. This commit
> adds the new logic to these functions.
> 
> Fixes: 7a671afeb592 ("iio: adc: ad7606: Introduce num_adc_channels")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Hi Guillaume,

Trivial thing inline.

I can't pick this up quite yet as need to wait to rebase my fixes on rc1 sometime
next week.

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 48 ++++++++++++++++++++++++++++--------------------
>  drivers/iio/adc/ad7606.h |  2 +-
>  2 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 8b2046baaa3e..893b93b86aa7 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -175,17 +175,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
> -static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
> +static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec *chan, int ch)
>  {
> +	struct ad7606_state *st = iio_priv(indio_dev);
>  	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
>  
>  	if (!st->sw_mode_en) {
> @@ -345,10 +346,12 @@ static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
>  	return 0;
>  }
>  
> -static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
> +static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
>  				  bool *bipolar, bool *differential)
>  {
> -	unsigned int num_channels = st->chip_info->num_channels - 1;
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int num_channels = st->chip_info->num_adc_channels;
> +	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
>  	struct device *dev = st->dev;
>  	int ret;
>  
> @@ -364,7 +367,7 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
>  			continue;
>  
>  		/* channel number (here) is from 1 to num_channels */
> -		if (reg == 0 || reg > num_channels) {
> +		if (reg < offset  || reg > num_channels) {

Unwanted bonus space before ||

>  			dev_warn(dev,
>  				 "Invalid channel number (ignoring): %d\n", reg);
>  			continue;
> @@ -399,9 +402,10 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
>  	return 0;
>  }


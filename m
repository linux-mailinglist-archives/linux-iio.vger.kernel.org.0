Return-Path: <linux-iio+bounces-21617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD100B031A3
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96333B9537
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842627A130;
	Sun, 13 Jul 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/t8MNZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152421C3C1F;
	Sun, 13 Jul 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418728; cv=none; b=bBigmrDwWFl9Y1/ZW53+MYQ5FVP/2/0fCKz7z20lABtPEI50Kpku3eA+wgkE7+ctK0l71QbtObPM0aEC6BOpmScLGFmY/WbgzRqHI7QjYzmU+aEtz3AA4GiNzw3xyUBGdlgjnRjA+CTMdc2YPsfMMVYFTfp9nrI8wPDCORXQ9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418728; c=relaxed/simple;
	bh=eo/20iFgUaYmaHCfZc2zmCv9VLWY1wsTdJqZWx2yBkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4Gbm6km9M6cdOsfh1chU6Tr80v8gtGUdEXJJpt/mSRco/yTnyQAU5tlJ7FnT9R1iOR3FSPgUiCvtx/dSFkoEgX/a+tNDxrOBBTOS/RBJZMhHaav0ZV/+dH1gaDmSlbTIK5vXJJkHJ0LMQ02ZAskZK7s7m23NJmG+ODTgvqEUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/t8MNZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73984C4CEE3;
	Sun, 13 Jul 2025 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752418727;
	bh=eo/20iFgUaYmaHCfZc2zmCv9VLWY1wsTdJqZWx2yBkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/t8MNZsvjb1TKlsWvBxHTUicT7ZMN+djiNImqBUvLpvcX4wYOfdh6QLgmxXB/JMX
	 CkYqWULQ4pKenIANBnzUFbJttx8ikccwVxwGjdx4bHrxaoOse8uAqhS2B4N/wrARIy
	 Ss1LCUSu+51xnM77sv5qwGdjos5uYKTV2h8STSBrnAMFKuC/8+VbJW8QdVQ+QgTogp
	 7eU9ryOvaZd6eLl+91cCO2P5xhkIRfBb8yOEBZNwsc9rKkStpHJHo814pSi1jRfCzx
	 D91cvPyofDOICWrM3JndiIvRgX4uiNbQw0MRHdTvT2RJa5xNED4IZ16U7AHGw/91nP
	 qAtiONZXNyQag==
Date: Sun, 13 Jul 2025 15:58:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: prevent scan if too many setups
 requested
Message-ID: <20250713155839.07476235@jic23-huawei>
In-Reply-To: <20250709-iio-adc-ad7173-fix-setup-use-limits-v1-1-e41233029d44@baylibre.com>
References: <20250709-iio-adc-ad7173-fix-setup-use-limits-v1-1-e41233029d44@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 11:35:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
> the maximum number of unique channel configurations.
> 
> In the AD7173 family of chips, there are some chips that have 16
> CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
> GAINx and OFFSETx registers). Since commit 2233378a8c60 ("iio: adc:
> ad7173: fix num_slots"), it is possible to have more than 8 channels
> enabled in a scan at the same time, so it is possible to get a bad
> configuration where more than 8 channels are using unique configurations.
> This happens because the algorithm to allocate the setup slots only
> takes into account which slot has been least recently used and doesn't
> know about the maximum number of slots available.
> 
> Since the algorithm to allocate the setup slots is quite complex, it is
> simpler to check after the fact if the current state is valid or not.
> So this patch adds a check in ad7173_update_scan_mode() after setting up
> all of the configurations to make sure that the actual setup still
> matches the requested setup for each enabled channel. If not, we prevent
> the scan from being enabled and return an error.
> 
> The setup comparison is ad7173_setup_equal() is refactored to a separate
> function since we need to call it in two places now.
> 
> Fixes: 2233378a8c60 ("iio: adc: ad7173: fix num_slots")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I know this isn't pretty, but after puzzling over it for a day, this was
> the best I could come up with that didn't involve a complete rewrite of
> the setup allocation algorithm.
> 
> I don't really understand why we care about which setup was the least
> recently used - it isn't like we are going to wear out one setup by
> using it too much. 
> Maybe it was just to reduce the number of SPI xfers?

Been a while, so I may be remembering the intent here wrong.
The challenge of these allocators is exactly what you have called out.
How do we cope if too many configs are needed to deliver the mix of
channel configs requested.  I think the LRU thing was an attempt to
reduce the amount of reconfiguring needed.  That's mostly relevant of
single channel reads I think...


> Anyway, ad7124 has a similar setup allocation algorithm, so it could be
> nice to eventually replace both of these with something common that is
> a bit simpler, e.g. always use SETUP 0 for single transfers and allocate
> the rest of the setups in order for buffered reads with more than one
> channel enabled.

So don't use setup 0 for buffered reads?  That sounds odd.

> And just always re-write the setup each time so we
> don't have to try to keep track of what each slot is programmed with.

Fair enough as a simplification.

If you've stopped using the lru, why are things like the _lru() functions still used?

> 
> Also, the commit hash this references is currently in iio/fixes-togreg,
> so if that gets rebased, it will need to be updated here.
> ---
>  drivers/iio/adc/ad7173.c | 87 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 75 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index c41bc5b9ac597f57eea6a097cc3a118de7b42210..d1d6c20fb1ee3f8479e8faa2209206e208adb90a 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -200,7 +200,7 @@ struct ad7173_channel_config {
>  	/*
>  	 * Following fields are used to compare equality. If you
>  	 * make adaptations in it, you most likely also have to adapt
> -	 * ad7173_find_live_config(), too.
> +	 * ad7173_setup_equal(), too.
>  	 */
>  	struct_group(config_props,
>  		bool bipolar;
> @@ -563,12 +563,19 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
>  	st->config_usage_counter = 0;
>  }
>  

> +static struct ad7173_channel_config *
> +ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
> +{
> +	struct ad7173_channel_config *cfg_aux;
> +	int i;
> +
>  	for (i = 0; i < st->num_channels; i++) {
>  		cfg_aux = &st->channels[i].cfg;
>  
> -		if (cfg_aux->live &&
> -		    cfg->bipolar == cfg_aux->bipolar &&
> -		    cfg->input_buf == cfg_aux->input_buf &&
> -		    cfg->odr == cfg_aux->odr &&
> -		    cfg->ref_sel == cfg_aux->ref_sel)
> +		if (cfg_aux->live && ad7173_setup_equal(cfg, cfg_aux))
>  			return cfg_aux;
>  	}
>  	return NULL;
> @@ -1230,7 +1245,7 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
>  	struct ad7173_state *st = iio_priv(indio_dev);
> -	int i, ret;
> +	int i, j, k, ret;
>  
>  	for (i = 0; i < indio_dev->num_channels; i++) {
>  		if (test_bit(i, scan_mask))
> @@ -1241,6 +1256,54 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
>  			return ret;
>  	}
>  
> +	/*
> +	 * On some chips, there are more channels that setups, so if there were
> +	 * more unique setups requested than the number of available slots,
> +	 * ad7173_set_channel() will have written over some of the slots. We
> +	 * can detect this by making sure each assigned cfg_slot matches the
> +	 * requested configuration. If it doesn't, we know that the slot was
> +	 * overwritten by a different channel.
> +	 */
> +	for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
> +		const struct ad7173_channel_config *cfg1, *cfg2;
> +
> +		cfg1 = &st->channels[i].cfg;
> +
> +		for_each_set_bit(j, scan_mask, indio_dev->num_channels) {
> +			cfg2 = &st->channels[j].cfg;
> +
> +			/*
> +			 * Only compare configs that are assigned to the same
> +			 * SETUP_SEL slot and don't compare channel to itself.
> +			 */
> +			if (i == j || cfg1->cfg_slot != cfg2->cfg_slot)
> +				continue;
> +
> +			/*
> +			 * If we find two different configs trying to use the
> +			 * same SETUP_SEL slot, then we know that the that we
> +			 * have too many unique configurations requested for
> +			 * the available slots and at least one was overwritten.
> +			 */
> +			if (!ad7173_setup_equal(cfg1, cfg2)) {
> +				/*
> +				 * At this point, there isn't a way to tell
> +				 * which setups are actually programmed in the
> +				 * ADC anymore, so we could read them back to
> +				 * see, but it is simpler to just turn off all
> +				 * of the live flags so that everything gets
> +				 * reprogramed on the next attempt read a sample.
> +				 */
> +				for (k = 0; k < st->num_channels; k++)
> +					st->channels[k].cfg.live = false;
> +
> +				dev_err(&st->sd.spi->dev,
> +					"Too many unique channel configurations requested for scan\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 2233378a8c606f7f6893d4c16aa6eb6fea027a52
> change-id: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780
> 
> Best regards,



Return-Path: <linux-iio+bounces-23836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551BB47A4A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AF2189DA9D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF3239E91;
	Sun,  7 Sep 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf/mJF6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A8239570;
	Sun,  7 Sep 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239222; cv=none; b=icxHBAbo357IjnAGsC5mQ0kcmJyuW+u5lpe+lXiputPsnU5CAfLrxi4zirpYfL7hXcp97C8X+PEpWnHYtT/VwCKH52sZX8kaO84b/t/AbGwV77yJBihL6JKiSF5dM59ruKAytINrHvWYXOG62S5KVpK89sDupDnfHld3U23sHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239222; c=relaxed/simple;
	bh=JfWpUEYPQW2GReQ0sxKhjJEbIWFSP22pqQB4+WmvFNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI3P+MOn646Nb3PAuAAY6NoAkZA51fWnM+q71pjM9erCck+6iBWOAVtO3RrALNV1hS78Ge8glYYVrGPoju64cKhh8VNXUaBFsxudOaJHo7ueMJ+YaFUCRGkWGlI/eYSdTz6171/NtUa9KkoLrIrzKvkwoIvEcNEABZe60b+nTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf/mJF6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B269EC4CEF0;
	Sun,  7 Sep 2025 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757239221;
	bh=JfWpUEYPQW2GReQ0sxKhjJEbIWFSP22pqQB4+WmvFNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kf/mJF6g0PrhJLF22iz2kYWzDCNwLvGvFL5r/OHQMmwUoVBXY6V2YOHsEh0+omK+x
	 saV5X4yj/RoQL/YBKAJcyElFQfer5VLzMtjlpaDBt2ACuEm3AhrIsRJazT+10NlK7u
	 lCNvszuhDonbRRdIc7x5Lzf/8ZQ+1IO8p82LopO6hmtKFOEyEogNsP13iWg/IFYUFM
	 HS7kQBgCe//1gK66lTHOCazzoYo3uFL6XBNlKAWQXQvsaNaF5Gb13XpOse+3ij2hUF
	 Q9RVduCVPBHWHpBYBHfPal/LSFjnoBFCwzkQGTV+WLtxvlxpQ5e5VxabXPM0oJQ9ZL
	 6RorwOTFpeJfQ==
Date: Sun, 7 Sep 2025 11:00:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7124: fix sample rate for multi-channel
 use
Message-ID: <20250907110013.266c2da2@jic23-huawei>
In-Reply-To: <20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com>
References: <20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 12:33:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change how the FS[10:0] field of the FILTER register is calculated to
> get consistent sample rates when only one channel is enabled vs when
> multiple channels are enabled in a buffered read.
> 
> By default, the AD7124 allows larger sampling frequencies when only one
> channel is enabled. It assumes that you will discard the first sample or
> so to allow for settling time and then no additional settling time is
> needed between samples because there is no multiplexing due to only one
> channel being enabled. The conversion formula to convert between the
> sampling frequency and the FS[10:0] field is:
> 
>     fADC = fCLK / (FS[10:0] x 32)
> 
> which is what the driver has been using.
> 
> On the other hand, when multiple channels are enabled, there is
> additional settling time needed when switching between channels so the
> calculation to convert between becomes:
> 
>     fADC = fCLK / (FS[10:0] x 32 x N)
> 
> where N depends on if SINGLE_CYCLE is set, the selected filter type and,
> in some cases, the power mode.
> 
> The FILTER register has a SINGLE_CYCLE bit that can be set to force the
> single channel case to use the same timing as the multi-channel case.
> 
> Before this change, the first formula was always used, so if all of the
> in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
> a buffered read with 1 channel enabled would result in the requested
> sampling frequency of 10 Hz. But when more than one channel was
> enabled, the actual sampling frequency would be 2.5 Hz per channel,
> which is 1/4 of the requested frequency.
> 
> After this change, the SINGLE_CYCLE flag is now always enabled and the
> multi-channel formula is now always used. This causes the sampling
> frequency to be consistent regardless of the number of channels enabled.
> 
> For now, we are hard-coding N = 4 since the driver doesn't yet support
> other filter types other than the default sinc4 filter.
> 
> The AD7124_FILTER_FS define is moved while we are touching this to
> keep the bit fields in descending order to be consistent with the rest
> of the file.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Given you replied to Andy's indentation comment on v2 and that seemed
reasonable to me + the other change is a simplification for now I think
this is ready to go.

Given the whole ABI / fixes tag point I'm going to apply it to the
'slow' path and taking via testing/togreg for the next merge windows.

Applied to togreg and pushed out as testing for 0-day to take a look.

Thank,

Jonathan

> ---
> This is one of those unfortunate cases where we are fixing a bug but we
> risk breaking userspace that may be depending on the buggy behavior.
> 
> I intentionally didn't include a Fixes: tag for this reason.
> 
> Given some of the other shortcomings of this driver, like using an
> integer IIO_CHAN_INFO_SAMP_FREQ value when it really needs to allow a
> fractional values, it makes me hopeful that no one is caring too much
> about the exact value of the sampling frequency. So I'm more willing
> than I would normally be to take a risk on making this change.
> 
> [1] https://lore.kernel.org/linux-iio/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com/
> ---
> Changes in v3:
> - Removed the ad7124_get_avg() and harded-coded N = 4 for now.
> - Link to v2: https://lore.kernel.org/r/20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com
> 
> Changes in v2:
> - Improved comment explaining why the new factor always applies.
> - Fixed merge conflict with iio/testing branch.
> - Replaced avg parameter with ad7124_get_avg() function.
> - Link to v1: https://lore.kernel.org/r/20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com
> ---
>  drivers/iio/adc/ad7124.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index c6435327d431e5f4ba28aa3332ec6eb90da7c83d..70f458e3ccc12db884dda9003abcffdf48989e5e 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -93,10 +93,13 @@
>  #define AD7124_CONFIG_PGA		GENMASK(2, 0)
>  
>  /* AD7124_FILTER_X */
> -#define AD7124_FILTER_FS		GENMASK(10, 0)
>  #define AD7124_FILTER_FILTER		GENMASK(23, 21)
>  #define AD7124_FILTER_FILTER_SINC4		0
>  #define AD7124_FILTER_FILTER_SINC3		2
> +#define AD7124_FILTER_FILTER_SINC4_SINC1	4
> +#define AD7124_FILTER_FILTER_SINC3_SINC1	5
> +#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
> +#define AD7124_FILTER_FS		GENMASK(10, 0)
>  
>  #define AD7124_MAX_CONFIGS	8
>  #define AD7124_MAX_CHANNELS	16
> @@ -285,18 +288,20 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
>  
>  static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
>  {
> -	unsigned int fclk, odr_sel_bits;
> +	unsigned int fclk, factor, odr_sel_bits;
>  
>  	fclk = ad7124_get_fclk_hz(st);
>  
>  	/*
> -	 * FS[10:0] = fCLK / (fADC x 32) where:
> +	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
>  	 * fADC is the output data rate
>  	 * fCLK is the master clock frequency
> +	 * N is number of conversions per sample (depends of filter type)
>  	 * FS[10:0] are the bits in the filter register
>  	 * FS[10:0] can have a value from 1 to 2047
>  	 */
> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
> +	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
> +	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
>  	if (odr_sel_bits < 1)
>  		odr_sel_bits = 1;
>  	else if (odr_sel_bits > 2047)
> @@ -306,7 +311,8 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  		st->channels[channel].cfg.live = false;
>  
>  	/* fADC = fCLK / (FS[10:0] x 32) */
> -	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
> +	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
> +								factor);
>  	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
>  }
>  
> @@ -439,10 +445,20 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * NB: AD7124_FILTER_SINGLE_CYCLE is always set so that we get the same
> +	 * sampling frequency even when only one channel is enabled in a
> +	 * buffered read. If it was not set, the N in ad7124_set_channel_odr()
> +	 * would be 1 and we would get a faster sampling frequency than what
> +	 * was requested.
> +	 */
>  	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
> +		AD7124_FILTER_SINGLE_CYCLE |
>  		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
>  	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
> -				     AD7124_FILTER_FILTER | AD7124_FILTER_FS,
> +				     AD7124_FILTER_FILTER |
> +				     AD7124_FILTER_SINGLE_CYCLE |
> +				     AD7124_FILTER_FS,
>  				     tmp, 3);
>  }
>  
> 
> ---
> base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
> change-id: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0
> 
> Best regards,



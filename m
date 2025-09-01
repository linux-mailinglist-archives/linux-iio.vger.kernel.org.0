Return-Path: <linux-iio+bounces-23586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9CB3EBAE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FF71894526
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CE92D594D;
	Mon,  1 Sep 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILl/M67h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763F22DF95;
	Mon,  1 Sep 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742278; cv=none; b=OTOh5mMTFVyO83578fEu6K5CHwjRPMtIM3slHB3ug471AwbfeiQ7R6mB4xJMTjyBfglOjKjhA5mjgG6I1QhFugOAhXqWXCOIA0nXlKu/EGIS0uaxvN34ioD8rKAWx9u1sJiDKQbDQKgD79w0b4lSEq945Q69GjMeEOjsfX5Xdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742278; c=relaxed/simple;
	bh=UGkUSdVdIFBvsm+oD4Xzw82yx2nmQBmXIiJ9qIDdMcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tllELRK1py0H26IbwaJ0c0WK7PUmSZasX8GO0x0iIg4LjBSgECMfk8TiVBzqsOLxc2pYYBW9PyaOJ/YUZv40hj+juSBx1/mWGnDBVr/Ya8jhvTV/0AsEwCTSfw0h/23KfqzHPlnVvfVO2JgTgUgOD6ePsSp0lGv59/wyxebS2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILl/M67h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7849FC4CEF0;
	Mon,  1 Sep 2025 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756742278;
	bh=UGkUSdVdIFBvsm+oD4Xzw82yx2nmQBmXIiJ9qIDdMcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILl/M67hwB5Muz+QBpvfxKHuBKTUjnIzQtvNVY14X2WGd25HssXTwGgLwmbJ+ydGg
	 SCKBiz5+Qi/gXgvzOc4xVqz9Uwfag2BnMxrxN782bRB3wfXtSBz+gRRf4q1uREOD3N
	 sC0Cxjz4FebR28Yhn4W0oTbLjb3QWZi7r/Fx2rk68v3UxK7Mmm0QZf2Az/1JeRN+c6
	 LlJL/KNz1jtLubwUu1fb5l2fBZkYXF7az3LSE1VbqSMICQfDTU5agCv7HQichuahRc
	 IM7+qlbad0WOqojkPXahllZP5vOLi5mcFSLU80CwN3O8pLNxugp6ZP4XWK+ougl65b
	 AHnh2gT9qd54Q==
Date: Mon, 1 Sep 2025 16:57:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix sample rate for multi-channel use
Message-ID: <20250901165751.305d0a68@jic23-huawei>
In-Reply-To: <20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com>
References: <20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 11:42:28 -0500
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
>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
> 
> where AVG depends on the filter type selected and the power mode.
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
> Technically, introducing the avg parameter is not needed at this time
> since we currently only support a single filter mode which always has an
> AVG value of 1. But it helps to show where the factor comes from in the
> datasheet and will be used in the future when supporting additional
> filter types.
> 
> The AD7124_FILTER_FS define is moved while we are touching this to
> keep the bit fields in descending order to be consistent with the rest
> of the file.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
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
> I also have a plan to resolve things if we do find we broke someone and
> need to revert the change. We have a recent devicetree fix [1] for these
> chips that would allow us to detect "new" users using the correct DT
> bindings and "old" users using the buggy bindings. So we could use this
> as a way to also enable the old buggy sampling frequency behavior only
> for "old" users while allowing "new" users to get the correct behavior.

I'm not convinced this is a good plan as it may avoid regressions on a
particular board, but they are going to get unexpected changes if say
they order a new board of same type that has a newer DT.

Anyway hopefully we won't need it!

> 
> [1] https://lore.kernel.org/linux-iio/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com/

Just one comment on the comment.

I'd like some more eyes on this though as whilst it seems reasonable
the whole different modes bit changing timings is not particularly obvious.

> ---
>  drivers/iio/adc/ad7124.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 3fc24f5fffc8f200c8656cb97f9e7f80546f688b..d75ef4d5de233c2a548c732b36440d0d82c86f34 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -84,10 +84,11 @@
>  #define AD7124_CONFIG_PGA		GENMASK(2, 0)
>  
>  /* AD7124_FILTER_X */
> -#define AD7124_FILTER_FS		GENMASK(10, 0)
>  #define AD7124_FILTER_FILTER		GENMASK(23, 21)
>  #define AD7124_FILTER_FILTER_SINC4		0
>  #define AD7124_FILTER_FILTER_SINC3		2
> +#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
> +#define AD7124_FILTER_FS		GENMASK(10, 0)
>  
>  #define AD7124_MAX_CONFIGS	8
>  #define AD7124_MAX_CHANNELS	16
> @@ -250,9 +251,10 @@ static int ad7124_set_mode(struct ad_sigma_delta *sd,
>  	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
>  }
>  
> -static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
> +static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel,
> +				   unsigned int odr, unsigned int avg)
>  {
> -	unsigned int fclk, odr_sel_bits;
> +	unsigned int fclk, factor, odr_sel_bits;
>  
>  	fclk = clk_get_rate(st->mclk);
>  	/*
> @@ -261,8 +263,12 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  	 * fCLK is the master clock frequency
>  	 * FS[10:0] are the bits in the filter register
>  	 * FS[10:0] can have a value from 1 to 2047
> +	 * When multiple channels in the sequencer or the SINGLE_CYCLE bit is
This sentence doesn't read. Maybe something with a few more words like.

	 * When multiple channels are enabled in the sequencer, the
	 * SINGLE_CYCLE bit is set or when certain filter modes are enabled,...

> +	 * or when certain filter modes are enabled, there is an extra factor
> +	 * of (4 + AVG - 1) to allow for settling time.
>  	 */
> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
> +	factor = 32 * (4 + avg - 1);
> +	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);




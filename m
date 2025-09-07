Return-Path: <linux-iio+bounces-23841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C96B47A74
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70003BEEA1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89E225A3D;
	Sun,  7 Sep 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQeGKZc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A172219A67;
	Sun,  7 Sep 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240543; cv=none; b=ePXlVZukTVR+zUX+Woy6rW16S0r0lHRIVC4+N6lb5ICtMHFBWjcJ0hXhc9355EtFCV/ZBRfp8c0B8jrRzlFPnxMb50B2M+kVmtG/2flnPT0puk+D//Ez/g+ZnddYq/ZqdbsOVaH9WMwzdWyxeLRleUjw1ptHvS7mINRvO672cwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240543; c=relaxed/simple;
	bh=OcQ2itqXYbva0bLYz0wJqI1fpzp1sSZlD7a9N1J0klw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUbWPvQMbFzHQdnfQg6eVaevP58+CeETUGX0Zb/L7IRUGqihk9g0BdiJmbHdwHlOyVmeMsVW4mnfa5c+g+Q3Tz8SqUVTOMNq2lvgunhKYiUy+4pscAhGOYCmv+8J5ZlmDSuOPVOlSKtHxNPhkr/Bo13UyexIQG7gWKjiRecYQfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQeGKZc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDC9C4CEF0;
	Sun,  7 Sep 2025 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757240543;
	bh=OcQ2itqXYbva0bLYz0wJqI1fpzp1sSZlD7a9N1J0klw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQeGKZc36+YkYgEnHkM961PNoAtvPl+jEPD8jb8GHnFZQz4Yl7MOEax3DLO8AzeSK
	 fRfdsG95CxaeOiA3A3XHVgAi7Aq0Yy1ttmVCRrtTIpt6b5HBYdfDrUEsRpDASP6nOw
	 hgn9wnUbhygbJymjC410VWc47jnxRUPKqyb2NbxpOTVHele4KZh/6hJ3T2+e20j+hj
	 rGvYFuvoEpDclrBJWBnKXLWUuGgiTYnhQ1MuXXYzquQu9tFjhw4qQo3YAY38Hn/Cm8
	 CTL8/lvShcekpQT0+8uCLqhvWFhFo/C/zm1JJXQIjahyU3aty5gK5hFtkoj+KYhD6l
	 gb8xwy0Ll5P/g==
Date: Sun, 7 Sep 2025 11:22:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: adc: ad7124: add filter support
Message-ID: <20250907112214.36b8564a@jic23-huawei>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-5-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-5-aee3834be6a9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 13:12:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add support to the ad7124 driver for selecting the filter type.
> 
> The filter type has an influence on the effective sampling frequency of
> each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
> For sinc{3,4} (without post filter), there is a factor of 3 or 4
> depending on the filter type. For the extra +sinc1, there is an extra
> averaging factor that depends on the power mode.
> 
> In order to select the closest sampling frequency for each filter type,
> we keep a copy of the requested sampling frequency. This way, if the
> user sets the sampling frequency first and then selects the filter type,
> the sampling frequency will still be as close as possible to the
> requested value.
> 
> Since we always either have the SINGLE_CYCLE bit set or have more than
> one channel enabled, the sampling frequency is always using the
> "zero-latency" calculation from the data sheet. This is only documented
> for the basic sinc{3,4} filters, so the other filter types had to be
> inferred and confirmed through testing.
> 
> Since the flat filter type list consists of multiple register fields,
> the struct ad7124_channel_config::filter_type field is changed to the
> enum ad7124_filter_type type to avoid nested switch statements in a
> lot of places.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

One really trivial comment inline.  Not worth a v2 for just that.
However, this is complex enough code I'd like to keep this on list anyway
for a little longer to see if anyone else has review comments.

Jonathan



> -static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel,
> -				   unsigned int odr, unsigned int odr_micro)
> +static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel)
>  {
> +	struct ad7124_channel_config *cfg = &st->channels[channel].cfg;
>  	unsigned int fclk, factor, odr_sel_bits;
>  
>  	fclk = ad7124_get_fclk_hz(st);
> +	factor = ad7124_get_fs_factor(st, channel);
>  
>  	/*
>  	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
> @@ -310,9 +362,9 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  	 * FS[10:0] are the bits in the filter register
>  	 * FS[10:0] can have a value from 1 to 2047
>  	 */
> -	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
> -					       odr_micro * factor / MICRO);
> +	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, cfg->requested_odr * factor +
> +					       cfg->requested_odr_micro *
> +					       factor / MICRO);

This second parameter is getting complex enough, perhaps worth introducing
a local variable?
	divisor = cfg->requested_odr * factor +
		  cfg->requested_odr_micro * factor / MICRO;
perhaps, or local variables for odr and odr_micro to keep this unchanged in this path.


>  	odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
>  
>  	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)


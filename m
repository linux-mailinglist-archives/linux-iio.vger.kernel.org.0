Return-Path: <linux-iio+bounces-22038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2EBB12F79
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0EA176D55
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8A215798;
	Sun, 27 Jul 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgaz9JqR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD12144C9;
	Sun, 27 Jul 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619503; cv=none; b=TGmkEehFR0uwbx/g+VhPyFS8GlFZwUw+KbN76B5fsY0dhzbDnx2qe/eLXRLTNV1JOX4OiAxNskAIB7Sgy1Ttj64wCXTDsf8qtKBi8ni1SxW+id1JjOtoXQx44GhrVOP+OPKxiTA/Bf9RjxNCuMxgUm2nxgGGTm9tHdao5I1Eg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619503; c=relaxed/simple;
	bh=k6k+z35tBwqWT3AAx1Q+8WeGzFHSJLB6sZrDkPR5PqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st5UAJ3hDbKeTqmBVbkNHohnczwFeDBOgK8yOULzgjFTtDITLLH+szVgTBAxJ1kGJTypsm2RoDvEhWGXHRC1+VVSyCCHbM9C+vOwCzMs5msdWsldzDkGSp6qZ3Uxg4ceyVwaFKtxk7jZWYkJASnBt8cM/tjhmeo8F099YW1DEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgaz9JqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B43AC4CEEB;
	Sun, 27 Jul 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619503;
	bh=k6k+z35tBwqWT3AAx1Q+8WeGzFHSJLB6sZrDkPR5PqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tgaz9JqRvEOBV3CMvTK/z5O94U1Ls+CAmW+QUugLW7GcdIH20IqsLft7gKwqmdWOR
	 LSgKyRP0vZ3LogK2wUj2HKsYGmXhqMwnBlQA0R4If8w8XknCCbFKspxk4pj/p/yXya
	 CGx/28KKJYtMTROtyOKrMKiDinnS0Muo494UAZzBesQMaUNM8UIg0aD79SWbz6Ka1F
	 +4gyDQCVtLQCtZP34U+JBVcKgKE8uKFQ5H3Z2mwckozLAJ1fFao+zRX/43A80NSxtE
	 EQxinwsHmB++GZAlxS1j5mu1xbvRQ0qTwdn3g+YehnlbA2ieHNkqH2/aI4zkNiKtXJ
	 VqdhWx102OHPw==
Date: Sun, 27 Jul 2025 13:31:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix channel lookup in syscalib
 functions
Message-ID: <20250727133135.385fa7c5@jic23-huawei>
In-Reply-To: <20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-v1-1-b9d14bb684af@baylibre.com>
References: <20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-v1-1-b9d14bb684af@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Jul 2025 11:28:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix possible incorrect channel lookup in the syscalib functions by using
> the correct channel address instead of the channel number.
> 
> In the ad7124 driver, the channel field of struct iio_chan_spec is the
> input pin number of the positive input of the channel. This can be, but
> is not always the same as the index in the channels array. The correct
> index in the channels array is stored in the address field (and also
> scan_index). We use the address field to perform the correct lookup.
> 
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Seems fine to me and i'll queue it up, but I would welcome another set of
eyes on this one.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9808df2e92424283a86e9c105492c7447d071e44..4d8c6bafd1c3171054c72a0d2b13d6b1afc4e51a 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -849,7 +849,7 @@ enum {
>  static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
>  {
>  	struct device *dev = &st->sd.spi->dev;
> -	struct ad7124_channel *ch = &st->channels[chan->channel];
> +	struct ad7124_channel *ch = &st->channels[chan->address];
>  	int ret;
>  
>  	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
> @@ -865,8 +865,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
>  		if (ret < 0)
>  			return ret;
>  
> -		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
> -			chan->channel, ch->cfg.calibration_offset);
> +		dev_dbg(dev, "offset for channel %lu after zero-scale calibration: 0x%x\n",
> +			chan->address, ch->cfg.calibration_offset);
>  	} else {
>  		ch->cfg.calibration_gain = st->gain_default;
>  
> @@ -880,8 +880,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
>  		if (ret < 0)
>  			return ret;
>  
> -		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
> -			chan->channel, ch->cfg.calibration_gain);
> +		dev_dbg(dev, "gain for channel %lu after full-scale calibration: 0x%x\n",
> +			chan->address, ch->cfg.calibration_gain);
>  	}
>  
>  	return 0;
> @@ -924,7 +924,7 @@ static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad7124_state *st = iio_priv(indio_dev);
>  
> -	st->channels[chan->channel].syscalib_mode = mode;
> +	st->channels[chan->address].syscalib_mode = mode;
>  
>  	return 0;
>  }
> @@ -934,7 +934,7 @@ static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad7124_state *st = iio_priv(indio_dev);
>  
> -	return st->channels[chan->channel].syscalib_mode;
> +	return st->channels[chan->address].syscalib_mode;
>  }
>  
>  static const struct iio_enum ad7124_syscalib_mode_enum = {
> 
> ---
> base-commit: e4d9886ad25adae72f38f2b12f41649b101581ae
> change-id: 20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-e28c933ead2a
> 
> Best regards,



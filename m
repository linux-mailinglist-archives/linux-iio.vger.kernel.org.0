Return-Path: <linux-iio+bounces-13227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FF9E869A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24221884D96
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399B1714B5;
	Sun,  8 Dec 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHBt1DPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23A170A15;
	Sun,  8 Dec 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675940; cv=none; b=lgMhdo1n/hPYt0eZ8Apf4TQrQqhtq8TruLeEbjiVEJvueV8hdx35IRDWMYEEv3it3VOhmRVInaShImOAZWPC+sBOGe9jXoc1nmmw/OHk6W1dLZLwjpwJmsr9A0djAfaD+tcZ24lHfJuEzHFMtkKSeJTQbnkzRPU3117Ka5V8RXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675940; c=relaxed/simple;
	bh=sVgC6fFANm4YvTxqIJfUkENZ4pfQs2PLRusgHdi9Koo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYiMnsVsmyc6E7CIBh4wipQzg0EidZDGkeyiUyyYRcy8zyfGR6Udm1FSVYlasRdQjEVjt0YNSgBNws05BfEqQXX34v2JZxGP3eiyBZ2pLGitW/lfxgvbBZ8ImdJD+d26LEiTzH0FOSWGZw3c632jqXULsXf8MXzwKaYFFTHfpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHBt1DPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A950C4CEE0;
	Sun,  8 Dec 2024 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733675940;
	bh=sVgC6fFANm4YvTxqIJfUkENZ4pfQs2PLRusgHdi9Koo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZHBt1DPWpkWGatAOLmY6NJYYYQhJqKrVJK3NJW88HyFCuQWDylAwDvahpMvDoV0iv
	 bm11ZdRK5hjKApiwAOOPmc1UzRBGE5x4fr6vRxYNbCV4KUWVrvelwlIDkWGzVosT5B
	 uU0OX8mLfCo8IFD7MGnBs0bUFi5tRoC9OpfkNxDeZ9eQbX+WmUCtzFjOL9gQCaI+Ss
	 NA09WQwiCqpsuiR8Z4h05BW7C522XZiPkfyxmRSDEVKCVNU92ZoCobGjbk0cwaXv0X
	 rFiWMttEdPwnMBRFnblQZQfRC/rM7CRWooGOhyGkHo8U2T/iX/rATatX70tRgpvRPF
	 AwN/YrE1/HPcA==
Date: Sun, 8 Dec 2024 16:38:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-prox: Merge information from different
 channels
Message-ID: <20241208163851.41c47c3f@jic23-huawei>
In-Reply-To: <20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org>
References: <20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Dec 2024 12:59:20 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> The device only provides a single scale, frequency and hysteresis for
> all the channels. Fix the info_mask_* to match the reality of the
> device.
> 
> Without this patch:
> in_attention_scale
> in_attention_hysteresis
> in_attention_input
> in_attention_offset
> in_attention_sampling_frequency
> in_proximity_scale
> in_proximity_sampling_frequency
> in_proximity_offset
> in_proximity0_raw
> in_proximity_hysteresis
> 
> With this patch:
> hysteresis
> scale
> sampling_frequency
> in_attention_input
> in_attention_offset
> in_proximity0_offset
> in_proximity0_raw
> 
> Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

whilst perhaps not ideal use of the ABI, what is there today is not wrong
as such.  If the ABI above was all introduce in the recent patch I might
be fine adjusting it as you suggestion. However it wasn't, in_proximity_scale
has been there a long time so this would be an ABI change.
Those are generally only ok if there is a bug.

Drivers are always allowed to provide finer granularity than necessary
so in this case I don't see this as a bug.

Jonathan


> ---
>  drivers/iio/light/hid-sensor-prox.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index e8e7b2999b4c..f21d2da4c7f9 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -49,9 +49,11 @@ static const u32 prox_sensitivity_addresses[] = {
>  #define PROX_CHANNEL(_is_proximity, _channel) \
>  	{\
>  		.type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> -		.info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> -				      BIT(IIO_CHAN_INFO_PROCESSED),\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> +		.info_mask_separate = \
> +		(_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> +				BIT(IIO_CHAN_INFO_PROCESSED)) |\
> +		BIT(IIO_CHAN_INFO_OFFSET),\
> +		.info_mask_shared_by_all = \
>  		BIT(IIO_CHAN_INFO_SCALE) |\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),\
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241203-fix-hid-sensor-62e1979ecd03
> 
> Best regards,



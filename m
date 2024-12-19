Return-Path: <linux-iio+bounces-13669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E669F81A7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4152170F1D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AB1990B7;
	Thu, 19 Dec 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB2tWhhC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA91A072C;
	Thu, 19 Dec 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628647; cv=none; b=M+4GSE3TP5D5SL/5DxZaNQ/9PAnhwafF6k/4Vgpk6kAF1BPyhr2zVSqE3ZsAIGCfhHpN/Vpj0m0u53fxOXY/uKyI3X2VHzIJfnkZvMQn8yGG3T8AfUIyErEIMzn1nq1pHzWcOSIWIOmgvF8LI+n+Zt0foNSZDZ9YgB6wc6pxTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628647; c=relaxed/simple;
	bh=CdgZs2ST2EHcflObKh92+jX0IJgfg0jGqqPrz2v1QkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt/peYJ9ZAlTCoP9QCmlmTXkZ+1XfwmsbCi8HS/WjDoMmRu7yNlxFF08IdPKTNodrlIlEtY4v3IeT8ePTfBRmDkT63ofz9nwHRtVqCFy/MeHM9fdYpH7KGEle68R5d1It+CTVjVkLAw8KGJzlcQIdo2rmzW/Fu881oudwnpI+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB2tWhhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F85C4CED0;
	Thu, 19 Dec 2024 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734628646;
	bh=CdgZs2ST2EHcflObKh92+jX0IJgfg0jGqqPrz2v1QkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fB2tWhhCaFvCyMNFX8WnhXVjx72vUb6jB0R7Oc+l/7pS4N+Yzqm1NkCCyBmPFts+K
	 2uIcJcFANQnR0QAEdLabLy9eEwmmpPSlMWba0POJUoQ/hdXbfCN6q4Bm0L7PClguiM
	 u9rE10wmUiqmNduL7P7LPR/nFptBvkrsiCLfSt3s8k3xn9V8DZW9YY1qDH6CG5pFMF
	 JWRl1PEodGhv7wANNltLUw/Ae9+B5l6YJz9J9yfFuE0lMFsWEINfsFfCq2qwT5o7tv
	 TKLqXYkmpmnxDvpVWNU7UxGYMDfjb7hkn/NlRsuVi2oBpbsY12XrFdazvSVl2DV3wq
	 2vsRIEt+QjJdg==
Date: Thu, 19 Dec 2024 17:17:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Message-ID: <20241219171718.2af17d6d@jic23-huawei>
In-Reply-To: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 10:05:53 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> When the driver was originally created, it was decided that
> sampling_frequency and hysteresis would be shared_per_type instead
> of shared_by_all (even though it is internally shared by all). Eg:
> in_proximity_raw
> in_proximity_sampling_frequency
> 
> When we introduced support for more channels, we continued with
> shared_by_type which. Eg:
> in_proximity0_raw
> in_proximity1_raw
> in_proximity_sampling_frequency
> in_attention_raw
> in_attention_sampling_frequency
> 
> Ideally we should change to shared_by_all, but it is not an option,
> because the current naming has been a stablished ABI by now. Luckily we
> can use separate instead. That will be more consistent:
> in_proximity0_raw
> in_proximity0_sampling_frequency
> in_proximity1_raw
> in_proximity1_sampling_frequency
> in_attention_raw
> in_attention_sampling_frequency
> 
> Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I got lost somewhere in the discussion.  This is still an ABI change compared
to original interface at the top (which is the one that has been there 
quite some time).

However we already had to make one of those to add the index that wasn't there
for _raw. (I'd missed that in earlier discussion - thanks for laying out the
steps here!)  Srinivas, Jiri, do you think we are better off just assuming users
of this will be using a library that correctly deals with sharing and just
jump to 
in_proximity0_raw
in_proximity1_raw
in_attention_raw
(should have indexed that but it may never matter) and
sampling_frequency

Which is what I think Ricardo originally asked.

Do we have any guarantee the sampling_frequency will be shared across the
sensor channels?  It may be the most common situation but I don't want to
wall us into a corner if it turns out someone runs separate sensors at
different rates (no particularly reason they should be one type of sensor
so this might make sense).  If we don't have that guarantee
then this patch is fine as far as I'm concerned.

Jonathan



> ---
> Changes in v2:
> - Use separate
> - Link to v1: https://lore.kernel.org/r/20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org
> ---
>  drivers/iio/light/hid-sensor-prox.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index c83acbd78275..71dcef3fbe57 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -49,9 +49,10 @@ static const u32 prox_sensitivity_addresses[] = {
>  #define PROX_CHANNEL(_is_proximity, _channel) \
>  	{\
>  		.type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> -		.info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> -				      BIT(IIO_CHAN_INFO_PROCESSED),\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> +		.info_mask_separate = \
> +		(_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> +				BIT(IIO_CHAN_INFO_PROCESSED)) |\
> +		BIT(IIO_CHAN_INFO_OFFSET) |\
>  		BIT(IIO_CHAN_INFO_SCALE) |\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),\
> 
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241203-fix-hid-sensor-62e1979ecd03
> 
> Best regards,



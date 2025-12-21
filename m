Return-Path: <linux-iio+bounces-27285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB16CD43FB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C211C3006F7D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D3226CF7;
	Sun, 21 Dec 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX3RJ1dt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47413A3F7;
	Sun, 21 Dec 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342104; cv=none; b=uWUVOnUIXTJiokp6/jK3ppluxTjgdbnTjlSHOmWYmX3lO3hHY29YCdC/vbdryvCnqcvaZu7v+nCtHylG0lkCpgHhkXuqNwaEGlOo0ttvLK1qv/Nmysx34skevAU4/8IKTXVdHcsECi4lusgVJfAuArxPzIbpMEti9vLBhV7QY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342104; c=relaxed/simple;
	bh=v4r3AsNHpcM1MSleHZxV+W2Xl+61sP8yUv1VWVzXKb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGYejKzxly7tNrAoQ6SLRMjGK/ZP5hCZhKrEh9NuBttf5qxDKFfC2iFe3y1b1yF0Wz6tEgERYtGIqCJ+hlUvaK3nhDJ22FGCnGVQdhbqnSC2erejZrTuyLeu4LGv87K8qxNyBAP9xgDb4rXQ8IP8ywDn9YH+5olvNs2rNVW5WRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX3RJ1dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03D1C4CEFB;
	Sun, 21 Dec 2025 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766342104;
	bh=v4r3AsNHpcM1MSleHZxV+W2Xl+61sP8yUv1VWVzXKb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iX3RJ1dtNpsN6YfEn+f7AvRVIhNyETCwNnzBbECRx1mw0Hg67/5Y5p8oEPjXJ0NGd
	 quAO3xmp48JtwM9GBM5BDncEXWBIX1eIaZ6S3ctL2UnekdlAaqvrd8O1i72vsKarU+
	 be0auNhqhLpIAcexCdQHvi7H+DW+C9zzDuqg4wlt8dbE6XfqG2NS0RWrAVAtmPDz57
	 XAMmPUmTmuLGxyaedszcwTdvQ5B+Fy56aVLe56v7EBXENYqSF8YU8UOB/+1Dz6xAF9
	 eGyZf2O3Em9FMPH9tE7ds+ZX/2/V1rv0HbKz6LLLVoeixpqnf78y3bmi8AJDtiyZRA
	 5XkdR+AGZRVXw==
Date: Sun, 21 Dec 2025 18:34:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andreas Klinger
 <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/14] iio: pressure: mprls0025pa: fix scan_type struct
Message-ID: <20251221183455.3dd15dd7@jic23-huawei>
In-Reply-To: <20251218-mprls_cleanup-v1-11-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-11-b36a170f1a5c@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 13:05:53 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Fix the scan_type sign and realbits assignment.
> 
> The pressure is a 24bit unsigned int between output_min and output_max.
> 
>  transfer function A: 10%   to 90%   of 2^24
>  transfer function B:  2.5% to 22.5% of 2^24

Hmm. So, that's not ever going to use all the bits. It fits in 22 bits?

>  transfer function C: 20%   to 80%   of 2^24
> [MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 }
> [MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 }
> [MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 }
> 
> Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Where possible drag any fixes as early as possible in the series as they
are more likely to be backported.

Here, I think the impact is constrained to the expected limits userspace
might work out rather than how the actual value of pressure is interpreted?
If so, good to fix but fairly minor bug.

Jonathan

> ---
>  drivers/iio/pressure/mprls0025pa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 9b18d5fb7e42..243a5717b88f 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -165,8 +165,8 @@ static const struct iio_chan_spec mpr_channels[] = {
>  					BIT(IIO_CHAN_INFO_OFFSET),
>  		.scan_index = 0,
>  		.scan_type = {
> -			.sign = 's',
> -			.realbits = 32,
> +			.sign = 'u',
> +			.realbits = 24,
>  			.storagebits = 32,
>  			.endianness = IIO_CPU,
>  		},
> 



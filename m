Return-Path: <linux-iio+bounces-22861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ECEB29386
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C261B261EB
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5C2E717D;
	Sun, 17 Aug 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y//FVKhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92752E7627;
	Sun, 17 Aug 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441138; cv=none; b=P2yhVzTNXWxkoF9ztlNQDE9UsBaDZ0xUcHMTRD+nXtM0XlpwzFFOcJI3wzK0/Y8w7hoH4ufQX0prEp59+htEz0UdGfnib1ycGBsZ/05mWqtQRA20seDRxrJNiBxBD0ijp8AeE/dZIKDshCJJc3p5729/+IhHeUpXqJ/nvWEsgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441138; c=relaxed/simple;
	bh=NCXorMZeOWGATWJWhtRGZU/e4/VhLOqWLoD8J+hkC3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMzxDUpeZp/Bt22beX8bb7S2KGMaiQWqOyIOHPjwuuGXL1+b+lwEV4yahefoSQRJvqvpsEypOrL+BzHH80qMdDaPe1s+q/pzgDB+TrzSkyG4Acfd6xD7avWX+5oOO+x3fT7DPxJ4/B/+HPovPRcLDJmSaKqxuwZAKgIOqETnaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y//FVKhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB599C4CEEB;
	Sun, 17 Aug 2025 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755441137;
	bh=NCXorMZeOWGATWJWhtRGZU/e4/VhLOqWLoD8J+hkC3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y//FVKhKBCW0j8Oh6nVRxGsacYdKmyGL97IEdupuTTDBr1vgZk2wxhQwkSdjR0EMR
	 0MfmMOc1yk5cnW5JQjL6rck7zkB2CoE0LasSxkuEJeYHJu1ZGmwcFcBRlpBhgtIhCq
	 iLoh16ZFuWWWrZfe0PqVkQvLT0XCFRpg14QEws8TP4GGFT8ojXAqbut4ztEdNsqHG0
	 uDWYBWwoVINNCqc/oSI5I2efZ4mwOEeYDFbuNU8NsTYMMbr8c4kVF79mZY5vPRMSmV
	 x5NUp+HTnUhCc++jC87V0KT5rWjYcFIYeG4Bgp0CqBk57Hb8CvR4xbnrn/1DvXErDh
	 PX+UCaXk+oItA==
Date: Sun, 17 Aug 2025 15:32:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 shuah@kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: adc: ad7768-1: Remove logically dead code
Message-ID: <20250817153209.560334f5@jic23-huawei>
In-Reply-To: <20250816133757.98624-1-chandramohan.explore@gmail.com>
References: <20250816133757.98624-1-chandramohan.explore@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 19:07:55 +0530
Chandra Mohan Sundar <chandramohan.explore@gmail.com> wrote:

> The clamp macro returns a value within the specified range.
> 
> In ad7768_set_freq(), the value returned from clamp() is checked against
> zero, which is not possible since the value would always be between
> 50 and 1024000.
> 
> Removed the 'if' check.
> 
> This issue was reported by static coverity analyser as logically
> dead code.
> 
> Fixes: fb1d3b24ebf5c ("iio: adc: ad7768-1: add filter type and oversampling ratio attributes")
Applied but dropped the fixes tag. No need to encourage people to backport
this.

Jonathan

> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index ca8fa91796ca..a27591bbf7df 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -687,8 +687,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
>  	int ret;
>  
>  	freq = clamp(freq, 50, 1024000);
> -	if (freq == 0)
> -		return -EINVAL;
>  
>  	mclk_div = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
>  	/* Find the closest match for the desired sampling frequency */



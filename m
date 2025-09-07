Return-Path: <linux-iio+bounces-23837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A507B47A51
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B223189DFB9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F6239570;
	Sun,  7 Sep 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycs5P8tI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788A315D45;
	Sun,  7 Sep 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239353; cv=none; b=aD9EuJd2JJL7zgWNt8xnBRQKDocY0JsvtVK7662Zmr6l3NgRcngmKvcjGFZz9REx4v/vq975zDTWJBEICh/50pzxZePYyG/9Dfyg8WCXrzWxOs5CCLY2/RCOtxGibALZzcygQcJG8CFVyFHZDr13M1UdnXOWHjtz4yq94aGm8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239353; c=relaxed/simple;
	bh=0cJgnHPcWxazPyMR750YSeFZNWwbrgGaHDCd4DkwT7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahumA47NFp4ii8M+6sQOBrkvyMGrul0kvmqwYhqIP9dGLnxO9pDkoTC31T7xbNdxwGmI+FVorOieEkILMrpbhQW52NTSHfIQQRYk6SzzZRgBFtE8qaPdf3n3VIQV8Iz+t5vtK+nrqmtd0zXv2OGdVpJzShAJ0jz/01fm/9GB5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycs5P8tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F9AC4CEF0;
	Sun,  7 Sep 2025 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757239353;
	bh=0cJgnHPcWxazPyMR750YSeFZNWwbrgGaHDCd4DkwT7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ycs5P8tId/b+g0H8i3zxLNaynePc4gOHJ7j8AAsbEDcrou0v8BXTiLi2bV9+It0Jl
	 vXuANFVNxSr+078l6nCsLq8BhaSy/jYLxLf3eDIRG+f5fd6uitDeUzNGNnXypuZUlV
	 h4KZV8UFee5sxRe8ccEw/JnzSk4SHJj9at7tsgUW9UonkyZrt8yEW614vYUia2W+5n
	 W+AEOKt7O58Fso6pAHz9UyEukqaR9NbOuUMug9k0lIw7wcDF1UILk21JO4ca3Ty1Aa
	 Kj4gzSI4N+EWcfTZuXjsW671XVlFuIjloGUA3iD5oPWIX62przVJFNMSvSeV1SYI3m
	 0WDDILULHmvIw==
Date: Sun, 7 Sep 2025 11:02:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: adc: ad7124: use clamp()
Message-ID: <20250907110225.01a6341e@jic23-huawei>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-1-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
	<20250905-iio-adc-ad7124-add-filter-support-v1-1-aee3834be6a9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 13:11:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use clamp() instead of open-coding clamping.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Good tidy up on it's own so I'll pick this up now.

I haven't read the rest yet but I'd imagine others will need
more review than this.

Applied this patch to the togreg branch of iio.git and pushed out as testing.
> ---
>  drivers/iio/adc/ad7124.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 70f458e3ccc12db884dda9003abcffdf48989e5e..117777fc8ad05b773da09c113cf84927c75d6b7b 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -15,6 +15,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/kfifo.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
> @@ -301,11 +302,7 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  	 * FS[10:0] can have a value from 1 to 2047
>  	 */
>  	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
> -	if (odr_sel_bits < 1)
> -		odr_sel_bits = 1;
> -	else if (odr_sel_bits > 2047)
> -		odr_sel_bits = 2047;
> +	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
>  
>  	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
>  		st->channels[channel].cfg.live = false;
> 



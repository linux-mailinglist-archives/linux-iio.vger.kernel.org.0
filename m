Return-Path: <linux-iio+bounces-17283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D080A73585
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0188B189B1DE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2518BB8E;
	Thu, 27 Mar 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQSjQgV0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B75186E20;
	Thu, 27 Mar 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088957; cv=none; b=rk1JChx9liMDIBI13qqoSED089eOBApdM6q/Vu0L+v9J979AszoIZMgAclkA2MPHFjWrHEnSTxYfS3fNNDwYPu2sIlNi/mn682wyqaiYyuz0N5dAokxw2MvmFn5xXqQLcjGJxgQKc3b9DA9LxkPODoIFUS9NDevRFD2zGOQo3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088957; c=relaxed/simple;
	bh=HKenljGoNABRACaUJ8GgUQs621BY3q54uwgxYhOahWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfwNcIUB1sPR1fr/VKj1SHh/oG3VIpqyVUZ1fvnz+Fms/X8Nu8sU9NwbE8eXZHMHWjKgYUBCDjsJSRzeh8MSGJjlYCzxEV4s0sfD7GwZ5rYumyuvr6EfX/4f28V4DxWivFn3xa312IuTr7lBcYnssjhZNnh2kB8sFyamd+StUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQSjQgV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B61C4CEE5;
	Thu, 27 Mar 2025 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743088956;
	bh=HKenljGoNABRACaUJ8GgUQs621BY3q54uwgxYhOahWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TQSjQgV0LedYqyAOCqrmYeYh8mOXpOsJLSkFF6cXqk1VDPCIMH4X7RHY3gEMmwGw8
	 6HbSTgbUW4EQGisH9ITvQJVnvbLqbh60wMNHa2nNFB/G48+0kKzajeLf0F+j/BA+wl
	 QLI4fmppzjhD9crffyfjyPmsL3TgJAkkslsEe8a0R46s4Oxlz/XLVZbem0mGsC5yPa
	 Rj3nxkFzc2W67tsOlfJVPyVWtSNGWMvrLtuyt6qOtDDZIUz3SD58xbkNVFyBNNrd3L
	 MRjumaulys6H9KBV1gdFHJob64JPG8K9nkwzXcU5U1a7Gm3euC6CFWzivXT0n193aE
	 aC/u++ImYGdVQ==
Date: Thu, 27 Mar 2025 15:22:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: Update bit manipulation
 macros to use FIELD_PREP and GENMASK
Message-ID: <20250327152224.61248837@jic23-huawei>
In-Reply-To: <20250326204901.44337-1-simeddon@gmail.com>
References: <20250326204901.44337-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 01:50:07 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> Update AD9832_PHASE and RES_MASK to use FIELD_PREP and GENMASK for
> clean bitmask generation and improved maintainability.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>

Hi Siddharth,
> ---
>  The previous patch would not apply cleanly as I was not working on a
>  clean branch
>  v1->v2:
>  Resolve previous patch application issues
>  
>  drivers/staging/iio/frequency/ad9832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..6e463488462a 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -59,7 +59,7 @@
>  #define AD9832_CMD_SLEEPRESCLR	0xC
>  
>  #define AD9832_FREQ		BIT(11)
> -#define AD9832_PHASE(x)		(((x) & 3) << 9)
> +#define AD9832_PHASE(x)	FIELD_PREP(GENMASK(10, 9), x)
This code is mixing two styles, the sort of 'function' to set
case here and the providing of direct masks that
are suitable for inline FIELD_PREP / FIELD_GET.

I'd prefer this was changed to the second style
#define AD9832_PHASE_MASK	GENMASK(10, 9)

Then where it used inline you can use the mask directly to clear
the bits + an inline FIELD_PREP() to set them to the desired
value.  That's cleaner than current situation where the value 3 is
passed to this macro to generate the mask.

There are other cases in the code where we have the pattern:
		if (val)
			st->ctrl_ss &= ~AD9832_SELSRC;
		else
			st->ctrl_ss |= AD9832_SELSRC;
which could be rewritten as:


		st->ctrl_ss &= ~AD932_SELSRC;
		st->ctrl_ss |= FIELD_PREP(AD932_SELSRC, !!val);

the !! is needed to ensure we get 0, 1.  Could also do
val ? 1 : 0 if you prefer.

So overall a good cleanup would be to move to consistent use
of masks (including single bit ones) and FIELD_PREP to write
the values.

Jonathan


>  #define AD9832_SYNC		BIT(13)
>  #define AD9832_SELSRC		BIT(12)
>  #define AD9832_SLEEP		BIT(13)
> @@ -69,7 +69,7 @@
>  #define ADD_SHIFT		8
>  #define AD9832_FREQ_BITS	32
>  #define AD9832_PHASE_BITS	12
> -#define RES_MASK(bits)		((1 << (bits)) - 1)
> +#define RES_MASK(bits)	GENMASK((bits) - 1, 0)
>  
>  /**
>   * struct ad9832_state - driver instance specific data



Return-Path: <linux-iio+bounces-26824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053BCAA95B
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 16:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C11C30DE353
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094425F79A;
	Sat,  6 Dec 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttJUZs8f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2B24C076;
	Sat,  6 Dec 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765035226; cv=none; b=Uv6UNnFPaeepTevauDpEMxExtzuLjB9hSlir1rizYqFX1y1sPECX7vr825jMiZBJOvvC5DxZh3Gft3uZWMwvPljt03nSdkiG6CV8VL23xU55GmLtEuV9As2guxo+bhVTKR55M1RWwBLKPd6+mdOIHcGhi502foHeJKHtg+R/gZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765035226; c=relaxed/simple;
	bh=AnQmFEU9zXW52WS9qQeG8ngPhpCGuhBG295DUAiZI50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpBhZLRjCIYmWXemH74gkDRQ7wxuHT1a4dj8/xgTCY1bafATcISvKcexVky7YfNmn+knlNCeqltNjEL0E5XG8paep5qmrVmcoKrMbNRattfZyeq2htrwprGLiDLzZBrJlSDRbEJrJv0yCD4CNQxQc3G7b9/Z87mg8ENQCAI0sDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttJUZs8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7DFC4CEF5;
	Sat,  6 Dec 2025 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765035226;
	bh=AnQmFEU9zXW52WS9qQeG8ngPhpCGuhBG295DUAiZI50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttJUZs8fFA6USqlUTvPmsELWGu71cKHdbIYaAK05h01n9jONUg1n9/R9r19AKdb1r
	 5NQmKiz+wC9EE1rE5gyC+Dflny1dWU3qYph65ubpFhxR0P+yCb9w7KzF/dvBcm4TSO
	 pH+xJVggzfn6PAfAThg09eD0nT3wFKpOQKgrmtAQ8+pqkoLzsqFGde4XRbtiohNYbP
	 wMdzIk0KgwRC479EZlPYbZDdF/ZxowxwcPyxDMJA7HCoVLIrmstch9r7BwzXahFtb4
	 2ZjLtSz6oCvD9m1Wqqg++inHzM5BJrF+wFhG6AdJPAsPj/3v1A1sjHb2vTJf8tqXhi
	 gbZPfrPpTyj5g==
Date: Sat, 6 Dec 2025 15:33:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: spear_adc: cleans up, update and sorts the
 existing includes
Message-ID: <20251206153338.57c4159b@jic23-huawei>
In-Reply-To: <20251206132120.11059-1-rodrigo.gobbi.7@gmail.com>
References: <20251206132120.11059-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Dec 2025 10:15:12 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> Remove unused includes and add what is being used (IWYU principle) and
> sort the remaining ones.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Hi Rodrigo,

Much closer but I still spotted one include I'm not sure needs
to be here.

> ---
> My reasoning was not correct at [1], tks for pointing that out @Jonathan.
> With that in mind, I've reviewed some discussions about the principle and
> I`ve changed a little bit approach: I`ve inspected the source code again
> to find  out what was being used and also checked incorrectly "indirect includes"
> using the spear_adc.i file to avoid them. The result is something like this now:
> 
> Removed:
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/iio/sysfs.h>
> 
> Added:
> #include <linux/array_size.h>
> #include <linux/bits.h>
> #include <linux/compiler_types.h>
> #include <linux/dev_printk.h>
> #include <linux/math.h>
> #include <linux/mutex.h>
> #include <linux/of.h>

For these, given we've been round a few times, it is useful to add a
brief on what is being used from each header in this change log or
indeed the patch description.

> 
> #include <linux/iio/types.h>
> 
> Tks and regards!
> 
> [1] https://lore.kernel.org/all/20251009182636.187026-1-rodrigo.gobbi.7@gmail.com/
> ---
>  drivers/iio/adc/spear_adc.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index 50b0a607baeb..b9eeed5533c6 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -5,22 +5,26 @@
>   * Copyright 2012 Stefan Roese <sr@denx.de>
>   */
>  
> -#include <linux/mod_devicetable.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/property.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
> +#include <linux/compiler_types.h>
>  #include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>

Why include of.h?

I'm not immediately seeing any use stuff defined in there
but I may be missing something.

The only thing prefixed with of_ is of_match_id which
is mod_devicetable.h

We've scrub unneeded includes of that file out of IIO a few
times in the past, so I don't really want to see new ones added.


> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>
>  
>  /* SPEAR registers definitions */
>  #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)



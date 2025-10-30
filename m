Return-Path: <linux-iio+bounces-25637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC97C1EBCD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943794E73BC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA0A336EF2;
	Thu, 30 Oct 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSusv8gJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E44334C34;
	Thu, 30 Oct 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809220; cv=none; b=jAzSaTs4UsQs6FnTAUsHq8zhtekx8dff7VRuHEgq+j3mf5uNwgeQJzlE8KsX0+dZfEE+5WEad/FiUBsll5fnqv1TwTyYW6QhctG3hpiZ/7/BrGk30eQpXp11q8LnBc0+5JkyljVLjQbFjto5aC8uPwUcnlC+8tbUuAKLm0pJlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809220; c=relaxed/simple;
	bh=7NTRWsc4g8WQ1bZdzaYVa2BDOzQlJv3cfHq8J8vsg7o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FCst1+MfL0YHD+0Ar+kUALa2njcLuVPCJ1UXQdm3Ci13d7a6ZBbpxDyGo6zD+Vav+n//KaR4zkst4E/7WPcHmY9n1dxvNlmXsf3aGCAZQ2FPTEkMPoB17P6+Wvl2OrA5+U8CO9PLh9R9+nFL/sjWYvv2F7zMpIX1wtbMMee10yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSusv8gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6CCC4CEF1;
	Thu, 30 Oct 2025 07:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761809220;
	bh=7NTRWsc4g8WQ1bZdzaYVa2BDOzQlJv3cfHq8J8vsg7o=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=qSusv8gJg1UvzOAjESBjuKqX7hi0mfLhjngbw2hAhioCwRtHZ8IijcssGisPuZXjp
	 TgsqK2H7ZuwV9tv5wstPlfLQ67XjklUvc84k60tm8l3CkCRvqcgHWzSeO9nK3i+yEW
	 JC9yBJnHpxHS6JKYQh2kUd1yEnRr8sj6gijLZmOmQYNQZXfgaBSyN8G31fugc0190s
	 y3q2kMaOqwgzb5lA2Fo74HKOvSzIFDlwylap23GBz/vcyaHOdLXOrnSTsaGi+UN+wQ
	 xOGBSDEuAqWJjfe6IrHOipCVsaKKFc29TppVgzQDM7wN9wyUQL7raX0Q8F54KG0Nl2
	 cslGuGC0y0Aig==
Message-ID: <4c114b45-e4b9-4a68-8391-bad00c8b3a25@kernel.org>
Date: Thu, 30 Oct 2025 08:26:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v1 3/6] media: dvb-frontends: atbm8830: Convert to use PI
 definition
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20251027143850.2070427-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 15:34, Andy Shevchenko wrote:
> Convert to use PI definition instead of open coded value of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Feel free to merge this through a non-media subsystem. If you want me to
take this as a separate media subsystem patch once units.h is patched,
then let me know.

Regards,

	Hans

> ---
>  drivers/media/dvb-frontends/atbm8830.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/atbm8830.c b/drivers/media/dvb-frontends/atbm8830.c
> index 778c865085bf..74032364d183 100644
> --- a/drivers/media/dvb-frontends/atbm8830.c
> +++ b/drivers/media/dvb-frontends/atbm8830.c
> @@ -6,7 +6,8 @@
>   *    Copyright (C) 2009 David T.L. Wong <davidtlwong@gmail.com>
>   */
>  
> -#include <asm/div64.h>
> +#include <linux/math64.h>
> +#include <linux/units.h>
>  #include <media/dvb_frontend.h>
>  
>  #include "atbm8830.h"
> @@ -112,7 +113,7 @@ static int set_if_freq(struct atbm_state *priv, u32 freq /*in kHz*/)
>  
>  	if (freq != 0) {
>  		/* 2 * PI * (freq - fs) / fs * (2 ^ 22) */
> -		t = (u64) 2 * 31416 * (freq - fs);
> +		t = 2 * DIV_ROUND_UP_ULL(PI, 100000) * (freq - fs);
>  		t <<= 22;
>  		do_div(t, fs);
>  		do_div(t, 1000);



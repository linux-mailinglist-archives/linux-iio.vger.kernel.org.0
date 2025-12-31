Return-Path: <linux-iio+bounces-27447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6FCEC71D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6D43014DA0
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A712F6915;
	Wed, 31 Dec 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSLxIgOq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732724DCF6;
	Wed, 31 Dec 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204589; cv=none; b=qYwrjzGJDgzkXqjBosNoSN35c2YUjLaekdg2/ctaLQL3dqbftTvL15ape86Ap6ZwqiSwZBrVLxxmypYgjyMy0U6M/RuwoVM3zDlGg5pp2h228sbDI9Q9UmoihK19n6ZEwW8B+4OX8IW4OP4UuUvW1Kta1RfZEgC7VNscjlYUuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204589; c=relaxed/simple;
	bh=yUoScwsReGaannKF2xlVDS5A8mqNManUuZq+niP1bPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgeDf9Nna8YdNc4zRh/ACLYtwGpS9p85NxZntVKrYszU/x1rpttYH74pAqnMioHmn0hV7dIRn0BOGMbnbY45b9ksUyI/ieYfDCtuzawj/LxzdRJlPQk2Dq74gxdoP74xNFCFY20QDllv2btfyUE+bfGXCicY4cr7pmsTjzcnGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSLxIgOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A6C113D0;
	Wed, 31 Dec 2025 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204588;
	bh=yUoScwsReGaannKF2xlVDS5A8mqNManUuZq+niP1bPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSLxIgOqx6lCsa+Rx/pegRXv7lz1LAGZnW7QMDSkmpZGb472N5AKuTpP0zFgKEa61
	 SAXXWhBr8ow9if44ruVnTYdDnJB5rkmP1ADAoaLJdSI3kRHMUWlaCvqzbv37TBjpH0
	 KrH9xX9M3TW0g0sCYgoX8Bhx0+Cbqpw6KJrBbM6YOSGoenDAKw6qtCZE4f7pzQtesr
	 9jccoRNhUK+fwmK27pZQ9LixXzZyrpGaza838VOmSBQe9MxOypzF0DOiwe4VxZW2PR
	 657m7cP8hbdOcrz3ybrR7Tdn0MUx3GiiiIq0ut0O1gNXTI4x7eBJFdqKJEMX2lRQva
	 2AvvNd0tAOFTw==
Date: Wed, 31 Dec 2025 18:09:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <20251231180939.422e9e62@jic23-huawei>
In-Reply-To: <20251230203459.28935-5-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-5-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 17:34:57 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Remove dependency on dds.h by converting custom macros to standard IIO
> attribute declarations.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
Hi Tomas,

Happy new year (almost)

> ---
>  drivers/staging/iio/frequency/ad9832.c | 37 +++++++++++---------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 4bb203a67046..aa78973c3a3c 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -24,8 +24,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include "dds.h"
> -
>  /* Registers */
>  #define AD9832_FREQ0LL		0x0
>  #define AD9832_FREQ0HL		0x1
> @@ -238,27 +236,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	}
>  }
>  
> -/*
> - * see dds.h for further information
> - */
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> +
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequencysymbol, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> +static IIO_CONST_ATTR(out_altvoltage0_frequency_scale, "1"); /* 1Hz */

This seems like a pointless attribute.  Default scaling for everything in IIO when
attributes don't tell us otherwise is 1 so should be fine dropping this one.

> +
> +static IIO_DEVICE_ATTR(out_altvoltage0_phase0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> +static IIO_DEVICE_ATTR(out_altvoltage0_phase1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> +static IIO_DEVICE_ATTR(out_altvoltage0_phase2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> +static IIO_DEVICE_ATTR(out_altvoltage0_phase3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> +
> +static IIO_DEVICE_ATTR(out_altvoltage0_phasesymbol, 0200, NULL, ad9832_write, AD9832_PHASE_SYM);
> +static IIO_CONST_ATTR(out_altvoltage0_phase_scale, "0.0015339808"); /* 2PI/2^12 rad */

I can't immediately think of precedence for scaling of an attribute other than
_raw.  Whilst it's painful, this isn't a high perf path, so we should probably
just do fixed point inputs for phase0,phase1 etc and deal with the scaling
in the driver.  That avoids adding new ABI for this very rare case.

>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> -static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
> -
> -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> -static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> -static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> -static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
> -				ad9832_write, AD9832_PHASE_SYM);
> -static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
> -
> -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> -				ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> -				ad9832_write, AD9832_OUTPUT_EN);
> +static IIO_DEVICE_ATTR(out_altvoltage0_pincontrol_en, 0200, NULL, ad9832_write, AD9832_PINCTRL_EN);

I'm not that keen on having the documentation only several patches later. Drag that
before this patch or combine adding the new ABI and documentation in the same patch

Jonathan


> +static IIO_DEVICE_ATTR(out_altvoltage0_out_enable, 0200, NULL, ad9832_write, AD9832_OUTPUT_EN);
>  
>  static struct attribute *ad9832_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,



Return-Path: <linux-iio+bounces-17350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C874A75AB5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131F918854F3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75CD1D6DBF;
	Sun, 30 Mar 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKxyF+ty"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134301CCEE0;
	Sun, 30 Mar 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743349431; cv=none; b=jZNbxQT9YxvNPDwZ8XSQ2HII6jzeW5bTNqaoBtzQgv3vyHt6G9/z5P0Ts7q+1CwSE7gLbH09st1p14mKKbT0NVfWDzpB6yU2Rql6ceCAwi3foee7FYU/6GeDTG+qfJ8gx0ej7RmbSnryP0rm2y/1YFgAvJtejrFV73VoOigkS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743349431; c=relaxed/simple;
	bh=DY/QoIgUcxlYWKWErAMultP4tK424psP9SLBssFPk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n81+D6VN9MG02S2gtpsYYNLM6jG4xajvCHml0DTZbzrSovZibewiRzPZFTi1GmILI31+YiqbxPjnqE4RIn/ULYhafQKgJd4YoAg0kQYeePTNAI8jIrPxx3aa3W8E2+Ue4jbh8iaqfzRTdiZiI3KNiG+U4kNuxNuyR5dnjVLxj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKxyF+ty; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3035858c687so5032996a91.2;
        Sun, 30 Mar 2025 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743349429; x=1743954229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYhteagEyzg+N5CaIO1iHsEXBTHsWVMkEKuAyOQorjA=;
        b=KKxyF+ty8voDiCAIANhraEC1/8WqY9g2wqSpsG4SJfBmW4/NzPbeEykaHF0fLJ5lTs
         QCow8IiLVlbYVm6D/WancDXuXsSbq1rPOt2ggRXZnJBpvN9AuB3OvW2iLFcBWBVOSkMp
         2JD6WwnTmxireofohz+Akh92OHcju73hbQ3aKjZZ7W1q6Hna6N7xUWcVjHIXjrIs/Twy
         aCpv9GORzqFdtQURwtQ/D/8keX9I+tEF4iBvN2xHTTMiFRYFXqu15UO8XQQv82JmPGIA
         aWaM1Ek1V+jalf2GmAJMkbKLbienJuha716h5kFiLMoGxyj0wHoLPsriVyvqO2fyOLtx
         6rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743349429; x=1743954229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYhteagEyzg+N5CaIO1iHsEXBTHsWVMkEKuAyOQorjA=;
        b=b71FEOmFyy3eSclrXQykWKppqs7psWrtFhYcUxwCEvkJE9epKFjF6iB9kf+mXuD4Sn
         0UZ0JgwBl0QhsCuDb3qDMT7eUw0IazinsU8IocmNPZZWzkomUWYC4simYFwE1bJ9WGwk
         k1D7zKsuydT398+lV3TnMowrhC8cZOc1S6W6DAQa1lUVQViDfE1gtGMyteNfN++LZd9m
         +Zvy9Aai8G5/s3B3YihGDOjnESQnp2rnfm0T1LDnuOspDojIaizNBVAf6VGEBaZR+A81
         CGPF7h+/swAEJVcKS1OYpJ5LrtfiyP0UemqjgXvpUXlwmJ5hlSxupR42hbCnDgY0K8Ky
         ef8g==
X-Forwarded-Encrypted: i=1; AJvYcCWTl4GGHnBZ30Srl17Niif4b7n2H8Iu1u00MDFXWZ9lkDArP0PhAi2//+kxQ5P9l5EcXgykO7BFnSSBsUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBQC/WUtawmi8ofXILVH9SlyqDHv4I4Cwriangruz6u5PwEfC
	3d0agHpbIjyJmYFqt/9mrcViMGtaBvqb+ZKl8hT+dSEAf2yfoZe2yeg83v6k
X-Gm-Gg: ASbGncsBdDMHb9j3SwiyOFRHb6c2ZryI6Q0Xe5FJ9cM5C99jnX85rcgtrJg0maSJzZe
	vLRpAk+qZWzIsC+Gcp6zKt1nvDKpDhmNrYYRLOfUPmVd7Ad1hNNCfkBJCFFrRm0jBszE1zkfyGl
	oe5tkrBXefkCiokuCYyp6Wa/Lx+UfyS6PC44Tc/MRlyuYgWo0lqc8Zb29rmla88ba8Nqub2RAEj
	6Qq5A6KixSDyvYI5fY3aK0a25u4vVER+MkxfEmXIO4RUIqA+ahPLBJ0iiM2LlOH73p3jIMbUbuT
	ipuqwgrzDurYvdjlvh3++YQE8tkOmkZgh3uSrPRUBZCRKTRyoNshXL1TI6s93fXC
X-Google-Smtp-Source: AGHT+IFQ1NR4OoxulZ7bvgn4OOzRV3N3uO6d2kuqzhU72/7pKS2qxDZ/gPmXAxdv5zgchB26Xkyk0A==
X-Received: by 2002:a17:90b:2e88:b0:2fa:228d:5b03 with SMTP id 98e67ed59e1d1-305320afbbfmr9008735a91.19.1743349428908;
        Sun, 30 Mar 2025 08:43:48 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d62964sm5567734a91.26.2025.03.30.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 08:43:47 -0700 (PDT)
Date: Sun, 30 Mar 2025 12:44:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
	jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z-lm8l1ILFuJE5YS@debian-BULLSEYE-live-builder-AMD64>
References: <20250330135402.105418-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330135402.105418-1-simeddon@gmail.com>

Hi Siddharth,

Some suggestions in addition to what Jonathan has provided in his review.

On 03/30, Siddharth Menon wrote:
> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  v1->v2:
>  - remove CMD_SHIFT and ADD_SHIFT
>  - use GENMASK
>  - store regval in an array and iterate through it
>  v2->v3:
>  - add missing header
>  - refactor code in the previously introduced loops
>  v3->v4:
>  - update commit message with a better one
>  - convert AD9832_PHASE and RES_MASK to masks
>  - cleanup a few if else blocks
>  v4->v5
>  - remove unnecessary inversion (val ? 0 : 1) used
>    with AD9832_PHASE_MASK introduced in v4
>  - use ARRAY_SIZE instead of fixed integers
>  - use reverse xmas tree order
>  - align mask macros
>  drivers/staging/iio/frequency/ad9832.c | 85 +++++++++++++-------------
>  1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..e74d085fb4f2 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -16,6 +16,9 @@
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/unaligned.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -59,17 +62,18 @@
>  #define AD9832_CMD_SLEEPRESCLR	0xC
>  
>  #define AD9832_FREQ		BIT(11)
> -#define AD9832_PHASE(x)		(((x) & 3) << 9)
> +#define AD9832_PHASE_MASK	GENMASK(10, 9)
>  #define AD9832_SYNC		BIT(13)
>  #define AD9832_SELSRC		BIT(12)
>  #define AD9832_SLEEP		BIT(13)
>  #define AD9832_RESET		BIT(12)
>  #define AD9832_CLR		BIT(11)
> -#define CMD_SHIFT		12
> -#define ADD_SHIFT		8
>  #define AD9832_FREQ_BITS	32
>  #define AD9832_PHASE_BITS	12
> -#define RES_MASK(bits)		((1 << (bits)) - 1)
> +#define RES_MASK(bits)		GENMASK((bits) - 1, 0)
I also don't see RES_MASK being used by ad9832 so just drop it.

> +#define AD9832_CMD_MSK		GENMASK(15, 12)
> +#define AD9832_ADD_MSK		GENMASK(11, 8)
> +#define AD9832_DAT_MSK		GENMASK(7, 0)
>  
...
>  	case AD9832_FREQ_SYM:
> -		if (val == 1) {
> -			st->ctrl_fp |= AD9832_FREQ;
> -		} else if (val == 0) {
> +		if (val == 1 || val == 0) {
>  			st->ctrl_fp &= ~AD9832_FREQ;
> +			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 0 : 1);
The previous implementation would set ctrl_fp if val == 1 and unset it if val == 0.
This patch seems to be doing the reverse (setting ctrl_fp if val == 0, and
unsetting it if val != 0). Was the previous implementation potentially buggy?
If not, I think we can just do

		st->ctrl_fp &= ~AD9832_FREQ;
		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, !!val);

>  		} else {
>  			ret = -EINVAL;
>  			break;
>  		}
and drop the error path. Slight change in interface but guess no problem with that.

> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> @@ -224,21 +230,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			break;
>  		}
>  
> -		st->ctrl_fp &= ~AD9832_PHASE(3);
> -		st->ctrl_fp |= AD9832_PHASE(val);
> +		st->ctrl_fp &= ~FIELD_PREP(AD9832_PHASE_MASK, 3);
> +		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);

This seems to be a typical modify use case as exemplified in
include/linux/bitfield.h. So,

		st->ctrl_fp &= ~AD9832_PHASE_MASK;
		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);

>  
> -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  					st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
>  	case AD9832_OUTPUT_EN:
> -		if (val)
> -			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
> -					AD9832_CLR);
> -		else
> -			st->ctrl_src |= AD9832_RESET;
> +		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
> +		st->ctrl_src |= FIELD_PREP(AD9832_RESET, val ? 0 : 1);
Hmm, this is modifying behavior. AD9832_SLEEP and AD9832_CLR were only being
modified if something other than 0 was written to output enable sysfs file.
Is the patch code mode appropriate than how the driver was before?

>  
> -		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  					st->ctrl_src);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;

Regards,
Marcelo


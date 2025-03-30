Return-Path: <linux-iio+bounces-17343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B69A75A8E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DE63AA049
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2641C174A;
	Sun, 30 Mar 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPcBRrp/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866889461;
	Sun, 30 Mar 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743347848; cv=none; b=obXWfpa4O7w9sOSf/donJRzwcucmI/Z3kxWAlR0pj0IvPNh3yJ7EiYru8lPkvHYsOH8ea/dy4UdCP6E8OavNtr87aUDiINRHS/V+WuH7TY3Zd6S5/heRAMYlFuEkefWs3U8KXt4wTly/6ew7lRHdM3ysoeKeeWhm4A9eG4kz2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743347848; c=relaxed/simple;
	bh=GqrXJA/GoOV/tLNKKAKW/ZwC2zKYzb6MfKixWEusiKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQwIDZLPZ6lux8egggyUf9tXRTf3IQrrf4Iy7qk4voumzc8SQnBTSrJovFnUPyN6BIwQXWx/g/7wJxP7KAOZEMq9wTT8sssHMBQeRItCZ6jBXgr6+f2Pa2gD2ax9RUYWS4xdBkxICwtE9dkoJ0B1ygQId1VXmkKddT003UmaQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPcBRrp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2559CC4CEDD;
	Sun, 30 Mar 2025 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743347847;
	bh=GqrXJA/GoOV/tLNKKAKW/ZwC2zKYzb6MfKixWEusiKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPcBRrp/mMiYpUHA0XgSTG9RAZmwxGMNCP9E+JSQbK1jsrbiEzWz4kvgD58/wTb9x
	 ZqhaHX0c+3tAV6+wxhS+yqL9SDevZ6N1cwjAHfagPaLIfOkjGw0s73FuYtwlwrSwxd
	 tRlh6yrSge5xB4lmj/jwhAIa5a6idsWILKvjdn2+6mXreiKWOtX6zXYMMGmQvf/M7x
	 87YEd1G56jJUMfMGnivGFT8nS815ITlwEKrJBVRP6QZRY9dHxB7KTf3+Jn+A/l8hKG
	 IgTLbaVmkLGGYRY5bp/CYF452wSRRjZjvJ/obx28M/LkqGW6EMfAYyVqcoAvq67nCl
	 DEdqRIXJqxVXA==
Date: Sun, 30 Mar 2025 16:17:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org, Sam Winchenbach
 <swinchenbach@arka.org>
Subject: Re: [PATCH v8 5/6] iio: core: Add support for writing 64 bit attrs
Message-ID: <20250330161721.7d718fd0@jic23-huawei>
In-Reply-To: <20250328174831.227202-6-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
	<20250328174831.227202-6-sam.winchenbach@framepointer.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 13:48:30 -0400
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> From: Sam Winchenbach <swinchenbach@arka.org>
> 
> Prior to this patch it was only possible to read 64 bit integers.
> 
> Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> ---
>  drivers/iio/industrialio-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a2117ad1337d5..b2436b8f3eeae 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -965,8 +965,10 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret, fract_mult = 100000;
>  	int integer, fract = 0;
> +	long long integer64;
>  	bool is_char = false;
>  	bool scale_db = false;
> +	bool is_64bit = false;
>  
>  	/* Assumes decimal - precision based on number of digits */
>  	if (!indio_dev->info->write_raw)
> @@ -990,6 +992,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_CHAR:
>  			is_char = true;
>  			break;
> +		case IIO_VAL_INT_64:
> +			is_64bit = true;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1000,6 +1005,13 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		if (sscanf(buf, "%c", &ch) != 1)
>  			return -EINVAL;
>  		integer = ch;
> +	} else if (is_64bit) {
> +		ret = kstrtoll(buf, 0, &integer64);
> +		if (ret)
> +			return ret;
> +
> +		fract = (int)(integer64 >> 32);
> +		integer = (int)(integer64 & 0xFFFFFFFF);
I forgot on previous reviews but for this case we have wordpart.h

		fract = lower_32_bits(integer64);
		integer = upper_32_bits(integer64);

I'll tweak that whilst applying.

>  	} else {
>  		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
>  					    scale_db);



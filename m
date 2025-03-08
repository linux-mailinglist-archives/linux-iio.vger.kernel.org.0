Return-Path: <linux-iio+bounces-16552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC59A57AD3
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48F83B13BE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E71E868;
	Sat,  8 Mar 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ8FjAxW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801427482;
	Sat,  8 Mar 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741442440; cv=none; b=WVWqrWf82G9Du76e929pU4VjBM5nx9UCYn3aQ7cSh/6WTI+qmEF1B3NtqLsv+G6yTLKBZssi1RimUfOiLbVX0//cRFcfGB7YrSFfDBq4GQUJnCjxvLBuq1iQiF3TxM06Q2RsC6xq5w908rBesEgz3QJiCczbki0MTiVuEk+DFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741442440; c=relaxed/simple;
	bh=MGeajvNNLtB2jzMTtchiV2decBaroz6crJroxo8ieV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRjrkmCdkgjFcYHboVnopyyg/SNWJ+Cvnp0A/lrn4G/Xi+7C0yIMV8JDDu839csKBIQDgWpkqXLKxPuxQD4m/8YxOW744WY+8J1BJ4cC1DnWH1Vt93hrQGseQV21/FJD5Ab0a4FiSI2s9rZ7LIiRX2mphlf+yEWeK9qBJoDQOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ8FjAxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF62C4CEE0;
	Sat,  8 Mar 2025 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741442440;
	bh=MGeajvNNLtB2jzMTtchiV2decBaroz6crJroxo8ieV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQ8FjAxWww9zQ+0fkRs8i/FH5BVu2KwiTXZXD0OwyBujp9f5CDpjCKfBxKH3QYN8P
	 lW+yAqlFVM/9EpuHDcYNSf3JfR861e3Wu9T+/8HkQQA9xlsUXvUg+KQWZ1R3wrtx0E
	 zKNpsgVcWKfKzr6f28AlEwD9WYl0GU2iifgg98DWGHB0JPF99UzPK5hAfRwuGVvZWv
	 txm8jw2NR2WSZGYuU/7safg5PgN7Qwsd0MmDbjQqCkJNX3/Vy+dXf6O3g6tZHBUH6k
	 Hc3sXrk110UCy0Q0TUodBTxRvdOygPBx2nnWkpw5dIG1u+q5zQzEpuBLNsZMWrgMco
	 pOkmeOfG9FO1g==
Date: Sat, 8 Mar 2025 14:00:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v6 5/6] driver core: Add support for writing 64 bit
 attrs
Message-ID: <20250308140030.3fbc767b@jic23-huawei>
In-Reply-To: <20250307150216.374643-5-sam.winchenbach@framepointer.org>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
	<20250307150216.374643-5-sam.winchenbach@framepointer.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 10:02:15 -0500
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

Patch title should be iio: core: 

driver core is stuff in drivers/base/

> Prior to this patch it was only possible to read 64 bit integers.
> 
> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> ---
>  drivers/iio/industrialio-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a2117ad1337d..b2436b8f3eea 100644
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
>  	} else {
>  		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
>  					    scale_db);



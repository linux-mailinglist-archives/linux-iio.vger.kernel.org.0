Return-Path: <linux-iio+bounces-16841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2CA61746
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C82D7AE167
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202E202F8B;
	Fri, 14 Mar 2025 17:16:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0311FF7CA;
	Fri, 14 Mar 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972600; cv=none; b=kgHNc2mKstDAIXcKuUTNOuPoQqgrEdBQRbIBXMBwFFpm/mAhkBsQF8QppCH1oC8tKu4/qSjFqwxOVWONDAf1jMI7Zoh2JGrGeEaNO7eLfru9zw8ZCEbJQELHOHgeYfR08ckKnPFSxXLjIS5H059Wz4KX5gZQE/Y6nY6aUy/Lndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972600; c=relaxed/simple;
	bh=0Nz3fw421OR1HpIMBgabaR/cBVwKujxG5ayl5xh+MNg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSO5KDt8yTtCfK4Lmpoqu6cqGd2lKmG84BQO2Wv/F8IRgPWEzNu9GwJDrcCWcw5KRCqU7HPlyEr4iN+sdX9OnvTgEIvssVTrIc0OCRrcOtv1GqRMWjfOh4i4oiqpvzDB07jwLWoF6xajyMpFjFI8CHxXJU6S/c3rO6nPPdibKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDrYt0d2Bz6JB7h;
	Sat, 15 Mar 2025 01:13:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C916140B55;
	Sat, 15 Mar 2025 01:16:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 18:16:34 +0100
Date: Fri, 14 Mar 2025 17:16:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Siddharth Menon <simeddon@gmail.com>
CC: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, "Marcelo Schmitt"
	<marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH] iio: frequency: ad9832: Use FIELD_PREP macro to set bit
 fields
Message-ID: <20250314171633.0000654e@huawei.com>
In-Reply-To: <20250313195442.30264-1-simeddon@gmail.com>
References: <20250313195442.30264-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Mar 2025 01:24:17 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> Refactor code to use the FIELD_PREP macro for setting bit fields
> instead of manual bit manipulation.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 39 ++++++++++++++------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..bbde1f0e84ff 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -70,6 +70,9 @@
>  #define AD9832_FREQ_BITS	32
>  #define AD9832_PHASE_BITS	12
>  #define RES_MASK(bits)		((1 << (bits)) - 1)
> +#define DATA_MASK       0xFF
> +#define CMD_MASK        (0xF << CMD_SHIFT)
> +#define ADD_MASK        (0xF << ADD_SHIFT)
Don't mix and match.  If we can't get rid of CMD_SHIFT then
this is not worth ti.

Ideally should end up with
#define AD9832_CMD_MSK 0xF000
#define AD9832_ADD_MSK 0x0F00


>  
>  /**
>   * struct ad9832_state - driver instance specific data
> @@ -139,18 +142,18 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  
>  	regval = ad9832_calc_freqreg(clk_freq, fout);
>  
> -	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((regval >> 24) & 0xFF));
> -	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					((regval >> 16) & 0xFF));
> -	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					((addr - 2) << ADD_SHIFT) |
> -					((regval >> 8) & 0xFF));
> -	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 3) << ADD_SHIFT) |
> -					((regval >> 0) & 0xFF));
> +	st->freq_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
> +					FIELD_PREP(ADD_MASK, addr) |
> +					FIELD_PREP(DATA_MASK, (regval >> 24) & 0xFF));
> +	st->freq_data[1] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 1)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 16) & 0xFF));
> +	st->freq_data[2] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 2)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 8) & 0xFF));
> +	st->freq_data[3] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 3)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 0) & 0xFF));

These are doing a byte wise write. Instead of this regval shifting madness look
at converting to array with appropriate unaligned_put_be32
then a loop to do this.


>  
>  	return spi_sync(st->spi, &st->freq_msg);
>  }
> @@ -161,12 +164,12 @@ static int ad9832_write_phase(struct ad9832_state *st,
>  	if (phase >= BIT(AD9832_PHASE_BITS))
>  		return -EINVAL;
>  
> -	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((phase >> 8) & 0xFF));
> -	st->phase_data[1] = cpu_to_be16((AD9832_CMD_PHA16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					(phase & 0xFF));
> +	st->phase_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_PHA8BITSW) |
> +					FIELD_PREP(ADD_MASK, addr) |
> +					FIELD_PREP(DATA_MASK, (phase >> 8) & 0xFF));
> +	st->phase_data[1] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_PHA16BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 1)) |
> +					FIELD_PREP(DATA_MASK, phase & 0xFF));
>  
>  	return spi_sync(st->spi, &st->phase_msg);
>  }



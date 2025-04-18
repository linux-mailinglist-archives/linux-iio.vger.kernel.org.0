Return-Path: <linux-iio+bounces-18264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F79A939EF
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A381B66DFD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B902144A0;
	Fri, 18 Apr 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVMCpFmF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6C2139D8;
	Fri, 18 Apr 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990669; cv=none; b=dXKCaI5hj7FYeKLS180U+nEUm2rdxXbL3KRG48VVe7HjGizxTaERz+qmteQQitdxAahldDKnP6tEGJl4qGQ+fwaAbX97JV1ensijsuJ2/Uzf5f/5vmGmICUdAoLX5Qtj4gh3csMJE1dU6DTs+GXov2Z8GnJfVpdnneDpsMpl0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990669; c=relaxed/simple;
	bh=ePj9XBwxI8VhpbU1F8JnRfKVKSF8Vwg5qYMWDW9j5Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw+RoG9eRYeinUzUg+nTnBCRmyIFw9jP7egyMQcakXKBIx7QDpBElqiBcTQ03+0hgXsshScgFNUqMmOMy2ICYNNAO6fLL9tZzWJfklEPxXWVLKheOX2VhV9mXvyJE1xCgcyaZX5Eff9jJIkJBkaBk5gS59drnp/ILklrvxjRQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVMCpFmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777BEC4CEEA;
	Fri, 18 Apr 2025 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990668;
	bh=ePj9XBwxI8VhpbU1F8JnRfKVKSF8Vwg5qYMWDW9j5Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FVMCpFmFMik0JEZHNat+EuYp7TRjpOOTj/QGc/Rb1gug+Bpr18pAyMZtPYuuor5Ty
	 rOTmP3u1zBJbPiz4XT5/Msn/5wNIcwn6LVJIlgaXSYo7bpXFWg9Nc04IhpUpxBtqmq
	 s/Kp5+sF4aro9LhIwMrHA+6sIbLvZSn9qp5aZhX/H1BYvfgmA7k0AZ7x4mKEv0nYF2
	 yD1E1tTkcIP8KkOE8VudODicBK61vW84Tfmi9ta0V7VJvshMHfhWDPdxj/NOMC56f9
	 qwrLoZVHKO4beHJhLcH/dngcCs2S+QowoTutOborJqgjLBdFZMPSm+rAE9JBpdWyBT
	 9PFej9Kj6z6Sg==
Date: Fri, 18 Apr 2025 16:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: ad5933: Correct settling cycles encoding per
 datasheet
Message-ID: <20250418163743.4f9379a1@jic23-huawei>
In-Reply-To: <20250416142219.554938-1-gshahrouzi@gmail.com>
References: <20250416142219.554938-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 10:22:19 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Implement the settling cycles encoding as specified in the AD5933
> datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
> previous logic did not correctly translate the user-requested effective
> cycle count into the required 9-bit base + 2-bit multiplier format
> (D10..D0) for values exceeding 511.
> 
> Clamp the user input for out_altvoltage0_settling_cycles to the
> maximum effective value of 2044 cycles (511 * 4x multiplier).
> 
> Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d5544fc2fe989..5a8c5039bb159 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -28,7 +28,7 @@
>  #define AD5933_REG_FREQ_START		0x82	/* R/W, 3 bytes */
>  #define AD5933_REG_FREQ_INC		0x85	/* R/W, 3 bytes */
>  #define AD5933_REG_INC_NUM		0x88	/* R/W, 2 bytes, 9 bit */
> -#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes */
> +#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes, 11+2 bit */

Probably spaces around the +  It's not code, but lets keep to consistent code style.

>  #define AD5933_REG_STATUS		0x8F	/* R, 1 byte */
>  #define AD5933_REG_TEMP_DATA		0x92	/* R, 2 bytes*/
>  #define AD5933_REG_REAL_DATA		0x94	/* R, 2 bytes*/
> @@ -71,6 +71,8 @@
>  #define AD5933_INT_OSC_FREQ_Hz		16776000
>  #define AD5933_MAX_OUTPUT_FREQ_Hz	100000
>  #define AD5933_MAX_RETRIES		100
> +#define AD5933_MAX_FREQ_POINTS		511
> +#define AD5933_MAX_SETTLING_CYCLES	2044 /* 511 * 4 */

>  
>  #define AD5933_OUT_RANGE		1
>  #define AD5933_OUT_RANGE_AVAIL		2
> @@ -82,6 +84,10 @@
>  #define AD5933_POLL_TIME_ms		10
>  #define AD5933_INIT_EXCITATION_TIME_ms	100
>  
> +/* Settling cycles multiplier bits D10, D9 */
> +#define AD5933_SETTLE_MUL_2X		BIT(9)
> +#define AD5933_SETTLE_MUL_4X		(BIT(9) | BIT(10))

That looks like  a number, not a pair of separate bits. 
I would expect a mask for this field then some defines for teh
values it can take.

> +
>  struct ad5933_state {
>  	struct i2c_client		*client;
>  	struct clk			*mclk;
> @@ -411,14 +417,15 @@ static ssize_t ad5933_store(struct device *dev,
>  		ret = ad5933_cmd(st, 0);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		val = clamp(val, (u16)0, (u16)0x7FF);
> +		val = clamp(val, (u16)0, (u16)AD5933_MAX_SETTLING_CYCLES);
>  		st->settling_cycles = val;
>  
> -		/* 2x, 4x handling, see datasheet */
> +		/* Encode value for register: D10..D0 */
> +		/* Datasheet Table 13: If cycles > 1022 -> val/4, set bits D10=1, D9=1 */
>  		if (val > 1022)
> -			val = (val >> 2) | (3 << 9);
> -		else if (val > 511)
> -			val = (val >> 1) | BIT(9);
> +			val = (val >> 2) | AD5933_SETTLE_MUL_4X;
> +		else if (val > 511) /* Datasheet: If cycles > 511 -> val/2, set bit D9=1 */
> +			val = (val >> 1) | AD5933_SETTLE_MUL_2X;
>  
>  		dat = cpu_to_be16(val);
>  		ret = ad5933_i2c_write(st->client,
> @@ -426,7 +433,7 @@ static ssize_t ad5933_store(struct device *dev,
>  				       2, (u8 *)&dat);
>  		break;
>  	case AD5933_FREQ_POINTS:
> -		val = clamp(val, (u16)0, (u16)511);
> +		val = clamp(val, (u16)0, (u16)AD5933_MAX_FREQ_POINTS);
>  		st->freq_points = val;
>  
>  		dat = cpu_to_be16(val);



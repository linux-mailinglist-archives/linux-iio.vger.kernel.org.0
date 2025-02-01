Return-Path: <linux-iio+bounces-14801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30107A2487E
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C51164EA4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD785947;
	Sat,  1 Feb 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+gFj+0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035A76025;
	Sat,  1 Feb 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408701; cv=none; b=Q3i1LymyKAIPBhIGbjfRju0vHC3GSip9RIXcQCHN4Y+2qmrlSmy/rJ6Y7n27NicchJAVfjfcKpvRC/6GKi3FCytMgrl2yZyYgk8eEkZEkJnOy+rfEYSsENm+Kq0BoDxybvXCJjM+gRkDY9hEZmofu1+Lf/9gM9X4Fh/ea31og4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408701; c=relaxed/simple;
	bh=ZaroXdXtz1raiJgxpMVyXxuW1Om0COFMaHRq6VN/CP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mskoOBPTFTtyKULCKa8V53T1OcnjbB+cVz+rOPGutwZf09eRC8EkGur3ENtrgq9SxXeDMu1pppicZTZxCuY7rc38wifY6I7hmTPArNj1kMBtxlrT5BFodYGOTHgNbbAlEl3wKNxBrRPk61VZJjtcHCcpdVmTEYUZY0Mjg1mW/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+gFj+0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D5C4CED3;
	Sat,  1 Feb 2025 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738408701;
	bh=ZaroXdXtz1raiJgxpMVyXxuW1Om0COFMaHRq6VN/CP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+gFj+0C0VkZ1h/xsarulecAg5XLysCUvkjhOd046CTvCc/b5oZqenOxnTS4Ijlqu
	 gy+Pj9nO/qBS/0E4BFe2BF6ef8J8y/q5d0vvhg8ho5GwP5OQ29gaFBPFO6EPycIW6m
	 F7K9nRHzIXdWbtV600SzQSH98DmJHh4gDY2Fn7WjjpXCThAMtunjwZy7RjzRD4jEJL
	 n07Ho9OFKUnh8gUAukUG2Ta75tVX931z+wSdIEXwzBV6la50rmo76awKH+sYEXJacg
	 z5VasSj9QlyITeyFFVLxWkPntNH1hAAsRTNj80knPPOFZyD7Ol5146nD0Zd5wZ2gfD
	 sa/mg5CWP85qg==
Date: Sat, 1 Feb 2025 11:18:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <swinchenbach@arka.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Message-ID: <20250201111813.6b8cbf5b@jic23-huawei>
In-Reply-To: <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References: <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jan 2025 14:54:44 +0000
Sam Winchenbach <swinchenbach@arka.org> wrote:

> When a weak pull-up is present on the SDO line, regmap_update_bits fails
> to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
> reads them as already set.

I can see this as a valid micro optimization but I'm struggling a bit
on how you can use the device if the pull up is weak enough that
you can't read data back from it. Does the reset in some way
solve that?

Having asked for the fixes tag, I'm less sure on whether this is a fix.

Antoniu, I'd also like your input on this one!

> 
> Since the soft reset disables the SDO line, performing a
> read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
> doesn't make sense. This change directly writes to the register instead
> of using regmap_update_bits.
> 
> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> 

No blank line here.  Fixes is part of the tags block that various scripts
scan.

> Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> ---
>  drivers/iio/filter/admv8818.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index 195e58bc4..9cd1eee84 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state *st)
>  	struct spi_device *spi = st->spi;
>  	unsigned int chip_id;
>  
> -	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> -				 ADMV8818_SOFTRESET_N_MSK |
> -				 ADMV8818_SOFTRESET_MSK,
> -				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
> -				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
> +	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
>  	if (ret) {
>  		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
>  		return ret;
>  	}
>  
> -	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> -				 ADMV8818_SDOACTIVE_N_MSK |
> -				 ADMV8818_SDOACTIVE_MSK,
> -				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
> -				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
> +	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
>  	if (ret) {
>  		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
>  		return ret;



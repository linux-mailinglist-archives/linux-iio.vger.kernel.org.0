Return-Path: <linux-iio+bounces-22827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6BB28E3B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B5E3A803A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39E2E7F1F;
	Sat, 16 Aug 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8JVqC1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AC2D1303
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351839; cv=none; b=j2Ye5un3Am+g5M/XqjSJo+nGqxT+HymcfhIn1DEPvHDWc+EDvwNSNb5+tuNebEki17JgJOJmBGEtufqPf+uYyNQH++27B7u/VYw/OtoiudHKr0EwkwnyVLLRHKXZJC0X1UXvCw66n1U1uNmHiLPtrMt4vAv+HVQQxLJpS635QQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351839; c=relaxed/simple;
	bh=a31K5zqEVACpgPYT3tuJh8Ph/iBybpGtyyeVAa1zL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH65qGvYlcGbfitTLlsuX2KafbphJ2xA/hHg+PIWw7MKT/NaaT5IWsq/IyDdJsfQBKDHxpRsZR1P5SDTagR7ofOPSw26ELxqsBIBnIeSnHh4JbSKcbvVDzKwlgOTgbh/ehCYmOmaVsODTu7cYic0ow74YwRMBsmo+zirEffeO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8JVqC1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C78AC4CEEF;
	Sat, 16 Aug 2025 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755351839;
	bh=a31K5zqEVACpgPYT3tuJh8Ph/iBybpGtyyeVAa1zL6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8JVqC1xaqE9WwRVWW4IFqyVwCoCfBFrtRatmovHhdIDwLPxPQmdI9/M+dDkVJiVQ
	 EkvZt02uaUGsdZpMikemNKrUbfVSCGqdneRC776yFmrmYsrk2RIJCE7CKwanNnn4CQ
	 6Cz+8kiNPjmXSfdmUpc1zQQteKDgj3Vl22CZDne2ZLLKMXNNy0lknMJMiE0PuZasgZ
	 QAZYblTrUMuP47H/pHN1QgnvQqd3wJYwe1lUhv1YriZxLMVX5AZjWPKEnmc6L+bkSr
	 e9Kacw5Z8Mxjj8ukye7dDDRrvOIJHVyNr9f+wQKhZMvW3T5RiRHqI3MnGLljnaR/rL
	 4WjounrPD6HGA==
Date: Sat, 16 Aug 2025 14:43:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Cc: linux-iio@vger.kernel.org, marius.cristea@microchip.com,
 rene.straub@belden.com
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
Message-ID: <20250816144352.53e61562@jic23-huawei>
In-Reply-To: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 13:09:04 +0000
Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com> wrote:

> There are two problems with the chip configuration in this driver:
> - First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
>   lead to a config overflow due to HW auto increment implementation
>   in the chip.
> - Second, the i2c_smbus_write_block_data write ends up in writing
>   unexpected value to the channel_dis register, this is because
>   the smbus size that is 0x03 in this case gets written to the
>   register. The PAC1931/2/3/4 data sheet does not really specify
>   that block write is indeed supported.
> 
> This problem is probably not visible on PAC1934 version where all
> channels are used as the chip is properly configured by luck,
> but in our case whenusing PAC1931 this leads to nonfunctional device.
> 
> Signed-off-by: Rene Straub <rene.straub@belden.com>
> Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>

Hi, Thanks for the patch.

Needs a fixes tag so we know how far to back port it.
You can just reply with one to this thread rather than sending a new
version.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 09fe88eb3fb0..2e442e46f679 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -88,6 +88,7 @@
>  #define PAC1934_VPOWER_3_ADDR			0x19
>  #define PAC1934_VPOWER_4_ADDR			0x1A
>  #define PAC1934_REFRESH_V_REG_ADDR		0x1F
> +#define PAC1934_SLOW_REG_ADDR			0x20
>  #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
>  #define PAC1934_PID_REG_ADDR			0xFD
>  #define PAC1934_MID_REG_ADDR			0xFE
> @@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934_chip_info *info)
>  	/* no SLOW triggered REFRESH, clear POR */
>  	regs[PAC1934_SLOW_REG_OFF] = 0;
>  
> -	ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> -					  ARRAY_SIZE(regs), (u8 *)regs);
> +	/*
> +	 * Write the three bytes sequentially, as the device does not support
> +	 * block write.
> +	 */
> +	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> +					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client,
> +					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
> +					regs[PAC1934_NEG_PWR_REG_OFF]);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
> +					regs[PAC1934_SLOW_REG_OFF]);
>  	if (ret)
>  		return ret;
>  



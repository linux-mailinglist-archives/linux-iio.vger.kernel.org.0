Return-Path: <linux-iio+bounces-24484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF7BA5FF9
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788AF3802EC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1E2E0B68;
	Sat, 27 Sep 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFZjtiKc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9512D949F
	for <linux-iio@vger.kernel.org>; Sat, 27 Sep 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981323; cv=none; b=TNepdx1+bB0PspnnU2cikFKLHNXPUxTNF3hJkd2KNshbvLJstgzCIVPaM85A/nDS3OQVA77P4wKO4pZfl8YHVgX+f2rMshFoVFTmWrWCkMTV87VHS9bbUkm/hoW64zqwc3PpiVSNceOCdWg36eXKoWEo8cxs2/qwMwOhAW1u0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981323; c=relaxed/simple;
	bh=4ZPRX6Avpyb9sskbB7hnDLbjW1kKpRJvK3j5Men1Vt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYsTkmKljsDO1LwVtMLQNGBifIgoFrQ4h7JTiuPbtc1Os2N0Z726nFf2+5ak2PhZTG0KQ0xHEAZGZnX/ZYpe39G4tdbvRKginbV58AAXw8pRW2R0hjDIWZ9oGSOcL8P1pe+VpmvXyWsEuaItvZTl82vCV04SslsSoQsGTZyRqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFZjtiKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D0FC4CEE7;
	Sat, 27 Sep 2025 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981323;
	bh=4ZPRX6Avpyb9sskbB7hnDLbjW1kKpRJvK3j5Men1Vt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cFZjtiKcv8QRomofww1ocs6yPQD+dR1NNefyrppzEheoUknb9O+sMjoL7qE3sRY/q
	 LbL/Jlwn4iyTVxzDs9P0Z2E3XH7T9d9FOleciL16/o/4BbIVhrUPaam9XEsKwSbisL
	 xPWbK4jaeQ6NatOGYR9IvYmcBcHafnNzoBaXVl2YEEIz0UUldZIVZfCnbSe7u9vsXh
	 HX0zcB0GFbjBnvvSx8AFlwBlN1RMjjrUHR6EmMPHZpRjD9RJY7B5mJX4+sJKNKqdL+
	 eoZVtiQ2LDavRlqMr1zIbcf1zRXzHF/tmyw3lbrVYZ7XYtezUgsKKcLnR+J7HFMIWj
	 xllmk0sgMNRmg==
Date: Sat, 27 Sep 2025 14:55:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Kessler Markus <markus.kessler@hilti.com>
Subject: Re: [PATCH v2] iio: accel: fix ADXL355 startup race condition
Message-ID: <20250927145515.26692e60@jic23-huawei>
In-Reply-To: <20250915115818.14164-1-andrej.v@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
	<20250915115818.14164-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 13:58:18 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
> 
> There is an race-condition where device is not full working after SW reset.
> Therefore it's necessary to wait some time after reset and verify shadow
> registers values by reading and comparing the values before/after reset.
> This mechanism is described in datasheet at least from revision D.
> 
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> ---
There should be a change lot here.

As per the reply I just sent, even though today regmap doesn't need a dma
safe buffer for bulk reads that is undocumented detail and may not remain
true in the long run.  Hence use a dma safe buffer.

>  drivers/iio/accel/adxl355_core.c | 41 ++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 2e00fd51b4d51..d688841f374da 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -56,6 +56,8 @@
>  #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>  #define ADXL355_SELF_TEST_REG		0x2E
>  #define ADXL355_RESET_REG		0x2F
> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
> +#define ADXL355_SHADOW_REG_COUNT	5
>  
>  #define ADXL355_DEVID_AD_VAL		0xAD
>  #define ADXL355_DEVID_MST_VAL		0x1D
> @@ -294,6 +296,8 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>  static int adxl355_setup(struct adxl355_data *data)
>  {
>  	unsigned int regval;
> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
As above. This needs to be DMA safe. If you want to keep it local use
	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
or kcalloc if you prefer.  


> +	int retries = 5; /* the number is chosen based on empirical reasons */
>  	int ret;
>  
>  	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
> @@ -321,14 +325,41 @@ static int adxl355_setup(struct adxl355_data *data)
>  	if (regval != ADXL355_PARTID_VAL)
>  		dev_warn(data->dev, "Invalid DEV ID 0x%02x\n", regval);
>  
> -	/*
> -	 * Perform a software reset to make sure the device is in a consistent
> -	 * state after start-up.
> -	 */
> -	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
> +	/* Read shadow registers to be compared after reset */
> +	ret = regmap_bulk_read(data->regmap,
> +			       ADXL355_BASE_ADDR_SHADOW_REG,
> +			       shadow_regs, ADXL355_SHADOW_REG_COUNT);

Here is the non dma safe buffer usage.

>  	if (ret)
>  		return ret;
>  
> +	do {
> +		if (--retries == 0) {
> +			dev_err(data->dev, "Shadow registers mismatch\n");
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * Perform a software reset to make sure the device is in a consistent
> +		 * state after start-up.
> +		 */
> +		ret = regmap_write(data->regmap, ADXL355_RESET_REG,
> +				   ADXL355_RESET_CODE);
> +		if (ret)
> +			return ret;
> +
> +		/* Wait at least 5ms after software reset */
> +		usleep_range(5000, 10000);
> +
> +		/* Read shadow registers for comparison */
> +		ret = regmap_bulk_read(data->regmap,
> +				       ADXL355_BASE_ADDR_SHADOW_REG,
> +				       data->buffer.buf,
> +				       ADXL355_SHADOW_REG_COUNT);
> +		if (ret)
> +			return ret;
> +	} while (memcmp(shadow_regs, data->buffer.buf,
> +			ADXL355_SHADOW_REG_COUNT));
> +
>  	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
>  				 ADXL355_POWER_CTL_DRDY_MSK,
>  				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));



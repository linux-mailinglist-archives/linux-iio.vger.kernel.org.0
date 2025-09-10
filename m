Return-Path: <linux-iio+bounces-23962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8FB52045
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B115E1E2D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CF26F2A6;
	Wed, 10 Sep 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeiOeX9f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33A19C54F
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529057; cv=none; b=tCZnJMabwSeloISnM9ODi/2qSSJQRwWJGsM5EERPBUtIkH9fAsgOq3FqhuxbSXVV4xkgZRt8F74g4kVy3qoEjhyQsNiuoMOudltJQkzT9Q3+ePi40ovD7eJ/i5ncKfpfVXCJvBwiovwauWaeRYsEy9hsbN5k90HPHJ3ve53iNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529057; c=relaxed/simple;
	bh=DXlj2a55svWWqKJiSTR+EbQrABpFnf8vcD4z9vlwy+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJnXQIRxki4Sa0YsIGEo/4MVaFCBnd3j3YqsCF6TSYTgfGFUyufYUbLYWTqTeX1eCeWKJngzhh+TvK0Y+P8LgwnlrS/HZwrTLaLOKj1a+IKou/ZKhs4QYzkjfSFAandcsTSqruFjzwqzmDGNnG2PWnMxccMxNM08BN1oV2gp3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeiOeX9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B90C4CEEB;
	Wed, 10 Sep 2025 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757529057;
	bh=DXlj2a55svWWqKJiSTR+EbQrABpFnf8vcD4z9vlwy+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TeiOeX9fDv+8M4dUapjbBwbYEomZbFyHEtCmWf/MNOjdu+e7KHi3WxvLJBzMzePMM
	 5dzakPmkjgCqdzDgP5uhIJVMgek1ZXnFcQBa/0+3qNDBkH1qMBQbr3c/qzE23LRrdv
	 OEsCHLsIQ/4lCv+bPZ5IObpUdwl4GPU4mT1dVULNryV1HTHr+nDoE3cUkLZC53t8LM
	 k90Zfk78Lsu3VEo/Irg42hzm/baYN58HoF5eF/1lLhsKC62PfwgR9pSqu7ApKN42dk
	 C/Ead9lVMSNUgCEhWpbweWjv0nUvsMrv+JOo12h+Uy/vRDDwBxDNDup8DTLrst17/i
	 fdjzLe3wVwgsA==
Date: Wed, 10 Sep 2025 19:30:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Kessler Markus <markus.kessler@hilti.com>
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
Message-ID: <20250910193049.145aa79e@jic23-huawei>
In-Reply-To: <20250909085528.68966-1-andrej.v@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 10:55:28 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
Hi Valek,

Thanks for the patch. Small thing on patch title, don't include drivers.
It's a pain but you need to look at other patches to a given subsystem
to find out the preferred style.

> 
> There is an race-condition where device is not full working after SW reset.
> Therefore it's necessary to wait some time after reset and verify shadow
> registers values by reading and comparing the values before/after reset.
> This mechanism is described in datasheet at least from revision D.

I'm curious about the retries. Does the datasheet given any explanation for
why a reset might fail a few times before succeeding? 

> 
> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> ---
>  drivers/iio/accel/adxl355_core.c | 48 ++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 2e00fd51b4d51..5386cd4766def 100644
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
> @@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>  static int adxl355_setup(struct adxl355_data *data)
>  {
>  	unsigned int regval;
> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];

Needs to be a DMA safe buffer.  We can't assume that regmap will always
bounce the data through one before passing it to the SPI controllers
that do sometimes require DMA safe buffers.    Add a buffer to end of
struct adxl355_data where you can take advantage of the forcing of appropriate
padding that is already going on there.

> +	bool shadow_regs_valid = false;
> +	int retries = 5; /* retries for reading shadow registers */

If this is an empirical number of retries say so. If it's on the datasheet
then mention that in the comment instead.

>  	int ret;
>  
>  	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
> @@ -321,14 +326,47 @@ static int adxl355_setup(struct adxl355_data *data)
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
>  	if (ret)
>  		return ret;
>  
> +	/* Do software reset and check validity of the shadow registers */
> +	while (!shadow_regs_valid && (retries > 0)) {
I would use a do { } while here.

> +		/*
> +		 * Perform a software reset to make sure the device is in a consistent
> +		 * state after start-up.
> +		 */
> +		ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
> +		if (ret)
> +			return ret;
> +
> +		/* Wait at least 5ms after software reset */
> +		usleep_range(5000, 10000);
> +
> +		/* Read shadow registers for comparison */
> +		ret = regmap_bulk_read(data->regmap,
> +				       ADXL355_BASE_ADDR_SHADOW_REG,
> +				       data->buffer.buf, ADXL355_SHADOW_REG_COUNT);
> +		if (ret)
> +			return ret;
> +
> +		/* Check if shadow registers have expected values */
> +		shadow_regs_valid = !memcmp(shadow_regs, data->buffer.buf,
> +					    ADXL355_SHADOW_REG_COUNT);
The reason for the do { } while () suggestion above is that then you can move
the memcpy into the while condition and just decrement retries unconditionally
at the top of the loop.   Then if retries is 0 in the loop exit directly.
That way we avoid need for the shadow_regs_valid variable and generally end up with
slightly shorter code.

So in all that is something like.

	do {
		retries--;
		if (!retries)
			return dev_err_probe();

		ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
		if (ret)
			return ret;

		/* Wait at least 5ms after software reset */
		usleep_range(5000, 10000);

		/* Read shadow registers for comparison */
		ret = regmap_bulk_read(data->regmap,
				       ADXL355_BASE_ADDR_SHADOW_REG,
				       data->buffer.buf, ADXL355_SHADOW_REG_COUNT);
		if (ret)
			return ret;
	} while(memcmp(shadow_regs, data->buffer.buf,
		       ADXL355_SHADOW_REG_COUNT));

> +		if (!shadow_regs_valid) {
> +			retries--;
> +			dev_warn(data->dev, "Shadow registers mismatch, retrying...\n");
I'd drop this as rather noisy. If the retry is a reasonable thing to do, we probably don't
want to bother userspace with it. If it indicates a hardware problem, just fail if
it doesn't work first time.

> +		}
> +	}
> +
> +	if (!shadow_regs_valid) {
> +		dev_err(data->dev, "Invalid shadow registers values\n");
> +		return -EIO;
> +	}
> +
>  	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
>  				 ADXL355_POWER_CTL_DRDY_MSK,
>  				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));



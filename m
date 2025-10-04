Return-Path: <linux-iio+bounces-24701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B660EBB8D5A
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810F24E1011
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D8274B26;
	Sat,  4 Oct 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agQN1jYO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142560B8A;
	Sat,  4 Oct 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582402; cv=none; b=BxvKq0d+pTHkfQLvS9PrEn0xEEzG0fepV9Bb2d/XcGzISEpmLftTkZyJGFm4/Wvmghx8sOYq36ZMwBhkxhTo4q19jrWawGYC+mUipa7C6pJqiWdOPCvQnVig0z9/t0+P9+klVO6R29EDU4TZ8LsuPTjSWu/m68lBbjfkV55HEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582402; c=relaxed/simple;
	bh=5cTSDfuOM8FTBJ6ekVoinzo5GXCEGY64aElhQgmgD08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7e6wVmoGRsAceLZW0NjGU7Ms6pAvZssN4jYtPxHQNLGlECxhZTWcF9GIW9Ri9+BhZDN9STlBlNI6UMv/Qe7hqeeGeafCavb6KCP3VriPcV6/4EZTMxdl1OOdEzSOMf5JZCDfq3b+GKznHUWaxkPbUOiN433m2AoebouCpeSEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agQN1jYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E364C4CEF1;
	Sat,  4 Oct 2025 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759582401;
	bh=5cTSDfuOM8FTBJ6ekVoinzo5GXCEGY64aElhQgmgD08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=agQN1jYOrZvKiXBvKr0tLrgeZeMfyBfTMg++UYH4Vf6D7pguj39gjFuAXGtLn8GVC
	 sQUkpFs2/lMtNax/eF36k+bK+aMSw7Uv2NOVrQbBDm9LSlyrYEUzHrY8EC5D1J0QyI
	 omjOziUxj/SLsBE0+J0A3IGtIPejIuUc6Y0gn0roQadkumwzC1CpU5Z+BP35nnViLC
	 cH7GGVXrnURfw47NTdaZGfQf+OtlrGmM5wPhHixCdoXSPSzNq3E1I6gmQg61Cpmc/O
	 3hF4bUfPl83nX+voaXA5O4n6cem9wO0Yt2b243ovyXaMNB0j/xS3oLbF6Dd9NZL4s6
	 2D+bLQMIaBDGQ==
Date: Sat, 4 Oct 2025 13:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: accel: bma400: Reorganize and rename
 register and field macros
Message-ID: <20251004135312.41858380@jic23-huawei>
In-Reply-To: <20251002184120.495193-2-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
	<20251002184120.495193-2-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 00:11:02 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Reorganize register and field macros to improve consistency with the
> datasheet and naming style:
> 
> - Move field macros next to their corresponding register macros
> - Reorder register macros to follow address order from the datasheet
> - Rename field macros to include the register name in the macro name
> - Add a _REG suffix to register macros where missing
> 
> No functional changes are intended.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

This is much easier to review. Thanks for breaking it all up.

> ---
>  drivers/iio/accel/bma400.h      | 110 +++++++++--------
>  drivers/iio/accel/bma400_core.c | 212 ++++++++++++++++----------------
>  2 files changed, 163 insertions(+), 159 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 932358b45f17..ae3411c090c9 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -16,31 +16,37 @@

>  /* Event and interrupt registers */
>  #define BMA400_EVENT_REG            0x0d
> +
>  #define BMA400_INT_STAT0_REG        0x0e
>  #define BMA400_INT_STAT1_REG        0x0f
>  #define BMA400_INT_STAT2_REG        0x10
> -#define BMA400_INT12_MAP_REG        0x23
> -#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> +#define BMA400_ENG_OVRUN_INT_STAT_MASK		BIT(4)

This is an odd field as it applies to all the INT_STATX registers
However  I would still try to make that connection with a name
such as BMA500_INT_STAT_OVRUN_MASK

> +#define BMA400_STEP_INT_STAT_MASK		GENMASK(9, 8)

This bit is a little odd.  We are treating INT_STAT0 and INT_STAT1
(but not 2) as a single 16 bit register. That makes it hard to
associate the field with the register name. I wonder if we shouldn't
break that and just handle it as a pair of u8 instead.

> +#define BMA400_S_TAP_INT_STAT_MASK		BIT(10)
> +#define BMA400_D_TAP_INT_STAT_MASK		BIT(11)
>  
>  /* Temperature register */
>  #define BMA400_TEMP_DATA_REG        0x11
> @@ -55,70 +61,68 @@
>  #define BMA400_STEP_CNT1_REG        0x16
>  #define BMA400_STEP_CNT3_REG        0x17
>  #define BMA400_STEP_STAT_REG        0x18
> -#define BMA400_STEP_INT_MSK         BIT(0)
>  #define BMA400_STEP_RAW_LEN         0x03
> -#define BMA400_STEP_STAT_MASK       GENMASK(9, 8)
>  
>  /*
>   * Read-write configuration registers
>   */
> -#define BMA400_ACC_CONFIG0_REG      0x19
> -#define BMA400_ACC_CONFIG1_REG      0x1a
> +#define BMA400_ACC_CONFIG0_REG		0x19
> +#define BMA400_ACC_CONFIG0_LP_OSR_MASK		GENMASK(6, 5)
> +#define BMA400_LP_OSR_SHIFT		5
#
Should never need a explicit shift. Use FIELD_PREP() and FIELD_GET() to
allow the MASK to be used in all cases.

> +
> +#define BMA400_ACC_CONFIG1_REG		0x1a
> +#define BMA400_ACC_CONFIG1_ODR_MASK		GENMASK(3, 0)
> +#define BMA400_ACC_CONFIG1_ODR_MIN_RAW		0x05
> +#define BMA400_ACC_CONFIG1_ODR_LP_RAW		0x06
> +#define BMA400_ACC_CONFIG1_ODR_MAX_RAW		0x0b
> +#define BMA400_ACC_CONFIG1_ODR_MAX_HZ		800
> +#define BMA400_ACC_CONFIG1_ODR_MIN_WHOLE_HZ	25
> +#define BMA400_ACC_CONFIG1_ODR_MIN_HZ		12
> +#define BMA400_ACC_CONFIG1_NP_OSR_MASK		GENMASK(5, 4)

> +#define BMA400_NP_OSR_SHIFT		4
Similarly on this shift.

> +#define BMA400_ACC_CONFIG1_ACC_RANGE_MASK	GENMASK(7, 6)
> +#define BMA400_ACC_RANGE_SHIFT		6

and this one.  Might be a good idea to switch away from using the shifts
as a precursor patch as it's really a different sort of change from
the rest of this.

> +
>  #define BMA400_ACC_CONFIG2_REG      0x1b
> -#define BMA400_CMD_REG              0x7e
>

...
  
> -		osr = (val & BMA400_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;
> +		osr = (val & BMA400_ACC_CONFIG0_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;

Here is one of those cases with the shift that could just be
		osr = FIELD_GET(BMA400_ACC_CONFIG0_LP_OSR_MASK, val);

>  
>  		data->oversampling_ratio = osr;
>  		return 0;
> @@ -603,7 +603,7 @@ static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
>  			return ret;
>  		}
>  
> -		osr = (val & BMA400_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
> +		osr = (val & BMA400_ACC_CONFIG1_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
her as well.
>  
>  		data->oversampling_ratio = osr;
>  		return 0;
> @@ -637,7 +637,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
>  			return ret;
>  
>  		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> -				   (acc_config & ~BMA400_LP_OSR_MASK) |
> +				   (acc_config & ~BMA400_ACC_CONFIG0_LP_OSR_MASK) |
>  				   (val << BMA400_LP_OSR_SHIFT));
FIELD_PREP for this one.  
>  		if (ret) {
>  			dev_err(data->dev, "Failed to write out OSR\n");
> @@ -653,7 +653,7 @@ static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
>  			return ret;
>  
>  		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
> -				   (acc_config & ~BMA400_NP_OSR_MASK) |
> +				   (acc_config & ~BMA400_ACC_CONFIG1_NP_OSR_MASK) |
>  				   (val << BMA400_NP_OSR_SHIFT));
here as well.  Anyhow, from a quick look it appears that getting rid of the _SHIFT defines
should be easy.


>  		if (ret) {
>  			dev_err(data->dev, "Failed to write out OSR\n");
>

>  
> @@ -786,8 +786,8 @@ static int bma400_enable_steps(struct bma400_data *data, int val)
>  		return 0;
>  
>  	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> -				 BMA400_STEP_INT_MSK,
> -				 FIELD_PREP(BMA400_STEP_INT_MSK, val ? 1 : 0));
> +				 BMA400_INT_CONFIG1_STEP_INT_MASK,
> +				 FIELD_PREP(BMA400_INT_CONFIG1_STEP_INT_MASK, val ? 1 : 0));

Could use regmap_assign_bits() to simplify this a bit - but separate change
so different patch.

>  	if (ret)
>  		return ret;



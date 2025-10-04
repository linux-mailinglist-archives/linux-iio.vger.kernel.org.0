Return-Path: <linux-iio+bounces-24702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13EBB8D60
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7AB189896E
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422A274B59;
	Sat,  4 Oct 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBrJ8Jqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07FEEAB;
	Sat,  4 Oct 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582718; cv=none; b=LisGMCcyGp+xg7lJ2aKn5+Sd7qW6M43dxFZdpc7y0axlLvKNybOjRNEAfkw8GjayIgUeJMQ+cmHO2NaoUpgtvAsw2z1hPcH9a0a/TY+G7GiclrWrvsjMwFApqkFyKxzBFZOpeIB7Hrd5YkJHHxPTDezvdFREE5sv1dok8rXqGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582718; c=relaxed/simple;
	bh=KBqW3QSnz85eXoRODyagydgAvgGnhYdaKO/Oy9W6IkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvHbXrADi3CiZgKi1TjBxAGl8cLine40BIWbIySzp2mbVSeQGu3jEORWTjwN0JqJpL0ULifmZq8CUBqN8c/ki30mtY8rYWohJC3svIFHqjmmVSZ0l+T9R9dtKxZOo/7K4mrOhFj4OC09/Fkxrn8QfYdY4LUADD1bCC2+zQcNNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBrJ8Jqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B7AC4CEF1;
	Sat,  4 Oct 2025 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759582717;
	bh=KBqW3QSnz85eXoRODyagydgAvgGnhYdaKO/Oy9W6IkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oBrJ8JqxLmigtzroaDf6in74sXMIVAbcyxki+Jxyt4Ejt9PTmWEn2x84qHO1BXWhr
	 rMbQHVjbfiEpTu8M2xfSaBYaAXk0QHA9F7bl51ozu3U59FY6iMjswaqyhTnhr0sAVs
	 o2VyMMPc4dKxGZ3tmiEa/fGh9hdtBM0rw5kd+e+Pztham1gqTqcLuckDoPaP+WZNdf
	 Ooxw/VwXlBfz1YDMK9OUS8yUjL01wWCQCqRBxuAjx5smFPx3CP9FhWEQtXrpIpnOZv
	 rwP1DgSuIh5MYYHJX4BtwsEN0sDrT2/NQ7iFlNbBfEiNaPdpyeAGZvn+7wF1Xahbh8
	 BibNdU3HGcD0Q==
Date: Sat, 4 Oct 2025 13:58:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: accel: bma400: Use macros for generic event
 configuration values
Message-ID: <20251004135829.531a03e1@jic23-huawei>
In-Reply-To: <20251002184120.495193-3-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
	<20251002184120.495193-3-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 00:11:03 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Add macros and enums for configuration values used in generic event
> handling for activity and inactivity detection. Replace hard-coded
> values in activity_event_en() with the new definitions to make the
> configuration explicit.
> 
> No functional changes are intended.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      | 30 ++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma400_core.c | 14 +++++++++++---
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index ae3411c090c9..13fe2e5a3175 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -106,8 +106,38 @@
>  #define BMA400_GEN1INT_CONFIG0_REG      0x3f
>  #define BMA400_GEN2INT_CONFIG0_REG      0x4A
>  #define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
> +#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK	GENMASK(3, 2)
> +#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK	BIT(4)
> +#define BMA400_GENINT_CONFIG0_X_EN_MASK		BIT(5)
> +#define BMA400_GENINT_CONFIG0_Y_EN_MASK		BIT(6)
> +#define BMA400_GENINT_CONFIG0_Z_EN_MASK		BIT(7)
> +
> +enum bma400_accel_data_src {
> +	ACCEL_FILT1,
> +	ACCEL_FILT2,
> +};
> +
> +enum bma400_ref_updt_mode {
> +	BMA400_REF_MANUAL_UPDT_MODE,
> +	BMA400_REF_ONETIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_LP_UPDT_MODE,
> +};
>  
>  #define BMA400_GEN_CONFIG1_OFF      0x01
> +#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK	BIT(0)
> +#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK	BIT(1)
> +
> +enum bma400_genintr_acceleval_axescomb {
> +	BMA400_EVAL_X_OR_Y_OR_Z,
> +	BMA400_EVAL_X_AND_Y_AND_Z,

An enum for potential field values only makes sense if you are going to
use it as a type somewhere.  If not it is simpler to just
use a define next to the mask for the field.  Also these should be named
with prefixes that align with that mask.
If you do use it as a type in future patches that's fine but the naming
point still remains and you should specify values = 0, = 1 etc
as they matter whereas implication of using an enum is that the actual
values assigned doesn't matter.

Same applies to the other enums introduced in here.
> +};
> +
> +enum bma400_detect_criterion {
> +	BMA400_DETECT_INACTIVITY,
> +	BMA400_DETECT_ACTIVITY,
> +};
> +
>  #define BMA400_GEN_CONFIG2_OFF      0x02
>  #define BMA400_GEN_CONFIG3_OFF      0x03
>  #define BMA400_GEN_CONFIG31_OFF     0x04
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 35d2b90425f8..58c378ba9931 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1166,14 +1166,16 @@ static int bma400_activity_event_en(struct bma400_data *data,
>  	case IIO_EV_DIR_RISING:
>  		reg = BMA400_GEN1INT_CONFIG0_REG;
>  		msk = BMA400_INT_CONFIG0_GEN1_MASK;
> -		value = 2;
> +		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
> +			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_ACTIVITY);
>  		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
>  			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
>  		break;
>  	case IIO_EV_DIR_FALLING:
>  		reg = BMA400_GEN2INT_CONFIG0_REG;
>  		msk = BMA400_INT_CONFIG0_GEN2_MASK;
> -		value = 0;
> +		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
> +			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_INACTIVITY);
>  		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
>  			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
>  		break;
> @@ -1182,7 +1184,13 @@ static int bma400_activity_event_en(struct bma400_data *data,
>  	}
>  
>  	/* Enabling all axis for interrupt evaluation */
> -	ret = regmap_write(data->regmap, reg, 0xF8);
> +	ret = regmap_write(data->regmap, reg,
> +			   BMA400_GENINT_CONFIG0_X_EN_MASK |
> +			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
> +			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
> +			   FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK, ACCEL_FILT2)|
> +			   FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK,
> +				      BMA400_REF_EVERYTIME_UPDT_MODE));
>  	if (ret)
>  		return ret;
>  



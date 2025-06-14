Return-Path: <linux-iio+bounces-20636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781BAD9C90
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CAC176918
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849B255F26;
	Sat, 14 Jun 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFy+vcSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8328EA76
	for <linux-iio@vger.kernel.org>; Sat, 14 Jun 2025 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749901448; cv=none; b=ohwdyqBZzfhC7wfxSproQqlMmXBOPR4mn2GaryjIuno/v5Dy2SKymGPpJ+aa1D6U7Ec2rA4lAlmUWU3Gtye3vAsDvn/hzpWDscjErXSBsiNWW38kVdknWwGsMmGCG07fAOvH+UGI4A0JY8gjjFmTaTpzQx2x4HVy5KmKx2lU5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749901448; c=relaxed/simple;
	bh=Stcby+vALzJg6BQc91MKhT4KJS9TKrkcbczfbkXzeL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEj7DQ5uhfVEAIGo8Qi28gmbMFfYqU2F0F7AQAMc0u5IEqHbfpxOV/qxLzSL4Z9PX/ORq4QKeYUQnv8+b4dSh8LuA8VkTGztXHCL0Er/NmCHZE9DsLaZ7lcjeqkRw1EGUStO1FvIfDqM6DBA5f9IFLN+r+VjofoFA/79KkP5ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFy+vcSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AD3C4CEEB;
	Sat, 14 Jun 2025 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749901447;
	bh=Stcby+vALzJg6BQc91MKhT4KJS9TKrkcbczfbkXzeL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AFy+vcStovhyNnoQ1slSflPZCG0WhBOmUjA83ZALt59YDvWRlOWJhBfbD8PgYzEpY
	 +m80b1Sofh7+P4kGkJQs2H52Q9LVMuv5dP52CymCdgYoK+h0XWiMnrQ5nmYwMhDmD8
	 OAsBHKuKlIbNOoGrnhQtuDGW53O+jVfawqXsVNvABrD6PK3wJzbp506mwxIlT1Dw5I
	 4PN3r2cpwAC/XgQFiOhViZP09OACP0w5EE+GVqit2jCIRfcyx31hrgfPrfQ5cWg6cA
	 3cS0UPBnaEZAGeskyvlgAyGZ8oX063U4uSApbrc/IvdPLvt+ftjynrRrsKobRVqgbG
	 Jz1LC2MoyZSDA==
Date: Sat, 14 Jun 2025 12:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: nattan <nattanferreira58@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, lucasantonio.santos@usp.br,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
Message-ID: <20250614124401.32b17eda@jic23-huawei>
In-Reply-To: <20250611174253.16578-1-nattanferreira58@gmail.com>
References: <20250611174253.16578-1-nattanferreira58@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 14:42:53 -0300
nattan <nattanferreira58@gmail.com> wrote:

> From: Nattan Ferreira <nattanferreira58@gmail.com>
> 
> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
Applied with () added after function names in this description.

Thanks,

J
> functions to use a helper function (apds9306_get_thresh_reg) for
> obtaining the correct register based on the direction of the event. This
> improves code readability and maintains consistency in accessing
> threshold registers.
> 
> Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> 
> ---
> 
> Changes in v4:
> - Noted that the change actually adds four more lines to the driver file,
>   so rephrased description to avoid claiming code line reduction.
> ---
>  drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609c..9216d4974 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -744,20 +744,27 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
>  	return regmap_field_write(rf->int_persist_val, val);
>  }
>  
> -static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> -				     int *val)
> +static int apds9306_get_thresh_reg(int dir)
>  {
> -	int var, ret;
> -	u8 buff[3];
> -
>  	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> +		return APDS9306_ALS_THRES_UP_0_REG;
>  	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> +		return APDS9306_ALS_THRES_LOW_0_REG;
>  	else
>  		return -EINVAL;
> +}
> +
> +static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> +				     int *val)
> +{
> +	int reg, ret;
> +	u8 buff[3];
>  
> -	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> +	reg = apds9306_get_thresh_reg(dir);
> +	if (reg < 0)
> +		return reg;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
>  	if (ret)
>  		return ret;
>  
> @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
>  static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
>  				     int val)
>  {
> -	int var;
> +	int reg;
>  	u8 buff[3];
>  
> -	if (dir == IIO_EV_DIR_RISING)
> -		var = APDS9306_ALS_THRES_UP_0_REG;
> -	else if (dir == IIO_EV_DIR_FALLING)
> -		var = APDS9306_ALS_THRES_LOW_0_REG;
> -	else
> -		return -EINVAL;
> +	reg = apds9306_get_thresh_reg(dir);
> +	if (reg < 0)
> +		return reg;
>  
>  	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
>  		return -EINVAL;
>  
>  	put_unaligned_le24(val, buff);
>  
> -	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> +	return regmap_bulk_write(data->regmap, reg, buff, sizeof(buff));
>  }
>  
>  static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *val)



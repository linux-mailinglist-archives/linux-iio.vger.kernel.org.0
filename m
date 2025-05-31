Return-Path: <linux-iio+bounces-20084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE1AC9C06
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C0B9E3409
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E31624E1;
	Sat, 31 May 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os6O+coe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7ED299
	for <linux-iio@vger.kernel.org>; Sat, 31 May 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748712229; cv=none; b=qFVIWyuxQ753dlL13IynPiFzCdbGLP/zpP2E2O1DMg7KthOlm58A7c045YkPPX1HTRevLJhwvAcy8/Gsu6oNQPs+eqcahN8uWPNXWpVjZA2psUfk2PPRcjmBc1UYgLvFe/SoFI5Gzyr2kJMFdwYfZ9yLQ0PX0syHdFq8yuPsO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748712229; c=relaxed/simple;
	bh=OlpS3amQw/jhiqqWf2yspRC3TPC3hrl4+OMLj1AGrJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzI4aPaLBBKi0ynDIluHR/KktgK06xtnDn3+4+0BQXXUATJL2X7To9flgtfK/WqxQjCRfZqc2Oi3/aUpGoTZcQIm6Kye80dToX61DMOCjlkEbJEY3B0rMr7vJXonnjM2zjpyt0ASbVsvzLCOK8no3HkVJhtFvcIE//VC7hh9UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os6O+coe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B64EC4CEE3;
	Sat, 31 May 2025 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748712229;
	bh=OlpS3amQw/jhiqqWf2yspRC3TPC3hrl4+OMLj1AGrJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=os6O+coeqJpi2Rf51lC6nsfuO1FR0vkE4u4CVGq4Zh1TELx9ZWVkEVG0sCoxYs51F
	 dZcOgujWFLAICGyv/byN7p8yqQ05Scst45eotYNlgFMPcpOTbnG/xWcy12YxmaPFKF
	 z1FAHbqK3AgyhpV6Oh/YzbUTuB/17xsuBcK4KZ11rQzoVckJwdvSlMNVFdI+Zt8rv9
	 1HNKpEe7e/oIDZqlvhQuAehPP2dv8v+nvjDXfd23utzaL49BWMLDHhkjJK3yKIWHFI
	 lfZqxML4/ovJ419tnD8Y/OGINfbHya2wyuLxONhNRNlRaS8xjaR7LAGwwtLo1KqWve
	 tQyTDdSUvDUVA==
Date: Sat, 31 May 2025 18:23:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: nattan <nattanferreira58@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, Lucas Antonio
 <lucasantonio.santos@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
Message-ID: <20250531182344.2c3a370e@jic23-huawei>
In-Reply-To: <20250526235906.6598-1-nattanferreira58@gmail.com>
References: <20250526235906.6598-1-nattanferreira58@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 20:59:06 -0300
nattan <nattanferreira58@gmail.com> wrote:

> From: Nattan Ferreira <nattanferreira58@gmail.com>
> 
> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> functions to use a helper function (apds9306_get_thresh_reg) for obtaining the
> correct register based on the direction of the event. This improves code
> readability and maintains consistency
> in accessing threshold registers.
> 
> Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> ---
Change log?

Also this seems to be the second v3.

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



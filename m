Return-Path: <linux-iio+bounces-7401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B1929830
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAD9281081
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22397210E7;
	Sun,  7 Jul 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtlOAuyA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDD1E532;
	Sun,  7 Jul 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360171; cv=none; b=rgAq9u44YtM8DXy8RiHawRvf8OuSBQrPOHUQkAT3deIpzcRmmu+IlId1a7MswxNEGNIEvRAAcGTTjNcODY82QFQh0UCfj00fIjFfXO8E0TQ2O2w1PE4e9ziDOqkYwdL+fhaR8AG7CVqWuDRQI3D6WbnVEFX2mZxjRUDjpjH6QsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360171; c=relaxed/simple;
	bh=PgLTfejkMmIayrl+gkyBdppGOwtWUWYx9kO7ZcNDmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3Lypa0nzKZoVu3G6sRAaGXPtnCNQBu2t/c40QErmKZGMqn+LU7b/4PO4R9r81ORYsfLBhSf8M1PZ1cZakADTIMRoZeu51WgT4pBRSdBN7OB+hIVk2/EyKvX/5xrLNDzAFBtxomFZAtgmFqi8olTloahgqSMlCqa53ASqYATQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtlOAuyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89177C3277B;
	Sun,  7 Jul 2024 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720360170;
	bh=PgLTfejkMmIayrl+gkyBdppGOwtWUWYx9kO7ZcNDmeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RtlOAuyAA/fXbDvqVERNvkNhETaI9KRvVSiP4VRFz5+l0F/zVrPdNXHdceoo/+6NL
	 oHWUuuwv0cyrIw6F8EJo4h/afKgP+RvIyBOo1YJG5oI22VYVJx4IkPozFM6k6FkBbc
	 227zmkh7JHPbluRlMLNqaK1SM2rDLRPIeC6dyWcEYWPS4WOIHGVog3QqoGAhaE1mZh
	 +xbR49J8+6uscjJTXkVv5kDr9aa/jeRCKWXPpPPKQkKQewg8DkWdIqgU6aLqHWpru3
	 JpuJ6IdrSaqbNrUlqzGrhxeFJpsuyzVIe4mSDwkFRE+nChp6VeTZNHQO9F75/RKVBf
	 3Q3++c+iE6XrA==
Date: Sun, 7 Jul 2024 14:49:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Shreeya Patel <shreeya.patel@collabora.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: ltrf216a: Add LTR-308 support
Message-ID: <20240707144922.1a9140da@jic23-huawei>
In-Reply-To: <20240705091222.86916-2-marex@denx.de>
References: <20240705091222.86916-1-marex@denx.de>
	<20240705091222.86916-2-marex@denx.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 11:11:45 +0200
Marek Vasut <marex@denx.de> wrote:

> Add LiteOn LTR-308 support into LTR-F216A kernel driver.
> 
> The two devices seem to have almost identical register map, except that
> the LTR-308 does not have three CLEAR_DATA registers, which are unused
> by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
> calculation constants, 0.6 and 0.45 respectively. Both differences are
> handled using chip info data.
> 
> https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
> https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
One additional question inline...

> ---
>  drivers/iio/light/ltrf216a.c | 49 ++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 68dc48420a886..375312db4ef58 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -68,6 +68,13 @@ static const int ltrf216a_int_time_reg[][2] = {
>  	{  25, 0x40 },
> @@ -382,15 +394,19 @@ static bool ltrf216a_writable_reg(struct device *dev, unsigned int reg)
>  
>  static bool ltrf216a_volatile_reg(struct device *dev, unsigned int reg)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
>  	switch (reg) {
>  	case LTRF216A_MAIN_STATUS:
> -	case LTRF216A_ALS_CLEAR_DATA_0:
> -	case LTRF216A_ALS_CLEAR_DATA_1:
> -	case LTRF216A_ALS_CLEAR_DATA_2:
>  	case LTRF216A_ALS_DATA_0:
>  	case LTRF216A_ALS_DATA_1:
>  	case LTRF216A_ALS_DATA_2:
>  		return true;
> +	case LTRF216A_ALS_CLEAR_DATA_0:
> +	case LTRF216A_ALS_CLEAR_DATA_1:
> +	case LTRF216A_ALS_CLEAR_DATA_2:

Is there any point in this covering registers we have already stated above are
not readable?  I guess we could argue that having this change is acting
as a form of documentation.  Maybe just adding a comment that they
don't exist would be clearer?


> +		return data->info->has_clear_data;
>  	default:
>  		return false;
>  	}
;



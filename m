Return-Path: <linux-iio+bounces-25241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A6BED4D5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057A919A7664
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06565257839;
	Sat, 18 Oct 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9HaIyeJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3876252904;
	Sat, 18 Oct 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808040; cv=none; b=AxB23sZjvoWwWARyYBoK7P9ZJT5GqDiDSg+AsW1OclEd/gDfpVs6Ug9yCS1AHqv4CsNJZD97pp6pgIslcaorDVsXUTvo0+fpSeqRQt7h/oFVC732WuPMSZkcL1OIQ/qk27wQIq2rImrVr5acTB/RvUUcyrdzAdWz56F9bYj765c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808040; c=relaxed/simple;
	bh=rJaVcNN4cnkEj+48Rr5L3efyA8cTVvTbzk214NOuLt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOkmF4QFfeMQRXzDmt+ZZWzUeDLCFO0i74stsR8iWnarbvEkn+hHTK0cdTM931hwUEBJguD7x5WkTp7rHXcsu/bLiGvKiHMl9cRWpkeArJP4vaDGBNnoLlCE24VHDFPy5R5k4AIFr03blUjmOA8A0yXPxxIDGoUk/CGEtq2omUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9HaIyeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A229FC4CEF8;
	Sat, 18 Oct 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808040;
	bh=rJaVcNN4cnkEj+48Rr5L3efyA8cTVvTbzk214NOuLt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9HaIyeJHlkEBCdFo6mqWHgfuqYt1vFJeZvZC3PCOTmZmyj8uGDfOGwyjQLLpC1eN
	 jkvtJIUEIMg5DbcVZ0U9Cn1Tb783qHSNVkTNWSLp4GlEnPBGevVSnvLING6FFb7ZVR
	 dKcouLJjaI6cbf70sgcUUkrSzKqRA5mZtfA+r0SCzC2/yhw2ZqqZUPDERWvxP92T6R
	 Err42BWY/rQx4GFCEoE/Jf8Atlvb/3ogTqr6GLZ1AeSj8MkIf82JAEh385GoS0knKc
	 k3oSTvvqtjTsnUtYwFaviB85zmKFpWv89Mi5GJjNWfveQgYsDikmFpsCTumSXEPZM/
	 jhfuHUU63X9tA==
Date: Sat, 18 Oct 2025 18:20:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: accel: bma220: add low-g event detection
Message-ID: <20251018182032.657d6af6@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-4-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-4-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:43:00 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add support for low-g detection.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Just a follow on related units of _period attributes.

> ---
>  drivers/iio/accel/bma220_core.c | 101 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index c4bebf3e5548..daff22ec1f2d 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -119,6 +119,14 @@ static const struct iio_event_spec bma220_events[] = {
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>  				       BIT(IIO_EV_INFO_PERIOD),
>  	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +				       BIT(IIO_EV_INFO_VALUE) |
> +				       BIT(IIO_EV_INFO_PERIOD) |
> +				       BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
>  };
>  
>  #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
> @@ -509,6 +517,7 @@ static int bma220_read_event_config(struct iio_dev *indio_dev,

> @@ -602,6 +634,37 @@ static int bma220_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_THRESH:
> +		switch (dir) {
> +		case IIO_EV_DIR_FALLING:
> +			switch (info) {
> +			case IIO_EV_INFO_VALUE:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
> +						  &reg_val);
> +				if (ret)
> +					return ret;
> +				*val = FIELD_GET(BMA220_LOW_TH_MSK, reg_val);
> +				return IIO_VAL_INT;
> +			case IIO_EV_INFO_PERIOD:
> +				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
> +						  &reg_val);
> +				if (ret)
> +					return ret;
> +				*val = FIELD_GET(BMA220_LOW_DUR_MSK, reg_val);
As in previous. Seems very unlikely period is in second here, given that would be far too long
to make sense!  See the ABI docs.  Looks to be samples which means
you need to deal with variable sampling frequencies as part of this
calculation.

> +				return IIO_VAL_INT;
>


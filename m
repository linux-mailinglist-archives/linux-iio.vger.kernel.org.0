Return-Path: <linux-iio+bounces-10504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4E99B4D6
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9630B21A6A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE216F826;
	Sat, 12 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHYiK+Ey"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4638DF9;
	Sat, 12 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736596; cv=none; b=igHX0AyNHxewTmNKS1Gb/2A+0mEaB7yOr/bTSSgYuhRS0m1UOnXCfcz5K3CHO7aMhurw1xZVPzLNhNJ0fZy0AVpogdUfwwywM35t5PMDfe5y4lYwSdn+blMBkh8+zBK9WuVUHIwbOdt/kSqHyokX3hEgTKyrvddEfZuQGDYtme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736596; c=relaxed/simple;
	bh=a/UatQU9+8V2NPlACBhCG+m3NEPKW6F6N2R7bStcDlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEntnU4+XMfrmc7GlbVka79yvHHF9GUcCiNA+jgwMiuJeNZ9CQEeRZdXWVift03cDNYrQ2103//jTiLf1qrgYGsML1XgRM8iZZia+P8sGb/aXEIwQZ5E4fJ7/8ugBNZn79oP6hpxhLG+nfemJISThv3tSd+WVo9HpdheBtA4GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHYiK+Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27EBC4CEC6;
	Sat, 12 Oct 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728736595;
	bh=a/UatQU9+8V2NPlACBhCG+m3NEPKW6F6N2R7bStcDlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHYiK+EyFbI90QnbHp4JiK8cxzFKQOVIkg8Jq4YD04ZepflkpOxuYq6vibHvlfM9B
	 EgDMbZHnsIrO1m2vUSVaCAdmgOl7z/eMjaBCt34nDkULpOm67ttT5FrnrLvUSVGjNr
	 xSH9dL2LV+qmWYd7syBQjSjcMppzSMExvO/WTfGtf4ZBTIT/FmOKA176OqTFj2Onht
	 Cldxdpou4gFz3vJdd8XWk9hlmwsYBG3dfEumzsAAF8wCVVIlswNCzGiB5BU/tCEDAo
	 h1aK5uFI4TocUviwg1HkumcNUy2qniv/y9ctXjC1pKxP89pbSDl6hYVir7n8UWqAu7
	 eYRYjS1RvrXrQ==
Date: Sat, 12 Oct 2024 13:36:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] iio: chemical: bme680: Add support for preheat
 current
Message-ID: <20241012133610.0aff77bc@jic23-huawei>
In-Reply-To: <20241010210030.33309-14-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-14-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 23:00:30 +0200
vamoirid <vassilisamir@gmail.com> wrote:

> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add functionality to inject a specified amount of current to the heating
> plate before the start of the gas measurement to allow the sensor to reach
> faster to the requested temperature.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |  1 +
>  drivers/iio/chemical/bme680_core.c | 38 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index e7eed2962baa..c658cb631b52 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -42,6 +42,7 @@
>  #define   BME680_RHRANGE_MASK			GENMASK(5, 4)
>  #define BME680_REG_RES_HEAT_VAL			0x00
>  #define   BME680_RSERROR_MASK			GENMASK(7, 4)
> +#define BME680_REG_IDAC_HEAT_0			0x50
>  #define BME680_REG_RES_HEAT_0			0x5A
>  #define BME680_REG_GAS_WAIT_0			0x64
>  #define BME680_ADC_GAS_RES			GENMASK(15, 6)
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index df6ae4355902..6cdf8b9dbf2b 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -126,6 +126,7 @@ struct bme680_data {
>  	u8 oversampling_temp;
>  	u8 oversampling_press;
>  	u8 oversampling_humid;
> +	u8 preheat_curr;
>  	u16 heater_dur;
>  	u16 heater_temp;
>  
> @@ -223,6 +224,12 @@ static const struct iio_chan_spec bme680_channels[] = {
>  		},
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.output = 1,
> +		.scan_index = 5,

Set scan index to -1
you don't want to create the buffer related attrs for this one

> +	},



Return-Path: <linux-iio+bounces-5302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BF8CF06F
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DC1281C13
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E886657;
	Sat, 25 May 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koGIY1hG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081F78C78;
	Sat, 25 May 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657902; cv=none; b=FK14SrSzsoF11xpvQkxSEVFUbBb0HD6YYpIeasHR08/1r6gBATdOSO6fLzVKAqe+mSSCQbD4yoLh+LxCrzeF9SLyQPvwlYdB1bfHTiUwpwDJRSQqxBicjLvMjpntiD+BncVgBkVV/BXmXg6teLlhh7q83VhIZYRJKm42FxMVXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657902; c=relaxed/simple;
	bh=zF3vWrRSb3Tt7ImJivSuFUwt5wnnge7uh0GFA9YiEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiFqXUkrgb3dlQFC4WNcURvg3ntbkiLUQNmmjyjJcQHRPbZ5XsCrkHGdD0EPCgcJ4aYbFcNZdnZOHpYXBn0eDaWQCSq2lhwQOJSlWDdn+nz0tvuDOmIVkS27sYuYZSUz5yl0JAS6ZtKFaVbPh9VcFxKC7oOsQeYoomLSaMni8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koGIY1hG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D153C2BD11;
	Sat, 25 May 2024 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716657901;
	bh=zF3vWrRSb3Tt7ImJivSuFUwt5wnnge7uh0GFA9YiEXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=koGIY1hGItUS/r/PnbTu2Amp4969qGtiCQIgGPliswec8QlEbW5c1deZjFZccjRza
	 lil+TiCtlu2WvMdwZAzA/poHogccvHbozbiN/FTF4iUlkpiqKfQwJ3ZyF1PTPcetIi
	 OvJ+iMsKDA0zVZj2nPadzC4Xs8cUELvds7p0qv0nHnbGuobFbBA+ygi+VAB3AN3DrI
	 RaFvoc4552gW9xYuqA2TJlh0yewzauXQAytGg1irTRSNaiKVdnzfeMessPR9/DesLT
	 EaLlmU/qUs93vk18F9k59JQuwQlrc8rAj2skibiNukZ0cBUVsitR332ejvd2d1MGtQ
	 unoFecL3QSl5Q==
Date: Sat, 25 May 2024 18:24:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sort Makefile
Message-ID: <20240525182451.552ac7e3@jic23-huawei>
In-Reply-To: <20240523192412.3220547-1-dlechner@baylibre.com>
References: <20240523192412.3220547-1-dlechner@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:24:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The Makefile for IIO ADC drivers is intended to be sorted alphabetically.
> I can be tricky to keep it sorted when adding new drivers when not all
> of the existing drivers are sorted. So let's sort everything now to make
> it easier to keep it sorted in the future.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied.


> ---
> 
> This was done mechanically using the sort feature in my text editor,
> with the exception of the line starting with "xilinx-xadc-y".
> 
>  drivers/iio/adc/Makefile | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index edb32ce2af02..6a8c2da0e707 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_AD7280) += ad7280a.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
> -obj-$(CONFIG_AD7923) += ad7923.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> @@ -29,6 +28,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
>  obj-$(CONFIG_AD7791) += ad7791.o
>  obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
> +obj-$(CONFIG_AD7923) += ad7923.o
>  obj-$(CONFIG_AD7944) += ad7944.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
> @@ -90,42 +90,43 @@ obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> +obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
> -obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> -obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
> +obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
> +obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
>  obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> -obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
>  obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> +obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> -obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
> -obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> -obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
>  obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
> +obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
>  obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
> +obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
> +obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
> -obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>  obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
> +obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
> +obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
> +obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
>  obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> -obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
> -obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
> @@ -134,7 +135,6 @@ obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>  obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> -obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
> -obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o



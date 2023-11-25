Return-Path: <linux-iio+bounces-361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8687F8CBD
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15BE1C20B76
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C42C861;
	Sat, 25 Nov 2023 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAvZNSld"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D351384
	for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2023 17:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45585C433C7;
	Sat, 25 Nov 2023 17:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700933118;
	bh=htnaOPBl/Kab+ZpjJXrbvc1PC3mpuEB/13T1KfZ4C9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mAvZNSld3bzLwX67volEbq3Gr9Ucpnw8Hqw7WKvu2R5Iv10FyWlo9EMF6LdlLHNis
	 rYQ3JzskqJlvUybUSiaXjbhMj1YjnHtgOj+f+SF6II3oj21wHzF0PvlOxgdn13wViV
	 4B6RBmv1B3WwA8DV3IVHloyRNw7H+vVnzxc+Sb9VWvFF3sCEyR4xvjkLzCfjPATdPT
	 GdfydhRR7RxCBYlG+A+v7Qok4QwF1BKCvSk8oaSNgiez/pVj6fz1DIsTJBH5zMYfi7
	 CkCCbxOyyCxxseJGe6q6n1h+cnA8JO+T+WfhvP+I4RZRBLoWTU0xar62ULpMd7Ou19
	 CPYdHUKxs+sZg==
Date: Sat, 25 Nov 2023 17:25:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: <lars@metafoo.de>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
 <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
 <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
 <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-amlogic@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 1/1] iio: adc: meson: add separate config for axg SoC
 family
Message-ID: <20231125172508.2a2242bf@jic23-huawei>
In-Reply-To: <20231122074741.154228-1-gnstark@salutedevices.com>
References: <20231122074741.154228-1-gnstark@salutedevices.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 10:47:41 +0300
George Stark <gnstark@salutedevices.com> wrote:

> According to Amlogic custom kernels ADC of axg SoC family has
> vref_select and requires this setting to work nominally and thus
> needs a separate config.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Is this a fix?  If so, please provide a fixes tag.
Or is it aligning with the vendor kernels and we don't know if
it's strictly necessary or not?

> ---
>  drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index db280da9edbf..34555a85f131 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>  	.cmv_select = 1,
>  };
>  
> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> +	.has_bl30_integration = true,
> +	.clock_rate = 1200000,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
> +	.resolution = 12,
> +	.disable_ring_counter = 1,
> +	.has_reg11 = true,
> +	.vref_volatge = 1,
> +	.has_vref_select = true,
> +	.vref_select = VREF_VDDA,
> +	.cmv_select = 1,
> +};
> +
>  static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>  	.has_bl30_integration = false,
>  	.clock_rate = 1200000,
> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> -	.param = &meson_sar_adc_gxl_param,
> +	.param = &meson_sar_adc_axg_param,
>  	.name = "meson-axg-saradc",
>  };
>  



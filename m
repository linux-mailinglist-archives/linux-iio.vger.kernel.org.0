Return-Path: <linux-iio+bounces-8293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64A9495E5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704D71F21664
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B346450;
	Tue,  6 Aug 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdQOXAjW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D844C81;
	Tue,  6 Aug 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963072; cv=none; b=IyRu14TgT8NxInnlPLPsE7n5+mpH4b4VunlSBA56PAkvHSZH+f3kmPg5QotBpkuj86yqi8LV2Dt5tRCkP5BiGZAymQsLdbosB3tNZMT5cxA0L+RUPQpavbqxwaYGkXLHnNc7gAepL50I1fzPrv1g5JNjVrU8o7hnDinhgxVCB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963072; c=relaxed/simple;
	bh=17eO7sl2jd1gtxWt8RVlCObOGsTQ5a/P8JFR/vmFREY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsPeoHFaLcxg+E0BWZQh9mXa7m8IXQ/SnCudPGTIonA+PdT/W2QTv+0lNoRJLj2IV0wv6ptq+ENsrDLNSZ0IZtp4nhXSHssRf2j/PsBAXUTR1k6q1FxU5b+k/2LkHEYC0R7Ewr2Dd90FnGi+H53LljbhszKOw9agJXgge5tsbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdQOXAjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5034C4AF0C;
	Tue,  6 Aug 2024 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963071;
	bh=17eO7sl2jd1gtxWt8RVlCObOGsTQ5a/P8JFR/vmFREY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BdQOXAjWke+YVJ7M94Cqkn1mWhs11qVSCmbtfOkCA1QjpaAKlMnIAUcR870pXf0WB
	 G9isqgmLNvGoTCFResa+tSZnKaq25a04mvVUfwf8EL5Wfja5AY4vNNEaxuiHMSzFvl
	 6kC2yLD94EHYXWLeyo45gQx/ithDK5NN699311Qy9cCdHcV+Mh2vyK3SAsEfGcn3yb
	 dMv27AGPrZRTHr7n31sZ317TlympdjYTGltXlbaKV2AkUgOzTELjoOp0hlOdAjRRip
	 FPqFLNDVq/jk5bcCVcKP7gOvO7Qbds3qu0LOUwzgYm+JwessgwHstUMzRlg1WBFRIU
	 2Cu9FcM5bxemQ==
Date: Tue, 6 Aug 2024 17:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/9] iio: add iio backend support to sd modulator
Message-ID: <20240806175106.09a53784@jic23-huawei>
In-Reply-To: <20240730084640.1307938-9-olivier.moysan@foss.st.com>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
	<20240730084640.1307938-9-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:46:38 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> The legacy sd modulator driver registers the sigma delta modulator as
> an IIO channel provider. This implementation is not convenient when the
> SD modulator has to be cascaded with another IIO device. The scaling
> information is distributed across devices, which makes it difficult to
> report consistent scaling data on IIO devices.
> 
> The solution is to expose these cascaded IIO devices as an aggregate
> device, which report global scaling information.
> Add IIO backend support to SD modulator to allow scaling information
> management.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
I've applied this fixup given changes in the backend code that crossed
with this.

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 06f9c5cacd53..654b6a38b650 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -74,6 +74,11 @@ static const struct iio_backend_ops sd_backend_ops = {
        .read_raw = iio_sd_mod_read,
 };
 
+static const struct iio_backend_info sd_backend_info = {
+       .name = "sd-modulator",
+       .ops = &sd_backend_ops,
+};
+
 static int iio_sd_mod_register(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
@@ -131,7 +136,7 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
                priv->vref_mv = ret / 1000;
        }
 
-       return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
+       return devm_iio_backend_register(&pdev->dev, &sd_backend_info, priv);
 };

Please give it a quick spin. Hopefully I didn't break anything.

Jonathan

> ---
>  drivers/iio/adc/Kconfig            |  1 +
>  drivers/iio/adc/sd_adc_modulator.c | 92 +++++++++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index bd028d59db63..43ff8182b2ea 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1195,6 +1195,7 @@ config SD_ADC_MODULATOR
>  	tristate "Generic sigma delta modulator"
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IIO_BACKEND
>  	help
>  	  Select this option to enables sigma delta modulator. This driver can
>  	  support generic sigma delta modulators.
> diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
> index 327cc2097f6c..06f9c5cacd53 100644
> --- a/drivers/iio/adc/sd_adc_modulator.c
> +++ b/drivers/iio/adc/sd_adc_modulator.c
> @@ -6,11 +6,14 @@
>   * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>   */
>  
> +#include <linux/iio/backend.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  
>  static const struct iio_info iio_sd_mod_iio_info;
>  
> @@ -24,7 +27,54 @@ static const struct iio_chan_spec iio_sd_mod_ch = {
>  	},
>  };
>  
> -static int iio_sd_mod_probe(struct platform_device *pdev)
> +struct iio_sd_backend_priv {
> +	struct regulator *vref;
> +	int vref_mv;
> +};
> +
> +static int iio_sd_mod_enable(struct iio_backend *backend)
> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	if (priv->vref)diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 06f9c5cacd53..654b6a38b650 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -74,6 +74,11 @@ static const struct iio_backend_ops sd_backend_ops = {
        .read_raw = iio_sd_mod_read,
 };
 
+static const struct iio_backend_info sd_backend_info = {
+       .name = "sd-modulator",
+       .ops = &sd_backend_ops,
+};
+
 static int iio_sd_mod_register(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
@@ -131,7 +136,7 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
                priv->vref_mv = ret / 1000;
        }
 
-       return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
+       return devm_iio_backend_register(&pdev->dev, &sd_backend_info, priv);
 };
> +		return regulator_enable(priv->vref);
> +
> +	return 0;
> +};
> +
> +static void iio_sd_mod_disable(struct iio_backend *backend)
> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	if (priv->vref)
> +		regulator_disable(priv->vref);
> +};
> +
> +static int iio_sd_mod_read(struct iio_backend *backend, struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = priv->vref_mv;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EOPNOTSUPP;
> +};
> +
> +static const struct iio_backend_ops sd_backend_ops = {
> +	.enable = iio_sd_mod_enable,
> +	.disable = iio_sd_mod_disable,
> +	.read_raw = iio_sd_mod_read,
> +};
> +
> +static int iio_sd_mod_register(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iio_dev *iio;
> @@ -45,6 +95,45 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(&pdev->dev, iio);
>  }
>  
> +static int iio_sd_mod_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regulator *vref;
> +	struct iio_sd_backend_priv *priv;
> +	int ret;
> +
> +	/* If sd modulator is not defined as an IIO backend device, fallback to legacy */
> +	if (!device_property_present(dev, "#io-backend-cells"))
> +		return iio_sd_mod_register(pdev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Get regulator reference if any, but don't enable regulator right now.
> +	 * Rely on enable and disable callbacks to manage regulator power.
> +	 */
> +	vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(vref)) {
> +		if (PTR_ERR(vref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
> +	} else {
> +		/*
> +		 * Retrieve voltage right now, as regulator_get_voltage() provides it whatever
> +		 * the state of the regulator.
> +		 */
> +		ret = regulator_get_voltage(vref);
> +		if (ret < 0)
> +			return ret;
> +
> +		priv->vref = vref;
> +		priv->vref_mv = ret / 1000;
> +	}
> +
> +	return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
> +};
> +
>  static const struct of_device_id sd_adc_of_match[] = {
>  	{ .compatible = "sd-modulator" },
>  	{ .compatible = "ads1201" },
> @@ -65,3 +154,4 @@ module_platform_driver(iio_sd_mod_adc);
>  MODULE_DESCRIPTION("Basic sigma delta modulator");
>  MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_BACKEND);



Return-Path: <linux-iio+bounces-10415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1D999160
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2593F1F2513A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059471EBA1F;
	Thu, 10 Oct 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quwx2Hhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E91CFEB1
	for <linux-iio@vger.kernel.org>; Thu, 10 Oct 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585149; cv=none; b=fji2Kvx8VY715oBgszVbfRolbs+XWMzK97/n7SUnJiNpkkBlju2zLIrrL6d3667HGFyn7GYpKtii9cnhgRgBU27Q58ra8PEM4shYXSeoTpc/NpMk7ywAEVdc/LRFlylIEfDA0e6G+cEaahqWWpDxOXcghDj0j2dyLk3h0pWBpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585149; c=relaxed/simple;
	bh=kv4lFHCiw4MMHXp/ZxXttWKzv6qi4bVXfq4S2UcA3gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT61jR9sRd61f3arHFsdNEefg+PDtR5t6t6ENPDMYDXl+3f3mfr3lN22jB3Yny0bNA6eo+12kNt8pBC0oII+5B4+y+Dasa4uQU30F/D3WK/1yWWkSbS/8Z2SwLZCa8uivK41sWdkZaBXuuN9YN3p2EJ2fPRJBLf7U3ezs6neXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quwx2Hhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0C5C4CEC5;
	Thu, 10 Oct 2024 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728585149;
	bh=kv4lFHCiw4MMHXp/ZxXttWKzv6qi4bVXfq4S2UcA3gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quwx2HhuFWz62xlR4UQl6NMotOAfuFkjOMmvg4MLsSAJDdMNDkFc21bWFMxn2rAdS
	 Li0OvV0iikl+2qvBQNRHrXJxqgoSefHPp3lpmZcx3/YZvepKci+EYXPCxXfkY7T8v/
	 WbEY7qHgYYNDjizaudYHrLFodvJicqVxmqtD7XVUp8YkfdbTzkickTSEN3BMJ2c4Bt
	 7Wpjl80kQQCl710a9PD6wTJ+GjUjvy8aT6Sr0Tzv9V+ipxDkYrkXz5xlzLJSAxmnR/
	 dId17UOuFX95nqaIy5gVrGkPOf/yje/MIhimn30CwMPMGW+cCrLYLD72ZZIUI6o9Yg
	 PoM+NiozWK+Ng==
Date: Thu, 10 Oct 2024 19:32:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Switch back to struct platform_driver::remove()
Message-ID: <20241010193224.29837b71@jic23-huawei>
In-Reply-To: <20241009060056.502059-2-u.kleine-koenig@baylibre.com>
References: <20241009060056.502059-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  9 Oct 2024 08:00:57 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>=20
> Convert all platform drivers below drivers/iio/ to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>=20
> While touching these files, make indention of the struct initializer
> consistent in several files.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to take a poke at it.

Thanks,

Jonathan

> ---
> Hello,
>=20
> given the simplicity of the individual changes I do this all in a single
> patch. I you don't agree, please tell and I will happily split it.
>=20
> It's based on yesterdays's next, feel free to drop changes that result
> in a conflict when you come around to apply this. I'll care for the
> fallout at a later time then. (Having said that, if you use b4 am -3 and
> git am -3, there should be hardly any conflict.)
>=20
> Note I didn't Cc: all the individual driver maintainers to not trigger
> sending limits and spam filters.
>=20
> Best regards
> Uwe
>=20
>  drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
>  drivers/iio/adc/ab8500-gpadc.c                       | 2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c                   | 2 +-
>  drivers/iio/adc/at91_adc.c                           | 2 +-
>  drivers/iio/adc/axp20x_adc.c                         | 2 +-
>  drivers/iio/adc/bcm_iproc_adc.c                      | 8 ++++----
>  drivers/iio/adc/dln2-adc.c                           | 2 +-
>  drivers/iio/adc/ep93xx_adc.c                         | 2 +-
>  drivers/iio/adc/exynos_adc.c                         | 2 +-
>  drivers/iio/adc/imx8qxp-adc.c                        | 2 +-
>  drivers/iio/adc/imx93_adc.c                          | 2 +-
>  drivers/iio/adc/meson_saradc.c                       | 2 +-
>  drivers/iio/adc/mp2629_adc.c                         | 2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                      | 6 +++---
>  drivers/iio/adc/npcm_adc.c                           | 2 +-
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c                  | 2 +-
>  drivers/iio/adc/rcar-gyroadc.c                       | 2 +-
>  drivers/iio/adc/stm32-adc-core.c                     | 2 +-
>  drivers/iio/adc/stm32-adc.c                          | 2 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c                    | 2 +-
>  drivers/iio/adc/stm32-dfsdm-core.c                   | 2 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                    | 2 +-
>  drivers/iio/adc/ti_am335x_adc.c                      | 8 ++++----
>  drivers/iio/adc/twl4030-madc.c                       | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c                      | 2 +-
>  drivers/iio/adc/vf610_adc.c                          | 2 +-
>  drivers/iio/dac/dpot-dac.c                           | 2 +-
>  drivers/iio/dac/lpc18xx_dac.c                        | 6 +++---
>  drivers/iio/dac/stm32-dac-core.c                     | 2 +-
>  drivers/iio/dac/stm32-dac.c                          | 2 +-
>  drivers/iio/dac/vf610_dac.c                          | 2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
>  drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
>  drivers/iio/light/cm3605.c                           | 2 +-
>  drivers/iio/light/hid-sensor-als.c                   | 2 +-
>  drivers/iio/light/hid-sensor-prox.c                  | 2 +-
>  drivers/iio/light/lm3533-als.c                       | 2 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 2 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c        | 2 +-
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
>  drivers/iio/pressure/hid-sensor-press.c              | 2 +-
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c       | 2 +-
>  drivers/iio/proximity/srf04.c                        | 2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
>  drivers/iio/trigger/iio-trig-interrupt.c             | 2 +-
>  drivers/iio/trigger/stm32-timer-trigger.c            | 2 +-
>  47 files changed, 57 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2d5fa3a5d3be..26b1033799fe 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -451,7 +451,7 @@ static struct platform_driver hid_accel_3d_platform_d=
river =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_accel_3d_probe,
> -	.remove_new	=3D hid_accel_3d_remove,
> +	.remove		=3D hid_accel_3d_remove,
>  };
>  module_platform_driver(hid_accel_3d_platform_driver);
> =20
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpad=
c.c
> index 59f66e9cb0e8..f3b057f92310 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -1194,7 +1194,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_pm_op=
s,
> =20
>  static struct platform_driver ab8500_gpadc_driver =3D {
>  	.probe =3D ab8500_gpadc_probe,
> -	.remove_new =3D ab8500_gpadc_remove,
> +	.remove =3D ab8500_gpadc_remove,
>  	.driver =3D {
>  		.name =3D "ab8500-gpadc",
>  		.pm =3D pm_ptr(&ab8500_gpadc_pm_ops),
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sa=
ma5d2_adc.c
> index d7fd21e7c6e2..8e5aaf15a921 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2625,7 +2625,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
> =20
>  static struct platform_driver at91_adc_driver =3D {
>  	.probe =3D at91_adc_probe,
> -	.remove_new =3D at91_adc_remove,
> +	.remove =3D at91_adc_remove,
>  	.driver =3D {
>  		.name =3D "at91-sama5d2_adc",
>  		.of_match_table =3D at91_adc_dt_match,
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 9c39acff17e6..a3f0a2321666 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1341,7 +1341,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
> =20
>  static struct platform_driver at91_adc_driver =3D {
>  	.probe =3D at91_adc_probe,
> -	.remove_new =3D at91_adc_remove,
> +	.remove =3D at91_adc_remove,
>  	.driver =3D {
>  		   .name =3D DRIVER_NAME,
>  		   .of_match_table =3D at91_adc_dt_ids,
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 7f052af56afa..9fd7027623d0 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -1182,7 +1182,7 @@ static struct platform_driver axp20x_adc_driver =3D=
 {
>  	},
>  	.id_table =3D axp20x_adc_id_match,
>  	.probe =3D axp20x_probe,
> -	.remove_new =3D axp20x_remove,
> +	.remove =3D axp20x_remove,
>  };
> =20
>  module_platform_driver(axp20x_adc_driver);
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_=
adc.c
> index cdfe304eaa20..f258668b0dc7 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -611,10 +611,10 @@ static const struct of_device_id iproc_adc_of_match=
[] =3D {
>  MODULE_DEVICE_TABLE(of, iproc_adc_of_match);
> =20
>  static struct platform_driver iproc_adc_driver =3D {
> -	.probe  =3D iproc_adc_probe,
> -	.remove_new =3D iproc_adc_remove,
> -	.driver	=3D {
> -		.name	=3D "iproc-static-adc",
> +	.probe =3D iproc_adc_probe,
> +	.remove =3D iproc_adc_remove,
> +	.driver =3D {
> +		.name =3D "iproc-static-adc",
>  		.of_match_table =3D iproc_adc_of_match,
>  	},
>  };
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index de7252a10047..30328626d9be 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -700,7 +700,7 @@ static void dln2_adc_remove(struct platform_device *p=
dev)
>  static struct platform_driver dln2_adc_driver =3D {
>  	.driver.name	=3D DLN2_ADC_MOD_NAME,
>  	.probe		=3D dln2_adc_probe,
> -	.remove_new	=3D dln2_adc_remove,
> +	.remove		=3D dln2_adc_remove,
>  };
> =20
>  module_platform_driver(dln2_adc_driver);
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index cc38d5e0608e..a3e9c697e2cb 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -238,7 +238,7 @@ static struct platform_driver ep93xx_adc_driver =3D {
>  		.of_match_table =3D ep93xx_adc_of_ids,
>  	},
>  	.probe =3D ep93xx_adc_probe,
> -	.remove_new =3D ep93xx_adc_remove,
> +	.remove =3D ep93xx_adc_remove,
>  };
>  module_platform_driver(ep93xx_adc_driver);
> =20
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 4d00ee8dd14d..4614cf848535 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -1008,7 +1008,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops, =
exynos_adc_suspend,
> =20
>  static struct platform_driver exynos_adc_driver =3D {
>  	.probe		=3D exynos_adc_probe,
> -	.remove_new	=3D exynos_adc_remove,
> +	.remove		=3D exynos_adc_remove,
>  	.driver		=3D {
>  		.name	=3D "exynos-adc",
>  		.of_match_table =3D exynos_adc_match,
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> index fe82198170d5..3d19d7d744aa 100644
> --- a/drivers/iio/adc/imx8qxp-adc.c
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -487,7 +487,7 @@ MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
> =20
>  static struct platform_driver imx8qxp_adc_driver =3D {
>  	.probe		=3D imx8qxp_adc_probe,
> -	.remove_new	=3D imx8qxp_adc_remove,
> +	.remove		=3D imx8qxp_adc_remove,
>  	.driver		=3D {
>  		.name	=3D ADC_DRIVER_NAME,
>  		.of_match_table =3D imx8qxp_adc_match,
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 4ccf4819f1f1..002eb19587d6 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -470,7 +470,7 @@ MODULE_DEVICE_TABLE(of, imx93_adc_match);
> =20
>  static struct platform_driver imx93_adc_driver =3D {
>  	.probe		=3D imx93_adc_probe,
> -	.remove_new	=3D imx93_adc_remove,
> +	.remove		=3D imx93_adc_remove,
>  	.driver		=3D {
>  		.name	=3D IMX93_ADC_DRIVER_NAME,
>  		.of_match_table =3D imx93_adc_match,
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_sarad=
c.c
> index e16b0e28974e..2d475b43e717 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1483,7 +1483,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_op=
s,
> =20
>  static struct platform_driver meson_sar_adc_driver =3D {
>  	.probe		=3D meson_sar_adc_probe,
> -	.remove_new	=3D meson_sar_adc_remove,
> +	.remove		=3D meson_sar_adc_remove,
>  	.driver		=3D {
>  		.name	=3D "meson-saradc",
>  		.of_match_table =3D meson_sar_adc_of_match,
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index 921d3e193752..1cb043b17437 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -195,7 +195,7 @@ static struct platform_driver mp2629_adc_driver =3D {
>  		.of_match_table =3D mp2629_adc_of_match,
>  	},
>  	.probe		=3D mp2629_adc_probe,
> -	.remove_new	=3D mp2629_adc_remove,
> +	.remove		=3D mp2629_adc_remove,
>  };
>  module_platform_driver(mp2629_adc_driver);
> =20
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-=
adc.c
> index 8c7b64e78dbb..152cbe265e1a 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -819,10 +819,10 @@ static void mxs_lradc_adc_remove(struct platform_de=
vice *pdev)
> =20
>  static struct platform_driver mxs_lradc_adc_driver =3D {
>  	.driver =3D {
> -		.name	=3D "mxs-lradc-adc",
> +		.name =3D "mxs-lradc-adc",
>  	},
> -	.probe	=3D mxs_lradc_adc_probe,
> -	.remove_new =3D mxs_lradc_adc_remove,
> +	.probe =3D mxs_lradc_adc_probe,
> +	.remove =3D mxs_lradc_adc_remove,
>  };
>  module_platform_driver(mxs_lradc_adc_driver);
> =20
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index 3a55465951e7..7c1511ee3a4b 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -337,7 +337,7 @@ static void npcm_adc_remove(struct platform_device *p=
dev)
> =20
>  static struct platform_driver npcm_adc_driver =3D {
>  	.probe		=3D npcm_adc_probe,
> -	.remove_new	=3D npcm_adc_remove,
> +	.remove		=3D npcm_adc_remove,
>  	.driver		=3D {
>  		.name	=3D "npcm_adc",
>  		.of_match_table =3D npcm_adc_match,
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-p=
m8xxx-xoadc.c
> index 9e1112f5acc6..debf742baf07 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -1016,7 +1016,7 @@ static struct platform_driver pm8xxx_xoadc_driver =
=3D {
>  		.of_match_table =3D pm8xxx_xoadc_id_table,
>  	},
>  	.probe		=3D pm8xxx_xoadc_probe,
> -	.remove_new	=3D pm8xxx_xoadc_remove,
> +	.remove		=3D pm8xxx_xoadc_remove,
>  };
>  module_platform_driver(pm8xxx_xoadc_driver);
> =20
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroad=
c.c
> index 15a21d2860e7..11170b5852d1 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -592,7 +592,7 @@ static const struct dev_pm_ops rcar_gyroadc_pm_ops =
=3D {
> =20
>  static struct platform_driver rcar_gyroadc_driver =3D {
>  	.probe          =3D rcar_gyroadc_probe,
> -	.remove_new     =3D rcar_gyroadc_remove,
> +	.remove         =3D rcar_gyroadc_remove,
>  	.driver         =3D {
>  		.name		=3D DRIVER_NAME,
>  		.of_match_table	=3D rcar_gyroadc_match,
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc=
-core.c
> index 616dd729666a..2201ee9987ae 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -906,7 +906,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
> =20
>  static struct platform_driver stm32_adc_driver =3D {
>  	.probe =3D stm32_adc_probe,
> -	.remove_new =3D stm32_adc_remove,
> +	.remove =3D stm32_adc_remove,
>  	.driver =3D {
>  		.name =3D "stm32-adc-core",
>  		.of_match_table =3D stm32_adc_of_match,
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 32ca26ed59f7..9d3b23efcc06 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2644,7 +2644,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
> =20
>  static struct platform_driver stm32_adc_driver =3D {
>  	.probe =3D stm32_adc_probe,
> -	.remove_new =3D stm32_adc_remove,
> +	.remove =3D stm32_adc_remove,
>  	.driver =3D {
>  		.name =3D "stm32-adc",
>  		.of_match_table =3D stm32_adc_of_match,
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-df=
sdm-adc.c
> index 2037f73426d4..c2d4f5339cd4 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1890,7 +1890,7 @@ static struct platform_driver stm32_dfsdm_adc_drive=
r =3D {
>  		.pm =3D pm_sleep_ptr(&stm32_dfsdm_adc_pm_ops),
>  	},
>  	.probe =3D stm32_dfsdm_adc_probe,
> -	.remove_new =3D stm32_dfsdm_adc_remove,
> +	.remove =3D stm32_dfsdm_adc_remove,
>  };
>  module_platform_driver(stm32_dfsdm_adc_driver);
> =20
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-d=
fsdm-core.c
> index bef59fcc0d80..041dc9ebc048 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -506,7 +506,7 @@ static const struct dev_pm_ops stm32_dfsdm_core_pm_op=
s =3D {
> =20
>  static struct platform_driver stm32_dfsdm_driver =3D {
>  	.probe =3D stm32_dfsdm_probe,
> -	.remove_new =3D stm32_dfsdm_core_remove,
> +	.remove =3D stm32_dfsdm_core_remove,
>  	.driver =3D {
>  		.name =3D "stm32-dfsdm",
>  		.of_match_table =3D stm32_dfsdm_of_match,
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 00a3a4db0fe0..8b27458dcd66 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -697,7 +697,7 @@ static struct platform_driver sun4i_gpadc_driver =3D {
>  	},
>  	.id_table =3D sun4i_gpadc_id,
>  	.probe =3D sun4i_gpadc_probe,
> -	.remove_new =3D sun4i_gpadc_remove,
> +	.remove =3D sun4i_gpadc_remove,
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_id);
> =20
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_=
adc.c
> index 426e3c9f88a1..95036efb8320 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -740,12 +740,12 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
> =20
>  static struct platform_driver tiadc_driver =3D {
>  	.driver =3D {
> -		.name   =3D "TI-am335x-adc",
> -		.pm	=3D pm_sleep_ptr(&tiadc_pm_ops),
> +		.name =3D "TI-am335x-adc",
> +		.pm =3D pm_sleep_ptr(&tiadc_pm_ops),
>  		.of_match_table =3D ti_adc_dt_ids,
>  	},
> -	.probe	=3D tiadc_probe,
> -	.remove_new =3D tiadc_remove,
> +	.probe =3D tiadc_probe,
> +	.remove =3D tiadc_remove,
>  };
>  module_platform_driver(tiadc_driver);
> =20
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-mad=
c.c
> index 0253064fadec..072e12b29776 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -914,7 +914,7 @@ MODULE_DEVICE_TABLE(of, twl_madc_of_match);
> =20
>  static struct platform_driver twl4030_madc_driver =3D {
>  	.probe =3D twl4030_madc_probe,
> -	.remove_new =3D twl4030_madc_remove,
> +	.remove =3D twl4030_madc_remove,
>  	.driver =3D {
>  		   .name =3D "twl4030_madc",
>  		   .of_match_table =3D twl_madc_of_match,
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gp=
adc.c
> index 6a3db2bce460..ef7430e6877d 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -1003,7 +1003,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_op=
s, twl6030_gpadc_suspend,
> =20
>  static struct platform_driver twl6030_gpadc_driver =3D {
>  	.probe		=3D twl6030_gpadc_probe,
> -	.remove_new	=3D twl6030_gpadc_remove,
> +	.remove		=3D twl6030_gpadc_remove,
>  	.driver		=3D {
>  		.name	=3D DRIVER_NAME,
>  		.pm	=3D pm_sleep_ptr(&twl6030_gpadc_pm_ops),
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 5afd2feb8c3d..4d83c12975c5 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -972,7 +972,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf6=
10_adc_suspend,
> =20
>  static struct platform_driver vf610_adc_driver =3D {
>  	.probe          =3D vf610_adc_probe,
> -	.remove_new     =3D vf610_adc_remove,
> +	.remove         =3D vf610_adc_remove,
>  	.driver         =3D {
>  		.name   =3D DRIVER_NAME,
>  		.of_match_table =3D vf610_adc_match,
> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
> index 7332064d0852..f36f10bfb6be 100644
> --- a/drivers/iio/dac/dpot-dac.c
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -243,7 +243,7 @@ MODULE_DEVICE_TABLE(of, dpot_dac_match);
> =20
>  static struct platform_driver dpot_dac_driver =3D {
>  	.probe =3D dpot_dac_probe,
> -	.remove_new =3D dpot_dac_remove,
> +	.remove =3D dpot_dac_remove,
>  	.driver =3D {
>  		.name =3D "iio-dpot-dac",
>  		.of_match_table =3D dpot_dac_match,
> diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
> index b3aa4443a6a4..2332b0c22691 100644
> --- a/drivers/iio/dac/lpc18xx_dac.c
> +++ b/drivers/iio/dac/lpc18xx_dac.c
> @@ -184,9 +184,9 @@ static const struct of_device_id lpc18xx_dac_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, lpc18xx_dac_match);
> =20
>  static struct platform_driver lpc18xx_dac_driver =3D {
> -	.probe	=3D lpc18xx_dac_probe,
> -	.remove_new =3D lpc18xx_dac_remove,
> -	.driver	=3D {
> +	.probe =3D lpc18xx_dac_probe,
> +	.remove =3D lpc18xx_dac_remove,
> +	.driver =3D {
>  		.name =3D "lpc18xx-dac",
>  		.of_match_table =3D lpc18xx_dac_match,
>  	},
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac=
-core.c
> index 2d567073996b..95ed5197d16f 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -245,7 +245,7 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
> =20
>  static struct platform_driver stm32_dac_driver =3D {
>  	.probe =3D stm32_dac_probe,
> -	.remove_new =3D stm32_dac_remove,
> +	.remove =3D stm32_dac_remove,
>  	.driver =3D {
>  		.name =3D "stm32-dac-core",
>  		.of_match_table =3D stm32_dac_of_match,
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 5a722f307e7e..3bfb368b3a23 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -398,7 +398,7 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
> =20
>  static struct platform_driver stm32_dac_driver =3D {
>  	.probe =3D stm32_dac_probe,
> -	.remove_new =3D stm32_dac_remove,
> +	.remove =3D stm32_dac_remove,
>  	.driver =3D {
>  		.name =3D "stm32-dac",
>  		.of_match_table =3D stm32_dac_of_match,
> diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
> index de73bc5a1c93..82a078fa98ad 100644
> --- a/drivers/iio/dac/vf610_dac.c
> +++ b/drivers/iio/dac/vf610_dac.c
> @@ -272,7 +272,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf6=
10_dac_suspend,
> =20
>  static struct platform_driver vf610_dac_driver =3D {
>  	.probe          =3D vf610_dac_probe,
> -	.remove_new     =3D vf610_dac_remove,
> +	.remove         =3D vf610_dac_remove,
>  	.driver         =3D {
>  		.name   =3D "vf610-dac",
>  		.of_match_table =3D vf610_dac_match,
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index f9c6b2e732b7..0598f1d3fbb3 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -386,7 +386,7 @@ static struct platform_driver hid_gyro_3d_platform_dr=
iver =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_gyro_3d_probe,
> -	.remove_new	=3D hid_gyro_3d_remove,
> +	.remove		=3D hid_gyro_3d_remove,
>  };
>  module_platform_driver(hid_gyro_3d_platform_driver);
> =20
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index eb1c022f73c8..f2fa0e1631ff 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -287,7 +287,7 @@ static struct platform_driver hid_humidity_platform_d=
river =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_humidity_probe,
> -	.remove_new	=3D hid_humidity_remove,
> +	.remove		=3D hid_humidity_remove,
>  };
>  module_platform_driver(hid_humidity_platform_driver);
> =20
> diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> index 22a63a89f289..675c0fd44db4 100644
> --- a/drivers/iio/light/cm3605.c
> +++ b/drivers/iio/light/cm3605.c
> @@ -318,7 +318,7 @@ static struct platform_driver cm3605_driver =3D {
>  		.pm =3D pm_sleep_ptr(&cm3605_dev_pm_ops),
>  	},
>  	.probe =3D cm3605_probe,
> -	.remove_new =3D cm3605_remove,
> +	.remove =3D cm3605_remove,
>  };
>  module_platform_driver(cm3605_driver);
> =20
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 30332bf96d28..4eb692322432 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -467,7 +467,7 @@ static struct platform_driver hid_als_platform_driver=
 =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_als_probe,
> -	.remove_new	=3D hid_als_remove,
> +	.remove		=3D hid_als_remove,
>  };
>  module_platform_driver(hid_als_platform_driver);
> =20
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index 5343ebd404bf..8fe50f897169 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -344,7 +344,7 @@ static struct platform_driver hid_prox_platform_drive=
r =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_prox_probe,
> -	.remove_new	=3D hid_prox_remove,
> +	.remove		=3D hid_prox_remove,
>  };
>  module_platform_driver(hid_prox_platform_driver);
> =20
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-al=
s.c
> index 6429d951ce7f..99f0b903018c 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -912,7 +912,7 @@ static struct platform_driver lm3533_als_driver =3D {
>  		.name	=3D "lm3533-als",
>  	},
>  	.probe		=3D lm3533_als_probe,
> -	.remove_new	=3D lm3533_als_remove,
> +	.remove		=3D lm3533_als_remove,
>  };
>  module_platform_driver(lm3533_als_driver);
> =20
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> index ae10db87d1e1..1d6fcbbae1c5 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -574,7 +574,7 @@ static struct platform_driver hid_magn_3d_platform_dr=
iver =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_magn_3d_probe,
> -	.remove_new	=3D hid_magn_3d_remove,
> +	.remove		=3D hid_magn_3d_remove,
>  };
>  module_platform_driver(hid_magn_3d_platform_driver);
> =20
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/o=
rientation/hid-sensor-incl-3d.c
> index 5a0d990018aa..c74b92d53d4d 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -410,7 +410,7 @@ static struct platform_driver hid_incl_3d_platform_dr=
iver =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_incl_3d_probe,
> -	.remove_new	=3D hid_incl_3d_remove,
> +	.remove		=3D hid_incl_3d_remove,
>  };
>  module_platform_driver(hid_incl_3d_platform_driver);
> =20
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> index 414d840afb42..343be43163e4 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -362,7 +362,7 @@ static struct platform_driver hid_dev_rot_platform_dr=
iver =3D {
>  		.pm     =3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_dev_rot_probe,
> -	.remove_new	=3D hid_dev_rot_remove,
> +	.remove		=3D hid_dev_rot_remove,
>  };
>  module_platform_driver(hid_dev_rot_platform_driver);
> =20
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drive=
rs/iio/position/hid-sensor-custom-intel-hinge.c
> index 033a82781fdb..3a6c7e50cc70 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -369,7 +369,7 @@ static struct platform_driver hid_hinge_platform_driv=
er =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_hinge_probe,
> -	.remove_new	=3D hid_hinge_remove,
> +	.remove		=3D hid_hinge_remove,
>  };
>  module_platform_driver(hid_hinge_platform_driver);
> =20
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index a906da4f9546..dfc36430c467 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -350,7 +350,7 @@ static struct platform_driver hid_press_platform_driv=
er =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_press_probe,
> -	.remove_new	=3D hid_press_remove,
> +	.remove		=3D hid_press_remove,
>  };
>  module_platform_driver(hid_press_platform_driver);
> =20
> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio=
/proximity/cros_ec_mkbp_proximity.c
> index c25472b14d4b..b1a4a923e788 100644
> --- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -261,7 +261,7 @@ static struct platform_driver cros_ec_mkbp_proximity_=
driver =3D {
>  		.pm =3D pm_sleep_ptr(&cros_ec_mkbp_proximity_pm_ops),
>  	},
>  	.probe =3D cros_ec_mkbp_proximity_probe,
> -	.remove_new =3D cros_ec_mkbp_proximity_remove,
> +	.remove =3D cros_ec_mkbp_proximity_remove,
>  };
>  module_platform_driver(cros_ec_mkbp_proximity_driver);
> =20
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 86c57672fc7e..71ad29e441b2 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -389,7 +389,7 @@ static const struct dev_pm_ops srf04_pm_ops =3D {
> =20
>  static struct platform_driver srf04_driver =3D {
>  	.probe		=3D srf04_probe,
> -	.remove_new	=3D srf04_remove,
> +	.remove		=3D srf04_remove,
>  	.driver		=3D {
>  		.name		=3D "srf04-gpio",
>  		.of_match_table	=3D of_srf04_match,
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index d2209cd5b98c..0e21217472ab 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -283,7 +283,7 @@ static struct platform_driver hid_temperature_platfor=
m_driver =3D {
>  		.pm	=3D &hid_sensor_pm_ops,
>  	},
>  	.probe		=3D hid_temperature_probe,
> -	.remove_new	=3D hid_temperature_remove,
> +	.remove		=3D hid_temperature_remove,
>  };
>  module_platform_driver(hid_temperature_platform_driver);
> =20
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigg=
er/iio-trig-interrupt.c
> index dec256bfbd73..21c6b6292a72 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -96,7 +96,7 @@ static void iio_interrupt_trigger_remove(struct platfor=
m_device *pdev)
> =20
>  static struct platform_driver iio_interrupt_trigger_driver =3D {
>  	.probe =3D iio_interrupt_trigger_probe,
> -	.remove_new =3D iio_interrupt_trigger_remove,
> +	.remove =3D iio_interrupt_trigger_remove,
>  	.driver =3D {
>  		.name =3D "iio_interrupt_trigger",
>  	},
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trig=
ger/stm32-timer-trigger.c
> index 0684329956d9..bb60b2d7b2ec 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -900,7 +900,7 @@ MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
> =20
>  static struct platform_driver stm32_timer_trigger_driver =3D {
>  	.probe =3D stm32_timer_trigger_probe,
> -	.remove_new =3D stm32_timer_trigger_remove,
> +	.remove =3D stm32_timer_trigger_remove,
>  	.driver =3D {
>  		.name =3D "stm32-timer-trigger",
>  		.of_match_table =3D stm32_trig_of_match,
>=20
> base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1



Return-Path: <linux-iio+bounces-21343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A4BAF8E26
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 11:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B55A58134E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5502F2C41;
	Fri,  4 Jul 2025 09:09:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD562F272E;
	Fri,  4 Jul 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620161; cv=none; b=QRqJJxM825qiz0mYXV23ROPkHASR9ZU4Hgz4ze5AEh5XNQMKHRCSUemaVnqvLp7jmKVk56YY+IFfA4amqxeS2xnqJ5nx1OIcztQ0mu/351ShTS57oT3ofu1rrzIPEjEqoeWq5nylGmgsN3jjZklBX9CutYPhyDslH3eyHW0yjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620161; c=relaxed/simple;
	bh=munUDtgCHhnGuDcxIuSFnsFhUCfzFZ32SGb9JULuB9I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIn95vL02B48x2CeEk8cRzLCSwfJc9UKkPwmTq5D/GHr+HB8KT8Kcv+UqWTvHOTNs13X4YJz84R7Y0bnncIFbTX0b7ERcQHrfYdkdAiH6B6tl7USehY5/PosgkJALNVUXtJJugS4gAyQ/BSaPM93xY9YWZEOIVFX5S/mIZrOeY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYSRb2XN3z6L5HM;
	Fri,  4 Jul 2025 17:06:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C9103140393;
	Fri,  4 Jul 2025 17:09:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:09:16 +0200
Date: Fri, 4 Jul 2025 10:09:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Cai Huoqing <cai.huoqing@linux.dev>, Haibo Chen <haibo.chen@nxp.com>, "Shawn
 Guo" <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Francesco Dolcini
	<francesco@dolcini.it>, =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, "Rob Herring (Arm)" <robh@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, "Mike
 Looijmans" <mike.looijmans@topic.nl>, Olivier Moysan
	<olivier.moysan@foss.st.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Julien Stephan <jstephan@baylibre.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-renesas-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 28/80] iio: adc: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250704100914.000042db@huawei.com>
In-Reply-To: <20250704075420.3219092-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075420.3219092-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  4 Jul 2025 10:54:19 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> 
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                 pm-runtime-6.17-rc1
> 
>  drivers/iio/adc/ab8500-gpadc.c     |  1 -
>  drivers/iio/adc/at91-sama5d2_adc.c | 10 ----------
>  drivers/iio/adc/imx8qxp-adc.c      |  2 --
>  drivers/iio/adc/imx93_adc.c        |  1 -
>  drivers/iio/adc/rcar-gyroadc.c     |  1 -
>  drivers/iio/adc/rzg2l_adc.c        |  3 ---
>  drivers/iio/adc/stm32-adc-core.c   |  1 -
>  drivers/iio/adc/stm32-adc.c        |  7 -------
>  drivers/iio/adc/sun4i-gpadc-iio.c  |  2 --
>  drivers/iio/adc/ti-ads1015.c       |  1 -
>  drivers/iio/adc/ti-ads1100.c       |  1 -
>  drivers/iio/adc/ti-ads1119.c       |  2 --
>  12 files changed, 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index f3b057f92310..8eaa1dd6a89b 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -607,7 +607,6 @@ static int ab8500_gpadc_read(struct ab8500_gpadc *gpadc,
>  	}
>  
>  	/* This eventually drops the regulator */
> -	pm_runtime_mark_last_busy(gpadc->dev);
>  	pm_runtime_put_autosuspend(gpadc->dev);
>  
>  	return (high_data << 8) | low_data;
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index c3450246730e..67846fefe21a 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -896,7 +896,6 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
>  	emr |= osr | AT91_SAMA5D2_TRACKX(trackx);
>  	at91_adc_writel(st, EMR, emr);
>  
> -	pm_runtime_mark_last_busy(st->dev);
>  	pm_runtime_put_autosuspend(st->dev);
>  
>  	st->oversampling_ratio = oversampling_ratio;
> @@ -971,7 +970,6 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
>  				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
>  		at91_adc_writel(st, TSMR, 0);
>  
> -		pm_runtime_mark_last_busy(st->dev);
>  		pm_runtime_put_autosuspend(st->dev);
>  		return 0;
>  	}
> @@ -1143,7 +1141,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	at91_adc_configure_trigger_registers(st, state);
>  
>  	if (!state) {
> -		pm_runtime_mark_last_busy(st->dev);

Getting familiar. I'll not comment on other cases but {} should go here.

>  		pm_runtime_put_autosuspend(st->dev);
>  	}

Please fix all those up and post a v2 series for IIO.

I'd guess similar are present in other subsystems though so may well
need a v2 as well with the excess brackets dropped.


Jonathan




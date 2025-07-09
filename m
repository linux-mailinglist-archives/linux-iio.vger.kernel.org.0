Return-Path: <linux-iio+bounces-21485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE99AFEDE7
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E8F7AF630
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C622E8E0C;
	Wed,  9 Jul 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYdDGgmo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2452E8DF9;
	Wed,  9 Jul 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075493; cv=none; b=lUaBiNqbD/kMpIWjY7nAHwunvq+/HmAVrjAFbJ7oik+HCj1z1nQnJVigoLfJl7QSzfZLGZmxPzKqL26aGb1eIR/EopDXRxHyQ8fkXHVB3YvPSLtgL0MfTljRmyjA8OjlooJx4Z+G6ucBTTQWfryCxv9rpS8sxiqZGPOGcMTVvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075493; c=relaxed/simple;
	bh=Xl25DKWUzLXWpg5KhyYoRSsxahTDR5DpYlzJd9W9CaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyHtDB+h+A/7RS4zSzAET0uWqAf1JtXMqbJ/JGJly5koUjQh7+gwKxeg6RfVaCGdAeRzxI2hu/8vKG31D5MZZQNh8Z7vl3MRDJCl1Zr2hvbzZGl0THmlDixsMjDYBA8TSlU0CwQBNbFizvhIB158vKq50KUma5rtekxy4HQTE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYdDGgmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C79C4CEEF;
	Wed,  9 Jul 2025 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075492;
	bh=Xl25DKWUzLXWpg5KhyYoRSsxahTDR5DpYlzJd9W9CaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYdDGgmoD68kb2rNpNP/hz5SiwAXDsyvezTzMSDMKDb2YClMAF2yt/AxOjTPs7sNl
	 ZTOE8jKrng1ejwdimLIcfCR+DZXhizhMc2qXzwb7YBRhhYhR+Xnf7h120quqvHtuXQ
	 vwH5eiko3xNTUaDORSLeGHicywXRuFhftgO6XszyBy6kDg/HN0KkQYjiYK9KT3zzls
	 T5Wx4zQYlggDBTLa0AXA3d8QhmsyQveEUAZY1P8m2i8gSq2eYriSLniXhAiyw5Yn+g
	 o8IjE8LQibgIjGnYjnHpSjOCrrGvcXASgZXGde0dgcLjH93VVyf4X6KUiYxOt+Ess8
	 Oo5M4FmCysnGA==
Date: Wed, 9 Jul 2025 16:37:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Cai Huoqing <cai.huoqing@linux.dev>, Haibo Chen <haibo.chen@nxp.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, "Jiri Slaby
 (SUSE)" <jirislaby@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Julien Stephan <jstephan@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 02/12] iio: adc: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709163756.32b0e1d1@jic23-huawei>
In-Reply-To: <20250708231152.971398-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231152.971398-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 02:11:52 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Some comments for the future as more about what can be improved on the back
of this than what you have here.

>
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index cc326f21d398..3a17b3898bf6 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -163,12 +163,10 @@ static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
>  {
>  	struct device *dev = priv->dev;
>  
This is a very clear example of where the *_set_power() pattern is a bad idea.
There are two calls of this function, one with it hard coded as on and one with it
hard coded as off.  We can just push the pm_runtime_resume_and_get()
to the on case etc.

I don't mind that much if we do so as a follow up patch so this one can
be the mechanical change and then we follow up with the enabled simplification.

> -	if (on) {
> +	if (on)
>  		return pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		return pm_runtime_put_autosuspend(dev);
> -	}
> +
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 48549d617e5f..f2a93c63ca14 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -374,12 +374,10 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  	int ret;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> -	if (on) {
> +	if (on)
>  		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(dev);
> -	}
>  
>  	return ret < 0 ? ret : 0;
So this one has a stub version which only brings benefits because
we have checks on the pm_runtime_put_autosuspend() path failing
(which it does if we have !CONFIG_PM).

I think the right option there is check the return value is < 0
for the resume_and_get() and don't check the _put_autosuspend()
return value at all.  Then we can just push this down to the
call sites as all of them hard code the bool value.

>  }



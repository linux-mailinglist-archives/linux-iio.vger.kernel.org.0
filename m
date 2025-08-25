Return-Path: <linux-iio+bounces-23247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EACFB3450D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92921B2083C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122D2FD7C7;
	Mon, 25 Aug 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaOaKmoG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CF230BD9;
	Mon, 25 Aug 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134052; cv=none; b=YnlIgPKHRBYctOyx0BaIWwoToGE6i+mCSAzz4o4T6vikKIHxILADdA0mOA4cSDlVWbrP6Z04YL+++Lfe6WSnjzFOxCYhurVzxllA1WStvx9MDRTTm+QVTDXCjnE6dUqAp7Hq/5yuLkJX9bFA9OZh/SkIziky1qKuJGnD2zaKwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134052; c=relaxed/simple;
	bh=cr6KBROp1M55uUNu32ISj3IWnbsJZPYjC+bGhB9SQOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4CaKtaxAmB8eYr0mSGFXL8+waCsBtcM/OnscYCGNIMfwlbgLaf9WbsXwNSyzlzNr3QkuEsZVhK1Yq5e2WilE2NBd7zt1KAtsgZ9A+n1ibr4c/5KS1T+hwqCbXnVKZsjbQRMreOb5yFh+ZqudMlzuy03AgshmhS8U3iLCRVeaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaOaKmoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DDCC116C6;
	Mon, 25 Aug 2025 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134051;
	bh=cr6KBROp1M55uUNu32ISj3IWnbsJZPYjC+bGhB9SQOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaOaKmoGlIlwlRdIoLyJtkubsH1CewYNTdrqKLHi8ddKVKCkemSeXe47xaQgg004d
	 T3lmlEzwuKUifFLJ5PVs2+7TuPpeAnJQHzDfAbqNGwwaDneln+zYZ+84Adbp6iop94
	 qAbjLfQYS3y2jaaSjgni6VgI4AlthAMuOlOMQv4+lVWBgKHJS4cif7DVs8iI7IPyjB
	 eW2gmu7XTAl1p7046BsX5lOFUR7KVS6GesFnuVLNhIzWcrNNGIWkdas4VxAUPqXuUK
	 6oyvuTPorCS5xBCrjb15JSBPvntgI78pfkGXUgLZ5NiXwoaFgIl3BBzKViqlJjM8fC
	 287YGOTl/mxEg==
Date: Mon, 25 Aug 2025 16:00:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Eugen Hristev <eugen.hristev@linaro.org>,
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
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Rui Miguel
 Silva <rmfrfs@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, Andreas Klinger <ak@it-klinger.de>, Crt
 Mori <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>, Julien
 Stephan <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, Bo Liu <liubo03@inspur.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sean Nyekjaer <sean@geanix.com>, Frank Li
 <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>, Rayyan Ansari
 <rayyan@ansari.sh>, Gustavo Vaz <gustavo.vaz@usp.br>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede
 <hansg@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, chuguangqing
 <chuguangqing@inspur.com>, Shreeya Patel <shreeya.patel@collabora.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, =?UTF-8?B?QmFybmFiw6FzIEN6?=
 =?UTF-8?B?w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, David Laight <david.laight@aculab.com>, Jakob
 Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 05/12] iio: dac: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250825160023.4070bbc1@jic23-huawei>
In-Reply-To: <20250825135401.1765847-6-sakari.ailus@linux.intel.com>
References: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
	<20250825135401.1765847-6-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 16:53:54 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Also clean up error handling in stm32_dac_set_enable_state().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Hi Sakari,

I don't follow this...

> ---
>  drivers/iio/dac/stm32-dac.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 344388338d9b..e8688f9d6df7 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -82,9 +82,9 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
>  	mutex_unlock(&dac->lock);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
> -		goto err_put_pm;
> +		goto err_pm_put;
>  	}
>  
>  	/*
> @@ -95,18 +95,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	if (en && dac->common->hfsel)
>  		udelay(1);
>  
> -	if (!enable) {
> -		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> -	}
> -
> -	return 0;
> -
> -err_put_pm:
> -	if (enable) {
> -		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> -	}
> +err_pm_put:
> +	pm_runtime_put_autosuspend(dev);

now the put is here, whether or not there was ever a get as the get is gated on enable()


>  
>  	return ret;
>  }
> @@ -349,7 +339,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_pm_put;
>  
> -	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;



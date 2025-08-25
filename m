Return-Path: <linux-iio+bounces-23254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12BB34552
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC27AC627
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C382F39A4;
	Mon, 25 Aug 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlcjShzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCA227E82;
	Mon, 25 Aug 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134812; cv=none; b=huTrlUYGRtaYNO2jwCOGnxUxgFQemFkZ2OaZClVUIFtER3os6C159Wor0GJucMggEz4oh8cZKelnAiTLITIFg9EufsYZftmxvT20Se3jyoFH4nrlQzk1/O1AKDTcRJ9M2eWPfhEBwwtAl5i0UyCUGCSPHzs7ppkFXsDeZgWeCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134812; c=relaxed/simple;
	bh=qVVGVCmEX81q9uESMpI7TyxhGRS5UoJ7gvEO8EB+yKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOh8z7JYV97LHLMScfcE3eanNbsNFW6WLWqo0zq1YDs2lNVTAyNF6PxgG0NWjJ1Wna2WWpgfTH0mFOBh4P0PJe33tsXHo+E70Tj3gwbqnB+vnODw/eIATHfJTBHGSRdNy0F+Xh9r9tuPN+Rdfi7mpk7Iefz92bNpIMBR7mN9f1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlcjShzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6642C4CEED;
	Mon, 25 Aug 2025 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134812;
	bh=qVVGVCmEX81q9uESMpI7TyxhGRS5UoJ7gvEO8EB+yKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlcjShzrpC72PpmqNkeR39/m61HIsV3DNjisBUSZiC/W8SqEEV4YFNHCO8Qa8xIuD
	 NiC06ZgFtIH0OE1APL1wBlFbg9bsrDazQlbFXLYKOfSq3YOCS3Hxj8gtAqoTSeAqAk
	 xHy10Uy3I4bcpojyqbaQH+nB/Ye700rvMaz/1ZlTspjO+ohq4z7m56aL23NM7F4Xqi
	 0lMU+z786eKA46L4NwBMDPlm9TaAjm1wxkkXAyRqRioOdLBvbR815CnAaHTxl9rWWJ
	 APuE0BKQqqW0QwTbV/9a4f0QgiUVgpxD5vh5EGyKs9tAWbYEDUwflKsKVyDeRDMPRe
	 ZBOgUeKDLA8kA==
Date: Mon, 25 Aug 2025 16:13:05 +0100
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
Subject: Re: [PATCH v3 08/12] iio: light: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250825161305.611ecb75@jic23-huawei>
In-Reply-To: <20250825135401.1765847-9-sakari.ailus@linux.intel.com>
References: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
	<20250825135401.1765847-9-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 16:53:57 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Hi Sakari,

I'm going to apply this as it stands, but there has been a lot
of cut and paste in these drivers, so a common pattern is to have
a no entirely pointless power(bool enable) function.  
Previously it at least wrapped up 2 calls, now it is doing a choice
between two single line calls so makes no sense.

Anyhow, if anyone wants to clean these up that would be great.
In meantime I'd rather not leave cases of the pm_runtime_mark_last_busy()
around to get pasted into more drivers.

So applied,

Jonathan

> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 0e4284823d44..374bccad9119 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -336,16 +336,11 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
>  static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
>  {
>  	struct device *dev = regmap_get_device(chip->regmap);
As below.

> -	int ret;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  

> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index fc3b0c4226be..8801a491de77 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -641,16 +641,10 @@ static const struct iio_chan_spec tsl2583_channels[] = {
>  
>  static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
>  {

As below.

> -	int ret;
> +	if (on)
> +		return pm_runtime_resume_and_get(&chip->client->dev);
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(&chip->client->dev);
> -	} else {
> -		pm_runtime_mark_last_busy(&chip->client->dev);
> -		ret = pm_runtime_put_autosuspend(&chip->client->dev);
> -	}
> -
> -	return ret;
> +	return pm_runtime_put_autosuspend(&chip->client->dev);
>  }

> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 61a0957317a1..d2f5a44892a8 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -361,19 +361,13 @@ static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
>  
>  static int us5182d_set_power_state(struct us5182d_data *data, bool on)

As below.

>  {
> -	int ret;
> -
>  	if (data->power_mode == US5182D_ONESHOT)
>  		return 0;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(&data->client->dev);
> -	} else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(&data->client->dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(&data->client->dev);
>  }
>  
>  static int us5182d_read_value(struct us5182d_data *data,
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index cc81a30b7c70..4dbb2294a843 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -576,16 +576,11 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
>  static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)

As below.

>  {
>  	struct device *dev = &data->client->dev;
> -	int ret;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 01bc99564f98..963747927425 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -141,17 +141,12 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {
>  
>  static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)

I'd like to get rid of this function.  It was of marginal benefit before it got
even simpler, not it is actively making the code worse to read.

>  {
> -	int ret;
>  	struct device *dev = &data->client->dev;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,



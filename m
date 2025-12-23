Return-Path: <linux-iio+bounces-27336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60055CD9F16
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 775B6302D5D6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711232E6B5;
	Tue, 23 Dec 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxocYG+q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1690318151;
	Tue, 23 Dec 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507079; cv=none; b=S9EaB2CULqY0KQnrsPsFk76Gl8XkxnGBuJYGX/7CinykRYIt7yZhV2FG3fwXLw3Vps0OwZ5FWzjRvUG/Mzbc8YFXVvqY4AkKrWdmrQL9VBKeosFKNu6PKxYQaErC/PfOOwjkJmf1luA1fKCxPpGHG7pJRRH5Vew1s5NVpSJH6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507079; c=relaxed/simple;
	bh=3qVOvSQIWwScePELLmWnd91+x+FO0ghrlMNcQT2LZbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxrAiWi14x+jbvNinMhC5DAN1MxVH3yBT0xzr6v3VSI+CrMked+1o4XAPgu/nYSzsQzu03T2l6zFXnYUSZwxG0WBy6Fv1b2krScnGCH9MhDyxbY90/eqd7LuCKDPXCT6uCGI10tiGFxqptNuoNw1KRycLl9jQYk6TT6VIyzjlpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxocYG+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0240C113D0;
	Tue, 23 Dec 2025 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507078;
	bh=3qVOvSQIWwScePELLmWnd91+x+FO0ghrlMNcQT2LZbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxocYG+qrFsexKvWp8UnmdmobfpsDyH7P1+YJTEa2MYESPoFxhafpM8gsfi6cIU1R
	 n9Gfg1fwPKTG1mVszIKw6gD/hi1FUHPlichzp8hHC1c+ODcPI9IBtiK3ysngVX/8kW
	 6qtUsjPhga/f+L4DCnVAi/486vh+xUTx4zZGQNwJ3DsWuw1m/H07s9A63d0isPWvAn
	 xfv73Q5cyzS9PAQGwA0vuOAt9j1S+Rh8W8c92InWjFECnByviZpnF8o0xVzvH73G+F
	 Ou0DXgasgqiym6+NqEvExYrZ1OZI3ZKfz52X4AGZYCiiAOFPgWM25YiaBJBeAweuxD
	 6BLkrF9xDKKgg==
Date: Tue, 23 Dec 2025 21:54:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hansg@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Saravanan Sekar <sravanhome@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 2/2] iio: inkern: Use namespaced exports
Message-ID: <aUrCQu-wmQ7gOyD3@vaman>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
 <20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>

On 09-12-25, 09:25, Romain Gantois wrote:
> Use namespaced exports for IIO consumer API functions.
> 
> This will make it easier to manage the IIO export surface. Consumer drivers
> will only be provided access to a specific set of functions, thereby
> restricting usage of internal IIO functions by other parts of the kernel.
> 
> This change cannot be split into several parts without breaking
> bisectability, thus all of the affected drivers are modified at once.
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for power-supply
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/extcon/extcon-adc-jack.c                |  1 +
>  drivers/hwmon/iio_hwmon.c                       |  1 +
>  drivers/hwmon/ntc_thermistor.c                  |  1 +
>  drivers/iio/adc/envelope-detector.c             |  1 +
>  drivers/iio/afe/iio-rescale.c                   |  1 +
>  drivers/iio/buffer/industrialio-buffer-cb.c     |  1 +
>  drivers/iio/buffer/industrialio-hw-consumer.c   |  1 +
>  drivers/iio/dac/ad8460.c                        |  1 +
>  drivers/iio/dac/dpot-dac.c                      |  1 +
>  drivers/iio/inkern.c                            | 54 ++++++++++++-------------
>  drivers/iio/light/cm3605.c                      |  1 +
>  drivers/iio/light/gp2ap002.c                    |  1 +
>  drivers/iio/multiplexer/iio-mux.c               |  1 +
>  drivers/iio/potentiostat/lmp91000.c             |  1 +
>  drivers/input/joystick/adc-joystick.c           |  1 +
>  drivers/input/keyboard/adc-keys.c               |  1 +
>  drivers/input/touchscreen/colibri-vf50-ts.c     |  1 +
>  drivers/input/touchscreen/resistive-adc-touch.c |  1 +
>  drivers/phy/motorola/phy-cpcap-usb.c            |  1 +

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod


Return-Path: <linux-iio+bounces-23765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81087B4551C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD675A5E11
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0272E62A8;
	Fri,  5 Sep 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJb78JN9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28642D5C6C;
	Fri,  5 Sep 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068956; cv=none; b=NIJvHLJa29szJJ0JnUHMJ5+Fy7W66I8PyFUD7xniygAqvfJ2/pID653DFD3rvFUAXGFzLDfvq5aIvcztupXpWt4FQQ+EILgkVLJ8YWXc4aM8E6xSU/iLE2sRYBJsBwEkbY9b3MuwB0x52uLC1WK872U/BEpmpyN5SK8GJkQulPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068956; c=relaxed/simple;
	bh=+I+6Ob8PFYzlZ0UQk3wSgdfHmrOiugnSzIZKb8fhQEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH24OTQ5/53JFbLpARH9vl4IsdQWpCgF+/E666Cv7FtI3Gj8Y/B1DIAigK3gvg4/4GnUqOEMHnWNNRxQ8ptVCGUZxIJbVS9TtYgIBUrVyO/3eLGMk4RieILOBel5N8Tq0MiU8EN9/68WleOCdSHpLaJuNpTHMSRL0SsHJLFJAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJb78JN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C01C4CEF1;
	Fri,  5 Sep 2025 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757068955;
	bh=+I+6Ob8PFYzlZ0UQk3wSgdfHmrOiugnSzIZKb8fhQEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJb78JN9Aubn7l+hWFWK2KhL4xncFQiznSU1O+VqVeYoJWONHp4RcAOCsvHduuTfN
	 +nudQ518QxKtrWwCOfBIzTxEEJAGpU/jUCrDlsuwWXRXBBl2j3vBt1Ltw4szB1n87y
	 h7x6GKYVobYJ3QTWpsrKBMfGZ15EnA7yYfTpXWUhfEXV1WWfuuJ0vS7hs6fM/OGabb
	 EOWmFuoLcS3oeA8aB09KPBnxvbJrH5hUgrl3aMa2r81N5UzhAZ8Ke81VM3YcHVbnvU
	 RJi3JEAJOsT+TM9h+WPDYgQX6anuQ91U155dHwC08dgE3WTQvlLfDX33vEVEuA2/m4
	 2N9AdUNBEKQBA==
Date: Fri, 5 Sep 2025 11:42:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Talel Shenhar <talel@amazon.com>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	"open list:THERMAL DRIVER FOR AMLOGIC SOCS" <linux-amlogic@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"open list:QUALCOMM TSENS THERMAL DRIVER" <linux-arm-msm@vger.kernel.org>,
	"open list:RENESAS R-CAR THERMAL DRIVERS" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	"open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 04/12] regulator: max8973: Remove redundant error log
 prints
Message-ID: <2f060139-7446-4cb1-910d-791918b28f51@sirena.org.uk>
References: <20250905072423.368123-1-zhao.xichao@vivo.com>
 <20250905072423.368123-5-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hSBr52yOin/qCY9V"
Content-Disposition: inline
In-Reply-To: <20250905072423.368123-5-zhao.xichao@vivo.com>
X-Cookie: He who laughs, lasts.


--hSBr52yOin/qCY9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2025 at 03:23:56PM +0800, Xichao Zhao wrote:
> devm_thermal_of_zone_register() prints error log messages when
> it fails, so there is no need to print error log messages again.

Acked-by: Mark Brown <broonie@kernel.org>

--hSBr52yOin/qCY9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi6vocACgkQJNaLcl1U
h9A9Ggf8DfcaSZB9QDgKG3CTzMYN6dA03Qdzw6VmLM9o81xSSlRvqsWSYEm0G86q
z/jyW0esF1zaS9pQ+ni9mgIUQQvCBr6/d1pY2UJpJd3z1xw2eJUWIgNHIfLsaKDk
ZIixofNJ8unn3ayIaYKW6fWIhZcoMRY+yXMtvdtUD2vxzMFOerQ1dFKakBEsu9Nj
JTQTup0slsEXR1tzi/4HBQfftUi+24MUDaRkOnfPfOn1D5gmUaZ6c07B1fGp9dmM
5c73MTNcN3xonK265AHjzWrgi4sJoXEeqfN7SmvHqspnq6df5zHeKUvFD9Jx+lEw
n/HlWMMkt3wAlpDVMMsmqqlWaSrGcA==
=sWAM
-----END PGP SIGNATURE-----

--hSBr52yOin/qCY9V--


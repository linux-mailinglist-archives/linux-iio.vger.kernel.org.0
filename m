Return-Path: <linux-iio+bounces-23754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254BB45077
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4493AAF82
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5C2F7468;
	Fri,  5 Sep 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QaTEQEmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0cf+H8i"
X-Original-To: linux-iio@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEE2F60CD;
	Fri,  5 Sep 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058996; cv=none; b=PbABLUAIg5WqHT3UW6lzL9GvbEeZV68KtHgNg8lNA8e82zSpWR0W8ZCkiYkZZJ1t4GpdyxEcdDhQJAHWfmPv6nKdOoAQMpOQ8/S/YGlXyKfHG5ea0peuJYqQdZ4CIWoP38pk4fKD/mNWuzNZpCqr6KhF4cAdgcO8djAgqUGGwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058996; c=relaxed/simple;
	bh=DCIyd4J3pbvUjw8wlbL34A1o0IPs27eqjyKuOZAMvOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViW5tY6pTMR/CliMHA/3AZd15+lEB34bZvnBVzVlHfeWJNeI3WX5V8syMQmUJPII1ySlPspe91DOKyPWMAVd1sUDD+cf1VGjc6/O4LUgI9hDrRZ+oKQdSYrjT5bQIURWR36ifwhyVzI7Afgjxcpsz8JZkC/ZLqVmT8afsf4OpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=QaTEQEmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0cf+H8i; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 820DD1380159;
	Fri,  5 Sep 2025 03:56:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 03:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757058992;
	 x=1757066192; bh=KXUoaaH+PV1RudhFs2J2lVTbxM4uje+tSmH6gtbu+Nw=; b=
	QaTEQEmjGTJeSxeiah6pwWZmjZ/MZs5T6DwWq8Nmr7oHpYFT9j95C72yMyBcZ5nz
	u3cXjVlnWCc6V75Dwc83w5se6RUX0cgy2r6hhn8896BD1N9niWfNBDEsX5z3bbZh
	580Lxh1wJduGFt3iTeOOmO1kuUcf+UmbfmLmVrhi303staCq+82oOHT6v6FtLJ0q
	KUmIN0sVOTWfm9OO4IWePH36nTPtiHUbxCP6V5sCpCoy7ecX5fAcARL2bBp1+hYX
	meum9lsc6nxtc9bJfoYbWnrGaAyGJmjEbDgf28gHFpwuN2s7fsfyePI14fKiGSKO
	+KWH0qpxAXjQsFF5TvJk4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757058992; x=
	1757066192; bh=KXUoaaH+PV1RudhFs2J2lVTbxM4uje+tSmH6gtbu+Nw=; b=Y
	0cf+H8iNJvMgyddoNtlWXiFqcl4IGVll81T+/QLuu0VNzM2Tdl4Dututnx+WBVfY
	ZUAq036GCT8hJkBvo1Xuxdbdn01HtUdgUk4Ofv3efStIQ3nE14kAyA73FHfb4fjf
	KOwQB+75cW2V3GGZKDUuIfX594V3wr1n+Z2P2+qfVHB3QqrZG4ssbRrH1By1GbCD
	TRIW/OdNehrErechp8kPDk8rijxMDklBtf55Ic7ogPHsHFoI0ZeeNpUdQIUyNFBc
	8OZXytKiVrvaFoIX8swMPQV8EFgUKFbS92QjUo575ehIJo8Op3B6lZAJqKd3TDxm
	YaTlavtRtgFLUQVaVcOvQ==
X-ME-Sender: <xms:rJe6aPT4hEQwkAeohLnFC7wamjbvAr7niwm9b31Yo5zEex0vYFN_jg>
    <xme:rJe6aPCqpHI9uJ68XId1Qna7oWm5iyUGoAQPsu1kx2oN2qHjsCp2dNoZI4nTxFNl9
    MurlN6lVZ1a7ntIgiI>
X-ME-Received: <xmr:rJe6aO_r3H0kGSKS2fH0hEtRAmpG1wYDXGxPnza4nmiPk8yaDQHgreHxbUoYRRqeSVYYMKGdX0I7aNFWxHyOdN0DhlU70pWKyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgrshcu
    ufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvg
    gthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheetheek
    keegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrght
    vggthhdrshgvpdhnsggprhgtphhtthhopeeihedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepiihhrghordigihgthhgrohesvhhivhhordgtohhmpdhrtghpthhtohepjhgu
    vghlvhgrrhgvsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigsehrohgvtghkqd
    hushdrnhgvthdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepnhhunh
    hordhsrgesrghnrghlohhgrdgtohhmpdhrtghpthhtoheprghnugihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopeifvghnshestghsihgvrdhorhhgpdhrtghpthhtohepjhgvrh
    hnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rJe6aLaJP6Xj2rkulgEos-3PuobS8mQKjatGJJBMK7inm3Pq7Gp2Vg>
    <xmx:rJe6aNF7-pW6bVrecDyimGuFt4rFKlRaO80vk9U-M3x2Osc7wCA6DA>
    <xmx:rJe6aLeryKtg2eNLenz4G8c7nPW0XLHn41W-YUcd9nAafvGlUomGZw>
    <xmx:rJe6aID5jwH-KTo0RNYmn7aS7aHdvvvDvzZsp7Xrs_Dh-FuDrHloig>
    <xmx:sJe6aL5VH3NVRImO0zXqWNKt1X3K9WtPu7YT5fkHwr7N4ubXrLHaDEMN>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:56:27 -0400 (EDT)
Date: Fri, 5 Sep 2025 09:56:25 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,	Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,	Talel Shenhar <talel@amazon.com>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	"open list:THERMAL DRIVER FOR AMLOGIC SOCS"
 <linux-amlogic@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <imx@lists.linux.dev>,
	"open list:QUALCOMM TSENS THERMAL DRIVER"
 <linux-arm-msm@vger.kernel.org>,
	"open list:RENESAS R-CAR THERMAL DRIVERS"
 <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/Rockchip SoC support"
 <linux-rockchip@lists.infradead.org>,
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	"open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 01/12] thermal: of: Add error handling in
 devm_thermal_*_register()
Message-ID: <20250905075625.GA1852264@ragnatech.se>
References: <20250905072423.368123-1-zhao.xichao@vivo.com>
 <20250905072423.368123-2-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905072423.368123-2-zhao.xichao@vivo.com>

Hello Xichao,

Thanks for your work.

On 2025-09-05 15:23:53 +0800, Xichao Zhao wrote:
> devm_thermal_of_zone_register() does not print any error message
> when registering a thermal zone with a device node sensor fails
> and allocating device resource data fails.
> 
> This forces each driver to implement redundant error logging.
> Additionally, when upper-layer functions propagate these errors
> without logging, critical debugging information is lost.
> 
> Add dev_err_probe() in devm_thermal_of_zone_register() to unify
> error reporting.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/thermal/thermal_of.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1a51a4d240ff..8fe0ad402579 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -475,11 +475,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>  
>  	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
>  			   GFP_KERNEL);
> -	if (!ptr)
> +	if (!ptr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
>  	if (IS_ERR(tzd)) {
> +		dev_err_probe(dev, PTR_ERR(tzd),
> +			      "Failed to register thermal zone sensor[%d]\n", sensor_id);

Don't thermal_of_zone_register() already print an error message for 
failure cases? If not can this print be moved there? That would allow 
the change you make in R-Car drivers to remove the prating completely, 
not just for the devm_* cases.

>  		devres_free(ptr);
>  		return tzd;
>  	}
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund


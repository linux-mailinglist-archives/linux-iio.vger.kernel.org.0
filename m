Return-Path: <linux-iio+bounces-7257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5E9264EC
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 17:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D711C210E8
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E138181BA6;
	Wed,  3 Jul 2024 15:34:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2617C218;
	Wed,  3 Jul 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020885; cv=none; b=RwNiOvL4CLpxUv8Mr/sCNqCiINAZkm6dF5KgE5dbJd36NZwIQ79g75vCiKnfEGmE1b7ecA/i+qQKBXA+ToV+D/E5tbdbTrX9G4WBCW/0uszp9ezM2mQmvpVgABPNIpkPeLKLD08GUJDHU0WkIg9xTWW4N98fvOjnLWeW5ReDLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020885; c=relaxed/simple;
	bh=bfaw19uuK8TQlCj0Vgpd7pA788Xds97aFClcqdNEz8I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdoaSnkF6wr4OfABT437IixwWVioFcvV5ypAVLyC59UItQKcZHaxZwBjcCYH2dbSP8ylkfhmsfinMDc12wYc2p2HAv3USuYBTFVrVBgm968pA4HUhXOOR0zg1N97YLP1aahmQ9VmPFZQ3/6s9eUR+lGzny1VkLWntATO+5LUXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WDkLJ3vy7z6K8y3;
	Wed,  3 Jul 2024 23:32:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6253A140A87;
	Wed,  3 Jul 2024 23:34:33 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 3 Jul
 2024 16:34:32 +0100
Date: Wed, 3 Jul 2024 16:34:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Nathan Chancellor <nathan@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Bjorn Andersson <andersson@kernel.org>,
	Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, "Krzysztof Kozlowski" <krzk@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "Jonathan
 Cameron" <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "Richard
 Leitner" <richard.leitner@linux.dev>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-clk@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-samsung-soc@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <patches@opensource.cirrus.com>,
	<linux-sound@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 12/20] iio: adc: ti_am335x_adc: convert to
 of_property_for_each_u32_new()
Message-ID: <20240703163431.0000268f@Huawei.com>
In-Reply-To: <20240703-of_property_for_each_u32-v1-12-42c1fc0b82aa@bootlin.com>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
	<20240703-of_property_for_each_u32-v1-12-42c1fc0b82aa@bootlin.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 03 Jul 2024 12:36:56 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Simplify code using of_property_for_each_u32_new() as the two additional
> parameters in of_property_for_each_u32() are not used here.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


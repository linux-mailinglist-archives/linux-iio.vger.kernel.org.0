Return-Path: <linux-iio+bounces-26933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C6CAC931
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F593045081
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A812E6CC4;
	Mon,  8 Dec 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2T3KfPwN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F13B8D41;
	Mon,  8 Dec 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184274; cv=none; b=FgeHdkTpaebn6ECTmTyClly5HZ7+MXKIZvaopLwOsumqd912FcEvUPzmG9kS2FDnWgWZIbeOTW4jmJybhuqh0xWPvp9khItAFCzYtR3SGi31zCYc3kGnPfRobirf5ZlU0ONjm6wwLhzywobUvN5QMMzID0JQHB9vBYEsGnsiQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184274; c=relaxed/simple;
	bh=zmlKMgzkanVWDnk0Lc30Gqgw66DMVuf2sBnpcY3VYEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDu3XgT0nAfJxN2cLE+Cu1II6s+q0wkdpH4wE8sV0Wyj+hDXXyEJeYWck+uEkASt8A9jWYipXeCWHy0XogfVrvTf9wQJsxX3uAGwAlyi8LHPpCHJRIOvBNODTmchAZxjhOLZu1bUjKFG6E0FPfiQyCVVeiZhOX3XzNENxWyKVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2T3KfPwN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D4F701A201C;
	Mon,  8 Dec 2025 08:57:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A16AD6070C;
	Mon,  8 Dec 2025 08:57:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F238102F0A9B;
	Mon,  8 Dec 2025 09:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765184267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3fg1zW3LOXIPMYWNiGMqZlYLtPRdk9K2q2GNC8WmibM=;
	b=2T3KfPwNwUmq9Lt4oZRqOtwhda6Flnt0QwmI6YflOV7VPGQxgDkBWZm1p3eQ/328i7qyeT
	vHLZNvI6W9Ak5hYLXJXSXXc0CBXXjO270B+alVG9LDd2+bg0vChABDbMJnDLkQgk250BSW
	yETa/SIv6h41p8o1hAExIjtLVPVZ8RV5Bgg8+LV/GzKtTKyzW0yIMTclkHFszqC3bHv039
	X+wfJkbAvLGpj6OWpG1D1daow8IER2MeouFk0gESqQfoiPEYAoa5xH1Wkl2fWCRa8FpKv2
	BXH9ELHLTcGyZhCZ6+8r5UDmwKTwkGbxTWIG2Ke1rzoMYicClzlETWMJoL40mA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Peter Rosin <peda@axentia.se>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
Date: Mon, 08 Dec 2025 09:57:24 +0100
Message-ID: <2024471.PYKUYFuaPT@fw-rgant>
In-Reply-To: <20251207184818.2ad7cef7@jic23-huawei>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <9b43da0b-61e1-49bb-acc2-392de3817db7@roeck-us.net>
 <20251207184818.2ad7cef7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7885096.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart7885096.EvYhyI6sBW
Content-Type: multipart/alternative; boundary="nextPart22929280.EfDdHjke4D";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 08 Dec 2025 09:57:24 +0100
Message-ID: <2024471.PYKUYFuaPT@fw-rgant>
In-Reply-To: <20251207184818.2ad7cef7@jic23-huawei>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart22929280.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 7 December 2025 19:48:18 CET Jonathan Cameron wrote:
> On Tue, 25 Nov 2025 08:37:20 -0800
> 
> Guenter Roeck <linux@roeck-us.net> wrote:
> > On 11/25/25 02:25, H. Nikolaus Schaller wrote:
> > ...
> > 
> > > Another suggestion: what extending the "regulator-fixed",
> > > "regulator-gpio",
> > > "regulator-fixed-clock" pattern by some
> > > "regulator-gpio-iio-dac-current-limiter" driver to make it independent
> > > of your specific chip?
> > 
> > The name is terrible ;-), but that is what I would have suggested as well.
> > I don't see anything chip specific in this code. If there is a need for
> > a regulator driver which uses gpio to enable it and a DAC for current
> > limiting, it should be made generic.
> 
> Agreed - something generic is the ideal way to go.
> 
> However, before going too far it is worth exploring what are common circuits
> with these things to identify what parameters we need to describe how the
> DAC channel is used - e.g is linear scaling enough?  You'll need to that to
> define a DT binding. If it turns out to be too complex, then fallback to
> specific compatibles in a generic driver to cover the ones that don't fit
> with a common scheme.  A similar case we already have is discrete
> components as analog front ends for ADCs - mostly they fall into a few
> categories and we have drivers covering those, but some are very odd indeed
> and for those ones we do have a driver even though they don't have anything
> to control as such - most extreme case being when it's a non linear analog
> sensor.
> 

I actually did use a modified version of iio-rescale in my downstream code. My 
use case includes an OpAmp inverter circuit placed in front of a DAC, and it's 
useful for me to be able to describe this in a modular fashion, as two IIO 
device tree nodes representing respectively the DAC and the OpAmp circuit 
front-end.

Moreover, the LTM8054 takes a voltage on its CTL pin and infers a current 
limit from it. This is also something which could be represented as a sort of 
AFE node.

 LTM8054 output voltage control:           
+---+ +------------+ +--------------------+
|DAC+->Inverter AFE+->Feedback circuit AFE|
+---+ +------------+ +--------------------+
                                           
 LTM8054 output current limit control:     
+---+ +--------------------+               
|DAC+->Voltage-controller  |               
+---+ |current limiter AFE |               
      +--------------------+               

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart22929280.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Sunday, 7 December 2025 19:48:18 CET Jonathan Cameron wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; On Tue, 25 Nov 2025 08:37:20 -0800</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Guenter Roeck &lt;linux@roeck-us.net&gt; wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; On 11/25/25 02:25, H. Nikolaus Schaller wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; ...</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; Another suggestion: what extending the &quot;regulator-fixed&quot;,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; &quot;regulator-gpio&quot;,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; &quot;regulator-fixed-clock&quot; pattern by some</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; &quot;regulator-gpio-iio-dac-current-limiter&quot; driver to make it independent</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; of your specific chip?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; The name is terrible ;-), but that is what I would have suggested as well.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; I don't see anything chip specific in this code. If there is a need for</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; a regulator driver which uses gpio to enable it and a DAC for current</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; limiting, it should be made generic.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Agreed - something generic is the ideal way to go.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; However, before going too far it is worth exploring what are common circuits</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; with these things to identify what parameters we need to describe how the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; DAC channel is used - e.g is linear scaling enough?&nbsp; You'll need to that to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; define a DT binding. If it turns out to be too complex, then fallback to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; specific compatibles in a generic driver to cover the ones that don't fit</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; with a common scheme.&nbsp; A similar case we already have is discrete</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; components as analog front ends for ADCs - mostly they fall into a few</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; categories and we have drivers covering those, but some are very odd indeed</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; and for those ones we do have a driver even though they don't have anything</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; to control as such - most extreme case being when it's a non linear analog</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; sensor.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I actually did use a modified version of iio-rescale in my downstream code. My </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">use case includes an OpAmp inverter circuit placed in front of a DAC, and it's </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">useful for me to be able to describe this in a modular fashion, as two IIO </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">device tree nodes representing respectively the DAC and the OpAmp circuit </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">front-end.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Moreover, the LTM8054 takes a voltage on its CTL pin and infers a current </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">limit from it. This is also something which could be represented as a sort of </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">AFE node.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;LTM8054 output voltage control:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">+---+ +------------+ +--------------------+</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">|DAC+-&gt;Inverter AFE+-&gt;Feedback circuit AFE|</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">+---+ +------------+ +--------------------+</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;LTM8054 output current limit control:&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">+---+ +--------------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">|DAC+-&gt;Voltage-controller&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">+---+ |current limiter AFE |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +--------------------+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Thanks,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Romain Gantois, Bootlin</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Embedded Linux and Kernel engineering</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">https://bootlin.com</p>
<br /></body>
</html>
--nextPart22929280.EfDdHjke4D--

--nextPart7885096.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmk2kvQACgkQKCYAIARz
eA7Dhw/9GfGpoHhSNiYoLEY8BU6ezNDIJRsccNjENK6KoL3UN7ypRE+gcLa0bNqe
WOOtbaVjjBeF7GFKMzJ+nR6jiMzUM+qwAc1Tv4ShuhXjG07gC/seUciBiywn+Bmg
QuEm40+vr+C5/U6sB5NGm78ns25z5Ek9xNsqGpugLstBb8gntze+VSH1d78aZA+w
ygVLP/T9s4nxR/0abtoiKwumEuw6gmo/4Qhp1WW5WD9w6O83DlBMlt+/kl5fDC31
sxpFYgNfqmqAppD6gzuvmpF058IihWRpjUTrD/NjcOnVkq7Vq371YAirJJsLFJoz
eyggKZkmrUPLJc6jhjqy5AMq5g+hN+gkppuDvMg7NRYAwSqu8j9J3x6+EiHjm6oN
NAFVOzw1KPrGAEfxLLRWWubm/61UD7i/S2nS6cr/r2AeN/wfIXA6W+dQIEWQEnOx
6KJm925Bs3jjBqPcyL2NQ04H02mhuUzIb5Q3aH56o/gRA8IR3yVuRgTgFkNoOogI
xoZeteDlq6fyune2SC1YlPsh1BOOn71qWvJg8kVjfhuEVzRvG5g7bXNUAoZ6fReY
lkPXNIHe9Tgp/76WA+D0sJCTWXtYR+mkrUKHig5TVEszW67+zyfH5l1cVdQY6Izo
ui99LBQWUI+OunYO2iIEevgn+n92e13HFNZmzIb89ZE/4VWcrvM=
=oqy9
-----END PGP SIGNATURE-----

--nextPart7885096.EvYhyI6sBW--





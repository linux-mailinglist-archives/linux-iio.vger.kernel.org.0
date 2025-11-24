Return-Path: <linux-iio+bounces-26433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A63C8177E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAF173472AA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06EE314D07;
	Mon, 24 Nov 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="23udfwRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA63314A99;
	Mon, 24 Nov 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000162; cv=none; b=ZITF02+fXUqMm8ZjTEUmEzvkwzmdohXeNVb9T0PZEvxIGs893fc10/LjMLdn+y/CIvjgFsTylnxoPKHqX5HwdzbFbXXDMSEeAazp6+8/6TAJrbYlKgKMKTskmUvCxKohrzmtuZSKqIwXb59UmaXybRqqNxLbWTLA/V6p5JxL2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000162; c=relaxed/simple;
	bh=5Q+VikH8axfZlkzsYeZld/28ixnUIrc2DukFEZtwOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4JaPK7wamMqoS8udRO9RQRJRCdG+w93QjIc8DHXCSX/lYY+NwTPgL/ppzSGLHLtTuPWAZ+oaITRE+Ef1uf2u8hG0E37x+cWPoRrSbUny6oLVD7/YyHlShLRfWV+IDPZXx3G2+1LBzmHTPFATgBiZEgJRK3pRsA9TX+bBkZv7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=23udfwRH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37A521A1D1F;
	Mon, 24 Nov 2025 16:02:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CFEF60705;
	Mon, 24 Nov 2025 16:02:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8569410371A40;
	Mon, 24 Nov 2025 17:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764000156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fSwjEBFFDA7v4bZHV1Jm9ubAIPIsgOhP8uG9o5XCi3w=;
	b=23udfwRHWY7LPrwckXXVkKWtIY8/eTNFCxCxQWXtjDVTJ3DRPxhsKBikUYSYQORgje6CfI
	Uj0uzPLpyPefkgYCQVeW/eBaaXFS4BJr8RNGi+1iy91XiIL3CsJhIcwHld7ZhcrnTzLsos
	/KrNNrVd+eZVVCHWi/UzDkWw6jo5WJ7c50lLUi8UwiyiOAm7ArWsJL86sYoxm1eLHptku9
	S4iBPNHAB7Hlw7ubbePM5/A97LXQv8Cg5Naj0CNOC1a+vVOiqALNKbPLhffpETcy5bQb7W
	bJlpVwC81gpwBBgLKILszMA6tPpRo1nN9vMHFgx+mFx2CsYzS4BkK9jesRKLmA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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
Date: Mon, 24 Nov 2025 17:02:21 +0100
Message-ID: <5820146.Sb9uPGUboI@fw-rgant>
In-Reply-To: <da5457ea-c1ed-4c90-8743-fc982a02ed88@roeck-us.net>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <23111366.EfDdHjke4D@fw-rgant>
 <da5457ea-c1ed-4c90-8743-fc982a02ed88@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2407312.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2407312.OBFZWjSADL
Content-Type: multipart/alternative; boundary="nextPart2232231.yKVeVyVuyW";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 17:02:21 +0100
Message-ID: <5820146.Sb9uPGUboI@fw-rgant>
In-Reply-To: <da5457ea-c1ed-4c90-8743-fc982a02ed88@roeck-us.net>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart2232231.yKVeVyVuyW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 24 November 2025 16:40:37 CET Guenter Roeck wrote:
...
> > 
> > Do you think that using the IIO consumer API is not correct here? What
> > other
> > 
> > method do you think I should use?
> 
> Ok, I had a look into the datasheet. Unless I am missing something, the chip
> doesn't have a digital control or monitoring interface such as I2C or SPI.
> 
> At the same time, you copied the hardware monitoring mailing list on this
> summary and on (at least) one of the patches, but apparently not on all of
> them. This lead to my apparently wrong assumption that iio is used to
> monitor (not [just] control) something on the chip. I wrongly assumed that
> IIO is used to report chip status (voltage, current, temperature) using an
> internal DAC. Obviously that was a wrong assumption. Sorry for that.
> 
> Apparently you copied the hwmon mailing list for the introduction of an IIO
> namespace and its use in a couple of hwmon drivers in one of the patches.
> My personal opinion is that this should not be part of this series but a
> series of its own. That is just my personal opinion, though.

I understand. I can split it out.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--nextPart2232231.yKVeVyVuyW
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Monday, 24 November 2025 16:40:37 CET Guenter Roeck wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">...</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; Do you think that using the IIO consumer API is not correct here? What</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; other</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; method do you think I should use?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Ok, I had a look into the datasheet. Unless I am missing something, the chip</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; doesn't have a digital control or monitoring interface such as I2C or SPI.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; At the same time, you copied the hardware monitoring mailing list on this</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; summary and on (at least) one of the patches, but apparently not on all of</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; them. This lead to my apparently wrong assumption that iio is used to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; monitor (not [just] control) something on the chip. I wrongly assumed that</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; IIO is used to report chip status (voltage, current, temperature) using an</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; internal DAC. Obviously that was a wrong assumption. Sorry for that.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Apparently you copied the hwmon mailing list for the introduction of an IIO</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; namespace and its use in a couple of hwmon drivers in one of the patches.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; My personal opinion is that this should not be part of this series but a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; series of its own. That is just my personal opinion, though.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I understand. I can split it out.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Thanks,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Romain Gantois, Bootlin</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Embedded Linux and Kernel engineering</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">https://bootlin.com</p>
<br /></body>
</html>
--nextPart2232231.yKVeVyVuyW--

--nextPart2407312.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkkgY0ACgkQKCYAIARz
eA7Sbw/+IYj1nxQCZiCtv+dhusxsoeEnMc+7km6Tdiz5j2SjZJRD/edgkVP7TjRx
wVQcHHDUrVzdLDYyWfvYZ0F1/gPV3ucv6nxkzKsluOW/atgPproy8w1sbLq+ISP+
uLXFWne5Rdt+OhRG8kGDHcP5XKa98L1b/IFCoTdTe/jINYXwYDR2CxyFURJQrNSL
naSNbJjMu1adFjsOKsemwKKQOI4lVy6xd7zVfKRAlquVAP3NW1LV71QrEhVfnKFg
XY+Q0KMQp+EVd5BKw2C0PNkrrjC3kJ1YWEBV861/Cs/eK207rHf0vNPiaDCLntfz
csXkzjesTqOs7KlwU6MTPAE9yDRA6bzJjWr/GHfBxkYoNoSmEml90yeFLaPSJg/L
pMhv+nUSVazSCwI5ALEd/lNu/JXEn4j/Ec1WJVcTIiL4iRDZxJkokTXim2oV6lY6
F8f834u+ZEhjk/0qFRPTOCBbPD94TMRL+0rd6pnm/+uqOeK5mJicMQzEjx9JRsh/
ksjQoJ68S+fLTpNLKGZ2JWb/e7TgVnyJmenjVT3sAO/VAPxvBr3KqaWi9w9bjY+1
2Y6b49RMZ3BVqxwfKe8Za3xO2q6W1Uznm8M7yOUJ31tf7pcxVLYgB8Vbeb3Ackkv
IJbePktWu8NRDvwSQ1495EHaLKPtXsC1mT0yoAd41nvKbvte21U=
=W/xS
-----END PGP SIGNATURE-----

--nextPart2407312.OBFZWjSADL--





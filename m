Return-Path: <linux-iio+bounces-26432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4887C81733
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 298163464FB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A5314B75;
	Mon, 24 Nov 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VarxPDuE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9902D59F7;
	Mon, 24 Nov 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999865; cv=none; b=c4lT/JuL4gRLnd+klc6Wx1ZULCHVxluLkxuMYRCbRq0onePqX8EVKG7Nmpfi3u4myunlKvxCjEFHFFt+QLvcHXIf0xbRafhxLjpYb7NfSMnBeRReJonlRVZM0JKnANI6lDsMsRKYE1kojhjqyAVX2QauoQd3YzZp4IBlquwYRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999865; c=relaxed/simple;
	bh=yGI97hDLro8+McOQ+lHZp2VCQuWtN25N7eUBLNYm8jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTCsm3F2lnq7TAt/+LcdW13xRmQbXCch6c9ZUKmnAMj/ev38+TWORiKXVad0Mr8ZrqOCBtHIACfQ+775h1cgIMw/cPEzmJocUsX1XkHzOxSlMMcSz6mLyJKWzklWBv36HJvmKyNvQy/6NSHG8E8uAiEIDeC+jzWk+uzxyIGyXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VarxPDuE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F79A1A1D1F;
	Mon, 24 Nov 2025 15:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71C74606FC;
	Mon, 24 Nov 2025 15:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0297B10371A40;
	Mon, 24 Nov 2025 16:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763999858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UX028RVBrtav4WisvLm2dO1F8K5+rUIM4Xp+GTn4l88=;
	b=VarxPDuEXoNSmVvJFI8GatO2RP9trnXzaYCfsYMM6RiiQJ2m93PBXrieFqWdi7u6Z2RoZg
	GAGA01Dg63AWsSjF79FfLxVFlCWOLC7nb+Zva16AiZR4LFaDIOkwTjS+1qvXT6UkmCc4TH
	yzjFgzaGeZFlS18DchOYD0zIe6ixo0ZO9D4JFiPQlx//8nY7IyIYwgA24Z48+/kegy6SN7
	r9KW3P+aPv0ig9jzpcYgX+xbOwsPSqiPsLbiFMkGf/rdRqa9+vF2g0o12LRVP64iuC5S5t
	QWlRuX+uUfAmODHQDKv6cyMvrBcyY/vc3NIbj+57IejdauvBbh+DRTxNEjxg7Q==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
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
Date: Mon, 24 Nov 2025 16:57:16 +0100
Message-ID: <4053840.MHq7AAxBmi@fw-rgant>
In-Reply-To: <563331EB-2460-4CF5-87B3-5FE60B18BB70@goldelico.com>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <23111366.EfDdHjke4D@fw-rgant>
 <563331EB-2460-4CF5-87B3-5FE60B18BB70@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2111402.atdPhlSkOF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2111402.atdPhlSkOF
Content-Type: multipart/alternative; boundary="nextPart2186563.taCxCBeP46";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Romain Gantois <romain.gantois@bootlin.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Mon, 24 Nov 2025 16:57:16 +0100
Message-ID: <4053840.MHq7AAxBmi@fw-rgant>
In-Reply-To: <563331EB-2460-4CF5-87B3-5FE60B18BB70@goldelico.com>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart2186563.taCxCBeP46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Nikolaus,

On Monday, 24 November 2025 16:35:28 CET H. Nikolaus Schaller wrote:
...
> > Sorry, I don't quite understand your remark. To integrate this voltage
> > regulator component into the Linux regulator abstraction, I'm providing a
> > current limit control function. To provide such a function, the voltage
> > level on a pin has to be controlled. AFAIK, the kernel abstraction used
> > to set precise voltages on lines is an IO channel.
> 
> I was curious to learn about this topic and looked into the data sheet:
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/8054fa.p
> df
> 
> As far as I see the LTM8054 does not even have a programming interface.
> So is it reasonable to provide a dedicated driver at all?
> 
> The figure on page 20 seems to suggest that there is an external DAC
> which drives the regulator. And the regulator drives for example a fan.
> 
> So I would think of a driver for the specific DAC and ignore the specific
> LTM chip at all.
> 

In my use case, the LTM8054 feeds a DC output port on which various devices 
may be plugged. Dynamic output current limitation and output voltage level 
control for these devices is a requirement, as well as stepped voltage 
transitions, thus the need for a proper regulator device.

The LTM8054's feedback pin can be driven by a different DAC, which allows for 
dynamic output voltage control. This is a more complex upstreaming topic 
however, so I've left it out of this initial series. There are other component 
functions which fit in squarely into the regulator framework, such as 
input current limit control and soft-start. But I understand that the current 
driver might look a bit "bare".

> What could be necessary is if you really want to be able to "regulate"
> the current going to Vout, some bridge between regulator API and some
> IIO DAC.
> 
> And enabling/disabling the regulator by some GPIO can be described in
> the DT already through a "regulator-fixed".
> 

This is a possibility, but when you bring in all of these other hardware 
functions that I mentionned e.g. output voltage control and stepping, you'll 
end up with several different devices which look unrelated from userspace, but 
actually control the same chip.

Userspace will also have to know about some hardware details to properly 
control the DACs, such as the values of the sense and feedback resistors. In 
my opinion, this bypasses the kernel's abstraction of hardware.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--nextPart2186563.taCxCBeP46
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Hi Nikolaus,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Monday, 24 November 2025 16:35:28 CET H. Nikolaus Schaller wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">...</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; Sorry, I don't quite understand your remark. To integrate this voltage</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; regulator component into the Linux regulator abstraction, I'm providing a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; current limit control function. To provide such a function, the voltage</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; level on a pin has to be controlled. AFAIK, the kernel abstraction used</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; to set precise voltages on lines is an IO channel.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; I was curious to learn about this topic and looked into the data sheet:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; https://www.analog.com/media/en/technical-documentation/data-sheets/8054fa.p</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; df</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; As far as I see the LTM8054 does not even have a programming interface.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; So is it reasonable to provide a dedicated driver at all?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; The figure on page 20 seems to suggest that there is an external DAC</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; which drives the regulator. And the regulator drives for example a fan.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; So I would think of a driver for the specific DAC and ignore the specific</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; LTM chip at all.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">In my use case, the LTM8054 feeds a DC output port on which various devices </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">may be plugged. Dynamic output current limitation and output voltage level </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">control for these devices is a requirement, as well as stepped voltage </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">transitions, thus the need for a proper regulator device.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">The LTM8054's feedback pin can be driven by a different DAC, which allows for </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">dynamic output voltage control. This is a more complex upstreaming topic </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">however, so I've left it out of this initial series. There are other component </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">functions which fit in squarely into the regulator framework, such as </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">input current limit control and soft-start. But I understand that the current </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">driver might look a bit &quot;bare&quot;.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; What could be necessary is if you really want to be able to &quot;regulate&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; the current going to Vout, some bridge between regulator API and some</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; IIO DAC.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; And enabling/disabling the regulator by some GPIO can be described in</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; the DT already through a &quot;regulator-fixed&quot;.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">This is a possibility, but when you bring in all of these other hardware </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">functions that I mentionned e.g. output voltage control and stepping, you'll </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">end up with several different devices which look unrelated from userspace, but </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">actually control the same chip.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Userspace will also have to know about some hardware details to properly </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">control the DACs, such as the values of the sense and feedback resistors. In </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">my opinion, this bypasses the kernel's abstraction of hardware.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Thanks,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Romain Gantois, Bootlin</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Embedded Linux and Kernel engineering</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">https://bootlin.com</p>
<br /></body>
</html>
--nextPart2186563.taCxCBeP46--

--nextPart2111402.atdPhlSkOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkkgFwACgkQKCYAIARz
eA6Alg/8COym+7pL1LpZ1EUBzLeuPJJMpNXAoKBsdBPOyD3NnxUoT3dqx1KV6Qxl
qgm6tINDewDnwWGblDKog18X7I3G9JZVLM4/LwN//KMnkzo+GcECfLyFvnNrzKhg
X1ZpkaamjbifIadbFXhOy1HQ/A6tO90ICk4ae2Dgye9PCZAqsL/GUGtcwiJzbWTk
mNNqqvmwxf7KGS/63peSY0oGREjOfo95tZPllfLxP5lgvdVP/kiTot7ErGsaFh5y
zzUIaEYjpiE86eQ+0/gKRs+Xkn4sAOyPzzRwoycI9JsYuJOPLEkIdChhAKNkKUD9
MmGR4aMVjgLxKxu2dfNwsJmVQJ8mkVor+3jqyP77XSyM7E71ZesHrujCRodKaicr
hiTtUMGt5qkalsMDHQLJ8MR3R/hMJWK2u1uKitIC0NhXCNQfR2yGlEothJDFcdQL
K0cOhaJGpDnxfaopsfnN9ianNPZ5MhUYJj6qvQPAjTtARK8E+uL2ysXgZ9bQ1xKx
g+URjMLJ49zdR8rHCJw0PLPE7Cb8GcsPFlad9yWPzjhJxk5y8JTMNWAnzZTRH96b
I/PLDFBC9fy13WU6sj9591J0oxcpRC/k6ctEDZzN5sQZ8J+2rwc9moNFpGRpuLGc
sefn100uth/gnbi+8IJjmTB564t5KIY0Xpnk7+3vfqFC2a88B+o=
=Wv+m
-----END PGP SIGNATURE-----

--nextPart2111402.atdPhlSkOF--





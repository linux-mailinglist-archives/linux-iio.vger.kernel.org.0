Return-Path: <linux-iio+bounces-26429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE313C8143B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E185F4E24E2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837631327F;
	Mon, 24 Nov 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TntYoh8A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80502749FE;
	Mon, 24 Nov 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997237; cv=none; b=IpiO8jSgnCj8jqbL0xeOEt7MsmXUi+ecBeH0F03+ibVOJyzjekyiwCYx4IRM6Be+LAS0La/QTnIiJC4eXUy2QYrqoOX/oRDHY0EMoWHO202TLbvVGUfRzupDObd0OoEmExgJdf/dkdwrIyxwklfpTqpsqCnmyFhLOXoOP/38gK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997237; c=relaxed/simple;
	bh=gBhx8Mbf0EyBCb2GMYE7V3/PC7aCPdL0yiJrn3XgNAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWlw6EixN0LnJpwnsTwZ0Rg50AmVLL0CWPR3ziKTO00aLwer6hrQ3410EO/qJ1ojjrJUlFBcgloieOVG3rVYygQaPQdhPGTnRPd0xeRlKwo/U5QrtBdRVIKxjqPGW2/U89lB/qwYZvCArg5wwgG66GFPUSWlYLHUQ3rCuqwspT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TntYoh8A; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D5BCC139AF;
	Mon, 24 Nov 2025 15:13:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF0D660705;
	Mon, 24 Nov 2025 15:13:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8382810371A40;
	Mon, 24 Nov 2025 16:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763997229; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KeHRsQWQWHgCUqrAiXnJp1WIeWLgxqdNlTv4+nJhNOg=;
	b=TntYoh8AeSRn4I+5TNL9anc2ksbdcU3gCGIIM0uCozEReM6pGtWO+C/NwdpLkYeLztP3/w
	5RuxgzByVoF1vNmgCkNzCXV1qRBqjxwRgvSYjxhVPkkK4flld6reO+1Fq3hyEOMkslukjN
	8l6OJQAzvyy/7zkY7oB2nW6bvSrtwRW83lB0m3bEi3RMQ8QTbDMmT8ucAdBnLKHO6Yrh12
	PAIZLO55VpDOobuDS8v4RYmFPVUBdJNkNmKo4n82qa/5ugkeG7xT2UXZl9OV2JNEhITFqj
	aMjr9X3XwgfbShXaoK3UFtga1GgP/ZO9Y16VJaeDTrgb3pSkfMOtanXC/Tl3og==
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
Date: Mon, 24 Nov 2025 16:13:26 +0100
Message-ID: <23111366.EfDdHjke4D@fw-rgant>
In-Reply-To: <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4113614.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart4113614.kQq0lBPeGt
Content-Type: multipart/alternative; boundary="nextPart8077299.EvYhyI6sBW";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 16:13:26 +0100
Message-ID: <23111366.EfDdHjke4D@fw-rgant>
In-Reply-To: <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart8077299.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello Guenter,

On Monday, 24 November 2025 15:57:41 CET Guenter Roeck wrote:
> On 11/24/25 06:48, Romain Gantois wrote:
> > Hello everyone,
> > 
> > This is version four of my series which adds initial support of the Linear
> > Technology LTM8054 voltage regulator. The driver supports a fixed voltage
> > and a tunable output current limit using a DAC-controlled pin.
> > 
> > I'd say that the most unusual part of this series is the usage of the IIO
> > consumer API in a regulator driver. I think this makes sense here, since
> > the regulator driver has to access a DAC to read/set the output current
> > limit.
> 
> I don't think that is a valid reason. Literally every driver measuring
> voltages or current uses a DAC to do it. How else would one convert an
> analog value into a digital value ?

Sorry, I don't quite understand your remark. To integrate this voltage 
regulator component into the Linux regulator abstraction, I'm providing a 
current limit control function. To provide such a function, the voltage level 
on a pin has to be controlled. AFAIK, the kernel abstraction used to set 
precise voltages on lines is an IO channel.

Do you think that using the IIO consumer API is not correct here? What other 
method do you think I should use?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--nextPart8077299.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Hello Guenter,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Monday, 24 November 2025 15:57:41 CET Guenter Roeck wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; On 11/24/25 06:48, Romain Gantois wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; Hello everyone,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; This is version four of my series which adds initial support of the Linear</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; Technology LTM8054 voltage regulator. The driver supports a fixed voltage</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; and a tunable output current limit using a DAC-controlled pin.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; I'd say that the most unusual part of this series is the usage of the IIO</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; consumer API in a regulator driver. I think this makes sense here, since</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; the regulator driver has to access a DAC to read/set the output current</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; limit.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; I don't think that is a valid reason. Literally every driver measuring</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; voltages or current uses a DAC to do it. How else would one convert an</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; analog value into a digital value ?</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Sorry, I don't quite understand your remark. To integrate this voltage </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">regulator component into the Linux regulator abstraction, I'm providing a </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">current limit control function. To provide such a function, the voltage level </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">on a pin has to be controlled. AFAIK, the kernel abstraction used to set </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">precise voltages on lines is an IO channel.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Do you think that using the IIO consumer API is not correct here? What other </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">method do you think I should use?</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Thanks,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Romain Gantois, Bootlin</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Embedded Linux and Kernel engineering</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">https://bootlin.com</p>
<br /></body>
</html>
--nextPart8077299.EvYhyI6sBW--

--nextPart4113614.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkkdhYACgkQKCYAIARz
eA7Qpw//QZmn8Z6KMjxYRaV2oFT+8zEG5iKQ7jzafgDDFy0In7oKyj1RV8ZqVkxI
5YLcWx1HZUN25O9ysPGCiSE/uSvFGyZeMjCI4vQcEUrjPc2LgrzKc78YE3C2Rzk3
FVp2JmSU26N8JWgb76E8XsmdQsD9gYFgEvptccUYauluiw98CsLLd416CTRUG4ko
AWiRXWQc4iNKIV5Xzr+PYzRDp0w0TtqI0jgZZPOsL+QHzrMvq7nIbDvmiCOaSBJG
BMW5zhT075/cTv0swZYoTdljT18cPC3HqsXeUwADYgzlB/+5z5Ji8Lew3BVtoQmd
pbsehIp2cC7r5HQvbgtyb1Zbjo534R8rPYMM2vujv3E1N5/+3p7WWr7UQCzm+Hll
X4MSDSI6FczjKXBEfPUlPAuDPo2Ms5C7cTdh0MdFjXnX6kRZkfawuYhwjxuS6Vl0
lqtZpG1OlMbm5gRcGYxZehWxhYZW3+fG4gG6V3NdgXJBgT0VoxlA3Wq3uG7sU/MM
Mn4yZWXRs+JyiVnWoxbg6L3AB6PFChnD29VbJ372najkvwwJKmDoV7BdRNx/K9vC
3C1215jYC3lElxPoTNmPTV6sdtp+wtPdJ2k5ZN/rGPm4LuMrNfVplLWsqH/U8GY4
SOtoXDr+y5wsgtsVqvKWrzlJD6HcAeef7v8oIqP/v8LaH3xkhKQ=
=xKLG
-----END PGP SIGNATURE-----

--nextPart4113614.kQq0lBPeGt--





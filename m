Return-Path: <linux-iio+bounces-26517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F4C8F23E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9408C35376B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9A33556B;
	Thu, 27 Nov 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KsDxrTwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1532C95B;
	Thu, 27 Nov 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256039; cv=none; b=LedkVX8YkPD+H+HbsRqbJHX69fLGdEGATonzlngyzZpyuQX6/TIk6ffAtG5czx+SmuR6VTltKDeZgFmaAOblQnC3JC/zZ25RYcW3TqSfVQNJDx96J7fv2jhdNHQ3oNjOVB37YsW/brtNIjqHnL1l+k5KpQC/fgvTT+qMkAv4j/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256039; c=relaxed/simple;
	bh=NyPHAxEuBfxhiJKrWsktUqr6mdKRf3cbmidwmHAlulY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t15wy+0pnSRZ/B+lcJW6rRj9Vrd+eo/KMBluXZhg2SZ8cMWqp26Hby8fVKV9m+T+jD/07E3CNGvoK0JqHfbTUrRaXXh/7e880PGhFQfuf/CuHDO3+v0j3762zCsrI0HIND4fZjjhbeR6OYsc+rJqrC4042WsiiVRPKKzsMNQwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KsDxrTwJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C26F44E41920;
	Thu, 27 Nov 2025 15:07:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8520D6072A;
	Thu, 27 Nov 2025 15:07:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE57C102F218C;
	Thu, 27 Nov 2025 16:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764256032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Xb2gYHXIhVp2zaSFmlDMNszWhEx2yHpcG9wfBD9WQ6Q=;
	b=KsDxrTwJZ35P4V4zqNgBRz6dueQQQ479lYnTv33vH6BaAZQ6mqaBR8WEopD6/WxoiDZf3C
	Ic4RTSKoLEfjd0/q+TBQmqIrfWBRSTeCoErZlb34wHoEcX2HAzuN2RzutFpS6+d2ln9KMJ
	TSvAsAUfwMfwSBd4rCMr2Fdi3SKnKSNaEM9vqWiV42ClnoYd2t6PVCTiOsInGdUD2yiqj4
	ZzTUOWwdLINFYrJ9uWeuCkQFxLH7ib2+v5JAxnvTykYWonFW1xB3OWNxxohmbmwdgPC/rA
	Ba8/f4uTLQUuaOMbgPFSeaBwbd+ExYFXfFw+9W2+71ncOaO/+QIwmKbAGZv6Rw==
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
Date: Thu, 27 Nov 2025 16:06:47 +0100
Message-ID: <8695751.T7Z3S40VBb@fw-rgant>
In-Reply-To: <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <3021060.e9J7NaK4W3@fw-rgant>
 <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10847283.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart10847283.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Thu, 27 Nov 2025 16:06:47 +0100
Message-ID: <8695751.T7Z3S40VBb@fw-rgant>
In-Reply-To: <0E900830-E248-4F0F-A048-075EAF1D2440@goldelico.com>
MIME-Version: 1.0

On Tuesday, 25 November 2025 11:25:24 CET H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 25.11.2025 um 09:41 schrieb Romain Gantois
> > <romain.gantois@bootlin.com>:
> > 
> > 
> > This is planned support for a voltage regulator chip.
> 
> Well, but one which is not by itself programmable. So IMHO, it does not
> support that chip, but the circuit it is used in.
> 

The boundary is a bit blurry in this case, sure.

> > > Are you looking for a virtual "glue" driver to logically combine several
> > > low level functions?
> > 
> > I'm looking for a clean userspace abstraction for this component, the low-
> > level functions in this case are those of a voltage regulator.
> 
> As far as I understood it has
> - constant voltage
> - current can be limited
> - it can be turned on/off
> 
> That means it is a fixed-regulator (for constant voltage and turn on/off)
> and a mechanism to program the current limit (iio-dac). Both have clean
> userspace abstraction.
> 
> What am I missing?
> 

In my case, the regulator has a DAC tapping into the feedback divider with 
allows modifying the output voltage level. This isn't specific to the LTM8054 
though, you can theoretically do this with any regulator chip that has a 
feedback pin.

...
> The question remains if you want to solve something for a single board which
> happens to have an LTM8054 or if you are solving a more general design
> pattern.
> 
> In summary my view is that the LTM8054 is just a "fixed-regulator" which
> gets an additional current-limiter feature by adding a DAC chip (which needs
> a driver of course). So software control is required not by the LTM8054 but
> by adding a DAC chip.
> 
> Another suggestion: what extending the "regulator-fixed", "regulator-gpio",
> "regulator-fixed-clock" pattern by some
> "regulator-gpio-iio-dac-current-limiter" driver to make it independent of
> your specific chip?
> 
> By the way, are you aware of this feature of the regulator-gpio driver?
> 
> https://elixir.bootlin.com/linux/v6.18-rc7/source/drivers/regulator/gpio-reg
> ulator.c#L97
> 

That could be a preferable solution given that similar current limit and 
output voltage limit control methods could apply to other regulator chips... 
I'll have to think about it some more.

> Just to note: I am neither maintainer nor doing any decisions on this, just
> asking questions for curiosity and from experience and giving hints for
> alternative approaches, where I hope they help to find the really best
> solution.

Sure, I appreciate that.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart10847283.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkoaQcACgkQKCYAIARz
eA4wIA//cR+gzKtW78qSkS/qn3QD4fmem8sIoJemjJ96zZS/fPrrD7BVbwlzmT8Z
PX35PtLLxRdN0CRWsdmEqAAwFLRMn0/UBGpROLNSqKZT9c3SisrVH5XlVV0s95LB
fS6l3xzgbIjdqhGxwXgV+43B2OuuBLE9AopgYIwRunAam9+nECFHo9hU/4glxqrS
O54WKxLhs7/BMJdpAv4T8UYjqKiC7Lvpd4oq43g64sacplSnZNv4iwqkga0oOtd8
2IayCT5+gRm6xd9Xt/cVkQUQAFsoiieLLt87+JZP1ECtjcfwIsDiPBf49DvppELP
SLg8qwG44QYRhfsPvdBRLFuvkmsu1rGZaBdRQZ+npfBkkwljuh6EllMbFgUOpuCR
aFQleHJ/6naNsAZGxp4mW6x1YPwsiYeCQuQdffSq2DrTLEAnG3EV3wIB5TbMsF72
p6glXdEj3uYECnRJ9Lql1PWO9MHGnubF2xCDqRIn7HDxq+DLmZkkZzg4c69/V1fy
O7go8T5OfK1233Kqb1VDvY9SDRL5+nLo1tacht8yyrhq3LEUumAf7TFLXzBmN+QQ
5TURL5uovvulw4c6SXs9sa7yriUKuayb9s5CKLsJJI4uYBt+Csyhm/fOfpuvKVm5
Bryk0xixSfV1ekLMojoBFaS3AFNPGNCHqSmjGOEsaK8hrJ5HgkM=
=KPmo
-----END PGP SIGNATURE-----

--nextPart10847283.nUPlyArG6x--





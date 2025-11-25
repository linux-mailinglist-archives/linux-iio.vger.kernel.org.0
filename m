Return-Path: <linux-iio+bounces-26447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06847C84083
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 09:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA12B4E5527
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96812E0B71;
	Tue, 25 Nov 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="np8FqZdy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF32DAFB5;
	Tue, 25 Nov 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060126; cv=none; b=RTtyjybJNed1TAYTyGQDYgxBZ1wfqGZwLDUKGVQqDyDAQzOZvTrCd3uLrm8ctZZz2/9z4S3TQeShRfR97dowJW8xEbAs0rwOsbzEMfI+hOzaQoAHsUWDTCWCjvuO4FYAZDB5QakMsMw4dhke3slB5NDegzBRsdVbr2/4GApaF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060126; c=relaxed/simple;
	bh=n7wfBFTS1kGLsWICsHYKAhBOKvlSac+am2uGBQZ1i2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKsou0PMP3K5gI2vhT25nWyMwL9MaDDs7dMCOUHEmRwamdIpzlKxl75gNjPCGctD5CvhmhfuG2V1gj+Jp+dpLMzxG5iQykqvEBJu//eUl6HTa92yJpi9xZr1fQBIW32lObHD2m0jaJ7NHDfoMlSyovJ8EC71Orx27FSHJQO6NZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=np8FqZdy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A8EC21A1D30;
	Tue, 25 Nov 2025 08:42:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76F1D60705;
	Tue, 25 Nov 2025 08:42:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 937281037160A;
	Tue, 25 Nov 2025 09:41:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764060118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2o0olBqqiCnYMdbfemBfUTVqO9jEfeuMqW3Jkn2wJC0=;
	b=np8FqZdym2Wty0W93O7w7shgzDAPxvx7OSrXs0VRuETOjjAW8+HA50+CFTcDPlJ1zO4C7W
	e6PURzgtrculx7tTu8rN97eJwG2WPlJhw8q6DJTImD2KkbiUG+rt8S7g6YHZd4v6vlZzWI
	4KV0igv0n6z6xtyafwxwCTcHE8Eb5vgS9NMtbd+09MDsbnWaraeS/SLEzkokIKtYa2tQnA
	LE7CCJQabojoGkiALiJgmhfnKLC74eVKEj0pyAvSQmlvHtLFegfXUAYwlMTCjo3Xo8WnoB
	XKSt0lq2XmLzPCn6oWlE9BzvoJHvLN1w/658oqxZrLUwOEMDLD4Oop8egVF3iw==
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
Date: Tue, 25 Nov 2025 09:41:34 +0100
Message-ID: <3021060.e9J7NaK4W3@fw-rgant>
In-Reply-To: <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <4053840.MHq7AAxBmi@fw-rgant>
 <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3391484.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart3391484.44csPzL39Z
Content-Type: multipart/alternative; boundary="nextPart3384998.aeNJFYEL58";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Romain Gantois <romain.gantois@bootlin.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Tue, 25 Nov 2025 09:41:34 +0100
Message-ID: <3021060.e9J7NaK4W3@fw-rgant>
In-Reply-To: <732D3F12-0361-4800-8981-EF629B4C491F@goldelico.com>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart3384998.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 24 November 2025 17:19:45 CET H. Nikolaus Schaller wrote:
...
> > The LTM8054's feedback pin can be driven by a different DAC, which allows
> > for dynamic output voltage control. This is a more complex upstreaming
> > topic however, so I've left it out of this initial series. There are
> > other component functions which fit in squarely into the regulator
> > framework, such as input current limit control and soft-start. But I
> > understand that the current driver might look a bit "bare".
> 
> So you just want to have some user-space mechanism to control voltage
> and current limits? Can't this be done by directly controlling them through
> the iio API?
> 
> Is this for a device that is already in kernel or planned to be supported?
> Or is it "application support" for some SBC?
> 

This is planned support for a voltage regulator chip.

> Are you looking for a virtual "glue" driver to logically combine several low
> level functions?
> 

I'm looking for a clean userspace abstraction for this component, the low-
level functions in this case are those of a voltage regulator.

> > > What could be necessary is if you really want to be able to "regulate"
> > > the current going to Vout, some bridge between regulator API and some
> > > IIO DAC.
> > > 
> > > And enabling/disabling the regulator by some GPIO can be described in
> > > the DT already through a "regulator-fixed".
> > 
> > This is a possibility, but when you bring in all of these other hardware
> > functions that I mentionned e.g. output voltage control and stepping,
> > you'll end up with several different devices which look unrelated from
> > userspace, but actually control the same chip.
> 
> That is quite usual... I have often heard: user space must fix this as
> kernel just provides basic functions in a harmonized way and integration
> has to be tailored to the device anyways :)
> 

IMHO this is not integration, it's BSP work. As far as regulator functions are 
concerned, the current status quo is that the kernel handles getting/setting 
voltage levels, applying current and voltage constraints and other basic 
regulator features.

> > Userspace will also have to know about some hardware details to properly
> > control the DACs, such as the values of the sense and feedback resistors.
> > In my opinion, this bypasses the kernel's abstraction of hardware.
> 
> I came up with this argument several times in the part and got a lot of
> contrary :)
> 
> What I still wonder: does your hardware warrant an upstream driver for a
> non-programable chip if a different solution (with help of user-space)
> already exist?
> 

A different solution does not currently exist (although a userspace-based 
solution could be designed). I just think that a kernel-based solution is more 
desirable here.

> Another question: is your scheme generic enough so that it can be expected
> that other devices are using it in the same way?
> 

Yes, the LTM8054 has a fairly common design as far as buck-boost chips go. 
Things like feedback dividers on the output voltage pin are standard practice.
And since the driver doesn't rely on a particular way of integrating the 
LTM8054 with other components, it can be reused wherever the same regulator 
chip is used.

> Or could the power controller framework (/sys/class/power_supply) fit
> better?
> 
--nextPart3384998.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">On Monday, 24 November 2025 17:19:45 CET H. Nikolaus Schaller wrote:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">...</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; The LTM8054's feedback pin can be driven by a different DAC, which allows</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; for dynamic output voltage control. This is a more complex upstreaming</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; topic however, so I've left it out of this initial series. There are</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; other component functions which fit in squarely into the regulator</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; framework, such as input current limit control and soft-start. But I</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; understand that the current driver might look a bit &quot;bare&quot;.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; So you just want to have some user-space mechanism to control voltage</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; and current limits? Can't this be done by directly controlling them through</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; the iio API?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Is this for a device that is already in kernel or planned to be supported?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Or is it &quot;application support&quot; for some SBC?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">This is planned support for a voltage regulator chip.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Are you looking for a virtual &quot;glue&quot; driver to logically combine several low</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; level functions?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I'm looking for a clean userspace abstraction for this component, the low-</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">level functions in this case are those of a voltage regulator.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; What could be necessary is if you really want to be able to &quot;regulate&quot;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; the current going to Vout, some bridge between regulator API and some</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; IIO DAC.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; And enabling/disabling the regulator by some GPIO can be described in</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; &gt; the DT already through a &quot;regulator-fixed&quot;.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; This is a possibility, but when you bring in all of these other hardware</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; functions that I mentionned e.g. output voltage control and stepping,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; you'll end up with several different devices which look unrelated from</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; userspace, but actually control the same chip.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; That is quite usual... I have often heard: user space must fix this as</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; kernel just provides basic functions in a harmonized way and integration</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; has to be tailored to the device anyways :)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">IMHO this is not integration, it's BSP work. As far as regulator functions are </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">concerned, the current status quo is that the kernel handles getting/setting </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">voltage levels, applying current and voltage constraints and other basic </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">regulator features.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; Userspace will also have to know about some hardware details to properly</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; control the DACs, such as the values of the sense and feedback resistors.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; &gt; In my opinion, this bypasses the kernel's abstraction of hardware.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; I came up with this argument several times in the part and got a lot of</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; contrary :)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; What I still wonder: does your hardware warrant an upstream driver for a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; non-programable chip if a different solution (with help of user-space)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; already exist?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">A different solution does not currently exist (although a userspace-based </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">solution could be designed). I just think that a kernel-based solution is more </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">desirable here.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Another question: is your scheme generic enough so that it can be expected</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; that other devices are using it in the same way?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Yes, the LTM8054 has a fairly common design as far as buck-boost chips go. </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Things like feedback dividers on the output voltage pin are standard practice.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">And since the driver doesn't rely on a particular way of integrating the </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">LTM8054 with other components, it can be reused wherever the same regulator </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">chip is used.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Or could the power controller framework (/sys/class/power_supply) fit</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; better?</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I don't think the power supply abstraction is relevant here. The LTM8054 is a </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">voltage regulator, it doesn't have charge, capacity, temperature monitoring, </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">power limitation, or other power supply class features.</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; There is an API to ask chargers etc. for battery voltage and current limits</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; or even write them.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; There is also &quot;generic-adc-battery&quot; which allows to hook up with arbitrary</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; iio-adcs for measurements - although you need a DAC in your setup. Maybe an</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; extension here is a better strategy than a dedicated ltm8054 driver?</p>
<br /><br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">What if the LTM8054 is not used to supply a battery?</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Thanks,</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Romain Gantois, Bootlin</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Embedded Linux and Kernel engineering</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">https://bootlin.com</p>
<br /></body>
</html>
--nextPart3384998.aeNJFYEL58--

--nextPart3391484.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkla74ACgkQKCYAIARz
eA4uoA/9H25d5rofXv5yC5jGvCQOKojoS9wGic9EKNLG3RhZlGrCXhEf2dFw9w9I
KdlTjGKLaXynf0oBz5SfeSL1juql9WOfV2px4AeCeEALikbdQs1ce1O7K126uo4q
A1zlxkZMPa6Xj3pQ1IIri7WVCjRDiHVFs1hrFJz8XoMbIC0XDycQD+8DEe84cHbk
aqo/wiWTxLVusXDihmVD2JfaZhDKMKTW6rQ2HW+MJUOGcNtTYNKlQ6PjRQtaAvbq
0GaffUh2vHyQ0qR1mmhgJibiSX+opzhVeHFua3cA5lfVPZPudubmORMAUnDXeT3j
coFe7wkMqx34bQG2vf1EUrfl5tM0SLF9yPo3W2Y0rWRpSJhRcnDDqtMBY4LGtU4P
KzMYczGkdSXG7xA+fT9kR0ANunjMz3ub2kFnR5fJB+B07C1DNAQFA7zA8WRt4iL/
cNPYb5BX7VDxw33Xripatp9u8hE2Z3CGBKYW7gudC9Jd2U5GoIukMdxn4TJlZHAA
2TL8/ZJDKBTcUEsca+UU5BUa3tm8gk0jfJpThZwOhB2G+eOuKVbcLejZqAfNN1rG
quNoBZmTQ51CzAoHiDbTGrnK5oz84q2KWOmHXLAn8O20dlJWEUgb/ghFR79r3EW4
AuNuKXwXClIOnvF5B9NLbFCwZzFK9L5mIQ69ZwaVN+0kDzg3CAg=
=LLKl
-----END PGP SIGNATURE-----

--nextPart3391484.44csPzL39Z--





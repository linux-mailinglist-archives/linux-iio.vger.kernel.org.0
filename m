Return-Path: <linux-iio+bounces-26880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE5CAB5C0
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 15:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A49304B95C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFA1C5D57;
	Sun,  7 Dec 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsCx8mM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCA16132F;
	Sun,  7 Dec 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765116074; cv=none; b=G1Q79u0ZNVqScYkzk7jDB/QTdoX8s2g0FbBfWbiTT/xsX4dNdYXgPBJBGUy9oychWtPifJ/6v10goNsgFzBAkNhFLPUlecFnWh3GIBfUiQLkW7PbweoKMvHa/FwAPVSAvfjHJF2T30OnQnz4lSgUw4UWrNBz/aWfqSA4rEwxTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765116074; c=relaxed/simple;
	bh=XIPzPHGdu9MVAiWYzmLVkJFzpk/+VDBaaF5v6Z7S21s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce4FcUxQ1282a91kbMuMJ3xs1MO0Vu5NJ+DKabqD9sgv2tuywNwEutXWhartsJ5TTS8iCWsuYdMEaAyXLkNrftercW7VS9Ng70vfhrLlzE2WPBc87zESMPFC1msWa8D3c7VodcZSSEtsCPwAC/6GYbTm5OY9b+gIQCSPnCHoTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsCx8mM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD22C4CEFB;
	Sun,  7 Dec 2025 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765116073;
	bh=XIPzPHGdu9MVAiWYzmLVkJFzpk/+VDBaaF5v6Z7S21s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsCx8mM87A8HyrcrJI3CQaCEoWdzjxwjyxeqqWomtZPKX5oKnNhnVYczlV7yr+api
	 h1nrsAZDZtwq8anuESeyBIikhqAGux8Sco7E2Rn/vfqVt3PrLc2LEXvN4NSCJv8VNd
	 QVVaCfRbNh41EPha2La8wU9XYpzaRw5oeg/WKfl2DGoA8/1tRRDfQAYNuQDEo9c9yk
	 dqBAsLPZNDc43gMPXaP5nnzCsVtGWyKsl2w7so4uosQ6fq9FfMfKiMuPsd2YnYkyMA
	 RKvB9A/O4JQAg0lFIEGn3i1jJw/CzAX645QjvGuZeOKfDEgbv9poaPspTv29soMaUq
	 UJU9YlFfffWtg==
Date: Sun, 7 Dec 2025 14:00:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>, Peter Rosin
 <peda@axentia.se>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Kevin Tsai <ktsai@capellamicro.com>, Linus
 Walleij <linus.walleij@linaro.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de
 Goede <hansg@kernel.org>, Support Opensource
 <support.opensource@diasemi.com>, Paul Cercueil <paul@crapouillou.net>,
 Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Matheus Castello
 <matheus@castello.eng.br>, Saravanan Sekar <sravanhome@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Casey Connolly
 <casey.connolly@linaro.org>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Amit
 Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sylwester
 Nawrocki <s.nawrocki@samsung.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, David Lechner <dlechner@baylibre.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] iio: inkern: Use namespaced exports
Message-ID: <20251207140046.56322d6f@jic23-huawei>
In-Reply-To: <5948030.DvuYhMxLoT@fw-rgant>
References: <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
	<78240755-44dc-4835-aca5-99540cca0304@baylibre.com>
	<5948030.DvuYhMxLoT@fw-rgant>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Dec 2025 08:30:58 +0100
Romain Gantois <romain.gantois@bootlin.com> wrote:

> On Monday, 1 December 2025 18:15:54 CET David Lechner wrote:
> > On 12/1/25 4:59 AM, Romain Gantois wrote:  
> > > Use namespaced exports for IIO consumer API functions.
> > > 
> > > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> > > ---  
> > 
> > ...
> >   
> > > diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> > > index a8198ba4f98a..33d6692f46fe 100644
> > > --- a/drivers/iio/dac/ds4424.c
> > > +++ b/drivers/iio/dac/ds4424.c
> > > @@ -14,7 +14,6 @@
> > > 
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/driver.h>
> > >  #include <linux/iio/machine.h>
> > > 
> > > -#include <linux/iio/consumer.h>  
> > 
> > Unrelated change?  
> 
> Indeed, I'll leave that out in v2.

Please spin a precursor patch that makes that change.
That way we can easily check all files either both include that header
and have the namespace enabled, or neither.

I might merge this is a slightly funny way that leave it initially
not meeting that rule so that the precursor isn't in the immutable branch
for other subsystems but lets keep it logical in the patch set!

Jonathan

> 
> > >  #define DS4422_MAX_DAC_CHANNELS		2
> > >  #define DS4424_MAX_DAC_CHANNELS		4
> > > 
> > > @@ -321,3 +320,4 @@ MODULE_AUTHOR("Ismail H. Kose
> > > <ismail.kose@maximintegrated.com>");> 
> > >  MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
> > >  MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
> > >  MODULE_LICENSE("GPL v2");
> > > 
> > > +MODULE_IMPORT_NS("IIO_CONSUMER");  
> > 
> > Is this actually needed if we don't use anything from consumer.h?  
> 
> No, it's not.
> 
> Thanks,
> 



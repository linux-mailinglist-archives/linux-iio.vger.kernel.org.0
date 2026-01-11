Return-Path: <linux-iio+bounces-27626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A8D0F789
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11ABE301A4E2
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365234CFDD;
	Sun, 11 Jan 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5PCNrhP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8E22AE65;
	Sun, 11 Jan 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150705; cv=none; b=Wvb9Uf1zE51d+7tt+D6jmO9x/C10bLScXv2pfRfTY41cPMYqGrGw8LN5lhcqpekIjM1vwnTR4C6Xr/U5a++jjb15cmUUnUNkTBEjIz9u6170d0w5cYKaefojjPJ1RtRq7Pr4W4WbkJqUxvSxLU/ok9SKPq7yyWcJ5QUAiPrrTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150705; c=relaxed/simple;
	bh=2wbW41C2J76Sms115w/xbUlLwXKlyG+kYWdIrr/qsDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJXo9JU2LP7j4MoQdh85KXV7EET6W7VXWOYj+VzQ+jVIK4CoeaOiJedEqKoYNXrKAMwEs2RD1Y2dJc01o3Vsytb8sfoJxStkMl5r6mh+9DULH3HhaJnjCGfIbvg8H5U8RMZvFFDYHpNP7VU0T/sg+QBEF3x3D3mnMvM3rvQeE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5PCNrhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B94C4CEF7;
	Sun, 11 Jan 2026 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768150705;
	bh=2wbW41C2J76Sms115w/xbUlLwXKlyG+kYWdIrr/qsDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P5PCNrhPcaJ6XgRJcU2TduO4WKsQM5ILv9aSb19pPv7i20fpDsJbn3GwB+TeRu6tk
	 HHlw8YPtqrKhjPnlMxNkxf7Q19UAEmtPdQIr0D1EiKipCQ7T9FTAlsYItaUriFDjXz
	 OXZBNgbYOY2gG4mwXfJDllKa2k7op7UVTYBmE9ZUetjvyx3ttHcq5DT6vNvpn04aNW
	 qvDiy2a+o0DG5yc6rGODRfJm4OgxGvY+98HjA2GFpwftHZ3XDOAaCD+rn7qr3dBrxn
	 ZxB0ByoBmt8MwSToF8OPf3y1B4Obiqrfi2OfJ7xD2vS+K2/LFec2tHqUpRQvORglcl
	 xoYYSIMBwFh5w==
Date: Sun, 11 Jan 2026 16:57:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Guenter
 Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
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
 <alexandre.torgue@foss.st.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/2] iio: dac: ds4424: drop unused include IIO
 consumer header
Message-ID: <20260111165757.15d1a2bc@jic23-huawei>
In-Reply-To: <CAHp75VcX_z6q879gmWcb76SeFHtqMvpZ=y9PwNn0=eVFb06wAw@mail.gmail.com>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
	<20251209-iio-inkern-use-namespaced-exports-v2-1-9799a33c4b7f@bootlin.com>
	<CAHp75VcX_z6q879gmWcb76SeFHtqMvpZ=y9PwNn0=eVFb06wAw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Dec 2025 16:45:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 9, 2025 at 10:26=E2=80=AFAM Romain Gantois
> <romain.gantois@bootlin.com> wrote:
> >
> > To prepare for the introduction of namespaced exports for the IIO consu=
mer
> > API, remove this include directive which isn't actually used by the dri=
ver. =20
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
Picked this one up on the togreg branch of iio.git.  I'll sort out the othe=
r one
separately given I should do an immutable branch etc and that takes a little
more effort and time than I'm putting in today!

Jonathan




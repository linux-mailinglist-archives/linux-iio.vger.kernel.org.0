Return-Path: <linux-iio+bounces-6722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB891358A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5E91C20D13
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42A2C697;
	Sat, 22 Jun 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slBSHExp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21B225CF;
	Sat, 22 Jun 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719079641; cv=none; b=BdFt/9huKG3P2h7yxCj6umrXNTTpErTbT1L2zQSCBdMM3EnM+FZrZd3IlTSOTBqd4mVss5k9qwikPumDV4fjjzN15wiffXJFf84YZoGh9Lp6eTsxA0nqcFKrtTyTD7HaKIYxsU97EPOMbgKXERANFi3JYo4LkIYnXaVnPNhny+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719079641; c=relaxed/simple;
	bh=OtT1Bdv6RV8ExcvkSroMHalr66r6ej9Rmqb6rUMOMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+niIOEBsmQyM0xIXmZEpKbtK6DUXmYpORNpS+3/LErvZvHdvlyIs3/IoIyZ2JTg5G5bO2L6ij76xVQlFGLOQssDmXGjoaHBvEqeDPCLZvNISB9rxKUD5xigpJRudgmCxLZxB3o3NYbtoZimE3faITmVxsM/H0wT7K14sCSbRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slBSHExp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F603C3277B;
	Sat, 22 Jun 2024 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719079640;
	bh=OtT1Bdv6RV8ExcvkSroMHalr66r6ej9Rmqb6rUMOMI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slBSHExp0Uwe7g9gxR6wtZtx9GvEjsaR/9tW7T7D7ThM65vtbu5NwRtXOWZLb/A6Z
	 x4vzB//x6l8e4m/dKCQqux2wTtNYCkhB0sPnsVA49iVVQpmQ8/6HKwHmZEjeGxQQ66
	 +En2No/IKyo4TyARnNnRLLs9Nlw+Wx1OIGZR/8G+Zs7XxL5ECp2Dn79Bh9vAwRcAGW
	 Q8Y8kd5QjhT3h2nHvtxpe7LJn/2WOfoj1p1f/BnDGUBk5Elm13U0NGXZWsbU0pwaet
	 y4XEQJhRSJfiNLyG4NPQ9Gvmck4nLZjpuik3GoyfpXf0YXq3k6IOE95ZnJLrkxyDjj
	 eGKmdj2tsObmA==
Date: Sat, 22 Jun 2024 19:07:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede
 <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Saravanan Sekar
 <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 00/41] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
Message-ID: <20240622190706.670224da@jic23-huawei>
In-Reply-To: <mv3deevgf3pp6ojy3pa4zgc5z74ajroe26sayhzvrbua2dqrdu@enqs7sobbew5>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
	<mv3deevgf3pp6ojy3pa4zgc5z74ajroe26sayhzvrbua2dqrdu@enqs7sobbew5>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 17:17:27 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Trevor,
>=20
> On Mon, Jun 17, 2024 at 09:49:40AM -0400, Trevor Gamblin wrote:
> > Simplify the way regmap is accessed in iio drivers.
> >=20
> > Instead of using regmap_update_bits() and passing the mask twice, use
> > regmap_set_bits().
> >=20
> > Instead of using regmap_update_bits() and passing val =3D 0, use
> > regmap_clear_bits().
> >=20
> > The series is marked as v3, but the previous two revisions were single
> > patches. There was also a resend of v1 due to not properly CCing the
> > mailing lists on the first attempt. Trailers were pulled in from those
> > where relevant.
> >=20
> > Link to v2: https://lore.kernel.org/linux-iio/20240613133927.3851344-1-=
tgamblin@baylibre.com/
> > Link to v1: https://lore.kernel.org/linux-iio/20240611165214.4091591-1-=
tgamblin@baylibre.com/
> >=20
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com> =20
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>=20
Series applied with a few wrapping tweaks.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look + because I might rebase that tree after some fixes
make it upstream on which I have other dependencies and I don't like doing
that once it is in the public version of the togreg branch.

Thanks

Jonathan

> Thanks
> Uwe



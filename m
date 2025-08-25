Return-Path: <linux-iio+bounces-23189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA07B33990
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779DE484F60
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680952BE7A7;
	Mon, 25 Aug 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiKVSiOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF72BE65A;
	Mon, 25 Aug 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110998; cv=none; b=Dj8M9Xlzt6I9+3PTNuP+JUUVJgIgWaJHuDA2Oa6jPaVSPxzckgXDSJAstxhanzhfZIWbCRNsMSWcllQ96pILcd+lATg6zW+bQ+ZACVQKhTJAsnaGEtsNG2YBigMfuTDl5enKRLLdAm9oxpRVFZ7IK5JoaUTWAtSu3M8k0f67gjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110998; c=relaxed/simple;
	bh=WfaWLEgdb3jnJ7oeG9CJd/226yiBCsA11HpFYxtP4ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GReCQONjdj9jRZTFLSfG/66OdqsdCnSeEem4uNnMOcxiVkud5gR3juoxIMIuz6LPAfFCP93Gr7i26zRsBmZqOHnziEW7lz2zGp3HIW79ucMeGOsBt8d/DiIHVJR0YcBJqPO9rSydjkTvwRtPRATO78K/3x+sqTcaaZxqNfQf5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiKVSiOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15402C4CEF1;
	Mon, 25 Aug 2025 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110997;
	bh=WfaWLEgdb3jnJ7oeG9CJd/226yiBCsA11HpFYxtP4ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AiKVSiOP3IUKqIrE0nTH3NobajH02tOQwEZZspr/7mjkgAUlw30jkvC8fFJFXowLX
	 0WzIXSGAhgnIZdfmsYNAcn0b4ZptW0NHASXukWAToEBV86BHXo8yFsjGa+t+jpI/Tt
	 H+ZFhzDEWliaHAzrUjbGaXVFmIuNuNfh7AaNtL39MnNiHZdp13hGT3OLLrbD9BzYGF
	 7wB6ceHclSvDqzX7iv4OQSAowmeI553BhCTUiYhAPF05UFqNwkDSWYcu6/MhHKuJWY
	 MM1YHmhnjYtTu9F6GpE9Tq3QyysX5PgAziaI/OCrDuEmL8mLy6hZawNVj5zU2+Xnkp
	 8U6Nd0fcpUSyA==
Date: Mon, 25 Aug 2025 09:36:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Andreas Klinger <ak@it-klinger.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Haibo Chen
 <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, "open list:AVIA HX711 ANALOG DIGITAL CONVERTER
 IIO DRIVER" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:NXP i.MX 7D/6SX/6UL/93 AND VF610
 ADC DRIVER" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 2/7] iio: adc: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <20250825093622.68c8e5cc@jic23-huawei>
In-Reply-To: <CAFBinCDDMo2Dm1UAoB4QKyf-KKoRUTNNg4i7Qh_vgZh71trMNg@mail.gmail.com>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
	<20250821080723.525379-3-zhao.xichao@vivo.com>
	<CAFBinCDDMo2Dm1UAoB4QKyf-KKoRUTNNg4i7Qh_vgZh71trMNg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 22:31:51 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Thu, Aug 21, 2025 at 10:07=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.co=
m> wrote:
> >
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.
> >
> > Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> > ---
> >  drivers/iio/adc/hx711.c           | 2 +-
> >  drivers/iio/adc/imx93_adc.c       | 3 +--
> >  drivers/iio/adc/mcp3564.c         | 2 +-
> >  drivers/iio/adc/meson_saradc.c    | 2 +- =20
> For meson_saradc:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>=20

Hi Martin (applies to others in this series),

For a comment about a tag please use the style submitting-patches suggests.
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # for=
 meson_saradc

Then the tooling picks it automatically.  Sometimes I remember to edit comm=
its
to tidy this up, but not always!

Jonathan


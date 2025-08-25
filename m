Return-Path: <linux-iio+bounces-23191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CFBB339CC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121D2171803
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D202BEFE8;
	Mon, 25 Aug 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBAHoObe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE72BEFEA;
	Mon, 25 Aug 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111305; cv=none; b=nSY493xyrr/7N18Ls5i4xkfaPvBwY0hazhAC7/7kLQkF3lj/e63s1uMvR7cieCP+h1b52wsmjRLupFhdsvZi6MOUZ/QCDgFQ88iHmCKiQQbPsRPfQFnOEucHRZPar5DUk2YnWZujqT9zW4K4E5BbAHaiEBqeEkzivZkj+wbuRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111305; c=relaxed/simple;
	bh=K2j4Xg82+Ip2/lcscGXYAAN0FTOLzSOwafKLqgXQ6dA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLr9raEOsGGqCZ4EY8xhDvwCwgs48nK4ba90RNpdtGswlXId2sqKB62u8AVOf1O0hqwDd3WGqTqcmH7+My923NNKbIwkXNG1dILJhj2PqTEN2ebmcEo4EUqa0LT+bjNfA10lx8MWVCqtsNiibht1uFNjIMFUbKVT3Q6dyliOH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBAHoObe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E789C4CEED;
	Mon, 25 Aug 2025 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756111304;
	bh=K2j4Xg82+Ip2/lcscGXYAAN0FTOLzSOwafKLqgXQ6dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZBAHoObexxJACm0CyT3rWXmTuEE3szQxoY+ur1d3YdWHQaypq84Bs3bw170XTdiJs
	 Fbkj+dLEIluoQjMCiePR3+JYeu2vjM/kZ5FUo4gmjOAVjqhrIrxUIsYMfm0z55V5z/
	 fs4QYjZqJi7rxJ5VxWWchq/yTvwSj7xStzfihEv9Y/SsfJc5slYpJUGrOf93HPIvFL
	 a0e7q75do94CVIMGHOgJ/VpMIDC2D7nFQOtpeEnLr/Hwr8tUNlSMSo5UrwGktdFcu5
	 gPtDrlIV1iPA+gG1UmsY6pAtRTF1+7Jm+owKUNZpYQ3OlNR15vKbyaHqY2irS2NWEi
	 81EoJrJwx/hEw==
Date: Mon, 25 Aug 2025 09:41:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>, Haibo
 Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Heiko Stuebner
 <heiko@sntech.de>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Gustavo Silva <gustavograzs@gmail.com>, Tomasz
 Duszynski <tomasz.duszynski@octakon.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Crt Mori <cmo@melexis.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Waqar Hameed <waqar.hameed@axis.com>, Yasin
 Lee <yasin.lee.x@gmail.com>, Julien Stephan <jstephan@baylibre.com>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:NXP i.MX 7D/6SX/6UL/93 AND VF610
 ADC DRIVER" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 0/7] iio: Remove dev_err_probe() if error is -ENOMEM
Message-ID: <20250825094128.7d2834fa@jic23-huawei>
In-Reply-To: <CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
	<CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 11:13:00 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 11:07=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.co=
m> wrote:
> >
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'. =20
>=20
> when the error
>=20
Tweaked and applied.

> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead. =20
>=20
> In favour of this series,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> (yes, I indeed looked at all patches in this one :-)
>=20



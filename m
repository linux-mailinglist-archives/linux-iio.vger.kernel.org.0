Return-Path: <linux-iio+bounces-23253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E71B34536
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25FE1677EA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE612FA0FD;
	Mon, 25 Aug 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlRrsJYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A712E0921;
	Mon, 25 Aug 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134406; cv=none; b=GDLMW57IDrIupJEhDmYg1SIPVqfmyem5cnNc2cOgLMupgTvZoGZ5WoT4N56tRdCgHdmCwy8hTYM/ZvkuvAMD4Nyi4JFSSRjrGyv9/Gbdvd/Z0PFVoczmEw6F7qa2mpO1a1ZWD7wdeQpVGAY5c+QD4DW9enjqUmaYQQbK4qObCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134406; c=relaxed/simple;
	bh=IEx3IdPUhnV7OGkpnwVUrIgWfs2rY/cYnWctQCEEJ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzxV6PLTdw/szMxT/lItxEzCZ+Co/vlg+n8Hfpes7SNYkDweQKv+/l4G2nnAEtjtJRxhZudiTRAi7Kn5+KigjHqDifqP/NFfa+sfnWIaYcFmCSOTJeCGIqXsllFWeaoQ2j4ag9pIWvhdkgIYE4UdaemIc7YORD19oOHmvgpJhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlRrsJYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B59C4CEED;
	Mon, 25 Aug 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134405;
	bh=IEx3IdPUhnV7OGkpnwVUrIgWfs2rY/cYnWctQCEEJ/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlRrsJYhezCzuHJ5a+MGB50ele/+stfeexSys4m2CimEgtgYnb6qO3lQbtEelF2XN
	 x2r8ZAIgel4ZkWILiruJUWd8BKxMfHkrmJ/tbQbZfZSvUlUkNRSCWbfXb6Z0yyslHr
	 FMBldh/aW0/Y5qy3d+4ZH/b6J01+zLvlYisLdczp2MJMfidSxf9qu6Svf1AHqComgZ
	 Fy5LGqmlD36AF7H6+DAh55YYeGSxLbX/SUoYwwNAhWWL9LOdjkpCLEJ6flwj+5OOt4
	 VdY8mARebFa5oyr28ThqHAzM9j+Xf8ouBCibS3HjpjuDikTcpXCoE4kE6o7PcnPm6D
	 I1O+d9iyK7BMQ==
Date: Mon, 25 Aug 2025 16:06:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Cai Huoqing <cai.huoqing@linux.dev>, Haibo Chen <haibo.chen@nxp.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Rui Miguel
 Silva <rmfrfs@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, Andreas Klinger <ak@it-klinger.de>, Crt
 Mori <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>, Julien
 Stephan <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, Bo Liu <liubo03@inspur.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Sean Nyekjaer <sean@geanix.com>, Frank Li
 <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>, Rayyan Ansari
 <rayyan@ansari.sh>, Gustavo Vaz <gustavo.vaz@usp.br>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede
 <hansg@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, chuguangqing
 <chuguangqing@inspur.com>, Shreeya Patel <shreeya.patel@collabora.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, =?UTF-8?B?QmFybmFiw6FzIEN6?=
 =?UTF-8?B?w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, David Laight <david.laight@aculab.com>, Jakob
 Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 07/12] iio: imu: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250825160617.3ad85902@jic23-huawei>
In-Reply-To: <20250825135401.1765847-8-sakari.ailus@linux.intel.com>
References: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
	<20250825135401.1765847-8-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 16:53:56 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Applied.
Thanks,


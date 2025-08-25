Return-Path: <linux-iio+bounces-23249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4118B34519
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ED71B228A0
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B362FCBFC;
	Mon, 25 Aug 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3u/gidg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25C227E82;
	Mon, 25 Aug 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134169; cv=none; b=B4gAfrx4iaotbiFgCB//hoYyBkUgOPC8oETDivPOZzVWVEFVuQ5z6mh+JiaMEMuENpXoI3rrAPCntGVnBjA9HY2PZcIq2tDo3EmYvdCgdxxj/fTD5zZDxxunWKD7mVkLe0rm79R8F8klxpPYEhlDjIfxeviutmAr/86qsxnhFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134169; c=relaxed/simple;
	bh=c5D8FclPtQXAowZ2nvtJ4V2evDaoYK/2G7ulPfDRYjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQQMlVlfgva2neOkw+xK7mQfoXLJ1o+XTHe3IwdMo/+JMiY7usQDMuI1p2SHJdWMRCTYOLFvtCCF4NUX4nnlpkJkImp+R5hm2dxjEYSWYXUwMDmBV7edknaokMkCK1hQJM8pj/zWIM3v48FVZnkNi95DeJiues2MeW/NDcUHSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3u/gidg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEF4C4CEF4;
	Mon, 25 Aug 2025 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134168;
	bh=c5D8FclPtQXAowZ2nvtJ4V2evDaoYK/2G7ulPfDRYjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J3u/gidgKTN7RPiptHCLKnm/D2Tvfl7+fQ7U1ZGbSA3RCXxFsJ43JkaEE8SLN3Kcw
	 s/ZzCIZw42W3bKMCN/5ZVs8FUmSEw7i5wFH+5djwjxrUyadzg7EUj9oiE9Y7HM18Bj
	 6+TFw+dhH/+Wjfr2wT5VrEJTmHHi87KKQpSBQj75NpDRDCB3GcWDBL5J8Zkj05oBAP
	 vXV79+CQFU2n2DSllsB+PB4E3CT0ksUazeXbqQNAaExBiuh/XoxnPTjUn2o8KQ/yHH
	 zYHIHH3Knd3v4iXmKSYwwtwsJ7Gv7OEgQetVMEJe2on3q/EopRS5vsYbDPjgvCqL05
	 JFeRQ3UzQ+XQQ==
Date: Mon, 25 Aug 2025 16:02:20 +0100
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
Subject: Re: [PATCH v3 02/12] iio: adc: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250825160220.438272e4@jic23-huawei>
In-Reply-To: <20250825135401.1765847-3-sakari.ailus@linux.intel.com>
References: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
	<20250825135401.1765847-3-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 16:53:51 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
Applied.


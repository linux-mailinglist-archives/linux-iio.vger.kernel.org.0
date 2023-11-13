Return-Path: <linux-iio+bounces-48-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8817E959C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 04:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E8280FEB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 03:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF8C2D5;
	Mon, 13 Nov 2023 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea8hxNwi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B38F47;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30071C43391;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699846957;
	bh=jdxeDVtgM5/V3SaVfri5ZhvhnazvM3zMI/UV31SAZgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ea8hxNwisz1LC/1DzBtjKwF55VCjbDAlXbgbnY45zFxU2WoW0zsWunTZmPaVRAsLA
	 QJVKUKpitKTbZgtNrsWEeapO9yD0BLH5nWZdygQvmoxqWjiYDi7mXbWyFQGnPY9uFm
	 ysOFDGLvKa8Ut01D53wuNH/MjQMgT0U9BJUKXrFQZZkE5os7Kqj5v8hQIXF6x8Y7Ik
	 DPFvCHxRDQK4+Mc2QMy7IBUSf5HjkTjEQPSMjV/VpAcEmMtnjuPqXNCloVYyAK6fqU
	 qErzOeo2HHErGox/8maRe/4DiNSlfXMO/woseQri91k++DciByjTKNswmtOUiirZWt
	 EpeJnWQEJISpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AB63E32712;
	Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/49] iio: Convert to platform remove callback returning void
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <169984695702.27851.17182787496510678882.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 03:42:37 +0000
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: jic23@kernel.org, jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 lars@metafoo.de, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 kernel@pengutronix.de, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org, eugen.hristev@collabora.com,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, ruanjinjie@huawei.com, robh@kernel.org,
 heiko@sntech.de, yangyingliang@huawei.com, wens@csie.org,
 aidanmacdonald.0x0@gmail.com, andy.shevchenko@gmail.com, rjui@broadcom.com,
 sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-samsung-soc@vger.kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 ak@it-klinger.de, cai.huoqing@linux.dev, haibo.chen@nxp.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, gnstark@sberdevices.ru,
 andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
 linux-amlogic@lists.infradead.org, sravanhome@gmail.com, jkluo@hust.edu.cn,
 dzm91@hust.edu.cn, avifishman70@gmail.com, tmaimon77@gmail.com,
 tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
 benjaminfair@google.com, openbmc@lists.ozlabs.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-msm@vger.kernel.org, marek.vasut@gmail.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 olivier.moysan@foss.st.com, fabrice.gasnier@foss.st.com,
 zhang_shurong@foxmail.com, frank.li@vivo.com,
 linux-stm32@st-md-mailman.stormreply.com, sean@geanix.com, trix@redhat.com,
 jernej.skrabec@gmail.com, samuel@sholland.org, rafael.j.wysocki@intel.com,
 damien.lemoal@opensource.wdc.com, broonie@kernel.org, idosch@nvidia.com,
 daniel.lezcano@linaro.org, linux-sunxi@lists.linux.dev,
 dmitry.torokhov@gmail.com, andreas@kemnade.info, peda@axentia.se,
 vz@mleia.com, ktsai@capellamicro.com, bleung@chromium.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Jonathan Cameron <Jonathan.Cameron@huawei.com>:

On Tue, 19 Sep 2023 19:48:42 +0200 you wrote:
> this series converts all platform drivers below drivers/iio to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side. As all platform drivers return zero unconditionally in their
> remove callback up to now, the conversions are "trivial".
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> [...]

Here is the summary with links:
  - [45/49] iio: proximity: cros_ec_mkbp: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/2df694f710d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-iio+bounces-21187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96DAAEFDD5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC55162768
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9F27A10F;
	Tue,  1 Jul 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QBUjHrgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A427874A
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383029; cv=none; b=Ifl1c4AbaXDPqJ87cqLFcAyEmzVeIDk2KYbzbdNWv7kHr4S2J3wodcY3w+2JOtV67hQgqVn+o2zx55DCiunF09iz39K8W7vBTgQR3qoDrsQFR62kUAg0JRQTlncTXiL8jR9RPGUs6YgWKCtV5r+DSrG1nuna66tK9KMVRMUxK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383029; c=relaxed/simple;
	bh=UzPkDkcjv+i8GzG9JMJlLQc03B+nxyKMyUaYhYyrDlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu2DFRvJoom1Gl/VkFNJu1Y/zboaoRFNGWtOyT031PqzwS/NvvtgkjGWUIoR+IpVJ+McEjBXw9LXbrVjjtLD+QAQLSLGooNM8RcAGt6nmTrTvSFim8vLfNdIsdLWYLri05J8TmQLaQwa7WZIAqbXApyUakzQB4TyTjPQtaYXBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QBUjHrgj; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2efc0ed41efso1755371fac.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751383025; x=1751987825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kto2WDWq8SXrCfQMl14bP+htdglCH2HfwzImspNOE2s=;
        b=QBUjHrgjD67guZZCnvGCf3qcjC3trXQ1T4MfucAYArFCASgM3v1RpQ1cx1Pq4fnNE4
         6hnTPC9qmF7pL7My2l/a9II59dDYTL/Vty7tUMK00PSi5j7ArQ5KHO7HQqdLPIZgIlsP
         ezEM9+j6JU5lneOSu1X0ZoTj26KO50mVGgsOaA62RlbFnJ0n8Juo6lKVG2DkLpUJgkoN
         OiGT3nWan1qTs3y1Rjz7MDtbYOomiXQ7jFaD9c8PN4Fc34xW3znQpDfMSY8z1Q/7jUap
         pM80IbP4vWcPHfXTpUYCrHFpZ5ypDZggvY6zRyl+RZPa9z1ZoyVZ5EVMKR4sIdJq9dwO
         fTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383025; x=1751987825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kto2WDWq8SXrCfQMl14bP+htdglCH2HfwzImspNOE2s=;
        b=KcZQIQhDOKQlLp/UXvDTreUNaTmqDfCBeQ0y46/a3BrQisaydWSG/xxVOR0NMaiZ5Y
         gMPg3VqNPEG8Ot7CNLGNP7FjdolUuIQkFOGWh7cLiAJA5tLXGPll5OH4pV6oZx6yXwxn
         Fe9UlUIlz9sHBHt59UV0JYmex7y/+YfmDtIF19/m7CSQsATxMZi4K44G1lLHM6dP/jle
         0nxd8aVVz6dx3l7l2iu6gsj4wdoMvsXSy2conbVRp+rHdqaReTFrqJ6XwL45YrcbMgFj
         n2bhJkv5xs2IOOnh/AOoLpPT/nVjQHuTCyymgA5yqFw5I9UyHGSPSHRPvrIqgPHpmekS
         qigQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9zP5MzPCNOWUZZHVAITSjf0KQAD7jBvMeCtgo4wCxf5GouF+4SVtVkqIKC7WJoFUGqvNF+ga+wIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Z4hM83ohxx5Wr5lyYw8PykuR055rfs84y4cECoob6lIyuc+E
	aOWGim4mHSxHTqSMF0ARk+l4GNY2BKeEtKeFfIbYxgDg9ayC5ZIj6ydK3khSIpxTRsk=
X-Gm-Gg: ASbGncul/gtn/Aq877kBnww/+wqAke4yfnK11PDnDM9yznFu5DKNnhgAfmlfv0rSIeh
	GaFax8/NYxOC7SCgAsY+egmOGG/3344/TLEMF+ZOgDs2KMdjB1KDbPlRSwt00VvS++T2VxUOPnv
	FyjXDB/FYicH+slLoGfukmdOCaD45gkxWsJf3MFjPLFwNTMVVnMWTvJgMfnKz7e/KUcGddH37YY
	wYKwdDT20efn4CC6hLiOhyMMYlxDBXKR5uA4LTdf+URtPEwqWE5o7uCIZDQiMQ5bERNJqFM3X27
	YQCGV8lOgkErPgyGtns+pA2qP6O8QlaQpQa1c8BZZk0BH0BovRep4Ulo9D+Yi9TDQNwW13SE6lA
	AhTGdDO9gtPyYVs1yyZcg6JlOZW9As6yw1tKRy/s=
X-Google-Smtp-Source: AGHT+IGFKFZEsYZ4erbtAtqvl8tEHdHdyZFtcG8OKzWXPDqsQnJB5BtiKcEBEjaczDbwqY+Qnse9tA==
X-Received: by 2002:a05:6871:82a:b0:2c7:6f57:3645 with SMTP id 586e51a60fabf-2efed67879emr12142176fac.18.1751383010329;
        Tue, 01 Jul 2025 08:16:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5? ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50fb14esm3319606fac.42.2025.07.01.08.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:16:49 -0700 (PDT)
Message-ID: <3df2c424-297e-4538-b350-5c465b22fa39@baylibre.com>
Date: Tue, 1 Jul 2025 10:16:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove error prints for devm_add_action_or_reset()
To: Waqar Hameed <waqar.hameed@axis.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>,
 William Breathitt Gray <wbg@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Peter Rosin <peda@axentia.se>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Heiko Stuebner
 <heiko@sntech.de>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Song Qiang <songqiang1304521@gmail.com>, Crt Mori <cmo@melexis.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Karol Gugala <kgugala@antmicro.com>,
 Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>,
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: kernel@axis.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
References: <pnd7c0s6ji2.fsf@axis.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <pnd7c0s6ji2.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 10:03 AM, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
I can't speak for all subsystems, but this would probably be acceptable
in the iio subsystem.

However, I don't think anyone is going to accept a patch that touches
all of these files at the same time across subsystems.

So I would suggest to split this up into one patch per driver and create
one series per subsystem. This way, each subsystem isn't bothered by unrelated
patches that they don't particularly need to care about. And note that some
subsystems like net have additional expectations, e.g for the patch subject
so that it gets picked up by automated tools, so be sure to check the docs
for this.




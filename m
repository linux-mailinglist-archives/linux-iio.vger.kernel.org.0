Return-Path: <linux-iio+bounces-6613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2691009A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 11:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99A828420C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E91A4F10;
	Thu, 20 Jun 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SJ9C2RT/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FB1A01B9;
	Thu, 20 Jun 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876520; cv=none; b=dYE9bQyDzoJQEz/egvLziA3zekHqFvI0kq9XmFB3M4uBI0xMB7gBdhBwv0BAJig9+RkTmD/6YV+tU3fE5q39C2LPVp5uFFxyJmzvi7vVWyONi9vyBfi/y9LrpUYLzN3fSVvwxookCVGoxIAzhxGLHOildy0D+G0ujqqps0tNXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876520; c=relaxed/simple;
	bh=+XomlozgwEM7W7jw1RV2XyzUdCf14DpPm3CMqpPk4RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LDAHnCzesrn5y+OqLBaTm09hAfs9b0k7viiHriJnlkNQsLKM2ij3bpmVkSj+iLTP/xrkhLug9qdT4IXqV0dlT47+FrDmfU8u84In0ts/kzdEfLntJ5NA6DtUM2sr4R7Lvxyz38ZZTbq8vKaacQUuw4dnnnM7Bl7+0uKNk5R8iyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SJ9C2RT/; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 095FB10001E;
	Thu, 20 Jun 2024 12:41:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 095FB10001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718876507;
	bh=eHWSHU6IOFj9d81lzeTSCSoajp29AFtL+A3T39sy4lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SJ9C2RT/3zxNcETOlA+R7zdR9bgqCBWrTAJKs6yKjHsLD92MS0HKFRJ6tgF47uJdC
	 2D8JzU4ZBZKqQnlDmhNQ+jJtM1LsUuZBkWCbqfNu2SC19RrO0B826IIgjtAkuiNku/
	 qBYufLJfpgbHyadnxpSGN91F/1bTEMqag/3CjsSxfsBxyU+Hzwmh/fAn5uZs9e27rS
	 8oFLwkDs8ETXGGDo8UvUi5s1W0z8adnonSe/14p0m+nKmy8Hi7+NN62ydlW+kqKcR0
	 rpbSQTmuo0fxX2N5/quj+Z7SS1mGSIC/X9sZm23PbhFf7smSqqyLTNQZASjKuMF15q
	 OepCAAht5MUOg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 20 Jun 2024 12:41:46 +0300 (MSK)
Received: from [172.28.129.141] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 20 Jun 2024 12:41:46 +0300
Message-ID: <dc787966-2920-459f-b091-ce09fe97315d@salutedevices.com>
Date: Thu, 20 Jun 2024 12:41:45 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/41] iio: adc: meson_saradc: make use of
 regmap_clear_bits(), regmap_set_bits()
To: Trevor Gamblin <tgamblin@baylibre.com>
CC: <linux-iio@vger.kernel.org>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>, Fabio Estevam
	<festevam@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Chen-Yu Tsai
	<wens@csie.org>, Shawn Guo <shawnguo@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Linus Walleij
	<linus.walleij@linaro.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Saravanan Sekar <sravanhome@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>, Lars-Peter Clausen
	<lars@metafoo.de>, Kevin Hilman <khilman@baylibre.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>, <imx@lists.linux.dev>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Hans de
 Goede <hdegoede@redhat.com>, Orson Zhai <orsonzhai@gmail.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
 <20240617-review-v3-13-88d1338c4cca@baylibre.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240617-review-v3-13-88d1338c4cca@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186025 [Jun 20 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/20 08:22:00 #25655230
X-KSMG-AntiVirus-Status: Clean, skipped

On 6/17/24 16:49, Trevor Gamblin wrote:
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
> 
> Instead of using regmap_update_bits() and passing val = 0, use
> regmap_clear_bits().
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Reviewed-by: George Stark <gnstark@salutedevices.com>

-- 
Best regards
George


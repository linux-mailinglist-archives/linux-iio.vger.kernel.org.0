Return-Path: <linux-iio+bounces-23743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164CB44FCC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46825B611D2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD42EFD81;
	Fri,  5 Sep 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lflsgA5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0D2DC331;
	Fri,  5 Sep 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057183; cv=fail; b=BseGrzaQlXh+ej7lwuJDLU0kEAjsY/orE+ZeLFkvGi9qN9mJdXrZZxpKanyT/CKeATDTTgxRo8WEFXmR3w1t2FmkxhK8/g1342WYkTX1pUi+1V8XErYJZbdmRxx8KyE/9DZcTApEvtKLWHLtug5iwgSdv31CX7RJ3GK2gpnOwvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057183; c=relaxed/simple;
	bh=r9j4MHMP1frpAu6CCEy8LO5tJf6bcWqbsNBBzT5di2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aw975ipERGlWykC1Y5G7NwOKbI/BRGVYZbyOTvmPYf6b1wHUY7MEw/qOfSA85PH0yugfnKNTnLm5+D9IcIkkkCi0oXqXIpvc2c0TEpVl5Rlap+7iq01RKiQvb2Y7CZm8+hlcP3ZUx/YUD0Nt252jrXBVAEMjmOvmoyrdvTd9OOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lflsgA5b; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8cMq0Bj+o+QcjKEzp7AxL8C2x+iChyt83TFGT6uySsuqTcfqB1B6XjPGqRuNByhQX32H5XpSwzivzTQV5wfPVTwQvQk+HlJ1LUB6rpCX2cKlgr/MMzkBQ9vkFzK70BMdy0Uo6G4Av6J6hPz0AreaewNPsSfqFWa8LUYQAOUuCRIc1ADKuJd0+HRdpG9nP8eugNdtZd6FyrIjVw2N/sd+QT/ihqu2o5mO807c4krjitXhdF1RnvlAC2e2cRdVv9tzlSZ+cocsc2AgE9zH4Oe3xWYQN6cUK5JdE6Bx/w5q+wzkrtSGSVPtsDL1awSfy9v/5FgnTBzXQJfzw/QSfvHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SffeoXp5Xqg5ye4sKIRVDh/I2EcrGLSlkVbdCPPN1eM=;
 b=gJHaKHHbWzcEdfqCMSCYVfJcCc4SnLMtiHBAmhBGUsHZsyYxM5VyHhyUuVzQPM+uH5BnrFn7Y+4n0jhA/upQrCRg29jbbK4qR82/QdaG0glcG8ELZnoIZdq9DhVLFDjLy4CEoIRbo60tDYOTs/mrVl6awoEY+CZ0cKB+wJpNWY38DAx20A1s+3pB1LtoAIHjPPg/fxZeQYX3f/qzFY4G4JM7RPhE7oP6/qBROP0Yjqe7qk1RG2KlOgUiSgjabDb5dveAo07A6DKjSClrc0gOLydVMqiSEbNp8/6JEG8Du7wTdKAQoCX5rJ0Ji2XDevSRcpK2tprU7b+c+Ys8u9VPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SffeoXp5Xqg5ye4sKIRVDh/I2EcrGLSlkVbdCPPN1eM=;
 b=lflsgA5btXkl0flA6ZddLg9rRMuYMRL5Hy2vLr77D/n8zYFSpkf6a4X1OCSgbxmBHRvQBFPMYMPy3ySzCnbE54EhyiJOBfhHKHXeeS1kDBgQ28jSBsCEIKwBcX0zqI0lIc1931m4v0BhK5xPH28t+QeZyQtUqsaQwDDj1s05MhK8okGZJguHhsFi7AWwYQ3xe29FO+1blkyjaVs+miDTiKPnnV78AvwsHyXNE/5kNQPebd2lrSozeUMtrrSd2Oi6r2S5XubYCe/0V65gRi/mXuGYgXk64/dep29qDCCTO4EiMRGyZQonGQoC7tScYs0PkU/+IDdkwKtCDPWW1Pvb7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:26:18 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:26:18 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Talel Shenhar <talel@amazon.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC SOCS),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL DRIVERS),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 03/12] iio: adc: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:23:55 +0800
Message-Id: <20250905072423.368123-4-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905072423.368123-1-zhao.xichao@vivo.com>
References: <20250905072423.368123-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|SEZPR06MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 16442944-1ede-4f3e-cd0f-08ddec4d8152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3cExIArm0odrmTh2KkGZyP1KHrkzD+cAru4E3aWshu6ymbysQ05c4KHMwNq?=
 =?us-ascii?Q?7XWIfqQXmI019lxXJoZ3SRVICYYeliQRtE0/9EXjbEs7TACmiYBVOGSNSlG2?=
 =?us-ascii?Q?q5eptpT8ui5cWQxACis7znedsq5N21ANx6ekh0lL8mNN3/HHmb3gOcxa9ofG?=
 =?us-ascii?Q?DFErplMjvBYa9vIoIbhgHZ+lTkKeQbG7K6c/4OhxiBlZJFR07ni/QiHQSF3l?=
 =?us-ascii?Q?oFPgdpmh7/loixB+mscYQHB++qC+MOjv+ffE4zbAl5u1ghcaL6E95Z4TOJuv?=
 =?us-ascii?Q?jl29VZQF809iZcjpmdvP6hAiewzgOl7mEnSiSy+8tS/KQDohveT+bkHtLvRv?=
 =?us-ascii?Q?96XUkSorw4HXc5k+acEDP+vMaW4QMqSgVWsmd/duVN8lxmwCMEoZlb92ZN1a?=
 =?us-ascii?Q?gUF4W9IH3T7gkvGpr0sk9K7NqG1fCmVjUZpzKYodQEUpbZhdYNzW+19r8Kqs?=
 =?us-ascii?Q?TXDl2NO4MBaqLZVXQMl9Z3dSgz5STk3hNRxiJP7R06HvXL7+3et9atiu8zMY?=
 =?us-ascii?Q?UElDkB2LEfU3dSLpyLmldHr/DkA6p6zvCDY6PRCt9Bo4WubyyXM2IplBFQlm?=
 =?us-ascii?Q?ILEPOeRSrMHU3fL41JqaKdRVFxXLmUe4opWm7ZDrtTJ8xWDGWh/juR7hhbkB?=
 =?us-ascii?Q?uzRgb9Vv5kr10+e+zcdFqXwKge5kaygHkcTwa5aNdpnWK8FDvAeu5c/9xBey?=
 =?us-ascii?Q?5YXVfuHdIC2YG8AR6MYckECL3n5favH2CqyYCnVEkldxvYCwF2sqAxLSc9m4?=
 =?us-ascii?Q?4IwO0Ame2eI9VvvmKl5MGKUeIPgGa7YiQ1VnNrXDaRcrWFM7kWCLGoCYyD4G?=
 =?us-ascii?Q?gtP3m2aDgfz9j1I2QHz5bSP2B/xWjyNQzWGZnT/uVx2oWbXGvB80wH10+n6+?=
 =?us-ascii?Q?7+yiZ+HoUO0LgLNlAnzK91AA7883VQV6h3VQ2i+z5Zfx98e73UGi6u8YCW7T?=
 =?us-ascii?Q?eD7aXDfxm9YD81UnDppYfnKSBlLoU9Q7TaiITxqoSyu24ZjTQ8l7AAnSDX/Q?=
 =?us-ascii?Q?RfsV9aYrDIv8PQBMK7inwcf2OcD69YGhlUa9dzTZtjQ8CDIveInz/W0NIZS3?=
 =?us-ascii?Q?wVPNeanWNt10GcsLfOWoV4CaI6RPYNACJKR1uyypMrFNEmdEyXV4RJ8JAlQv?=
 =?us-ascii?Q?0OkhKQ/rSfK03dsNCHiavK54z38ZaeXjz3y5fmWeg9sdKry/AwybGOrtxS8S?=
 =?us-ascii?Q?/9s1YDbT2TETsmku29ZY8vg98hjWBui3l5T4ciQL6fr14XKUoRP2TDufCfZ/?=
 =?us-ascii?Q?T/mQiWQWCx0oaXs0Y3nvJdWxc0r9OZRinv1Z8+a4/iW026MaeANKGPbKBEY+?=
 =?us-ascii?Q?lzptmSx0b2y0RISQC+gFAnEoFVqC8zbK9yNNSF01jOqHjUU0Gwx+w3D0CP4g?=
 =?us-ascii?Q?MhxhFZBmPlbugcSC+aNtsdrMagsijx+P5+TJSQHtdPkH8kltkWdvRpj4g01w?=
 =?us-ascii?Q?nigILdTooGBrO4Umv5I8mCr06LyJU3h5MzlYdP2duuDV38TcIO1KzlIa4aU3?=
 =?us-ascii?Q?3ThMpl3pmBor9y0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WExwYx7nLfVAHEA075Ze4QNjopD5MQzCw5IYpnv1/FBjsjaUlUMXGilzID4Y?=
 =?us-ascii?Q?TCZ/Fqw194u02ZErrNMeD6cgKG1C0wcchX3XCNJHJlvrO6m51enwherwvak2?=
 =?us-ascii?Q?k/qjGkQ8noMT4g1T5R6tFn+z9tg2Lj0MlZlm1A8FoEZYzOMvJkXz5Y38msgE?=
 =?us-ascii?Q?Wyc/DEmW/NzKBOJNl1sETxA/iTpbg6VwGrJ3yBZWm2pxQFoSvKfA2qHArDWa?=
 =?us-ascii?Q?ftqjKiH5h/xuzerzcJFQFwvrE7jkxGMzV2Se6IAiUzlNEIGuADWE1zMsVaFV?=
 =?us-ascii?Q?uQU0w8NxlxddKXIfk7k3AfBApD5NYQsHs3fvCUa3Br7bxK8pz53mkB5Nh6ug?=
 =?us-ascii?Q?xaw2Js5Gw9aBS91DV1cFebEYTxDf1LIKC+k1vdsoDiJVIX7zd1bJU08amUTR?=
 =?us-ascii?Q?Yd0dSyJ/fZGyANKJezerYxVrckgVF+TXTlKDW+Rd2FcvK175w+AjmyfD7aL7?=
 =?us-ascii?Q?mlfVvF3TxAGNpkci/EUzEirA5iqDUZv2mPWFuapJprS61gCzp7e0Alq7MAkG?=
 =?us-ascii?Q?UWH83EyrUR0/mGZBGgA2KG2D+GsYEdiQK/DL49Pdj3KbDvxtbWgDUo8PtxwN?=
 =?us-ascii?Q?ooYLgc6mbUsgS40UZuDWHc6x0f+r2/s+ZGMsQ7qAQaJPz0a1Q7cfQI3xqANk?=
 =?us-ascii?Q?D/GFYLvOQQXSjiHbc/LGTDeeYJuhnXwhU/d1MF6VpEMnyYTJfEqTZX0FRMDB?=
 =?us-ascii?Q?eesNt5VwB54lvasCUT/70jyVb7dNCB5DS0V4LuYE++tofzxm/64QwsJkf6Zt?=
 =?us-ascii?Q?J+slw9ULO2oed7UrAKjh364uxcM/sYiZczsaFhaOiwQD336bkkCS7Y5xCvd7?=
 =?us-ascii?Q?CbfvwOfZcbLcy1xYB4sBeFSeY65P/4O6kQAdCq9h9c2gjNVkrnJC52gWeSdG?=
 =?us-ascii?Q?Se8fJWJCWrtXTaUDvdPjWiC8wO6BzolYJo4vv40RPHdfHVqVnyIO8uQEtvEG?=
 =?us-ascii?Q?bkre2RTdgTc/2x8ydwSDSzirmtDZwDk1wNCBtvihMtvURNd4rHNcoEGKslkO?=
 =?us-ascii?Q?kuiGsW/2WixrAA0C1EAC7dJFNf4UIJXt7hpjmYfmGcE43Y/uRDvj8VCHgJ2e?=
 =?us-ascii?Q?ZkewwPG7ZeuwntzBPRf/LiDin2Px7+ZPNkZfoNTA2diEI70Qz80XNEjKXSsY?=
 =?us-ascii?Q?6ebGPDeCdkwua0o5RtSr4EEiAcy+Au7ZtJqPDP7pils5M9FD6SKQ3x0Vrmur?=
 =?us-ascii?Q?qcXpEF7nUFNxQF4kbFfEkZebh7RMnP967f2xtJeDG65mbRc3BoJOaiWnW8oK?=
 =?us-ascii?Q?ERcAMRRA30dOF9EQGEuiJMOQqorTHX96pyZw0B4oYt0z4cLk8D6WDz7Sbtch?=
 =?us-ascii?Q?XXQ4KNcyw4rNbv+r8wLJGhvKbNStZRApD1BMN/tVWC5U57v6OBDVKSc3b1hG?=
 =?us-ascii?Q?ZOw3WIxYyANu1z4MIC1OC1IB/M3aluuBrX28uYNSKBBiaz9I0VYvORAHC/7v?=
 =?us-ascii?Q?6Fd8Hhz/rLFHeywI1/2pfmN8L3D56eHYbf6l+I7rXSo6ZeOeVfA9y6JR1H7I?=
 =?us-ascii?Q?7OJHFrCZYzYAiAEjh2zfLTAgINOdfyFOuuojECoGCO54qLNqVLu1r0+WVRx7?=
 =?us-ascii?Q?XZpvSX1PLBAUGShG7oyhBWrcvhav9Fc+B4zhkLRi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16442944-1ede-4f3e-cd0f-08ddec4d8152
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:26:18.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFBAP9AyfTZxtYeVmIsq4pApN2kTnxHd1YOyxbPMzxoPXiVm3vgS5hQY8Q7pQOo0CTR9eHAxbOUGoA2BNPuGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 6b8d6bee1873..3b33480813fe 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -640,12 +640,8 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
 		 */
-		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
-			dev_err(&pdev->dev,
-				"could not register thermal sensor: %ld\n",
-				PTR_ERR(info->tzd));
+		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV)
 			return PTR_ERR(info->tzd);
-		}
 	}
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
-- 
2.34.1



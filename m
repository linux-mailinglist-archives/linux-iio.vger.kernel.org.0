Return-Path: <linux-iio+bounces-23746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D97B44FCF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D25B62282
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA42D7386;
	Fri,  5 Sep 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DL5q2NiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013019.outbound.protection.outlook.com [40.107.44.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A72D323F;
	Fri,  5 Sep 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057271; cv=fail; b=TkQEOnkBp3JWamKWRPSQKAfmF42Pvbh7fD0/N88WRoejudy0IOE1rA30PFky0pv/m64VF3Ln9c9gzUt76yjh4s7yN9K+uKq8Mm+U0tiurfq03rrRKX34GLhRSraYkhq2AYkIBDfHOXci/fnFHDmR6xofjskSmzIM+wDNaDYpQPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057271; c=relaxed/simple;
	bh=/dwDErWm2YkzJ21Y7tlDe0PEfmOlNBQXHwLns4rJUJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkxgDc8dwPrSQqbxP7ZH1j6NAD3VcFUVNoi0QTYIG9h9OMV0SNXiFMFtdRJJ8DOqq9uM3178ztFPzji57qlVAKRLFxNbdwA4LDhUG/TtC85UAdcoD5aKDkZpyme6+HSjBk/sBHHGjaGJfh3bZp+ReLIy3Kct3AhCkBNh9EC+Z3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DL5q2NiO; arc=fail smtp.client-ip=40.107.44.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnjO3jEFEoPdsFGv+DT3kKX3P8fZuejkxMgBEjUmP+sgB27pfpIkEOvepIhsISukztoFsRTk8TDGtlFbBOTrM0KqK7clJ0FWoEiZ9brlR9/OOXfkH7ehMOmkX27ptuZk5z5Yes3wkekJBSSrMlBrddXax282f5MBkBrzFK2oyEqaGq09qV7O20TLa8pKDP2jeLfyCsKvOtaixY5yDScitEqkke5fjbzdAqA2areKtD7Mw80ucKMoz/RzvoKmQGEprIoKMTXAxkIN9v9VUM6kJFOe7FayvyIMqCpWPlsjzMG4pwMyV6qr/fEwaacJX4sGr2wbgMfjqta3pvUP9uA97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6mlQVxKsqrYItvzOk89kEV3G5z5dQ31SYBeLV6PVsg=;
 b=lKI7bRdnBPbIc41tMK/jrjA0DJ7PSAZX2ayG3hEf/TaVO12mfPCLWGkVgP8LUompakFF2SeVJmfovnigykLcI7y0OlEemcp5a1d1CI0kT5/HCZFKTaZmJREVB1oFndMV+SHKEjHY6HWEW5la8H64rL6cFN+babhW8CUV8EfwkAavTCTBVhXfn0VMZ2KtTm9a/KSCs4FMYBakMnANSraec7eagmLYZs4zSednjKBAcgzV4+Vlgb3UBI/AU00LRgu+D2TDcA4f1eIXQWLJcoLjTi4XQIuEFUtbZqm2huWPKX/BpVRwcY8BCeL93m0JN8pIBAP/ZpvGGeZn7xhCAgnRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6mlQVxKsqrYItvzOk89kEV3G5z5dQ31SYBeLV6PVsg=;
 b=DL5q2NiO+VtFwX+Xeo5UkFVbC3PzKHSR/66cPr8j3abp+fTSnT0c6ycGwooTmZVrjauNdvq6ATB+Ww0Va7Wm++pnhHjxg5c/mM4a4JcArYldqMf2DTOIUn5cv68Q0rOHOU2D0CFIcC0esvRUbnfmgeIINupTVp+qAFX5zBFdi7RwQLIwhJDccdkL3++GDStemT0d1+wFrD2ELkLBD253kvmi6M8/l45W90VP9IleBOJf6L/WVaXGDyEROQuVYRCM3p3qZV+aVw8iqr960T2cBtWKOL3fj15BrhF42X/yiWfX5lh+EB+/37+Mau+qe9N87IRO+dKnMgjlRMfF7RO7Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by KL1PR0601MB5837.apcprd06.prod.outlook.com (2603:1096:820:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 07:27:45 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:27:44 +0000
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
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL DRIVERS),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 06/12] thermal: broadcom: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:23:58 +0800
Message-Id: <20250905072423.368123-7-zhao.xichao@vivo.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|KL1PR0601MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: a8096567-eb12-41e4-0a68-08ddec4db4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsKJIN553s5qnbTg3yHGm1uN5agbbhVUQNjtMes/j92oKY8B6R1Vmo7Pnu1K?=
 =?us-ascii?Q?9Uz53MrXvZ8eFXVPTGVX0YUUPHvGIyrrPPotl2UhYxyRfo2XZlpfYxhulB1s?=
 =?us-ascii?Q?hOzhiDTOrW4ELIimrllGsZgWs0KHxGxluIsfOPj2DKZM8zG9nGcB3PVh368l?=
 =?us-ascii?Q?A3Hfs4neOnvTIYWUMTohe40Nh7YhaJZ8ZGrBAXILHqekE0WZQpXBa1TRFvaF?=
 =?us-ascii?Q?MSojyoaInSG0dimgu3ur2PZrsBR4eOJmtU8KwnU0f8jDuOmDBOv69dUnumag?=
 =?us-ascii?Q?HvgFnGosFknU+twhz+j/VUjJRfh+6gG7COekGd14W6i5zTee+rlVyja2ev0M?=
 =?us-ascii?Q?PMI/ebjzDyjObVPqovSrMtOgbo3/DawIgZMgQvhfO+pw8uiJ/mlzKVuClXVZ?=
 =?us-ascii?Q?cplOwg8CLUP+nvjvhtyMdtzReNUTaP1CqCoJY1SNjinqTD9mHBdVGUWxUIeB?=
 =?us-ascii?Q?mc9L0WXv7s5VoALTLUyLfrfpfivsICi1Y3XZTCwV2ViwZGReqJeU6Tqq8Q0x?=
 =?us-ascii?Q?0lwOH8ZDDR7KH2Xia95NBMtYO+bHNmGDy3AN2knpyMrHF7ltsZFCxVvaLHBk?=
 =?us-ascii?Q?oF7/PgCLlAG4QbMBZXRELTsSQM11NlJ1FK7ai/5Pz0IsPHza+f9T0V489yFb?=
 =?us-ascii?Q?3iTr3D9vmnBoLiNFQXMD7Zre+/oU24NY0QgaB9X8isEMEIb/74PzvaIwwu2z?=
 =?us-ascii?Q?Cv6NZRuIRbDNt45wj022OCFWKskwx6NgFj/kODMlzShJa+5/EY/km3i9EBB4?=
 =?us-ascii?Q?ak/PozUniqymFeccafA7Rl2cmaMkvyMuFt7pW2z46xYnsSJ+6iDCHk8qszTS?=
 =?us-ascii?Q?L8lra3+SeprCw3rG0N7vwiH25MBPptdCEH4AwAXE9sJfn7bITmTe5qWrgTvp?=
 =?us-ascii?Q?VTX/b6yrTGy1gXEpCiyuREAdnjHgL842chUX71iSS8/lpDEj1pQu/sQ6IXvn?=
 =?us-ascii?Q?A0oMo1NYxTGFp/zZSEQ8crTA0WpCYtsqK5DhtuN5iO4UVp1CSd+j0m7cZ3Ab?=
 =?us-ascii?Q?uy8YArgK/wcC9os3MwjQaCV+mQiFTjM8A8XIC4y5a+XzHkdxqFqV39WC4gTc?=
 =?us-ascii?Q?peOdVTbaY2VF/xSWLkxqbwp2h7RiNK/8byn7fnFSMctMeDvZNVxG4Vvb1FxD?=
 =?us-ascii?Q?PNX2UUWmImYnpRKntnFl4+pRADXYQB8eSp/RTzI/XsZuIlU5Z+P4u0LrfZ2F?=
 =?us-ascii?Q?fr+iUX7AvLCDsYDGLh4ZhWusgm4rJGryTo31L62IpPHPAuDi3I4aBjCzlNDF?=
 =?us-ascii?Q?gPkdoVKj2LTKQ52fqEaCWUAI86CqbQonP1P/R6eZgwKmxS+l9IyGu6fhxnIj?=
 =?us-ascii?Q?KZkIJY1q0coz9icxIAPAVVKM8XT+gxGVmArSAUGCj1AE3I7sBzYvepT5XmDH?=
 =?us-ascii?Q?xC6ghO7gcpPOEzAjN1wL39PBZA+AZNiHqUq3cE4R67Cyx7XrDItHmZY+lq4d?=
 =?us-ascii?Q?9NLqivTc2J1kG+X/Z4RKWM8hM9mShIKogcWyia4dYL/U9CUmt6Yy4RWACcQ/?=
 =?us-ascii?Q?ga6DIf/ly04sBKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuUQEYOIUvGMgqcNdgUgr8kfBgCKEIFyAGL+Q1op5LYjPUZDaryWO34yIqOm?=
 =?us-ascii?Q?MSiuu3mccGEQ1m2jlMMpdPn0xBtyf8V7uHqehfLgPHGysuLtHOzhl+9eOCUV?=
 =?us-ascii?Q?+xP6/JsaX+281ywvx90m40rA2cu9vz8MACekQJ+m9ioCC97wDh8yRdoolYXS?=
 =?us-ascii?Q?dHgq91LN1vEgDhu0w9VSqLY4n0eJ9znkoodKFTUEUYNrX/8c00jN/t7NqNza?=
 =?us-ascii?Q?Vre7ph4eipKcJTBoGo5YQt+Ni9zqS98Ge3vfMbiHSgXnPqse7Nch7qyB0yzq?=
 =?us-ascii?Q?ybMIgV4y8P+5RBiJsX8ZAh9nx1z+mVG7IYFRIQdeH04f1n/nFrUlJEmqAr7Z?=
 =?us-ascii?Q?TGwfZ0qvC71Kl78JQmpWCbwHgc3fHtSdSL9O+1TE+HAhY/piYkCAfx0+P3mv?=
 =?us-ascii?Q?j1b9O7P0gZEXB830V9xiXlJkaLSw2H46xz+MLCot2jHcc5DEXEvvM3nBq/B1?=
 =?us-ascii?Q?OMtNjgC8vha9dAzlI+yPTR/JD5xwyKXvGllxJ2HbS5vf4lzcuLuDg9sv9yu5?=
 =?us-ascii?Q?BCoIHQ/vYCkjt0LbJrGwwVP7xAJyOJ+Z9qGg6etffXaid7AHWUPbmmlSandc?=
 =?us-ascii?Q?DWyDlPXpkV4JPKrnSHJ9PQreXsVbaZP7CI0LPkC2g0uKZAAEwUYCGyyiJ+Oe?=
 =?us-ascii?Q?C/ALfyuFZlI/Ai5F0rxZMPqqBrqVomqFSThysRb8e+A/9J+phiIWWFJjnd7t?=
 =?us-ascii?Q?LWoLDvVaOaHqDc2HmXnRbVgtL/Az0CwwAba+FOEkh9Ftj5ut2hfLYk9//D8+?=
 =?us-ascii?Q?05amWneCaoIYOkKsm2qg30d8zpHZUxz11wkeRE4Nd6ujK/ZOyGfrftDFnqro?=
 =?us-ascii?Q?l4NikrJNLKR2c9SsFCsxb0Vei/HGifF45dMqYj63XPoMdMcnj2NhWxfepTVh?=
 =?us-ascii?Q?vG5z+iUnvUpjYDt0mts8kS2btmM1eeghK3oipHXWULvuydqcprOYImJp7PMI?=
 =?us-ascii?Q?Sw/N+NYGRHvxqSj0DWPOo7TIrdFap98Zc/Ge+qGomyzQ3ib8PxvNuEbHkQTN?=
 =?us-ascii?Q?4qEkWJMOm+qhKaej9PZEDzX8tiSdN4OwYIu3K2tnZRotIto9odT7OMnhz4bF?=
 =?us-ascii?Q?QZSts2IbizL6aWcl0tEKfNJUty/NH+6tx18tLEtmHyQuKx8oRQ9/tlycEjCv?=
 =?us-ascii?Q?0FNzoP5jCwAw6OtFWl6aWKHGRQg5QiyeWX0m+PwMsMBoIjmxR64xgDMgR3OG?=
 =?us-ascii?Q?0e6Y0MEqJ0D+h1hC73RHh/OJUfhRJBs79TFGVsOGAbGkpBe4T9kqmCA92rVI?=
 =?us-ascii?Q?N2i/L0Qh8ZNeq6otlZ0oCAKRUCNRLQq/H7i4zrN7kTANikl7XLyxFDSBZlRZ?=
 =?us-ascii?Q?PPq3awe1K8HwX/JrGv6IrduJayxfizUci74jHBBRWvDSsLGQmPEyzrjbqytS?=
 =?us-ascii?Q?K5jeDJgyoAcILlssR0TkaqcLxJrNu956aNiOF+45ZuLphIIYGJ5jKVOLd+jl?=
 =?us-ascii?Q?VBgG+XcpdV+FZ6SWebDsWcZGDAdf2YJX0zxn3W1je3qNnvIg+xHGNWlrSVbt?=
 =?us-ascii?Q?DA6MXwj/ar8zXmM4260c0Rx9D2ceJtEtIfD5EIcH/IXmRMTH4q6ZEhYigYz4?=
 =?us-ascii?Q?dnqK4mjjtlUkAgS9CT6kmzozenEYoxFUT5ogG2za?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8096567-eb12-41e4-0a68-08ddec4db4ba
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:27:44.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJau9OAJE0qnITzKSg/K4TCNjFRc8u5mA/lVjVX8qcLTZPSZUNY2lYAL8OvAUJOU6KqNDX6N4xQvhFS7vFW/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5837

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 7 ++-----
 drivers/thermal/broadcom/bcm2835_thermal.c | 2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 03ac2d02e9d4..962dbec5e6ef 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -90,11 +90,8 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 
 	thermal = devm_thermal_of_zone_register(dev, 0, priv,
 						&bcm2711_thermal_of_ops);
-	if (IS_ERR(thermal)) {
-		ret = PTR_ERR(thermal);
-		dev_err(dev, "could not register sensor: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(thermal))
+		return PTR_ERR(thermal);
 
 	priv->thermal = thermal;
 
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 685a5aee5e0d..c4205ae68e80 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -198,7 +198,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	/* register of thermal sensor and get info from DT */
 	tz = devm_thermal_of_zone_register(dev, 0, data, &bcm2835_thermal_ops);
 	if (IS_ERR(tz))
-		return dev_err_probe(dev, PTR_ERR(tz), "Failed to register the thermal device\n");
+		return PTR_ERR(tz);
 
 	/*
 	 * right now the FW does set up the HW-block, so we are not
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index f46f2ddc174e..efc8bfd04f68 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -346,8 +346,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	thermal = devm_thermal_of_zone_register(&pdev->dev, 0, priv,
 						of_ops);
 	if (IS_ERR(thermal))
-		return dev_err_probe(&pdev->dev, PTR_ERR(thermal),
-					"could not register sensor\n");
+		return PTR_ERR(thermal);
 
 	priv->thermal = thermal;
 
-- 
2.34.1



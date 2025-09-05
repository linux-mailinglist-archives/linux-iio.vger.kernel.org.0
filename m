Return-Path: <linux-iio+bounces-23749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DAEB44FC1
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B7A18973DD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120CF2ECD11;
	Fri,  5 Sep 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QLWK+YPi"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013026.outbound.protection.outlook.com [52.101.127.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C4202961;
	Fri,  5 Sep 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057356; cv=fail; b=ojDCB+6yao405IboNRxAveyAdkpj9Up5SWtfKk6mb3hROa5b9WiCVwtc9hkYP4TTRLfcL70CtznxRbhvs3JDFvEHIT5/PTWIzzf18nuu53UqmeQNOt/4hvD6+PyogI8W3Qm97bauthoj8n1+fLyPv+Fm2YPB1QLxfajZepststA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057356; c=relaxed/simple;
	bh=5hwRk4aA+UCquah8zYwC8Qr//7FAFgi25em08WKh/wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBw2lVQQo4fzLLfBbABCULDrpeUbkwujrdD/A3tO4zpUAo9yYXQeHedU9DUedyoloti0RMOkEE651MNh+OTUA80J8yIeMxLs2G4q8xB2k9rRGsA4rMUBA6wd4qW8ympFWo4Se0vkprKjjeXOevz61WucDj2ed2axQEdEUuwqHvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QLWK+YPi; arc=fail smtp.client-ip=52.101.127.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeJgSsw/MHVtZ4W74jrOlezyHZZFZQatknzAsBK/IGzmPNWc+CfmXx+8OYk9r8+NoqYy+qni0jraJetfOzlGB8YOwZqk4LHeMwu8c44PSc62syS5WjqV2HIWPVWgzjzSESw+BufJkVBWCjtcQ3i6nLH51/rzE1kjXscEz2BejM3Gx3aADv8wAlpVLix1f6KNnQEldcZwZHViLzE4WVLKCSi2dCqYI+Q/i1kTECxB8jqCcXbTe5NVmLUHy51taSoG04tSgiqSgp4UxoJrC+WyAludSabGmDu8p7e+fw4wQ7ngNKWnZdGOB3aWSrz4v+JiaoBnRnTeyq9fezsrcMrrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVmTOhXyQVe1cZNV+/tK+eAeDAeQlj8+MSDWYDF+ias=;
 b=mw5OuxsmgtmfPEmRoNUGSlpePUismBvgfc1KTSQqUyRNID+mSkO8/WscOXo1rq0f4LfG1bo6KM/ddRSqV0oyVn1S09Vw3ZapRZ3UspMR0NvifDSroiK3/SKqlCnmL0AiYUsa2RdA4X/wU1CGuwVUWE3rqN+VOtMpHUgbI95OXQIEP2pi6oiwIWtvtzsDQnQeZOJMLBezsph9+2v7VBy64Xz0p+ocw2WrjEIrp0KhA5hhgLcjqWyYRqX7h2YJ7Iz8znkE3LHNe9sCqwjfu3+eBvuyMs33zV5WM1KB38bRojLIA1tYQzlB5+MvFZ9S5+5+3EOf1Yn4+M5BxTUiX3uIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVmTOhXyQVe1cZNV+/tK+eAeDAeQlj8+MSDWYDF+ias=;
 b=QLWK+YPi5s8YmAUNOP7C47MX5lMlytxyuVlqd4Bzo5Ealle7BCST2RNx9rlA5dh24r5B9QEBCU4w/x9D+ajHwuJY0LPPv0zvQUvtJ4FM+VuuSzYR7fBj+4pnkSf+W5Jcidy5NndKnaKx7ZwFpmI0urQnPNSZiZTzgFhQj5ZW6tuBBB7OZn4HBVqEuu6OA0YR5K59oYCEsjtCtaS0DDu/S6JYia+t/844Vzmqvym1I+hFkQGkkwEjMdcE4ugsLx6ZaLcPcgOfv0C3PHNFdUVKSjbcXaaNaP9mkZ3RlRDFFRjY+Pwm1BO7Rnks2sV2c8reQ/iDxQPUYq9w52tHIRFbug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by KL1PR0601MB5837.apcprd06.prod.outlook.com (2603:1096:820:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 07:29:10 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:29:09 +0000
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
Subject: [PATCH 09/12] thermal: samsung: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:24:01 +0800
Message-Id: <20250905072423.368123-10-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6256bb78-1f8a-4586-f5ce-08ddec4de763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nY3oRECWPC0dphInSc6sZYbK/WCc2dxHgAH22wufuFHZbwohrOroX0zlpQhE?=
 =?us-ascii?Q?xy8NbscTsTZEld6e29tufmpzjcUVjx/YZZbYvzjnGgGu0SwX8s7o+wJ/2DVc?=
 =?us-ascii?Q?GurrQs2QZwh/3RFAAcBh1xDZriUzW40AgcOPXB2db5TwTiTRVFhPr9vKRXGi?=
 =?us-ascii?Q?mfRiNK6WMnmwRYegPgUHapjbGjDyWvl8BSKNPZ3y4pSx0kN8RS1k4xZxk1wO?=
 =?us-ascii?Q?aAWTlEaLkdNbLhkY07fjezyuVbW4+oHao7t1uN75OgJJsZLr5KcW6s/ucFiP?=
 =?us-ascii?Q?2jjyA1eiQerMooL/Fdvt/ivfZ7BRYm5bWdpp1gGAmEW25SxJ5Py1UcY4UjGE?=
 =?us-ascii?Q?z87a/AGtAVI8sS0pZjHCYKPtaVFrimbCwkCIFlpUyJsQpRsMC0XtjByoOQ6y?=
 =?us-ascii?Q?wwVbnd13XlNSeGbaJrtg00AYKtigDGjCxIVIQcBb92MuE2c928WsFfQXyml1?=
 =?us-ascii?Q?pRvl+30hPi/Qu87d98kKsdYBmUF/c3wdgoKOE96ydDRh3rCxNtfJLH2rM6yo?=
 =?us-ascii?Q?FCLVgPPLVJNrr6aTH2IRbDuJyZsJcJ5YNKdOhZKcaJIoQvkEt+OKDynGTCQ+?=
 =?us-ascii?Q?6NxdjJDj3NmKzwkEULW74p2b+5clxRHzmuuPR1ysJtbNkiJjsZfPutqNOaYA?=
 =?us-ascii?Q?h0t4Lf4ALCBiHvQ09a7Yv5qQQAIkBOM+Gc/7ZzsEN0d/1TNj2zvROUnY4cVf?=
 =?us-ascii?Q?8vjYeSkci34wxqRR1QT7fbmKl0sc0fYnFC8UIhPd8Q73r6KN9GaakMlJiRQG?=
 =?us-ascii?Q?RzgkvY3biZItbNsxltAhKgaJJbPKekHCsjhYn9R5fs+qfN9m4oQA26MoiFGP?=
 =?us-ascii?Q?XVjV37LCZ+H4XayhL151aA95H5D1Oi8ol3pdE6Nxi826CxSPq0ddNsbuTV1G?=
 =?us-ascii?Q?hVAEmLvCvTu4vsFv+y3d7mC76QfPo4A6X6nnK9ob9D4IAy0NhYe3Efix07RY?=
 =?us-ascii?Q?ChV7zxazzdJk8JYuuFRNYm7OtHyza3HDJZCiab4/VAzVJAfxwHWtm4tgv5zN?=
 =?us-ascii?Q?9chzY9QCMV8GAq1jrYF0+YKi8xWWeKQsEPQo1V3P05iKhnPYJNtC73E02+Ts?=
 =?us-ascii?Q?HYET82TZurAu5TUjpkUW+HOtY+qcDzCvEtyDj2mVEA+fmCtKrYHsye5jW4M7?=
 =?us-ascii?Q?brRbToxfyr0aJbUYYFO3gzR2HgBAai1NOwd7QaG+16kMY1fATpOgSle4IWOM?=
 =?us-ascii?Q?wmTdOB4lLq7Zg4YdbliOGF/wEU5VLsctY7jXSsTGO9atQzALPFCwnM0CYqWE?=
 =?us-ascii?Q?Z7Bat/0XZ1R/O17NLLlfoFMAxH0OK1ep3WpznYoVJmVip0rSDjmWYcJduH27?=
 =?us-ascii?Q?wHNO5I+djh8zUBbzIPDZA7z6174ebroGJHq06/Fq/PHWyLti5KW8SMF26bqv?=
 =?us-ascii?Q?9S9iGXn6Xis24xVDziGw8n4B57P5Fg9rbkUgMxaPdMXmxY0iaBZJN0E1a+W3?=
 =?us-ascii?Q?bTAJtuLADhx/QUB4RlG13CTKMW54aZg6MECI8kOwiN8aBX95jIgTjhmcHb7Y?=
 =?us-ascii?Q?mpjyLZhvxURSw78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0vcVxcf/2XX2eT9Tsngcz7/xRk126NMjWDzDZ8Z7ae4v0Z0SAO9Vrtv9SOK?=
 =?us-ascii?Q?O/ITrOwBYFTodnw6EkAiInJGZvLCv89ZIcrZfwJYzRvrqa/JdxZHgT/Mps3o?=
 =?us-ascii?Q?Auku/TsNxdP8CTcmwSbA6muifjidWbvfQDzxhmw3Sj8AJQK6oeAQYKemRTJa?=
 =?us-ascii?Q?Obz/7/C7Vezr/6j9kiCML3mptP8SX+o+UnUlhYLwqowWCqzIz3JmzR/177Qb?=
 =?us-ascii?Q?D9YkK5dEpTIQvzF69uZROnrBBpstFwWzpgwHKKlSTVdhRG6h6fZ9BjWWYbZX?=
 =?us-ascii?Q?qFh1e7loR0KMVKrj0sB6RHyCnZPZ3ELrB83kTwgNlI44d/mZhZu/u+C7OC8T?=
 =?us-ascii?Q?rvhYGOCHCh+4SA8+dXCMvvHoEnCMM5ExTfnRSxkU067BYHJxWg9MZSlAS1Hp?=
 =?us-ascii?Q?YnwC5wdJsqqFi0h15YcHckPT6+eXL2x/XV8Ne41Vx5nrTSb/LbibbafKAaR9?=
 =?us-ascii?Q?Vq1BjClpPNoAcr1+lpl9fHU1wnmi/pK4r2YBlNkZW6uuyV7mBA/Tnnbr6XiB?=
 =?us-ascii?Q?1mxMWsUZzmgKDyaW0DM5VmXxtnY6spy8G1Jmu4xO7KZgsxXh0/IUmkSzu3z4?=
 =?us-ascii?Q?bmLyE4a9/pS7sAr/MNbIUwYtc9WdvL7Fdb16NhYXH2wLToKtnVyn9y/RUwXf?=
 =?us-ascii?Q?J3ah9roEPMLEB8ETL6Qj/A4hdILfZEo3Y/TvFxF8YPaU5ujSK2s27M0G1Yzb?=
 =?us-ascii?Q?k3wi7BTU9Rqltt0HWQfuun96pyT7VQlPwGtzNZyhtLqa1ZH9R8B1RzT7Y2ID?=
 =?us-ascii?Q?rTOpVdulgLbVp5NgfHwPz+/ZJ5TEm8pCp4SQrLzsSbslQnMvIini2m3TNNbY?=
 =?us-ascii?Q?yBjTKUl3tF4OsmVbGU15WkVzAk6Oy5v/U1xqiM2IP0XZU7JUilyzhoqIxfWe?=
 =?us-ascii?Q?Ys/nRWCf+qFbzt49X9OroHlffbv2evj0jOYfVmBIbGUjJx75PPbNps4loVzj?=
 =?us-ascii?Q?VpifxLhNwPRCVN8Y2RDCwOTIR6UdnBbjcyCKGGZoqxi9wDJRAEjrxmwLDdYo?=
 =?us-ascii?Q?Cs4hsbjn1xTNcvdlcTyuiMLSnrfWt3y7bAJ8ykBzW1NCXLSVYxb2TQKRrKCT?=
 =?us-ascii?Q?CBwpsZCuV4yQnDjvBVh/MD5fes8apOuaW8BA/nEQuW8SSMLlNhuXcevv0d3V?=
 =?us-ascii?Q?9jS1pkp5OLy3aIP6pAswaLrlaTOxycGGsHpgfZzAyt9sgDF0y9yboDVTCvcM?=
 =?us-ascii?Q?vYT9nbXebyfQ1bI1tWFruDC4Eh9NqW9hVNw7xTnVWcwi0uoP66mEgSOKpRSq?=
 =?us-ascii?Q?7CU6glLtL0YCH21AFkSvY4N5VA4sN/gvX1AkWjD5NcVfct+UORNHesNjHxtr?=
 =?us-ascii?Q?dAF4gmcjBKCt96UoGAjFf41aljr6fXiJmC7x1wLKreOUfA2tw+fJYUFbJ0yB?=
 =?us-ascii?Q?q8ttw3oc/VfpFKaxuyXbRxwFth0KajYkoryAYb8IlqFsLwSdbRICE/qGzUeF?=
 =?us-ascii?Q?TEqZLm7eIevE073uhWN0PBmUW0ZdeJ78H10X+JinrG9X69haeXoRtYVIRC3s?=
 =?us-ascii?Q?W9JAwy0VT+BbiDQK/Z96o0fy1Frm5wRJmYAwNVyKLvDixX+EBrWwcA8br9aT?=
 =?us-ascii?Q?mFcZ0bcuDs3yQtUKTLwd7n7AqAp9rM+ba7peE2Bm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6256bb78-1f8a-4586-f5ce-08ddec4de763
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:29:09.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFNHzDz5DBi5+mz2+aIuGjQOTRuy+/870OZQZwOHGurRQALb2nsUPCR9sJibb6bvy5JBcixZqYz5LAav+lyt/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5837

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..d09637d64f6f 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1087,7 +1087,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
-		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
+		ret = PTR_ERR(data->tzd);
 		goto err_sclk;
 	}
 
-- 
2.34.1



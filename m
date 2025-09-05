Return-Path: <linux-iio+bounces-23752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045B44FC5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED935A2F28
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B32D3EFB;
	Fri,  5 Sep 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dMLm/gmD"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012011.outbound.protection.outlook.com [40.107.75.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2821A420;
	Fri,  5 Sep 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057439; cv=fail; b=RYNNdwfvw+nEZGNwKSA1wXT38O9QzyskT75lPRyEZ7IIjXCiJon2GKxVY9slCEsQAtVhCrSEMcTXN8AGzn7aAgorCJoTSyICGKPpvVvShCGDkvpLuNXF/UeaJpoSBiPQ1WwmLwm2ADuI5OalavV8llkPHDDodVb8fySIFW2XgYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057439; c=relaxed/simple;
	bh=zHaMHeIJpCQ1qDfq0UURHsc5zuudUW13uIfWY9R9bEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qr0jOa8gV1YOlU4A4JBMc/YDaKEu1LVBhg36vnJSm5gy9yfjlYzeeggARQOOg5z45NtvcOKefTPA3BligXrB7ybyfazRHKXoyI3pjWO0aEtdzAcxE1koRTepTZOhy+B3wcjIWnxo+fCpeBDEFwfANsvN5HgMZGHAYpI/eXydDX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dMLm/gmD; arc=fail smtp.client-ip=40.107.75.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvPM0zBN3b4LcUByyJcRSlIe3kYjAlGRGKogUUNQou0pmPtGLdo7Hbprf6X8PSX8n0CBzhgS7DJl9an2TWNBulz6dtbgRjKffhM/Bhjyhe8bo6Ayxf2Xwwh37VVWDzzj5Y3WZwCan8R7yi5E5i9SNTv+8mnaJheTxTaThG3Mx16MzGir+tJurYWWjVSQPdh1REuLEXq9r4rgADwSczIMJIIKfqpZla8VG9G3mhnywStLaY3NfdLV5wJIya1ZTimNOjkL9qxDOHVdhPmsTELLwgHq0hxjsfW2pGJTjByPXk+yJCU/tTd40lQQ080tq9c1Q+vSnOs6Vt0rwRIcZ65Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+z+FBSYFBJ3GvWe4VVDnS660/Npl4eDZTbKMxj8duI=;
 b=selS3o6Xzb/GIlGioJkfeZAto7bRDeNAWggoUprt+5csJo8ymXnNoWFVZkdtxyA0HBLJzKRKdWEOf/vUXKvbf4AR+hC6FtZ7tm2Pmw3JDEkPJXtn7lwbhBr+YJ64aLomHQCUlvTSL1e5zhZuNRU3DFE2KPe/aRH8CJs28Y/e9ejWtq0OXzY4D/A6rdqn7XVhrzVoFtgApi4IF9J2T5vg44dhzHlx4wvInHyN5F+gjiMVt/PcSbXA43jsmWr3zl2vP4SaMVJdL836ya1fQwV0sJ51mTP4wQEvbwNy3cVzelPyr0KsODauC9RSgt8RYMN8134W+2Xwqb7fZ21/fWSM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+z+FBSYFBJ3GvWe4VVDnS660/Npl4eDZTbKMxj8duI=;
 b=dMLm/gmD9+XJAOp1WazDhH6bsd5bMk8GDZw8/O9yQcVHc1u0VndS3hOywqUfCw5crJQYVyiDSR+IVCObeyVaP6VKezCsoWQ2a8odFVvwP0iCQK4+5y15WOYlk0pczT6nPIXGCEirDk19sOxaRCSoZipQ5eyUMnvpokg8D88+FHcrJ5pbQr0HW4MXQB6g2HgKOqYhRs6mugv3yVZxR1lqdykYRTpeoXbDiNkXUkRXDbQrbDHvNj+ucGTlTYKyGCYLjXvnA0KMKLxhVJBd+BbpLmlMJaKuqOPFXO8bs+6A6+xBoGBhb7mSMwaEBcA14yZT7/5rcJhbUGEvmz5xwfZVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 07:30:34 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:30:34 +0000
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
Subject: [PATCH 12/12] thermal: ti-soc-thermal: Remove redundant error log  prints
Date: Fri,  5 Sep 2025 15:24:04 +0800
Message-Id: <20250905072423.368123-13-zhao.xichao@vivo.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|TY2PPF4DD1DCAD3:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c168d6-2e18-4db4-2cdf-08ddec4e19f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5nXJQxQPjs9P76NYDhhy84I3XzpXvClH5hiYyVG4b5kv05qYWRbEwOHPvtNf?=
 =?us-ascii?Q?OOE/VGO2jsxpcaKGDcZoH6NbdzTJAc3TQG0MiQKHRHLrH2pgnoam1T5WNb1w?=
 =?us-ascii?Q?KP7EicWy5GXcWKF58HTfy7VA/Oehptmy7GoS/pzN2/fTHWc558gX3e16SPua?=
 =?us-ascii?Q?O72hoH4tEinAkFW5lOs0R2pXs03p8Ih4JVcBwy53O1/srmqTxxHHUwi2bL4x?=
 =?us-ascii?Q?IvbFRw45/YS2Kc8IWMrLD+4T+TYhn7hRYX6wjIOx3A9Hhf6zyKLV2YGsq71A?=
 =?us-ascii?Q?Q0oMw/NezZUIJ3WQdL12Ww1Fxcu6hM1Nc3mNu732jVx8L7pkHvb6ZO7P5JsE?=
 =?us-ascii?Q?Ay5jXCIH0B+3nuCWQq6HiOMJEUR08NzcY3YZUn3rh57uQ1Tw4UP9CNgqApfR?=
 =?us-ascii?Q?w+ttjgWe83wHOKLIs8o9ZgGfw4RO2J5XLAt4SUmRtkGpMRcEUg+Q0axN4VL0?=
 =?us-ascii?Q?EFGKjY+MzcVGDUkI/hA+RiOAZc4UW9UM1GM5x3CNiFNWaNsBn8FeZpSB7Bh3?=
 =?us-ascii?Q?4NMNOoOWA4mLzg3Wttv8LHEgD3jd+nIqqjDejwcOpI/Vn5fT8OSQ5mFmcRsM?=
 =?us-ascii?Q?U0GR4y2LK1rH/7qShgIiRDlHJRspUfuZnb9QxYfBeDa3yglNs32rBgQkKZF3?=
 =?us-ascii?Q?s/3X2lI4ZjIjnWhOsRUgLFkPr2CD3ZfZKzg/fPWIXKEpBA2GnIBB1anZjf1R?=
 =?us-ascii?Q?77NXSVklvovGp8iDa4EeWFgg8NeSTmjEAZ82ExkfpVcIIaTfreSNACD7+lMn?=
 =?us-ascii?Q?Llqd+O5iOBUfGyC2G9k7FDhupOwsh4fmr90GdIJe6i+8uRVp994OFkKRZ9n1?=
 =?us-ascii?Q?3nHMu340ehYzGBUgQjkGF9uv5ht7g2DktGGT3ND8aSdwhDxHxIH7KURWaMNM?=
 =?us-ascii?Q?GQhYKzqOuO+qKmFgGi5mCnC8nww9lsyeDcpyRoX7BoQteXVsAttXcBZ05u8R?=
 =?us-ascii?Q?lkGtl0jD9hxGBcdCREjC11q1s7HF7sytJjRdtn3gOmYNHoF7b6rAt8bgazD9?=
 =?us-ascii?Q?YEhfCybbXj7D4uPI9Nx46N+f1qF1TJ6mOQl7lf61VmvNhJVx03woY4dhUa0A?=
 =?us-ascii?Q?imCdK//RB8VQBOHRWmIZrLz+5y9XtV9ZHbecP11P739nBLPjSg/8CYpNIinq?=
 =?us-ascii?Q?Auoe8jzxDv0nw6MQO48BH4/RhlP93o2HxqDhECJ97wMr/ZfCfI+xioSjyGBa?=
 =?us-ascii?Q?LhcUi+NRJ4PV+mHY0LMUkyoPYVSsEL65Md6IXNeBmGNGtIYuXXlOMI7cqbWk?=
 =?us-ascii?Q?le1QymsaXQqcYSqyDnZ0X/hZeunQtCn2EoyE9aTQBr16R0IqDOpizTi9H35o?=
 =?us-ascii?Q?DxQV0CoGX5eAAykkXnlr4RANGCCfuoSVOxygyGizIkcgVXoBRQeIWjQ3sBgL?=
 =?us-ascii?Q?YMUR9uGSTheiWFrV6wUMfKgKDCVPUbSn4Tth5r5iqU6MfxVTFsDuwSXNj1Ny?=
 =?us-ascii?Q?nns/e4UJ1DOqYiafXnqwbtt3K9sJCgAkZn291au5uDbduskIdxzQv4LPSh2U?=
 =?us-ascii?Q?rgmUZ9sM3c3WabY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/15ACXZ8Uf0PG30wmG8WU7MEjaZRKT8pd8x/yNmb4YMjJ9MNtyr7kxa3ChVR?=
 =?us-ascii?Q?pp4z0tSPwi1dYhLBPaTDZgsB4FLb0VvQPifuyzPerXEk7GNs0tH910pWqi/Q?=
 =?us-ascii?Q?MdZQAW2h30qVosC9OAKNBkCCTZsuPZ6L+6B8H2DsP7fQIuaJK7g56VN7i9Kt?=
 =?us-ascii?Q?ye4uBNEQ5Z1f4zOZ3uxq8V+ECA6Nt8BsK6yIXsZAQofBZo4BO5TsHa6tNks4?=
 =?us-ascii?Q?+g87GT7chosj5QpUyDZY/QtNFd45hH8xSDEyK6H7/YmnagYzmEMNOx9G/9Cz?=
 =?us-ascii?Q?Y8tfbBz7hYa+wKHXBalYd6kRXJOkHIY/0Nsomn723e0H8zFqm+ItHYO0o0gk?=
 =?us-ascii?Q?TCwdzkY5RJVNLJM1gaTwdXTdO4Wt8GBQtse8yCh3dyd/vkrg9f8fLhRWBLAS?=
 =?us-ascii?Q?9Om+phBbe/uuNIyE5qq0nvsfNH4GLLKM2DQV3G77/b6q6RMNJDn7SGAVEirR?=
 =?us-ascii?Q?snwwJh3gsNsFShdmMkl+C8vsX4TZTl8hdq2T1ZcxrhOd9F+XDALxYzykfPAG?=
 =?us-ascii?Q?ovbYuyZ4B3SEvkCAt5t2gaNeR9n9HT6NH8YH+HmqdiGpUbD1URaB6laPgRIR?=
 =?us-ascii?Q?h4O91zEN0WuS+3IHE2jDKhAfqCy/qdZ9l6jkjaj48LvsDEPYIPHT5CAGztTc?=
 =?us-ascii?Q?ZJuC49deARzTX7RmRY8XyXiu+rlNwiMSCezJ02eRXcXGlJPcCU5+RyQTzXfV?=
 =?us-ascii?Q?19X7TOnwo6Ts1ZfTHGTHsK4Ag1aWYW9gRHtYv7068STpGb1RhZ+F2fsf+Gqj?=
 =?us-ascii?Q?itqk4k/5JG/UxTokKvWn3aJzqTBT9WOzKqhD1OxL5pR/VoSqXOkcVKROxvRb?=
 =?us-ascii?Q?tuxAzjIfVqwM7kw47eDIKXNgu/HJkloSNUXtO3tGalWOKY/l+lF2yGuieGx+?=
 =?us-ascii?Q?dDCgC1Vm9e9NVl1rPf4tNjMcQGj82SBZSYQPrsZPr+gBxFbf152Hf5/BH0Ui?=
 =?us-ascii?Q?0hNUexZDgS5aCY1KBZM3YzvVfg3blmEV+wRi6+wtr1YaP1QLPsUdQE/EqqTa?=
 =?us-ascii?Q?NDjvn1C/fTJ7K3kAK+aSdFeI0Gbhff/L9XSYQjzypFlEIWgh0HRkICGIpaib?=
 =?us-ascii?Q?r2wYvEVemo0uOtwFLdH3WDhUytgs6JWZxFyJzs5VFBYjBIUds0Y8p5h7By1q?=
 =?us-ascii?Q?AoxBQ+AhWyUOv4o4gSedT0DAUITQJylgzIz0EhWKSzvLCH4M/pKcq+gC/loO?=
 =?us-ascii?Q?vLNPBm6qE8D+v86evSsqFliKlx0nlZU4fUqWOEgizi/zoxkqug7i31I1/oqE?=
 =?us-ascii?Q?UtpXzL1Jlns9mLlPFhZSggEOl3KyC+ihozg0t8HuwP5YiCPr95dcgTeOQ4k6?=
 =?us-ascii?Q?WYW+3wC/wIZ5rsjJSKXKUGS52XtXPZMa6kL7iWN85awKD8zc+VjSTnMBdc8N?=
 =?us-ascii?Q?DdOZ90XAFpisj0dxx7qzODworKsmkU0HOf7xfSB37UiQsrqQBbzqbmx3oPG7?=
 =?us-ascii?Q?4H0ZJKGcvbjZdgo4WJj4lFYQAIl7AOyl3pEpdk2N2+ngjJ/qIahs+qMmhgDj?=
 =?us-ascii?Q?g2AFGVdLDGOiEfNZisQGrdSUZmnRcXNHShJvvxDtC3PGpqI12WRgWM0CI0Qt?=
 =?us-ascii?Q?dLKbcMZWO/2I+8OPH4pg4QeDmKrOr4NIPqoMzooM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c168d6-2e18-4db4-2cdf-08ddec4e19f4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:30:34.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH9EQYEqhhJ9DqL2OKMQ/mm1pTNM2efGsKzyUdjeuxE8gV8zMOsN8dF65QyAEf7gMJ1GC4SCqMHdXoNy5VeumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0cf0826b805a..e07a82eb8c3b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -175,10 +175,8 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	/* in case this is specified by DT */
 	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
-	if (IS_ERR(data->ti_thermal)) {
-		dev_err(bgp->dev, "thermal zone device is NULL\n");
+	if (IS_ERR(data->ti_thermal))
 		return PTR_ERR(data->ti_thermal);
-	}
 
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
-- 
2.34.1



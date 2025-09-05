Return-Path: <linux-iio+bounces-23744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1EB44FE2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD4B7AAA2E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008CC2F28F4;
	Fri,  5 Sep 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H71taQBg"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013071.outbound.protection.outlook.com [52.101.127.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168B26C385;
	Fri,  5 Sep 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057214; cv=fail; b=jWFlEE+YsWrcl3JFseJ+qR985znZ3DjBy1VWMg6M+TDZz5sIQ3u4hISfg32DphTtBAzQP5iardjMZq5GsvOIvFa6LGaMserh9YrM9TGYVs3URRwCtf+sJcTrb6XUBZ7QhMpHp1ycHLoo502yixoFeYoroAF/+p275cGt/z1eV3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057214; c=relaxed/simple;
	bh=/qZLd3zfioZRkM/fo9KQDBD75zgAC0a/aZnJdVnFeDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyfJrnJHYv+27MGs01Hwk/nQnBaMFUcVkgp/wcfS9MG0jwxvE9T3f1PA2hxW5Mo4JF0tlhtkPjCwcJgYbQyIjJw5GQNfocUv3izSDDCW7Or5sqZNFBVb2AalkXK44Qiex24Eswacb4GbMd/KmyCOaiikqDtkLWtDhTqJvBvyLUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H71taQBg; arc=fail smtp.client-ip=52.101.127.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHAMnUNOCVKwud8XFx+WXIjEi3UTSuOAljS41R7IOpzz8SwR9MZlLcTB10skCJHJsDbkihGipz0X4S1h5aFCRpvQfOdIkqpyuDIfF62txDXIXlf78MMDk+tZKVGealC3E/EwSAclc2JdZnIB6ulP8qoP7iRzksf8nOk9PjmW4m1wh8UbPnXruSo3eQL/v+Llj9wtBA+dP20WhbI0v3jYP4eLB7aBKzDTFvQRLvaJWRMWhQmS2SVzw2pM2a/eMl6L9fddtVVXpvXhpMHda9UHWTsVA3yDdYydbhcWFXGYwvTpqLCKR1hIR1eJaedWU/OrOKJuU+mcqKtDFsmnVfVWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeeYxhUULCvbxu+II3pNFP3kAwp9J7NLhxy9Ed1R/78=;
 b=Ny5SxnkMQ7FenOOiVWBr3dhLdJiK4+TwwFpPJ5dneOVG40yKIbeMfm2MxTCOeMu+GqGEUCxtqZDcwN3FSZb+QmY7LPr1+n51KoNQr7htjxrCWBYNyrwwL5SrCXTwHUayOMiZt5qC64+eOII+A0SdZJ8lcqgjkduftZPkFaHtMSxLSpzPo3kSTyIOVMI5r6MhIZT1YbQ8o2UR9hsbhsApyIiseQtxRwsiY+Qx/uecBntxClHBf9JKBYjAUL2C0w4uh5XVRwffH7KVry86cZChVMBpofK7B2ysoFJhGSw+wlJOv6MLCdhNrJnH7pTegZobhzHk3XQJ/jox4typXo0aXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeeYxhUULCvbxu+II3pNFP3kAwp9J7NLhxy9Ed1R/78=;
 b=H71taQBgkidCXrQwyYG/ThXRJlz+AgIm4AiyUL13+B4Rf/8nz5pW6W7XoVAEw3eDpcwIk0GCtNLUQVNRE95yzY+T2U1AP5XoWi/nOV/KcF/mSstymXqPjvPcf6MabOsqbK6SewKXY0dwuk7g76uv455rDLlxZTlN6kuyPApIyK2yzinKhKBu4TqJoZ6LNYtPi4ciYl7Q6rjLQNGJsFN8GuBzfZZuZFMFPREoXe4Ba5AAQszzLeKnacGJ6AMC93IIwmBXN+u8JSKhktUZhuP4UmSBHK77yAEQVd9/eeAajmEyG8PPdPSguQRhLU9I98aW1egcZd+6CUxIoIPQ/pns/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:26:47 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:26:47 +0000
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
Subject: [PATCH 04/12] regulator: max8973: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:23:56 +0800
Message-Id: <20250905072423.368123-5-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 151cf416-3c8b-4b97-6ebc-08ddec4d92ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ypVFJ7Z8NX1AsshLK+pO9JA4Q/JEZgxPA5+tFoCYwnE4wfFk7ZaG2vlbs/h?=
 =?us-ascii?Q?fGKfIbm9EqenvGc8DFJUuDM66jZ1EwGyuScc7p9s8l/kLJ8JaBHkiBUvY0gH?=
 =?us-ascii?Q?oKeg9ornkJ1eLmxLSZRb/gHTFL6H5bhaZYjiXCKvPYdLYKr2ETyBe1bd74cU?=
 =?us-ascii?Q?yaxB9a5LCldwchl7VqH9KAmQgRcjnC6Czk1hgFb9PSUfT8QmnhNM3h4JsPmr?=
 =?us-ascii?Q?SFEl9jp8FpSqd2yxm2XZsZ5aBxCKkHDDltDartqQKOkvkXZWTbYcTzrQf6x6?=
 =?us-ascii?Q?TZBPho1r2ZApKPNN58xzTUMQwBzWcdjrP2sVZqLWPl3gg62bkrWgw9TErrBz?=
 =?us-ascii?Q?wBsLjxAJm53Pjymk+f/hHQumJ6SCh+muHHeZ/i2Eh9xf1ucPQDYRJpT5FvCz?=
 =?us-ascii?Q?8SYInTfM1KsBieaQSxoxMOoB16rw/huQuTIR6S6GmDWEuaJBJEFbo8agB3FN?=
 =?us-ascii?Q?qtHTOayU2K7yUeUARiA4Bfs0f5c65EcX+bEtQlmPoSPQpa1+fUgAiGcvCGOy?=
 =?us-ascii?Q?P4Cdo7nCe25S/NicXV2z5i9YCw3tU0IV7byHUSaDW1Hwt2KIRhRnDg2Ws8ue?=
 =?us-ascii?Q?lq6uv3JT61263IjNzr2kJwauLFiJ3JW7PHPOE2PscQf130L/P7G8QC60aSIm?=
 =?us-ascii?Q?zC7aaRtRMV83y6PbRyPn8Irt4pz+f0jVRCTNmtpLRN58bTj0hJuicvlQ/w+I?=
 =?us-ascii?Q?x568SCtm0AQWFvvbeHv3rDn0aZrnbv/+Eh3Rb4Cju/y/Eo1lxA3BsxHAjrte?=
 =?us-ascii?Q?k+/s+DxjdglW6YOytUg36VvPoVHlgaxZrYcif61WDCTm9Lt+ClY8NEKeCl2I?=
 =?us-ascii?Q?Xl/9yuRAnRTnEYTbUpp9hT87olgVdmNI5QtF5qfT42k8U30ipGKXZhw/gSee?=
 =?us-ascii?Q?uosXYKU+yaqu8p2AzCITP0qOHFvXLrsW4kWAbs5lyR/VlOA7hbJH5mL1aN8n?=
 =?us-ascii?Q?017g5MiM6Ej5Pfs95Iv+7QXD1c+di+V104cmZvGF6J0+UlF1mMRmM4SVf+Mw?=
 =?us-ascii?Q?gJPSf96lvkCdrP18HdRxZ9jrok6oOPIchR2gGHmuFezK82pwjHtgAN5rmZov?=
 =?us-ascii?Q?ymwKY043JjPwwVeRnBhfXyjDjrhnipNsKVpJNmWOy6JctP/dESPAnyrkcvDK?=
 =?us-ascii?Q?12hSpJw0gDIQixn28PlgNwh+RWMM+VobJFIkqAfcIJvZ0DexAs3m3YSucDlF?=
 =?us-ascii?Q?meK6Lx/dM8CXht4FesvYueRaMpjajrrc46NJ3uyfR6P+yPk+8Fz9CY3hWLGU?=
 =?us-ascii?Q?8twtfZlZJ0qSv2C/PyzFkbNs9brvSqAa/Qvr0aPLzCeBb4ubOB7ZYW/Ow1uy?=
 =?us-ascii?Q?y0NxgW6nebPIdPlBu6A/mzYCf1bLTEz9JHTpLaA2po4jDQ8rdSd6BzXeIhiT?=
 =?us-ascii?Q?78FkaSxUM0dvUCai09F05n2pKPqz7Z2tbrd29iz5xMOCgEQzX11DDrG6Oupv?=
 =?us-ascii?Q?AamwL0VT1pRaCVwU0ucJ69RVuLot7xkeOPFgTApDSw+gqMwgj3IWIk5Atp63?=
 =?us-ascii?Q?tlF/JySNMRtnYc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LyC7poIaS3r3ARcUluwdZrWFbMJSCclX0uofeRX47tkdhI0ylDtcrmOJkeVm?=
 =?us-ascii?Q?N3MRzsc3stXDFdH72Xk3mHAcBQy39DEE5lOz4qcBTMrba578HT0bfj4d7ZyJ?=
 =?us-ascii?Q?WoPnnNHzw5uVFoMFkd5APv1yPRIezT/WFoNZ7seGDoWMl8r2bIwWb0/xCW6p?=
 =?us-ascii?Q?l3SUZu0Mp6PATtmXQWsJHQ68WZ8eOl/lMSmtDFJ5guMnAFtvg5lHekYg/bZ8?=
 =?us-ascii?Q?MNnArzfONmz96lZm64twRyzb6cIwq231jiGd4Ow/9YQNRxmJ1tQjtBYgYQfE?=
 =?us-ascii?Q?+o7liy1RHlBFDqEJWBuMmTRUuuLlDzK4iYrS9m/DM4n+jGUSwPaY2l82elZI?=
 =?us-ascii?Q?0EiaSqeXtgEefGtY2Lal2wYlYBardxd9/5wHWu9BIn1Q+BGxaxHRbgq8kES1?=
 =?us-ascii?Q?QQGmAJ3Bv0sziAA3EVWwU6k2hpdxKKhutU6xUNHrXeWFHi1PZ1dWNwvKXTo6?=
 =?us-ascii?Q?jyy9SgHk2rsiW/T4aaiAqHtoeZqIAqKu2AvqaWcYxOu192APfyGPk8zNgecS?=
 =?us-ascii?Q?/1wMruL7y7CgkpvkbagndZtRkzubHF+9NnuDqip7L0pZf6DP6OIlNIylMUva?=
 =?us-ascii?Q?/8OoiT+2LKhN2LTzaXrE7QBo6KrkjZE3MhNFNUq1XgsmvNJQjge8UAMiojJl?=
 =?us-ascii?Q?fbl58OQ8W1Jl15t9UYeXQxvFqjAPwctVpVpYYbDm+7MsW3aA5t3xaiX2ZPsM?=
 =?us-ascii?Q?vQ2GGG5Jok6pHPDeYFrcLfBl1okvNlFMCs/3NymTOnM6IgauuNOSDoO0sdeK?=
 =?us-ascii?Q?lXyHBLtN9NfjgyLq6W/9slg7qH2YRF3rD2SOlQEXNmvEh+Fyaeh0ptMOqizi?=
 =?us-ascii?Q?HHPR95norHBwNuVdr665Xb1OjrWkcvWD2S9ArgIuBinpHJVJjup0sOvwxjl0?=
 =?us-ascii?Q?dUQc/IwTIUx6jp4b0C5RulbqzxuzBOPBDhkATbTHecacXAm8z3VqYbFWEo6P?=
 =?us-ascii?Q?PscL+KfIrLEaztN9Ep1XRr6wOdF4T9mTRUXPy93f2rWFvCnTz0acpVGmqHuX?=
 =?us-ascii?Q?tzDhgUx5ip7rX4cHXzN1UFHO/UyiE0CpZFAcxBCbOJoVSkZDWqa4VM2ueiV1?=
 =?us-ascii?Q?i56gdc84FpwT5Op9xJkGfuhkbaEEfBgV9g+xr2YpsquKZfslTCsX02ZN/FvV?=
 =?us-ascii?Q?FlIwtvK5kY2Q4V0tNrcTRXw2Z7ii90TRI3/EDoZLKLYaYpziwDBEP56yPXUv?=
 =?us-ascii?Q?wC/G8jiIVKH0zjOblTtQjDh7AmhmOs49YZH7yLQiJ1EV5/ejtV0daNgzsCjj?=
 =?us-ascii?Q?G55U0XQm9nqJVvMLKoPJEU7QVuVK5WsHPoS46xdZqcup3rfj21QuPxRLre00?=
 =?us-ascii?Q?nqjJSa3IPrKGegsfQf6ZqVaYv7FU4eceCSsQm8CVcc7TSYnfp3+F3uwVfhN2?=
 =?us-ascii?Q?6WZaY+a0qoprplO/QXd+OyP1ncdBpr9VRxNlTXUDmRA2q4BW942fYuP++O7t?=
 =?us-ascii?Q?1cLtmtH5QhSyS2RMBpX2/1yyJikeMqWe34SbTsG1XKmrNaFx7rgD5hlhQmvt?=
 =?us-ascii?Q?cygL8ob4q1gxmXC59g7xEdIeZqNYqlhd2iB2Z7y4fUAQZrdX3J7f7dW9Yzel?=
 =?us-ascii?Q?XJgSovAOrQAbYSII3e5fdndwba2mPOvPXirCF/V4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151cf416-3c8b-4b97-6ebc-08ddec4d92ac
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:26:47.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2VTnIdO+0cgaHKWx9wB5mICOVdg7SFaBANBDhjgxnZswn+Baj6v5zJLgySCHrWgcop6ihEW14VWz/69IBtPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/regulator/max8973-regulator.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index f68caa07f546..9853a7a5850b 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -478,12 +478,8 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 
 	tzd = devm_thermal_of_zone_register(mchip->dev, 0, mchip,
 					    &max77621_tz_ops);
-	if (IS_ERR(tzd)) {
-		ret = PTR_ERR(tzd);
-		dev_err(mchip->dev, "Failed to register thermal sensor: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(tzd))
+		return PTR_ERR(tzd);
 
 	if (mchip->irq <= 0)
 		return 0;
-- 
2.34.1



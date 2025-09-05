Return-Path: <linux-iio+bounces-23742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B567DB44F86
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8921CC08A5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041182ECE89;
	Fri,  5 Sep 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VadMQih6"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012017.outbound.protection.outlook.com [52.101.126.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBC2EBBB8;
	Fri,  5 Sep 2025 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057154; cv=fail; b=IFFSn0twIjB7e4hU76F1QLGlIUTp2wjHqshn2HTzH6y/fKYT2akGvYs9aLT6XGkr7YOk6eHHKpCfczlx7gd4C1I8e3rYA3hm49+3CdqtJuTHfyFl0WPHs/UCW6jqPdnvBQHOhat/2ixJedVvYvvGZN/zwOo2+6U3O9wMQWyiURY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057154; c=relaxed/simple;
	bh=LdsQiMpTEwOmIiruSJNFvOjjdHp/DcxFmmiJNC/iiKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkPy77+Q2trH4/Uww75dGfMeVSgKjeH2cezZ9EukJukAoGBb81GQENz77cC1Kwj+qZxDyX8a6Rpa4DAuM7WMRRdQ+jzUCgxQZBw+BNoZmkPrURSeeWtnyXSs8xenE5SIL1LnS87qPiGLIf4qq60yOaVOzIbcb/A4sClsLOz5HuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VadMQih6; arc=fail smtp.client-ip=52.101.126.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkVYIam7Hu3hfpvEdl+4WsPkYQVYlkaNqlpXlyNLFoU9tPUX1KvYLXDdJs1N0lFqYSexI3OLmFudjCnEbSYAzpIs5JodGZIFsNyNJl4+gBfZwWx7mphw/JmKY4w0f7LJhm9XuzrdSIPzQrMQ9V3Ezps5lFU9tOtrZO8YHxHulAEY1+ppsPDeP4QH/zqJyiYJxu/tFCuMp2wY9HCXQus7XgZTM4gRp5kkhFeNMGi0iX22wfa3NWQGAL9NLOII+Ea7lkuwPOcncpTWTVQ+2faNnoxwnWluPlYUv838sqMV5PiI9mvg0jlOjBrZdbMoKdGbTXG4SuK+8Cb7Oiazg183pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCwjSlMRAlZIySyDErzK94P4oa5bEiRJ5nv1dfot5Ms=;
 b=LNBYwPS40IOSMcf6Aix+4ldlgXsdQnudC0naLW61ZkxKcmklzMmfpfRwYPzTVuMzKJ+syIRE4RlQc1xxLq+ZnHylqXvlzWusnLsqlYpWb7Iw55QBKwQAHUGgNIBuqYDtg18LhjVmdqupWO6I1LY8/Sd/oz63XyLl47ggoyBh5tB4R2M6bSECUmdnmmdu4gSSz6PQDnMrs6AupCgMieOv62/TZpwqWp5Vt8IGvY6gCCOm3uM7g3HHfXkJeoyIOlC1pXGDkwT0wbzEb4KsFqraRY1UU/cDU9tjs1jRruZtZGHo8fne4PM4nydRtGKTgByDfs53hqKfro4omn3tZ6xksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCwjSlMRAlZIySyDErzK94P4oa5bEiRJ5nv1dfot5Ms=;
 b=VadMQih6oXJAng7ZJYFnCmuD4bI3HDRiGwDs1vFyVLh/XIxvqKiqWV7I6K6FFM607WFOCfMwKWHz6R5X3PHzj0KPT02PxIn9Nr9w+CDJ7EgzOI/L1Ox0gwbpEsao8zzpR43GqLU81UUsNnugfq/v3WXhSyVfLcPNr1IyxCXok7pnW6dAaZGElgBnyjKc+OYxtsedBZjFlk9jCPAihdlCaBXv1SG8qru+ZHSM3zahLqRRJlLFH8F3hSu3ktxujy/PeadvgpVELyI+eDutiq9YE1Zv1Wab8KzKi8NinsoEPj3sGBLnM5g+P+LuYYmRA+jSTk94FsKJK8kTLVcKZPZOIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:25:48 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:25:48 +0000
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
Subject: [PATCH 02/12] hwmon: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:23:54 +0800
Message-Id: <20250905072423.368123-3-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0af3cfe-0dd8-41a2-a39b-08ddec4d6f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhZ9MbcanvItIJvqman74oHrE/q/BZdhiUZYxY3pIbcLDBPyP2CTCy4LC6qw?=
 =?us-ascii?Q?aZaZfv01gdAS/FB+gKKL525EFKRACq/6sW+ruVnvLYLObRZwJK95zxl9HaXY?=
 =?us-ascii?Q?qWFenwnbohXemOJkfoVGhKdnhIyoTNaGD7ez+JL6qQk4gYTBuSa2zhm4Fy7z?=
 =?us-ascii?Q?XphR0Oa6O5P75M5T3BjKY4T2S0N3OfwRP4qOAX1FQiuxuPw9XR6jAJfPgi5g?=
 =?us-ascii?Q?V1i8mBOD1v+KDSJ/G8QVcPwOrneRcMkLirI17WtHjp7pCPtXOk/9soajMUP/?=
 =?us-ascii?Q?J9A3qS6ysjM0YCdR5YLkx38XndHFMlyXirVedBbOrDPPtMNm3o9dnIYnDEG1?=
 =?us-ascii?Q?SjBuPzpHmpW1K4yJIm5sLdeCfGkesgpeLC458ldC+l8z4RULo8YfcOJsb6a8?=
 =?us-ascii?Q?/CJXJ5BzJFFboty6pHwKwpcyjYx5sJq5YKbmMs089IojlnwcKg4P+CLrqhge?=
 =?us-ascii?Q?UEYu3oXfFJ8jSWayicblN3z0P27bm1oKOTiy8PDlYZ1HzLWSu2eWC0krJ8az?=
 =?us-ascii?Q?cxfnMMpLwK9avgIs/Cfv7NcCrd3Z9RwnE8EMTOVsTWTR3S9/rVmGnR3Bsfb8?=
 =?us-ascii?Q?rAf3EjrSaPbNSbpJVJhKjns8ppPT4f2VLnkZLmpqtFoKLFyTiQt+VerEI13i?=
 =?us-ascii?Q?OjXGvxcNsjNPiqCFlfCy4jC/dIf2umcFvRS1ll5FkOxJ+zY+9gzjpqVSGX/l?=
 =?us-ascii?Q?KEZgMrgV7IlnUckhMzeKYw38+zhTq5d9fYtlwnbZ7KFKFBZFQI0H/pXA1a1h?=
 =?us-ascii?Q?DMnrK1ZZc+V0VejWTGqU9XHutN7CIjBDBQMYYAc1dGIuKlEhsGPKH6V6zk48?=
 =?us-ascii?Q?NEI3W1eWRaU9PlT+/FbR4kEnprmD5OfdLjzj+ISbHu7AAcAla6Q2vX7/bBiH?=
 =?us-ascii?Q?3dCndnpgwVrIx//qZXsML5B+NDbicH7UQIosBOPAMILGZe36P7/jMIRTwj5W?=
 =?us-ascii?Q?1+LB3XuOjV3W2/39RDMQ9icaiKYdBqAlkLTTQj6oeZW/k+xo9gADCwZ6RwIZ?=
 =?us-ascii?Q?qtySnvQj5la+f+IK3VW/R2nsc6AHuDWFrrYLuTh1a4RAzOYGBsY/n9Xogx13?=
 =?us-ascii?Q?lBWGbzDxYj7n1mNmtSPoOIxN8/KFyOJBLbIvYou5/m5rG3O7luMnHi+ZJWyz?=
 =?us-ascii?Q?WA3CmoNp2RXIJ/6zbCJbOn9h//4ffqmBRAVblr5mRuDgO6/6byjby9CScTdg?=
 =?us-ascii?Q?a0I4x5Qq9HWCLq/a00z0agElGphIZqip0x4uj5LnpF/KUgayneM0lGNp+13i?=
 =?us-ascii?Q?a2e191l0ycAORujhe8OUnUtldHKjVjKHeU8FnYPW9p/w8mbK/aLcqUC52OxB?=
 =?us-ascii?Q?HaV5VJF22/dgMhADAPKDMknSY+0BxZPzRR7bVACuuucMaQndTAvrzGWttLO1?=
 =?us-ascii?Q?mfu5pJn5sNM/B8wvXQAGVQLx4AvSeiCSU8CNezX0ywM8ehc4cRR+LegJHnNG?=
 =?us-ascii?Q?DL6l3t0JN8smjSuQjziEkZZYNLWge3IkRlfonAD2LYteI8jHNHZaUvDc5N3G?=
 =?us-ascii?Q?oHlMX/Pnf2O22bc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4amkddSoN2W5gFuI3KiIn+9PCmEV2nmGcSDBD3/UEZS1zKELD7J631tfUuLQ?=
 =?us-ascii?Q?GfDLIZJXaNybuFKVAyIISxNEpvE4xEfJLD9vMJU6LsdcOvmxDnC+Y92aAUYT?=
 =?us-ascii?Q?4ZlCXCYnE//tI+WWQhmvtucAbC69OfKKZvS5sUbZSceIms7UQyZGFg+6UDSq?=
 =?us-ascii?Q?mKomNiByBrbtOZmF32tBrrYcwl63NbTuVZgZkJvsTg+V1h7yZi/m+N38BHVO?=
 =?us-ascii?Q?Jb7452iQLa3DPeqZlGR1DtmXJ1irk+lFdi7Nlww/TWd2rpPYRP0G/kXcvywg?=
 =?us-ascii?Q?sAh1pm/CSYloa+RJwBrWXAk1V20R/40uk5k8MF1x0Hba/iSnUczlAorsy7cw?=
 =?us-ascii?Q?m7dE62qkg6GiHvENcvDDSsy/nCGsYUFi25v6Spg1Fw+OgwVl0ybf+DVHquME?=
 =?us-ascii?Q?WjG6NoA57f0usYEcft9pwVXu27V7eaIzK9PiJ7v5PBZTCmGD8IiAK8r87NLw?=
 =?us-ascii?Q?VVp4TvZlke1QLhX8AiQ9X+/XvbwHeHaDCq2ye9Hqwk7HMe4gl0Uw/QJIsrQw?=
 =?us-ascii?Q?CWKqT7U8RVRZKccAEJcNgJZSAKnZCBQuuQVBICKrBg/XooyqPJwYEVZAwdJ6?=
 =?us-ascii?Q?tkmUuhrapnu3729313dqg5y5P72ATyz49/o6F3C3ueaUOIP6RVmpfS6mCqiS?=
 =?us-ascii?Q?WCq5OyHqB1sDX8Y9IS8Y+XxU79vzey+n7qHpmNVx2Tgez8afPY+Kvya6JvhW?=
 =?us-ascii?Q?wNIq599lgwd4iB97c3muwh6yfRhd41I3sL0cf+8UOwiO2Tp59IUOJaDGITQq?=
 =?us-ascii?Q?rh0ebAaZIklbcJ4ldzvFNUq8w2sAQ6BRIVQbOhdEbyvNERi1EWT1z7h9fKuR?=
 =?us-ascii?Q?1BcetbwZ9A4qI4to2gqtPQkXLuV3l5ppvc/4NixDTJnuvE9pVcrTF7bOKbxv?=
 =?us-ascii?Q?zH+fKWc4M7x6xhwjLSGHaM/d/2981fWmaCI2uIK8SkXTXvQFABR8f+lSR5DT?=
 =?us-ascii?Q?sPP7Klz8M21uB+ylIleaB/Zkab473OL3ZpwSuRzaRZKRbuiQ5aWn4HhR23Kz?=
 =?us-ascii?Q?XBul9f6ro0U5XXWf4vaDrWmZXss6ma7jvQ/ZhXH+GznRPCZEfa4E3y/hszpT?=
 =?us-ascii?Q?7OPU+WzSscoPlvsBFQkEZjCGL6XWIlEA+2V0Qr4vyoV/1m1lqbQcDO1Vpqf6?=
 =?us-ascii?Q?TjG5YajiiItBMAOoGFI+L3Z+xqsAlBKUBoA6EFV3MegheavIe9pxhJRdb993?=
 =?us-ascii?Q?W172nzJZvlJnmgdVffU8L6ZClsUxvML+E/OpcNDplPJ6G53DJoWmx4gTqV5W?=
 =?us-ascii?Q?YW6lRLtDMnZ6t4arMlprvYrIS+3eLl2euBsiO4aPYMFBG3Pm/uNPOG7cdmjK?=
 =?us-ascii?Q?JumeSNU3LRmg+SFTlCodJ/6tyC4Ka38k5Yiake3LeXCluSiD4qZO99Viguzu?=
 =?us-ascii?Q?dASf/368e/WL3K5WOuFqiY5fV8Q4Ex1WH1sG6m6D3tVY0zGSud4GcOa/bgR5?=
 =?us-ascii?Q?VYkibMPNBenZKXmhwnUL19tbF98P1Ph8T6t3Y1Jhk7KCjia1m/zj3DUOePCn?=
 =?us-ascii?Q?5D51UGKguwwvIj7rx/7Iv/hIMXvCVkPNXgN40OevHf1GMEd5qwnXFUw+VEJT?=
 =?us-ascii?Q?Jg2Jv/wvyGWkLwZ2AaWNcJrfZpXb74+Wx5QXXNwg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0af3cfe-0dd8-41a2-a39b-08ddec4d6f5d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:25:48.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVZrP5Ic6dH3cp2QYqqVDpuVge3ZL0I1B1XJoEYhns1LR4kkGlxGzl0tG+8bdF7EjH+nSVI6kZ5RUEi8u62lYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/hwmon/hwmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 1688c210888a..0514e4bc5e71 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -239,8 +239,7 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
 	if (IS_ERR(tzd)) {
 		if (PTR_ERR(tzd) != -ENODEV)
 			return PTR_ERR(tzd);
-		dev_info(dev, "temp%d_input not attached to any thermal zone\n",
-			 index + 1);
+
 		devm_kfree(dev, tdata);
 		return 0;
 	}
-- 
2.34.1



Return-Path: <linux-iio+bounces-23750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929DB44FFD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA57BF90F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D427A46E;
	Fri,  5 Sep 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OgnLNm/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013046.outbound.protection.outlook.com [52.101.127.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E72D481D;
	Fri,  5 Sep 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057382; cv=fail; b=YltPN6FwtegRmLc6yJflBBP4dff31/0CCsyKNkHlE1Uc4cfdl8FABJRohELe9o3IUGcEOY9pEb9osn1tq71M2mPjHJ8DoBmjXzRoPggh+pXOVU3YZPY91UGRKNWmVPlJTeX3fivHzNv133jw0eFq2KDDXNXuPGadk/Jcg0Yv4qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057382; c=relaxed/simple;
	bh=eFrptktn094J6ClRYN+jDjwMTyKBTZRmY5vP3uO/sM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIbibskfWYAn0VjYiogVfGnXJkq7OsiMMBFEUeGfhGsz9RbxJ5KWk2p8XsnR39sBMc5WfFVz8e3HbV/srdAJ8Uke4pCwD2YB2hLhqzBywgscHntNhyRBWgjUCrqgmvtnG0Afu2UUmNOrPm/goMwAtVy+k0FFWqDQk0n64s1C7s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OgnLNm/F; arc=fail smtp.client-ip=52.101.127.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnCuKh0zwyybG9zl4lAIJAXna3hxza6NedOLbwoNH8L8dbQTx3TNlRMBgr7HlNkUeAZGurriK3B9tGKnUeUbGtY0PMKvEYRn454blMnRP15EjssnnztgJa8NyRaXoFzxmxfrVKQrcr2VmiSa7yadraP9mp/RUe5ak550dwp4xp5zyV0Bqr5w6oE5KsHZlBlZsH1tkQ+pqT45XvVzwv/TThBkcAN3rT/VElGMorx9uJW/2ZlJn0ZB+fPVsCWTqlklHW/j/H7KV92AZup+guuJvmVHZjb1IZCmLDY1Obbn1frEckA3PcsT51uQTka2OhHPGk8sMLAbZT+l/RVL38GDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeYKkWaQLs/CRaoMCLJM/Vu98fUwCF2ggEJgss5OwXc=;
 b=oplf+ylSVJnqrmhMUZR3kiR3diBbSUyhzw4vnDtwMYLrofRZ9xr9lATIy1b85xsmklZaa87SSZ4bh4yelmjq9Xgy3HzGGPJere3lR2bo4s1yk0iixgLrcBByV2nVML/XZx8VO/GSX0YTFTFgKO/zSzZDdmr0HbCBpWXbrZ8s8MFiGUeLuQhx67vBUdPKTjFdfQOFI2qxvJpmtF2krtiQ4BvpJcpmsW9m8mafxhz9LjWkEC7LW5EzfxTtuirGJxoLE8zbrlkKt1EPMCQIhXnGGTZD8hT9ZP0W1h1MziD29euc2Wu5xfCbF3ZM7gSHzA7ZGpLoNqIo4NV8NF46X12vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeYKkWaQLs/CRaoMCLJM/Vu98fUwCF2ggEJgss5OwXc=;
 b=OgnLNm/FMMH2nhrNuzKTYuaTPCNno6TRvtCd4p2+byRgLC4W4Ls/wC2jHiaM8IY74ONGDg+1v5y/rd+9/mtX36eDt/LbZnWekYVVKS7lztAUBR+9eZ8HxTuFGcnWZSvNS6LnEPS7b1xuUsDUq2ZdQkKydvO95Po+0cEevACn+M/diP3NDVS7rRd7RpaG8SkzsEGVhRI1mRCP5jnGehvcC4aCjMCmNIlT6BSmWk66C4KyNz81GhBwFOSGFf+5mCP8fY7KFpO3RgHhhzvCyoVW+BcKhr50cI4iSklHw4D1GVw92qPIhmOgXCcZ20BHDeXpIhHO1s6uqQaPi2/LcmH4sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by KL1PR0601MB5837.apcprd06.prod.outlook.com (2603:1096:820:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 07:29:38 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:29:37 +0000
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
Subject: [PATCH 10/12] thermal: st: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:24:02 +0800
Message-Id: <20250905072423.368123-11-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b98ba3b7-5241-4ca5-61e6-08ddec4df820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyBF93/TzmlTMPJHZ97bHx3G6dLPWmcerSvzpzhgsFmM8Ldsr4ojfZfVpyYo?=
 =?us-ascii?Q?YFHOgcofig01bmbrllRp6PEvxCFXOAJeOw6e0cgDPGVGvfFXWu2KwKI1sTuD?=
 =?us-ascii?Q?hfV9BQFfz3C22kwHe/xSgkS5gQu6MFdwUCzlLr0DIRmnBJYSlYC1MxBpj/RD?=
 =?us-ascii?Q?3UA6/UTLWrl8PtWgB3Kp+VGqiLhNMgIeDWfMIp4fWdcdsVeGPCD1hHgrhCBh?=
 =?us-ascii?Q?uhmnin4AHViLU3OHD/7hEXojWQpqYbyB+7hhZx+wFNUPbbuI7FI7peq7K/CV?=
 =?us-ascii?Q?DK5h22hu368/zuhfZWEi5RRGF0Kk5BQPGUbxgyUbVVhXyipSG47vCkwWCyr0?=
 =?us-ascii?Q?XM4lP2TLLetd2Yetb+4OEO1cvBqkEj1/2qjzeU3QbigGqAc92WLz5Bb9gGza?=
 =?us-ascii?Q?qqwJuwT9JI67ygsse8UH0ggSyMO103YUyNf/6lvYO+Yt+HsWymsM3MzqyAlo?=
 =?us-ascii?Q?iC+oAHqG53zryxhEcY4547dRovVTcij8u7/Ptr0NdkJHHhfYXQB4mWV0JJ2F?=
 =?us-ascii?Q?ulV0h6j0yTfsyxG/8ER190+rOgg1H09rAZaoSZ5d2ix8YlN+Z+GjKcQ/4vKI?=
 =?us-ascii?Q?jSkgNpYl8XAf4txszbY45yigQjII6OzjSVM++JeOHkHJUHqqYE7CQN/XnhWD?=
 =?us-ascii?Q?Qt8/9t+lU8vD0bmdkOsdsIHvMviQAwaOyOI3nVdN/QYFDHoPiMlhiL0qHas5?=
 =?us-ascii?Q?6arNCDy9Ey5pCE3IdTlIFQ2plG4VLtQuWkTnpRiQdSyaq01v4Gvp9r6Ardza?=
 =?us-ascii?Q?NPI2TGHRvRignbTPfKxVxwodkLkLTQyluYcWm9RfAA9PUNAqGhHjqnTvCfsb?=
 =?us-ascii?Q?Moh7kUN8h83kjmKsx+ZMmKWONo3t6qJNwB7G8WThTm/gjitr2P0WJ1kdi6A/?=
 =?us-ascii?Q?FU6A+kBrlrBcUK3Jm4tOpTo/z6SSWWvjA/iDvHPziMJgc/Zc129lNeFICciE?=
 =?us-ascii?Q?4RbxTxqHwtBqYTuSVw/m0f3PfzbsWwf3aseii8aM2Xm8A7L/yT4elOSkmxnc?=
 =?us-ascii?Q?AeP5/VHB8cQXg03IPbD2ns2Kj80BKO6PR8kEXGQgDr7Zxk8KM5CHHFxDIxL2?=
 =?us-ascii?Q?0lGZC3+ykMWA+ZSbSfKUtaz2D/RbxaprUbY3SoXbxV0smTY5sxKFp9x8Uv7m?=
 =?us-ascii?Q?QxFdDSMMbwAiygvBgTWTdwDDiSqbcO8WxtN8wqI0g7HnOQ8/nAafTpUAZ3cV?=
 =?us-ascii?Q?Vzn5P7cSyEEBjLulaHr5dL7lqp7A2k7NUmJkXCr0ef89ot98QBIgIyYoBkHB?=
 =?us-ascii?Q?WVWWmyVcNmoGQKdXqSOyeQrtUm0mphn2zwbbNX4zTy7cB1kut0jC3Pv1WWtS?=
 =?us-ascii?Q?m0fSGtrP50syh85qhoqunqjqOcy++D9HYV+tyNNYrycAZXTvbvMlP+m5o7zd?=
 =?us-ascii?Q?4HHYq0fxpPvYthAx4JylJ7dJsqcwWMFJ2htKueyH9fGX2l9eeAjp4BrTi8Jj?=
 =?us-ascii?Q?oKTCSHoa916T5eOxTXLfhFj5n+16JPBo97uVBhvoVFCJ3dmAeJ0YesmxTqN3?=
 =?us-ascii?Q?D9JGc2H1G4SN2YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNcpxZSSD1eEomqmpw0bduNWnqQI/s0fTRYb90DfBendeuAIeZMUInJC5gMj?=
 =?us-ascii?Q?4PebpAvej536sUCoNpgjSQvyP4rkwMAbW7Qia67OcIh37yOboo4Gpajn/CoB?=
 =?us-ascii?Q?GNFuUvkmCLzPXqc7cv5PVt0FHAdbEdBq/Q1xofOWpWr33cUsQZl1Cg7t/HIl?=
 =?us-ascii?Q?jaGMVRDca8cALu3mevFQTdYtCsh+EayIwK2RmuOTTgKIa3cvRBYbeF0v927V?=
 =?us-ascii?Q?zUXIQx5qBxvAolrxJ5+M47Fc1bwW58k6LF/kUSv6Ddl98p9DBQlaWqJ6cTwe?=
 =?us-ascii?Q?OCrd2E5eO75qIc5cQykBTjJNOPYs1XTAHfGJiroY7y9e8MTZKdliRZ9SNRZH?=
 =?us-ascii?Q?HOyeVSI0O6kCQRcz1cAaKXjuMcIIWWoFZjTQdbE5bRxPgPkAw50RIp7wqnPZ?=
 =?us-ascii?Q?f8ZFLIrAemxJzCrkHrwcVMYhIuqpjNLx7jeE+Ltb/h6RF0TKMFy6UC5t67fO?=
 =?us-ascii?Q?uoXKU+BJSpkpB+vxpFCUSj6Z1/jzaXIomTglmt0wb8KjhClxU//+gPSw6rFp?=
 =?us-ascii?Q?IvUN1Hy/nOrysdLNMgWSsMRA8xJAMguZu6ROUV+D8Uj/P9dn4nxki6MTPwgR?=
 =?us-ascii?Q?85ctfall44ekTnEAGtm+ClEEm7ADI+3JsOHeWsZyS7/Ea3vtZMgMxwXv3npL?=
 =?us-ascii?Q?JfjmyLsoshUhi0IaaS5vkXTnK29EP6Oakt/xkXopM0xXMvO0Adpqp+VMZnNd?=
 =?us-ascii?Q?DIHmCgoMcioPSsMPOKPJGyUsGD9+ngSk8JjFaV7RQlHpniyWuQhXRQJeWbLG?=
 =?us-ascii?Q?rwKs/wg2YtOMcI5P9mC0L/Caax+pvtCASGvKpQT++/va81ze7Oa+pTc9mI0j?=
 =?us-ascii?Q?f86JDKl0/YUw+Ijzsf4mAAFwqX2Gl2wjbMVYrOfkpWLNDTxwuhTuJ1ERvZIL?=
 =?us-ascii?Q?7nBp1I6SjIqT+GV5SCmET89zAqYWfLaIRURJnG8RZXLVGT68NQBsh6roxxNt?=
 =?us-ascii?Q?HCHP+pZTvBX0ovScZi3EHUydPwAZRWyV3SYBazq3U3QFSIn8f22GwpYWuVoP?=
 =?us-ascii?Q?py/NIYOoTGWqwPPHGiGOtJkBCktuvZIhzWEEP1/D9LXswt2ad2mth6htGTMA?=
 =?us-ascii?Q?Xajs8j0HsXyVTn11NBeVz8whkRrl2sozXm9U7ocX01ZGSUiYdxY37qGa0Vv8?=
 =?us-ascii?Q?2LwGMqeR9nAlzyyzGqqhtDtt2WT/keW+bCTEJMkdF6tfwNUZ0mCGhlf+Rce6?=
 =?us-ascii?Q?oAD7l+aM846f17lj54NJXo+9PnhuqtJFrQyAXFG1dQSAbsgVTUfFiuRbcn+8?=
 =?us-ascii?Q?+PPBYO4uHSMvuww688YA8J5ZUXge0qs3dEr5WwyXgSHXs4ThljO5Ny9W6X8w?=
 =?us-ascii?Q?47ZQDdg5TahYYlnyFQwKF8YDDIshLSjr10aX3ltJOaMwklUChVEqw8JT5+uk?=
 =?us-ascii?Q?BMsXo4xc9XRJw6qHIM8HuPHI6stQS9B+jPN3M6FxN4WZ4Tk5cd5stpYvmIGy?=
 =?us-ascii?Q?SNvXcNot/Bz52ouZFewxR3ovew3d2j6NqwBIlSj0mPN3BAk8ZFLpI1I9EC0n?=
 =?us-ascii?Q?0kJAuRB1EI39ACgeQnsMuOCLuN8IFXGXrTCboyTofRwBuf+YzQaTtRY8c19a?=
 =?us-ascii?Q?nHmPCMgQ1Af8laeaINjoU+hoPKYioTeGQI6bbov9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ba3b7-5241-4ca5-61e6-08ddec4df820
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:29:37.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKTkVh/cuBqxzwxv0/CnFqMKsYrUIOIp+WtHclF/ztYl/aKETlo1D/SbCS/oZE013lHOqcTQL0z3rdLlLxvghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5837

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/st/st_thermal.c  | 1 -
 drivers/thermal/st/stm_thermal.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1470ca519def..6d0c163658c4 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -198,7 +198,6 @@ int st_thermal_register(struct platform_device *pdev,
 	sensor->thermal_dev =
 		devm_thermal_of_zone_register(dev, 0, sensor, &st_tz_ops);
 	if (IS_ERR(sensor->thermal_dev)) {
-		dev_err(dev, "failed to register thermal of zone\n");
 		ret = PTR_ERR(sensor->thermal_dev);
 		goto sensor_off;
 	}
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 6e90eb9f414d..963c347d0ef5 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -536,12 +536,8 @@ static int stm_thermal_probe(struct platform_device *pdev)
 						       sensor,
 						       &stm_tz_ops);
 
-	if (IS_ERR(sensor->th_dev)) {
-		dev_err(&pdev->dev, "%s: thermal zone sensor registering KO\n",
-			__func__);
-		ret = PTR_ERR(sensor->th_dev);
-		return ret;
-	}
+	if (IS_ERR(sensor->th_dev))
+		return PTR_ERR(sensor->th_dev);
 
 	/* Register IRQ into GIC */
 	ret = stm_register_irq(sensor);
-- 
2.34.1



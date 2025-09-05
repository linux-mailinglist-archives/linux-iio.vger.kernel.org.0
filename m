Return-Path: <linux-iio+bounces-23751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C5B44FEC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EB9B62BA9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20F28488F;
	Fri,  5 Sep 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pcc+19y2"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9A21A420;
	Fri,  5 Sep 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057412; cv=fail; b=GBj8Bpee53Ot89XjDO/VoiGOsl4nVIQdO3ONR9KckL8t4viLfJcOLPXTgxKDUmiizoZ8cHRSkWyY8TTFISmcZv8TSTRV6fjQQop8T+v8Wc7aCt91ruAfzlZ/V8UKEW+c9IbIkw6rFRRk4Eqm397FOL21lwgWkIO0I2q4SQSDoDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057412; c=relaxed/simple;
	bh=zwmOFYkSTLOhDDa9WbAJmmLe/c7bJBBRIRSKUdzROyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQqrMlfuaHuCItACri3K12bLA1fPjrXXcpDRbyiNtHQjBfdzZ+alm4KZrBhrRk03r9gHpDXXcWvuo5oDZZIgcGTGLJyPHO2B4TwqMolYeyKH84ZxdQcsh0piLvGomPgbNyBG/Zp6VIXGrSo0BETE7ZR38wzA5216krVNvASBNww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pcc+19y2; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYz+rKsTEe4yY3i9vl1yla7HNK56HOLwAd9D3mJRFIfSMpfeaXP+ew/wh3vVpNQc/yoVE8mn+Lg05IZtMhUqvvRxFwgy2+WgbxAuUJGZxHmJL6p95XsarfmpEyC+y3TO1Ero+TakTXHEFZntVfSoPp2XV9tTzn09Q0Mbn2pFWx0HsIDWRT55yqPXXWQpECG9WqufBkm1sWQMZwmec6AhkCoemD+5sBPX/9/Ykizhq628i0OVdbwd8usqdj46SXJ+K5t6w53AxL+cwl17exjZm3eDRokNKuNlRCiCVpdYaq2VCj9jmi8pz6yi+hAlE+vNIaa5rFatTTv1OGT82mzcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+k54ojTov4JB/am4DUU7BjjPlfJ9VPOVzVc/U5yAf4=;
 b=OKrecW1Vgzzf+fwRzzPHlprk8NnD64kLLHElKtl0uVmvsr8sxUy3pT+EXWzt2CyLBIdmWLs5/U+Mqlnl8pc/R2TsE7ALkCEeVmy+y1SGv52Pmo96lFsX8hi6DZu+ZBxPLpL6b5e1tFfiUMssyvpQttfmf+ktX/aLP9bQtQPfDNmxQZebs8nhfl0t8ulaiDnrW20V3YljkS9eBEq0h9zKy4tX7AVhlDuW04C5ebLHdxXHwf+2dTWhMogSjrlrU4YCZPK3YnmxJFvhkHfIjiY76MG+/ZmeLNoZumVPoPAH1IGFxMrFCOYu08D21a4dMFNJuKwyCYvUOR6d6TqISB1fyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+k54ojTov4JB/am4DUU7BjjPlfJ9VPOVzVc/U5yAf4=;
 b=pcc+19y2AujYE3Fvhdd63eczoYc+V/x92PVNM6Hg4mflLCWZuGNhbUCm6waj1+/4yZ6owvzyw/2rhvmqAdKMb3POn8ZsP4vUH/lanIF8COStfDO+fyXW1TZJiVXbjg9ID9QwkfxVrZmsf8IQSou0jyQlaGPsUCnDKEFDx8W5sOPzwKVgZ2lQzL+a864q3otVlWPSX7bpcH0hS4+vNt3RDifkFISkkEhLI7OD6iyfAkGlTZZR3GItikY7ggCzfWzRU9mnSsjymZPlJroZMommJRym82xEFQIpoHkgcu+hDQirTiHMiOhrj1E9BWRiQ9H7B4pyze5JKEAhOuY0LRNw5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 07:30:07 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:30:06 +0000
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
Subject: [PATCH 11/12] thermal: tegra: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:24:03 +0800
Message-Id: <20250905072423.368123-12-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98f9595b-2c1c-41e4-98cc-08ddec4e0909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oeKZDE6h2Os7uoFLHEiH43ZQo8kLa/irn+DZ/eSK6ciZ3qpJIV7OmXUrjCP+?=
 =?us-ascii?Q?p61XuqSpBdRTVYCcJ6futpSad1YcRu4t5nlb2uEJX1a5LFvYPvf1IABKPfM/?=
 =?us-ascii?Q?j9Y16FJa86zeKLX6VP5KLODuE60gjaO0mrB5lT6xNNce3pCqXpQ3IKbUvYSd?=
 =?us-ascii?Q?BNTGE/AWz19Gvg9BAy8nntU5PDfd5DqF3tXCaxDU59kXOiISYAoBZrn8qK9q?=
 =?us-ascii?Q?zlN/ezx+IinqLSCRjKazmyCplLnUOQmwW4fD8XDLavOeEck3D8VYhdwOV8kN?=
 =?us-ascii?Q?W+0YIEDqk06zZuGecjNf78DJNSsERZLLZ+2GzkctSedGxo8wjFdJlPnz6FZ1?=
 =?us-ascii?Q?M4JxW+T9DIzVScHFnvFriR4bap8BnVKJ1g0hWyOgO7JqZcRCitTY5hG1NU/2?=
 =?us-ascii?Q?wjKIBszOs/uQCZFT1AJ0K60AHpFwRIUBLVeMLnnsbleWQTweHRC4cDU3ciBo?=
 =?us-ascii?Q?C8yd8wbn0pzCZkMgWwAtmpsh2mYMEpjGvel8bUc2dK+dYmsn+hPB9uStxInX?=
 =?us-ascii?Q?eMpJOPbZynJ9OAQJbxXTaUmzK/bbGD18C/XyCRha6ZBj3TTrGXmJ4JPRdbHI?=
 =?us-ascii?Q?LCoZE34iSpPSAeYK6UgU9Sh4Rz5s48HZgffOiv9Vfe+p944rN4Kn9/1xLyrG?=
 =?us-ascii?Q?e9GwXyQaSplAuBr4TwdK9U2+rV9tOWr5sgdLThG+hM32AQEQ+r3gfdQH3+me?=
 =?us-ascii?Q?/1Sp82aoWj9pe53IOUnTEFE1Y0Pd4cGgITu25vlfoRMNLgPnhDkdqsyuUYxV?=
 =?us-ascii?Q?ou4ujdwn6GXVJlAtiY5GeZzlnYYUCGxViroONNKaJ2Vm8L/XKOQOJXEVXvU5?=
 =?us-ascii?Q?7DgSWSx9UcJsDloiig/BYn7s/0qfDJOgUkBumaK0BagNFMpw8YjYcJe6HZCW?=
 =?us-ascii?Q?h0ybG5wn2O0eZJGUF59gcVur/rnMgdOIp4+PMi9CxKl+owmdU1dGbA36d9SH?=
 =?us-ascii?Q?TyBcjHcHgueHpUOlqicQe7/GArw/35E+Jc0VoNEKSN90eac2Y2bCqqGDM3Wa?=
 =?us-ascii?Q?FCRowOaJDqPT/WFCSlzR+YWj2E5XhjNQUakAIt4j4Nix69bHxHdchKbnXIQY?=
 =?us-ascii?Q?CW1AbMHuP6D76GvOTJNwiinTVMgw8lDBWsT+c/CHNbGD9vcEhrm6MrjeOvIm?=
 =?us-ascii?Q?T5PpJh7+yY5/z9XHrV9nv1fi/NktmmsTKWX074+YORjuSj7IevWHeB8NRbSc?=
 =?us-ascii?Q?N5E/DVpPAqhWzLdKiRySDnKaAgM/WTvVwfcwMxInhCmDIjplYBvG03cBKXHC?=
 =?us-ascii?Q?rxDNKu0JsWgDRzxk0vkPZbzw0MFMF3zIYHLeJDRr05uoIsBR2iWkrrK7Yvh2?=
 =?us-ascii?Q?l+hGZU7pwwv1QdF58+0rtRUaGVVii1G21rzzCQBxl9WgZm/99csC67by/Ult?=
 =?us-ascii?Q?TlyAZvvZ3bn3UitKZ/TwveMInXxXQbQB6LAkbM+PweBJP3aFM4UWZj4EP7UY?=
 =?us-ascii?Q?2Z/ZPHIVV+Dd6jx6yWwqGOvrHDsK06/beUnLOy76Gl3drlVhJwf5ubo4Cbn9?=
 =?us-ascii?Q?RmNEPDgVidbQ03o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rb/I4Zr9mUaLstWegBpjnGC2pFa2w+fky+AtunBw8naDsKgW4BAqv+OLp2F3?=
 =?us-ascii?Q?rXIX1UzzsiGEKLMsshyAHdv51Wtmxxn+IJWzHSgsNy/kAaza24G7uTxi7VWF?=
 =?us-ascii?Q?t38r7z41f54w5AiXf6QbOo1T4im+uBT7RwBdWWofhUyU8t6rUuxd7WoI7xo+?=
 =?us-ascii?Q?hEFzTsQsEjKkcOJx4yVwL1XcO1mMrPsTINRzShOXmjUXFePlTXE6OQXRqsGZ?=
 =?us-ascii?Q?sN5H7GJgKjK7jzYiFojzg9Ff4JQvh2EZfO5+UvWk3L8X/Ag0nnjPqLtsDrGl?=
 =?us-ascii?Q?wbLho0Esbl21ZeCFetuohbZ84wbtGb7ZJV2ZrN69qUmtTiJVNGapoYuTl5E6?=
 =?us-ascii?Q?qVjH5jko8jfNLJgUqAzWMa3Q21Zwb6zOXQ20kGOz9WXpbAinRcbVCbm5OPC7?=
 =?us-ascii?Q?uyfjcZv0JpBZKTPUwak5Rxe9d6GSn/RhfRaioiNowwTcwGdc/7niW549icOy?=
 =?us-ascii?Q?KBO6VBPrxF/eDcaJf7w76K+z98ovj/V+zJSeHS1FmNJk0tvaVSmAIbHgdZ1z?=
 =?us-ascii?Q?QF3J5zXaCoa+rXufyTzgR2tZREiT46qxOpkMFR6hjBk6HZG28KvvOutblazl?=
 =?us-ascii?Q?Th2DPZmV2RfaKOcm/frt2TnWFkty3sWLlt7YmIymr6fnmr7meKEooKpUk/Us?=
 =?us-ascii?Q?zt7BxnuGhA54s2DlXA2cryhGnCllVGnpq7qkIxIWGA6O0GVSJMBMxLrWlbUJ?=
 =?us-ascii?Q?5xImvbDxpJtNOTbjkPrc3i333jMx990QD0byMUf6VVLzz93ZwgYmOsOX4heR?=
 =?us-ascii?Q?KKJQ2ga3qqhz3Iuw4/I21jdjMybDj5PTwes9KwSdtLWwsSlvu0kykBha/vn1?=
 =?us-ascii?Q?7lWm1tIwisopaXKtDciMKEbjoMIBx4ZSzqU6IXb19oo7vf6tGRuY77sCv0zX?=
 =?us-ascii?Q?wc4SsZuMxenP0QoNQuguw45i995SvIk0IYSVDOxyscu+DCk6+Dr7Pm4zKW3Q?=
 =?us-ascii?Q?VeoThcuo2cvR36hEtuv1jf1E0XfWyD6qO+cWyaNyEl0uZjGlRMIkEr4KpvoN?=
 =?us-ascii?Q?pCUfydEvbj78Mv2pGBbMIyVgbobKVHQfi2oqo0pe9iBRoNkfgbFCuCO3078o?=
 =?us-ascii?Q?XYPxvbOMeRDvGgjPT48OE8L/hsD62Z/EN4GaNsAC9KY8sG9JJets6Jtq72cB?=
 =?us-ascii?Q?6tCuKDTaJrGvL/o/IItut10TUHZGuizbbzx0uCJ7tyfX9VP7b+daa/e5AQEa?=
 =?us-ascii?Q?MaTTU7W6Xwjydidt6DR5+xvT25QNg6QILUg0SH4z6U8In2U82RQVmtZYJQju?=
 =?us-ascii?Q?MsN4QB6LdHDgMI6uVUnpHqs96N0Zpb1l5efwmNPISIUJxqasM+0XKw4OAxFt?=
 =?us-ascii?Q?WSPEUrg6CBF64InbV1zJftDaxyETReb4kki/tjiBkttMVnp8qwyLiEU8YD07?=
 =?us-ascii?Q?66jhTsM/PNYqpBVFvFr8HhtpJXSU+HsWW8OdD60FnVpyXWhu1X45g0FMTUxV?=
 =?us-ascii?Q?J8NBoJYPjOCdIKI3GFN08UiFjtCsNOmY/giQVdHAHb7EB7My8kIIxGiGNK5Y?=
 =?us-ascii?Q?sESKuKXrqxCXZlHlW580Z6uqQsikHE0ZEKHpUEfNb5ANq6d/jqpqkxUm4SE7?=
 =?us-ascii?Q?1WDqobZib8VJlEAk9tEqUvzP0cCuQongXh68Sudk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f9595b-2c1c-41e4-98cc-08ddec4e0909
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:30:06.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msrnzxuAPcpwuyzq9ZOPMRxnz0p7+5THXnrbrt2nlfz7F4UtMKBwTLFDOPbjPu1pZgHJq82P5vi6scvXDQm7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/tegra/soctherm.c        | 2 --
 drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 53a5c649f4b1..3db20d34f88c 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2186,8 +2186,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 						  &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
-			dev_err(&pdev->dev, "failed to register sensor: %d\n",
-				err);
 			goto disable_clocks;
 		}
 
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 6245f6b97f43..7bb9776c4172 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -517,8 +517,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 	tsc->tzd = devm_thermal_of_zone_register(ts->dev, id, tsc, &ops);
 	if (IS_ERR(tsc->tzd)) {
 		if (PTR_ERR(tsc->tzd) != -ENODEV)
-			return dev_err_probe(ts->dev, PTR_ERR(tsc->tzd),
-					     "failed to register thermal zone\n");
+			return PTR_ERR(tsc->tzd);
 
 		/*
 		 * It's okay if sensor isn't assigned to any thermal zone
-- 
2.34.1



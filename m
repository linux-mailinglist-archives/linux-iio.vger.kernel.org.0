Return-Path: <linux-iio+bounces-23741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C5B44F7B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1883ABC9D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942702E9ECA;
	Fri,  5 Sep 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bfr9jJn0"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013022.outbound.protection.outlook.com [40.107.44.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CE2DAFDF;
	Fri,  5 Sep 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057125; cv=fail; b=kqEStOz8eOSIIjypKEGBfKBfncQfv1xZqAzMAe9xiowBIpxVcO0gETODqCZFDf5MzibapSgXPScOb0Evjs2zhXALoIHlcLLluXlSb1wigKqYzpmd0sc2LLmLkCsf/PZK+iieskxrOjO+Csysz9Aa+3EgaJwG/mbt4p4gb63aYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057125; c=relaxed/simple;
	bh=aenjcrfMc9mimImGreYdaDbyINiRStiF0KkaeXFas7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2JhNKuHF5u+UZy8N3sg39XKkAHhX1CAeJlMu/AYbp1Vt5dX+e0AKm76TEiBJ/xVuS/BCXpcDwbgoHuEPq9MTYyumRKI7zdQTiDIf9WRyVTjhw6BvYvSTUSmK7g6ieYY9h3D6/zjV0c0XQTFLwqMxKiUr5+E7Q4yPKdcbrPTg0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bfr9jJn0; arc=fail smtp.client-ip=40.107.44.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbBcZaUNub57DYcoKlbaHj28WkuLvAwVdj58bbVNMRE3Iu1gqvJMmngsFcK0ArEn8Rc3CKoiGhj+zkx/346HEN8+OZMmrXdlRlzPp/7gBWvHK7PE+Yj97Z1Jq8Msr5VdByLuK6rFyYvUTEA7MfvzsQrd2LTvcECiNUukJD/Rbg5YmAupA+cdIjUdVQwjfLnEXNfKqQAripWEixwsObgvHmCTlPeQnMRpMA9RQBMhaX2kJ2i816f+xoF85moPii764BCIrxacRKE40KcBsDuAp1lDhnCl7RmXmOVlCYp3e15BzFcdnRFlAOfhwQSN6txUDHBU57523Qy3UJwVxLRQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHnz7gT78ZW7Tn7xfhEXGj7EezOWWLj2FzQbYHvesfc=;
 b=mH9W5zTMFYz9df+DZvpvtQLen+Qinjt2G3Gr383DKFxxfDEQHt9irb8au40GKa1Ix3vuo86I78myy5ELFFmaW0Vsfu4vA+DAw9kdAQC08IS2eKQJ1siYMnl+EjcZqeTQXx+dwMT6IPIChoF4GPjmSAMQZ3NbisQ3mlyuVnffQ3p924fH3AcndSLlivFhFjvPFEObJp3cQiBStEAYDgA7BXOm+zgSPZ51yZ6Sz/MM3UT0N35/pyKzdRfYuCOHKBVqRM39iYcVc6InoUgWKGDYjQeJNZ/mD+XFO8tWTwy5C3dw8qKB51HFhJmHr3LU4866OWJDl9XaLiTAXENgt6kxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHnz7gT78ZW7Tn7xfhEXGj7EezOWWLj2FzQbYHvesfc=;
 b=bfr9jJn0NtArYEcOK/Jf24XKvwDOvZ8u3FBJesVrruajN27/nwrDCGtRsXOy5J4j9SrHOQHLU2Thz8YOxJE/SKRPBRp8D3jS4MR83uVeHDjXzNk9X6sErKN11dbrNAn8Wywaj+bO7yrs/CCBSC8lOT9q2Tzuj7+O7G5gNZixzQCsx3Rs2NouMlz181hCN3vLDWWRVFQO4IDWeMTC0IvJcX5lAtI2/YNxKdqvJuw5KmQ7LpWbU+DAWiPTp69DD6E5bJewj1yjaZYSinpGxyVqdEc8IQCpdRX7Q+eNqI6zWBM8yuYs54B1Gofbs0jPp8r9IlSEf/01d5eSB9896QgfjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:25:19 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:25:19 +0000
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
Subject: [PATCH 01/12] thermal: of: Add error handling in devm_thermal_*_register()
Date: Fri,  5 Sep 2025 15:23:53 +0800
Message-Id: <20250905072423.368123-2-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80eab107-46de-4bc5-ac11-08ddec4d5e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9buLFp3zvgXr3+jim7vVCdqCq4V1CMHbKHjM6YB+6dAS8MTu09d/tJAq80s?=
 =?us-ascii?Q?hALCKwrKi9SuH/aYIHnO+B6u2IdI5USOKsHZcNqnROGwFSrnaDzbF/XpONNV?=
 =?us-ascii?Q?gdTQHdqWjKC7vDunJK4SIFtnhSNWackxda3WjXYFpHviLquUSNduZj8UUdIq?=
 =?us-ascii?Q?AiIQFYMV7PTRCpiyXZmiiX3JcUHNycA79QTBjoNuRSpkbFpY/dCbWctkv7HN?=
 =?us-ascii?Q?84S/ltR2cN7+9JR4HRha9CSpWAclsIp0HOc7EbgBCqnEkNlyp4pvT0uHOlFD?=
 =?us-ascii?Q?EOySPiX/OeznBRCCg9DFz22gzgvpj7NApvmdMd3Z0Ok5ZwISjKdkO3DT/LiW?=
 =?us-ascii?Q?I7bfGF7gHMmNHt5rgIxhKDwu064Pi5xHR/Q8VN2BEH4+qYoCl2rIIRfoxX92?=
 =?us-ascii?Q?AqwrA3P5niULkOHIlE0yMsl3fgLW8mlbmqcXiT8PDkvYw7t0V6lrsrjmfhpq?=
 =?us-ascii?Q?4z+khll4ye9HMr8fqvoxjiqUaqCbQhhOgk4Cc1R9BEdz1muagpyguESj2N+n?=
 =?us-ascii?Q?8VpUcev2YUnMNH249qMgxzD2M6pl4rHSDGXM5Gi1H3/gTESb8PgNv0DG1EIM?=
 =?us-ascii?Q?PX896OY0Q6rIITk+fEC+JZ7tbHNDwU9oaB6LnjpiU25iT7hivka4RR1TvjrS?=
 =?us-ascii?Q?AF+JfWwB7Ww+wpVON6pahG7Or2R1m3axztJzDSpJbaSLPIuOALo+BrWWIKYv?=
 =?us-ascii?Q?eCINrtjsHyNyVPNU+7fWLByy4WeF6sxmIOhwP+qRHZTgNFz5dLp0BsO9daem?=
 =?us-ascii?Q?70KxnL4nCf76qD7LevjkB5yDHZyTfwPAQ4G7koLp+RmVD2p9Eiz4wwFBRlE/?=
 =?us-ascii?Q?OXTchHsFTzpWusc6mtKmC2Ez2DtN3QuOXZLJt1DMf3ek3JgjfES0vlhLQmV7?=
 =?us-ascii?Q?vLZiBVbZG0a8ULkDLA0RSUxTBS6rAxyQbMoeSthB7uxz36tUlO1b+ATMxyqW?=
 =?us-ascii?Q?t9WXVHeO5jMnLn9GVcWsHSWUFIir8Kuyw4q4VVSy4TFCq+FQUJUEvPj5uv+G?=
 =?us-ascii?Q?aMK7cAzVP8I05MnxLtjh6Z8gr/3e8uFH2Dbj4N6sLRzvCvpe4ZOClm+cXCNn?=
 =?us-ascii?Q?Xj+QcFW8PpKLj2luQhQaN/v5tLQeq7Z62LhQCOwHwZ5FpdAttmqO++rdaysX?=
 =?us-ascii?Q?gdDGi9vPtAVIXsUpkPbYvseGjqpvrNMsWobMmfBK983tadxyiwgTYsDmynOf?=
 =?us-ascii?Q?ELfrzWLVO31yxUWYjVOmNdEJEVBtA/xNTIywDn7HdSFSJYLUlYLU5u34Mixw?=
 =?us-ascii?Q?7XhXM/mjGZADRrtWB/Jug4SHSWe4/z8nThfRyGW86oPXMor2RSLNUUlyXvSy?=
 =?us-ascii?Q?xadj5T9Pz97vrDXkGHq6nihcVzqk7+sho9rLiPSPmIIa7z400PaSApqhFYCR?=
 =?us-ascii?Q?QhKa7q833lCoTm7L95DIEPMX37U5vqlwAjefgfGbFRuefHYeopndM7h0rpEq?=
 =?us-ascii?Q?aBZ7Pb/qspLp8sW0XRIqFbomtN/ABuvMEMXg1Ej4XW7wHFEgWDZL5vBzUV4S?=
 =?us-ascii?Q?5VA+i1WkawGpH90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5udhviKqS3ad7gxk1eUg7O8e7sm73ohZpOxcFTlZsrE+H/tQNQuHH3DCnh/?=
 =?us-ascii?Q?yrRkT5jqyUAcmgDMMdKJbtBReBVwZ2A8J+vNsK2ickxeZu5ZRTCQn3kuc3t6?=
 =?us-ascii?Q?vk1LCwekfb2txcJE02ErPcq/4KrNswMyNUVyjJNZhYoU/nAybJraqxWF2Zxb?=
 =?us-ascii?Q?EEYGh3WEOeisMQ1N/g3M+qQvkyR4f30d1J3E/KSro/GkBJUYZfbbvptlrVAY?=
 =?us-ascii?Q?1Aa78bLslokZBDoGGk4pzs2gQ+krH3j5vonEaYThVeCpotRTUPehznGRh+de?=
 =?us-ascii?Q?WHTNrk3h1GEdSfVREWRtrmEOZxgnMLQUHUi1zHllFE8hNkaqBmgwEY8sGry7?=
 =?us-ascii?Q?KC42jjVysvP2+A+RlWJPL6pt+1p+KtByX/FoZqfa+xNnrXYmaTH0BsZYdnFA?=
 =?us-ascii?Q?BkIaD3sXv6GyymuvpebXlzq+Q1YL04nytAdV4n5FD0xkMzK9OiI8cDz65Rk/?=
 =?us-ascii?Q?6CIbReDVo5TVl1UhxUPLUo8nNNp1G8ctT+Mb4fmUodWE/OhCobTI7HbGQdtT?=
 =?us-ascii?Q?24UvkvmlvawdFlP7RPzHJoTlwwV4tNlEHoaStltxcKjWtQSJmxp3QfPykceG?=
 =?us-ascii?Q?uDS9xG2jFLVHQZwUgfqVidURkneXfLzxV9k4nKkDE/Ss+rYPK2IDrBOder4q?=
 =?us-ascii?Q?FUf7Gaa7ztXGoeuiMC8gkyLlcWMrQ+QQ3DjMcLLmKVqwM9rLwM2kGsKXPvGB?=
 =?us-ascii?Q?bnnhVryYxMw90IPZFc1gZ3DYXKlb/PmVryZzrs+OVz0tJLXRIH2d8wlwkEc+?=
 =?us-ascii?Q?3irDJ7DsddHbHvuA7o7HfmbaYyLD+2IP8VqPxxhR+McqrC/X7jDNiYPvPYsD?=
 =?us-ascii?Q?YmnZ1scsGab+VnIE0SOHZhBF3WktRvKvEIJ+H0j053S/2vlo7PahkjajjZuR?=
 =?us-ascii?Q?On0epgV72CIkA1unqQdy5M7D2j9CEYXwIPnoOfuOODvk4k+Sue/r9ZkTnzgp?=
 =?us-ascii?Q?xywQrwdCJOsoBUHpru33o56aVqAxt2In+qkB8P2n7v9uwQbJ2L8pAkqZuH4z?=
 =?us-ascii?Q?49SapEC1Oys0QvFbLRRrKKkaK8F5sMdh3bgKaQWpZE1cd7vj6DInadYeI/LY?=
 =?us-ascii?Q?EbkeIKQ4EklRANhnpGgO4TOSfjNqeqW71UebOQecyX9k0vouCpjwqoQZB8me?=
 =?us-ascii?Q?qFi/tkyjrNDO8Z+lllvuGfnCLV62QSV7m7vT3zyjuA/00i7eipjVUrRcmm8Y?=
 =?us-ascii?Q?d7oLO7M5kxesRN3IcloOvO2usiEP978CGgPGEwUDqUYygqX0TrmHyk/99S6V?=
 =?us-ascii?Q?YWbgFh7x002+5BOUbcCVqrx5PJA3kd0p1D8O1OIuAdHh/D4IGfBEy3KUy1YX?=
 =?us-ascii?Q?Z+Q/882yc1Ujp/1Tosn7Fx5B+hcyRhmZ+jz/0DZRiOGbiNNq2MtRG8aAZa0k?=
 =?us-ascii?Q?JQ9jSPf4fYGr5P3IoFufbiUNMutIyZq46IqZoqtIfIqD2q21sa5BjSS2a/xg?=
 =?us-ascii?Q?nleJ8oseuuklnmew+AZbMkpciU1i0LrsxA/s8XBfEa2BjgGxIBjy8dYTp1Ff?=
 =?us-ascii?Q?VUsUS8OiYn13kjf0x5tAs8pRZikNyEQhY2bmEf2A0DM0ZUdFj7dYqGTqXLj0?=
 =?us-ascii?Q?ZEODhJWB49sLC5F7JAonJrQ4I4xeyd4FIKTIe3LF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eab107-46de-4bc5-ac11-08ddec4d5e3e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:25:19.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U97931r0l2GOHh8GiHiL0sQ8YwVb8JXoCeUAX2Sh0P/piK3HaLqEE0l7qFIDo4QJqSsIi0ojr1yKC0MIAYs6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

devm_thermal_of_zone_register() does not print any error message
when registering a thermal zone with a device node sensor fails
and allocating device resource data fails.

This forces each driver to implement redundant error logging.
Additionally, when upper-layer functions propagate these errors
without logging, critical debugging information is lost.

Add dev_err_probe() in devm_thermal_of_zone_register() to unify
error reporting.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/thermal_of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff..8fe0ad402579 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -475,11 +475,15 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_err(dev, "Failed to allocate device resource data\n");
 		return ERR_PTR(-ENOMEM);
+	}
 
 	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
 	if (IS_ERR(tzd)) {
+		dev_err_probe(dev, PTR_ERR(tzd),
+			      "Failed to register thermal zone sensor[%d]\n", sensor_id);
 		devres_free(ptr);
 		return tzd;
 	}
-- 
2.34.1



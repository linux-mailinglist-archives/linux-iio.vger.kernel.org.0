Return-Path: <linux-iio+bounces-23748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27DB44FDB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C782BB625E5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D32E3361;
	Fri,  5 Sep 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Gl1Szgs8"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012021.outbound.protection.outlook.com [40.107.75.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D72248AF;
	Fri,  5 Sep 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057326; cv=fail; b=rym8Fqv5O+GwhnX58ABpuZjhWAr2ozMwrV+uoq5JKHt71CHyVAVfOUpBFOmq6dT8+oP4dCdy/vTEBw4yLzV2Fp7osUdaT8xoqqnYCSebv+dE9VAgJ1HlHQ6PdAB5ozb8OZkrAjI58qrh5hxjhypoMC3PrmLB1xP+KQfJYDDihvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057326; c=relaxed/simple;
	bh=7b0GzX8QNH3prEwgWFGRwrlSf3LBQ0VBE2LGwBCN7hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzuaUQymhketydSvj3sANS8WXKxMX6Fxw+dDjqB9+EVe6zXytzG9fG5BqxG830Ee6Oba3c4zTbTrCvnpN+7W1hbX4o7wCxqhSwnN7KE4U8GoBjR0SSWbnSMrF4OoPR2Hh71uHliP5FCr3eahgM9LICKFDYxCsoCmpBlMymev+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Gl1Szgs8; arc=fail smtp.client-ip=40.107.75.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxNiJdxJckuQExD5PgszBJdAMUoxYsQKEBFL7MXcLokvu5mOkHh+UqbyOFJ1Coaoqt4xpDlitY/XCi9w1JaYSB072i6Cjqu+JMFbgqYukBMfQIwEKKz8MPbMkHgUDOA0qlreXy4Nmgg+OvPP6z6XJL3CPeN9k/mtdrJmWmMdh0ZLF9Q1pLSjbuk2I0BrY1+IvXmlXYm9r4SsmBMrKVZr1xubtfjifa7MOR60bj4dPfZZCOD9pkjx+H0YMxb5z87a1iP873g9SydxMLFxaBnUzaJls9/hH7ZPN/9W2JYyHUWvzKx6G8heNr7zTtpnF96obxs0sXXcpJ4ajgKGbpq4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC58hy9QtsDZcppllaNy4fg6cRzLXHCJE271rXZqNKw=;
 b=h4Wsv2pNDmcMJk1oX6ASVhLkP76AxvyLwQHbNbq77+k0Pg+od2NUocsGGvTyPUgtizq7RL9A+ykd2KvCdW4tkFowsAt+SrOqUNmfoLjJKmvuGaUQqSmWB/lKGzn3GKdYirN87zvM5/70ZcnF0nfD9uaT08mmkT0UIfFqpN1Chi6oSVCZ5SAmoCgL3haxv+yEUrGogP+T9h31teEpzTdRe2uqwFFIvjT6OXxt8ljiSiZjQztsgl9RcMlP2skJFTryQAWOef+JeTZ7AjoQNIcOrVwZpYpaSM8kjU0qYQ2mWIAFMwNMVycAtLS6s81BHSZY38YNOylOFGq8/gH0GvGNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC58hy9QtsDZcppllaNy4fg6cRzLXHCJE271rXZqNKw=;
 b=Gl1Szgs8gaBONGpq+0qrmmoeNMmAIFppJD1goQsVdSlRSSVJx+daSdOJ8AdLxIbT/R8m4YIVCY84kNJ8YDkkL+tR69H4Vb4nmyUUzjaJ/4APA7MJb+VE7/Qc6n93Bn1tpXnmfFQYZXdFsYVieB7jsmIPqf4CDSfHupHksJyE0uY8S14B0WQA9nypWoOReaPD3J8+HxP3fR0HcFTMpPxJyMofyxVZv5HJq+Kr97akkzAZMjpCCaagqGe84SclJX+4iUGxiXXBmz3HNPgsg8qRLQ+308zFI2Ftt08zz8QDW5nFq59T4sLI2HKruL5zbDPGOE2rv5jwoNpW/Faa74zFWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by KL1PR0601MB5837.apcprd06.prod.outlook.com (2603:1096:820:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 07:28:41 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:28:41 +0000
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
Subject: [PATCH 08/12] thermal: renesas: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:24:00 +0800
Message-Id: <20250905072423.368123-9-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8114e70-c323-4429-8ff4-08ddec4dd692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oNg3RUKo31BOF3ZfjH0eGDodvTSXqskp8UVgwIf/whl9kcnTkLnV9yVxtiG?=
 =?us-ascii?Q?RufNnJxYL1/CA+rcM4vbY1+iN/PsxNVvI4ukYRQSSMXu0TUSzT4sffn5t6Sa?=
 =?us-ascii?Q?9T2TTXfUHrkGjRyb2RxwVvtJ97iYC37tJ2xdZ2C/vhN1GlLdgw6VE1Md5eJl?=
 =?us-ascii?Q?OzD8tVFz0NJC6jNqiY6EsppY3qHPZnkptW1XKQdymIMSAAr1vUV1ZFz8GYcM?=
 =?us-ascii?Q?AZlXIQwcTJ5HIgYwJA315ix/H6eV7vIRAVSUjENc8C6sPkcFURKTgCtkKHzk?=
 =?us-ascii?Q?R+TPZmMzC66hFxvW7zwQ0rv60w4DhAePzl0EeiEKgvAOiSQzKfjxYT2QVZCa?=
 =?us-ascii?Q?9kHnADnlqWhGDd53WVxmmM2Z2gwV/L3IHgw0jz8OEMs8wovRMlSRZ+awZeeL?=
 =?us-ascii?Q?yvTViR3liWNRAMoWac40FF4PLjxtvA8PQ7YZJecNuR/Jtk+MjWshVLEt61g/?=
 =?us-ascii?Q?bqH+CBojb/Zn3CAQWwJhYauu7XFo33MsjTryRhNcS8f68csRSoSEEZ+N/J5b?=
 =?us-ascii?Q?nINrv8fADOTCJpxknPFbQq0PVJNeOiwxbZP0rL+oXlmgJWFmQn5GLth+Rxsi?=
 =?us-ascii?Q?aHnOgQ267rT7X4rEVC+KvejXnWKv5gfQUMBsdtMDur4h+j76NuKjPfMEmtf/?=
 =?us-ascii?Q?itLtD8jMmE5GoHhJxwMSUUSofeKZhdCktmt0VgdZJypJ7TtDvgyDt+8hkWKP?=
 =?us-ascii?Q?24C22BgET67WN8Sk5bcECHcuPMML7YsiuO4bH3HlLUquw3kbPC4fIgz25V5B?=
 =?us-ascii?Q?ZAqVNtSj8fckqv9CZfc+wQtj3zyg5cUYK2zA7Gu7Ez6ad1nniSRcweYZ4bJp?=
 =?us-ascii?Q?GKlLwKP3dUUxpQnrDIrJH9fZSGVQcsyN+VSoiAhxZrJ+D+6B8D3sz9uixLWm?=
 =?us-ascii?Q?si3WQ4m9OovO0EgYiDEZr66s3pyhyvCr+d8LB5pSBpUnZT+2kXAxx1IUOKiD?=
 =?us-ascii?Q?3AKmTvMziFSm0rQ1bmsdq4jk4984EzLuXTY//HPPzKAaGEmiW5LP5hDmfUJj?=
 =?us-ascii?Q?f/P53bnWs0GjBW6vSlTqHLgeLKxdT/nME8zpHsfJ/wR/c1S60YLZNQJbkwJb?=
 =?us-ascii?Q?GyVuF91pzUxjZFkQGopBVcrZBLjUPvUUEopbnDQFnE+GG3bAC2EpaPk43647?=
 =?us-ascii?Q?z/B4+q99BGNfFTyXKCgWPmRmfqJM8pjmGgPKiR6+Og9G0sEaIEg/7ZmPhYrP?=
 =?us-ascii?Q?Aw20b0Dil0TeVHzVM42/7iSKT6QGJ8NitI3wcwyDCxZV9bBm5nAlWnupEOWo?=
 =?us-ascii?Q?q3Ylxy6W9sYT1HPRiiTElhdq31WlY+9zDZ8I9AZ5p/DAJTCPSFkNEvDBd3WY?=
 =?us-ascii?Q?OAkeLqiTPgyMxAWa1bCPxNPca5B/thZHI24GAUR/CA8ls1ZFCYt/ZrYUuzxe?=
 =?us-ascii?Q?JQ9PzGEepYNjHCjVihUU4+SArk8+kzHPMrgn00NHsHISfmm5yvxvcjozaB0O?=
 =?us-ascii?Q?2KemMeM2i7jANMVcZUfW/4oy5nIh7SwuN4t/IHnIQ2hXAS4WLNfF09YW2nym?=
 =?us-ascii?Q?N7XcB7nbszdm7n4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obCdF3Ud6U+4c+zf+vYx9BDheidl8Brecdw9vdyiQ4WwQ2YNaqnY7NzZBG9C?=
 =?us-ascii?Q?A+fXtHeT/3dwZ62hiyDEtPW6S3JhaghHV4Ys8VeYZpQ6APVqCOMrEot4gLKY?=
 =?us-ascii?Q?nhT5iB1b2bYeUoVWDr+fVaRQBhe1s3WzRb6zielT+YHFvD/NSqqckOdzOrLf?=
 =?us-ascii?Q?4g/brWI347I4qIMfMyLv/oWKIefb7b8ae9UkyZKVbBFHk/3Xaj2TjEi0ctad?=
 =?us-ascii?Q?xvyDBK+4vl686ZuO7FE8L/n+q2t+GWX7J1Fai9JqItx6dIiWx4LNvhw0tWI6?=
 =?us-ascii?Q?Z3PvXYL4JO/ULd27lE9xVJ9v1sdU4VkBvahoESvnwe85GX6JsBiI6hNaipr1?=
 =?us-ascii?Q?TByZ+E7Wc34ceIx7KTk/A/7KxcS/xnHMkxA0v2qPkiOhLT0OFDYij5YbGH7m?=
 =?us-ascii?Q?2f8M0XqeOZ1Ny0Qz9BoenOb6iSf/6bvgnMSzrYbRagL1aZBk0Sff2ZQ+wz40?=
 =?us-ascii?Q?DZRVXJs1Ge4CdXw7vHzBUAdUrSnFRU90ws8weFU7tfEAWKoWUmjj7a7bgTGm?=
 =?us-ascii?Q?qsZ1ArMZGSqjPzOO1Wmp6fvtWcxq8Sh/cDKbZeLoCXjnDMqlibGJRCSKrpHZ?=
 =?us-ascii?Q?Sqpecom+eLh54lTGIQhQbXCoOX16HvQiu1qjMTK36S8f3RTK6h5j2hdzG2ck?=
 =?us-ascii?Q?7BesxPpD9C80BKR8hgPubHp+1y43z8mjWHeuxtxp625RcLzShDYSQKvHzfC4?=
 =?us-ascii?Q?FARiY113KeW3lueH0aZhL586pokVQxAr5dKGOPdo8eAB7lRmzQeLBhwhnWSm?=
 =?us-ascii?Q?F2+kVkvj9kP0YsXxL5V2U+y2nsiIsPpmdGieFtuN3VDhJxTSxQxs7x/joIFX?=
 =?us-ascii?Q?lKkgW9McYoltsNoxEqz453aOXtaxx/3Rl8BwI2dcbW6IC6HKwEZw5535qcCM?=
 =?us-ascii?Q?TdlI+urQpvdUr0Jg3FqvpqiPum+RkYpSMwZqEFnunbiEmpyCw7tBjJv+0LLk?=
 =?us-ascii?Q?e2MusEKtVsTccFYlO3VX3cYrUzeyAq5Y13qIc16GLQovlY5BPIslOzPcSxVW?=
 =?us-ascii?Q?MmHdT8VyVpIKeI83lGMsxi4PijWad3cwb516CBrFZyfmxdfkqYCW598qN97p?=
 =?us-ascii?Q?FFHyOV0ZKN4wQdcd0iy7MXlunqiO6RqZOyqocfDKJROLz5Fhm+D0TMlBxMJw?=
 =?us-ascii?Q?rau4xQlb+/W6v0ijZUE2rv7cHGvqK59pXYKyqpW8AiKVR7WZkUPzYCpXyarn?=
 =?us-ascii?Q?FzgdQ2gP2W86IDje+PN+49lifQi2r/U5BDZkW1XTtFaMrJZ0vs85hiciJqcH?=
 =?us-ascii?Q?aHfoJKM0VG0nhmWrKLJi22ZDCbBN3McX4fEbK1Yj6lVkwsWPPuz9H6dnVCM/?=
 =?us-ascii?Q?CQEsrqeilpV2QJC69kTJw/1ZAufOn9iLn+EB9zDdGobHHsLkTfMR7Fx2QoSX?=
 =?us-ascii?Q?2GuIbnanMplaqCfpQYQy7KX821wV7vMaeN1pcoqhoWF2821ICJ7V7axrKZpr?=
 =?us-ascii?Q?m28yPeGK0sHhjlYjB4E+RnridAn55r63vZ6RDA8v3k4QednthuzztRIEzNlC?=
 =?us-ascii?Q?CwvG62B0ZQNSVDv2uIyrcAac64kd7wrQLz55hHaCXkbL8RzhaEJto5tVGowP?=
 =?us-ascii?Q?/3N8JHUC9XTl83B+nB9Xjiy9g6pqFmyLEipoeGxL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8114e70-c323-4429-8ff4-08ddec4dd692
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:28:41.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgBXtiEJB/XjJxZNy0RR3hRSweV9/g84pxn3XStg7/j64yiLOubd2sF9sCzAdnURU03CSvPuXzm2Ha/Qw8SKWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5837

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 1 -
 drivers/thermal/renesas/rcar_thermal.c      | 3 ++-
 drivers/thermal/renesas/rzg2l_thermal.c     | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 24a702ee4c1f..4788fd311887 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -540,7 +540,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
-			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret = PTR_ERR(zone);
 			goto error_unregister;
 		}
diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index fdd7afdc4ff6..a623f21520ef 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -498,9 +498,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 				thermal_zone_device_unregister(priv->zone);
 				priv->zone = ERR_PTR(ret);
 			}
+			if (IS_ERR(priv->zone))
+				dev_err(dev, "can't register thermal zone\n");
 		}
 		if (IS_ERR(priv->zone)) {
-			dev_err(dev, "can't register thermal zone\n");
 			ret = PTR_ERR(priv->zone);
 			priv->zone = NULL;
 			goto error_unregister;
diff --git a/drivers/thermal/renesas/rzg2l_thermal.c b/drivers/thermal/renesas/rzg2l_thermal.c
index b588be628640..3b13ccd5e76a 100644
--- a/drivers/thermal/renesas/rzg2l_thermal.c
+++ b/drivers/thermal/renesas/rzg2l_thermal.c
@@ -208,7 +208,6 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	zone = devm_thermal_of_zone_register(dev, 0, priv,
 					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
-		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
 		goto err;
 	}
-- 
2.34.1



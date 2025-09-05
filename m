Return-Path: <linux-iio+bounces-23740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13408B44FBA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D15B612E7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94A2DF718;
	Fri,  5 Sep 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jJUQ7rV/"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013042.outbound.protection.outlook.com [40.107.44.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9A2DCF6E;
	Fri,  5 Sep 2025 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057099; cv=fail; b=p7uwaPrxCzVU8Uc1zp95Rn4eghInpgSopTjd+1vD38hzHd18ISg48EDQVGUuAc4jHvUSXKVJxgTV5uIVDLBMAQqnjxjvzGCaZ2rDPNcL3ipgH20YdiSF22ByM3PwKM0PSImS08tE9mxpGFJRjgcDz2UNxSoA9swLAb1YElW/+UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057099; c=relaxed/simple;
	bh=acvGn+RpRxj+AITe/razYVnfbZtaEGybwyK5b7Pd3IU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HMYGQytzNJ43Bj7t6rh24SER6e+Lu1JyTfefnSqAhlXaNyTpeFQBQOnVAmdSgEsB+T8N34JP4giuQZo8X99n8k5l6wLgGeOqKpNEb7f6/qL+iZeGkoDMVO8kHc+JkUZj1Y1gkJaULCq2TNjSc6DPe8LMoPoZOTEBm775ZUYiAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jJUQ7rV/; arc=fail smtp.client-ip=40.107.44.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUEzKZJy130J3LZpRDi268EHykQ8Q7GvKsnmww08mX1T0Hyxk/qzi924V/ESj0ZyMjaEnbd6B62KpBbYpWTuOx+aO+dMQNWSIN0orKWj+KeFCIo9ppAsKl9C3o4pMFNRYiPUFkEGL+C3Ynjf4AUM0VFTNS84yq0IMzxPJCc2yPDwRo7bBUtUL1aggd3jd1oXdx4OzUCjL3PVNLB9dCy0KK4FHbsyAGff6uy3QcqiKz2Z+SBaI3hwOEQoKL/MgSeRmnF58SB4Y082ZdZ2gPU/83AXPSJKIkrxpvRYtDfR0xjvTv3Z2QbkyE4HG57cAJP63GzDiIARCF0esaWaep4kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l00aG08W87I1prscd7L+aG/F3ovWpspEgEd6GQuSNBc=;
 b=cl3YF129SNJOoulVpsnCMa2Da+zqV+mBnbEaQHMiAUNDYlkMO4prn/xHbZRbp12h6RcmuvYVSrMuYaN3m0t7oXr1b82wDUlR4A1djgOh+VqOG7pHQVmqYSbA+vjCt/1leFpqyj/N099yX9jRbIgQc227VpTx2xIrGyVu+D4hZMzpYa0VwYS+pBWjOzfRm1fsIaW2v9X1abp4jBIW7OnXleEYZK3yWDk3RVlmckh/a4PMsig7700R/Jmv3KqD8psmbc+RIwQ6gB/jIh8GYV/ir358/ophubCwSwcdiDbDBVDf/PTh0wmu7l4FSYtisn17LIbT5j8NmdpqQkWI9BhVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l00aG08W87I1prscd7L+aG/F3ovWpspEgEd6GQuSNBc=;
 b=jJUQ7rV/2tjm05PLvH5sxyJ2oo/pKnA5P/+MdTuiqfACAaKkmUzx5RtRDcRPSgKrATS4mH003mQfomci51Na0TmokQ6oZHkv1/9M+xB15eKC2roaH1TgXFcLmECBlJnIfGH44n49YrqqqOmqut+jyYmtuxLejfaqEGOnsgEcVcDHL8oseiG9+fwd4GpMYPKNGaXUeOGPRGWaufD+r/jlwhWQ8n1G1sB2fj5umJAVxKS4HZnRbDND24tT6PNmbsFPFohteAECEs4F4jwnpzNlLNjOF4TMcH1O7+fbgCEfgpj4a+Xbp9ill+vfQTii3bDkDDp/Vu3s3V81qt1V6kDH+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:24:51 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:24:50 +0000
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
Subject: [PATCH 00/12] drivers: Integrate log message printing into devm_thermal_*_register()
Date: Fri,  5 Sep 2025 15:23:52 +0800
Message-Id: <20250905072423.368123-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 4ce90b0b-55b7-4cab-a0d2-08ddec4d4cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RdPhrFtPD62QYRERKyMpXhYXceCHpOCdnsSISXPeCItz7fQ83GhkKaXQYJ4K?=
 =?us-ascii?Q?h0e5qwTaJmwm78arHIgvmTHRVURhxCnVByEUnKNhbIQy4CpSVJrJL1RdYFrj?=
 =?us-ascii?Q?Evb4bIV1aosKL/kQLNNN68qxVQ0a8QYTrJcWQItDJd5Dk21WN0XzU4pJiY/D?=
 =?us-ascii?Q?YsqICFWFw5jotuRueYfalqRCNJfPaXckNG0v1s1dW2rqXhW7IdYmAJ2XznTZ?=
 =?us-ascii?Q?PBg4JDvQ1SlNYFwIC3PqI4HLID4O2PBXJrz5ye0RlyNVJrHFGWF98VzPREQy?=
 =?us-ascii?Q?FZ/FfDtFOPSab0tNGi+yZrX3pbW01P7G4m1+4mwiwmzXjg3ROR7Nst6gBwi9?=
 =?us-ascii?Q?WPXoNixBIYUP4ssXJQ+vhSimVIOmnCh+g+vDGTtARET4Sh76oTtZbgkviwKz?=
 =?us-ascii?Q?OckcvCriT2bZU1BCt4O+AbHmxGx7hoe/+4E7mqilLFPx/WyMGF7YNRt7BgvH?=
 =?us-ascii?Q?Z5g09WxmHcvGBkLotB9/+XUsJC4zAFINIJ0dThZ6kuMKGSiorAskmE5en3BH?=
 =?us-ascii?Q?y4PHHdyFVqgtcI7ElyDCJT5XSnKpuFY3JSp8LWt8wn3xOUjjgpJMrnVJIUF2?=
 =?us-ascii?Q?4VouEI6UrOPAosUJPOrx0oZtxpNjAHZ9i53kmr2TOI1fy4ln1OWwxjsGmGhO?=
 =?us-ascii?Q?tJJl77GA8871Wob074ZditN9RbZpNC0b9oiidyHzLqWSVMZ8R765g1YP+pBU?=
 =?us-ascii?Q?H3XOc138OsYNPJZBRDvzhKViSrUr2eUvrevzWAvU+U38RQOeSovYLy/FXTZl?=
 =?us-ascii?Q?VNtCpewA30+Un5G6h2dfUit09JTr+nu+AxnmTOSLJ6ER+KCS2L0rkTyk6ib8?=
 =?us-ascii?Q?O+Z6h1hZyzNk5wclDxaJBb2BRP8U3N+9OAhqapnE7qYwwSF6mY7Gs4Y3veFu?=
 =?us-ascii?Q?S2VNRYLMiM5zErn9MoU7Lq3iv3yP4CqBjvm3Ia9dBWvWf+jEuIzpOsNzgGHO?=
 =?us-ascii?Q?wAjfHulo+/idyRqRpIHWHDsfSmviaGjPjrA1ljQPQYA/iriwF03NJJL08geJ?=
 =?us-ascii?Q?fUc0A3yjBC0Wfz+cLVc4CXxPwAmxK26OLMnQsovC6+eWrYx5YCuvLalIeoCy?=
 =?us-ascii?Q?Sk4RZLuhI0ZSZvt1VgNsEAl+sJbPDrwKnBkCU8Ya08DwcaMm8B+GXHCEHPjZ?=
 =?us-ascii?Q?+6nM5tQ/58SRkHpbn5bcBn1McsHEJWiZGSMyrlDxi9shXLP6ms5CTfQNg//5?=
 =?us-ascii?Q?zFuzP9Iom+NA/ktPpkJ9/yFK2vTSM4+zHr4UMB0uIwChFGyyWr88cANmltPx?=
 =?us-ascii?Q?Aw4hgu0PI3XXIl2eXbHRbdWb6TCR2kwmdPByOA37gs1IG8WVoI1mbZlEsfOx?=
 =?us-ascii?Q?U5e6Xutepl0DfuCtWWXGbQh/HKBoGf2kpxC5+YoSlpHjmqrN0oF6Ql2kBeAS?=
 =?us-ascii?Q?0YkG7p443CmJY8fTlXtQf9CwM0jZch5wc8vP/5MnE4gZYlRluhJ7T84z0Ubz?=
 =?us-ascii?Q?kFJmuPMKcxKiE0qh+uQWnSV4Mz0YR+Wz+MXOPRHDeSEITse5lei2VIDxKHby?=
 =?us-ascii?Q?IwPn3cIVTOSV7ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PaGM1vR8GM6pr87N6crztM4CFNPQ9dJRTcvDhsGmKGtZ+jpH5ToLNh9VFvOw?=
 =?us-ascii?Q?V9ljzdUgy60O3/+ot7+hlVAvlt5Y3p5xqgzaQ0iffvEeKFUl3t4tGAfU0M0e?=
 =?us-ascii?Q?6SXlqX27C8asMGtBpQ+vPreRpoaWp4nlBxbXiuPjvjDEUu6xROZDwEjaRGpi?=
 =?us-ascii?Q?XSPpnw9obwoM87lv2dt0wL4/CuTPOro191ZhWs13cvNxM8eii2ELf66P0w15?=
 =?us-ascii?Q?Gqznd6rhWHue24aePSFto0GvIjjPjaZrzc5cPMl8kBDq1A8gzVW3mR0AeUou?=
 =?us-ascii?Q?tMRoGTnwOJ0oPCwBOjpMumFsThZQyle16u891W0Vqt4L9ievK5nU0anObDWm?=
 =?us-ascii?Q?M26Ddetda5vbCZoEPEuxdbNhMCyMJzXfSdmur93IoMpxrCoaCxFaZ0h9pnqs?=
 =?us-ascii?Q?20Be7WLVOzmrSux/HQJvAM0AUIDF+W9/mWwiaaCgS9/UcUVxoa7TOR/5L9je?=
 =?us-ascii?Q?PpWXYWp0Gic6ZGaD95iSeuH2hmq7RADe/LSYaJj/nDv5HVYEx/OBeA7OdETz?=
 =?us-ascii?Q?fqmyV5y2UluHwFGrMvQLvD6SPqGIrJVnfVTIog9/q59i33OSICHlHGjSaEqb?=
 =?us-ascii?Q?STaqWuodjhJskEeFtO4ZX6Q4O36zWyfQos/Jkwkq+EhUXL5pAnYpb4jpCNYs?=
 =?us-ascii?Q?e4haZsdTz7wyEkPxy7kqPfmwCwxDnZ/mwQZth7vt/AFWBveCp9sHoVfSAB2v?=
 =?us-ascii?Q?RtlbpeOXZ+rsEUA9zbEkBe9hinurUDumzWm6XAn9IlobBF8XometisYLe1o9?=
 =?us-ascii?Q?Vh+j2vCbFFUkv0l8e7Aj1aQ7HkNNVxxGqDKIYWpd99tfafn5AW7wX4jPp+wV?=
 =?us-ascii?Q?7ApWCfj03V9etPsOWpLGA53jVEtp/tin/yin8b2jAFcnrKaX51aYxvAUAtuW?=
 =?us-ascii?Q?45qIQrR9qAhRSdF5sKdAiFgjD31fOyYTX7ZtsrWLCHyWqJ0H9PSVIrbGxMNA?=
 =?us-ascii?Q?f4Czz/5WbsvuCONlczfdE/f8MpYQA7rAG46upGUNZyGLUXJJd7AjtZsnpqgq?=
 =?us-ascii?Q?xdfF4HxCTffd4LQouqxnw674tvpRYdoirSgCXBZJDriHgkFXrwyCKNOWJ6HX?=
 =?us-ascii?Q?CqVPe8iG8ZX5JNqfIdIkYDhoWKGYoWoPEnByjbgyL6UadGcVVlnq4U1xg5+g?=
 =?us-ascii?Q?FPmfItVqx9pD+0ecWBWfBrT50SldlwSXIQeazWi6rQzpaxCv6pVXvs7j1tYK?=
 =?us-ascii?Q?vfmyjvw0Tf/+9ee93lD/TCJjYmnadb/JDCUHbnfbkDTvph54s8mDWcaQqjLo?=
 =?us-ascii?Q?uGc4Vs5drmgqd+uu+/uZks6U3UEckmzBayK7q2ejxMdSmmeeoP6lk+wl1SYg?=
 =?us-ascii?Q?IbvnzKQelKY5M8gOS6XDXSSiWwby5PkoYmB0KJKMXAI2I8biikyIJQRI0RaD?=
 =?us-ascii?Q?coNRP28zmB2gIakTF5wzNck5N/hTXdfSsSF9+bYRTPdKQd4SZzlOmNikJhlL?=
 =?us-ascii?Q?WL3CYQy6l9XkhyUHEOmUsCb9PEPvRELBpVCOaAhe/gvqPMspZIjBSDKOIjLE?=
 =?us-ascii?Q?H4F88PQuy/wICLseyiYBT6lxgkRMOKQwWAcCJ39EnimjIpCJ5SjQ+6Ay9iqf?=
 =?us-ascii?Q?zzSBuefklIZOXiv0961N5AXJosZMsOk6gqTL1PyW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce90b0b-55b7-4cab-a0d2-08ddec4d4cd6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:24:50.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3R4e/IRJQH3VXFbk/lRBhlzGkYiV1hW2lSfNsQ0JlobI3EhfdYw0N5q4fAIRxoPes0UKblB6s7wi+N7zmbCmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

Add dev_err_probe() in devm_thermal_of_zone_register() to unify
error reporting. Remove redundant error log prints in various driver codes.

Xichao Zhao (12):
  thermal: of: Add error handling in devm_thermal_*_register()
  hwmon: Remove redundant error log prints
  iio: adc: Remove redundant error log prints
  regulator: max8973: Remove redundant error log prints
  thermal: Remove redundant error log prints
  thermal: broadcom: Remove redundant error log prints
  thermal: qcom: Remove redundant error log prints
  thermal: renesas: Remove redundant error log prints
  thermal: samsung: Remove redundant error log prints
  thermal: st: Remove redundant error log prints
  thermal: tegra: Remove redundant error log prints
  thermal: ti-soc-thermal: Remove redundant error log  prints

 drivers/hwmon/hwmon.c                              |  3 +--
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  6 +-----
 drivers/regulator/max8973-regulator.c              |  8 ++------
 drivers/thermal/airoha_thermal.c                   |  4 +---
 drivers/thermal/amlogic_thermal.c                  |  7 ++-----
 drivers/thermal/armada_thermal.c                   |  2 --
 drivers/thermal/broadcom/bcm2711_thermal.c         |  7 ++-----
 drivers/thermal/broadcom/bcm2835_thermal.c         |  2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |  3 +--
 drivers/thermal/db8500_thermal.c                   |  5 ++---
 drivers/thermal/hisi_thermal.c                     |  7 +------
 drivers/thermal/imx8mm_thermal.c                   |  3 ---
 drivers/thermal/imx_sc_thermal.c                   |  2 +-
 drivers/thermal/k3_bandgap.c                       |  1 -
 drivers/thermal/k3_j72xx_bandgap.c                 |  1 -
 drivers/thermal/loongson2_thermal.c                |  2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |  7 +------
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  3 +--
 drivers/thermal/renesas/rcar_gen3_thermal.c        |  1 -
 drivers/thermal/renesas/rcar_thermal.c             |  3 ++-
 drivers/thermal/renesas/rzg2l_thermal.c            |  1 -
 drivers/thermal/rockchip_thermal.c                 |  8 ++------
 drivers/thermal/samsung/exynos_tmu.c               |  2 +-
 drivers/thermal/sprd_thermal.c                     |  2 --
 drivers/thermal/st/st_thermal.c                    |  1 -
 drivers/thermal/st/stm_thermal.c                   |  8 ++------
 drivers/thermal/tegra/soctherm.c                   |  2 --
 drivers/thermal/tegra/tegra30-tsensor.c            |  3 +--
 drivers/thermal/thermal-generic-adc.c              | 10 ++--------
 drivers/thermal/thermal_mmio.c                     |  6 +-----
 drivers/thermal/thermal_of.c                       |  6 +++++-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  4 +---
 drivers/thermal/uniphier_thermal.c                 |  4 +---
 33 files changed, 36 insertions(+), 98 deletions(-)

-- 
2.34.1



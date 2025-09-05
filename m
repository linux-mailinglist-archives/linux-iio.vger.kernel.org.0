Return-Path: <linux-iio+bounces-23745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F89B44F99
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24D9584FD3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA202F3C28;
	Fri,  5 Sep 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ehTifwuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012067.outbound.protection.outlook.com [40.107.75.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074926C385;
	Fri,  5 Sep 2025 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057242; cv=fail; b=jwDKHJgGYbAVQzXV4jz9I0JB1cIG1QfTS4Uddr+umdGi1D96lQ32B/Spn9oQ/+PmmslAPOuMmWMvkvwA/MkXL4pnN4P+g9m+4iFE1TxJzFJYSZ9YnEFsFD3FhwQd1yDLoWRU63PjZ7yjx+mP3DhhzdXX6Qc2KzuWHHYwnaW7f8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057242; c=relaxed/simple;
	bh=YG9nwbrsKdmezOTA8Vz8EJgANHMLD2O0URT6cOQdu8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVyvylAjFy9WGJ6s9CFUovFDUfSmmI7nsnz1SiEcX/po1JwY6BkGsMkIRXKHlBim/OgxnU7iKDijv/QKV++TcuMlKpQwAh27Px7RgHdW9JoVezWQ/dr5NOATmEJ13SWsTnamdzOpLw+ih+M5Os2D6B+7A2GtYj1x9k+FDOyn9zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ehTifwuW; arc=fail smtp.client-ip=40.107.75.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZP1NxXhSPHov0eFrdfyS+cQ6XZyZe/7Sn4wC9munXT01JiP/vFQaeT4bpP4jECJRGZXFtCLrfHGXcyVsxBmlEB1TnkLLPrlPuTS/rRy2m3oDus4SYPEK0JALANak0TCAJZZ129sG+uadqFhR3/KKLioMUOVaX75GZx9g3p0kesVbUcJC3f1D/lOnodrv8I/swy7gC8tsX/QCNNfhCvZ+L76uuxFhzhXswNkazQck54CiAtdCbNanCkEvkm4XzvHqjN7CaDJVZZ8X89j254iGHwaOM+c97r8t8ydpkTobwoM4bF+JAmGh9fHWPHZLg18nmWejA5mju93OobuphPQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb7F4uzJgz/NeiKUYjDd+fDPpxHiSX+KCXakcjBktkI=;
 b=xy3uPnz+99DfoFdfl0vlrnq7L2DX78uM2OG7OBx05QyeJ8LpEXRguoFfnnqdH6zUNGhfx+4o/JuBlxhPT3laZ6LrPqvMiW2cBdKtJ8pVOvhiIBSLMS0PrzwFqQ/t/djjoucoyiCK7CnVBREhUQUe/8uMnotqeBSg7MZoDIG8ujjT/HnegfT1D+t2V/6W0taB6eEICuwNA0+2uC9SmPEBrzGN/weXfWizRC7HhV4mAlPrD6sJU77WgLxQ5FFB8ckiyWD7dXaJ69yvGHCasnfHysoDo2v01hciIpwq7KTYp49sQUAqZO3Op1Vvp9PGKSn5gB6xpr2QBWn2VMVOPs+cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb7F4uzJgz/NeiKUYjDd+fDPpxHiSX+KCXakcjBktkI=;
 b=ehTifwuWhlt7Z6X3ZudyVvHYc1mZSejp6Sh7T0JTiFAbjLPPwEO0++AUTTLBAeDZ3V1O8+7dpvL27j2oHkMmqmBpd1zjFvwntVUSas6J+A2oM/RAa6MKHzUmQzW3W8T7rwyDY5b+IZyqixXQcBx0k1ym3iZj0zsi1YuV7kDl9YzJDC0RT76vbuUEb4Qx482UzaVl7Fe4tvd9+R94mdDs/fPq+ajFyp4ccH3H9lm+JQbbF9PbAKIvHYAC4pgTXgTh2UwLVinBdqV51V8I/2ypE8Epe+Eq0bBB2Q4Dr0AeU/I3LdDtxkSiEQEH0gYSkYNIPuLWXsemQlD+YXx9W1MQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by SEZPR06MB7185.apcprd06.prod.outlook.com (2603:1096:101:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 07:27:16 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 07:27:16 +0000
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
Subject: [PATCH 05/12] thermal: Remove redundant error log prints
Date: Fri,  5 Sep 2025 15:23:57 +0800
Message-Id: <20250905072423.368123-6-zhao.xichao@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b305593-9eb8-46aa-f0b9-08ddec4da3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWen3RBZrTpfyhmMIbL5fc0t6SNsFfB00XHWjVMNOMjxx6Jrm8LgbMPNawty?=
 =?us-ascii?Q?N3yHh5+NHt7wUNkaNQfcLpOkf2xNTxsW8O2KK1fxmk+04O6V5WkaO/l6u9RK?=
 =?us-ascii?Q?bQf44Kl8nd3tk41302jUnzmeZSLuRvTtB0j9wG3NOh2ScYZbzikSjMgfmZaF?=
 =?us-ascii?Q?14bOsiXiwRMeZdueSj03QY68MHC7BKzWalpaALKTLzcBNr7xRKesf1x7I7BG?=
 =?us-ascii?Q?08ZKE4GgPmGJSe6ZRka5xfIrSYwKP+gldFbZ8de5i7JTv8fYeccjbPfEu40v?=
 =?us-ascii?Q?tz3DtVJrSsS3TN4+4oWNDaBKExIignpmlJ32c/TgZn4mOZaQ7odtqKaFVAmp?=
 =?us-ascii?Q?PFFtbfjK3v4B+l29WvgfPOgOtsdlyTyXmm10XcnNuM2WaSyBOAm2DaVCSvm5?=
 =?us-ascii?Q?jJp6ar4d/zlEexqOVAAVQL9XE1LaYA+iLlrTYbrE4cTnRKihLdYqEUU43Ho1?=
 =?us-ascii?Q?DKu7Fv9bn6cYzhSHDoDgCazvI5TcSADE1Cvrnz4Qo6NVfUvoqzFJ5+OrVmVK?=
 =?us-ascii?Q?LqLL3wpPD1r40WLDUVLJ9iyhNFtmaaFHAdXDGTdqNyUs7XX8hkr9j1L9EeOA?=
 =?us-ascii?Q?gMQ8HblufY/NNTfoJg644bXqTHSLlixpA3OOlLw9VY5wjuzLJXsJl3Xs1b1D?=
 =?us-ascii?Q?J3u94lO9r3Z2iSc67pBTdPSpWn2y9ZLDg4qnYBb4wcC2cBsqNEjeTfivDZE6?=
 =?us-ascii?Q?ZkftVMRtSOmIwYyYZ5CoKOZPg6Gr/8Nfnva6nd4SQGZZqNghoqT91FpvdRUi?=
 =?us-ascii?Q?C4D38m+ktscbNYLQXDKrL6lJlqqA/CR5p5TcGtoXk0F/0lNP+dASZqQovQTB?=
 =?us-ascii?Q?cff9SUSoswYPwH/KtHDxSNw4L9eT4Df5gvJl1z18QgwxvblGOvuP1/OopuWS?=
 =?us-ascii?Q?+MXtwXflMN61RqQ6ikQ2MAolXdVmE43pBwHwjAHChaCy7azg5Q13wBnZewBk?=
 =?us-ascii?Q?GqzVB57r9GsEIehW5SGpjlHBun3n+B6I+9fzru6I60MtF3xA5wg5rTBh4LIz?=
 =?us-ascii?Q?47xJEWGxbOICVbgT5K9lsKbDTVqMCBx5nqaS/KWb6iS8cukkqSsQb0Rc7OYb?=
 =?us-ascii?Q?QuHYKx7jRd4dKCa83l9AJ6DzJMG64o4tR2JGYCx6xvVbDfE/k3NUfGiz5Lfc?=
 =?us-ascii?Q?b3s0RlIc2Ce7f8HIU3EDUGhcusBZjlBe2jfti9yOiFG+LgC3ewdo38H5FAfx?=
 =?us-ascii?Q?DLJ+Kp3ChEtSsNI8Jm0H6FvZSCoQVAy77poAHQPiNkfwg9l3lwhfnGCltlCO?=
 =?us-ascii?Q?6qpjSRTkb81neCWnX4cim2ipAsGH/em0ExP98jvQOGf3BdwpM0+D4CWVMvJd?=
 =?us-ascii?Q?mDKNOyWctVKnDQ5QQcvG3xVuiLYvHEa5AGZCg/mnTxgyExgfoPB6DIRpRV72?=
 =?us-ascii?Q?YTGF/Gm3LbOrlV2mFPSMM1joAOqQEOPsBa2RhW+fNIG4IFjoZZlIBY+JXW8+?=
 =?us-ascii?Q?6g0/k1yrcZC2d+OCX55fdxpWi/ocD6Fa/1MlC3XAb+8+xIJRyn7400m7llyY?=
 =?us-ascii?Q?L1HyMhHnW1im6yo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQxnM4oAIPaYqNdwEkqk4UlFkF+BsU1cJOMiTt0DSObvv5pPlFm14WnKrCEF?=
 =?us-ascii?Q?U9sx+E99B3I36r52LgUcAEHqLqdwDzdHPlLGds1Bg00Md3qcf68rO5RXBCzF?=
 =?us-ascii?Q?4Dql76QVlrLKLjo70gojlCD6sXtOT5j0O0qx9rodyaKzJEF4R88OGnv9O13X?=
 =?us-ascii?Q?LhROuYnPCVjYP80ZudW0GySpwEBbbFluowd1gTDwk+vY4zE4A6UwCk4hutP+?=
 =?us-ascii?Q?sS5RtTo67afVaHQ9GQyyDAwZl95KtGQ7SUiiOf0vJXt3JfrSj1UXpErmE/bS?=
 =?us-ascii?Q?vFdMpOtG0oObjq1AuK2T+dEbQefcpH1soz+1fn8fA/y6jRcuDHAIG5l1Dqsn?=
 =?us-ascii?Q?ku0HjNJIRNaS72zzfxbce7XuoCedpgNrY34v6Ancr47YNcWWh97ICGEmGrrx?=
 =?us-ascii?Q?9E2cnMlpA7ZiYfCuA8ZyZtQ77oXx2oYWkog7R3DnQUkop8UwITbXj2wGqP6L?=
 =?us-ascii?Q?90uD8woAaZTA93+09WzuBnKnJwVHSNci4nRqtdGlIyNeLnZcGrENnVNOqzW1?=
 =?us-ascii?Q?dO58L+qj8EI7hIrWmWecSWx6Pkyb0VZ9csczY9eX56wW5260W6rq5md1dQZv?=
 =?us-ascii?Q?KRxt1E1lvC0PlzPG9nnTTb+Si6Is+Knl+TcksuxLbq2lvRH19Y7pyv9CGCte?=
 =?us-ascii?Q?UD86jC77AmBI9QGmm0q+wNtkKr2hmp+GnaHI6t8dNb3j8QDaAUMteEu8PWDO?=
 =?us-ascii?Q?UcKDdhabIEVWyOFuevUlzb4ZuXr0zd02VVLWByqt9d+dXZmNVvDqikQ1jwuV?=
 =?us-ascii?Q?e/Nyvg1Q1AR0+kA68FryQtHeW9ND2rDfDD2zj5SitBWwfTNhvc2JoUZkzLmt?=
 =?us-ascii?Q?p6g0+qwOdxvuBkzj5TzX49edza2obBOUMAYFAV1luq6aVbPSln569HhRiBH9?=
 =?us-ascii?Q?5/5HAG2fjycklFlIaV36Jf7A1vycn1j29a7Q0iozGEFzamRR2bBBFhHD9rM1?=
 =?us-ascii?Q?ev24+8WlBgznnsbafEM95VV3htyuxv7pm05yhutRJkkt2+i7G4z2VnXmeju9?=
 =?us-ascii?Q?i05E5MyNI2v9jBsx8zSY0voLb19ffTLPM0ta2yW8vlorsr/Pc6msETwIuTy1?=
 =?us-ascii?Q?DTM3H2+ziR5+OqPtlEEpLRH7zE/WpE0vILsbDb5dTqH+llWc/YH7Hlg7loWE?=
 =?us-ascii?Q?4eZ0V21leS2WDuy59ykIx7oKaHZHY429tHvxIE7A9xkDxZ2JvOdG59bGZOfO?=
 =?us-ascii?Q?Y/ANFUUJuuiwxUntiCPZNihQvB63TRzlK80XURux75Tsnz5+dZmKKlQJr7zO?=
 =?us-ascii?Q?yR7+fjG58BDubvhQ1+MdWlnPy12+2qAIfuOkgfmvnh+Vbb+fnLTonzhcKqSz?=
 =?us-ascii?Q?bhIrTSSEFkZEmxN0Wf3svsOUanr+ogaZyhHOxDU5BPHGtSl0c2bcESza7boK?=
 =?us-ascii?Q?ffv1XL3gS5u7k8cQIcBDqILZvXgW4CD27CGebpkiDDzQLX5WdDqQoFvPnjJK?=
 =?us-ascii?Q?dJ/z27ft04hK0UBVlcuAC7SEcivwIIFZesb1nv/aDpllO4n9MDlBEUkoE+KB?=
 =?us-ascii?Q?27qcS4T63QPyQTT3HIqJ+RBUbS4S4YBfESYhZjBUlcZ6IC9DdSSFHp8g6w1Z?=
 =?us-ascii?Q?uZxRYFKI/ZZQqfS0+iUCrqx5EvaQwuX6OPW8sCKP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b305593-9eb8-46aa-f0b9-08ddec4da3e0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 07:27:16.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b/iTlwYQ6ggeeFuWRxDFb6srBGx1ddYAFfAUliXY/yEvpOK2QcVIlxJxh8C9prpR13jGyhHWjR/0A2cA+DHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7185

devm_thermal_of_zone_register() prints error log messages when
it fails, so there is no need to print error log messages again.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/thermal/airoha_thermal.c      |  4 +---
 drivers/thermal/amlogic_thermal.c     |  7 ++-----
 drivers/thermal/armada_thermal.c      |  2 --
 drivers/thermal/db8500_thermal.c      |  5 ++---
 drivers/thermal/hisi_thermal.c        |  7 +------
 drivers/thermal/imx8mm_thermal.c      |  3 ---
 drivers/thermal/imx_sc_thermal.c      |  2 +-
 drivers/thermal/k3_bandgap.c          |  1 -
 drivers/thermal/k3_j72xx_bandgap.c    |  1 -
 drivers/thermal/loongson2_thermal.c   |  2 +-
 drivers/thermal/rockchip_thermal.c    |  8 ++------
 drivers/thermal/sprd_thermal.c        |  2 --
 drivers/thermal/thermal-generic-adc.c | 10 ++--------
 drivers/thermal/thermal_mmio.c        |  6 +-----
 drivers/thermal/uniphier_thermal.c    |  4 +---
 15 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..1994b62df04b 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -454,10 +454,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 
 	/* register of thermal sensor and get info from DT */
 	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
-	if (IS_ERR(priv->tz)) {
-		dev_err(dev, "register thermal zone sensor failed\n");
+	if (IS_ERR(priv->tz))
 		return PTR_ERR(priv->tz);
-	}
 
 	platform_set_drvdata(pdev, priv);
 
diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 5448d772db12..03f806248df1 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -282,11 +282,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 						   0,
 						   pdata,
 						   &amlogic_thermal_ops);
-	if (IS_ERR(pdata->tzd)) {
-		ret = PTR_ERR(pdata->tzd);
-		dev_err(dev, "Failed to register tsensor: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(pdata->tzd))
+		return PTR_ERR(pdata->tzd);
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..22145b6cb2d9 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -938,8 +938,6 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						   sensor->id, sensor,
 						   &of_ops);
 		if (IS_ERR(tz)) {
-			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
-				 sensor_id);
 			devm_kfree(&pdev->dev, sensor);
 			continue;
 		}
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 576f88b6a1b3..891a4ed639f0 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -186,10 +186,9 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-	if (IS_ERR(th->tz)) {
-		dev_err(dev, "register thermal zone sensor failed\n");
+	if (IS_ERR(th->tz))
 		return PTR_ERR(th->tz);
-	}
+
 	dev_info(dev, "thermal zone sensor registered\n");
 
 	/* Start measuring at the lowest point */
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 4307161533a7..30181ac8cf47 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -480,17 +480,12 @@ static int hisi_trip_walk_cb(struct thermal_trip *trip, void *arg)
 static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
-	int ret;
-
 	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
 						    sensor->id, sensor,
 						    &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
-		ret = PTR_ERR(sensor->tzd);
 		sensor->tzd = NULL;
-		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
-			sensor->id, ret);
-		return ret;
+		return PTR_ERR(sensor->tzd);
 	}
 
 	thermal_zone_for_each_trip(sensor->tzd, hisi_trip_walk_cb, sensor);
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 719d71f5b235..0776b7b0675f 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -333,9 +333,6 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 						      &tmu_tz_ops);
 		if (IS_ERR(tmu->sensors[i].tzd)) {
 			ret = PTR_ERR(tmu->sensors[i].tzd);
-			dev_err(&pdev->dev,
-				"failed to register thermal zone sensor[%d]: %d\n",
-				i, ret);
 			goto disable_clk;
 		}
 		tmu->sensors[i].hw_id = i;
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 88558ce58880..6a36e5f54a51 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -111,7 +111,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			if (ret == -ENODEV)
 				continue;
 
-			return dev_err_probe(&pdev->dev, ret, "failed to register thermal zone\n");
+			return ret;
 		}
 
 		devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd);
diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 678d6ed711b5..4cd61e916ff7 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -216,7 +216,6 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 					      &data[id],
 					      &k3_of_thermal_ops);
 		if (IS_ERR(data[id].tzd)) {
-			dev_err(dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(data[id].tzd);
 			goto err_alloc;
 		}
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index a36289e61315..fabb42fa6df7 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -509,7 +509,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
 							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
-			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
 			goto err_free_ref_table;
 		}
diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index ea4dd2fb1f47..ce978db950e7 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -168,7 +168,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		if (PTR_ERR(tzd) != -ENODEV)
 			continue;
 
-		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
+		return PTR_ERR(tzd);
 	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 3beff9b6fac3..adf46b74ecc7 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1681,12 +1681,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	sensor->id = id;
 	sensor->tzd = devm_thermal_of_zone_register(dev, id, sensor,
 						    &rockchip_of_thermal_ops);
-	if (IS_ERR(sensor->tzd)) {
-		error = PTR_ERR(sensor->tzd);
-		dev_err(dev, "failed to register sensor %d: %d\n",
-			id, error);
-		return error;
-	}
+	if (IS_ERR(sensor->tzd))
+		return PTR_ERR(sensor->tzd);
 
 	return 0;
 }
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e546067c9621..d92964a931a4 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -409,8 +409,6 @@ static int sprd_thm_probe(struct platform_device *pdev)
 							 sen,
 							 &sprd_thm_ops);
 		if (IS_ERR(sen->tzd)) {
-			dev_err(&pdev->dev, "register thermal zone failed %d\n",
-				sen->id);
 			ret = PTR_ERR(sen->tzd);
 			goto of_put;
 		}
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index ee3d0aa31406..b370c7ed808b 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -142,14 +142,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	gti->tz_dev = devm_thermal_of_zone_register(dev, 0, gti,
 						    &gadc_thermal_ops);
-	if (IS_ERR(gti->tz_dev)) {
-		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(gti->tz_dev))
+		return PTR_ERR(gti->tz_dev);
 
 	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
 
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 6845756ad5e7..bd302dae5047 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -69,12 +69,8 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 						     0,
 						     sensor,
 						     &thermal_mmio_ops);
-	if (IS_ERR(thermal_zone)) {
-		dev_err(&pdev->dev,
-			"failed to register sensor (%ld)\n",
-			PTR_ERR(thermal_zone));
+	if (IS_ERR(thermal_zone))
 		return PTR_ERR(thermal_zone);
-	}
 
 	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 1a04294effea..a5e6353f2da7 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -308,10 +308,8 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 
 	tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
 						     &uniphier_of_thermal_ops);
-	if (IS_ERR(tdev->tz_dev)) {
-		dev_err(dev, "failed to register sensor device\n");
+	if (IS_ERR(tdev->tz_dev))
 		return PTR_ERR(tdev->tz_dev);
-	}
 
 	/* set alert temperatures */
 	twd.tdev = tdev;
-- 
2.34.1



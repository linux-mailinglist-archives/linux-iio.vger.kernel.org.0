Return-Path: <linux-iio+bounces-23085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811FB2F09D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CA51C878B9
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF542EA732;
	Thu, 21 Aug 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="izvN87gP"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80A2EA15B;
	Thu, 21 Aug 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763680; cv=fail; b=c1md8ddEaBBC+55xyt4mQnEgYRJYO3AS5zVBHALH/cUfXteqo4i24mXMmDTHMpqrKwrwkJNVgfQTpe2p5pYHGntdKYWHe6ReLlhK9KeejyXvuMECfFRZ2v/Hvs17eOU59rlgFgFuSg01VE30haXyNLWqsVgV40yFAeINlMJh1Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763680; c=relaxed/simple;
	bh=DRtc1nkt9vFSjnp0Y3mHBIcnLi/nKoLGBraLubpn/6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7atpWoMCVLSVy5gsQDxmK1fm9JKBGkJVNBzCHqc1L8w6fQtpS6+JXmJefdDV8d3fwc1pztwtlnovVx/krn28HvDpFSKsJEG3GrMBTH8uKLnbzox8bY4BRkLbDaBsLMB9OHSD+5xNmv31JsVpNBKoYjKFpEPZfAmYFTqkLD15Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=izvN87gP; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcT1I9tNmwhJHMtgxjrfnY2Untz0g+jURdyEM5LbVx0j5LS6UVcy/XRYZMRYuQKmvsn56bCjfz2LRZ0j47uwIgCcyEJkV2p4uzw5jc3EBEoPLB9YX0hs2x2uUgDGtsJcV2iU9vsUYWbdzqXkVJ7JCvD4XA9/o15EliCMAlH847WrcE8EXlb+Bz3KTMewD/yMvPI7+aYaFjj84lvx/y9UeHUe5oCCkXJu2IsVykGiZyvUftlI2oMM6ZRDqHWDGGqTFopduRyJbTflvtQlLB39V9IySwxiPKc40WXCds2anx/TvfsjHD/3Q6vbzb+HVI10hOwn48+jDgdVjJhvXXiF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1URSl7BbR5sDlgBHGuZrVgTE1Og3HLUvLy7qBWijcs=;
 b=y3GIM1k0bLDPMdoXOHWVGTyZFvW2K+CgnHn2tJQLVxzWCQkLgW08DX2z7SquqZyCXNDcLhKkzDvVKvtqgG6EiUfw1aTSCY5crnxwFISezFGeePSG1qsd/rRucVSIDrecWGdC8Bm2UvN1Jc+IFkM2RURmfiJmoRqQYDqwvru7oHfF4+KlVbhWE9pebk0EE+mud8HT+4relxfbYhSjcXRMstMuyHmPDPbgh42wylcHI1WbzQkShbX0SFL7WCWf0T7U/MC1fQSDQr0M2Iq+CN9Dl99+pVm+wIOtrym7AAOSAx+8HrqDw/BB5aUt9qU0HxUPnnIbSCTV5jigA9FHSahwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1URSl7BbR5sDlgBHGuZrVgTE1Og3HLUvLy7qBWijcs=;
 b=izvN87gPhoAUT3zqRzsvBLED4ShYslYj7L0FtthJyCzald+wD4RW682w7FH8CYN4cIIjHMQC3aZu9OPqB4+41avpQy7pTgHkI1RNzuKOpwO9LKTV8NNEOU4X7VzyYXywX2WEaO15ibXzE476/bc4GvXJA85NmTADYZiC9TCCYghXhO+OVYLpbfK9v1TJtcvsj+CHOKmP4EiZFCrmAj7NQE4hWJvPp89krgjZIyxzlWZJqnK9rY6SCwCxyjTmYyU3VyIrZR5YmdI7swkURwuyXQyi/M4ymjrAxidezxPuYf3y9FPm831vRS1hKb7GaBwQofItQPNb7SY5BK/hhbCnIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6488.apcprd06.prod.outlook.com (2603:1096:101:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:07:52 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 08:07:52 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-iio@vger.kernel.org (open list:AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 2/7] iio: adc: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 16:06:46 +0800
Message-Id: <20250821080723.525379-3-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821080723.525379-1-zhao.xichao@vivo.com>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0610ed59-e351-43d1-8b99-08dde089d370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zaHr1ht263fmgRiZemdPjJgMwCQIGuYDbuzXTUsajjP8Vo/QZd91fJoIeNS?=
 =?us-ascii?Q?qR/Lh9YT3JvnHIBjw2nNrvTof4zSWHQsc9SJP4ueKcJz8r3K8uJsMinZ2Cpb?=
 =?us-ascii?Q?XWLeI3s9UY0xceK2U0uREDZuw4HEqiZDSxrtUvXDty3I0uBgxZo09/kVk0WK?=
 =?us-ascii?Q?fPTJNKnKuNw47gJxt+twnN3SDimheOQ46t1MLkwdppxJeI+CJWoQohZMP5CN?=
 =?us-ascii?Q?q2bssu1jn6DhWJZRsXS9RFlLh9tcSywhqrzgn5uEtVGDXa6qCs6i4ZIMvaBD?=
 =?us-ascii?Q?z/5QnC2TPkwaVK+cJGPjFm21ax2D+QvKP83a0UWTPYM4loOrxHGOVu8R6Biu?=
 =?us-ascii?Q?kz5Jgj2JNm4ztgluN2ILyz6aE878FNKOCrffe/z+cmdtTfKIo50QbPtoDRff?=
 =?us-ascii?Q?5vIjbjI5+e0XBjbxp+cvMwSvHstBevGGr4GK4Fv/8k4O7tBrDobtS0IA7KVk?=
 =?us-ascii?Q?nbJifWWO+EH4fYPfgZI4749EcugF7JiOsUwy6ArJi7TH17a/W0/vvnUBjjbY?=
 =?us-ascii?Q?FkCoHeLZpayHOhllpnG0idLcTzqB97I0cZJUFN1m0PwshMAT56bd9kJQocpP?=
 =?us-ascii?Q?AylHz9S+mumFMMUxYVqyL/+jfZEGU2qlS0SO99Eh6uUnyHQrsK1xaQL06HUp?=
 =?us-ascii?Q?/YlXTwRy41aXre5mrGwBPeoySCdsVwzVnJ2G5qqBfJFaHLiq5fNpEUsWjqOs?=
 =?us-ascii?Q?2r3e2hABfQ03IzaR8YKnG7SuZGRVVJrqrYvzmlEEGHD1+l241nq6YsWJan1d?=
 =?us-ascii?Q?AB2o9/LwdjYz0kzZTDMSO9PqGByZl6aVINa//hAIv4AjU3NxYxpqqKk2ToGP?=
 =?us-ascii?Q?r5+26xYw07oNZBXV8O6QRyNDDQ32OtizH0azSb3Yh+T04Kcy3rBpOCFMyOUG?=
 =?us-ascii?Q?O6tloSZ7NuuKucBEbHRuHI5aQiw1sfQppc+nVv54fplN6GyB6QnXr2QGUgRL?=
 =?us-ascii?Q?7EIlm9Ujnao9pvzP/JfPAxvsySZXd8HuZBB6Gfs7T0XNymAb3/iYviLBP4a1?=
 =?us-ascii?Q?9lOOV5CCxuufxrTaj/jhxxcWSzErIa+J46F8HTsU7v1XrDf9UzhKvd+J8k9x?=
 =?us-ascii?Q?ZWJ/x7SS5buzhBHjPKNpl6jren8J9c2irvBpdHSRCcHR5pjYCqhrgvQeRn3j?=
 =?us-ascii?Q?6KdJC8UbFR+fgn1fHVF+CcQlFABJsTrEAZwhEOq6jZDOLtDMC14+wvSf9TSz?=
 =?us-ascii?Q?iWSJ3tNHUyzwua3BuJCRxjCBhi+IyvEvg8ZNILz7cu3d/w6AQ7L7IBO58N1z?=
 =?us-ascii?Q?ZAxBvEY3K3UGl75mkI+43MvywAqaYwWKDVLObEjTLhqKvkQPQo2/18Ujc0ws?=
 =?us-ascii?Q?SlpKxymox0I2tGP4id87QgPNsswEg5nAAb7LFWILBcvPSDK9wfeqRmUR2TLK?=
 =?us-ascii?Q?lS2h4QIhiyTFhm4LPAMsvTN7q+9dtarcXIWasg9hA7zPFX7oCFgwCCW5rD/B?=
 =?us-ascii?Q?4NH3rE120VLfS7tOX61U6hhzV+OfzH711aU2DbENUX8Cn3Z/GRoRpZ8Oh4Oq?=
 =?us-ascii?Q?ctBNjhauzjuPaNg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DguZXgve5/xpByJ3onTtjkPj2ny+1+wcJ/UelfSoieErvEdp74iaScIMadMS?=
 =?us-ascii?Q?W7m4OdOpRPyVtMM9QDJskdb6aO5ATkqOjnvxEMt7Ozcvd/V+fOcaGp25uuIv?=
 =?us-ascii?Q?D/D0ExxntnshCzXE8hxr+u7c2pYwd3kZdkuSc8KsaaGZDApGPyEo5V6yvpGI?=
 =?us-ascii?Q?wlkSUiorW7pCYU24Y97m2I2GfjTHAnosR9D2YXPrIFvdOXeuv1mlAjEwxS2E?=
 =?us-ascii?Q?Zry/4AkOl/7bQRCA+rn5yiEEhiaoQPpmXIL+8rE/jJDgMnRgT8Km/8Id8977?=
 =?us-ascii?Q?hEfqkIapyNrlBS2oXjRiCgWakKyt5QNjhgiNztfgfufnU/QbCIQ2qIXT1HcR?=
 =?us-ascii?Q?VI5FskEPia36LiWOORlqno9EmaFBekrcp76flGeZdh9G1K+snV/Z+fYdNUsc?=
 =?us-ascii?Q?OsHpjDk1cMxooB4ezaiYvwjUYYS08Ng0esS5aXb0T9NNrk3phs4/ziuowUYr?=
 =?us-ascii?Q?0veLUoyOqefJd9FMaMZPRLUsvfM5EfI/oQx/6ruAV5fEpqHxiUlvvef72PLS?=
 =?us-ascii?Q?grJmdoEeY0EEow1TuOUlwowwzgSRIXrQ2S30pxaOEjtehTPtWMId7ndLR7gc?=
 =?us-ascii?Q?Xn2yrafSghIjGEBy6tabGK6TRGJb1y5y5r55NMbe74agyyg61eH/uRYQX7WX?=
 =?us-ascii?Q?urAN6vyCca7hdksokPhrBz5aIkEE0h3TIszHTNAupOmV1WFWit1eVTyFSMET?=
 =?us-ascii?Q?Qeg1VO7AODZuzj3d5OWBK3aZbXjpj3rHq/VjcWYVviKA+J5et9O0sCefhv86?=
 =?us-ascii?Q?y0sllZbNMoxLMo42r3Uv/TRdPcR/1iYdabUUX9mAMNwDgj/E/G331wmBxU0k?=
 =?us-ascii?Q?w2XLpnda9djeeVq2kp/DrCirwSK1do+68TAkPLUuLmNOlBT7crTi2Da/gpFV?=
 =?us-ascii?Q?ksjf1tH5yO2lavzw/TSmmi5FQHdL6k6R4wTvqbNzfxxNZ9f77toUlL9n9zdS?=
 =?us-ascii?Q?/N8Tgzdntt5sW8E9dp1prdJUJ1fx+QjHeUaywjW4mZNO6JAOSHavq4DMLJbR?=
 =?us-ascii?Q?tPjlIiGFK3BT0opvw/tz41WYHNSlPfcoDzXkTHnlmXtNMtHcSmWBlTx2Rb4e?=
 =?us-ascii?Q?ZmRsEgpwRW7A57qR/NlvVduSLyQuH5kjnO1rISkv/UVncEcyyGz3z/k9cOHr?=
 =?us-ascii?Q?crLU6RCDp7lBxqksmHAXFDRYMFrFBHk9+kCRTgDhimjCyCOSgpn2W7e6eGjH?=
 =?us-ascii?Q?H+onXDLwBwP6/suof6F7Y3sbkEumZajPcunadK1ZeSp29IINFif+5Gnhl0Rk?=
 =?us-ascii?Q?m7RVlAoduXngYKhVurifLO+96j9NVfvht2kZnWD4KoEarxKVwdtBGGMaeZMh?=
 =?us-ascii?Q?QQoU6DOxXzHMhUnNeAO5ryeWiZR3D4qI2R1FHbhslQRhwCq2iEI3aCwv2qWJ?=
 =?us-ascii?Q?IGZLO9y2DoQWug3rWjxLlMPw+C5HUo2iRpHegOvItGQGkgsSdgnhqqH51dMv?=
 =?us-ascii?Q?GZ00adL/k0RKd+jIEUeG62YGJ/U2BN6CqfcY/bPdDQMcXOMbwY/1Zs+nPd/J?=
 =?us-ascii?Q?oZUlnr+aFR5YVeoesGYVHRuI7ZjnaJ9mFmX3s77wCYk4aBjjwud0Tv3yj5FX?=
 =?us-ascii?Q?3/uE5lpOjIav1cGe3dREMpe+eZkqDxo6l8MAjqYB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0610ed59-e351-43d1-8b99-08dde089d370
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:07:52.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gsshdZLtFKwuh9I+PrDjZD3JTE+RDTWJOFayQXaE2+BE2mmNnnJrqbWHUL1AeIrBBWZjkltIN1n/hjPkWfJcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6488

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iio/adc/hx711.c           | 2 +-
 drivers/iio/adc/imx93_adc.c       | 3 +--
 drivers/iio/adc/mcp3564.c         | 2 +-
 drivers/iio/adc/meson_saradc.c    | 2 +-
 drivers/iio/adc/rockchip_saradc.c | 3 +--
 drivers/iio/adc/spear_adc.c       | 3 +--
 drivers/iio/adc/ti-ads1119.c      | 6 ++----
 drivers/iio/adc/ti-ads7924.c      | 3 +--
 drivers/iio/adc/vf610_adc.c       | 2 +-
 9 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 7235fa9e13d5..1db8b68a8f64 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -465,7 +465,7 @@ static int hx711_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM, "failed to allocate IIO device\n");
+		return -ENOMEM;
 
 	hx711_data = iio_priv(indio_dev);
 	hx711_data->dev = dev;
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f..f887cba44ec6 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -308,8 +308,7 @@ static int imx93_adc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed allocating iio device\n");
+		return -ENOMEM;
 
 	adc = iio_priv(indio_dev);
 	adc->dev = dev;
diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index a68f1cd6883e..cd679ff10a97 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1019,7 +1019,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 
 	channels = devm_kcalloc(dev, num_ch, sizeof(*channels), GFP_KERNEL);
 	if (!channels)
-		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
+		return -ENOMEM;
 
 	device_for_each_child_node_scoped(dev, child) {
 		node_name = fwnode_get_name(child);
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 4ff88603e4fc..f7e7172ef4f6 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1357,7 +1357,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM, "failed allocating iio device\n");
+		return -ENOMEM;
 
 	priv = iio_priv(indio_dev);
 	init_completion(&priv->done);
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index bd62daea0a3e..67771a70dfe4 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -466,8 +466,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
 	if (!indio_dev)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "failed allocating iio device\n");
+		return -ENOMEM;
 
 	info = iio_priv(indio_dev);
 
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index e3a865c79686..418c909ff35b 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -274,8 +274,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed allocating iio device\n");
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 	st->dev = dev;
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index d2f86e1ec656..0e0628084b5d 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -693,8 +693,7 @@ static int ads1119_probe(struct i2c_client *client)
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed to allocate IIO device\n");
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 	st->client = client;
@@ -750,8 +749,7 @@ static int ads1119_probe(struct i2c_client *client)
 						  indio_dev->name,
 						  iio_device_id(indio_dev));
 		if (!st->trig)
-			return dev_err_probe(dev, -ENOMEM,
-					     "Failed to allocate IIO trigger\n");
+			return -ENOMEM;
 
 		st->trig->ops = &ads1119_trigger_ops;
 		iio_trigger_set_drvdata(st->trig, indio_dev);
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index b1f745f75dbe..30285765c299 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -355,8 +355,7 @@ static int ads7924_probe(struct i2c_client *client)
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to allocate iio device\n");
+		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 1b3b1843a801..d7182ed0d2a7 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -832,7 +832,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
 	if (!indio_dev)
-		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
+		return -ENOMEM;
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
-- 
2.34.1



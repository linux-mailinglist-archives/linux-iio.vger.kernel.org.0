Return-Path: <linux-iio+bounces-12147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8509C43CA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62B6280F33
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A11BF7F9;
	Mon, 11 Nov 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SD6oqpix"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906E1BD9CD;
	Mon, 11 Nov 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346380; cv=fail; b=G9iQGpnGP63WGVF7IE2AK0wypMUy3C+BjJ75ZUVxHPzahwiJkVVNgaTxhKMxY+cT0Xm/RcPRmdJ1ycXbTrCxbozuiLJhcHPd3dchTTuBpZOwEEUcIFCWm6VOZem2T3IRS4I9GlvyF7+GP/EBpo8ldoL/amrLlDy1ju+BYQ950T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346380; c=relaxed/simple;
	bh=OxwlpHDBzx7gu1DR1KZg+LSN76MVcUEG4mWJvWBzHvs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=berl7i8ZBIQUGJhJlWTUsrHObGIhYFGpjOOUCyzjWb7LRyatn+NoW0BftxEycE8tY36BfPjGOiogXREDLbQwSZzB0MEP01aV7a4d9jpHxpBLtCnn0nBOgKByKEWR6TFWUKR5/SthkiZkTKhr2GKwUvSFlwavt5nUvurQ7I7jpik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SD6oqpix; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phrRgy/xXAMA7pigGTf871C6hUe5+Gh8VU7RbUtRl7ZKAc8a/VAIWuZdQVtQCr3EUYWLLtlNEoxGv3Eo5/crpOmjIUA6qSgBqcyj+djH69sU7WHHc+WcmAlaV5XL3Krb8cLFwXJ6EAwtlL1HjvWz5KzImQtMnzE2tOra3PMlogQ8j2ShijReldUbaO4tv40vfO6Fx3n6b4tX9OH1w1wvGHTySGMSpAFYHzm9cVL8OLzLcabov6ANCfcasVLbCeNJJ/bRZ43koIj02FYw+uZzj2G/cj1aN5Eo/4Yf65EPEKtny+d7sXt2xRJCs/1MDRpQYruJMFPERR0lH5biYzDQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBR9Rt5iWZ7G+8yQL1hxTSqN0o1thWd8r7kGUqd9Jio=;
 b=SKg1mbZ3IjJpva+4B/4TefXSHPM6EAq6/KPkmFknnHzbiXFq8QOu/qMOxaJPVM6dSfh/wdxsdRMNHZColG+9JEbfOY6nB90FOCpEBzTuJtVUBak7wqsUnMsNkh7KZ0z9MTsLi0y6cL/R0o1ShvUIwQNylsq5TcrT8skCcioCXlTKcO1FroSqLfO4Vnb5oALZACFVE394BgYzoUeNRU+KUgVltyWHsqS+Iqpk6D4p8rqynuVLKpQ6wqleThiKAr5EG/JD+BSnxb1Y72QUMgdKc+wqf6/SOA8C0zUgTVnQFdZXmt9p16FwLm2/V+HW378x7E6+tKiWoRwAnhhEMB3OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBR9Rt5iWZ7G+8yQL1hxTSqN0o1thWd8r7kGUqd9Jio=;
 b=SD6oqpix7iRzxsZPhftflIfAjq3wHF0m3XfVMg72fwtmRPOsnNKEN2E4uW63Gv+YXacZCgYdd+cJI39umIQJW0AvCv8b4zXLWFqtH7ZZJs9xh9Ngl1HDlvvSZQNBiJ3ItLyQBjJMMhbwQ1koDx8bpttp6DhaKxEk4KfdmlpWMfs5QzmHJJA2AQOtsLQ8JdDmW+7YlrL0j/cMTPW1DPraFQZVM99tir7tJkWdEEQId2MRg+ydApvTeApAxssT9XIqm92xRVeALhgO1L4wHjQDmll3jj15smILQecKxF0ryEq+vxYCDNWA6dN+5SJlf77kQiXFXohTqbUkRdabGaqxtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:32:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:32:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 11 Nov 2024 12:32:02 -0500
Subject: [PATCH v3 5/5] arm64: dts: imx93-9x9-qsb: add temp-sensor
 nxp,p3t1085
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-p3t1085-v3-5-bff511550aad@nxp.com>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
In-Reply-To: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731346348; l=756;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OxwlpHDBzx7gu1DR1KZg+LSN76MVcUEG4mWJvWBzHvs=;
 b=vW8Um++tn2BzxkcvHjP0n2y0CDzvl8r9BxFTlAyR/DkCyIq9JS2AEu4pwB0xQlwhxAclK+uc/
 dmvYPOKuRUQBOBTeGEcYGs94ayFVFLKyUUmazmlcHb78nz77RFZD2yy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b631c75-a92d-453d-3dd0-08dd0276e156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhCL3cxWVJTTnQxWlFlNVFhQmlFeStZSFBhcHBDbHlTNUZNQ2ZkUDFZVkEz?=
 =?utf-8?B?YXRRcmxtWktRS0ZrZFJHNUN5VzhEaGVBYkxPeXVGMk1LSmxrek1zTUVScEdh?=
 =?utf-8?B?bnBNZVg5b0V1SmIrM0dkZHJ2QkIyd1FLRWppaUZ6RTNuWm9EQmk4ZmFWNFMr?=
 =?utf-8?B?aGIvZTN6SHFpYjZNYVJzZlVHYjBnenpXMFRIajRWSzlZOFZLN2VHdGk5SmFn?=
 =?utf-8?B?RENsWGlPdHNKRGF4MnVkWDlydXBuMzl1bnZsVkFTOHBpV0ZGTE9NWm5QeDlw?=
 =?utf-8?B?cjVQbFRFcVBqYjBYeVExRjZOVXQxREpMUlZFcVM5azJsRHRweDlaZzU4N29T?=
 =?utf-8?B?aTU2bjArSFdFOFVIeUhlQlJ0NTlDZHZQZWdtV3VlVnpueWdLK00yajRCU2dq?=
 =?utf-8?B?R01CelNOdG9wR1M4ZUF5MVludXpTVVlFNlpiS01sWFpITEdXWGFCWDkvd0dJ?=
 =?utf-8?B?WXZKbE1vTHd2QmdCRWZiUnFHZmoxa2hXU2RUcEVFeXA3NkxZRW0wajMvMlRu?=
 =?utf-8?B?MW5jdlgzeHB5dkhxNFFzK1pkWHFHeVNjT3dtaGV1LzhKVkZNeVJIMTh6Y29V?=
 =?utf-8?B?a0N2SFNubUZqNE5XcVlEZldKYVNnTHF3czBtRXQrdHo4WVNUWElFM3hHZjIr?=
 =?utf-8?B?QzZaQjVnN01oSkZxSnE1SDk4TFVmWDJTZldTSy9WT3RPdlRXU05NbSt0ZEJk?=
 =?utf-8?B?dS96cjBqUmZDTXFuUmhJS1FreTdHQXpOS0pCdlVTS3VIcmlPRWdySzRLZlpp?=
 =?utf-8?B?cEJYQVoyb0c0MTcydytqbTVlUzNxNmdvamt2V1YxR3UxemRGWDdrTkNKTXdH?=
 =?utf-8?B?YmZ1U05ZNENhbHhJTi91OUpVM0QrOWN3bDcyM1dpcGJnSDBLbWZ2UEp0MHNt?=
 =?utf-8?B?UGZhWU1UdlRLS0ZoR1VuekRnNmNKdVZXSU1iWXpFSVZQUzVFNDVLSldvajZV?=
 =?utf-8?B?WVNzSEpFa29VZ3BzNVBjOCtpd0JyQWdHc1hJWXJtdUppM2JrK0NiblFNOEZZ?=
 =?utf-8?B?UWlzTkxsL29hd1VnTWFFOCsvY2pPOXRnbjZQUFFYZituSVhSamt2Sjc4ZTRT?=
 =?utf-8?B?WHQxUG1CR2dXQUJ4bVJocEtFUTExT25UaDlQbVJDY2lwOUpoTnFMbjFPR3ZS?=
 =?utf-8?B?NXgrdWJTR2kza2JEYU56UVJLclBRWTFleU1KRGQvREtTeWtPb0xrL0QwSWkz?=
 =?utf-8?B?T2xwU0FBSjUxSWhTN1lrYlB3aWgwQ3ZEM05laWp3RnR0L0tzcjNwbjNYQ0cx?=
 =?utf-8?B?SzdIbWgxUUw2UjY5MExTbUd5MURVREp6THlkcWdrd2pocFc4NWRuL21QS0NT?=
 =?utf-8?B?VjdLZk16anNWb0lxRG9FRTMzUVhhL2NwM0FMeEVxM0VHVDdCdEc4aGljaVJs?=
 =?utf-8?B?V28ybzdqbnpiUjlJeHlGcnVzOHJHM2NaWmlQMWtxVnQvd0FoOFVWUUQ1ejdt?=
 =?utf-8?B?bmVHWUsrekNVUnE3MUNnTnduRjEySUpYMFhqczRxeHNsL1BKTllodWU1RUM4?=
 =?utf-8?B?Q1ZyVFQwbmdZS3ZGL25FSkNkNEtjUitqRnNaalBjbG9vZDdFRU9USFlFdWdT?=
 =?utf-8?B?MW53bGtUcWs4YjEzRjV3VGY3ODR0Z0k0ZE1jZnpOTStNMmdkeDFYbFArVlVO?=
 =?utf-8?B?MDcvUEZydTBNMnNYOS80NDBOUWszVHRFSVcwQjVsNjlTRGNTMklLcmlvbmtk?=
 =?utf-8?B?SlZTNFNkNjZZRW5nK2E4YXJjTjU2cXBZcUUvYk10TmVzM3VyMlliQ2VBTDZN?=
 =?utf-8?B?Y2xYQkYyMk9iaUpQUmJGUTliMlZVOURIMHh1Q3lJV2krTkMrUVkvaUl6cUZZ?=
 =?utf-8?B?OC9WQ1ZsUS90djRZRlRkeTRuVldBVDFGdmVOaXpIdmMwL1AxQmZwYW8xK050?=
 =?utf-8?Q?6qN65yX/71FQ9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2k1MktmdkFhTEV3bGVxUmZPSDZDcFl6Q0ZyYnFlWGJmQ1dRRVgxbit0K0ty?=
 =?utf-8?B?OERneWZEclVzY24yQno1OStJa1YrQm5oMFY5NG1ycFJaZzM2S0lYWG5ENmlp?=
 =?utf-8?B?T05yZllDcUpDU0hQbTV2RGFJNzhuSzFKMGpzaFl4Y2VnK2hEOE5Nc2ZGYmZG?=
 =?utf-8?B?MUZGV0U0V3d2Zk05eTZzbC9vQmV5aFE1bWhBTGtnTkNzU2lXaTdCVi82NmlK?=
 =?utf-8?B?NVRTWlNhd1U1NXVybXpwZmNISk1lc3F6WGU0Tmk1YmpJSFlOVytOWlQ3bkU4?=
 =?utf-8?B?NTlYOUFmNDNkc3Q4SWI5enBtYzJRbGpKczVKWU1NUHZ1L25jelQwak5IL1lT?=
 =?utf-8?B?bzZ6ajFTa2pRdUJIV2h1UkVZMWQya3BRb2FUOUEySGxubUg3N2F0Ukc1M3l4?=
 =?utf-8?B?Wm9PMGFwQUJGZDNEVS9MV2hxVlVDNkJCUG4ybExHeC90RU8raFdydndWWGNZ?=
 =?utf-8?B?TjZPeFdwWllJTlFqNUFuVEVWUk5XUFQ3Ulcyc2FNSzRQRWdrekUwUmRsdW9w?=
 =?utf-8?B?aVUveTBHVFUxc3ZBb3dpWFg1ejBJSVppclBId2Rpd1g0Wm54bmgxM3Fka0dQ?=
 =?utf-8?B?RThseFdNUGgxeTRMWGFzeWM5eXpTdzFKNFJuZmtQT1pYbjJ3d3hlTGpCMzZm?=
 =?utf-8?B?WDR4ZFpNN0xOVGVVeUhyZE1qRUwwdnFYRWphN2pRYTZRMzVEU3I2cklveUEw?=
 =?utf-8?B?aVErek1Md08rVGl5TWZFWERYMkNKSkRsOTdtV2piVTBJN0NWUmxleGtCWWJh?=
 =?utf-8?B?NlMxdHg4UDltT3crYnFEZVJ4TVptcjFXN2RVb2UyN2RKU1VudXJKbkV6aG1M?=
 =?utf-8?B?K2h0aFVqSXFLRGNTQ241ODlGSGxKVTh5alZPcGpwN3dvSUJuM1B6djZXZ05Z?=
 =?utf-8?B?U3RUZ2NUcGZiSU5ZZFNreWxybVdNZTZWemZwL3JFbWVZL1BqSlgraERSd0hT?=
 =?utf-8?B?ajByRUtQNDY4UXZCTFZWcjhXeDJJc25yZXRaTVhaUUlsZXlYU3ZpS2lxVlNq?=
 =?utf-8?B?VGxxaW5RSVBMQjBuNXRRSXQrckMzeEZFZzJLemU3UGVZb1p5Qk9iT3J0L2Vj?=
 =?utf-8?B?SjlTMXcyN05aczNid2ZLUE0rMGF1NWpXOWdRTmdQTXBKYlRUVTVGN0kwRXpG?=
 =?utf-8?B?M3dJdk4xNytDZFlmYjlIUlEwZGd3QVJPVTEvTTZnUXNvK2x2R1prOWpUK1Nk?=
 =?utf-8?B?TEhxbU9rRGpvSDJ3d20xM1lEUmxJWS8zZWhNU05CbjZIdU83RkJZV1RwTUIx?=
 =?utf-8?B?MDM2WG1KUmdnNURhSUgxTUlmbi8xZmJMbVhrVlU5VXpNMXI1MUF4Sm1tR2Zt?=
 =?utf-8?B?eDRrcGdWMjZDUzcxbGlIelJEdkNyQnVqSFpuM1FQaE4wWUxrS2I2S0c4ZUlk?=
 =?utf-8?B?dzZ3OTVzNjRHUFZ5VGgySzdjTnRRL1FTL2lqRzNURDk3anRyeEpzMHFlR3lJ?=
 =?utf-8?B?K29kbnpRQlIrMW9VUG5zYXd0UEtmM3g0TXU0YmtSTTF1cC9yOEgzajN6YUhH?=
 =?utf-8?B?S2d1ajgwUU1wTkJ3SXBEYVNkV2lqUWF0MVpQclRLT2xlLys0VDFYdUtNaVQy?=
 =?utf-8?B?RmhQeDlTbkN4YWFNOVQyV2hwWkh5NVZOenhrb2JrNmY4S3VZMDloRUl3TEtO?=
 =?utf-8?B?emJ1WDJqSm1ibkdacHhGNHEwZkN1akNLZ0wxSm40S1M0YitsOWN4UTFpcWRM?=
 =?utf-8?B?bTY0TWd6dU4wTUhiUHVRekxkeGFUUnFDbFJYTHpjS0svWExsUjd2MDM1NXZk?=
 =?utf-8?B?TWE2Yzk5ZEFaaFliTWFUbEVLQ3RPSDh6d1o4My9mVzNJVXZjUGI1ZUt0UmN6?=
 =?utf-8?B?MjRSVjBnK3JYMFV4cmpVdGJrdkhuc0ZxYlZ2NTdhWEFDK09tbDNPQlhjQzl3?=
 =?utf-8?B?Yko3QXppYkgzN1B0S2s5SHJLTHhDU2tVTjE1UmFDN0E2aEd6Mk1tZzRZYW80?=
 =?utf-8?B?NUduT2w4Snp0aEl6dHNTNG1MN0ZBSUE0cXVadGV4NjlqQ0l4cGF5M3I4ZXdQ?=
 =?utf-8?B?ZUJOUmZ4dGZMckdEd3F2Q2FPTXM2V09JcjJ0eEJwQjBUb2V1d1MzeFhKTkg4?=
 =?utf-8?B?MW1VdlIzaFBtc2x3ajJuV0tGbHpUUitwUXUrbmdkcDdYZlVHME0wamplMFEx?=
 =?utf-8?Q?NZuqW+OjBfSHrXwWHDJxC5761?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b631c75-a92d-453d-3dd0-08dd0276e156
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:56.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA6Oo6IDqOO/T/AwRZsnCfb9ckLyUJVe2McKPzxVFExVvwjFhcwZEkQtXMSGT2558Crng5S/KNM1erhr6loPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v3
- none
---
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 20ec5b3c21f42..36f2995acbe29 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -221,6 +221,11 @@ wm8962: audio-codec@1a {
 		>;
 	};
 
+	p3t1085: temperature-sensor@48 {
+		compatible = "nxp,p3t1085";
+		reg = <0x48>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;

-- 
2.34.1



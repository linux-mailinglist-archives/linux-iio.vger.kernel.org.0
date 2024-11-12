Return-Path: <linux-iio+bounces-12184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021EE9C6068
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B838B66316
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08B2141CB;
	Tue, 12 Nov 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBcnmAwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05902141A8;
	Tue, 12 Nov 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430353; cv=fail; b=QdQNmxEEvHqXMDXDpYfxyM7irXdeVKSwCphkXLwvxgx1Attm4cAC0EUcPm2+bkfTMnf99r6urE75TUdzhQFY6H9H8J/IoMmb/Jz8ymWsmy36a7XT9O1jUG6ll+oYZLMJss1hx39yQz86SkluL/tY5IW4n8cn+057taqd07Y8sMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430353; c=relaxed/simple;
	bh=JAPK3bGdhfGqrsoR9koYophADpQ1m2fjbRKgX4s6sn0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dn5a51fOmIKmQDQRZbLi4pKfFPG4bJNb0ibGaP0RK4KQ9EvD+Hhoify8kxIAJ8o6NKBM97M0PQgkrkltCCV1hOvfyYfT2Hr0kUbzaOt3Ktp15wEXBaOMwakR7xJHC/1X6uf4q7uKqnKD0Bqftcpu/2XchlwVZo/QgMuDH4FDbl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SBcnmAwJ; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpmWm6l04moXBed8Z+gpjAlaXKtleJluJVm3eFJde39a6mDj7mrhUyIFJwV32QtrDbQYqOOlDT7LhNyABzr7oMfaegbqmzTQNnFxHSlZheUwhClnTxSnB1Dr2fEISCbeagNml95Lh+7W/xEYwMpK+3IidHvXcmFbx8xqr3Yf36oAdT5zkiN1y2jb9OuTkp0Wl+0wQovfDsNMY/bJr0pASYdr8BJ7NLuYNsxiTK84jWX8w64A66BQOw2xzAq5sRdxaCOI7yspBm6u+OFuXCHvrUcrhl/7TJmSOSAaQHhy06uhUgUi/1JSCPVPKV7qqiOvou/LlVVTd878qtc9q6+u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjnOm9DtrWDtfEbRBI7BNxeeiqhv9ulpfh970Uk//hA=;
 b=qDGQjf/a3HpjdziSIJQ4xBLuJQgPvpSmaj3uh7iqo5rtnD11RBydaUz9r8hG3naLGW5ILvvnYLiL2JsXNANZX8ZTFXFF3+OM5ZxX2Rbddd0swPbuIBI2RNrCUosPpUKGtUAiL2P3ATkQgpzpLv4482xdAZJVHSp+9Qm/OcSo/g+bhy7ycPl3npkCAX7GIkr+OVaoICaVG5YhzgGqxcS4tkPHyBF6ZJ60FcARb3E/BS8ZSQP8SgXYYvn7dSFzHbFnTMCWdtGAJkIUtrnDB1BvoCyB+KxgZG7oYBQ/+/TAGVIb600299gr5fgt8AFN257SnapB5fu4B8M22u9BrNygHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjnOm9DtrWDtfEbRBI7BNxeeiqhv9ulpfh970Uk//hA=;
 b=SBcnmAwJuFVRzmJIrFmYdRPQ7iBXaTp593xwadYQ78VoLnZ8qwcaRLNKR3gqfDs8MSAT8Rjuwt4ASagpG8BLzt0kk5Puqpuh5JAvn9VixXbMX+a4eoqOMRXJXuLNdmEMNF9QJhULt7/XYZ/C2Ip8R4M66Y6HP4BqI8zF9/GTAWw+nAW09lXj36RLaIXMXfvD2yxqCYNsG/+0uCq0QbhOLbt5sbR0ZH991knqrFlhjN9PPlhQKIJa1CpS2VI86R2Kc1QZxGVlWwCdASKfR2qP3IpV5LpsGWRG89+tLQaVTlXN+s5F7YWF2eI7AJrfZow0JyioVpKGoGYPkSVtQgNh+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:52:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:52:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 11:52:00 -0500
Subject: [PATCH v4 2/3] hwmon: tmp108: Add support for I3C device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-p3t1085-v4-2-a1334314b1e6@nxp.com>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
In-Reply-To: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731430334; l=2704;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JAPK3bGdhfGqrsoR9koYophADpQ1m2fjbRKgX4s6sn0=;
 b=lytpmW9PjE3AkoFvOTWvM3IbqWbrv1N7NfI/qTCQWlF1CE4LMKyXOmZwRtpM/cw4IQmXbMMBd
 1XjbgdgZLbNAfsAhSK4FQd1yjk4d890ThdOdV5K7mWlF8CbUa4tXCFP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 596a0b0f-e4ec-466f-3144-08dd033a6404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUthcm16blBreGpIZk1mc04yWGNOMEkyVE1KK1djVjYyN2s3WTkweXNEL0kz?=
 =?utf-8?B?S3o4dUxRbHlFa0dYczZlN3V2ZXBOR1FGTHRKMktGaUc0Z1FqNkRJekRMWUsw?=
 =?utf-8?B?QnAwbVBicXpJRXZVRlJ6TjZMcXpqVTM2UkhjU1ZKVVBHZmg0SG1PaHkrSVp3?=
 =?utf-8?B?YXFMbFJFVFhNRlFudXZGU3Bma1ZQMHVJbXpkZjQ1UjhPSGZGTUdmV1BpTmFH?=
 =?utf-8?B?TTBaNGdGYWVoNk0ySXRodkZRVVlma0lVQ2VxZTRPaTVGNGxDTml6QUlxQUJx?=
 =?utf-8?B?aHFqQVh1TTcyNnFuRHpJdHJPL2Y0WHNOZ2FQSDl2NytZM1hsZmpBRE1KNUl2?=
 =?utf-8?B?dkNleDZVNkZrQUNLdnJxNE5YcCt0bDZVWVlPNGFrby84aFBQbGZJamVINVN2?=
 =?utf-8?B?UWZMVEtZRVhTdVFGSlF5N1h4R25naVN4WllDWk01YkhTOHpacnZWVGt2My9t?=
 =?utf-8?B?WDJhVTBpMXBvc2VqT1FnT1R6MmhvdFRkeW4zY0JneDNDK0ZjSC9QVGEyeXRV?=
 =?utf-8?B?Ny9LZjdYbC82YzlJdWdBRWwybVc1d0pSc29kVGViQTY2bjBWS3NaeSs2NE5q?=
 =?utf-8?B?T25vZ3UyZm5uUCttd0NkeUZWMzV4RnJFYmc5WFRnK3RNTEhCRFkzcjJLVVdj?=
 =?utf-8?B?MGJyY0FwT0U5Wm5FMi9YektPYWJwTnh5Lyt1ME5YM1RIREdKNlp2Ni94YUJT?=
 =?utf-8?B?RzZHVUlOcGdrUTVxbmJCZTVkUHUxalV0UXFPTzRyaTNCaW9TTWRzaU03NlhF?=
 =?utf-8?B?QkxXYzk4ZTJyVEFFN09PTi9aRk9UVlRCSHB0NjBnMGhUQm5jZ2swbktHNGU2?=
 =?utf-8?B?SDdtZ1lodkg2Qm1xOXhXa2NTaGRQSzlBY2cyZlR6cmFLQWE3R2tUQkNwS1pU?=
 =?utf-8?B?THlXUjlBM0ZWdkxKeWlSbCtQMWdQRk9IZkt6WVA1SGtrSmRDU05pMlpmbk9B?=
 =?utf-8?B?VXQ3dEczclJrWHlKajk1UGN5bmFHUlJnWnZ1VXNiQy9vdkY3dlhvMG8rTVdK?=
 =?utf-8?B?WFY0RVFaUk95TVNwQjdNUmdUQ2hJNVR2OHI2Tjd2RTdIVWtsS1A1TGFnQnFS?=
 =?utf-8?B?MzRsakZyWWZUblVIQ2RKR28wTWZTRXk1TmRUdXgzRnlrcnBKRnk5cXBJRStY?=
 =?utf-8?B?aTYxOUIvWDF0VW50SHk5azZ4V3FLcTZvUkhKYlZjNXQ4ZkdIbW4xTW0vSXo0?=
 =?utf-8?B?d3NRZHVWSG9qMEh2ZXFmdHYxMTNaTmRjNnhodEttSXlNQ3RQWHlLcll4QlVu?=
 =?utf-8?B?R0lFT3pPQ1Q5WitXOEYvM2w5UHo0THNnWWlNYVl4YWFNb2pjRW82c2krQXZ6?=
 =?utf-8?B?ZXAyQ2FJZER0NytWMG40WVloZWhMYld5VEVhMXhEWGZxS3lSQ3NkSCtTdzVq?=
 =?utf-8?B?SmpIUDJZdFplQm1ndm0vcXRRWWVSMTh3ZVV4ZW9mZ3l4ZFFsSkxmVllSSHU3?=
 =?utf-8?B?VnJGbUViT1dQQnNwenNRaXp2ZFV4WklkSk5ocFN4L1hhZUpEU256YzZ5c1BL?=
 =?utf-8?B?bW1USnhMd1RrZnBmQUhmeDhERDlJVEtDTVNUWGkxMmtUUnE0MjVUdkxsdTdS?=
 =?utf-8?B?c05sYUFPQkJ4cTQxMGkrNG9ZUnpNbUFMN3pPT2E4aDYzT1c2dCtaL3ljRy9D?=
 =?utf-8?B?cytzV0l0U1dnbmNqQ3poTDRJaWpMMGt3ak8zc0oxQWVGN1BvQ2VEYVEraTBT?=
 =?utf-8?B?ZnVnQ0ZrWDM4a29WVldtbVhEeHlVZ2c3dUxORGN5cElpOThxSkFKK2xXb2Fo?=
 =?utf-8?B?bDUyaGlzQlh1bUk2OWtzR3FxNFJnUUQ5M1kycm1nS2wzYXBKT01LKzd3bGxL?=
 =?utf-8?B?Q0ZwWHdJWkZyNCt6eWFRMWhjRGxNVFBiZGRua25LcnFrUFA5WGNTSDNJKzlV?=
 =?utf-8?Q?Ni6sY6YM/3GLx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnN0bVFhb1YzV2V1VmhvenJCMm4rYXJaa3pHcGRNdjU1U2oyNDdZTllab2pH?=
 =?utf-8?B?ZUhzcWVoME1HVUZ2UUtqZTNaNGd3b1pyUWsvV0N3ekVTeGVoa0NMZURMd24y?=
 =?utf-8?B?T2o5ZUJwNFJkN0d2TWo4cEljQTdZc0JGSkVQZDlQMTc3YUhpTThER2lLaUZB?=
 =?utf-8?B?YWQwL3pvUjY1K1VUUW9ENkZEbWpvRU5pK29FSTc5QzkwYnc5VHp1L28ybTdk?=
 =?utf-8?B?NEhMSnBYNFd4eHpTNUppdDlOalI1M3pCUTlhQTAwVERma3paeTdNRUxNRFdO?=
 =?utf-8?B?ODFqaHE2V0FKdk5Fall1NlRpWEZFL2NuelhJMkhET0x2eUFWb3JCTTZsMHpN?=
 =?utf-8?B?b2FuMTdvekxEajZzMUxwTUUvcWsyVVBzV1RLY3RwK1hMeDhYUlFRYWZaOGww?=
 =?utf-8?B?ZS9xZTFwNHZ2MlN2aHFnTFZqK2JzYWlEQmVmVkZQcjZLWjA5N1A5YTgvTUpC?=
 =?utf-8?B?QndzZzNWbDJUMjRNOEhnOW9IRGhKTFJQanJ2SmV2Rks2OXRhNFNvRU1wR1VM?=
 =?utf-8?B?Z2RGMzdEdGh6VEFNaE5hV2JhYnZrR3A4N2J6anVneW4zTW9ocTF1c01sdm5Y?=
 =?utf-8?B?dmUyRURVTXFmdXRiUEZicWVvVU5FSkJOMXFySjE5ZTN5eWFiTXpyTUpHZHht?=
 =?utf-8?B?YzZvVjZhR2k3ZExacVVUL0VFRWJTczRZdkZ6ZzRVV1ZWL1VQeFBMWkI2dERK?=
 =?utf-8?B?VjNSa0VOeVN3NnRvMEUrczBzMkxOUFVSNUJkNmNpeFR0ZjQ2eDRKOG1paUJz?=
 =?utf-8?B?TDZ5N0ZZOG5XODdBV3hNald5U2QyRUVJVVo4MUN0OVphdk0zcDMzS1FvRG0r?=
 =?utf-8?B?Q3RrSkVLMGRMb0FZUDRsK2EvK016ZUVyaUphNWFGNVZmS08yT1NGdWozZGxk?=
 =?utf-8?B?WCttNUxrQnVGeDJLeC9SdUN5M0VKRXpVOUdoSWJrdEdRUksxL2ZmOFE0ZG1q?=
 =?utf-8?B?eXVsSUpad3JGV25KdzJsWXdrZ2VPSVNQQlFvb1ZFNU8vZWljR3BtY2hzNHpX?=
 =?utf-8?B?dytrWkc5Nm5yYUk2dGRkTTdvWVRzOUQwRXVqRzNnMnM0czFGcU1UWGZQQ3dQ?=
 =?utf-8?B?SGI1WCtscytaWUV6ZUMzVWJTMEE0cUV3bE84VlIzOXlJcCtRNGZ1VHZkWmt1?=
 =?utf-8?B?UUJUZXM2cUs5d1luSHRHbVMyMytmMU9DaWlmK1VONDVQUVl4cEJBZ0IzS2dH?=
 =?utf-8?B?SDQrZHh2S2ozQXR1ampHQTEvai9VeEhpNkFMM2VKL1hleFQwczRPYUxvZzNL?=
 =?utf-8?B?R2VRSGVCcHludFE3M3EvWkx1eitFVEtnS1dhZDNNZTZGdlhmd1dTamVFcU5p?=
 =?utf-8?B?eHBqdmI1MU1RWWRPYnlxUHJqOGJBVHJBYlE2czJIZGh5MXlKMVpBN3l1WmRT?=
 =?utf-8?B?eVcvODRKbW80aGZ4OU9mRmlhVjRQZTQ4cHd3eXp4bWtNSmNtUW9YTDVHN0Ux?=
 =?utf-8?B?K09DV0JhTndpSm1HdGFndS9veXNYMEpWeXVjWGw3RURLTEh2clF1Y2RxeVZs?=
 =?utf-8?B?SkR3Vi91V200aUc5bVVkdlpMUFNwRTJGZWp1UHNQdU1XcFhIcnluQVprd1pt?=
 =?utf-8?B?WU5WUGJhd0tXS0FvK1QzTjQySlJ6eXYydDdHTmJCV3M0Z2xJNjBCQWtzRjlu?=
 =?utf-8?B?T2NMUktqY0tGV0VrQkpXU2VsdlYvZmtqU2xqUVlGNU5JNUIrTlJyQ05IRnB1?=
 =?utf-8?B?VEp4dWFRU0lyckVzY3BqTzd6OTJoeHJKNnA2U2VYeTl5VjM3SHE1d29vczBS?=
 =?utf-8?B?L3A0NEZvZjFqSlQ0UTUzUG44RFJOMkwzdkZSOVV3RWxwSHdWVDlRNUNmaEFo?=
 =?utf-8?B?REtlS25oU2dyYXJrZS9EZ0RYbG95RzBoVE9HcmgwZGwwejY4UlRvZmkrTDNI?=
 =?utf-8?B?QW5TaDRzSVhlTWFjSi9lRDR4QjBtaHRKWGJVU2VBUENPT3dpbkIwQVZzR1Fr?=
 =?utf-8?B?NmlpUFRreDZsd3lMUEwxeGZFRTVYZTZSY1U1dlpOd1orVlFSeDE4QTkvMlNt?=
 =?utf-8?B?ejM1RXk3MXBIbUJ6bElXR3pPWFdZZWZoWk1BMkZBNTZveGZTMzlyZzE2YlBr?=
 =?utf-8?B?SGNZRkJwWEtqZ1dtRU1HcE1QWWdtazN5RVN1NUxaa1JjSW5IajNRRGhSSnI4?=
 =?utf-8?Q?8dSfLT+Ddbpc2J3J/u2ZMgHCL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a0b0f-e4ec-466f-3144-08dd033a6404
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:52:27.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X59XdbkZSIbi55LLe40AMkfV/nBSIbVHIlvs+8cGMHdMpF2+/ib/zQ2f72g6/QvG9tlCUzmjzDCI9Dllp/LquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Add support for I3C device in the tmp108 driver to handle the P3T1085
sensor. Register the I3C device driver to enable I3C functionality for the
sensor.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- use module_i3c_i2c_driver

change from v2 to v3
- change kconfig to select REGMAP_I3C if enable i3c
- remove i3c/master.h
- remove , after {}
- use #ifdef CONFIG_I3C about i3c register code

I2C    I3C
Y       Y       support both
Y       N       i3c part code will not be compiled
N       Y       whole TPM108 will not be compiled
N       N       whole TPM108 will not be compiled
---
 drivers/hwmon/Kconfig  |  1 +
 drivers/hwmon/tmp108.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d43ca7aa4a548..9579db7849e1f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2298,6 +2298,7 @@ config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
 	  sensor chips and NXP P3T1085.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index bfbea6349a95f..1f36af2cd2d94 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
@@ -440,7 +441,39 @@ static struct i2c_driver tmp108_driver = {
 	.id_table	= tmp108_i2c_ids,
 };
 
-module_i2c_driver(tmp108_driver);
+static const struct i3c_device_id p3t1085_i3c_ids[] = {
+	I3C_DEVICE(0x011b, 0x1529, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
+
+static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+#ifdef CONFIG_REGMAP_I3C
+	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
+#else
+	regmap = ERR_PTR(-ENODEV);
+#endif
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
+}
+
+static struct i3c_driver p3t1085_driver = {
+	.driver = {
+		.name = "p3t1085_i3c",
+	},
+	.probe = p3t1085_i3c_probe,
+	.id_table = p3t1085_i3c_ids,
+};
+
+module_i3c_i2c_driver(p3t1085_driver, &tmp108_driver)
 
 MODULE_AUTHOR("John Muir <john@jmuir.com>");
 MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");

-- 
2.34.1



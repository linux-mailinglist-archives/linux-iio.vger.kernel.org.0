Return-Path: <linux-iio+bounces-5643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17738D76F2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C635B22348
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FC757F6;
	Sun,  2 Jun 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FUSW74W9"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B65FB9B;
	Sun,  2 Jun 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343393; cv=fail; b=BBVXu1t1vWRIcP/Bz5FNST1TyWlL2Pksrnt2D9cyTwdFCpaeveDEgpILna9+7WlEAuGfbpo2uSMGTBy71YgVfG/nwKRgXIRBH+wtdpYPUtAcYLS0hY0jhwM9JWjYwbYHwx6srqvbJNwDNKAimq/eUSpDGI6fbUonE+AdGounQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343393; c=relaxed/simple;
	bh=kES2HB3UmJwXWYZulDjoJS0K/eITeISVm+N26XBUkUI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rLxkT8uXAu321rY6GHkF/XGlKnprYYzAvY8WZdGedEXIWSmBgj66cp71TBgCcudgr7CElYlrNDu3DARhPCocI3SHg7MmQHTj1ZsBRXvtVsOoBTGR1rfSTIB8k9X3/c3BDCJ3pAPhtkKCpmRD2xDV1x7Dm6/1dvFoJZVqe7Y2Xt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FUSW74W9; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/ZS3F0DDRWeiLnxrbSDqdqveIvLGpqPIBZg2gc6g/3hmrP3v6SDAsJFF7YYFy/+fgTLMS+llNAJl6oI2vR9H3nihlraFAttK6BnjmqVd9+Xdk0OF7OkR5mvzreXPrbpcPd/3U08ezXeJrOHW6AdqQ0TkMDa1OvhGV12zrv3b+37+EHulVfQMo409yCB3xz0XVIcFsZd7bZkBBDnwl3LFmgQXrLnzckCUkEK1fI+j5FDw3HoabgQwgESw2N/x1ubAafIv2gqhOx9zINQyH4eHrTKH9ptKOwdv8LoIqapzF6RRbfok2m7AvgHshgSgtyfF6UAXFHKHf8mrNmtH5DZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d05q49xYLdldzIAJAOLYnFweox24PXDvvTxGws5LHM=;
 b=OjeDa7Ew3RWZFJJBfr9ekjoKZ6ND9obuYPQllAsM3biul9g8CIjn9BY/SRWOYB4yDFgVjam9iQ5IVjMPd9gmGB2Yf1ENVj2nZCJd4IRujHuppXNrzFFnqIxscbqHZMONOBk/ZdJ+0uoVlhhGduaDgMms+6HHlRjx8RRNCYBJMV6QXZVXWVdPOaEYmGw5nZ7xcNXLkejCnE1Cq+UkaebnrxxXAQ+FOUfBFq0j/BtqdDn95HVmy8AbRB/cv6is0XeNX4i4QgWxpEkh+2OIPjgm7RoPE7I1IfixcrjD7p6rgVbhfxkxm1XG/OD/bMOEeC7vgi2m8v+Sr+TnptrWpHFBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d05q49xYLdldzIAJAOLYnFweox24PXDvvTxGws5LHM=;
 b=FUSW74W9Yr4gu8n9CytmkC/hXLR35JEd3v6WgInncYhxoifr9wXSp/cYCrirRBa25r/cCvMMX8b+SKKJ/s3J7VcuyZVMEdtNwknKYXxmOyXuRsFePmxuSy7p+vPlQwjQxotNPnsVuujrlx3DX4f8k+ae9KNXXONXDV8SXbVJjIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:43 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:43 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:40 +0200
Subject: [PATCH v6 5/7] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-5-89393e86d4c7@solid-run.com>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
In-Reply-To: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: afcd37e9-adde-4ee4-c973-08dc831b9ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0JJTUJ3cDV0SmJqQ2s4dFI0dERLVjBYWnEwMHQ3bnloTFZmYjhSQmdoM1ZY?=
 =?utf-8?B?QlRNbC9QQ0RVbyt0REI1dlZQbU5EaDd1UU96ZGFnTTc0ZDA4SUp3anByQkUx?=
 =?utf-8?B?dUNJMGdWdUZrTWNyT1B2UWZDY1M1M04xaUtqL1BmSHRqQ1JuckY0OGFuUHlC?=
 =?utf-8?B?S3pTdzQzK1piTXNrWXFpdjhvdmZEMXBkdGxaVmZHT1BCbTFhaEZ4cjgraXYr?=
 =?utf-8?B?MkFtYWk5MlAzQlRhMWhxVE9aT1RvY1lnR3VPNk4wUkNnWUZQTnQ0b0RZUjRJ?=
 =?utf-8?B?aGFTdnAxSlhOVWs5K080dlN3QnlsMW1KcVQwSUFYSW5xd2NRM2FRVDBEYW9Z?=
 =?utf-8?B?UEpUbVRzaTFVR0NFYTRmMFJOSzM1dzRPTGVOUUdXdm9lRUNqdys3c0x6SGJC?=
 =?utf-8?B?WW9JZU05STVhQU4ybFZCU3k3SDVvdVZhbDdTOUUvS2p5TkJyaEo4cHpaWnlU?=
 =?utf-8?B?aGRKcytzUk5oZHFLK2l3TC9xTDJ3eEUxck03U0ZLck5VOCtHTzIyRGlyUWkx?=
 =?utf-8?B?dTlxZ3AvUldlUXJiYkZoV082STV3Vk5IeHRMa2pSaW5WQWpteTBDaVkzTElm?=
 =?utf-8?B?SkQ0USt4dVFiK1dwajlrUHhNWEd6aWhMYVZ1bU0xSEh3YmhqTXBJN1o0amZW?=
 =?utf-8?B?TnFaQlgrNkxPWTMwTUVqcWl2UDlzcW5PakFDL25MN0tWOVF1RjhQRUlWNDhx?=
 =?utf-8?B?LzVYZjFuQmRqVE1pa3ZwZmFqajFVR29rY0xPOUo1K2hDMmFXWGoyaGN0L0pR?=
 =?utf-8?B?M2x3TG9ES3cwb0dEbWl5K09GNGFQa0VMYVcwUFJtWEt3cFdzeEEvT1FMUzRX?=
 =?utf-8?B?RUhpQ1VnWVVqUDRCUVY5RDZyWjlrdTlpRVI1dDYvd1ZWZ1JWMFk2eVFPSUpn?=
 =?utf-8?B?b295NitiVTFYTVRpUk02Qjc0TTdaT091T21hb05MS2w5elRKMDhHb3E1TmhM?=
 =?utf-8?B?TkdpMDdPRHpHSXYybmRIUEZ4ckxXZGdqV0JyV2pwNmFjQ3BaQm9CT3pTQWpZ?=
 =?utf-8?B?WlJCdWtMYUFDMkRQblRJL1h5WVR6ZzZyYTYxdXlKOG1lVWJ3WWU0YktQUUFV?=
 =?utf-8?B?NWZmWDFwWWJoOHcxakxnbVdNMjgxYS9BWlNnS0FEQ3RWTXRxQnljUXdkb01E?=
 =?utf-8?B?Tm0wb1VjamlVb0tWY0ZMeWdvT3BXbVZiYW9QeTk5RDJQQ3V3dDVHZ2d2a29K?=
 =?utf-8?B?SWtlVWFPck5DdlppWk1kWFRERndXZEdnVW95WHU3UklvVUoxeHpvczJCRUVq?=
 =?utf-8?B?eENjM0NFTnhXVlZML0NGUWZXalFqa0FXNXdkZ25KelVUTy9weFRJQm9wYTlF?=
 =?utf-8?B?R0sxSnRNcmFybEpNZVVFUTRBSE8vNXVNaDRqVkZvejN0WVNramRJV05mZitS?=
 =?utf-8?B?MERtY2RzVUlVV3A5T1FqV0RBVlVvZ2VWREdkMklaaFk4d1I2SmdEOTFEWUsz?=
 =?utf-8?B?VkYwKzd6V2s1T2ROYS9PUWNmYWx3U0J5amtNLzNqa0liR0w0WVQ3bXBrVG9H?=
 =?utf-8?B?ZExGYVcrS0V0a0NSVzNHbW5rS1A2TTNNN2w2N09rK2cxM3I1VmtveWx0STl5?=
 =?utf-8?B?TGxVeFNFMC9LZkE2NWFKL0VSZEV3NHlhRjllSkVNTWI0Yy92ZXhUUzI2ZktC?=
 =?utf-8?B?NHN4LzZlUzFRTU52cDNWVmhBMFJVS3p0cHRXbDdtV3JSYnNoMFk4UzJSRnRM?=
 =?utf-8?B?aDhVZ2E2ajV6Y2hVdUovMjc4UVlqS2lxUjJNZ2hWZktLejZBWnFBOGRhTUJ4?=
 =?utf-8?B?cFV6VUNBMG5mOGZuaGNOY2tGY0ljNU80enFuRGZYWW92MG94UUQ4Rm1PSjht?=
 =?utf-8?Q?mPDtPmwfo1dVa2oSMjG5XygpJlpMvOLmJyp8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnJXUUhaOGp3aFNLTDdqMktxb0tEa2VQaXdUS3E0bTczdmthNE0xYlN4UFB6?=
 =?utf-8?B?NDNaZWpPWjBjT2V1R2hwYkRmVktHc0RZNHNWVDl0cENqMkhJcFNYVWdrcUR1?=
 =?utf-8?B?NFVwbExZOGQ5am5JT0M5S0YxQjE3dGJGZFBlR3EvZlJhZmVPVWNhc2FscDlI?=
 =?utf-8?B?VEdFdFBHdmF0WVRJRHZSUEdBK2ZtTFV2eVBkNjQ1QTE4UDJQbG9lempkWGdi?=
 =?utf-8?B?OFc5LzF0azFzaVhQa1ZuMkhQQU5CbWhONjJmRXZ0dFpRNGtFK1gxR1lTY1Jn?=
 =?utf-8?B?cHZ6R1pLN0V2N2dHVitNandCZWJOOUprbjdSTGlucFhqUGo5bTF0eXo0MnBL?=
 =?utf-8?B?aGRaNFBQanpONzJ4amtnNWFHRmdheS9oOFJ2N0cxVjR2bitUNTZjQVN5MWg1?=
 =?utf-8?B?Z3AvUzl1SUMwL3dnc0wzOTREeWMwVDhzSVVrQkpQcFkzWjFwK1JhTmlYYXRa?=
 =?utf-8?B?VnlObVdaaG9RYkhoempENmJWYnRwcWd6eVdKbTB4WXc0eFhVeXc4MnNnalhy?=
 =?utf-8?B?RlE2ZEdXZmI4cENVVWFybGN3dW8vdUVUOFB0RU5CdlZHMlB2WENtc2dMVGgw?=
 =?utf-8?B?eVEwaEVmU1dJQnN1bWVSTnJqWm04c2VYalpvYTlYcFdBWFJ3ajRFRkdkTE1X?=
 =?utf-8?B?M3lnY2xmQmdjdk1FeHZMcXFmUzA4cHUzc2x3WGRzcnA0cXBhWlRrWDBaZUVi?=
 =?utf-8?B?bXBrL3Q2b0dOVXJoQkNOTUJqdTBMWVNEbG5KZlJVVmJHMFBIeGNpQkg4UVE4?=
 =?utf-8?B?VE1WczlyY3dTb2JhajFpNEM4d1VBRUpJN3BZdXFrQmEwMll2WVI4Q2U5RlBv?=
 =?utf-8?B?YkhtdzZaQTRrRkpydFRHNGlpUVhkeUxiQmJaQk5HaUpybmZOdTNUdFp3YVRW?=
 =?utf-8?B?bmRDeWZGUC9CazhYekZMOVRrS3VuWjlxbGo1WnUwSzlEWWYvNWwyVFJJWFo1?=
 =?utf-8?B?UDFnSGNrV0lnYit5TC9zRjRrRUpaZE80ZjZDMThEYm52TXJHaFdhSmdNcG1F?=
 =?utf-8?B?WlBKWFozaDhnbW5xc3haTGJXcVFlVjA2dFg5S2lqNHRGanZRU1hPWjVWVTl0?=
 =?utf-8?B?aEJXT21BbkU2RmZBWHZOQllYY1VsSUV2KytBTWpBcFRWd0pkNEFQd051Rk8y?=
 =?utf-8?B?SGdKcWJFbVdXWi9mL2hJbGpRSlFOeWRDSjZ1UW5yU1RESkhjUmFKbFozSGZJ?=
 =?utf-8?B?N0tSMUJDSC84bDJlVWdjbmljZXVYRnh5bFovMXhibDF3bkphRmd3QlFqRWkz?=
 =?utf-8?B?MU03TEZrZUE1eWlvVWtLTmE0dzU1b0N6ZzV0NHhHM2kxeEd6ajBNQTR1VFNn?=
 =?utf-8?B?OW5oRUZEVGtyN21OWFdlcVpnYmZiTG5nMmNXM0prR2VFYlJuZE1XNzJxTG8y?=
 =?utf-8?B?ZjB2OUxzYklWMFZJcXhPODkvTE42VDgxcFFCWHdoRDZkd3d3OHVidFk2Q0JP?=
 =?utf-8?B?ZzB3Mlp5elFhang5Rm80RjRMVEFyeGp0RTJxNmVlNlRpRHlLQ3ZNUVZuYjBH?=
 =?utf-8?B?KzZ6RExFR2VzWkhKMERUL094VFJGYXN3aVRPNHVzMWNVRTdDK0lwZUhCdmVv?=
 =?utf-8?B?TjZmeFc4TlRZUHdZUXVsT1dFMEhzS1dKS3VGeVJERjFaSWQ1U3lKTlcyUmRi?=
 =?utf-8?B?UlE3eGhMQnBuNXFVaGMxektBUktqN1lmYk9IS0xuUC9ST3R0TzYwdDFsaGZp?=
 =?utf-8?B?M1czWldDZ001N1hoWi9CMHlSODRrKzhweDZTc3dzRzQvTi9hbFV1N0JlODJp?=
 =?utf-8?B?ZUpWVHdOT2sreGpGVTl2ZTR0bG1Bdmh2Um5oOHh6Z3JraER0UkdXL1FmR2JE?=
 =?utf-8?B?alhaVm4yZzRkYzNUb0VPbkk5S09YZUlhcUFoZktiU0RmL3ZUbzd6aUpwY3Fv?=
 =?utf-8?B?WFZlNzBEa05SM3JsMTQrT1o4ZDdSZWV2Z0FLcDlibGk3Unc4VDlwanM4bWlB?=
 =?utf-8?B?WkxWSGJKeFdVVmJTQndFb0JjeHVpRjd0bU9WTk5BajZ4Y0pyZEdraElGZDgx?=
 =?utf-8?B?dFpDTlZnNXBMMVdrYWU1Tnd0bjk5VVpNWUpGdmhHTjQyT3YyZEl5VU1SRFRG?=
 =?utf-8?B?bmpoczI0d3pKNk5GTi8vSjYwOUJOTGNhdU5lbVRHK3dYSjMvRlZhalB1NTg0?=
 =?utf-8?Q?fa4N4fz6p3BIxuvKk/J8ISDfA?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcd37e9-adde-4ee4-c973-08dc831b9ea9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:42.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIoMiL/f2wpc1U1MWmhwHa7+eW8zuoyltW/3GDXDS+aA59PY83RZGzwmUHV8HTwI8SWdMKrZvjPsIu+McL/p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
reference boards.

The SoM has been designed as a pin-compatible replacement for the older
Armada 388 based SoM. Therefore it supports the same boards and a
similar feature set.

Most notable upgrades:
- 4x Cortex-A72
- 10Gbps SFP
- Both eMMC and SD supported at the same time

The developer first supporting this product at SolidRun decided to use
different filenames for the DTBs: Armada 388 uses the full
"clearfog" string while cn9130 uses the abbreviation "cf".
This name is already hard-coded in pre-installed vendor u-boot and can
not be changed easily.

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/Makefile           |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts | 178 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts  | 375 +++++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi     | 197 +++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 160 +++++++++++
 5 files changed, 912 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 99b8cb3c49e1..019f2251d696 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -28,3 +28,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
new file mode 100644
index 000000000000..788a5c302b17
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Base";
+	compatible = "solidrun,cn9130-clearfog-base",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio1 31 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	phy = <&phy1>;
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (yellow)
+	 * - LED[2]: high impedance (floating)
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_gpio1 {
+	sim-select-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sim-select";
+	};
+};
+
+&cp0_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link/activity: On/blink (green)
+		 * - LED[1]: link is 100/1000Mbps: On (yellow)
+		 * - LED[2]: high impedance (floating)
+		 *
+		 * Configure LEDs electrical polarity
+		 * - on-state: low
+		 * - off-state: high (not hi-z, to avoid residual glow)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a61>,
+				   <3 17 0x003f 0x000a>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&sim_select_pins>;
+	pintrl-names = "default";
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp31";
+		marvell,function = "gpio";
+	};
+
+	sim_select_pins: cp0-sim-select-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+};
+
+/*
+ * SRDS #4 - USB 3.0 host on M.2 connector
+ * USB-2.0 Host on Type-A connector
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
new file mode 100644
index 000000000000..a27fe0042867
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Pro.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Pro";
+	compatible = "solidrun,cn9130-clearfog-pro",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+};
+
+/* SRDS #3 - SGMII 1GE to L2 switch */
+&cp0_eth1 {
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour similar to switch ports:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (red)
+	 * - LED[2]: high impedance (floating)
+	 *
+	 * Switch port defaults:
+	 * - LED0: link/activity: On/blink (green)
+	 * - LED1: link is 1000Mbps: On (red)
+	 *
+	 * Identical configuration is impossible with hardware offload.
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			label = "LED2";
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			label = "LED1";
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+		pinctrl-0 = <&dsa_clk_pins &dsa_pins>;
+		pinctrl-names = "default";
+		reset-gpios = <&cp0_gpio1 27 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "lan5";
+				phy = <&switch0phy0>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED12";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED11";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan4";
+				phy = <&switch0phy1>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED10";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED9";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan3";
+				phy = <&switch0phy2>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED8";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED7";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy = <&switch0phy3>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED6";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED5";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan1";
+				phy = <&switch0phy4>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED4";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED3";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth1>;
+				phy-mode = "sgmii";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				label = "lan6";
+				phy-mode = "rgmii";
+
+				/*
+				 * Because of mdio address conflict the
+				 * external phy is not readable.
+				 * Force a fixed link instead.
+				 */
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			switch0phy1: ethernet-phy@1 {
+				reg = <0x1>;
+				/*
+				 * Indirectly configure default behaviour
+				 * for port lan6 leds behind external phy.
+				 * Internal PHYs are not using page 3,
+				 * therefore writing to it is safe.
+				 */
+				marvell,reg-init = <3 16 0xf000 0x0a61>;
+			};
+
+			switch0phy2: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			switch0phy3: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			switch0phy4: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+		};
+
+		/*
+		 * There is an external phy on the switch mdio bus.
+		 * Because its mdio address collides with internal phys,
+		 * it is not readable.
+		 *
+		 * mdio-external {
+		 *	compatible = "marvell,mv88e6xxx-mdio-external";
+		 *	#address-cells = <1>;
+		 *	#size-cells = <0>;
+		 *
+		 *	ethernet-phy@1 {
+		 *		reg = <0x1>;
+		 *	};
+		 * };
+		 */
+	};
+};
+
+/* SRDS #4 - miniPCIe (CON2) */
+&cp0_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy4 1>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	dsa_clk_pins: cp0-dsa-clk-pins {
+		marvell,pins = "mpp40";
+		marvell,function = "synce1";
+	};
+
+	dsa_pins: cp0-dsa-pins {
+		marvell,pins = "mpp27", "mpp29";
+		marvell,function = "gpio";
+	};
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp32";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 on mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+};
+
+/* USB-2.0 Host on Type-A connector */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	/* CON2 */
+	pcie1-0-clkreq-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "pcie1.0-clkreq";
+	};
+
+	/* CON2 */
+	pcie1-0-w-disable-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie1.0-w-disable";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
new file mode 100644
index 000000000000..ad0ab34b6602
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for common base of SolidRun CN9130 Clearfog Base and Pro.
+ *
+ */
+
+/ {
+	aliases {
+		/* label nics same order as armada 388 clearfog */
+		ethernet0 = &cp0_eth2;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth0;
+		i2c1 = &cp0_i2c1;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	reg_usb3_vbus0: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&expander0 6 GPIO_ACTIVE_LOW>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&expander0 12 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&expander0 15 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&expander0 13 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phys = <&cp0_comphy2 0>;
+	phy-mode = "10gbase-r";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	expander0: gpio-expander@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&expander0_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		/* CON3 */
+		pcie2-0-clkreq-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie2.0-clkreq";
+		};
+
+		/* CON3 */
+		pcie2-0-w-disable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie2.0-w-disable";
+		};
+
+		usb3-ilimit-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+
+		m2-devslp-hog {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+	};
+
+	/* The MCP3021 supports standard and fast modes */
+	adc@4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP, M.2, mikrobus, and miniPCIe
+	 * SFP limits this to 100kHz, and requires an AT24C01A/02/04 with
+	 *  address pins tied low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C bus being present.
+	 * PCIe uses ARP to assign addresses, or 0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* SRDS #5 - miniPCIe (CON3) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	mikro_spi_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+
+	mikro_uart_pins: cp0-uart-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "uart1";
+	};
+
+	expander0_pins: cp0-expander0-pins {
+		marvell,pins = "mpp4";
+		marvell,function = "gpio";
+	};
+};
+
+/* SRDS #0 - SATA on M.2 connector */
+&cp0_sata0 {
+	phys = <&cp0_comphy0 1>;
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* CS1 for mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &mikro_spi_pins>;
+};
+
+/*
+ * SRDS #1 - USB-3.0 Host on Type-A connector
+ * USB-2.0 Host on mPCI-e connector (CON3)
+ */
+&cp0_usb3_0 {
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "comphy", "utmi";
+	vbus-supply = <&reg_usb3_vbus0>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&cp0_uart0 {
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
new file mode 100644
index 000000000000..4676e3488f54
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "SolidRun CN9130 SoM";
+	compatible = "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+		i2c0 = &cp0_i2c0;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* requires assembly of R9307 */
+	vhv: regulator-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* for assembly with phy */
+&cp0_eth2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth2_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth2_phy>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	som_eeprom: eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_mdio {
+	pinctrl-0 = <&cp0_mdio_pins>;
+	status = "okay";
+
+	/* assembly option */
+	cp0_eth2_phy: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+	/* max speed limited by a mux */
+	spi-max-frequency = <1800000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_eth2_pins: cp0-ge2-rgmii-pins {
+			marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47",
+				       "mpp48", "mpp49", "mpp50", "mpp51",
+				       "mpp52", "mpp53", "mpp54", "mpp55";
+			/* docs call it "ge2", but cp110-pinctrl "ge1" */
+			marvell,function = "ge1";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_reg_vhv_pins: cp0-reg-vhv-pins {
+			marvell,pins = "mpp41";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3



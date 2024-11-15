Return-Path: <linux-iio+bounces-12331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB29CF609
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BE01F23BB5
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E8C1EBFE0;
	Fri, 15 Nov 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfQfdSfc"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887118BBB4;
	Fri, 15 Nov 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702262; cv=fail; b=KcVlbio9apwnH7vMrcf2PG4KH6j3j2NLYmjbAbfGoZ1Q1H4RHYE68bPWVCt6n69Qi/5Rm022xqRW8AU3+5SyWICvaE+BU5BdyPlB9TLmLuD8A6GEBOis63WkySlX2bScrbr5sUGva4uCyICwngM2dvDlPTxmiSnuOcmk/Zrp4WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702262; c=relaxed/simple;
	bh=dWZ2LxpGCejn7c/P8olivV4ofvefDyRm28MtFAcrRco=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C0FkGZf/jhdMyadA2way7dK00EQ/DdM1Ioc9KN6LkOpPw+e1tAiPba1nFjCuIxEZI4nACe2F+aiCvBjady0e/C8QwI6xbyKqrCeyMp9cSIRJ05rC3t3epovaUmDAvhpuESNN96mqXOgF+ZtEGBBBLBVQKPdCof8ehYUkSEgoPQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfQfdSfc; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbE3srivitwwapt+IRVhtX++aqwuLlngHnYAej7Uagxe2mXiNyM6pIn1Apr5jLy0estH+TC7IIZerQ70mByBM0ZEch/Mj8ccAFTUPu4MDeUaN+D1WMMQm+c5B0MzzBrdIVO5utYOTiUcDiCLQiSMq+7bNr7e4HeyVSEbmoBCVSMKw9mhRsjdkDF8gx3+tXh3M9OfGo1NtqmJp7Tp2NPqdpxXUGsHvl7HHbxDhsPPA7YWa9G2yHHL59wrpE9gf4mUwTkQvtWoXj0MWXRehxN+UOobDt02vnfIuV3VChx5jN3Wog7IhSj0yBTirh1rvQdWLguZN5azoV1VgX3pITDcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCJIUH8zMf3xLGPEULpQRNV/dw58yprK5fJpFjAJH6w=;
 b=XnOaaxzz1ARl5tUZk3pIDlaaDV+Pzp/EfGIy9HY5b+F4LcZfqPkxCWAKXAOy7bf3seZsGZ0A+L46VsbiuDVXZk7ggWK8hqDkMehc730oMmupvMnZY9D2HBfHjFHIoW4X5s+grjwa+EIIbag88/bN3LYcPvACVE7N9JCP+Bi34yxRUi7FLXnb2WvSQgGQOz9/qumTjeH3h+dWUXMilBOFvv78VzhaPzUe/uOElq9a/NmuZ7mNoKHuMTJ4xM+9mPhnfpZvtgeBmE+/bfkxftDtjW/TpbKzMbvRI0+MsRFVFikO+mVmRvsZY7MUcDQIqLAVNdxhe5FQF+3BexZYqugtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCJIUH8zMf3xLGPEULpQRNV/dw58yprK5fJpFjAJH6w=;
 b=mfQfdSfcEadSvGRcI4ihdiELDv6zGfaqFO7Tc2XoXBY9u7u4fLQs6oNmwnsEYHKbUIKRJlNJzX2QyiulOshvgQXKBmjiARjcECTYFicSnc3/6gEq5vk0LUfehb1RMBXc0uy3AmfYzgbOjWID5+o6oBN4f581yTQXkDVEOYy0UiSdAfhkRqoZt4/CEYyO3roAZvHEr7oGH1M6zU/sjxWVnp+6SIkSHI2FSJ4BK1OmvkaPnGAQStW7h5l9AseC4jUrZB9Ohl0PCsDJRGeBt+pNKJi/tuYOlclAvNw34UmG1qZE51Q1FJSqACirEeAocht+CbamOwBPS7nYPQJNPPKBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 20:24:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 20:24:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 15:23:57 -0500
Subject: [PATCH v2 1/4] dt-bindings: iio: accel: fxls8962af: add compatible
 string 'nxp,fxls8967af'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-fxls-v2-1-95f3df9228ed@nxp.com>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
In-Reply-To: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731702250; l=1303;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JW3+njpvrL42G9LXX72s67pLFuCJdYTJeGkvV9T3+as=;
 b=2H49ktKbP45TRHA8eQmZQXOBwkVJnk4Pzf4tiOzX1ef13hkoHyJjqu1AkCcYjAvGlLmBa3NDY
 gLwd/SxgCQyDRsibPJv08ODkBV4tIl72STuHdfldGQY+OvH4zlhF0J6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8527d164-6605-4715-5f39-08dd05b37ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJmaFIwc25Pc1VWa0IzUVc1SkVuMW9JazdwaG5LZWNwemlqS2ZTKy8vcU1G?=
 =?utf-8?B?V29XWFpvcDM5N3FYOWxaZHAySzNMRC83YVhxOGY5c1d1Qktrb2ozOUdkY2Rw?=
 =?utf-8?B?TW5OL05Ya3dvRjg0VmlhUXlYQWlSR2JGbEp3YUhIaGJZN25BcGY0UUhuS29m?=
 =?utf-8?B?ZE5BNzRCQzBIbkkrNWVOSW5YejB0NFhJTnNNZ0lvRXhzVDNxNERXbnpra1Vw?=
 =?utf-8?B?T21GVi9jNmE4S1hhcVBPbm5BbFFDbmNjVTFRN01ocmtLL2Vibks3VHplQ1Q2?=
 =?utf-8?B?eDZVVXpvL3JhdituN0ZZUUY3MkRGeEhiWmwzT3RiTUxJanM2MEh0dVNYalFp?=
 =?utf-8?B?bEZ3N3BkTTNxNFRPN0p3aWlNMDl5ZXY4YWxvQmVEV2J3a1Z6dEdJK294T0c1?=
 =?utf-8?B?bjZva1M3WU1QeGpSTDNWMmdpQ0ZhSHB4V0lwaWFWTFJLUS9YeFk5V1RSZTlM?=
 =?utf-8?B?bElTYnJPODQ4K2VKSzFMaitMcTJ5NWhhOUZzdEJUMU9wWlJWV3NjK1pNZG91?=
 =?utf-8?B?L0t6WGtwZHUvNWFrTEIyaGJmVHVURmc2ZlA1Y1VwZUxhQzhzSVlydjBxQkox?=
 =?utf-8?B?MzAvZ3I4MzE3V2FPMy9iSFBZaGlRTU9hNExNZ0VPVU16WTJldE16YUUyQzVS?=
 =?utf-8?B?ek1mZVFJT3hmdFh6NHR5SWk1bEVtYnJ1M3cwQW1xOW9LUFU3MHphVkxUUWFj?=
 =?utf-8?B?dzhYdEJvMnJrRzQ3TC80dGpKZzU3UDIybkprSzl3bFdseXlhVW5zdG5ZUXBM?=
 =?utf-8?B?OVZ4OUtvSkwvY0NWOUJKT3NHR2JNMnJxRzJsaTVpbGR4Sm9Qb09DYWVPbHVT?=
 =?utf-8?B?NFlnQTV1MHF2Smg2T2dRRXZPRnZjVXR2ejFZN3lOc3BqaXpiN0VlZXYrS1Zh?=
 =?utf-8?B?MzFpQXQzWGo1aG9nNktwUEJNUFlNK1lwVnFWZDE2OVM3bHBDUUZtQ3RiRk5y?=
 =?utf-8?B?Z3FxZUtYeTBBZk44cTdrMXg3eG12QzFyTmlaVGhwRkZJR3lGWWxMZTZDMW5J?=
 =?utf-8?B?UURrUU9rYi8zamJOTERwOWFOaUl5Wmc2ZXJadi9DZmd3TThhSnFrU1VrSlRH?=
 =?utf-8?B?L0d0NVhGNWR0THhXK3FtNFZBVjZNSzB6WTN4SFNMakNtUmFSSllkWVVIcjJo?=
 =?utf-8?B?ZGpmRVcrV0xNdUFLWXBySDNqN2M5V1lhUElhTzl4RG9ZcUtMeDllVkJhV0FE?=
 =?utf-8?B?Q3VQcFJMWEkwWll0QnpyOUtCNDBsWUdmai80T3NTVCtiNXl5RjlyeERXcHFE?=
 =?utf-8?B?cUF1OC80ZVJTdmV4MkxNSnovanBqUi9pUEpWb2hISGVPQTFJbjJVM3VyVi9x?=
 =?utf-8?B?UEd5YWx3TTdXRWd1YmV4MU9nSkthOHY0VW5BNUJsVGcrS0NYV1hFazdsdDg2?=
 =?utf-8?B?aG13enU5OFZKT3c1SUdmbkNHUjArTXZ5RkxpTEVFaHk5WldacDhBUDdKRVJN?=
 =?utf-8?B?NXFNSFhKRlY1OXRNY09QQVNRdVFleG1mQjdxK1kyTGhYaWY2ZDdrekVMSXkr?=
 =?utf-8?B?WExhRlErbklZY2c0dEd5dXFJNjhqOW5YeC9LQ2JjN21jK3kwU1JpRkdrMDc5?=
 =?utf-8?B?TnBsd0lLdXlQZjNjdGpVKy9ZSHUxK3RWVTRNaFBoQ1B1NkhuaW9Ya1IxM1Fq?=
 =?utf-8?B?bllsVmlpVGg3SmsxaGtLYSthdEQxQWNrV3pRL0xsUkJtUHUwZkdvVGlwc0o0?=
 =?utf-8?B?MVBlWk0rR1Y2WGhMeG9TSE41YnNTUGNUaGc1dVpnbXJzM0QrbDFxQ0NKMGQ0?=
 =?utf-8?B?aVREYjBFVXVSUTg0QWdDSFloZi9ac0xJaTR1Zms0bVI2NnJiSGFScEhwbXZa?=
 =?utf-8?B?TGhBNUk2ZW5tWUNOdXdpeXNTaXFFVTgya3Z1MU5zRk5mK1ByUGh6eUNOSWhT?=
 =?utf-8?Q?pxf3hnnyVzLXG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXRmbkVXU2VYdWJoYjFtZ0Y3dlJZcnA2OGt5Y3RuUnFpRG0rNEMxbGpvNFRo?=
 =?utf-8?B?aUdEY1JXV2VQaWJWT2VSYTgvU2dWUitVeitpVTl2S2lNQitWRGtjR2crNjZi?=
 =?utf-8?B?aFRVMFJDUk4vd1FPczgyVUJHeWZDQ0k3Nk44ZmRFZnlYTS9pVWN5SS9ZZHBK?=
 =?utf-8?B?L053LzhvczJJSmFIbkNjYW81cjB3dGlJL1FBOEV0cXYvczIwU212WnZDUm1r?=
 =?utf-8?B?SmZxdE9BYmVTWWVwRUFFczR6V1JUREZlK3g2d3VNOUdCWTNyZDVNSVFxYUw5?=
 =?utf-8?B?TlM1VS9tQzY1NFpvNkJaaVdNT0xPS2FvSjVmb3FVckVDM1BLY09yL2R0M1FB?=
 =?utf-8?B?NU5YT2ZwaEVvUVoyUnZYRElvdjkxK1ZESTFRWTdKYm1FTHhXMTlvTHN6eCty?=
 =?utf-8?B?NVkxTitCZmtUVUxuYmxxekRmYi9CUUJNQm1pVjRDY0syL2dyM3hzN2c5WDdT?=
 =?utf-8?B?bUEwZW5GaFVmUnV6UnZUZ2szWVo3Y1k0M2w5OGJPVHhXSC9hSkFJVmxQN09K?=
 =?utf-8?B?WDVEUUNMQ3hRNS9nQ2JxVGozZjNIbFhvM3EzZmRDOXhwQ2JkOVk0WVJ3d01q?=
 =?utf-8?B?c0JYZ0tIcTZPK1ZZbHZuTmVVQndKZzBvM3A4U2lKNWI3ZTV0ZE1oVVY5MUlN?=
 =?utf-8?B?Zi9Ec1E1a0hHdnk4ZTZKZlEyUU5tcERMZlVzUkRrRTNWRkwrNjl0b0pjNDdU?=
 =?utf-8?B?Yi9oTXFTTXhVdHYxRFpkbVBtNDdnanhOZkZXUWgvemRzcnNoNkt1eDZPWVhh?=
 =?utf-8?B?V1FyVlRGRWprSDZ6Y0hUZG5ucDlpQ3FxaEE2ejJIYVA4Q3BKNTBNdENWT1Er?=
 =?utf-8?B?VS9aaDhCUjlOUy9MNXNCd1hpOE1adTVBTWJEUjNubHIxaFY2VldDUFUzTXFt?=
 =?utf-8?B?Uk9oeTFNVDRLY1J1cld2bXhFeXkxeS9tQnltaEtDZHE4a0hjMitGYWJOMlph?=
 =?utf-8?B?cWtKTmFzdktpVUF1bVluemRxNW94bW5JdVdoY2tPNCt0U0xCTzRQTE56Yldo?=
 =?utf-8?B?cDRSZ3c0cytKRTR6d3JZb0hJV2tiRHZFMDRFNmJJZGxreTJaS1QrRFNMZjhk?=
 =?utf-8?B?SktmcW1BYVlDYzNxNXNDYWlSN0Q4NkFCNTlOb3RQbyttYjgwN3lCbnJuejNx?=
 =?utf-8?B?aGkzOTJFeDQwMm84VmNhcWoyb3JNcElYdEp0VDQyeC9yL20zdkg0TzUwR3Zm?=
 =?utf-8?B?UU02RHFFc2M3bWl3c3hrZVNwU2REQ0VOZVpkaG5xbU51SVNlT3g2bXNRZEcr?=
 =?utf-8?B?NVdwS2pmblV5QVU0cjVqRTVaMmx4WUpEdzdCYldhVGZOQ1RONnQxMEVQK3g2?=
 =?utf-8?B?SjVNN1ZTNC96R0VWQi9KSTFkK3VRMHN6RDdkcnU2TWo5VENLTmtIZkZHTnRY?=
 =?utf-8?B?bkVuaUdDTGJDbHpqK3N4ZzgzN1VzRXRYMEthS2tWd2xoS1Vma1pTSWdadEhD?=
 =?utf-8?B?b2hNMGhjc29oUmxubWV6bytnZGR4aXh0dWwyVmx6V1gzTlpidXVGZ2YzdDFt?=
 =?utf-8?B?SDVFUmFCWlUvOUtGM1VUMVZzbnBja3dIdWxRTlRFZWFVSGhPbWE0emkyWmRT?=
 =?utf-8?B?cGVkUU9sUkZtYkJweGU1bVZuQllvSGdxOEhmMUdWMXRVRDdkQlFkeTA4U1RL?=
 =?utf-8?B?aWFJR3lWRzJBV242dTJZNEZoNWtOanRQeTNqYVRxUzcxMHRUYkR3MTJ4bkQ3?=
 =?utf-8?B?RVhjc3dqY0RRWlAwNDd4MjBwMkpPb2I3bVJVVUhNOWRmYWhRZEs0aEdnZmVS?=
 =?utf-8?B?aXBwTHByRHkvMlhVbmdsSitjZHZ0TitSRXUrcGhLaVhqSkc3MG03UFRIZ2U1?=
 =?utf-8?B?SU9acitTb2ZBRFR0UFZNUFFTcVVwWHhMQU1tU25LRnFJTlpFY0h3dURSWnRY?=
 =?utf-8?B?Z0hYYUt3SWRPZCtpZlRBUnB3clIrZzR0NXJ6V1hpY0pSdk5OOXRMMWlYYkVH?=
 =?utf-8?B?QTgzcExJcVh5Z0FjcytMYlF5TnVKZUEveWJxcFpHaWhzZjI1emhMMi9iUkRX?=
 =?utf-8?B?emJxYzRKQWd2UkRaa3lpeWJrNGJUTlVZS3piZ3pSWmdEeUdzUkhlcEdMVHIv?=
 =?utf-8?B?OXJJam1aeTV0ZUFHb2pMMkZhYzluQU5JdGw4UDBCYTQvZHMrWFhGM2oxSEtR?=
 =?utf-8?Q?pkEDGkgbDmMwYRVAKLRkKWgnq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8527d164-6605-4715-5f39-08dd05b37ab4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:24:17.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZq6Mel6kNXjORmVZ8tgqWm9mPxoAZqZd+ksVwrJ7KMwMXSXeicAFZ6+/ryyWyLEUAM3Ks3sRwYTVsbCfxGAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231

From: Han Xu <han.xu@nxp.com>

Add 'nxp,fxls8967af' compatible for the FXLS8967AF sensor, falling back to
'nxp,fxls8962af' as the only difference is the ID.

Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 783c7ddfcd90a..a5c882bd7d06e 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -14,12 +14,18 @@ description: |
   SPI and I2C interface.
     https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
     https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
 
 properties:
   compatible:
-    enum:
-      - nxp,fxls8962af
-      - nxp,fxls8964af
+    oneOf:
+      - enum:
+          - nxp,fxls8962af
+          - nxp,fxls8964af
+      - items:
+          - enum:
+              - nxp,fxls8967af
+          - const: nxp,fxls8962af
 
   reg:
     maxItems: 1

-- 
2.34.1



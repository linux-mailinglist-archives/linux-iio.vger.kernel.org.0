Return-Path: <linux-iio+bounces-5644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D78D76F5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8550C1C218C0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8477116;
	Sun,  2 Jun 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="JCYIvYzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2131.outbound.protection.outlook.com [40.107.7.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253C6F06A;
	Sun,  2 Jun 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343394; cv=fail; b=cd60V8r2XfVzrbtBjHIUhz8XrBlldwS2hi5+Kxvm+k99uICqk+ra90j28A/CNeScpFtBId7x97J+tfG4E0btVPyuk30Ljaz7+S9roa8F/gczzKTlM6HubNX0s4M6lDX+7/QF8YZbIF0ZuJmdZKb++DxAgfL5Tnmx80uoZAlvMOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343394; c=relaxed/simple;
	bh=TjqY5poStO6rZ9XUcYuW1uk2taLdDumd2hFUIavQPV4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WJzxblFulUVFCFORRfpoAdrjmCThdHgMHZLfDA7pu/3HJ/dpexP/546RlToi5D1PzSy5x8JFrH+hmGpWHGfKYYG73Zt/MMce+tCLNsaGV9DKHg2lvNQD1VuXwu8ViX11p0m1RCKn/GNEuiPHeSpUAfviq/MUlLDVAMzxVFUk9Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=JCYIvYzP; arc=fail smtp.client-ip=40.107.7.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt3CXMycI3f5NN6ZK8lY5E6joZVhVH32CZzREpL+14KYbGz4S0OjiQ1PGwFCIZhp+83zhcHARBZSSj88k3mUedEXO24iGFkc/MlKBnGRO0byBwPzN+QgJsUV5NAvZKs2ORxrK/mc3UP0YTWdyrs0atNoHjBXcQi2JzaVXicZlpk3mH1f5rDFVWjADTC+yWXei5hDW0S8SCpb0yySzGkdl2ZKI1ICzCAgg/OvPyQKbj+Y2EYW/WVbW5rHJ1chXtUr2Fyln/BZV93DF5dkrjpmW2n51pzuqC9QBzTUN23VspF1DOrS8k5cJjKo6jnLBfZd4/JjAHlMZAs25SbrGEefSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5UHay0sun3GYifzFmxig3whsD1MbfqU+nn+/IfF07g=;
 b=BM8X4qpCixfTZIKClXk6rLJJRHTRcSVmHob6+G0QsefCHLb6rHSxom2QPagtHyfuO6uFITji164EkhhruVKVgJS7aM0E2TLL35rYBRt34mgMdg574bBso61NEtPIXGZt3Ym6Zayyh3pq0awvD6cVI9T5oZ2SsZcJ1917t2dB7KPdskEYPllrfxlbbqirpl/oUZlaMmZf/oPt9vm7RcGwAYu5RPtAQMixMbQ9I5SWX5nJSxpGDWScyxIRZhpxZb/zNFfYxvtYacmtKDPfH6mpU/yDeIu15APFBbS3HtnlfgiJaanleRh0bmfFzB2UmfmwGrEECN12XbROKGcdkBACYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5UHay0sun3GYifzFmxig3whsD1MbfqU+nn+/IfF07g=;
 b=JCYIvYzP9XQl/8z1gPK3CJ81jFtYhq8SlJgjZzerXAiPDXq58Mi/1548h2OpQ/qjgscT4X5s++EeG/XzmcelTSm0Dc4/ek9pSIaxPCbwdJuIYzjeMrBY5vUgnNiJgyBHPEB9kgaZysee5EjqpGVzltPtuw+4js5rPNggLfG1jsI=
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
Date: Sun, 02 Jun 2024 17:49:41 +0200
Subject: [PATCH v6 6/7] arm64: dts: add description for solidrun cn9131
 solidwan board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-6-89393e86d4c7@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc27dcb6-9a9b-4f35-c905-08dc831b9f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?disvSEFCSlcvTU83Y3owcTR2RnVyOXJ6ZnFUNDZTUjYwOHh2YXN2YkIzY3hK?=
 =?utf-8?B?ejIyMDdTYkpOK1dMd1ZhYThOTEd0cEJaalcyTUJZR1NuRC9sUjNXTWF5M2ht?=
 =?utf-8?B?ZkhDWHovTitqbCsxNU9hUDRjbXFlQUh6UE05QjhIUEh4N1dJTDNSQVE5NVRq?=
 =?utf-8?B?LzRqemg0RXVuNCtDUFZpOE56TGpiVFFMV0VsYWdSK2xBbG1ZZklRWVFHRUgw?=
 =?utf-8?B?NERlU3Q4Z1NsdkgyMzE3WWYvVTJiQXFZdThZSU5IYkR3c2FFZHp6enNYL3g5?=
 =?utf-8?B?Tk14YmNUOXJPdDhGRE9FbDFya1BWRzVHS0MyQmZ6Zy9JSVd1S21LcGZZNDY1?=
 =?utf-8?B?ejB4VXBIWGtSVmNHcVBxWVlsNll6Q2lOR085TWtIMllKQjVQdklBcE82RDZr?=
 =?utf-8?B?SlUwVHExWnZ3TnZTY2tOa1lsbC9HTDAvZ2JrbVRYeWNIWVlxR3lzWGY4TlRW?=
 =?utf-8?B?TDFadjRhNXMzQmZCU0ZFRkQ3cy93c0c4Z08yUmdBU3RFZGRCRmhLcTdCTTdI?=
 =?utf-8?B?QWpwbVo2dFR5QW9VM2VrTzdiUityWHBWdDFiUTgyZWlEby9VdVUxV0NWKzlw?=
 =?utf-8?B?bE5CRStqcXc1VXJvQU02REtGZ3dzS2pyallWdFFXZFVEajNnNnhEWlNvdE91?=
 =?utf-8?B?WEorT2xXbmxyS0t5REs3bHpReEM3Z0FYK3FERi9mMXlrNmJ1SjdyTFhJVERN?=
 =?utf-8?B?NkdnL043Y1U0NE9VWWhjTUZ1Q0N0WVZUUHNqZ0VyN1JKN2k4cENWdmUrV2NZ?=
 =?utf-8?B?UDFOckY0Z2ZXTWpjMWNvQU5ZTlNFcWxjWDR1NkdTTi9xTWdWV2hyUVQ4RHZT?=
 =?utf-8?B?NUFHcDFUaktxQ0tvQk1KVnQrdlQrbFRxRkx6UWVWMERtV09tQjlHbjV3KzVu?=
 =?utf-8?B?a0ZjSHlrVGtZUHV3enNTOWNPSk9ZTFRKYi9neHVKM2dGV1lXMXdxMXB5cW8w?=
 =?utf-8?B?Z2lra0xFbnUyVmkzd2EzUGgzMy9pcHJRTVRLdWJxdFN0cWhaUDRFRG1Qb1A1?=
 =?utf-8?B?ZzVtN3g2R29LLzc2VERpellDNW15YWhwZzBiWU5YUXl1bzlzNnhyUTQvN1VS?=
 =?utf-8?B?UTJSREdLNldVK2dacmhCK0piUVNPM2dmUEN1MmVHcW81NUVsR3R0emsvQStn?=
 =?utf-8?B?QjU5a0JzYVB1SWN6NzgvWGc2dGxSRUovUndSVUh4bngzaE53Rks4L3NrTUta?=
 =?utf-8?B?RXAzY1NhcEhZMENvdnZCSFVqN3pQcjhqeUpLZ2pxUTRlQ2NsRTBoNlFOTWow?=
 =?utf-8?B?bkRtTmgrRWVsZng3WWlRU3lFUlc5T3YwVlArajRvYng2K010L2xMdzE0SEIz?=
 =?utf-8?B?ZFBteFhyUTQwZnFkaW9SQ3VJYzJCUlYwbHFFL2hic1VSS3FncVoxQ3VZcU9T?=
 =?utf-8?B?YUpGbEJNU3pOaDEybVUwa3lHN0k4VzJ3VHRHcTNFN2Z2UjJhZ21oRVErbTk0?=
 =?utf-8?B?dDBFc2pHNFV3Y0FFOVY1azZlYzJjckJGZEpNbUxFa2NDcjVIOW1nbC8zVU9F?=
 =?utf-8?B?alpyS3RVdGw3eVpRQytXUHU4TUlkTmlONW9HcVJPQVRKWWhJRjlxUVJTT0Fk?=
 =?utf-8?B?RVZtaEdETmF2S1Bzc01zSVF3SitGalRWbDQzNitqNlJBaU9GRjZFVElzaU5j?=
 =?utf-8?B?QS96UGRzb05xYk9rOU1mYVBWdTYxUkY0T3l4WWFQYUt4VjYzcXVGTlp1Nno1?=
 =?utf-8?B?M29QZ3ZmMHdYRkptcGdoUUhicWcvUW82dE83YXNRdGFmOXpHdW9SbmlzYytG?=
 =?utf-8?B?Wm5DYXFTVEo2VjBabUd2RUdQS3JuRW1vMUU0UU40Y0JieUxqT1JGbXExZ1hn?=
 =?utf-8?Q?Vjlty7Mss2kF8Y6KdkY4s8jnewsKb7yG/gCHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjViSDB3cmVuaXovRG43T2JCT252dWFscURWbm5qV1JCTm9tdUV6RkFVQWQ1?=
 =?utf-8?B?NEJhNEx0Z1k3WWd5MllhaU5LWEtiZnAxYkxCS282OFZKbXlPcUM5RDBqL0M5?=
 =?utf-8?B?MUFuQWpldFFRNUQvUStHVkd3bFBPRkJJb0tOQWNSeklURE9lcjgwaHRWbWpX?=
 =?utf-8?B?VGFZek1sbmJBeGNWZHk2Nm1WYm1PL2lSV0tXalByWTJxcnQ3UTNUTUtJTFBi?=
 =?utf-8?B?UTJYZHlkSnF5YWxIZ1RMOTVvbjFCRzhjQWdtQUtFUTBuL1ZvL0p6MGUzQldQ?=
 =?utf-8?B?WTJySktPaEsvQzNnd1c2dC8yWEhvYUFJQjByNVFNYWJWTTY1bWZSdUVOVDhS?=
 =?utf-8?B?WW1USFUxeFI1RG9HbXhyK0JReVIzaXJibTA3WDQ4V1RZM3NsZzBXUUF4KzYw?=
 =?utf-8?B?eXVvU0Vra1BGZ0pWbnBKdFd6V3RaaVpvSE5iQytsa1ZwM29GalBOT0xRUmcy?=
 =?utf-8?B?YWNnbENVQkVnb1VkcFEvNllNcXZYSHA3NWlkMUtiZXlKemQ1bVhISDFaMjlW?=
 =?utf-8?B?TTlYV3ZrcFo5WERRdHNTN3p2YnRnbVdYamZQNHJnSDYySjlGZEUzWDVFZWM0?=
 =?utf-8?B?NEtEbFVvNFh1ZUtVU085K0FWQjE3K3d4eU5hK0diL3B2Q05xRk91ejJvZmdr?=
 =?utf-8?B?Yjdxd0NHZjl6OUwyWHZIUm01WjNPQVB5RVM0bFdlbUgrK2ZiNHNqT1dnNVIz?=
 =?utf-8?B?Wmk0ZzdnWHNNN1RQZ0RXQXc5YzZHQ2F1dmRxNFFsWHdlcHNSNnRXVzdBOG83?=
 =?utf-8?B?cVRuQ2RvanNaT3JOZEFMQTlQRGt4czY2czE4S0Qzb1RRU0xqakkwUE1ka2g4?=
 =?utf-8?B?aWdkTG5TekxXRHNQR1NMM0pYNndqSU9KT2FoUnZoMkJSUGpianNjNkM0dExi?=
 =?utf-8?B?eWtLNDYyQmozc3pKN3lLZGR5Zk9vUVA5N3E0YjhGK3dXcjJib3BmRHlINkVS?=
 =?utf-8?B?NHphWXlNS21pb2R1eVZUdFdVOE0xcTBYVTYxaEh3a3dOSlZvMmpGblN0MFQ0?=
 =?utf-8?B?bFRJTGE3RGtOdTRqQi9HQXlycDhuV1dZL0dmZ2QxeVdRdisrZDA2UXMvNmZ4?=
 =?utf-8?B?bXdkRVhKUnA1Wml1dTBPaFZxbUNzTG0yeEJkZHpYZUtBU1hBNGlnM1ZVNkV2?=
 =?utf-8?B?ZVRKUFFPbWNMd3lnaTl6b1VOZDRFdmJKczB0T0NyUTg1MlhGUENQdWtwd29a?=
 =?utf-8?B?T2RhNVg4WWw3OFY0cklWQTdJLzF5ZWdQdk9FUFd1MDBGWVBrVkxRdlZaeVRr?=
 =?utf-8?B?cFo5ZUpEZjZnLzA2M2lML2J4dm1uTmFBMGRoRTFmRUVDWTVPc3o2OUxmbXlq?=
 =?utf-8?B?OE9qcG1zc3dUM2JUeVQ3Tk9NTGhzTVBXaGZEMFZiQWVDRWtmTEtib0F0cm1a?=
 =?utf-8?B?UEFaZGRKYmF1ZnlLQmdmTGx6YVhJMDNWVjN2SmkxdmRJeUFwODVpYWhqR2NG?=
 =?utf-8?B?SkZMaWtYbGdiNmVmUG1nMTh2REZmU2kzNnE0NkxMYUxtdFdwdTRreTlvZkgv?=
 =?utf-8?B?LzZZbmZPK2Y2YjQyQzlDR1pLWDBLdCtuZ1QvZXdhd1hBWDVWNWE4Q05mSkY5?=
 =?utf-8?B?aHRGUFJOMUhmYUhrMmpVRlNNcDRrWnkvbjlwdEordkRBQkpEakhnTHVMdjNP?=
 =?utf-8?B?Nkh0d0hVR3FTdEJ5RmpwRnJSUXRjbDZUc0MzN2gxM3I4aVZxM0tFN2lycDl6?=
 =?utf-8?B?TUtiVStmMGtoWEczcG9mYm5SVnNrRDhJVE9lb002QWdwMmVlSEpyQTBuS09r?=
 =?utf-8?B?dVRZL3JCR1hZY09Zbm9iM2dBMjVxMHFkb3RwZ3RxelZFYjBuS2ZTZnB2Zmxw?=
 =?utf-8?B?eTBQRHdOTW55ZVMvbFk5UEdMWXVxbi9hc1IrR1paZVJQS3MyZXd0am8zbXBG?=
 =?utf-8?B?eXhZVC9MSU9PYmhoWU41cGdwUHp2TzBoWDhIdWgzbEYvaTdZZG9OVm4wcWlT?=
 =?utf-8?B?R0JidFdDWFdub1IxOGFYdWVCQ1VkRVBRc0t2RzRqZFl5ME9WTStBTVhwdEZh?=
 =?utf-8?B?NDluR1I1TlB6cFE1YWZxS1FNYkFnenA4VWZGdWhZYzMwU2lKd0pmdS9JL3R4?=
 =?utf-8?B?NStTR3lSRkF4a0dFVGplUFBQSXhRRXNocUpFdGdacGNNNXNaWGwzeXh2Sm5R?=
 =?utf-8?Q?I+qEbI2LGFR+efDcE7D+rp4of?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc27dcb6-9a9b-4f35-c905-08dc831b9f0a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:43.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+J8dPvWQoUc0cjhfRc7pi3e2dZehByDvm5QF6FSIfUyfsmjST1U9PAvvIAhU3d6FQEbwk5+qt6QxlatZs7bBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
with an extra communication  processor on the carrier board.

This board differentiates itself from CN9130 Clearfog by providing
additional SoC native network interfaces and pci buses:
2x 10Gbps SFP+
4x 1Gbps RJ45
1x miniPCI-E
1x m.2 b-key with sata, usb-2.0 and usb-3.0
1x m.2 m-key with pcie and usb-2.0
1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
1x mpcie with pcie only
2x type-a usb-2.0/3.0

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 637 +++++++++++++++++++++
 2 files changed, 638 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 019f2251d696..16f9d7156d9f 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
new file mode 100644
index 000000000000..b1ea7dcaed17
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -0,0 +1,637 @@
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
+
+/*
+ * Instantiate the external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9131 SolidWAN";
+	compatible = "solidrun,cn9131-solidwan",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp1_eth1;
+		ethernet1 = &cp1_eth2;
+		ethernet2 = &cp0_eth1;
+		ethernet3 = &cp0_eth2;
+		ethernet4 = &cp0_eth0;
+		ethernet5 = &cp1_eth0;
+		gpio0 = &ap_gpio;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &expander0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &cp1_i2c1;
+		mmc0 = &ap_sdhci0;
+		mmc1 = &cp0_sdhci0;
+		rtc0 = &cp0_rtc;
+		rtc1 = &carrier_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
+
+		/* for sfp-1 (J42) */
+		led-sfp1-activity {
+			label = "sfp1:green";
+			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* for sfp-1 (J42) */
+		led-sfp1-link {
+			label = "sfp1:yellow";
+			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-activity {
+			label = "sfp0:green";
+			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-link {
+			label = "sfp0:yellow";
+			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* Type-A port on J53 */
+	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usb_a_vbus1: regulator-usb-a-vbus1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus1_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sfp0: sfp-0 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp0_sfp0_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp1_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp1_i2c1>;
+		los-gpios = <&cp1_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp1_gpio2 18 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp1_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp1_gpio2 17 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp0>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	/* Without mdio phy access rely on sgmii auto-negotiation. */
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #1 - SGMII */
+&cp0_eth2 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp0_phy1>;
+	phys = <&cp0_comphy1 2>;
+};
+
+&cp0_gpio1 {
+	pcie0-0-w-disable-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie0.0-w-disable";
+	};
+
+	/* J34 */
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp0_i2c0 {
+	/* assembly option */
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	expander0: gpio@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+
+		usb-a-vbus0-ilimit-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus0-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus0-enable-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus0-enable";
+		};
+
+		usb-a-vbus1-ilimit-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus1-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus1-enable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus1-enable";
+		};
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+
+	/* usb-hub@60 */
+
+	/* assembly option */
+	carrier_rtc: rtc@68 {
+		compatible = "st,m41t83";
+		reg = <0x68>;
+		pinctrl-0 = <&cp1_rtc_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&cp1_gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp0_mdio {
+	/*
+	 * SoM + Carrier each have a PHY at address 0.
+	 * Remove the SoM phy node, and skip adding the carrier node.
+	 * SGMII Auto-Negotation is enabled by bootloader for
+	 * autonomous operation without mdio control.
+	 */
+	/delete-node/ ethernet-phy@0;
+
+	/* U17016 */
+	cp0_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - miniPCIe */
+&cp0_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #5 - M.2 B-Key (J34) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&cp0_m2_0_shutdown_pins &cp0_mpcie_rfkill_pins>;
+	pinctrl-names = "default";
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_led_pins: cp0-led-pins {
+		marvell,pins = "mpp4", "mpp7";
+		marvell,function = "gpio";
+	};
+
+	cp0_m2_0_shutdown_pins: cp0-m2-0-shutdown-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	cp0_mpcie_rfkill_pins: cp0-mpcie-rfkill-pins {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus0_pins: cp0-reg-usb-a-vbus0-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus1_pins: cp0-reg-usb-a-vbus1-pins {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	cp0_sfp0_pins: cp0-sfp0-pins {
+		marvell,pins = "mpp31", "mpp32", "mpp33", "mpp34";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
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
+	/* add pin for chip-select 1 */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* USB-2.0 Host to USB-Hub */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SRDS #4 - USB-3.0 Host to USB-Hub */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #4 - SFP+ 10GE */
+&cp1_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp1_comphy4 0>;
+	sfp = <&sfp1>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp1_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy0>;
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - SGMII 1GE */
+&cp1_eth2 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+
+	/* J30 */
+	m2-full-card-power-off-hog-0 {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	/* J44 */
+	m2-full-card-power-off-hog-1 {
+		gpio-hog;
+		gpios = <30 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp1_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp1_mdio {
+	pinctrl-0 = <&cp1_mdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cp1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+
+	cp1_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - M.2 (J30) */
+&cp1_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy0 0>;
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+/* SRDS #1 - SATA on M.2 (J44) */
+&cp1_sata0 {
+	phys = <&cp1_comphy1 0>;
+	status = "okay";
+
+	/* only port 0 is available */
+	/delete-node/ sata-port@1;
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+		pinctrl-0 = <&cp1_m2_1_shutdown_pins &cp1_m2_2_shutdown_pins>;
+		pinctrl-names = "default";
+
+		cp1_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp1_led_pins: cp1-led-pins {
+			marvell,pins = "mpp54", "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_1_shutdown_pins: cp1-m2-1-shutdown-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_2_shutdown_pins: cp1-m2-2-shutdown-pins {
+			marvell,pins = "mpp30";
+			marvell,function = "gpio";
+		};
+
+		cp1_mdio_pins: cp1-mdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "ge";
+		};
+
+		cp1_rtc_pins: cp1-rtc-pins {
+			marvell,pins = "mpp12", "mpp13";
+			marvell,function = "gpio";
+		};
+
+		cp1_sfp1_pins: cp1-sfp1-pins {
+			marvell,pins = "mpp33", "mpp34", "mpp49", "mpp50";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/*
+ * SRDS #2 - USB-3.0 Host to M.2 (J44)
+ * USB-2.0 Host to M.2 (J30)
+ */
+&cp1_usb3_0 {
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host to M.2 (J44) */
+&cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};

-- 
2.35.3



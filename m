Return-Path: <linux-iio+bounces-12055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72D9C278C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF481F2286C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EE1F5821;
	Fri,  8 Nov 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGx9f4sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A120DD41;
	Fri,  8 Nov 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104852; cv=fail; b=CRGgZ3YjirnxOnM4/M0SWCbesFTa8omKyWAsrCn84azYCEDG35w6EV4m5os17EwzLHeEr6CLbhkX5FUqgZMvJgRI+zXDw+f4v7lOejp1G/xiBT+t5nmd77oWwguvHgt6iXeddYgZ/YkryUbEXpmOuDTqRaEcroebUive3RXGbsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104852; c=relaxed/simple;
	bh=674fGre16wsgmxYfHmqsN6VLMJ4S2VE2ToXL1V2Wrqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ONO1tbq6mR6SBf40LMDgzbVP4PnoDIc9LwPmFpdp4LJBS4RUnW/Ey5r/XvMq9qRORwLiOIPfs9Fn30ybhN+il3Z1ND0TEygK6bFqw5HVJn2l9GXHEU9kKDlYESW1iprSWqnetUVhLP2C+EQQ5IvNJCxvMdNBXBwA2E52ZeIn68I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGx9f4sw; arc=fail smtp.client-ip=40.107.241.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD7iOAOVPrdluNYn5n/aqvGEQlXCpGnoCJ9+6h6GBFkTt8FL9kzt2LpMPd5inZAUaWI4lQs9QVdCR8mUNHydE2rZwoSCgnXdA0TWqxxBzIpJ1Lb0vvL8gBjo55NeRGEz/JZDTQy049UrssvjdQ0idC9A/0QgG5GUHhbL5AZOwp38sX9Gcet47u+s5Q8sWWiTlPX3ebrFhX5XOQ/Bj5Z/jBhzCVg4739TKfUdA3hP0nuRik9yszmUE/4qLZQxb6OGO01svgOJpSpb9SyKP0P4fQ/VJOxnEmu6UsVM1SJbtHF3nKTNwCJYHRzd1hOFgggcc11qlqIRv3O8Qd/CeVZ9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6awtrZQU6LkJHPear9BLzG6arSog9kzzlZX/iwhrU9E=;
 b=uMAiagOTlLw9GQ6daoLB2aGsRjqFHiytWGsZHzQ5pZ6UBRbg3E2VnBmVFuJirBJor2lsMRp05lY0t9n/pqBAzlLA7eM/ZCMJ9nSdnRLzvtpPvUT/17w/R1pSz4KjNCfDMaPolMJW8zB3CsTBtY1UiFuj9EBHdJvHVUDIXer7aqRSGyfH4iKIvB1jkcQnfkYqIgJ2HAwHH5QQNJkR1kPovrBEJbNotVK6Di0vivyigFGFsWRE0e8Vjyv4QcOWICSiHxx0khI+hiZqJxPq2PiiPBwZ1HcIVXkU52AMkKmne7XH+Gx2J0VxdyKo22cJcqILhkQoZM0a/1NQEuDRSK/omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6awtrZQU6LkJHPear9BLzG6arSog9kzzlZX/iwhrU9E=;
 b=DGx9f4swQ0gvLNuwp2259jYbYKGahDwoS83huv4FWr5bwVFFvWuIKcMw8trqYW9p9pw81/nsZB73Od6LeMFpdKe09iUb7DMnNu1nlA84XIFlBKOqwW99T0mhM03Pr6Ujww5jfHjuHzO1Hi2K8shnivKvffG30L8cxexGlTWE2wm1BYHJmEtRerYgE2LGAaDAX7EHhMOFgSoagaw1LMFWOxgliMRJZvGLVaQ2VPADlp8Fpnb9QAxu4yrE/z/cnv+LUGSmlwc7RNE+ON7EXbfO7SYqOAo1BR//zCeLvEA61PIrJUxx++Q+/2Gg2mU1cUoIidC9FZrXnXhbF8MBQByUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 22:27:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 22:27:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 17:26:58 -0500
Subject: [PATCH v2 4/4] arm64: dts: imx93-9x9-qsb: add temp-sensor
 nxp,p3t1085
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-p3t1085-v2-4-6a8990a59efd@nxp.com>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
In-Reply-To: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731104824; l=721;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=674fGre16wsgmxYfHmqsN6VLMJ4S2VE2ToXL1V2Wrqc=;
 b=Y+MzSe2KSXsAJIxX0HXXU0jym9Aa6G+WVDcAZXVtKepayPEkF5J2m+ptVIxkadHBwS50h5my3
 eg8xwnaVGLtCM2fzYxg31UXY0tODApsqPPf7UFpuqKRgXV+loJdiBrl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 604be78f-1d69-421c-b0ae-08dd004486bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2JHWGlkbkJSRTdDLzYxam9jQ0wrUWd2LzB5TmpUamNWSmtGQk1hZU12aVNU?=
 =?utf-8?B?dENodDZ2elFMSkNtWWJ3Q3QyZzZUSGkyUVhYQ0xLdjBOajVqVnFEZDRrVFVt?=
 =?utf-8?B?R1NSM21sMTF5STNBYTFheStsYXcyUzdqWWZPTWxUaG5nK3hzaVZWVFhHTUJl?=
 =?utf-8?B?WlVXVjJvdWFYMFd1OTIrZnBibGJLNmw5VEU4ZDZDcU83cXFNdkUvd2VGVUtT?=
 =?utf-8?B?THNINGFqMzV6REdPVEtPL3FUc0xYelFQWjA4TnIxT1NJZTBSSVVxQ3o5SmFp?=
 =?utf-8?B?azNSVGJTRmYreVlQaStHeExEVjRRMzdQNGpDRG1jZnlhYkYrS1JhZDZkUFNU?=
 =?utf-8?B?Q2pGcFVMRmRPVHErSytwM054MkJEOEtWZlNhajJocnE5bVJrT1FPbyt0clJt?=
 =?utf-8?B?MExqRmdGa2d6bXJtWFo1M0s3RDJDTi9IaTdGSkMxMmY3c1NjQWgyZlk0NmtN?=
 =?utf-8?B?OFNKbVdCN1JFc2NmWUZNaGpLSUZ1c0kvSnNvNDNveE1CV1hRV2ExYnE3ZjJB?=
 =?utf-8?B?TVZPamxHU1lJRVBuc2ZIZVVza2N6WHpOLzB1VU9JeE1yTEFaemRYMmkrY2Ix?=
 =?utf-8?B?eTluVy94aUJOR1d4cldKdkxjZi9NSGwrdGJyYzA0U3RlZ2VjbHExa24rd3hp?=
 =?utf-8?B?V1JKREloMnFkREVOUzBVT3B1bm5XVENRbWRQWkZRN0tKN280ZXoxbjJiSzRz?=
 =?utf-8?B?YVlYWndiKzQ2b0hTb2tyb2tGY0ZsYWZkekJiZkVta1dwRUxaeC95N2ptVjkw?=
 =?utf-8?B?RFdJK2I2MmQwVys5UklqVWlwc1lOeSt6T2J4djJJVmdoMVU1dnVtb3FNVlVt?=
 =?utf-8?B?UVRFRmthMXB3MUtQTGJweDVHaCt3ZE9jVzFEVGVER2YxM3UvNzFnSTE5TGZr?=
 =?utf-8?B?ekRCS051WGVZeUowbU9QVFY5YjhoZm5URE1VZnN3dlNFWUpYMmxEQ2Q0YzlV?=
 =?utf-8?B?ZXk2YVVsMk1ETXErQUJkblJUdzFkUnhoTEwxdEJDOEJRWDdvbEZqZzl4d1V5?=
 =?utf-8?B?ZHpNNm13U2RvRFFMaTZBQjZSeitLL0tqSE9CVi9Ia25VSTV6dFF0eG8yTTIv?=
 =?utf-8?B?dXR5aDZVdlBXZ2U0NEh3SHpwNEJ2WFhXY29jbThKZTdKVmpKcjF3aW9yNmNI?=
 =?utf-8?B?Mit0V1ZQd0pGbVBNdDhqcUpVZmprbkcvUlRkSWhoYUtEd0hzM0MxY2pNVmlw?=
 =?utf-8?B?M0RVNW1iVG84Qng0RkNVR3I5dVo2V29DQmFqSWhYeXZobmVEZmREYm5Mb25T?=
 =?utf-8?B?c2xtRFR5SjdOV0t5S0pzYTNJSjcvTlg1aTVUbWphWDErNXgrQUtaVFkwVWFt?=
 =?utf-8?B?UjZsVTFyWXJFc0s3OUo1TmF3RlhISTUzRWVJUklmWEt1WXNkMmdDMm1Nd2M1?=
 =?utf-8?B?VDk1WUJ6eE0yYlBFaEVhaWdlQ2JtaUNFdTlBd21qOWV3SVNGZlBzVFZoMXgr?=
 =?utf-8?B?TVNIamhSaDBZTFRZZ1o5d1hVRE9wSVN6QjhNb0ttZmNOc0Y5aVZuWTdRVWhP?=
 =?utf-8?B?VzRvNXk5enh0dlZSN2tISHFLMEJ3Y0lyWlF5aVlWN0JUR2F2RXBwT2dvd3k2?=
 =?utf-8?B?NExEaGsxN0V2RU0vQ01YVlIvTE1iWU85UWZGS1ZyZS9DRmNjVzBuTVllZVg3?=
 =?utf-8?B?OEFwR0NadkVMRkgyanQwVDNlNjIrVTVGTHllZHFONW5NZ0NUdnNDeC9zL2Jw?=
 =?utf-8?B?bk9pNEF4QXl1SkNPSEN2T2Rjc3V0eVRncG9TT1R3UEJNelVRMm0rNWFvUGVv?=
 =?utf-8?B?dEJtaDQwWkVmQmMxOE9WZXJtRFdYamR3SitBelNXdUxnMEVVaHZ6V3VPcVFk?=
 =?utf-8?B?MVFDeUhLK2d4NXpueXRZaEI2UGYxVklEb3h0QUpmQUVTSTNTZ1VtbUk1elNL?=
 =?utf-8?Q?7A+Xs/D9Y8Cu5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01NOVJ6ei8zUjVmRytUbDVDMWRlVDUyNDdnajRVc2FSQWt0WC9LNEdzR1JW?=
 =?utf-8?B?dWRpUkJmcURDSXozZzJOQWdqOVlYelM3MlQycFNyZDR2ZVp3ekRoYVpPR2hy?=
 =?utf-8?B?MVBMbndVWndEM0xyVy9MOVFqaVc1eTc4ejQwc0E2eTJicjZKS3ZtZ3VrRWlS?=
 =?utf-8?B?ZjRvU2JockxXamZ4SnhadHNyRmkrTUNnK29NU05la1hMcHY5UWpsblcyVmVJ?=
 =?utf-8?B?SVdIRk92UDBoeDlOTDFJUTNucVZ0UjBKT0NwNUpFVGI3V3d6UFJ3dklSZTNx?=
 =?utf-8?B?WmNEZklRa2hseEJ6eG1YcEpiejZCQVV5S09pc1IrK2JrZFpMaGhqbXJuMDFj?=
 =?utf-8?B?N0RVSWJmL1NEM1NTOFF2d0lWczJieEx4WmdBamVBM3VNNG1ScHVrSXZGWE4x?=
 =?utf-8?B?cjkwUTBZcXBQS3o1eVZSbm1Td1ZTYzZtamIxdUY0QlZZaklFWE03aWVpYXIz?=
 =?utf-8?B?dCt4TUpMM1V6TWlkbFFhbUNDN2ZNeDhDRk5rWGYzbzRseG92RC9vdzdyYmJE?=
 =?utf-8?B?QlFuNExWR2Y4U1BTTWhSYTVDOXJmY0hTVVJ3TFVlOGtiakJWSUp2dnFwVXZH?=
 =?utf-8?B?NTgyTjhOWnNhV1dBZ2xwQlhkejVMOWZyYXJ5YXBhT3N6ekVTRFY3TTBwUW9K?=
 =?utf-8?B?SU0yS2xTNTU0dmJMdlFZcFlCdWkyeXZueTRCS2Rwa3RhSUdrekdGdnNDcndi?=
 =?utf-8?B?R1JwWVNjaW5Ma1JwdmdzY1V1dkdobkIzK25JU2wvMWRnS0F3VVorN3BLVzVT?=
 =?utf-8?B?L21LRTdTaUk3c0d5NnBLVStLb1ZMelBlb1dKaER1VjJBc0RtUkFSdkFWTFM2?=
 =?utf-8?B?c09JS0hsNElVai9aTkJOa3hzM29KS2J2NmVGYWdaVVBrVGFYeDlRSVZqdUNy?=
 =?utf-8?B?UjdIR1kxWHZVM296TUZjTzV5aUY1Q2pJbkgwMEg4RVNrUEJMWkZtN2Y5VUYw?=
 =?utf-8?B?ZnlqY3g2Mzc5ak1LSXo3RCt1cTRYQktkWGwyUFo3YzFaVU5HYmRyTG1peWFO?=
 =?utf-8?B?QklWY1o1V1FLTW5iVnQyOE1wN1ZxanJ1azZFRUJxcjRnUFk4d2RJQk1JWUFE?=
 =?utf-8?B?S0N4bXlkRnMvalhTTlNxNGhSMUJEQVYxd2VQWXJHL3lLSmw1b1NpSVVjSmtB?=
 =?utf-8?B?U2psNzk0dGxLcUwzVkFxeUNFQ3VNaitJc3FPQzJLdEhienVZY01QbThqK2hn?=
 =?utf-8?B?UDhMaGQ4K1J6dVJuc0xYeFE0TTgxOWJsdTB0a0ZzTk9xOERYaU9TVmxsRTJF?=
 =?utf-8?B?cnk3d0M2eHZISVh4N3dkZ0VLc3BnLzUwUTJjeE1wZ05wM0RDOUV3bmxWTS9h?=
 =?utf-8?B?TXJmZ3JCdzBKYkJHUUhsTkFaaU1oN2NYa2JZNEthS2JldVRCZGJrKzRDWUd5?=
 =?utf-8?B?T2hqVGU3a0hFSkI4Wlp6M1dWdTkvTEh5UHJNWFA5aURPeGcrTmZPOHVBcGpL?=
 =?utf-8?B?SXBOT0lyKzFSdHF4VXJKbEdiNTErMTRILyt0REd1citDUk15bnhucWJWZTVD?=
 =?utf-8?B?ZlpIZFFMdjVCWUVwbGtpQUdxOGFoUi9lUkxYWnpuR0dtdmxhOTFhUTVUTG1o?=
 =?utf-8?B?bXlXNXZ3Q1FBWGNVRW5VcWd0N0xNQ2dreVErVDVob3FEMW5lYlp1dEpxMlBl?=
 =?utf-8?B?TlZaZEMzYlhObGowTi91cEZSamlEZmt1ZWg1RlcxVTRtY0RwVWU2aHY2Z0Vh?=
 =?utf-8?B?MzR0T3BPTWlvMEI5SU9SM2JNS3k1VnRKV2p2NXRTMXhjeEZHZHdWM0hueUkx?=
 =?utf-8?B?R3hHWjFaWFQ0WDVtdk03bUZFS2VTNWdQV1o5M0xZOEF2YVFCMklWL3pnc2N0?=
 =?utf-8?B?M2x3STFsOU9oRzNnZkdoRXArWUFBWHBkOG5QY0Z3OGNpVFFycWxuVlJEODcx?=
 =?utf-8?B?UGU3SmV1YTBKcUNISEZxc2xtYStqRmpTbWZjKzhERkE1YmhlWEQrWng0Tktw?=
 =?utf-8?B?MFRCZFlTeVE4NkRKWUlwTUwwZHZVbStkdmVyUXl0N0daaTNDMTFpQ0V3ZTht?=
 =?utf-8?B?U3NyTzlCdzJaSVgvM3VqQTk3S1Y3UXZuNTRQWmVsM1RYbUF0T0pCVjBFbWlL?=
 =?utf-8?B?aDFBbkdkcHgxV0pPdSswYkk3Wk42WXorckltREhod1RtZlB1UjNwVG9RRFlr?=
 =?utf-8?Q?I596tDk5v7jLvQyhBmwf6hScX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604be78f-1d69-421c-b0ae-08dd004486bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:27:27.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToM9KMlF4JPA4tuFZhqXdjJPZh/Lzfd7jKyfJNONMwMkw2NYPilf/3JxoHm/NwnveOoLEohdUjmkchSe1T+HsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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



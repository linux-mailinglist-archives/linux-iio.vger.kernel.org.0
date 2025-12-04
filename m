Return-Path: <linux-iio+bounces-26719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B2CA217C
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 02:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E083010E5C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBD21FF3B;
	Thu,  4 Dec 2025 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOFpnHyI"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382E21B192;
	Thu,  4 Dec 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764811384; cv=fail; b=SRSEMnyzShRJRaIGI1Qw5IhsR5oCHMPSUhgIObKzMvVz/EJCtJJWpTcA2kgMh9Ml47vtKyOJoJf+4WCisDmCt7PmP3g8nJ0QL8QdmnZozcWDrJ3O34RWaI5m2Pvnyj1ll/0WafwYEfxIypD1LZwUs3eSmKId+uUg4bF7Q/Wklf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764811384; c=relaxed/simple;
	bh=/LO8fajHnq7NXtZEmNk9GH/4+CA2IjjqbEcewxRwFyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Npz8hCUl5vt4VCe5CDpOAUyiDiZkpA6yD9AzybJBQivDMAgS1KGoXl3AifpZW++YMf6ko2hw2V0Al23JS+tK+1Hqxq+BE8yc2m9bMmgr/gL+bRysPdeSNUUVWi/yYfJ4gvIIHE7nfcNPdD8PV+3b1un4OICCPk6n9ff/f+BlZO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOFpnHyI; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leZst43LtGn/65EiQyFJo3TJUzQ/ouYfLykI8Dkyyev5GPTxTLhUKsZBXNXg1kG99Kpa4rpKWKYBUO9VMRbwiW6iXOjkr5c9nFarYW8uZ/ukXrwUG27JUgbu3+bYnKf1iGJn17e2J0qy8NsJV1eaafjiTajrCxFiaFQmC1ewp5btTbeLq59FdcQbNIu6Kd7Cnht/FCP3SdIl+B4WgFBrbxzHsmYnZTSX8DZSIfr12og2s1eP+4Mq+kUlFKH8w7hcpJF3dm2D8WjJ0MwL9JQO9RRFmExtu3g39TAxgtrmApWF2K/pt/AhZIVKP+70AuFIdTVA8j8BKxttXT+TeBalsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bThQ1a9Kn6MOgii1HQKxmiMGNAq8dO3MWodfFKLpWw=;
 b=RwtFy3llg7GoW7yyQq8UNceM6EZKxyKjZHAEIFuZcanWPAiw7ObIddUzcP0QuBnTBzow01giC23wWP2dR97yPyWXbWLYRh6XlJ4Cmjm9oGp82amLzAjXq0+G72PVsCEzChuCGEIA9GcNLdLboiONErtHHo8jBYe9iOyknFI+hPCEjhk4E2c8BU4L3GmXZzyEZ+klJ+aVUtmR8nD6SJu3e61cG8E1BqsoRpp1uiQgEHf462yBnKO1gEWooWlDwGSo1p6x41s+t9mAhNsq81Z51rytcvkmParmChWpiDTs+UhuzOf9db0J4A1rtB30hbBThu0OssxYXRXjSHu15T/tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bThQ1a9Kn6MOgii1HQKxmiMGNAq8dO3MWodfFKLpWw=;
 b=NOFpnHyINW9Dpl+70yMs/Sg7OgGOVYy8XZIddWyPI2tL8/CQdJiSfazkvjyQdayvud1h7L59HrpfCqQrsWyNogrh3m4WOlGWCh6vU3RDy+K1wTEVTv9iX7kls4nPj+gc+gMcoWPEubslbKCFDilc7He/tm7q6les2jAKkHMAgMm1T9ec1qZExsE+PlHZWs3J7Sj1NwDe+1iyMIl/Nxdd5UTXbXQ/B3lnx0RAQtLohlu1sAz4XfH9YLyufoPmBTFkU9zx3JXPiGj8ZythRu3kMr510G2UYvoOS0mEtdbppDLoako4DbNhsawSh0Vs1E6Hyl8iZ9FJt00BoOLnsT3wdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB10994.eurprd04.prod.outlook.com (2603:10a6:150:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 01:22:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 01:22:58 +0000
Date: Wed, 3 Dec 2025 20:22:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v11 1/6] i3c: Add HDR API support
Message-ID: <aTDiakSN34TCIskS@lizhi-Precision-Tower-5810>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
 <20251106-i3c_ddr-v11-1-33a6a66ed095@nxp.com>
 <16428df229c494c807ddc75009feffe219f11a22.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16428df229c494c807ddc75009feffe219f11a22.camel@codeconstruct.com.au>
X-ClientProxiedBy: PH8PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB10994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8811cd67-841b-4815-9403-08de32d3a89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCt2cDl0K0FNaGlOQTFkMGRYUFJhNDY3NFBUVDZ0TnhMTTBOckZ3eDdROFdY?=
 =?utf-8?B?c3JGRmxlajRsQWlqUWdWQ3gxMlZ6WE5yV243V3pyWnpRK1h2a2hGVWMwb3JV?=
 =?utf-8?B?QmErVnViUzV6Mkh0bkhxTGxscnozZ2FHWjltbWJzQ240LytUSXVjR2pxQ0Vk?=
 =?utf-8?B?QUswVitRRmJJdnlyVlpaVFovQWxUUGJ5ODdKM3g1TXlCVVNFZjdCVGZBWjJ1?=
 =?utf-8?B?OEo3MHlnbHV5YUlFOUVsMkVHVFRPQ3BmWEUyTG5zbS9yQVc3VExXeDRWcnNX?=
 =?utf-8?B?NGU3NGFuc1B0NExNbStWOE5JQ2tnMVRlOUlaN1pteWpIL0tVTU1jSVhnWDk4?=
 =?utf-8?B?WTNzbEhaV2lEbmxWeHA0cGVOQXA3a3dpS1hRTkIxQ2hESFhOTUczUUlBcmZ6?=
 =?utf-8?B?cGRGU3pPVkdQQXBrbEFyNCtPbHJuVGxndkVPZDREZjB4MzF0UnpSMlJyWEdZ?=
 =?utf-8?B?bk5QY2RtLy9zVVZCeW5XMVRZNVpyd0o1TXpsNzRmdXQ1a2I2eTJncjlrbTlC?=
 =?utf-8?B?WVY1bi9RTGR6WE15Y1h0eW9kc0sraEVYcExPUXBLUm9pUm1WMHF1YW1ucWdr?=
 =?utf-8?B?c0ZKYVVhbWZOaHJSYUlxTGloWWgzdXd0bENrNFVUMXdkM20xNlJERkxyUHZw?=
 =?utf-8?B?MzJtM1BZNUx2bzBWYXpyenZHRlNiOU1zbEhlb2NuTzVYZksrWTh0NWRLUU5R?=
 =?utf-8?B?VGZ5WDR0emxKTzlBSUV2TFJ0THozKzdIdFlFcjZRZnBWOUd4TEwvejRKWlJo?=
 =?utf-8?B?TGRlY3RMVlpXSk9XMWVlVFNJUWtOWXpkblJ3aUFUNmZVMGpiYlh6RkNQaXdC?=
 =?utf-8?B?ZHJYV2twRVlRcDdTa1BZMmhEcFJ4NlAxbVo5Q0FDWmZYVHVmSjdYaUtrcTRQ?=
 =?utf-8?B?U2NGekg4WCswTktoYTdib3cwRG5yVG5sc1RWNnBPN2hQOURtbVpyZFFhWTFP?=
 =?utf-8?B?ajBsN2FtSm1zK1lsQ2ZEMzI2V29IKzlQdkNMR2dYNTJTWGIxeUlNZ0J4amQv?=
 =?utf-8?B?MWplS2tZY29Kb1YvSnh6S0ZZQ1NiaXExSW1wcm9mNFhqUnRNcUJTODlXR0xM?=
 =?utf-8?B?UXlZVm9pd29ER1h2WU1jcnU5VVNjU2FnWnU4YUdQUXhoK0M3bCtuY0dnS2hj?=
 =?utf-8?B?Ni9rZk15RlU4bUI3NmQyVHhaUFVTTDB6dEkwemdYMW5RUmVKRzdlaGZGcDY4?=
 =?utf-8?B?bjJuSks1T1Ewbm4wdDFnS3pZZlFGL1ZnWU5zNTB1RVBqeUxHbXpmV1lnRzlq?=
 =?utf-8?B?ZU5nbjkrUDhzSUsxMHBJUnFUTFN4QzYwclNQdEhwNVk0Q0pONHVmc0Rnd2JZ?=
 =?utf-8?B?Unk5V1Z5WStXeHBuNjVsMERneng3V3VyU1h3QUxMVGJmQnRHRloxa1pMOHlI?=
 =?utf-8?B?L2tqbmV4aUhjL2dhUkpKNkVlWEdqS2ZubHB2aGFpSlVzU3JYVGcxallTallK?=
 =?utf-8?B?cWZOWEwvWERoQnBQck8zVXNLUGhXeHFLVVVYUndzKzdqWkx5UUJLc09ydjhG?=
 =?utf-8?B?bUpoOStFb0pQVEllNHlsVWoveCtpTWxUWHBORFZndHgySVNOdnlXWTBOK0dX?=
 =?utf-8?B?NVd6VDdnQmhTTWZlcEVaRlFOSC9SVnhVMVdTTWpSVnZBeW5KRy8xa0k2eVZs?=
 =?utf-8?B?eGpxM3Z4dWRtQUdFTU9OUTVZbUdsSGwvNEN0a1pPcXpqdllzMU5IMnN5dkpG?=
 =?utf-8?B?eGF2YlYwWnh1aDhqZm5VcUJwN2xEL3czSkk1VXNPUm1kZHM1bFFCQTh3cHl4?=
 =?utf-8?B?bm1vTGVZb2JRenpHaWQ4cllNQTFhbnVRRFV0S2h2NVBSVzR1VXM1VnJ5a1B6?=
 =?utf-8?B?Ujh2dy9FWTA2NGFvc1JoaG56Q1FCV216anVvV3pzM3l3eDFrQ3NyeC8wV3lF?=
 =?utf-8?B?c09sd1I3cmFDMnVEbkk1ZnEydTd6b1dPaSsrNjlPM1FRdlBvbXIwc250eEtT?=
 =?utf-8?B?TmhlTTBobGVLWWhXUHo1a0xHeXJYWFBJcUg4cW85elF3YURXMGlzcHFWNzdm?=
 =?utf-8?B?TmFybExzb0JwZzBWcWgzblZnaHN0TXlZMFgvdjh0TjloeERGN3hXdHB2OGhv?=
 =?utf-8?B?T0RaanVzMVkwZWFiRHFkeFAyY0M1SEFZaHFUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdramxTSXFnVC9McGRRaTdoREtBN2hOMWgyZ095VG9mazEyMFRwQWFQRWl0?=
 =?utf-8?B?allTd0RoTnNGU05NQ3Y4Wk1UNTJZT2RVSWEvYUpiT1VkRGFNaHJrNjR6ZnhO?=
 =?utf-8?B?TDhPa2xXMVNLY3lYZVNFc1NJUmlVdTFSU3NqVkJqUDRkNXBOVHlnZ0phbi9z?=
 =?utf-8?B?c2gzUHhnOFljQzlRL3FCQzRrTWhCY1ozcnZpb0dDTkJIK3lWZ0lxY0RPWEZk?=
 =?utf-8?B?N051Y0R2SGtCUGdwMXVGMlQ4YjRXcFoyOGphWktibVovOCtmanlnbVgvZWFO?=
 =?utf-8?B?ck9KZTNUQnRENjhoR3d3dTZlVy9zSjA5WDJwNW1BaE9BSXdKVEppZ3R3UU1o?=
 =?utf-8?B?QS9xUERIRE4yMzNDbzdEdE9BbHBRNUNKUVAra0pOaDFPaE95ZThlN2pxZUIy?=
 =?utf-8?B?dHBzMTV2LzdOY2dGSDhOWm1sbkQ4dzZBb0ZMcXl6Rms2M1ZKM2FnT0o1Y0ht?=
 =?utf-8?B?dENoeWxJbWlBeVZFSERiQUkzTUpESDladmZSVHNOSnR4cnlzQklYM3hFRXd1?=
 =?utf-8?B?NHdlRE9PQ3lZZmtBOUs5dnVaVVBHOUJyb0JPQXN1cStrTUZicW1ORVFQb0Iw?=
 =?utf-8?B?alVnMW9Hcmg2SS8wc1pEbHRHNkk0UHBTT1RQYUpmaVVrUjFSdC9RTmhzMHYz?=
 =?utf-8?B?eVhaQWhkeGhKMmUzZ3R1RjlzT2ZQVVhtZm5aQWg1QkpoZ1B4RURPMlBoZ1FF?=
 =?utf-8?B?T0JhZG82MlBJNzRjVmgyemtYVUNUVGpodVRtL01NSGkvZEcxanhLcGZUb0d6?=
 =?utf-8?B?dE1WM202Wi80YWpUdGhueng0cXNWNlNHQ1NtYUNjUFRWSm1wY2QvOVFxMi82?=
 =?utf-8?B?cDlFeGF0WjUxTzRsWEtLTTlWYmJXUFlmR1lRQ0xGNEFCMWZSazA2TnZjT0t6?=
 =?utf-8?B?Mjg1bkZ3QzdjVkdwTjBHOHZUeVI3Njl6Vm5OeEduMWJ5b1VMdnFhTk5WdnYy?=
 =?utf-8?B?dFVTU3Q1WVdqRGF3aW5nWmpRazl1VmlMNUlORmd3bkZUaWZOYURKcGQ1d3RP?=
 =?utf-8?B?cEJkbVAySTZtMjVBeDdkbHAwZ1l0aEJOajVxeFJMUUVmSUpUR3ZNVEF2OFFJ?=
 =?utf-8?B?aXV2eUw0TFFEajlqejhvSDFITGFVdHk0ano3WTVESE1FSXVMM28zRE8wQUVL?=
 =?utf-8?B?dExpcEgzYk9jQmMvbW5jb0xvK3NVZko3dU9IVkIzZjF1eUlwREJ1MEtPTlhU?=
 =?utf-8?B?TFVUdmtRYXcyUmwzRDVxdkxJRkszYWpmZkdZZ0l4VFB5TE8ranRuRjF6Nlo3?=
 =?utf-8?B?enh6UTlwblFLeU9oMS9CS3kvcHhJNEhGemgyQXNIcnlIMXhFQktwSE1YL2RH?=
 =?utf-8?B?VTNqZ0NkOTJaa0RmNi9tL0pha2l4dXFKQXdNbytmL1JlWE9ySlFTUEdEaUsz?=
 =?utf-8?B?eVM1UWxHejZQMXcvRDI0S2w0eEJZUWtkb0NiVXZCNGlrdDRqdGFDdkNhSzZ5?=
 =?utf-8?B?TkNHRGI0VDhIVUVnNi8vc0dSUVR1MkhrVVhBNWZ0OUt5b2F5Qk5LUGJsS3Fi?=
 =?utf-8?B?dGJpZ3k0aXp0SEl0bjRzNnk3L0FjQ0JWOWdFRGtYcFVDeW45aW5jbkNpQytL?=
 =?utf-8?B?UUNXM2pGMGZNOEhBbDN5SktRbk11d1lidWJCbmNERmMvV2NMeUUySzRaOVlX?=
 =?utf-8?B?WDlVNzVkMzc0R2dBT0hGekFEenpjV3BVbXlVdmR3Smo2ckViS1lxQjRBWEdt?=
 =?utf-8?B?MEdKN1V4Z2V2WjVCQWRMZElPSkdMbUdwdTdFUS9rMElCVFlicWlaRXlISktm?=
 =?utf-8?B?MmsxY3BHQmtsOXNDdThmS05BekhrV1l5UHJNU1FNeTdIcFVIdGFqUzl4cWU5?=
 =?utf-8?B?SzlNcndjcjJsWGgvVWRHMW1VS1VqeU9VaThXbG01ZC9JTThQK216OU53eitN?=
 =?utf-8?B?Unp0VEJkOWpkc3Fac0d1WUZmWGtWTDVUYjZ0WXA5K0FlMkllRlZCK3dJaHpr?=
 =?utf-8?B?aFZNTkxRTlg0R3BEV1dKbXViMFZuOEVBTlRXdS9ZQnBDNlZxRFNUTXc4NlBv?=
 =?utf-8?B?dkVTTUhCeHpUNmFnWFFGK3ZEdG9tTnFybnFkTlpNbzArQ2ZPM3RhYkpVUVRx?=
 =?utf-8?B?MnhrdHpJdHRlaFp4c00vUldxL3VjUUFPVTg0bTlIdU9wQURiZ2NvVWdJTGIr?=
 =?utf-8?Q?IxcISB2zlKyJB8NfRGO+8BMJd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8811cd67-841b-4815-9403-08de32d3a89c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 01:22:58.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1izKkialTGsuzO5qubEvLYiXg4OTq3AWP+RQaORsJLahILAIYAjuDa7rRmT14Wx5GMQgwLYqVn3+pg+wcErkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10994

On Thu, Dec 04, 2025 at 10:47:57AM +1030, Andrew Jeffery wrote:
> Hi Frank,
>
> On Thu, 2025-11-06 at 12:36 -0500, Frank Li wrote:
> > Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
> > I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
> > Technical Overview.
> >
> > i3c_xfer will be used for both SDR and HDR.
> >
> > Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
> > CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.
> >
> > Add i3c_device_do_xfers() with an xfer mode argument, while keeping
> > i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
> > with I3C_SDR for backward compatibility.
> >
> > Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
> > 'rnw', since HDR mode uses read/write commands instead of the SDR address
> > bit.
> >
> > Add .i3c_xfers() callback for master controllers. If not implemented, fall
> > back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
> > all controllers switch to .i3c_xfers().
> >
> > Add 'mode_mask' bitmask to advertise controller capability.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
> > one i3c transfer. for example, can't send a HDR follow one SDR between
> > START and STOP.
> >
> > i3c_priv_xfer should be treat as whole i3c transactions. If user want send
> > HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
> > instead put into a big i3c_priv_xfer[n].
> >
> > change in v9
> > - fix typo Deprecated
> > - remove reduntant master->ops->priv_xfers check.
> >
> > change in v8
> > - new API use i3c_xfer instead of i3c_priv_xfer.
> >
> > change in v7
> > - explicit set enum I3C_HDR_* to value, which spec required.
> > - add comments about check priv_xfers and i3c_xfers
> >
> > change in v5-v6
> > - none
> >
> > change in v4
> > - Rename enum i3c_hdr_mode to i3c_xfer_mode.
> >
> > change in v3
> > - Add Deprecated comment for priv_xfers.
> >
> > change in v2
> > - don't use 'priv_' since it is refer to sdr mode transfer in spec.
> > - add 'mode_mask' indicate controller's capibility.
> > - add helper function to check master's supported transfer mode.
> > ---
> >  drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
> >  drivers/i3c/internals.h    |  6 +++---
> >  drivers/i3c/master.c       | 19 ++++++++++++++-----
> >  include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++-----------
> >  include/linux/i3c/master.h |  4 ++++
> >  5 files changed, 70 insertions(+), 26 deletions(-)
> >
>
> *snip*
>
> >  
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f90b99e58eb806f9 100644
> > --- a/include/linux/i3c/device.h
> > +++ b/include/linux/i3c/device.h
> > @@ -39,20 +39,25 @@ enum i3c_error_code {
> >  };
> >  
> >  /**
> > - * enum i3c_hdr_mode - HDR mode ids
> > + * enum i3c_xfer_mode - I3C xfer mode ids
> >   * @I3C_HDR_DDR: DDR mode
> >   * @I3C_HDR_TSP: TSP mode
> >   * @I3C_HDR_TSL: TSL mode
> > + * @I3C_SDR: SDR mode (NOT HDR mode)
> >   */
> > -enum i3c_hdr_mode {
> > -	I3C_HDR_DDR,
> > -	I3C_HDR_TSP,
> > -	I3C_HDR_TSL,
> > +enum i3c_xfer_mode {
> > +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
> > +	I3C_HDR_DDR = 0,
> > +	I3C_HDR_TSP = 1,
> > +	I3C_HDR_TSL = 2,
> > +	/* Use for default SDR transfer mode */
> > +	I3C_SDR = 0x31,
>
> 0x31 is 49 - is that really what you intend here? For instance,
> building this patch for ARM32 produces:
>
>    In file included from ../include/linux/bits.h:5,
>                     from ../include/linux/ratelimit_types.h:5,
>                     from ../include/linux/printk.h:9,
>                     from ../include/asm-generic/bug.h:31,
>                     from ../arch/arm/include/asm/bug.h:60,
>                     from ../include/linux/bug.h:5,
>                     from ../drivers/i3c/device.c:9:
>    ../drivers/i3c/device.c: In function ‘i3c_device_get_supported_xfer_mode’:
>    ../include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
>        7 | #define BIT(nr)                 (UL(1) << (nr))
>          |                                        ^~
>    ../drivers/i3c/device.c:272:68: note: in expansion of macro ‘BIT’
>      272 |         return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
>          |                                                                    ^~~
>
> Should this be decimal 31, rather than hex 31?

Yes, fixed patch

https://lore.kernel.org/linux-i3c/aS8YKfhPAxvpj6xy@lizhi-Precision-Tower-5810/T/#m7367e8845c31b924672445dcf639eea39112aac0

Frank

>
> Andrew
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c


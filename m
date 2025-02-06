Return-Path: <linux-iio+bounces-15059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F5BA29EE7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7FD3A7802
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 02:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2661D13B2B8;
	Thu,  6 Feb 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kvzKg4Dt"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D5136358;
	Thu,  6 Feb 2025 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809668; cv=fail; b=O9Yf0hoZMbwbQyNr6ZHzryOqK3vIfLjZUYgwlYmHXfr5UbspSZCSy4q7xqHB/Nmu5GXnA9YMt5TV+KaGb1NtbaIL3ZW08Hacp5vpgvmXNuSvqeHerhaKAgvDk0/Gk7OM7EKBrLrc3HAGobxDd1bjv6GLd+/Cu08P8J5q4OCcCm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809668; c=relaxed/simple;
	bh=HMgMc6SUK36aXI/fIoOkeTcy8HpJEdV7aiGd735Fi/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwT8APxm3oXqqzG+dSZQOXkighSjcPitHcydcayli5syJaUPHNWH2ZNFZdMNR4sM6be1S2Tq+dj7hOpvQpbNsVwZyDLO9zOrCiaMIgneP0D+4sTWiR3P1pXvZY7tw9s4xjvs7X37rNKcu62LJVLStHaZ8218PdQcUhFcBkiQ4JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kvzKg4Dt; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQzpBAmDllkQJWVU+442WPledhv+1ixrowMenNquNJte0rSK88987cZT5TCxHItdAHU+huEq9+jmzQeJxx0wuKYT2rnMPezJLJi4PlMogABaEWwMkM34z+vpF0foLr5goUwLU1u5l+UKF+BhUDu40CvtwINp35grDu90lyWvfkur1guQRFffdKQjj2eIGSBkOCEhVC4RZhQcBleWHjrC8sZcJ1FVUnX9/RXE8x+XqNz9Ned3GoWp/4rSSLZkSp+Ke4RVn02byQSDRo0NY3CqSyR07KFQTAlQwPzF9PhoHZKKlIM1ofrUAz1/lx8q7zdJIgHwiUPWwOZ3j8GvUlu5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMgMc6SUK36aXI/fIoOkeTcy8HpJEdV7aiGd735Fi/g=;
 b=jxCOSvZ5KqUpdyVHGPHVy7qf54jktFNeIaQ/AjndPCkpauSRzhdjlDZP58ux2ayiwXZSDxE1MXErJLCxGpOwPOI5Drnr4ICdMqS/Cq2pb68VM0xTBcLMbJK04FDCptfzBFTamQfGEhSGGCnnKicejcBvq24nfp88HBmcHy9OFS0llgSPPHv/v7FSCg7eeFZK9rYi7XItWpIotkDB2JwWDhbllIZRnxoJCwof3Hu6BOA5hK6eoMqxu03xFySxua+mIAAJZpbRwp+Sv1peVacEM9GvZONu4zX6ViZ7l3drLtLzt9Zjh7bwGLAQC4K4wCnDlAtdTg7QVpVZFgXUsw9I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMgMc6SUK36aXI/fIoOkeTcy8HpJEdV7aiGd735Fi/g=;
 b=kvzKg4DtHGQYcuNZxYkuyIiNlAEsBW4gUSPEkddN74HQuMIAlKwvUpUM8uimd5u4sA+3bgRBvky7DThAkMt5RFamKPVJbNwZ0E07dHDR+VtlAx2X3dCmRj2vnqngXHdcQomxRT5TXRY9jbJjGd1WSM4kLVTcRzkDbsXqPwbNIY/2v3NnwOVjtexIIMb+WTLdVr7CuHc90gVJBn1vF2gdG3L5R8LRDUKY35SchMqM2YWTW3Ae+zParXvh86KNo7Z7Vld8wxHmpgrQjP8xYiGU63IaKvFh8Eqyzuu538P7aud6VB5L29VO2FmvXJCpISGJ3j2zhfkZF2B32XDroT8n5Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 02:41:04 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 02:41:04 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <m.gonella.bolduc@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: fix missing type definition
Thread-Topic: [PATCH] dt-bindings: iio: light: fix missing type definition
Thread-Index: AQHbd4UXaZ0odXRwv0CoMPLVsSbi+LM4lZ4AgAD8eIA=
Date: Thu, 6 Feb 2025 02:41:04 +0000
Message-ID: <1e1ff244-098b-4b3b-b430-8bed9ca8188c@microchip.com>
References: <20250205-brcm-binding-v1-1-a996a840d2d6@microchip.com>
 <20250205-enormous-wise-copperhead-c1c0a9@krzk-bin>
In-Reply-To: <20250205-enormous-wise-copperhead-c1c0a9@krzk-bin>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|MN0PR11MB6205:EE_
x-ms-office365-filtering-correlation-id: 5acdb079-f873-43c1-1c60-08dd4657b37b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTlUWEM2cU1tcDgwVEpUeG1zVEozV2lJd0UvUVVPSjZPWVJRTG03RVp2VVNl?=
 =?utf-8?B?c2ZwU1I0eno5elZ5NkJDRXF3R2xaMDhZTmcwT1ZURlZrMGIzMnpYeGFHQWQ2?=
 =?utf-8?B?U2NJYitZMDFCSTJGR1dBOGlLKzFpODBWSlpudWZybU1ET2lHQnIvbzZyUEtw?=
 =?utf-8?B?NEpoa3hoVVB0NmJFYU5uayttMVFhYmJyVXJZVmo5K3hzaXZIWlBzcFhnZ3Rx?=
 =?utf-8?B?K0hVSk9WTGdzcGt5Z3ZGVURSWHh3ZWR6SWNhN2RwWkx3RmNrVlVFTFI5Tmw5?=
 =?utf-8?B?NzlRb1NsUEljSi9GRzNGbzg3Vm8vNWJ4Y2lOQTBDNDBhNDl1WGF4Uk9sajBv?=
 =?utf-8?B?ZVozZjZxSVF1MDRkR1pRcmFFVGJFNTE1NmRWTVpHcy95SExGVGIwTHgyYVlv?=
 =?utf-8?B?YWt4ZUx4ZmV3bnRMNUdDVENacmQxNFhtL2pCbUpBbGgwTE9ONkFnL0NHS1g5?=
 =?utf-8?B?RmRHZURnRzBodFBubzNmVjIyQ3BIdFVDOTc5NUFOQ2xLZ0xUL3ZvRGFvTHh6?=
 =?utf-8?B?TG1QUXFsakZOMThRSjRmQkJlVjhkOW1HY1dFZ1V3bnFhajI4YlQybjJlZ3Ns?=
 =?utf-8?B?ZW0rWStneFBXVm1nT3hUS2pKRWtYRWYyV0dzSElNRXlEUGFzbVZiVHk2czN2?=
 =?utf-8?B?aU1iR2NNbFVvZmg1QkUvckNFQWt4TVlDQnBFd3ZCRmpRSE9yYjB4eDYyTmFR?=
 =?utf-8?B?M2lnbUlvVzdhYXFGSlpqaFpiRCtib0thYk1hVEhFUTBZNHV6NW93dktFdlhw?=
 =?utf-8?B?RW8vVlZ5M3Q5MjkrM1drNHRCdVhYUkg0SzF2Y01EcUZYSzNFUVZ6cXpRS09E?=
 =?utf-8?B?MDFIeEpMRXU2U1lrdW85eDRXWGRaOGpBSExob2pxRDhiVVJ5L3FHaHA0dGFR?=
 =?utf-8?B?UUpOMHM1MlpKK0sxRWpnNitMaWFMbnpsaXE4bkpBUXJ1bDVpUFVJbTJZTFdy?=
 =?utf-8?B?d3I0dzFLZVNaOENWRFpsUFFreGpEV29FeUp0U2Y0WnJmd2ZDMEJHRzNpTVFL?=
 =?utf-8?B?WlpOZXZXN0s5R21lNHZKYW5EQmcvK1pxd3pFNHBHaFZpei81TmhnOERUbXVZ?=
 =?utf-8?B?TEx2K3Rja3VvbUxFNmlEelhVY1lkcWFpQy9uUC9QUzM1d0dtTko0THpGektr?=
 =?utf-8?B?aGNCWTRyeW85T25NeXpUQ240VHpERGI4ekNackNwWGNGWVlPS251bGUyQkl4?=
 =?utf-8?B?bENhVk40Z0dadVFyeFBCdlIyQmdrU1RQZ3Y0ME1rbmlSekZrZjFTcEw4cEdR?=
 =?utf-8?B?VkoyUjdmbitIT3JwU2N5SnY2Rm5xYkRyS1o5b0Nsa1VSeHVnVUpUV0RlOWRX?=
 =?utf-8?B?a1Zsd1JVR2toQWJoeGpsZEYxSVVsMThUQ250RjQyUldMQ3Y2UjBDQXAvOWlW?=
 =?utf-8?B?ZW8wNWdzMFlpTE9NTTlVWjZQTkMxVVUxU3BwbklmWDhKMFFVZkpSWnhTeFFp?=
 =?utf-8?B?R3NWSjRINmtKMkJkWXVacDd3cVJkRVl5UVN3VEJQcFZoTVgxQ0xoWUJmQVlp?=
 =?utf-8?B?c2U2emlTMVk3NzJ3QzdzZDRnQlMzTEdOS2wyTEZJK3NabkhRYldDaGJ6anRQ?=
 =?utf-8?B?dlB3WXRaS2RVenVIVDZrNEY2UDJ1UGJMd1cxditndjh1SStGOGZXMjgrYldX?=
 =?utf-8?B?VVc1MDdsN3UrcnZINXdZZkViVGNJMWIwb2ZocW5peEorTkVkR3NIK3FvU2t5?=
 =?utf-8?B?QVphWmJ4UXQ1MVY2dGtKeXZSaktFb0UrakkvQUNyM085Nzh4MlAreUNaaHo5?=
 =?utf-8?B?Z3BaYmxCNVc4U05pMTZlampROEQxeS9lYmVsT3BubllzR0NjWEgzYzFSSHR2?=
 =?utf-8?B?M3BEZEo4QjVabTljbE1rSVlBcFE4VjFtMmhyVWM4RitmSVFKOEtpQnVvWlVv?=
 =?utf-8?B?T3I4b0lUQVNtQVMwT21iYVdiN25VME1CQUlYU2VrOUViREE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RURkSlpvRW42UFpIa0xJb2phSWQvUVRHZGcvR3hHVUJSTnNYZ21lM0ZBZ2dq?=
 =?utf-8?B?NFJEaEJuU3d0cGwvQVZXbENpNVVtOGlyMmxKelZUVHRyZS9qRk42dS9CQytP?=
 =?utf-8?B?T1hyUDRGdFdqWE9QNWU5eUwxaG42WTJic1hpT3FGS2VxRG9FbFlMcElHa2k5?=
 =?utf-8?B?M1pPTzZSZlFqeW4zM1ZwRzhTN1VpczFTSE9TZjBFTUJjZHNjZW5tVTlDT1o5?=
 =?utf-8?B?anFYNDI1Zi8rNmNGNGZET0lNZUZWVnBTcGx3dWU2eGVXMmx6aHFLM3E4bHhV?=
 =?utf-8?B?TG1xdEtMd1N2MHRZbjhPRjhrd2ZXb1FpNHNaeGhFVjhSMkFyR3Z3YjhWMWsz?=
 =?utf-8?B?MDlIeU5mS0x2T0xWUkYydW9DaTMvMzVqbkVkYVZxWko3RDI2VnQwbTlvTXdh?=
 =?utf-8?B?dlMycVdvSU0wWFpYc2dsa08yb0xuQmhzR3hsUUJPckplOFl5YkIwRGt3TFNq?=
 =?utf-8?B?TFNTK3hsTFFBY2RUYUg3MUNOY3h1MFdlMXY2UkJHY3ZpcGtidys2K0xURXZh?=
 =?utf-8?B?SngrZHpjL0U5QTJrQkpKd0phZHVkWG1iYWRCRG1ML0pKOFdJUGZZTjVrR1hL?=
 =?utf-8?B?dFp5cDNRR3pwcWRLc3JwUTRBcDI1cEJ4azk3bWhNRDF1ZDFQZmljTm5ZdkRT?=
 =?utf-8?B?dTBXTTRrenVHZnl4TGxCSCtwaDJWTVhzSHBPSmpjdlFsd25PMHE4RmkrbVNy?=
 =?utf-8?B?UUtGNFcvcnBrUVJuQ3JIVkNXdnMyUW5lQ0hTbGZLZnJ6WTdCNWZCekpFRmtJ?=
 =?utf-8?B?eklGb1NmTUpzKzZUcldrY3kva3NHSE9xaDFYaUtVVjFkUndrajd6U1lSVjg1?=
 =?utf-8?B?SEczODJRZlpPOGd2WUJmdThuYXM2Q2lJZnVKdmU5RitLMEVvRWdXeGVnUENj?=
 =?utf-8?B?MkhqeUZyM0FqQWNBV2psbVBJeTYwbGZUS25RYVZ3empHNmlxR2QwdlNVdjRn?=
 =?utf-8?B?dFFOdXNXb0tHNGNoVnJoSFd2bS96Z3FCdFJTeG1IOWZBVDdJaGhKSk52Z1FX?=
 =?utf-8?B?QzVkRnZXN25YczR6RGFBRW8xLzljcVEwSWNmVjBocnlVTFBWU0tDZUJCWWVn?=
 =?utf-8?B?eTRSS2c4Uno0QXhHMUMvU2NYSzY3MnEydjJpQjR4ZnNyTzFPKy9MTjE1U2h4?=
 =?utf-8?B?T29mZUNzaTZMV0VGc2pXOUhpSWZzZzk1endTL2ZRb01ZM0V3ekhBaUlPYzFR?=
 =?utf-8?B?VDd6dzRFcEZtQVhYcHNQT2VzN2kwS3YwVmhoclZXcTZxeW51MWpTRDBuQnVm?=
 =?utf-8?B?TjRtRFlGWTFtNENWdHh0Mk1kbFlGbGsrbUI5QkRqNU54K2NJcWdzVWNqUjJu?=
 =?utf-8?B?WjZiM2lCTCtRcVY5d3NhS283dFdtWnVVN0NaVXY5WklrN3dWY0JIQTNLZEVF?=
 =?utf-8?B?eThGWHpHZDdJVUJZN3RNOGwvbmxUa0kxSG5pcW0zSkVKNUg3VFhjSFRvUlN5?=
 =?utf-8?B?NHl0YitkMTRiUFVselNGNHc3aXB2MEl2bkNnTlR3dGdKTmxvdHpZSkkwM0kv?=
 =?utf-8?B?QlhScGxFMkkweXJZRVo0TG0zT1hIYUw3eWZzSEJzUmtwemlndFcvcHR2SjFZ?=
 =?utf-8?B?OXRnemRIUVFmSktlWUU0anZzOWtEb2ppWkp5UjhhSXpIT1BMeklpMUZlOXhE?=
 =?utf-8?B?K0VYbVE1dlV0bURKdkNmTHF6NjVvMEhVUFJicXFyVmlBVGgzTU9Cd0JYL1JQ?=
 =?utf-8?B?emFHckExcjZxK1A4dG53WllTOXU4aVRhc3Y1RnpNYWJMQXVwbjg0VnozM0xC?=
 =?utf-8?B?aVo0dW5tSFlIOW1kY3dQV1ZaSEdHOUVSMU12ejJRRXNMQ0NTcVlucDIrMGtw?=
 =?utf-8?B?alNMK09VQzUwU0FYKzNKaUdZdS9XRlpuR2hRZ2JMZFB4NS9SNTNKbXpxcEJl?=
 =?utf-8?B?R2tvS01PR0dvdmNsZVY3TjFnSG9xZURkY3pENndQODJ3VzBBaTdmaXVUZy9Y?=
 =?utf-8?B?aWVGMDh3REJqOHpLVTFWb0NCNlF0RDh4WEMrMVEwWVlzTXVNRTFPZThFT0lS?=
 =?utf-8?B?TzdaR3FnUGFCVUZPTUxDUzZ4MTczL1UzcFA2OGpnS29DaUFrVE04TndOL1hR?=
 =?utf-8?B?LzRtSS9MUElTbmtJOUUvMGNwNU9kRkVxY3JtS0orQXUvNnYyRVhMVHFWWmN5?=
 =?utf-8?Q?7RIXF9JWWHeqWkCQBH373SEOl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <587A3940305D764A8FD970695CCD96F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acdb079-f873-43c1-1c60-08dd4657b37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 02:41:04.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOwbcG8eHaCJRx7/VJk/rUDZE9brCaBHZGPztB4XBDeTjyUgddR6hCs/JGmtsQJHrlght53FtCYrXvswBiu8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205

T24gMDUvMDIvMjUgNTowNyBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEZlYiAwNSwgMjAyNSBh
dCAwOTo0ODo0NUFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBBZGQg
dGhlIG1pc3NpbmcgdHlwZSBkZWZpbml0aW9uIGZvciBwcy1jYW5jZWxsYXRpb24tY3VycmVudC1w
aWNvYW1wIHByb3BlcnR5Lg0KPiANCj4gSXQgaXMgbm90IG1pc3NpbmcuIFlvdSBhcmUgdXNpbmcg
c29tZSBvbGRlciBzY2hlbWEgcHJvYmFibHkuDQoNClNvcnJ5LCBpZiBJIG1pc3Mgc29tZXRoaW5n
IGhlcmUuLg0KDQpUaGVyZSBpcyBubyAkUmVmIG9yIHR5cGUgZm9yIHBzLWNhbmNlbGxhdGlvbi1j
dXJyZW50LXBpY29hbXAgcHJvcGVydHkNCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90cmVlL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vbGlnaHQvYnJjbSxhcGRzOTE2MC55YW1sI24zOQ0KDQpJ
IGNoZWNrZWQgaW4gb3RoZXIgYmluZGluZ3MgYXMgd2VsbC4NCg0KSSBnZXQgdGhlIGZvbGxvd2lu
ZyB3YXJuaW5nIHdoaWxlIG1ha2UgZHRic19jaGVjayBvciBkdF9iaW5kaW5nX2NoZWNrDQoNCkRv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vbGlnaHQvYnJjbSxhcGRzOTE2MC55
YW1sOiANCnBzLWNhbmNlbGxhdGlvbi1jdXJyZW50LXBpY29hbXA6IG1pc3NpbmcgdHlwZSBkZWZp
bml0aW9uDQoNClNob3VsZCBJIG5lZWQgdG8gdXBkYXRlIGFueXRoaW5nPw0KDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0K
RGhhcm1hIEIuDQo=


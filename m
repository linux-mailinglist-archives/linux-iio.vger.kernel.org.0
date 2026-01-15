Return-Path: <linux-iio+bounces-27810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A564FD22F39
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521183097C13
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9232D45B;
	Thu, 15 Jan 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZvRQWCWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022091.outbound.protection.outlook.com [52.101.66.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECC32E121;
	Thu, 15 Jan 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463372; cv=fail; b=X4fdvEUME9R2AsiVyMJNYKBxWaApvwQym1II2D4P9x18qJxj4qjMr4v6J796psmZB6s0r5ZhI8xd59LBiu75dGoRtQsnvirFlCBMm9S0PK2y9jGAv9kRnPxC88EWBX8OCTXnIUTh1ORFmFQ9t5vaKgRmheG0BBSldPsLyreSUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463372; c=relaxed/simple;
	bh=Mj6y5oRRlTkZuVr539DEcW+BUdE6SHJdtTsRqpJdfF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHmDoW8ZLp5nCzlXJq2FVVB90KyY3dm5KyeURBc2XIi+S+Mwz3zIzIB1CAgGY2bIflHieulC0p2oDz/PT7apGaTGx7uWdzsSfdNSOmf6/pHYu8esakeGuVhSy7wo56x8pSjxSRkX7UaEbmiTyqMFQtb0B3hpQ9bRf6l2Xt87pbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZvRQWCWn; arc=fail smtp.client-ip=52.101.66.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIuJev9IjqWPLjzWQ1HwTsUha4KHi4UGH3VeTjf1o3ymUFrqM7Rg9BIr9YrFMQ3gi3vGLisEacZvMES+ERAiFw3R9F2ixqGf3eZ8wKygVbkLHAUEHkLfvJ2RKLHxz1pXeJIUSxleBjGrhXJa/bacxSheKA05y6W/Sf/fTx5E/36MUM0U7X+9QkvIQodOoqH3z1ym0NFP/FIsU+Jp13Gul98w893moxswEm9IzxzDHcadjzYjS62PLEafzUcNQdxuvuMURF03Qi55R+wcmIwZJaD3/oZ/DbXQ5uw1BrRanYPWA2C/qGZPA8xmdfcjVqvvf9arsNyF0T8+aflat8rgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57YEuKXGwnqLCSDR73Spv78l30MQPH5c12Pg7ahQVac=;
 b=RFxJbMRvJzVcK4fkxAWA+zPsUSzzvh5g7/Z0OdGMAQFJcsT8lMHifLO6A0UxK8VKz0EfbonB/Bw+XvAPCqN7W+4FDuKZ0kjKcOfSj7fgFYUESjMj6szlyLOe7nffgRDjlXWNIJaae8CTKKzFa7ZjU3zlRYE7ZZXuQ0RvwhmrJAY4p7bLYN8jssS4iduxU/cBV4KzXXFefqYagtYyOQVfHDHC0r1/m4QiLUsdAbQf3maWy5tOnIJr6xI4VRcKLHBgl14lW4XrNzVo1mJtwub3GGccw5IzwROFXMWbT09pxh8y6FHYZuoPpInDEZtKmyijfWDot6UAH8CCTyHMB6Scrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57YEuKXGwnqLCSDR73Spv78l30MQPH5c12Pg7ahQVac=;
 b=ZvRQWCWn3j78mCBsbEQxj3uppFxHRtAZJPx7EeZyEobumu4tnCFCPyFhn8AZTGWhXX7HPw4iY3lj8JNE3xg2MAtYb+7Y2bhlhdBu6aDPYxxgRcW4j1FAcQM0IcEtyR+eRFCBttiGHMe6vM87TSgRL0rpRCMEeREGLPLdKU5/oZRGA9Zp2DyN2CKlzffd+/9nf8QJbHZlQx0W7pxq22VHtdsJ5r9vdsUgR3LEEqAJYDdFIAW8Nyy3KVyT8P/CTZlQ3hW6nw6xnEnqyVLGYET1LgRzYfzKAkH7ViSZQ5Gb35adMTvuCpubhbG4RR0k9GFOy10CbySdfmYQhL5AFToZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB10125.eurprd06.prod.outlook.com (2603:10a6:20b:6c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 07:49:19 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 07:49:19 +0000
Message-ID: <921b457e-fc3c-450f-a00c-1912ef9abae1@vaisala.com>
Date: Thu, 15 Jan 2026 09:48:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
 <20260114122854.00000aa0@huawei.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260114122854.00000aa0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002BA5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1c) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB10125:EE_
X-MS-Office365-Filtering-Correlation-Id: ddca205a-e472-4196-7c2f-08de540a9700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUpZa29QYmtvT2ZTMHY3VjV0THZMY0hCZzNYQjVQZGtqRVYwZHZEOElpcEQw?=
 =?utf-8?B?eUloTWI5d0FieWZlR01SWGtERjZEU0V2UHI0aDB2MTVPUUp6MFI4SDhIanpN?=
 =?utf-8?B?bTkxUDJGTiszR2NkQVpoeitCcHQzVkxoOVRMOUFUcGxETDBEOFVWd1R3U2xY?=
 =?utf-8?B?L2tpU1FFS3NQZlYrWnJSZnYwWkRNUUxUVnp0dXM5STkydmEzUWU0aDB6SHN1?=
 =?utf-8?B?cWpGN3ZuWW5PUFZhdnlJdmtQZ0Zzakh1TUduY2hUTG9DR2VhYTFySyt1K1VL?=
 =?utf-8?B?ZWJBTnVNUUt4YmlIcmcycnFvN2RMbERvdGtmT2xsV2pXUXJNMXY2UmsrcmVt?=
 =?utf-8?B?aWp5ODM5b2xLYzJsWS9MelhSbUh0ZWhUSDZKR1ZpY3QxbU4zUFh2cFBxZlFT?=
 =?utf-8?B?NEtKYVFLRU1JeXdWR3pVR2VjTmYvYVlocFBLb05OMjZJZTBiVlB5UTJPcWsw?=
 =?utf-8?B?enVONGNKWFNSc2trQVgwaXhaRHhPRG5mcXNKRk9sL3NzbHJRZjN3ZElSb1VN?=
 =?utf-8?B?Y0RKZVc1T2pqY2dVakV5dUxPRmM0VGI5SzNGb21WbXVtMU91bmFublFLTXMx?=
 =?utf-8?B?eUk0YXo3UTBCZHBsd3pabTVXZHZ0TWc2VDR1bWlYejIra3lvYWhkSXdIZFlO?=
 =?utf-8?B?RHdyNnlDWG9McnltbkY0UjdJREZUK2RMdkZZcndxRlBXUk9RUzVnd1JRRURR?=
 =?utf-8?B?cHcrTnlkRFlFNjB5QUVZTFdYcVpxcDhsSnhvZUxIbUVOT3hpMm0vcnorZmlr?=
 =?utf-8?B?bGR2Z1pvb3dydFFyRzZ6MGdTQ21FZWVkUXVyVi8xQlkxbUVtQy9RYXM2ZXlY?=
 =?utf-8?B?MWlCRWYzQkkyVk94dnFMd1pCTDkrWUpxcm5JYmJZbTlBSWtCMnVna3lYUkVN?=
 =?utf-8?B?ZGR4allRUlVrd2d0V2tPRHdVZXNLK1Z6a3NvNU5mVXlDbFgzc0liZWtGdkIy?=
 =?utf-8?B?V1NXYmRmYTRsRVN5MTBncnRFRDV6cy92NVJFbmVNbVM2NzZUekkvcDhDQi9D?=
 =?utf-8?B?SE5xVTNiVlBvM2lEMGpWd3VHWFBwRGE5QlpwcXp2eHN2V1FaZ1liTER4T3l1?=
 =?utf-8?B?R1E0Y3hOYkw4ek5JbFNnbXBWQ21ud002UUg4Rjh4ZzN3LzltSG9ybE9oTTNm?=
 =?utf-8?B?SDF4akJaY3lPSC9GNWo0WU1uS3p0cHNNUUhLakIxT1l2bjR6dVFjUkR3TmxV?=
 =?utf-8?B?dFlLMEtWYlBwZmNBKzA2Lzk3ZTlMTGJ4ZHo5MEIreEsvMExMNUU1ek5kc0FY?=
 =?utf-8?B?WEdVdHdIOWtWWEVSa21DKy9xUjcvSlFPZzRQdkNoQWdPcUV5TVFtVG80aVJ1?=
 =?utf-8?B?YlJneCsyR21uTDNKUmZaM3NVQ3VsVW02TTV5cno1RXlIRHUydmVKS3U4ZjBV?=
 =?utf-8?B?QmtZOFBmMVZvenEra09XV1FuVUlucURLLzQyVWErY0QyQUM0dTlRTFNITDZi?=
 =?utf-8?B?T0tWVld1UmtZN0lPMzhubFBrU09RK3g1R2kzRCtyNnFuUUZEa3g2Q2FDU2RB?=
 =?utf-8?B?Q21vU205dTNwYWFyYUF0RkM2Zy93TUdmN0RwNURjVlUwQ3E5NlhrM1Uyb0Rw?=
 =?utf-8?B?Z0xhZ1BrMkVqVTlmeVFtemdDL2xBMlpucjZCRG5tZTVQdmtsR3Q1OUppTEFB?=
 =?utf-8?B?TnB1OW1hT3dzUVZWRzBGYnRERm9OWTljRUY4SjRPWnF6aXNnOFdpV3JIRzE4?=
 =?utf-8?B?UFl2Q1Y1aXpxakg5M29NeWdDZTlvcGlXSFVOMTV1cXhYNXdHQWljTE8xS0pV?=
 =?utf-8?B?ZkxXb0d2Z3NnWkdGcXd6TFRMYStLUkJrbGdpcnBDby9aeTh1TDlWdFlDMVVI?=
 =?utf-8?B?OEFXUHhlNnpVeHFTZWN2b0krY2ZpYWJqenpyQUx6T0hxeC9MaEhPOFVmakpI?=
 =?utf-8?B?d1k3YWswVnFSUFBOV1ZzclhYbXRWbjJlREg0YndUR3hjQkYxQTRlOW0rMERl?=
 =?utf-8?B?MFJ5dy85ZlQwMEJ0d0djV1hodXEvUkh3NC9kUDlOc05EQlVXcXExSUpBWFdF?=
 =?utf-8?B?enpiT1VObHJYdUpxbVlINE1uWWR5eEd4clJjcmQrSTlnUmw1N0Z5Zko1bFF4?=
 =?utf-8?B?ZzMrSUZhQkM5TDB3Z2NYVUlJcGs4b0x2L0pmemloWG15NHpxUy9Ic1VaZmtI?=
 =?utf-8?Q?cKdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S28zVGxtOEl6WUEvOElnZDhJWkZVeERYMTlqSFBFRS9VMnllYmsydW9udWpQ?=
 =?utf-8?B?SXNXR1gyb2RhV1U4d0xlNEIyK0FZTGlCeFM2RzBJYjQ4NFRxM3NrS253Z1FW?=
 =?utf-8?B?OG04a0pqV3RrckU1dk5QM1A0RkRZdGh1UEZEWVB3ZjRwS2s0SkJvU0UxSnRR?=
 =?utf-8?B?dGU1c1o1a0dlQ3BmaEVWTVFOQlNCd3JHaUczV2gyUDVEdHNVdFY5Nm1iUmtR?=
 =?utf-8?B?MzVhNm5qSTd1TjE3ZnErWXUzSGhDbE5qcTZjd3d5TkRtK2ovZUhDTStPeExE?=
 =?utf-8?B?RTF6L2lNY1NRUFRlakxyNXVZQ1d2SGZnQ0ZWZ1o2dzhZcyt6RmRJbFFVN09F?=
 =?utf-8?B?bXNOUW5jVU9qbjQyOFFCTWpSdTNOc1ZEM0k0UWg0YUdLLzJpUEpCQ1BMYy9D?=
 =?utf-8?B?VGc4Vmk3UnRDOFEzRmlZWi9ja0VNM0FZNW0zNGRldW0zMjE3Ym5IRXFyVEJH?=
 =?utf-8?B?bDdFbW9Zam4vL1QzYkVESHAycFpxM3d2cVdRL0IwaDY0a0JvMGQ0SzNKdGU4?=
 =?utf-8?B?OFRUUUJHOExSbFlTM3Zra3ZhdGRqakxsbVpyNHhlemFtSjg5ZmVObSswaXVB?=
 =?utf-8?B?VHlYak1lWldLSlBXTDQwWENBRjhtT3JJeTlPVFdLM282MkdpbHJ2VktvU1Aw?=
 =?utf-8?B?WmEzcFNVTjc1RXppRGx4dkwveC9YOWQxNzVqMUxLVFIvcUFmZjN4RW5xRG1H?=
 =?utf-8?B?VFF2UHZVT2RPRkJmSkFRQkR2VFh3LzFNeUZkaHRUaUR4ZFVOL3FIVlJnYTh2?=
 =?utf-8?B?NWZYK3U5RlNDVjdFbUxrblMvSnJLbzFwUjdkazJaUXlxWnNzUGthUDRzdlJr?=
 =?utf-8?B?d2ZLRW5ZQnN1Qk0zYjN1NmNqYkVEZW55cW1Wd1FaNnMrYW8wK1hOUnR4dkxQ?=
 =?utf-8?B?U2RBMERFRHhzc2s4Rjl6OVVYcm9PTHBYL2tRYjd6c0xFUjhRdCsrZmNsU1J1?=
 =?utf-8?B?K0Fka1RZRCs2cW9GNG5jZGtxMWhRZWgxT3Z0cDE1VmYzN0d2V1JJVXVvK0hz?=
 =?utf-8?B?WEFWb1JzaEhOam5uRXlDOEVjbEp0SUpOYnIreVE3RHpqOUM0Uk1jMzJ2c1k5?=
 =?utf-8?B?QVFtdXhKb09sQjFoZzBFZC9VQS9tWkNqUVNUTjgyZzdvNUFZcWVuRGw4VGRW?=
 =?utf-8?B?K2E3YlpWeXJuRm5xY3ZOQ0JQZlVzZTNmbU1UbnpPUjBJNWlGb0lWSUMvRk9Q?=
 =?utf-8?B?ZWZacFdralVYWkNHcFFlV25CcU1DSlcrNW1yWVduYUx0UHl0K3ZwYmxMeCtn?=
 =?utf-8?B?Y1grMXE3a3J1ZWZYcFp2TGhWYjhOQjM5TnBVZnBRZzVGbUVSWWlBZU1pNmxk?=
 =?utf-8?B?aGJkS3B3b2dmVW1WSWV6NGVqME52TWJ1d3VFam1mVTJxSzZHeExrZ09Wekp4?=
 =?utf-8?B?Wit2TXVJRmxhR1k5cDZvaUx4Z0o2UXI1THJ6TjNlMmJBbDV3elZjY1NEb29x?=
 =?utf-8?B?ck1pb09lRis1YVZhS0gwM3Z1N0ZpZGgrRGNDN1VNWjA0Y3V2aUI0SndzdFFR?=
 =?utf-8?B?aEFoMU1BWVJIcG1kTE9EODhITG1WQzZqanBPZjc3a2NFNEFreFJvRjJaWU5o?=
 =?utf-8?B?TnZQM0FoTkV6VzFCVzNwbi9PMVc4NE5uMUY3QUhhRjBwNVVYRFRIeTdvREdB?=
 =?utf-8?B?OXAyQWNyeGNXV1FnM0p5YW9zb1k3Nm1zb1EyNU9vd3JPaG90aDNxUTRyckZZ?=
 =?utf-8?B?NlloVS9GQzRJejJFelR3SU9ud1Q0K0VhR0lNYkYvYmdwL0p5dnNDNjFkOXB3?=
 =?utf-8?B?MUk3NHZ6NFZVSExIUVVieHJwdlV5WDVhdnYrTVA0TWM0UVdOSVI4ZHBJM2hE?=
 =?utf-8?B?Tys1Qnh1STNMaW1xd3JyZ05PSW9RU05YV0FhYUVOT3lIaXBZYTlCT0NYSTJF?=
 =?utf-8?B?bkxsOXA2L0tSRUptVjU1VElhRGZyYUtlbnpvUWxQUnpZNWQ3Y0NyWXJpMDVC?=
 =?utf-8?B?YWVjREttWVJLMHc2T0NVMFpLZWFqVDdwMnJrd2lGR2xCOWtMbHFQY2JLYXRp?=
 =?utf-8?B?enV5WEo0bE1jZHlYYlR5M08xNGxCOVB6SElxRnBhT25xeDREN2xYSkd3VFBO?=
 =?utf-8?B?S2NhUUVkeFkxWmFHbUpER1JtRGQrVVFScVBxUmZZdEU5QWFNNXJpN0RON0pM?=
 =?utf-8?B?SW9RTzRqWHl3dmZReGk5TmpBQTN5TVhXRzBpZVd3WDRGV2RVeUs2NitlSUkv?=
 =?utf-8?B?eFdUN09TL2lCdkdrUzhLd1RvMU5NNVAwMWZNUW9nenhPQ2dBSTNvWDQweHcx?=
 =?utf-8?B?Zm1qd216UmY4cXNjN1ZkSUdtLzBvRzZ6eVdQN3N2YXNmRkxtK1E1Z2lJb0xw?=
 =?utf-8?B?NGpCU3lYcjEwc1hOMk9aSGt2Qm13RERRWUw0ZUowS1BQMFY5bDcralFsc2dB?=
 =?utf-8?Q?C9V7qwL/DUeuaSuA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddca205a-e472-4196-7c2f-08de540a9700
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 07:49:19.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2KfmNoTpuLtxb+nlyAvY6NCdpICDx8i6BrF1z7JQwNkHFZDOUr+F5uQdAILF6n7Mt38lB76cb5kgyZEWho5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB10125

Hi,

On 14/01/2026 14:28, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 10:45:51 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
> 
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> Hi Tomas,
> 
> One thing inline.
> 
> Thanks
> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
>>  include/linux/iio/backend.h        | 17 +++++++++++++++++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..0a98fdd5df9db6cc233af819ac5243ba8cd5266f 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -56,6 +56,7 @@ struct iio_backend {
>>  	void *priv;
>>  	const char *name;
>>  	unsigned int cached_reg_addr;
>> +	u32 caps;
>>  	/*
>>  	 * This index is relative to the frontend. Meaning that for
>>  	 * frontends with multiple backends, this will be the index of this
>> @@ -774,6 +775,21 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
>>  
>> +/**
>> + * iio_backend_has_caps - Check if backend has specific capabilities
>> + * @back: Backend device
>> + * @caps: Capabilities to check
>> + *
>> + * RETURNS:
>> + * Non-zero value if backend has all the requested capabilities,
> 
> It doesn't...   back->caps = 0x1, caps = 0x3 returns 0x1 which
> is non-zero.   I'd do
> return (back->caps & caps) == caps;
> 
> Though that also rather strongly indicates this would be better returning
> a bool.

Thanks for pointing this out, will fix and change to boolean return value.

Thanks,
Tomas


> 
> 
>> + * 0 otherwise.
>> + */
>> +int iio_backend_has_caps(struct iio_backend *back, u32 caps)
>> +{
>> +	return back->caps & caps;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
> 
> 
> 



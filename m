Return-Path: <linux-iio+bounces-27083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DBDCBE1DD
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1906303B1A3
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83202D9EEF;
	Mon, 15 Dec 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="eDH5fseS"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023100.outbound.protection.outlook.com [52.101.83.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49B2D47EF
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805635; cv=fail; b=B2VJEy9lVpXnILyp9dopYmkLzFdu8DQY+iDFjMI2v5edMiCne3l34Zd9eN3UFJy0EpdnbSlymS52iWg5CQvI+mwLrlPHLM1vz5M9dt+avdXaW6bM8hFZS8nfK6+6nOGIe3WwdQw/Rlxx7Mpgmvki0E+03H4Ag5B7H+YBt0pS6Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805635; c=relaxed/simple;
	bh=LThXK7y3KqG1BozIh9LZMnCHtE/CjCESoA2pWcR9YOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k8oDB8Ed6L69jX8AmA9fX7QEFFLbhys/u1yC2d4Gt5Vdrvwr4QXakqQsFr+c2ugXSqxEMlWpFm64wKkXWY1bjQx33u56UNxj3zb2jSdWUzRj3NMV3jwIIFitR2ylYkLorLGe4AteXrZVmKLhrwO1D6LBlSva47iv7z7UZX1nL4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=eDH5fseS; arc=fail smtp.client-ip=52.101.83.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f69zwIqPkBVGBTGAWgaxaExnBzkmnbCmKL97wCBrZc9fTYFdkRN6hy/oP+b4Xa3PPg5gf7AH6dIeHuzp8dYpi+aLkAQtwKlwii7CwwH3dJkzH5Sj28cFoesafRmXfy1LWRwUu+Oybp6oOHGIeWVh8HyH+IMApoaRsGRscdEenhwwSKhTWmxkcZ3VMXruYhVfYSDl+zea/W4hCNAP6VI72zPLXdQ95vv+qkRXy7x252Aq7VIrUyvrdbsgPRWr/vMgjKhFcmreF4k1FgUqAIxFBDwCksSGUo1f/X/X36xPzwoummKKBQWnYg4axmlbqFhD0pf+AUwzX0yFjOAOa+JauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcsGKzEqovwpSaIzXwA0WNfNPvJyvlswyQNfhiVzOP8=;
 b=U3+ujGeydohigfpnEya49+e0Xgd4Y1/j2t9Vf2Sj/5INSU0eeZ4cCFZQ/HkVwtraXBaSnCAKq64ENz5kp2JQ45mrCeQNsGjhQ3WDhO1fo643BTN0i49fF5ZrBtl24sSuNN9FWvYy6NC1nXFZdk0oW/lyv7zjUU3t1uuNozfn6w9OQWGVBi/e+0ua+VeuTpq5XPRyynq+S7fl7SN1pWrXLjIT4/1Zb1FHy6HK34cyDR4HZTqpd0rzhXdGfoC/TQhmDe9J7utsgDHUb6fYWzzfu3Ed/outZVS1Dz4UhApNzR2CShCQl7/m1fey8CthQ2l5NXpSvXFdsKmY06QgIIJXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcsGKzEqovwpSaIzXwA0WNfNPvJyvlswyQNfhiVzOP8=;
 b=eDH5fseSL0IPhZ6UGR3v6rxEoM7nbPW1Y0++2zVD4S2o6tyI0R5ks9oV9WyeiLIslmmGoKf7psdu9kTAfDnMCWO2UIQRepo9yQSuT34aA+kNaoRKI9QeEnOhuhtbLxWgJUK2gZpavHUlTxTnUlJdyvYIGmCaw5Nb9Rn0RL8kYuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by VI1PR02MB10180.eurprd02.prod.outlook.com (2603:10a6:800:1bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:33:45 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:33:45 +0000
Message-ID: <78de7c11-5724-c3ba-4a32-0dd0f8b4d74f@axentia.se>
Date: Mon, 15 Dec 2025 14:33:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: core: add separate lockdep class for info_exist_lock
Content-Language: sv-SE
To: Rasmus Villemoes <ravi@prevas.dk>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>
References: <20251215131723.4130826-1-ravi@prevas.dk>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20251215131723.4130826-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0076.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::10) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|VI1PR02MB10180:EE_
X-MS-Office365-Filtering-Correlation-Id: cd56de42-9480-493c-3fde-08de3bde91d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDZTZTVuN24xZlZWamdOc0J2RFM2aVdua29ZM1psYnV0Q3pneTE1TW4waHl1?=
 =?utf-8?B?VmRiRi84MmltQXZST2RpSE5FbVVRdDVFV1VMMXBSNHhOTUIwUXd2SzBZSnpt?=
 =?utf-8?B?SHhIc3ZLd09JWjdtcTVYbVQrUCtiMzRMYkpXWjVEWU1BbnB6NHc1N3Q2akNn?=
 =?utf-8?B?WFZDQXVDOGl0d095R2RjS1pYd1o2d2dNcVVsMGhsWVdGaEZaQTgyNEVWcWFK?=
 =?utf-8?B?dXE0VmdySjFLMTdRMWl5NmZUMnZLOURFeDAvenNsR2lDUnJiUVFZblNwM3g0?=
 =?utf-8?B?OE1OUlNGRVNyKzhZbnhvU2MyQ2lUaW44RW9wQjZOdkU2bUJZMC96S1M1UVVQ?=
 =?utf-8?B?T3pkaWlIV1R3emtoV0FqWU9KQmdnWEhmazNQcGl0a1lsZ0pEbjRFY3dZdjdI?=
 =?utf-8?B?c0QrYXBYMWw5TnI0cFQwZHlvUlQrNWt0NXNZV1dCMkh2dU16UHROS0NrQ1dQ?=
 =?utf-8?B?UmxCRmI1VmphRDlMNWRrL1pvc0M0UE9NUHkzNUlNcGI2TG1Xcm5HbXdQRkox?=
 =?utf-8?B?ZlBDb3VtcU9CR2I5RjE0TWhPNkJINVZsSDR0ZVo2UHpGVDFseFB6WFpiaXVC?=
 =?utf-8?B?UGRvQzhxQndoL24vVVpLVUt4N2VLRXhITTFJV3huT2RrR0JCcElXWXZPb2dJ?=
 =?utf-8?B?SGxtYXV4L002Mjg1am1wNk5jUmVGdjU3aWJBRXNqRm1mWk9KTEFiVmVGWGo4?=
 =?utf-8?B?Qjc3aFNxMWpHRytZWnFEdVNUTzZ1N3VwY1l5QmNyMi9TMmpudUc0RjFuOG9I?=
 =?utf-8?B?OVRDcVRsWkZPYVNVVzcxcEIybktjQ3lSYm1BbWRuQ0NHRmtTUWFvd3J5ajJ1?=
 =?utf-8?B?eWFlREJHRDFLeEQzOUxHTUlZc2FTZkRVUFdyM011SzZkOVBXbEZwOHVxcGxL?=
 =?utf-8?B?SjM4ZTZMUHJNb2k1cVVYcmhFZTZsRTlsYW5KVmp1MWdkenFtZkhIZHUvWFJU?=
 =?utf-8?B?cC83cjFLdWw2UHErbHpHYVZrNWpCenM0blZTa01ZbTlTVlVNWWIrTGlaTFRz?=
 =?utf-8?B?b1NreTRjc1ZVcmF5TlkvOWNTZTVXc1dkMFZIMmtvdk44Tk51UG1FMTFyRzFU?=
 =?utf-8?B?MUpGYlpuZnF0dDVkd3M1YlQyQWJmRFRPdzBYejBvQXUrcXliVUNNdkVLd1Q0?=
 =?utf-8?B?b3ZhVVJiNzl0VU55cnhGN1VRYnpXMThmVmlza2hudVozUWFEZ3lJOGV0VkFI?=
 =?utf-8?B?dGt6MGdobUkyN29teDhXeG5JYzA5dkM1MW4rMUZtRmUzdGtBYkJYVnZJMktK?=
 =?utf-8?B?eDF0M1JiVlJKTnNlczZUdlB4dFUzbjZnVzRmV1hOTTI5Y1VyR3dqakRvOEpo?=
 =?utf-8?B?cEFhcnUzN2VmaFhkbWVWeVUzblp1cVM5a0NGSWdUVWx1dWN5Uk9UenRQM2Fk?=
 =?utf-8?B?SHpsTjJ2WjZTN2p3SjhJaW5wYkZzaFNtYmVJY3NhQ05YNEcvdlVzV3M0M0dn?=
 =?utf-8?B?cUw0bDhoUGVHODdIcW14b2tacFR1c3dyZEdGWFVtdWpaL1YrSTl1MHJjaFZJ?=
 =?utf-8?B?KzIwN1IzTHp2a1k0bjkyclFTNFdSSU9iNG1ZMzlwcU43cnRqNXdXdjl3eHpl?=
 =?utf-8?B?TVRQVUUzTTBUMWlzaTU3STF4UFl1UUN6RFAvNTNHR0EzaEdaY09yQURtOFdE?=
 =?utf-8?B?V2ZFdmt3QnBxd3Q2WTR2cU5nN3lFNVNYZzFpNEZuSUlSbmpKMUJpdjV5ZVV1?=
 =?utf-8?B?bE1EY0ZBWVFtbVRmS0JIaHo4MklSWm1lemJ1RzVOL3lMbWpSVFptT05Qbng1?=
 =?utf-8?B?OUpxWVBwdjArNWZwN3VTWWN0VU9hYjJwWURLNFNoQ3hYRVFBNGIvYlU4Y1M3?=
 =?utf-8?B?cHlHc2Y1eDdsMGRhK3NnRHlzSXhDTW5xbGV1WjMyMGJscHNzLzI4QmNZVVV2?=
 =?utf-8?B?N3R6ZThNN0drcVJOU3IyZXZnS3ZjLzloZWJkZCtqS1p4ZVFCbFpvc29BQ2lh?=
 =?utf-8?Q?YEGaElQE0wZ1aDLe+e1dX5kdA0LSxfTz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNTRGpzQWZiWGx6anBsUlBzeVBSZ1FKSVBNcWxQMHF1UkZEZHJWbExHUnRQ?=
 =?utf-8?B?TW1hNHMvNVJwZ0x3dXBjSCswYms2RGtlK0FLaEpBQ3JncUo4UE5rd0M1V3Rw?=
 =?utf-8?B?WExPS2FPVVVOOE0rSHF6TzI0QkM5VFBRc0tHa1pkWHJTZUxsRDdKbm9oRFAx?=
 =?utf-8?B?STVLbElvdmNtMEQwVU9pZmlWUUFHMUJvZW5XOTRUMFByV3ROSTd5VFdzRUlz?=
 =?utf-8?B?TTBrdDFLQTZpVkRCZnIvWnZNZ1VYRDBXQkNXSjc3aVNEOHV3WHBYbDBLU3hT?=
 =?utf-8?B?SjZQcURXV3RERW5tMnJMQzFHcGNOSU5rQUs1VVduL0FaTEx6L0pwNEZvNHd3?=
 =?utf-8?B?Nm9Qc2pGMzZZa1dXTjlCS3RFZ0pFK0MxZGp2Uys2ODU0aE9DWGV3OUY5T1du?=
 =?utf-8?B?cE9hcVFFSy9xaTdsNEZXbzJ3MkFZQm1mb0lHVnZaWm8xbXdsZisrYjNmY2NR?=
 =?utf-8?B?UUJ5L1I5eGtFMzdoVlBuTGxlbTRyOTlnbXJxSWp5YmJacG5EdjlLR1I3L25m?=
 =?utf-8?B?WHY2YWEzbEVvRGRySkptRFNDQWFoWC83dlgvN1U4ZUVEZks1SkU5c1VTRFNI?=
 =?utf-8?B?S3p4Zi82clhHTnZkeHJOa3JuUVMzK1JkamxTcHAyL3phRXgvdkpTSzJ3dFR2?=
 =?utf-8?B?a2VGTnRlM21td0d0eWdtSWQ3Z01rVnNPa2d4bjFVL29DRlZwUitoSDkrd3hT?=
 =?utf-8?B?L095clRidHkvR1FGNEJHK2VrOUc5MUs4MnpSVEdsUzM5ZEtzNWlaVTc1dUJu?=
 =?utf-8?B?RW84cHdNZ2VUNmdJcjQvSW14VEdEV09jNWRsRHNvVTM5Smd2TnZ6U29LRXds?=
 =?utf-8?B?eW1jckZoYTB3VVQvVGcyN1F3RGhJV2VtS3RkM00vSFpDUVhZTWpOOXlNNXNK?=
 =?utf-8?B?aGNXRmJGSmFuVUs2dlA5U3h3ZUhjSE9HcGFVend2RlF6OUxmZVJrczZmc0lP?=
 =?utf-8?B?L3luS09UZ1ZHTFdJNFFkZ1p4OVNqOVUrWUlCWDJkR1JDQU1XSEp1R29zcXpK?=
 =?utf-8?B?UnJXYlhYRnBJVHd0SGVmTzdMMUZQdEFGNzhvTUpaS2NJT29NNThkL3JpNHVj?=
 =?utf-8?B?TnY3U2VxNUhxc3Q2WjEwWFpPblV4UEpXMmxWSkFYWnA4ZjZCWEtCbmlaMklh?=
 =?utf-8?B?bjZyNDJyTTJjakp5Z1JrbHBlblhOZnBFYWFLMHQxekcvSHpLajYyZ0tCVkg1?=
 =?utf-8?B?NWhiRXQyMWZRSmpoTW4rRi96eFhJOWNNR3J6a1ZOOHl5dGYwejBsL09PT2lw?=
 =?utf-8?B?Y085dXpUdDRvSEFzS05VbFI3bnB4dTcxZlBZaU0xTGxaaWZHTEJESERFNDJh?=
 =?utf-8?B?ZmJJL0FzYndWWDdWUWxWV2VQQ1g5aFBaOElHdHlDUnF4bWVwL1VLSFE2eUdD?=
 =?utf-8?B?ZnI2M1pKM3B2NUdFZGRZUUxCUUdCVE5NeHkwRmVkV0kwOUlLUWxDRGMzejk2?=
 =?utf-8?B?NHkzenppVTNWUmw4YWpwN1VrYUhpWmphaXpXV2xYUExHemljci9aU2FRdVAz?=
 =?utf-8?B?QnBLODFMNU9yS2NpOFFIZzlTcDRBQWwxV3IzWW1sVmFQbURidEdQSVIxSlRr?=
 =?utf-8?B?YjFkTmNTREpWQVlSaXNsajlzVHZZTzF6SjJsckhxTGF5aVd6TWs5UFovcm5w?=
 =?utf-8?B?REp4bmQ1UFAwSjZWeEx1R2loZGhiUTVHNzhnSFovRlBoemZZS1FHL25HWnhj?=
 =?utf-8?B?Si90NVF2QnFoSmdScXQ0QlhTVThxdG5NZndiNkllWVhkZFhGQWJXSllYNFFI?=
 =?utf-8?B?NnBib3RURTYralBMR1ZWdHFSb2phMll3SlRmYURkNlVWMVNGeTQrdU5Jek1s?=
 =?utf-8?B?U2REQnZGcDFJdzFkR2hGVWo1N3Z3eU1rdFkyVmJQRzNISEpzQmlTc2ErN2pO?=
 =?utf-8?B?aEJXTjhBTWQ3emd3WjZadDVBU0x1R1pBZ2VISGJZUzJ2UW1heEkvSlFidXZR?=
 =?utf-8?B?QVdkSXlwdmQwMXZYS0IyVFcwS2hBR2ppZnp1UDc4YTg0blpyQVJBRzRzcjF1?=
 =?utf-8?B?b0Nza084dkRYdTUxQUNDLzY2L2p6d0hsbi9tMzQ1aVdvR25nbkd2Y1h2VUhp?=
 =?utf-8?B?YzNDR2cxeXlKRUJkN0t5YzJYeVBNN1IxcGs3K0k1bHBubkV4QmQ2YVlicno3?=
 =?utf-8?Q?9SV0anBE1fIBfEh5uftB96eAb?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56de42-9480-493c-3fde-08de3bde91d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:33:45.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv4tx/f48LYKF+Un3njoFqtFU/tFUd6Hr/YFQ1AAQS/+iE+TB8FApgk0XtmZC70B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10180

Hi!

2025-12-15 at 14:17, Rasmus Villemoes wrote:
> When one iio device is a consumer of another, it is possible that
> the ->info_exist_lock of both ends up being taken when reading the
> value of the consumer device.
> 
> Since they currently belong to the same lockdep class (being
> initialized in a single location with mutex_init()), that results in a
> lockdep warning

...

> Just as the mlock_key already has its own lockdep class, add a
> lock_class_key for the info_exist mutex.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Looks sane from here.

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter


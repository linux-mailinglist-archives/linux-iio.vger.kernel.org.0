Return-Path: <linux-iio+bounces-26941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62DCADA02
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4163043F5D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B02D7813;
	Mon,  8 Dec 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="f3FFhxY5"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB223536B;
	Mon,  8 Dec 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208522; cv=fail; b=SoBF/J4f1ypjfsNVIMCqoA+LIwnc1tiPhYrfm5Ic7q3VFUra1uN5y1iKNgWPp5/JLFN1XLX2e/nFgV50KcM8BovjA7fNLb+zfpeHi2p6oetgOZat2+BdKztQtZDVzl8+zKExI0HoEDw8AWli8Kc6BUuPVaLPE6hwSkBBUce8Z/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208522; c=relaxed/simple;
	bh=L5guroNYSwdtjftFH+LRcUNbV0aPlfzXXY6lYoETT6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDdsbUdzdXgoshm7WjwOFaVmiy1Row6yTsTiDU7fSb8EIQAyfycrkYfeFLFQ4KOreB0vHbqwzsPH/dSk9M/SLNaspZ/ihjCENpAeBwyrs8HbmFut3bx0s8rxdUk+WvMRZAKitYbnRxe1Exx0B64j1JjuPwjfKm72wOLKphyk+aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=f3FFhxY5; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG19U7QXNBL6F7ZLcoHq34jAyyyG/Ce7/fXxXQczsfOqnNyk7yLtb1KOpnBwY7rSX+tY3eOTgmwb4/HbQosMLULd7Hn/2Y7rttVLDsL9brHiV2qll4z/H7osH4j+TrIxNHEqBGFJZ6RKw1XWu+RgohdBaaljs2kbjZ5T3FPvz5kw59sqYTvrVyAzYxuJmky4KbzOFb6QNuEG9LJeXd/1oRd0SqmGC5aqxX8/NiReO/rKH2eoj3PirG5m3d4BhJPbi8fADKrCJx55p1mDxojLvP/6Ky/Km8qsq4tePnkFXIAYpAyyU4cxpyasIKY4F6nUvdYi25UW5Dz0lmuFS6I4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzpsEcgiBmrN2EzW6duuMJdt764wdF5APz6mIiE8KGM=;
 b=qZyIYTpQEonQ4+Iv3onMQXRn1s7ILelCgnJtzm2aQzt+cgds1fbukqIwNFwopxxz81PpBy+L0cyi6wtzCbLzmd1+En9d5+2VSzI72dszo4jBIPl9ufNWUBneee6yo/ri8f2ti5wbwsXfNhqg6c6JevdAt6LuT8C1Y7raqZS9nJCUr8mHbUOZRTzYhRX3ZpSLel8TNYZ8ssnmS+6N0wN/tX4QUWr3xR7qpN+9OCPi2DSvu24RAeZoOlPNxMp+jBNSEgsakkd/CNek+jdKGH3NmO2fhO3VbsSVbQ8sF7m7Iyt32JizawTsDhfKWDcH5q/Pp/NLxoeMZ2LXK8FXnzGv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzpsEcgiBmrN2EzW6duuMJdt764wdF5APz6mIiE8KGM=;
 b=f3FFhxY5d7iMa0qFuNu9vcvaSU8Qa6p7d+VCX/1zPhFPngXQfDDn06hPoA/gJUWu7RpPnHbw7w5WFWW8kNnIhZeOyLqegU29jbGc5pyZboIEG9WVy0mD76D90wnzBUDRiixcgubTI16bXLbemw4pgvPOR5EK7bVgHndjWJoOJTbCJYyOv2J6Hw7ctLCoewRHcRHMT3ct8cGxM9FrxtRt97+SoduVC38UlVNjlHv+JteXHjWjetZ6dj/bEkNk2bvXwLlYwz3ngyl0yIlcrWLcZLU5CDRDc27gNSbzfSswzQbnzre3zdsypkM+6rTp0D6G0I53lUCM8QyHStrK3vg8Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM0PR06MB6482.eurprd06.prod.outlook.com (2603:10a6:208:19a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:41:54 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:41:54 +0000
Message-ID: <1467f6e5-9d50-4b51-a283-aec19c031470@vaisala.com>
Date: Mon, 8 Dec 2025 17:41:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: ad9467: drop kernel.h in favor of
 array_size.h
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
 <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM0PR06MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: f66514c6-1af4-40cf-2e7c-08de36705058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1k2SHlaZHRveUR5eDExRUlpUlpyT2JXZE1wRnV3ZGhlcTBTL1ZxeEg1MW1B?=
 =?utf-8?B?RFdlQzM3RGZ6SnErT09Vc1BQZHlMZzE2cWZiK253SzRyVC8rY2c5d0hCWng1?=
 =?utf-8?B?aGk2WE5VSyswUUdCZVRvQ2V6SHhRYWlWVjUzQzVqVWlsVUs1UkM2amhHZCtU?=
 =?utf-8?B?amErVFo4YjZ1d2ZuWHNnVkVML09SUUZVbnNFQ1RSNWdMT3lyZG5ZMGl2Y3lY?=
 =?utf-8?B?dGczTmc1U2hXY3lKMFg3TDhqTFJLZm9UaGN4ckVYOUtPb3FEeStNaVh1d3I3?=
 =?utf-8?B?VHV0RTlmZDNWT3RKYm43TytnWkE5djNpUWRUOVNySEVmc2w3QkxWTmxJUTM1?=
 =?utf-8?B?bk5rUjVuT1pSaWJ1d0dKZ00xeHNVUjUrN0x4aXBzT2dSa3V4MUVHcGMxakxx?=
 =?utf-8?B?c1ZHV3YyMk4xYzVkenNwVkoxTEhaWEJEbVQzR1pLVEVxajNmbjE3a09MeHhr?=
 =?utf-8?B?ZTZTRUpFeC90SHhxRHY2NzNlQ1N2MUQ1NmxkdkZwVmU1TWJiSnNxTHZPL1JO?=
 =?utf-8?B?aDBDZ0orWTIvZ0JtbGNWNFJEVjVFTW4wcGZTbUltYzA4L2tYTDFudHc1S2xE?=
 =?utf-8?B?ZWtIM1VPMzVNRjh2czhLQzhyNTVzaGxVRFV6MWpKUkx2Mnd0N0QvSjFQSkhV?=
 =?utf-8?B?OUc2c1oxRHlwMlhVeEx3cHF2NGNuWFZNbDlhajh3WmNPZFltcmlMcW4wQU1k?=
 =?utf-8?B?d1lERE1oOWVnUzZCNUMrUTNtcUxuNGxvT2NDenV5Z3ozOS9TN0xKQU8wdHdQ?=
 =?utf-8?B?Z2NlZ2RTdlg4THVIczNyTkFwTmxEMTNnMUJQdWpyRU4yaURMaTBrV1hmemdF?=
 =?utf-8?B?NXBueHZhRUFJUFZuVFBkQWYrQWZiSlRVbk04Vmh5SHRKTmVHYmRERmVjUjdl?=
 =?utf-8?B?K3ZWLytIaUs4NGxHYnZ3R3pObU40d1NFa1R4bDlya29nUG9yVVBPajZDZGdy?=
 =?utf-8?B?Z1ZFTGRiRS9UWWQ3Q3VKN0c4aVVmRFdoME1ERHFhUXpyWk1jUVoxRWRKSzRx?=
 =?utf-8?B?QkJ6U2E1MXBQY1hNaEh2eXdRQ29ROVliYTlsdE9iN1FmRG1taHFIbDZSa2ta?=
 =?utf-8?B?d1pvOUZvQ3ZhQnd3d0RjMngzQ2pxOGVOQ0RKVTZ4UUpLTkNnS3Awa3E4Wkxx?=
 =?utf-8?B?ZGJHN0JTYTNBMDdyQUNqV0U0LzNyRFhGVGZGc1c1aGlVWlEvZGwySXRyaFY5?=
 =?utf-8?B?T1czam80TThmN0NUZmN0YjNaL3QvdHJ4NWVJL2wySFBRMGFVYVhobGZkR201?=
 =?utf-8?B?ekVVYWdLQm5lUVA1TUp5R3luekdPNVBZNHZlNnU4V0o3dmxYNXlpT3N3bExN?=
 =?utf-8?B?NFRXNDNTZ1NFZHZ1VTd3dTFXUVlIUGs0TXhabjd3Q3BndkVPQ2I0cWV2MG16?=
 =?utf-8?B?QXQ3cWNraDZFaUlsRXIyaWh0MVFzaWlMdVhCRlJwMy84N2l1YVpVblM2S3Y1?=
 =?utf-8?B?eVpUcDNhRUVOU29tWVFFQjF2R0NJWmFiRElvS3F1amU2Ympzc0xpeEdhM29I?=
 =?utf-8?B?N3BORXVEVmhDd2Rzb1hVaFF4bDZnMUpFOVRRMHNtS0M3bXpHSWQ1RDkzS1hX?=
 =?utf-8?B?a0hyVkx1MGpVWHpuajV5aDhxZDZOcmhXU3l6VFRDWHIzb2JEU1Z4c3NoelBK?=
 =?utf-8?B?TlZXcFREWFJwVzRWTytYaUcrK20zZ3dXbGVzZWgxRzJkNnl1SFIyNDVza2xw?=
 =?utf-8?B?M3dTdGs4OEVNQ2ZlUnhXWHNMSlFONm95QXZ0amZlY0hhMUNGRExKZXcrMGZx?=
 =?utf-8?B?enQ5djZnWU5EYUkxVUhyUWtjbEV1VWNkNzlmNFpaeFR4bGtSTEVGNjh3UFND?=
 =?utf-8?B?UUt5bVcySEEwbFlBYXhEb3ZSeFlMUUYxV2pJWlAwTnVBOUVRalJsT0oyeWk0?=
 =?utf-8?B?b3RGcW5yTDQxSTlJaXBXdjZ3cnk2V0MyZW9lajJhbFMzYzZYQTNGcW1XSGFD?=
 =?utf-8?Q?sZFOdPU6VlppggqZlZBJ6AqdsWosPkHd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRJSzJ0Z2Q5bktKZHlmVG5sUG5lTG93RS9nZHpxTVA2V09vUHhOUFhXaCtP?=
 =?utf-8?B?dkZtN0poc1paaUJxMWxUdGZFd2lCbUVrQkhmdEVQUmRyMFlsLzhXSTRmTU16?=
 =?utf-8?B?OUxEWkhobnM4SHk4c1huNDJEbUkyK2xobE9NNkNETy9lZzBSYjh3c2ptQ014?=
 =?utf-8?B?dldYMGFad29xREtFWEdwZDc2ZzBXR21oOC9EdXpsamlENUpJY2F4ZWpVSW4x?=
 =?utf-8?B?aE5tM0NISFIyQlJJRDBBS0xUd1MzK2lUTTdvVTRhNWtrUExVdHhsWDRyNm8z?=
 =?utf-8?B?ZkVJQmwzZDRGS2xwN0hXZ0JxUnUrVUxuMnZsVE8rcytPeEtLQy9CQVZKb2Ja?=
 =?utf-8?B?OEhMZDVmNlpieVdUdFlxZGpWQXhZRlozNzRoenZUdlhZZmlxVmRaKzJkVTc2?=
 =?utf-8?B?eHk5MEI1Z0EwMlphNFE4RmVlUWxta3RPS3U4eGhmM2lPcGNJMjFlK3JyZlRi?=
 =?utf-8?B?SFNnRm9tR2EyL0lZaFZJcWN0bGdUK0gzbDlFQmh5dzBlWG5WVnRJSXZVbUs4?=
 =?utf-8?B?YjRhSjd6aDkyc3F1OVdEU1BGaURicHNZTSt3M3pwY1oxRERLTXlwVmxZQmRy?=
 =?utf-8?B?YjZ0TzZmRjFZODRkRDV2U3VJMVI0aU5QVGl6cGozSHFueFkwOHVCeWRsNHNJ?=
 =?utf-8?B?OGsydk5IbktTKy9JNDI1TDJUZzNiUytaSzZhM1l4RC9kYzNock42YmZXRUFi?=
 =?utf-8?B?RlZqQUIzZC9nRkZuNnRVOVRLdkpiT2svZVVVSS9pRU9jdEE4SFc3Q2lURUpp?=
 =?utf-8?B?Q3RTWkQzV3YxemVzSlRldDJZL0JxUE5xOWdIZVJiRmw4RzI4dlRUUjZIQzlv?=
 =?utf-8?B?RFJlcS9ldDh6aGRrOURjaXBHTVc5YlZmdWhCb2RkSnJoVFVxa2p2dTY2S1BC?=
 =?utf-8?B?R1VsQ25HWE9DYTZaNW9DNnlaSi9yZjFRZzhnVm9DbzB1ZFBPc240ZENVRnVx?=
 =?utf-8?B?cHo5NDRXWmh1Ly81N2cxREhDL3Nxd0xjWGRUcXdCNXpGMGxyUW41VEZNenVQ?=
 =?utf-8?B?ZUV6KzhaQmZqRjBubFY2K0Z1RmdnbnZwMW40aUNkanEvWTNsQjNRdEl0ZWNJ?=
 =?utf-8?B?azh6SjU4NWUvLzYxeE43ZGhYdzljSVpNeElQUHh1VFNKbEMvalEyNkFCMTR0?=
 =?utf-8?B?cHc3aHhKZTNaaWl0YjJiMFhRbFRmSytjMG1LazZqQUlCOXh0UFVkenhBazFU?=
 =?utf-8?B?R2JXTGIxcm90NFJMcnhGK0J0Zm9OSDFkRG1VR0ZxWmxnejhNTmtGd3J2Nndk?=
 =?utf-8?B?MnR5dUZjNjlNd3VJTTliYmhncHlvckpxcWJQTjQ0OHNEaTVqamFWbGhkWmhW?=
 =?utf-8?B?TXZkZUtFaDBMY1pFVmw0WUt1VElxd3F2WHRGL0U0c1BvZkxMejRUSmo2cnFx?=
 =?utf-8?B?a01XVHpXMlNZaDlMQmR2WEl6bld6YmVlNGJybVE4UW9yRmcwTE14R1JZNGdD?=
 =?utf-8?B?djdWakVHYWlNLzVnWVpoN3pLMmNodHBBMGFYbERXY25UaFZUbHNRZWhWaWpW?=
 =?utf-8?B?NjhEdmxMd3NPQmJSSE4xUHJXUlhEM2NsNjRjSVRITGh0a2lCSVFJVi9YL3BP?=
 =?utf-8?B?UUxkMWUrblVZTE9JWmFGQnRKanllWTNoVUp3OVh0QjhqajAybCtXLzZMdU1O?=
 =?utf-8?B?b24zUFpaL3hJdFd3a3VKWjk3TWlwakJ5K21HVWExMkpsMGdXbzJlSDJYcDhk?=
 =?utf-8?B?RHpVSHZTWGtqUE9LNGl2NDVDSHVTeTJ1ek5USnhxTDRXTVBxb2U2Qks1T1Zh?=
 =?utf-8?B?T0FodmJNRlZKVDlmemJUVGRjVzIzUUo3VEV3T1N6WE95ckkxV01JWnJYU3Yx?=
 =?utf-8?B?ei9IRENlajRRTWx1TXhXVzF6NXdab0NUR3NVOUpDTGFzQ3NRK3FVR0NHcGxS?=
 =?utf-8?B?WHBPYm1TaWpOdm0xaWNOeVJaeEZLeUU4SGhxY21SZklJdi9LaXh3c1FvRVlZ?=
 =?utf-8?B?WUc3cDYrYUNxVkx3bTV6R2NnSzlQcTV6R2QzYWZtODVLa3VzNUx6bVlxblZB?=
 =?utf-8?B?S0xKUXJBeEJOSHhKSTVpZ1dGTFNYTnVRWFlzeGtKQjlHS1J3WkZ2NGFxWmdo?=
 =?utf-8?B?aTY2ZUpyOXlTdk9Dejl5K1o2Z1Y1blI2aVRCTzZ3MkNFUnFvOVNWUTdPUm9Y?=
 =?utf-8?B?TzRRMlR3N050cndyaktFTFUwL214N09lNWJveUhJYkRKcXpoUFBYQ2RTU0xl?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66514c6-1af4-40cf-2e7c-08de36705058
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:41:54.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mid/clAf/Qf75EXrzf7rGRqvlGHY1EDoDBhJ0iGPC+C0bUt0qlnBc1a86uywioAQkwnchWKp+oLIrtkOPju6jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6482

Hi,

On 08/12/2025 15:20, Andy Shevchenko wrote:
> On Mon, Dec 08, 2025 at 12:30:59PM +0000, Tomas Melin wrote:
>> No need to include the entire kernel.h when the only thing needed
>> is the ARRAY_SIZE macro.
> 
> ARRAY_SIZE().
> 
> ...
> 
> 
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -12,7 +12,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <linux/device.h>
>> -#include <linux/kernel.h>
>> +#include <linux/array_size.h>
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/seq_file.h>
> 
> Please, keep them sorted.
These were unfortunately not sorted to start with.

> 
> ...
> 
> While this change is almost (*) okay per se, I think we can address more
> while at it.
> - Make the header inclusions ordered (also fix the location of clk.h)
> - drop other proxy (device.h) or unneeded headers (bitops.h as it's implied by bitmap.h)
> - add missing ones (dev_printk.h, device/devres.h, ...)

As this change (kernel.h) does not seem at all as straightforward as I
envisoned based on your initial request, I will likely change this patch
to instead just sort the headers. Reworking the includes is separate
topic from the intent of this patch series.

Thanks,
Tomas




> 
> (*) no, kernel.h provides more for this driver, for example, your patch
> misses types.h.
> 



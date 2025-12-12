Return-Path: <linux-iio+bounces-27047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF74CB8EC5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83703089E0A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91395265632;
	Fri, 12 Dec 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="0MFm7gZv"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023142.outbound.protection.outlook.com [40.107.159.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFD25F78F;
	Fri, 12 Dec 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547451; cv=fail; b=b6Kpa+9KWqy8cMmjkHQ0thJqVe9a5djMGv4BO5wRo5xaKYsmCJCglaFg9HnfhVJOiREKXbeNrCQbMmoFjtbyzZRWx/jVVkaC6dXF2L2OPgkQi2ANWGA2JBhcZCkAsPLohntU05u9r+Qoi4WcsYX1X3qoKCqhVwvEiqi4BNQny1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547451; c=relaxed/simple;
	bh=a1X/YGkq4vt8+kTG5bskblpg7L+IDjvIG5WpyDm4QPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QCEpiYuStYola7ou6BuX0cwVxUj6ZFQWr7XnxnsJq8AQqBkl55pnfGQahZfV2k8zuX2tSje1LDcdO7rr0vHz7kIyUz1moeOs9x07HxnXrYPVFPFrTNXmyzTPq+8rEOVaaffs2FGfxrgOdhXwQujPMgw9YAEABZWyMZasXtnTPsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=0MFm7gZv; arc=fail smtp.client-ip=40.107.159.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHd70OnvkECUHdDxyTTJceEgMAW2PFV6ZOMh01TLE3O2VVO7CoEoisyNDJcPj2GaDMZ9KoImr1LNhVW9JCTo9Nxr81JepniMO/YBsc0N9o8mT/pbsEuso7BYnTfe0DflpGPT+qzL/O8xGhty/MdQKIwh/5L0hNm45DQH98mUHbnQnLZD6mXkLoG0vhmxAYw8+iTTkMJCytdqQS23gXj5c2F+7h3pan2cNt/+bicJ5QX56dKwCGgOf+z9xHeISRCjy9VRDHM1zLLmS3ZZBgskxE15wgCSQ8tMA3Znehv+GiT/M620PJXk+rPhlPOTLW2Ow02HGouPAMX3G5kim3dCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dVAbVuDdye/R0fnLMhVMiOff1IebZe/KMHRQyN1X2U=;
 b=bnHca9EOk9Ye22SP5FZ/S7MDyzZuBAvGO5f0abqd/Lxxnr90g0zqeNqGNJ9cElk2wikHFd/OE+xxq2USDxdvmWs8PXGo/g+I2dCq2KB4EEfwac/XvB/KaLtmxXoaytPWN/UHArMb7A+5PXJnFfje3jlN5SXpodNqwx3KKr7+3+N7lHywV6pGCaXRTy4wqIjUvYmDDd8QPf6GbhBLFzn7WyxILMUgm1aRwKVKZ/gT6YpUevdg1MyL1LLpslcsqEFpZfw5VJa1btnCsPe+1dXhleplKA/44wRFKxBTu/saOA5AzHdIw6KUV67/1oh0+kvtl6eY9UEge0tRlEX/it4K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dVAbVuDdye/R0fnLMhVMiOff1IebZe/KMHRQyN1X2U=;
 b=0MFm7gZvcg/SsBxWrR4pgcd8DlkSziyT3aWF5fqhtG4c6lNWcpQYTeC6Q2woY1k8VN+gWWZlF5Vt7Pgu/IJ5h+zYmzG1ZTSsc0ovVrTtO2dLfYK0khUVgwUDXgNfQqwIIFZR6sqL4ygZBTCTwKECsYOiNYxky6M++wV3ngy0/+9RoXnq9ABMR5usqL7epptRBmKHavj2av1bmQs/TFaWsuJmaolq42T6w7otLQ7Y6twuoYe5eJYOF2jkReEXuuDVwcs7dh3qf+DHXNnASu9iEzvBt0nnc6INp2Dwpj4u0GVHGh4GFkciVvRFTyNsCO2YEpbTjNQssn6+DiHW+h5k9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB8PR06MB6460.eurprd06.prod.outlook.com (2603:10a6:10:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 13:50:44 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 13:50:43 +0000
Message-ID: <9b18b2fc-3f6e-4872-b222-7cb3d309f653@vaisala.com>
Date: Fri, 12 Dec 2025 15:50:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <8568e452-15a5-4a94-aa2a-b7525888799b@vaisala.com>
 <DEW9HATVCPDE.9X0RFCJ4UJMP@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <DEW9HATVCPDE.9X0RFCJ4UJMP@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::11) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB8PR06MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac3c4ce-3016-451b-581a-08de398571eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1sOFFHZXNleGsvVUtxSW5LeHZKbDJPUUZUNGVidG1nVDlmZmFMZkVwVE1r?=
 =?utf-8?B?TXR2dzBPN0JTZDI0SU5JOUVHOVo3RHByOEkxWlhrNWg0ZEh4bUJpRUc0UkF0?=
 =?utf-8?B?dW1YVDZKWS9HTXlIMEZJa1ArWDQ4ZHpvdGh4VHFhMVMxT2p0VUJxT0grMzQ3?=
 =?utf-8?B?MHY3VmZFdGpid2NCV3h4a0wvY3dUdWFsUU4rMkE5TVgxZWZoenF5WDVQNEtU?=
 =?utf-8?B?WitLU2dpYy9COU1kMTlGVXJHcjJQQXZOUE15YmMvN0oySGJwckZHRWFPdXVk?=
 =?utf-8?B?b2JYb0tFRWl6eE9xTFJMQlM2aUsrMTgzM05UdmtqL1RodlZrZ0trWHFRWGlF?=
 =?utf-8?B?RWpKSUdCUE9YWjFXTHlUZGMwVlIySjlMemYyNSs4TEMzRmVYKzBkRTVLMVlB?=
 =?utf-8?B?R1M1NHc3UTF2cGJhTk9VaWgvU2l4eVBMNVF6YnZQcE5ybEQ2azdSWVlIUnBu?=
 =?utf-8?B?VE5VOWNsL0FkMWJQckVYd0JBY0dGZ3ZsTnVyT3p1WnhTQWJZcVhGYnRIdHNz?=
 =?utf-8?B?d2VrdGFqYy9qTFhPODNJKzlSRXdxbFhGaWhwSUNsckpIdUxrcCtsbVJCV3pD?=
 =?utf-8?B?dExSRkh0OGdHcjcvRHdBQ2lnNVlVSy9wdDdiYTBiYUJhOEhxWVl6ZFpTdnpn?=
 =?utf-8?B?VFNXTHZIaTFwUHZtSWphYUNDbnhaVys0bE9PSmdXNUFPNkdoWDlETEpxRzIr?=
 =?utf-8?B?WEh5a0J1bDV1amp5aGRlZGtHRWlqdXFyTFNFZVd3ZVdBR25CUW81WmFobXd4?=
 =?utf-8?B?bjJVQUVBZlhKNnhUYSt6dGhMREllQ1llUzV6aC9Ga1VORzVDcVdOckRUaGVF?=
 =?utf-8?B?ejBhZnhKa1pTWlBuN3Q5Y2pubnhNMWRScTc0a2ZKamxzdjBnTXI5RXp0eHA5?=
 =?utf-8?B?Y3FROUltR3FvMloxYmNUZitrSFVlVzliOTQ4T09Ick4vNkFyTmI1akx1T1NN?=
 =?utf-8?B?dTBKZHFJMkRiVXhQZFY5OE5Zc09zaktKVFdDeGwvQ2dNVGZhdFNsUHYxMFUw?=
 =?utf-8?B?UUhUTlBoWDhRZ2RtdnNlTS9PWXJFMklyL1JJcTVyNkZYZDBrNHZSdHhYLzdV?=
 =?utf-8?B?Zjkya21yQTdaT0E4V29FUVV6ZVdzSjNFWEVUejEzTm1kWk1LSTR2YTUwc1pm?=
 =?utf-8?B?RlhCT0RHdGwxRDJTbUxqTjR0d3UyWVFzeTRZOTg5M2M3T0NiUlJIZTdGWkVW?=
 =?utf-8?B?N2dFTVBZMnlNMVdybTJiVzNoSy9YOHBvRGR6SkhwTm1hUi9SWmVUanpaWGFk?=
 =?utf-8?B?d3hXdFIvQW9YQ2p0ZXgrZzQ3ZlZySmszVmNVUnQrWlFjdVdtVkNhQzhQN3VI?=
 =?utf-8?B?NlMvRVAxTkVPY1ZFb1pSWXRHNUFGQXB2RTF2VWNFRzFzSTkzV1dXTVlZWGNh?=
 =?utf-8?B?aVdWSUZXVzFrRmYyR05hTldNaWJnVFZCZzFUbEtUcEsrZW1HYnZ0bnR0cFBU?=
 =?utf-8?B?bkVhaG1KbU1jYzllQUQ2U0ZHU2tNck82MnNqVk93YWd2bkZrcThtVjBFdW10?=
 =?utf-8?B?K0hiRlVNb3IyUGgxd3FtZnRiSDE2YVVtbTZvVGJQM0JLNE9KNnJIcG1NV0w5?=
 =?utf-8?B?Zyt3UWlueUZ6QXR1VVdVUWtGYVhXczU1d2V4eHAwVys0NFVqWlpEa2c1eUl5?=
 =?utf-8?B?TThLVURjOWIxTDVabEViVmpkU091Z21UdUJldDZFMm4yaGRMYXNVWVEwYzJs?=
 =?utf-8?B?eGk1TmhodjluNERuSk0yejdrWlhFMzRtR0R1T3B0MEJRUlZ3UzQvNlV3M2lR?=
 =?utf-8?B?Y0ZTaisvZTM5dEVINWV0M2V4MWNMdURJT3l6L2g1SGhsenFQamttL1BzQVFM?=
 =?utf-8?B?dGhkODRDRmRPSGtLNDhJaTdJK2o2QzBoT1Y1aERTOEl1SnFCcmljdmR1Vkpo?=
 =?utf-8?B?bFA2L3BiZnk4TTF3dUlaZW0va25oM3VhU2Jpdm43Z3ZuNUR1d0w1RUNKamZh?=
 =?utf-8?Q?3+GzimZVdTLfY4vFdxQQDE8Ukz5i0AY7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVBSdkZndCtkcktPZ3E2cjl6M0Y3anpPUWlTRmw0NkFQSXBkbGh1ejNqbkxQ?=
 =?utf-8?B?eEYwVHp6ck5rdWNCNHF6cHdkQjhIclFDdHZUK2EzVGx0M1B4NG53Ri94anBI?=
 =?utf-8?B?M1BrNlQyNjAzM3oyWEVXclhidXkrdFdtc3ZJNmdZV2d4bXlzSmZaZHZpOVFO?=
 =?utf-8?B?NDM3MEtyWkgwVVBKTnVaVTRuc2ltZW8xSmZDQnBrVnVWcXNkcjBPRVFZdGJK?=
 =?utf-8?B?Umg4TlRXR0hXSGMyOFF2NUk5eXV5VThDTTUzckZGYXFWb2t1WVVrSExuc1lK?=
 =?utf-8?B?ZjM5aGNJNkNiZ0d5SXVrUFRLTkNSaGxvaEVwT1lNRXVyTFFVcllWTkhYaldx?=
 =?utf-8?B?Zm5uSVZ3REtiME1GVmdrRHNtQm9kemlROWFjYXZydUVudUN2TVRWNHJvTUhv?=
 =?utf-8?B?d2JCblc2REo0LzN1VDVrd3hSMDl3QWFDUyt2M20zejZKeWxXY3RvZFN6a3cx?=
 =?utf-8?B?QldoL1dyT3BVODFjWVpMZHJtMlBkQ1Y5enZCOHM0NUg5R0xoaDlRRnpaWXpS?=
 =?utf-8?B?cmFLUHZSU1pETVY2V1VWRkMxcnVLVTg2VFBUcHllQ1B5dlRyOWFHbm5zVlpF?=
 =?utf-8?B?RHR3dHR3MG9QUmlrTEhySDFBVVdGUm5lYlRuWXM3cmxpbVNkMVZ6T3BGamRw?=
 =?utf-8?B?cVMvSXY5MU81VFhzYkg2Y3hDTjIyc1dkRS9RRnlweWkyUFJSUEhlU3ZxT3pJ?=
 =?utf-8?B?TnZ2WVdqRWVBeTEyZVFZYkUrUUR3NWIwekpYMXg2Yk0wbEIzY2VTbXQzam1l?=
 =?utf-8?B?eFVpRXBISkdIRnRVNXdRTGszZmd1ajFJTzducHg2aHpySFRwbk9UVmQvQUFJ?=
 =?utf-8?B?a2QyVnZPdGpxZjJjSk5NY2JOYVFLU01nL2JpRlVKSHg2dXYwc1gyQ0xET3Fy?=
 =?utf-8?B?N0pmYkRjZmoyc1c4SFM4aFdrNVBYUzVBa2RSblF6bXlHVTdueGd5aE9nelFG?=
 =?utf-8?B?bXd5VG80d1h6T2dhRnVmUWhHNUxVOGs0bFNRV3djMHl1ZDhwd05QUUZrNTJY?=
 =?utf-8?B?d2lBZnBzQ0Q2azZaTUdHWnJ3VnJlaGVZNVpUUVFRM1c4VVdkTENXT2JoN2tO?=
 =?utf-8?B?dGhyT1Z6ZitPZy9lOGxWS25DSGNRNzUxbkhRMElkMUl1ZWpTRUl6UWpOY2xa?=
 =?utf-8?B?WE5kSE92aEdGMUtNcWpzRlNBbVI1dHI4SkhhZzBPSXJUVDZ0TUZPQlo5ekI5?=
 =?utf-8?B?N0dUdDlMN3NQZDY4T2FuUit4VFIxYmlNQ0dwc3llbXQ1MVN5blh2UnJsTGJ1?=
 =?utf-8?B?SUEvVnU5U2RGbkQwR2QwSkI1R0NwSkVzZWZuUnVPRG9JNkxidFU5RHBENFBu?=
 =?utf-8?B?TjB0WnRiajM3QldQaTl6UU1yS3RDSDl6WkdkdjEwcndiSmppd2hFbG9Vc1Ey?=
 =?utf-8?B?ajVTSE53Z1hhWXQ5MW5hVDZ3cXA0UUU1YU9CQ2UwenBDZ29GdCsvbVh4M3l3?=
 =?utf-8?B?SzFKMDFKQ0N2YURGQlVDQ3ZTK1pQaEtXZ0RGUGZxOFZHK2Vock5LUEtkNldN?=
 =?utf-8?B?MFMvVEo2eTJ3RWorUG5aSExxZUJ3UzZRN042ZWlLVllGNEFnSGFOTVV4ZzFH?=
 =?utf-8?B?eXQvMWJiYkFDUVd3VlNON1dzems1aldOWE5Ra3lZMXN3bThVcllaZC9nSjVO?=
 =?utf-8?B?ejJSc1Njd3lCazA0VnkyZVAzTFFNSWNuYUxyejJpWEpORm53aUpMUWVxSjI5?=
 =?utf-8?B?ZzRhU1NiamxLcmxZY25JL3VWOTRpWStkaWZjZGk0dXlCUU13QlpwOCtyMkRU?=
 =?utf-8?B?dTI3QVRiWUptdjlLaWpxV3Z1bzVYL1FvVTJRWG1zaW81dHR0bUVaMEJVQ1pJ?=
 =?utf-8?B?bUtSTmlzT3A0SW96b0QvTmdXMEx4VXNHZEJoTmlDL0N2V1hsVER2K0J5YVo3?=
 =?utf-8?B?SytodEVCTDhMUFNRMVY3ZEw4MWZyUnd0TjBzWElVREZwQndkc21PakdlYzZL?=
 =?utf-8?B?OU9jOWt4ODdzeWs0Z3I3MjhoT0VITjFKMHNxZG1lOUttSWhkcytHcjFYRjBL?=
 =?utf-8?B?SFI1Z0RzMlU0bWkyR2Fqd25UQzNFS0NoNkdzbzlUZEVDbFhHeWxvMTlmQU43?=
 =?utf-8?B?OTh1V25RNEJHbW8wbldONUptTlc5OHNlUXRhUEpJSFlaeHRoVm0vYmp2bjh2?=
 =?utf-8?B?M0JWYm56bHdDeUUzUHYwN05GcUxmakc0Z3Q5SUVjU1BjU1NiNjBtdFQ4c3Jy?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac3c4ce-3016-451b-581a-08de398571eb
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 13:50:43.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMm2LO4PMoRnDgFdg0zzuYZ9l2HHvkJnq8n3MEZyKyuxxxQuce4/DkB2TP9v6HIWewxnnYXWAa0tvwr8nHwG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6460



On 12/12/2025 15:10, Kurt Borja wrote:
> On Fri Dec 12, 2025 at 3:40 AM -05, Tomas Melin wrote:
>> Hi,
>>
>> Sorry for coming in late in the cycle, can you please explain why the
>> driver for ADS1015 could not be extended to support also ADS1x18
>> devices? Briefly looking into the topic, they seem to be very closely
>> related.
>>
>> Have You looked into that alternative?
> 
> Yes, this was discussed in v1.
> 
> Although they are related, these two devices do not use the same
> protocol and regmap is not a good fit for ADS1X18. We need two different
> SPI message structure for driving the two operating modes (direct,
> buffer) and the trigger needs some special considerations because
> ads1x18 share their drdy interrupt line with the MOSI pin.
> 
> We concluded merging the two drivers would be too messy as both
> protocols would need a lot of unique code. Not to mention different
> triggers, buffers, custom callbacks, etc.

This information would be really valuable to put into the cover letter.

Thanks,
Tomas


> 
>>
>> Thanks,
>> Tomas
> 



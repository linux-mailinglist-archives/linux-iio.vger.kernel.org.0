Return-Path: <linux-iio+bounces-13608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFAF9F63B5
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EF118958D2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A54199EA1;
	Wed, 18 Dec 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lMx+BBA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C09198A07;
	Wed, 18 Dec 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518788; cv=fail; b=lykXOlkD/9hdx7BCaX1YxnYuGsMIWBHHCbe8enV7IGFitZQ0NaJkIYGnFQVTc92bs7TiAYmfgKMh6xBpl7J2kwFAZpeMLJz/NVTyi4QNOg6uIxAZpAYoaE8kvUNDhAwo/idkg4d+SkIQYDZZOMlyscQ744oPpaq9VwKvkzmI5RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518788; c=relaxed/simple;
	bh=qVTvaHMqR9zatVWrNod2ous13EwPIZNCzAYBgeqxsgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDw4xt67rQypQr46N77dIJDMgMMSKMObiYPwJjCATYrnyygCtfMPgGDvE1q1KEpoYiZoNZb1UJJzHUxr85dE6rNLZHxBTqy3xzkBoNCtFCunwBDAzbrZLNl1s0HJGQQEjhSRL0V+uRJWK20t1YEpWdg0Ajcx/Rwxr9XJV0uTZSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lMx+BBA2; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e87HUCZiWIcjefQkmyefjRnfPNpg4oYPkPzogluO0hmVg3BQ+SE1VpBMI5pyKpQANwQC29/MqIt11Ud4qjrqPFFmKVsmWr5KqTJ+QxEaIyke2g8AUm8h/PGWuDbOp/Xslz2aKPfwnv6mZ0dxOUA+nHaSOc/Ruc0QJpEeSW+bZoGPnqICJlhWAQXVw+XTbsPwKkeYy8NfAORz9JKrHqi7qOJkYhrX/tnMEp91f2G2XRAHwq8MADoyckngvEbXHzksG7gZCUOeLQBAyt+aJJytxgBwwAWnLQAyDR7311g16DGjMDdum0Hl4UKKYcU9hXdN46cbRC0+80CiJ3N05ClmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1DCSFcmMnWG6qsfOuych8j/Euf2mAQwHdbXGgeZ53M=;
 b=Fkdu/8Q7GvFJIOTzDK27GxzyvvVLzu3t3t2Pwlba/+8WCdw42KpHClVogh/rlGKBAbHZp6GYDszCBmARN+0R//CA4N8EVMLKejDba/So0XnkMjKiMWR1BYlRqQe32ghx93Sc8RkPE7DlrRVZZhjdrvWtdgfEgeL1XJwde5wJK6+eYQpxNkEtv/MJch67FXNfsE9SzJa4xpKbv82g89+9+n4PWGL78U9UvBqfmvFkF1FgjexMuta5XIuxFn7IpSAbMfDn2a0zmCHkcMSckUBzYCPE2X3Ljx90yDyKqbQTVviY3Fgo4dDO6ld6nlJ2wTOicAj4GPFIZZmJZrrBpnewJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1DCSFcmMnWG6qsfOuych8j/Euf2mAQwHdbXGgeZ53M=;
 b=lMx+BBA2NVAIYiAt+L8ubdaoEjv4WFlemcLG78LP+PNTfk11D7w85HXFGoUh0b0Socn4XzCDE3IwOoazfO/c3qngzuHReCNtrtVap/S8mFb2J/oHi2pPOEoMJKmZSvy3fys+9vfawdI6sph9axRBPAQUOWt2QEFbvr8iBgRyycI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AS2PR02MB9859.eurprd02.prod.outlook.com (2603:10a6:20b:609::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 10:46:22 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 10:46:22 +0000
Message-ID: <c5d5575e-7df3-4e2e-9c00-d9b71959bd02@axis.com>
Date: Wed, 18 Dec 2024 11:46:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, rickard.andersson@axis.com, kernel@axis.com
References: <20241211140409.1619910-1-perdaniel.olsson@axis.com>
 <20241211140409.1619910-3-perdaniel.olsson@axis.com>
 <20241214182123.22b5ede0@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241214182123.22b5ede0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AS2PR02MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f218a-43e8-4600-a645-08dd1f513667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzNFUzdubFFsRU1TbVQrRDI0WE1rdW1VWlZFNzBId3l6WDBqYVRsaE9JbmdO?=
 =?utf-8?B?a055b3ZZWDY1Q2RqU3huYjkyUm9GYS9BVU11cFNTWS9jdUFHdjFzQUlsMTNV?=
 =?utf-8?B?blc3QjJ2TU9PWnIxdEovaWpSYlZjY2NIa1JSRGVFTldKOTNPMWtxeTUrRE9E?=
 =?utf-8?B?bGUxZFU2ekFmMC9qR1VsM0V5TDBxMzBwQS9Na2hkN1Y3OTlENlNnRkZFanhU?=
 =?utf-8?B?bEkxeEU1MFRtenhTSG1abVhmczM5dDVsNklmQ2hqUFVtbWdTOXF3VE15NUE0?=
 =?utf-8?B?RUk4SjI3RHEvcnF5LzBrdUo3aDMrcllrK0RwTmgyWVBqVmdhU1F3UnZXd2FQ?=
 =?utf-8?B?SmlkUmw1aHNBYVMxZDZHeGRkLzUxMm1CR3hScEZjOEo0dlBZT2NGTWxVdG1w?=
 =?utf-8?B?bWVtcElaMVFVUEw0d1FZSy82VW1odmdLNnczWkN6ZVZ3Z3dUNTZ2c1l0ZlRm?=
 =?utf-8?B?cVFUbXRWNjBOV1BMb0ZYbmJySjU5NXMxbEpUWktvVEIzbCtKOURMZkE3SDcr?=
 =?utf-8?B?RjRZY09QYmJxVnpHa1VhSkE4RjhZMjdWa294QUlpU1Q2a2hWLzRlR0E2Z3Zh?=
 =?utf-8?B?eTZ3bmdFOERSWUV5SjN1czRLQjFwcGtwZ3QrWWNaNThWenFaTG9oODIyVlJo?=
 =?utf-8?B?M1BpUnFkR1VvNW5EemdueXFvOFU2L1V3bG1WczhkSDd4OENMNVpLdXdvdnVi?=
 =?utf-8?B?QVhhQ3JYSlFpRWV2VDAxOVJKZm1vRDBmUXFxTWRVT1dUcnBreVAvK2pYTTRq?=
 =?utf-8?B?TVowNkluSW9ZN3FVQWVTMjhpY2hQeGxvUW1saGVnNXMxMHo5MGpLTzcvTVVn?=
 =?utf-8?B?N1h3d0RVRHRMd2VSTlFCUVUxK2VWMkptd1hyZ2VkVTZIRnZaM2g4QlVJR08y?=
 =?utf-8?B?QmN5WkFvTk1jODZ3ZUZ2MVc2a0E2ZWk5VHRLOEFrQVN2T2s5V25WSVBBWVhT?=
 =?utf-8?B?dTBKQjJmSFZYeEx0ZVRVVWlYQWozN05QZmN0WUtpVFVXbnA3NUxaaHBtbWNs?=
 =?utf-8?B?V25WZ1dhZjd6L0ErQXlKcFQ3OEt3YVY2NW5PbDdzTm9qZDlHYThRQ0pKRnpB?=
 =?utf-8?B?aW1kbWNOSnZYS1pyUlVIVGVWYUpqMEJwVmlweUFoUUNjZWN4RGpCVGowbzhy?=
 =?utf-8?B?L0tiT0ZIdmxUNmJDNFJBM1ZYUG81VEhEbml0b3gzMVVYb1FMbmM4ZkhKZjhP?=
 =?utf-8?B?UHZ3SUlTY2Rwc091bjU0OE9XbVNyeXk1SkZ0S081bkg2dTVZWDlXMWhBTEg2?=
 =?utf-8?B?MFVSOG9pY0ZHSGQyUjhkSmh0YWkwSThKOS9za3pBaUEwNnltUFlDamhIN1Zq?=
 =?utf-8?B?S2tIUFRNa3poa2t5Q0h0WjU0elN4VFowL1FRcUtKaldtVm5LdHFsLzNPVGZ4?=
 =?utf-8?B?M2trUERoRjQ0WDBzZGpIVXdPazVPdlYvd1d6WUl0WnhRMmVSUVN2MUppUS9L?=
 =?utf-8?B?djlDTHZCWVE2djdlb2M0NXBpSkZMU2NwN1FpR2ZkMlJNZEFTL1YyUnBuNFRN?=
 =?utf-8?B?THBCNUMrUWh5b1BRNFR4Szh0ZHE0azZHa1FhNnVRWk5RTVdHeXRzQklKTm1x?=
 =?utf-8?B?cjNrTUl4ZHVLcSs3aktLTUx3OVFselIrSUdScjJsV3ZTNlB1cjJqNlFndUFj?=
 =?utf-8?B?b1NrOUFWYUU0NmJxMmMweG9KVXBBU0poSjZhdGswUXlKZnpldmNNV1ljTDFv?=
 =?utf-8?B?RDNERnA1Z3I5R3FGNHc4OC9Qdyt4UWNicHRyNUxSZHdVMmF2aWRIQk00cXdJ?=
 =?utf-8?B?QVMzRlp5YTJMdGVxVmZEakJBUkFJR2RKNXc1ZzlPbDYyeTB1d1NaRkhYYm92?=
 =?utf-8?B?ZzNFWm05YWdlWS95NXo2Zk42bFdOczBzOU9lNlhqaHdPbUw2aE1LUTlKeloz?=
 =?utf-8?Q?yfv/xZLbdHcvR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NnTGo3K0tRK2t5anhwenc1MFpVbXZ4Y0ZXK2RxSFNNRG5rNDgwdXBGTEN5?=
 =?utf-8?B?TWJ1R0hMVURxejQ0SGlYbElZVDRoUXNFanFKaDMxOGw0NHNXd1I4WlBudlpq?=
 =?utf-8?B?aDE1b2k5NHlmOVhxYWtzbnRXUlpwR2hTTHhhL1BuYXB6NzlpR1U0OWhDTWtJ?=
 =?utf-8?B?T0FhQStDSm9vcEZ4RVFNUlpjSGdEbjhvNTFXUnVZR24wL0o2N280L2w5MzdS?=
 =?utf-8?B?SzVqTmV2WG5iN3ZRbVZtRml3TzkxQWZFVmhjR0drYnMxWnREeWdBSC9JOVU3?=
 =?utf-8?B?L0JDenVWSmhMQTRkQitNdXEyZ2hlWExXK3FSMndLR2NoOUMzSkJwUEdFMDcw?=
 =?utf-8?B?dDEyTWNlT2lrQXIyN0hQTnNNTDRmbmhINFJuM0lVbjFGTi9TQ2lGNXNPWFNL?=
 =?utf-8?B?VDhiWGhNemlyaFVqeEx0T1lCVUhFakc2akxXcGw2ZlV0R0UyZ3hoUUF3Rnhp?=
 =?utf-8?B?QzhHcWNPeE1hMWd3R1JZMHVKV2tZY3hSL3dDUU1mT2xFL3VTSm52bWEwQkdk?=
 =?utf-8?B?c1d6TWhoT1kyeG54STI2SEJnWmNFRHRwdzVkdE1CZE8zUlRkM0JaWkFrelp3?=
 =?utf-8?B?Zi82cSsrQkNnQWdsNFhrSHdxYW9JeFd3d2pBOHVnSHRMZnAzUzNoQ1JCdmt3?=
 =?utf-8?B?ekZ1WEwrUnVVSlBoMjVrVHY3YkV6NlBySWY0cmRvRm1tem5Sd01adWY3MDM5?=
 =?utf-8?B?Qzg3KzVEVzNaUFNOUlpWUGsxcUlybzZKaWZ3dlE2blk4eFdVZWRpeHprRUl5?=
 =?utf-8?B?SzNPbm1yMFdhQjc0MlAwdi84ekNZSG96RmdVU2RTT0dVWTZPZFFZR01kdmxC?=
 =?utf-8?B?OWhuUVNkeGkzZGIwNGlramZ1eFo3ME1NODFWUHFKc3NndmI2bHBpZFU4aWZZ?=
 =?utf-8?B?WGN3c1FCTTA2bjZialFFNERHVWRBUyszN2YyWXovZlRpMDRTYjJpbEo0WU1m?=
 =?utf-8?B?WnhHOHdncGhNMDhQZG0zVzlGZWhtTEtOa2hITVdsVkNKZ3NpUGt4MVlZT2xO?=
 =?utf-8?B?Yyt0MkJ2N2c5ODhYRk9hbCtKN1J1QTZWM1BDWXcrSFlBY1RzUzJNNDVUU3gr?=
 =?utf-8?B?TmpBcWFFQ0E3NWxZZDJvR0ZRZUdyU3NLKzVpVXFCMC9aaUhxd1FKbHdqRmZt?=
 =?utf-8?B?Ylk4Z1pwT1I4RzlFOWNza3JvUWZ0dGQ0bzdKbXl4OFRZcFFaYnQxYjl1TlQy?=
 =?utf-8?B?VzU2WXR2ZGJlUjhVMXcvYW9EZWNINXc4NmJwRUNVaHZLT0VaSnZmdDhqTDU3?=
 =?utf-8?B?WGE5M2owREl3TU4vdDA3K1U1Mzloeko3Kzh3dFdFTjhTUGVSZE5sV0pEbjFz?=
 =?utf-8?B?aXFLWGtBYzZTWFdsRmlTc3pLQ2lST3NJTWdrWjJSWTB0WlFZRTk4Lyt6eDEr?=
 =?utf-8?B?RlRXbHhpMGgrRFRiSE1sVDhucVpoZ0ZXQjMwcFI1TTVZUU9rdWhGNWFObVdh?=
 =?utf-8?B?VFAxam54VEtFclptTGpMWnphNENqcjRodHdFTEpETHV1ZHhzQUJub1Bwajds?=
 =?utf-8?B?OTVpTEQ5SzYvUmtzTGNkRGRTK1pnSk1HMVpRQi9EOHhHeURzSlljM09YQWow?=
 =?utf-8?B?Mmpac3J0ZTNmSGZhSHRwdWM3YVpJVFBiNXJGMk5QRVhqdSsyQXhDSS9wL3M3?=
 =?utf-8?B?a2pScmhlR21mWElsOXd5MmUrR2tNSzBXbmgrNElBMVRKTk11ampLVzdxbFVw?=
 =?utf-8?B?TVZ1d3BDdG5kcjJ1NGFIakQzZ2k4WXFiVTVxaUt5aDJYSEF4dUhUSG92QmpU?=
 =?utf-8?B?MTlPakZBRlowbDFmamRUNkozc2wzU0kwckk1NDVvSjRsMTBlNUFobDRsZ1Bp?=
 =?utf-8?B?S3h4SkNVSmEvL2QxUHd5bFhHK0ZvZlRYb2RqUXJvaHVsNHJ6aDhuZmxTME5S?=
 =?utf-8?B?R2MvM0dnZVJuTXlzYVE1dyt3dTZZM2FoK1dsMFhsR3dZeXYzY3RTcW1MbkZT?=
 =?utf-8?B?VXBWUVdqSlcyOEY4ajF4Skd6dTBCZ0xDY2NVdXFDOFVOZXEzWldJUTNyOGhT?=
 =?utf-8?B?WUtFRGtrTjlWRnM3L0tzRGtzaGJTeW1FdG40MjF4c2pmU3NwQldDZTFBRk1C?=
 =?utf-8?B?MTNPN2c4b0JySGxtSG15bVJPcnloWXlpV2Z1dkZjRU1ROFZTTkFPUE44NlNo?=
 =?utf-8?Q?Qft0=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f218a-43e8-4600-a645-08dd1f513667
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:46:22.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSO0XHl+XGm0xC2x35i74ToIfjXF5KzBZrRdfr+QRj0YzjLJtidrfmqgfFZhihRv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9859

On 12/14/24 19:21, Jonathan Cameron wrote:
> On Wed, 11 Dec 2024 15:04:09 +0100
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>
>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> 
> Hi Per-Daniel,
> 
> I think this is nearly there, but still some races or at least places
> I can't currently convince myself aren't races.
> 
> I remember long ago being a wimp and failing to implement a similar dance
> in the max1363 ADC driver. That manages one more complexity in that in
> it's continuous mode if events are enabled, the data fields move.
> It still only supports one of events, sysfs read back or buffered output,
> not any combination.  Maybe if I can find the hardware I'll revisit that
> one day.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Thank you for your comments. Also thank you for sharing your story about max1363,
sounds like a tricky piece of silicon. Great to hear that you think it can be 
worth the time to implement concurrent use cases, I was a little worried that I
was pushing that part a little too far... :)

I have added comments below.

Thanks (and happy holidays if I don't hear back from you before),

Per-Daniel

> 
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> new file mode 100644
>> index 000000000000..4a7d970c5d7c
>> --- /dev/null
>> +++ b/drivers/iio/light/opt4060.c
> 
> 
>> +struct opt4060_chip {
>> +	struct regmap *regmap;
>> +	struct device *dev;
>> +	struct iio_trigger *trig;
>> +	u8 int_time;
>> +	int irq;
>> +	struct mutex irq_setting_lock;
> 
> General rule is all locks need a comment on what data they protect
> even when they have a nice specific name.  Bit advantage is it makes
> it clear what they are not designed to protect!

Done in v10.

> 
>> +	struct completion completion;
>> +	bool thresh_event_lo_active;
>> +	bool thresh_event_hi_active;
>> +};
> 
>> +static void opt4060_claim_irq_setting_lock(struct opt4060_chip *chip)
>> +{
>> +	if (chip->irq)
> I'm struggling to see why you'd be messing with irqs if you don't have
> any?  I can't see a path in which chip->irq isn't set (which makes sense!)
> and you get here.

Good point, fixed in v10.  

> 
> So I think you can just move the mutex inline which avoids the mess
> of lockdep warnings etc and let's you use guard() to simplify things.
> 
>> +		mutex_lock(&chip->irq_setting_lock);
>> +}
>> +
>> +static void opt4060_release_irq_setting_lock(struct opt4060_chip *chip)
>> +{
>> +	if (chip->irq)
>> +		mutex_unlock(&chip->irq_setting_lock);
>> +}
>> +
>> +static int opt4060_set_int_state(struct opt4060_chip *chip, u32 state)
>> +{
>> +	int ret;
>> +	unsigned int regval;
>> +
>> +	opt4060_claim_irq_setting_lock(chip);
>> +	regval = FIELD_PREP(OPT4060_INT_CTRL_INT_CFG, state);
>> +	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
>> +				 OPT4060_INT_CTRL_INT_CFG, regval);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set interrupt config\n");
>> +	opt4060_release_irq_setting_lock(chip);
>> +	return ret;
>> +}
>> +
>> +static int opt4060_set_continuous_mode(struct opt4060_chip *chip,
>> +				       bool continuous)
>> +{
>> +	unsigned int reg;
>> +	int ret;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &reg);
> 
> You could use a regmap_update_bits() call to simplify this like you 
> do for the int_state above.

That register is a little special. It requires a real write sometimes
even is the data hasn't changed, so regmap_update_bits won't work. This
is needed for triggering one shot mode. I have renamed the function in
v10 since it don't just set continuous mode but also one shot. I have
also changed the comment in the code.

> 
> 
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "Failed to read ctrl register\n");
>> +		return ret;
>> +	}
>> +	reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
>> +	if (continuous)
>> +		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
>> +				  OPT4060_CTRL_OPER_MODE_CONTINUOUS);
>> +	else
>> +		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
>> +				  OPT4060_CTRL_OPER_MODE_ONE_SHOT);
>> +
>> +	/* Trigger a new conversions by writing to CRTL register. */
>> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set ctrl register\n");
>> +	return ret;
>> +}
>> +
>> +static bool opt4060_event_active(struct opt4060_chip *chip)
>> +{
>> +	return chip->thresh_event_lo_active || chip->thresh_event_hi_active;
>> +}
>> +
>> +static int opt4060_set_state_common(struct opt4060_chip *chip,
>> +				    bool continuous_sampling,
>> +				    bool continuous_irq, bool direct_mode)
>> +{
>> +	int ret = 0;
>> +
>> +	/* It is important to setup irq before sampling to avoid missing samples. */
>> +	if (continuous_irq || !direct_mode)
>> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
>> +	else if (direct_mode)
>> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to set irq state.\n");
>> +		return ret;
>> +	}
>> +
>> +	if (continuous_sampling || !direct_mode || opt4060_event_active(chip))
> 
> I think there may also a race around the event active check.  You could have
> one event direction being enabled concurrently with the other being disabled.
> I'm not sure it matters but worth checking.

I think you might be correct even if I haven't been able to trigger the case in
my tests. I have added a guard for this in v10. If opt4060_write_event_config()
is called from several callers at the same time, the whole sequence all the way
down to setting sampling and irq will be synchronized with the mutex/guard.

> 
> Side effect of either claiming direct or buffered mode is that only one
> caller can do it at a time, so that would close this race as well. 
> Having said that, it's an implementation detail of the core (be it one that
> has been there a long time) so you should really have your own driver
> specific locking scheme prevent that.

I have implemented the "dance" in v10 and it seems to work well in my tests.

> 
> 
>> +		ret = opt4060_set_continuous_mode(chip, true);
>> +	else if (direct_mode)
>> +		ret = opt4060_set_continuous_mode(chip, false);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set sampling state.\n");
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Function for setting the driver state for sampling and irq. When disabling
>> + * continuous sampling or irq, the IIO direct mode must be claimed to prevent
>> + * races with buffer enabling/disabling. In the case when the direct mode is
>> + * not possible to claim, the function will keep continuous mode. All
>> + * functions, sysfs read, events and buffer, work in continuous mode.
>> + */
>> +static int opt4060_set_driver_state(struct iio_dev *indio_dev,
>> +				    bool continuous_sampling,
>> +				    bool continuous_irq)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	bool direct_mode = false;
>> +	int ret = 0;
>> +
>> +	if (!iio_device_claim_direct_mode(indio_dev))
>> +		direct_mode = true;
> 
> Hmm. I'm dubious about this pattern. Why is it fine if the driver
> leaves buffered mode right here? I was expecting this to do
> the dance with claiming either direct mode or buffered mode.
> (with the retry loop).  Direct mode that you pass into the next
> call may well be false when it should be true.
> 
> Even if you can reason why that isn't a problem (and there are worse
> dances where it switches mode multiple times during your call
> of the next function to consider) I think it is easier to reason
> about if we know it is definitely not changing state until we
> release it.

"dance" implemented in v10.

> 
>> +
>> +	ret = opt4060_set_state_common(chip, continuous_sampling,
>> +				       continuous_irq, direct_mode);
>> +
>> +	if (direct_mode)
>> +		iio_device_release_direct_mode(indio_dev);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * This function is called in direct mode from the framework.
>> + */
>> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	return ret = opt4060_set_state_common(chip, state, state, true);
> 
> return opt_set_state_common() is probably the intent.
> 
>> +}
> 
>> +static int opt4060_trigger_new_samples(struct iio_dev *indio_dev)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	/*
>> +	 * The conversion time should be 500us startup time plus the integration time
>> +	 * times the number of channels. An exact timeout isn't critical, it's better
>> +	 * not to get incorrect errors in the log. Setting the timeout to double the
>> +	 * theoretical time plus and extra 100ms margin.
>> +	 */
>> +	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
>> +				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
>> +
>> +	/* Setting the state in one shot mode with irq on each sample. */
>> +	ret = opt4060_set_driver_state(indio_dev, false, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (chip->irq) {
>> +		reinit_completion(&chip->completion);
>> +		opt4060_claim_irq_setting_lock(chip);
>> +		if (wait_for_completion_timeout(&chip->completion,
>> +						usecs_to_jiffies(timeout_us)) == 0) {
>> +			dev_err(chip->dev, "Completion timed out.\n");
>> +			opt4060_release_irq_setting_lock(chip);
> 
> This is where exposing the lock directly will simplify things as you can just use
> a guard.

Fixed with guard in v10.

> 
>> +			return -ETIME;
>> +		}
>> +		opt4060_release_irq_setting_lock(chip);
>> +	} else {
>> +		unsigned int ready;
>> +
>> +		ret = regmap_read_poll_timeout(chip->regmap, OPT4060_RES_CTRL,
>> +					       ready, (ready & OPT4060_RES_CTRL_CONV_READY),
>> +					       1000, timeout_us);
>> +		if (ret)
>> +			dev_err(chip->dev, "Conversion ready did not finish within timeout.\n");
>> +	}
>> +	/* Setting the state in one shot mode with irq on thresholds. */
>> +	ret = opt4060_set_driver_state(indio_dev, false, false);
>> +
>> +	return ret;
> 
> 	return opt4060_...
> 
>> +}
> 
>> +static int opt4060_write_raw_get_fmt(struct iio_dev *indio_dev,
>> +				     struct iio_chan_spec const *chan,
>> +				     long mask)
>> +{
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		return IIO_VAL_INT_PLUS_MICRO;
> IIRC That's the default, so you don't need to provide write_raw_get_fmt,
> though no harm in doing so I guess.

Ok, wasn't aware of that being the default.

> 
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> 
>> +static int opt4060_get_channel_sel(struct opt4060_chip *chip, int *ch_sel)
>> +{
>> +	int ret;
>> +	u32 regval;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_INT_CTRL, &regval);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to get channel selection.\n");
> 
> if you have garbage, not sure it's valid to update ch_sel.
> 
>> +	*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
>> +	return ret;
>> +}
>> +
> 
> 
>> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir, bool state)
>> +{
>> +	int ch_sel, ch_idx = chan->scan_index;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	if (chan->type != IIO_INTENSITY)
>> +		return -EINVAL;
>> +	if (type != IIO_EV_TYPE_THRESH)
>> +		return -EINVAL;
>> +
>> +	ret = opt4060_get_channel_sel(chip, &ch_sel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state) {
>> +		/* Only one channel can be active at the same time */
>> +		if ((chip->thresh_event_lo_active ||
>> +			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
> 
> That's a bit nasty to ready. I'd use a slightly long line and get the || pair
> on the first line.

Fixed in v10.

> 
> Hmm. We've never made rules on this but some devices to fifo type
> selection if they have limitations on events enabled at the same time.
> With hindsight I think this scheme of just saying no is probably more
> user friendly.

Ok.

> 
>> +			return -EBUSY;
>> +		if (dir == IIO_EV_DIR_FALLING)
>> +			chip->thresh_event_lo_active = true;
>> +		else if (dir == IIO_EV_DIR_RISING)
>> +			chip->thresh_event_hi_active = true;
>> +		ret = opt4060_set_channel_sel(chip, ch_idx);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		if (ch_idx == ch_sel) {
>> +			if (dir == IIO_EV_DIR_FALLING)
>> +				chip->thresh_event_lo_active = false;
>> +			else if (dir == IIO_EV_DIR_RISING)
>> +				chip->thresh_event_hi_active = false;
>> +		}
>> +	}
>> +
>> +	return opt4060_set_driver_state(indio_dev, chip->thresh_event_hi_active |
>> +					chip->thresh_event_lo_active, false);
> Maybe wrap it to have the | pair on lines with nothing else.  They are a little bit burried
> otherwise.

Fixed in v10.

> 	return opt4060_set_driver_state(indio_dev,
> 					chip->thresh_event_hi_active |
> 					chip->thresh_event_lo_active,
> 					false);
> 
>> +}
>> +
>> +static const struct iio_info opt4060_info = {
>> +	.read_raw = opt4060_read_raw,
>> +	.write_raw = opt4060_write_raw,
>> +	.write_raw_get_fmt = opt4060_write_raw_get_fmt,
>> +	.read_avail = opt4060_read_available,
>> +	.read_event_value = opt4060_read_event,
>> +	.write_event_value = opt4060_write_event,
>> +	.read_event_config = opt4060_read_event_config,
>> +	.write_event_config = opt4060_write_event_config,
>> +};
> 
> Given you have option for no irq it is probably worth picking a version of this
> info structure with all the event callbacks removed.   Technically it isn't
> required but it does harden the code (by crashing horribly if you call them ;)
>

Good point, I have added a separate version without those callbacks.
 
> 
> 
>> +static irqreturn_t opt4060_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct opt4060_chip *chip = iio_priv(idev);
>> +	struct  {
>> +		u32 chan[OPT4060_NUM_CHANS];
>> +		aligned_s64 ts;
>> +	} raw;
>> +	int i = 0;
>> +	int chan, ret;
>> +
>> +	/* If the trigger is coming for a different driver, a new sample is needed.*/
> 
> from a different driver?

I have tried to clarify this comment in v10. When an external trigger such as
iio_sysfs_trigger is used, the sensor will not be running in continuous mode
and a new sample must be triggered.

> 
>> +	if (iio_trigger_validate_own_device(idev->trig, idev))
>> +		opt4060_trigger_new_samples(idev);
>> +
>> +	memset(&raw, 0, sizeof(raw));
>> +
>> +	iio_for_each_active_channel(idev, chan) {
>> +		if (chan == OPT4060_ILLUM)
>> +			ret = opt4060_calc_illuminance(chip, &raw.chan[i++]);
>> +		else
>> +			ret = opt4060_read_raw_value(chip,
>> +						     idev->channels[chan].address,
>> +						     &raw.chan[i++]);
>> +		if (ret) {
>> +			dev_err(chip->dev, "Reading channel data failed\n");
>> +			goto err_read;
>> +		}
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>> +err_read:
>> +	iio_trigger_notify_done(idev->trig);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t opt4060_irq_thread(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct opt4060_chip *chip = iio_priv(idev);
>> +	int ret, dummy;
>> +	unsigned int int_res;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_RES_CTRL, &int_res);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "Failed to read interrupt reasons.\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	/* Read OPT4060_CTRL to clear interrupt */
>> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &dummy);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "Failed to clear interrupt\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	/* Handle events */
>> +	if (int_res & (OPT4060_RES_CTRL_FLAG_H | OPT4060_RES_CTRL_FLAG_L)) {
>> +		u64 code;
>> +		int chan = 0;
>> +
>> +		ret = opt4060_get_channel_sel(chip, &chan);
>> +		if (ret) {
>> +			dev_err(chip->dev, "Failed to read threshold channel.\n");
>> +			return IRQ_NONE;
>> +		}
>> +
>> +		/* Check if the interrupt is from the lower threshold */
>> +		if (int_res & OPT4060_RES_CTRL_FLAG_L) {
>> +			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
>> +						  chan,
>> +						  idev->channels[chan].channel2,
>> +						  IIO_EV_TYPE_THRESH,
>> +						  IIO_EV_DIR_FALLING);
>> +			iio_push_event(idev, code, iio_get_time_ns(idev));
>> +		}
>> +		/* Check if the interrupt is from the upper threshold */
>> +		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
>> +			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
>> +						  chan,
>> +						  idev->channels[chan].channel2,
>> +						  IIO_EV_TYPE_THRESH,
>> +						  IIO_EV_DIR_RISING);
>> +			iio_push_event(idev, code, iio_get_time_ns(idev));
>> +		}
>> +	}
>> +
>> +	/* Handle conversion ready */
>> +	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
>> +		/* Signal completion for potentially waiting reads */
>> +		complete(&chip->completion);
> 
> That looks problematic as you haven't necessarily reset the completion
> if the buffer is enabled.  So you probably need a flag or something similar
> to say a sysfs read has been requested.

The completion is only used when triggering a new sample. The code will call
reinit_completion() which will set the internal counter to zero. The code will
then call wait_for_completion_timeout() which will wait for the counter to
increase. The call to complete() here will increase the counter each time it's
called but since reinit_completion() is called every time before waiting, I don't
think this is an issue.

> 
> 
>> +
>> +		/* Handle data ready triggers */
>> +		if (iio_buffer_enabled(idev))
>> +			iio_trigger_poll_nested(chip->trig);
>> +	}
>> +	return IRQ_HANDLED;
>> +}
> 
>> +static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev)
>> +{
>> +	struct iio_trigger *data_trigger;
>> +	char *name;
>> +	int ret;
>> +
>> +	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
>> +					      idev->name, iio_device_id(idev));
>> +	if (!data_trigger)
>> +		return -ENOMEM;
>> +
>> +	/* The data trigger allows for sample capture on each new conversion ready interrupt. */
> 
> Make that a multiline comment.

Done in v10.

> 
>> +	chip->trig = data_trigger;
>> +	data_trigger->ops = &opt4060_trigger_ops;
>> +	iio_trigger_set_drvdata(data_trigger, idev);
>> +	ret = devm_iio_trigger_register(chip->dev, data_trigger);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +				     "Data ready trigger registration failed\n");
>> +
>> +	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
>> +			      dev_name(chip->dev));
>> +	if (!name)
>> +		return dev_err_probe(chip->dev, -ENOMEM, "Failed to alloc chip name\n");
>> +
>> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
>> +					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> That's unusual for a trigger type interrupt and seems likely to give a lot
> of spurious interrupts.  Even if the pulse is short, some interrupt controllers
> will hang on to the bonus edge and trigger again when you reenable the interrupt.
> 
> If intent is to use this for events, then I think you can configure it to latched
> window mode and one edge type and it will all work.

Removed IRQF_TRIGGER_RISING in v10, don't know how both ended up there...

> 
>> +					IRQF_ONESHOT, name, idev);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
>> +
>> +	init_completion(&chip->completion);
>> +
>> +	mutex_init(&chip->irq_setting_lock);
> 
> Trivial and I might not even bother changing it, but slightly preference for
> 	ret = devm_mutex_init(...)
> 	if (ret)
> 		return ret;
> 
>> +
>> +	ret = regmap_write_bits(chip->regmap, OPT4060_INT_CTRL,
>> +				OPT4060_INT_CTRL_OUTPUT,
>> +				OPT4060_INT_CTRL_OUTPUT);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +				     "Failed to set interrupt as output\n");
>> +
>> +	return 0;
>> +}



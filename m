Return-Path: <linux-iio+bounces-13407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B403D9F0440
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 06:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A621649DE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 05:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACC189B8D;
	Fri, 13 Dec 2024 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Lx7ecLwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C744C6C;
	Fri, 13 Dec 2024 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068357; cv=fail; b=iCM/zTe1UAZdrSYhlqThd1NNe/4GCP/K/9a2bxz/pmya6ejDmBiKfEHBuinFIt4XAJfm7Ef4n9VgGGN2xB29S10hwgEoaeU8T4wi0EfmTAAou0BvbycJaoGBXCW/xtWc3z7yqp9ClYBFa6NnW0hzHUYr/HfEMoqOR3YcmUyyfqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068357; c=relaxed/simple;
	bh=p8svsTQylkSBItYNbXWVXmQMTtIkbpU3i/CG+qRNvDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZG/razoLtoL/B45UmKe31FRsknLvSfvbe1qNBjW8t5x/TTsP3JVbxI9COv7dDX8uqy0lZxKZ++nsX688ww8vspTRDR4ILgewQw8A0Rj4ZE32cZZkwha74LqbK8W5C3pzx87cBwarNaqiH27Vza4Hn78djWUN8F8lxWxhk0Qlhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Lx7ecLwC; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDsX3hMd5T59Xqh/GIpvTVu8q83b1Oo8kHByXMJjBmadm/sQQqSvAT7wGoLoj0ObbohUL5KeyUQKXczXrzu6sY9qAvHfRHMEBaHWYMBltUJI9e7+YgHRs39WDflhSDK3t8Ml4pYHWJKON+RugfHFwFlJq4kE4HsCe3P7rpp6bVK1UxcFF1IYAJzwTtveyEqZhM2x4jkgK3CC0JpC3J14iVLfW/2KNIkIXCfjKKRLXFOE6baik6nY//w3Ra6S432mitw2zopN2gGhii12ReZBjN2PfIOyNHilhljXq7DZRM66nfVqDoow7T5L/GmpuKjIcT+016pSuCnfybgyxWh0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnHoL+n7JwyeyvlLyRQINUoTNn90+r9CSGLx0FN781s=;
 b=KDAUqqCkMcK9vbeaupVErdc9FnYQD5YwuedRWeRCSznFiOmVhZPCNOzW4oLwyBrODODwWMJakonhW4QMMwzzwH60u/nSH4//L4tfNpu74KViB6ci1M3OlbskOxd5aLSasjWPD/pI9u8iNBkHxFzbazW0SfUygt1/vfxqIlWzJGCe1CLMtzf54aGBU+S7jKAfBgqPn5lCsgzSJ73kFvJk4QIqXC/ViYPdVANZQJaJ6uZ4LLwhc+2r12pRZuBPLJDVj5+5yKkxZG52SCpAL9q3KwMddI+8ILoyCOp2QLQOelsViYbRwbIoTGQlb4uqJPnLOZP3G8S6K6u0j4kXEEIAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnHoL+n7JwyeyvlLyRQINUoTNn90+r9CSGLx0FN781s=;
 b=Lx7ecLwCoQ1iGKuMSVtFsIyS8Y26JX/HpDzTo4xLLtUdFhNReNAWN8Xb6IRwFbMkowER6SLVxARkhroEa+A95zWMPWZk7eAgvT2KS9r042xRk9tbZMA5Vg1qjdyp73pEApUKJL9R3J8DpM4933nRLdx9QoZgatEaIROb2HjtAO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by PAVPR02MB9497.eurprd02.prod.outlook.com
 (2603:10a6:102:306::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 05:39:10 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 05:39:10 +0000
Message-ID: <3a5c0c73-0d80-bbd0-b53b-522e2f3e936e@axis.com>
Date: Fri, 13 Dec 2024 13:39:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] hwmon: Add support for D3-323-AA Pyroelectric IR
 sensor
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, jdelvare@suse.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
 <20241212042412.702044-3-Hermes.Zhang@axis.com>
 <5b53cffd-ae7f-45e5-b265-8e700d753275@roeck-us.net>
 <20241212165945.0000584b@huawei.com>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <20241212165945.0000584b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0096.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::36) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|PAVPR02MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: e822e541-acaa-4fb3-8baf-08dd1b3877aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFhSFEwbElxZE1HaEZVcFBvK2o3b1dINUNsTm55WEZIaWpMa1BRM2Y1SlBz?=
 =?utf-8?B?OFRjSGpEN0ZzOUNTN3VhYi9hZjhKeTFLSFlFMHdSeWRiTng1U2tVc0Y0anlO?=
 =?utf-8?B?T2NyeWFMWkVqYjZwWldORUlLbmdOWWwwaW5heHZjd2dyUDlOSC9UaDJ0dTVO?=
 =?utf-8?B?bUFxSXdnTUNGaUxNUjYrZGRVaGVVMytpdkY1UmZGZWZ6eGhWVVNSaktYNGJT?=
 =?utf-8?B?ZllqeER3dElOR1Q2RmxmR0g1SGhGNjgzSXY4M21SZmhON0lFN2x3VCtqOStK?=
 =?utf-8?B?d3pENEV1SzdSSTJMYW44K09DWjJhT1prMDZDTTVKUnI4d3dCMXVnRmNwTEU1?=
 =?utf-8?B?WFFYQ3o4RkI4cks0SDNHRkFBclZZVDRsSFV0SXZXb2E2L1daSnVpenRQZzNa?=
 =?utf-8?B?aXNWNi9ybGZOTGNUNmtTSFQ1clNycGp3QW1kVFhmNzBQaVVkVTM0ajJaMkhH?=
 =?utf-8?B?Z0ZwRCtPTGZBcG03aWR3bjV1OXFQUnpSM2dGUlhrcktOWndUcURwcHFXMmcy?=
 =?utf-8?B?ZGJUTVpNUHBPYWV0bC8zZ09oVkxjb2hPdGNRVFBJaVJBdzlFZmhUMXJweHNr?=
 =?utf-8?B?Q1o1dTIzODVIUGFIcXhuRk9uY0Zkb2x5ZUZwbWlFVW80MTd5aFgzcWtjVnZk?=
 =?utf-8?B?Y2M2R0tzb1FBL2ZUemx6SEE5MlhRZXdHZU4rVllqdFA1d3FvOENoU2VZQmZ0?=
 =?utf-8?B?a2h4K1pmOHRMYXl1S0g5V3IxcHV6eW9DakJIQ2p6elJGMUt5VnBXTEl6alMy?=
 =?utf-8?B?cG90WE1wMVNMeW5ObDlQMTFaS2o5dmU2c1k0UHlaL3grR2wrdmRGNWt6aWFT?=
 =?utf-8?B?bEZsOHFta0laa3RjSmJKM3JmRCtGUFhYODVJaDZlQWZSVGU1dXVhTTZycGJm?=
 =?utf-8?B?RTRVNUdkVCtCVWMyOW9oVTJuSG1WQ0NZMXZURCtualV6VG83QkxIZ1Aybmxj?=
 =?utf-8?B?dXhWQUtQcERhQ1JDQ3E5b2pjTFc5aFhsSlZZc2tsTExLNnp5V3k1ekFDM0gv?=
 =?utf-8?B?OWdxbWJSTXVZcHludm5OR0xoYmc5NVAva2FjOW1JalhPbWtFUmJmQkZKZyts?=
 =?utf-8?B?MllHcE5HT05Xb3VGamFUSG12b3NYREQ2dHdhaTErdzI2cFBDdVkrTzV1N1FY?=
 =?utf-8?B?aTN2SkpOcnY5UFNETmtwRnE1Ymo0ZmtxUnY5RExTL25YV3B3b1BlOTVHdUIz?=
 =?utf-8?B?amdiR3F4TTF5bUtlSURZdFMyYmhSQ09OS1VGNndBSm5kV3NySWtvNGJEcHhZ?=
 =?utf-8?B?TGZ2NG5salRJcWpQeHZ1RFNKQTVZaUtPOUZzaGwxaEdHMGYyaGRpN3VldmJB?=
 =?utf-8?B?MGF2cFpxNVY2VjN0Qm12T2VwekRRcHNpS3lIR2d4UjZUZWZXbEFRZXVDTUpN?=
 =?utf-8?B?bjBvU3duWEp4ci94djNCU1BJb2dUaXdBTXVMVkk1b2RHMGdHMzRhSEpxTG1H?=
 =?utf-8?B?OUJ4Q3Zoenl6aGpwUEliTDBWS1F4VVQvdHY4V05pNkF1TW90RXdyQlVOblFG?=
 =?utf-8?B?Z3RuWGtYbTVmNVlDZ3krN21aZzNRaDRUL3N4WDMzTlo0K1E2QUdLbktRZ0da?=
 =?utf-8?B?akd5WHFuUnlWbWx3M05mcFFLWE5BUUtOUE5DRXVuSDJEd0VZVXN3YTBENFkw?=
 =?utf-8?B?RGVYRVl4S2daL3NYRkNDOHJsZHpTVlhITWtoaktvTXBocTF6OURaUCtERWRm?=
 =?utf-8?B?YlkyNTV6RkthZGhxMkxBMTJRSTd4cnBPOVpvRmNoRldpeHFKRC90ZXpTc0xp?=
 =?utf-8?B?c2dYVU5iaVlTRitVRzRwOEtKNEtxWmpjalpSNnBxY2dLQnFBQ1Nvc3lNeEZh?=
 =?utf-8?B?OTF4V3ZkRWcyL0hCTkdPdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHBVUnM4NGxKYmljYitONVNqZ3ZOcFdCRmVwZk12Ui9CVTRYdW9XeUc4Nzhj?=
 =?utf-8?B?UkMwN1JBTmZFb0VITlJnYUNidHRONXRQY09UZzNib1pKR0RnMkJLVi9tQ1Bq?=
 =?utf-8?B?K0xCc3hRRS94ajZxdkNWRDdXdmNYOWE0NTRkUVozSFI2TlJlUWViaDBsTHVI?=
 =?utf-8?B?MHhwMXJpMi9ESzl0MTUxSTJmb0x3VE5SQmRVODhCTFN6SXFSb0RUV2taM09i?=
 =?utf-8?B?eUJLMnBZK0N4T0FEeHI2amhMQVc5OVRRc09yU1hPU1J6cndCQkp5dWM3VnZU?=
 =?utf-8?B?eWZ6cUQ4TEpUekE3VHo5YVE3cVJuMXhwTm9rOWVUdG1EaTVZV1lGaWg2SFk3?=
 =?utf-8?B?cGQyVDhLekpXcVR6RWdZNHFtS1BnckJDM2xtdkt6K2xJRHpkUWh1bTlsVmI1?=
 =?utf-8?B?ai9pQk05U1IxMnZ0VDBWdEhoQ1RKdmNrMUZKazVuYmhFcGxZTy9SZ2hXRW82?=
 =?utf-8?B?SDhid01pNEpmbERnWVBpSGhJemZoRStWK1dUZ2E0VXdsckkvdWQwMEViNE5V?=
 =?utf-8?B?ZThWakVoNWtzaVJaWWpIc3Q5SWpyZTdud1ZoSS9xbmdCYkFFajNuTTdNeWpM?=
 =?utf-8?B?Wm54alNNKysvM2Jxd2hVZlJVU0xOUlByTkFSdWZPbVV1aS9ORHNFcS9RN09C?=
 =?utf-8?B?bDJZOHJwZ09XS0JUTG80ait4UG9UYUxxNFVLRjluK1VYT05IbGRwSXpLemtx?=
 =?utf-8?B?TmozWjZLUnpvUkliWElEdDhDRDFhaVhsQzFhWXNQZFRIK05yMG1ZTHBuZStE?=
 =?utf-8?B?TU5uT0JRRTRlZ0ZtVUIybW94ekJybVlLVmtOb2FFNTRqQzN2QlJJWWJLNHVw?=
 =?utf-8?B?UzNOMEpzc3VqamdxMnJpOWQ2TnVvNXBYY0tOanNmZzNwdTl0QWJsQTNxTklm?=
 =?utf-8?B?Nk9rOUhiT3JIdVlLalVYNnVvNml6STRHazRaU3ZBUFEzL3VOVERvdFlzaE1u?=
 =?utf-8?B?ZDNIVW1GLzN0YXlmVytoTXFMa2VCZEMvczhsa0t2MFpic3AwamZMVFlMKzFZ?=
 =?utf-8?B?ZmE0dEhxMnZPL2E5aHhCS0JhYW5tOGdVTlRBcmhSNzcwaEtUcGJ5bXFaQ2tm?=
 =?utf-8?B?ZTJZMjcyWVNkWUpHZ3dtZ3NCcUNTTnpHUEFCWnNlOXd0NWF2Qm1tak5rTHI5?=
 =?utf-8?B?M2t0WFJsUTk4eFgwZkxyZHlzS0xKWnAzRHZLaTN3VGZTZU45dTFOUDBUbjJu?=
 =?utf-8?B?QndXMzJ5VGNmeXJrWGprdEc4ckFOS1F6dndaQ0lTU0JBMk9DNlkvNnJ0eity?=
 =?utf-8?B?bUJBampHU0UrNmNGWEthcEExczArUHhrczBGT2NjVHdSQU00NTNOeG9reEVK?=
 =?utf-8?B?eGZBWFp4Q1NmZDRFNmxoWGRCditxTDdqdkJOMWtsNVN1YVVldHkwR1MxWXhq?=
 =?utf-8?B?d2FKczdwcEVmd2ljNWRMS1Jza2s2cXBxbDhlaENUY1lmVVIrZHhDM2VsQmNj?=
 =?utf-8?B?cU1XZElMWGh1QlVVOHZSQzZNd0FLTk1BaGtrNlEzek1sNlAyclJidzQvd1g5?=
 =?utf-8?B?L282dFNkTmRDekVJZ0hRR09NWVdtbmRyMjdZSmdmOGxxVHlYTEFIK2tuSFI1?=
 =?utf-8?B?MThZemtPaHRBOGxoQ25WWTg3N2hkbGFlamFuQk51UDR1KzNjVnRWUGpoRXZU?=
 =?utf-8?B?TkNmL0xPV3BxaG9UZENmRTNBMDZERjJRcnkrWmNzZWVDSjcrSFQ5Y3NLbTQ5?=
 =?utf-8?B?UVZZdHE3U2FFSXFNZVRFdVBRRldRakxERkVPQm1qVnFkZGFvMWN5UDF1MTM4?=
 =?utf-8?B?UzBZMWQrMythdGdCYXVFVVBKQVZIQmxNOG9XQU50TnNrRW9nMmFxN2E1ZFFZ?=
 =?utf-8?B?eWpRY3VTaTRBZXBrK1ZnUmwxaE5RdXJBNGhPV0RoOFZkOUJoVUNVNXNNMFF6?=
 =?utf-8?B?QlZwT3BrQWxmTWhERjFNS3R4aGh3dVVLSDJRcVVsc3VtemNqL3I3a2NRbGZ0?=
 =?utf-8?B?WjhpQ1lGeWVacnRnL2JRTktRVSs5bjVqT3lmQW1tRjZWSjB5UW5HdWV6eUlp?=
 =?utf-8?B?QlNmN2hUc0dBQWhHanZ2NDBKWXgrNDB3dlowOGJwTlFFU1ZKUFBpSXo1U1Bw?=
 =?utf-8?B?S04rbkwzaXlaQ01DVkdyQkhjTWM0bXJMMm8xS2lNN05HK2laZ0ZIWEhmSFdZ?=
 =?utf-8?Q?QbD/IDorkw30s7nuBXJHp7UCz?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e822e541-acaa-4fb3-8baf-08dd1b3877aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 05:39:09.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8AjhbVZQIRnFZoWY2HhvAIMQSMUI3qkSiqAFHs3H7M0U3KaNHRBiM7tmeFzIO6Ie0VguI70/2LAuIQWllojLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9497

Hi

On 2024/12/13 0:59, Jonathan Cameron wrote:
> On Wed, 11 Dec 2024 22:17:49 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> Hi,
>>
>> On 12/11/24 20:24, Hermes Zhang wrote:
>>> Add support for Nicera D3-323-AA Pyroelectric IR sensor. The sensor
>>> support to config the threshold/filter_type/filter_step and return the
>>> detect result in sysfs attribute.
>>>
>>> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
>>> ---
>>>   
>> ...
>>
>>> +
>>> +static DEVICE_ATTR_WO(pir_threshold);
>>> +static DEVICE_ATTR_WO(pir_filter_step);
>>> +static DEVICE_ATTR_WO(pir_filter_type);
>>> +static DEVICE_ATTR_RO(pir_detector);
>>> +
>>> +static struct attribute *d3323aa_attrs[] = {
>>> +	&dev_attr_pir_threshold.attr,
>>> +	&dev_attr_pir_filter_step.attr,
>>> +	&dev_attr_pir_filter_type.attr,
>>> +	&dev_attr_pir_detector.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +ATTRIBUTE_GROUPS(d3323aa);
>>> +
>> I don't know what this is, but it is most definitely not a hardware
>> monitoring device. I don't see a definition of those attributes,
>> so I have no idea what they represent.
>>
>> Maybe this is an iio device, but given the unusual attributes
>> I am not even sure about that. Jonathan, any thoughts ?
> New type of sensor, but sure could be in IIO.
>
> Seems mostly a human presence sensor. Not that different from some
> types of proximity sensor and indeed that might be the path to take
> here.
>
> Taking a quick look at the driver suggests there is lots more information
> needed to understand the ABI.  At very least needs ABI docs so we can
> discuss how that is generalized. So if submitting an IIO driver
> I want to see
> Documenation/ABI/testing/sysfs-bus-iio-xxxx
> with significant detail. The datasheet provides no where near enough
> info.
>
> Jonathan

Thanks for your suggestions. For the new sensor, it seems require three 
attributes, e.g. /sys/bus/iio/devices/iio:deviceX/in_threshold 
(in_filter_step, in_filter_type), then one data to indicate if it is 
been triggerred (bool), but I'm not sure what is sutible IIO type could 
it used? Do you have any suggestion?

Best Regards,
Hermes




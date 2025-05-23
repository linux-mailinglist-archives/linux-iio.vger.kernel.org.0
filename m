Return-Path: <linux-iio+bounces-19819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498AAC1D1F
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 08:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A577217843F
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63F21A315A;
	Fri, 23 May 2025 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="xldHVzW5"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020109.outbound.protection.outlook.com [52.101.84.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5214A627;
	Fri, 23 May 2025 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747982211; cv=fail; b=HfSqToLiQj7OZ1Z58F+ZO+Q8jfcJ+0yXfWnaj/hCmAs+jgIava7TwgXO44/ECMvCYefYaOyny46SjzliJBu7z7oNP235dkSs3+nFkETaKbklspI1+i8QzThKRJFcjfwTLcRDz3uoyfjSAFJcWA2Zn6fNj2z+IlkWAB0HoWH39F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747982211; c=relaxed/simple;
	bh=4d/gCoDwGwvOYq+eDGSN/WOSl+rTVXiTrMYr2c5RsTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GT9P+Xho2Upy1vR3oBvNAhUyXs3GcFHbXLUIn7GhHzBL4wW0G5M5IIpYiZJ4VZ4U5sffochbZewTaaZLmKZ+fbgJlWeIbAxyOX8SlqLu1HW+FaxxQL2DZq5BTdtUPA+GF8m4kRQ1JNAos2q/bwJgiOQkz1NIcaOHFcN1Hs3ZQjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=xldHVzW5; arc=fail smtp.client-ip=52.101.84.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMffb7XPo2oW6F7YLC+0CZgBRW5db00ButoRXvRaRqCPg8H3ZrJqwl9m1GqnA/wBDex3ZHj2jFSA9gknL+l3WslSmr9GbaicnCzXhddjwo8IW4VR0snoPXW4s0td+/K3luSkkg+QdOYnAvTBMGbRzAPnuNJdvDF6NWyGALqAT6KdlTyX+jo3tKNd/52qLjaDeD13Rb9GO2yawV/TzN5EGYhZKaiZl7dgXDJqaUXHBdLzpgQuGoZcswMmjo1zrJqeZiy8nXHPoM6QMBVkQiLw1GahR3T8PJ/mJo1VPOODa/+kPK6eud52ZFPav0sloAmmHkp7uWNCq5AdRjOdffoF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zjkUE1ytt94MkPZmv780FzF0oePWNj35ccrqMfwfR4=;
 b=JZPcMTUjQZ60bktqMZ2nn39bID4FOL6chCO1q1UZ7p4Km5ppiI4vDcipgascHfw8JRBCijbHTLw/bzz2w31jcX/MbJS/kyd0ugGaWuuuBNxq4KaMhRrnYrXMG0RYEbTKbx7dGvy0hg8eZIUuO3pkshhnW2DnK7xN7TDINp4pMlHGkMzVdiq0WP95DS1rGSvkA3HEn/ijYwWbOaU7E897srpGfdyBaHXJrl5mSd1o2S+KguDNR2ALMHAiUwW9eKrlT/ys8WFsvhzr98A41gKnMYASeiCNM+zqHUB7FKZldOrOGNEKfi1FflmZHOQNoptHW7EvHctK3kWZBpgnuHEYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zjkUE1ytt94MkPZmv780FzF0oePWNj35ccrqMfwfR4=;
 b=xldHVzW57Mghp3xYzuRWAKikkObEK5/dOXEGSkcfdIbkoS6g2j1Wietuz2oqvoT6Iwm96rw9jR2zTjrFzFbraQ9KYwzSo9GZsh1LQiqKDhx5XaVsHWKajfslJgA/s6jNcArqrd8O4AQbCK5AbpMnmaXDaDD7j9rsTFcSPEk15UvMlhQ25/qzxlk19NtB8HPi84PSxhf3sf0759PMRZyyb04luI7ur7Ud+K/urQMTA5Ik5Doyt/gE3T/WeUvkO3kPJ8UTuYLArZQYuu/vNJl14z/v61LnOMwAg7LcZA1NLoItsjNQv1WaGiHxUfb0++nBFd7XaBst9O03dxmdMpkzSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by AM9PR04MB8147.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 23 May
 2025 06:36:44 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%3]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 06:36:44 +0000
Message-ID: <d764e4b3-9c9b-4fbf-8257-be0afd43df58@gocontroll.com>
Date: Fri, 23 May 2025 08:36:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize
 device structs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Christian Heusel <christian@heusel.eu>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, dsimic@manjaro.com
References: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
 <20250522181236.00006dda@huawei.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20250522181236.00006dda@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|AM9PR04MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb62c2b-9642-4361-a2d2-08dd99c42f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVJ0Z3VZRHh3S1M1RHlKZDk0RFFVM3g3dXMyNnBkRGt6U1RrNGE4SlVBaTNI?=
 =?utf-8?B?R1k3VDBXUzh3NEtONjRkSU92NmhzdzlFTCtYcTUxSFZ2Q2VEL3NLaThKZ21v?=
 =?utf-8?B?TW9DS0dNNEk4emszV2RkTlovbzBxVndsT0dObWxrMXZOZ0VkcDIzdTdKSTVC?=
 =?utf-8?B?elhlMVNkcGlVSEE2YzNWOUgrVEs5N1RBcUJ2SThuZE1DQWRGOEFZOUV0ZEdN?=
 =?utf-8?B?VHltM2hBbTcyMnhvRTd0WEdGQ2ZBSlh4MVdzVTBWbE1SWFBmN0NEZ2RUT0Ro?=
 =?utf-8?B?K2JYRkhyOWZJbWZKbXVDZkxGb2NHOW94Rm1FSnhvTUVFK3ZvdWJtQlJxa3Zq?=
 =?utf-8?B?NEZDdkp2TFlseVlaT21XN1htT08rVUJLQWZUUmMybzJ1WVRLOG5Ic0laa0pq?=
 =?utf-8?B?b0s1MEhUTFVrSkN4RjV1dnRmNzZLbFhxWDROVmNmOFVNVnJEMU1Nc01GbW4z?=
 =?utf-8?B?dGtNbkV5ejdYb0xMNDV5RnBDTzFRQ2Jpdko1TVE3VXNlbVQzcEVGM0U0YjVE?=
 =?utf-8?B?MXJHV2loQWtPNTduTml2MXZSTkJ1NUxPYTZMSWtSWnAvZ3hBU2QwMnZBUFVk?=
 =?utf-8?B?TlZVRHpkVU5Xb3NRT24wZWhVSmdkY2Y0UUpsdkVyU2NSTUNmQlVuZkszVXY4?=
 =?utf-8?B?ZHNDS0pmWkwzdHlNMmpaTXUrTzZaNHZXcXVqdjlNNkthRFMzN2RpK2lELzRs?=
 =?utf-8?B?aWhUNk01U3Fjb2hqMzdxMDZNUTNTOFdUTlIzMXR3NlVuaDZtaVB4RGE3Q3R4?=
 =?utf-8?B?SlFYczA4bkxRVm85OHh1Nkw0YitPcFlhbkxad0tlQjc5L1hIdjRRUUtwNXNN?=
 =?utf-8?B?VmdJTFEvUmFUa25UUWNLL2owNmFja0IxNTBsdXE1d3N5elBSdFEzc1FqMDA4?=
 =?utf-8?B?dzJDZFFyVEh3RHdGOFdWMHdncVUxdGZYOHBGdm5saXJleHpIbG5vbFY1c1h0?=
 =?utf-8?B?WG4xUUl0eXUrcWwzUDdybkpuRm9HOFVCTm5ySzQvVERoUWNHMXN6TGwwYlo3?=
 =?utf-8?B?ZWVBSVVXNU0zeHYrSGRFTDg1aXhzM0VoUTk4dEVEcW1TeXRDUHBER1Z3cHNx?=
 =?utf-8?B?OUZhbG5iN081V0xCT0MrVWNIei9OaFJseXNUa2dtZDhWekZJYWNSYjJUMmY0?=
 =?utf-8?B?YU9aNzRHVnRTcS90SHJWT2o0SUU0QmZERjMweERHSmY4eEdWdTVnYS81V0NZ?=
 =?utf-8?B?Nmh6aEhGYUc5SXh5K1M4bE9ObGxkT3pWdy9yV3JpcUhMbVFaaEhENW1zOWRO?=
 =?utf-8?B?MTNFUzhUcGUrelNCR1Z3STBIaW5kOGNMSkxHZ0hRZG90K1gvamEzZ3FRUFhI?=
 =?utf-8?B?RlVQKy9ZRVVUaXpOalJILzJueEt2YUNOb2pvUGxVLzViOTQwcWo1STlWVFBJ?=
 =?utf-8?B?YUJWSFhwVGVhU014dFpDcWR1amRhK2Q1UW5DWUFpbmhvWXcyTWhMbnR3cjkw?=
 =?utf-8?B?bjcvOWw2a0RMTWtRT2NIWUVrcjFtMzNkWU8wMjIrMUlVbk51L1RxVm9ncXBP?=
 =?utf-8?B?ZHFERTQrOUJEMVRCNUUweFR2QzQ4clUrQnZ2NWtuNDhzNVNURzJZUHMrekk3?=
 =?utf-8?B?SFZiZ0hwM0JCSTZjcnRKTXBlYy9DdXpMbFlmV05OVHpxTG5vcU52T1ZjbTI5?=
 =?utf-8?B?Z1o0cDFJeFhEd2tkeWM2OWVxazNvR3VZT243OFJSLzc4bzNjTkFJSVBKY1Y2?=
 =?utf-8?B?S3VPMEZQY0N0TzRPWER6c2RUODAvRFpwaURBNk4ydEVuTy9zSWovMUZ5VkZu?=
 =?utf-8?B?VmhPUHNQRURuK2tqMEpZVUR3QXVvUGx1c05jUjhJN1FDTHY5K3g4bjFHcTEr?=
 =?utf-8?Q?Dmg7EHmf+0fCN3dP0zK0t6qZ4XhXVtZt14Vk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFM5RlBIWmVTOVA4RE5LeHhHb2R5MzE3bFlGQVM3OGIzb2NLV2Zqb1d5dHNr?=
 =?utf-8?B?eVpNVVNlaEpDdUlkYlMyZDZkanA3S2RLQTEwSDZWRTljS0F0dDBjMzYwOFZt?=
 =?utf-8?B?QVpaS01nazRyWWhqa0kyM3pUaVo2MkszekYyRUdCK0Juc0xTRmdiRVRtMHZI?=
 =?utf-8?B?a01XVnhmQmJWMkJERGo2MXFVTWVGRWozUUpaeUNFcXR5dldzYytrUm1qWEI5?=
 =?utf-8?B?NUNHM2ZsYVR0UDdIcERFTEhjMlR5cHM2T3lpTVdtUmJVdXg2TXJicGZTZEhr?=
 =?utf-8?B?N3A2WC8vTTcvcVRMNm1rS1dQeHYzbDRNempKWHJncmR3Z281ZmdET0l5bE1h?=
 =?utf-8?B?QW5icjZ2YkdzSFFQdzF5ZUJ0S1JZK0p5OWh2YnRxaHVmUHM5OGVURjRVbGFH?=
 =?utf-8?B?MHZUOVp3M01IUTBISC83dTIyTmRqOFZEYkpoWkcvWldmMWRhWm5PNGIrRzkw?=
 =?utf-8?B?cGtXTmE5TElOcFJZNVh6Q3dEbmlSeEdISWlyNW1XRjg1NWhYZHAvYk5KUyti?=
 =?utf-8?B?ZFlKdzJ1dTgwVEl4YnNuRjJsRkM3UTdyNnA2ZUtPQ2FaR1pZYWZ6cCtha0xt?=
 =?utf-8?B?eDBlOSttZlIxZ0tnQ3JGdmFCLzE4d2xoOFJiUW1ZVFErSkxpYlBFdStsUkN5?=
 =?utf-8?B?RUJBdVZHSXI1UzBJeWk1N1o0cnU4dlV6aTRMbSt5MjgzNE5QVDRJZ3ZXemVZ?=
 =?utf-8?B?SnNER3ZRMnhmbE5IeFRKWTZlc3YvQnE1QWM5dmZnUG1jdS9Ub0R1WFl5ajAz?=
 =?utf-8?B?VmFDVWk2YWpYYS9VWEwwdkRVYVhwdUFtUTEyWUprclkzZnE4ZThiOTd0U1NV?=
 =?utf-8?B?THE2QXVXcmcxQUxuRTNzSzdWSTZ5Z1A2T3U0VHNDVmljRzhsZnVXTEFYbDMr?=
 =?utf-8?B?SndMa0dTMDR2TlBKTk1Xb0Y5dEhsSVd4N282MGdlN1M0VGE5c3Y5SFlwZkV3?=
 =?utf-8?B?Zll5L0FUN1BYc1lJRTNTSVExSWdMSVBPc2tmU0xVNUhiUlQrTm5qNnpBYSts?=
 =?utf-8?B?K1JLd0NrUk14WE9ac0pqRE9Vb0FTQVgrMzlPczBQY2E5N1IyK1BrVEw4QmlJ?=
 =?utf-8?B?OUt2UVExM1IvV3o1cGJhajV3NkgzVFp1SXczLzUzak1Od0UzUHl1b2VTakRo?=
 =?utf-8?B?Z1N0NUtNWklDdWhISXpzQUU2THdBZE90ZHoycU9WbTU0SXo4UDU5dG5IWG1D?=
 =?utf-8?B?dXVGWE5oeSs3TEh4bkROY3JEWTRDOTFqdTFKcXRjcmVXdzN4V25TMUVRZndW?=
 =?utf-8?B?cXdQQitSR3lPcE00VS9pWkFkZ1hwcTA5ZUpkYjVQcmkxNVZIN2UrUGFqTnVa?=
 =?utf-8?B?Y1JSSWhaMTBnTlM1Q0w5RSt5dmlzRVA0THRlaXQwUVZrQ3hqWEZWRzBWaE9D?=
 =?utf-8?B?Ylp6N1RaR0N6ck43NXhiL3R2cTgrb1FXdjFYc1BDc3FmKzltWHNZb1RZRkhM?=
 =?utf-8?B?Tkx2Um0yOU1SaGU2WW9tZFNIYUVQRFl2S2g2YXlmSlR6MG9tcFdKRmtESmk4?=
 =?utf-8?B?dWoyektqdE9hamw0MjJPWVpCNUtWMGJMTXJrdGQ2eGlXS1RTVExhYkhIcXdh?=
 =?utf-8?B?TmpGRFFSL3hYN25FSmJ0MStlV2FqQnlZVXVsa3JCb2FuYUxQUW05dXE5N0NZ?=
 =?utf-8?B?TlRaR29HdlhhOUZNYlNOWVhJckhZaU0zcnJZWlFBSzBTVUh3dDJSWE5nbFZH?=
 =?utf-8?B?aFEzS1Y2YWUybG5BbCtMdkhvekE1bEJKVG5kemZXdkdRaGcwZzlrbU1Tc1o2?=
 =?utf-8?B?M1hkcmt4Ni9Cbml0U0pUQ2JXS2k5bDl5R2ttbHpCREF3NWpYZy9CcENLRjdW?=
 =?utf-8?B?ekZZSERmeVljd1RIZ0FFSjUzb2tZbG1CZUFHVFc0MEJtaTNqMUxTcEEzaDZC?=
 =?utf-8?B?U2E5ZCt4SExwVVJqc1Fyemk1a1NGNWdYMWlkU2d2ckVzL1dpOVlUYldiV3pP?=
 =?utf-8?B?RS9pRjhGS29wNTRnUVMxeVprNC9kZnVJVnZadWoweTFIanQwcmt2NVFRaGdT?=
 =?utf-8?B?ZWlqSU5oZ2thUTVxYUFGMkxBN3dOb05uNm1udHJBalE2NUwyWWhzdFF2OTRu?=
 =?utf-8?B?ZzZzYzJwNFA2ZU9kNWJHdzluVXkrWnk5SllMOWkyOXdJUnpQUUd4ZFlDQVQy?=
 =?utf-8?B?QWhBWXVINnJ1aGE1MDhSN0JVL1NtUTRnNDQvdVZmY1RnVERIT1VKQytqMVdj?=
 =?utf-8?B?bmlNeE9sMmcxVC9zU1dBbTdSYWhWTDRZVFVTRUFTYUpubzd3SWxjcGtDMjdM?=
 =?utf-8?B?aUtlWS9UYjdKbVh2UnFCZHFLVzFRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb62c2b-9642-4361-a2d2-08dd99c42f2d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:36:44.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6Ek7/1eAt6SuiY/qn4aF7mUrol0hkSoKimS86LGye3dYT30CnTRihIDljR5FOo4+DwzpodKuBhLHnjYDuVbrI5d52bIz+1+p9br2RLhwGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8147

On 5/22/25 19:12, Jonathan Cameron wrote:
> On Thu, 22 May 2025 13:18:55 +0200
> Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org> wrote:
> 
>> From: Maud Spierings <maudspierings@gocontroll.com>
>>
>> Throughout the various probe functions &indio_dev->dev is used before it
>> is initialized. This caused a kernel panic in st_sensors_power_enable
>> when the call to devm_regulator_bulk_get_enable() fails and then calls
>> dev_err_probe() with the uninitialized device.
> Hi Maud,
> 
> 
> Curious.  Given the device_initialize() is in the allocation function
> it isn't immediately obvious that something needed might not have been initialized.
> Any idea what is being accessed in there that fails? (i.e. any idea if my
> shallow detective work found it ;)

It is indeed what you describe below, in the stack trace from my initial 
bug report it can indeed be seen that the panic happens in 
device_set_deferred_probe_reason(), __device_set_deferred_probe_reason() 
to be specific.

> https://elixir.bootlin.com/linux/v6.14.7/source/drivers/iio/industrialio-core.c#L1675
> in iio_device_alloc() is where device_initialize() is called.
> 
> Using the device in the iio_dev structure is almost certainly wrong
> but I'm surprised it crashes... So I had a quick dig.
> 
> The only path that isn't a simple print that I can spot
> is device_set_deferred_reason()  That accesses dev->p (device private
> data)  Which is initialized only in device_add().
> 
> I wonder if we should harden device_set_deferred_reason()
> against p == NULL, perhaps with a message strongly advising against
> using it with a device that hasn't been added?
> 
> Being in error paths this is the sort of subtle bug that
> rarely rears it's head :(
> 
> +CC Greg and Dragan for thoughts before anyone spins a patch.
> 
> This change is good either way. I'm just on wrong computer to pick it up
> right now.

I think I may need to send a v3, I didn't add the stable cc in my commit 
message above the SoB tag which the kernel test bot is informing me about.




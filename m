Return-Path: <linux-iio+bounces-10960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCEA9AC033
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB71F23792
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD232154457;
	Wed, 23 Oct 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MZCpTWue"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385D14BF87;
	Wed, 23 Oct 2024 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668556; cv=fail; b=BOtQzKY82LOOLqNewOwPAf5WwT+UEaLU+b/o938+av6tHGtCqj6lTvJRBxPqjETulR+MhXfDXtt2MPwXQkezfOWljshHVEkWG3jkrtcDD9vl+TnYkKD/B5LRzu+myLsRtz+wNhSiA9a0pATyk70BMi0YWCtJVy+Rev9wGBMgprQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668556; c=relaxed/simple;
	bh=7GPRlubrJNLBsb0NWYA+E8gwQpEEKk9XwDUjRDvnzUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rs2RoTVpXU9ZKtagA5xpBhNTQCa6aRgj4YecDeP1+g+q+fMbcKq9xLT//QFzvcXNoS1+IwMeaO4Kg3sBH96n/xHQIATu1A2Qbz2KjzBcVFAiSRpVX9GouGr3gyeBWziNSlWERanIhMm/+RgbX6cp734cXRuiQCCbnJLGykcHcBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MZCpTWue; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+DAqBB19/nrg9HwNboi/6gOmlUTXmYJuQYx6TZQEhWPJ2y0wecPxuunR/1eCumwqiMMPY3Iu4351YsrqIPVoxcIl8glHmVkx9Wp/uSweaSPdL3HmmXyHnnlhYjWSZnnSBlwbLG8erU2vNqYqbgtEE8iZDHVQamP5yRzUqUp6/Qx8KXXy4jSTR3v18uWVXYlSoKu1NQi73WJXZMmgGqWynOt5SYNzZyzhVpU67iTlphNqmaC0zuB1X3THetMbLgUu8foVnraO61AwIU/fZPjx4BPPCk7yPwTZWDdSP79Kvi/FmvVmRSVsshQUnPVwlStzRxgH6i8SsLWW6xfvAvRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00bpYUuX5ZJ+7CzBfNjQSl//OF4g4cYegXq3tnvVWdc=;
 b=JMpYSPMIcx4voJ2DUJ44if4ME6z+Si25jsr4CphGAM/WGzaCIy39vo6Q5PYditBmFutkrU7n7YS82MCaEZv0Znsm4p9/sYp85bVozBzR/CW6+PeL+1m74r726gQwkVOq6GA30WrJrqY0hWOtQldyED+mYBZX6WgX5FAY3h8On+KmG5DMzimBu1jWRN07HofPdGskiEPqdQNGsiOWi2gKLr8BloAZtoP6KhxjoQ07lq15FlIvqO8y8jMbMgVSxu3dgzsfaIkCmgNfOfPundyR3pMgt6Q/2t0sYsm9wmDtE/uH1em+FlY76G9DiCGNU/nv5sDc2StTfyh30Ol0ztHsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00bpYUuX5ZJ+7CzBfNjQSl//OF4g4cYegXq3tnvVWdc=;
 b=MZCpTWueJknKYcaICGRqJDHBpIT+/iSjze0Za7gcltwFho+/9EXEhEIXVh5eBGWaj7TUqpJ0UrpuEp3gx+PJFphXDY6GtZNEnsUHNl8st3ijX02fkBEZjYMQpl01m45Id0YTy2xgzGPXj0Mqfl4rn3TXWHLrWUhAu+W3CIiNGJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by GV2PR02MB9398.eurprd02.prod.outlook.com (2603:10a6:150:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 07:29:10 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 07:29:10 +0000
Message-ID: <10d6bba4-4d25-4ee0-877e-48a27c622bde@axis.com>
Date: Wed, 23 Oct 2024 09:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
 <20241016213409.3823162-3-perdaniel.olsson@axis.com>
 <20241020135105.36b29fe8@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241020135105.36b29fe8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::9)
 To DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|GV2PR02MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 00adedb0-29ef-4c1f-dbae-08dcf334628c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXhpZmJNZUljVGZObW5wNWwvUG84VzluRWxLa2JtMWpXeExVQXRxRjl0VUt4?=
 =?utf-8?B?N21oZEc3T2tpdlJ4ZVVqejdYNjFtb2NBM0JHTTZRZ1I0ekE5KzVQM01UOW1H?=
 =?utf-8?B?NXF2M2ZMczlZaloxZ0pBZW5yem00SEJCT0FjeHR3LzB2TjdqakFZcWFWNWxS?=
 =?utf-8?B?ZWErT1pxaHBwQUI4a3JrV2VaS3VMSVBJR2FqTzlWa1pPLzBKcjdpY2YrWVNQ?=
 =?utf-8?B?Nzg2MmFYbVBjdlZOY2twQjFnbktVWWdEb0N0ODR1Z0VKTSsva3UzdUJMdkFG?=
 =?utf-8?B?Tmg0dW9ZMFlMa1p5S2Erb2NGdXQxQjRQQU9YY3B1anA3SEs4ZVVoQVkrMDFH?=
 =?utf-8?B?WkduL0c1VS9uOWlxSmwwY1lGeVVlR1dNN3NPdml6WVpZaVYweWtOdEtaQi9W?=
 =?utf-8?B?RDJuRmFjNCs1Tm9majRpL1dvaGZkS3M5TUFNRXkvUVJxd1p3R3dYbm13QzFD?=
 =?utf-8?B?a3dYYSs4bWd1cDJ4Nk9jM2lpT1NvV0J6S1VybVlYT05pZDA0N1JlbmJyWE1x?=
 =?utf-8?B?dmppZGtxT1ViSjhBU0JFSmhlSENCY3RUd0ZqSytFZ0p1V3VERkJqQW4wWnRC?=
 =?utf-8?B?R1NQRVdzVTR6MWtUVzZna1QvbVhZeUxsd3IxQ0xrM3RGVThXZTNqQkw0bkRo?=
 =?utf-8?B?ZHR1NWhSa1dwYlVtL0JVSUxQUVpSOWVOZXg0cjFlVWRCcDZKYVg2NU93SU9u?=
 =?utf-8?B?RHVmcGd6NFVPcXBwMkZZbG5EV2Fqb3ZOMEVnNU90bE00eXVEb3VyS0MydjNU?=
 =?utf-8?B?azRCb3MxRGpWZEo0MWovbkdvK1JpWE1oYVZsbk92M2pnUHJoNGFtcHRIalFJ?=
 =?utf-8?B?TWRzdEhqQVN6WWx5VDZMTVBnZ1JWc0Fqb2JERHA0eHV3cTVKME9VdEZmZXdt?=
 =?utf-8?B?VmIwSlg4MXFHRFk2YXBNZkZlUFIyaTlYaERMcUJwQldibTNHb1dOSzhtYk0y?=
 =?utf-8?B?NFhyY0w2M2k2c25Pb1dGclpzY2xWVFhwTExDTklrS0szandWbENoTC9aczU2?=
 =?utf-8?B?WEdlb2Z3dWVINHZNbEljaS9DaE9NeGtIeE5aQkt4ak9Edit2aE0zd2dqcEEv?=
 =?utf-8?B?WjBtMVo1czNpeVl4eWNnVjd5Z0hKeUw4RU5YOS9NN1MyZHZoY2FMc3hURlN0?=
 =?utf-8?B?cnBlRlpHb2tpVGpiby9xWDNLcFBON2JtYmlna3oweG5qNGc4bTJwOCs5UGlC?=
 =?utf-8?B?dEh3TVoxNmMxWWFoNzlTVnlQOW56WnV2QVNNdUI5K2lxRjFyeElVMGdYTU9r?=
 =?utf-8?B?dldBRnJWanl1TGNneVlueTE1NlNZSWRKUmhTbGNlbVZUT3hBc240T0Rkeit5?=
 =?utf-8?B?NHg2dnVkWFJ5cVpaVStaajRYR1AzNHZKWXJveU1XcmV2Nkdmcnl6Um9hUHFM?=
 =?utf-8?B?ZFJmWUphdlZIQ1c2Z1YwS21oUFZjeVFMa1c4STJPaHdqSEpBTy9ZenRxYkwz?=
 =?utf-8?B?eWRUTUdRVDdSbm5ad3l0ZnlrdGgrbnd6cStMelNmOTRvZVp6V3RtZmM0Uklq?=
 =?utf-8?B?THljYjZKdVpFbWZiSVJKYjJLcGFvczRzaCt2MDV5UUkrK0g3bFRURE9UZXdh?=
 =?utf-8?B?UVNzUzhmMUJ1QlJwekpac2Z6L1RwNHFRLzIybHNxZ0toMEZZbWRpQjFhQzFp?=
 =?utf-8?B?cVZWa3RERlNpRjMrT3U0cktmK2ExaXQrOVU1ODNaUlJJM1dVSkNQOUNPOHJl?=
 =?utf-8?Q?7IOo3epDLcBepQbjiMAg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zlcwb2tnUHgxMG5FV2FDd3g5azV1WCtIWm5lYUdhMHY5eGFZb2ZFR0w0Z1FC?=
 =?utf-8?B?eXNiQ0UrTll1dUJOT2MzbGd6TTZPZm1HeFJhQS9LUncwRmRCNWY0VGw1NzM2?=
 =?utf-8?B?ZHlsUm1jK3YxczBNMnJTd3ZiWGR6TVhaZjhxb3J1ZFJmRGtUOFhJejc5TkNr?=
 =?utf-8?B?WklrQnc3S0haWmhxL1dlalVvTHA1eWVEVnFRMmlack90UzJjOG85U1JBUE9x?=
 =?utf-8?B?UUZ5cnVJY2NKN0lxb3A5Z2xCVUg4SHhzVHVPUGFUcisybWsyYjNtdU9YdDM1?=
 =?utf-8?B?TnpOQkZaNm5uYjFiMXhEZSt3SUkzc0hqWENINHAzU0Y2NElsY3dDMkZyRnZo?=
 =?utf-8?B?czNvdDFSSEZXeEFpcmZieFZ1MUZ4TEFndEdUUDZvYWhRN1ZFbEFEV1J0eE9E?=
 =?utf-8?B?WlIrbUJRclh3Sk9vb0N5dHBFcmZ2VDJscCtNZDNqTTN3cVZaaGM5WWRDMWZ2?=
 =?utf-8?B?aEdqK1JFLzJpSmI2MUp3WEVZYjVqTU9heldHVjBseWlyOVg1bnhRSllDdWE5?=
 =?utf-8?B?dUN0QVdsZ3RwY1g3eStQSVJoVm8rdlYzdkxKSXlyMmRsckV6eXpYUUUxZ2Yy?=
 =?utf-8?B?V2JPTFI4S2pLL2tDQkRENXdkSHZsU1cvTjRmZ2QwRVdvRTBXMHNaazJYL0xO?=
 =?utf-8?B?RkRJNHZ3dFZuRFJTQVJmRzkwYndtU2NoU2hVMHBpZUpqcGxuT0p3REY3bFpw?=
 =?utf-8?B?aTFJMlVnT3RGWml5cDg4cys0WlgxUk5aRE0vREF6dTdwb0MvN2R4TUFuUjFQ?=
 =?utf-8?B?Q0NkQ1ZNSUxUK2prSWtPV09wSVlSdE9ybzRjQ2xIR2dpaFJhaE0vTk8reUI2?=
 =?utf-8?B?b0h2RUVYZWFoOGx0aXZ4aGZvSHVpV2ZtOVd5UUVvOEtJVmRManZsTEV5THZt?=
 =?utf-8?B?SkJDdGJLWEh0VHVCWkl0d3AxcDdtREJHVjRscXFJRlEySGw3TmdPZ0ErTGZj?=
 =?utf-8?B?ZkFRL3FZKy8rUS94dlBCUUl3TXR5TGN1SXZkcE9RVmdjTTZFZ3ZKVXZpZEo3?=
 =?utf-8?B?bWxFVkIyVVRkcXkydDJjaFV2Z0dxbUlCcGVLUVUvNzVVU1htK0lkTTJ1aWww?=
 =?utf-8?B?ZGh3MWpNZU5FR0RER2dzeDVLUm40MGV0VURCZVYxNC9jQk8rN1poZzk3TERx?=
 =?utf-8?B?d1pmVHYwNHdnbU04L1FPakg5MVM3anVpTERjam11RUMzL09jL3Y5aWxaOHc3?=
 =?utf-8?B?a1ZwZVEwejVTc0szTVpsVVU3WnFXa2M3NGFmK280eStWd0ROOVlhaFBCWGRO?=
 =?utf-8?B?QXphZWZ5Q3E2SWJWK3MrSHBsWllxSnVVSG83NDg1cTJDTHR2QWcrTVI0aGJ0?=
 =?utf-8?B?Wjd6L1p1UlBodWlVbHlBUEZsZk9pWUxmQklBblVITDdzSnVYaEs5a0doQURS?=
 =?utf-8?B?dnZILzQrT1NHYmFsRWJqNFBNaDJKeG9WRUxobklzbi9YbG1DTGFBTnNtVlRT?=
 =?utf-8?B?QTUvSzJCUDJ4WTFCUmw0WTZyL0xiSmpSUW9WUWNzcjNMMlFsWnJvenFZZE51?=
 =?utf-8?B?UHBsaDU3WUdCaGF5U2tVRk5JT1BFNUxnN0VrNnNiYzAxeWM1Vm04VmZHVSt4?=
 =?utf-8?B?d2lXeHFYQW1TbzRmNk54dTFCNFZCM2FMb0hMUEpnMDVrQjRnUk1lQmlsZm52?=
 =?utf-8?B?WHkrMHlIYk9sSjF4VCs4K3MyRkJNN3lFSWd5Ui93ZjBNLzlNQmFGa09DNW1i?=
 =?utf-8?B?bXpMNEg5Wk43Y25ES2k2WkhZSVltYlZHcWFhQmU5V0hVMHE3aHhGb3c0Q0ZH?=
 =?utf-8?B?eGlqbSttNldXTUlhbm5mQll4dGJkZ05paU1nSGVOakdja0s2bVVBTDgzU2hD?=
 =?utf-8?B?cDlucWR5OW9Hcno5dVFBdnB4ZXJmZkUxY0JEVjFYenpGazVZK0lTVENEQVV6?=
 =?utf-8?B?Rm9UM04ySkMzeE0zY2ZZMU52RFY3WUE4SFhLVWZwdEdTT3lQd3pJZ3NkYnk5?=
 =?utf-8?B?WUxydXgranV1eXJQRzF1UVhmUXhoQURSQmtBeXZER0xqR0ZaWE03VSt5V1FS?=
 =?utf-8?B?enpwZ3Izb0ErbVZTdk5NUytJc0ZBcTk4RTFaM3pDOEFCVHJGWUNzK3Nqb0Ur?=
 =?utf-8?B?V2JvNm5oS2l4L3I2ajA1aHc1Y0xoeHVLZ3QycGQ2UHQ0bmg2NFdMTytUL2Jm?=
 =?utf-8?Q?G6+s=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00adedb0-29ef-4c1f-dbae-08dcf334628c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:29:09.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO8ToOzscxQk1kMZQOaRlMlyVYqbe+RGo3qCSMG08EJj57Yt3+luylgPdKg426qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9398

Hi Jonathan,

Thank you for your feedback, much appreciated. I have added questions and
comments inline below regarding channels and triggers. I will address the other
comments in the next patch.

Best regards / Per-Daniel

On 10/20/24 14:51, Jonathan Cameron wrote:
> On Wed, 16 Oct 2024 23:34:09 +0200
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>
>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> 
> Hi Per-Daniel,
> 
> Comments inline.
> 
> Jonathan
> 
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> new file mode 100644
>> index 000000000000..2c3761ec423a
>> --- /dev/null
>> +++ b/drivers/iio/light/opt4060.c
>> @@ -0,0 +1,1259 @@
> 
> ...
> 
>> +
>> +struct opt4060_buffer {
>> +	u32 chan[OPT4060_NUM_CHANS];
>> +	s64 ts __aligned(8);
> 
> aligned_s64 is now available in linux-next + the IIO tree.
> 
>> +};
>> +
>> +static const struct opt4060_channel_factor opt4060_channel_factors[] = {
>> +	{
>> +		/* RED 2.4 * 2.15e-3 */
> This needs more details on wrt to what standard etc.
> 
> The datasheet is a little vague, but it seems to me like TI invented their
> own standard. To use this stuff in a consistent ABI we need to have
> a common standard or at least an approximation of one.
> The illuminance estimates from some devices are bad approximations, but they
> are at least attempting to approximate a well defined standard.

I have read the datasheet again to try to figure out what TI means. When I read
it now with your remarks from this email and previous emails in mind, I think I'm
starting to understand more.

I think we should expose the data from the sensor in the following way:
- Four raw channels (R, G, B and Clear)
- Three processed IIO_INTENSITY channels with normalized values (R, G, B)
  to get the relative color components independent of light intensity.
- One IIO_LIGHT channel giving the lux value.

This is basically what TI is stating in chapter 8.4.5.2. I know that you don't
like how TI are calculating the lux value using the green channel. But after
reading the description and detailed description parts of the datasheet again,
I think it sort of makes sense. Looking at the spectral response curves on the
first page, the green curve covers the whole visible spectrum. It seems like this
is what the sensor is actually designed for, measuring light intensity in lux and
color independent of the light intensity.

Does this sound like a way forward you think?

> 
> 
...

>> +	if (processed) {
>> +		/*
>> +		 * The processed value are multiplied by factors that correspond to optical
>> +		 * parameters in the sensor. The processed values gives more correct comparison
>> +		 * between channels.
>> +		 */
> 
> No to these.  We discussed this in review thread of earlier version. There is no
> standard unit of comparison defined so this ABI is not something that userspace
> can currently understand.
> 
> I'm not against introducing one, though it would need a bunch of investigation
> into what the appropriate way to define this is. TI have chosen an option that
> I don't recall seeing used by anyone else but maybe I'm wrong on that.
> There are several competing RGB standards. https://en.wikipedia.org/wiki/RGB_color_spaces
> provides some info
> 

See my remarks and question above.

...

>> +	/*
>> +	 * The threshold trigger allows for sample capture on threshold interrupts.
>> +	 * Just using events does not enable a way to get the samples that actually
>> +	 * triggered the threshold interrupt.
>> +	 */
>> +	chip->threshold_trig = threshold_trigger;
>> +	threshold_trigger->ops = &opt4060_trigger_ops;
> 
> Whilst I understand your usecase for this, I'd rather not have it in the initial
> driver.  The use of events to trigger data capture should be a generic feature
> not one buried in a specific driver.  Best bet for initial merge would be
> to just stick to the dataready trigger alone.
> + I'd also encourage you to look at if your usespace code can be made less sensitive
> to slightly late read back and hence potentially not a precise match with the
> trigger event.
> 

I will remove the threshold trigger in the next patch. I have started looking at the
generic feature that you described in a previous email but it will take some time and
it will have to be another set of patches. The team here working on the userspace app
will have to adapt until this is done.

...


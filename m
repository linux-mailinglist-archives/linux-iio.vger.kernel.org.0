Return-Path: <linux-iio+bounces-8801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434995EF93
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCCC2824AA
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C414F121;
	Mon, 26 Aug 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QGT0k/pF"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F0143C7D;
	Mon, 26 Aug 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670940; cv=fail; b=pCTIf4YqpYb18EczHR+byeot9Ljk7UYYh+g3ERucgK+YttwmJeUojQtlZFyHbN8e8l0h+1pYDSRdhy11YfGbHvnefABSmACMVWIbjYbiOjeTl11blgAu+5QYuWTYh/bQuWz47gN+0HcoD6BpLC89g05JjIv2F+A8AAUhZpwaYh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670940; c=relaxed/simple;
	bh=j0cni70zkjrbILn7BDp7N97zOxhz48M6YBVqCTLtA84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdhEjCzCVdS1ZWgf+YF2rAuc8ORpDpZknNxhlvPFqRSBYXOhfcJh44BsFReJib18A5UrPLcXH4qaFAGkCRYOEN93u0E1KOPLNrO7R154MfS9irwJEJhqhmzuw7tArEGHDZEHQojBiB1LHumk5M72KfZQzqQvIF94ODt9Ke7Sh/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QGT0k/pF; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LynYjQPqGeDuB5tZXd26CdFslyCwf0i5co6lvenDZ+HCqI92G/8LeFdaPfUmvd3sIUH5ggp7VviJFJfe0NzPSfuir5VFk3WVcWbtCEwoxfOHZ0ywaNf+OI8gwgfzN6pL1nuiTRuU9GhsjryHQ+BtEtLEf9e28SPwIjnIWzLtwECSKfOLuJ8otFFlEVVXjmM8/ySLZdntrRzL0saovbpeRHwHRf4f5U2eiqRd/E/IgS3BS6cb+KKdxSq+rfb06th6yXjq7mwqt/7FOvcG4bKnU+xHRSOKVgtwAd1NfJtdzkcdaaLh2AmJawVaUXKqH49IYoHBl2ENhwbgLuL8rI43+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuxSgkykegk/eAzdtjTSGihen7IqIaCnjHdKnfVj/Ak=;
 b=DhNRD6AtUvS0RlFoPby6eQks7Qrf9PhOuKfG1cKnArCjUZpkoeUp95CSs+hKfg8PhoT102PuK079Ybk+xDd1M4qRzW9Qg6fiuV4PruO8A46qj9IqzNeCuX6tum07T+4NqnRAD/9/4kiSLy8rL94FsrmIdQ7e/XDGgvh3G+B1C9ZAP7P8ulrQ3avWLY76rCkwEsDDeuL0g9qMWnDYb2rRHQPJDTn0w3nFIGbWPDdXOgaYula+vGSYxarYWpQssiRWYB972Y08ZBOS4meVzBRTecnvt9WDw3euTD1VId28wOPe68rqegaDTK/nD1c5ZPID0xRRBSEBErw321KITjjFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuxSgkykegk/eAzdtjTSGihen7IqIaCnjHdKnfVj/Ak=;
 b=QGT0k/pFEjwuGu/acvLo82dXwRStNe1GrNZ/aeNKepRYS+D8NI0uajycam3WHN24idhAbnlZJJuZSoJDi+4NT2LXGk50if4RUIek1g29+2wX5OxuDn/FawtwmryjSkZhO0lWaBX+t1EfiQIzV7ACkMARPTVrtWuXVAnmlvAKzOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:15:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:15:35 +0000
Message-ID: <66609a52-6a30-4642-9fff-5e41f58add6e@amd.com>
Date: Mon, 26 Aug 2024 13:15:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: xilinx-ams: use device_* to iterate over
 device child nodes
To: Jonathan Cameron <jic23@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
References: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
 <20240820-device_child_node_access-v3-1-1ee09bdedb9e@gmail.com>
 <20240826115226.43027f1b@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240826115226.43027f1b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: e88b16f6-7d6f-4e13-3540-08dcc5c0686e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SC9MZjlHRGdUVWNTbTdLN1FjbGoxV3Y2Q0dWekRpajFmODlDUm1XMHpvTW1x?=
 =?utf-8?B?QmRhMEJWbDVuRGt3NFphWUxkUUxKSVI4K2NvRHpvVERmRHZML2MyTy9lMGVs?=
 =?utf-8?B?K3A1TWhwdDUwd0ZLSzUzZW9IeFBwZ0NsTCtkNkZ2TUxhdTdzaUR1SDVodU9o?=
 =?utf-8?B?VTRNaXNGZnY4dUtNZkFUcUVxRm1IbFo2QnJuK0lvNlo0eXdwSENSYkE5clh3?=
 =?utf-8?B?blp6VytzekNoRlh2MHFiOW52dmlxRWcyanQ5WkdpZXFDUGlLNE9LbnBKS1Iw?=
 =?utf-8?B?WVRzeEE3cGQ4cmxldVI1UWZwaGRQZjlUOC9DbCs0Nk1lbEhLNVRhZyszWnZw?=
 =?utf-8?B?c1NWUC9PZVAxVjVKSkZCOW5tdjhzaGRKcnBIdUZtbWk5SU14dXoybWdGd0Jr?=
 =?utf-8?B?UmVhcEUxYWNrOUcyd2ZjTGdMWnU3aWZkb01SWXZCVEMxVUFxQk92K1B0TTRP?=
 =?utf-8?B?WUNxZC8xdExHK0M4dUVGMWMzMEdkVWVrZ3Z0R1p6YXlRMGJUdkY3Y0d0a3hI?=
 =?utf-8?B?Ym0zbStCYmNaazdxNVBBNm5mMVJnNlFXK0cyUTFLa2d4a2VxL25qYUs3VDdy?=
 =?utf-8?B?cFhYMnl4ZkFBTUt6ck53eW05Y3pudWdpNWFOaEpkcnNJS0o2OHU5eTNyNlNF?=
 =?utf-8?B?bUdlK0ZtaUZQN1ZGTDZHb3ZSNE0vRXlld3R1R2JTMEU3Ylh5WjlmbTQ3aUpj?=
 =?utf-8?B?MmVyaUpKd24zRis5ZVJiS0NXNHRVbTJZR0U0TFVRdUFlUjFLYy9KOUJKMjYx?=
 =?utf-8?B?eVZqWHg0Z0hvVjhqd09qTFZGWlRxcVdSNHk2NEFES24rdzBXZUxYUStONUk1?=
 =?utf-8?B?L25zbjlHaURqdDc2bUJxbHM3cHBDVzFFYm1yQmlkNWF5aFhzUDQ0ZUhFSExK?=
 =?utf-8?B?N3hjY3dlTGQ4d2JLNFRSQUdPbXVIY055M0JFeU1tTnpBTXR1WE0zbXNPWnlR?=
 =?utf-8?B?WEZEK0E0VEhWZVRTOFBqcEhGU3dLbFRDVEUrbGZ1SWpEbHJ0MEkwUUxkK2hy?=
 =?utf-8?B?WUVQSHpVdmZORlFJd1BqOFRYNjV6K2s5a0x2djQrb2wxMnRBMW1Ya2pYWnB3?=
 =?utf-8?B?eWhOenhpVWg4ZkRzUzhBNU9iTkJ4aFU3ZlhrbW92eDErRXUzOS9jU3o1VkhS?=
 =?utf-8?B?b1cvT2Raak4zelFGQmhwY3VrNlB3bjhwTjdycGFxSjR5MDYwcjRrN0kvMjh5?=
 =?utf-8?B?ZVVNQ1k2Q0hnZmhlZ0VNcVZCWi9KYndtZ3M1c1l0cm9mU2c1V3c5ZTlCNUMz?=
 =?utf-8?B?REprd3g4RU51NytuSHg3VWsrdUs5WElzUHpicWR3VkFYc1hkTXA1MnRzT1Bt?=
 =?utf-8?B?L2EzN1ZWRFdrRjJhME93bVptYWpoV0pSMHo1cEtUYWw4cWk3bVZLZ3A0T2xm?=
 =?utf-8?B?SDB5eTZ3SCtTMTVLMkR4K2ZDNVZQRTg5clgvR3U0R2MxZkhvV2NKMUtvdTJw?=
 =?utf-8?B?d0hlVlNPdkxaQmRhQkFGNU96KzVseHBRVXE0T0oxbU1tSGdHWVZFRlhob0Rl?=
 =?utf-8?B?NlkrcXdoNWRMZXBaMStiaGp3N2JPRitLeHNBbGxHdXpESEZnM3hPUjdCU3g3?=
 =?utf-8?B?RmF5VjVOVkhxZk5BMndkdlhaanJZWUEvTGRVU0hFRUF1MTQvc2lwSzZ5aXJC?=
 =?utf-8?B?TWZCU0k3ZUh1RVlBRjhNN1FCQmVSQ2xSYk84dVQ0QnBkb3JITXN0N1BnazBE?=
 =?utf-8?B?S1NPWXBZb1drajdrVFZOYytWc2ovNzZ6YnZhMnczM2VHLzZtWk4xV3pkdWF4?=
 =?utf-8?B?RlRJVzVKME0vUVlBbDJYbTlNelFPZ3BsQjFyUkRBS3M3Sk52a1IzN1dmaFlQ?=
 =?utf-8?B?UHZFRjlkMHVLSjZ2NXVodz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUdqUFJVY0xueWNvdkh2eGxPeWwzVXNJSGxIQSthSng2ZDRaZWk4dFBNLzl0?=
 =?utf-8?B?LzlhaHF2akR4RUJveUd6TVpEbVVvS2J1K1hIcHIrRjVFclNpazVxSXlaSWRp?=
 =?utf-8?B?SkpzY0tMMkVibU9NOHQrMHczbmNZL3ZvMHJPWHkyUGMyQ2FGUDZnSHFHWmdQ?=
 =?utf-8?B?TUlHVjlhRlQ2WDRyY2VvTXVaY2t4Nk5nNm5uZW9GcmMyWHNtL21jSGZqVG5I?=
 =?utf-8?B?RWdPaDVtSzNqakE3UzYyVFBDNEZyVVpwTnFrZGo3WTNhcDdZQUtPVmVLaldE?=
 =?utf-8?B?VDNnU1BpQkpyRC9OaElGQm80UWZIRlpXV2NDMlR0Y0F3Vytubmg0VlBKQlFF?=
 =?utf-8?B?citqNEtaR1NINHFURDVzem9TZUJYSVVyYklSK0p3TEpZU1NBNnFBeEhJaktv?=
 =?utf-8?B?Qk9jcGp0NGVpcTJad1NlVEtQUHB4NTZlMTF4Y1hnQ2Y0Ynh6anQ1QlBiaS90?=
 =?utf-8?B?NE1ld1hFNlllUzNjQ3pESytsL2tpcHczTnZ2YmJQUE1YWkNNTExaWVNQU1Y3?=
 =?utf-8?B?MXBNczB4L0JXcW1XSjFoY0ZqS1plN3dlbGRCdXozNFVHZEpqTVVUWVhNUmdI?=
 =?utf-8?B?RVpZU0UrTDFadnQ4bjlvbTZCYWxIR0pzYkZra1FRNnJDVFRWR3FPeWJTK3VG?=
 =?utf-8?B?UndKalN0VTl6Mm5rdkFIdG83aTF4RGdsUkowWE82SGQxT1NxV2VXMXV6MEFQ?=
 =?utf-8?B?aUZKdHFWZ1ZwNWh6dXBWMmJGWlRHTG9NbFM3SXNNV3o2Y1R2ZCs3czRQZU5O?=
 =?utf-8?B?U1g4MjNUbi9hMDF3b1Nrb3VJWmRPSENEZzhpSmVLSUVZTG1YbnpKWHJ4cE5M?=
 =?utf-8?B?SnIyeEhkRkt4ZnZrSktUTnZZRThmTUlNUFd3UGg2RVFYdjg0WU9zMDY2VmtM?=
 =?utf-8?B?RjRNcXYrT2J1UFh2dGdzMmlSSjZuYlhaOFZUcjRwa1dSbFRSbU80QmJiK3B2?=
 =?utf-8?B?ZGtRRXdWMWU2bHplQWw5SnhNM1NIWnlDUWU0VWRSdUN2K3dNVEpVd1FtZHpk?=
 =?utf-8?B?Zks1VHZYQ2lBVHhka3pkckUxSm5jT2NFYnZiQmZlZmpBZVMwbEtlNHdJOGxD?=
 =?utf-8?B?Zm8rOFVQYk1sTG1kYVRGZi9nMnh5Lyt5KzV1cjREYmlLaXJzc3B1TmhKYXpZ?=
 =?utf-8?B?QVV0ZVhSZjVJUGgyK1F4VXQ2S3J0LzJTM0RLVndUS3JjbzUveGcxUzl6N2xE?=
 =?utf-8?B?ZXRFN1owTE1LL1g4Y1EwbHl5bkFaYndjazU2WUZzSXRISlZZQ3ZMdGNQampL?=
 =?utf-8?B?c1NGQnpHMWV1RFJSTURiQlgrVFVVUDI2ZmY4ekFwUWV0S2U2ZnFtSUY2N2VX?=
 =?utf-8?B?WjM5aWZ3RCttV09pMlJVc2d0UW9vZHY0S1RRSVJmem5BTktGYVIxd3k4UGM5?=
 =?utf-8?B?RXhoQmxHWEo4aVM2Z0NTMWNCeDYvdDhtelowVDE0dmRSQkMwQ2QyT280MmMr?=
 =?utf-8?B?ekhlYmNFVXlwL0VFeGs5YlFKZFVla0N1UWwxcm1tVWY4K1I3dDd4THRneVIr?=
 =?utf-8?B?Z0puS2tSSTNpdWoybWRXWVk4RUUzOWRRMXVqcjVramJkaGg2bVN6TmVRRTdD?=
 =?utf-8?B?OW9HMTVEUjlkWjNmOGJBYWEvLy9WR1JqT3hCcW1hY0pVN0ZYbk9IY3JwUnl4?=
 =?utf-8?B?b01MTVRiU3ZGMXNRdlZMVC9kY1ZmSW1nS3RoT1R4bmZVQUNhTVNiTTI5MlM0?=
 =?utf-8?B?MWxrUmszN09NQlk0Y3FvVmFRSGY5ZjFUSWttdFpaUzlWdXZ6MFBzR2trRnFO?=
 =?utf-8?B?dlUrLzEvQWlpbU83NFRQN1hnOEpVNEs5Mzk5UHBPc1FJWUNKbmdqTVN2ZllV?=
 =?utf-8?B?NjUxOStrZ1ZrbVB2NXk0WmhHR1lGSTFNb3FjajNHQloyMm4rNklHMm5UNXV3?=
 =?utf-8?B?RzFJVUwrRlNnemd0cjBFZlNTOWF5MUxqeFVra0VLYlNTb3VHK1grRE5uMll0?=
 =?utf-8?B?RWN4d0ROU09uWnI0clY5cEJkMklJWERvTnJBbGh6S1RxdWUxdzZsdEpUMU5Y?=
 =?utf-8?B?Q1JKZVR2cGJyWFNpbU00WnEzRUVOZXNQbStSMERpeGd3MDg2WWwrM3h5NEx6?=
 =?utf-8?B?NjZqa3pxYUxCcnJoZnQ0OERZWWhObmNPc3c1bENIS2tOQUhkQlpHZklYbk1q?=
 =?utf-8?Q?rgfuPH/4yC3YNT2R6DWSFDybh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88b16f6-7d6f-4e13-3540-08dcc5c0686e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:15:35.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLb3YMr3py6ZJ4U9o6yihvTZS7CPoUNSXKA5yx+l7rerBZDLc37tT0mK7sSjF+PV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

Hi Jonathan,

On 8/26/24 12:52, Jonathan Cameron wrote:
> On Tue, 20 Aug 2024 21:02:26 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
>> to explicitly state device child node access, and simplify the child
>> node handling as it is not required outside the loop.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Applied, but I would ideally still like one of the xilinx folk
> others familiar with this driver to take a look.  It'll be a
> few days before this ends up in next anyway as I need to rebase
> after Greg (hopefully) takes the pull request from last week.

I just get back from vacation.

> 
> It would be lovely to get rid of the direct fwnode usage
> in here but I'm not 100% sure if there is a path that will land
> on a disabled fwnode.

Conall: Please take a look at this and test it.

Thanks,
Michal



Return-Path: <linux-iio+bounces-23927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8AB5112B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6424E085A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A830F7FB;
	Wed, 10 Sep 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pWBUdPgE"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66330BBA6;
	Wed, 10 Sep 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492781; cv=fail; b=antanTuQQ1z6inkztOPkytlwG18PfNpWyuBvWUkEEgZMv+SZKEgnoUh2GscH1sdtPNouA2xveDe/wQdJN9C8vgdLB/wAAuYud27PY2jI04XfiLZquQoPXToly+YosdNVSPAY5dQ0fK9zzYzaiT/QQ9UFbeaPILrJkWGn2bqn8+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492781; c=relaxed/simple;
	bh=lg/VRVLhyzM3Z6bqwEEzt2Fod/wkgubsa0c5DvD2fTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFq13BxJdikzB9G5c3tPs9/S29HmXsnbyIzoIkIJhjybajLMMdscav/47YdS984FlRNKivHteUJMGEGbFBZuC0neNIipvj1kqLtZHyO8dSY2yzai+pG2tQxb9Yt67y0bgf5tvNQ4zURrFo+CqKQPAWWh2jJy3Imv+NEAAddV7Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pWBUdPgE; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwLyxpUW9pq+lPG0Gg4T8OMJ5UoMVMViq2p+kLuQGBCj7DR9WRiD968pINAlnEf3nuh5KV7d9n/czBuZwnNSq2Lp2S/FU5MY7eVL1twBFSFxJu0d6/v8I4qqqcaLElOws3GtC0C2h5JBNIvYTpskI6SNCvCfThGkIhKGVngvdWyuZeaFwtn/KaZt0DLS0JTgZjve934e8ckxDMIMu07EIfPe66veYSw2emlLdNw2rJbg42pmiKwtNAj1Z7Mi5gOaxV/PS67n4QqOTH334TJkPb/MXonBC430mMQii81nAZzWRhdsmBV271y8cpNO+tHSwTbYcJ+Kll/P0EBclcW2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMnaDz4cN+dgp85ylRaUNypw10qwQyBJGmh/UyGO+C0=;
 b=pyy3Un0yJOjPhfCRlMkGSpEOCK4cIWW+w/0PnJMn0Ft9dKjigdBBtQ5OnIlQ4P5o3tRirqLJPuMEuGoR48Ee0v1WcOlLDKCXU5brWTvO2U6vegxwIMx4dK8VtqZT1uSBAI6BHNtHb13Mkx9B4K32OoNBqUSIUhXF+hUbhr89P6J53kpNbC+At5MkhAjlYHQOBPzLRp8j5LJiaBmuv14SzHLuf98Rmfs0jNduURiUgn44X7eTpx35PRE5A5+Fyke/uq3WQSfIafsSZ+PrcN4GvT3iYnGjHAuXjOW6uisy7A71R0mWkv2SnG1glAN0iKRvWYa7uQqf1RFRfQ1QQSJMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMnaDz4cN+dgp85ylRaUNypw10qwQyBJGmh/UyGO+C0=;
 b=pWBUdPgEqaxiAwpYhdtAeRHhIZ3wtVVto/bIcoMUYFP3REJ7FhKJsxwwYw7R3HqCck5mcTGMHSBuXeTV+gsxkE0EZhH4ikKlgDrxC+AWRmkLM0t3P9og+FDnRz2LZcoN5rjWFCJrC5AVqYc7FX5FgIUT1Sai5w48DBGy83nvhaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:26:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 08:26:16 +0000
Message-ID: <f4c1f3af-c73f-423c-8404-3d0d4bb95d98@amd.com>
Date: Wed, 10 Sep 2025 10:26:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iio: versal-sysmon: add driver for Versal Sysmon
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Salih Erim <salih.erim@amd.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <cover.1757061697.git.michal.simek@amd.com>
 <2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
 <CAHp75Vc1hkf8jgP76+oHgKU_hFn2STPbgO550ZP2Z39KaCFb7A@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAHp75Vc1hkf8jgP76+oHgKU_hFn2STPbgO550ZP2Z39KaCFb7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: b662df22-d00c-4262-aeef-08ddf043b5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZ4RFVxaEJKeHowMUxJUi9VbFF1RmNTelljMEllbmN6aTNiVlVrLzYxaHNB?=
 =?utf-8?B?aDNqdk1PWnZtRE04S1lEQ3VqUVBSVFlFR2YwdVZwcUZwRkVJcDV0Z0tnUlV1?=
 =?utf-8?B?cUtqd0pUaHVQWFU0UVE2S0F5Ny85VC9oUTJsYnBsWFVtaFlkV29EcThMcVor?=
 =?utf-8?B?bmtwMUlmK3I5VER0bEgxNExQc3RyUnN4WWlNR0lsUVlZNWp0Nzl3T1VUYkVB?=
 =?utf-8?B?ck9yeFlaQ1AybHFKUFRETkpnNllXU3JTNWhrOUFqajFuV05QT1BPeVB6Z3l3?=
 =?utf-8?B?eW1PZFNlMHBERlFKaHU1OHNSMlBxWXV4UHUwRnhGS1p5VEJ0c1RqMEY2eTZD?=
 =?utf-8?B?RWlmSXBqVjU4bmxBUGxrZTlEdksyWjU0S1dZZnlYa2ZqTDVpb1k0WDVPQjVm?=
 =?utf-8?B?cXY4RXFwMGtNR1h3UmVISzduNjFoemdMTmIyMDhGSThIZmJUS3BPd2RyK0Mw?=
 =?utf-8?B?ZldLMFJVWXkyWXRaZ2JXUnVMY284M3JvZFZmRHI2UkFoNEdhdWp5c1ZEM0xC?=
 =?utf-8?B?bldxRFgvWEw3RWtEa2pTUnN3QktGN3FndHB4M0hkMURMZlJSWjdESkVVSEhw?=
 =?utf-8?B?SHVyOVMvT3VIUjJNdk96bnRCZnloQno0NjZGVjFVaUpDQ01hb1AzMGEyNk9F?=
 =?utf-8?B?ZEs2enF0dndPcXBjODNodFZTVmJVRG45RzRscEh6cm0xKzhCTWlXUHJBb2ps?=
 =?utf-8?B?K2tvVWYrWXBPR1Fqa1JDUS9DNkkvS3N3Lzd6WHpodW1uakUrMFVqZHhGZmNW?=
 =?utf-8?B?aVc5OTlmUWxNb0NhOVZlQUVienJldUd5L09VazFQUDZTSWxrVW9HTGN3UEd4?=
 =?utf-8?B?Z3kzY2h0bzlmMGJFdFhWZHZRYzB0YWJRNmpUc3pEdlR6WC9VamhWOWZmSE0x?=
 =?utf-8?B?ajJLSXVGU1k5YUtZaUhRQlJUNEFmQldKRDZhZkduTVI0empablFIZHhKcXlY?=
 =?utf-8?B?NzlUUzV0NXNRcW9sRFBjdDdYMERlVGpSc1pWcmRRbVZGaXBxOTZhMDhNeG5E?=
 =?utf-8?B?eXJmYjhydi9YVkZaSkNXbmtPRnlEcEVUOG4zQ2xEMVVTK1Z0S2M3OXp5VGRG?=
 =?utf-8?B?SHEycXlRUFJFcGt3dFc1WVhJVm1kUVArZHpJZENkMGVFQkZlclphdTYvUEV2?=
 =?utf-8?B?VjFWQlF1eUpTUVhBOFZjKzdENzE5VGxPbmdtbkdvT3d5UFlHbkFHNzdSc2xo?=
 =?utf-8?B?aktjTzN3MG1wY21xWEU1ODVhckpsM2JXYXZhS2VCdkprYjhxdGx1cUNCS1Yw?=
 =?utf-8?B?eEJzSWs3aDBnbjJVd1gvYnhRc3R2Z0ZidjIraHFrOUF2dFYxVXU1TkMzall1?=
 =?utf-8?B?NllxeGhMdkNqVUl6TEVKL2h3OUJZLzBkelhXMFkzaU1TVEpOTWp3S0Z6N2xY?=
 =?utf-8?B?Zkh5elFSR2NXL0RjcTdBVnoxZDJYOHc3NEZZTzJBOFBmZXBCeVgrZkk0amtv?=
 =?utf-8?B?UHFNMHhhWVlrMlFrVzdPNXl0SW5SMVhuK1lORm45NjFvaFVQbHlDR1J4ZXRC?=
 =?utf-8?B?eHhNWUlnOWlBWWtMcmYwdmtDY3JrZDNXOFFURUFOdkx2clk1Y0dWQlFDNXVp?=
 =?utf-8?B?c2YrcCtYMEYwTWZTWkJZTUJkbGhmQm1ZQ3M3b293Tjk0RURjbGkyYnJkSnJU?=
 =?utf-8?B?cDBwTlY0cDlBMkhVRXMrdXVLOWZOUTdzMERGdU95U2t4VmRFczJ3Y3ZTcHhQ?=
 =?utf-8?B?c0NHTFZJK1IzK200alZiNEVUQkNPM2JYQ1g2UVp1dHhzb1ZML1dDVXp5eFZH?=
 =?utf-8?B?OExUWDQ2TWxXakdnSHpoZlJJZFljVFcvUGFNZk5sSE9lcnVBVFl2eVNqUXRw?=
 =?utf-8?B?RWt5Si9vd2xMOGorNFBiVnJPU0NLQlFOVDNNLzYwd2xTK3BTYjZYaWY1ZFk0?=
 =?utf-8?B?bFozYXFJTTAvZ29Cdzd6RzB6bHd4dlR3cWx2dmlySWxBekpqbXc3b1FDU1Z6?=
 =?utf-8?Q?r2PpxtRDDa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGp4eXlaQnBIL3NOQWpwZnFod29xWHZWSFRodWJ6Y1l2Y3VjM3QwMUUvL0tV?=
 =?utf-8?B?TEpkU0t2NitRbG40V3BPd0Z6N0NlRS9RbVNQcFdwenVPQ3JzaXpXazNtSXBG?=
 =?utf-8?B?aURtMlh5S3ZaMkp3MWo3QU1NMkFra3BUSVBXQ3RLdGRxdzdIK01UYTdzYXc3?=
 =?utf-8?B?S1RFc1JpaWRERmFTMmZja0JlK3I0LzAzRldqTXVSamZDT2Q1dUhrNndRN1lu?=
 =?utf-8?B?eUZoNTFuZFpqUkwrM2VHTUcxWlhjNnhGZHc5Y2hJWWRLdnpLQXJCQ2ZlV0RH?=
 =?utf-8?B?N3hWWVpLaVpRMDV3Q0Vudk9VbXI5N0d3OEdXZEZSampwNGNpMzZCSzZabzJK?=
 =?utf-8?B?Z3FPWjJua3JpQzlONDE3M1BXWk9LUEJKNlhRUFk1b0VJTms4YkxxUjQxTVJX?=
 =?utf-8?B?WExrMDZVdVczd2g2bkJHem9yZTc3bmkwUjJoRnJOY0lEZXlXN2xKZTgxZklu?=
 =?utf-8?B?ZGhaSWJ5Z3hHbFhnb2taNzZzdjFLM0JlVmszNGQ3ZkR5SmVXZkZZc1o5RXJ4?=
 =?utf-8?B?Y2hSWEhrdFJuMmtXRzgrMWU1MGtPQkE3S25QcHBBZTNsOGxsK0JZVzhuNFo0?=
 =?utf-8?B?Vnh3MWxseThQRk02QkhsRFNxQVZybVdXZmpBNFB4ZnVZZm9DOUg3R0p0ZEZ4?=
 =?utf-8?B?bGl3TzlUekJZWmNMSDcrUzdsTzlYYS82RjFBVzdhbGNWVERER0RKbFoxZWlk?=
 =?utf-8?B?Y3ViSUdsV0dEVWpmMGgxU1ZOaWpteW00R29NU015S2k1Q0drY2VLd1ZUQjRp?=
 =?utf-8?B?NEJFMkQ5SDRVeTlsT0NNakhTbU5SVzZ0ZUt0cHMrY01kZC83Mmw3bWtmcFRB?=
 =?utf-8?B?MzhmdjloTzhzaU4zanMwNGk3Tmwxb3JOOGRBRlpjRnlPUzJuZlgyMUZuQkxV?=
 =?utf-8?B?QzdxSWdTT25zQjdrckVKRkFWNVBrRnFDMWZ6MVZYRmkwRVRTRlZFR1crT2ho?=
 =?utf-8?B?QytpRkNMaXZiaWtNb3JNQit3bFBRL09HN3FBL0pOTXZ2NmhjdDg3Qkhsdm5E?=
 =?utf-8?B?U0NoM0JOdS9HUkJYVU1uTk1Va0ZVT3hMbEVLWG1zcHhTVTBnNlVlTFZxK3M0?=
 =?utf-8?B?V3BtR3IrSlp5aFhGbytOSFJDT1RienE4WVNrQjVYOEVIaC8wVU1tSnR2TkFt?=
 =?utf-8?B?Umx3WlVNdEpDSUNndlo5L2dCclpUbkJzUDAzMURFbGNQM3NheERlM2xhVVlp?=
 =?utf-8?B?UWVvZVFtbnpFYWJJVytZQnNTSlFaSXFoVS9jK1A5YWZyNWlHL0tDMDVqeHJo?=
 =?utf-8?B?emtLWGk5ZVZ6Ty9RZFVwN0RRTVJFUGo0TmVpNWREMEFCVHc1OEg2RVMzNitk?=
 =?utf-8?B?TmE3OFJRTURGYVl3aUUyZ3ZTN1lJUXB1azBsOTNlOE1tZTB5WHdNQndtaEY4?=
 =?utf-8?B?empROTNPaVFQZTV3NmRJTjNWZTJ3MkhnOVRtZUw5Y2VKZnBEUk5IVDBPWkUx?=
 =?utf-8?B?ZVJIYzBUZW5IUy9JNU5ldVl4THVRV05HTG90UlQ4dEhjT2Q4QWhsZlhNZm5a?=
 =?utf-8?B?anM3QjJ0TUxEUUFTUSs5N3Z2M01WdHFiNzY3dTN1ZFU1RlBFY1VNdkVLWGly?=
 =?utf-8?B?Vk1JbUxXdGR3Yjdualk4TytDT2RPTEVIMGpqajY1aTY4RVIwRytVWlVJcS9i?=
 =?utf-8?B?VTZSaTJxY2NWTVE3cU5rQmtjMThGbk1iVGR0aDdBZEI0ZEZFaTB3VlFYTkVU?=
 =?utf-8?B?UjA0bnNNbFQ5UUZicHVqc1pHeFh2VFBSUDFMN0tNcVBReEdrZ05JOEpnYlhE?=
 =?utf-8?B?TU0zVU01L0hGQmVQY004Z3JiaTZ6eGZDNDRNN1RCclJtR0J6NTZiSXRyMDlz?=
 =?utf-8?B?RjBvM0dCUU4yUmxGYUhlNmpWeWhlUk9jNC9rSTRwWUI4OG56eG10OGFmMWtY?=
 =?utf-8?B?aFc1UkdTUWNqZEZ1b2g2ZnRYeWN0bVlZZjZ3R0FCeThrQjFxc0JqdkpsNFo1?=
 =?utf-8?B?d3NPb1FKUHAvYlF0VDlmeEF0OUNlZnBWb09rM2F1WjB2S1AvNWlHQm5Mdi9R?=
 =?utf-8?B?NHlQOS9xbEJtdjhNZ0JocjNwdUlBMGNQUktPM3V4R1doU2dqR052b1NEcXQr?=
 =?utf-8?B?NFBKVitTMmZORWxXZURva1hxeWpEV1BZT1ZsMzNyaTZFbDM5VGhuMHgwemRi?=
 =?utf-8?Q?e9F9K9nHRYpFTGTdHyVJanHXT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b662df22-d00c-4262-aeef-08ddf043b5e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:26:16.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygnRMaraROXwp+qtsh340LY5eQfNJeDQqUrjn7COmOc0NXVmWyK/sW1N8Tqeaar1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

Hi Andy,

On 9/9/25 12:33, Andy Shevchenko wrote:
> On Fri, Sep 5, 2025 at 11:42 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>> Sysmon Driver uses Linux IIO framework, which was used to abstract the
>> supply voltages and temperatures across the chip as Voltage and Temperature
>> Channels in the framework. Since there are only 160 supply voltage
>> registers and 184 measurement points, there is no constant mapping of
>> supply voltage registers and the measurement points. User has to select
>> the voltages to monitor in design tool. Depending on the selection, a
> 
> in the design
> 
>> voltage supply gets mapped to one of the supply registers. So, this mapping
>> information is provided to the driver via a device tree. Depending on the
>> number of supplies enabled in the design, the device tree will contain the
>> information of name of the supply enabled and the supply register it maps
>> to.
> 
> ...
> 
>> +config VERSAL_SYSMON
>> +       tristate "Xilinx Sysmon driver for Versal"
>> +       depends on HAS_IOMEM
>> +       select VERSAL_SYSMON_CORE
>> +       help
>> +         Say yes here to have support for the Xilinx Sysmon.
>> +         The driver will enable users to monitor temperature and voltage on the
>> +         Xilinx Versal platform.
>> +
>> +         The driver can also be build as a module. If so, the module will be called
> 
> built
> 
>> +         versal-sysmon.
> 
> ...
> 
>> +#include <linux/bits.h>
> 
> Quite a few headers are absent...
> 
> + export.h
> + types.h
> 
>> +#include "versal-sysmon.h"
> 
> ...
> 
>> +static u32 sysmon_temp_offset(int address)
>> +{
>> +       switch (address) {
>> +       case TEMP_MAX:
>> +               return SYSMON_TEMP_MAX;
>> +       case TEMP_MIN:
>> +               return SYSMON_TEMP_MIN;
>> +       case TEMP_MAX_MAX:
>> +               return SYSMON_TEMP_MAX_MAX;
>> +       case TEMP_MIN_MIN:
>> +               return SYSMON_TEMP_MIN_MIN;
>> +       case TEMP_HBM:
>> +               return SYSMON_TEMP_HBM;
>> +       default:
>> +               return -EINVAL;
>> +       }
> 
>> +       return -EINVAL;
> 
> Here and in many more, eliminate dead code.
> 
>> +}
> 
> ...
> 
>> +static u32 sysmon_supply_thresh_offset(int address,
>> +                                      enum iio_event_direction dir)
>> +{
>> +       if (dir == IIO_EV_DIR_RISING)
>> +               return (address * 4) + SYSMON_SUPPLY_TH_UP;
> 
>> +       else if (dir == IIO_EV_DIR_FALLING)
>> +               return (address * 4) + SYSMON_SUPPLY_TH_LOW;
> 
> Redundant 'else'.
> 
>> +       return -EINVAL;
>> +}
> 
> ...
> 
>> +static void sysmon_hbm_to_millicelsius(int raw_data, int *val, int *val2)
>> +{
>> +       *val = ((raw_data >> SYSMON_HBM_TEMP_SHIFT) & SYSMON_HBM_TEMP_MASK) *
>> +               SYSMON_MILLI_SCALE;
> 
> Can the whole driver be switched to FIELD_PREP()/FIELD_GET()/FIELD_MODIFY()?
> 
>> +       *val2 = 0;
>> +}
> 
> ...
> 
>> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val, int val2)
>> +{
> 
>> +       (void)val2;
> 
> Unneeded.
> 
>> +       *raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / SYSMON_MILLI_SCALE;
>> +}
> 
> ...
> 
>> +static void sysmon_supply_processedtoraw(int val, int val2, u32 reg_val,
>> +                                        u32 *raw_data)
>> +{
>> +       int exponent = (reg_val & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIFT;
>> +       int format = (reg_val & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;
>> +       int scale = 1 << (16 - exponent);
>> +       int tmp;
>> +
>> +       tmp = (val * scale) / SYSMON_MILLI_SCALE;
>> +
>> +       /* Set out of bound values to saturation levels */
>> +       if (format) {
>> +               if (tmp > SYSMON_UPPER_SATURATION_SIGNED)
>> +                       tmp = 0x7fff;
>> +               else if (tmp < SYSMON_LOWER_SATURATION_SIGNED)
>> +                       tmp = 0x8000;
> 
> This looks like s16 limits, can you use them?
> 
>> +       } else {
>> +               if (tmp > SYSMON_UPPER_SATURATION)
>> +                       tmp = 0xffff;
>> +               else if (tmp < SYSMON_LOWER_SATURATION)
>> +                       tmp = 0x0000;
> 
> u16 respectively.
> 
>> +       }
>> +
>> +       *raw_data = tmp & 0xffff;
>> +}
> 
> 
>> +       u32 ret = -EINVAL;
> 
>> +       mutex_lock(&sysmon->mutex);
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               switch (chan->type) {
>> +               case IIO_TEMP:
>> +                       offset = sysmon_temp_offset(chan->address);
>> +                       *val = sysmon->temp_read(sysmon, offset);
>> +                       *val2 = 0;
>> +                       ret = IIO_VAL_INT;
>> +                       break;
>> +
>> +               case IIO_VOLTAGE:
>> +                       offset = sysmon_supply_offset(chan->address);
>> +                       sysmon_read_reg(sysmon, offset, &regval);
>> +                       *val = (int)regval;
>> +                       *val2 = 0;
>> +                       ret = IIO_VAL_INT;
>> +                       break;
>> +
>> +               default:
>> +                       break;
>> +               }> +
>> +       spin_unlock_irqrestore(&sysmon->lock, flags);
>> +       mutex_unlock(&sysmon->mutex);
>> +
>> +       return 0;
>> +}
> 
> ...
> 
>> +#include <linux/bits.h>
> 
> + io.h
> 
>> +#include <linux/moduleparam.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +#include "versal-sysmon.h"
>> +
>> +static LIST_HEAD(sysmon_list_head);
> 
> list.h?
> 
>> +static struct iio_map sysmon_therm_static_maps[] = {
>> +       IIO_MAP("temp", "versal-thermal", "sysmon-temp-channel"),
> 
> Where are the IIO_MAP() and struct iio_map defined?
> 
>> +       {}
>> +};
>> +
>> +static inline int sysmon_direct_read_reg(struct sysmon *sysmon, u32 offset, u32 *data)
> 
> + types.h for uXX.
> 
>> +{
>> +       *data = readl(sysmon->base + offset);
>> +
>> +       return 0;
>> +}
> 
> ...
> 
>> +       mutex_init(&sysmon->mutex);
> 
> devm?
> 
> ...
> 
>> +       indio_dev->dev.parent = &pdev->dev;
>> +       indio_dev->dev.of_node = pdev->dev.of_node;
> 
> Drop these, IIO core does the same and even better.
> 
> ...
> 
>> +       mutex_lock(&sysmon->mutex);
> 
> scoped_guard() from cleanup.h
> 
>> +       if (list_empty(&sysmon_list_head)) {
>> +               sysmon->master_slr = true;
> 
> No need, just make a sane default and !exist will work in the other
> branch the same way. I believe it's
> 
>    bool exist = false;
> 
>> +       } else {
>> +               list_for_each_entry(temp_sysmon, &sysmon_list_head, list) {
>> +                       if (temp_sysmon->master_slr)
>> +                               exist = true;
> 
> Why to continue?
> 
>> +               }
>> +               sysmon->master_slr = !exist;
>> +       }
>> +
>> +       mutex_unlock(&sysmon->mutex);
> 
> ...
> 
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/driver.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/adc/versal-sysmon-events.h>
>> +#include <linux/iopoll.h>
> 
>> +#include <linux/kernel.h>
> 
> Mustn't be used in new drivers.
> 
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_address.h>
> 
> Huh?! Please, make sure you are following IWYU principle, please
> *drop* all of the headers that are *not* being used (by this header),
> there are a LOT of them to be dropped.
> 
> ...
> 
>> +/* Channel IDs for Temp Channels */
>> +/* TEMP_MAX gives the current temperature for Production
>> + * silicon.
>> + * TEMP_MAX gives the current maximum temperature for ES1
>> + * silicon.
>> + */
>> +#define TEMP_MAX       160
> 
> Here and everywhere else, bad namings.
> 
> ...
> 
> This is an unfinished review due to the following reasons (from more
> important to less):
> - AMD is not the first day contributor, the code is awful, it missed a
> lot of reviews and updates regarding the last several years of the
> kernel development (IIO subsystem in particular). Please, avoid
> letting reviewers do *your* job.

Sorry about this. Firstly we need to find a way to have DT binding correct which 
affect code too.


> - The patches are too long to review, it would be nicer to make them
> feature-by-feature, where each one is < 1000 LoCs.

We will look at doing one more split. It is 2k LOC now. There is actually also 
i2c part of this which is not included.

> - I started this a few days ago, but I'm busy at the moment, that's
> another reason.

Thanks for your review so far.

Thanks,
Michal



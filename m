Return-Path: <linux-iio+bounces-27486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25131CF3448
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 12:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAC731076F4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB63633B6CC;
	Mon,  5 Jan 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="d2ZN4rTu"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022109.outbound.protection.outlook.com [52.101.66.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C533AD82;
	Mon,  5 Jan 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611249; cv=fail; b=n7JXOFWgcbKndxzATFMwGAz213zmAvcVgKI+ESoetaCfUzU0088VfJ566TgcEY+TMXI0vaVLTOjDW1HzA23JJkPwHhcXW3EHqstrYphjtxAdltj5P9okXpOmeDiiF3Y8+fPJ9u0xEX9Ejdb9KyNKShBHhUpFBeMNr+1Gey/y5TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611249; c=relaxed/simple;
	bh=PCivtR9hxqt1cJNwFsmYTu/pmxsUh4m41mwmyKl/6Y4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i7NUwt26jOreXJa+CeUYek5jHG2bXBpg4s33P/Iay/RQoKodRqMjHGspFFNYa8WPU9eXkB8Q5AxQ3zHkIfShjN26z4FV7OdM077uComkxyE8prP652LoWVpFsW1wirLhvRCcZwm0W2Exsptux5Vam79rjDtCMhkGxp+h7IpCw9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=d2ZN4rTu; arc=fail smtp.client-ip=52.101.66.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCvIVWoAunccuK7x3CctfLpS0Gr8ZHjElXzE62T8I+JlxYR1SlsKKXN5nU37+O0w1ASZRL6gLs+SYCFP4PmHRc66ebqLDQTiyyMNr1VBY+6YnePWgldBux0oFbPTOamOI4nSAUgcMJoWLLfQjEnJE9RGJbZbkTTHCQutO+eggbhWN2nrK4a3HzPzjPAwTU2++uMwcAV1nnXKaOxtLzD3Y06HaX4LdLfBS3S8OY1GwHT4T6JFoce4oNdhO7UUAH0FqCyJ/PUDUnBZGR25gWYyoN/A/ycxonFJ9LuF28JN7LdHJ8ikLiIgIEl4NZQmjDXjM6Y9gyPQ5PNNxUjj6SxPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oKRxDyBw44b+EUc64Y/j0hICia9sDAdHsiKzjiZgWk=;
 b=AfYxUEj1dtt7cF9K2a4PBiTb/vZ8rJXVCRAYJ+gG7cCujWdaG8gA3l1lSVE8/EBuBpN6a3I+1t+V0oqK05afYQ+a6SgFS9j6IBm2bSkhxV8BZMpTLbY296H0ih8x6MscHaYXSrQItYQTXKubQbxOGpGQas9vwQkkA2/11ntCiFT/kccj64+/4Bies/wjVSoEDFf4hIOXOq+l0kxMMaLeegNjA+1NNSCdU3sWfYqN03IdWWOWyJRoUc2FNvMPddwztaQaAGUZVyF9jTSFpo9lc7i5dpaZdwN/W2tiBvQiL7M2Sfe2xMQ/FjFK6U7pawo4ULOEmWTzPbpXYf8K/YYKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oKRxDyBw44b+EUc64Y/j0hICia9sDAdHsiKzjiZgWk=;
 b=d2ZN4rTu5qhYjCudL0ASvZADxcX7t2eE+k6Ftj7jsTfcgdR9GQ5qnKfszXXb3vbf+Ptkl1Ex4kgw954DgZGzzm5uoEYiuZicJSzcXeoIcArggEZ+xvYU7BtnjW0p32F6kX7hniDuW3//hHwaGbDQDnHK1tqdZgzlBQ611ZfvHXnhCbUA/Dsl64djIcG90rNcoN3g29GSt6d4imwqRzeN+ZL1mYlaDkk9i+KqGLZ4kOlsRZxhQilQ09Y0wQ8ew/ss+/53L1e5LgI1K9HNOGSAAWaC7DbB2/zPmn1oOCIgduhyTxsvwCvIe4xXduJBs14DTfnazWPVn9aIvOlGwRlaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8726.eurprd06.prod.outlook.com (2603:10a6:20b:654::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:07:21 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:07:21 +0000
Message-ID: <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
Date: Mon, 5 Jan 2026 13:06:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <20251221200014.29af7df8@jic23-huawei>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20251221200014.29af7df8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e0c2d-cc1e-4d69-d616-08de4c4a98e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N01JY0MxWlFhWVV2bU9QWmVoeU54M0FuQXFKcEkwZGlTR2VYMXRYOERRd2E4?=
 =?utf-8?B?S2s0NGk0VVdOMktIYVorRlRYRmlISHk3dS9oWjNUK2ljN1ZyNkNJQ0JoWUpQ?=
 =?utf-8?B?ZUIwNFlYUTJNaWpOMTdtSDQ2WmE1dmhBQXRjSHEyMEZwQ2RXK3dLVE94S0s3?=
 =?utf-8?B?aXBQc2krVWhyenU1MUJDS3N1T0pJUmM5TnM3SEgrbkVBV0pFek9KR0tEWHlS?=
 =?utf-8?B?UForeDRNQmZEcXZGQU1TWVR6WExmTjhGRnlUZm1FMUN3a0NvZEpjN2VubHpZ?=
 =?utf-8?B?eVRIL3JtRVF4WktWZjZIdjdscDNMb3FxZDZoQUlRdGg1OTFDZ0ljb05ZUXVj?=
 =?utf-8?B?eWJZTGRra0NaUlk0Z3dvVnI3dCsyVUE5OG1ySmZVWFJEL3ZITzZNM3dqcEZG?=
 =?utf-8?B?RVQ5QytScCtKNWtqTnFvQnZYWWhFZG5yWjgvUFRlaGFLQ280emQ4OS9ZcXJX?=
 =?utf-8?B?aGVoYmZYQVpia2trdXRwQW5DTkVhanFKL2NKS21udExGMHZuL3gwYjRUdG02?=
 =?utf-8?B?bFFNQUd6U2ZBc0RQVG5paW9ZMkJwRkhjVUR4aGlLcmkyYVNHd0tKa25kRDJt?=
 =?utf-8?B?KzRzaVFWWWdLMTcxYWNnNjN5SXJzakFEZ2EwRXhXK0EwZ1dBV21WcjhBempU?=
 =?utf-8?B?SVB6RWlCazd2YkNBNXF2eWNib1BHQ3J0Rk1ZNXIrR1cyS2RMV0RkMVVYZ2I1?=
 =?utf-8?B?UmNBTjBLNEt0RU5zMEloWWtMaTI3ZkRlR1lCK2VYZkVrc2g5OU9GZTBFak9u?=
 =?utf-8?B?ZnpaRE1NQU5ndEU4QWNUMU1wd20wM0ttdlJWc2MwelpMQzRhY2N1TStaU0xQ?=
 =?utf-8?B?NDhoQjdEK2FvMXFyaUMwc3VVa0pDWUJpY0NMVjZQMVlEckNMcUUwc0d1Vms4?=
 =?utf-8?B?RWN3ck8rWVF5dkVTVHhzWDNHZ2c0QUxUVndkMmFndjEydWJPNXpmK3pHdmRX?=
 =?utf-8?B?OGI1Z2kzeVA3YnF6Y3pKYjF5OTNhbVpJRmRhZXFZVUkycHIyZjRqMmdLK1NS?=
 =?utf-8?B?cGZzUDJvKzAzYTkvWjFURnFCcHl2dWo2cmluSFZiSnZZeTB1Q0k5WnN1R21t?=
 =?utf-8?B?SU5QN0JuZ0tGaVg1Y1liejQwTFBFTkdMc0ROMEgvMU9IYm5zMFZ5ZmMyeU5T?=
 =?utf-8?B?U25JU1F3b0RxVWg5WHlRdlc2dUh6SHo2U2xlVmNGcG55T09LQmJrM3JDMStU?=
 =?utf-8?B?RnJ2RUdIZEZ2VkplbzZBcmcrZVRORlFPbzNiSDA1ZHY3ZDlxYzdmQzN1cG1G?=
 =?utf-8?B?VmlQUDFiWE5kdzR5Mi8zcmRCVi92VHJHY0JJbHFvRFIzbEt0RXorY2tZVloz?=
 =?utf-8?B?ZVNlNmdNVXVHVmFsbDQ3R0hqUlVWMHp0NzI2WTVwc3UxS1IyejNsTUtQL0JM?=
 =?utf-8?B?U1lIUXpoQXg1ODdqV3ZFLzQ2WWpJbTd4MXpKT0RYQjFlNlhSVFpoU3VKOTlG?=
 =?utf-8?B?b1B5cjArbXlMR2tHMEFKUFM2REZPQkMwR2o4L1ZCRVJIQmNXSnU0NmJCaVlw?=
 =?utf-8?B?bVQzZVZ1SWgwQStEYVMxM1RPakc2OElyQmdUbUM5Q1F6UlRBQllCOWVrU1ZY?=
 =?utf-8?B?TFN1YmQyRUF4cElENXRqWE9iZWkzV2N2cFhtUkh3Ky82ZUkvOTRvOWFrR3NH?=
 =?utf-8?B?K2ZscFQ4eERJL285eVFUM29rd08wTVFMbFQzNFhCd1RrNFFaTEFqcUFEWFVJ?=
 =?utf-8?B?Mmt6cnFGTmNpQ3l4clRrano4TXpaUzZzWWhHM2phS2w0UFFkb0dGVEIzNHVx?=
 =?utf-8?B?RHNMZXhLNVczcFNJVERPQ0J3WGIzeVd0cmpVSDVJQzdTd1VhbFVHb0pVYkFn?=
 =?utf-8?B?b01USW5CazVRT2RYcmlIK29mdXFxMnVsRWZNVWtnRmxGeW0rdXF5eGlLQ1py?=
 =?utf-8?B?Tk5zRUhXR054R0dwalMva2cxTTVjVWE2eXNSK3hKelBUdnkrL3ZraUZMRGkw?=
 =?utf-8?Q?mUEXnmtd27V0TJtbkKd6DkA4MvwAgEZS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9hQWt5dnlNZjRlOWM4TGVoQmg2N3ZwOFZJOTg2dTFQbnNYVnMvYmxFdFQx?=
 =?utf-8?B?TjhhTUVCTHFxTDJRZ3IyWnlwWG5iRG5ZV0h2UmxVZWQxd1hZdDBVY0dWVjZx?=
 =?utf-8?B?YXM2RktKbjgwSXFWTEFZUXJ1eUdJNUNnTkFLSnVteWtDaUpVanNLUE5yb3BW?=
 =?utf-8?B?U1VHZGZEQi9qZU4xdmFsYTVyUlY3cUcwdXBIa2hiQzQvcG9ZQ2QrcWFJUnR4?=
 =?utf-8?B?M1haYmhWNHJYTjU5cXlYSC85bk4yMmJxdlBHMktHVDZKVW45bkl1ZzYrQ3ZZ?=
 =?utf-8?B?R01qeHZhUVdHVzN0UWoyTXR4MWVPVGtrdEc4TEtLMEU0UFMrQ1Bpcmw2MlVP?=
 =?utf-8?B?UnNuVmUzM0EwdUVnL1NrNmd1QUtrVVFHQzg1SXFOYmpJazB4eXI4S3FiUzk2?=
 =?utf-8?B?b2RSQys5SllnWUYybWV3Mnk1REY5b3c3cDVnL01EODdQZ1Z6OVMza0ZGMkJi?=
 =?utf-8?B?U0Vic29SRmNwR0xoY0pldEhVZWVnbThObThGQjFvb0hOQm1QSmpHM0FIbExR?=
 =?utf-8?B?M200WTZnRStPcEo2d3h3aSt5U2psbjd5WituTytUck9ySjFnTDU0eEwxY0ZI?=
 =?utf-8?B?OFp4QXg3UXdoTmltWDQzNzh0MVVXdklXNXZ5bU9qSGwvOTg5aVhqbGdITGw5?=
 =?utf-8?B?Mks4Tlh5TkRnbWNyc3YrTXNNZHRsdm1ZQU5USW9iTU1SMG9VZEgyanZmUmdN?=
 =?utf-8?B?N1lwNTVic1lsbituVEU1VFZlcm1kOXd5U3hYb3M4bmI4aFhkWU9WSmZDUEJK?=
 =?utf-8?B?ZEdrcFJYdzVzZTErTE80RUllYmszVy9FVU9UcmpJdXJ4VVoyU0VpSXFpODBU?=
 =?utf-8?B?NmUzcVhaZlBNVU5iZmJpY0ZSdU9YSG1xb1dJV0Y4ZERHcFlaVm1WbmpWbzN3?=
 =?utf-8?B?VnBhLzRNS3JGKytSTU00aDdsMU1MV1ROd2hpOFQ0TDBRbXhSU3UrQzNpTlpO?=
 =?utf-8?B?bCswSVpxRkloV21KT05BS3RsZVZXWkdUdFJ5ZXk4cWlsR2dmb2QvRHp4ZHB4?=
 =?utf-8?B?azVVYksvU2VCRkRCdDVMZ0pobE1aam5sWiszMmNPSThiOHBGdDRXQ2VoZkxW?=
 =?utf-8?B?RmxwaHlWODZiZ0tnS2xaeGVLUmgrNnpmY2ZRcVcrVkFUZm5lUk5WNEpvZU5E?=
 =?utf-8?B?S1JFbkkwUFgrNHRWaHAzSzVBM1RVUUNjaU9YN3FTa08xQnl4c2N2L3FjUE93?=
 =?utf-8?B?MkdUeHlSRndGRzd1MmJzQ0JHSUtkTmt4YlN2MHA0T3AwVEl3S0R4WGNYQzBt?=
 =?utf-8?B?ZWlmMXh6UmFPbVNFY2hyNkpwWjZFcXFIVzBHR3l2OERwdm1tdVBORDFOY2pZ?=
 =?utf-8?B?enZPV25LcHJ1SFI3U0NsYUJwQ2djdkZvSnNjb04zTUFURWJ2VFMzR1U5RDMy?=
 =?utf-8?B?YVBMQk9XZTU4U0Nwa0J5VUw4K0RRaXErV3NYZnVTTERvRnQxVTltejBxMUxD?=
 =?utf-8?B?bWJ5T3lvdVRYbE40SDE2b2tmMFhsRVpXbWNTdzFtWm56SHA2QXRObnh5VHI0?=
 =?utf-8?B?UXVZTHl2Y1NHQVEwU3k0K0tTa3JxdVZBTitZaWxmZzBLN2M3clJKOVYwbmFm?=
 =?utf-8?B?ckVTUzg4d2c3UmxCaFZiOUZobjVoVitOWEV3TEluNjk4Y3gxSHNGbTdOb0gy?=
 =?utf-8?B?dkN6djFyek9qZGZXTzdaeERyYmgyYUtPTTd2cjhxWFVMZUQ3QWxRY1RPTzh0?=
 =?utf-8?B?eHZEaXZyOVEvWGpVS0wwRW5MaEFOOEh3OWNqUGNQOE1xWWd4a2pvNE8zQkQ5?=
 =?utf-8?B?TENURUtTVDZ6ckl5ajFBRng1ZlZaUUZ1OTFPSTdQL1JaOGkwRGhOYklsem5W?=
 =?utf-8?B?QXprZDBoSHBIK2IzRFNqWThoRU8wd2lEbzFnTWNIa2VyOXppUnFUR3NFQkVl?=
 =?utf-8?B?T0ZhR2QyNkF0M1A1d2lqZGNRaG1tT1dKa0ZXci9UTDVqSElQM3ZMQjFpT1Q4?=
 =?utf-8?B?SEU3R1psbUo0KzRQUjVURGNBWGpnd0hQVzB0UVY0SVVLOGpoMzNRTlkzMmlm?=
 =?utf-8?B?SG40NUJSSGY4UmQzVlNXSDJnQlM3Y2JBQTcwc2tuZWlLaitWS2hRNUpKVkpu?=
 =?utf-8?B?V1VhVTMxb05ZRmRPMmtxWnhJeTJxcUs0cStCSVFYb1F5WWdYdWZWQTVIMlFt?=
 =?utf-8?B?VmlNTlQzUlJHQ3BNNjRlRGVWT0hROE1MUG1PeHRNODBrYTR1M2c2S0VwTTZK?=
 =?utf-8?B?Y1RHSERVSG1EaHF2RFZkaTlJT0VITit1cWRhUlpjN2tkL2sxVjJhU0NNOTNW?=
 =?utf-8?B?RGQ3eVlPQWVCVFlEVFdjZ0x1WDNQWk9OeWJDZmUvMXpYZXZTTjJUOHZYaEFk?=
 =?utf-8?B?OHMyU3B3cG1kYXNoanNmaFZiejYyMXlFSGt1YUhQbFVVWXBubmZaSVZJL0Zs?=
 =?utf-8?Q?eg+mlLHxrgd/BDRw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e0c2d-cc1e-4d69-d616-08de4c4a98e4
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:07:21.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUisjcBrUDyDfl1YB2hIzBRwWzonoOPTdqP19ye+Q/20UOsXDCsEauL2q3NF9qAZggbpgqpW03d/veMp/MOTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8726

Hi,

On 21/12/2025 22:00, Jonathan Cameron wrote:
> On Tue, 16 Dec 2025 11:40:06 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
> 
>> Not all users can or want to use the device with an iio-backend.
>> For these users, let the driver work in standalone mode, not coupled
>> to the backend or the services it provides.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> Hi Tomas,
> 
>>  static int ad9467_probe(struct spi_device *spi)
>> @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *spi)
>>  	indio_dev->channels = st->info->channels;
>>  	indio_dev->num_channels = st->info->num_channels;
>>  
>> +	/* Using a backend is optional */
> 
> I'll largely defer to Nuno on the backend aspects but I would like a
> lot more than a statement that it is optional in this comment.
> At least something about where the data goes and what a real system
> that didn't provide a backend would look like etc.

Having the backend as optional is about flexibility to incorporate these
devices as fits best with the system. The current backend approach is
pretty much dictated with how the ADI default backend is implemented.
These devices are fully configurable via SPI interface so the backend
doesn't necessarily need to be anything fancy or even configurable.

So there is atleast two use cases that promote the optional iio-backend
approach
 - simple backend that is not configurable, no need for a dedicated
driver. The backend (FPGA) sits and waits for data and handles it when
it arrives
-  custom backend not compatible with the adi backend features. For
example different approach to calibration, or other model for data
channels etc.

Not having it optional would mean more or less vendor lock with analog
devices backend which probably was not the idea when adding the
iio-backend feature in the first place.

Regarding the comment, perhaps something like

/**
 * Backend provided features are optional. If a compatible backend is
 * not present all features might not be available. If the system
 * otherwise provides a path for the data, the device will still be
 * fully functional.
 **/

> 
> I can think of some setups where I'd be fine with this change and others
> where I'd push back harder.

Given the explanations above, I'd be happy to have some more feedback on
this.

Thanks,
Tomas


> 
> Jonathan
> 



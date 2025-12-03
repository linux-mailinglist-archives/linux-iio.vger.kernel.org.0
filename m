Return-Path: <linux-iio+bounces-26659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE82C9DCF2
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 06:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F88D4E0579
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE16F274FC2;
	Wed,  3 Dec 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="BYEZNLCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021102.outbound.protection.outlook.com [40.107.130.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D053207;
	Wed,  3 Dec 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740319; cv=fail; b=n+66XWTT1DsBbdIfNAVHxa9PqkGVzSiCOhc5jbCLRDWDwwDZnOfA9eEMq2lKehbufBXaD4mkYw/9NB7mGCSkn2ox4K5q/W696NhE4KoPR4MufSi/eupu4x6YQJu0awDdrO/wPsT1XwID8enKO6zNEStMGs6KZbL2YGCDlyvA9JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740319; c=relaxed/simple;
	bh=L0pBv+/PwBjB06HLL2Fr/OjCRW9qRZs0sDGDykgfgAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzAvy1Vm+EBpCA8hlsNxEFietqOycRotNdmHjySa3UVs4AwipL91+FP0maplLDzDOjwEpFcoW6hofGVlp9xS7P2Lc12mZXLKMFpR9Ac0+bGtI4Wk2PJAldTieyxNuKloJd9uCwAkPt9kOAlguCOmPi2Bh/sUt74h2y2bbeNCb0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=BYEZNLCI; arc=fail smtp.client-ip=40.107.130.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZp4y/O1pogBzichbS3Ghus5xIUl/9/RpYeYJ/NEqCZXsq371YdLepD7WzqQ1BjS3qDhCK6ccV7avtvky2CP3mX2gH+qgyQ9IBME1bWoVkQ1D+RJWVT7wlhc7Y8OVJi6JRvtPD+uGW4Fh1PToD2O3LyQbX4UDRb6TGfvRwPrjpUi5h/oXq0xOGyuje1nHxcd2GZDzgOivD8ZCAp/7YuvAz5uM7Cn9qlqTHYjvyXFykgL1Ez/9tIXhV9aANvDhwOjHmCuw3dgLEE7ARtemTGUt0W8M64M0uDg4wNC+2UJfWJ0nl4MaNWArxFa5EIfkx/01E7RDQPABZN8FoFTpLZicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG/zLUSPm7vEgry8LR5bJbV06+l8jhVc+p1GjcYnc7k=;
 b=TmruDHn1/62m5Pv2lyLiho9hZQEZn7kfnik9Idwrw7vsT+Yxx4cVdRgbtzrKAgxaIRWCz+ZqIwhvGUA/z05vPcMb9FSHQr/2xviTQgjcvwnUl7MlYkWfCouwpkES0L5kQ1+qy6YxgF3EvfNWw9B4lNYc8JAQzr5DE8Y/f4qFByOmaY5jkkmmyYnHILtbUrBVGbua7sYvfwd+zYjFeN9lhdjWUFWlan3med85re49huk+nQMJs/McFm1L55UA5BsHXYkG9YR1znfH0X6TSjNwjyRQq27ftmj4TsEHXOayu6d/p7N0aB//Mg3jd8zdBRDUJ7QlJdtMzL+EYs7ao9/gMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG/zLUSPm7vEgry8LR5bJbV06+l8jhVc+p1GjcYnc7k=;
 b=BYEZNLCIbhionD1pXb2Q1j0UeA8F1CoCHuLE4GZQ3wbsiPHydJ57WaP64+9jrmiuJziwtJjBA2pgAIEqHRm0eKGMpErBDdTnY+i1b5fVe0KbS3kv28FOclvbOaeE/fbI4FS39xwpNBNBMvyS/Zjwp2v7JHQ1psCJnaxBDMw9dNkTGd/UFAJbByCjmKfm9Vmpbpw/g6zB1CW9hMSIBYAqZ5KQvHafOreVsoKwRN5v504LzIucHfxHiko+V1g3sPEKBWSV0IAXsQVa+N29EeGGtzI4yHnB1i7QVDRDrQHYoOsQsaG1pqsIX4Nj6W4TDOP7sDXvgO8DgLymP5drSNsrEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB6976.eurprd06.prod.outlook.com (2603:10a6:800:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 05:38:30 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 05:38:30 +0000
Message-ID: <d69a8880-4344-4cb5-b4d1-451072954c55@vaisala.com>
Date: Wed, 3 Dec 2025 07:38:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
 <8edcbe15-b3cf-4259-9d07-87c07f1f400e@vaisala.com>
 <a6194f8f0b8506283d2941a869961fd4f284634d.camel@gmail.com>
 <3edc68e2-e46a-4315-b2db-a221fee94b9e@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <3edc68e2-e46a-4315-b2db-a221fee94b9e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF000167EA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::671) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: b95d9074-6d00-4420-81c0-08de322e30b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N251SlZZTjl3YXE0SGZkQytvaGdMY0VwU1FSNGlta0NmenRHUkFlYTAxR0dh?=
 =?utf-8?B?QUdMKy83TDMzQjhSVER1YkVqRVlkU3RqM041U3lYVlVTMWU0SzUxYjZFSDYv?=
 =?utf-8?B?OHVGLzF0UjlkQzIrRlFTeWVSdmxQZ2ZRbW1MdEUyd1hIL0RzdXBhbW5IK2d1?=
 =?utf-8?B?Uk5IYUp5WkZ4eFg1ejJUaXFrQ3ZMY3RKME5sSUlTQ0g0Y01kVUJEY3B3Mzcv?=
 =?utf-8?B?c3U4bnpJLzEwcU5KbkV3NHJlUFZTZzJVSTd3dlMvU2JRVytNUzFpdVZNdFkx?=
 =?utf-8?B?WE9xUnZoc2NsTnNucWM5ZlpGa3huUHZBZVdvYnVibEFSbjJ5QUhITlMwRDZu?=
 =?utf-8?B?TmdBeUo0eUJwbWNjbnYyWkZLY1hNdkJzL2s4NTY2ay9uZGJGNTVCTUtHdXg3?=
 =?utf-8?B?RUVEcDNJTlIzT0F1Y01RQ1NEN3VuMlMyVk1qMFhUYWFsWXhyT1d3VGFpQmwx?=
 =?utf-8?B?SDA1NjExZVI1bVY4Y3htdDBFUm53OHo1Z09nSFhHMGdaWjgxdHo2TUNLTUJo?=
 =?utf-8?B?SndrQzh1RzBzaGt0eEg1dVYrZE4zMWtoUmI5czJPdDQyRUdKUmx1SkovSHZX?=
 =?utf-8?B?ZkRXdW9UQ2piQm5sbW5CWU1PSmdkbXJqUDg4aG1yQUt2a242VmxNQldLWWZ4?=
 =?utf-8?B?cEN4MGhOODhIcm9FQ0gvcUxhemI1cXRqaEtycytITFd0NjdDVFRSWmZxNlI0?=
 =?utf-8?B?cndORkJpUC8wZ0hMSTUzMVJmTXUvcjg2NGpOczFZR05qWXJ2R1dXbFlZNGVu?=
 =?utf-8?B?L1ZSSURMZkoyeVhsNEtLd3BBWG1lTFY0RXpQS1YreHBNa0RKMkhPME8wTlN4?=
 =?utf-8?B?VHFGTWxvNWxjTng5clhQbmFDblh0R0N0bkplejBSS3BZeGpuODFNT2dQNDJ4?=
 =?utf-8?B?ZTY1RForMytSRytUL2dMOCs4dzc2UjJDRW9UUk9rZmVoTVlLZEJvci94c3JN?=
 =?utf-8?B?QUZsVlZyZ08wSVV2VTNleFVOQ0Z4TVZhSE9xYnN2cFdLcWxkc1F4RVVWZ2FN?=
 =?utf-8?B?NlE4MXlDTTdqcG5EYjdOd3Q2RlFiWi9jY2cxUkVxNlVobmFNZHM1eTlWS0tk?=
 =?utf-8?B?M0NPNUpoNVRSeVhSOXF3L2FTdnFSemhFcjB5NHdyd2txd2xFYjBWSlEwRXFt?=
 =?utf-8?B?K1ljRU1POWFyMXFteUk2ZW5hRWNaK1ZrTHNTbjNFTGVwNlgySHRyUzRVQXZk?=
 =?utf-8?B?TFlVWEV0bUZBSFl4UkxqTlFNM1QycjRPM1g2bXc5OUwwRnFYMTd0VENtcHIx?=
 =?utf-8?B?ZjlxWFlUZGp0MzRzTmtXK2NGTkZBN2ZZOTh1cTEzendJeVM2QlRoZmVhbWR3?=
 =?utf-8?B?S3VEL0ZFZ08xS05OL1ltNlh5a3BVSUE0OEhZY1BYbGxpNHFLTERST3ZmdkZB?=
 =?utf-8?B?MDJVbzBVVnYxcE1jRkw4d0xTRDZ6Q293WE00dE1mNDJqMkdnK3BuWFQxL1Bm?=
 =?utf-8?B?dThFeHcvc0FnOU90TzZqVHcxYTVLaDBiODF2N1ZYUEZad2RtV1NVVnVlbW1U?=
 =?utf-8?B?Tng1MFlxaW9OZW5pZnZDTW04R1FyTEs4eWhmZDcwd3o2ZXpkc3hSaElsS3lP?=
 =?utf-8?B?d25UTFhLcXB1MU1nSGZpSGsxQ2EwQXFmWDlUUFFDSVA5TDRGaDRmU00rcnQw?=
 =?utf-8?B?UWZNQXlXOEZMSUE3R3ZBbFBMdWFMdzJmM2VIVHZIUjZONGR5VloyTTdzakFw?=
 =?utf-8?B?djdQVzAxVTFMcG9oTWVqQkpSdXhSWUoxTlJKVXViSE1QRFZvMW8wSGdJbTJB?=
 =?utf-8?B?c1VJMWhGc2s2UG5TZkY2SlRETzlhSWk1YzExUHlRRGd3eXZWMkNUQ1YzbTN6?=
 =?utf-8?B?bC94KyszNWNOTFJONE1PQ3NKZFNHZVovT0VZQXlVNEE5YURDZ3BGdGR2alg3?=
 =?utf-8?B?TnJCZXQ3TUE0a29LOGZJR1NTSlFQZEsyTWhEaUZvNjhlcXV2T3V2YXhwc2NS?=
 =?utf-8?Q?NKL+oq3w4lq7gtsjiJMM2zqXYCIDgjEZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q25QNkNCMTRkZ2V3MHhCRXBZbDVhdktTcFpsbitkSHdCTzNFUGxtUTNyclpC?=
 =?utf-8?B?TW9sQW9MNWVvUmRwVkEvQlViMk9td1dxdnZwTUc5T2RXZFY2bUlNSkdFRHpK?=
 =?utf-8?B?S1JIQjNrVUJxWUNoNzdkWW5uOGQxZlVweXkwWHNIVFByTGt2WHE0K2x1d1A5?=
 =?utf-8?B?S0pleWUxY29GSTVJUGsxelRYVFdMS1dGK2YvM2E3RFl2UXRjRUptYmZmeDY1?=
 =?utf-8?B?amo3MnpJSFlhZTVZaTllaFFWVm9hVVFxdEJnMklMb2NKam5ydWtNdjZ6VGRQ?=
 =?utf-8?B?WWNKZllzcmlVR1Yxc3NMbmc4aGh5b0Z0WEs3QlY2eDNLeURFUG4ycmd5Skhy?=
 =?utf-8?B?cUVPUjQ1NDNnUDF0RzdtVFVvSHZYUDlRYWdab2RmY0wyN3liVHFZOCt2S0l5?=
 =?utf-8?B?RWVHVGZOeUE2SGJXZXdCVXVzSW1hdjE3QitWcmU0TmNxd05GSit6Rlc2bU5C?=
 =?utf-8?B?cGh4bWJlLzgvQ0tIa2tMWWtUZ3pRTGczME9ncFRhdm5xaEZxUHZDTmd0dFky?=
 =?utf-8?B?dG1aRkxocDFGMUhBTmtNS1lCWTdCTDR0Nk96YzNCODJBekFhWENGSlBKWGVi?=
 =?utf-8?B?REw2c2hIY05BTVphSGJhcWU1NGlyRVFJSmRCeGo3OU5zbzJQN01vVEkwajNB?=
 =?utf-8?B?NjdxMjc3VUJPalM1Nnc0ZHRVYlY2OENJZnZVN3Z0TnZvRGMzOGpzZFlodXh2?=
 =?utf-8?B?b1J1NEZUMG5pVW5DMS83amZ0Um91S1YwZ0N6OGxYYk16KzBTajc2OHBLNVJq?=
 =?utf-8?B?ZVJ4U3FPYzlUM0Job3NHQXJET0JMSFBYaU95b3p3SVlpdXlWWXZ0UThZZXVE?=
 =?utf-8?B?MkZLT2lvaUd4WDYrdXlpQ0xWOHg5K1dMUWsvaEk3V2wzWGlaTkkxY0kxS1pk?=
 =?utf-8?B?cDQxazYwNVFZMmZJTFRKNWpyMmxzQWxUc21hSkRZQndHUmxaUU5FNUh0RVhL?=
 =?utf-8?B?T2swdnBvZG1heElzd1NuL2UybElONzRUdXJGQ1ZkcnRBZVVjSzZUd3hsRTNa?=
 =?utf-8?B?VFp0RU5PRDI3UVJTb1M3ZHNDc0NXbGdKajJnNUFBSFNSU0ZFbloyaDczV2xX?=
 =?utf-8?B?dG5uTEFrdTlNVHBFTjJ6ZmZzaVM5WmpsRXM0Vm8yZFZDb2tLWmFMcW9la3dq?=
 =?utf-8?B?S2JKUHZ3eWZkQkx6ZVAyZ1BYRHJHWitha3huZEp1S2M3WEJBbmdoVkZUanVP?=
 =?utf-8?B?OUFmczQvRzhQSS9vcHdmaWp5alY3cWVHUVFab0Uvemc2NEpjbUhDSkl5eFJk?=
 =?utf-8?B?ODE4cWJoMm15YWJHdmZLbVZRN1VjTnVGUENjZnpyOTZ3YVVETzE2akpkQ2lo?=
 =?utf-8?B?NVdEMzhvUTEzazNmL3IxS2xNNTNXL1NSQmhyN3VCSFhPcit2QmRrMUhVR3Jv?=
 =?utf-8?B?aGxEUjJmb2o2V0dTcFhFUDN4dURydUg1Z2xtMEJjZ1ZyNVFyMXlSb2M4TmhS?=
 =?utf-8?B?SGtHVW93SUJ3ZFFXUVV3SlV5cEF5a0txUThhaDZFNmpuVE9XVUF6c28wcXhV?=
 =?utf-8?B?M0x4WDdKM01oZ2E4VDVlY3N3S0Robk1zUDFRalNhWUtFdGpJd3p1aWI5Vzd4?=
 =?utf-8?B?ZzlKcmtIeHBzT1NuVm9Hak52MElUbmczMEJNM1hEQzhIakxCdHJEYXp5Q20y?=
 =?utf-8?B?MjVwT1FJQThlb2JZMTEreEttQWNncitwdUY5NkJEMTFJaU1LdGVmMDcxMmhi?=
 =?utf-8?B?RzZCSHJaUHpvZ1hqVEhnaDhwYjl5Mzd3MmtPVzNXMmREK1VhNTFNbU1BZEx6?=
 =?utf-8?B?UHdLa1ZWK3hkWkNyYnZWUWlrdmZEQkFGY2FqSE5ML08rS3V2YUFFcVhCRDhT?=
 =?utf-8?B?Z0Nad0NyeDNEazJEcDRHdkI0UmNEdE9ib20remxML0paai9oaTNzcXk3ajNW?=
 =?utf-8?B?ZVVzVHVSL1F2SCtCVmtzSnFQNXJDTjZxYmc2ZkF2bmZtQ1BZTE5WU2cvWko2?=
 =?utf-8?B?MzcvMUVPNWlPQStmWG9pM0lXVXpweFhKZVRmS3NqRDZIUHRFdUVnQmdxejha?=
 =?utf-8?B?ZVZ2cWNqamZvQ2dFNlIzeENyakZ4cmNZL2t6bG5RSDViOE5RUVVGTTZzOXBT?=
 =?utf-8?B?cWFXUzU5MWd6cjZtSU5VVS9OenJIN3B0ZG51M3Q0VnBJRE1KVXFXbWJyZkRu?=
 =?utf-8?B?VW9FWC9LdkNOdUVPZmNiUGdxaEp6UjJUUDBDaGV1V3YwZnpUUEY5U0YrNWFI?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95d9074-6d00-4420-81c0-08de322e30b6
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 05:38:30.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I54QtUF8lF+zKypzk28eXjHWC3lkqMeEA2YDwpfBckvREXGJjuuAShEoxQ367Ijp1XlKdjRfu674lRFqqTJftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6976



On 02/12/2025 17:28, David Lechner wrote:
> On 12/2/25 9:05 AM, Nuno Sá wrote:
>> On Tue, 2025-12-02 at 16:52 +0200, Tomas Melin wrote:

>>>>> +
>>>>> +static int ad9467_set_offset(struct ad9467_state *st, int val)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +	/* Sync registers */
>>>>
>>>> I think this is not what David meant by adding a comment. IMHO, the comment as-is does not
>>>> bring any added value.
>>> The sync operation is needed in several places and is not commented in
>>> other locations either. Do you prefer no comment or even more elaborate
>>> comment for this particular sync operation?
>>>
>>
>> I know. I'm just stating the comment, as is, does not bring much value. But I was not the one asking
>> for it so I guess you should ask David :)
>>
>> - Nuno Sá
> 
> I did not look at the rest of the driver before. I guess the
> fact that it does the sync after every register write makes it
> clear enough that this is just a thing you have to do. So I'm
> OK with leaving out the comment.
Thanks for the clarification. I will remove the commment for v3.

> 
> What I was asking for though is _why_ do we need to do that?

Addresses in range 0x8-0x2A require a sync operation to transfer the
data into use. So it's a kind of latching.

Thanks,
Tomas




Return-Path: <linux-iio+bounces-27961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6CD3AAB3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308733061DC1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699436C5A1;
	Mon, 19 Jan 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="RJPtYm1U"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022090.outbound.protection.outlook.com [52.101.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B735E555;
	Mon, 19 Jan 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830614; cv=fail; b=K/dzfuEXQ9JwfSOzJKCP4a2ZGJYWrnXU8COs6DjrATtTXszPGGZkiUWrdtHIY0cm/CRwIh4e6ZYpefzRaaGCPXyC4n4ImCuwnoBOchY8FupYRe7FPRwZzyRUgOhKvoYLiFHQHPRxuzVcJfIj3sbNkf5iFAHZbybNEyEMcx2Edbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830614; c=relaxed/simple;
	bh=Sonk6ixen4P3gp5BGF+5vVJaqcfUkL+OQpAkCB2381I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eSbgXN4cRy62NmOBE+HkVcL/MKW2CyQsll7tTX7NpdMtTE3IhLtWNpKiyUBnCEwJ1jPScjoPJNemCCWOEBhc//0FL6XMF9OYpLkxK0YrbBUnC60h0p80okZquP+zA/tIm8ivew8lri40Z7XMG+muIJvx7n0Xmedzv0pbiii6sz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=RJPtYm1U; arc=fail smtp.client-ip=52.101.66.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ52ufnVhCCQmEZLo+AFjBQFowiVVkSGUz8wjgQsUuUc/wPovKT6hiWQU5of9mJpdkALVrg+U8bVvs7VaJNrm/GwFS5XsxVAlBSrQt4bmgA7bAFP3vlfCAPZGUp+YK/UND7xvguAMjcG6OoAdMomkD1YY2xUNU3yf+CtHO8tFUaGfnLVAEO3bPERj1aVMpy7N8kMZRXJxlnYWkePhBtIY9ibPWFtHz4DW6jE8Yz5DSsH1t3zlnLKnxRTV7SdWWnsl9WPxijjkIvAu6WC4tzcQZ4cM6sozzmWSU9XwczK2vXDN/s3JnNHWWDde1KVaHd9CpOZoyHiSidLncT6J2uhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmFGwfjjQX8gdRUQU1Ci/WOkf1tfkUOFUi4H0A+ywdM=;
 b=mhTndQRBZNSOsINzgdLzrWSpmIZtZL3yfj60oRX+DTynSayJKMv9EqOhnRJgxtDlZ6HwAy+kemR5Wc5bhsL42WHhmDRRhzxzfh2crQ1KV+eZS7/YVzgnGUgh3/STPtW2bytGjU6KAosLifbf4a1+0wcVzfjPih75lsIsEh4RjGgSLT5MwybeDv+M42Y0y2gWGKek1FCZJokYKOaD4JZRIUT9arc49vtLWD7e/Ti+1Wco2SC8KJlkR63C9XSWlyplYCBRQkd5wJyLcJJUta3byt8beJE51UoYnXli7n5PCj2qW3RuW+H5dkjCOxQaKfauI1W9/IHn7QhA+Tdp1FFJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmFGwfjjQX8gdRUQU1Ci/WOkf1tfkUOFUi4H0A+ywdM=;
 b=RJPtYm1U5sEcx6BKRAlNapxs0foVRpbLNZGTLGGbeWJut++V0DmrXHsDrkXKgLa/6Gf2Ir3zv/PcoQkuGjqnYXwYwiqiUh92hTsaQ4+9bPhIAqeZ2h5GH7fWXNTo3cc1njHUGKe0IXy4UXEVT6oAu2KBl+Y68ay9vya4MwsR0IZB/uXxC4ZbTRulGykuz35SecPW9b47t3vx3A9Ky6d88iZ6pyl63duhDiFzl9Jw8EAJQDrbdqxaPIPenkjJXupddFyiFzYDN2SuN8kpQEJOdsJNr8ZMDTVH4JpvvsRM6y4YValY1r7H1F7kckWuhirtxFb9slU0PqXzXzqV3EtP0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8821.eurprd06.prod.outlook.com (2603:10a6:20b:67c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 13:50:05 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 13:50:05 +0000
Message-ID: <1f431375-f2cb-49a7-a0bd-6c00273a3c92@vaisala.com>
Date: Mon, 19 Jan 2026 15:49:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
 <fda7d715e2cab2545c9ecdeead22d8a58ae5032d.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <fda7d715e2cab2545c9ecdeead22d8a58ae5032d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DC20.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::114) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a24ed1a-ed92-41d7-06e9-08de5761a6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUhwTXN6YS9tcTYyNURYSUVzZC9NUnJyenRNZURwQlZGS2pjOGlUeVBucWM3?=
 =?utf-8?B?TFh6a0Q1ZkpjQTRCaXpyQ2loV2JoQnI0dXhzZklCVDNhVyswL2RoU2ZlcmRP?=
 =?utf-8?B?NUVwV1ZlNUthUm9PeUlpczU2TER3aG91UnhqejRQODVndzRBeGh0dDgvdG5U?=
 =?utf-8?B?Nm5xTFowdUpTaTg4Z1FNUlJZdVY3YllnaGJPNWZOZmZYUm5zZGRZMVZwZXp3?=
 =?utf-8?B?UEE5S3V0SW9MQ2kzUmJYM3NjV2Z4MUJYSVlQM3UwTXdlQVJ1WGRLdHV6Qk83?=
 =?utf-8?B?dlVObUh3SE5tY0F2cEp6dTNRVkNqbVBpcEhRaUtqdVJyR1o2d2xZK3RlMTFj?=
 =?utf-8?B?azZUR3IySW9Wb0s4M21WazFZU0Y4N1d3TXFWVEg4bkJ6SmUvZnAxT0NSRkNO?=
 =?utf-8?B?L2NCdEl0SUFZUUV1SnVsNXNKVXZ5Nkp4L3lpMGxIMkZjMTVJSVV5eGhSQTFH?=
 =?utf-8?B?VVlQWkhqUlRsNDJVOTF6QnZXV0orK2RjL0U2a3pBKzd6bVc0MXZnM3pNb3V6?=
 =?utf-8?B?MlFqUjNzbnZYNUY2Y0tDYkp0TzMyTjE3ZDFCVkpLZUVHZTExZ1NJTDVySHlR?=
 =?utf-8?B?RUZqUTNheGtjVVZ0WU5FNUlUQTcyWDkrYkFFWWRrMlZQN3IvNGFZTjllK2V1?=
 =?utf-8?B?OHdMR0x4dDU4Y2FWVk5PQU4wK0UzeWgydmEvS3Vmd2ZCVFZRT0kyR010bjNU?=
 =?utf-8?B?dmhnY3pib0RHa2lmWERnVXYwNCtYK0pOWkwxU0p1MEN3U3BkYVBxZEhCUndV?=
 =?utf-8?B?bXUwR01xckFYU2xsdmFGY3BXdFp1aUVBSzg2T3k4OWVMYW8zZ3gyRUdFNVBk?=
 =?utf-8?B?QjBRQnd6YWdpRHdZUGY4clcrYU14cC9NSXkzSzZob3JwWjF6S2U0eTUyQ3JQ?=
 =?utf-8?B?TUVZaHdmRXE5RkJ4d3VQRDhuN2ppUjR5M0xsaUtDV3c4emNmSEJXZzJNMm8r?=
 =?utf-8?B?R0hWNHFNMFluc3RCZmozRkRxNmZqdUxuSGJiNE5zY3cxUU5wZ0lTcnYrMU12?=
 =?utf-8?B?bWNmSCtVWWFRdGdTQTBMVVdVeDFpRVU2cFJXUVh2OVJ3bjdGWHNlbkRNM0p2?=
 =?utf-8?B?aVA5U3RUQWdFT203dnpsQnMxV2tJRjBJZjJsY3FOWW5FZ0h6Yjk0R0pwb29Y?=
 =?utf-8?B?KzVZSkdUZXNHRmVoZU9IMU5aYy82aHZsM1hiT2JROHJMVzlBNGw2UlVmcFNP?=
 =?utf-8?B?aWpwblhBWCtwV0JYNVlQK0J5TDc3ZXA0VEpyTkFqaVZ5L05jajdhS05hSW9Z?=
 =?utf-8?B?QmdKd295QjBMeW5QTTh5Z1NleThxYzBVZkUrcFV0QjdqREVjV3FaYVF5Y0pU?=
 =?utf-8?B?UUdzR0h1Nm9TRko4REV3WUtEajJXSFNSUjFpWWx4SDk0eUtIZ2hIVEpFUndY?=
 =?utf-8?B?Z3M5TXdWOVRNRlFsRi9QZk9WeGJsdmtZbFdXNXZKWXQvMU94OVBEdk9DMGdS?=
 =?utf-8?B?VUNiUjBkOHQ0RW9DMDlHZzhkWEFjZVBKQkh1L3dzRlkzaXJQZ0wxRlVRaDB0?=
 =?utf-8?B?U2hWZ1o2L2JqNGtnRkZSLzBaS1JEekladWo1OVBlcE1tOHBiUjNCS3ZhS0RN?=
 =?utf-8?B?eEdrNklicDBkSlB0Z3Badit1aisvTURDREtRU2I5L2RjRTdkTGs3OEVLTGpO?=
 =?utf-8?B?dVMvQXpJRUpEbWsxZHZMMlA0WW40eW5HMUJ6M0VmVU5ON3hBZXg4TEZSVW9Y?=
 =?utf-8?B?TGkwbjdZMlBkZTkySUdpTktHYnkxWEFKc25lY05tYjhtSUkwN3loQzUzV0RW?=
 =?utf-8?B?RzgvakoxVU4rT2FQMVU0bjFZRGxLNmVBYmFMdWZSbGZQeXJ5Q2tUMERtYXlT?=
 =?utf-8?B?Nk5lMUJ5SGM2Q0JDaDJiOXlsR01ZUHpWTkNrNkVIcXJKbkNkUElnTGt6OXps?=
 =?utf-8?B?MjZMR2FyVzIzc1gwTE1GcEk4cWxlR0FIc2RtbVFhS05WVVFreFNkYVB1OVVH?=
 =?utf-8?B?aUNVTGZESVh5SFRNK09lQlhTdnl2bUJJVkdZMlA5bU9PVkt0S2gwRGsxTmVX?=
 =?utf-8?B?empScndOcWJ3NEx3OTRIankzV3B2Rlh6TlF2Mk1ZR1JhR2p6UW9GNFExM0lN?=
 =?utf-8?B?QWZkU3hKazYzWFlsNVZxcjdqQy9pS3k2UzZjU0thZm5DcmNIcXdmWlVCSXFR?=
 =?utf-8?Q?LD+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tEaldkL0txeEJrQ1B6TTdFQlllaDlUQmhacnM1MWlMTGdNalFQSFhtbkFD?=
 =?utf-8?B?UHNUVXFFcUVLYmMwM0pHM1drSjFTeTVLYkxmMmRoUHVQZHJLSUVsdUF0Qkli?=
 =?utf-8?B?RzFUbnJENkJLaHpSL1hBZzl1b3Y0YWNxYmV6Qk5DTUl1QWdQR3RNOEFoRlpy?=
 =?utf-8?B?RXdSakM3dXk4dWc4N09jZGJHTEdDZDVzNUxINkJiQmI5djcvaUFBWktUMFBG?=
 =?utf-8?B?NTErdUtJQkUzZEw1WWNrNE1YK0JKWXRSVHNvMUV6dUV3UWFRSmFiNHZETVM0?=
 =?utf-8?B?dFZDZEJMOE5SSzFGQldMUlhpajhXZnJSd2lWdkluQUQvdjJlNldlcGFmUTA0?=
 =?utf-8?B?cEVXSkJxOWJyaDQ2eVhSRmYvNjgvcDhRNFhyZFNVMDVNRzJLSkNLOTl5Q2pE?=
 =?utf-8?B?eVhrWUVMOVpBQ0pCSHk4VG0rekZFcWZaVlU0VmtiWWpVRWZ0dnJWb1lpWTUw?=
 =?utf-8?B?aWd1M2dkR3NvdzBpTHRXN0ZOcVBvVWp6WkgydEd2UFlFQ3A3Y1VFRHAraCta?=
 =?utf-8?B?MW9lK0xnQmdvWmg3YU9wL3djT0hqeWxvaFVISDFKeW9xQ1VlK1JXT1F0NWlF?=
 =?utf-8?B?MTNkdk9xTHRwOEMxVXg5eGNhMGNmR2N6VHB4RzlWUFZQT1JGaXM4Rm1BN1Yw?=
 =?utf-8?B?RWJGZ0h1NFFiZlFhZ0VWdjFWQU9zM21pUEtuZjBDRmJsRS9kdFIxSUg2Vm1R?=
 =?utf-8?B?TjN1RlFoUlFZLzFDbUUwYlhEQTE5QzV0UEpnR1hOVTZkNU1RSURUR0RGV3Fn?=
 =?utf-8?B?U0o0WEgxKzJOYjQ2MS9ib25pSEJmVVFvbXdCcWZHMUJGNXl3NHdSTlZ2bkJZ?=
 =?utf-8?B?T2p0QXd4ZjBjL0lCOVJQWHFGa1dkRHhWMDBLcVBFUGJTL21Hdkt5VVdkWWR0?=
 =?utf-8?B?dnhCUmxHYzFTY0dZNlFrS3RkUnMyMktGYXBsdmJCWm1SNkw1MkdvMjVyR0tp?=
 =?utf-8?B?QXVScnNFNjJodDZSdlp0dkVXWXVDMjZraDV6ekpYS01yTFNvUStsQWtvYnYr?=
 =?utf-8?B?UkhITVlnbytBVEZiMzhKZmNMYVczbmdjcDRuR2toVUtVS0tVWkNNdXpxcVB5?=
 =?utf-8?B?OGs5SzhTai93QzBQQTBvR1k0bzFUT05XSXIydFUybkc4SUZoRmE0Q0Jtdmpj?=
 =?utf-8?B?S092SVNjOG44czJIRkxoWERmYTJrZGVsL1o0QVc4ZHduYVl4YWVUdktnRkd4?=
 =?utf-8?B?R2dVMUNPMTlUZi93S2RsS1kwWGNWcEdtL1VCVTIzYTFtenZSNnNrR2F2RmJj?=
 =?utf-8?B?dktVb2RaczBDTWxtNG9LSFJhTFFXVkE2T2tQaFRvSU1BczRqUU90WGMyUkVt?=
 =?utf-8?B?YWpxeVpCSERvYTdRWnhIWUlJV0tVUE9lV2VLY3E3NUEzYmRscW5lT1lueXA1?=
 =?utf-8?B?aWlYWnlFeTZkY1pyaFUvbTY0OFpWREorME9BdFVHbVJJTk5JV3Y5UU9zSHlw?=
 =?utf-8?B?NDBRYURnZDJ5dXNaMit6UGRXQ3JLNEE2UVBYZWlhRkQyUWZhT2E3YVpKbU5D?=
 =?utf-8?B?TmVsZXk3aUZJOXhkTllmbjBQdDBCNnV5cUJKYitrUlRMM05jcWJOTC9XVXVV?=
 =?utf-8?B?WHpUWDlUck5JUzNKY251cXUycmJ2VUs1U0xKWjMxNld5ZGxqeXhNUnZLN3pN?=
 =?utf-8?B?RzdsNmpqOFdKMnF5cHJHLzlTZDl2RzFYdDZ6UXJreDhqVDlZVkFDWmFaOFF5?=
 =?utf-8?B?UXprOTNGVzhpREhFZlQraDloaEN1aE40RWFxSy9tTnFjSy9ZQ0Y4am9FWnNv?=
 =?utf-8?B?QWZXOG5iN0M0YjhNM2J3QjVaQXdRbG4zNjZxN0duRDlmU2UxYjExZjJ6eEVF?=
 =?utf-8?B?ckpsUkNXOEJCNFYrVXYxek1YbmFtVlNLOXVoZzM0OTIxemxoSnRsbzdlWVVI?=
 =?utf-8?B?VDJpWk1scHZ4UzZqZzh2bVoyUTVJVWQzTmE5blBqeDJaNVlxZCtIRFVwaG04?=
 =?utf-8?B?c1RRVmlpZmVIYzIxazlMcXJQRUFvNzQvUmF4d2ZJcmUyTmpHU1VnaEZpcldX?=
 =?utf-8?B?ZXdwMjBYZDB5TDlxd2VlL0V3aEFJNGdkUFc4TVE1OXRuK1dqK050bVVUb3Fh?=
 =?utf-8?B?dWtGSWJwZ2g1ZXlQaGkxVDA2SkZtYkY0RkdOUTBneXk1MmxWdXk0TjRrcENq?=
 =?utf-8?B?Qlluc1EyTVp6SWFiMlRHNHBRVVExSi9iZWRKNWUyWng4cjBLZlpieFh2UGlk?=
 =?utf-8?B?UHhsU0lvQ3FKT2lzYzNNb1QvRE1oZS9oQXhUTm00WUE1R0pncW91amhqUmxm?=
 =?utf-8?B?N3MrTm5BakxpVFdkZzcycVJkaUdhWEpMSE5UZFN3Smx2YkxUVzNBb2VRb256?=
 =?utf-8?B?QVJUbW03aVJZcWNYeEp0c1JlWnAzQ1BBOVgvbitaeTU1YVFEZUM4ZmQ1aWIw?=
 =?utf-8?Q?0I+TaDUrEKQz6yrk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a24ed1a-ed92-41d7-06e9-08de5761a6e1
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:50:05.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsVwoZwzq71WEQMyoQqUpx/F3tUfGgu03AoebehWCxdjldN4ARaH/vxOrb7TipeCuzBk02634Bu+V3PNlykzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8821

Hi,

On 14/01/2026 14:20, Nuno Sá wrote:
> On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
>>  drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
>>  include/linux/iio/backend.h        | 17 +++++++++++++++++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..0a98fdd5df9db6cc233af819ac5243ba8cd5266f 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -56,6 +56,7 @@ struct iio_backend {
>>  	void *priv;
>>  	const char *name;
>>  	unsigned int cached_reg_addr;
>> +	u32 caps;
>>  	/*
>>  	 * This index is relative to the frontend. Meaning that for
>>  	 * frontends with multiple backends, this will be the index of this
>> @@ -774,6 +775,21 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
>>  
>> +/**
>> + * iio_backend_has_caps - Check if backend has specific capabilities
>> + * @back: Backend device
>> + * @caps: Capabilities to check
>> + *
>> + * RETURNS:
>> + * Non-zero value if backend has all the requested capabilities,
>> + * 0 otherwise.
>> + */
>> +int iio_backend_has_caps(struct iio_backend *back, u32 caps)
>> +{
>> +	return back->caps & caps;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
>> +
>>  static void iio_backend_release(void *arg)
>>  {
>>  	struct iio_backend *back = arg;
>> @@ -1114,6 +1130,7 @@ int devm_iio_backend_register(struct device *dev,
>>  
>>  	back->ops = info->ops;
>>  	back->name = info->name;
>> +	back->caps = info->caps;
> 
> It would be nice to sanity check the registered backend here. If it advertises some capability,
> then better to support the corresponding op.
That might be easier said than done. A certain capability might map to
slightly different operations on different frontend/backend combinations.
Agree on general level but I would omit this check currently.

> 
>>  	back->owner = dev->driver->owner;
>>  	back->dev = dev;
>>  	back->priv = priv;
>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..8a0df8e980e910ac2d5398275963dc5adf077c8a 100644
>> --- a/include/linux/iio/backend.h
>> +++ b/include/linux/iio/backend.h
>> @@ -84,6 +84,20 @@ enum iio_backend_filter_type {
>>  	IIO_BACKEND_FILTER_TYPE_MAX
>>  };
>>  
>> +/**
>> + * enum iio_backend_capabilities - Backend capabilities
>> + * Backend capabilities can be used by frontends to check if a given
>> + * functionality is supported by the backend. Capabilities are loosely
>> + * coupled with operations, meaning that a capability requires certain
>> + * operations to be implemented by the backend.
>> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports calibration. Needs at least
>> + * iodelay_set(), test_pattern_set() data_sample_trigger(), chan_status()
>> + * and data_format_set() operations implemented.
> 
> I would not be so explicit as the above. It is very specific to the ad9467 process.
> There are other devices with other ways of calibrating the interface and I don't want
> people to keep adding things into the comment. So it needs to be a bit more generic
> and we should also be more explicit about it being about calibrating the data interface.
Agreed, I will update the text.

> 
>> + */
>> +enum iio_backend_capabilities {
>> +	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
>> +};
>> +
>>  /**
>>   * struct iio_backend_ops - operations structure for an iio_backend
>>   * @enable: Enable backend.
>> @@ -179,10 +193,12 @@ struct iio_backend_ops {
>>   * struct iio_backend_info - info structure for an iio_backend
>>   * @name: Backend name.
>>   * @ops: Backend operations.
>> + * @caps: Backend capabilities. @see iio_backend_capabilities
>>   */
>>  struct iio_backend_info {
>>  	const char *name;
>>  	const struct iio_backend_ops *ops;
>> +	u32 caps;
>>  };
>>  
>>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
>> @@ -235,6 +251,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>>  			 long mask);
>>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  				 struct iio_chan_spec *chan);
>> +int iio_backend_has_caps(struct iio_backend *back, u32 caps);
> 
> Not what David suggested and I do agree with him FWIW.
AFAIU this was exactly what was suggested. Citing:

>> bool iio_backend_has_capabilities(struct iio_backend *back, u32 flags)
>> (caps is fine too if we want to keep it short)

Using the longer format is not very practial. Can we keep it as

iio_backend_has_caps ?


Thanks,
Tomas


> 
> - Nuno Sá



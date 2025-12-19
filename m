Return-Path: <linux-iio+bounces-27187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9526CCF8C3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E656301596F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7930DEAB;
	Fri, 19 Dec 2025 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="lC4vK84+"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023115.outbound.protection.outlook.com [52.101.83.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62530DD14;
	Fri, 19 Dec 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143027; cv=fail; b=gD+iQ4t2bJ8StDkW3gvSEUOob8FHbzvtr1myc09ktHoNvAoO4eNQ69NqNRelz/B8HVOy0jO+5UoMRuXQBzcuQeG5Lawz+Ooe3y8vM9kHOGgYGXHiRlAVj2dd410RDLllTQ5uoLuVkyLZBc9t9E8oEuWh1d5R7PX8bJb5vArFvA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143027; c=relaxed/simple;
	bh=/JrMg1Vra4snk4eWM0nxmYpIeQfn28kbNUkeI3uR94g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrXdv1r1jK1gHRl022KoVe6EjxZqHznK4XYKkeEjKZdhSLmqAo7Tyv7jwllnj6lCUYH9tB1cPASyzwVLJ8tDpLxaEKdYrzI22VYs3lvHqJCVO9noSbSG0MbL5y0jg7uY97ZmW4EL9giCvl+dZLc45v36PG3NV0g08BkGItlAPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=lC4vK84+; arc=fail smtp.client-ip=52.101.83.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNsAT14G5N+fE9OpNfQ2KLrtO2Tmild9ze4Khlqs8is68ilwu6NAyK6kGw++LkjDKRDNEK8tNL05bSl/H+a56YYnwThrBD5e+CClTw1V9ke42AS7L2ySH3lDxQa+vUdD/vbvx4aizieNh3gR7SNsEoe5mNE/taGBP04r0uDx2IqiAW5tW2piM7JuEkgVWp8A/PQdiD1j+q9KuHGgqo74T++IvaYjAQ3SfJFYUEdgkSPZBNJEi2pzO5TV+zu5DQ2GB745RmxVvHYzBEprrh5NmJhg5aDKddp2JlIQJmtt1M1R4O0S6jnwFSJnbQGMwy+h6jGlFUWZyFSzcdAO/Fl9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N14PCu4X3oZnxPXPJxwbGsvU3r6+kB464bX9nsplW90=;
 b=rl5ZRAB+f4gCuD/Ik/wEmTtQfWftS1T3xNncUkGVnsEoQVcVtdCF7QwUQOuGlO4BLlVoYXP03rRSIlJRJemcxOSp9CzWpM1yHWuXzqcy0iSfx6/eAUgAq7UItkh6wUWc0Ymu6sG4uvOuRYrS/m1OiqzrLviVWclfCXNnWZMQmLcnF59gtyCGXQNsynxRmPCNoArIWXbfwZthn0QMwYKkxEy0PhE09JyOfaEK4An2kIpUCgsjuW3rcfc0sPd7Irhis2V89K0RBHRQyxewVU84hlVQk/GJzLMa6PtHbDeRwdzKgCOgF6+ZTTZFwKT7JOoepjuD/mDDPUCdpng2Gx3z5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N14PCu4X3oZnxPXPJxwbGsvU3r6+kB464bX9nsplW90=;
 b=lC4vK84+dzPpSO7c0PWV8mxGg1GH9nu6IrKYVczhF1S8BJejGhIS38b6I/hfqLHReTpO0QETSv3EonxnG1SjTaB57DcchaqrUH6JJGYIYVkGwNq9Iu53OAqONuyITlQjEb0k4le9lmnu1lOr23G84hSTmSvKvXR8o71qKHF29ZlobIKe2/WOcVtrGrLklkc1bFQD1FKh0UC8Q58LP6e1BY81nsad/FXz2f+/euTsbUs6IWNTNgiSO+MzrmEaCI33icMYAP36HlaHdnJsQKL9YgzqU4N3803vsaIfw+8eNT/2oXOb7+QNgrxVO7vZ0jdG7hCntCr2bD9+1EQkQ3P2Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB7564.eurprd06.prod.outlook.com (2603:10a6:10:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 11:17:00 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 11:17:00 +0000
Message-ID: <e095bc11-9986-40bb-8ad2-967ee85f67e9@vaisala.com>
Date: Fri, 19 Dec 2025 13:16:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <88efd2784c9fce72e432a59a03472bb4441e975b.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <88efd2784c9fce72e432a59a03472bb4441e975b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF00007A7F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::611) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: ae59a2e0-a5c5-4f34-3da4-08de3ef020e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVhEeUl4eEVVbnNLMytKR2tzSHRrVVRjcmhvcjRibE5LVTMvYVJYZ3Nvb2hq?=
 =?utf-8?B?V0N6ZWNhdzNKWWJuYmFuTU9ZbmpuL2g4R0U2UlZpYUk3NllRbDNSUzVEVmRt?=
 =?utf-8?B?RXVPUjl3ODhjZU51NlNQVVpKN3MrUEIxK0NGbWREa2t5c2pmSmRkOEorVU5B?=
 =?utf-8?B?WUV6NDlhVFQ2a2RHeXFhWUpjWW4yNEc2eGUzNWFaa1hSWkNnNGN2bmZZUlRt?=
 =?utf-8?B?QmFOSFRZY2Q2WjdmbVUwR0IvZ3hpZFBOYTVXQk4zV0trUmhQVEV1eS9vaS9K?=
 =?utf-8?B?eFpGc2k1bkU5bVM2YVhkSFN6aVRPUEsxSzNIdjBWZWhxOEJUN2ltbFIzdm5r?=
 =?utf-8?B?Uys0TWwraEVadzRENldMbFZUamRVZHVMZC9iNy9xM2VKMlUzZGZUQWc5Nllk?=
 =?utf-8?B?cVVpVmZOK0NzUVA3cGhkYWNHYmRzNXlCNU9oUDhhbFdPdFYrcmROZ2RMckt5?=
 =?utf-8?B?L0Zod2tyWVpJNURSUFFoZDlzTHl5WGtudmhvMGRzZjVYOFVVQ3hucFU4MWRi?=
 =?utf-8?B?a0RCbm5KcXYrQUVldm5pL3FrWDNYYk1Bd21uUU93TGNRN0dYQ2NtQzVZZFJK?=
 =?utf-8?B?d1VhSERSd0YrTFhteWFyZlVocWxxUTk1RkNNdTM5blhVM1hQR3MzeWVqRm8v?=
 =?utf-8?B?K1NaVUVWU1pDU0NBUitTclI4MjVBWEp6cHdRUUNHTW4yaTlPdjllWFdkNW9K?=
 =?utf-8?B?ZFNWK2RuUGRmUUlqU1kzWjZjS09yZkYyeHR6QlJvVEJGVkZ2ZFpkZkhDRHM0?=
 =?utf-8?B?ZVJHbVYrUlNLUlUrRUJ2VHBqYjdwNlFJcjBVckQ2WTNqczlZT3U4eDVVTnpl?=
 =?utf-8?B?QWE2dVdwYlh1OGxMY0FjMTdmQUJ2WVozdDVCbytJeTNoeHFLQ25kYncySk1B?=
 =?utf-8?B?NDFQY1JSd1NUVW5Raml1THF5MXdKbzZBdENZc0hMbnJ4cEJDSG82Mm1OMHZV?=
 =?utf-8?B?STN1LzJjYmhzVGhIVjh0QW1jNmpFbjBtY2RxdHM0RVJBVmNnbm1pRUJPd2lr?=
 =?utf-8?B?QzUvZ0hJUjNMYVlwRDNPQnpkSHhhUThsUjVyQlJnakp5dnF2NHpKVnF0aFdQ?=
 =?utf-8?B?MXdSSnp2OFIwcXZ5QkQwSlpPQlFZdmhnTnYyek9jTzd3S3ZQVTFNem82dDVO?=
 =?utf-8?B?RkJlRUpPMW9haElwUVFLekpQekFtM2NHalF3ZHBnUU9XTUp4Nmc2d1l0M2Rh?=
 =?utf-8?B?a3VuNXd3dkk5R2pteisrRzNaeUpDU1RrWmJRWlNSNGo5czZKZk1XQTB0MEVO?=
 =?utf-8?B?b0JZM0JOb1VvY3lCY0FwTXNZSmMydW9NS2pmajU5dkorYlQ5L0tGVWpQbllk?=
 =?utf-8?B?ZjVhdXFUVTlaa1dyc2pmU0YwUmZXbTNhWmowZko1anJoVy9OdkpLeUlPQkUx?=
 =?utf-8?B?VDZNNEwwaWZLa2NUTGJKd1BMdzdDb1AvWkQ5QkRMTFNIZjNycEcxUkJMSVdu?=
 =?utf-8?B?RnhicHBNc2orbGRuSG5kWFRDcEtabVo1TUlENCthb1gydGk3S3Z6QWNyRmEy?=
 =?utf-8?B?aVVrdE9VRFNtQWNzT0VLbUNJRWwrV1lEVlk2eG1kdkVDSDYwNHBtMXRJMU5Z?=
 =?utf-8?B?VkNHVUd2SHl0M3R6ZDlWSG9jOWtSTjUyemtVNURqdlRmVy9CU3JRWlk4M2Fk?=
 =?utf-8?B?ZUFJRVN5RmpDQ0NHVzBTaTJYSTZVeDkvUElmdFpoSEN1azBSRUZ2c0dNM0Rk?=
 =?utf-8?B?SytDRzNKdXR6ajJtNWJoSzhiUFk0VXZLVEYrVmxtdmdyRFN4YTEwcmluQkI0?=
 =?utf-8?B?Ty95YTVPZ1hDVnBYTmpvVFNQRGtudG1UZFcrN3JpUTZTTDJmTVdoaGp6S2VH?=
 =?utf-8?B?UU9jRHBKMDhGRmE1WmxRWWtKZmJETHl5UjZSa080dWxTRHVKUXdXTEozMkVE?=
 =?utf-8?B?SXYvbENkWTI0bFRCUVdvVnFnaVRzdlNVOHlwbW9qNTdyUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUxBbzArUmRvMi80QldkTEJtUCtyYzhuUHNZYkJwdVJ6N1dqUFBBN001ZVF6?=
 =?utf-8?B?bElkNFY4ekgyRWw3MG81aFNLK25lMmxOd0laYW1KSEhFYmNMek1uUmFRQ0Qv?=
 =?utf-8?B?QkJFZ3JEYjd4VkErNFJFc0JRQkxGdTZYL3R6OUZBdWJsejNNU3dVbUJYWGpK?=
 =?utf-8?B?UUgzRUZXeURWbDAzUDdtM09yNUwzaXhIam5XQ0lySlRaMXhpbVdrRVR5WXZP?=
 =?utf-8?B?MW1KdStqTGhhSGZHRW9SR29rZDZjSkVHMVFrSCtWYnY3YnhYa1VweTJVL2dH?=
 =?utf-8?B?cGhiZThyVnlnN2Y1SmFxR3g2eEwwZklpRVd2QlRodnEySmsyQ2RhZmlaYm1X?=
 =?utf-8?B?b3JlbmRCMXFEb3l5Mm8ySlNUZHc0b1l6YTVkcGxTNXNSSnREaEJwVlVUazcz?=
 =?utf-8?B?d2NGOEY1NXlSTWRKL3JsYUhCL1Z3NHpOdi9IWlpEdWtzeHJyYWl3aExrZTVS?=
 =?utf-8?B?TmN5OE1JenBaWWYwblhtUmFyVklLRGxRYXpveVBUSnlucnk2MUo0emR1ZjRt?=
 =?utf-8?B?MTVlWnh3ZFVqZ1g2Y0IzWFI2eHBNam5Kc296NnpwK2xjSCswdjEwc2hNVWE5?=
 =?utf-8?B?UVJSQXcxdDI3OWRFYmY1MHFNRi9TclJyNWtkVHRTaWcyb05RNkpxWFEwdDVD?=
 =?utf-8?B?QUpEN3Fva2lDd21lZ09OZ25zTU5KRHh3dE4vWlQ2MFVxbzZuWndiVzFtL3JC?=
 =?utf-8?B?UEZsYWNidkl4NG1yTDRoM2FKMWFkTWR2NHU2K2wwR3Jlc2tKQ1JTVlhZeEFW?=
 =?utf-8?B?dkJPWUsrKzZrd1BwZGtwSnBOUWNqTzlMbGkwL2IwRXFjVnVoUVpVREdWVitR?=
 =?utf-8?B?dzdjM2lHczRIK3Z6M3Y0aGNNVGVkMU1jYllXS2p4SjhrNnhvbHgxd0hraS8v?=
 =?utf-8?B?ZXBZSFQyTHA3ZmkvMVFPLzV3d2ZqQUJoamcydUp4L3ZKMFhrMFNKYmgrb2Rq?=
 =?utf-8?B?OGVDRUlzRFBJS0FKemZPS0ZOaWhML0tUemYrTTZiTlBscEJYUThKT2UrcEpG?=
 =?utf-8?B?eC9mTVlTVVp2cTVIOUs0Z2w3UXUvQll5U0Z2QVN1ekg0WkNhR0ozRVZ2WU5W?=
 =?utf-8?B?RE12QnFHWTFQZW9ROGl3OEhtMG1kZTcrTGVqVjlnYmxMaE1hVCtRQVJhaVV1?=
 =?utf-8?B?cENwWnpERXdMTVhwc1Y2R1BnQmxGQnJLSFRobTNUNFdTN2xMWDM4bU84U3d2?=
 =?utf-8?B?cW44MjRSbkxMMjltNGNIeGQ5cUw2SGF1T1RNZzc2YXVRbEt2Rm1yR3RrQXhq?=
 =?utf-8?B?eXBhNXhsZXpwa2IyeUZqcmJZblZsMVN0VVQvYzRJaEZLNUFFck1PVUxhRGJK?=
 =?utf-8?B?TVlyQzdDMVYwbzR4bHY4U3RFWlZuRi9TZzlDdThqL0pGb0RSMFNoSGtUbWdK?=
 =?utf-8?B?ZU1vSndleCtuNjdwZzQ0Q0tqTVFIaGNPdUQvYnZXN0JJUG1BR2xrVEphNElp?=
 =?utf-8?B?U3IrWklWNGlyVU1NUzZVUnFLTDhrWlNMQ0RUZzNtZlFrQ2cyMWlyaURwdVNy?=
 =?utf-8?B?MS9MSDRKWEFaMlJubnVOWG1JaUxUZWFrQ2lLaWx5cXNFR2FjM0JBZEVBZEtz?=
 =?utf-8?B?WkhwZzJDVlJHZjJRdUx3ZUk1MVYvcStEUGtXWXNERWt1c215dDlhdVRtYWkw?=
 =?utf-8?B?V2hOdVQzQ2FvMUdUVnNHRVJoNTVxR0ZyalVzRDc4QStJQTJoNk1VUFBHZEhV?=
 =?utf-8?B?dnpxN1FJMmtYbTE0RkptcDJlMEJqcXl6WmNPby9Tb1dKaHMxb0llSUhZaUF2?=
 =?utf-8?B?cVFLSVYwUUtYb3ROQU5EVlhaN1VZblJqcHZMZHpGLzc2ODhlODNCb3ZmUnow?=
 =?utf-8?B?SHZHK2V5VzNweGFSM3hlc2Fvb3EwbEZXa3JZWTFXU1p0YU4vWG1nNlhuU2VD?=
 =?utf-8?B?TWhURlZ0bDdXeFZOV01kcHpMQzZoRGdBQ1VGK2kvTE1nTSt0TFYrQlhhUHk5?=
 =?utf-8?B?bFJsaHorUDErblo0NkdRVjJCL1ZFNHZWL3N5YjJBSnVhZzBldHY1NTRrOGVj?=
 =?utf-8?B?NFhaM09ZaHNNS3Eyc2ZzQytreHVVM0wzamJ1dkRMUEtVSkFGeTNjU3hnTlBw?=
 =?utf-8?B?bHl3TWRUTjhQdFk5WEdhMHEzMDlXUEZZRXBDTGlvRTRMdjRzdUdmcTBzNTdv?=
 =?utf-8?B?aEtsV3VqSC9oem5lRTVHVjJjU0JqLzZSOUdCd2NvSkVLditpYnlPa3BjeWVw?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae59a2e0-a5c5-4f34-3da4-08de3ef020e5
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 11:16:59.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqrNcla+ZCRd1tMa9GWH1L+kQeXo05lxEobat7WU47IArupL7CsRyzt31Tsx3pnDf2YBJo+xQdwK8GMls7IN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7564


On 18/12/2025 15:49, Nuno Sá wrote:
> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
>> Not all users can or want to use the device with an iio-backend.
>> For these users, let the driver work in standalone mode, not coupled
>> to the backend or the services it provides.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
>>  drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++------------
>>  1 file changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index 60fc3361b2689a4c38287c613ef93fe00338e5fa..37b8f88da6681d44f3fbbb6c8c171ae7117b9090 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -1000,6 +1000,9 @@ static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
>>  	unsigned int c;
>>  	int ret;
>>  
>> +	if (!st->back)
>> +		return -EOPNOTSUPP;
>> +
> 
> Let's not add the buffering interface if we can't control it.
> Having it just to return error does not make sense to me. This means yet another info:
> 
> https://elixir.bootlin.com/linux/v6.18.1/source/drivers/iio/adc/ad9467.c#L916
> 

I agree, not having the scan_mode at all would be more clean.
But adding those different iio_info structs comes across as a bit messy.
Would it make sense to create that iio_info dynamically in the probe and
fill out the callbacks that are supported for the configuration we
encounter? I could try out something like that and see how it would look
like in practice.

Thanks,
Tomas

> Also the channel definition should not have the scan index. But, given that the IIO device
> won't have any buffer I think there's no way to reach ad9467_update_scan_mode() (unless I'm
> missing something).
> 
> Still, while I understand that updating the channels to not include the scan_index is very
> cumbersome, having a new iio_info with no .update_scan_mode() is trivial and make things
> more clear and explicit.
> 
> - Nuno Sá
> 



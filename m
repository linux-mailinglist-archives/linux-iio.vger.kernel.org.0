Return-Path: <linux-iio+bounces-27043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D903DCB84D7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F876300B926
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A430FC22;
	Fri, 12 Dec 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="W5B1k1Ln"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023132.outbound.protection.outlook.com [40.107.162.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54C4A01;
	Fri, 12 Dec 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528824; cv=fail; b=hIin5kA9N8/3VHmYnHfBqa8enGU4IhHH8I3+Qk/SriL3uRxaRBKDwJ59BcDJKRCjK3X0kPXZ3gGEhCUkPmxTd8D4Ct3FycJZjI7+86AYYymtlpN/ARIzNB/wfxQE+5SpzMSEz1hDBOwSVspfdaBNnMZKxWZbdE4K0KAhGi04ge4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528824; c=relaxed/simple;
	bh=YHNcXmMux7hsUnTPWaHJOznEKoiisF4ZJCiePO3Io5M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njRS83r9VtQkCdhgK9tpNJyfUPV4ZT0blsaiAtBB4W82tco3zBBRnPEk4jyAXdNihGqMgWe+Q/jvqzi+uL/GFYipze1pCeNSGbQl0PiMWKLiy2jkfygNJYaazTbmrNaqVmkHNE4+9yTLQ9SGGHb6ga4BhravE8c2I3xxZ+XT3D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=W5B1k1Ln; arc=fail smtp.client-ip=40.107.162.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7kgPELBf8TJtkQwCwK7397kuDOh0BJVQrBLYopTUtBsMBvMb1mI7VHHCFEdYV4Le99dIGcKZjlinzo4xVaWsFYSuaC1rDPeYEuw+re+F+bUwGmmq79zkQctzpT8rTI/IEygjg1IYyfWU/6ksoV2LUqznCvxrDHjkvhYFWtDnfHr0Je0molrPk0DUHF3eyjtoWcsQtVH3uZK2ZLXp2JwL/a9POUPqOej0nKXZoh4y3GAliNL/d7RZW8btZyfhLUCPcTK5Tr6KtMA80Cs/PJl3hsE2nVcOk3ilGc9BCsXpALvSKmchY1WPPS7TNPUNjm+Ja8fTHk6mvbgewokMzCY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhzExKsa/lgeaNpEibb5qp15tC4AOT1bkuA3DkX98vY=;
 b=XtcC+o9Vz0quN8i/5nik6nK6jnOUYAa1meCkoHh1BrDUnK3nV4f9N0ymvwLS4Arl5j5FONSj6LsnJiupdBTVPnd+cMbKKoNZMjZESDBcNvSFp6rwLjBOO+Yk7X5qFviguRgis+W9glOAcoWDkpPSuwaNStbd+7Y9P9qwmU8ihTXGK2G0KpE7ZGcSw/0Cm7rzKGhHqLq7aTmKkTUoAsHBPcnwtSq/7oizlpOCzQEw0Rfn2Y5goIs43KtpQne9JFDZlHJFL2nAFTWZ4cEgKumtON9ouJTvPWEPNEEVeaoZfjYU3KwKNKo9anURLRi3d2R0hCMLl0VtuTsdbOLRsf64gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhzExKsa/lgeaNpEibb5qp15tC4AOT1bkuA3DkX98vY=;
 b=W5B1k1LnPe8eN3lXS2JrdlYEEmMJL6erVdtRwazkiCI3p3toRuc/voU+UbccwV/DZsaGHIAxBXEnpDCBuabcjSvFSofoicGcVCgFC6bfdKKlydgVeTLhN86EwqaijvsaZvRrirKKJT8k+MpcJIlgxKkOCvftAlid52vaRkLxgAjJrxiUvQNIJ9E6nYaMdqqC46hq7uww9/ae4Tm61lvXIDshMZicKR/RyYPdbk8fqp5UfrBV3RD05ebIYYdoy1R3g+9k0VVjKWja/KjKmiLPJHHRVN38QNARWci7Acu6CsqVSLwkt8xQ868E6Nxtzx1WRiOYxvh44Rq6x5EyHoVOSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA4PR06MB7215.eurprd06.prod.outlook.com (2603:10a6:102:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 08:40:12 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:40:12 +0000
Message-ID: <8568e452-15a5-4a94-aa2a-b7525888799b@vaisala.com>
Date: Fri, 12 Dec 2025 10:40:09 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
Content-Language: en-US
In-Reply-To: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV2PEPF00003837.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:20) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA4PR06MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 616b69eb-c673-41d1-bebb-08de395a10aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXR1MFcrZ2UwTTFRME5rN3dGVGdqcE5jR2NzWlVaTGdHekxydkpVMVJtOVg3?=
 =?utf-8?B?SkhVY045ZVBMTjFEcVY4a2dIbGlFOUVSK2laMEVsSTJlNjhHMThqZklHNmFG?=
 =?utf-8?B?NXZiZlpRZ2ViMFJpMGZRZ0N6YytLaC8xVTZmRFR5VW1ENUc4TmNEMUlEZGNz?=
 =?utf-8?B?Vk84Mmg0Z1NkL2JRVE92SDBSdU9VVFRPcW50WHh4d2UzdGVEa1RlNXh5a0lO?=
 =?utf-8?B?WVNGcmN6Mkp6dEdjOXJDNDdSR1hCMzNUYTRrZ2VrS1hXMkxRMDdCb3FLczBB?=
 =?utf-8?B?ckdUSi9udE1oMktaYjJmai9jSlM3U2JwdE5LcEN0SFF4UzFZdVdVcGlHaTA3?=
 =?utf-8?B?Si9vRFE1QnJhRkZ2Mzl1ZzRuMVZZTmpMQ0JMTWN5L056UmRITlVoTlcxa2tu?=
 =?utf-8?B?QXBuS0I2VTZaR3dBd2xYOFRQbDM5clpsUU1DYXYwNll5M0hhVHRKaDFqUklz?=
 =?utf-8?B?eDgxWUtXbTc2WWNNNjZiSEcyYk5LOGx3aW53dlM5cTBielRDU2NGUWFTa1dp?=
 =?utf-8?B?VWh2SnFydUpKZ21Da2Y1UkwvUXBwSDNycjV2aGhmSjVROXV6cTJJdUlBdld1?=
 =?utf-8?B?OFd4NGJpRXNTVnU5RDVId05iOWZ1WFVOaWx0dFlCdWFKU2N4SzMyUW1qMXk4?=
 =?utf-8?B?SmI2ZExsYms5OXlqUDdFTit6a2RzUXdmNkpXaHBPbEVyWUlnaHd2LzRYZkpC?=
 =?utf-8?B?L2Q1cWI5U2pvNWtkVXVHYVJxRHRwZDBJc281ekcvTkFBQ1BLZXFWTXh3QUx0?=
 =?utf-8?B?UVZjc3BYeW51Mkt5UnhuNnNBUWR6eHl6QnlKWVdmYnBJQXVYcFlXTWluaHpW?=
 =?utf-8?B?ckYveWZLQWh5NUNJM2MvQWF4ekdUemZxekR4NkhmeDJYOFBZaFVWZE5zNXk0?=
 =?utf-8?B?Wlp5T2ROTWdtcEswK0NCakF4Mmt4M1pEU08xalRvajdMS0VuSjY4QlBlU3Ez?=
 =?utf-8?B?UTNLeDV6Mzlxem9qVklnelh4MVp6dnc1RjFpNlEyM3ArdFdCSUdpbjRVT2tp?=
 =?utf-8?B?b1A2cUhQb05Bd0FHT29LQ3FyUDNpQkRyWEhsLzUwN0Q2bUhaQ0ZrSys3Mnhn?=
 =?utf-8?B?ZWNDOFk0SkVtOGpFOUdoTTBoZWJ2ak4zMTVTRmFDZUpNZHh6R0lzOEY5QnpJ?=
 =?utf-8?B?b2cyN1QvbS9hVWdpTjJtU3c1QVRaR3lxYXlqRWhBR3R1MFd1U1VvODFNY05t?=
 =?utf-8?B?N2pSWk52OGJSREdiaVpHYjEzOFpWd010MU5BaVZ4NVlzaEEyaEdJN2JGNnJ1?=
 =?utf-8?B?dC95WTlWUVExWkdjWUR6UHhtM3pmOHFoUTlQeHN4SXhnTDlGdXBya0pHTHpv?=
 =?utf-8?B?NjRuT2V2cWhSd1RBZFc2OWt5b29IY2UwQUVmYjlkYkFuRnpOd1oyNktZNzQw?=
 =?utf-8?B?RzRja2FCdVpNUGdFd3gzT1NMZFc5M1RuYXcrNjkwc09aQjJJU3ZCTmxzSmdQ?=
 =?utf-8?B?VUNMZW1RbmJkYjhCVUt5bHlaK3VqTjVTYjlyaEZ5Vk1ZRHA3S2hEaWpvRWlM?=
 =?utf-8?B?azVINGtLUVFrZHpTVVRmdlVSSG5zN0FsZldXb0Q3NHh6bEgyVTNUc2FCY2Jy?=
 =?utf-8?B?UmdoUFBGOGdsNCs3am9MZVNpQWpUdW9ZUjVpZFhMUU9qOFdlbmlrZ2pYZEJU?=
 =?utf-8?B?TXI2eWFGMlN6OVk4WnNsNXpIbEN3SHhlbE9uN3o2ci9rQjBVeXpkWnVSeGRa?=
 =?utf-8?B?ZFhhaWN2WFpOZ1RZN0FnRkFTTGlXa1o2VlpkT1FDRTA2VnNtM2xMNVlZbDZI?=
 =?utf-8?B?VjFTZ1Qzdjdid0plU2pMQytpV2xpQzM3ZDhrd0lnTnlDdmJxc2psaU5Wd3BK?=
 =?utf-8?B?bzY2dFFVRkxYUGFMRGJlL3VGOU9uRHY3Mk9RUUVVUjAwNDJTeUZYV3pDOGRI?=
 =?utf-8?B?bDh6cDEveSs3U3dIWmM0OHhpL3NxMWtWKzlWY0xINTA1bmRlSXFMVXJoOVdp?=
 =?utf-8?Q?OCjvCIxMQ9uS76uHCBiMJrM/LU2V2yZC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExhZ2NFdnpGWVhFeWFUQmhtczc5eVUyZ21IV204OGEvWnBQQUp4OU1hZkxP?=
 =?utf-8?B?MGR4Rk5PbTZFVHNlc2JyaDV6UVlNdjVCOGZqOGFVY1ordFVHY0xrY2JJL3N5?=
 =?utf-8?B?bnoxbHptTVlBV1hMZ0RWRlc3RmZEeHpINFVKWUJOWC8zWXpaWXB3RWtOR0Mr?=
 =?utf-8?B?aE5UV2swZ0NMTkNoMW9PWHk3Z0JFWnV3THdub2UvY3RjUkhyaXRQQ1dwRVla?=
 =?utf-8?B?ME1VOHVYTmJoWjdNdE9CZjNkamYrWXM1UGdGaGw5UXZ1QUl0bjgwL3J0Mys5?=
 =?utf-8?B?RTJrRVVMQVcwQ2c3MlJzU1V4ZDVkMnFUb2h2eGcwTDNqYStJZk1FcVBEVGZ2?=
 =?utf-8?B?VytqeWJpR0VUekZKY1ZXbGNMKy9nZGN5eGFPbnlPREIwMEZXSlYweGIrZDJ5?=
 =?utf-8?B?SUZWMWJRSmhCRWNUQXJreXFCMlRBTStydEZrdkhvNGNqYjc3N3NYUTBsSGc0?=
 =?utf-8?B?TExzMTJub3dwUVBtK1RFVCtXNEFvUHMzRTJ5WU5ISVVoaUFVTFV2aUZrK2F3?=
 =?utf-8?B?UWppTXlENFM1bU8xTERjNG9MY0lBRkZiMHh6aTdad1I1dVF2VzVvMHBMeXZ3?=
 =?utf-8?B?eTNoWUl4eG1Vdmc2d1lFa2dVT1JXODByaUY0UUIvbm5WOEhKNGxIZkU2dkIz?=
 =?utf-8?B?TnJwV1I1K0Z5Q0xpTmxESUJaY01oNE9ER1lUTk9IYXdlNXZuSkYvTW9zamVp?=
 =?utf-8?B?aGZoeXNxNlFubzZkNGwxaTdIUEVqQjA5STUzN0NJUzlNQXlzaHp5SXBGK0o1?=
 =?utf-8?B?UjhiYUlMV0YzMUp5YmNvSlV6MjVnc093ajgxbmFhRHJwYW5FeGFWb1Q4ZUpi?=
 =?utf-8?B?UTQ1d3RmTWUvYXNkMXB2R3Bzb3hkaTlJVmcxNTg3TFVTQStrZjlJWk9FU21Q?=
 =?utf-8?B?STlZOHpsKzc0c3JUcE42dWIyRnUzbzdFblF4bHpwUWZRdVNId3NEQ3ZaNGJM?=
 =?utf-8?B?K01INXowbko2aE5yL0sxRHV3ZWs1MTVGd2tENXd6d2ZoZXlzeDdwWGViMER5?=
 =?utf-8?B?SEZlc0pYNE1SYUQzbStpUUkwTE1VWGxya0RyQlY0WXVIZi9yZUNGN3o4R1JB?=
 =?utf-8?B?aFZzOTR0dnZsQ3NzVStYeVlmcXdRZkxBbWRFbUlSYzg0NDJmbTZUYVFXRE5Y?=
 =?utf-8?B?SEt4OFUwN2tJdHpScnd6Z3F0NnRkNWdZUmo2SmVCcGNRMWxKZDhvaUpwWmY5?=
 =?utf-8?B?end1SzQrZjhxL3NaNHhMY1YyRjlUUUR3d2FCR0dnSzNBK1F0RjB1aGtvaERp?=
 =?utf-8?B?cVVVR0ZPLzU1SjdiQWwwYUkwZlhMbEh1K0xJcXJYMWo0WWtORDgvZzZkNFFn?=
 =?utf-8?B?OWJ2a2FJRFQ0RFRqdUFDb0RpNjJKczY4Ri9LbHBKM0VjN3JydldBVitOQWhV?=
 =?utf-8?B?V0RGdFZhYnhybjg5Z3hZRnQ1M0Jzc3lKZjJQTGdiVk91QW5WVjdsSlNwa0hP?=
 =?utf-8?B?UzhPdDJpQ3NQTTlGVU9zaks0aXcxQUoxOE9YZ1N5Tm9GeTllT0d0SGxBOHU3?=
 =?utf-8?B?N3owQ2Z5QmdBZjdxN1NuRVdHckRyMXB0S3Q0VFEzS0VSWlZNZ2FiRndPdlB4?=
 =?utf-8?B?Uy9aRWgrdkt0ZWwvcmNHZk9Xc2UvMlBPamkzbjNWdE4xcXdDazM0SFQ4Z0k5?=
 =?utf-8?B?K2RUdUxqZ3RRZm0ydm9lc3UybUc1bzhaZjhrTlgyektNN0owTFplT3lJVnRM?=
 =?utf-8?B?MEpTWWlZenc3RmpXeG9QMUJ1dWxBVEh5azhkR0hib0JjRTJiTk5LTWRvN2k2?=
 =?utf-8?B?NUZDUk9kbGpxM3VOTHhUc09jNFRCeDVURlVDT0VJT05jbmRtM1J2S0JjN1BE?=
 =?utf-8?B?ZGgxSTVYNnl5YXhuYUs4OWtoRWNKeGNZd1BJaElxYTFBa21LbkQvZjA5VHVw?=
 =?utf-8?B?Q0doenNXNzBPV0txa1orejdZa3ZORWpJSkdhL2twNENxSHh1VHhITG5WUXpv?=
 =?utf-8?B?Y2dKc3ZRZTc5SEk5bHZZTjkzbGdNR1plWEI4ZVU1aDdpU2U5SFEydzFuNzN3?=
 =?utf-8?B?VHh1bG1rY0tJbEljZ2w2bUV2MTJkbjNhZERZL3g2ZWF3eEw1Yk5wSm15UFhq?=
 =?utf-8?B?RWpvODBkT21aS01YOG53bEtUT2dNSkd2S25Gc01wcmRDY0k3MUhSOFZmVytG?=
 =?utf-8?B?UUtBeXl1anppd29URnBxa1lUUmxlVDl0VG5pejdscDZON0RIYUFMM0VGejZ6?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616b69eb-c673-41d1-bebb-08de395a10aa
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:40:12.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7lrDJqF0hshBMsXaHMhcAS+hvflDeeCA34ARkwZUY17E7Gx7l0uQamLzYFykc57fCNgpHWF/ZGZrAnnH0Fspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7215

Hi,

Sorry for coming in late in the cycle, can you please explain why the
driver for ADS1015 could not be extended to support also ADS1x18
devices? Briefly looking into the topic, they seem to be very closely
related.

Have You looked into that alternative?

Thanks,
Tomas



On 12/12/2025 06:25, Kurt Borja wrote:
> Hi,
> 
> This series adds a new driver for TI ADS1X18 SPI devices.
> 
> This is my first time contributing to the IIO subsystem and making
> dt-bindings documentation, so (don't) go easy on me :p.
> 
> As explained in Patch 2 changelog, the DRDY interrupt line is shared
> with the MOSI pin. This awkward quirk is also found on some Analog
> Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
> inspired by those.
> 
> Thank you in advance for your reviews.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v2:
>   - [Patch 1]:
>     - Move MAINTAINERS change here
>     - Use generic node names: ads1118@0 -> adc@0
>     - Rename file to ti,ads1118.yaml -> ti,ads1018.yaml
>     - Drop ti,gain and ti,datarate
>     - Add spi-cpha and spi-max-frecuency properties as they are fixed in
>       all models
>     - Add vdd-supply
>     - Make interrupts and drdy-gpios optional properties
> 
>   - [Patch 2]:
>     - Update probe based on dt-bindings changes
>     - Rename file to ti-ads1x18.c -> ti-ads1018.c
>     - Rework ads1018_oneshot(), instead of waiting for IRQ wait an
>       appropriate delay before reading again
>     - Only alloc and register a trigger if we have an IRQ line
>     - Drop ads1x18->msg_lock in favor of IIO API locks
>     - Read conver before enabling and after disabling IRQ to ensure CS
>       state is correct
>     - Add ads1018_read_locked() which takes an additional argument
>       `hold_cs` to explicitly control CS state in trigger and buffer
>     - Fix ADS1X18_CHANNELS_MAX limit 9 -> 10
>     - Call iio_trigger_notify_done() in all IRQ handler paths
>     - Drop unused includes
>     - Drop BIT_U16 and GENMASK_U16 macros
>     - Drop unnecessary named defines
>     - Use u8 types in ads1018_chan_data
>     - Rename some struct members for clarity
>     - Move tx_buf and rx_buf to the end of struct ads1018
>     - Rework channel handling to just make everything visible and add
>       ADS1018_VOLT_DIFF_CHAN
>     - Use .scan_index instead of .address in IIO channels
>     
>   - v1: https://lore.kernel.org/r/20251121-ads1x18-v1-0-86db080fc9a4@gmail.com
> 
> ---
> v3:
>   - [Patch 1]:
>     - Use unevaluatedProperties: false
>     - Drop #address-cells and #size-cells
> 
>   - [Patch 2]:
>     - Add kernel-doc to internal API
>     - Drop bits.h and bitops.h includes
>     - Add types.h include
>     - Use unsigned type for data_rate_mode_to_hz
>     - Rename __ads1018_read_raw() -> ads1018_read_raw_unlocked()
>     - Rename __ads1018_write_raw() -> ads1018_write_raw_unlocked()
>     - Rename ads1018_read_locked -> ads1018_read_unlocked() for
>       consistency
>     - Let ads1018_read_unlocked() take NULL cnv pointers
>     - Add ads1018_set_trigger_{enable,disable}()
>     - Refactor ads1018_write_raw_unlocked() loop matching
>     - Invert ads1018_trigger_handler() logic to follow traditional error
>       handling pattern
>     - Refactor ads1018_trigger_setup() cleaner
>     - Make ADS1018_FSR_TO_SCALE() calculation be 32-bit compatible
>     - Some additionall minor cleanups
> 
>   - Link to v2: https://lore.kernel.org/r/20251127-ads1x18-v2-0-2ebfd780b633@gmail.com
> 
> ---
> v4:
>   - [Patch 2]:
>     - Replaced <linux/byteorder/generic.h> -> <asm/byteorder.h>
>     - Dropped ADS1018_CFG_DEFAULT
>     - Fixed long lines
>     - Added Andy's remark on ADS1018_FSR_TO_SCALE() kernel-doc
>       description.
>     - Fixed wrong argument on iio_trigger_notify_done():
>       ads1018->indio_trig -> indio_dev->trig
>     - Renamed argument in channel macros _addr -> _index
>     - Changed return type of ads1018_calc_delay() to u32
>     - Mention @cnv is optional in ads1018_read_unlocked()
>     - Use 16-bit transmission cycle in ads1018_oneshot()
>     - Dropped spi_set_drvdata()
>     - Use full resolution in ADS1018_FSR_TO_SCALE() and subtract 1
>       inside macro
>     - Rename ads1018_read_locked() -> ads1018_spi_read_exclusive() for
>       clarity
>     - Minor style changes
> 
>   - Link to v3: https://lore.kernel.org/r/20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com
> 
> ---
> v5:
>   - [Patch 2]:
>     - Fix ADS1018_FSR_TO_SCALE() long description
>     - In ADS1018_FSR_TO_SCALE() subtract 6 from BIT() argument instead
>       of shifting the value
> 
>   - Link to v4: https://lore.kernel.org/r/20251202-ads1x18-v4-0-8c3580bc273f@gmail.com
> 
> ---
> v6:
>   - [Patch 2]:
>     - Actually make the changes described above. Sorry for the noise :(.
> 
>   - Link to v5: https://lore.kernel.org/r/20251204-ads1x18-v5-0-b6243de766d1@gmail.com
> 
> ---
> v7:
>   - [Patch 1]:
>     - Reword description slightly
> 
>   - [Patch 2]:
>     - In struct ads1018_chip_info, make pga_mode_to_gain an array
>     - Drop ads1018_{get,set}_{data_rate,pga}_mode() helpers
>     - Drop context remark in ads1018_calc_delay
>     - Prepare device configuration in ads1018_single_shot()
>     - Let ads1018_calc_delay() take sampling frequency as an argument
>     - Drop *_unlocked() methods in favor of *_direct_mode()
> 
>   - Link to v6: https://lore.kernel.org/r/20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com
> 
> ---
> v8:
>   - [Patch 2]:
>     - Fix commit message (These -> This)
>     - Multiply temp scale by 1000 to comply with ABI, which specifies
>       final temp calculation is in millidegrees celsius
>     - Drop ADS1018_FSR_TO_SCALE() because ABI specifies the final
>       voltage calculation in millivolts, and the macro would overflow
>       32-bit values while calculating, even after shifting 3 more times
>       :(
>     - Add comment about gain calculation in struct iio_chip_info
>     - Manually list voltage gain in iio_chip_info
>     - Use HZ_PER_MHZ instead of MICROHZ_PER_HZ in ads1018_calc_delay()
> 
>   - Link to v7: https://lore.kernel.org/r/20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com
> 
> ---
> Kurt Borja (2):
>       dt-bindings: iio: adc: Add TI ADS1018/ADS1118
>       iio: adc: Add ti-ads1018 driver
> 
>  .../devicetree/bindings/iio/adc/ti,ads1018.yaml    |  82 +++
>  MAINTAINERS                                        |   7 +
>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-ads1018.c                       | 746 +++++++++++++++++++++
>  5 files changed, 848 insertions(+)
> ---
> base-commit: daea3a394a8b425a2dd206ab09eb37f0d1087d35
> change-id: 20251012-ads1x18-0d0779d06690
> 



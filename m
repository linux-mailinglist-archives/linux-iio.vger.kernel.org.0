Return-Path: <linux-iio+bounces-27786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021BD1FC54
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1866F30AB2F4
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808D396D06;
	Wed, 14 Jan 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="UHkss08B"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021127.outbound.protection.outlook.com [40.107.130.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D58255F28;
	Wed, 14 Jan 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404278; cv=fail; b=XKWHJPQ69yt5q1hTmTDQHWXC2Wc04MYj1zlfvpZgT6XieRiAKwhtYVG02K64st2RGnskoPMX22a96Wgd7moZVFvrc67dgJsOxhzI0613OPO9TXUFSIA/pA2R01UkTeAv7VqWGijbEcR8wOMhhi0qu+X7isgMPG48PRSgSkBw7GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404278; c=relaxed/simple;
	bh=jGfYHob5rpImv6H6vkkHozvcLrpUEWFeoK1d3cz3ODI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyyrIFkJlE31akVc7ZQji7syMWLr5jAghDmFexc3UXEqpcKPcwJZ1pvddFI46TVGfHHTjJZN1zyjUJul4nFgUjkeo8pEXr9MxDlm6oi2ZSnrAa51n0FCvMikvcFv1xvnFsjuxgtOLhNufqTv+FuhW81bMey3HRVHmw6vuqZdCYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=UHkss08B; arc=fail smtp.client-ip=40.107.130.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH5H4vs3j2UBv8FKFmdUkDOPtJIEUHsCNG9JEy4b9Qbanu1BqSpojckjq2LG0a/+5TJaGhvEUmAkzQCCvzPdx9dDxJoQV5rCVXTgX9FCrZ23ncA0KhC0kUaCgUjsB1eyAImTwsFc5Bl5LGiHEBIWTG2EsusTh2juTkSiweW1utxbiLVjdy79ZtwnadcOKnyBH8fdZxWjAO077ZyTj59uivH3iQ6dwmwCpYu+QC5PqsBFmOlN1dzvVN8AI+RqwZGK9Knwt5a2J0kDpbdMXU2aOQY9gMwcoi9fnXqSon92sWOr7MrkDacUGWc+9SfbN1HwfdLLxDiyqAUlYMsxsc0jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qFmDt/PpSUTHK/lRyOFzcgsmZuth3pG6Gm6EjY0MfU=;
 b=pVDmdh9b+SP45H3GjStdoQmTtwE85xHay3cnTGVW06evLyff8Ozk7wdn400fcriIWlyF5Zgsn016w/MXFErhXNmP7ljPXGwdPEUjRo0//mDnlV0E8BGhZpeFNX+DrOGgMIy9ssdJ/9tcnP358XvwNN5d9rJAdVOZwASvQlfyW4wn0DaAWnNocQkGlZ84q8KTSUyujS1fFpJXcZ9HRwBff4RFrKJwpL/xamISK9EhRX9fR/Ius/EEL2d+qSgkIZvsppCXEnLNzMzYsmaAUJYnHvtLlbzhHw7ZO5zIdvXAFKxhsaZ8fvQ8Vmu7LchWpZND+6q+ejwjKFcQLOAWPAvCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qFmDt/PpSUTHK/lRyOFzcgsmZuth3pG6Gm6EjY0MfU=;
 b=UHkss08BQh445wwbOKfHDCBvyLz9rsG0PP8oPzrLUv3ZQgqdEexI9lGHPfTAW2j+n/vfuRmAufR4aO4E7q6Xr0j5BUmxGE0hi1lYHrl+pRFaWCvPKyZ2cU3rm7TxbUezqIq+NKwiSJIINw3P0ozJP7LTDcRckkOoBoe0ccJr83comLUMQ8TT3LbieV0S48ElAtexkz+U+NI5bvMOSL+MYgKJGhhjXsRAH7luSQUi7n2iKn2aDdYFrbc1G4fgkA7eAzCB14+voBqsgvdhoTX0Ur1U93xpMb9C7k3Va3D1LCTKhmyDL9enyyTcpyq8lUqR4AYHktjuHsL2mvwNrU6Ylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10381.eurprd06.prod.outlook.com (2603:10a6:10:61a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 15:24:26 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:24:26 +0000
Message-ID: <4b84e4ec-7d42-4a77-b521-cb41a8623a24@vaisala.com>
Date: Wed, 14 Jan 2026 17:24:23 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
 <20260114124527.00000344@huawei.com>
Content-Language: en-US
In-Reply-To: <20260114124527.00000344@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: a35be8da-f381-48fb-0bcb-08de538100c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2VNSkMxUGsrZlRNRElidm05NHh5eVJITmNnL2pobkRHbVJjVmdFdlBhdXdq?=
 =?utf-8?B?ZW82NG42QWpsa1hSTDRobkJvODYrL3hjYlN5Z3RDOHBFbUl6VjFhYjFENE4y?=
 =?utf-8?B?ZjYrOFQzUnlmdHh6dVEwQVljaHVGZFBRTS91QStXYlE0RnZoVmI1cTd3MHVJ?=
 =?utf-8?B?MU1WZ1J2enUrRFRHTzFPalVhU21wcmVRS3JnWEpyUWNVeGRPVFl3dWdscEwr?=
 =?utf-8?B?TS9sTjl6R3hVSFA3UVcxVWYvSWJBZVE2cmFVdDlHNk41aUhqbmljN01tWkc2?=
 =?utf-8?B?Ylowakxuc29hZ24rQVBiTU9kM0l3VzdsSFBYandUUyt6TUZIUTdsUHhFS1Nw?=
 =?utf-8?B?NmlMbTZJb0NacENGcExzQ3F4azNCSXN0SmMrYnZldTlCODAvNDMrOXo2akxB?=
 =?utf-8?B?NkVGZW1uU25vbFNIU05OeldUVWUybmFIM1BBeklPeUswZGF0UlMzZWg5NlZM?=
 =?utf-8?B?VHdrVWhIaXc3NjJVajNQTEVhVDZhWHhxOEtRR2hLcHhLcnB5Y0ZMR3hvSjhj?=
 =?utf-8?B?MzZjbUJlMDBXRXU5d3hEVVpwTWhtUXJKSll5Mm9NTDNucUZlVUZKUTVXL0dD?=
 =?utf-8?B?Yno2TnRudUZsQkR2RW5xcThFVUF3RDNUclVXQVlBd2p5dy9FeGhKUUZDa0xY?=
 =?utf-8?B?ZTNTOVcrWjExM09mSEh5MVMwaW1CZWtHdEdkbTdqTUR2WVg0TmtKTTAvNWhN?=
 =?utf-8?B?RVFocXdzRm1vMDdEblprQWdLNmx2eWpIaWVzTXI5QjZsakZDY0Y4R21xbmpk?=
 =?utf-8?B?ZkdzemdCeE1scEExSGpta2Y3aHZoWk5MYUdET2M3Y1d2Z2l4VmVWZW1vK3NS?=
 =?utf-8?B?blhENDRMSGRSNVVmYy82YUVWTDZKNUtDUnM2b1lLMEdxYXFGbGJQTFhVemZ5?=
 =?utf-8?B?Nm5iQjVlYmwvU3RiMTV3THMzWFZTRzkwcDJGUmlXOUpBSllRcndKdVhpaG9k?=
 =?utf-8?B?aEFRcUlRR3hPS3NxdjBDbWVIYnI5V0VoVUVjaUgrdzVvZ3ZlTTdZODN2NGRu?=
 =?utf-8?B?WnpQc0ZIVDFFUmVjOW43dlFZUW8rVC8zMWZRa0xxRnlRZ0dWNmhFWk5hOVRF?=
 =?utf-8?B?enJZb2FmUnF1QkNZTVQvTkdMaGxHOVpCckZmTEJ6R1QrUW1NYUpIT0lwbXBI?=
 =?utf-8?B?RkF4VStXbjlleVZyVW9nNXJxMjdBd21ZRUVPZzNDdW1zdnByWmNWaUZCazZB?=
 =?utf-8?B?MHhNUGE4RWRJNzFoeFVjbldrTjlSNXhyeFF2UGR4eDhtemVxZDJGOE5HTVdl?=
 =?utf-8?B?QjQyMTl3UXhyUERSdTdQekt1VFNUbzV6bHRKajZBRmxweFlzb3R1d3lEUlAz?=
 =?utf-8?B?UG5JVC9PWTFSR1Q4OXdDVCthc2lrY0N3QXNxVTlIbkZCN3ZVZVdDTVZRK0oy?=
 =?utf-8?B?aVVvck9lZ25qeHI5eWh5K0JVdWVxeTF1c2dHa3E1T0xhQmR5cUxIVDdSQ085?=
 =?utf-8?B?QzMyTDhtMmNPbkdNOVpyYVczL1NBUEk1TXVudmhXN0x6WWoxaHpXWVZvdktM?=
 =?utf-8?B?UmlFR0JVRWJRRUhWSytsNTVPNThmREFzaElCN3ovUEw4OWs4Z1pXbTU0MkRm?=
 =?utf-8?B?TGhlUW82RExQc3ZCS2FKV09SMDliK1llUGxXNXhFQmd4VVQ1dUp4dGw5UjZQ?=
 =?utf-8?B?TE0vWGpGemNRaUNwbjlTejl4T2tpc3NhNzJwTGhPVSs1SzlBM2Y5YStMcCtQ?=
 =?utf-8?B?RFM5TEh0ajNzcjNUcjRYOS9ld2V5YlFFckZMTGZBQmR3c2V1bTJVaFAzemU4?=
 =?utf-8?B?N0dEeGJZeXJmR0N1aGl4cCtTWGg0eU1qUkF3Y0RobVpLR2owSGFoM1Fndzhp?=
 =?utf-8?B?REE4dExjN0Nva0JHaVJia0tqVWtBeTFiN1U3UlpHcUc3ekdraTZUOTNoTTJS?=
 =?utf-8?B?b1ZyTWNuY0tZRElBV3pHeS9XQkNCOG1KYnphUkZwMWdOc1hqQ0dUM2hFUm1t?=
 =?utf-8?B?S1VzNytzN0czdW1iU0k4b1ZET0FKSlJmdWZOeGh5dWJVaU9aRDJSRmFzcGNx?=
 =?utf-8?B?SzBnRUJLN20vZUIxS1I3dHZLVnR1emhkTER0VDdDckxwbFl1VCtYUFZtSDRI?=
 =?utf-8?B?WVIrRmNBcW5SSmZnTXovVVZFYXl5ZE1CSlJpZmdNSFQzSWJJWjN2WDE4eEM2?=
 =?utf-8?Q?EVwM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNNZU5YUlFJSTVIdUVMb013b2E0RnRQQ2RrSW1WZitLZllQSjlmWW9ZUUsr?=
 =?utf-8?B?NC9CUDlwTERDU1U0S0JiY3BUaTJDb2R5bDFOY2tZa1d1UTQzK1FTNk15SElQ?=
 =?utf-8?B?SGZPdk5LVkUxQVZVYUk0cTlTandTeW5pSVI5M2NHNGNrLzArRExza1Z1eFJt?=
 =?utf-8?B?VlRqYStDNDFsWE9uUGRqZm1rMHBkZXZxNzhhNWM3MTQrUHpGemhKYjFjYkRj?=
 =?utf-8?B?SHFTdkJwVTJhT2ZURC9xNkE1MWlpZjdhUDlWS1VackRFWnA2SjArVENUKzQ4?=
 =?utf-8?B?a0xFbjdReEVialBqNE4vN2txZStsTDNHZTFBclB0Nk1VUXhjTG9nUTJ3TlVZ?=
 =?utf-8?B?WlhDanRzV1lTSHJJSTZ2NVI0R1dUNjNJMTVOZ250Tklua25HY3NxaldPMWdX?=
 =?utf-8?B?RzNGZGlZakR5aXU1YmRkTlJJbGIwL1RJamM0RUxXTExzdmVxYlUxMlJSWmdw?=
 =?utf-8?B?ZXNpNWkxc1BHMUVUTW5qVTYwVlc2dG8zRXRoQjRNR2w0ZFVlSm83dHBQSXlG?=
 =?utf-8?B?b0EzdFhPSWE3cnJLVGxzV1R5Q1RkR2tQWXUyMVdzSFA2M2FVdjF1S2MyV2Rp?=
 =?utf-8?B?dzJweW1ScHkrWWdmWm50QkhKUUlRa0YzN3oreGVNSjd0VGk0U1QrWUJoTllq?=
 =?utf-8?B?bGI2YlRVbGxWRXVFbWtuUXZWMUJUbC91RkF3UkpXTXN5NE1RZUwwcDNmeVNk?=
 =?utf-8?B?bWhsS0RTVzBSYWwxRGpmTXRWaGVXNll4cG5HODhGTWxMYXljc1h2RVlncGRT?=
 =?utf-8?B?eUpqamZWaEZiOGVTVE4wcllpbzF0bW9rejVDOFZtYlc5NXFZRmpWVkJGZmh0?=
 =?utf-8?B?K1FNc2xUZkNIV0xvV216dTRnMCtVMWpnZEpNTE0rMmN0bzJpc3lFOGRrRmhh?=
 =?utf-8?B?ZFNxQVJQUkZlS3NkTXM0VlBORVc0RVZJK1JPbDUwZncyYkx6aVNla0ZSVDE2?=
 =?utf-8?B?OVZNck0xYTBSeTFHUURuZFJ0OEhwOUVnWVd5Tk9CKzNMOEozRUU3dkV3WDNa?=
 =?utf-8?B?d0hhWjNRVk1ZbnlBamp3SUdOQWFyZlFHeVI1V1pXNllMNVM1R2FTc3Y5Rjc0?=
 =?utf-8?B?NDRBMlB2dExDY2hNTkM5Q0t5dWhWTXE5S1pBSmFFeGZmUWYyOTVYcVBtNDNG?=
 =?utf-8?B?K0F0ckJFSDZzaTNkVFJDN2VTckdQYmc1MzZWTmdGMmZ2djF4MzJkRmIvZ3Zl?=
 =?utf-8?B?V3YxV2dPZ1BiSnlhMTRyUW9GZWRGSHZaai9qTFhBL211QzRDT2M3dkpkL2lr?=
 =?utf-8?B?amZRdVN4eDdjcW9Eck9abHRXZ3JEbFFicDB3aVlES1dlMFRPUjJWb285b3BH?=
 =?utf-8?B?U3ZJVUlGMlQ1ZUJjNGRuN2lCd3l2M0Z0NVY3amgvc0ZpZ0NDL1dXa3pVdzIy?=
 =?utf-8?B?MlhLcURXcGVtd25pcldKek0yVHpFZC90RW80b3pJRVRHZlBxQzc5UjBIS3p0?=
 =?utf-8?B?NmxOZ0Zkb0pyYTl6cDZIRFVaSWxFRG42TWtHQmpaWWZhbFNOVWlHWnVzbk5y?=
 =?utf-8?B?ZzFaOWkwK1dFbElDWTVQek5TblZsZG5FNlBKczl2VkdPZjZGUVo1YTlyU3E4?=
 =?utf-8?B?THdrczJYejI5QWNzalUxWXBmeHhlcGgwMzh6eDhrbHROMWRZZ1VxUG80WlBr?=
 =?utf-8?B?NzlhMkUrVG1zRWRDNXAxU1h2Z0pic3JkL2J1MkhLYTF3anE1WG4vaFNmU0Ix?=
 =?utf-8?B?MVBMeWdVY2libUdsSmNwVndqNC9rSlQ5SHdIUVcrUGNNK1UxMWthY3Jibzd3?=
 =?utf-8?B?M3A2bG51UXZ0cDJVVnpaS3NvRWZMUjVyem5TT1QrQzVVcmE0elkzdVFsSDcw?=
 =?utf-8?B?djVPZnJ3SENEeXE5MTB3NFJ1SDVxWFJKa21RTFpTeW1od2dhK01ZQ0lscnBN?=
 =?utf-8?B?clBrTkJvbERTMTJHMURHWm1Fa0RJRFBtY3h2RzRwT2VuOUZmaEpLOSt0dHFm?=
 =?utf-8?B?MEtYczdveFpiaTVUdVRWY09IVEZjSzVseWh2Q29lb1ZieVNtTi80SlZLNUE0?=
 =?utf-8?B?ak9LMlFsL2lTMnhKdnliKzh4WWZYZU5rTGF5WlVjRDhXeUlIZmd3SWRZVG5P?=
 =?utf-8?B?cEcyU0MvenpqTmRKdWdNV3BodmRYOEhHYWpEVUFKSWlFbzlHNjRuTnJ6TVZo?=
 =?utf-8?B?eVpTSkhyem5nd1FRSEtLREk0Ull2Yjd4ajBHYVY5VEpSc2RIdzcwckY1MG5F?=
 =?utf-8?B?U1pCeWMvTmZqWnAvSjczeUlMZlV4WXVPMnlwRVFkRTBsWkxvMXNoZ2x4Tlpx?=
 =?utf-8?B?YXlqSDRrQU5vSGtQRU1wZ1E1aXBSVXBIQlVkcTU1OXQvWjNqRUw1SmlvZHdP?=
 =?utf-8?B?QnhrMHdlWVpMTXoxOHErbnI1Y01ERGszNmh3NjVtdlhQRzFlU1RndzVaN1ZM?=
 =?utf-8?Q?refISm/UGsfFYm9g=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35be8da-f381-48fb-0bcb-08de538100c2
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:24:26.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdLL6nKOwrRFMp305YYodi/DEPBzz63yv/2No93dhcNqysxfvPUsmYxhXs2/b4qL1ijCIftTIYenyMC4Mxch8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10381

Hi,

On 14/01/2026 14:45, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 10:45:53 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
> 
>> Add capability checks for operation with backends that do not support
>> full set of features, but are otherwise compatible with the device.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> Hi Tomas,
> 
> A few comments inline around when we should or should not return errors.
> 
>> ---
>>  drivers/iio/adc/ad9467.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..349779a049ad68b4c9f72abfc40154b4a3f2e095 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_state *st,
>>  	};
>>  	int ret;
>>  
>> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		return 0;
> 
> If it isn't supported then isn't any attempt to turn test_mode on an error?
> I would return errors from all these calls and only decide it doesn't
> matter right at the top of the call stack.
I was considering this option too, I will change accordingly.

> 
> In this particular case that's either calibration mode stuff (covered by check
> below) or ad9467_chan_test_mod_write()  I'd just add a top level check there
> on ability to do calibration. Alternative would be to not register the debugfs
> at all.  Challenge is that is a small ABI break.  Do we care?  If we had
> been doing this from the start we would have just hidden the pointless
> interface.
> (Key is we can change userspace interfaces, as long no one notices!)

The testmodes from device side should still at least be there, only a
few of the modes currently have a backend mode, too.

> 
>> +
>>  	ret = iio_backend_data_format_set(st->back, chan, &data);
>>  	if (ret)
>>  		return ret;
>> @@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
>  	};
>>  	int ret;
>>  
>> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		return 0;
>> +
>>  	ret = iio_backend_chan_disable(st->back, chan);
>>  	if (ret)
>>  		return ret;
>> @@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
>>  	bool invert = false, stat;
>>  	int ret;
>>  
>> +	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		return 0;
> 
> So this the idea of a stub calibration bothers me a little, but I think
> it's more acceptable to do it for this top level call. So keep this one, but
> all the others look to me like they should be returning errors.
OK
> 
>> +
>>  	/* all points invalid */
>>  	bitmap_fill(st->calib_map, st->calib_map_size);
>>  
>> @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
>>  		return ret;
>>  
>>  	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
>> -	if (ret)
>> +	if (ret && ret != -EOPNOTSUPP)
> 
> I don't see any modification of devm_iio_backend_request_buffer() in this
> set so why why is it now acceptable to return not supported?
> Given the capabilities stuff added, should this not be another capability
> we check before trying to request the buffer?
Basically because I reasoned that capabilities are more like features
rather than single operation. The single operation tells if the
capability is there. I reasoned a bit more about this in a related
answer replying to Nuno, hopefully you find time to read that
explanation and provide your thoughts.

And reason it would now be acceptable is that the original code does not
account for any optional features within the backends, but now it does.
It knows it can work without the buffering, and the return value can
tell if it is supported or not.

Thanks,
Tomas



> 
>>  		return ret;
>>  
>>  	ret = devm_iio_backend_enable(&spi->dev, st->back);
>>
> 



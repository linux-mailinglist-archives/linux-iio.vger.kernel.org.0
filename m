Return-Path: <linux-iio+bounces-27957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F035D3A796
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 12:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8492330B095E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01C31A06F;
	Mon, 19 Jan 2026 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="qT5omNcz"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021126.outbound.protection.outlook.com [40.107.130.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF04314D2F;
	Mon, 19 Jan 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823722; cv=fail; b=aMZ5NxvclOOQqerDeL+GQRw3AzCwOY0a7CldBgJV03qnqMaEL6pxH+ggOjAyqaryb7WmzNE/R6ON+LN9RbrMqCuNq37BZMT5CwUFRaVyoSFiS+QiYJxC6MxvDGi+VGb6NUh5/OQxKPbxpWvtbvPviuDzFH2mg7DLQdVLCwNrFUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823722; c=relaxed/simple;
	bh=q9UqEZGQacaLEkBo8WxPiT9uuxp9wgjVrdeilDXH4fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cunUddJ4ns2RC+teM2/0IYJOh62hCq8AMzt28QtzlF6bs5dlCgvlfXbFlkvsv5y3llfHkR0BRM8wsRHW/3ZMckOhq/itpGLOZf1g/dnRh3AJ5qzNDJeNyv8NCiLSBHN2FpfAISKsFe67Jvr5lCSyNJmp91ocgDw5y0eHnmk/cX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=qT5omNcz; arc=fail smtp.client-ip=40.107.130.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks/1gGlsPa3n0E+6klU/eO9mdNAQuQlWVYGcb0M6jVTq1lM4tYP4/URPu5U5TkVLUQxlm3odjAEkvGIgrn2/4mf4PCu26MID2xKmi16KyebkI5toI6hwo2BjiRLfHDp3V7MpSRpGOunSbh7GjmqBz/bvkkc3feuX1CH0y7Qvi/S7D/2FJKCorO1WVU+GWZjC6LnqBfX2Wf6SOWQF5iJ5dkNFLdX4Wu/kJ2RYbnsuPrpjdz2Dx1pLOrbPSy8/3sAb3UebGjP+lTwF5ibnjsktCcQRAZqfY+3vuj0LhegHeT7tzVUtBvZE92LL5dnPOb5Riayt852MllyjAP//BjBXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JChQud9NKZP8r35cebE2cdYnk1kYyC2eDEdRPchsq20=;
 b=JQmnwFKjHSK6b1eXcoXb3Tc04X+v7Y7jnBye/aiScVXOr73S6P0uKwA2jyQ20V5cpeQM3VwX6//6e5KMe4PtRzKyBul+opspz02vr5ew59a7QQs8xsm5MrmVcmd8NIKilw68aGZFMVIzG4Y0WL7oA5tXYYRcIGrwtIHOJ3HtmMps1He5kP5gUpu1HgYiVP4si5kkQ06ofNDKtcPNIA5SD0DhpYETd31SzWMjFviP6oQQKospvqLKHRBTSNLqJSUd0Jgy33akAzG/sxZaHc7VUiRlpoS2/XqovilPgfvczKqY9XDvwHVSDALHRDHVLnIrUh/pxmH57vEfEg+aBSfeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JChQud9NKZP8r35cebE2cdYnk1kYyC2eDEdRPchsq20=;
 b=qT5omNczhEgsjaULd8v6Nap6tXGCPTFF2xAiVe1XuI1j/iyflBajflGmHBU7EfPFzTHfC4e/Eu2fCKrrdkqjP6AI55orMGpY6Lv4QoxQEI+TfQnvTMl1abThAB12IwHvk84FVAKOzPo5dd+vJHpt412k5CraiuLWwNHgCBpxfHG6I5oX0xhLJDYrSBHHO5W5TesRzJ+rso4RJ/w9oE0CKnIXy44NhLldhtGCrGgQNJEvRM50nAkcaQ+mXKljc3otnXtieM+0lrfAtHB864qJyyj5DGXu7N+Hs2QxMbFZJWcoVMZhwTqDTrL5buhvfubSlF0uccx+ijvWlOReoSEvhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI1PR06MB6608.eurprd06.prod.outlook.com (2603:10a6:800:180::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:55:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 11:55:11 +0000
Message-ID: <fdc20647-671b-4ba8-a30a-50e46ac71c6e@vaisala.com>
Date: Mon, 19 Jan 2026 13:55:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
 <34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
 <68cee45e-4822-41af-a0da-d1b88166425d@vaisala.com>
 <9214d1ba49ee31e4f35d8d3fe5d894142e1d6fef.camel@gmail.com>
 <20260116183212.08630389@jic23-huawei>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260116183212.08630389@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::12) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI1PR06MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: a779cc17-c75d-4ff7-21ad-08de575199b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDgxLzkxa05lUkd3dnpiVjlxR3JKUjdKbHBsWElxRFZMMTY1QTZiYzJPM3B6?=
 =?utf-8?B?TFhlN0NOdkxBWm9oMGUvSGk3Ym43RjA2N2xncG1VQ3BMYjFNbmdacTlkc2Ni?=
 =?utf-8?B?Z0JSQnBnUklPSXBtcjlqaWNYWDVkSHVvSCt2UFdWU3IvTjljYUpHZlhzVTVS?=
 =?utf-8?B?L1lQMHZSRTRQQzRwZ2dPQnlhVkNONDlDa0Z0YlJRNCtLeVZaUFBoOC9qK2ww?=
 =?utf-8?B?SGJCWkR0NE5KY3RveTdtcFNueGtwSkhJUjJIdnY5c1ZDVTBldStKcG1lNWZJ?=
 =?utf-8?B?VGJ0SG9RMHNEeXFGTWZjVzArRUM2TXhwWGhUUWZTbzdjNiszYlF6aXRVNk8x?=
 =?utf-8?B?eklHWkRvaTJvTXdVd0pDZ3ZtK29odjFITG5LZVRiTGxENEpNRm1XUWN5dnM5?=
 =?utf-8?B?Y0VEL0MyTzhZMjNpaVhZNENERlhWOVpodVc2RzNycmFYUmtYNWlNdjBuZ0d3?=
 =?utf-8?B?R1lSMkRTVVk3enJwbTAvL2VGSEllRGI3dDlicVlJVU5DOFFoUXFRaGRhem95?=
 =?utf-8?B?Sjk2VzdCNkJCZkFlRld1WFUrZ05tUGhqWUFUdWpoWEpRQ0hFaE9TeU5MamZY?=
 =?utf-8?B?K0JUSE9Yd0M4MEZVVzBuR1ZPRnVHRXd5cHUxYkFNREFIMVhRS1VISmxOYXdP?=
 =?utf-8?B?UWZROGJCdU54YnpjSDE0Y21ZVzgwdjRIdW84V0g0QzZ0d0JMMlRlOTN4MU1Y?=
 =?utf-8?B?QStHMkhYbzk4QlRUcG9lckUrUXMxSGRvTzRTMTg1MVlwZVl0NUo5N01NQkhn?=
 =?utf-8?B?bGlsTEl4M3B1Z21oTzhvVUw2ckVnUXl3ZG1zSXpIZDhIMFc3ZXNzeDJGaHNG?=
 =?utf-8?B?dUJJcjMxRFFZQ2dTUWJ1WkRXWjVUbSt1bFFzUlB6cmJWYXBsdExYcEkvUlU5?=
 =?utf-8?B?aGpiNU1RT3Z0VlZEUm9jcWg3eVNWOSt4NlJNMzNHQTY2MlZPalZQbmVXODZ5?=
 =?utf-8?B?UXQwSzdSWE1ueTdJRHBsVktjK0dGdzkrZVdaM2JCWHZyUUNvTEg5eXhMV214?=
 =?utf-8?B?ZHM1NVMveFFZcHRkZFlpdHhWY2xhajBNMlpvWVJHOTRsTkNFN2EvY0NtVTY1?=
 =?utf-8?B?SU9GZWNjdVNWdDJ3UGVEb3VYSTZibFMxVFRBYzVkUExLcjJkSE55emZNaHhQ?=
 =?utf-8?B?dkNXeDBHMHBlQ3I0WU8zazNsTmlvRjdsT1VOa3pWbWY4aVVPaWY0a3hpdVEw?=
 =?utf-8?B?bUw3blgvdFNSL2c5TkNJTkthVk92djdnN0ltcExGejkrS2JBb1FUbjJlaVFH?=
 =?utf-8?B?QVlTQTd6NURucUQ1R3QzeHNmNnJQYWI3K2k5RjNYMmhUSllTTlZubStIZXV3?=
 =?utf-8?B?cngycnY1MExqb3cyNjRhQXJGRStqN3lNZjVDNDF4L04rOTF2L3B3MzhhT1BH?=
 =?utf-8?B?b1dMN09OY3BxWVVPdjVPY3VTWWtETUlYRFZzWXZWRFRtNUFWWUpTdlRROEVs?=
 =?utf-8?B?WmpwamhwNXA0NVBZdGxCODRlaUxsWWdRQktoanFvTmJ5emhRMUtaa0EwMHU3?=
 =?utf-8?B?VXVmbTdvVzQ5SHN6MzQ2OENZMU4wS3JIVDN6clptSWN5NlVzVjVpdUdWdXRO?=
 =?utf-8?B?SHR2WUE1bzZVbHNNSGtvTjRmTlRRMnlld20rcHhnWW00allFaHA1Z05FZnBY?=
 =?utf-8?B?ZnE5NjV0RFRpTzdUTHc1TkdFTXU2NFBNVG84L09PbHo4T1VMRGIrTFBqdW8v?=
 =?utf-8?B?WjRHb2hiU0IyQlB5aXZieGtMR2tZL3RLOGZVSnZ0eHVEZHg5M1lCV3ZVM2p5?=
 =?utf-8?B?STU1amcyVHVlc0MyeDg1UjJKT3hheC9WMmVqazg3VFZVK2o5a2N3SDM5UVhY?=
 =?utf-8?B?MVArZVR3VXc4blI5c2dSRGc5UlYzQVlwTjlEbkszb3dmZGZuTjFnNEJ2Vlp2?=
 =?utf-8?B?SmZEZXhkZnRvZmZuenVVSlVzazJ4VUVBVktiZjRvMURRTE1VRVlLY3VyTk1O?=
 =?utf-8?B?MDU4VkZwcTl0cFJoMlcvWDB1NnhiblQxUHFkNTVJOUs2WkM4QnpBVTh2TWQx?=
 =?utf-8?B?cVd5YzVvWW5YNnZxM0FwWjRqU3hPUVZ1S3NNRjBaWnp2NjFpSEJORkY5SDVG?=
 =?utf-8?B?NWd3MGUyaDd6dHFJdFRqQ0RvYUxOM2J5MnprK0NvVEgxVHJzcE9QVXRCejZL?=
 =?utf-8?Q?7a4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJpR0hPVG9Ra1RMcy8rQjZlOTRHdmExR25xKytyVlJtYnN4d3IvUUlvZ1hw?=
 =?utf-8?B?M1hyMVk2WG1ZM016Umd2QldGQzRKaTFSQWdOcXROVXhnV0VHQkc3dkhyWkJX?=
 =?utf-8?B?aDZjaHNIbkNJVHVHR0Zyd2VOdnNtMkdsbEI0MldYcUdqS2RNRlo4ZmMyVmhF?=
 =?utf-8?B?a2tFaUw2eWwwOWJibE1tNkFoYmZEVGJsZ3QzczdMSDNhQWIwdjhvNFdhR2gr?=
 =?utf-8?B?Q2pyaFRlSjZoREN3ZWZtQlVZSmJqRFpucGhYaHpURmdPRVg5YTN2dFg3c0ZE?=
 =?utf-8?B?V2RRK2FXTHgxS2E1bGFFYWhWdis1cFpNS0xtQmJianBxbWFWLzBlNGlCTEs5?=
 =?utf-8?B?cWFBN3JOSlZ6VmxkNVpxbGF6OFhRU0hTdEFia0RyMkk3N0JaWEltUjdsY2sr?=
 =?utf-8?B?Skszb1JOcXdlbFJuNFBBcDBqR3RGeis1VnE1b1M3SzdudWVjcnVaMWNuSk11?=
 =?utf-8?B?ckxZeGJPaXBFZ3BkSHVtNk9uWWplckFaQ0JWd01zZS9wbUtMcU00VFNUMzVX?=
 =?utf-8?B?aHZ3U2gyclRveWY0V21qUGhRdks3VlBFVTFCeVlMcHEyRHVxTjUwOER1NFVE?=
 =?utf-8?B?Q2YzLzZzWHFnMWNUQlgwa2ZOUXBkUFhldFZnd2NEWlJNOTFmZ0JtZUJIdjAw?=
 =?utf-8?B?cDlRQ0FkaHhrajQzZ0EyL0F6dk4wSGwrUjYvbDc0S0EvNzNic0V5N0MrU0JK?=
 =?utf-8?B?andkdlM0YUt3QW5keWRCUXdhTTE4L25ieS9IcE50Z2RBR2ZCdmI5VWx1VXE1?=
 =?utf-8?B?Rnd6N2JwZnhoRFVpYUZJaEtQQzhKR0dCMVArSDVONDliYUJCWjRkanFKMURS?=
 =?utf-8?B?RTJYTG55VHFtdkszVXlEZnZ4bnp4VFljZjdaZ2YySmcyNVVSbzFKZ0ZZelNU?=
 =?utf-8?B?b2JmM0FkT2FEc2Fhamxtb29VeEpQVVFOUXJvaDN6aXpoeFZkZWFubjJDQjZh?=
 =?utf-8?B?d2RVVzJONXg2MFhwRDNDQllZK1llTUIvc0kwblpLME5xTElXMVU2Vk5MOTRo?=
 =?utf-8?B?Q2lPL2c5L0NUa1d0YXgySjFyeEkzNVVHWkJocUpnME5DRzkrMG1JSERibWla?=
 =?utf-8?B?OVlMdWdtMHFWMDJ4ZDRmdEJKVmpSZ00zd0NBU3M1Zkd1aFJRbFpjU3p1M25S?=
 =?utf-8?B?RnNrMFNISkYxVHVmUGE0SDk4ci8rOHRrYjJvb0lnZUZBKzJSVnpiQkhNSVk5?=
 =?utf-8?B?RXBkVmlCczZoNmJmMytjOEZQeEpNRWVMOFJkWW1LZk9Tdm9IZTFIV3VLTkhs?=
 =?utf-8?B?L1czL2hVZnR2Wlc1THpFT3lsV0UwRytGWEhhdzBkZVNQWmlyWisxVzVlV2wx?=
 =?utf-8?B?UWJsUTZiNkJyTTZYYUUyYWJuM2ZvUzZFNWk4Qk44MkF2OUtkUitiRDFIYzF6?=
 =?utf-8?B?cEdFd1hZSVZ3U3F1L0tRRGRSNXRXekU4MW94Q1BVbEpmSTdranovQ29uVThD?=
 =?utf-8?B?enVjSWdDTUc5UmQ5Z0Qxblp2aUs2dS9udERoSW4rZVhhSDN4SFRtc29SMlVh?=
 =?utf-8?B?T2s2NU00QkZlbW1LeGRvV3JYWTdwWldjRFB0K0pvb2E0MWJvWnVvZldVSUZO?=
 =?utf-8?B?Q3BnQmg2ckhlMUxIOThiUDNJeEpodW1YYkJtakpPY3VWV3dlTHpoRWxmSWl4?=
 =?utf-8?B?UkJGVTFobW5TUzN2UktvUlF0V0EwRzEyZ3ZvT0NCMGFNcm56MXpxaS83elpr?=
 =?utf-8?B?ZkFLUzBEZStReEdHc2NZSDAya0laQVYwMG12QVFEbVp0YTJUZnhPNFJHZXB5?=
 =?utf-8?B?cHJDcHNlZzJoQUI3Y2Z2bkR6QWxKM1hoVmg5aUsrUnI0WHR3YkpXbXNud3Q0?=
 =?utf-8?B?VTUrazlLOXlUSUVOeFdzSHg2U1B3UjFVTmpHUWpscy9PbnZkcU1vTjgzbWla?=
 =?utf-8?B?SVpiMHpBY2xYNlJ6b2Z1NWx2OGdwWUxXVFRnZUNoQjNJa3d6RlY5UFpkNFJ6?=
 =?utf-8?B?MkZETWZOaHM1SlFIN3JPcE80c1poOUlydjVUTGhXRkhVU2lwaTBhRkM5TTVC?=
 =?utf-8?B?Zmh2b3h6aHp0QlNSeklYM1NnQnRMblM4ajBHS01QWFZlYThPVkZPcnZxeTdy?=
 =?utf-8?B?R21DdG1kL2VaM0c2c3pDOVRmUUtBbVJ1ZDArTWlFKzRybkNNNTNaSkI4eUQr?=
 =?utf-8?B?cDFSTXhBL3N6NHlTYkl4cFdlQlBUVnFVUHBnYkFPWC9pU2dXdmlsNi9xQ2Nn?=
 =?utf-8?B?SE9VZmxSNVR6SDlhVGhqRm5HSDlyNkkxVHV6cGRibXZmOGY5VGR6YWd2dWNl?=
 =?utf-8?B?L0JGWlFOUVFZTVBhWGk1bXNMOXNLTHRZZjRET1FhN296ZVRNejk4SUlRU3Nh?=
 =?utf-8?B?b0JKNlJmaldBSXYvUjlKUjB0U1k3M1Z2ZXE4TFcwL0R2QXIzVUxWWnpsaWhV?=
 =?utf-8?Q?FKIR8Zkma8TmgOF0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a779cc17-c75d-4ff7-21ad-08de575199b9
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:55:11.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cdPhjRmod0RujCKfsQFXEAdHmQo3rBCfuH+q2W60OszMo5IPNo8jt37aafWdNX2mfOOwleNTR+fsLKGBHMkdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6608



On 16/01/2026 20:32, Jonathan Cameron wrote:
> On Thu, 15 Jan 2026 11:54:28 +0000
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Wed, 2026-01-14 at 17:23 +0200, Tomas Melin wrote:
>>> Hi,
>>>
>>> On 14/01/2026 14:29, Nuno Sá wrote:  
>>>> On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:  
>>>>> Add capability checks for operation with backends that do not support
>>>>> full set of features, but are otherwise compatible with the device.
>>>>>   
>>>   
>>>>> +		return 0;
>>>>> +  
>>>>
>>>> As David suggested, it might make more sense to do the check from the callers. Not as
>>>> important as within the backend functions though.
>>>>   
>>>>>  	/* all points invalid */
>>>>>  	bitmap_fill(st->calib_map, st->calib_map_size);
>>>>>  
>>>>> @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
>>>>>  		return ret;
>>>>>  
>>>>>  	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
>>>>> -	if (ret)
>>>>> +	if (ret && ret != -EOPNOTSUPP)
>>>>>  		return ret;  
>>>>
>>>> Don't agree with the above. I would prefer to see a dedicated CAP for buffering
>>>> otherwise I would argue why not doing the same for everything? While it might
>>>> be acceptable merging IIO_BACKEND_CAP_TEST_PATTERNS and IIO_BACKEND_CAP_CALIBRATION
>>>> (given they are related to some extent), that does not apply to buffering.  
>>>
>>> Okay perhaps we first need to agree on how we define a capability;)
>>>
>>> So my thinking here was that calibration capability expands across
>>> several or even many op calls, so it's a feature level thing and
>>> requires several coordinated functions. So does the test pattern, but
>>> it's a sub entity of the calibration so I merged the two together. So
>>> checking for a capability in these cases makes sense, since checking
>>> against a single operation call for determining if the capability is
>>> present is not easy and which function would it be, etc.  
>>
>> Makes sense.
>>
>>>
>>> The backend buffer on the other hand maps to a single op call (in theory
>>> two). So checking for that buffering capability can be done by checking
>>> if the op call is supported (eopnotsupp). I was kindof thinking that why
>>> need a capability if the mapping is 1:1 and the information is available
>>> through that error value directly?  
>>
>> Yeah, TBH the only reason I can think of is readability. To me, it is more
>> explicit:
>>
>> if (has_buffering())
>> 	request_buffer(); //not allowed to fail
>>
>> And can be a bit confusing having a mix of has_capability() and checking for
>> error codes.
>>
>> But yes, checking for specific error codes for determining behavior is a common
>> pattern so I won't be nitpicky about it.
> 
> I'd prefer capabilities for each thing rather than a mixed scheme.
> Nothing wrong with also returning -ENOTSUPP if someone doesn't check
> the capability first as that's still helpful for debug.

Okay I'll update accordingly. So capabilities are defined as being
something that

* is defined/added on a need basis to help frontends decide if a feature
is supported
* can map into multiple operations
* can map to a single operation

Thanks,
Tomas



> 
> 
>>
>>>
>>> On frontend level, like here it is known that the driver can function
>>> without that buffering, so if the backend does not supported it can be
>>> okay to proceed.
>>> If we add a capability for a single operation that has 1:1 mapping then
>>> basically we should map all and that is not really the point?  
>>
>>> I see the capability like a contract between the backend and frontend on
>>> feature level, that the feature is there but the implementation of a
>>> specific capability might actually differ depending on the use case
>>> (like we see with ad9467 and ad485x calibration and their backends)
>>>
>>> What are your thoughts about this?
>>>   
>>
>> Ok, I think it makes sense to me but maybe we should be more explicit/clear in
>> the docs:
>>
>> "... meaning that a capability requires certain 
>> operations to be implemented by the backend"
>>
>> Maybe s/certain/multiple and we could even mention that if a frontend is interested
>> in knowing that a operation is not supported, the error code can be checked
>> (though this could be obvious already).
>>
>> Let's see what Jonathan and others thinks about it.
>>
>> - Nuno Sá
>>
>>
>>
>>
>>
>>
> 
> 



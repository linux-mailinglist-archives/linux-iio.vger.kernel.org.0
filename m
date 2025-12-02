Return-Path: <linux-iio+bounces-26622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47DC9B860
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5956B3A7B2F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48E313E20;
	Tue,  2 Dec 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bqTDiw6L"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021099.outbound.protection.outlook.com [52.101.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934D3115BD;
	Tue,  2 Dec 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680014; cv=fail; b=G64sfBww3+s2qBddzPRy2v4Uas0p1ANELh15WbLFcKIb7fINC0gHPzrEewGTG3P8bYo7kVsVLauXKsKFgqw+xsZsVjyH7Skjh26b2aKea9Xp/gCF1Op005ElwROnwnSna5rhrKoh32Mw2qM07BsIxfQ7XAP1IbS4BU8apMMDpNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680014; c=relaxed/simple;
	bh=XblcyXjBsF/u3E6vhjnh4Bi5+zanAw+5k2Zirq3B6wg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ewG14rMG+iuJV6Joy8raKO7+vpRVmijZUU5fx8cZ58DmlVAUp/ZDuYR5wUO/lHcJ7XpW9q80h3UJA1ONKgDG+KuK5qIrlaB5AHgOKcQgkj6zqAoK2PNwkdD4383vRGmc1KrOn+xv4vczFXwmenwK7osmHrsKGJlgAi2Dr0Ecngs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bqTDiw6L; arc=fail smtp.client-ip=52.101.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXZAmuAAglxBoul/JwsGdMa1YMlnZ4k9Ec5AWFdE7sdewJHzMwZdKOGw+HrN7i9y2jAMi/R9iUN1LGshVK9paesKV7GLbggKSDOBRs1ZT8bo4bZe5aiwKp1Yp2PH9JITTWS4pu0HgNxzKqhJKTqPeSl0YEHu9EQHl30XtMM9Lfo35VqQMshgtnXk99YKtlUjCpCYFTOwkPPqdLjPGB7rAZAxSQH+z4/IGkCKSCOdgdbXvlisCs1zG/fK3IzLaMWifjJrFLqUbWN47Z4+jEV+Q9of+owvO+AK+Sg9U6ukH9ZtRIxc9NqNdKD3U8opIS+BXsaZfeF1g4JrG1JOV8BbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WrSxo9K0rO2ZUbfft7kNg0RKUNfYP+xJ/aAb9SYytI=;
 b=hl2Ao3yS569bR5yOppPuHpAmRW87tpMUBYoMvL9F9uqeipKs3ZfBsgAJjyiv5lulhSTFTcuMeWLmLsSyC0hXTI5YjNWtt6s8ryhwYB8TfHXO+fWv7G5eaIBc9hhwoXMO0Rn23r09jP7sDjGPewc3NNOxtcZDoYmSFayyaRjMzdyMemhbjp0nuqdOZruYFWnHF9RCwWzRYX+djxRaetlDuSd37NjjIpBgukD0jjaZqT6/xOFIxxtDCeNt7vo3afYFyFI7WAHkTgO+6sGhTb0b+yO6YZn7HL/X87WwBLFp59bu2d1ETZhfLtsjIJeTNyemY1K+QALQJAHbusty0BIv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WrSxo9K0rO2ZUbfft7kNg0RKUNfYP+xJ/aAb9SYytI=;
 b=bqTDiw6LH4/u8gbsy66jVZkGmiKh69PZk8iLgCth5oVJ2ZKoOeMjis1IGaEAh+zrPgsDlOExVzupdgUoPysctPg0e/EGc3WHEr9DZjme4LkRv5nevbJw8QjfqQ1UNzKCwWDl4K4+NaHytpPEmD/TMnyknAvftwLCCDfWlx9nrl5hb4rkMLi91m+zchYdF9iA33BBgBVizAf6rKNIOVuubhJNm0b5LpYgTJl3bH5oMTIXccZB17JXERLeZA0lQSWRHo9BIWT9Jm4rkC3cbHkZmPW7BjkzW5+ZuzymRL/rkuEaq3zUrQh8gq7QkYEhFQATqOtZ8GFTyZS6hgm7Q2E2jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9178.eurprd06.prod.outlook.com (2603:10a6:150:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 12:53:23 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 12:53:23 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 0/2] iio: adc: ad9467: fixes for ad9434
Date: Tue, 02 Dec 2025 12:53:07 +0000
Message-Id: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPhLmkC/3WMQQ7CIBBFr9LMWgwgNNSV9zBdjDDYSbRtwBBNw
 93F7l2+//PeBpkSU4Zzt0GiwpmXuYE+dOAnnO8kODQGLbVVWiqBYTAnIyK/KYs+xOBdH2/OKWj
 Kmmg/mnEdG0+cX0v67PWifuufUFFCCmtw8KjRW2UuBTnjA49+ecJYa/0CIlo2SqoAAAA=
X-Change-ID: 20251201-ad9434-fixes-6dfdc86fb881
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764680002; l=919;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=XblcyXjBsF/u3E6vhjnh4Bi5+zanAw+5k2Zirq3B6wg=;
 b=btB2jyrjv7Fw1Op49FMntjJlhO1qGkOPtqMGPFLduVc/3C11AvHXDzAXMsHtaLYQ9qXayqLYD
 xNXszV1Qc+zBN+5xs5J3fAPiKDC3CUIOEWqtQtZ7ikzstPH9rNsTfH5
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e60f997-0bf2-4d23-6b0c-08de31a1c6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXIybWlIZkFmbXg5NFErQzVDend4UFE0cC92ZHdCTlhXTmFZbjFEN0MvczN6?=
 =?utf-8?B?ZkJFS2M2YUphZU1iZm1uN3JxMWpTeWZlWVpEWjI3SHlCSUtwbFBPdmN0ZzdZ?=
 =?utf-8?B?WFpneGNuSTZBQmxKbFVlWEFTOFYvUjAwZ2FjRzdOSU9KQ1FJQUQ4T2YxV3N4?=
 =?utf-8?B?bytycnZrV2hjM3pCZTlpQnl3b3pESzBCYzNUcGxnUkhUSXA5eEEvcWdTRUp0?=
 =?utf-8?B?TEl4aG5hVTk2Qkd4RWI2MTcwdWxVVGtIRk84N3FMRFV5WEdDVFk4NkJNQmMy?=
 =?utf-8?B?WkZYYTVBRlZadlpCQzVnQjFJcERSbGhwWmJwUVFEVDQ3TGg1OS9HRC80ZmZQ?=
 =?utf-8?B?NEgraEFDb1ppcWNub2VZbDREL0N3d2JsS2ErT2VPMzlBL2Iza2Z4MkdkaTV1?=
 =?utf-8?B?TERKbGYyMmN0NE94ZTBmUElrdjA2VHBMUlB0M3dheXVLUVBPZ3dPV1IvcmFR?=
 =?utf-8?B?TnFiTUgwY3A0ZG0wOFlmekViRGsxNko5OVJ3Z3kxUW03VEpWcjFKcTdWV01w?=
 =?utf-8?B?R1lLVm1LbHc4SGs2ajJSUTRMbVpRV1pBVFF0WVFhTXZ1TXhiN3RuNWNJM0du?=
 =?utf-8?B?bW1UVTkwSmE3RTB5cTVYaXRjNnBWd2dPVGlEUmNpM2JvWkRNWGFiV2dJcWdU?=
 =?utf-8?B?dWdaRHFUSzBxNUJtM0hPc3dLSnpyaHhSekhYRjdBRFNoclVmclpFaEF2d3F5?=
 =?utf-8?B?a1ExbkFmNzBQcWJZcWFnL1diNHBhSDFBWkpDVFJyZkdWaFpjYXBEQVBOcm1S?=
 =?utf-8?B?dVFaMjRlQjd4NzEySVo5a05DS01xOEJad2hra2pZYlZjNU52SkE5WGFaTUh4?=
 =?utf-8?B?Tno5WTdqdUR2RnEyd01aL2IvTmtqVDdPTXZ6Yll1RDZDZUdqandFSXVDZmx4?=
 =?utf-8?B?T2tuaHRUTVNFTFkzWnNIRE5TaFBRcG5MT3ppcVlZRGRhOUQ3RXFIS3grQVR5?=
 =?utf-8?B?VkpXVFdtUFdVOS92d2s2TXFrSkYzWWRGdW5VRDR2amhRVFYvK3NaR2hKWGpk?=
 =?utf-8?B?QWxuWnJoYzN1d1NMMjFMNzdPallwQlI1bzBNSXdCZWozUTN0V1g4ZU9rbW9B?=
 =?utf-8?B?MEl2STVEN2lHd3BGdWpMT1FHZnFyak04RDh0azIzdlJuZW8wV25aeE1OTzZn?=
 =?utf-8?B?ejVSdmkwREo5eXJNdWU2V3kyd0JabVVlT1RvUGR1ZEttcXVjSVp6ZXI5cWd1?=
 =?utf-8?B?MS9HaFlQRzRldGlESVYrN3ppSS9xc1RaamlteHdJeUtYSnVQc2kxamJnb1R4?=
 =?utf-8?B?cWg4Rmo3YzZzR0x3dGIxaU1xYUxMc1BrT0t2MmR2L2daMTFEYWcrOWZ2QURE?=
 =?utf-8?B?UncxOW9YdUlKWTh4RThTcS8xcHQrVTVvdGplY2lBU3VLbWtMb1lCaVROUXZh?=
 =?utf-8?B?SHFiekV1Z2pOUU1ER3owbDBick1DTGFJcWsxUEpNRUlaR0pEK1kwMWJ0WFBk?=
 =?utf-8?B?WU52RStwbEZUMlhnM0gzQVVvVmtDSWZISWFMZWk1N282V2N2b2R2K2dGZWp4?=
 =?utf-8?B?K3hCWURUd2I5VS82cVVJRVZaclMvRTl3SnpoUFRtbWF6dVNjaXBYQnJFTHor?=
 =?utf-8?B?cnhJVmV6Mk1PVU5zbmZvcHVQUUdaVExoT2VIejdBY3dZQkZFQktGb29YRndn?=
 =?utf-8?B?aDI5ZkU3RTBxZlZOUmFsQ3psalR2WW16MFZFeW5wb05tNUZvaC9yenFKMGhQ?=
 =?utf-8?B?VTJENUJOUmpSa0tOM0VKMmNERjZ1cnp4QU9RdWNVdUZnVDFNekFxNFJIdTNP?=
 =?utf-8?B?cDFlR2hEZ3I4RlpxVGRWd3BhYk5EUmsvbStyNVhWKzRqTnFrdGNtdHR5RXJR?=
 =?utf-8?B?eG9KYjNhYjNJdWxSdjMxb2RvVFFGbFVVNmpuQ1hnektBaEp5ZVV5a3JmcDlt?=
 =?utf-8?B?YUM4c1Y3dDIwZFNzN2d1d1A3clJRaDhDQU5ub2xzeWxKZ280S1pHanpNUHhY?=
 =?utf-8?B?eTN6TkdNNUdCSkNSbFYyazJwOC9xUk1iWVllN054dGF6cG4vSW1wblUzT2w3?=
 =?utf-8?B?SGp3YmVJbGxPTlViSWM4d1hRSkFuZHBPajM0dEFKNDhqa2VuaTk0YzB0eWNC?=
 =?utf-8?Q?0+aDT6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWMvcVdMVWUrSnI3R2VGeUE3WUFlN1FjUi9OdmRsQW9yNWhEci93TStVSTQ0?=
 =?utf-8?B?cm9rMTYvUjhaNksydDdMWXYrUTJkOWZUUkJPQm4zYXlzMVdVNWtub2lSUnhY?=
 =?utf-8?B?SjhrL2pKNGJBMHcyWFZTajVwdUhqNkc1RGliRUFrQXNhc1dPcExoZGJJdFNw?=
 =?utf-8?B?Y3h4LzZKbHVEVE8ybTc3bVZtZnpmR3FYd212SnVTbEIzSkUyNzdoSmVRMTYy?=
 =?utf-8?B?SEYrMk1kVGdndDBHM0I1aHN5dXJFSTZwSDBSSXR4Qk1lek9NNXRiSU8rZkp0?=
 =?utf-8?B?MWJFNkx6bDZVY1dGM3hwSU5ud1RRNUdZeE1DN2hoSkYzZDNKTlJpS1JmK2Ri?=
 =?utf-8?B?N2VXTlNPbE1GdVdlRGRvalRqUDdJWVNlMTM5TTMwNFB3RlQ2UFUyYVM0Wkxw?=
 =?utf-8?B?NXRPd3NiWlVOL1pvZjZxc1RsTUhwSFEvN2FrMDFUME5yOU54QU1la1FidnFU?=
 =?utf-8?B?bm1CcWhLaVZ5TFByTzNBanRCaUEvZUNORXZDQ2hicXQyM0g5UXh3NE1mSTNh?=
 =?utf-8?B?eHNZTzV2aWhXRzFSci96SFdBUit2VGVxV05qSFNNVzlodWxSMnVrVU5rVVVY?=
 =?utf-8?B?RGJBWU5SSGlPV2FucitSV3dLbnZiU0NRL1Jhdm5hK1VCVkV5anE3WTdQZVZa?=
 =?utf-8?B?c0lXMFFVTkRwd2J2UWNVTlZXWDBWWUJ6MVJZSXpZczN5L3pJMzUrSm1RODc5?=
 =?utf-8?B?emZzWFdpWDRpa01GWENUVDhZYkNxaXpxSGNSYTB6aWhmeERXWnlwZUU1ZnhX?=
 =?utf-8?B?OUZtdElWWlc5N2I2RUZidlhIL1NGV0llbVNGQUYxNnB3QjV3b0k2bmV0Y2s3?=
 =?utf-8?B?ZEgxNVdPRFdCYk5FRnVBUWVwK2V6ZWVxTGtsQzRSdjJVQkJENGdubXlPNDN4?=
 =?utf-8?B?WjdEblZMUUEzSG92VDdMNHBRYmtYT0dlbnZiU0Y1UThOMS9kZUFKcFJlNW9o?=
 =?utf-8?B?U1c3ZlVjSkZhWEpKaTRGUG1TbkZJQ1VkSytOQVhBS25tTWxwb0c5YzhGWUJM?=
 =?utf-8?B?a0Z1U3ZDZWZDaTlwOGVGc1lOR3g5cWJPK2h1MTl4U0prMS8rQWF6dWNoZEk4?=
 =?utf-8?B?ZGlmRC9uM2kxZFd6cnVYNXlkOWthOVJFYktwNEQxc0xrZjdDYm1LZTd3NTBT?=
 =?utf-8?B?eEwzSUVXY1dKeEZOaWNJTUV3dzc4TnRlWVIyWjd3YllzbFl2Z1FSMjljSnow?=
 =?utf-8?B?MHBhUGdmZktRYm92SXdPbWkzSkN2YkNCbkR2TmwrdDdEZUY5ZXFzS2FHTVAr?=
 =?utf-8?B?eWpsMzIzN0o3bzNvM2dLaCtQY1I1Wm0zaU9ubFQwVDExWFUwWU9WYnFMdFVm?=
 =?utf-8?B?dmxFMWtnK3ZENlY3Qy9JbTZ5Z1hMalB0a0FNMmNmVW51L3ZQOWNpZElkbkU2?=
 =?utf-8?B?UDBJZGZwNDlSR1JlYUgveEorL2FmUlR4M2ZnZ2pjb2VxM21UeFJRS2tZYzN4?=
 =?utf-8?B?T21EVmJ2dU5CVlBVeDNtWHVDaXNBVTF3RGhkRCtYd1FoenhoRHMyUVF3VjBJ?=
 =?utf-8?B?ZHN0K2NQak5MclRmSTlPeHlDS3RoY2ZPREFUc0RPQS94YnhrdHJhWEY0Nklx?=
 =?utf-8?B?RjJVL3dKYlkvQXJ4TGhKVmdXcTB0Z3d0ZXFBelJHS2hpRkpucDdna1RhTm9j?=
 =?utf-8?B?cWM2TUNQK2dyVXp1dFE4WGJzTzBWaFE1SGZXWjNUTHZtTkg0TzZTWnl2ZkdS?=
 =?utf-8?B?aDk1Vjd2MVdJUTNIRmcrN2ZsR2tSSm14NktlQ1Rma09VWGRvOGQ2MVJCaG1Z?=
 =?utf-8?B?L29DWTV5L2VtRkErcDRYZmllTDNGUkdMTlIweWRJNnJzUVl3eGtINy91MUVy?=
 =?utf-8?B?TmhGVXRCTFRCZlpCTnRpRDIvUSs4TFNaMmR6SVY2OGRqTTdkL2xWNHpuR1Iv?=
 =?utf-8?B?aisyN2pBWWExOE9ZakVVeEhjbnphY1MwSXEyRWxXSDI2UkZkbVZpRmZEbDFn?=
 =?utf-8?B?TDZoekZCdlkweExWdVNSMzZXSXhJMmxWbDFlWUIxVmFDbERmdGdsNVRFUDFD?=
 =?utf-8?B?d2V1VUpYRjQ2NVg0cTcvODVRc0xQKzlYZ081TFgvaTUrbDRBNlNvZkp3VUIz?=
 =?utf-8?B?bkFBamZ4bnFpUTBOWWFIYndUZ1VEYzNlMVBzb3kwTWc5YW9sS2tNVFAxVmxC?=
 =?utf-8?B?dlBXWnVzN2J4ZUlLalUrZVIxdEJaSGk1ekVidFQ1TWJFNUlaZjFwSUdYWjRo?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e60f997-0bf2-4d23-6b0c-08de31a1c6fc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:53:23.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqp0u3wDKpsoJ089LZrgkWQA1pJN+KWuHgjH9q/NBRaZgDFXUvAekYEmVN40Y6YjCrueyShur8z3oxQx5l4m+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9178

Add support for setting offset range (calibration) for the ad9434
and fixup vref mask handling.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v2:
Updates according to received feedback:
- embed ad9434 channel description instead of resorting to macro
- change INFO_OFFSET to INFO_CALIBBIAS
- keep offset value untouched in case of error
- drop length from avail_range
- Link to v1: https://lore.kernel.org/r/20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com

---
Tomas Melin (2):
      iio: adc: ad9467: fix ad9434 vref mask
      iio: adc: ad9467: support write/read offset

 drivers/iio/adc/ad9467.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)
---
base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
change-id: 20251201-ad9434-fixes-6dfdc86fb881

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>



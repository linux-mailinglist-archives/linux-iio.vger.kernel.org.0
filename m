Return-Path: <linux-iio+bounces-26997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275ECB42F6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E643012CE4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADD2E2DEF;
	Wed, 10 Dec 2025 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="HCWjOgVa"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021087.outbound.protection.outlook.com [40.107.130.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C371AC44D;
	Wed, 10 Dec 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407293; cv=fail; b=KyWGnIMjdbSHS2M+VxOFtzTruZ58cMdpTWnc0yHl4GseKgvExAVf2xUKm1dy+WyUEpdW+yGhVRuPn65j1pYPY8XgdPP82QSv8n8ZDOQX4fcTAQxCbv42XaCbdgdbISpSboExdanyMYoZxG9VjQg17wW2Y6XJLvWEyg/T5AnYQhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407293; c=relaxed/simple;
	bh=FUQtuOeDk3PLBlG4vdbf4h4wbVXmC0eHnkU7X+dKtr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=skszvXx4Qts7/FtbI/k7w/3AplYNLfZ7Y41fkbjndarJufTca3C1AA0K//etwFzqJJNEe7zeAHJft+3FWiFILVE7V4x6Ae1/WuNmJq3D+M5WXwiTliSS8Kl6YZRXIHvKkgzZgtUJFEJvlTgvBkhypP1AyjxRMY/q5pr58cfwhbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=HCWjOgVa; arc=fail smtp.client-ip=40.107.130.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR1NSd4lT73QYATK6xPa9wIVA3guzXoL/PXvFQ5439nhdfU2XzLCEJqLi1d8wn4x6rI9w28LzrEMYp3IP1+JqyiqPCkLjFdW8KZqDZQI4F6wk3jVmuV2LY3XcffXR4ei5jGw45R5SXUZy0ryL25Ger3+A9SjI7CDjcZVT12FDHwgJAt7uKl3plrmh5Gs1Eeo9w9XwyHAoiBEVXGNEA0FeVRsEYSiCqNW8aSHS5LVlgWCVMyeIgvg77PEoN4zyc5VG59HlplEeiBW6IN5djdd+Z/qzzahL46kd5SYqXYvLrhXZqJotW5UHMVP5y6PKLnLxhjkJ+SZ4qV7dY39v61GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtDaFRKhXZAHsSHOGhmNIbVcpR6Ap/cIAO1Ifqe0UY4=;
 b=YlUGezB3QrVXf/PvsmoZW6WbfQBHlEYBkI2AfljOFRpXjpGmoqqrGWhfQh3hjSDisxWTrpAf04DcV6G4l5jOTIGbaqBbui3jGrFoXd5emmVjhvYa87Zwc65t2odC77gjumNvnWN6L4QhlR1Y4LigxFPBXj+XMHR4x0eFCASeM+l8xW0XvgF/rCU5YYwb6tcnUOsZcYl5IdLYm4ptnpfr4lY2CvdNSiN3TY8nAeucSYi6coNyFKMruemf6ntOiG7nVbHumYawpdak6V5WSBmj2OQsXxgiEpqGgx8AF9rSe6civtGJi3q4zqTBtQjAihcKjDM51a+j3lrj4tF7ZlAGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtDaFRKhXZAHsSHOGhmNIbVcpR6Ap/cIAO1Ifqe0UY4=;
 b=HCWjOgVad3WfGsmwxiVlSLL/in/sIAP5nHAajoltkezojuj7SMIBH7uCI9rx4YqSzhyKI2pMokJv3QHWPPGkkUtVmRahbrN/9WzGP3uA93ERRRbP8tqDAut0YCbSMNXcgPlQexz1ZMtbh8aBNZTQmPPeGIGuznpizF3KmPMUbSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by AS1PR02MB8049.eurprd02.prod.outlook.com (2603:10a6:20b:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Wed, 10 Dec
 2025 22:54:42 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%5]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 22:54:42 +0000
Message-ID: <ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
Date: Wed, 10 Dec 2025 23:54:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
To: Guenter Roeck <linux@roeck-us.net>, Rasmus Villemoes <ravi@prevas.dk>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <87qzt2tnlu.fsf@prevas.dk>
 <17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
Content-Language: sv-SE
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00007576.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f7) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|AS1PR02MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 735b03c3-853f-4292-9337-08de383f1aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHdNbnU5V0VvK3I3c3NtOThwNWQwRkowVWhXRTVYWCszNlYrSFpOWnVIL2U3?=
 =?utf-8?B?U2lrVmkzeklPQjJuYUdaTW5uS2ZZaDVTaXRYMStyZTVUM0NJTFg3bkpXS2dn?=
 =?utf-8?B?cnhKbS9lYzA5UkJ4SG1peHlqOGw5ZlQ1aFFSeWlPeXpnanp3Wkg5ZlFHQkNa?=
 =?utf-8?B?MmZ3ZTN1cG5MSXBhdUdwYytiS3VsWnF0em9FOGhrRk1GVXFFMThFYmJpSVZR?=
 =?utf-8?B?MVVXU0cvSXMrZnpoQ1RqNG9CRStBQkdnUDQ5VU9qdU1sVmxMUFUvN2Fia2ZV?=
 =?utf-8?B?NTJCVXR4ZlEwZzUvM2psS1R3L2luS0cvWGtDZm9FTGRlTnhJaXROdVppZVBF?=
 =?utf-8?B?bDdodGJQd2NwMVZvNlhQcnVLbkpCTXg2QmgyTHlFbllaMzFKeGRBMFB1VzRl?=
 =?utf-8?B?SFIrWFVUYlRaZVc1SHBGNENoaVJ1R3oraGw2dTJjcWVJSGlBMS9HYU4raGZv?=
 =?utf-8?B?N1hxNkJDZlZHN1JqM3NoMFkwTmFBdlprYWlhdWZreDRaQi9Id1VZZmhrRlBH?=
 =?utf-8?B?V201NUF0K2dHQ1l6ejc2Slh2bkJHelkzM0VtRlM5TkdVQ3ptYmd5Y20zbUlS?=
 =?utf-8?B?ZHFMYVNkK3BpU0t0djBWOEQvSGdkTjlEcWttU0RvdjZkWDFKSVcvbmpvd29V?=
 =?utf-8?B?MGFyZUx1d1oyOFlKYzQ3bUtnWXRURjVvemQ1OHNaMVJ0VEhzM1pMTWtoTTh1?=
 =?utf-8?B?c3AveTFvSTVaUjR1S0RyZDk2RW1QV2p3WlhReWdMTXRIcnd6d1hrYUpOL3g5?=
 =?utf-8?B?NVRyQ3J6T3BkL3laYjIvVTRuYUZEYW1oYnd5WkFlUWpVazVhUDdjSnI0TERK?=
 =?utf-8?B?d3dDVjdvb2pxN2FpUUlXQ09NT0JLY2lGUUZsbXJsbGVDeWlIYkI5R095aG5D?=
 =?utf-8?B?TTBMLzgycldrU21HbnBscHFxQWV3Q0U2cjVSdFN2QlYwL1d4ZGR5emkwRWdq?=
 =?utf-8?B?ZXZoa09pRzBxSE4wNTNRcXpKRDVwTmRjMHNyNWxmZU51cUxvK2ZhOTgxM2RU?=
 =?utf-8?B?bXJDOW8wNENkdWpaaTdwMGJjUW9DMWZNWXpLdG43bldYMzIvUnRlSzd3ekY2?=
 =?utf-8?B?TzZpSFAxNkF6dUJoSEY1L2ZJMm8xTzBOZU52ZWxnMGx3K0hGcHlnUVl1MFRo?=
 =?utf-8?B?OTRXTFF6WWlmb1RNMjJFeTF0SzNKQ2hMNWlEWTJJUlpmQU5nUzJpaGFiU3pT?=
 =?utf-8?B?VUhTV2REcStNTzlNSXlscFIrNVpkWDRaelRlb2UxQUpRS09LVlQzaXg2Nk40?=
 =?utf-8?B?dHhtL3lWVGRNeWdXS2lDTmRRSlJ1OWtoeUFsOTZNeHQ5Vnh0TzNUbHA3Uk8v?=
 =?utf-8?B?Qk5EUm1SNTZ2bXB3Y1BYQmtZbVVXRitNQytFdGhjd3dLZEI4bndQa0NHSzVC?=
 =?utf-8?B?Z09kU0hVdmVoakpoVThyTEJXd1d0NzNlMVNsYXI4R3R3Mitrdyt4K2FPQmdP?=
 =?utf-8?B?TFlBZWk0MWZOMFd2a0RDRy9tNCs4Wk5vdXEyblV0VVdFaW1MUmpFUWdNRk9Q?=
 =?utf-8?B?WEFNQlh2dHgwamtpOTlPeE0xK1dIdHA2dFR0SDlucXhpd2pHb1lRRTB3TCtl?=
 =?utf-8?B?Q3ZoK2p6TlJTbkRQcnExWW12TFVqZTU3dUFNcmdmVm5tUmZ2WERxMDc3ck10?=
 =?utf-8?B?dDdRMTlNWHhLMjBvdDNtYU1GaWUrOGhWeGtDVndjRmFrbEdldCtNWnBhdXRP?=
 =?utf-8?B?ZGpOYjk1bFJudTBCRHZTMzdNakF6Y0JTa3ZkelRPQks3K0hQWWU5OHphdDhE?=
 =?utf-8?B?SGw5YThwYmhOZXUzQ2tSMlhOWGlBNzVRd0tZK283UjhmOTBURlkyd3h2cmtm?=
 =?utf-8?B?Q29nZUd2WHNVM3I3d2JLRWhGQUFjdS9XWGdubTVucEoyaFExeTY2R0s4ekY0?=
 =?utf-8?B?Z0tLaFVBVUlJZ0JGMHFvTHFVRWsxeHVoMlhzNVpzU1ZhR2lLVStjT3hpSXJ6?=
 =?utf-8?Q?9CLcO0GsOYcaPYo+yu1pplE3ksLtCdIM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak1Lb2ZSa3BLaDJvNk9FK1NBQ0VSRFdzenNyZlMyYU5UVEt6SG5KNmVyZGlR?=
 =?utf-8?B?dWdpelJDRlk1Qk83cUhLR093OXF2NFk2bUMzSWo5M2UzTUJDZFFYdmFYVThP?=
 =?utf-8?B?a3RnTzdRNFo2cDZVcjIyZmpWQUUrRVRLN0E5UlNTRTJtWm9sM3pFcUxjVlYw?=
 =?utf-8?B?akJ6dmlkM05PcUdRR2FlaDgwQ05pd0lxN1lMMVpzNDAwSHVsVlRGRWhLQzV4?=
 =?utf-8?B?LzhuRjdTNmV0elcrZW9LWWJqSE4vTWlWYTJ3MHE5UC9IN05nbXo1YmNzTHhm?=
 =?utf-8?B?U2h0QjFpSVBMcGlpWHJNWGVubUZ4UmdtVEZQVXB3Mkhmb3J2bElodjBwSS8z?=
 =?utf-8?B?SWMyKzAyemtlcm84TStIVFQ1ZElsNWg2M2tWMkRWeFBBQnRLVHVCU2crSXBD?=
 =?utf-8?B?QUIvdy9VUTY0aVc3OTNoQnpTeXUwRWozTG53U0pBRVBrYXFzTEdjelNVempa?=
 =?utf-8?B?NHg4TFNlT1ZaK3Y2aE9HQlZrWUtURUk4cjlHNUpMQkt2c1hYYzFqWHQwdHVu?=
 =?utf-8?B?UHhvdGxFMnliMTZXYUYrUDlIdmVnbnBkUTBJSWhlc0syMCtVeUthbXkwL3Rj?=
 =?utf-8?B?SkJsS0IzY1JZaGxUbmJXZHo4T3hTb29oRmtZYVJpUlZwUW0wTk9xU1JiVm1j?=
 =?utf-8?B?UHZrQUViWWUzWWcyNE5zZ1ArMTRTbG5Ec2g3M2w1V1FjSDVzSFR2S1hjcFFx?=
 =?utf-8?B?bVI3UHR6OGdiVmlmMHREbmNVR2hZMzRUSVd5UWFSaTV6S3VNd0hkWXJOYkJF?=
 =?utf-8?B?ZldxM1ZGdTY0S2o2TjY3U2JSK0JBU3J1WFVPcExQekN2NFB1bTlreWJ0a2Ft?=
 =?utf-8?B?S2Z4ZG1ZcUF2c1N3STJnQ09GRXNoSG9wcmdKUkdaNU5pRGJ2ZTRmTHNoK0Ny?=
 =?utf-8?B?RG9uamVKR2RMNlZUSG9SaUNLL3JHNVlRYUtXUmNodWRBaFhOWG1DK1N3WWZD?=
 =?utf-8?B?d0I3c1JWdzNYUGM3dlEreXBySUQ5SC9BUUw2N1dmVWdYYUI3cGJuSVh1dUpQ?=
 =?utf-8?B?dXAwVTZJSXJYVUxTSGhwS1l3S0pDUzRib1h2Y0RwbW0rNzNyNFpBMFcvWmY5?=
 =?utf-8?B?amZDWGpOa3E2eTFOaGZ2OTNvNkZ6STcrZWNTUDJEY0pIS0xhcnVjUGJyb0Iz?=
 =?utf-8?B?NjcwSVNUM0NGMDB1cTkxVTFPTkRDOGdqc2IvenNWczF4QXNVK3hGc1hxOE5n?=
 =?utf-8?B?K3E5M3NlbG53YVV1cllPM2VOZmFDSXJnUk10WVNkbDU0TnRyL203eXF6aXhW?=
 =?utf-8?B?Ynptc3MyWXZrb25pQURFRGQ2aW9PNkVDQXV4MzZCWkE5R0M2bkR0Yi9wSEI5?=
 =?utf-8?B?ZnR2M04zbVI3bUh4c1ZNQmZtTC9EbC9QNXpSNW03MThjL1JRNUs4Q005eDU3?=
 =?utf-8?B?V250bWZnSVNSWWQ1aWFldWhBT1FDV0YrQ3piOGdnMnZjM2pWOWlVQlhGalho?=
 =?utf-8?B?bURadXR4TGEwNFJRUkZMZHFNWnQ2Zk54dkswV0RYWW9GMDdwSDBPak9CejRU?=
 =?utf-8?B?cTRXL2JNU0hEOVRMaDA2Qi9Zeld2OUhlMHp6MFc3M2pGZGdybW1PeitRd05B?=
 =?utf-8?B?OThNUXE5RGZWVFlvR0NhSHJXYmplY0hSUVRtYjJkTkZFeWxtY2lUWm16d0pY?=
 =?utf-8?B?QzVFY2dkbmxiYy9PVjE5eklFRWVURkczOEFKNEJxWFJPcFhjTCtTVmRKZ3Uw?=
 =?utf-8?B?WXhGdzRHUmkyalN0eFI2YkJ1YmlHbG1vVld3TXJaTUlyM3BsdUJNUjUrVDA1?=
 =?utf-8?B?NG5tRjlZZXZVbWd5MFphc1JTbWxMb2dIT2YxSC9qdDJUMW95cnVDZUNKTEVW?=
 =?utf-8?B?Q0lQeWU4UG9uSitReEs0NEgxR0RvaTlkekdSSmx1OE0wMGpkVGJKMllOT2s0?=
 =?utf-8?B?ckgrdm52WmF5YnkyMTZiLzJpcUFmRnlZSUdrRWNGeXlySnBkMzRod3ZNR1Zr?=
 =?utf-8?B?S1NiU1o2Vys4V2xlVDdiMjk5a0ppb2RvQU41MFlsZkJLOHJERjVGcnVIWUI2?=
 =?utf-8?B?ZzNhbjhzWVNxeFVFK0NoTngvNHlWaE9IM0gwYWtHbWlCVEowNDZQMHVBdEVh?=
 =?utf-8?B?aFBmTXF2ZTllb0E5dDlkY29WQmtzY1hnYnFsdjI3ZmJYYk5wOWRBV2ltUWE4?=
 =?utf-8?Q?pTz26+IlNvTBmKwfwaH4sPYDb?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 735b03c3-853f-4292-9337-08de383f1aee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 22:54:42.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHKfi+iuaMblXRmGpFj8cR6EO2jeqFi4TdWLgUIlB3DqDvOpIR1PMCTJozN/oyXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8049

Hi,

2025-12-10 at 20:12, Guenter Roeck wrote:
> On 12/10/25 06:31, Rasmus Villemoes wrote:
>> Just accessing a single property under /sys/class/hwmon/hwmonX/ also
>> results in a similar splat.
>>
>> Am I doing things wrong, or is there a genuine problem hiding somewhere?
>>
> The lock is acquired twice in the iio code, once in iio_read_channel_processed_scale()
> and then again in iio_read_channel_raw(). That does look like a genuine problem to me,
> but I don't know how to fix it.
> 
> Guenter
> 

I don't see it?

The info_exist_lock is per iio device and the
iio_read_channel_processed_scale() call operates on the rescaler
iio channel, which is a separate device from the rescaler iio
source channel of the iio_read_channel_raw() call (in this case
from the am335x adc).

So, I think everything is fine, except for the lockdep splat.

If I'm right, lockdep is not informed that recursion may happen
and thus collects the recursive iio calls in the same bin, i.e.
it keeps track of all info_exist_lock uses a single lockdep
class, even though it's not actually the same lock.

Before commit 3092bde731ca ("iio: inkern: move to the cleanup.h
magic") I think this could have been solved with a number of:

-	mutex_lock(&iio_dev_opaque->info_exist_lock);
+	mutex_lock_nested(&iio_dev_opaque->info_exist_lock);

I don't know how to convert that change to the world of guards.

But then again, maybe I'm just wrong...

Cheers,
Peter


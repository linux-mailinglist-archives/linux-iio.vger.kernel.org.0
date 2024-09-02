Return-Path: <linux-iio+bounces-8963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7278968410
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868CC281412
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA313CA93;
	Mon,  2 Sep 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="s6+CcA/C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B513C820;
	Mon,  2 Sep 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271498; cv=fail; b=EXn/qq9cOge4ZGDtf5nXIRhbwBYpNBHNYf1rZg9Qh/wdS00Bquop2j/xzwHDQ2qVuutktv7nY68mXfPaxuVR9f0xkbK6/EhVbvHUhfo24fy3HjOgBJgS22mMIGoKhTmUKu/1kod6XcfSigS6R2HAK++9B2kxq5VTFHz1ceV6Ue4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271498; c=relaxed/simple;
	bh=h2g539hdLdgRyCrNqcT5UwSvS5eYUZ3ZvyyuvrH1JUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foMFG8JWOeySAkGiKR1gTW3bv9Hco7ywHubELbAP6PgsHNRIlHUMQSG19dOZ7er75wHIJgt1nHhVNRP0kLgtPbfrPhZGjV5htd4iRJ3hhQNOtcEhGYXI8gPBJn7GIJAvP9PA+k+cqRv7qkZeLKPG966emqfkWNo1qDJ19xtBzcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=s6+CcA/C; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481MSO3T004738;
	Mon, 2 Sep 2024 10:04:22 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010007.outbound.protection.outlook.com [40.93.77.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bshyh750-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 10:04:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/2cn2nrbkgAv+gpiBHTILHi6XKkKDn3G0nb0R1rMw5vKOImTop2TKvY2aYkXsZ31Np/GvzpOUhPSXBQ3DPXc+ttyralPWLDzRal4An2POG1SVBufesk5nVr/yS5ZZDQcNMuYQBTLXxFEArCByf9KpVJFVjYuggG0pQUMh1XSOF7rH3xC96hLO6SelmeyFEWDGmMUHWKQnZ41hYgnjTMECChURodOxuFJ2S5ivoJtZBzLYuDp83a+eVkoTZZCbs7i93ZwXRB42MVztMPQRB4AthcZI4u2RYr9w72+jjBaGQvGMEREfTrgpuhejOsbBoItQ5mVDb1686mjwXMVvwYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2g539hdLdgRyCrNqcT5UwSvS5eYUZ3ZvyyuvrH1JUg=;
 b=WVd8C9FBuYD6/A0MxngkDL4ulTtjNvDO6QZTTm7Q+mNlky2fKApq6VD8YmeUqXSyKwEZt/NtahgYX15kmGl55VoFBVKxXqfhEFHh81ew4CNJ8zfbTYucdCjH+tv3GgzsmM75nmUeVWkIO0mo7Y+kbNXZjdnvlUPUlkGnP9oQwgfkGB2K/2r0paZXVlPmCubsPbl7ieUym7m5QTTrzYSRmaF8taY3MlIhy+xHrfoX3alEP4z/IYnsGE7S/L8QaRRM8yd1Facc7KejtkN2Rweb/ikT8tKgaCeBvbwhqQ5KQk4me2K58ibYgIEIUvaCh8ktS1JFY/LDuzpPpf3xkMHQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2g539hdLdgRyCrNqcT5UwSvS5eYUZ3ZvyyuvrH1JUg=;
 b=s6+CcA/CcbVOnpZPCm7UeVjfelQcDGDjsQtToMYmdrRDb3Jhe72dlvtzJGCxi3wbBM1McDPPp84n3eE8SnRx29MOT1m/HfizRdi/sX7ftBJR1Gopp/FvbJH0LrlV0IZZLstybzgx1oyJl6x/S8freRhnif1TlY+1CFOVcsX7etlrWVV1ZyRINfi9UhwTLqffiyySlF9mtGqZlVQJQQPqG73btGK3m5ymnL73hWPYfysZsvHSe38C+DaF7L0wrKFKc1l2RjNsbNLpRjRQKDEr1TcIxMtYrzp5ABNiePPqECMaZWrNV4VcZ7Wys4hzh+LXMz/miN5NMmd9SYMR719qpw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB3370.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:04:12 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:04:12 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: gyeyoung <gye976@gmail.com>, Markus Elfring <Markus.Elfring@web.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Thread-Index: AQHa/E8debrMbv/GBEasBsapfpQyyrJC1rSAgAAZzQCAAVTPAg==
Date: Mon, 2 Sep 2024 10:04:12 +0000
Message-ID:
 <FR3P281MB1757324BA65151253A82F8C8CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240901091214.15199-1-gye976@gmail.com>
 <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznvriPOTZHFyNVoNkAce5q2vy+itN5yJ20kCQw3Akn_PEQ@mail.gmail.com>
In-Reply-To:
 <CAKbEznvriPOTZHFyNVoNkAce5q2vy+itN5yJ20kCQw3Akn_PEQ@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB3370:EE_
x-ms-office365-filtering-correlation-id: a941bad8-eb43-4dba-073e-08dccb369844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXVtUDZocENUYjhvaXFyTkU0OGw0K1pVVE5mWTR6RVc0UXJYMXRkRFAxcWFs?=
 =?utf-8?B?QWlRVzlaNTdrOFU4Z1RibVNDYVVybGhybDMxUVFMNndDS2ZkajlodWNGVlBG?=
 =?utf-8?B?U3FOS2g1YzNYT1o3NXNqNmJNUTYyWUNaWEZhSmZJV3JnL3p1eG5GdDlUSXZY?=
 =?utf-8?B?UzRNdklIZmJ3VmpTdUVjSDJJT1RJd293UmZHR213c3JrZGpwMVphUXE2YldV?=
 =?utf-8?B?SWdNRjhrME1PWkpwK0RhY0hkZTdFT2ZDR3BnZW96LytycVQyam4wajJXYzJX?=
 =?utf-8?B?MkVhajBNVkFRWkhPVjQ2TkdDanpCV3Vzc3cyZW1neUJHNGF1UWNVOGdvcHlW?=
 =?utf-8?B?dHVtYkpDRGtUMzBnL2FTTzBxTlFzMnJMOVJvempzU29SMEdJa2pBWGh6QnZ4?=
 =?utf-8?B?bEVMZGs2ekNuRG1MTGZacXVEYUJoOUdKUXlBWnRmV0d3UUljdWdPaVNBRjVG?=
 =?utf-8?B?ZGZsRFRGQWhQcEJmckZmZ3BvR2lxWHZLRk1od2wxYUttYVNFTHpmMHRDanQ0?=
 =?utf-8?B?V1VsWGJyTko4SmdPdUxKMmxFc2JaejM3WmswSUVYdGk2Y1c2QVU4TWpQTGxx?=
 =?utf-8?B?WTdZc1l6dXlvVnFneFdwc0hyb2gwd0Mya1pZQi9jaEo5R1dHa21zZE5DcUlD?=
 =?utf-8?B?K0xteHIwRFFEaTVaQlAvd3VORmpJWjN3ckJXT1BMR2dNc1lOV2lUcG54MnND?=
 =?utf-8?B?ZE40MjVaa3ZZRXkrKytjSkFmSUl1ZHBhdjhDY1RnVG1USG1TRVhzTXRwQU5X?=
 =?utf-8?B?K2pDNFp6WFBobHhRM3F5VGpYa3ZuZk5GWFFBakIycXhCQ2JOemkrejcraFFt?=
 =?utf-8?B?dktLV21nSzJQUnB0QXQ1M2drZS9lc3N6bm10N1Z5WndnTDFNVHhYS1dxU0h4?=
 =?utf-8?B?RnIvdDgvcUpHOE4yU2lMY3Uva1hvY2ZDOWJlbmh4VFhRYS9mNEFtVWtCeVIy?=
 =?utf-8?B?VlRnWjRucXlvcmY5S0xJWDZ3NStSYTdJSTRpVkVVdUVETTRYQk53d2RKMHZD?=
 =?utf-8?B?ZUMvT1Q2cXpjbjZJNXZ0VmprQ0E0Vk9CWHliSWE0MFk2WGI3UlQ4VldqUng5?=
 =?utf-8?B?MFBKYTlVeC9za05McHhuZ3l4TlZtZGo5SUZsNk9BREtnVTZPR2Y1R0o1WTZh?=
 =?utf-8?B?dFNmcjMrZTBvTTV3MXlua1lvVE9PMjgySzA5UFBKeHpyaWJiSGFFZHBOOUtB?=
 =?utf-8?B?Qjd0clMwM1M2Z1pMZXlmeHBybDhMWStkVFZjcFJYVmNadEFOdHllalZrV3NP?=
 =?utf-8?B?SEpMOUxzM0NWUHRENU9LWXhrVXM5K2FGMVhZNDd3WVpGVHY0TjVnNURpRDZa?=
 =?utf-8?B?aGZCQlU1d0hLUGZScjlhOUFNTWV1d2NGOGlmU0lkVkNLbkppU3l5d1prOVoy?=
 =?utf-8?B?bWg4Z1dIa2FPNHJNN3VZVlZsNVdUMnVTVW1VQzRBMEFtNEFhNE1MZWFCK21y?=
 =?utf-8?B?emErT1N3VHc5VnFYOVgrWHZtdjdLb0xFV2dBdURXT2NGODNOWUpCY0FzSGFm?=
 =?utf-8?B?b21TWGRIR0wzNjJHYUhyR1RyVUVBSERsbzJuWmVoM043TllXY0FXUDhlVG9r?=
 =?utf-8?B?dmpEZkpVSWhIb3ZXSUErcmdHbUt6TG9DM0k4SXRvdWZBRSsvSDNJR0pCSnA4?=
 =?utf-8?B?T0prMHp4cHUxS2ZNaXFrZFIvajljQXNFN2dFME9sd1Ztb0ZGM3ZuMXRHckor?=
 =?utf-8?B?bDlpazFjL0RQZlVyMERkRVNHSTZaKy9HWTA2MTdSb2k5V1B1S3piUUpZVXgx?=
 =?utf-8?B?QVlPZUtSb3YyOHpub3plY0FVSCs1RC9qeDRWYzhHTmFJaU5nL0JyNU0vTnlR?=
 =?utf-8?B?NmtUejJWdUo0eGlpVmdlcnVNOEE0b0xQdm5MZ09lSXZ2cFB1cW5XcnVSMUFZ?=
 =?utf-8?B?allLU1FJU3gxRVJMdDRQNnFJVWV0RzQ5MEhEZW9VdHpySkl1bGxVcGRaTmEr?=
 =?utf-8?Q?e6YzmtokVo7t/0O1qqtGbwq+w3k7zLQE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXppa1RjejQ5L2MrWGxRbm1wZi90cmZxZUFLczNJL2FKZStlRWsxVFNKb3Ry?=
 =?utf-8?B?Rys4eXIxeUdhTHNtdVRwMUp3TnJEV1kzaTlUaUZab0pockJ3Q1o2K3YrYm1I?=
 =?utf-8?B?SFg4elBOT2d1bUtpaUMwNWpIaVhvVXh6NFhCTHc1T1pVOWEwNjRpV3RaYXZJ?=
 =?utf-8?B?ZHJ5UTNXbmp2NTk4a0xLSEVyeU5wS2tkNkxsM1dEaHc0KzZnSWhSSFZpQmxw?=
 =?utf-8?B?UXFDa3dUSXJKUGx4ajhGQmhhenFtTWRBMThuUlF6V2hnU0dHd1k3amxuNXBh?=
 =?utf-8?B?RllZdjM4b0pnbXMrNDdVeDVOYW9UNWRIMks2SmhBNEtidnRWU3EySTdxMU5V?=
 =?utf-8?B?c1VKc3kzYWJsbStrY2tUV0RoYXBuTnF0TXFsUWV5QnN5L2dlVkV5aGU0R3Mv?=
 =?utf-8?B?d0dNR091UjZlaVJrNUFqZk9vbXZuOUhxWldNSFZEdk9kMUxXZGEvdExhK3Y1?=
 =?utf-8?B?aklCTUtrbnBuc2FrcmtqU3ZBK2JxZHZQMHk4ZzgyRU1iOVd3QU96SDNvVUYy?=
 =?utf-8?B?dXkwU1RPVzJhcVJFajM3bEZSZFpkVFdGK0V2by83TWpJS3AwVEZuOFdOWCtr?=
 =?utf-8?B?TCtKVU1WRVk3SUxMaTlrNWtOdlZDTDVacXhscHBiU2lxTThTTTVBT0twZGp6?=
 =?utf-8?B?SVdQZkdtbUF5bS84RHBGelBTcS9Sb29kQ2dOek5FQ2JZRDBpV2FYb2EzTGJK?=
 =?utf-8?B?ODA3cTcySEM3cENibSswQ0xMa0kyNCtYVzNPN2RmTWFRai95cm9tVkVjakdB?=
 =?utf-8?B?am9JdENIbjlrNlNFbUoycWZHaW9DSHhHWlphbk5GN00xN2lvQ21XR3ZicUZD?=
 =?utf-8?B?L3gxTVRxM2dsR3RtemVUa0luMmVSVWM4czhRNnNMRmxWK21hOFBIR05qV3VT?=
 =?utf-8?B?aFpBKzZ3QUxqVlFTZHkyVTBwV2prQUpZRjhzei9ERDVFVW9QMER1NWxyd0dJ?=
 =?utf-8?B?MXEvcGtMZEhwaEw1TVFOdldMMTQzOGM3blJDOS9laGJvK1FrL1BsQmJ5cWds?=
 =?utf-8?B?TWZkcldIOVpXMzhIVGVkdFpOV1Z5K3B1NDBtaVB4UEdSV3E1R3IwSEw4dmRH?=
 =?utf-8?B?UzRoRXgzeEhFUkMxYzk1VG1VMHh2ZnR1VEYwNm9NU0lWdFBVMVJBVWZLeTVi?=
 =?utf-8?B?UlFOTER4S0ZQY0g5L09DenF6MlF3bmNBd1hEZm1yelhJN2RTV1puR1NBYXcx?=
 =?utf-8?B?TjF2ZHhoYmM2WG8wVXRkNUw4THcraFNxdzhZRThjaDA1a0UrbnBPZ09kSnpV?=
 =?utf-8?B?NEprUU84T016MG83eDZMdll3ZFM1SkorRkxxdGExSjFaMnFuS0ZTdUJTWERa?=
 =?utf-8?B?MjdwSGdCUkJUaUZBTU9uNDRIMjYzeForZmRUUnlQajdwMmtDbUVxTlJ0dkpk?=
 =?utf-8?B?WkR1OFNLZUpjM0JYR1A5VTczVFYxZFEzZk9ZYkVnSDhrby9LUWdCRThTRFEr?=
 =?utf-8?B?ajVYeGNhNG9zY2lUM2w0QjIzUyt1VGlZdUQ3dktHRDd6VGVpVTRIN3pSRDZx?=
 =?utf-8?B?Y2t6ZFJEMnV5MjJnbG4xUHIyV09vU241MTk4Y3FEbkI0Qll6dkRxU3laeFBx?=
 =?utf-8?B?NFVLdnBncXR1YjVabDlrbHN4VExDdTYyS1ZPeHAycTI1M0JPNzdweTRYbGxM?=
 =?utf-8?B?allCTS9GTTVtTklPTzRvWEQ0VnF1bUFIRktEUmFua0xWRlJoM3U4Y0FGRGdO?=
 =?utf-8?B?SHkyNXY4QlkyUFU5QytsTTVmL0IzbjAySGJXVTV5eEI5Vk8rcHhCNG1SMXlW?=
 =?utf-8?B?MU9PL3V2dmpabTZva3RpelhGSDh4dTlDL0FISmJvUGR5cmc3Vk1BRHRIcmhJ?=
 =?utf-8?B?a1FLWENkOFdINDZEQXk3eE1pVFMzUEFRVlovMThjaDBhR2RDUUhsQXBZaVMy?=
 =?utf-8?B?M212RVl1ajh6UGE4RHB5ejRoc0NPR3R3MmZrblR0YUtQR2JWbmR3Nm5TdnZ6?=
 =?utf-8?B?YXlmNGRwTFNpOHhCTkhqK2syWnBKSDQvcXhyWS9ZQW1ldkJQMGJCdmpZU0Rr?=
 =?utf-8?B?bXg4ZWFkbWorN1VYNjl2QUJmSDVDbWd1NlpXR0U0dndDUDdRS2R6L3FCVE44?=
 =?utf-8?B?bnE0NHBHZ05renJVV29vT1ZGcU1HTFdIZmQ0OWJVRDVYY0J0TmhyZmR2N21i?=
 =?utf-8?B?WVEzZTRoRVB3QWdtTmdmRlR6cEtCanBsb2x6R25YMk01Z2hleXlCdHNCSno2?=
 =?utf-8?B?T1pWK2Vxa3ZHaTBGbFpEUmMwano1UEo0TVFHc3NoaEl0eTFqVlBpZzBVLzFQ?=
 =?utf-8?B?d0cxOFBYLzU3UGpRTDI4clMxYTB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a941bad8-eb43-4dba-073e-08dccb369844
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:04:12.2907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBR4n/MuAGiwxpXiH51d/6xzUngxcbPOsKZsfBC3eXAr6JU0XNN7CwnWtaHu2n3PCFDwLWy5GUUapz9k5k9dwzQ/fHQl1DF2RiUd4enQx04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3370
X-Proofpoint-GUID: EVfqYt1ZJxlFa2RTyCtDICRpKayitLIM
X-Proofpoint-ORIG-GUID: EVfqYt1ZJxlFa2RTyCtDICRpKayitLIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409020081

SGVsbG8sCgppdCB3b3VsZCBiZSB0cnVlIGlmIHRoZXJlIHdhcyBhIHJldHVybiBzdGF0ZW1lbnQg
YmVmb3JlIHRoZSAyIGxhYmVscywgYW5kIHRoYXQgdGhlIDIgbGFibGVzIHdlcmUgb25seSBlcnJv
ciBoYW5kbGluZyBjYXNlLgoKQnV0IHRoaXMgaXMgbm90IHRoZSBjYXNlLCBzaW5jZSBlbmRfc2Vz
c2lvbiBsYWJlbCBpcyB0aGUgZW5kIG9mIHRoZSBub3JtYWwgZW5kIG9mIHRoZSBmdW5jdGlvbiwg
bm90IGVycm9yIGhhbmRsaW5nLiBUaGlzIGlzIHZlcnkgb2xkIGNvZGUgYW5kIG5vdCB2ZXJ5IGNs
ZWFyLCBJJ20gc29ycnkgYWJvdXQgdGhhdC4KCkJ1dCB0aGUgbW9kaWZpY2F0aW9ucyBhcmUgYnJl
YWtpbmcgdGhlIGNvZGUgYW5kIGludGVycnVwdCBoYW5kbGluZyB3aWxsIG5vdCB3b3JrIGNvcnJl
Y3RseSBhbnltb3JlLCBzaW5jZSBpbnZfcmVzZXRfZmlmbygpIHdpbGwgYmUgY2FsbGVkIG5vdyBl
dmVyeSB0aW1lIHRoZSBmdW5jdGlvbiBpcyBjYWxsZWQuCgpCZXN0IHJlZ2FyZHMsCkpCCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206wqBneWV5b3VuZyA8Z3ll
OTc2QGdtYWlsLmNvbT4KU2VudDrCoFN1bmRheSwgU2VwdGVtYmVyIDEsIDIwMjQgMTU6NDAKVG86
wqBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPgpDYzrCoGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1l
cm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgpTdWJqZWN0OsKgUmU6IFtQ
QVRDSF0gaWlvOiBpbXU6IGludl9tcHU2MDUwOiBSZW1vdmUgZHVwbGljYXRlIGNvZGUgYmV0d2Vl
biBsYWJlbHMKwqAKVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gVW50cnVzdGVkIFNlbmRlcgpZb3Ug
aGF2ZSBub3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQgd2l0aCB0aGlzIHNlbmRlci4KwqAKSGVs
bG8sIEkgYXBvbG9naXplIGZvciB0aGUgaW5zdWZmaWNpZW50IGV4cGxhbmF0aW9uLgoKLS0tCkJl
Zm9yZSB0aGUgY2hhbmdlOgoKImVuZF9zZXNzaW9uOgogICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9j
ayk7CiAgICBpaW9fdHJpZ2dlcl9ub3RpZnlfZG9uZShpbmRpb19kZXYtPnRyaWcpOwogICAgcmV0
dXJuIElSUV9IQU5ETEVEOwoKZmx1c2hfZmlmbzoKICAgIC8qIEZsdXNoIEhXIGFuZCBTVyBGSUZP
cy4gKi8KICAgIGludl9yZXNldF9maWZvKGluZGlvX2Rldik7CiAgICBtdXRleF91bmxvY2soJnN0
LT5sb2NrKTsKICAgIGlpb190cmlnZ2VyX25vdGlmeV9kb25lKGluZGlvX2Rldi0+dHJpZyk7CiAg
ICByZXR1cm4gSVJRX0hBTkRMRUQ7CiIKLS0tCkFmdGVyIHRoZSBjaGFuZ2U6CgoiZmx1c2hfZmlm
bzoKLyogRmx1c2ggSFcgYW5kIFNXIEZJRk9zLiAqLwppbnZfcmVzZXRfZmlmbyhpbmRpb19kZXYp
OwoKZW5kX3Nlc3Npb246Cm11dGV4X3VubG9jaygmc3QtPmxvY2spOwppaW9fdHJpZ2dlcl9ub3Rp
ZnlfZG9uZShpbmRpb19kZXYtPnRyaWcpOwoKcmV0dXJuIElSUV9IQU5ETEVEOyIKLS0tCgpIZXJl
LCAnZmx1c2hfZmlmbycgYW5kICdlbmRfc2Vzc2lvbicgYXJlIG5vdCB0aGUgc2FtZS4gSG93ZXZl
ciwgdGhlCndvcmsgb2YgJ2ZsdXNoX2ZpZm8nIGlzIGEgc3VwZXJzZXQgb2YgJ2VuZF9zZXNzaW9u
Jy4KCgpPbiBTdW4sIFNlcCAxLCAyMDI0IGF0IDk6MDjigK9QTSBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPiB3cm90ZToKPgo+ID4gJ2ZsdXNoX2ZpZm8nIGxhYmVsIHBlcmZv
cm1zIHNhbWUgdGFzayBhcyAnZW5kc2Vzc2lvbicgbGFiZWwKPgo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kX3Nlc3Npb24/Cj4KPiBUaGUgbnVtYmVyIG9m
IGFjdGlvbnMgZGlmZmVyIGJldHdlZW4gaW52b2x2ZWQganVtcCB0YXJnZXRzLgo+Cj4KPiA+IGlt
bWVkaWF0ZWx5IGFmdGVyIGNhbGxpbmcgJ2Vudl9yZXNldF9maWZvJyBmdW5jdGlvbi4KPiA+IHNv
IGkgcmVtb3ZlIHRoYXQgZHVwbGljYXRpb24uCj4KPiAqIFlvdSB3b3VsZCBsaWtlIHRvIHNwZWNp
ZnkgYSBjb3JyZXNwb25kaW5nIGdvdG8gY2hhaW4gYXQgdGhlIG1vbWVudCwKPiAgIGRvbid0IHlv
dT8KPiAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVu
dGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9oPXY2LjExLXJjNSpuNTI2X187SXchIUZ0
cmh0UHNXRGhaNnR3IUVGTXVQRndZN29pRVhxR21Hak5HcEFINEVabF9tR1ZiMTB2dTJYb08yWDRm
TlI1MHk0Nnh1bGpybDNoT2pVTFprT0VfZDZGbE5xRnozWENaWTlkLTFWMCRbZ2l0Wy5da2VybmVs
Wy5db3JnXQo+Cj4gKiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGluY3JlYXNlIHRoZSBhcHBs
aWNhdGlvbiBvZiBzY29wZS1iYXNlZCByZXNvdXJjZSBtYW5hZ2VtZW50PwoKZmlyc3RseSBJIHVu
ZGVyc3Rvb2QgdGhhdCB5b3UgbWlnaHQgYmUgcmVmZXJyaW5nIHRvIFJBSUkuIGJ1dCBJIHRoaW5r
CnRoaXMgaXNzdWUgaXMgbm90IHJlbGF0ZWQgdG8gUkFJSS4KdGhhbmtzIGZvciByZXNwb25zZS4K
Cj4KPgo+IFJlZ2FyZHMsCj4gTWFya3VzCgo=


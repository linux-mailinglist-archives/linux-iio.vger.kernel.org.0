Return-Path: <linux-iio+bounces-9179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9773596D310
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52521283EEF
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A1197A95;
	Thu,  5 Sep 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Rx4JddcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD33197A7A;
	Thu,  5 Sep 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528371; cv=fail; b=mDWRm1ZksEOSpL3zjiNHB90WtNyK1vmVWl7ecKdHVq/DjYdU3zxMq2adSAVL9qtNck9X47/ILGcM8JJf/q/Q+DZrkxF5zYVI7sJkXzpF9o8NsKXqb10J0TFmYUL7vtrbuJnmp8kpK6g/nJNmOhpxypOghgF68TIZMMHKr1SFXGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528371; c=relaxed/simple;
	bh=y9AEnM53jDRROVfwkFDyL0YRQYZjpoxwH8crDmuy7Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YkP6bCAihZbXnDyDEx6Hqr7775DAs+cdkdc25MaQVVKXSOwz6IHXD8lMRmSaaaJYnu9QEsbxmmNgTvc/HIiBN0n/gPdoMJhrHMvM8I3ZDXHXOP+5F/d4QQJ9wIio9uFRrU5jk0O0cJ7vEAisTaoDtZ1PN1/mU1vHbBXG5arJyaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Rx4JddcI; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484MZm2G007592;
	Thu, 5 Sep 2024 09:25:38 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012051.outbound.protection.outlook.com [40.93.78.51])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bvhk3sxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 09:25:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWhFQI0YqvyGEegSHrydTcLI2aVNOeA3bk6zshOcHUVLVtOMp/RRCyY4rstyVqsdJi2Mnqk/jtaTxPpfuRhisnVodH52EIum3wU7AafAs3Wk+s6ViIcfLel39tdFkrvrQGY+BNGOHK6cGhM5B/f62CP2Aw2g3bB+X+NM/36NroN2x7JPU9mjNJ0X61RSa5ruB6RKPdM8Av8rug7545abYc8Az4HJ3WA81/xWQmH6cpOqG8Q8BdWt49xJXmNGph9FXT/qMbrNSNxuXGiF6EgxK5y1C14tPVkSq8o+vd5Ph4X8LOzVNGi37iKlaDVjqNPLzvBBgtSwW1nZ7so3pC3v9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9AEnM53jDRROVfwkFDyL0YRQYZjpoxwH8crDmuy7Ng=;
 b=JCCPvHTsr/TGgjVla7PeyoS195RiSbt0SCIymoFEEZsIciJWSkGnNmrKQPKlIwTAdD3EEbBG72CLCLwVFCw3qmwoLuil75ILVKfvsL+BB+MFuCs97oYv/fzxMc9s0TF0LiEE0kfuANMM7c6Tx8O6tGKNUyrIfkzAh4lSO3AW25iqzIVc1b4tx9Dv4kjGKkCm6AhakKXd56jH+w+zIxazTuIbamWpK1aOxwgplfwfAbmeA6Y22/h+uecYtnMfvPeGvF6XEYLVNkk4U5BKNCWcY1zpVWGbOl7+VuskcvfCMP1fz3/bM+RHdYUewL26KOJw4r0v4c92isWPWRRdrHR1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9AEnM53jDRROVfwkFDyL0YRQYZjpoxwH8crDmuy7Ng=;
 b=Rx4JddcItyvKZ5sDnDCAzDgXFg55FJPiLbZ3XROIKXAwbe/+P4fwt1FKatfTiPRY3d6l2KmAhrHwDwIH0HifJr5c6Wsrt3WzPJmpnQxxnX9oAp+FpYYTxNYcEkwpGXNeqPO/QG/zrgwBkNMOWzWTXzBg8wG2fOFfx6v2S5Ao7v4RjBYhCTa7Hd3bcajM4z5Un7RNJ0h4yUL/qx8mufiNcOIiJycL7FNVoG57feLujiWt/+dSCkl9hdA+TpgfBRbX7nwmpo7coHN5WBHW+xwrs1uYQxS3mJy5avInY8cAn2CM87H2ZgciEKIJbqY/jnf7FBXdjYb+4kDTgJoWkRiZRw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR5P281MB4584.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 09:25:34 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:25:34 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: jason liu <jasonliu10041728@gmail.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Topic: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Index:
 AQHa9rmgqTimB9qMZ0ezhD6k7oXBDbI5M8nJgAAiAACACRXAgIAAnB8AgADWk4CAAHDr24AAGpOAgAL6loCAAZkXhA==
Date: Thu, 5 Sep 2024 09:25:33 +0000
Message-ID:
 <FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20240902113101.3135-1-jasonliu10041728@gmail.com>
 <CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
In-Reply-To:
 <CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR5P281MB4584:EE_
x-ms-office365-filtering-correlation-id: c4c85570-e02f-40d3-d4a6-08dccd8cb138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUFDM2gySW42ZXl5N3l3RFNPa0NwSk8wV0t2STlHUUw2UnhpbWFhaC9zRklF?=
 =?utf-8?B?R3dTNXk1WlZMQjdEcEJtUFdSRExoeDVtSUJLOGZaQWNHMlFPbWN1clVCVXQw?=
 =?utf-8?B?UnBlVUZGbUtoS0UwQW9xNzZoZSs1TWtmQTNBaG9vd2R5MEx6WU1mNm1NT0xB?=
 =?utf-8?B?R2t4Uzl6UHVLbEhvcTRwMHZ0bkhkRXI0ZkoyRlZPK2xMMUlKanpZZzZMRWNO?=
 =?utf-8?B?cFFMMVVIZEJZNndwQmVkUGJFVVphZnFyR1BtOHpWT2FPUzNTUjg5M2NKMGVM?=
 =?utf-8?B?bmx6eTVPdmtoUTZKdXpkZVhIbng3MGtGcExnTVViQnovNzFBNGtTTjZJSzZM?=
 =?utf-8?B?clZrNjluOWU0VGVhcE1UcFpSRURicUNxaXg3U2txNTNYaFVYdENYUzNiTENS?=
 =?utf-8?B?Y0JFUWFLbWJmZmJzWm1hV21Ba1ZIR3pPQ0d3cTVSNXBNZSsrUTRMNkVMZ3Vx?=
 =?utf-8?B?TXJwQ1R4VG9PSDNsTTlneXNnbHVKTE5xczd4V2N0OFcrYmNwQ3ZleWZpVmZB?=
 =?utf-8?B?SG4rTWZuaDk2MG1YTC9pQTJoSURQOTV6ZDBraTRILzlJL3RhREdJT0lKSVND?=
 =?utf-8?B?U2Ywdmx3cFdDbTkzS0ZFUmVRT2ozR1lsU09LWDhEdTlqbzdZNG1TZkZKQjBy?=
 =?utf-8?B?OXJBMGdNa2pycXdqQ2lMZGlGeHFOQVFhWGVvSWJZU21DZG1iclZDczBaRXVD?=
 =?utf-8?B?NWVNVTFjRForZzc1czRZVWJtVThlVUpQdjU5VlpDcmJXZ2JNK2ptNzN1SDhQ?=
 =?utf-8?B?RkltYkFoMCtUMFVsSGRqeWJiY0p2alZ4UjEyUXMzb0NIaXBmZTJtcXF3U0xF?=
 =?utf-8?B?RHRtZFNEUVNmOUFZOGJvZTEwUGVZTVpNbUhpWW1oRVRYY2tBTGR3OGxnVHAz?=
 =?utf-8?B?S3BPM0dJUi94Ny9Vd2xseGZlSG82RWtUemtrcEN2dzBJYXpVZkFVS2tDQmJE?=
 =?utf-8?B?bWpsYWZsSzhINXoyOFVsS1hLN1ZMbUl2bkVxUG5mRC9yN0VjTlRsTDd3bnZL?=
 =?utf-8?B?SnBVWXlVYUZUYUMvM3ozV1F1RUJCRDZqTU5WbWQzbmNOQVBhTmN1N3ZuY0Ni?=
 =?utf-8?B?MTllVWtqbmt2WlF6U2xzb1RMNEI4bHBwZXpVQllod0M2N2ZzSktVNmoyV0Ji?=
 =?utf-8?B?WEx0a1VuVkVOek1Wcy9wY0k0Z0crZGpsUVo5aVBGRy8vMURTakFWem5EM3R1?=
 =?utf-8?B?TE5jK1Y4NmVaNlZNRitlK3Q0K2QycjVRVzFjQ3d1RmNtTG1GUFRHN3dldlJR?=
 =?utf-8?B?Y3F0Nnd1amU3akg5WExjRHdST3lzMUhkZFF0N21ZeUxzUncrU3VHL21EcXFS?=
 =?utf-8?B?bXM1a0NHV2JNbUJWeXdUQjVyRlhLc3JCL1JMeDBBL0FQVzVwcTdnSGFYb3Jq?=
 =?utf-8?B?YnFVZmtDR1NyM2dQa1dmeUw3KzdzM25XN3FUV0NSK2RzT3VDTnpuWTdaeWNK?=
 =?utf-8?B?bnZkZ1B4Qkg1LzVwTmFESytaMTNCVXh1a1l5MG1XT1BKT2QxRGxlbU93S3N2?=
 =?utf-8?B?MDhKU3R0UFJMT29abGVwOEtKMGlGWE1xTzRZRzAzMDc3UjAwNk94eHpwdlVX?=
 =?utf-8?B?ZXY3L01sWFpRUXk5NXN5YkhxSHhrZzFvZTdYVXYwUitRdDN6ZzRzODdyRGJQ?=
 =?utf-8?B?RjVGY3QrclAvRUlzUmNxblRFV0d1MTA1dkJiMFU1K1BXQjBwb2R3MzdOcmFP?=
 =?utf-8?B?V0JWeWtrK3hjQ0FZcC9DcHB3T3hPcUU2bzQ0YWV0TU94VTRIN3lNMEFDOHJO?=
 =?utf-8?B?LzhvU3ZnOU80NCt6YUZEZVFndEpwci9yUndVandoa2hjMW8rR21YZWRoUkhD?=
 =?utf-8?B?MHRxZ253N1A5S2NhSi9VVklPNjNRTmZMdGs2bTJ2SmdxMnJGTkZqODR2czBZ?=
 =?utf-8?B?NjZteU04TXpsckVaRDFPNThiV010MWVlS2w0MXlxN3BTeE1SVlZzL1MyYWk5?=
 =?utf-8?Q?RxpTdD/YrgU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTJ0VVdFSzNWc1hlSWh2TEMrd1pOZG8wVzI1UlRRNU9oNGowcGkvdHVJREdP?=
 =?utf-8?B?WGl3L04vWWJFdmVhSHBJcEJYTFJweXYrbFE4ZXlYd3U2MjJDVkRpRWJsWDFL?=
 =?utf-8?B?cE1zNzEyUW1FWmdSSnNBWmVsNndZaXFGVUhEVDZsMS94aXpaKzdXb2RiQ2ZL?=
 =?utf-8?B?eDlWMHI5eEVsUUxJSHZUQjBRVXkvOGR6MU1aZmhaY1RMVEdkT3FDOE1CQkpQ?=
 =?utf-8?B?blJSRzJhaUdOOVBuOVMydk9KSmc0bjFZNHRQaEVSTFVDZzZLb2ZrV2VIRWdr?=
 =?utf-8?B?K3ZJbm1tdEJ1Znl6cDVYME9XaDJOLzBnSW96NXpoa2tNcG9KaUdWNTYzWCtG?=
 =?utf-8?B?SCtjc3JGWGhYaUxNSkRZdjJOR1RYWkJqNXBBVGJyeXhFclhDeHN6NGZlRGt2?=
 =?utf-8?B?VklpOGpUWGVkUmxJN2l1OFIzODhNQVVZSEcxbkNpL3NvZFRxOGZvSjZyaExi?=
 =?utf-8?B?TVVIdDI2ZEwzb3pscTIxa3BPM3drM1RtOXBUaXJFUy9tVlVDVndndXRBYXNx?=
 =?utf-8?B?b1RjZFVRTWdCRklQSEt3NXJIcWZYeUZyYjNWK0srdkVoQmFXVmNaclh0VmVC?=
 =?utf-8?B?MU1oRFRaTW9uMncwUnU4dmdja0w2cWMvZGI0dGdJRG1RT0s1N05KU1pjSTVH?=
 =?utf-8?B?SkdkL3k5QjRmd0xBVWh0d0JwcDR6V1hhYjFIKzJJUmxURW5CeGZvaHB4Nlg1?=
 =?utf-8?B?cUF6SFEyRFUwQjQ5WjBzaUdIM3UvRWNmdzJxMGxwTmluQS9ISTBOYVgvNFNs?=
 =?utf-8?B?Vno0ZW9SbVhzby9jejFvdDVPakd6Qk5yR0lkRGd2Zm5VRER2Slp3OUt6Qjhl?=
 =?utf-8?B?Wlcxd2xEUE1mU2ZiZSswWTM3NjdkL3lSV08vM3pZQzc4QjI3Zm1iT1RGckIx?=
 =?utf-8?B?Q0tqR05PY3FMeTltRTlzN0Vwc0pma29CYks3N2kveHlaZVMwc1ZZM0h5TldJ?=
 =?utf-8?B?NnlVZ3BVV2tMa1YxelJVc0M5MXFkZG1BbW4raGN0c2lDWnNwQTVueHo1NjZt?=
 =?utf-8?B?NldLWVhHdmZQWGVJTERNQmIvOFZERWxNQm9CQXNsc01HZHpFZG0yLzlwSkRJ?=
 =?utf-8?B?NlZFT2xlWFJNdG5Mb0FCWTMrN0tSUFA0Ukw1MFluVllDWjZMSnUybGpVbWI2?=
 =?utf-8?B?SU4yMVE3UGhLVTBRcVR6emo5NmhyWDhNb2NERlhvVTNCRjF5dSs4QlRzTE9o?=
 =?utf-8?B?TmZWS3ZVM1lUa3hvU1lWcXZEZHcyZzhoTzBUTFVJamRtY2NKZUZoRTU5TFdl?=
 =?utf-8?B?bm9UUlN4OURkVUpQUmJZUU1GVThuTHhrYmowK20wTGN0anBrN3NqRW5aQ1Jj?=
 =?utf-8?B?Yyt6dllVNEVqa3kwUFIvTld4aENjUzlYakhnakhVQmRlSGlFY2U5M09Wd2tN?=
 =?utf-8?B?aXQ5cXRmYUl2QWtLai8rWmtXTHNuazF4RzFKdkFIQUNyV3ZQZFNmcEo0OERQ?=
 =?utf-8?B?SkpDN2psbGswZEpKelEzRE1YcDJzazZVM0lZUkNCL3A5UzV0T3NOaXpSckpv?=
 =?utf-8?B?TkdrMnVybTl6MC9jV0dMdzlsUlZvYVI4ZUE4d1g5RW55Y0VqazNVd3J6d0o3?=
 =?utf-8?B?U2hiSUpvTzk3cHhBV1lvcHVJeGQ0czY1Q0FuVlBoVmpQcmlpWjFGR3VjRGww?=
 =?utf-8?B?MDMvb2Mvek9nZExlOU9VZVVNVmw5Q3V2SmdrQVpwZXNrSTVOUE0xNXFaRm82?=
 =?utf-8?B?K0kySWxMZjZaZVJ5WktZdFRGMnN2a3o5b0tHV1g4UjJObUdWZEE0RWVVRzRG?=
 =?utf-8?B?S2RVQlZuTFd4bkRLK0F0RGxXN0dWSndvQmFWMDRmbEZSOEdoQmVRd2ZFTzRo?=
 =?utf-8?B?NXlWdHlTeDRBaEpCSWV4aFB4aGxRbHdSdWZpOG5EZDhhWTUwNjR1Y3d1RW9Q?=
 =?utf-8?B?ckdWMkhmaE9ybW01c3RnZ2FINjY5Q2NnZG5wRzR0c29DVXhnbmdzY3ozMjJY?=
 =?utf-8?B?dnR4ckMvNTFjdVRhcWtFMUUxbXRQNU5nMzZMUmpUbUlFa2F2b3dxc2E5amhS?=
 =?utf-8?B?R3V1SDF6SlNGQVV6Vzd0d1JTdnZGVzBXN3FzcVM5R0NwOWNpNG9ObUIrYkMy?=
 =?utf-8?B?aitYd2dBazJEck9zNkF2S3JobTFFY05KRlNRdUJIQk0vZjN0Z09FNDZiOXhy?=
 =?utf-8?B?dlFmNzA2SEkwSWJrOFlpbkxBVTJZbzA2eWg1bG9aUmlyanNieWhzZDdhL1lU?=
 =?utf-8?B?QWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c85570-e02f-40d3-d4a6-08dccd8cb138
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:25:33.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pOJGBCb06muVFQsYEclBsJ1+KcnntGoXqo1PS/EYNe8VgPwyqIIkhByRc4uiQidl3KaG03TquFFM14VrrcMag1UN6KjKKskFs8GrpgykrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4584
X-Proofpoint-GUID: utv8UbkoQ0dMU5UgWrjjXFtdIHMPx314
X-Proofpoint-ORIG-GUID: utv8UbkoQ0dMU5UgWrjjXFtdIHMPx314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050068

SGVsbG8sCgpsb29rcyBnb29kIGZvciBtZSBub3csIHRoYW5rcyBmb3IgdGhlIHBhdGNoLgoKQWNr
ZWQtYnk6IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRr
LmNvbT4KClRoYW5rcywKSkIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KRnJvbTrCoGphc29uIGxpdSA8amFzb25saXUxMDA0MTcyOEBnbWFpbC5jb20+ClNlbnQ6wqBX
ZWRuZXNkYXksIFNlcHRlbWJlciA0LCAyMDI0IDExOjAwClRvOsKgSmVhbi1CYXB0aXN0ZSBNYW5l
eXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPgpDYzrCoGppYzIzQGtlcm5lbC5v
cmcgPGppYzIzQGtlcm5lbC5vcmc+OyBsYXJzQG1ldGFmb28uZGUgPGxhcnNAbWV0YWZvby5kZT47
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PgpTdWJqZWN0OsKgUmU6IFtQQVRDSF0gaWlvL2ludl9pY200MjYwMDogYWRkIGludl9pY200MjYw
MCBpZF90YWJsZQrCoApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBVbnRydXN0ZWQgU2VuZGVyCllv
dSBoYXZlIG5vdCBwcmV2aW91c2x5IGNvcnJlc3BvbmRlZCB3aXRoIHRoaXMgc2VuZGVyLgrCoApI
ZWxsbywgZG9lcyBwYXRjaCB2MyBtZWV0IHRoZSByZXF1aXJlbWVudHM/CgpCUi4KCkphc29uIExp
dSA8amFzb25saXUxMDA0MTcyOEBnbWFpbC5jb20+IOS6jjIwMjTlubQ55pyIMuaXpeWRqOS4gCAx
OTozMeWGmemBk++8mgpBZGQgdGhlIGlkX3RhYmxlIG9mIGludl9pY200MjYwMCwgc28gdGhlIGRl
dmljZSBjYW4gcHJvYmUgY29ycmVjdGx5LgoKU2lnbmVkLW9mZi1ieTogSmFzb24gTGl1IDxqYXNv
bmxpdTEwMDQxNzI4QGdtYWlsLmNvbT4KLS0tClYxLT5WMjogZml4IHVwIHRoZSBmb3JtYXR0aW5n
IGFzIHJlcXVlc3RlZAotLS0KVjItPlYzOiBhZGQgaWNtNDI2ODYgKElOVl9JQ01fNDI2ODYpIGFu
ZCBpY200MjY4OCAoSU5WX0lDTV80MjY4OCkKLS0tCsKgZHJpdmVycy9paW8vaW11L2ludl9pY200
MjYwMC9pbnZfaWNtNDI2MDBfaTJjLmMgfCAxNyArKysrKysrKysrKysrKysrKwrCoGRyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX3NwaS5jIHwgMTcgKysrKysrKysrKysr
KysrKysKwqAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9pMmMuYyBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2kyYy5jCmluZGV4IGViYjMxYjM4NTg4
MS4uOWU2NWZlZjA0YzM5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAw
L2ludl9pY200MjYwMF9pMmMuYworKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2lu
dl9pY200MjYwMF9pMmMuYwpAQCAtNzEsNiArNzEsMjIgQEAgc3RhdGljIGludCBpbnZfaWNtNDI2
MDBfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkKwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnZfaWNtNDI2MDBfaTJjX2J1
c19zZXR1cCk7CsKgfQoKKy8qCisgKiBkZXZpY2UgaWQgdGFibGUgaXMgdXNlZCB0byBpZGVudGlm
eSB3aGF0IGRldmljZSBjYW4gYmUKKyAqIHN1cHBvcnRlZCBieSB0aGlzIGRyaXZlcgorICovCitz
dGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgaW52X2ljbTQyNjAwX2lkW10gPSB7CivC
oCDCoCDCoCDCoHsgImljbTQyNjAwIiwgSU5WX0NISVBfSUNNNDI2MDAgfSwKK8KgIMKgIMKgIMKg
eyAiaWNtNDI2MDIiLCBJTlZfQ0hJUF9JQ000MjYwMiB9LAorwqAgwqAgwqAgwqB7ICJpY200MjYw
NSIsIElOVl9DSElQX0lDTTQyNjA1IH0sCivCoCDCoCDCoCDCoHsgImljbTQyNjg2IiwgSU5WX0NI
SVBfSUNNNDI2ODYgfSwKK8KgIMKgIMKgIMKgeyAiaWNtNDI2MjIiLCBJTlZfQ0hJUF9JQ000MjYy
MiB9LAorwqAgwqAgwqAgwqB7ICJpY200MjY4OCIsIElOVl9DSElQX0lDTTQyNjg4IH0sCivCoCDC
oCDCoCDCoHsgImljbTQyNjMxIiwgSU5WX0NISVBfSUNNNDI2MzEgfSwKK8KgIMKgIMKgIMKge30K
K307CitNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgaW52X2ljbTQyNjAwX2lkKTsKKwrCoHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGludl9pY200MjYwMF9vZl9tYXRjaGVzW10gPSB7
CsKgIMKgIMKgIMKgIHsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmNvbXBhdGlibGUgPSAiaW52
ZW5zZW5zZSxpY200MjYwMCIsCkBAIC0xMDQsNiArMTIwLDcgQEAgc3RhdGljIHN0cnVjdCBpMmNf
ZHJpdmVyIGludl9pY200MjYwMF9kcml2ZXIgPSB7CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5v
Zl9tYXRjaF90YWJsZSA9IGludl9pY200MjYwMF9vZl9tYXRjaGVzLArCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAucG0gPSBwbV9wdHIoJmludl9pY200MjYwMF9wbV9vcHMpLArCoCDCoCDCoCDCoCB9
LAorwqAgwqAgwqAgwqAuaWRfdGFibGUgPSBpbnZfaWNtNDI2MDBfaWQsCsKgIMKgIMKgIMKgIC5w
cm9iZSA9IGludl9pY200MjYwMF9wcm9iZSwKwqB9OwrCoG1vZHVsZV9pMmNfZHJpdmVyKGludl9p
Y200MjYwMF9kcml2ZXIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYw
MC9pbnZfaWNtNDI2MDBfc3BpLmMgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9p
Y200MjYwMF9zcGkuYwppbmRleCBlYWU1ZmY3YTNjYzEuLjc1NDQxYjJiZTE3NCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfc3BpLmMKKysrIGIv
ZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfc3BpLmMKQEAgLTY3LDYg
KzY3LDIyIEBAIHN0YXRpYyBpbnQgaW52X2ljbTQyNjAwX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGkpCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaW52X2ljbTQyNjAwX3NwaV9idXNfc2V0dXApOwrCoH0KCisvKgorICogZGV2aWNl
IGlkIHRhYmxlIGlzIHVzZWQgdG8gaWRlbnRpZnkgd2hhdCBkZXZpY2UgY2FuIGJlCisgKiBzdXBw
b3J0ZWQgYnkgdGhpcyBkcml2ZXIKKyAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNl
X2lkIGludl9pY200MjYwMF9pZFtdID0geworwqAgwqAgwqAgwqB7ICJpY200MjYwMCIsIElOVl9D
SElQX0lDTTQyNjAwIH0sCivCoCDCoCDCoCDCoHsgImljbTQyNjAyIiwgSU5WX0NISVBfSUNNNDI2
MDIgfSwKK8KgIMKgIMKgIMKgeyAiaWNtNDI2MDUiLCBJTlZfQ0hJUF9JQ000MjYwNSB9LAorwqAg
wqAgwqAgwqB7ICJpY200MjY4NiIsIElOVl9DSElQX0lDTTQyNjg2IH0sCivCoCDCoCDCoCDCoHsg
ImljbTQyNjIyIiwgSU5WX0NISVBfSUNNNDI2MjIgfSwKK8KgIMKgIMKgIMKgeyAiaWNtNDI2ODgi
LCBJTlZfQ0hJUF9JQ000MjY4OCB9LAorwqAgwqAgwqAgwqB7ICJpY200MjYzMSIsIElOVl9DSElQ
X0lDTTQyNjMxIH0sCivCoCDCoCDCoCDCoHt9Cit9OworTU9EVUxFX0RFVklDRV9UQUJMRShzcGks
IGludl9pY200MjYwMF9pZCk7CisKwqBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBp
bnZfaWNtNDI2MDBfb2ZfbWF0Y2hlc1tdID0gewrCoCDCoCDCoCDCoCB7CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC5jb21wYXRpYmxlID0gImludmVuc2Vuc2UsaWNtNDI2MDAiLApAQCAtMTAwLDYg
KzExNiw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBpbnZfaWNtNDI2MDBfZHJpdmVyID0g
ewrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAub2ZfbWF0Y2hfdGFibGUgPSBpbnZfaWNtNDI2MDBf
b2ZfbWF0Y2hlcywKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLnBtID0gcG1fcHRyKCZpbnZfaWNt
NDI2MDBfcG1fb3BzKSwKwqAgwqAgwqAgwqAgfSwKK8KgIMKgIMKgIMKgLmlkX3RhYmxlID0gaW52
X2ljbTQyNjAwX2lkLArCoCDCoCDCoCDCoCAucHJvYmUgPSBpbnZfaWNtNDI2MDBfcHJvYmUsCsKg
fTsKwqBtb2R1bGVfc3BpX2RyaXZlcihpbnZfaWNtNDI2MDBfZHJpdmVyKTsKLS0KMi4yNS4xCg==


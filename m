Return-Path: <linux-iio+bounces-25733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADAC24B1E
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C9018989F9
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB7342169;
	Fri, 31 Oct 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Bc9isx1C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8F341AC1
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908831; cv=fail; b=FrfBL8OtGrqm88GehaU1o+tg4lMRweNkz3vJZpk/goaPX36OXu0FeYMFL5MSd7RvfOYAkgOliv78RTOQlXNaBYzsGXjDqe+MKsGYTLQP2FjiDuVGqBPyLgY2mIxt2BauAde6QI9CDSweYaDxpCyQG4uccfRmoinYBiLYg5nIXIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908831; c=relaxed/simple;
	bh=BQTo8HGpJHYtCKTHExCW9LZWySI1noqctPkv7j1keb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYAtx+9/QCGzvk/DFEdoafoZpk+laC4cSbpZFxD0uvWqS+fn5oB/tEMpQempf3ogaat68uU504e2mQngLySlWguFWnSTUJUmqoiutGvPrzBpPc7bNConDfyC20iSOhX3vftOGR0F10WBD86rLtF+s3woyP4l/Vn0w5mS/bgOR5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Bc9isx1C; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UMsgbb2613181;
	Fri, 31 Oct 2025 11:07:06 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012059.outbound.protection.outlook.com [40.107.149.59])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4a349sjg0e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 11:07:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3bXMzXVtivh2z1A6hj1xb4bfVPpa/2jKXmoHBXhib85j0w1raVmprR477oU4CwL1TR5TtI1bKNMJhylXMUEhAIVynKbeF2M8yoySblfIy8VjxB//z19qLXP/vLyef7gndynhZB5nz63zWVpq1+L9ISVUg1Jtyd+D3uCDLNWHcFuNuCHJWbX2dl0fo2pjVvezX69uQivadkRETQDf0za0+n6vj5oA+6bpEcESMqTkaJhvo72o8K/GUsox19QCS0g26Gz76al1cXBO8zTv11VWqRmyqu6eo6hiCavQVFte3Z+j9Ga8z1hqUITKVks5y8fulDVYexcGYC9ASfdn6wXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQTo8HGpJHYtCKTHExCW9LZWySI1noqctPkv7j1keb4=;
 b=YgLMXKhPdC8KmxtJnLBhnxN5/z2yE3DBkEQsKfzqGcfQ0F30QPGoge7ZVllHzd771UNKpTeLR4KpQneWhgjkXwsZ0T6+5D9STn48o5hqL4xhp0/CnjTC7m4DB4BjLof4SxuMIPw3zl4ROxGfDvxKA40MAZYOWxYriJe8Bo6tEXZzeh/ta1CdB9KtJMyVTs14tetsfBkhHDd43KojYgdDEGRt6JtziXlAh3TTQpQYzDtEeCh0J8bd3KpDZGn7qHSyuNnvYwbXcKT2V0mOD0u1nQQG9A90VUPiTcKQdmvoP9FBqxjrz/gjRMB5CpQs8jD3m8/w+AYi5ltoJpGMacKn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQTo8HGpJHYtCKTHExCW9LZWySI1noqctPkv7j1keb4=;
 b=Bc9isx1CZ62TbjqvCpAsfygcXJlUYnVr6YeBFDAKKDFZ48oO5wc1+2F5AZGVz/zWDeqBsqFD56R+//E3ilrXQHj1APIcVqUEPnN2WeLVD4sId8eoN5I0q2ZAVlFn5N6E9zg/o6l+jzQaDO8KgLxEY+2nmJZorQsVaGQbAFkH2rR7766pJqo1cx89bRN+gH+cUgl2SCWudB1mY40IXrYTFP6EYXDSXsF3Vbp5c7LW9fgsf4dF+Vc7JgUL+aM4KucqGvRm0EQ5aV8jciYdmzdh+yI+UDfv0sb38KUs6FnneJHzAcUtxj34xydos7k/owIAnNuJrWUq4D+j5idHmaiBjQ==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE1PPF52F0CD9FB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::642) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:07:00 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::495:8823:ba38:6fd4]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::495:8823:ba38:6fd4%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:07:00 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [bug report] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [bug report] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHcQ0PBPqefy5GNI0S0Hq+R1TlRFLTcJaSQ
Date: Fri, 31 Oct 2025 11:06:59 +0000
Message-ID:
 <FR2PPF4571F02BCF2D49BC0558101D30A2B8CF8A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <aPi6Xw-ZoUkW76zR@stanley.mountain>
In-Reply-To: <aPi6Xw-ZoUkW76zR@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE1PPF52F0CD9FB:EE_
x-ms-office365-filtering-correlation-id: e2566277-fad6-4a53-7639-08de186d9d27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2pTamVFUkdVak94RzJJVmdsWFQ0eWVRRGQwY0M2YXBxVi94RUJ6VnhBUGJw?=
 =?utf-8?B?WTdwLzBabzcrNlB6V2UwUXp3SENpeGU5Tm1EcjdxdGlRNEFBem43bEJibGx6?=
 =?utf-8?B?bm4vRDI0SGVSazdCcXlJcHhMMi8yMWdqM29zTk1NaVVMRmh5S2ZHNjd3TmF6?=
 =?utf-8?B?MUpBbEFhMFRLdC9xZVg3WEFjcUFXNmhiaG40bFVCNzNLbEcxbDBQVnpuTDFM?=
 =?utf-8?B?TW1UWHVTeEhqWE1TZkR0MDFvbVg4cjVid2R5VEIxcFNCYm5EaHhTaFVrWWRS?=
 =?utf-8?B?cWU0dC9jQnJaN09xdytJc3IrdmREVmhUWWxabkNyWnlzam8zT2VpVDBtYjk1?=
 =?utf-8?B?QnNPemwwZ05BQTQ0MHVZcGtuVll5amFSNzRPUnQzdW1NNG45THRveitwbHA4?=
 =?utf-8?B?Ti94YXp5M3ZFajJuSnlvK2pZcDRwTUdLT1lxeHliaGtnK2dZK3pmdkNleGg0?=
 =?utf-8?B?OUtLNkRjZ2hPbEhWY1AzMWVqQWxobDU2Mk41aUVOcnE0a0tSaDdpbXF2b3dw?=
 =?utf-8?B?cnA4TmkyMEp4QTFhTjhJWFhmb3ZGR3EwUWUrMzNqcGlucmlyeC9XaGZjOFM2?=
 =?utf-8?B?Qlc1eVVjdzdSeDJ5cWF3MDhQZDZNdEREb20yZzVPSHprdFJ0Vkp2bVFHY3kw?=
 =?utf-8?B?ZDlaenpIS1Q4elNtazhnRDhaUzg2bFUwenZXTngxQnRBSHNDdWp4U3pLY1FP?=
 =?utf-8?B?ME56dWF3ZGhmMFFZMFpYVWU5cXg3b0haaTlZTHlEejJGVGQydHFZUFlyU3U0?=
 =?utf-8?B?dFBObXMzMzBVQ3hJOWovQUc1QkdwV2lRaE5MS0dTRjJxL0xDTXJJRGhYVitJ?=
 =?utf-8?B?WUc4RG9lNmhsVVYyTkZwbHp2WnQrSmRtTm4xTUgvV3VlTmZZdWtsajJXSVVj?=
 =?utf-8?B?blJWOUtZNjdZWGJIcW5NeXlWRjE5SUJvNitKdUliam1SSFphck8xbjVBQkc5?=
 =?utf-8?B?OVc3V1ZPbFl2UkF5eXZITzRwS044VTBmZngxdExkZWdpK2o4M2ZSdU1YUTVM?=
 =?utf-8?B?OEtiOG1IV1NGZU90YzJpbnE1TDBNNWZuMk1lZEZjcHAyQjBmdnJLazI4VzhE?=
 =?utf-8?B?MEg2NFZnK3lpTm1heFYxU3QxUmZPT3gwR2tRalI3cWlXY1ZLaVdUc0VBN0cv?=
 =?utf-8?B?M0MxajNFVGJ2R3B0R3l6anRkQXZYTHEzaU5EbG1RK3NpbGoxWU9IZy9sUkpS?=
 =?utf-8?B?d1cyNW04SEsrdk5naU5ZeE1zSHFtWEVGOE9vRXNqWmtBbnBPUGdVZ2hBanRF?=
 =?utf-8?B?a09GMFllemZCWlhmV1ZyeXlXYWpvZVpuWFZmU2M1UWovSnd2dVUvdXZ0Tm55?=
 =?utf-8?B?NlhUYkNjUy9HcmE1bXNwYmdMMkVOWXYyaVlWaVFkaUp5Z2xNYlhMdHdWSHZa?=
 =?utf-8?B?cTRpbTIwS1l0eWVOaGg3UkNwcDZ2QnA4TkxQWE15TjBBR3RnV0RPTEJuRk1z?=
 =?utf-8?B?SXBOYWJGNTlvV1M0TXNSbCtiNmxLd2sxcDFSZEFyck9aNGpRSjFmdk1VcWVq?=
 =?utf-8?B?RXlaeUlSZjRzM29DNGhXMUpESUJUN085REQ1cktyUGpCdWQ5UXlIT3k4WVlu?=
 =?utf-8?B?OXZEWXRUa1QvaUJlOEg3U0ppUnhyYUFzUHgwakdDZVkrQnQxaTFnakhqa2t1?=
 =?utf-8?B?Q1dtTStZYUFZbU1tbFZWSGhtTTBKNHVibkhuU0lXa1BVOGxUTnBZUmhJbUEy?=
 =?utf-8?B?WWYwb2xHbnFmOWdHbkJpQVoxUU16VThhU3BNUitTVWlGSkF5MkgxYUFCVjRw?=
 =?utf-8?B?anNrM1hIc3FzenN4alErU0kwUXRhTXpNQURJNnpCS1psSS9qTjg4VFZYY1p1?=
 =?utf-8?B?RWZGa3RpTzdrMnhqRUJRbm4ybmh1SU80TzlLUkhDMjRHTnVHcTNlRnRnRXBu?=
 =?utf-8?B?TEFISjdWd05mYVpzNWJLRzZzSHBxY2RwZXY3b1VqYkErWll5d0xrenRHOGlS?=
 =?utf-8?B?WHNXUnBMM2REckdjbWNaQ2xWNnJkMHBoVW9LNnF0Y3JMamVFalhUelQ1Qnln?=
 =?utf-8?B?Rlo0bW5DczVPV1FNSmVLSkFNL1JGd2laOXRKUGk0NitNbXdjYnV6NG1GV0xo?=
 =?utf-8?B?OGMyMTVHUDRGQXVJb1hPTkYyb21SYit6VHJqUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enRRejZpcmRqMUVHODl2REFIREZncVZibDVLK1I0Wmd5R0x2S1EycTRmN1lt?=
 =?utf-8?B?alM3MzNSL2d0S3hHWDRhalMwbHBONGVSeTRlb1NQZFJJVDA4blZMU29LSFg4?=
 =?utf-8?B?V0djWDdJUXhNZEExRmE1S0N6RW42ZzhwK1RHeTAvOXBIejhrbCtFd21PaUVM?=
 =?utf-8?B?T1U1cHFkVVNFa1YrS2VqRVM3aGhFVVZERUxUdm1HVkJPOHVDdzJEeFFhdmlu?=
 =?utf-8?B?emI1bFd5cHpXVnBpdXpxNE9ONkdTTE1TclNreU4rUm50UHRKYU1QSjg3ZGNS?=
 =?utf-8?B?ZkVTdzNlSEY3SnYvRzJiV2prdWhtTnhlNFlJNnR1QXJGVjczbHB3ZGlQdGpq?=
 =?utf-8?B?YU5keHFhRExPMHdsVERHVTlNSmovMUpmQ0NVckFqUmNrcFo1L3NHMFROQTBI?=
 =?utf-8?B?MjYxalJQaS9ISTkzK29kL3dwbzRaYXkzWHIxTk9jamdTR2VNeFpVM2NtdS92?=
 =?utf-8?B?amRwcmIrUkY4YzIwaWZGd3pubGduSzBFVEo1WDBxaCtjZXNRQlU3M2JPYktU?=
 =?utf-8?B?MjlQcUdTM0QxVUFEaUNVYnZhbEo0VWRzOFY1alZnZlpuTmdhR0R6SHlSZzYz?=
 =?utf-8?B?cEdmbFk3V3lpM0NMRkhHR1dvMmROckZrYS9ZeFd3c2t2VUhFWkt3c0JXeTR6?=
 =?utf-8?B?akcxdCtTeUw3UzBoWVE3dUF2RWs2OTFIVENUNmpEK29tbDNrUlZKTzMzZ2ds?=
 =?utf-8?B?R1lFK3VHbHF3VmplWnhZSFI5YTRUdnpyNTVxMmxLZlBJb1hsYTgrTDhoVk9U?=
 =?utf-8?B?a2pUZS8vNWVjRmdLTlhGckdBVDJzejMyNCs5L1pHZTMvUGVORzVTRm9wSlJ5?=
 =?utf-8?B?T2NJcDUrVlVrUEtwb0RDamhMNk40eVNFUnYwSXB1SXFuUFQ3alN4QktjOTAy?=
 =?utf-8?B?bmhjNmFQWk9DSnFWS0ZDN2dSV1ZRUUlMWVVxcTlOa1hBZWhqaDJmc3FrM2Nz?=
 =?utf-8?B?VzJUS3lhSFJlTE1sWDduTW0rSGdmOEh2Zm5zZTlaUlZNNFQrYjhiSCs0Q0FK?=
 =?utf-8?B?MkY1UHMrVnNtcnlPK2F2WTVka2gvcTVmQTVIc1hyMUhUcS9vN2JPZXlPYmZk?=
 =?utf-8?B?K0tLQWlXa3kyT1NzVXhSTlVwYmxobUVtbWx6V3V2c3huQkR0L0tYdmdyODFm?=
 =?utf-8?B?Z25XT2d6QVdBbHRTM1hsNDgvUDdCSGVkTEFiOTdwU0RRb2ltRHkzSjkrRGpN?=
 =?utf-8?B?dlU3SXFqY0lwN0w4T0MxNXNrRFhJVEVwY1d1bnlGYyt6SUJsRzRpWmJmNlR2?=
 =?utf-8?B?OWltUnNNZ1Nuc0ticVl1cDJ0TFJqWXFzYmpkNEs3WWVhVzdMaGg1Yjd5RWNZ?=
 =?utf-8?B?UzhqVWY0UHN3bnBnTmJRR3B6U3FXUGFRUUYrYnlybngwdXdtaTFiaDlLRW1S?=
 =?utf-8?B?V25YUmczTVMxckpMSkg2aXlxMjJGYjFLdmM4amcyQWdpNFdyR0JGZ0VYQkVj?=
 =?utf-8?B?ZXVYZnQxR1haMmYvOXgrc3U5MllOTzJkMTd3WGYxZzJudllOYUlOTlhZcTZl?=
 =?utf-8?B?Q3dlUnhWbCt6QkZIYkFyNmM3dHVlNldsRHNGK2lIa1hrZkJadm52Snd2OTNq?=
 =?utf-8?B?VkdOaG1iNi9YenBSSDAzOEt2TlNtYnR4NjA5aW9BbHJaUld4TktPMGZmcmp6?=
 =?utf-8?B?cVA5T0RJeCtDTnNuamNvN28vdUdVdUdYQTB3QVNCRXVnZ3IvdHdRYmJJSnJE?=
 =?utf-8?B?UHpOblNxUnQvcmU5L21ER1pFS1ZsUi82eHhLUm5iTVh6WmlURkZFS0VqVU9M?=
 =?utf-8?B?cU51VmNGcTFxbGFqZjVsdnRROGxiZHF4UTdvU3VJcHVhNHZaanBXNHVPOXF0?=
 =?utf-8?B?ci9FcHJoVFhKMzFJdk81bWVvUHRJeGRqMXd3bWVQVHc1Z1gyemFnUHVvdklC?=
 =?utf-8?B?L1dlODR3WlNBRFRKTzhQRUlGeG1peTB6aXlhb0ltY2UrYmpobGtOSWhNbzRG?=
 =?utf-8?B?amVTNURYMXNCb0lNQlRhbm1taFlybnBhVGxjL1laZnl4UVVRT283QzNCZzZR?=
 =?utf-8?B?dk1CbzR4aWxQYU5LOENVckpta2ZvK0hoZU9oOWNKRW9LRzNrTjZvSVZtYmJI?=
 =?utf-8?B?ZEZ2RWJHdEprdEg2R3RJL1Q3UE9zUGRhUG1jRk1VanJtT3dTVEFSSWxVWFBP?=
 =?utf-8?Q?w4Njj+rEs1YPMxk+o8+Adu+b0?=
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
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2566277-fad6-4a53-7639-08de186d9d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 11:06:59.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDkt55hzKjokPv+ZkxfNSp4cOgLsSICNAhGOah7WBPKiRPW2wRl1/mpGso6Y8MBUasejL9zdMdu3qLL192Ri0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF52F0CD9FB
X-Authority-Analysis: v=2.4 cv=NPTYOk6g c=1 sm=1 tr=0 ts=6904985a cx=c_pps
 a=fBBSAWMpRdHsrBRfZckhvg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=ElAXwVD6Txke8P11qFMA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: aNeTFooWVMM4EN7UTBUXWco3pzxzFen_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMCBTYWx0ZWRfX6gKEUIMmrOLi
 LuTYvEh+2bFl8cj++KxlmD4pkZveIer647EAMT5VdPcV1gZIyUGUu2R0eOF0pxaHPZfrRlkFJNZ
 VGHPdus882yyh2JpcyrawvLHqnvyiSCPTu1U/gBsd8OItBpVDUNS5D8sAk0SJYNvUKdA1M79YfH
 ieUyuuhd/bpCRNz3zMZUPipv9tkTZrML7B3uwdQRF85jGezfpxBV2jPC4trQ+/k35b/kCd0DF8X
 CCRbNxdamlWphKHUPHNRWb/g78zQcpMfAgnA94Jwq9HpDib0Jk0BRGLvRe5LNXjQk6K0vXNllV5
 k5oAXpoBSKN5o1h56Lack7d456Lo0U3sXseIhy9aSrxLN0BK1EQhgkK6oncxpje73hV2265vy5o
 ral/Yui7tgBSskRW2uZjEMcw/zLFFQ==
X-Proofpoint-GUID: aNeTFooWVMM4EN7UTBUXWco3pzxzFen_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310100

Pg0KPg0KPkZyb206IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4gDQo+
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIyLCAyMDI1IDE6MDUgUE0NCj5UbzogUmVtaSBCdWlz
c29uIDxSZW1pLkJ1aXNzb25AdGRrLmNvbT4NCj5DYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zw0KPlN1YmplY3Q6IFtidWcgcmVwb3J0XSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgYnVm
ZmVyIHN1cHBvcnQgaW4gaWlvIGRldmljZXMNCj4NCj4+IFJlbWkgQnVpc3NvbiwNCj4NCj5Db21t
aXQgMDY2NzRhNzJjZjdhICgiaWlvOiBpbXU6IGludl9pY200NTYwMDogYWRkIGJ1ZmZlciBzdXBw
b3J0IGluDQo+aWlvIGRldmljZXMiKSBmcm9tIE9jdCA3LCAyMDI1IChsaW51eC1uZXh0KSwgbGVh
ZHMgdG8gdGhlIGZvbGxvd2luZw0KPlNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0KPg0K
Pglkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9idWZmZXIuYzozNzcg
aW52X2ljbTQ1NjAwX2J1ZmZlcl9wb3N0ZGlzYWJsZSgpDQo+CWVycm9yOiB1bmluaXRpYWxpemVk
IHN5bWJvbCAnc2xlZXAnLg0KPg0KPmRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2lj
bTQ1NjAwX2J1ZmZlci5jDQo+ICAgIDM1NCBzdGF0aWMgaW50IGludl9pY200NTYwMF9idWZmZXJf
cG9zdGRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gICAgMzU1IHsNCj4gICAg
MzU2ICAgICAgICAgc3RydWN0IGludl9pY200NTYwMF9zdGF0ZSAqc3QgPSBpaW9fZGV2aWNlX2dl
dF9kcnZkYXRhKGluZGlvX2Rldik7DQo+ICAgIDM1NyAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRl
diA9IHJlZ21hcF9nZXRfZGV2aWNlKHN0LT5tYXApOw0KPiAgICAzNTggICAgICAgICB1bnNpZ25l
ZCBpbnQgc2Vuc29yOw0KPiAgICAzNTkgICAgICAgICB1bnNpZ25lZCBpbnQgKndhdGVybWFyazsN
Cj4gICAgMzYwICAgICAgICAgdW5zaWduZWQgaW50IHNsZWVwOw0KPiAgICAzNjEgICAgICAgICBp
bnQgcmV0Ow0KPiAgICAzNjIgDQo+ICAgIDM2MyAgICAgICAgIGlmIChpbmRpb19kZXYgPT0gc3Qt
PmluZGlvX2d5cm8pIHsNCj4gICAgMzY0ICAgICAgICAgICAgICAgICBzZW5zb3IgPSBJTlZfSUNN
NDU2MDBfU0VOU09SX0dZUk87DQo+ICAgIDM2NSAgICAgICAgICAgICAgICAgd2F0ZXJtYXJrID0g
JnN0LT5maWZvLndhdGVybWFyay5neXJvOw0KPiAgICAzNjYgICAgICAgICB9IGVsc2UgaWYgKGlu
ZGlvX2RldiA9PSBzdC0+aW5kaW9fYWNjZWwpIHsNCj4gICAgMzY3ICAgICAgICAgICAgICAgICBz
ZW5zb3IgPSBJTlZfSUNNNDU2MDBfU0VOU09SX0FDQ0VMOw0KPiAgICAzNjggICAgICAgICAgICAg
ICAgIHdhdGVybWFyayA9ICZzdC0+Zmlmby53YXRlcm1hcmsuYWNjZWw7DQo+ICAgIDM2OSAgICAg
ICAgIH0gZWxzZSB7DQo+ICAgIDM3MCAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ICAgIDM3MSAgICAgICAgIH0NCj4gICAgMzcyIA0KPiAgICAzNzMgICAgICAgICBzY29wZWRfZ3Vh
cmQobXV0ZXgsICZzdC0+bG9jaykNCj4gICAgMzc0ICAgICAgICAgICAgICAgICByZXQgPSBfaW52
X2ljbTQ1NjAwX2J1ZmZlcl9wb3N0ZGlzYWJsZShzdCwgc2Vuc29yLCB3YXRlcm1hcmssICZzbGVl
cCk7DQo+ICAgIDM3NSANCj4gICAgMzc2ICAgICAgICAgLyogU2xlZXAgcmVxdWlyZWQgdGltZS4g
Ki8NCj4tLT4gMzc3ICAgICAgICAgaWYgKHNsZWVwKQ0KPg0KPnNsZWVwIGlzIG9ubHkgc2V0IGlm
IF9pbnZfaWNtNDU2MDBfYnVmZmVyX3Bvc3RkaXNhYmxlKCkgc3VjY2VlZHMuDQo+DQo+ICAgIDM3
OCAgICAgICAgICAgICAgICAgbXNsZWVwKHNsZWVwKTsNCj4gICAgMzc5IA0KPiAgICAzODAgICAg
ICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChkZXYpOw0KPiAgICAzODEgDQo+ICAgIDM4
MiAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgIDM4MyB9DQo+DQo+cmVnYXJkcywNCj5kYW4gY2Fy
cGVudGVyDQo+DQpUaGFua3MgZm9yIHJlcG9ydGluZyB0aGUgaXNzdWUhDQpGaXhlZCBpbiBjaGFu
Z2UtaWQ6IDIwMjUxMDMxLWljbTQ1NjAwX2ZpeF9idWZmZXJfc2xlZXBfaW5pdC04MDYyZjZlMDdm
ODQNCg==


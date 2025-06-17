Return-Path: <linux-iio+bounces-20741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B19ADD083
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096DB18921F6
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B022DBF42;
	Tue, 17 Jun 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="RrtuQ1fn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22420B808;
	Tue, 17 Jun 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171462; cv=fail; b=YyhuFDdz+iJpEIEHxox75kiFy256SE105t8hQOTP1HNpqpFmb28Z32+XRipqg8iXXsX/hDAQVrM+6vDkJMV1RwbgpWTIdJSvaI67HH8CgRD9Ci2ihTirbqD7YUCVZRpVOuCslj5gcFXKp6045VptCwYcGaJ5A4XlMheCLfbYXto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171462; c=relaxed/simple;
	bh=YrB6JIzRCfMCr9FJwiO8IYX46cx6Ff5Xu5iySiNo0kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=padD5b3pqA5lJSYzn5ubAmW+MV/66bxoKuFJ37Qt3HYtNC909Uv/XDYZKE5/y2eRRmINdAcFu+0+w2+WaO9PnAeEp6Q1Hgq+D2y8QjClAQbub/IKKuVlN3Hy3fsY0x7Di4BC7jIlB6JLXe27jQpjssuyBj/hE1dpOXsDqTl9iZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=RrtuQ1fn; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GMj2v1000945;
	Tue, 17 Jun 2025 14:43:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4791nk29w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 14:43:44 +0000 (GMT)
Received: from m0233778.ppops.net (m0233778.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HEhiqW004208;
	Tue, 17 Jun 2025 14:43:44 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012039.outbound.protection.outlook.com [40.107.149.39])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4791nk29w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 14:43:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX1K5mvjeAapw5LGO8ryCdKpGyk5DX4/v3lSEKbD4K50WFWh7A6V5b2zOv4jwAOaYqBlIrvB2XrRRxzlef11/TKGc2fEdJGVPDKTttUjsSgaPpL6li+d+7hdaKIxHZwtYvrghL2A8vfIPxcqmdq3bO5cdAKrp57njnT9dqLABb3QvqZ4cUvFDg/Y4SjHtFnyFEa1In9ZOdsCrcgSWQeN+hY+vtfrBUSZnbaNcIrBT0nEinxj31q8D4e6oI7ctsj1rUuem2HGOs+W+5xMOqavMZYxuU79UQF0REW/nsK7jDJ0i6//J5jk95UUg7F4owFNgg5M52JaeyUoI6Iz/5H4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrB6JIzRCfMCr9FJwiO8IYX46cx6Ff5Xu5iySiNo0kQ=;
 b=tYcC9mUM/HGTMLuGwzLLH/dIaRxbtGrFhgsRx/wuuiNws1/dYyRpnIBpH5D46lmLym5XIf+3ry79fLhjCvHhIDApYtKVhvvCh/ssqMdFfICCQip7O+hsD5d9eL2b3CZ/hFSQYmx3SehLOYhi8qPpss+Wu9Wu5Ktxo3ODjao1u0IiFSh0v+v0zRX+ZSzNHYZFHkb+wanS6ygmrCp48rpfw93VIty2jcECjzAzA7FOJMEiZeIV3NQyzA9qJm43GKDvBUtJW7pOZo11G0dLYe4Q+bnmL0gv8ACPxTQQfJ1Q36m+lXVm5bHp5wehuvpCPLzHFDaDbF/MLMS6PYnM04QyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrB6JIzRCfMCr9FJwiO8IYX46cx6Ff5Xu5iySiNo0kQ=;
 b=RrtuQ1fnSgXBghn7PwvOAHwwYssPyup7TTSd6LiklYThzxFv6hZL3psf6LuY/BHi5kMPnH1vtSF42mZzdaxddzIVBumfF4jjqDsJEw862X4FTKIgr5nEPscMh/6+Am9uuCb2Mhx/p0QGnbePQkP6sTMauLBJ5pT2Qd4L61Kts925WW7zt6bQ3/QUt4+tMokUItQs49G3UdYzv/h52Wum+2iZKCjwYIfFR5NGni+gFo3fYWezdUU3WNNDo37yFTj+5f+OW/J7BPkQhtKNRso9bfFLS0BjJAt/5MAE/IAMLgYltH9zhNUGFbt8ACD70H93NGeFBbtrZH8LQIKeyDjYoA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3PPFEC93CBEDA.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 14:43:36 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:43:36 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Thread-Topic: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Thread-Index: AQHb3p2yhsQhO66i3kSQkmuPrSQlU7QF0zjFgAAG7QCAAYThiA==
Date: Tue, 17 Jun 2025 14:43:36 +0000
Message-ID:
 <FR3P281MB175775DBE90C5469637F3C66CE73A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
 <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com>
In-Reply-To:
 <CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3PPFEC93CBEDA:EE_
x-ms-office365-filtering-correlation-id: 5339fe8c-43c9-4857-ca3a-08ddadad575f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkZRdW5xSnp4ZlJFcGc5aGpJZmhxcldGVzg4WWFjbWpnMm5OcFlkcHRJSXBa?=
 =?utf-8?B?VkppcUhoYmZic0phYXg3L1FBcC9mQ1poMDJoTzJkSVhxYWRxcVY0QmQ4eGxz?=
 =?utf-8?B?MDhxWm9KZUR1akh2T2hEcThhdU5aeEdrZ2kwODBTYUZPTW0xWW1uNk0wUTJI?=
 =?utf-8?B?QlFFaGpVSnA1eSs2enY3ZFBWWVBLWml3L01VVnl3cWxSM3d5QVU0eHdHcEN5?=
 =?utf-8?B?eFd1K21ITTV4L2ZEeEJyVmYzcWxKN2d3Mm1QTlQ2bjhSUWJWTTZrWVU5UW1I?=
 =?utf-8?B?dGY3eFdPVmMzK1UybCs2MVRaZ0t6N2tUYVkyYi9JQk5ldzB0N3oyNGZEM0hZ?=
 =?utf-8?B?ckdWaTQ2SkJLYUh6R2p5SGRRcDVZdGZPc2pkdHVvL01GL3JEWlo4MDN3ekhM?=
 =?utf-8?B?ZFEyODFsVllLVlpiRFNid2RCeHVWM0tEWEFBQ0U4WUs0YklZb1hsZmphNGpp?=
 =?utf-8?B?eHpQcVM0OXlSQlA4WHYzMndlT1YyU1E5T1FrNjA1RzE4SXlVSHFRSGE3K0RP?=
 =?utf-8?B?WXZNMUVFQ01aNVFiMjdtUk9GcmJlam4va0hNQmR5dUdyeFJVQVFPSjlJOFVE?=
 =?utf-8?B?Q1ZNa0VnbGRsSnpPR01UZ0FibnVFQWN3cGlFR3dMU3UzdTErdEczT29qajVK?=
 =?utf-8?B?UHpaWkxmNXo0RThvVWlUbzBjZ1JHRWt1UEQvVU5hZjN0MEx1aG96bUROQzRq?=
 =?utf-8?B?dzVqMnFJQlJIK2NuTU5TNkc1UnZ3NUUvbU1UaU44amVpZTVmeUFPREp3Qm9T?=
 =?utf-8?B?LzNTZjhucENQYkVjZUNQUUJLZTdSeEJxVDNtQmZwMTlCbnhCTHRFcUFmSG1D?=
 =?utf-8?B?KzZ6eGZXdlBRR2pDRFdPTUN1OWtwQ1ArVmxpYWhGcjIvVUdxMlBiYng0eWt2?=
 =?utf-8?B?VytYeDRtWHNSN29ZR2xGWG9JdHJQUG1FUzlsbGxmSmpjR3F6a3JjT1NtenNY?=
 =?utf-8?B?d3pzMmZublVQc3J1NEZMZVY3UWkxUlBCUjRMUjNsaFpuWnBvTzA5THMranZV?=
 =?utf-8?B?ZWJYZ1o4ckI4SVBVK2FRcTM0RmRkSmtlajBzTGI3M3M4OGF3OG9PdEpPem9o?=
 =?utf-8?B?WUIxejRMdHFpaUFwejhFazljVzdFaElmMkZ2L0lSMEZqd3pEaXhKQ3FUUWdM?=
 =?utf-8?B?UzVsdGhLSi8rczl1dXBtZDRPYUZLbW4wbGZYN082WW5XVVh1VU1OY0ZBT3RU?=
 =?utf-8?B?OUxOMkJpZjdLZ25qUU9jVnF5K0xib0k3QmNsN1o1Wm9XaFVnczlkZDJDVS9L?=
 =?utf-8?B?TWxoNVRnOXJNdFBkZ201M2RmMmtET3psRjNZVG1aWlNPV0RBaG42blFIbk4y?=
 =?utf-8?B?bHozK08za1pWTkZRVXFDb0dNZVVrVDIzNC9FWGkyaS9sTGxkcEVDckFoV0VO?=
 =?utf-8?B?U3duY3lFWHF3UG05eC82U3VuQW1wRVhMM1lwU3A3WDdGVXN3VXhJZjBoNmth?=
 =?utf-8?B?ZTA5Y3laNmV1MHRxaXVKZFN4dkQwREpFaHdGZExkc2lKS0l0SzNZV1lRejRv?=
 =?utf-8?B?L0crSktYU2xMMEkvQk5WS3hYTmkzQ0VFT2VWOVY1WFNiOHZIa2VtZnBOM2Vw?=
 =?utf-8?B?OGhLVHV3OUh0cDE3NjZ0ZHpPYitjalY2VENJVm0vcU5CVlpKTStJTDNiSURE?=
 =?utf-8?B?VTZIL1F3ekRDMWtDSi9nM2lhZFRMTzdQL0ZrU1VHVE1hZGE1VXNIdWdhVFBu?=
 =?utf-8?B?N3dkLzVjN2RiYk1rdWZjNW55RUlLR3UvV2xlc0IwK1RwRG9RK0dQeVkrLzJs?=
 =?utf-8?B?TFNwdjFJZCtEZjY4NDJDc2grVWlIbjFSNjNkUFpndlM2Ynp1ZUFZdmM4b0t4?=
 =?utf-8?B?WVV2ajFuRWVGUlgxNVRtSzIwekFUZnFYbzFjZjQxRVBJYXQrREtiZUFTWEc2?=
 =?utf-8?B?Z1NWbUoxRmRTaEJNa3dkVjgzUkJIbytKcERtc2RPOVcvb1VteXFJdUdvTFRO?=
 =?utf-8?B?bDNIVWlLSDhjTGZabmVKQjREMmordnRRK2ExUEtKNzMxWnlveStoRk5zOUhO?=
 =?utf-8?B?cDMxM0ttcWJaUGx2UWVYc2d6dXpTQW9hWkloVlMrbklXWDhibW41MnVTSXl2?=
 =?utf-8?Q?3ATF0J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmt1Z0tzNG9wU2pYQlZRSXIyUktMRWRCUjc0UURRd1ZPVXFoZ2t6UVo0KzIr?=
 =?utf-8?B?ZjE5UytOTXlVY0FrRHhFZ3ZQclVNV21uNmNYbndaMTdyY0UzUm9iUDc2VTYy?=
 =?utf-8?B?WnErczUraFBLTzVUZGJrdzVOY2hPcjE2VWJLaTBEa3lDLzZRQVBpd2I4WVB5?=
 =?utf-8?B?SXJvT3BnSVpkT0VyVUZMVXVzWS9BaVlZSitYd1BuZk9TNXgxWCtDSG9rU21I?=
 =?utf-8?B?a3NJeDdveGMrMnl6UDVHS0lBWU90TjhiNm0xdS9yMzAxZDMyUG1mbzkvZXNt?=
 =?utf-8?B?MTlNYndmODMxQnlnQVZ5MC8vUzZjQnl6S0hxYVEvMmVTODNQU2hXRVM1WGRa?=
 =?utf-8?B?WkFVSVQzUW5NUTMwRkYya0NEbTF4TStMbkhROXZjSFhMa1JkRXNYWFI0c0ZQ?=
 =?utf-8?B?UEpGQXBiUXh3eFhMMGRrSldIQ0NHelM3aFlLTnFWaTJJUWJZcHFzU3pEZ3V6?=
 =?utf-8?B?Qk5tbGdVaXZ0SEdjT2J1SDB4cG4xd0ZFa0hsUDZsS2RJdVFpRkdkUmFHY3FR?=
 =?utf-8?B?NVU4NzdSU25aeEM0Qm1uR2VHQ0lvSUo3UXNvQ3FNNmFid0hOSnE0QzhBUWlB?=
 =?utf-8?B?dUdZYmVaVjBlZmloNnBYemxzemhQZzJiaVdrZW51RVpVSGdLYk1oUnc1dGlm?=
 =?utf-8?B?eFVORmdXNVR0UXRRcnc3bEt4eG1rR3dpenFjck1EUGVDcFlidVArR2dYdFB3?=
 =?utf-8?B?WFFhMWovaC9KNGFpQ3FUU1dIT0tCT1pIUloxRXJaL1cvVmc1c1h2TEt6U244?=
 =?utf-8?B?S1Y4QkNiSUJEWGxnVmxEVjc1SmY2Nkt0aGc1ZVd5NG1idWxLSjI0N2FMYWth?=
 =?utf-8?B?dTBaaStIWWl1OE1jZlUvUFB6OWFNRjdmQUNqNDNFYjgvUlczR0doZkQraEM2?=
 =?utf-8?B?R0xZNUhtVk5SK0wyY2NYQXhHS0hDZXN1U3g1d0xOZGZ3RkJ5NDNGbnVBaWE4?=
 =?utf-8?B?YTlBL3pZbnlPN1VjeWtFdUNteGpkZHZObkphZDdSVDlFb1ZqcmlSUjh6RWIv?=
 =?utf-8?B?cGpTcXhZUWd6Q1RxT2VSalY1WXdRV3lhaHpWK0dsc1pNa0JDZVd1cnRtVFZj?=
 =?utf-8?B?bmc4QldqMnpCaEt1clB3YldCb284OWlFRm5WTzI5dGxRYnpHeFdNTWxVZG50?=
 =?utf-8?B?VlJJVmtSRjVaY0lhUDlyaXFXK0xNdXhsSEdrcUNSL0gvSU5FOXdZSXdUM2dq?=
 =?utf-8?B?ZkhLNTRzTVZ2WnN2cDM0VHBDR1Y3L3V3bDFOVHYxendsRUEraWlHdTNCZGtW?=
 =?utf-8?B?ZFhZMGEvaUJDUTB0ZVUxclFEVEdqYXdUUFdMQ1FWdTRud2FLQm5rb1UwQ1B2?=
 =?utf-8?B?d0ZucWhScWF0ZEVJYjZaVlNKVjlpRU9xby8vMGpEUUZPdmtybU02S3FXYTQr?=
 =?utf-8?B?c3FjdDl6cW1td1dCNzhrUTJzWVBDY0grZVplYXhWdXgwSDJVUlM5UzMyQ1BI?=
 =?utf-8?B?MDJhb2pDeWVPZnhnZzFLenVLdDJvaVdpUnhGM2hMYTFNL1VYMGRHOGlRdUdt?=
 =?utf-8?B?NXYwaEYwN1E4cGlDTFA0M3RsWERIN0lhMjFvVDVDNnhFeTlxWHRaM2MvNVdq?=
 =?utf-8?B?TjVtdEdJVzBIQi9BamQwaEJGWmpvYmFkdU0xclRzdFpEQ3lHVld0QVR1a3BV?=
 =?utf-8?B?MnhmVDVsWVZUYW1nQUVXb1VTcmZVZ2duVld0SWF1OEZ1ZzFka1RvTExhSHQy?=
 =?utf-8?B?MGwxNElOSWlXaFkwdTJjSTdUMG16WEFzbnlxTmI5TjFGYXJIalA2U0JiQ2Uv?=
 =?utf-8?B?SzBYTVRSZFNhRWZHME8vQ2pJOEVsL091TWRNN2hGUlp4ZHk5YWNUS0MvdnUw?=
 =?utf-8?B?cTN0NDNEZUZ4RHJXbHVKT3JXRWFRZ1p1UkZRK203QUtQaVN2QkNFWlRkUEFP?=
 =?utf-8?B?bmhNL0FFTDE5UVFwTVlycDc2dTZkNURSN20vU1NWZEZidlMrN2VsMi8vMFZY?=
 =?utf-8?B?a1A5Z0c4ZjBCSC9rMnpDa2tyNVFtMzlxRE5qaTlGY1MxcWlCemdoUWx0QVps?=
 =?utf-8?B?VWZ0WUFMcUl3eGtQTXI1cUZqYThnaUZ4bHJFOXBTTEYrSjB6emsrd0xQL0NG?=
 =?utf-8?B?TkZwc04weFNxTkRLTzh3NkNnclJWQXBqcVp1M2hGalo5VytrSFJ2dFpkSzVk?=
 =?utf-8?B?ekE5RHdCTmNKOTcwN3ZvS2JMdlVQc2NXdTBIZG56UWZ1bUx2NU5ueXd1bHJn?=
 =?utf-8?B?REE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5339fe8c-43c9-4857-ca3a-08ddadad575f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 14:43:36.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjF9qZ6HQD7OCgoIzttfEScPkRFrjXlqGTM0pM/83smzfirB3r4FQ3Yq0K+AKtL7dSNi0m9nidhVwkbS5XtXbGQRo0F1m68iV+C3z++rg9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFEC93CBEDA
X-Proofpoint-ORIG-GUID: PTqrCnb6Y81NOChjR7YxuTjsOTnYmxpg
X-Proofpoint-GUID: FchV8lo8yMCK3911MduwWfiD6n37X_aj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExNSBTYWx0ZWRfX3Q4kBFUrD+cz
 R9D8oskH8UMY3FaCXG9YNFMGRMK2fJxRPou8DOsKna5AEYxSZq0rwu7l5EPB+81IP0qAvx31z/q
 mjLtgezJ8uBaRE+gZad4WLZzVL6xupffbuFhrQh2SXbts/NZ6cOVcBRGHa+TShyKX31NVBb7UY5
 7rkMz2MwdwheEyqx4BY6cx01avHn6oFbvkUd7c83QNjaC0eFpkFkKpqJnR5S1th9S53FN2k1VHK
 0PeaDe2vieH/ex3n46LuXXRj96fYBppgz1jT/b1imWDvo8vm13YHYAgBsl0YEjsyJASM0RG0Tgv
 yikTFdaK2KUSXHqFwlx5ZKgsNeL4khfRFWUnP4itTpsmV4iEiDqNfSaMswzq2yxZ+7kX0Nk1m/l
 Hcd6T9CZsjrwVHiGVFA+upqvfM8KstsAeZI+LvX2AJwNzOn3tcYZzP8CkYWVWwFLyAnMkE7K
X-Authority-Analysis: v=2.4 cv=C/PpyRP+ c=1 sm=1 tr=0 ts=68517f20 cx=c_pps
 a=2rX9jWqLNoY/UoYA1grcDg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=pGLkceISAAAA:8 a=In8RU02eAAAA:8 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=GHniDeYSnIcxJVJicDYA:9
 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170115

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTrCoEFuZHkg
U2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KPlNlbnQ6wqBNb25kYXksIEp1
bmUgMTYsIDIwMjUgMTY6MzMKPlRvOsKgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0
aXN0ZS5NYW5leXJvbEB0ZGsuY29tPgo+Q2M6wqBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFu
YWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz4KPlN1YmplY3Q6wqBS
ZTogW1BBVENIIHYxIDEvMV0gaWlvOiBpbXU6IGludl9pY200MjYwMDogQ29udmVydCB0byB1WFgg
YW5kIHNYWCBpbnRlZ2VyIHR5cGVzCj7CoAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJu
YWwgU2VuZGVyCj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRp
b24uCj7CoAo+T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgNToxNuKAr1BNIEplYW4tQmFwdGlzdGUg
TWFuZXlyb2wKPjxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+IHdyb3RlOgo+Cj4+IHRo
YW5rcyBhIGxvdCBmb3IgaGF2aW5nIGRvbmUgYWxsIHRoZSB3b3JrLgo+Cj5QbGVhc2UsIGF2b2lk
IHRvcC1wb3N0aW5nIQo+Cj4+IERvIHlvdSB0aGluayBpdCBpcyBwb3NzaWJsZSB0byBhZGQgYSBm
aXhlcyB0YWcgc28gaXQgY2FuIGJlIGJhY2twb3J0ZWQgdG8gZWFzZSBhdXRvbWF0aWMgYmFja3Bv
cnQgb2YgZnVydGhlciBwYXRjaGVzPwo+PiBPdGhlcndpc2UgZm9yIHN1cmUgYWxsIGZ1cnRoZXIg
Zml4ZXMgd2lsbCBoYXZlIHRvIGJlIGJhY2twb3J0ZWQgbWFudWFsbHkuCj4KPlRoZSBpZGVhIGJl
aGluZCB0aGUgc2VyaWVzIHRoYXQgaXQgbWF5IGRlcGVuZCBvbiBzb21lIGtpbmQgb2YKPmNsZWFu
dXBzLiBJbiBzdWNoIGEgY2FzZSAoYWNjb3JkaW5nIHRvIEdyZWcgS0gpIG5vIG5lZWQgdG8gaGF2
ZSBGaXhlcwo+dGFnIG9uIGEgY2xlYW51cCwgYmVjYXVzZSBpdCdzIGNvbmZ1c2luZy4gT24gdGhl
IGNvbnRyYXJ5IHRoZQo+aW5mcmFzdHJ1Y3R1cmUgZm9yIHN0YWJsZSBrZXJuZWxzIHdpbGwgY2F0
Y2ggdGhpcyB1cC4gWW91IG5lZWQgdG8KPmZvbGxvdyB0aGUgRG9jdW1lbnRhdGlvbiBvbiBob3cg
dG8gc3VibWl0IGZvciBzdGFibGUgKGJhc2ljYWxseSB0aGUKPm1haW4gaGludCBpcyB0byB1c2Ug
c3RhYmxlQCBpbiB0aGUgQ2MgbGluZSBfaW5zaWRlXyB0aGUgY29tbWl0Cj5tZXNzYWdlLCBhcyBh
IHRhZykuCj4KPj4gVGhlIGRyaXZlciBjb2RlIGlzIGZ1bGwgb2YgaW50WFhfdCBhbmQgdWludFhY
X3QgdHlwZXMgd2hpY2ggaXMKPj4gbm90IHRoZSBwYXR0ZXJuIHdlIHVzZSBpbiB0aGUgSUlPIHN1
YnN5c3RlbS4gU3dpdGNoIHRoZSBkcml2ZXIKPj4gdG8gdXNlIGtlcm5lbCBpbnRlcm5hbCB0eXBl
cyBmb3IgdGhhdC4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KPj4gLS0t
Cj4+Cj4+IEFzIG5vdGVkIGJlZm9yZSB0aGUgcGF0dGVybiBpcyB1c2VkIGluIGxlc3MgdGhhbiAx
MCUgZmlsZXMgaW4gSUlPLAo+PiBTbyBpdCdzIHNhZmUgdG8gYXNzdW1lIHRoYXQgSUlPIHByZWZl
cnMgdVhYL3NYWCB0eXBlcyBvdmVyIEM5OSBvbmVzLgo+Cj4tLSAKPldpdGggQmVzdCBSZWdhcmRz
LAo+QW5keSBTaGV2Y2hlbmtvCj4KCkhlbGxvIEFuZHksCgppdCBpcyBnb29kIGZvciBtZSBpZiB3
ZSBjYW4gYWRkIENjIHRvIHN0YWJsZS4KSSBkb24ndCBrbm93IGlmIEkgbmVlZCB0byBhZGQgdGhl
IENjIHRhZyBoZXJlIG9yIHdoZW4gYSBmaXhlZCBwYXRjaCB3aWxsCnJlcXVpcmUgdGhlIHJld29y
ay4gSW4gZG91YnQsIGhlcmUgaXQgaXMuCgpBY2tlZC1ieTogSmVhbi1CYXB0aXN0ZSBNYW5leXJv
bCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwoKVGhhbmtzLApKQg==


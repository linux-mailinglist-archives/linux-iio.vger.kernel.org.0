Return-Path: <linux-iio+bounces-5104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51718C94CD
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 15:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83BAB20C32
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B074652D;
	Sun, 19 May 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3Nqb905";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zegdhzgf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338281870;
	Sun, 19 May 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716125857; cv=fail; b=Sof+VFUKn/78yMn6IRKjk3ipFIuOOZhb8xFjm03rpaLtpFkqy6MIgl3dOzShg1tpkcpVcbp1m8WmEmFpruQqCQINZrerw3G3ADZ/a3RpYeN9ZvshQx2zJxfHvjqTGCiQmAdmt3zEGSAn4ymMlJto0vMPKA4OTFX60f4IbzRgCj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716125857; c=relaxed/simple;
	bh=uuNnwrRNphRyr3o/TMQ8pIgX1SWu3k0qmkVHpGnO2ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=om9Evjmqr26dUhpuniHd2DR8ta5lXcRKAQR/QH4xWrYMMF3mNjOKsN/q4luZQFbIcP59ILZOC8wT9lA2/bOjqvoSCVKZkIevVBQEUeHKEhag88KMCg1M4JE78NfHtNklhVUSn5F6KmYEV1XTZraKNw3N8RbvC3INVwX+cWjxlgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a3Nqb905; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zegdhzgf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44JCIn72015447;
	Sun, 19 May 2024 13:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=B3yvtrEFwgd7UsmmkIdu4I8HYov2FPNaRS/qWWLvwlg=;
 b=a3Nqb905OCGtz8Nu7wrfWS3nN5fkksKY1lrdlnN45mANg5NM/h5YSibLFzIB0c3PM5SW
 FCIOcF2k4wMIv4AabLIo7comPOtxv9EM/OJTu7UGZzkp1XV8tookUJvCuP92fdnyckq7
 /8oawk7WZnc8qdPnhyf1anRxCxxvJe9DH002q2ifKzIEULgfnmzBY2YeNq6eSHbbgv2b
 RlEmjP9uXLn3jcGxBjNxT8kaydeRFV56yVY/XUBnywx/aL2ubyFa0HashzaGodLx8gc+
 O0TPfRWk0KVCeuyBTvfl4967J0AlT00m3Zb1TBeHdO3/824w1ovvu12HvY5if8bNTzsh Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdsbfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 May 2024 13:37:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44JD0aiX019535;
	Sun, 19 May 2024 13:37:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js5ak4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 May 2024 13:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V98UUh0zRsQEICbZ7Y5Yu8BSiJQOwgIYVVJkQkSh4LmrvLBEZSuqhoBQCxBNw/En3vQgYxPAl60yzTKpfVcPGMTa+tL5de70fhIFDI7S53ASfOlPtzxco5hapwyDtmsl+0R8BaGEprsEcZ4Ywe1AAAZKzgx8qiEir3GBQC0qPMTB1RcH0WnUxcuQS+1Z91/IyI6i8B5bL3KkPFnf1MY0kVrqpXcgBMP/OOmilM5g1YxY9JlHo3+U7EZz1C472NVVNZQHrKXDG1Lj+Mfzhq1EfByUSsNmetRwJJlpmkj48sIhXehY27zTgM8ofeh6SNBJBl9CDAw4+pTNGWgRCKMQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3yvtrEFwgd7UsmmkIdu4I8HYov2FPNaRS/qWWLvwlg=;
 b=iN8FaUkRzhzdShrRcqWpTa1tSvN0c+V/QzVHBHpkFqKWAigJTO+gajO/z2kZRuR4XX8y2gDVjUqZZdaFl88bR7GyxIXxVqvNvh1ujUe0A88NVTlbrRW6EokQM0pr6Y/WtAqsiYWJStMKJ060O2OywZvTOSr+TLdOc3+20l65FL8t5gooiZJlg3XdP/MofifYOyS4VtTRfnmzy14dVbTHXoms3zMmOfLn1vLfGcMP+TdfXishq+2MBI5JurBFfoXrjRteBWZIDDUtXFOTmetumYzP5ifT6n2TOpSIdem06isx55r24vRRzHr8ZmnN5i7XEswemaf/FXFiBpOzn9qMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3yvtrEFwgd7UsmmkIdu4I8HYov2FPNaRS/qWWLvwlg=;
 b=zegdhzgfiffcRMblPvMduIIBgMsvqvlCvtOjqzHrbJ0JLTcJOHCZRYcNeDuC+9zVCxuEY/mWTdG4/ZkxBjtIxI2LWrLmEF6Ib5v22Kvw8Mt+yz8K85cmhYEjZ4HiHiT0KSLuwWJfIUjc/XlM6AQAqeZ8cugm/9LG6WHh46rends=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB4850.namprd10.prod.outlook.com (2603:10b6:208:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 13:37:08 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 13:37:08 +0000
Message-ID: <b6f1d062-5f09-4d57-aa24-e8515c5cebcf@oracle.com>
Date: Sun, 19 May 2024 19:06:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: temperature: mlx90635: Fix ERR_PTR dereference in
 mlx90635_probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crt Mori <cmo@melexis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com>
 <20240519132940.3714e57b@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240519132940.3714e57b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa7c1f1-adcc-49a7-42c6-08dc7808c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmJOdFpzeEdpSS9WeXkzeU9SZHBmUGdrd09kWG1SVnB5QkhvY2UvT0kzd0t5?=
 =?utf-8?B?NkEyRVAzdEkvM0NMclVhMWp1amZtd3BmeEZOai8xOXBUWVFBZW4vUGt6UGR4?=
 =?utf-8?B?R0dCajFYYnRVNFByVGl3Q08wWVNZbVdPdVFJNXlHRUl0ZU1HTDhJMnFQTmtj?=
 =?utf-8?B?M29POFRwdGt6Nno5VGNnOXBRWUNkQUNCZ05SbDFFL1VJTmMzMElPTDYrSVRi?=
 =?utf-8?B?K0lkaHVsUFZhUm9kMkVmSUpqeFNMK2d5ZGh2aUxKaVVkbUppSU41d0g4VVB1?=
 =?utf-8?B?U3FPQ1RUbUpqZ1hZTFF2VndIekNEUG1DTlhYTjFwaHhPRlIzblBjTm1kci90?=
 =?utf-8?B?U000NVZ1bXR1TVV4ZmhrNWtYUW5QMnFCbzVudkViZXM0eisyZ3hudStXNHJD?=
 =?utf-8?B?d3JuVzZxYWE0UUcxTjU1T3BtRHNqRVpDMS9WTGcvdDlka0g0SWdnY2Vib2gx?=
 =?utf-8?B?RW51cEFzUGRVRnJDbkNUeExyWnd2b2NEYTh4MFJQV1FWazQzWWV2WU52S2Yw?=
 =?utf-8?B?YjJJcDZBbEFZSTZKQk5kQWFzYUgxai9XN1BHblNhUnQ5aks3empzQVpzYXNo?=
 =?utf-8?B?NHpMaUxLV1Z6dFZtZXU2UURHZG8zN28vekJUQ2NoMVlFQTNHVGg1ZjF4OGFN?=
 =?utf-8?B?VFM4bUhGcDFtSVVoL1ltend3RG1OSVRJcW02RU4raXBjSW1xTnIwV0pqVnBP?=
 =?utf-8?B?VlhDbDV3Z0RESExrQ29qTE9kYnJyUmVQQVJHRWNSeEZTcVkyMGtJSURYTlM4?=
 =?utf-8?B?L1l1eEJqT2JyazBrNHc4ZWJxc29OV01nQTA4RVk5R3dIN3ZZcTZjWWVmOGgw?=
 =?utf-8?B?cmF2VTJQOHdpcU9LYzI4Uk1GTUQxWEQvTVY2bXFjWHhZSEE4eDBsU1AyTmlS?=
 =?utf-8?B?MDJnL25wUHJCU2ExYm1NNXg2azBHaDV5VFF3bEc0RDBrNVdxKy93bHJoN1VS?=
 =?utf-8?B?MjdodG5jbGd2d0FZdDVReVNMYTZzL3A3cE1BeHBNT1QzOFNFQ1NNZC8xT1hO?=
 =?utf-8?B?V2VuS1hZSzB5QkltWFRJRFozUFpBQW1Yc1ZzcUFTWlk3dyt4OUIyb2hsOUpk?=
 =?utf-8?B?UGErUlNiSk1Id0dIamRlZVFxZE9LQXZUdjBSdE15SUFhdXN4MEx0MFBkbURH?=
 =?utf-8?B?UFBTWGhRM3hFWVY3TUM2enVzSnduTmd1WXBuOGFnbDg2cW5pTVZFbmJJbGdX?=
 =?utf-8?B?Rnc2bzdLSGhWTzhSYmJrWEJGM1hvNVovU0Y0bUQrUzhIWHl0QkVkTTlqaDZ0?=
 =?utf-8?B?NVNmenJjWTJCTGpnblNYdE5rcjZRd21ibm9BZVpMVUtGNGFLSW1VbWZOVm1w?=
 =?utf-8?B?bk51dzFLck4wdUhuV0NuOXdyRVNZWDRCejkvWExDNGZ5R21KNi81d1JEZHVO?=
 =?utf-8?B?Qnk0dHNPMzBHVjA3bEJBL1hJWEg2eWdYNzZSZWs3S1dXL3JxamlER1VRRzRL?=
 =?utf-8?B?R0MvazNScUltR1g0YnN0U2R3QVJXdVdTTDJBRFIxNGJJWGNCUUxZbFMyWFAw?=
 =?utf-8?B?dzZBdlVLQ0RIUTN0WVprdk4vNFJyNjgvUTl6TXA2akxxR3RIRTdDeEgxaEdL?=
 =?utf-8?B?cDJKQ09tWkF6T241b3hISit5NEQwWGRIeXp2RnRja3l5ekE0bjZWVlBiVGtN?=
 =?utf-8?B?RWtwWit1WURnOXNNOUw1YTJWelFwdzBWNW80dVBoaGRtZHFvTUExT1NlcHlz?=
 =?utf-8?B?bEdoSnBPbzc2Z0F0enU2Qk5NbmVnMlJ4WDdmN3VwQUtGOUVIUHlvMkF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGJ4N015WVVJeWtrNTBPUkFkY09jclBOWDRhS1hRMlhlOWFRUnIrT1VUNkJj?=
 =?utf-8?B?dmFZakQyNEhoYkdmclkzcXNWNnhVN1FKMmVPUERuUTdxbXBPTVJTaC9sblFa?=
 =?utf-8?B?eWN4bXBsRTZxcFcwOG1lOE11emgwYUdFMVNZV2NOZlhMVy9xbWdQTW9uUFo3?=
 =?utf-8?B?bGZNdXNuTUpkdW9NRkc1V2w0c0lveFNpQlBXand0a1EzVjFZVzczeWJaTXNW?=
 =?utf-8?B?NUZCc1Q0RUkxMUxCZVA5Z1YxdmlHVXhLMmNUQmswb3dFZUduL3gwTXlvRzBM?=
 =?utf-8?B?a1VxVkpMUnFtQ3JGRDNHTjcyTG9NZmQ0bDFiRkhGYnJOTHd2alhyUmFoZzNy?=
 =?utf-8?B?ZkYvNkRMckFXazJNaW5zMGU4YUhGbXlYU0NyVGJ4YXZHcXBiMzBGak8rRVh6?=
 =?utf-8?B?eEhhSDNoaWRJQ3g4WDBHc280YVkwclFNVzBtOFlZMzFwU3VESFlpMkxzTWtk?=
 =?utf-8?B?ZWxBaTE4OWhSLy9uS1BXL0N5ekJtQnpPMXdDaDZCajlTeTl0UkJTODhJdkdO?=
 =?utf-8?B?OW04b2xwQzh6aFB3M0R0Ujd2eVdSSjFMR2R2QjYyWXRsTUlYbHBMb1BKNERL?=
 =?utf-8?B?OGpMUWpsNU90UmFlNVV2N0YxNkxHL0tjdlJzSFJldHhvOEJ0a25aMStvRDUv?=
 =?utf-8?B?bE14Q25jVDU2cTgyZDRxWUY3c2U1SllUZis5U3lkOGZLdTRSV1Y3SzRSbUZ0?=
 =?utf-8?B?bEhWZS9meXhHYjdSRmVwUCtXeWlZMzFNeGJrZWlrVTR2NUhGZ1pJa0E4NFRO?=
 =?utf-8?B?VDFmb2U4UFFNdkNUZ1hjeGFZZDFjZHZsbVI3OVJoOG4xM3UvRVRzZ3p4TWZh?=
 =?utf-8?B?L1I1d2ZEb1JhSzQ4bFRQUVFTRGlGdytpUmxmTFNiZkdGN2M2L3ZrQmNYVjZE?=
 =?utf-8?B?aTA5bEZQU2RqcXZ6c3NnbGUrSmNXSWphZXhVMnZMK0o5TUJyRW10cysvSFBN?=
 =?utf-8?B?bFpQSHUvS1QraG5TVW5WU2JJanRlSnhEMWgrSXMybHlCVHNyM2hhQy9xK0xw?=
 =?utf-8?B?NE5nQXh1UHpNRWcvTU9yZit6UkN4SGhQNDR6MGZPU294OEJhRFJkZTRHOW1Z?=
 =?utf-8?B?c0FwR2oyVzJFNDc4NmpObys2Q2pNWnZ5a1YwZC9rWjd6TnFvODdETmdLd0RB?=
 =?utf-8?B?bzJjbkx0SFp4dUJheWx6OEpRR2s5b3FnSnNLcWZFTHZLdTc3UzBIUXNIUEUz?=
 =?utf-8?B?UVB5a3VhaW5jdlpzV3hrNGZQL1NKQWNCajhCUE9WWFgrMGMrbW1zSE42T3U4?=
 =?utf-8?B?bWEvOURSUmQ3SlFFVlpaYkg0MWNxUXlZZ0syVUorUWNiRVJ0dVZ2WHVpT0No?=
 =?utf-8?B?VUFVZDVUTUhrUkJDVHZiQ2FuZElDOHhTNHZHY3BDMi9wRGpIdWFoYkJqM3VW?=
 =?utf-8?B?a1E1UlJvdW5pNit3dzRmSGFpL0U5UnQ0NVh3cmxyaU40ZSt5YWIzZEpCQ2Z1?=
 =?utf-8?B?cFdZWk40U2M3YWZ3Q1d6R0p0UGo5bUhCdU1ZQk9Xekg0OGEyZmMybWUxdnIr?=
 =?utf-8?B?OXdtY1p4Z0JlbEV6OWFZYy9NWXhhd0tpdlhmYk9yLzJRN1l3KytabUxYNGV1?=
 =?utf-8?B?VGNIRS81QkZmamdXNFJPQ0lLdlovNENhNTIvbXg1UFN1RlVFYk1UU3FEeWxL?=
 =?utf-8?B?b2JVWDJ1QUNYS2VjVHY3MUpIRzVtazBjQTZRcDFKd2JKMmZOK21NLzJkdkhm?=
 =?utf-8?B?ZjRuZFU5TUJJYURGMlJBaWpBWFFQNkM1YzVZUFRnbVJwYm1sS1lzRC8yVURV?=
 =?utf-8?B?SGsxQ0FMR0t6ZG1BYUFzMnYzbmJjWGpDa1RHN01tYlNmRy9KSHZUWjROR3o1?=
 =?utf-8?B?NG5EeklRa3VOaFpEcEFWSTliUXFHV3JzazlPTDFmazhhNDlRQ3I2UU40dTRm?=
 =?utf-8?B?ZHROZmdPaTNiTmxmZjltM1dOUDFZZXpaQkY0cWtYdVNWZ0lzUmdVay9QU3Rv?=
 =?utf-8?B?VnBJeXViaDdjNCtlTmlLM2R1aTk2Z0NwRDBTNGJYRXUvajM1aTMxOTB1QWxE?=
 =?utf-8?B?SDJwTFJCcUJMNlY2U1F3YzFBUUY1c0FFeDNXdlF6bjIzTDFnMzhxdDVrTE5m?=
 =?utf-8?B?bTVEdUpDSXAxVEdFbFUvdUg5OExUdjhhR3M1Nmw1bDk0ckdSdGRxVXBzYXBi?=
 =?utf-8?B?MTQvcUVoRzVKNXJDT3o3SU9HbzFGYnFkakRaWjFQWWhrc0Q3Um9pWnJXNXR4?=
 =?utf-8?Q?YRuZcbBFpWEV4TTSq5wKcSk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tQl7/CGXwQpS64N7G31XgKJlol8d1V3V7f6/lqTV8DujxBoUsbOnERxkXcrZwT5nLn8vXMFjfNBcuH4cTYO7Rg2ojHDBke1r04ARjnu9rH1LMPVBcYUmi17RPr+JukFZ5szisBdEjiXoeqxkf2b10dyhR+NwimfsgUS5YHiqOAH2ZIWfoOjnKOT1P4p0BkkNdF9kpnSYK5aLZ3xDNEnI6E2yVawLu6YjO4EuR/4McyQ3XzC6ree8ZxTrj6VcWm/ohDlNUUFTu4mK6ujJ28WCZwR3fDn8hSKWGP8WPvQff4ToboFDiEAYyqFZlrpygaPTeANCKlCTpycBDagET9X1hK1wK6aLlaLQZTDyzSvIAblV1zwDCy1bdJwSOi6NeMzhw7ikUZm/9JTUqsPv/78NF6RoT4wjKQVLwPXM8ctTLAhUChsptyvZJcsVAMZnotmihxUIXqLnRazE4umb+pwEBC4HNJozVaGAc4xTs6ZKDCJuOtt4z8VAkoSegmnuu7HK/oEGG7OQNW7wxCwIwlvz5Pl47Y/nRbnuHAGZlFA9giSxP5NRmHpFNrC5s2Xask+M+kdvQuSGV0ITFr/1e4eeDt8PeWAkECNJetOyz+hNTJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa7c1f1-adcc-49a7-42c6-08dc7808c726
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 13:37:07.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk6lszAtMtCGE7FYqzsrrNvnW0bI6l0y8d1Hp3F8UGETIExWmvE7smtsMcspRsH6dOSZa1qHDdTz8yqMqCLfNYocsKhwwSFHEHiCby4PSdov5AeibM2XiSLhEbxkaxGJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-19_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405190118
X-Proofpoint-ORIG-GUID: b7VUg8RkzE71DB9slilB-6S1zKDMQHMA
X-Proofpoint-GUID: b7VUg8RkzE71DB9slilB-6S1zKDMQHMA

Hi Jonathan,

On 19/05/24 17:59, Jonathan Cameron wrote:
> On Mon, 13 May 2024 13:34:27 -0700
> Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> 
>> When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
>> instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
>> like a copy paste error.
>>
>> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Please make sure to pick up tags given on earlier versions.  You dropped
> Crt's Reviewed-by without giving a reasons. I've put it back.
> 

Sorry, I thought we should not add tags as v1-->v2: is for addressing 
the reviewers(Crt's) comments.

I will keep this in mind.

Thanks,
Harshit

> Applied to the fixes-togreg branch of iio.git and marked for stable.
> I'll be rebasing that on rc1 once available. Until then it won't be visible.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> This is found using smatch, only compile tested.
>> v1->v2: Address Crt's comments.
>> ---
>>   drivers/iio/temperature/mlx90635.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
>> index 1f5c962c1818..f7f88498ba0e 100644
>> --- a/drivers/iio/temperature/mlx90635.c
>> +++ b/drivers/iio/temperature/mlx90635.c
>> @@ -947,9 +947,9 @@ static int mlx90635_probe(struct i2c_client *client)
>>   				     "failed to allocate regmap\n");
>>   
>>   	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
>> -	if (IS_ERR(regmap))
>> -		return dev_err_probe(&client->dev, PTR_ERR(regmap),
>> -				     "failed to allocate regmap\n");
>> +	if (IS_ERR(regmap_ee))
>> +		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
>> +				     "failed to allocate EEPROM regmap\n");
>>   
>>   	mlx90635 = iio_priv(indio_dev);
>>   	i2c_set_clientdata(client, indio_dev);
> 



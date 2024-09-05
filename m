Return-Path: <linux-iio+bounces-9180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1A96D34D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115451C25A8B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A319538A;
	Thu,  5 Sep 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="iRqTJgvD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D194AF3;
	Thu,  5 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528611; cv=fail; b=ZWPLuAk4s9P354QG4Bz/ZS30i2vm2crJ4bZpw5AiZiUdRnU7MxRrPSnjyOBOfWCsPyd8a6esvOqo7qZw3AZkipO3Qiigo1zT2HeK7sM0dq7CGBaKvP8ZtQe9hns6evmdMkQT+rE0beGzsu20FwvZ5qytjuxLzne/717Jb1SToVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528611; c=relaxed/simple;
	bh=Sw99WEgEaBHxwU6z4Hs4Br1OU4z5AXxt6yVF2B4Oj4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pfb5zMvKaA5fmzOFXocucme8Iwt/+CPO1ehd1NF6HPExldpxqt8Pg520caBfqeHnWKSLtHQvUoenfX5i/v5z4j7xm9pl14poZJkfE8ijD/zoYo/DQq08F1zoMRVUdHHPLM9Feh2c8DJCbMvuHRDziJVGL0uSZVsSxAKA5MWbZOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=iRqTJgvD; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484MZm2S007592;
	Thu, 5 Sep 2024 09:30:04 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012052.outbound.protection.outlook.com [40.93.78.52])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bvhk3t3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 09:30:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uje35792XjiPEYqbotl43C+P6YOYq4xtrYZWGGHPaFAB0syIBAkNP7RCCF0cGW2XhPa9cajITvi3OI40gk2eSSZaOB3adLr59LNTV0Y5oZn72fxurDVxYwwmd6UaoJAkVruESr28vVV8ZVTFcn0KoJwYrRc097f3nzKvvBaBP1hYLtlei6opyrNDyIXvezlrMlC2sGeEv9ejH+tXazCJOQnYhLRdSvS3lTFUULadMNQ0+d6c4j8dILwdhtYgrrfwiFjCet4IvOMbTqjgKXwq7Y0rmi2s4k4D/84CIfR1D11xrcJI1OOTg6fDSV2fzSl3p16TDs4m/ajFDdUXYB2Umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxGuLs+MOxjtnlF/pvc2Qmb/VCoBP2fJvgsa3g9QbcQ=;
 b=COZgk04EOjk5NpmIn4mbSIwUQQLw9Sd11Knl4M4hOGghI6yoB7AYOlQhZxDC4hPVla3LEgp1Cb93GH0aPxEUqiHPLChplrfjeATa2O6u+vVPWoeRG8jndZBFvuXhG1tXc26cYS1LEMviPUfvFJQUHhf8EmootcnNZTkJfTOPX+VmX9eMg42i7KTYNNGQVs6+ilZ5bAGS8yrIYYzct1b6XBNQtINEOlYwI689qB9uji+FhP7osyS4ioLXxLtxYKqfKgFBiBUVlPVv6d2rU7E9lfdFkLtFk6Im25Xi0qmRct8BOYrwvTKBZcMwGoW0lEZgMzp4h4vNhei08aF3jHDopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxGuLs+MOxjtnlF/pvc2Qmb/VCoBP2fJvgsa3g9QbcQ=;
 b=iRqTJgvDuLRXwspt9q+WhVhtGK2aBlMgTr1fE7hPbx0I0E1qcqaAXUkli7ygw+pox9mtzDljoCjibhLWeQNewnvkS+FKvxlHLKer3k205BNjLaZZt8/Yu/2tNiabVfLxgmmg7Iu26jl8CXESqZzDeNmtv+niZ5Vt9DTk6lQysA1ihhZjLD7HmdUqgSKW8fIG3/ms+jL2WgVsjbiDYkHqwS/Tn5yemTGXUYx97iFcoPeXFC2sBF0Qu1ibNeyFpe38LrReYz2C0Sd0+3Eht0fmfRucC/zsuWbTyMdu4/EHaHRvh234UvCs0/NSLJZ2g7KFwHgDVCJMs/5PG5ainwlKTw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR5P281MB4246.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 09:30:00 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:30:00 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Gyeyoung Baek <gye976@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe
 function
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe
 function
Thread-Index: AQHa/h8F3ggf8XRdBEat2H7IesL0qbJI7vKF
Date: Thu, 5 Sep 2024 09:29:58 +0000
Message-ID:
 <FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240903163302.105268-1-gye976@gmail.com>
In-Reply-To: <20240903163302.105268-1-gye976@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR5P281MB4246:EE_
x-ms-office365-filtering-correlation-id: 7c79995f-cb5c-47f4-5816-08dccd8d4f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Vo1v0Xnh7kZGUkoVJcQS8qBw9tXSccg0SC17PPqLDotZBc3GEsmL0NrzKL?=
 =?iso-8859-1?Q?mNvoK85NaVtjwjLa+sIuFbcc/d/c9U7Z9jS7KVtKLh+rVtzFejsbpk+9Dw?=
 =?iso-8859-1?Q?J0x9/+5WrKXyc0gCVQkxfmiwVlY0s6HCJ0AKpB9F7bdYskzbmm0qBjyzsR?=
 =?iso-8859-1?Q?/vPQFKF88oEDWoKIUwcwkk6KHYR49PCRL+s9W1XpGklEw43soYLgmoLKAv?=
 =?iso-8859-1?Q?VtCNTCsv05SgYVzF2CgHvwTuw0gIGPeQxfWvDR9Ojls43+emBea+LyfUsb?=
 =?iso-8859-1?Q?GGeKPL1l7dkGt0LUVTkIDI/q7xzOzSD7yqRh4MNWiAWbfW82oI9GCSyA10?=
 =?iso-8859-1?Q?aHOCUb3gTqssLpXHD3amcxzXBh+Q2JecvALK/LTMQKlPGW/9Cne+hBvP0/?=
 =?iso-8859-1?Q?cUCfLQ+1VE5phrbgQorEhcs4XE/A6GX2uHe4DkpIN+2GfJeQk1MEk8JKFx?=
 =?iso-8859-1?Q?LgSL4GQSKeJHGRvMq05+mnk+9EFTa7E6KIbVzWCXStR/l2cDfXRmd5S3v+?=
 =?iso-8859-1?Q?Sx1cL3myd5FQCPvZjGzu8p1wdqox21iYQyAWdxo1lu5UMv5Q8ePcxAkHaS?=
 =?iso-8859-1?Q?nBXqRpBQ9EZYUQTPrOQxmI2uKfAtCTwX+b5nNlq5R+wnGMGBj88yfJTYp6?=
 =?iso-8859-1?Q?1Sd3S5AnQ2CBr7MN5LPSictmZKb2Csbp6dilG0ILoUESfRQtqwf/Ky6Toz?=
 =?iso-8859-1?Q?z5E58tibv3T3eAGwShW8eYBQXhr4qzLJJGnOA+s8XrHtHS6A2ppOpCvUju?=
 =?iso-8859-1?Q?Tw8yazFxUYTRhtnNHCrkU/C05RwziY5vNV6HJ53SG8IjfWkQHbYJzxrPzx?=
 =?iso-8859-1?Q?LGH2KmvWsyDZEdaYWdDTjx4ta+tQ6iMoZ8H2Q+bcHf2/SLlXKjm/ELxZTi?=
 =?iso-8859-1?Q?N/LyaOKPUOXJ3pOV9NYG0QTvxuc27xx9Sx25pGTioJCyGa+wTa94FW7lV/?=
 =?iso-8859-1?Q?ADIOHhZLxH87YSgp4oGszKA6FX5KQSwGgq1B8ewDeUz57J41jitxahYaPr?=
 =?iso-8859-1?Q?1VbqozLZyQT6x7mL3xFYug4BXqSH1Z0HeKDxWAZcwVYezo8TFuY2wPptaK?=
 =?iso-8859-1?Q?5WUSbmM9Zwok3L5NRRmRM4xzXJ4yKsKT1ntCVMPZqgeAe5Q29/xpmj/8bw?=
 =?iso-8859-1?Q?HEyPi68k1/mKVYW8O8PxUclDgsVsxfxbf3cragDyNucefzoPDzPqewq/pc?=
 =?iso-8859-1?Q?6Lb/O+amjn8oAW6gBu53yZ+RU1HW7B/mhj6ToyDmwAMJiag5vGYTCRLIsb?=
 =?iso-8859-1?Q?zneVyzGTSXS+yjmGsoIR/chO35pwGOZzYd97s+e6RMmIzVqXxdw4LqKmPx?=
 =?iso-8859-1?Q?w/KaqBhVAJpvruH+pGo8GyyBQWUPRz4e55LwwScNO7R72N96N3WdAfATCh?=
 =?iso-8859-1?Q?hkHMUNW/pSY0FeFX1MF0IkwDbiim0kUFv1QxYdxdicG1OPeCknyW6RqxMK?=
 =?iso-8859-1?Q?g4hJiBtcBSgIPzPmA/MO11mA9fbFLLwiBC72xidQ0qBeoFZtKYcVtCw1ih?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sDF6e56x5wqAx/4Q8GQuJTnaQR8jMYq+y7gHqE5XaSjkdMAJvTyh2fur45?=
 =?iso-8859-1?Q?L6GZaXxBza0UCRT1WbALb8zp6VWack1qZwOnT3vTVma6wbOUH+mHZbPz6z?=
 =?iso-8859-1?Q?veTDCmTnNMiLT++AW6HbQPN9llCQWNqKNVPIROIAA4u1CmqxJ8pU0eMSxK?=
 =?iso-8859-1?Q?57ys1qiGZkpZdIB5qvo4BSMnXHdnbK1kGQ6usDacVg2YFrowAPKo40Ajcz?=
 =?iso-8859-1?Q?JzL2LoWh/ySQU75QCLeJilzVsFI9+0KlgO3dCA1dA3FkX9/Hsyyqz4QxR3?=
 =?iso-8859-1?Q?cT37NjSEl0NaDVSuvpp8ZpZRmEWwt8bxBB45J44I3e2e2phD/oJhoDNWSj?=
 =?iso-8859-1?Q?XPcIbb6/c4gxltEXvHTR+j2zVYJ25ETBK4i+CjHdbo4wZzRtD15hLwel7l?=
 =?iso-8859-1?Q?ZkUzhcV41LVwMRmlOlaljKjl7venBqh4u8/3Wn4QxcQMTR6Z1qNP4s3hTo?=
 =?iso-8859-1?Q?P1ok/c6BmDUnkSAbliA/CKoGA0qLTXXBDDfyuTkrclizuu9la/K5steywu?=
 =?iso-8859-1?Q?IDNxlEY3QplxqzZa2BoCoWA/musKSxlC3ghVdxvofm4Hx7LVHsxdF7j9EL?=
 =?iso-8859-1?Q?b6fqyul/iUTGlcVf8Ge0TFvtYsqbhxs4hNFvKQn6m5vbeGzK7G+UvGoz3R?=
 =?iso-8859-1?Q?KA3e+6oP1ttACtSY3IdBWj+pLlKQAsBe31i90Q7z3YqwGl79a3oEpe7Eig?=
 =?iso-8859-1?Q?LcY5BGPfuYJycKXrQfwd9R8bzAfSfSG+wvKi6gUxODxVLRlmW/ke0FuCdB?=
 =?iso-8859-1?Q?++W5t7MzrR7Y2Jqf0Cj4iQpaNGV1oPM/XRelxlbarxG/bS6KWteL2aBK/z?=
 =?iso-8859-1?Q?dXe67B88PagsvWuoJhG9DACVt+jdu+wtrKMI9GTlignBTtWsO6g4AwQGUA?=
 =?iso-8859-1?Q?QNt+QoGhqXOFlE4ReIepX45F+nlrvvwPgbXC9ANSLhX39qALqEm/QtHZ7h?=
 =?iso-8859-1?Q?GHdqDoXtAfizJ+X3f5tO/XYWXynVhejwsUQoEMrlToBJTfhjDG8zWf68bP?=
 =?iso-8859-1?Q?xGVxo0XF0tyswodZtkpFcCa2JUJpi33z9Ye5Ha0ziCUcsKPmZlJnbNkoQW?=
 =?iso-8859-1?Q?D8EB/XxuwW//Mfm+4q3u5DvqTNJj1c5wOn0+poDrUowbVwMKrdLQbp6off?=
 =?iso-8859-1?Q?u1P9T87dUjZxB1edIiyXTK09VnaHbGD7qe2m2fzF3GqiJ2xFxfSBU641Qi?=
 =?iso-8859-1?Q?5PnBNpUKUPe1QtdptgJNpeEZW327lvRCHnYwsE0jvSX68r7psrqV8UPMOa?=
 =?iso-8859-1?Q?1rutYKnOaOKtmBqAWQpo2pnZH242y+ojA92WB9KpuA2iGiDTNyOTIm08UR?=
 =?iso-8859-1?Q?OUR5CmQO0w2k3ifC6vdJDTryRQ1F3FNa4tMArOVG5dkBFhNndDheZ+zG41?=
 =?iso-8859-1?Q?RiS7ie8mB+9VmzwFs/nJ1EdobgqrwoNLgC49q73TKpQQAPVPPXs6WoeAMx?=
 =?iso-8859-1?Q?6e1JbotxBt42inTfX2KEXUM+EhkKtlnSGhdCpxz1raw/ZSoSeHa9Vtn+IY?=
 =?iso-8859-1?Q?56xZK3TqPS8udx/t6Y9BMBRr4ErOcKwaagwRzu5fuAutN3q8ST5ftxPRvk?=
 =?iso-8859-1?Q?zjxeS4pnqpOrkN+cV4H4kfkLwzWT0mvaR2OqSRchezyUzgaaEciNtYJ05k?=
 =?iso-8859-1?Q?3nuI1JjmvjXxjZS0mo2AWx8lqJLQq/F1wL/9NI/q1JYn3var1+3JhsXQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c79995f-cb5c-47f4-5816-08dccd8d4f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:29:58.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaZXrA6osFMbgGfMgjFzzQATR7d5ZS5OIbFB+bOi2W8ajd+1CY2DSEFJZaw1e0Uwdm8Rq3xHIyM7iReFyzwGyUswyFfjfIrCJ6mWCCjrxAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4246
X-Proofpoint-GUID: SjfvnycBCWlsouG2dJgl_q2yD7r4sFTz
X-Proofpoint-ORIG-GUID: SjfvnycBCWlsouG2dJgl_q2yD7r4sFTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050068

Hello,=0A=
=0A=
nice improvement, thanks.=0A=
=0A=
But beware there is a fix pending in fixes-togreg branch and missing in tes=
ting branch that is changing this part of code.=0A=
To avoid a painful merge, it should be better to wait for the fix to be int=
egrated inside testing.=0A=
=0A=
Is that correct Jonathan?=0A=
=0A=
And I would prefer the wom_bits being inside the inv_mpu6050_reg_map struct=
ure.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Gyeyoung Baek <gye976@gmail.com>=0A=
Sent:=A0Tuesday, September 3, 2024 18:33=0A=
To:=A0jic23@kernel.org <jic23@kernel.org>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>; Gyeyoung Baek <gye976@gmail.=
com>=0A=
Subject:=A0[PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe =
function=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
'wom_bits' variable is defined by chip type, =0A=
and chip type is statically defined by device tree.=0A=
so 'wom_bits' need to be set once during probe function.=0A=
=0A=
but before code set it every time using 'switch statement' during=0A=
threaded irq handler, so i move that to probe function.=0A=
=0A=
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =A0 =A0| 16 +++++++++++++++=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h =A0 =A0 | =A01 +=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 20 ++-----------------=0A=
 3 files changed, 19 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 14d95f34e981..322ae664adc0 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -2076,6 +2076,22 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,=0A=
 		return result;=0A=
 	}=0A=
 =0A=
+	switch (chip_type) {=0A=
+	case INV_MPU6050:=0A=
+	case INV_MPU6500:=0A=
+	case INV_MPU6515:=0A=
+	case INV_MPU6880:=0A=
+	case INV_MPU6000:=0A=
+	case INV_MPU9150:=0A=
+	case INV_MPU9250:=0A=
+	case INV_MPU9255:=0A=
+		st->wom_bits =3D INV_MPU6500_BIT_WOM_INT;=0A=
+		break;=0A=
+	default:=0A=
+		st->wom_bits =3D INV_ICM20608_BIT_WOM_INT;=0A=
+		break;=0A=
+	}=0A=
+=0A=
 	return 0;=0A=
 =0A=
 error_power_off:=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index e1c0c5146876..a91b9c2b26e4 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -212,6 +212,7 @@ struct inv_mpu6050_state {=0A=
 	bool level_shifter;=0A=
 	u8 *data;=0A=
 	s64 it_timestamp;=0A=
+	unsigned int wom_bits;=0A=
 };=0A=
 =0A=
 /*register and associated bit definition*/=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c=0A=
index 84273660ca2e..b19556df1801 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
@@ -243,26 +243,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int i=
rq, void *p)=0A=
 {=0A=
 	struct iio_dev *indio_dev =3D p;=0A=
 	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
-	unsigned int int_status, wom_bits;=0A=
+	unsigned int int_status;=0A=
 	u64 ev_code;=0A=
 	int result;=0A=
 =0A=
-	switch (st->chip_type) {=0A=
-	case INV_MPU6050:=0A=
-	case INV_MPU6500:=0A=
-	case INV_MPU6515:=0A=
-	case INV_MPU6880:=0A=
-	case INV_MPU6000:=0A=
-	case INV_MPU9150:=0A=
-	case INV_MPU9250:=0A=
-	case INV_MPU9255:=0A=
-		wom_bits =3D INV_MPU6500_BIT_WOM_INT;=0A=
-		break;=0A=
-	default:=0A=
-		wom_bits =3D INV_ICM20608_BIT_WOM_INT;=0A=
-		break;=0A=
-	}=0A=
-=0A=
 	scoped_guard(mutex, &st->lock) {=0A=
 		/* ack interrupt and check status */=0A=
 		result =3D regmap_read(st->map, st->reg->int_status, &int_status);=0A=
@@ -272,7 +256,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq=
, void *p)=0A=
 		}=0A=
 =0A=
 		/* handle WoM event */=0A=
-		if (st->chip_config.wom_en && (int_status & wom_bits)) {=0A=
+		if (st->chip_config.wom_en && (int_status & st->wom_bits)) {=0A=
 			ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,=0A=
 						 =A0 =A0 IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);=0A=
 			iio_push_event(indio_dev, ev_code, st->it_timestamp);=0A=
-- =0A=
2.34.1=0A=
=0A=
=0A=


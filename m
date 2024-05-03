Return-Path: <linux-iio+bounces-4780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB15B8BB14C
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73201C21212
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B9157A54;
	Fri,  3 May 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="rfu26eUq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97027157A4E
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755541; cv=fail; b=BNIVC74Km2AyRXCP2eUBNie1ptvSYvF+pC256c4r70VsDxsC3YJFo4AMBHjZR2i/M21hRKkkQUD7jNDKRM1UZHJ8uDhKeHSX8AQtpqQ8gGA3SzcwgHQ9LtslYgZDCBnYUR6W/J2oCuVtegwwvEMdOJ2BM1r7KTIVtFyhNUEX8Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755541; c=relaxed/simple;
	bh=HVnvQQhW85/5/9oH8UVF8JGDWY7BU1m9btX4rvoLF5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EF3GyZWcj61vXaQPnnstO9pTBRtR35YQhD9plcgZC9bZaEd/HGgXSgDPQVr+EN1Gr1zVRblIO673TlVt/hYuVKZ4F11hvebvrozmwjkchv375NUwFh/Agur8HqTD5mvZYFnt+wO2qQR9ZrxfF4DMxttfjqUgZnto5Nl8HtTI3D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=rfu26eUq; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443GjVJ2030549;
	Fri, 3 May 2024 16:58:31 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrqr03vas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 16:58:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUPgl1DolQY6nukWy+VgvlFFdiysnFne4EbNUokcN83XZ2MQiuDHaGTbw976xcLmOo+3NWLbuFrvbNcJqvw5jbYxX0giMWZMJoNCWkc4b8wHPeen+Pmv5w/HYMCgC3SkPQjJGjM2TNS/Yu2noTY3waF4JPd/hFEnJasIFpVM8mNvkT/gVzL/nlR4Zf4mg2Fd7L3rW8cHBciAaMWpJ7iKNUFq8G6omO0Wpry9nqCgHDJHNTAWbA0LpMGK7dbXacvPF0sfamKaxmh6k3fkms2EFVfdzht/xd4wfsTrIuwiP7ur3ZaERhFPuQuLkMXBMjODPdhHat+zURklC2zWLgLfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rn+eOskyrnGJXC5Cbie1i0Q2Wywo1VvKx3T548acv4=;
 b=VlXlMtdFStPyuV+1AERJRVORrQCJGwY4f6JqCJtElw8ovxwVsKJs+r/SwE4W/y2Ni/Jhnkg6Ifpr1vGJHL/gVaibSy09pBuPydjglykPamZwhZFgas6R5RNRy0BPjEsTZPsnw21IZMZbcB/rwN/rsscYVxBF9B0NyQxPEUAbTKqQjZeEDCW0PbdinpValq+SyCmIu17uvHQJ0+vc5bYzJ90p0xAWp+SlsVhsSTRg4A83L/KCvjU1VptbM2kZwnYIVoqssBJ1AUzhAUXVJh2cV7C71bdSWSzfOqGgEK1WdqSISuByqwDYHPG7P6xsumpWHyai4K/51r16Dbeq/FIjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rn+eOskyrnGJXC5Cbie1i0Q2Wywo1VvKx3T548acv4=;
 b=rfu26eUqPsHwwp3ECaflB7AeuDbPwBKQAwfTmc+47rO7WpZhhuuIZaK+wIPtsF6QMMfUclV7AepfGJLAL5kAfmaPJom6akBeeibI7BUCtXWzbJYWhuhUdcHI9MNvLuG1ehuPM6r1UvYFq0lQULhlW1JkGCHWvNhLR5CNQ2xk5BEs/UxSUs/QGAT+BvAc4vtQOsu3qIwC+I6unuQBzG1Q0GdfKLBnuDXzBfvsiYBRvjDBxjBC6E2d6fOMt4hkz1R7MgEnP3WBYOpHPOpmARnABKGB276j1o4t5OrxWxT1f3FbocPzLq2xFwZhFpYIUJIOb6lPyq9wYG72vGUlmU5SOg==
Received: from BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1c::5) by
 BEZP281MB3332.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:74::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.31; Fri, 3 May 2024 16:58:26 +0000
Received: from BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9b9:82a5:638b:7109]) by BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9b9:82a5:638b:7109%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:58:26 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp patch integration
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix timestamp patch integration
Thread-Index: AQHanTlTpwCpvaaEnEq9+mvBOnaVsbGFSg4AgABxF+E=
Date: Fri, 3 May 2024 16:58:25 +0000
Message-ID: 
 <BE1P281MB17451D71F7DA272440D1FCD0CE1F2@BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM>
References: <20240503090700.235707-1-inv.git-commit@tdk.com>
 <20240503111124.000070c1@Huawei.com>
In-Reply-To: <20240503111124.000070c1@Huawei.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1745:EE_|BEZP281MB3332:EE_
x-ms-office365-filtering-correlation-id: a74e013f-5730-43dc-f3ba-08dc6b923fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|3613699003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?VRLtBZIJv9K3IzjAPEpAjc0aTjPfeiJipFLf9NOYj4Eei/dfza/bVi2mYG?=
 =?iso-8859-1?Q?C9iXpMdkt+KNbqJY9HAWDMtc7RATIF/x+bDXFKJ/11ugF+52RioQq9jmvR?=
 =?iso-8859-1?Q?jCrHBPRSAGGDwtCn9B0nURgocbZf2jnCIAqMrukotSVBvWZVV4kYslRwRk?=
 =?iso-8859-1?Q?cOwCpmFTtqAngbkBt901YU8Us0NcLEiJApO0xFF0VLyra4Zm3je8wX4tLE?=
 =?iso-8859-1?Q?ikZK/gKuyaqEgm076U3mEbx8KbFEF9EkFpkIyr8ZlkR9XyDo7ujcMdwDDW?=
 =?iso-8859-1?Q?vJ5BGlIkd4lPGeA2dRYzfzq5nvkX8pIB1o6d4ldlq+1EzE5keXqQJORJDx?=
 =?iso-8859-1?Q?5OoX0AMXJHzcNdben6JeS4bfk4XiBI8FmWyVxNyFdAWPdUqwoEqmyL+1w8?=
 =?iso-8859-1?Q?ZovUSIAnrbpGmCfpFM+9u8NQZkRxc8hXh5pN5v1hQHjTRCplBR1yyYhzg7?=
 =?iso-8859-1?Q?rc1vfwmc7EPmqhp4TSskzqjapgdK14ZAaSH/+Cr6eHt+yhzihcjlIUSltq?=
 =?iso-8859-1?Q?w/mH74Q5JBRXe5B6zj/PIlqIzG50P+Bien7mH1y8Pe10oVbnBolyESOdZQ?=
 =?iso-8859-1?Q?fLXiGvm0uWpoA2CfOxgz4pNNJ6pvgEYzkSnC9WrFdwcyrGJPtlhZj+t6Ff?=
 =?iso-8859-1?Q?GS+3VaAwa3LgeEvKzUIpijaRFmzwtxZRT/oDtykXv7yyCcGsSebD2bHD54?=
 =?iso-8859-1?Q?gfKfi4PEpjERh992LFPO1lA1BqG9Lqd7zHsofhF3Ir1AyVUkdXGoNSFGwj?=
 =?iso-8859-1?Q?QKSXf3qdWy65Z8vvaI9HE2WQKpaaHAXMc/8PFsd3GPbclxP5iPeSHKkOKC?=
 =?iso-8859-1?Q?GPpgSHprvEJtaFh9VDhUkBU/wE5cUW5ru7YmROZZ/IBOQxwSE3ZL172RoZ?=
 =?iso-8859-1?Q?d9fSsC/D6IpSlMdBgY2W+R1X9N6FIA5WMH8hz/SI3ZfziWNew0XbljybLF?=
 =?iso-8859-1?Q?XtzUCAdYcOAeEUmuyJRTw49yv8K7HwLqSMhxOKEKZqy4PWk1XEar7zXYNZ?=
 =?iso-8859-1?Q?OCN6AoPz/1yH7RtzxbVkdPK9ALl2M9wkKadV0g3NF0PLJfWrpLSRZ0SH3B?=
 =?iso-8859-1?Q?2q91l0zdaXtALznKuuCDdot6TIPD6H5eqU4onDANO8VKTd9iu2mkc7GKB2?=
 =?iso-8859-1?Q?2UjoO1CwYHMl8t2o+onltnvW3UNDumsXcKEb4FE3p2rDYsyiuNChqQG4qf?=
 =?iso-8859-1?Q?3NZpmqhoId33n/vZKrClT8BQXteKQ+tyu+e4TrcwluCTlBbAt2ySrMaVyM?=
 =?iso-8859-1?Q?tZkXX7+KKe68MMFTVCLwRLdjifa0lCgKdKB18/1tQt483u3bhfT95/fK1j?=
 =?iso-8859-1?Q?5AYfXq63HQHEiVdGqkrr/uTZp4So4w7nTYgHakEYc/BBN4fHjcRWNFf6TX?=
 =?iso-8859-1?Q?vU+c6AW9eM5ZTye41tr8FI2EmzpScjpR6apWLYGiWG8nDENEivwjY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(3613699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?oE8Krx+kLsHJaVtZwjLH+VDrZkwW8W48Jukd+hPwa4ybIcMfTeC36iVQ/o?=
 =?iso-8859-1?Q?TRmR/nk8bC40P4EutkARG6PmmtRP8N9D/Y1kwwa1PyasUx4ngZZ8MnOEjE?=
 =?iso-8859-1?Q?64HjK7jIxxZhA8K3IGJsm1rZkQGQrK0bIXgNXPHFcs09fvDxRCfYDOwSOg?=
 =?iso-8859-1?Q?omhz0+FdkgakN9FyEyDNRDA3GxO8OY7PQvjQOQkaNaL+tXswc2kg+x3W6D?=
 =?iso-8859-1?Q?pwC508wk5nZOXp0cwISIQuGkENDpl3/TJvTKU268rthKgmEXrmBda0PC6g?=
 =?iso-8859-1?Q?Gy08GVRMYdfTo9ERjaFT1AlUDcX52CYEk+s4WIZ/VpVt19Rjrd5S1HjwzS?=
 =?iso-8859-1?Q?0fhTkqq/tfBlDGPyXxPkGHxF76vUU7asAtuVs88CbOIftZBBYLp06mWIeq?=
 =?iso-8859-1?Q?fIiVitObzl0n8USKIAG2gi1nX9EnLGUgaCCftiI+1Muk0uyR/Dsa9ft6Hv?=
 =?iso-8859-1?Q?UVkvLBrOCRZyZJXc5uElLpACCBE6P9VZ32aGXY+7OAUcDvJZGybB7gpfkx?=
 =?iso-8859-1?Q?WJ9TgCS946IdreehI+2Nl2JQZZtdRhEAwWOy1l1HyO0s35LVO9ivrpQOCa?=
 =?iso-8859-1?Q?OEalzDF8n6ORKFynkcij+DT2sAqId2+Ayf0smwxM/kn5/DwaFXCDbdg8R2?=
 =?iso-8859-1?Q?VbpiAicTobkF0WuYxVgcQZSVL0BU4Ie0aZy+wn6cn31DgTpOWtMhBtlhEP?=
 =?iso-8859-1?Q?kuJQbK5vTfu8iy1ZBuwXlcRpA8UZw+1WGTWxXJVkrmkB1LxsQh6n5yZ/Je?=
 =?iso-8859-1?Q?OhUduAokG91/qq7Wq0P7XtjU0Ig1sHEfzNmzs2+QP8nc9YkC0voqjXHJRC?=
 =?iso-8859-1?Q?Gv6Wqc4E2H8zFOgO/iPCv5s3iruFSa73+n4YEVu/4GwGdEblVyA6RcA665?=
 =?iso-8859-1?Q?02WFJUfOKrC46WKINq4N9/lk/LX+WVHSfHrEB9HPbFUrRzhGyLgcNTxmvG?=
 =?iso-8859-1?Q?RGk3+/zHDlIgHoHX6hu7heywaRJ8Uihe5OTuuSHpGod3uZwY8357pLhXDt?=
 =?iso-8859-1?Q?dGl8Bo/WQSLMKxHz1PENxoyhQMzDzHpftIyi8MiWzv3a2CXHXlGyjRotzj?=
 =?iso-8859-1?Q?CHl8otv+AdCmEU026KLP6JhLVpYmBSZvHCdK+zEtMtWpFY1oti5Jz940Ak?=
 =?iso-8859-1?Q?pV2jzcCftneBxvKzwE/5uyBYauM+j9pOVyHi98XYPQDUAbY9bgq8bcmyj3?=
 =?iso-8859-1?Q?5vRwf0/gaOxxlpKMWN4IWRpbZoHR8o9qwvcwd3pu73Qm5QkU3qk/8kBMvI?=
 =?iso-8859-1?Q?v4H0kjhgqWYw10MIeezPsXyBAUQy7dNVGVElqt7zxANoD6XMq1koEHpkWp?=
 =?iso-8859-1?Q?F1T7zxxsd2/oACBsuNMlud8UINDYGQHr15C3VvN5UwvIfQ3i/L1PuWcYnT?=
 =?iso-8859-1?Q?1bInQJzpqaK1J3W0+57sljwIv8E5wIN2SBtenyNlX6DDHPpQa194DRpVvR?=
 =?iso-8859-1?Q?Lvul9bRpQHwq3+KO9gskGorepeZfC0l1dXnl+B6Lyv7TW8WntOD8jf0Hs+?=
 =?iso-8859-1?Q?9oJe8vjB5Ls5t6Vb1/o/bZqaQqFq12kpvwUpaeYO86avnb8k3dJ3a0+Kd1?=
 =?iso-8859-1?Q?JJrydBTv/ivLdqbysK+wuKt4orjr6pOdV2IyJ83PrgEGLQzKlz7hCbYOp6?=
 =?iso-8859-1?Q?X+ZfMCe9LgxAEXIyRrSP7fo7SNeUwv6QtglyMeS8FMd61p6E3ZGf/NZwfA?=
 =?iso-8859-1?Q?Ek5nm4CBIoD8rt5Xfa9eN0yD0Pan0rIRPICzo2ayme3fcdukR+u7l83twP?=
 =?iso-8859-1?Q?nFYg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a74e013f-5730-43dc-f3ba-08dc6b923fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 16:58:25.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRIQewEr0GnkggUHL7QxmC5kBToCVjScVxJeqnBhF7YSqy483z9OPfwCSDhzvcYUXYaUegaS2WEA3rgQD347hoqzp+cpB0sJCEnthKk0Aoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3332
X-Proofpoint-ORIG-GUID: qd8UwPcsTdr_B60XTVSj4uH2sJoFiQT3
X-Proofpoint-GUID: qd8UwPcsTdr_B60XTVSj4uH2sJoFiQT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_11,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405030118

Hello Jonathan,=0A=
=0A=
this is OK, problem resolved now.=0A=
=0A=
Sorry for the mess. I will try to warn about that next time.=0A=
=0A=
Thanks a lot,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent:=A0Friday, May 3, 2024 12:11=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0jic23@kernel.org <jic23@kernel.org>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.c=
om>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: fix timestamp patch integrat=
ion=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Fri,  3 May 2024 09:07:00 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> For fixing commit a5918cecaec3650df in iio tree.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Squashed in and togreg tree updated. Please check it!=0A=
=0A=
I'm not having a good run with this patch, so maybe this is 3rd time lucky =
;)=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 12 ++++++++----=0A=
>  1 file changed, 8 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> index bce25ff57ecd..63b85ec88c13 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> @@ -503,6 +503,8 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600=
_state *st,=0A=
>  =0A=
>  int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)=0A=
>  {=0A=
> +	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro);=
=0A=
> +	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel=
);=0A=
>  	struct inv_sensors_timestamp *ts;=0A=
>  	int ret;=0A=
>  =0A=
> @@ -511,7 +513,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm4260=
0_state *st)=0A=
>  =0A=
>  	/* handle gyroscope timestamp and FIFO data parsing */=0A=
>  	if (st->fifo.nb.gyro > 0) {=0A=
> -		ts =3D iio_priv(st->indio_gyro);=0A=
> +		ts =3D &gyro_st->ts;=0A=
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,=0A=
>  						st->timestamp.gyro);=0A=
>  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
> @@ -521,7 +523,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm4260=
0_state *st)=0A=
>  =0A=
>  	/* handle accelerometer timestamp and FIFO data parsing */=0A=
>  	if (st->fifo.nb.accel > 0) {=0A=
> -		ts =3D iio_priv(st->indio_accel);=0A=
> +		ts =3D &accel_st->ts;=0A=
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,=0A=
>  						st->timestamp.accel);=0A=
>  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
> @@ -535,6 +537,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm4260=
0_state *st)=0A=
>  int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,=0A=
>  				     unsigned int count)=0A=
>  {=0A=
> +	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro);=
=0A=
> +	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel=
);=0A=
>  	struct inv_sensors_timestamp *ts;=0A=
>  	int64_t gyro_ts, accel_ts;=0A=
>  	int ret;=0A=
> @@ -550,7 +554,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42=
600_state *st,=0A=
>  		return 0;=0A=
>  =0A=
>  	if (st->fifo.nb.gyro > 0) {=0A=
> -		ts =3D iio_priv(st->indio_gyro);=0A=
> +		ts =3D &gyro_st->ts;=0A=
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);=0A=
>  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
>  		if (ret)=0A=
> @@ -558,7 +562,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42=
600_state *st,=0A=
>  	}=0A=
>  =0A=
>  	if (st->fifo.nb.accel > 0) {=0A=
> -		ts =3D iio_priv(st->indio_accel);=0A=
> +		ts =3D &accel_st->ts;=0A=
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);=0A=
>  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
>  		if (ret)=0A=
=0A=


Return-Path: <linux-iio+bounces-10678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CC09A1D64
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D17E1C217AD
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8061D434F;
	Thu, 17 Oct 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="JEroanIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADE1D416B;
	Thu, 17 Oct 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154405; cv=fail; b=hVlus9VAg0ZWPNbY0v75YC3I16U3/q4qjjbKsEK4Z30i2gWSlHKMpMtZ+LC5yMBX1BAbECTJRPI42yqJtQRb80AytlODgXS3J6ishmBOqlwrivX3QrbHjF3AChfwQyvJ6AMjfS1s1bqzIjpDvhcu8mYqy9SnwjtDJUpPNemDa7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154405; c=relaxed/simple;
	bh=HlktMCwTyjSCdrSrsx+1JL+wFrXKtGHuU07T7SU0S4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n34U9pCUairP6JnLfL1yr95Na1pFnRLGlRbZeXIw4NzQQ+EwI1Td502HbWQvXlExfLWUG/28nmeA+kUVrHr/NXAF1GTDoFLGxsnQ6I7gPE+i7iWkthbZMLw2Hz7bj26NBVAK1lNscB5vNAZLa6s+qMD8jf/7qjvub8Aq3Gt+PfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=JEroanIZ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GMZ10d021686;
	Thu, 17 Oct 2024 07:45:26 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010001.outbound.protection.outlook.com [40.93.77.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 42aafn0sby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 07:45:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCziuU+lFmvEy6DSjvXzvnwvzmfzv5xBoGuzRLIcKq7YbHUwbXOBXhVmiAKAzXCITa1avmU6H5ZWYfesuFDhjJ3WamP+/mn1DqfVTTZAlHgtxprPdJsPCMkZ/144Ix7O6e3ZYotTMHQZfv1jOICRsNld7fIcgXO6T92RWmG3RsCQnct0Wy0cgQ/XEtAniO4rWNkkbvXyxXWwzlHNERZRQndj5vxq/t0h+kPK6e5B0dAjZan2nsIqA3grt2JAmiITr6xT9+jst9HGeMyb5qx7cQ2HMDVIMHZ8DKKz1yqNIt5WJ0F6+Hge5qrpGAQchR9WY3kOrm67Hx33fdP7Sqri8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYIlEXO1EVEijHjA+YJtIqsQdv0gAXb46l6WhO/erlM=;
 b=WFXPsLeqboolx77WJKfV8AmhBjq5ox6wMfB86IEaI+jgFqBEOw4frAEZ5pFnNsnuJLeanrit5L/0h1oaeVUnvncoMkHBVvqMoDzZD3zKEQX91rKwGaXbLlnaJXhRBYaljXUDiYch1UqAZUo/BtZHKSUOcBKQQZwxRNfE50mGZaCf+kH6AMT+mSwBnxljH1Aw+wlScbt0lx3O7FtJQABPP6o/R4WXqap0L4YPR4qI0iMpkpMt1AWloEA1hcnw9Nw/idHTzkjUcerZPA9AZq991LkFl9MazizxNTNKRNBJxLPrvaLTdJ56WX4pSqzksrmTxNxps48kI56Dl8AJRU7WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYIlEXO1EVEijHjA+YJtIqsQdv0gAXb46l6WhO/erlM=;
 b=JEroanIZHfEb5BLExv3qT6c8GeExx7CEz637qJA7vkmk9756226yCQIlqlxa8AnEmkK0CsgFMwcB4sGqgdU9abouXplmGV4X1V6Rad9jUuVxn2CW1U9SHM/xBVYdDDSvkesLMOS3WteBc8lndBn2EGCAiVBqdzFcx1jma8QlU+bKzzP0+BTz+u5+w3baI/ryvNbe7XaQtdDt+toBfQWrdQD08qvLENHPLx5q/enWx8Meo/ChZQ0PGPFpr0V+c5Lum3FPDLJt06rQyNrC/3/ngavjWnvMCAZLUl0k3Nasgm28Kt9aOluJNUvvPbcre99kBpgmbjU7h+7ss5qjnsuh9A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR5P281MB4054.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 07:45:19 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 07:45:19 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Thread-Topic: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Thread-Index: AQHbHuOlywSS12APZE6zPRw1c+Jjw7KKj7p/
Date: Thu, 17 Oct 2024 07:45:19 +0000
Message-ID:
 <FR3P281MB1757A52E4202A0193543C1DBCE472@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
In-Reply-To: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR5P281MB4054:EE_
x-ms-office365-filtering-correlation-id: 2325f93e-45c7-436e-b192-08dcee7fa62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VxuGlZSBXOal/oul+hIXl/MDZDZb5N8k5o6uVktATMi0l4D/jzq67GpJe+?=
 =?iso-8859-1?Q?huFpG7WJbqLX+totjdJra1E6u8qB7zJbqw3kt5xNEjcUbzMgB6lFkEIJVp?=
 =?iso-8859-1?Q?QaSkjxjSozVOJ06GVDFqXL5+Lw73on8+gJGD2MRqMYjU4vxziqqfx9KXlX?=
 =?iso-8859-1?Q?ux98VHMPekgvi4Db68/hLJxfDYbN9cqZdsZluKYRB8QKQi0GXaE0OUXxBM?=
 =?iso-8859-1?Q?apoluGg27KjyuJb4MGv2YACWS3IXxZf4LCTPPIb1LrDEi1ul/2lT9+FNqk?=
 =?iso-8859-1?Q?jDBSckbMpnlRjow57Mbedx9qtZxSbGJxP02nWzM3WbLMYoD0isNi4WAfrM?=
 =?iso-8859-1?Q?6Cqjsm4tzyM9+8LQmUvBywRbD2wJnjyX7sfnEfX+OgRBgWVchAeojU4sQP?=
 =?iso-8859-1?Q?b8YhKezL71HV6xxyjW1/U2purguCSpegWTOIjuFv9+Ym2hqtAb5FMkLivz?=
 =?iso-8859-1?Q?z8n9xe2vl/7ZYgZkmA37fC1Ngq5txB4+FUbvkIGaDkUhx4XQ1IQwYTTMdV?=
 =?iso-8859-1?Q?Sw1/XlVPPVEOfjTi0WDXPxS4QkHQEXc/2Ojger9CcYooZmeAoK4k2AH7ym?=
 =?iso-8859-1?Q?Y+CekEAmKo4iFlW3mVxfbyGBrsO/qpG6p920SsulOnzCk+A+qIGJluKHH8?=
 =?iso-8859-1?Q?xrs99XQnXZNNMH3mKSNucUTgT2J6ZvMvgZvGgRJkbAzHIRXvyjUmoDc/ki?=
 =?iso-8859-1?Q?yx3Cckhf+oVRiR6ctOsirjmQjBKiM02OSeU3JyZbKxSy+XJNBAccooOZ5u?=
 =?iso-8859-1?Q?nte+qhpJjhcMqs3QOvf1JEA1KQZR7sACAhJauJl8ibRK3Tfmi8Oj2SXM3/?=
 =?iso-8859-1?Q?NWCmbvu591vPKIg+MHi6p71o/frbDYu4/6V5bER2JAjIE62kFojh8fyidT?=
 =?iso-8859-1?Q?a8ZoXvI2cPhWRTdfmD10zvzHPmihfhYQ5AJTMJWN1HMmnNUxkTsUBCZvPW?=
 =?iso-8859-1?Q?Q85O9IZxzrd+r5b3MHSaCDi4zfWKcU+QR5Yc2HMJzK47pVK6MYt1JdDldE?=
 =?iso-8859-1?Q?T/b9lTfVEj/RWcqjKw48fz06mB7uK3y7daEH41xOmn4+L2WfamWwDu852J?=
 =?iso-8859-1?Q?QwCPop9ymGYdkvb31zaBW8ULyR9F2FLuA8f98V2lljE9lOzagX6fhgeXLX?=
 =?iso-8859-1?Q?VTp3aDCWhgPhWtYZoYmYTxNsUU+gS/5p8N71UkDRDrLrDZkO6TDeNyOalk?=
 =?iso-8859-1?Q?zKUDIOh6qSXXzdhJu+i96SS1p2gCnldivWFpWsVfA9pAQgbeKrLX7eNeQe?=
 =?iso-8859-1?Q?FO3i4PEF9MmZqnvV4YKCDa5f29T2FohFgg2jlyt+khMct6V0WGmu+UqpJx?=
 =?iso-8859-1?Q?iVq1gQEpiT2chSci9WBGUGJXPghud27Ts5kuEV3J6xWwj9wdJ86hrjRbRN?=
 =?iso-8859-1?Q?kb6GPHqB787ipTk9VtsPsVB975+rcz4bG9emFqrFICKc+LH6cF8mRSuX2O?=
 =?iso-8859-1?Q?W3R0iWEoNeVGAOzGKebuP5QNUi8MG2l+GBbAXg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DoO+y+7WjTUSL/HzhT/xiwVMYRxwI+46JaunySjfczAIyNTV7nsitZwbm4?=
 =?iso-8859-1?Q?SCpCgfWM124Z/IZgKLYSMhZqlSg2NFGZkAUT4BmlkdFjcs7aGOTRh2z5wf?=
 =?iso-8859-1?Q?SXeBDg8i19hkpDtJP79KSMxmB+/4xMOU3nfKYmgBZDTZzcUCk77KYtyvZr?=
 =?iso-8859-1?Q?65az8E7ApKZUILb5g/Yr/1eWV5BsnHuKKvJJi57aqulOpOGXk2yK9tj41v?=
 =?iso-8859-1?Q?m0BnpMFGAIJZghPoH6fUiE+PcLTxzNgDVvjm7vtJnQt9KIQEZvg/V3A864?=
 =?iso-8859-1?Q?PwrV9kN1xF4ti+s469RpZCeqmw1wPK4Q4kLzIyUB43Sn9OsFMYKsqyPtPi?=
 =?iso-8859-1?Q?FRcWV9hc5uZTXIrGuvMKSpITDBC2eGAh+rMWFzAErWeENoxZwQCrLY+CuU?=
 =?iso-8859-1?Q?atp3qgeZp2mBel3jK6Df+y7A9H+/7JfvPlflME5mM2z8MZF0gw65jtJK7X?=
 =?iso-8859-1?Q?3LkpWGo171gMnfWm6SQPAcz52Xt/aE21j4V/O2pk1AgZxQcZo3dlKRGrSU?=
 =?iso-8859-1?Q?waVuWENNOVSmgXujW3aQijcwENSrc9MWrj1qoXu1ynhnXuWxS/U323ShZW?=
 =?iso-8859-1?Q?TgS51kds7QfT5hjFj8hfeEkLI2sv5VOSiqIMxIPqIzYCdoMQXqKoqEOEvE?=
 =?iso-8859-1?Q?STDK7VBulHIcgwDjKdaBGPitfbtjTlEA6Ikd0WUJhB5NSUziClXya0JDvx?=
 =?iso-8859-1?Q?ufvi8zkRyUzBUNqo5otCnpwJKhvME+KnwsU8Q4s4hUQcQOqcxiCGFG+IM/?=
 =?iso-8859-1?Q?4KQvOiCiCvlCgpmvOoUglE0mv3qlv5+9d7AKGyu4+A97VER5m8Cz3kTTz0?=
 =?iso-8859-1?Q?U179DKGO4QQ4yzKwFlbg6aAw4kRY+R7Zo2Xhp7LR5NxMxDWruZtpQGD1My?=
 =?iso-8859-1?Q?wUS1pt8Rs0YukZIUNHKpWZaSicFikLsV1M/t0Ovhk08yuP5ZWZ+DBaCQ9U?=
 =?iso-8859-1?Q?bIBF8fMfKiViA4czH9ty6FrK/rvTkkoE1K148A+0zkVfllz3ARVPyx8Gld?=
 =?iso-8859-1?Q?O+C1YZsDjgNSOGFkA4LUlmIQhlKOG9bQqpKSSktXuLZPVMELccsPOCDkT8?=
 =?iso-8859-1?Q?rHUsvK0DWJ5Ejd7lwiM6Z+dGgDBmVeWWWoI1hIR2L49EALthLDbGwtDxaV?=
 =?iso-8859-1?Q?T1AQeFb5sPAxh82piH9zr33tE5OBvFCVfb8gLRATF+xFnX7Fnx8j3FlPqP?=
 =?iso-8859-1?Q?bNY4MHIru76NYGEbuZN5ap/OXNMi6w9YdPbbWJNDSvXbxPFyU8gF3kgk7n?=
 =?iso-8859-1?Q?pGf8M9MM5q4lgo/oge2iiqnhF5RNkGV0Sv/VyS65rbrRRl6nEVPPxFkTxL?=
 =?iso-8859-1?Q?FT4Dy+QAGxzHDW1A04r1lEPJjitd80ps7idxcjJXGbdXP7dPqjOSGakdhZ?=
 =?iso-8859-1?Q?3iKrHXisLXLWb47Ooiovs4KLmVoX2e15o2MIY5BfCjtEt4gEtTDWyx0AU4?=
 =?iso-8859-1?Q?lKO4Yi0teDAJbTXeadUh6nraT/wLpyUjuY7rgpzOVU78rip+ksGg9m0/EV?=
 =?iso-8859-1?Q?cMUgKquvIjz29KqTLwMBMBLa7A7fgJXcgI0qmTQ6lQk5vJv7opKYSiIYlX?=
 =?iso-8859-1?Q?LQew5SiKyurdrX3JWomZ0lIHEIzmR1lqzCvvI1EqzC8oJjystTZnnosABx?=
 =?iso-8859-1?Q?5MdpapTVFkyaEZ5CriIqZc4ojULi7JK9jATUnrFWF6LxfdugaUs4/xww?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2325f93e-45c7-436e-b192-08dcee7fa62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:45:19.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbs5pRwfOWoYNKtFLrUWuQeJhU3ftWXM+Kurqdt9c7EMsfb1a2gCEjO8O4T84GrnVRD5eEJKhKz4jFDTTkVDRq5fFlILkgIHnvHbWMY8pNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4054
X-Proofpoint-ORIG-GUID: WaWxhYEs8gIllPXwpu562X0Q7Cd_81uY
X-Proofpoint-GUID: WaWxhYEs8gIllPXwpu562X0Q7Cd_81uY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 malwarescore=0
 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170050

Hello,=0A=
=0A=
thanks for the patch, but for me there are multiple important issues there.=
=0A=
=0A=
You cannot prevent runtime_suspend to turn the chip off since it is its pur=
pose. If you want to keep chip on when pedometer is enabled, you need to us=
e pm_runtime_resume_and_get() when turning pedometer on, and pm_runtime_mar=
k_last_busy()+pm_runtime_put_autosuspend() when turning pedometer off. This=
 way you ensure the chip stays on while pedometer is turned on.=0A=
=0A=
The 2nd important issue, is the ODR frequency for accel with pedometer. Ped=
ometer requires accel to run at 50Hz minimum, otherwise it will not work co=
rrectly. I think we need to enforce this inside the driver, otherwise users=
pace may not understand why pedometer is not working correctly. We could pr=
event pedometer from running if sampling_frequency is below 50Hz, or force =
frequency to 50Hz. And when pedometer is running, preventing ODR switch to =
lower than 50Hz.=0A=
=0A=
Anyway, I'm currently working on adding Wake-on-Motion (WoM) feature to the=
 driver. WoM can also be used with pedometer to reduce power consumption. I=
t would be better to postpone this pedometer work and wait for WoM integrat=
ion before adding pedometer support.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
Sent:=A0Tuesday, October 15, 2024 11:20=0A=
To:=A0jic23@kernel.org <jic23@kernel.org>; Jean-Baptiste Maneyrol <Jean-Bap=
tiste.Maneyrol@tdk.com>; lars@metafoo.de <lars@metafoo.de>=0A=
Cc:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; linux-ii=
o@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject:=A0[PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality=
=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
Enables pedometer functionality in the ICM42605 IMU sensor.=0A=
=0A=
The pedometer feature allows for step counting, which is accessible through=
=0A=
a new sysfs entry. Interrupts are triggered when a step event occurs, enabl=
ing=0A=
step event detection.=0A=
=0A=
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  16 ++=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 165 ++++++++++++++++++=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  36 +++-=0A=
 3 files changed, 211 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h=0A=
index 3a07e43e4cf1..c3471b73152e 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
@@ -122,6 +122,7 @@ struct inv_icm42600_sensor_conf {=0A=
 	int filter;=0A=
 };=0A=
 #define INV_ICM42600_SENSOR_CONF_INIT		{-1, -1, -1, -1}=0A=
+#define INV_ICM42600_SENSOR_CONF_APEX		{ 2, 0, 9, 6}=0A=
 =0A=
 struct inv_icm42600_conf {=0A=
 	struct inv_icm42600_sensor_conf gyro;=0A=
@@ -141,6 +142,8 @@ struct inv_icm42600_suspended {=0A=
  *  @chip:		chip identifier.=0A=
  *  @name:		chip name.=0A=
  *  @map:		regmap pointer.=0A=
+ *  @pedometer_enable	status of pedometer function=0A=
+ *  @pedometer_value	status of steps event occurnce=0A=
  *  @vdd_supply:	VDD voltage regulator for the chip.=0A=
  *  @vddio_supply:	I/O voltage regulator for the chip.=0A=
  *  @orientation:	sensor chip orientation relative to main hardware.=0A=
@@ -157,6 +160,8 @@ struct inv_icm42600_state {=0A=
 	enum inv_icm42600_chip chip;=0A=
 	const char *name;=0A=
 	struct regmap *map;=0A=
+	bool pedometer_enable;=0A=
+	bool pedometer_value;=0A=
 	struct regulator *vdd_supply;=0A=
 	struct regulator *vddio_supply;=0A=
 	struct iio_mount_matrix orientation;=0A=
@@ -301,6 +306,15 @@ struct inv_icm42600_sensor_state {=0A=
 #define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)	\=0A=
 		FIELD_PREP(GENMASK(3, 0), (_f))=0A=
 =0A=
+/* Pedometer functionality */=0A=
+#define INV_ICM42600_REG_APEX_CONFIG0                  0x0056=0A=
+#define INV_ICM42600_DMP_ODR_50Hz                      BIT(1)=0A=
+#define INV_ICM42600_PED_ENABLE                        BIT(5)=0A=
+#define INV_ICM42600_REG_INT_STATUS3                   0x0038=0A=
+#define INV_ICM42600_STEP_DET_INT                      BIT(5)=0A=
+#define INV_ICM42600_REG_APEX_DATA                     0x0031 // 2 Byte li=
ttle-endian=0A=
+=0A=
+=0A=
 #define INV_ICM42600_REG_TMST_CONFIG			0x0054=0A=
 #define INV_ICM42600_TMST_CONFIG_MASK			GENMASK(4, 0)=0A=
 #define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN	BIT(4)=0A=
@@ -373,6 +387,8 @@ struct inv_icm42600_sensor_state {=0A=
 #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)=0A=
 =0A=
 /* User bank 4 (MSB 0x40) */=0A=
+#define INV_ICM42600_REG_INT_SOURCE6                    0x404D=0A=
+#define INV_ICM42600_STEP_DET_INT1_EN              	BIT(5)=0A=
 #define INV_ICM42600_REG_INT_SOURCE8			0x404F=0A=
 #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)=0A=
 #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_accel.c=0A=
index 56ac19814250..90fe4c9e15ab 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
@@ -160,6 +160,13 @@ static const struct iio_chan_spec_ext_info inv_icm4260=
0_accel_ext_infos[] =3D {=0A=
 	{},=0A=
 };=0A=
 =0A=
+static const struct iio_event_spec icm42600_step_event =3D {=0A=
+	.type =3D IIO_EV_TYPE_CHANGE,=0A=
+	.dir =3D IIO_EV_DIR_NONE,=0A=
+	.mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |=0A=
+	                       BIT(IIO_EV_INFO_VALUE),=0A=
+};=0A=
+=0A=
 static const struct iio_chan_spec inv_icm42600_accel_channels[] =3D {=0A=
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,=0A=
 				inv_icm42600_accel_ext_infos),=0A=
@@ -169,6 +176,14 @@ static const struct iio_chan_spec inv_icm42600_accel_c=
hannels[] =3D {=0A=
 				inv_icm42600_accel_ext_infos),=0A=
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),=0A=
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),=0A=
+	{=0A=
+	        .type =3D IIO_STEPS,=0A=
+	        .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),=0A=
+	        .scan_index =3D -1,=0A=
+	        .event_spec =3D &icm42600_step_event,=0A=
+	        .num_event_specs =3D 1,=0A=
+	},=0A=
+=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -668,6 +683,31 @@ static int inv_icm42600_accel_write_offset(struct inv_=
icm42600_state *st,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int inv_icm42600_steps_read_raw(struct iio_dev *indio_dev,=0A=
+                               struct iio_chan_spec const *chan,=0A=
+                               int *val, int *val2, long mask)=0A=
+{=0A=
+       struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev)=
;=0A=
+       __le16 steps;=0A=
+       int ret;=0A=
+=0A=
+       if (mask =3D=3D IIO_CHAN_INFO_PROCESSED) {=0A=
+               ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
+               if (ret)=0A=
+                       return ret;=0A=
+               ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_APEX_DAT=
A, &steps, sizeof(steps));=0A=
+               if (ret)=0A=
+                       return ret;=0A=
+               iio_device_release_direct_mode(indio_dev);=0A=
+               if (ret)=0A=
+                       return ret;=0A=
+               *val =3D steps;=0A=
+               return IIO_VAL_INT;=0A=
+       }=0A=
+=0A=
+       return -EINVAL;=0A=
+}=0A=
+=0A=
 static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,=0A=
 				       struct iio_chan_spec const *chan,=0A=
 				       int *val, int *val2, long mask)=0A=
@@ -681,6 +721,8 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *=
indio_dev,=0A=
 		break;=0A=
 	case IIO_TEMP:=0A=
 		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2, mask);=0A=
+	case IIO_STEPS:=0A=
+		return inv_icm42600_steps_read_raw(indio_dev, chan, val, val2, mask);=0A=
 	default:=0A=
 		return -EINVAL;=0A=
 	}=0A=
@@ -824,6 +866,126 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio=
_dev *indio_dev,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+/*****************Pedometer Functionality**************/=0A=
+static int inv_icm42600_step_en(struct inv_icm42600_state *st, int state)=
=0A=
+{=0A=
+	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_APEX;=
=0A=
+	int ret, value;=0A=
+=0A=
+	if (state) {=0A=
+=0A=
+		ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0,=0A=
+		                        INV_ICM42600_DMP_ODR_50Hz);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,=0A=
+		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET);=
=0A=
+		if (ret)=0A=
+			return ret;=0A=
+		msleep(1);=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,=0A=
+		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6,=0A=
+		                        INV_ICM42600_STEP_DET_INT1_EN);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		value =3D INV_ICM42600_DMP_ODR_50Hz | INV_ICM42600_PED_ENABLE;=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, value);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		st->pedometer_enable =3D true;=0A=
+=0A=
+	} else {=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, 0);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		ret =3D regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6, 0);=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
+		st->pedometer_enable =3D false;=0A=
+	 }=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_write_event_config(struct iio_dev *indio_dev,=0A=
+                                     const struct iio_chan_spec *chan,=0A=
+                                     enum iio_event_type type,=0A=
+                                     enum iio_event_direction dir, int sta=
te)=0A=
+{=0A=
+	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
+	int ret;=0A=
+=0A=
+	if(chan->type !=3D IIO_STEPS)=0A=
+	        return -EINVAL;=0A=
+=0A=
+	mutex_lock(&st->lock);=0A=
+=0A=
+	ret =3D inv_icm42600_step_en(st, state);=0A=
+=0A=
+	mutex_unlock(&st->lock);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_read_event_config(struct iio_dev *indio_dev,=0A=
+                                    const struct iio_chan_spec *chan,=0A=
+                                    enum iio_event_type type,=0A=
+                                    enum iio_event_direction dir)=0A=
+{=0A=
+	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
+	int value;=0A=
+=0A=
+	if (chan->type !=3D IIO_STEPS)=0A=
+	        return -EINVAL;=0A=
+=0A=
+	regmap_read(st->map, INV_ICM42600_REG_APEX_CONFIG0, &value);=0A=
+=0A=
+	if (value & INV_ICM42600_PED_ENABLE)=0A=
+	        return 1;=0A=
+	else=0A=
+	        return 0;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_read_event_value(struct iio_dev *indio_dev,=0A=
+                                   const struct iio_chan_spec *chan,=0A=
+                                   enum iio_event_type type,=0A=
+                                   enum iio_event_direction dir,=0A=
+                                   enum iio_event_info info,=0A=
+                                   int *val, int *val2)=0A=
+{=0A=
+	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
+=0A=
+	mutex_lock(&st->lock);=0A=
+=0A=
+	if (type =3D=3D IIO_EV_TYPE_CHANGE) {=0A=
+		if (st->pedometer_value =3D=3D true) {=0A=
+			*val =3D 1;=0A=
+		        st->pedometer_value =3D false;=0A=
+		} else {=0A=
+		        *val =3D 0;=0A=
+		}=0A=
+		mutex_unlock(&st->lock);=0A=
+		return IIO_VAL_INT;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&st->lock);=0A=
+	return -EINVAL;=0A=
+}=0A=
+=0A=
 static const struct iio_info inv_icm42600_accel_info =3D {=0A=
 	.read_raw =3D inv_icm42600_accel_read_raw,=0A=
 	.read_avail =3D inv_icm42600_accel_read_avail,=0A=
@@ -833,6 +995,9 @@ static const struct iio_info inv_icm42600_accel_info =
=3D {=0A=
 	.update_scan_mode =3D inv_icm42600_accel_update_scan_mode,=0A=
 	.hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_set_watermark,=0A=
 	.hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo_flush,=0A=
+	.write_event_config =3D inv_icm42600_write_event_config,=0A=
+	.read_event_config  =3D inv_icm42600_read_event_config,=0A=
+	.read_event_value   =3D inv_icm42600_read_event_value,=0A=
 };=0A=
 =0A=
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index c3924cc6190e..4d78cb5ca396 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -15,7 +15,8 @@=0A=
 #include <linux/pm_runtime.h>=0A=
 #include <linux/property.h>=0A=
 #include <linux/regmap.h>=0A=
-=0A=
+#include <linux/iio/events.h>=0A=
+#include <linux/of_irq.h>=0A=
 #include <linux/iio/iio.h>=0A=
 =0A=
 #include "inv_icm42600.h"=0A=
@@ -533,6 +534,19 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, v=
oid *_data)=0A=
 =0A=
 	mutex_lock(&st->lock);=0A=
 =0A=
+	ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STATUS3, &status);=0A=
+	if (ret)=0A=
+	        goto out_unlock;=0A=
+=0A=
+	if (status & INV_ICM42600_STEP_DET_INT) {=0A=
+	        iio_push_event(st->indio_accel, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,=
=0A=
+	                                                     IIO_NO_MOD,=0A=
+	                                                     IIO_EV_TYPE_CHANGE,=
=0A=
+	                                                     IIO_EV_DIR_NONE),=0A=
+	                                                        st->timestamp.acc=
el);=0A=
+	        st->pedometer_value =3D true;=0A=
+	}=0A=
+=0A=
 	ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);=0A=
 	if (ret)=0A=
 		goto out_unlock;=0A=
@@ -860,12 +876,20 @@ static int inv_icm42600_runtime_suspend(struct device=
 *dev)=0A=
 	mutex_lock(&st->lock);=0A=
 =0A=
 	/* disable all sensors */=0A=
-	ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
-					 INV_ICM42600_SENSOR_MODE_OFF, false,=0A=
-					 NULL);=0A=
-	if (ret)=0A=
-		goto error_unlock;=0A=
+	if (st->pedometer_enable) {=0A=
+		ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
+						 INV_ICM42600_SENSOR_MODE_LOW_POWER,=0A=
+						false, NULL);=0A=
+		if (ret)=0A=
+			goto error_unlock;=0A=
+	} else {=0A=
 =0A=
+		ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
+						 INV_ICM42600_SENSOR_MODE_OFF,=0A=
+						 false, NULL);=0A=
+		if (ret)=0A=
+			goto error_unlock;=0A=
+	}=0A=
 	regulator_disable(st->vddio_supply);=0A=
 =0A=
 error_unlock:=0A=
-- =0A=
2.43.0=0A=
=0A=


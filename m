Return-Path: <linux-iio+bounces-27154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A15BCC9644
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8368330BC852
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC812D877B;
	Wed, 17 Dec 2025 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="MDYRxFfB"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021115.outbound.protection.outlook.com [40.107.130.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8722D8DA8;
	Wed, 17 Dec 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998921; cv=fail; b=f2bwgdrhCKfFRoiJ5RxpguaVbJLYbCSV9QMnNFCI2B6vLri0gw3V74y5v0w1bw93gISU6X2zI/2MbJ7VjJBqiq6gEjMQx4nj7nplSe2Gy1wP4Oj6uZnxJKGNgN/UO3vwgwN5Pwz3LJPR1rMfo8xPMtdcBZtsrr5V4VZ/1GOBHlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998921; c=relaxed/simple;
	bh=jozFUc8DN7SOyEQkxIHNz6Oqbbgf9XWXznNzKOPp8Fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V93HcL4AmK7cB5McDBGJbeCqJ68DLDpcgLLdV3Bu9Jb1kb9+cWAv6eZtNhMv6nJOpdYdfLpxeOe+XOwOaOCoWymbeLbM9O3YUruBtH/pZkhiNbTE7NASD0WeQ6Klh7y8NB5HqlhIbay4VvoeY8FnV/s/93a8GDEu9huHQIkyBVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=MDYRxFfB; arc=fail smtp.client-ip=40.107.130.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onV5Qjta8rCDNzrmBEB2E3Jc6lDUDy8bluiAOrkAg9PqjBDW7lkuquvNPYJ5Jz0tUToiKNvE2OJGwmTbTCzw6c67UxFBOxBRA9Rdg0muSsVj9Pk6ThvlG/fLyeB+As0oaCJfEcroI0DoxSEsfd4fofP7uQRhz50xlP2r+HUpNosrp42yAyVhHEkWPsXIc0M9Dq3pHxnyh39ZqFinxrZdRsKU4OKijSw7ibd/5kKemvOPSX4y3gJfXCaWsrUScCSHBpgvd1LgxRi9j5gPKGNAtDfMgktnHsPJn07H+T4KWk5p1xlW4JIQ8cEdg9L4k0+geWciMAIFAqVw5Jfwg7n4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jozFUc8DN7SOyEQkxIHNz6Oqbbgf9XWXznNzKOPp8Fg=;
 b=u6zD264WjtINGw6GKu2f+P6/v33OQGqlGMWkwboD2IcE3u7xLkoMy7e/qHTrKnOEu0YRl6UY9Sp+dcZ7fNRVeY49vDPPVFRHHK3RpEldLX/jmy6Y5p3jiypdPefzqOAau5M3p3q4px0bEC8nUqfkRB14639DAOgemSOPzC2dwzTZI6Lf+RNVIX8HrG2YKvDgtJTtocaDUUx1SM5HsA+VoLbwsli3x2z5nDv0jtGdJyYySKwAUtxpDv83Q0QW/2yUq/r3xZKYoqnfovdSdpjxp8qpnpKso3GbBPGhch2x84hW4fasBgT9XerCmQVopRIFehL1cp+Zq2xirgZJ/OL0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jozFUc8DN7SOyEQkxIHNz6Oqbbgf9XWXznNzKOPp8Fg=;
 b=MDYRxFfBJgrySxxiRPmyHp51B6ZHqb/aTgkWgfOoY2dgo4fGtUf3Ccj2lnJJTyLRff14ft/kRMmK6rOwkVxEME1xBD8mxizRQOpwBtT8XTieQ3pME5WFTfgMMd5QJxhWK8yahGkVzxozr98nz4n2MuHgja5HXUEojf2hNyN/eoOP1Wqbdz6ymeUR1mGZTxaSU9XQtudBoikTmGgZQM+V18Dogr79WZK8hGKFju973bSk2MxgUJrU9T6dLJ8fsQXHqIKZ5YxDOVt3guKmegZR5vYlj7ofu05ZvdZWvkBIVXdtjHgW25BWZz6XnD2on7DEJ/olQGlBS+F2vj6f8Fi4kA==
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA3PR06MB9970.eurprd06.prod.outlook.com (2603:10a6:102:4b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 10:39:37 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:39:37 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
To: =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Topic: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Index: AQHcboDg2jiPMh+SKEeDKHne+sMY7rUkOemAgABObACAAQkFAIAAE31M
Date: Wed, 17 Dec 2025 10:39:37 +0000
Message-ID:
 <AMBPR06MB1036581C0CC704B85E159B7EDFDABA@AMBPR06MB10365.eurprd06.prod.outlook.com>
References:
 <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
	 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
 <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
In-Reply-To: <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2025-12-17T10:39:37.207Z;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Name=No
 Label;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_ContentBits=1;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR06MB10365:EE_|PA3PR06MB9970:EE_
x-ms-office365-filtering-correlation-id: 0c1f1921-4ddf-4502-ae9c-08de3d58939c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SvT/Hv6pwVN/uKu62yLLzOyeppt3TQa9pqO2ehVaNRZFs5eWYre3lkva7D?=
 =?iso-8859-1?Q?hQbs9f1MaYpixHs2pit/A3FZsvlUgjtJFLahvBj5dbxCl97nARQNbgLHO0?=
 =?iso-8859-1?Q?IZel/H9bxoVfxPr5e5X48MW7A28DhgmnRzKPmXGepLYj3h7UpIh8r3QEE2?=
 =?iso-8859-1?Q?lBn2+rhwGtRhwuzYmw1kjiCNY84c72s7J9ldVaTkYQ0QkbDowRv8AlbjiW?=
 =?iso-8859-1?Q?/Sj2F7cneZeHbGdHgG4CBA9z9TdQ/d3lOsDpdag1qNCN6j1Xa4H+be5XjL?=
 =?iso-8859-1?Q?94ERE5wTx/DYAwZR2kAXQciXmTfCqlLZ3yhej82SIELiOhvNuYwuCpukiF?=
 =?iso-8859-1?Q?i1L6Qh5gxBwcp6KSDg1OCPiJylutJfkyAR94IzeWmfSOP0uG/YmozaOl7Y?=
 =?iso-8859-1?Q?wAjE5yK2R4AZ80H/1SPnRz56EoKgpIc+O+3tBU50OX/+uI6tC48XUTCizt?=
 =?iso-8859-1?Q?Gu1SenxWIQy5ke+o5D307/El2VAuUiIKPycOvioLL307Ow5ojU/dQ0k2p6?=
 =?iso-8859-1?Q?eYj+gEGGI22MQ3Pp2sQQAvnXNRFru2eDOSE714980N939lqH9qC2crqDtT?=
 =?iso-8859-1?Q?AKpwWAccxbotlA+SHtnVAjpi92yTU7qB4ADSxoPfHvK6npGdYP52xOREJh?=
 =?iso-8859-1?Q?xHAKpV+CxVhu+2AIqKPEykCupFGGjBi1POnyQQkHB5zJcRTYLynAkab1DS?=
 =?iso-8859-1?Q?LzFPOBkp/osipWi5AqX62T+MutphX55qAlFwbF8M2K+hax7ZLg+kCKUgIz?=
 =?iso-8859-1?Q?jwK/V/Z4O6x7q79hcBEQh6DK0oV8xJrr5qXHAylU/s05NMMBe+9mXtTUgk?=
 =?iso-8859-1?Q?HYZT5rfxvFnyc2j3IXlKZUASFEvhkSMVTnFbQqZIWA7rrQM7LHua6OtpWG?=
 =?iso-8859-1?Q?aqKMctz9Ts5RW9FHy1tjydhs5yzvIEzj19DHgHlAr0cDw/jmXZb3TG6M0f?=
 =?iso-8859-1?Q?tzBCitZtLczWnqPu8z3O1LTLoxl4gy78KClpDrOATO+bnMhj9FB4LpzqPY?=
 =?iso-8859-1?Q?AHJowZKzl+KDUMNhqv+41choF4owogrISb/APIJIB3SN3PaPQTxk1x6g27?=
 =?iso-8859-1?Q?XxrrBiL28RaMBnsyeJeLKtXfGtK3gjU7GJc+CUOWMoWCnuKjQv8GNng1fh?=
 =?iso-8859-1?Q?BM2Savmc1rfTM0mj9Fmi9FT/uKJb+UbTi7fgPIK9kkB+CHXgm+p5WQ82vZ?=
 =?iso-8859-1?Q?HjHLH2CY73QVx7QNstUx22qxqIAGnT557vL29SNHWkjc6SxLPMPv3EeKxF?=
 =?iso-8859-1?Q?m8PBg2mQiGMbGRkhJlThZ4RecC3hV3cUu0EoGsA9vzqGvztim9BmQwSb/4?=
 =?iso-8859-1?Q?YAVg/KYvdpaZiI5VJmj2OgvSkdZJ4qTxSlOYwih3OVcElRxU80/a77+ubN?=
 =?iso-8859-1?Q?zCtOulxhMq/sub5SluAe0ZvA2GoKUwhHjGq2oGJGBABG38yQ4RnmKHiihm?=
 =?iso-8859-1?Q?HCRrhBKXYnnh+3qjVzXV5tlO9+PoeA6bySjiuVR70XzmWw/bp573mlakKD?=
 =?iso-8859-1?Q?dbq68l0OYX+xavEk2rxqZGKZgreXxk2ZwQovzawbBDzouYuTUDnmJP1gyv?=
 =?iso-8859-1?Q?E/WaAPBfUnnee/tIEyRcyg/HSyuk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cjmQXJPicwiTzX/j2rrutPxOUkHpI+4gp52hN51GyaEQLruqBJyeiWtxyF?=
 =?iso-8859-1?Q?9syTWXWyoI5PNblDIj2A8a2qMXCo51SGfJqzCDfZ5WvVTO9OHTuCTP07Ih?=
 =?iso-8859-1?Q?BdvSoCE53PPHTNFXGl0gYov+J4dxlpIvUGWutWlzDXdWX4PURnXOnI9yNR?=
 =?iso-8859-1?Q?3UFRaQp7lzlS0KaNVmMRIpN0TmPucG1sVWNvvt+sCi2NZ6FsCkESktuOSD?=
 =?iso-8859-1?Q?Z9gAbCLbt3s1SSnZAIqCrB0/dGyW4Kyjril0d7Ay/TRMWeNttg1Yy0Muk/?=
 =?iso-8859-1?Q?ffqOB7CK8HH5GfzV+Q5pwM8L3vRct+zONln+M/lTZi64ctM+mFDwdTnLOV?=
 =?iso-8859-1?Q?kPuvYsx1VYvj/7Ad0DHFQD0dhhv1EVaMXzr8E7lMP9MJplaf1VdF7RXSwI?=
 =?iso-8859-1?Q?AyGKHDbUAPl+qClLGdYwyOI6pyrZLFcqZAOe5T0PrnG4uWPndLE6p9sdxH?=
 =?iso-8859-1?Q?oI9Xm8oQo7DFv3MMuTHkfhvabPEmwHrJzMxfRoHIS3JS7f0y5W+IaGvfpz?=
 =?iso-8859-1?Q?UbJ+d5pc9o4c7H3J/YrG/bgIT5L/gIW33O6C1j1woLU4od1waeZTQyWID2?=
 =?iso-8859-1?Q?IrtO8PC2qpiYBcUEJaGnXFegYkGMLNeVGkIrKLCscRCLgVdx1i+RI6+/Bp?=
 =?iso-8859-1?Q?3FEiUKBBJMEuYDSVx/WqxZMM2SKKs1o3AkHv/U+u8w9Cf0P5zTWopThYUb?=
 =?iso-8859-1?Q?9ySL1hljaWIKWomEFSwEzbSynIKL10w/5SjF73K0au4XAqOxbeKKPkzGkq?=
 =?iso-8859-1?Q?GNr1O8qPJTQTBDXNQsi/X95Ic2J7ZIeF3n18r12J9NmNxPNkbLS+Q9tNpL?=
 =?iso-8859-1?Q?1+x67Nc0vX6PoFmwcqirQME9hVOr5fDnRpHwG86H3nWh7aH6mPAo8SXDF0?=
 =?iso-8859-1?Q?sXbE5/0tS5jBZc7YTPUIHdfzB5lJv/D/5G2CJsfcYd0V5yFaOwajXlJJIo?=
 =?iso-8859-1?Q?C3MWYZvzSdYaepzS5d+NQcE3rcFmvd8MiPSV2cIPMQxpZY75UGc3I7/XZP?=
 =?iso-8859-1?Q?ce2u2N7D9IdxW8BSJWPupknTf2qW5i08LqlhxcXjZyGWEnbsQ0Knj1eohl?=
 =?iso-8859-1?Q?mPBzilHxhiMf87r2pisCwejB+CrME0p10Ngpx19sskjwZRlsiD/kZq1tU4?=
 =?iso-8859-1?Q?g1RN+4meNnC8L3eCQhwRv3L90UUcLNLmefyMuwiK+vdzML/2ye0UJavWeE?=
 =?iso-8859-1?Q?uUUQRango7DIm6EcqBaYgZ2fTVtml67eNCPcdpTogEgo8QSdFL3GgbhBRV?=
 =?iso-8859-1?Q?JGg7zw7BecVUos/hgakF0lUo12vHEPdtl9vLXKjls4rmXQ5jmPDMb5p7sn?=
 =?iso-8859-1?Q?75glXoapJfLoyDvrufGnXUmNIq4fhFtYl/o4MGyO33WTaatNxz+my5a/dQ?=
 =?iso-8859-1?Q?3zkSW4TNXwOLjqFHBbrVUeJYS5OeT3i9F+LzU501sGHxRmnu487RLbvoWk?=
 =?iso-8859-1?Q?/giJdWXYyrrL+3Zwebi+ITmCBoXEdRrDAvCB5hRAC9le8aI8c9n9go0zbF?=
 =?iso-8859-1?Q?LNjUvVkULN5h2kLG8QGAVKBWfPbzdXLcwWtZXiEA+YojsEH1ScLcpbO/Nv?=
 =?iso-8859-1?Q?GvLg+WoqKLDJ9wQSLAfgqptSy3QtNTyVqUnpgzF1eO8bEuFtB2VRRIxMXa?=
 =?iso-8859-1?Q?M0C8esUAFonzT7GXJGDtmUfZGPcAcdbAFS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f1921-4ddf-4502-ae9c-08de3d58939c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 10:39:37.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AArkhywyiqzotvZr+shAt3Bp4OnbENfC1pZkKKHWHXw7pmTjwb+uc+qu8HDUsYZXlUZ0gSULwfvGsTTYSYlmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR06MB9970

Hi,=0A=
=0A=
On 17/12/2025 11:26, Nuno S=E1 wrote:=0A=
> On Tue, 2025-12-16 at 15:39 +0000, Tomas Melin wrote:=0A=
>> Hi,=0A=
>>=0A=
>> On 16/12/2025 14:56, Nuno S=E1 wrote:=0A=
>>> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:=0A=
>>>> Not all users can or want to use the device with an iio-backend.=0A=
>>>> For these users, let the driver work in standalone mode, not coupled=
=0A=
>>>> to the backend or the services it provides.=0A=
>>>>=0A=
>>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=0A=
>>>> ---=0A=
>>>=0A=
>>> Which users? The only usecases (for all the supported devices) we have =
require=0A=
>>> the FPGA backend. So do you have a specific usecase for a specific devi=
ce? If so, I would=0A=
>>> prefer an explicit boolean in the chip_info struture for the device(s) =
we know this=0A=
>>> can happen (unless you have a usecase for all :)).=0A=
>>=0A=
>> This is generically for all the devices supported by the ad9467, not=0A=
>> only a specific device. So it's about how this is used as part of the=0A=
>> design.=0A=
>>=0A=
>> This is aimed at users that do not use the ADI HDL reference backend=0A=
>> with these devices, but instead have custom backends suited for their=0A=
>> own needs.=0A=
> =0A=
> Hmm, ideally I would then like to see the backend driver upstreamed...=0A=
=0A=
First of all, as I responded in another thread, there is certainly real=0A=
use case behind this, I would not be suggesting it otherwise.=0A=
=0A=
Driver for custom backend would not be of any interest for mainline=0A=
kernel as the IP would not be publicly available. So nobody could really=0A=
use such a driver, nor would it be accepted. The default ADI backend is=0A=
 a different story, as it is available and documented.=0A=
=0A=
=0A=
> =0A=
>> In that case, we need to be able to skip the backend registration and=0A=
>> register device as a standalone iio device.=0A=
>>=0A=
>> Hopefully this made the use case clearer?=0A=
>>=0A=
> =0A=
> I mean, I don't love this and I'm not really sure I'm ok with it. These a=
re fairly=0A=
> high speed devices which often do require an FPGA IP to handle the data f=
low. Now=0A=
> we can ignore the backend device (which is an essential piece) being it=
=0A=
> expected or not.=0A=
> =0A=
> Or maybe we can just do something like regulators and get a dummy backend=
 or just add=0A=
> some fixed kind of backend. Bottom line is, it still seems the backend de=
vice is a core=0A=
> piece in your design and we're just hacking around the driver in way that=
 conceptually=0A=
> doesn't make sense to me.=0A=
=0A=
I considered the idea of dummy backend, but in the end it doesn't make much=
 sense to me.=0A=
These ADCs can work perfectly fine with a minimalistic custom backend that =
does exactly=0A=
what the design needs, without the need for basically any configuration.=0A=
So the ADCs rely on some sort of backend, ofcourse, but they are in the end=
 standalone=0A=
devices that can be integrated in many ways, the adi backend being only one=
 such option.=0A=
=0A=
Another problem with a dummy backend is that for example calibration cannot=
 really=0A=
work. It expects certain features from the backend to be available, etc. Si=
milarly would=0A=
a custom backend connected need to implemented exactly same test features a=
s the=0A=
backend now assumes.=0A=
=0A=
> Other question that comes to mind (I guess I was not that clear)... Do yo=
u have a real=0A=
> usecase with your own custom backend IP or is this just theoretical?=0A=
=0A=
This dependency on the adi hdl has been causing me problems over the years =
for a=0A=
number of adi devices, and the iio-backend has been a step in the right dir=
ection.=0A=
I hope we can take this further in direction that allows use cases that=0A=
were not expected from the beginning but are still valid.=0A=
=0A=
Thanks,=0A=
Tomas=0A=
=0A=
> =0A=
> - Nuno S=E1=


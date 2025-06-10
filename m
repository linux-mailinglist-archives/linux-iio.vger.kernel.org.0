Return-Path: <linux-iio+bounces-20361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4266AD3B3C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0731883CC9
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05341A8F97;
	Tue, 10 Jun 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="QtnmhBbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB419B3CB;
	Tue, 10 Jun 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566089; cv=fail; b=bqUr6lD9TDzwLfRdpYeONTYL/eK5zSMPeugSa5qSUOaeW/akshoa1nuzktCsu2bUfhwEgYP8ng613/2mAhXEIQyQjoCLcEumLKAA+ncJXIFglMoCbrObx/rMhZPa5Z4izJzyduJoZQQm4ZztUcPOyCF7t2gD4WZBqy+QKW7w62o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566089; c=relaxed/simple;
	bh=+pwh06/ja72tMk3toLuxkwH+g/f5zknS2giuNopdMIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iSd9N8iwCEe5qr35lFZLEUebOYWI+R6jc1UAtM5KfpLCGvywlggfSVORvGVrUQ55q48dazTLWwcW4/yajpl+n3+n82LfjJpWJreAazeGnBeeqRM3pgg4ZoLwHIpAJItdmmP9jB3HC3Qgs+f7Fs2rEg/Si7MEj1MLwbKOXQmsQ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=QtnmhBbG; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559MQLGN023864;
	Tue, 10 Jun 2025 14:13:49 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012040.outbound.protection.outlook.com [40.107.149.40])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474esnj54p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:13:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z33CLq44OH7JDRx9qCJRDJWD+mkpAUUeWNiLBuRbbYGbsAVS/ciyThpd9MdcJpSYzbXUVH3636j0OJbWhjiLEMzxQzDe6LoNmlJhxllcz0LF42A8IcQ2v1Sd+E9JwyljQ1EsH+Zma3syT1glYhMDfnndWPqqnd8CoWZeDKRm5LHxkfx63eyXhoNiiPqY+KPJ1Ngl50evIe4Qfn/x9Snic9SZV/rGKMwyIQL9LhlubSJoyDcoaCp8Oh/kY8rFznlQbdr4+NQFDwt2O3JmBGapsJ6Z7JgHeNaj/Y83VM8RmDuokdEnzuHbVXk0C3RhWfbp9vnOIFx+k4zCW9Uch0RsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qaw6vDn0xAFY2MXJT4V1iD2DMKoOsvAwmb9up+5TJag=;
 b=j6oHWJ6sOJuzgE6vyIO6jXt13cYhqoZ2rj10hyCovxO49EVJz+vF/9Hukrowd+iTEcjJrjb8GEuSwyO4VuNvhsdTYhErUJzrYF4CT5Rx2uSfcRhtbE8InUis6s/fDm6XX9+8QvF+ZvpqRe+SfEFHo4nXohALRR5MQbMPXdPjAeEOmFibXvwjNs6Xz34e6p3wVI+okHryHL+wIvGulHBaJSFziRJWbEsfo6BFJHfuydNiHp9DO3o0ZF8Qwgt22XbF+TdlF92rY3tlaYdAXjf2JeN7lKGZf41OChyr0IAAS4pRwN/x1c+BUdQ6Pz7KecZDz0sSH1NPrUyC0pSR0XoXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qaw6vDn0xAFY2MXJT4V1iD2DMKoOsvAwmb9up+5TJag=;
 b=QtnmhBbGdiLM5lPzuYsHOQOtNUCJ7XGGUScSyioWFaXvlFdQk+DGnur8mSD1pNl53PlaeSyTeq93B1mKkwu1XHZoZ5RTMmjzgspzM0vV2R5MM7KLeEzmgXgN7lummZnnjp8cYCPgbXlG19gWAY2RdxfhN1VjDCwiKNATR6nSwxnSVsZKWCuhAgOx5/gjQ+pdqtPHx+f+Wbk+TZc7KCOEmFQHfqT9b2f4l8LZQVdCreoTb9ZJj8hplez8VFI3dpBCRC8FWbWbt5n6q3q/Db/35ewbGGqYGgv0kyzQvB27vpk5izF57RhNqUJRUJEoz8YZmrKEbvNcFFTO44d2FmDhcA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE0P281MB0226.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 14:13:39 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:13:38 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHbsH2o0EUo+C/wbEygXsbiYpM8dLOrIWwAgFGdM2c=
Date: Tue, 10 Jun 2025 14:13:38 +0000
Message-ID:
 <FR3P281MB17573A98ECB6B89306DB8DCBCE6AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
 <20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
 <aAPDovuee7hoY1PS@smile.fi.intel.com>
In-Reply-To: <aAPDovuee7hoY1PS@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE0P281MB0226:EE_
x-ms-office365-filtering-correlation-id: b3d5182b-59c6-476f-8d61-08dda828feff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rtkRV5Ujw7qYsNfdFH432Or41Ar6zVsHCOtkMgzcAkEFBNLCWBBCXZqxMK?=
 =?iso-8859-1?Q?pohBqfSy0ZqULs+2isyb6+lR6NtALjMnTVCteIwU5Yv2zBVxNqMyF6lFtK?=
 =?iso-8859-1?Q?wnW1ttQYNWbSgtQrO1MqG5Jd0tl99jlVi+Lh2+gAgF8lSmpeIasTCGUo0R?=
 =?iso-8859-1?Q?skbm3S0omY2fRVnj8IaGwh80WCzul7BPRbJJPQBtoAXyqrHiOgfp6G15Os?=
 =?iso-8859-1?Q?kzWU5EUJhcMjByvpMRKTdCURgYLxw2GGNoy60HDL0nHh6ERo1SUCrASYHk?=
 =?iso-8859-1?Q?gvlI8y3uz0MoYtUGy3uYAofbbwf+YMNjOSDRyR5SmN1vwOFglDstFz4edb?=
 =?iso-8859-1?Q?jZ3ypecQ+cvZV1vvQDR91YJ77NYbvvw2fZIVu+TlMm47zDwb3l2w++Yztm?=
 =?iso-8859-1?Q?2+ZzrvHAJx2HAtxYvwJVruxHDlfl/x3bB9RzyTrXTZuyNBItYUdDKJrkHM?=
 =?iso-8859-1?Q?XvgywhHDdvmWSmxEB8fbn4rZoDmIn3x0GoC/74Ef2vaTFhtywo1EAFQXWW?=
 =?iso-8859-1?Q?diH3Un4/V1E4GmFYaMUU4uTuIJbk/9tFFX210K4pTHR2CkoSoGmeYak9X9?=
 =?iso-8859-1?Q?nrmg2TFmPiDY7uUw5bdsSSLtpME8Je6xzZLzmxCOTYiqzEDP3k+2whnJ08?=
 =?iso-8859-1?Q?z9gdLHTaugM+Tt1dckOydrFFo0bljW/pILPsjdE89tmOJ/e0BwNntyBAA4?=
 =?iso-8859-1?Q?trgwHSzZY0Tkho48b9XS58PbFdhTETBgmsyGEipsdRo2j1ZXbmcc9/oOJW?=
 =?iso-8859-1?Q?4OVt9oV/g83t2vAHw7AolLI8oYsBEVPl8VVKgV1jPmZeP9LHIp1UZk1YyR?=
 =?iso-8859-1?Q?Ww/TYhpmRT+pUCvILMz+Ey4Cef24MvqPxeR1yq0hZgOj9IGGp1KBkUXJT9?=
 =?iso-8859-1?Q?kHUvbayRfhjh7+J0Mwig+4jrqKwzB8iugh1gIPFWtbpO88emuBL0r+dN0B?=
 =?iso-8859-1?Q?e2tIJYbvO5UHGH7DmoHY1bPmVnZDyDvKaPuXi//AiqYEpDk5IAMz3BPiza?=
 =?iso-8859-1?Q?zX4IHyPp56SOkQUQN0qKPTnIivJz7JnVXUgFCpdPrZU7A1x18lVcTTFrXN?=
 =?iso-8859-1?Q?ytuP+1sEI0xzxQYlYMgVNzFbjNjNbiQcwHgs87aoJQzUeW0b0y+RYqcXiO?=
 =?iso-8859-1?Q?90OalsMUHAr/NvvZJl6BzINBwDOoEZKS6DH5DUFWkozJqEkNZqXKh4EOj2?=
 =?iso-8859-1?Q?fTqDQXVBCJoKarbOMU3bbZl8rGYbld4Fq89wqEnmsjbCQ4I26dKA9ec0jC?=
 =?iso-8859-1?Q?EWNc4EktR5ZlvxBUY/E7TD7hDv747pZANh7FRMyxRlonZz2MUXKcEX/2aL?=
 =?iso-8859-1?Q?X2VFjTBjVRjziPoXzrg8M7zFwucbIOQLVcE+aOR3jbS/vPwM4doIkFkyIK?=
 =?iso-8859-1?Q?wvv/87ze4QvdahAYM0DU8LoJPhHPTi8vSmkao0+ajdeUIXKgxrGkoJ/oEE?=
 =?iso-8859-1?Q?vDFF4MkkuXwX498CfpPRRQmT+C+VmVq99ooelIUiYUhsZBjTnlo70g1lBj?=
 =?iso-8859-1?Q?5I63ok3EaLz7g8j1m9S+KLEBu9rZhO+IESU1PpTO2Z05orLO/LL9fy5wkk?=
 =?iso-8859-1?Q?ENlXiJ1Ik3Gys2OFvtoY1fwWfdjb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4YoPpu08gCUE2wLNQq6sZlxWyAQ+YA4EnjYFaPtPkaEAjp/jKVuUypS0d8?=
 =?iso-8859-1?Q?dwBGKsXiWUwVPRKwNbZguV8aO4FIjJghSWCshyAQthA5AL3Exu0N4ki4Fs?=
 =?iso-8859-1?Q?bxFdUfBTdEsgye0Cxj7XviRDC2ygNdgdI+L5dN+Yrvc32IDN3RtWLTObLe?=
 =?iso-8859-1?Q?aignDkxMgIn0UDTq8b5npO9cUqdv4mdSlvE1SBtiEBtqaMFk6v/DP4ab4d?=
 =?iso-8859-1?Q?odXZNzo9echV0pPp7/9tfK58NFehU2Mq+D1iMyH5cg4Ibbs1k/ZWG2vykV?=
 =?iso-8859-1?Q?8Y6yt3fZ6dHzjT5/vbC1VRvES7oERBRRCPGHvt2tTttp283j4t+qmbC+6M?=
 =?iso-8859-1?Q?5sijH9JFQAqmsQvkaL8cYZVB89FPAqAnVk7s3YZfc8mgjQC3Avl9njtOdC?=
 =?iso-8859-1?Q?Mxi0MFuy8iXPx0AbznA+ZRTI7dL+vov6z9PMUtdB5YAPpRu2DLg+KrlzmW?=
 =?iso-8859-1?Q?ytm3fnuJg3RzdJtyzjg5iNj4m7QRo1wSE7zsLoZJraz1AVgosvgfqk83+8?=
 =?iso-8859-1?Q?XxC75M0aUzo4uw7RhhmGIFy7f8t2mW695o6xVZOWe2y3ZV2mQjC99qtLJu?=
 =?iso-8859-1?Q?vpIYZAprjJVvp+KENvPDdnCieMbnP9zRI796I+MI1QxzKyaDWb81A/i+P+?=
 =?iso-8859-1?Q?YNLjdkmFdpo/cDmjJdzs8FireuEtv7aDH4wjArad8fW+YNO63B5H9W+FnN?=
 =?iso-8859-1?Q?NowaG/ETlsz7IE/EiPB1FmQ2yXjUCex/GHaI3L+KchmKvFKu6MnEO35R/v?=
 =?iso-8859-1?Q?VTwhDrMIBEAScMB7d3q76Xyi10zjlDEhh+ZqxaVdhnHuiOGF2hn9gqu88H?=
 =?iso-8859-1?Q?A7HX3tdcMDKHr1ldD520o92FqD5X80wmJqM1OqjqoOvVriGCNcTGHwxL30?=
 =?iso-8859-1?Q?RH8Y7SK2MtruEk2pwhyZ29hDmEcNP41+1vaY4K3MeLFyiFLi6vQuPgN+VU?=
 =?iso-8859-1?Q?t0prp38ZRPhUxef5Afi27jsWLmq3VBtwxsQOnfHSCSKgUCWwTvTmaRMvyA?=
 =?iso-8859-1?Q?UfHoEVi2qicUaxdW1OLjuUhiYf5a0mAIBwc9/YF+53heDdYKRNsAFhcvw0?=
 =?iso-8859-1?Q?2bjmMbB7WJE5fGt/x7VfJyzKCvU/ahGTHiZQouaPLDp46uIbR5jS5WENFj?=
 =?iso-8859-1?Q?mDEFSpG/b/FZtT3lBmNGnZ/90RG0FTeem15Q2dVMXVNniBd+vFnKVzs+PD?=
 =?iso-8859-1?Q?oZpIhBRneXNQYDn02U8wd5SlUcQh/99Yzf7JSwPzHOCFLLOD/Z1lTnpIaX?=
 =?iso-8859-1?Q?qXqLoCd7WyGukMMBTJ0hQnnCg/2BCCTGEnIovT4gO91MO6hP7ZXiMii9s+?=
 =?iso-8859-1?Q?EhjhfLw+mzAImmLvlaqiG7KwQmxJGuXo+qhnzuzZDBrbufM04qAXqYQopv?=
 =?iso-8859-1?Q?f/4OC0DiiCKSLnafZSWM/6LHQyAruKHYEXgx+DaSZyTMpXKSJfxU9dVUBo?=
 =?iso-8859-1?Q?wo60q6cc9pCirIttmsGRMqtr+BGZ4+kpmEc5MdXqEOtULECf3WrhGr0lFn?=
 =?iso-8859-1?Q?5lKkDWev+8pBZdmyWxd2moRiFXsm8hLxkDHwvfpA85cSvGbpqKjhfC+l5p?=
 =?iso-8859-1?Q?Rf688D0FtZW5VGCVpaxI4B7qfgkUlhUIpyucDC5x9X3Br5U990Ss/yVuhe?=
 =?iso-8859-1?Q?ZZmhPxMkWYhZwlQk99vCqtYC2WTz9WOTJpWUr9J4P2DjMHvyfSQvJySOg1?=
 =?iso-8859-1?Q?YzrY/GollmjnNRyAiGk6u1ik+8S5BngChq2lcnpRz4erGbNkZj9bm480NA?=
 =?iso-8859-1?Q?+JjQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d5182b-59c6-476f-8d61-08dda828feff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:13:38.6681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqlKpwK+RQz+SDUVEWlIKIa3GTqyl4fkWz5/9gNyJUl1u9M8WNSYAujxdpn7qzj/jmheVQTcCGe6YhAdeYpwAVdxgtpInB+WRBIATileKCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMiBTYWx0ZWRfX/NO+x3WfLBD5
 Pjm1XDXnkq03A2beaJrHxX3e4YHNzr/wSsQNeWr4bhDFTnLdISvJHFLL6Y9uu2nPjI2DD2Oga8z
 50k/9Cde/OHFXcDw8sihufhbr42uEGhGHGjy3/ol+YTAe7zyWWT8s4l288wuKd29c5rVCajh+YX
 zWBqZh9Zg+/NdjaVu04N8mzXjf/OTpgdBhbQ0REr9g6MnSbzy9LV+TVWQEwaO94zI5sGnEKs7Ss
 v/ezFg4rWJ4we3wKTrwEEaW9Zt6AnK6UIBcpZ5wwEkX5Rvb4K+olXTUlRgoY0BEiyUtBxGAohyu
 SBU8JGWcbAH53AFSf9VJgnG7rZ72RFUIKqi7qbP6BrtRpDhZjehKJqAhvo5yqs1Hhu7lDZh/+vy
 taxIkgqCMDEwAU9Af5s3sPv+mJo4mTJnVbKwkZxipBtf8jRDgPPqvn+7V9fmgBm4ia51TLoO
X-Proofpoint-GUID: 0HEwrK_JdbY5xeHcY-3zohem8vL8hjhA
X-Proofpoint-ORIG-GUID: 0HEwrK_JdbY5xeHcY-3zohem8vL8hjhA
X-Authority-Analysis: v=2.4 cv=P6Y6hjAu c=1 sm=1 tr=0 ts=68483d9d cx=c_pps
 a=x0nDIQOoo1kOKUvCQdQjQg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=V9CieWEp6mFoODgdGGEA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100112

Hello Andy,=0A=
=0A=
sorry for the very late response, here are my answers.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>________________________________________=0A=
>From:=A0Andy Shevchenko <andy@kernel.org>=0A=
>Sent:=A0Saturday, April 19, 2025 17:39=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafo=
o.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com=
>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>=0A=
>Subject:=A0Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, Apr 18, 2025 at 06:19:02PM +0200, Jean-Baptiste Maneyrol via B4 Re=
lay wrote:=0A=
>> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
>> =0A=
>> Add WoM as accel roc rising x|y|z event.=0A=
>=0A=
>...=0A=
>=0A=
>> +static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t roc,=
=0A=
>> +							 =A0int accel_hz, int accel_uhz)=0A=
>> +{=0A=
>> +	/* 1000/256mg per LSB converted in =B5m/s=B2 */=0A=
>> +	const unsigned int convert =3D (1000U * 9807U) / 256U;=0A=
>=0A=
>Wondering if KILO (or MILLI?) is a good suit here...=0A=
=0A=
This one is a little complex, since we have gravity value in mm/s=B2 multip=
lied=0A=
by 1000 to go to =B5m/s=B2.=0A=
If you have an idea of better writing that, I will do.=0A=
=0A=
>=0A=
>> +	uint64_t value;=0A=
>> +	uint64_t freq_uhz;=0A=
>> +=0A=
>> +	/* return 0 only if roc is 0 */=0A=
>> +	if (roc =3D=3D 0)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	freq_uhz =3D (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;=0A=
>> +	value =3D div64_u64(roc * MICRO, freq_uhz * (uint64_t)convert);=0A=
>> +=0A=
>> +	/* limit value to 8 bits and prevent 0 */=0A=
>> +	return clamp(value, 1, 255);=0A=
>> +}=0A=
>> +=0A=
>> +static uint64_t inv_icm42600_accel_convert_wom_to_roc(unsigned int thre=
shold,=0A=
>> +						 =A0 =A0 =A0int accel_hz, int accel_uhz)=0A=
>> +{=0A=
>> +	/* 1000/256mg per LSB converted in =B5m/s=B2 */=0A=
>> +	const unsigned int convert =3D (1000U * 9807U) / 256U;=0A=
>=0A=
>Ditto.=0A=
=0A=
Same as above.=0A=
=0A=
>=0A=
>> +	uint64_t value;=0A=
>> +	uint64_t freq_uhz;=0A=
>> +=0A=
>> +	value =3D threshold * convert;=0A=
>> +	freq_uhz =3D (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;=0A=
>> +=0A=
>> +	/* compute the differential by multiplying by the frequency */=0A=
>> +	return div_u64(value * freq_uhz, MICRO);=0A=
>> +}=0A=
>=0A=
>...=0A=
>=0A=
>> +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=
=0A=
>> +	struct device *pdev =3D regmap_get_device(st->map);=0A=
>> +	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_INIT=
;=0A=
>> +	unsigned int sleep_ms =3D 0;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	scoped_guard(mutex, &st->lock) {=0A=
>=0A=
>> +		st->apex.wom.enable =3D false;=0A=
>> +		st->apex.on--;=0A=
>=0A=
>Hmm... Even if the below fails we consider it successful? Why?=0A=
=0A=
If it fails, there is no easy way to restore functioning. Better consider=
=0A=
everything is disabled to not prevent the chip go into sleep (which will=0A=
disable the feature anyway) and give a chance to reenable it afterward.=0A=
=0A=
>=0A=
>> +		ret =3D inv_icm42600_disable_wom(st);=0A=
>> +		if (ret)=0A=
>> +			break;=0A=
>> +		/* turn off accel sensor if not used */=0A=
>> +		if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {=0A=
>> +			conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
>> +			ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);=0A=
>> +			if (ret)=0A=
>> +				break;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sleep_ms)=0A=
>> +		msleep(sleep_ms);=0A=
>> +	pm_runtime_mark_last_busy(pdev);=0A=
>> +	pm_runtime_put_autosuspend(pdev);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>=0A=
>...=0A=
>=0A=
>> +static int inv_icm42600_accel_read_event_config(struct iio_dev *indio_d=
ev,=0A=
>> +						const struct iio_chan_spec *chan,=0A=
>> +						enum iio_event_type type,=0A=
>> +						enum iio_event_direction dir)=0A=
>> +{=0A=
>> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=
=0A=
>> +=0A=
>> +	guard(mutex)(&st->lock);=0A=
>> +=0A=
>> +	/* handle WoM (roc rising) event */=0A=
>> +	if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING)=0A=
>> +		return st->apex.wom.enable ? 1 : 0;=0A=
>=0A=
>Invert conditional as below?=0A=
=0A=
No problem, will do.=0A=
=0A=
>=0A=
>> +	return -EINVAL;=0A=
>> +}=0A=
>> +=0A=
>> +static int inv_icm42600_accel_write_event_config(struct iio_dev *indio_=
dev,=0A=
>> +						 const struct iio_chan_spec *chan,=0A=
>> +						 enum iio_event_type type,=0A=
>> +						 enum iio_event_direction dir,=0A=
>> +						 bool state)=0A=
>> +{=0A=
>> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=
=0A=
>> +=0A=
>> +	/* handle only WoM (roc rising) event */=0A=
>> +	if (type !=3D IIO_EV_TYPE_ROC || dir !=3D IIO_EV_DIR_RISING)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	scoped_guard(mutex, &st->lock) {=0A=
>> +		if (st->apex.wom.enable =3D=3D state)=0A=
>> +			return 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (state)=0A=
>> +		return inv_icm42600_accel_enable_wom(indio_dev);=0A=
>> +	else=0A=
>> +		return inv_icm42600_accel_disable_wom(indio_dev);=0A=
>> +}=0A=
>=0A=
>...=0A=
>=0A=
>> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_d=
ev,=0A=
>> +						const struct iio_chan_spec *chan,=0A=
>> +						enum iio_event_type type,=0A=
>> +						enum iio_event_direction dir,=0A=
>> +						enum iio_event_info info,=0A=
>> +						int val, int val2)=0A=
>> +{=0A=
>> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=
=0A=
>> +	struct device *dev =3D regmap_get_device(st->map);=0A=
>> +	uint64_t value;=0A=
>> +	unsigned int accel_hz, accel_uhz;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	/* handle only WoM (roc rising) event value */=0A=
>> +	if (type !=3D IIO_EV_TYPE_ROC || dir !=3D IIO_EV_DIR_RISING || val < 0=
 || val2 < 0)=0A=
>> +		return -EINVAL;=0A=
>=0A=
>Hmm... I think that splitting this will be logically better, as we see the=
=0A=
>type/dir conditionals in many functions, and values checks only=0A=
>exceptionally.=0A=
=0A=
No problem, will do.=0A=
=0A=
>=0A=
>	if (type !=3D IIO_EV_TYPE_ROC || dir !=3D IIO_EV_DIR_RISING)=0A=
>		return -EINVAL;=0A=
>=0A=
>	if (val < 0 || val2 < 0)=0A=
>		return -EINVAL;=0A=
>=0A=
>> +	value =3D (uint64_t)val * MICRO + (uint64_t)val2;=0A=
>> +	pm_runtime_get_sync(dev);=0A=
>> +	scoped_guard(mutex, &st->lock) {=0A=
>> +		ret =3D inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);=0A=
>> +		if (ret >=3D 0)=0A=
>> +			ret =3D inv_icm42600_accel_set_wom_threshold(st, value,=0A=
>> +								 =A0 accel_hz, accel_uhz);=0A=
>> +	}=0A=
>> +	pm_runtime_mark_last_busy(dev);=0A=
>> +	pm_runtime_put_autosuspend(dev);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>=0A=
>-- =0A=
>With Best Regards,=0A=
>Andy Shevchenko=0A=
>=0A=
>=0A=
>=0A=
>=


Return-Path: <linux-iio+bounces-9000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F496881B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300BE1C21C45
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF911DAC64;
	Mon,  2 Sep 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="4f/SowHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020118.outbound.protection.outlook.com [52.101.171.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A4185934;
	Mon,  2 Sep 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281927; cv=fail; b=h4DE7xFEfa5y8Qz677hUzsYRFnk8HmVksLFIvrUpG/3+OfTg6ZQtFLVWx6ncGUl3WVZXMcl+7sDohVBldVOahhS5G5UEW8FgZtQCJuBymf1rGak+PD9y7V4ymqwMfTxklTFojxQTJjNvEyRrsOOBIVF5FoMTuxzgIfcyXxB5II4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281927; c=relaxed/simple;
	bh=/2iMk9pJrTGI0Up9J6dNB6NVLHTr2mc6Qr0JjZF1fsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDc1ekB7YymhHjMT6wzmJWZ0/dr3VfqBxjjQ7DEfxgGk/oBxIOezar92q+yGf8hM7pNeI9NaZPCk/9vYBUPms46tbohj6M3SHI4DQgEwYjkKRZ9+5duuVGCa4VhjvCuEUZuJY8ZVNQT4DQqmRkflC4bVS7ZDzj+cEQrvpJFsUbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=4f/SowHC; arc=fail smtp.client-ip=52.101.171.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbiPvh8s/1dto5/lPVGSPHSsRF0sktmlSx+jGZOfWV0UR0WCDI3tBomIIPT8xvbYGGYe823qMVM7zbe8BdCBkm2qa+B5vxOKnARUwhWP6PzqzyMaaKhvtLAZAvLhqOSUDa8f3E4/Lif4mpq/DSecE1porE3UgdPgrs1r9Rcy3BnO9pkh16gAs6F3V7cSPeQMaxPZospM7KH/zqU7jy/JM2+PoGjnWfHImIGuwzpf/FwlmxqBGflWi4D/MG22UOzJaczlC2ufwAhmamG6G5pk9B6fHGtpATqog/dCJYuffKiBCY0zeG+ABdDBhCTnkrNF1WPKRYmTrO8o3m/dUY9zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV6E34/WD0p5rHTZ7bHmhbKdsCzUm2JSfnXP4PGB1eU=;
 b=Jvnt5k9TnEzy5soQ8/jw2gmnjVRHxxdQlyN3Vzd+eHsHDode9Prcx5tY3mjCMeWNWLPv79L5YM+j/e2qqUlfzSER9O8I5BBj3Lp30DRfZM70elD8wjyfdLZiDTy5VFj7uLyowRKRYpjHFI+mC5s6rI8Gb8wEoRaLpW901nehTs4jFNwcEeaVURpZz00JXKGcm+iyBwoSQ9sjoS2FQP/lLDEvkTZY0Z3gnHHv77g1yBtsTrfgM83QZm+hBZiygz+zCnCUlzHNzMH1Wg4AiUnDjf0vgRYhOlLXtE12byy+WMZhraC0sA8aewM/khzWX4qjrAvfgbui75yEz6KEqt0Ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV6E34/WD0p5rHTZ7bHmhbKdsCzUm2JSfnXP4PGB1eU=;
 b=4f/SowHCcuxErp5e1On2p9vsDdLbBP9ZvWW6h9xgzqUf1jHhnY7gMXHWyRHu1yF9WhnnJi/JN1eSz+3aMU+HefuMxotGS7aISbY1X/7mtTuLmhtfD8PNH0xODAilwYUgkr3Zt6pAw1GEe314kEDgXhqT0HJwH40QUxz0qulzXEIaw6PsDDstIJvTIxKpXXhc9rmupZ9OIOGuQB7kNY5Amjtkh6rtj3amutrkdDmhy2B3vv7ajnqPNurw06b1Hd1LFrl+TSvkHO11DE3Mm0Ad3ggk94SCXqgI6TJNK/JM7Onv7pETjVD5ui0JzRvhFnL4EsOFJp3MvDlURNYrRm9zpQ==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 BE2P281MB4932.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:be::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 12:58:37 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 12:58:37 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Index: Adr60bwOPjoiJD3QTreu2+tBMAOlGgADMoEAAJXJPEA=
Date: Mon, 2 Sep 2024 12:58:37 +0000
Message-ID:
 <BE1P281MB2420F7EDCFFB8C5B2528F680EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20240830-chaos-unrivaled-04c5c4c6add9@spud>
In-Reply-To: <20240830-chaos-unrivaled-04c5c4c6add9@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|BE2P281MB4932:EE_
x-ms-office365-filtering-correlation-id: 00287f5e-dc69-484c-6d7b-08dccb4ef60c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YstRBix7uAipjgklK68X5Jb8N90oslDnB7xWqBJ5De7REqeqNczA/NyvSWY4?=
 =?us-ascii?Q?Zi3ES46W/oMr59Axm4Vtb3NkORvDKW/dt0oC5edwYERWaNFmc8AK2zBkySjm?=
 =?us-ascii?Q?8t9r4Lr9Bb6yq2mixBSP4gesdvDsP4V5S3+nQoyjGrWFTGzuUTMEB/tvrRn4?=
 =?us-ascii?Q?9QOdrzICJKOvghk8/U3/oMQZmootVZDm2bNxw9xxhf/EaAwucToZVRCOjfAD?=
 =?us-ascii?Q?EllsmBRji4rXWX9EEQUsOeZ/E/LwBTrZu6LiGI/wtaLdI+TIjj22VNKeKw+n?=
 =?us-ascii?Q?6Ni1QlqFSkTEhPnNEh/Oq+09YuI17q4BZdNOYImQvOEijU2fPNwDi3KK1JLr?=
 =?us-ascii?Q?oSuDuzJYdPguirWSfshChdEav+b/UZPuhWnfSxenIJBpHZ/b6mNeJAd0OXEz?=
 =?us-ascii?Q?LxA3YSsfDEBdUXJqbkja6WKmfPrUH8xC4jRzbzNBNRQJRMgDOSYlIM6patSn?=
 =?us-ascii?Q?J7mug0OLhTjws1uUi4r3t26ADbYY5th7nfhke6p1WFQwQhW7zomCmeVw7YK4?=
 =?us-ascii?Q?ZAq3LLT+DkDIkJYwzeQlR4qDnsVDnVdU5HUUyum60ZJDlhp45eXeeXSpU13B?=
 =?us-ascii?Q?UeudjBnWyGWhj0+TtXPI0zMtjCP93ZRSFiaTiWNtHTupYR5l+RUJBwpPXUW9?=
 =?us-ascii?Q?jn3V4JXsR9hedpCczBfVY/w2T+r6Mat6kipKx35uPClNIE+OVPrbiMpdvOdj?=
 =?us-ascii?Q?Au/073oo7G9FxkkZeapMY6Ccek7uM6HDJguJnBFIqZqROtRQj0/e7CfqsiYY?=
 =?us-ascii?Q?xZTmvPGqYvkGD655JTAXV3cgfB6Ngje64K7oeIBF+cjS6fcbA5Lv/pXofq1/?=
 =?us-ascii?Q?4R/A0V6vEtJi3YHPmSt98UwfQJ9gLPdzhPU6qSdvXI0EgUUfLKG/2fOesmwn?=
 =?us-ascii?Q?io+Kg5HxnMv4e7hnR7xCkkwKpUn/Q8Fn6El1f0WI+taWM5W9azZGnEWNV+Nx?=
 =?us-ascii?Q?qdXU/ubyghoLiRhP8AEG90b33I3ykMFV5TLPreJxFE4So7GqgdbsOJynwpBC?=
 =?us-ascii?Q?KRpRFdMQezEHYnFQzEH+D4motEalaPCCrGVj50h7VEUkBjUBoFQPbF1Htpgr?=
 =?us-ascii?Q?8xFiT0VPx4Vja15Yfa3fAtHJ/5Sz3f+GuDI/CJb3OTa/u5TYAVxEKB+QYG02?=
 =?us-ascii?Q?ctVbiZ9o0ZFTnavbPiv2voR0AWO3YBxMQiUrSJFMFXjniI2NO1od2U8Ob4cQ?=
 =?us-ascii?Q?ZUwKDz6lmohfU+jyzB1X8ErjRy0l+4PCOg+5NVyuWKqiFKBK2mPGDemtzs3B?=
 =?us-ascii?Q?E6IVL3y87PWtpTYhroBvj05AQMoC7QS6E+kDuuoJs7Px0bNYIV+Qh0abdiTg?=
 =?us-ascii?Q?Ga076VDW5GehmA+6ApaGUGXdeaZhFsbBS83SakDeeYTwOl26QrT0PD9fLD13?=
 =?us-ascii?Q?NOMeNju0IiuBdv7Id3oISA/XaQwOtpciwgN1g2y76/lQTVtXFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AFa/RTUzA0wlStEngU3Lbowf6P+u9hK8XLK7IgRg27WasIEYX+GDjlNncJtl?=
 =?us-ascii?Q?9PxaZs78VrbAGZHySs/Hy3Ok57t8kMXQnippNos+1Vl7WNihpuYpUmI4dB+P?=
 =?us-ascii?Q?SRniietLqplCWjFAwjAy7THp0S52yqCp4Y300XTvDPgqAPqfdW1omZBS8EIb?=
 =?us-ascii?Q?Bu2ycd9tEmzk4cxZnJvBWnOWhMmTpu8zGZVemC6Mc0ENEmxa630u9FizjOYr?=
 =?us-ascii?Q?SZmhBCtRnqRa/ktkoWWXTzXDGEt8/59RcBonJjqhQRU5ZdFns7S2EGrntEqi?=
 =?us-ascii?Q?Z1gC8Y6yLWLColNkLAVJzRKN5FJjs/8PdpwxofQ6Dfr+n9deycS0EhdtPTxn?=
 =?us-ascii?Q?AOsAEOQ6zyoVsKUtKGOGAfzo5M5WyzFGbiBK964/x2kpannrdy323OQyfOMs?=
 =?us-ascii?Q?0oBUH8ojFQVuHEshVV9R5Expbw0noT/49Lsg+KoGyjFnBYYsAt03M1zVWKqg?=
 =?us-ascii?Q?41shFNBEjzQ7IhtkV/6/s2G1IvAsBq4XxQmJKyyz9VQ+YCc4n7AqpPxLXXII?=
 =?us-ascii?Q?OjmXXbObe+jZ48EEHp5ksDS+TKiWshFGN6ezSlntnDSOqx3AdMlyofvKKZR5?=
 =?us-ascii?Q?vZ/t0yvKrRDnFEiCqtSFHro2FWe3FsUrCeesDA7P0Xjl6Urr65x9vCB4nkRD?=
 =?us-ascii?Q?fEfsoOr0ISxaHCAjnYIVBHB2845wGrm85kqdI2nFK2M9l8HJbohPKgsq0uGr?=
 =?us-ascii?Q?4L6SOsBPPqRtQaH/U2CMucll+8XKfF82vs8HDDBdFdjZ7+7PlixT533uNNy8?=
 =?us-ascii?Q?sNVCwjG2vP+DkgTfqveCd78oSkqZP54pGvtT0nt64f06pJr49fyngIpeTbwh?=
 =?us-ascii?Q?PJ+MH35TSXOVvnJ35nLyshvd5HQVLjhnZ7/t5Qlu/l8IatuRwfSI9q5unlxJ?=
 =?us-ascii?Q?mKyvfmwktNqMxD12K6Z6t/Pk6e3ixiicjFm5oRl/s5cDIodSGNUa41tVYMgl?=
 =?us-ascii?Q?vg32UFRmskzlKw41In4wkCXNNqigea25D2jR5Fak9RaMTfL2cuzfrzqm+vm8?=
 =?us-ascii?Q?0reJEPiVT6c4OCeaIuWZkTP8TaDEmVAz0uV91jjI9GMxULaXk9JchV8w8gIt?=
 =?us-ascii?Q?PwAoq6jVPEy1ZPCg/q0eEWgZ7E4Y9Iq4hJNADfwLMm0z2K6VS+D6FQBOvKBQ?=
 =?us-ascii?Q?ENMH7/g0tsz30Jp8crp4l4OMO56mzNhdGaZ3ZpbqRSqD1quinJUM3v6mf6H7?=
 =?us-ascii?Q?kcLmCArb5YK2/ULV7HvAWRsqYzTKNMMMhDC5JvKLkxpuSsLQyxG7QxJKo77J?=
 =?us-ascii?Q?2ImWzSXxouthqmcu92a9tmkCHrhwywnquK39N8vPpOKxWB70iz4z6hbUa6Vs?=
 =?us-ascii?Q?DoabkrAKUJp865yFEeAqD6bOPsEQ1lFKXduBS/nTOQH2MyTyjFlPffPAApFV?=
 =?us-ascii?Q?no3Hqab5uBuuayStLNJ4Rkdnb1rwM6qtk8acV3M5+uVcTbFIkgbHhliJrRMd?=
 =?us-ascii?Q?VeM6qiQt51Fyp+v6OHIfFlUOj6VNBOzy+0nKsJ/Zm+VSjlKMgAfBdToecpEj?=
 =?us-ascii?Q?H6Ew77FObVOyuSjz4/Qmmu++aQaFgX0W2DCnb7KZAQ+IIe3JYqmOM78sXE8v?=
 =?us-ascii?Q?2gOShF9MyuFwvs5UGfDL8MNRGWOOtF+Hs4qYC0F0kf5tZ2QfhOUxILDnEqc1?=
 =?us-ascii?Q?uGcisOhZEwNoD5y0zZBo4DzOGP7C3aWyPt/wuxI2sTcZ5i/iWuIq/RpBEEv2?=
 =?us-ascii?Q?Hc4/VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00287f5e-dc69-484c-6d7b-08dccb4ef60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 12:58:37.5134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1WD9JJI01BFkSTihkm/3sq0ExHEynVkzl2ISJq19wn8Y6CrBUh+LA636un+0RE+JRjlN6RLdrYl0A7gVIc9ok4UYSjY8lU4NO48JzhmKco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE2P281MB4932

Hi,
thanks for the feedback in general.

> >  Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
> >  Documentation/hwmon/index.rst                 |   1 +
>=20
> And these two documents are not dt-bindings, so they should either be in
> their own commit or alongside the driver. Not sure how Guenter likes
> things.

Ok, probably misunderstood some documentation then, that everything in
Documentation/ should be a separate commit. Would move it then alongside
the driver, if that's fine from your side.

> > +description: |
> > +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converte=
r (ADC)
> > +  with an I2C interface.
> > +
> > +  Datasheets:
> > +    https://www.ti.com/product/ADS7128
> > +    https://www.ti.com/product/ADS7138
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads7128
> > +      - ti,ads7138
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
>=20
> There's also a dvdd on the ads7128.

Yes, but it doesn't affect anything in the driver. Does it still need to be=
 documented then?
=20
> oCheers,
> Conor.

Regards
Tobias


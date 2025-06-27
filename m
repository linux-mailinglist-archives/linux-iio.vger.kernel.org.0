Return-Path: <linux-iio+bounces-20994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD8AEBBDC
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DE13BA33F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE152F1FF0;
	Fri, 27 Jun 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Mrfasaub"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81D86338;
	Fri, 27 Jun 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038374; cv=fail; b=WpKhUE2ZFY08NXubh5CwHP63JisDO2hK0+JfMGh8dyAB/rVwmYYdxWoKnGi10uo4SnB0cu9OYFYhw+t3ARKpd7yZvVB0DiytqPW0v5YpN1tD9Tkzd9q6oZRJ6odvK1sqVG2uqgHa2e10ZlA/kCbftTHEQsMWezpE2oiyd42MfEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038374; c=relaxed/simple;
	bh=cxnC5oKzdpASs0iPBI+BJFMxstfHKm8m1RGifyiyj/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXxEsMBWN/+zBNPlwy4VlcKuaPeZxEcNvfb91WG2KSc6tYv0ACwD19oSz1Si0qyR21pZWcK5CQplFIq6BWOxVfJmyWq68N21fErWhSq+CfHcGu0CLqj+Z8UFL8HhHGM/jX6lV4MoMd1Iyf0sP/mvKgfDv8tlw5iVKHagFLPX7gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Mrfasaub; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCAaGP005335;
	Fri, 27 Jun 2025 15:32:19 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010019.outbound.protection.outlook.com [52.101.171.19])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47h94frxwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 15:32:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og+XNRJboz1R4jEG+wdE3cXwvwFeKIPbF+cP3ecyFbsH1V6wsCwC9XB3VPzl5o5RlXxil11s/nVjgQJmihlX1pvUkQ4tCauY1pCZuOlYC7r1JAWacxPOPrvyQcJ+bAl/PLqXoIlaReA5AJXDKDE1S/C/MaKGp8t4s2R33DWLBu0nLzDsE4fU2NcBVfuKrvFCDfGZtgGAwsbQgEf8Wi/3AnoddetPRipa8XZE6SH+pL61NplY1UcynakZ3m7oUD3AWt/WLI9Kq3DqOseK+Qdb7XBg4LiZvFQFkElz2KkNhYCw2XQKf2g0OA/E6jV3WsJ51FwhYLKbeZn3/aa8GdKI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHtlDT1AEz11Bw+33NQMZPbMS+xLenosfqu9zRPInoU=;
 b=QrsyfORLTuEeFonorKFinrWuMptOmSakmmUcbGuYdTNi0kvWSMofepPJfjlV/KUE6tJkrIsIF5V1mY+GWVhbrDEMpxqkTvjBErXTzvNrn0ClcHx1UybeoqViyPXdFT+H3P2rtZqR7rS2IYZa63UqecRRp/u9wj6BOH2xxJJ1xUrpqr/Vf3Y0TRNqQwYIxYdLjmHRotgTYjzNnlbAxO9EtDYDZYyRtpu9SpONtAGHR2Bz4VMJWfPIepxSYV5LQOIX/PsdS4ualeVDIhFJ5C4OU2gSLzRl5DeqDMkkynt4zw+BGnOni5r66fyF58c7rvHmE+XXFo9hxiksS5PHlVau3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHtlDT1AEz11Bw+33NQMZPbMS+xLenosfqu9zRPInoU=;
 b=MrfasaubmTZFiecendP+CwqUnYIUvTEMyNFkN2AS0+4HQ+taAyhcR+CUtZGFET7ERmIcriYz5bwWY1mZoT1lnojp72bqu0vAZPIdpT8ALcFaiUX3VQEqfr6htIA7/iQBAzIS290nuQLkCiNEt3qDHi2AOSqyg7nsflAqRG+uZEmAPmCvfDiwuGOeEdPYJepXZsaEZmwbW+8RiMjxe/cR/rCOFoRtWI0NYpjWBhfr+M0lpfC5Au11nwhktgBSca7w1RhjjijztU+j3wpc7t6FDT3jofNtTnldJh64iXLx5pNGO+OQnkNxvY3brbLByubjMhLvjm+TK75zXTynV6m+Jg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR5P281MB4122.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 15:32:05 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 15:32:04 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHb5D4zWAS/xrKQGkewa8H8xfBagbQRWFOAgAR2X4CAAA9OAIAADtCAgAE7K3Y=
Date: Fri, 27 Jun 2025 15:32:04 +0000
Message-ID:
 <FR3P281MB17577DF9326C6CC893711EC2CE45A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
 <CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
 <20250626195323.6336820c@jic23-huawei>
 <dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
 <alpine.DEB.2.22.394.2506262240440.3473@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2506262240440.3473@hadrien>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR5P281MB4122:EE_
x-ms-office365-filtering-correlation-id: ade2f095-dc54-4615-61ac-08ddb58fc50d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GapK1TIrr5tBOdfepS2OHLam+oBDi2L5KDlsZ3fSd54ZenT5K5HTeuh+VS?=
 =?iso-8859-1?Q?xXQ98oor8rdr4F06xRe8LiSTbK/GQpt52hZORrm2W4Hc3Ib3+3V0k7jQXY?=
 =?iso-8859-1?Q?Ny1cfkW1CaEv3HT9kArGJsQi/YNhYmqLgczi1ot3IW+j8ElTtv5Hg44PdL?=
 =?iso-8859-1?Q?ASNpKX8YLMjfVJZh6PtrdmnfHUk/Q0aV0XawxoFBtGDxL1FuuIK901yT+s?=
 =?iso-8859-1?Q?NJ40jHZoPD6C+AyOTq3xC23N96ULSNRophB9i2g/2U4g8JUkclEvF6Gozt?=
 =?iso-8859-1?Q?oMedrh/rAB2N0kAe75g22svJrlhZI4QRvIeLA9HUAw47uTy4YJeGnX2WAc?=
 =?iso-8859-1?Q?pjNXtql3257p75cfN0mUa1+L/Gd1ON6MB85JRG1Rsypi7a1QfkrACSyhWk?=
 =?iso-8859-1?Q?Q3eBqWxRBxYo5TnQb5xX5Rx5EpXoro26Zm5eoCG6x2W69kJl/BY6g/PLwa?=
 =?iso-8859-1?Q?MkYLbNwHKQpBWOyDVQFRHhE+ei2ahvWA01wgZmlIVoWWyv6TsMT+7hHH7B?=
 =?iso-8859-1?Q?0jgvrBAfae4MuJ9yM6BDss2G08bVQ9ioOSw/3JGS0sGYq3GavLRbfUuRkm?=
 =?iso-8859-1?Q?Fem6X1w4T83q59du1BORdaws1RpAFhcpH59lA2jKQmIFLvqNTTOfpi/kYy?=
 =?iso-8859-1?Q?vXXZabEk/cDOS5xt0JXZLjBzgW/cCZ3gYKdskuL44JRFMATwugecxqkQXO?=
 =?iso-8859-1?Q?GsT249qKGiChUJOgmJmKp8DaIUp3HSxYxXXw0GD9wLBvqG3U0igVZidkxm?=
 =?iso-8859-1?Q?zqhfidPGlXCytLJ69fS3liPb82bH9P+hKpuQsKsOWJ7AB8HDTMZNV689sG?=
 =?iso-8859-1?Q?vM5VrQq5S5rRcvwakKUpu7KlHTZ4Q2L0Vq0HvTQNdGJ4Sl+GmPqC+O2W68?=
 =?iso-8859-1?Q?O+PFoFscNNdvOXsjFtq78k12UlBs5OcjGGjWbrQQXY4MWRo9qibYDfUDx/?=
 =?iso-8859-1?Q?8MYoloB2OMU2KfX9C8sDO3wHSakhlIOd0opG104ddyrYIkV7Zje/x8GbW9?=
 =?iso-8859-1?Q?rUrtv6+6WK5cJvHnPwvpvJgrabpWxKFoWQNx+qkilqIrAIlwCQXHVTY5oU?=
 =?iso-8859-1?Q?KP7ehYs3cfmXSq584Q884jZIJ4kUzyswZXlKC43yKJ9nIyfsTW+VPMwvbM?=
 =?iso-8859-1?Q?oPbQwkgs7CI3vqOW0MkPrMdi7tGpIvc6BhbQeFm+1gfWVsorRkGrI5eqGu?=
 =?iso-8859-1?Q?BduGW8MSEHla4nR2uVLf89hmMzw5GqpYWItx8QL0qyAV+nDh/442s9WFU5?=
 =?iso-8859-1?Q?+rfbBJzzU4vgAG4/A1iCqJuH2IR/n8SVtUnuvsH04SLSUXG5cLBNnau3gT?=
 =?iso-8859-1?Q?FS3Xwh4MI2Qv8E9XqCEI1Tj6JtZ/Uo5Kl2XmxQZuFT/7oiATdROwtR34en?=
 =?iso-8859-1?Q?GM/zk8fOUgA6uD8i3j49JddMf5duUCJuwuQ+e2uU2XUkLRWMcNkHluBL+v?=
 =?iso-8859-1?Q?whlnf6i4BxxLwOAizKewloNpsOu71XQ4tQMPu6yQGHaG8xCD+tGlC4QWM2?=
 =?iso-8859-1?Q?QaejxDNuhBZrKyeyqUsCiKm/J/hNg3qibgvor9tyl7mQDLuWDhchkv0n24?=
 =?iso-8859-1?Q?HpkAwEg8Wz2Tdb+o0f92vdt92HjH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?P41S8ZhRiY1eLYsWOfZcb5Z+hv3N20ZJZqhQoYOcg/pPSqRLvyltI//yjJ?=
 =?iso-8859-1?Q?PyyzJ9xsRrNaBjjr6f1FIakXTtNBluyIXJOos6C7O9uO/LoCFoEGsRtLRs?=
 =?iso-8859-1?Q?FBsgXptmThRgLT5Xwqt13N8DRQt6unOQB27FTJ6x+Rl2wVkL2UqyKCdHEz?=
 =?iso-8859-1?Q?bH7QhfVfmmBxnawRNmmETRJyQbvBaWIzFIn9Sa12I7a3WTWiW0lcrNNoOj?=
 =?iso-8859-1?Q?q9X65Q2N2bZBfDob5Io4GOALo7O16+IbzlrLMJE7yxL9iBs1rldtx4uSAZ?=
 =?iso-8859-1?Q?BgeLVc3exOCPtu/N3Xf9LU/MZntsbVF4JFvb2CentWdRdeZ/o/3KOhk0qL?=
 =?iso-8859-1?Q?/PSftboGPxBi39+wYm4YFUAGh0cNuySnpUfmYvNSWou+WdLRTlRnsIocC8?=
 =?iso-8859-1?Q?gcAkx6WBy0H4LFTii+R33VBzmEYmcrFWSXerviHph6CFJ2giFM9HA5KHVM?=
 =?iso-8859-1?Q?BVb1F0tYH3E+NSsbaaVZrOyXRziMHGq4jYM392Ej8X5Fu84LGqjqMck8gX?=
 =?iso-8859-1?Q?E3BMvmTF08HqGbGW+SVSbKjB9DAjIVgTd3MfuRO2JGhSzkWQ+VS1FW3XAX?=
 =?iso-8859-1?Q?Dbu+d0iwu24Eg6MkbEjNrFy8g52VJZp6aOOsMDPwcEi2hO9CsFpD76DBd+?=
 =?iso-8859-1?Q?OyPDE73GxnsH/eotGh4iQk/sZdLi2NmT7BcsvMXTC4MItY6I0cKtTYy+pd?=
 =?iso-8859-1?Q?sPt2fIGzikI3p4N5XxtBafjbf3pwdu4WrPlO0S2xZIVvXW3GawyQVsTH8U?=
 =?iso-8859-1?Q?+U7o1T9+mtNeKDrhBFLCUG+dSOeTrT2slb52mIXSMC8lKPlURdr0i7m8q8?=
 =?iso-8859-1?Q?xkh2mbXmlw6sFz3RvW2BLcW9vicfevPtn40FvCdvoN+VIhvy1UhODVU3RR?=
 =?iso-8859-1?Q?Z/5/+twPoZNPDCXaY9nRsXFwpHwmTnC+NRKN/sosi/71vqOCLvokYJgZuT?=
 =?iso-8859-1?Q?bKloaYmIHq9xEqxgkAmeQ6FDjYNLaMpzIDoxCgmryQbz1JQPnnQjn/Ut2P?=
 =?iso-8859-1?Q?WjZV67E59WUpcvHbA4OthVzVwsa9JyQ3svdY21XvwyYoNcgNOuAmZNoad7?=
 =?iso-8859-1?Q?wvLLvpnGiRgeGph0L6nWISO0Jr57ltAYOSFKYadjU382AlP1tnbXoA/jYx?=
 =?iso-8859-1?Q?ugp2VrqPQctSGGvp5+Wu+74NcdlbbtQ/AvFtjFrAMNiE3VVL5bEH91VSbq?=
 =?iso-8859-1?Q?vH6Z9SCAi2q9PgqhQi0DRPWD5U6BZbpV+dXLTAvx2e7sycyMiWb5HtomFi?=
 =?iso-8859-1?Q?UX23N5KaRezfDWPc1Ap1DGeLcE07t5sjbKV1uT9VSdJiitGz/xCEZKH/gH?=
 =?iso-8859-1?Q?YoqF06huVB+pAyPLK9IyXuDo9k+Zvw4RQuKT+Fp1Nd+354pQJL9v0l1D0Z?=
 =?iso-8859-1?Q?sv7slTiXPh50eBoMDFbH/XKHAhCnM9rjED29NBeKy67wDAlliCi5ch5Isy?=
 =?iso-8859-1?Q?SD9sOBa+m0H3U/avZ3XjY6ZxFWbt3H3gMNEvEYgj7/B/AkoxUxxBXDxGjx?=
 =?iso-8859-1?Q?e5JT2dfAabfZcvliu4X99zxXMKMZ5VK3+3Bsr1FX9yT8jL+xifJhFbwTkE?=
 =?iso-8859-1?Q?U/esURLuvdhR3jweeYRbX3rNhJpkwi4S6GSXQPy23KOA2A1r636Ac86031?=
 =?iso-8859-1?Q?UOakuDuB3naeW4Nw95vXSrnIQuvSHHlBXxQAqIBkQthb0lyhJ15B6z1EFW?=
 =?iso-8859-1?Q?3E4FVeESB8l7NZkfUKqyjSgyCu3bh8kd+e+nyzaIPaZNdszuWD0dsfr0pM?=
 =?iso-8859-1?Q?sb2A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2f095-dc54-4615-61ac-08ddb58fc50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 15:32:04.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28VX5hiNokevmidZFNaBG52C/O7BxtawoDV/OcshdpojYi5Lcx9o63y7KOAKzncRlsSmtchpMONa1+Wva99lME//WG3/+kgEP1Nf/9lwk8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4122
X-Authority-Analysis: v=2.4 cv=DqVW+H/+ c=1 sm=1 tr=0 ts=685eb982 cx=c_pps
 a=Uk1dkqH0rGx9VGHu35Sm5Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=In8RU02eAAAA:8
 a=gAnH3GRIAAAA:8 a=5Co4QaNE1Z_q50yXfVYA:9 a=wPNLvfGTeEIA:10
 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: q9ppjw0fCioUvQiz0ZqXafKaQcSD-74r
X-Proofpoint-GUID: q9ppjw0fCioUvQiz0ZqXafKaQcSD-74r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNiBTYWx0ZWRfXxNi4PXnhqOU0
 tBcuTLrivESMo+I4giVnmkbWg9cO8rKByphtwt/zbzF5gPCM0gmFlUuNef8yPQ3GQFVr5kcWW5C
 Vx4uYIsfxaLgEbBStahPTxOtSXu8Gtl5tSy03tHiAMQKZ1cQga/puG2Cx05R8ZN9IX5MA7Az7f3
 roWtY0S009Sp1L0gfVTg0wE27O2QJRNE+NjofI0cMnSOOlM46XNI/a/FFU4mWlgFvmZhBZbjGv/
 1QlKDlJ17D9LiI454jPEuMp2FrRqGMv0TOO0AOpTJe8uAxgoi59bED/ory1vbTHm8erJWxxJ38n
 HlR6m4KgCNH0yGKxZ0MKG2uQR11p5D+UkWrUisaM9YsUw+/axV3Xx7ko+gV1CxVOJQUBIXDw08H
 oqa3VuEVhUO2yU01Qu1fX5IxPmgwyCDEf/deEgOnxIRDponwRyX4v27HWvxhQ56zZ4T0meTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270126

>=0A=
>=0A=
>________________________________________=0A=
>From:=A0Julia Lawall <julia.lawall@inria.fr>=0A=
>Sent:=A0Thursday, June 26, 2025 22:41=0A=
>To:=A0Dan Carpenter <dan.carpenter@linaro.org>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; David Lechner <dlechner@baylibr=
e.com>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter=
 Clausen <lars@metafoo.de>; Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko=
 <andy@kernel.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
>Subject:=A0Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Thu, 26 Jun 2025, Dan Carpenter wrote:=0A=
>=0A=
>> On Thu, Jun 26, 2025 at 07:53:23PM +0100, Jonathan Cameron wrote:=0A=
>> > > > +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_d=
ev)=0A=
>> > > > +{=0A=
>> > > > +       struct inv_icm42600_state *st =3D iio_device_get_drvdata(i=
ndio_dev);=0A=
>> > > > +       struct device *pdev =3D regmap_get_device(st->map);=0A=
>> > > > +       struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENS=
OR_CONF_INIT;=0A=
>> > > > +       unsigned int sleep_ms =3D 0;=0A=
>> > > > +       int ret;=0A=
>> > > > +=0A=
>> > > > +       scoped_guard(mutex, &st->lock) {=0A=
>> > > > +               /*=0A=
>> > > > +                * Consider that turning off WoM is always working=
 to avoid=0A=
>> > > > +                * blocking the chip in on mode and prevent going =
back to sleep.=0A=
>> > > > +                * If there is an error, the chip will anyway go b=
ack to sleep=0A=
>> > > > +                * and the feature will not work anymore.=0A=
>> > > > +                */=0A=
>> > > > +               st->apex.wom.enable =3D false;=0A=
>> > > > +               st->apex.on--;=0A=
>> > > > +               ret =3D inv_icm42600_disable_wom(st);=0A=
>> > > > +               if (ret)=0A=
>> > > > +                       break;=0A=
>> > >=0A=
>> > > The fact that scoped_guard() uses a for loop is an implementation=0A=
>> > > detail so using break here makes this look like improper C code. I=
=0A=
>> > > think this would be better to split out the protected section to a=
=0A=
>> > > separate function and just use the regular guard() macro.=0A=
>> >=0A=
>> > Good catch.  This feels like something we should have some static anal=
ysis=0A=
>> > around as we definitely don't want code assuming that implementation.=
=0A=
>> >=0A=
>> > +CC Dan / Julia to see if they agree.=0A=
>> >=0A=
>>=0A=
>> I feel like the scoped_guard() macro is so complicated because they=0A=
>> wanted break statements to work as expected...  (As opposed to how I wri=
te=0A=
>> half my loop macros using nested for loops so that when I break it only=
=0A=
>> breaks from the inner loop and corrupts memory).=0A=
>=0A=
>How about a goto if making another function is not practical?=0A=
>=0A=
>julia=0A=
=0A=
Hello David, Jonathan, Dan and Julia,=0A=
=0A=
no problem for me for rewriting this code using functions and avoid any use=
=0A=
of break. It is quite easy.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>=0A=
>>=0A=
>> regards,=0A=
>> dan carpenter=0A=
>>=0A=
>>=0A=
>=


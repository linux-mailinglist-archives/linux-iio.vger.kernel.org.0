Return-Path: <linux-iio+bounces-12632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BF9D852A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AAA28C407
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890719AD70;
	Mon, 25 Nov 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fBMzkpRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0319992D;
	Mon, 25 Nov 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536806; cv=fail; b=QQoUpopMBv2GohGz4mAptxbdIYdqi7VSeBYe7QJLmbCC/kdBVcqUmdYvwEzvPO4mJNWGK6Li/Tm+TLNnhpcqc5oGxynQfK/f8DN1QC5B2HPotUzRL/r20wgT9WIkgcXLT7S3PfIyDeNvt6tbY84ppTenduI0ag9YuQcr+Jq5Hvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536806; c=relaxed/simple;
	bh=3NbdN9JIcHKWe9uExxREmY2RnP8chDwrSdSvqKO+8Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VvgFwUzYjIDFXTbGkiZrtx+mxebokEmPUn7EYnpAhDTtbzrU2k59+e4iCRHe6+GAcvrIWQ6QgyHgejcw71gmqniYwiIIcQRtzkuyIHJfg92Yk1N8ETlB5qLOfGyZAZgDjRq2qo/5lj1XNXRHSMaeyK+Xfu7D/lw+icu2VC5MiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fBMzkpRI; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOMx9Rm006365;
	Mon, 25 Nov 2024 11:43:30 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010004.outbound.protection.outlook.com [40.93.77.4])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4335dxsam3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 11:43:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dm4Z8mT6QUIb303/tqBxA00/USrehcxaLeqSQDGPgaCKjEaRylnRXmq55it9ExxfPVSho4fGKQwTvxaYBgmPrNgQs59DyMmLWjykI1oCTvIDdcjT5irQyKqGKqC6WxbIRyTvZkDKW8oiivitLwB+CaFl9dHRLx3i23ddYmNr5y0n3LOx3B8jBOWiT0242maGqsp8O56PssuhnMfmMB+xKVktDvImuCNS8M0jn/i9Or/RiGoM1h4neSS3Sy4H9tk6kepOrEFusJcaPKtkWJfHk/hXCq2UBur8RdM8xwBRpU/aW0hrbbbb0+EsB48Ja4c79LFMTWSqRjdWaF2xAXSZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWnP0B/YcGvj4Qa4FKc3s2baN7Q4z9cC8KoIFyn8v6E=;
 b=SWu2d2+du1WptHS2+dYK85XyIi65TNCLAU0fZJRE69yzTGQkJDdCptyRvN0yZSpUJrVBeJVERLf4sJP/ptC2ZxFUGtKOa2gQHpcwPLheMpvYnF7dSv5Im3occETNwURx05OS+VkeIqL45qsv+qKtRpNbat2ljOBAP1mxMGEooQkDpnbRRwmWM0bAisYCqzQMZAHwk1y04Dw+OVQ/47uKivxBvwVkoMYzmq6kuSIdWtulYAE8FJjXYUDD/CvMIxa0mUGSSTTG+oF+8P14xs72PoA44m7572Veui/JRaJLeLV1fUcBtuMemEl8HidP4j72LCULPT7yoh3DjHWv0o6heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWnP0B/YcGvj4Qa4FKc3s2baN7Q4z9cC8KoIFyn8v6E=;
 b=fBMzkpRIGYN+6LPpRk7xlRM1cz40Uiw5bTjzxiQpg5XB/ZYp09FmgXP3TXqGE07rmyuKTW9g1H/rT4r3Gghjq1LXRzcXRUhR4w5T1Q545E+TAcczT7JJFZA4iiG1JCFMGonrRHaxCvEUZ34Ye2mhHbM1OFOkCD3BbQlUfdXf7Pla8JLiSHaz1+N9D31bMokvNeHE2B+ez5O174v7Tam5CMHbQ53D+eU6iNngclhaZ1Hol1Kfqd8Tf91B394QYQDSCDzWwln5i42aP4LiW/XREdQ4hHX6vehVqtWzGqhgeD54chxIBvhK75yQB1UWlcfgugN6xDjctQjSP99iOqOydw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2401.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 11:43:24 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 11:43:24 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Topic: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Index: AQHbN68NJchVZONPZkS3XOqNFkRQZ7LABxmHgAUDpICAAuNC/w==
Date: Mon, 25 Nov 2024 11:43:24 +0000
Message-ID:
 <FR3P281MB1757CC51713A1A6C418B2A57CE2E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
	<20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
	<FR3P281MB17572DAAB3B3145EE7AD56E6CE212@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20241123153333.51e4a517@jic23-huawei>
In-Reply-To: <20241123153333.51e4a517@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2401:EE_
x-ms-office365-filtering-correlation-id: 9b07aede-9e9c-4e25-9874-08dd0d465edd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bLEcEALUpaxkUBv9cGw6tVI+LfmkWWUC8NxWNzvfb30NaRX4H+LxvTAM8/?=
 =?iso-8859-1?Q?eBnpmtcmF+4b0WRhN0X95MSRiHmIkO8nuzr/oJjMW0i4YWMcL0+mUuDtIv?=
 =?iso-8859-1?Q?73k40E2jyeItoTVKmsbGwnjrJouD8HlXTY/J3lTub9mwEpVObCsGSxF4t0?=
 =?iso-8859-1?Q?mQIVBn/5oZqrN4u8wjerkCH31/NWpRt0HHadnv8Fr2j1jXXXIqDwLv+9fc?=
 =?iso-8859-1?Q?UYGzSCr/D+xFEx8gKvEeVahJ5WdsGJcsJudLd6hYHfWaxRhYbZmoOKd8uu?=
 =?iso-8859-1?Q?E27PO0oOnUMtLyyIu7eWtgfriflZ8z8SEL73AN3yv8o5WYT6cFzL/Vovxo?=
 =?iso-8859-1?Q?l2GuEeQsyuGICnbjq9bMz7qhZGXbRcuy3ec41hPYr3A9Vjv3mm8x6wlTFn?=
 =?iso-8859-1?Q?AojNQiYoiS2OgV/fJEiLKkJRcAUfakrEJw1coLEQ0ZJC7p/25EBwuzJ+fY?=
 =?iso-8859-1?Q?VS5gW516S5n0Us92QD+kbCaLeShUOy6ulgOgTrJqUwuZ/pvB4ViswkQHgg?=
 =?iso-8859-1?Q?3FZmhtMQiGY1LALzxJgW9149wc3zkliCq6pFFimketupBXTjasnztQytdG?=
 =?iso-8859-1?Q?YIeMdNCE/kw8A5AQXmT7eBVCGfW8qwu17/DJUdbM6qp03SfwPQnm0OApwS?=
 =?iso-8859-1?Q?bILZXDUDGYQfL56sy/JfuV/Dx+ildyag5dt3nb+ogocRB+Gyb0KZaLb/EZ?=
 =?iso-8859-1?Q?9b+Wop3hRzL5Acco1XiO1v5cC/hYw1agZ/2nJzNjbFZ+8M3+nG8KpLiG5a?=
 =?iso-8859-1?Q?LrpLvrWC5RUrbUrZrLLdnk6c+TqRbUARRynaP1o3kQKOYv1J1D4Crh50Gk?=
 =?iso-8859-1?Q?S2zlt6hFjkM1wnBVThpAXmEcEuBRB2006EKZCJ7vRNzdGD8RnHvYYi9mif?=
 =?iso-8859-1?Q?+oK2C1jotrksrPQhObHzr1i9qNBCGVekoQsnYAoNiMlb3KabJ5yl2bX61T?=
 =?iso-8859-1?Q?lFwrrYI8BQcBeCxOWDYeP6kc4SqIpvaL344I1lFtYItn2ugqdjSgoFH2KR?=
 =?iso-8859-1?Q?8MRmY2v2kVqZVwY/xEYdC4sUE0fTq4NaaJBR5k7rzD1KZNwQinzPYDOObu?=
 =?iso-8859-1?Q?AxDWJiubVykugN/QkI/XsTmPYWn6J6BwVMsaijkBckS1vyJroDmTrtJbgZ?=
 =?iso-8859-1?Q?JF9Rx/Lu+c4G9Ohjs4Ckd0p2b72fIenv2twIkOt/gJYqGNM3W6AGkHRegg?=
 =?iso-8859-1?Q?07sbeF2pHwt60vFHvdEWaR1mz9ze9GGv3SGOXhUXByUrOcL1hkmC6fbqPK?=
 =?iso-8859-1?Q?obeKuPN3EjXtodc7SFfxESG79kIdTynip3ws1XD7nQxEyH6f0+K17zyMkK?=
 =?iso-8859-1?Q?YqBcxdrLXuHpDPGTw9xE+1QIaDDP4XkYnxXdSUqc/XsSATQYR620yTzEvd?=
 =?iso-8859-1?Q?h+HIx9C6VSBHM5evca2vbPmqFoKCdr38mNPOHQVXL60v9ThLmqq5s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3RntWmzDkRV9dFT0yzhugvtiLN3T7d6B9Qm2R+qs+USV2NLFFp+gINi5SL?=
 =?iso-8859-1?Q?g9mG9KQIhYd7/OgJcgf23Re26d/O6x9FdewT1VZ7yGLz35atIfzjHStXBM?=
 =?iso-8859-1?Q?O6EsBMPvzJXEAUJXTqAK1KRcVQocTsShodIvhKDht0NMC1aLnuDclDV6rj?=
 =?iso-8859-1?Q?+4CpIwcyEw5re20LTKudVEosORAo1SbnDMRvx5orFkb1lu8zIxs6IPI0o2?=
 =?iso-8859-1?Q?y3MXEHFOXaoVFQRwDpWvrLbjwpNr71UYLzFkRknmnxUtQBoj8yCC2fS23t?=
 =?iso-8859-1?Q?N74f87qhK4Vc05xQy+FoWp901fQXNFJIJy3KrZjzCU4PpgJbWqtjlmQokS?=
 =?iso-8859-1?Q?zxJzlaNXnX7aD9RbzcWfwN2KRiYlebe/ncCZ5kXNN26bU+AG347ChTVKlI?=
 =?iso-8859-1?Q?ND3XXfo0F09M49ZlTE4vFgUi5DXHt1GY3FSFX4bvuRrCjBIjQCAobjWIZZ?=
 =?iso-8859-1?Q?7X/BHVycwwH4nPCYYtZs01diBr3XL2NJJriBnivCvpMvt+7X0XVKDEOUpK?=
 =?iso-8859-1?Q?7jXno2zc9GbheofyZ4nJGgMFXflv7KV5OiYmpmubxQ/5RMFj2HAu+JNFrs?=
 =?iso-8859-1?Q?pMqCNgiVVW07ukpyz5usvbxJBMcDHOswr1uVvN5HpMov3Rhj81J4JpwCml?=
 =?iso-8859-1?Q?PcsoBW8uDEFW4kUdmLLhiI6/Ukq0biZDy8aiCHRNwnGTZuoyKncKksnNyC?=
 =?iso-8859-1?Q?QBNk5LriYEamEl5m7U1ucLhbocM5JHh7byZdCpcHNebOi/6caDLsVtNGMh?=
 =?iso-8859-1?Q?7GXdONIK60qleFcY2FizcyPOL8sk9W01G4dkmzxx4QPF4ZG96trb20fiE+?=
 =?iso-8859-1?Q?0HnooQqUfVmHO6WqfhtRUhhOBu9KBSbPugHixcSGdfwk4gbUFlYoC8hz2F?=
 =?iso-8859-1?Q?qQ6ptgjDseT/3Yz4MBBc4s49azL0Tx1FyXz886ydFDKbkSzHdgXRyVOZqY?=
 =?iso-8859-1?Q?ZowHOhaTQWCwBB9BxcCypN2V4gIl4m3ZI8nw9SE7M+dUXn6GiceP85zQIy?=
 =?iso-8859-1?Q?HqXKDPHWWfRdNAmf1V7FRX6AQXPrEdnP8CzVrWswdskBIHjAzSKdDh38t0?=
 =?iso-8859-1?Q?1FSheEHhFnTdet3mcET01SsCc1z5T0MjOLOAULOnnhW3q17EkVwg62VZxn?=
 =?iso-8859-1?Q?ctQaoU7GBMngRkEyrDN1zGbNzoqCsjUDiDT1Ptnd+JVm3A7TW6A58+vseU?=
 =?iso-8859-1?Q?T3FYHpkNC2QEkOaw5qmAnIW9BkxH0lIlfZUy7xCoMef+WY/QE5sLUsJ0vi?=
 =?iso-8859-1?Q?b47B8J/WyO5gro+dWAERDg4/hxOa9OiNKSCA++oW82p5ry3UA6uTAJnPyU?=
 =?iso-8859-1?Q?Cd54uh8AuDZ4PeTPJvYdxr5aG8UA6NfFkg1CQgYT0M0pB2sllSarIh87Hh?=
 =?iso-8859-1?Q?IiXaPLYwMsngnKeSK0ZOn7wH1p+l6rzSOwhUvvClhmTs2t6pyZXl6YPHq9?=
 =?iso-8859-1?Q?2R4eilDOd16DW2prTTED+bXL0pG8UJr53M5wFyiWbEN4X4tL/R22Y0Rxv8?=
 =?iso-8859-1?Q?2hsUuCDdv3twMmflqR9fY5OilvxMFZ3A4lxdOfq1+DZqz29Q34fo5bFmNQ?=
 =?iso-8859-1?Q?ncs6h39nK5cJGn/DxLh4KLIbEMzAxAVhGt9VnmDWWKScUSaRmTrEJ6nwhP?=
 =?iso-8859-1?Q?iN6UHN3O2H8a4FrJKN+OakoTRshzOKR0vQ5p096OkxqH40PF/2CQhzQw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07aede-9e9c-4e25-9874-08dd0d465edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 11:43:24.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95i83RaDps30bAmC9NA4UcBlwM/jejnR3EeOUXq10R8OlDGDbIbjYYOqA81hochAgz1YEIXvANob+BnMwiEzhVHZLpRki8KEuIGw8MiUFUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2401
X-Proofpoint-ORIG-GUID: mIY5vg7vEFHL_m7ZW7HC7QvuFxm46yc8
X-Proofpoint-GUID: mIY5vg7vEFHL_m7ZW7HC7QvuFxm46yc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250100

Hello,=0A=
=0A=
thanks for the confirmation, Jonathan.=0A=
=0A=
Then, it's good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, November 23, 2024 16:33=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0Frank Li <Frank.Li@nxp.com>; Lars-Peter Clausen <lars@metafoo.de>; Ro=
b Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Cono=
r Dooley <conor+dt@kernel.org>; linux-iio@vger.kernel.org <linux-iio@vger.k=
ernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-=
kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Han Xu <han.xu@nxp.c=
om>=0A=
Subject:=A0Re: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Wed, 20 Nov 2024 11:05:23 +0000=0A=
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
=0A=
> Hello,=0A=
> =0A=
> overall looks good, but I've got one concern.=0A=
> =0A=
> The gyro bits used for scan mask are the same than other chips, meaning b=
its 4, 5, 6, and timestamp is bit 7, and these are the only bits since the =
chip is gyro only. Usually scan mask bits start at 0. I don't know if start=
ing from 4 will work or not.=0A=
> =0A=
> Jonathan,=0A=
> do you know if this can be an issue?=0A=
=0A=
Shouldn't be an issue.  There are various drivers that do this.=0A=
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.12/source/d=
rivers/iio/imu/adis16400.c*L821__;Iw!!FtrhtPsWDhZ6tw!BUKGdZqx3SyrRUYhJqLMYe=
n_msXNlBLk9L5OacejstVPtdMCSpltGpI8mpXdrFctK2l-lAmLQE4lpEXq16X-Up4$[elixir[.=
]bootlin[.]com]=0A=
was one example that I remembered as IIRC that driver was the motivation fo=
r these=0A=
being sparse.=0A=
=0A=
Normally we just pack them together because it feels neat and tidy plus=0A=
for high channel count devices means we can still use a single unsigned lon=
g=0A=
for the channel bitmaps.  It's not a requirement as such...=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Thanks,=0A=
> JB=0A=
> =0A=
> ________________________________________=0A=
> From:=A0Frank Li <Frank.Li@nxp.com>=0A=
> Sent:=A0Friday, November 15, 2024 23:37=0A=
> To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan C=
ameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herrin=
g <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=
 <conor+dt@kernel.org>=0A=
> Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@v=
ger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; Frank Li <Frank.Li@nxp.com>; Han Xu <han.xu@=
nxp.com>=0A=
> Subject:=A0[PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor=0A=
> =A0=0A=
> This Message Is From an External Sender=0A=
> This message came from outside your organization.=0A=
> =A0=0A=
> From: Han Xu <han.xu@nxp.com>=0A=
> =0A=
> Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It =
is=0A=
> similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI=0A=
> register data is difference.=0A=
> =0A=
> Signed-off-by: Han Xu <han.xu@nxp.com>=0A=
> Signed-off-by: Frank Li <Frank.Li@nxp.com>=0A=
> ---=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 ++++++++++++++++++++++++=
+=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++++=0A=
>  4 files changed, 38 insertions(+)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
> index 40271352b02cf..a7535cbc214e9 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> @@ -277,6 +277,14 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=
=0A=
>  		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
>  		.startup_time =3D {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_=
STARTUP_TIME},=0A=
>  	},=0A=
> +	{	.whoami =3D INV_IAM20380_WHOAMI_VALUE,=0A=
> +		.name =3D "IAM20380",=0A=
> +		.reg =3D &reg_set_6500,=0A=
> +		.config =3D &chip_config_6500,=0A=
> +		.fifo_size =3D 512,=0A=
> +		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
> +		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_ST=
ARTUP_TIME},=0A=
> +	},=0A=
>  	{=0A=
>  		.whoami =3D INV_IAM20680_WHOAMI_VALUE,=0A=
>  		.name =3D "IAM20680",=0A=
> @@ -1519,6 +1527,14 @@ static const struct iio_chan_spec inv_mpu6050_chan=
nels[] =3D {=0A=
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),=0A=
>  };=0A=
>  =0A=
> +static const struct iio_chan_spec inv_iam20380_channels[] =3D {=0A=
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),=0A=
> +=0A=
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),=0A=
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),=0A=
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),=0A=
> +};=0A=
> +=0A=
>  static const struct iio_chan_spec inv_mpu6500_channels[] =3D {=0A=
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),=0A=
>  =0A=
> @@ -1623,6 +1639,10 @@ static const struct iio_chan_spec inv_mpu9250_chan=
nels[] =3D {=0A=
>  	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\=0A=
>  	| BIT(INV_MPU9X50_SCAN_MAGN_Z))=0A=
>  =0A=
> +static const unsigned long inv_iam20380_scan_masks[] =3D {=0A=
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,=0A=
> +};=0A=
> +=0A=
>  static const unsigned long inv_mpu9x50_scan_masks[] =3D {=0A=
>  	/* 3-axis accel */=0A=
>  	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,=0A=
> @@ -2026,6 +2046,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
>  		indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu9250_channels);=0A=
>  		indio_dev->available_scan_masks =3D inv_mpu9x50_scan_masks;=0A=
>  		break;=0A=
> +	case INV_IAM20380:=0A=
> +		indio_dev->channels =3D inv_iam20380_channels;=0A=
> +		indio_dev->num_channels =3D ARRAY_SIZE(inv_iam20380_channels);=0A=
> +		indio_dev->available_scan_masks =3D inv_iam20380_scan_masks;=0A=
> +		break;=0A=
>  	case INV_ICM20600:=0A=
>  	case INV_ICM20602:=0A=
>  		indio_dev->channels =3D inv_mpu6500_channels;=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_i2c.c=0A=
> index 7a5926ba6b97d..62f7d16c2ddcb 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
> @@ -34,6 +34,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=0A=
>  	case INV_ICM20689:=0A=
>  	case INV_ICM20600:=0A=
>  	case INV_ICM20602:=0A=
> +	case INV_IAM20380:=0A=
>  	case INV_IAM20680:=0A=
>  		/* no i2c auxiliary bus on the chip */=0A=
>  		return false;=0A=
> @@ -187,6 +188,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=
=0A=
>  	{"icm20600", INV_ICM20600},=0A=
>  	{"icm20602", INV_ICM20602},=0A=
>  	{"icm20690", INV_ICM20690},=0A=
> +	{"iam20380", INV_IAM20380},=0A=
>  	{"iam20680", INV_IAM20680},=0A=
>  	{"iam20680hp", INV_IAM20680HP},=0A=
>  	{"iam20680ht", INV_IAM20680HT},=0A=
> @@ -252,6 +254,10 @@ static const struct of_device_id inv_of_match[] =3D =
{=0A=
>  		.compatible =3D "invensense,icm20690",=0A=
>  		.data =3D (void *)INV_ICM20690=0A=
>  	},=0A=
> +	{=0A=
> +		.compatible =3D "invensense,iam20380",=0A=
> +		.data =3D (void *)INV_IAM20380=0A=
> +	},=0A=
>  	{=0A=
>  		.compatible =3D "invensense,iam20680",=0A=
>  		.data =3D (void *)INV_IAM20680=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
> index a6862cf426396..211901f8b8eb6 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> @@ -84,6 +84,7 @@ enum inv_devices {=0A=
>  	INV_ICM20600,=0A=
>  	INV_ICM20602,=0A=
>  	INV_ICM20690,=0A=
> +	INV_IAM20380,=0A=
>  	INV_IAM20680,=0A=
>  	INV_IAM20680HP,=0A=
>  	INV_IAM20680HT,=0A=
> @@ -425,6 +426,7 @@ struct inv_mpu6050_state {=0A=
>  #define INV_ICM20600_WHOAMI_VALUE		0x11=0A=
>  #define INV_ICM20602_WHOAMI_VALUE		0x12=0A=
>  #define INV_ICM20690_WHOAMI_VALUE		0x20=0A=
> +#define INV_IAM20380_WHOAMI_VALUE		0xB5=0A=
>  #define INV_IAM20680_WHOAMI_VALUE		0xA9=0A=
>  #define INV_IAM20680HP_WHOAMI_VALUE		0xF8=0A=
>  #define INV_IAM20680HT_WHOAMI_VALUE		0xFA=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_spi.c=0A=
> index e6a291fcda958..cd54e9dbf99ce 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
> @@ -79,6 +79,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {=0A=
>  	{"icm20600", INV_ICM20600},=0A=
>  	{"icm20602", INV_ICM20602},=0A=
>  	{"icm20690", INV_ICM20690},=0A=
> +	{"iam20380", INV_IAM20380},=0A=
>  	{"iam20680", INV_IAM20680},=0A=
>  	{"iam20680hp", INV_IAM20680HP},=0A=
>  	{"iam20680ht", INV_IAM20680HT},=0A=
> @@ -140,6 +141,10 @@ static const struct of_device_id inv_of_match[] =3D =
{=0A=
>  		.compatible =3D "invensense,icm20690",=0A=
>  		.data =3D (void *)INV_ICM20690=0A=
>  	},=0A=
> +	{=0A=
> +		.compatible =3D "invensense,iam20380",=0A=
> +		.data =3D (void *)INV_IAM20380=0A=
> +	},=0A=
>  	{=0A=
>  		.compatible =3D "invensense,iam20680",=0A=
>  		.data =3D (void *)INV_IAM20680=0A=
> =0A=
=0A=


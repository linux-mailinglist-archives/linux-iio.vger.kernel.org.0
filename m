Return-Path: <linux-iio+bounces-11099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1709AE4B5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 14:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E151DB22A07
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0F1D515D;
	Thu, 24 Oct 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="SHruphps"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFF18784C;
	Thu, 24 Oct 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772718; cv=fail; b=rh3yGRnOR7JjJ46AeJaTZ93rD8bP4y45Z/2McvDTXB9NF3Ok7aK7VpuF1kWtuzinfyt807W7ft6aqkyQU5Z3i1G79CC82M9Lpd1G4C64vLmjGWR9pjTYZ8S1jvkPVNux1IDeQJLx/CG3/Jar4nzZC4/B4WcVYgbIO6Fj/S9Tn3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772718; c=relaxed/simple;
	bh=xz9W88YqdNakCry/t5E3MO9Mt0hGPnNMmDEFjEGJ/Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3X1rlbyY/5V3rON/cNV6ObbBbsbHENp/Kftc+xPa5ixunv/TF1MRxjRCR4ZWN7wpuWf/CVqihm4EuFJ2xQLeJBbVGFgpmIcQkuETjPY9pO9N8JdvpR6fuqPVJ9qs0bgksqq85U2bEGJxtc0eU0BhddEi68di1Qr0YBkjCRv3Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=SHruphps; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NNXQl7021257;
	Thu, 24 Oct 2024 12:24:50 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010004.outbound.protection.outlook.com [40.93.77.4])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 42em2vhhb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 12:24:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfYJyxsXSDxi8oSo9Aa1ZI59jLwvSg1uZXRC49/5+cEpy3uM5pbTK2nqM0WtG142OkGhxMvQ4apdVeW7ijaygQxvBcmfMAsm3nkqNm9LQUWpzVO0tWmNjk/2oQ9aSUpV9Vtyi8IsZZkff8OZ1qL9XS0aIm5UoD8nXS8M/hKzHLdPy/KLU3bR+GyXmb0rD9WjuyoJnUnkk+hit8cyma3QY4jAixGmofqg2sLHmGq+Jaf7VvBwkdvTG9NvGr9547pU/KrBYkPgrqH7qwvDyzuANcgvmilQ8CBLd/gvmW/3XaOPXg62Mf6PhOnx0L+r+mdgO8cnJhBMGb3pbgb7W3QCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfLvyFy7np+l9ngnam5U9iIm8riUWMhvya57lY7eSQU=;
 b=jEHSVC6eaDTO7uUW6yaR7x5rmjhksZOMUcIktGGyIhHU66KvlAg3uLHu9awg8xFykcuwLiAjTh/j1imMzAzWG4ClaOWUQq4pEjUw+GmBqLdyqniPDP8hQJFBHneTJCP2onhy0RG1Z2qjbPI2ZAUSvD5C5HA31N68z+3PFH8uON34WNBidVmvjEMODZ2m2dm4d1RE4J/6bmuifIxty1ovm8C93nB//HXgVJ64QNPgkmI+3BeTwLNuDQVCTOIe+45uDbRmI1RblEdiTYrF+IqPuC34ZXnAcp/dQyzapLxPaOSlcfbZe0TrL/mv1YIfv2TsNnf78BMhPq/iREgMJnZHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfLvyFy7np+l9ngnam5U9iIm8riUWMhvya57lY7eSQU=;
 b=SHruphpsNqklQn+BFJ7Xgpw15oLH6ai9C4MDRT+kA+42CsCRUXoPvf7DhxDxlt7rvpRjqN+lz5hX+UgHEWulNFCodG/AhNwq30VDwc0+o5v4ZDeziOYuBJDrWn7auHPjhLqyOrTPIaMu1ClFIEptBD2cVZ/8iPf4Ykm3yxzY+ItGyLU0Y4J0kx6vgMWwhffFVjaxo83VJdpAz1ZVf/cNj8FKQiiExJI4O0qis0qNZCkSlwBrht8srML6lnwtn08tlwDfgwuuhFiX1Yj3b4FzSLrMX6Xm+bq4/a4q6j+NP/yYglrSe4iDRW8d4KnsiOm7znG6gy0Md2cSQzMN1GD/Kw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3PPF436F94716.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::138) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 12:24:44 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 12:24:44 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 03/13] iio: imu: inv_mpu6050: Replace strange way of
 checking type of enumeration
Thread-Topic: [PATCH v1 03/13] iio: imu: inv_mpu6050: Replace strange way of
 checking type of enumeration
Thread-Index: AQHbJV9nKD6Oeqfp/0CLgeWJh67JGrKV0n6E
Date: Thu, 24 Oct 2024 12:24:44 +0000
Message-ID:
 <FR3P281MB1757AB30E105E474D1CD64DECE4E2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
 <20241023152145.3564943-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241023152145.3564943-4-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3PPF436F94716:EE_
x-ms-office365-filtering-correlation-id: 6e1ba1a3-5815-4ce7-643f-08dcf426d7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1sb6AXGQ0V7h/15B77YCrO93NGJbIwaTsREOVg03lcXAdaq3Pbt07fw3vB?=
 =?iso-8859-1?Q?eJMDsNRwfc7u5WUthGMotmYqwmfinkYlnGLQ66hTURdRUCvuf0dnmLOlfE?=
 =?iso-8859-1?Q?hVkDXs3Vo5JQccaMTTauQBQuBIYbXRr7PfPqoSjJJJRIe9GCY2mCqVRc2w?=
 =?iso-8859-1?Q?6K6VY7iDzz4Eig5Sw9jKH/sa1gf1qPDGaupT/q0knk2U6JrhYcR54BZ4fo?=
 =?iso-8859-1?Q?oUaojV6SBnRK8wrXeH/RdCRzRpVzlU82+J8tCNOzLZxtm00ov7UZMVxPHH?=
 =?iso-8859-1?Q?yC3NEtPvVDg3IZZvPluLybqA2/rx7mCAnmkpTFJSort5YtoEgYp18bJ2wn?=
 =?iso-8859-1?Q?Blh/bw0nKUGTtTJzqAHnOx6SzbE4PHa06rnAPzNjf2LqU3cW40dhUMJFHQ?=
 =?iso-8859-1?Q?ZvmD/u+UEwbbe+XO+pQzIWVGEPoiUVQ1usQq2wtF3d0GpXoHe8HiYksw26?=
 =?iso-8859-1?Q?gaAJw55IRp8Yni4hzAveOsCHHk7ftxvKpqBqdP0IwyfmJcg4mjthuvIoT4?=
 =?iso-8859-1?Q?LOrnX2CC3a94o2EjAvHX25E0WtmoqmEpjjVJ8JIIv15z3jwHOEAmPxjwPk?=
 =?iso-8859-1?Q?1/hFejQrI5uzgfBI6mFhDGoVU/5y0p3sRIUqQjf72qZZjximpLjJgaQWKt?=
 =?iso-8859-1?Q?r4qlLiM5HUXYEeVi41q9OYQAU/R8tkiV/4H7vGaaiGOajtjZYYj1dZ1yt9?=
 =?iso-8859-1?Q?cm2sORAsRN0Xhnh6quidCul+m9NAAiREQlSUT/36kVsJrToJH9DQrjpKDb?=
 =?iso-8859-1?Q?sUNpDNyo/S3fdckigqCZ0NsePLmktsm/S3nTOVteqbQzzvnyOWkr24V5mO?=
 =?iso-8859-1?Q?DJB1DAUI19MyfJRxDT5YDxRmv0vQHKjBQtrVaKWhYwKZEn1y12GGhB//KI?=
 =?iso-8859-1?Q?IlWFiXFmFx83c/IwcuXyHf+FINGeuE5BlMNWVB3G7gIypRIB25Ks0K+wU2?=
 =?iso-8859-1?Q?YHV+54vt0n3M67NUtGHCOyG4txapmcFN6j5wg6STnMzXO7tCf4tDucdTr+?=
 =?iso-8859-1?Q?r8VGcJIGTZXSGQrTLzu3LpRIGQSte/qT0oL97WC7UI9fK77Ev0ZwpGxRQh?=
 =?iso-8859-1?Q?8CMmVBHJjok3ovHKwZ7csYFlJ5KyFUKuPA48i9KwNNBp7zUaumIYHiAKEy?=
 =?iso-8859-1?Q?Rjh7ypIMJ88EZRFpns9LV1WxIV3SNUNkJt7ayUXLsi8mUnkFnfW5YvY7eZ?=
 =?iso-8859-1?Q?m93wgjUKxS8xrTg7MqAaORkMCeiCJVhu52Q7nywB1gx8na62jjBpQb4xFM?=
 =?iso-8859-1?Q?cxifRdoBHdo4t1hNvijonl2kyFzC4d9MLeUQdr2L7V2qIDGHbRI0Sp7IA1?=
 =?iso-8859-1?Q?VunUHAVf9DTJ2oZJtl6ZIfQsduUb/WxTgkhb2YdwqP5plJw5Zsw/K6vMOC?=
 =?iso-8859-1?Q?phkjyXFcrhnnias2v7EfuFK/kqKsoexVfilTWkhYANKGov9zucPwL/ETFx?=
 =?iso-8859-1?Q?8fCCnhnswwLHnNiRv2n+/nnm3TvbloD2CcnYxA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YpKeQQ15twA+z/alB8SoISPskxZa5fTKQgIpO851w10nOW5rgwZKOyOyBo?=
 =?iso-8859-1?Q?sA7kh6vIK7SSc6YBUnuES9ZA4VEtxJpJ+gv4wJ+03CzC5oJUOQ6idqL16r?=
 =?iso-8859-1?Q?d8mOhmlViWYpZr+mR+WEF5v4tXLaNCWOwoyLz+X/Okf1SerHM/8BmFK6PZ?=
 =?iso-8859-1?Q?HergQn0gVNmBG4Fcsrf5JrswBMY5BeS3wDc4ttuOHt3oNe7M+spYSwRxvu?=
 =?iso-8859-1?Q?avgKwICzTq799CJul8uPxLBpmNjlyQrncYKgSUYn6YbTxxvmIH1NBre7nE?=
 =?iso-8859-1?Q?6QvXsWuFMfkNIs6c5ICuzn5loWGhciHFQEBCKx6KOhBJb4RFdfPkC1YdrY?=
 =?iso-8859-1?Q?vLP8+HmNUwqSx6W1CwUf1CcJc+yPjzx5/+HQZ8op+95hvKoZCxupNbTUVP?=
 =?iso-8859-1?Q?423vkJdga/Ge9ZnUDmgOKRH/Gv9lXdsqELUX6Zo6oppjpQvYI7lD+y9ZjA?=
 =?iso-8859-1?Q?ZNrSoCoW1OScBIOjlYVmA0wwawdxMOK9Dg6GF8qtXJfABp3dJgUfK7FrXx?=
 =?iso-8859-1?Q?DJ2S548TiCmB//XrFf9o8+aSDlBPkYayxpAFd6mkcGhpyy+3f3Bg7c6kRz?=
 =?iso-8859-1?Q?zxQVvGh3JWYKjQcKljTR/TvpNXJMILsF3j4MXhm9jEkt2IYjtAyuPG/yU7?=
 =?iso-8859-1?Q?lDwsUjc3D4BPSab+loqj8GJVRHnvr3E+7NxxEnwpXZex/hG6bnUjlccNQ5?=
 =?iso-8859-1?Q?NiYW7/QsHdjLPJG9dEeUUrYalsHLPGYQtDnjA1Tw4Yl1g9KwLqgf2bo85w?=
 =?iso-8859-1?Q?faL7Io41dYyxxL8Du2WLumQ6JQZSslb4faXKqnJRPmsHrX+Sm0nheKvQhm?=
 =?iso-8859-1?Q?DVnkczvC8kIqmo4G81h1f7TzmEcP12lk9R8fHnd3QSxDL/kvXKKkoEZHZM?=
 =?iso-8859-1?Q?TGuJ+P24b+3gm8swFA3sVWCAv9gF/VODtMXDzrDXm/17UbIHsWbPWQrnZL?=
 =?iso-8859-1?Q?lvOO6+MXCwd0CfWmh5L5PfpC59McE/PVop5B7tDDxv3DC/eTKBaALnp0QH?=
 =?iso-8859-1?Q?pUE+mgo1WkMcdhUfx5ovSKj0cYSfXrDgQhg01NxL65buIYh4xwiM991lcy?=
 =?iso-8859-1?Q?nViMGdnhbYRMCB4MpC23uVim3GZqYScNolhwGXSatayBlSDria78TRSNWK?=
 =?iso-8859-1?Q?RmfornfU34c2HT6ywzP2crKAXOkJniGMYQWMrhoQxaPdn7Jqoi8NcNkyle?=
 =?iso-8859-1?Q?CMYW4P1i02ZQ42ugpA6vbFGqKeIup+ucTkd8iUQ2QPhDaqdcjeMotlgEhZ?=
 =?iso-8859-1?Q?J1g8QWtfho9t93eZRXdMB5/MeuDw+xDVhnDV9PV6wFxtdG1+eUriG28QM7?=
 =?iso-8859-1?Q?0Xn9LioUi2WFL48S8ZL3X2jr6Cco/XaNOelrKdegycGnZMyluviRFWpFoa?=
 =?iso-8859-1?Q?w/nMUqoFfMm6BdE1++KVa7vZKYQvQtpdTmZdUJGH+dGiUPCA2IcXaBnjgR?=
 =?iso-8859-1?Q?tF0eA+ECnzdxjS2gSNLJugD55R3gQsDkJnKkkG3lyFIuJ+qh7ASEUFIWUs?=
 =?iso-8859-1?Q?+wIlhh0U9qC+8iWMYbcBwvLwg4BNZdCiI6Sn/v6xbbIFobXbKNKbTsIKJ3?=
 =?iso-8859-1?Q?HKwQfFVvHvRiY5I3XcpIdJmzUoZNl4SkQJ27oMTn8C5WuoXi21zUAS0E+w?=
 =?iso-8859-1?Q?n6E0eBjfr8Ifwkw2B/HRlvv0FiTiqLZaWWOdYuiYg0T/W+7AO6GY/8Lv9u?=
 =?iso-8859-1?Q?Uqw5gmq8lp4TZrVdpkdwuprKTE2DpF4hwfTdsKHBpC+UXeJEqmDCJoW7U1?=
 =?iso-8859-1?Q?yKRw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ba1a3-5815-4ce7-643f-08dcf426d7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 12:24:44.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2YBmzYf7M/8taTpA7EMdfMIgmwHCDqUSL6ScYz3jG3gdcBJ0aF3s4jSGgdPjZBchj3ttHYnuiZD5jgbUjmm3CWqvqJ3vDxbaIMUDhAneEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF436F94716
X-Proofpoint-GUID: eft8pBaKQN0_8o45fXz4_jEtzOSeuVCy
X-Proofpoint-ORIG-GUID: eft8pBaKQN0_8o45fXz4_jEtzOSeuVCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240102

Hello Andy,=0A=
=0A=
thanks for the patch. I cannot test since I don't have an ACPI system with =
our sensor, but it looks coherent.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
Sent:=A0Wednesday, October 23, 2024 17:17=0A=
To:=A0Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Jonathan Cameron=
 <Jonathan.Cameron@huawei.com>; Marius Cristea <marius.cristea@microchip.co=
m>; Trevor Gamblin <tgamblin@baylibre.com>; Hans de Goede <hdegoede@redhat.=
com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo=
.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0[PATCH v1 03/13] iio: imu: inv_mpu6050: Replace strange way of c=
hecking type of enumeration=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
When device is enumerated via ACPI the respective device node is of=0A=
ACPI device type. Use that to check for ACPI enumeration, rather than=0A=
calling for full match which is O(n) vs. O(1) for the regular check.=0A=
=0A=
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 5 +----=0A=
 1 file changed, 1 insertion(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_acpi.c=0A=
index b15d8c94cc11..373e59f6d91a 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
@@ -104,14 +104,11 @@ static int inv_mpu_process_acpi_config(struct i2c_cli=
ent *client,=0A=
 				 =A0 =A0 =A0 unsigned short *secondary_addr)=0A=
 {=0A=
 	struct acpi_device *adev =3D ACPI_COMPANION(&client->dev);=0A=
-	const struct acpi_device_id *id;=0A=
 	u32 i2c_addr =3D 0;=0A=
 	LIST_HEAD(resources);=0A=
 	int ret;=0A=
 =0A=
-	id =3D acpi_match_device(client->dev.driver->acpi_match_table,=0A=
-			 =A0 =A0 =A0 &client->dev);=0A=
-	if (!id)=0A=
+	if (!is_acpi_device_node(dev_fwnode(&client->dev)))=0A=
 		return -ENODEV;=0A=
 =0A=
 	ret =3D acpi_dev_get_resources(adev, &resources,=0A=
-- =0A=
2.43.0.rc1.1336.g36b5255a03ac=0A=
=0A=


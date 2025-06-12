Return-Path: <linux-iio+bounces-20531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54030AD6BD2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBBB3B0124
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D7223DD6;
	Thu, 12 Jun 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="NmTptmYC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F659222597;
	Thu, 12 Jun 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719335; cv=fail; b=GCvtqZMgGp0/V7g7gckzVKec9qm27xi2vYpc8AcsN3J79mtmX5TD8itqN1fU9c05gdwu73NbgjmktznVKw4P5r5E0eh1FnVm9Lx8/ml7RIwCURZuUDwPotb2Tpx4giBamNCM7Ed4nfLmcE9/bDnAw5pjpvRungRxD2SUpwlr6fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719335; c=relaxed/simple;
	bh=IR8rvFfa5f0PUQ6MUpOKlUmmewgLm1lW3KmR+I9tDXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcttX1XdG+O7UuEod+hv3hj8uUyU2XEu5WVwboCG2b7j8qEbHrRyIVNemg222U8MCJ7dj3gjnuk+AVqwVbmXrcyT1rcqK2dJPQN2SvrqQz1mWG9eatjbHI2vpDRBmy5OLlHCuKZdbZm7YiPAzb4ttKQQpqAyeUkA6rNHNYpGqvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=NmTptmYC; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMugki025136;
	Thu, 12 Jun 2025 09:08:17 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010058.outbound.protection.outlook.com [52.101.169.58])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474bt33w0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:08:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN0u6lxWA72PMp/cXlFJWaIkzClfaMsVatGn0T3bC/QILs6/95FAKWdR4SK5AesqrlPl7vJwcnLCMqE1iERqiGX64uLMga7qMKBpvTSJQ+Ixu0kRO8yJqz3IjV1S7HKKbcmQwwBCC5wc6xV1oOIYSASZSQLFFBhmNyJ/MlJoydvsym4wi21BuCET/2MnGLMLdfJXNgo9s1VqkkqiuXMSh29cU4Cq8mnY12EqDpxPdJB81I1+fOuOJ3ivWBlh5LbKYawDn+U4K97FEEWD2erux7/p4TNd0xq8if0i7jHC+xv0cQM3iKRDb8qdphJkGJFZ7mgzoABheBap80jcab/xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TRGpRYLzhkbIKq/PqnroP9IdTsRxeIX7ramy8iCYAo=;
 b=XngcqwBvGUSEpOUixsXFUNC8JvT7ctAoSlql8fIpmC3Gq0OM2H/lzFwzDV/Nf5YLZCQWSbVyXHw8Ng2edOZNOMyGOAgcNNatyTAsVbswKi4SX2xPBAEARuQDxN3GEyJUmP3ykgGyx1HzaMJwzbrk2mcT0/2dQJWjAeb7dQfZP4vt2M/hUsGvVZWXy23dI1WSPe2JZ28pRtRU4+NORRr026+VNuckmCedGfCwhuIReIXvldxJlup2sBSMsTN85ZvSSsPQrzPynzJucqqg4LAQzorYVkaKdcNL0Njw9xL0e4HS2XZeY7vqRCc6vsvJw+4mW055NNsRUlnZf9S8Yhrt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TRGpRYLzhkbIKq/PqnroP9IdTsRxeIX7ramy8iCYAo=;
 b=NmTptmYCKfYuEhpkEeN53ewiWbeFgeCDTezXHibKDXCQ6x9Q1n/gDfNIH3U3l6qknS4UlzI8Ea5Q3zt0DLBU2pxSOco8JHANdXtCo0AhybfT+A0ywcNS41ZLyNcNJz5LGVMYBtQb8roE5sNHzOtNehsFycRlYP9fi/BxrxsKAtbeVndzxC38Hcp8m+g0fwRgGxsAjzjQDI/txSFom46vDUn6i5OLJn9dOCQch8AW9ST6p6XvnVxN2spdIV1sTT9iVRHyX/NHXeRnVXI02ayJlTC2QDMcabhN0b/21fCkf/hG5sKGAOmmduiYG+5VAsVZf03sAQiklW9qe0qXzlKWrQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1808.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 09:08:12 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 09:08:12 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: chuguangqing <chuguangqing@inspur.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] iio: imu: icm42600: convert to use maple tree
 register cache
Thread-Topic: [PATCH 06/10] iio: imu: icm42600: convert to use maple tree
 register cache
Thread-Index: AQHb2q8fVNoaqj1mv0OBp8tWzs6u/bP/Lnu3
Date: Thu, 12 Jun 2025 09:08:12 +0000
Message-ID:
 <FR3P281MB1757F9B29C7A6A4FD06EFDB5CE74A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250611085838.4761-1-chuguangqing@inspur.com>
 <20250611085838.4761-7-chuguangqing@inspur.com>
In-Reply-To: <20250611085838.4761-7-chuguangqing@inspur.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB1808:EE_
x-ms-office365-filtering-correlation-id: e281bf3b-0e75-4235-7ed0-08dda990a865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H3WJCff9PNn6np+Lx4LRsMmFF1DNw9uCCMXx3gAxS7bC3JEf8CPZV08s1r?=
 =?iso-8859-1?Q?lbI6sadwSnLD020EEhoV1PUjnhlI+IyHl0+Wkl246EokDuxIAYUPF2+ELm?=
 =?iso-8859-1?Q?iYXGiiFMYeZRzvpPzTEZelUjEUS0qjpfFcUSUjh71RPCh/9hcKUK959Wn9?=
 =?iso-8859-1?Q?W05xqVn8IAk7wKyEAGr+/63SlLbxrkrbfQycpGF/ZHfFMcMZQ6biiHxlRP?=
 =?iso-8859-1?Q?akyAZh7bQuChRQzrYDqD/v9AnX89JieQhaHYc8UfGmzNm1JfRfktp7hNsU?=
 =?iso-8859-1?Q?T65wtlwkF+/xI9xuMMPjp3HKVzlcklrFZcdyKG7ge9cPATNe1n0z1UdijH?=
 =?iso-8859-1?Q?Rd1U5NeoW9NZge1bZJpRUYnN+Qxzsg/Z+OoX9xyx21NgR6S2KgrFc29WEq?=
 =?iso-8859-1?Q?HfWO6Be5RQYBIydm3wb5xaD531lDjMVO4Er1iMV7hT3BPtMhkWmVd0U4sC?=
 =?iso-8859-1?Q?ivWBPV40esJHskorJFVi7II/NKYJuR9+H5dXAknPu9j7Fb9+XAamtna0YA?=
 =?iso-8859-1?Q?nT+nsAB2OAbI8jkssYo+Di/XeG73yIQ8gNelruqUzszQ7hyhPFyqmku+xE?=
 =?iso-8859-1?Q?iruosSz6RZtydQkxcjnb1pvi0HhVS3O5mb51LA1IihoH94iOUR/wqGip7L?=
 =?iso-8859-1?Q?gnQGFA+PSRDzrUkkpbLG44YLTkBpwyGhedvFHGzeU71McWbzHpO8qTck3m?=
 =?iso-8859-1?Q?tjiU/UuIVANjEqhOKef51RN9RT3ReOHHdHP17DVwARh9HD8YZhhaUMriNA?=
 =?iso-8859-1?Q?QMTDkRHJJEJ3mL0RgiRTLDFc3Ps7rJ6ZP30rNQHaUwKeFoXWedqVPm3zOd?=
 =?iso-8859-1?Q?iM0M5E9hlUGXvu5O35mIwx75e7cSX141hdjO6PAZmYYW2qo0zMtXiBCfX7?=
 =?iso-8859-1?Q?yaJ7qNOZDMGBTt212Fhr8fSCZvamFOgp6V+A8H6IA8JfVUAQRwO4QdY+4b?=
 =?iso-8859-1?Q?2o3bX2R675eDZnvSjfWH0qKTmC/kBDLFn0Iyvjq2zKZnXV3iuVRiK2fDvj?=
 =?iso-8859-1?Q?vWnv/Uw1/bQb7aRJpc7QefuLfakOl/yl+xtVrYiIDoW0eEfIOS3/6fZwwj?=
 =?iso-8859-1?Q?STaURKVbccL68VFhAsXylwYNRp63y9eQpAzsivTQwq9L5c8hIPAi8KOySd?=
 =?iso-8859-1?Q?KlvycG5gfyxSg4+k7KsFoV09IjGVhmNQz0KG0vKBVzhJbQGGb0iXAfNM0+?=
 =?iso-8859-1?Q?e90KHa4/g6vm226P6sehmdDnWNa1QYh4qA+9cvxPzUSLhsWRxSZI8kxLvU?=
 =?iso-8859-1?Q?CC3QfcYdzN3Cju2CSXkq7BGjzDjqZcqpMEsCogn7jPxBwPnDvKEDffXQz7?=
 =?iso-8859-1?Q?SK9dKxPeCy98x8Cp6S0Zxx3JMoQ5LIGWhVVH0tIFut6YQP93oGBTe2kDyp?=
 =?iso-8859-1?Q?jFY5yXwADuA9QVsfmFMTlQqAlrdIr2lH2R3A+Q6YJE6GI5IfGCN83XgQ+2?=
 =?iso-8859-1?Q?ZZFno9WItKHT9URbaxZ3oN89pNsBUcYPr1hIsG9zZvJH4UkjICdaTziCjQ?=
 =?iso-8859-1?Q?vbklPDiy22LcakXJ/qGM7hBsaqJdYdrEJTNPdGXRa985sq1QuO49XSvvND?=
 =?iso-8859-1?Q?613nUp0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PBMs6lhFKiHfUacSBxc04mMVbSAgeSN6ppw7iU1lEyKvKAWsO3RIkdp2qD?=
 =?iso-8859-1?Q?jO8PVwPqE8W8KKrl0sSOR6xXzNfMCQ/2ja99evotdQtxaD3ClRRts3jL7P?=
 =?iso-8859-1?Q?ZQLvUJ27b2g2x3rENogx5TbBdGiZnBc24JkoNc4imZvi65g2IAHClLE8GX?=
 =?iso-8859-1?Q?L5sM/+cO6hdrgfHiw7lfy04chmMmO3P3j4eWdwi6Mgd6S7ZEEEYsdROI7f?=
 =?iso-8859-1?Q?/ArIqCGNPls87CF18FsJPceaKW4DKKjDUhJO4HdDQIEH43kxLnMGfd23Hw?=
 =?iso-8859-1?Q?TYpFXD6Wcgt1dKjGrrtEOdSxlyYRlJCeluTB6L8zgzbYhvtfvr17HQRrn7?=
 =?iso-8859-1?Q?gkji5EZjFHXJwZ6X6fI1uR7plSLVBkRXByLshhF0DdT/HzdqZ2DxOyrASp?=
 =?iso-8859-1?Q?fswT6aFfAgdpzwSbHiEVEiL/SsVcXK8Y0NYqsY4AT7T2gI1AkSMtdEkUI/?=
 =?iso-8859-1?Q?0eO9Pdj1DII+BiNmRuSorZ/lA9rHhw4pf6fIOco3rti8G68v6xkheTLDzl?=
 =?iso-8859-1?Q?ubLcJKLwPGT+LiTITj5H11U1VnuKrXDNwan2t9zu0wuPEJouSf5lfC6+YV?=
 =?iso-8859-1?Q?SeWGAh4OZCUGFee83gdVSkpPpJFJ6NlYwmBerTuuM8UROIWgtnmEQFC530?=
 =?iso-8859-1?Q?r6n5/bsIympke7VKGeSfCURogtlbsgrUADTN8GyK+PwUbh0QFmCjGrYa6T?=
 =?iso-8859-1?Q?esI/RTQaaimQgM3n+FX3xYp4dFM285WrIv1Ty5zV3lxacJDZf0Ud/O7wAN?=
 =?iso-8859-1?Q?JnfzuSAKgN3EdaXKre8TrESanmfMQBZvO3Ff5lbclj2S/7R2dmP1++5aqf?=
 =?iso-8859-1?Q?3x30Gkw+abHiQ1SV3cfe3GbXmXSIY18T2+Vh9JsR6Xbc8hB3kAsUzCnPGx?=
 =?iso-8859-1?Q?qhdhaHMlQiF+D/45ldcnfJJlUhvpFsmEt5bKl4OIFBDU/pfH0xSad8KJ9v?=
 =?iso-8859-1?Q?EDl9itHsrLgBb7VRi0jE5Jikg58f1T6DaxVS1u1yOwuHNNIGgTWAo8abIs?=
 =?iso-8859-1?Q?bIeXVjC/HaKlbxH5Pl0BeLKwNtuD17s1bBmw+vKvv5pw/fLoFTl2zTUMoO?=
 =?iso-8859-1?Q?J6lZNXT1A4Aot33sGCCYl+TdaPCHFi0kRskX+cqTikU9mynYQw9g8zSmAe?=
 =?iso-8859-1?Q?ORS2cukXRTsOslDVCONDkw5K7k0KHOAjhr6HJzHxCsi6Rd0CmEWBcj71TT?=
 =?iso-8859-1?Q?hMmHxRm8F5lDNj34iA0gP3YoCaHY2KHc+SPYQAF4LvAsRjsUkyQ6e/ZLxh?=
 =?iso-8859-1?Q?qH3eWymg2T5tMc7q1hC6ra3AO9iq4OxqlKAGAcv3PHrL6WCRPBz6U3ACDH?=
 =?iso-8859-1?Q?uSyh8sAI0uu+WL0S2nokhW9SFx+WaYoEVm1yMoviEkuhtdT94JP1dA2kaA?=
 =?iso-8859-1?Q?3h/T6YINegvcPzuGj/GNGrlbWbJTstYozZ79uPGajVuwc8o1EBkKuTbd/N?=
 =?iso-8859-1?Q?OspjckzG4MoorTpfVz7IMGV0AoScQ9FBfgAZ6pIgNJKeNLavqXRwdXZAHf?=
 =?iso-8859-1?Q?RhMNNj5IZj1bUxSdEXs5cjGEOCwv6BQ2ifVTCY9qk7KaVLsAibqTyeipbX?=
 =?iso-8859-1?Q?ZZz12MAdCIr0utlT8lL3wgj7UYpDFcCIb6pr8usaDHWlgTwaMEbeRDGsdu?=
 =?iso-8859-1?Q?Fj58QU5b7EovMK7jpwGuQB0jyDEyBwfbmH4riGMl7tooy5Qt9JIte0Vg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e281bf3b-0e75-4235-7ed0-08dda990a865
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 09:08:12.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4thzR4HO5gdp4fVAPQAO7fhpibQ08p8PABQe31wos7fmuc/ai23k5noXXevxIQRpzkSvmYHycG61KGQIerW8W1hU5wOkJrM8S1LDSHJifsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1808
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA3MCBTYWx0ZWRfX8O0P3g/MkHV+
 OUX430Bv+OIvDx4TY1jdYtwF76RbfQTrvtXjk2rL0eyJ88hRQPMhB8Lrq5+MISYyQ7H/5smMhvY
 Pmv2f5BrFkwG2zIEyDlzK1XG8Yd+dD0CESUH1/QoQN5ah9QhO7kvbdiGI+kluFFE5bZB8VHN0Sm
 yv86ql7mVlZQI+4F8GAa+PrO4zQT+BomodOTlOIbfzmDWFwbyffCvKjnkIll44CdQ4NA0/+W0c6
 d93PAT0Khdx2m0AJetR2aV0gA6pIVnlFH89zruqUrdMoEgtS/A+lHNmH8XRrjpLL3WemECMVRUk
 HLR/piOoFtzrXMNcYHAJFabMMuRVu8DGohBWJm94HtBVRexZHjTMGDNNNmSQWTek4DE4T2rPXZK
 4PydtQUqRW0zKUDm5sZ1qawbLjel5eMAlGM6Vjv9MdtHNgB8ai60xRhkYeJVBFMFLZJ9Oru1
X-Proofpoint-GUID: q4usHTrm92v6Ev_8tRmf0wNWrJyVtTG2
X-Authority-Analysis: v=2.4 cv=Fas3xI+6 c=1 sm=1 tr=0 ts=684a9901 cx=c_pps
 a=VdJcGZ1pK9xtMcdC1Pd9qA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=In8RU02eAAAA:8 a=F_93P0QhAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=GHniDeYSnIcxJVJicDYA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=v2fne3mUlQEKA94IZ0Od:22
X-Proofpoint-ORIG-GUID: q4usHTrm92v6Ev_8tRmf0wNWrJyVtTG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120070

Hello,=0A=
=0A=
no problem for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0chuguangqing <chuguangqing@inspur.com>=0A=
Sent:=A0Wednesday, June 11, 2025 10:58=0A=
To:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo=
.de>; Michael Hennerich <Michael.Hennerich@analog.com>; Jean-Baptiste Maney=
rol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>; chuguangqing <chuguangqing@i=
nspur.com>=0A=
Subject:=A0[PATCH 06/10] iio: imu: icm42600: convert to use maple tree regi=
ster cache=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
The maple tree register cache is based on a much more modern data structure=
=0A=
than the rbtree cache and makes optimisation choices which are probably=0A=
more appropriate for modern systems than those made by the rbtree cache.=0A=
=0A=
Signed-off-by: chuguangqing <chuguangqing@inspur.com>=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index 63d46619ebfa..1fc4fddc2029 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -83,7 +83,7 @@ const struct regmap_config inv_icm42600_regmap_config =3D=
 {=0A=
 	.num_ranges =3D ARRAY_SIZE(inv_icm42600_regmap_ranges),=0A=
 	.volatile_table =3D inv_icm42600_regmap_volatile_accesses,=0A=
 	.rd_noinc_table =3D inv_icm42600_regmap_rd_noinc_accesses,=0A=
-	.cache_type =3D REGCACHE_RBTREE,=0A=
+	.cache_type =3D REGCACHE_MAPLE,=0A=
 };=0A=
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, "IIO_ICM42600");=0A=
 =0A=
@@ -97,7 +97,7 @@ const struct regmap_config inv_icm42600_spi_regmap_config=
 =3D {=0A=
 	.num_ranges =3D ARRAY_SIZE(inv_icm42600_regmap_ranges),=0A=
 	.volatile_table =3D inv_icm42600_regmap_volatile_accesses,=0A=
 	.rd_noinc_table =3D inv_icm42600_regmap_rd_noinc_accesses,=0A=
-	.cache_type =3D REGCACHE_RBTREE,=0A=
+	.cache_type =3D REGCACHE_MAPLE,=0A=
 	.use_single_write =3D true,=0A=
 };=0A=
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");=0A=
-- =0A=
2.31.1=0A=
=0A=


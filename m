Return-Path: <linux-iio+bounces-19052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E0AA8825
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE13618951DB
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A98E1DCB09;
	Sun,  4 May 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Iu09YYWY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956C156F45;
	Sun,  4 May 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377217; cv=fail; b=JLPti203VEEZYM3z28kwGxTwV3pTG1153o+xAd9nFPBQsWCRFK68pt8/5U+a/qK2YXy3eiwFYLXMK3h62VG2hwB7FlD1iNXE8zutSYv4XWc/SMq1X9CQrA/e3WPJWNctukhiRAtaMFstvdCzxasoAXMPbOFZqnb0teYt7GIixl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377217; c=relaxed/simple;
	bh=n2L1fzAn5vpCUAH3Cdp6TXGMxxwos29/CkVySztY4bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llf/oPQHehCpOELynfIiBv+gd00XbAHF/N4YAhtiytdQ1Cq/a5YAXG83r6IOcm4SWDbqcKScN1lhHV9gSyqg8+jp3rpm7E+00/PbZvPOAbSxrhLSdDClT62VnEhC86O1IkN2VQD/QWrJi2cpXznSz7+tZlD86Y9tV488M6ngqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Iu09YYWY; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544Gk7mi023283;
	Sun, 4 May 2025 16:46:07 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazlp17010003.outbound.protection.outlook.com [40.93.78.3])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 46dcgk0g41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 16:46:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqRfNxY9FtTQvCE4UyIK4LBKrHN27diGKcky09pECsk7ngsZbYqYLuHRadRsoWfPAlClPe9iFqoDbaWq1NcOmclzQ/bAr1Z/eBtkbp+jCf9KzYSjHivovS0WKowoQ8iR5dbgmb/4ejkD5S5Ql9ipBVAUwB3Ti5id6KfE2N7jdjP0K6idT7Pn5MmPlpOQ5n7PEddit4nnVnaiOmm6wcZJ2ZpDpGl8AkN21ol8YtoUjuSXlj8I6p1NUsiLOlrfSQv5o8PzKix5Z1uBz5z9msRVra5+KFnEpSmjZanHnpP6rxZ4H6tP0SM9Gyv8sbLS8z22j6lpwSBzbxSUPGsUSoHDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMsHNbTiBfzWeso1C5hB6JxduAd28exAE+wU+QZhs4k=;
 b=NOpY1phhyixgkpzsGvyP3PV8VdEiXIOdMqZrjMZPYNERBciLT9Q3Wae6eY6WrPFcnhaoQlDAj2DOA6ka3AfgvAXDtjEP/CoJqhWh35IwtYooRxAC9fK8sFpuEPn8CATgygNlz+PZWp4qDvkaB/VLmlPe5u/58ox9be53OlWp2uLRePd/0yKufhClwP01gCjNl919vZ5uWKbIlckJmM+I5c0QymT+tzEFj+7PBc8X4ap9DzVZ3Y2a/eK9d+RDhSEjNV+BJMzvRmMalkUtwz+t9ON4+8obA5qid3bgtoyoJvNRjuOP9aMJyrbnC5RS/vV751PqIv25AR0c/aVKfzUO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMsHNbTiBfzWeso1C5hB6JxduAd28exAE+wU+QZhs4k=;
 b=Iu09YYWYM6KZNpSRDhoW+LBS7orxE4QEZ9X0yJ7L93QmJ5/ofnw7K1B8BLg6qawbwEOGf4c1GhyxhKLNUKG8cr9ph53zZYfBnZGxJhaW5jhbLAVj7kOJolHB9UUzBnPjRr100dGwfTu19VmpJj6cKgiQrektFuUiFatT0ny0IAexGFDLZg6dpOCAkHiYD6BtHE9zQYXqtgoPnTr4bQxJY5aSfXsh3B3Bs3pE3PSnzcLizUJN9yRRVukxHDRmc+lZECz0tEIDkqmkzhn8gfUODRozFK39dtCULzjr+KFLgAOWGfYJCPtIqYH/bSQjhiVg2M8MJoLuQ47adeEzYcB78A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE2P281MB4868.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 16:46:00 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 16:46:00 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, Sean Nyekjaer <sean@geanix.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation
Thread-Topic: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation
Thread-Index: AQHbu0XeA0kSomfPdkq3x4vcKPq9K7PCm+GAgAAUcAU=
Date: Sun, 4 May 2025 16:46:00 +0000
Message-ID:
 <FR3P281MB175785C1AA53950D27EE3C03CE8F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250502-imu-v1-1-129b8391a4e3@geanix.com>
 <20250504162841.3a3cfe8a@jic23-huawei>
In-Reply-To: <20250504162841.3a3cfe8a@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE2P281MB4868:EE_
x-ms-office365-filtering-correlation-id: ffc35376-9b5d-4065-211d-08dd8b2b2672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WY61aRaSYJiRanYgbCVpMiaKZz5aDUiZGnZjNrXKiZJq5fN/aM3Su10oGq?=
 =?iso-8859-1?Q?hRnYy3x9FgI+SBnU5iWJUx90xTWJg376XlK/JMhpsulfV4A2kP6BbGYXnD?=
 =?iso-8859-1?Q?CKtoGRhHp6D6hGa15oUgaebqg1rL78FsUPgd/KZJ6q1HpB6xmhrms2kiM6?=
 =?iso-8859-1?Q?3wCzPyW43JAMIxUMa3khM8YgA91LRO2z/2gVxqtLIYANsqlz2V4jpMW/Pe?=
 =?iso-8859-1?Q?+iiVB5I+UYfvGloQMGVgoMWQaLmnojwB5z+KxAUzHUDs3XetLS0dkFNoam?=
 =?iso-8859-1?Q?h+XhxeVAK/SQtHI9O/SzSeVdNlIttK6BS5iz+B9GgZevJU29Tua0FKH+KM?=
 =?iso-8859-1?Q?cZyvla/aDFUVJLuQnxvq3dzBK/HZRGXz7kvPtm5TyJFbiXLJ1rkO8Lj+4k?=
 =?iso-8859-1?Q?wmSdJGew0vOcVooQAxIzPmn4BHE2mreUicjdW27jk7VwqlcYpX/aVmHork?=
 =?iso-8859-1?Q?53GEhbM4AQMn52oF037eUujo+tMHrYLDY+R1tKjiaxeKP6cAQNpke62pQw?=
 =?iso-8859-1?Q?cxEegG+69hcXcdL7H0kpcYII+x+L2fFKY4mkagwnYSA+qg+RooMIDxatTl?=
 =?iso-8859-1?Q?kBaj99Zfj7PX9IYy1NJzfOodmBeJvyIYp5Mz7naJ5WWy+ha8kD14ljnPin?=
 =?iso-8859-1?Q?qGY/JCc/uRYLvSorYztQqdSup4HDe2yfYOFI8znSSRvswYJ6lwVp+JMStz?=
 =?iso-8859-1?Q?DJoGY9OvyT94vuttCzS7mt7YEz+gcV246zV7nw3AZnjl+0w7UD/Z07VoaE?=
 =?iso-8859-1?Q?QIFTVIMXPnCkYNPAkRX/V79UYciVH8liUX8gPMuO2gdAI4l23AEB/2Kh05?=
 =?iso-8859-1?Q?jn8PI/LL/ttVSjEKRcB42qERwSvHIwAeQnSyCpDnJRMFVpU+Ld4v7de3xB?=
 =?iso-8859-1?Q?i8hOUShkFAQGOnsrQgwkxnpnTQiVuuYf7jQ5em38C1j54j4JwXhkKaIusc?=
 =?iso-8859-1?Q?HYCmfaQA9WmopGIHJUTMopMM41SkHX9nv+wzS4D2baCpFdle0szHc6drNi?=
 =?iso-8859-1?Q?Yj0I8yWLK0xgZ4YSqiAB68t2bSBBHF9cH9FbhSf/3V/mX81sLx3oKXatfH?=
 =?iso-8859-1?Q?ilJb8C1VVqug09/ANzw6N9LY4nGVrrNT5VHCckS2/kF8+K7Z/JH26SQnB2?=
 =?iso-8859-1?Q?3dmMb0+RXIovcF2lRfVjxna02CmOuZWSe4YKzZN2jfoejRmGMFZlznfgS2?=
 =?iso-8859-1?Q?DGLd1OAxQUR/iuaI3alYOpO1u3EFLKCxFOiqT5JN/FgDxxR9GcTmIr8T/D?=
 =?iso-8859-1?Q?Z+/cmZGEke6WNDuua1EYuvj3mjpkVRF8P8IXi4CqTX7f88wNAHuW3PbEOp?=
 =?iso-8859-1?Q?hTWgx+hyB48L5+hTceJ9gJRcBlnJ04ZIIS5ytsKz4jhEu9Ob1cFlAHFRsZ?=
 =?iso-8859-1?Q?QgnE9ezrzHq6UnH3Er3kb2vxzS1NFkjIe4W4Fio/UfftZhXfprnE9d3pBf?=
 =?iso-8859-1?Q?PKLxWKfXUnNKY5kB8OsxqypEOC+mNtOVOcKUYQQIsGbwNWXaI5nsIliLui?=
 =?iso-8859-1?Q?Lk8e4WuORDdwwBBK5sG1nvjNS7gFyVdAr4Jc14ulbzIPdenlqdm+XyouSN?=
 =?iso-8859-1?Q?FHWq0EY6Tfxa23AW3tGzP6eG1bLq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fucv5j7VAuR/NR/6ngneYqqIggFOh4nD7BOPArsOrLCSnf4UZQXjjfRYVP?=
 =?iso-8859-1?Q?yQSqEMiPwQZQwKULdj3jT+j9CmMYbHX8akSHzxpEUl+g52p4w6oMFCUId3?=
 =?iso-8859-1?Q?ma/ERPmC+YHZmZNHiIQQ0yfEUJEN3zM812zF4QGct8sBx4AmtLnGtBuYgJ?=
 =?iso-8859-1?Q?becjlWOtgvmAjkvK0mjabDtPshwbg8VLll+d8UvLhE4CB/4LnCNLDpzGrP?=
 =?iso-8859-1?Q?K6ZuDVYuUvafT8uyXhX19KhZlzIcQmQOhJBUz1WjQotE8YjrRZkXmOsu2s?=
 =?iso-8859-1?Q?DtoBGZbILMIpHBIHUBm4vdcs6QA0Cien8kbMH8O/JPuJsnBMMNG1mVCmQl?=
 =?iso-8859-1?Q?q9x5lXG24TZmy2pXTlulLvFSnIPYCvsZ+7tTRdP633xf9OZCCT8cihxV2B?=
 =?iso-8859-1?Q?/7Y+Bf/3P/JGCxNV7JkgWPVqsEhD/+K8HHtRvLCRq1l1V58/uhcK7B3M2p?=
 =?iso-8859-1?Q?xHrD9WgEzgnLp//AT3w/tpHAucd98+zxF+mHAa2Zv8S5O3mYJLnu0aSI+l?=
 =?iso-8859-1?Q?nLw6L/07K8+67bEGrT02x1CcwqFTPZWb+UT9F2gMyECbBxGeQ6hNpVJA7z?=
 =?iso-8859-1?Q?/kL/ll9Bx+ziep5tUM+sfFiJGKdX4+VrQJVGMuALsBqFZlrBiCoJKlSGow?=
 =?iso-8859-1?Q?AdU+DIcZDjfgi629BSmybBQl4b1PbTacWyGyGxDOEbUdnUoS2Vy431Gc2a?=
 =?iso-8859-1?Q?sz1JFNvQeDiHK4vH5NGIXI5W5b6aXSgm306XKa6Q9B9YBznYie7tj1q8py?=
 =?iso-8859-1?Q?rPZIAO1aRankQ+G/i6zPuz3Z/HkFTSRPyEZvVgmvM2jsHKoOqcryi/1Ihj?=
 =?iso-8859-1?Q?//s/PueONZVN5sSYy/rqnTTf8BeCZL1c878WcMVhDEIHS2IUZsHDoOK6wH?=
 =?iso-8859-1?Q?v1VGxA+E8SzgB2Bl32cIkPK2usYiy4FsiZG4M4pOa7CljuvoNVrg/UaP0g?=
 =?iso-8859-1?Q?peMMp2xKhZCsM7p/Uwe1zMObgkwq4UYlFTEhk22DhKwpywTnD2m8T96mWg?=
 =?iso-8859-1?Q?ihdwKqoc+kkFkFEc0X7lgcSW+T9looNbY7seGAYPJvOFIZeL9hcYxF0++5?=
 =?iso-8859-1?Q?nreANrCi42ZGvt19gERhJd79lhUvD6nimZDbFB3JqXw+jFV/1ItunpmTVT?=
 =?iso-8859-1?Q?m15HAiiFN5GBGn3h4xBTbWcnQlyjwRHVyO0gwMSn44LP1zGZ64dOw6tWvH?=
 =?iso-8859-1?Q?I3cJUht/yfFnvCBxdrnntxg6oDJPXE2a36Q5wZwSGaEtHlHEwRmoWsJELT?=
 =?iso-8859-1?Q?LlD5d7MrHnP51EXmtSU/8waNQSSDyLtO3Z9x/L3ULMntwCptkIO2W24Rce?=
 =?iso-8859-1?Q?5f53HRuA9zpsaUak+kdn+BMWZYoKL5UJt/SWslX/EWdt7A6QPzNBGh4vvb?=
 =?iso-8859-1?Q?VstQT+HTuS4qrX/CClQU1t2cWmQgWVzttWsZaQCCyuq7lQ8PQo2XOAtFxN?=
 =?iso-8859-1?Q?2oLfXUAIJuQlH0hlAaSNYiOJs05WDIVzLZKLFOTuiRzxWmJNO5qMACoHdb?=
 =?iso-8859-1?Q?8AJT/Dl4tJeMNDpUMP7GrQ2AK7le7NBCJ13Z0EZvZKiWttLM0U3Z0NX5Al?=
 =?iso-8859-1?Q?7eoOOJusThMjmw5j1cGLYpyUqWkHKxf10CNGst8AHgWjh3bV8YjcAZUEwX?=
 =?iso-8859-1?Q?Wij823A5yLlvzmdDS0C5QimFaXodAilL0RTBOUak4qkDgrjwQ/2M13De3H?=
 =?iso-8859-1?Q?+UMEHMIKUCnxUjhlTeMPheU4wD50UspxgLTx3PramY5GorzJrBcaEdf41D?=
 =?iso-8859-1?Q?gyBQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc35376-9b5d-4065-211d-08dd8b2b2672
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2025 16:46:00.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfpXJO2vHK+YGI9srLWWr1yleCI7/CzBMSHcN2ecCwmhS5Z4GhiNoGiRLB5BFM5EEBtWiJCdBgEOy0CrqoxiK5TkHzddIY66fSwV2hwgQ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE2P281MB4868
X-Proofpoint-ORIG-GUID: zaI99RV4LE8Pq0DSzWpWt4eYZ12wML7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDE1NyBTYWx0ZWRfX0D8VCjvF54gA
 CtHpjI4f4bQSh9NDc8+QDnHD/XshLjzFRwcP/7u1GMFEmd7wYO3H+4Kc9ZuI+ZNHYVRp1h/m1aN
 rUtNcrvNhhr9YmgsOlv35LejrJBryp5P+2Cdx8U7ViACPLhjmqukiyRy5XN9bHpbVm7HDY9fY/q
 szgJszdS7DP+8WS5uNtUaRYrWI1OffbBe1j4Zu9GYFXVRgivxi0BT1mzHnKKi5a3TCwcwzEJxLn
 1/WvgPIXQ87gHdJlecv4nSgYly5m/lAn398EYCmEzNVa/JHDzF8Y1NgAdeRvsoNJL+0D4AOUuJ+
 0RZHgjQ2Ah0Ofc6F7fhOznQBkm+4pMnrh+yPjw+RTvXrj3WaBcR8sgJv7WRW6owaLJk9wajOXbW
 tMO8S2x0oHqKR1u2rOperqA1AdOBhS8yvQDR9qc+T+uqA0MtnHj/4d4kHJzGPnTKqrH/U5Az
X-Authority-Analysis: v=2.4 cv=SLNCVPvH c=1 sm=1 tr=0 ts=681799ce cx=c_pps
 a=whECMvWgP56c33A+GJ2ePQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=Uwzcpa5oeQwA:10
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=ilKATfAMAAAA:8 a=i0EeH86SAAAA:8
 a=GHniDeYSnIcxJVJicDYA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=73awMTU50e6eLoBjGbzZ:22
X-Proofpoint-GUID: zaI99RV4LE8Pq0DSzWpWt4eYZ12wML7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1011 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505040157

Hello Sean, Jonathan,=0A=
=0A=
good catch indeed!=0A=
This is all good for me, thanks for your fix.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, May 4, 2025 17:28=0A=
To:=A0Sean Nyekjaer <sean@geanix.com>=0A=
Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter C=
lausen <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@td=
k.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; linux-iio@vger.kern=
el.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-ker=
nel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: Fix temperature calculation=
=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Fri, 02 May 2025 11:37:26 +0200=0A=
Sean Nyekjaer <sean@geanix.com> wrote:=0A=
=0A=
> From the documentation:=0A=
> "offset to be added to <type>[Y]_raw prior toscaling by <type>[Y]_scale"=
=0A=
> Offset should be applied before multiplying scale, so divide offset by=0A=
> scale to make this correct.=0A=
> =0A=
> Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor supp=
ort")=0A=
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>=0A=
Looks correct to me.  Given this is going to have impacts on userspace=0A=
I'd definitely like to know Jean-Baptiste has seen it though before I apply=
.=0A=
So, Jean-Baptiste please take a look!=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 8 +++++---=0A=
>  1 file changed, 5 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_temp.c=0A=
> index 213cce1c31110e669e7191c8b42c9524c0d3e5db..91f0f381082bda3dbb95dfe1a=
38adcdc4eaf5419 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
> @@ -67,16 +67,18 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_=
dev,=0A=
>  		return IIO_VAL_INT;=0A=
>  	/*=0A=
>  	 * T=B0C =3D (temp / 132.48) + 25=0A=
> -	 * Tm=B0C =3D 1000 * ((temp * 100 / 13248) + 25)=0A=
> +	 * Tm=B0C =3D 1000 * ((temp / 132.48) + 25)=0A=
> +	 * Tm=B0C =3D 7.548309 * temp + 25000=0A=
> +	 * Tm=B0C =3D (temp + 3312) * 7.548309=0A=
>  	 * scale: 100000 / 13248 ~=3D 7.548309=0A=
> -	 * offset: 25000=0A=
> +	 * offset: 3312=0A=
>  	 */=0A=
>  	case IIO_CHAN_INFO_SCALE:=0A=
>  		*val =3D 7;=0A=
>  		*val2 =3D 548309;=0A=
>  		return IIO_VAL_INT_PLUS_MICRO;=0A=
>  	case IIO_CHAN_INFO_OFFSET:=0A=
> -		*val =3D 25000;=0A=
> +		*val =3D 3312;=0A=
>  		return IIO_VAL_INT;=0A=
>  	default:=0A=
>  		return -EINVAL;=0A=
> =0A=
> ---=0A=
> base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef=0A=
> change-id: 20250502-imu-edc0faa6dae9=0A=
> =0A=
> Best regards,=0A=
=0A=


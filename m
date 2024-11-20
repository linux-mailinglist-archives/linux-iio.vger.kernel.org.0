Return-Path: <linux-iio+bounces-12420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5A9D399F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8D1F22179
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B019F41C;
	Wed, 20 Nov 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="hXjoIDJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E71865E1;
	Wed, 20 Nov 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102854; cv=fail; b=ZVIvNCq1rTLMTrmygGjw9Pad+RtUdDaeRVrTN4nHUBgYNd28xN3JQgwEjosla1hrFb3Hzg4lSs/7TIkvM60dTG6ikHGQLsHoq7m6At4wlCt+8Rg45WVv2xzZ2iZPlwpa+9s9iOVAfgyLf8fglIxQJ3QOUN8Fz5uZ7aK0bpyZrkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102854; c=relaxed/simple;
	bh=oc4D+1mArc1ov/ib121qkJi4ZM1wLUgquwq3NLA/qxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1WLVlDj4VT8cO4rD4gvyDrcHo2SbuQhKXheNPLFUgHb7II7lFQ8PILcfK94xHXcPNdqjeFBYjmBtiqVu8mac8i6TLoCPRxRHZNT1EAHSOL4movwZogm55+fIShnqUoJOW8/rMqoh7VANjQ/+QiIBrY7tqjJHGcVhdE7SMkdfpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=hXjoIDJD; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMiYdO024437;
	Wed, 20 Nov 2024 11:05:31 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010007.outbound.protection.outlook.com [40.93.77.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 42xmrhk13y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 11:05:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF6NKdLIcgYjYCI/dnikmxErE2nDx9SNPsuX+8dVq2XjKzQ73b7ECzK+TmdUMZ6u0au6ychLhLKaM3IS9D+vbli+ZHbvYcknuZ5CwNpmv5JopdTMozCZP5/TAeKSXzYGLt/UntZ6O+4pitAfvaNpX+gI+bHMGCRJIk3b0NbJNerQjSIC02dHToMVKuiq3/frZR4Ge0wZpcborjD9Qbp2wl85+Fh10FQohtEx+dhRzHFPma/D1P68tveduHv7s0bCzvBJUhvIG7gmvedgtCkZ9loHJqll9469e6QYE77EzveV+D2GIHj44nuVGGf+4X9N53LR28FCvpU5Kz0KFzgdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgrX+WjBP7HHnWDGMKd8KOHgoxNnBzTxF5o6wJW53sw=;
 b=FQtDSFq4BTmo+xIbYqwGK12ILvIIdElu1NRnokV30DXMdwj4kcXTSVwWf7AeEmBO8N0B+uEVXicIJM+g617kCjjlJdxy/1lkWeJUCAeg8xA3+zLcjWNVEGT5sxmith1isql4qH/aOCHs4ayV3LOIddVKLBLkBbSND+hnBkYei8+YMgSB8/i19EerIDIHhfZt+YQrSN5YgfLTJjQS2ZCbmyNwGvyWcP+9ULpRikIpcFcJZxGj6kbOiQxsadFN6TLSaoUfxHJtfiDhvC/7F+RuHPav8WdRL0Q2pYPHrMz/e+sse+3CsGXunDcHL2VlkpbGPupWWtsRrM43WUw4dViBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgrX+WjBP7HHnWDGMKd8KOHgoxNnBzTxF5o6wJW53sw=;
 b=hXjoIDJDOCZTTG5GAso8gPu1VV+H+J+LelQbjE0ECNyVJ5KVYPsZH+jf/wMiW/OfoMh088FKVm6aSBzpbiT2UEOgG3FmAR7aV+AdAeHeGpKXjEC+UTdmaWXw9BTeFCkQWJT8bXoVrpBQV+MGLxrJC4ljWi4S7Q3aSL+Siot8w/jgdr66PVQKaf2C84kb9prXIAahwTFrPuCtVavI6KUQAWbGsgAaWNEGF6NfbqKlQ4U+UalU2+gv+byKE0DidfPbTUHAgLhvk83Zcb/p+VaW7/kJ3aggum+cRS0knz0Q2Q5TiW2hF//Aph0eyMqr9XtuTqqD9ItMLBDNp0QBNYLsgw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR1PPFEEB7CA9F9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::fa7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 11:05:23 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 11:05:23 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Han Xu
	<han.xu@nxp.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Topic: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Index: AQHbN68NJchVZONPZkS3XOqNFkRQZ7LABxmH
Date: Wed, 20 Nov 2024 11:05:23 +0000
Message-ID:
 <FR3P281MB17572DAAB3B3145EE7AD56E6CE212@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
 <20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
In-Reply-To: <20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR1PPFEEB7CA9F9:EE_
x-ms-office365-filtering-correlation-id: d6534ac2-5073-40a5-8edc-08dd09533af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Z45V5sl2n2FzMMXlM/UgyWwaOH7+eCY/O4D4t0qrwi94+Hgqg9UgV8uIdo?=
 =?iso-8859-1?Q?h/x8yyWPnEDtphrVa17xuwGPlq+dFX4w/soonEdLP5/7M+vfUcvYFxQwxD?=
 =?iso-8859-1?Q?Dg9ZILGo4NCazFNUHMnL8FH4fywh87ZURdUuRz/WQMai9RhmYwW8D3vqKA?=
 =?iso-8859-1?Q?5aHuRTBRXObKKxJXYDkQOXZsNMmhwQjpMMdOk5GFxDrdfyBvqXh4m7xB2l?=
 =?iso-8859-1?Q?KNRebMb/jxHaFCbtQBnhRqjt3ML9lCntJ6VDHqbufVpIvvcQt4hRnYzLd8?=
 =?iso-8859-1?Q?lUxq+0LhiyFFmhWvZUFD+ajOpxPvROYZ7iagBpab82yiauN2Igm5sE1kXa?=
 =?iso-8859-1?Q?2Jsm0+L7vp3zgNBkcqXS1TQ58cp6SYN1LY4jK1SXV/vXl397FhSQvXBRVq?=
 =?iso-8859-1?Q?TE/Tzc3euT80l4BHeXAliwgGnKLkxJLRQWsyCcMfWfIDK1212XvtgdXte7?=
 =?iso-8859-1?Q?7htWZR5s+OTHievpJnzz1fo4c6w4I0M1nOpPwzocch0EfOsP/4UuuHdSMG?=
 =?iso-8859-1?Q?l0FGZ77dfMfkXdob75PtvyQTRrx77HDgvwPdCf0//0KKxcxAS0lmZwRwT9?=
 =?iso-8859-1?Q?nQKRoSMtaT0XyP9SFO/fVBeTPecS508C5KPLa5Umc418VOfhCB6Xr/dCiI?=
 =?iso-8859-1?Q?XGVugQ2EDSJGcLR1tIFCbQH8f7AQH08EaxqZQFDDYqUWRYUTLUigGj9wdw?=
 =?iso-8859-1?Q?fc2zls+6dAlqu2x+ilzEx05VDqPSSZ01rddW4uedrshWVkVHYfdIE+XELh?=
 =?iso-8859-1?Q?mKLTkbyw5XIXvFlMlBvU0oAg0LltOIxOfe7+p+CUmtTyb0x+viUB1i9GZC?=
 =?iso-8859-1?Q?n53ON3iG8Rad8cP/8nY8kx4DxGME+p7WWNfqfmLPbpH279x/Uh+ZB8ZuIy?=
 =?iso-8859-1?Q?bSZFafjJ5X2+dgMf40FR0jNaRB8XaT1HXnWuTFj4vV1wAPkI8zWvWurhpl?=
 =?iso-8859-1?Q?jF60I0QKUvwpuUh5kgQ8R4GMjA5il3v+MOvn27aEs1FG9bgXnzwNzrrUUi?=
 =?iso-8859-1?Q?fA7k3ev6SilfeicRTK8ua0Ou9XaVWdueSoVmqNpss1o0dM9GJPZPIR5stb?=
 =?iso-8859-1?Q?cUWOGbSuIRbr3YLdORc+KUQjA6byUJ0ojO+pqO+hxbf4+ooGGx/1axomql?=
 =?iso-8859-1?Q?dPAlWTDVWPPWAfuglsiyzs+NX8P8uK32FJBPNpp9da5V8buXhzEubjU+qa?=
 =?iso-8859-1?Q?DOFJl8ZtLlGvIjvgoTURg8yFid8yiysDDiKrz6Nu5mlB4unesg+B2w8Fa6?=
 =?iso-8859-1?Q?oWHrq6zhhIDbILCK1oO7HOuykXEVuEP4JKRl0bLBtRcI6Z/BmkXLyCUTTF?=
 =?iso-8859-1?Q?9UFa7HZp9M6vdZIv4JXzmJvS5t9dymZ2bttsJUpWb+yvxOdcqtVu9IxqCQ?=
 =?iso-8859-1?Q?FHwZQZgWWmCH3yP+UiWo+PlIWbpErQBVV3IFP5LfEMH6S4QEI5UuY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZvFzYRT2rI1jRF5i5b+kgBsJoURKaHVpA6/BJAaI/ALdAhEXthH5UJMDHU?=
 =?iso-8859-1?Q?RwWSlEiB+C/s0DYYp9X0A9VWnThJ7E8eb2lHuxU5RpNlH9OCbf0ITheQ7C?=
 =?iso-8859-1?Q?vpouIJRBEFPRykPWINNiV7k2zFAfDkWJ3gm7+dF79JAHrzn/Fd7xaU4a+o?=
 =?iso-8859-1?Q?oIYu0Yy/8LZdS2SvWOrfNrd9xJqYxFHRa3ypoVD4hnrTvIvmU+oruwvQ87?=
 =?iso-8859-1?Q?2SLNZDEJXVISKUHnI8OTtLr5lQjkuVS15V3CL0Mr35iRexXN0nl+Q5RPo4?=
 =?iso-8859-1?Q?ZxoOeWP1Co0X/nTHlvk4w2jTyuoFNYPsl4l7pSzmFpghYBMV7Sam+wqNfC?=
 =?iso-8859-1?Q?6Ge7Zv3jeM6Pbq3j1IQtdgLi8pM7Qmg3Nd+iEJIuO8IKJi/5wLBv29V/Yi?=
 =?iso-8859-1?Q?XGnxugempN0wZRnF+7VDn5NcjuWmFucA55TlMkp+M1RnRuUppahPb7hUTr?=
 =?iso-8859-1?Q?kmZG/Zf3l3orVZKfqNZSgTfx4Eo5nHJ/04jP4TS9Otp/yehqx8iKHjkoSw?=
 =?iso-8859-1?Q?KOiJuY0aCyolrtHDW/S7g9IFjqJYi8c5FYT1rWyGG4pBb08wFh8igMXHMU?=
 =?iso-8859-1?Q?/iPVGtJtjrIMZNs8GEfAxJJh3gzONm40//NFLnvgXFa8iwEfjx23WHcliI?=
 =?iso-8859-1?Q?6TEP3KgipjZeFUCg2GPWxURimDNjI9iTZzgrEvyUlmGOC4KBrBgFdh5ByX?=
 =?iso-8859-1?Q?DzV2CujQ1bSXarxVFrBO3+YlumhBMcgpW89sWZdvfvy7dM2Q2kcLSRogoY?=
 =?iso-8859-1?Q?hVotFfBiFDsAEo8eHxNeq7ueOQSXNEVZHhPG1chFP+i0XdvY21i2OGqw0G?=
 =?iso-8859-1?Q?r6fANYfUSWWRmjuZKAMo3OK1Lyj0E/NEfSRh6ESsUI1Xjf3bAJFxT0Ut27?=
 =?iso-8859-1?Q?I+UKKpuLxMFjXkIwdzgWPN8mw3/lW190h32fyn7IxBUCtv+lva7SI/MeFm?=
 =?iso-8859-1?Q?WJ4qQDRV7PSLzQ2pWSBgGKgnGniSA8gNgajO/NKLbJ+8rk2An+90URjSKG?=
 =?iso-8859-1?Q?uEWPg8+wvSWkhQGOVMIZe5ui0k1Wm6Xdz8kVf+iPKePnlqS6D01b+qFDp1?=
 =?iso-8859-1?Q?mvbsqvPrS1C19KMYezfj2uf90548MOJbQMB28Qd2HG0+XQRm1x6HF3JmiU?=
 =?iso-8859-1?Q?i1YycJaxjW4ksG9q81RefaFhxuW8fGblGmB42mPyOfVg6xz728AfrNGWTQ?=
 =?iso-8859-1?Q?CIsbinSDQNlGJUnt4MvUFytHybXETurVHJNVia+fnoDxjQhe0ttfIy8Ylt?=
 =?iso-8859-1?Q?aB+CvrNz6yqTGEM5xbUE83ZvqMD5xaC5ltYT2Mzg9tCF+wguBmay0u4YVB?=
 =?iso-8859-1?Q?j8AKLiQq2vSr4gP/kZRS6yrwrDrNJJZLeMK56pxmjGB0FuLEV7j8jAU70q?=
 =?iso-8859-1?Q?rXKr0K8cejzGv7SmTgtslv3IRn8mSXjppb0jAntPxoOzAHwEPGbdB4+fFH?=
 =?iso-8859-1?Q?VtDxIeAYogm+LxAi4/10a0p38rCJNG2SS5PTBOwWJPe67nZv+f0tv3LGPG?=
 =?iso-8859-1?Q?FA5pFQdd2XCJeNaqEtqZG4ouVwNSmcJs3BEassUMnnikY+IU5QcYerLyGZ?=
 =?iso-8859-1?Q?pfaa5Osi22+uMP7gtZukqcjXL85BXXA/E0gc81lvBnYJeAKQBnK6MxGD5y?=
 =?iso-8859-1?Q?69r2iPq/X15u3TwqvOMpBNnreEmDGyIEUagGxSYymBZMaF3rxo5cVklhIl?=
 =?iso-8859-1?Q?akq4qdIVsxIQCXLxKpKY96Vbh+MiNIqqx/td9HRQpQg0v8Mke56N6J/LlT?=
 =?iso-8859-1?Q?lzRw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6534ac2-5073-40a5-8edc-08dd09533af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 11:05:23.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtGBEjelmJISbJPqgAzPukO7ujE5rwD3CxaYpKSGftJnhlzru7dyBlMDQLiVl0o+avx/DvRl2LIXJk3u0jR/GCwxNAi3vDX0fc55rHsIO4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPFEEB7CA9F9
X-Proofpoint-GUID: O4J6h3ppLI_MhCLY24wlKV9GP8rVaokd
X-Proofpoint-ORIG-GUID: O4J6h3ppLI_MhCLY24wlKV9GP8rVaokd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200077

Hello,=0A=
=0A=
overall looks good, but I've got one concern.=0A=
=0A=
The gyro bits used for scan mask are the same than other chips, meaning bit=
s 4, 5, 6, and timestamp is bit 7, and these are the only bits since the ch=
ip is gyro only. Usually scan mask bits start at 0. I don't know if startin=
g from 4 will work or not.=0A=
=0A=
Jonathan,=0A=
do you know if this can be an issue?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Frank Li <Frank.Li@nxp.com>=0A=
Sent:=A0Friday, November 15, 2024 23:37=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cam=
eron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring =
<robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <=
conor+dt@kernel.org>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; Frank Li <Frank.Li@nxp.com>; Han Xu <han.xu@nx=
p.com>=0A=
Subject:=A0[PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
From: Han Xu <han.xu@nxp.com>=0A=
=0A=
Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It is=
=0A=
similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI=0A=
register data is difference.=0A=
=0A=
Signed-off-by: Han Xu <han.xu@nxp.com>=0A=
Signed-off-by: Frank Li <Frank.Li@nxp.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 +++++++++++++++++++++++++=
=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++++=0A=
 4 files changed, 38 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 40271352b02cf..a7535cbc214e9 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -277,6 +277,14 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
 		.startup_time =3D {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_ST=
ARTUP_TIME},=0A=
 	},=0A=
+	{	.whoami =3D INV_IAM20380_WHOAMI_VALUE,=0A=
+		.name =3D "IAM20380",=0A=
+		.reg =3D &reg_set_6500,=0A=
+		.config =3D &chip_config_6500,=0A=
+		.fifo_size =3D 512,=0A=
+		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STAR=
TUP_TIME},=0A=
+	},=0A=
 	{=0A=
 		.whoami =3D INV_IAM20680_WHOAMI_VALUE,=0A=
 		.name =3D "IAM20680",=0A=
@@ -1519,6 +1527,14 @@ static const struct iio_chan_spec inv_mpu6050_channe=
ls[] =3D {=0A=
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),=0A=
 };=0A=
 =0A=
+static const struct iio_chan_spec inv_iam20380_channels[] =3D {=0A=
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),=0A=
+=0A=
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),=0A=
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),=0A=
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),=0A=
+};=0A=
+=0A=
 static const struct iio_chan_spec inv_mpu6500_channels[] =3D {=0A=
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),=0A=
 =0A=
@@ -1623,6 +1639,10 @@ static const struct iio_chan_spec inv_mpu9250_channe=
ls[] =3D {=0A=
 	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\=0A=
 	| BIT(INV_MPU9X50_SCAN_MAGN_Z))=0A=
 =0A=
+static const unsigned long inv_iam20380_scan_masks[] =3D {=0A=
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,=0A=
+};=0A=
+=0A=
 static const unsigned long inv_mpu9x50_scan_masks[] =3D {=0A=
 	/* 3-axis accel */=0A=
 	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,=0A=
@@ -2026,6 +2046,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,=0A=
 		indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu9250_channels);=0A=
 		indio_dev->available_scan_masks =3D inv_mpu9x50_scan_masks;=0A=
 		break;=0A=
+	case INV_IAM20380:=0A=
+		indio_dev->channels =3D inv_iam20380_channels;=0A=
+		indio_dev->num_channels =3D ARRAY_SIZE(inv_iam20380_channels);=0A=
+		indio_dev->available_scan_masks =3D inv_iam20380_scan_masks;=0A=
+		break;=0A=
 	case INV_ICM20600:=0A=
 	case INV_ICM20602:=0A=
 		indio_dev->channels =3D inv_mpu6500_channels;=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 7a5926ba6b97d..62f7d16c2ddcb 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -34,6 +34,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=0A=
 	case INV_ICM20689:=0A=
 	case INV_ICM20600:=0A=
 	case INV_ICM20602:=0A=
+	case INV_IAM20380:=0A=
 	case INV_IAM20680:=0A=
 		/* no i2c auxiliary bus on the chip */=0A=
 		return false;=0A=
@@ -187,6 +188,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=0A=
 	{"icm20600", INV_ICM20600},=0A=
 	{"icm20602", INV_ICM20602},=0A=
 	{"icm20690", INV_ICM20690},=0A=
+	{"iam20380", INV_IAM20380},=0A=
 	{"iam20680", INV_IAM20680},=0A=
 	{"iam20680hp", INV_IAM20680HP},=0A=
 	{"iam20680ht", INV_IAM20680HT},=0A=
@@ -252,6 +254,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
 		.compatible =3D "invensense,icm20690",=0A=
 		.data =3D (void *)INV_ICM20690=0A=
 	},=0A=
+	{=0A=
+		.compatible =3D "invensense,iam20380",=0A=
+		.data =3D (void *)INV_IAM20380=0A=
+	},=0A=
 	{=0A=
 		.compatible =3D "invensense,iam20680",=0A=
 		.data =3D (void *)INV_IAM20680=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index a6862cf426396..211901f8b8eb6 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -84,6 +84,7 @@ enum inv_devices {=0A=
 	INV_ICM20600,=0A=
 	INV_ICM20602,=0A=
 	INV_ICM20690,=0A=
+	INV_IAM20380,=0A=
 	INV_IAM20680,=0A=
 	INV_IAM20680HP,=0A=
 	INV_IAM20680HT,=0A=
@@ -425,6 +426,7 @@ struct inv_mpu6050_state {=0A=
 #define INV_ICM20600_WHOAMI_VALUE		0x11=0A=
 #define INV_ICM20602_WHOAMI_VALUE		0x12=0A=
 #define INV_ICM20690_WHOAMI_VALUE		0x20=0A=
+#define INV_IAM20380_WHOAMI_VALUE		0xB5=0A=
 #define INV_IAM20680_WHOAMI_VALUE		0xA9=0A=
 #define INV_IAM20680HP_WHOAMI_VALUE		0xF8=0A=
 #define INV_IAM20680HT_WHOAMI_VALUE		0xFA=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c=0A=
index e6a291fcda958..cd54e9dbf99ce 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
@@ -79,6 +79,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {=0A=
 	{"icm20600", INV_ICM20600},=0A=
 	{"icm20602", INV_ICM20602},=0A=
 	{"icm20690", INV_ICM20690},=0A=
+	{"iam20380", INV_IAM20380},=0A=
 	{"iam20680", INV_IAM20680},=0A=
 	{"iam20680hp", INV_IAM20680HP},=0A=
 	{"iam20680ht", INV_IAM20680HT},=0A=
@@ -140,6 +141,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
 		.compatible =3D "invensense,icm20690",=0A=
 		.data =3D (void *)INV_ICM20690=0A=
 	},=0A=
+	{=0A=
+		.compatible =3D "invensense,iam20380",=0A=
+		.data =3D (void *)INV_IAM20380=0A=
+	},=0A=
 	{=0A=
 		.compatible =3D "invensense,iam20680",=0A=
 		.data =3D (void *)INV_IAM20680=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=


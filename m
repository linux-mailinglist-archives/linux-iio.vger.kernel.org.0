Return-Path: <linux-iio+bounces-5733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5CA8FAE32
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB15284A34
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29B142E8E;
	Tue,  4 Jun 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="eh6NkADA";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="eh6NkADA"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020003.outbound.protection.outlook.com [52.101.186.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288FBA39;
	Tue,  4 Jun 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491577; cv=fail; b=EKEX9Sk7c/2+xNvlORiIn1TV/TSCPSamGZOjEPpcrQTWoBijHJgBDXR5piwQN+dwsvtXbshRHkNxgQzO3wfd4KRUEmZvtgyolrzuprnvm4cFzF9LCRZnNrCZvLXVpnLYTGuki8fB39JXQpuhnIHbwjcEJv/PXjOxGkDNopO5H/A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491577; c=relaxed/simple;
	bh=2IS+P/GfRlnHCUdOJpUfQcGIpaX9TIVgqBZvnPK+mDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgBisQHdeBfg955Sa5sst9ksR9Zf9sERE0+sRVW4A7m4px+UN239UsZr0VM5wsfKqZYRZ3qYCqkfEVL7u947RHLJcLINIfxJtZ3eFlFGrApkoBtqSPF/8OG8yD+imetImSfKG7tqlouzz4e6OWCD7GI0sj3FRTBJQ2p4jE37Y5g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=eh6NkADA; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=eh6NkADA; arc=fail smtp.client-ip=52.101.186.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EcxUdyLNdW5kr75r4NZXaIEXTLLPEsKBn/d3DTrXTCSgJFNOSVMQULg3moHtMq+L7q9MjD0RjrhlQSoDAXMzrgSzxpU7nNPRVVUXAP3YFmIxhBKEABYit10s6jEftDVgK4ElAa3sfSEkIRZ7n+ekFcBGAiWdyPHBNZ1OcyhXOkVuUNYe/UhuRfMfTZBZTixRSeEnyDgpyfQ7vQs4uaiEWhu0ILHZ5JfQ+0AZZCV/LRXRIVYV7njVi/3BvBpgTaDdaVoJjsQUQyLOBIiOTh3jrONc1zthc/ZZtQXCleXfhPvBiT4k0CGAavvZiKWwmGPglVeVAcp7v+7hrUVJULowBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IS+P/GfRlnHCUdOJpUfQcGIpaX9TIVgqBZvnPK+mDM=;
 b=CsaAm7HN3PxysB8Z0z2hEedFbQLLYfXXwZxl0VBQmwB448GVh22cjEKeXgrO547fT+74x7LWPrys8HrklDEkRhsIxe8N+2Wil+VVH0OZJ6eWhn7KTCOKRnm6AqDwwk1AQ5bD7GGFg86S0R5YRskXkEMB4njv1QLWH+HFj5pcXO2CoCeysyd7/yyZOkO5gu5SDLzNQEkX3XCi10YVQvoakQlgZlMvOyVQNTNLhGZtIzl3pIPU3p5pBlM8Cg8dwaXqIoTuXT2o+HHAw/wjRPnb4J8aFIRDz4Oa+UpR5PViel9lA8etARuJLnaPpWN2kOBEjxzbuRLl+MwGbp5BRUiEZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IS+P/GfRlnHCUdOJpUfQcGIpaX9TIVgqBZvnPK+mDM=;
 b=eh6NkADAsyCWdqBliqFnopAiUDcnqoxAVNdNmpF5VrLIc7hfUjvByeEX3MF8rUccdVxIO0MFWkHRzF27UD4NLBP/PhvXs9NPFpwwkGSEdCimYPawBw7D1te8CpJ1svTDIf0Poqr3dMNhPFvAto8apwgh1izooO+d2W+/1W3xpOQ=
Received: from DU2PR04CA0234.eurprd04.prod.outlook.com (2603:10a6:10:2b1::29)
 by GVAP278MB0135.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 08:59:30 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::bb) by DU2PR04CA0234.outlook.office365.com
 (2603:10a6:10:2b1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 08:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 52.138.216.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.138.216.130; helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 08:59:28 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.8) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 04 Jun 2024 08:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvtTIs9UbEhaU0kwvb+JHaVLmD9RE9RtfnZSePtbuRBmKPIG2gMrjfB5eASlVqHtbsZbH6gpsKyApR4IvFbmKdnerebR2Fm5hKkrJDX3z79DCUDZJh6qMavq4xPiZJ/18iDd6+2ZOFvup2v/1XqXUpp/sdu1Vn1DfCD6wJeWqwvB31wFwqlAx89rH3yOq7c7/dghFOW1DsjKBaNIzBnCgsfo4OO4MuzP9WKUEickaDXWIJ9I6Nt6AFUqvARHID7N/iNvNMLR62XXyMA+2TyoJvYr3f2uhMummZEMpgAukL1XoMGJRWxZl7g5F7L9Nzq90JnsomJJVQt9ZoYiswDlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IS+P/GfRlnHCUdOJpUfQcGIpaX9TIVgqBZvnPK+mDM=;
 b=A8P66ONxRn1hkJ8ky689ti9W+4pxfru8dj6maemNBmwXZm7YP7jxfFK60UymVHRlKorjjdxITRomkkGtdLAoIJGWuyHVBA9JEz8tuJ+Z8/yG9YU1daND+A11OaV9+m/d/dyYh654DhcUqdv5qfQeedQjJ4U14wIQPk4Oz3K5453auNYmEXxpcr+AydBddglJIkGxwPxIeNHSOSyTQ9SruSYLFIyyLgf8TWe2RqEO/6z5QI8zJfkK3WQSlZFWyvEg6lIeWEVz3NX05NZvQFxFJxHPie1pb51XJJeIeV1lrt3ocLECXUTwV13id9NdYgwxhWJ9Ws8Ib0H4OX/gSNrzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IS+P/GfRlnHCUdOJpUfQcGIpaX9TIVgqBZvnPK+mDM=;
 b=eh6NkADAsyCWdqBliqFnopAiUDcnqoxAVNdNmpF5VrLIc7hfUjvByeEX3MF8rUccdVxIO0MFWkHRzF27UD4NLBP/PhvXs9NPFpwwkGSEdCimYPawBw7D1te8CpJ1svTDIf0Poqr3dMNhPFvAto8apwgh1izooO+d2W+/1W3xpOQ=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR0P278MB1463.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 08:59:24 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:59:24 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v4 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Topic: [EXTERNAL]Re: [PATCH v4 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Index: AQHatluDFMv2iDQbU0y0aSQ8wGG7LLG3Sxev
Date: Tue, 4 Jun 2024 08:59:24 +0000
Message-ID: <ZR1P278MB11171DD79D5A09580FEEF4A181F82@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
 <20240604-veml6040-v4-2-5a4d59597874@sentec.com>
 <e740deb8-e412-4913-9a79-59ad8e117d53@kernel.org>
In-Reply-To: <e740deb8-e412-4913-9a79-59ad8e117d53@kernel.org>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR0P278MB1463:EE_|DU6PEPF0000A7DF:EE_|GVAP278MB0135:EE_
X-MS-Office365-Filtering-Correlation-Id: f4abd673-c54c-4d7b-055f-08dc8474a461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?YAvuAVZAUP/hNya4eFFJGVKtQPzhLdpkIJwI522r8xL0FGMTuy2fJ8ebht?=
 =?iso-8859-1?Q?n0uWYmfdFC/2zmHRNRq3V/VtRKZNUqm4bCRa3qXFWoPbQPxvZlxrbZcOzp?=
 =?iso-8859-1?Q?IqHllGoANbOHxi3npQpdr4V/AEgAhPMIC5aR+N1jDN3v0ryNDY6MUQuwU6?=
 =?iso-8859-1?Q?hhzib8kBGmgpnwXrmvkbBCHAPkZ/k/OOV3PW63ZMwFGku91mrhgEHC44yC?=
 =?iso-8859-1?Q?aCBVKy6pJxUaeCrWNgYCPfnohK3QiNvs9PkngJstsV3Dpr57WaqAX4rhV7?=
 =?iso-8859-1?Q?0GQ/+53Hz6lqDB6viCS99HMSa0J+jitKaThM4mG8wgED7jYNn8h1oSSJz2?=
 =?iso-8859-1?Q?Cmuh4gDPTwSUlwYSXrB1A4B06j3mqSlyobFuEMTxJbCm0n0gLJfg8qU/kB?=
 =?iso-8859-1?Q?uDjH9Wa7T5s4NkcxPh8EdzXrZiHjEPth1qVLpEGZBVR4SOBIwaIXZ1ceVh?=
 =?iso-8859-1?Q?NsDUbGt09Z60Fe5XwWJVqsnd4DWDeHuAaZ1K5ctoikgD87TRSgDmIySubx?=
 =?iso-8859-1?Q?ls9crR7DQ/tFx0xqGcqynTyurN6qgn84/x9QTHhCAKjyvR+5Y4KhECGvn3?=
 =?iso-8859-1?Q?VbGNc6jW4vXvBE7rzmju3XXNMOq6sXoChvAy5ylKo+lOGxbC0jt+kSUE5R?=
 =?iso-8859-1?Q?Q35uN519ZFb+2itVp2eJKJ+E7RxwynR6/e7CVgmSalRTUsU3dnB9exfv1A?=
 =?iso-8859-1?Q?dMPGxqYgDOtLnjovx/Pj7CBMO86Q5vJ9X8c4lRYkC3QFHbk/MDqs5ZvzrK?=
 =?iso-8859-1?Q?AhdZRlumrO5NvbyEIw+VpMbRM5s3LLSrqXXfbxEJYMwS8fKHHgnuLWSYPU?=
 =?iso-8859-1?Q?R6y4cscX4q4ajnDRF6N2mKL3hnZDitNJVfkBTvVfy083I1vsdWS04s6Cux?=
 =?iso-8859-1?Q?Wjw1MhRgoN1FcGNNFiaILzzaho6hCED6i75/zneAxBufDyIMZGmKgCl7pC?=
 =?iso-8859-1?Q?p6W5m2i96QbsiO9UCsUqTC0fEAqdpkRLzXsEK42IFD0g1wNJkpIkLIr6gS?=
 =?iso-8859-1?Q?tn+12nQP4Awv/VNRQEm0FLSVj82xNoGQRwEgvO3eNXIlAUhjjaiBUlHmDv?=
 =?iso-8859-1?Q?soEbV8zu+2zXd9TGsEZI/MtrVIsSW+DwvlebDkfFjFbXDWx3Yt2EPTfnGW?=
 =?iso-8859-1?Q?ZiiAZoJnqqRAIMR00oIAXY6t895NgtgmZ7a17azSHOw2ybo4UBN4el9Xkt?=
 =?iso-8859-1?Q?wAN8cwPhwTVCngDm0kSRCcyrySmOjPXC1qP1SspyD1FJJltBpi9q/7hGdh?=
 =?iso-8859-1?Q?2V1STJT6UiAUa80KKkm/3SsfsRBj3oDMdG4okhS1KkudlfSknpOy/urhqv?=
 =?iso-8859-1?Q?ZuMZxrrXQ5DYOvlundgZbMxdbQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1463
X-CodeTwo-MessageID: bc7cd4e0-b037-469f-a0b4-809895bec052.20240604085927@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e34ca646-248a-44da-af72-08dc8474a19c
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|35042699013|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?67a4zfEEfK8pnLp6gM1sm9d8N66MmZ0aH8VMOotsol2Q/fbeqd07WIUpb3?=
 =?iso-8859-1?Q?F9r95OFBTrD2wfQM8l7EiYJcM+5eR1DrHiXlWhU5v0PfPo82K+O2OQLSq4?=
 =?iso-8859-1?Q?argEpHuJDAaRtU9/WDHTVCUuID+aUBMmi5ouQHt3/RCY4SeaaaBBvEA0gz?=
 =?iso-8859-1?Q?7dCv5VSGWiTVUVk2euwSaFAVntEkS394qoaZo+pw5z0apDHcXnf+wsP3vA?=
 =?iso-8859-1?Q?IcLdZI/Qat0gqhmDKnKilqqUEH4/vNtPDlxnGOAm+m0eXOZXeBlaVEHup/?=
 =?iso-8859-1?Q?c6b5C5oo0yJuak9eOzRerXpodEaTlXmvyqT9NhVmfYuMI9eiIhHpm9kDHS?=
 =?iso-8859-1?Q?0a67CyZDLEfXELwDJmbG431DjsPbh6AR+jv0lNZnvrsmTTouJjQsDBN8Yl?=
 =?iso-8859-1?Q?IkjaxnThX/W/uyzjXdM5E0ZV6cb2i5+Yvgo2WbBPnGviLnF/iY+StxQhOn?=
 =?iso-8859-1?Q?kAgs5gGOcpu1MtFz+NxIQFMTo8eL9KbBIJ8oKSyk/ZzbjS2oG404XiNCDc?=
 =?iso-8859-1?Q?ny038gj1P+5RE53s643jSz0zNTv4nAWcc6JUIEPjA73jtigE4sxqn1V8YW?=
 =?iso-8859-1?Q?J/4FRVoD0d120KyqrKK0eoNvMM8yOrkedoHVNotwMNkS38oXKTxB+UgOVQ?=
 =?iso-8859-1?Q?SdbxTEy3hwgxlpD9sokBzinFBTPmJyM1z/4hXoYumnGpKTdFeLJ3Z2V6h/?=
 =?iso-8859-1?Q?KO6q/mPyIwDq5/FvHvtArrZGpdfDcTlu28kedrsBbfzorlfBr+Jx6wzv2V?=
 =?iso-8859-1?Q?pla12tgDBZwOjh3Qm/tYuA0/sD8JTEBGq0NKx50szrUwiyn0wfvHRMYDlg?=
 =?iso-8859-1?Q?XfM8ng+3YugWrYbmpHf7C83Fi5jNrp9d28W8KZoDVc9G/7e95hFStLdfd8?=
 =?iso-8859-1?Q?KWaM2xr5gykHWrDIUXawVQ67Frdg3KuqcY5yUpqO2CE1jIVyySevutt2sn?=
 =?iso-8859-1?Q?47yLYrnRK9XoscNFmC2sYgxQXBaUNrpHjHpNbo0ONEhqG2MkDU9mqZGqqM?=
 =?iso-8859-1?Q?oux5KX25TdSjqw5s7ofk2SdxkTdZvfXf4jwYyhh2G4I8cZcUeeUUzdGYgk?=
 =?iso-8859-1?Q?ZdksOAfIOrizlQEipZ1gNX7ycaVSLC3MzKzyqgN7Os+gR9mYJUfxfJE/Vz?=
 =?iso-8859-1?Q?53P/RZfkUR1Hq9Lq/9+Iig4I4pZEJZ8NW7xHWe4acwy//EuXMwc0rgyh/L?=
 =?iso-8859-1?Q?kjwiLMirp1fhnVA5zw9DWEPTNTFtZTAIM1nqiYU7Oup+8Eag7UiB0xZWkq?=
 =?iso-8859-1?Q?LPdRYNfoRc1y1jPz8eR/qJgtp2mv7vSqPfP+fduiqbHi8dadAuGLPBz9V0?=
 =?iso-8859-1?Q?02usLMvmu8yk23zELfh0ykG7fP6sgxg1FDubOdZreuOM84YaLUgYowa9zr?=
 =?iso-8859-1?Q?dOout+7iQ732lVe1Cde3X0ravrsNQBRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(35042699013)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:59:28.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4abd673-c54c-4d7b-055f-08dc8474a461
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0135

From: Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent: 04 June 2024 10:45=0A=
To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzys=
ztof Kozlowski; Conor Dooley; Javier Carrasco=0A=
Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vge=
r.kernel.org=0A=
Subject: [EXTERNAL]Re: [PATCH v4 2/2] dt-bindings: iio: light: add VEML6040=
 RGBW-LS bindings=0A=
=0A=
> On 04/06/2024 10:01, Arthur Becker via B4 Relay wrote:=0A=
> > From: Arthur Becker <arthur.becker@sentec.com>=0A=
> >=0A=
> > Device tree bindings for the vishay VEML6040 RGBW light sensor iio=0A=
> > driver=0A=
> >=0A=
> > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
> > ---=0A=
>=0A=
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
>=0A=
> If there is any resend:=0A=
> A nit, subject: drop second/last, redundant "bindings". The=0A=
> "dt-bindings" prefix is already stating that these are bindings.=0A=
> See also:=0A=
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L18=0A=
>=0A=
> Best regards,=0A=
> Krzysztof=0A=
=0A=
Oups! I had read that part of the documentation but forgot about it...=0A=
I'll think about it next time.=0A=
=0A=
Thanks for the review!=0A=
=0A=
Kind Regards=0A=
Arthur=


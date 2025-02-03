Return-Path: <linux-iio+bounces-14942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB57A260A3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FD71644F1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1020B7EC;
	Mon,  3 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="t26R+heU"
X-Original-To: linux-iio@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022076.outbound.protection.outlook.com [40.107.149.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48601194AEC;
	Mon,  3 Feb 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601847; cv=fail; b=YEWmOTS1gLq0Q1izs52B/Ev7mgJmX5W3wXF7Cwj+azGuuZH93QRDQLjXBkzimtC1ID84mUSb4qS1r3sYyqxaECQC5puNfHSL22t1K3iQwdtuKS3BK2Sy6NMXaY7VcI5G/PYYLVmZfHQeJ7GNgL+OmnMQMRlvHYCBMHjsAZwUoZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601847; c=relaxed/simple;
	bh=iKFHJgx/5CFVGEBPRBx7X49u0+Tr/5r2RupgXv91+/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myA9XupQ7DskszZnsEI+ZQ3rzMkz3j9yCu2xFLBLYXyJitYC+D2ut5idGWXZQtQlrycFqJtyU6WKsE9C7l3VxRAHsNnWta5peoloRXY5ZpUZi6Oe9ctFEV4DEVbXbUbXEV8ZAvQSIUE0lB7ok50octwOFCBscBSnl6olOCKasH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=t26R+heU; arc=fail smtp.client-ip=40.107.149.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2X//O2uu4v1gAZmbKHAdc9BjlgWGIFG+IxwIMLS/oP0LMrBdfVa5zIDNQGUfOCKG9azytiEQSShbhXT8uFkBkXEcrg7J2MVoDf3HNBGCDtbRepzrRCjHAQ1Yj9pFqwtDt24D8DT4J6NeJIIsnBcMEAO/3B8LWUhVvn7ZLAKkZE8aczys8FbbzDsChuxW7g6lUaaBTdxI5DD4N48cphs+/L2ee9hPJue0L2MFBPBzH8GoQzOZUrG+BJx/RxrauqXnfFHOqQauioEuRzU3SdTnAEzAYj3+Y+7MB4elAZLnKJPh5sQF4+c0AKxkxt6ZnjElteL+0cX0toe8Eb9FH6GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw6l5WuM7WuYlqnpSInk3ZQOGmBcvvokRB5D+Pkzwms=;
 b=OYIlQM0yVFeeXLbKUTwk+3NtW6aoj45o6IU1b1XpaHaZE1HK/zjQmc8WID1QI241qcGlsdFGN9CvZfPTTwlEIjwpQpj5DT8Z5Mh3UnDBe0GvRLaUMZR0Hp5dnyGdGoQ5Rr38rKfaZ4ADFSvZYhvMY+y7gtwzB5TRw/aButlJT7fRelrAqn4p9774c2+wd0z698SJCwB8/xPM4CBVKB8Wnennu+FbZEw5TTmlc12L41ka5wt6KbquEq5mw8TJdWkhtwshqabfaDSvqkRUXShf1z0Ai76vFhnDvfVcC0chhS3x1x9C1jm7UGlc1b04XZXG2zXi2EWTQlY8JKppVs2zNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw6l5WuM7WuYlqnpSInk3ZQOGmBcvvokRB5D+Pkzwms=;
 b=t26R+heUh+xFrYa1Sk36rp4Uo/SwDdqNrznQOcqGSvSZAA1tUsOKwphpN5YvKM5Zatz1qRH3WaSpAdcpnCP3VxbOb2GDOe9tCP4P6tTHV+g5wZzi8AVB0dl1w7EaIQG4rLQzgSkmaMK19nHoh1F4xsjt4aSg7SW/BNyyNt07th9kN8RCVovG2gFxad8wKW5qx/z92cUD1yQ0/0cU1JXhE3bPj2LRi74hUfueVpUC3BlMTRGP2OHaIH5jhu0AG0xcTS43z5qPl6WIM2RcqdC9ERw2yy3U9jMCOtJ9FyA4/jMYk0IlN+gAy4g4idQ7SAou6dCzlIJk1hCT+veBasDFcQ==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR3PPFA67B257C9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::175) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:57:19 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%7]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 16:57:19 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <jic23@kernel.org>, Tobias Sperling via B4 Relay
	<devnull+tobias.sperling.softing.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Topic: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Index: AQHbPPFyoU64h9XPOU+xSgAMQsFXvbLGYqWAgG/U6gA=
Date: Mon, 3 Feb 2025 16:57:19 +0000
Message-ID:
 <BE1P281MB24209585E1552B80272D5448EFF52@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
 <20241124124205.02453a0c@jic23-huawei>
In-Reply-To: <20241124124205.02453a0c@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR3PPFA67B257C9:EE_
x-ms-office365-filtering-correlation-id: c9411666-917f-4ce4-5d23-08dd4473d200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o1WZYMsVs75ST6WZGXLDLfKlnppPWz1kvAjH7VPG5eFO8f+cHU/vnnpMNics?=
 =?us-ascii?Q?VwUZP/osjIx7h5EchXqfDXaUVqJJTm5Yu/BwfqFrjdDsSwKlRSthiyi0UzVa?=
 =?us-ascii?Q?hoT72bOuEY0gqmwJv3dFR4z258gaS2filCh88y969fn9TEt5BGrEYMnVlvLK?=
 =?us-ascii?Q?PzxBOwGKRhilundK1PczB+he4o2v02hmXZzkOF/qSgncDVuLY99amG9VIfrI?=
 =?us-ascii?Q?Whe8Aos3R3xbAlunTLminOLoDc3vJqTM4AOWpNni3JL70+IbXAi4kX83KUSe?=
 =?us-ascii?Q?NTnsaHGZZTfehzI/12mMdUX6WBG97+vPOu6yuib52m6sjs8YVLWzvNkBPOXA?=
 =?us-ascii?Q?N0xcAPRQB4ZEfyrRrPnF5KKfjoSaN/yaa8ROR6xctBpR1yUwHm62800jyG5z?=
 =?us-ascii?Q?4YgD5+PYqZoeykOMwkpAkQxbzIbSZs8rWq0UEPhn1SmI4PBOGPQbq68HrLMG?=
 =?us-ascii?Q?ioe/Anzf/MWDvZobGjoAV9XaptNfRtX3tmVKy/Nu/ojOhW4R7mrr0z3iMVFK?=
 =?us-ascii?Q?lGBj7coE92BwsfxHfzmxyz9XTqyjsEs4tJAUK23hpL4bmeZDj9MVD26YCCNB?=
 =?us-ascii?Q?dMcBe9QjumZUuNAc3ki4mpOqaRAJLbJJYqumNQ19RXl8rur4niQj+EKwN+om?=
 =?us-ascii?Q?0XVjhWEzwU1MyURxybKG0pcyt14wm+0Nwzo59mq1he7Wn0GXB466Cbm3BR5I?=
 =?us-ascii?Q?s4NMMbUYUs6T7Lg+RTd7TJ2ZBsWdpZoQJotb6JopDNqy+vF8rPTFZ1Tr7Gxi?=
 =?us-ascii?Q?pYTAh1RIsSpwsCt3wG6zYfZlgN7/9PrvcIFDmjD1O8or5Ko7TmTpBUZwxHpM?=
 =?us-ascii?Q?ps8WEnwNyWlBaoPRcW1U380jWCg9J8zWJfGZSXcaPqOppWFq400r4xu2z1Op?=
 =?us-ascii?Q?I5mVmuEic+IW8nkj/FWQlMzqYcdQylwNok1gcfyNX+gtO4WJQPT7UZlRqZlV?=
 =?us-ascii?Q?ajBiSvHeNBTfj/jJZ1BTuhhPCmebrzRz1z2cc8oImt0zyy37P6cL3ZGyJRlp?=
 =?us-ascii?Q?I1+X2DvGWqi1K0CDuFWFpSkDY+Yr0E6pViJzTUzqNUxvefjuL/ByT8kSsop4?=
 =?us-ascii?Q?s9nezzu5uqpK+VnRdf2U74YtX/L4yglL51b+lSojvBb18io3OVlVFYbit/IR?=
 =?us-ascii?Q?MW/nzyExl6oh3XJMPFCeK3CsLZXRTsTGjjxQ3qIZsYCrmGaBNN3004mo4YyX?=
 =?us-ascii?Q?XrAjdBCEqbR3MURuohU2DcoUydkimeRwgt+H0Ha1IuLcqT+X/2vqJ2cA/7hc?=
 =?us-ascii?Q?V23GHHCFCH5z0Cs1BZyd8G8Kw8Ra9+4Rtl0senyLV4YxuDGVaW+m4K6IVoiG?=
 =?us-ascii?Q?MR6bSoPYwteiOoNxM4Gwwz0MARRILZ72RDtoRtMPIpXws5+NcByge8lsJkeb?=
 =?us-ascii?Q?O5RRQynnOdibOp3Iv4TR5gkGVnxf2+syvdWecChgGd9ZGnpSCx/3UooYrLag?=
 =?us-ascii?Q?T/7f6rUVo5zCXOzMTlmw9F422ujwo5My?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WLAj6niHVkwbSNxZk9FYnHPaQk2A7dSYSK+WNPUl13fTpVb6W14GWpTlgr5w?=
 =?us-ascii?Q?iG65UqXxUP4wouCHphCtfA3xwAChrb4TaFnSX1NpLp1uZ3bVAsm6T0oKw5Qd?=
 =?us-ascii?Q?MtAK1CgSzthKyOrSkjCXeYm7ZskaH0kW13OyqFIel9tGFtRc9rGlpyXeSlcz?=
 =?us-ascii?Q?fw6wS1QAkcmw3DiUCo8Trwns5RfBLfx5NP0Umh9ZpqYzbvGipJ7bvQQ6qgie?=
 =?us-ascii?Q?N20O/GZyy9SybRxS6AW7hDEw3Yg/rVSGO/kQEjeORBt6917gmOSXkXsuN6VR?=
 =?us-ascii?Q?FRuJpn0HliCeAL4q8WFra065mRA2R/25xwK50J3iTDpRZLsV4QWZg+p3MwrQ?=
 =?us-ascii?Q?HZ3JbhcRXAKoz9lxzxlWIJZPcBo/juuX58aw0vmh+WHUjfPR45aP2y+8a4dc?=
 =?us-ascii?Q?1Ibr16OxP1X+zPQYxW+pH/goeubVsaDOP27L6d6rnGZIHmAweV/lv7N85Ox+?=
 =?us-ascii?Q?jNO/eU7E6UH3mtUTPZAr6gF+lzPXFLAMJBeMx4VojADe60Mlz8+0t5CWP5Jx?=
 =?us-ascii?Q?+vleBA8uAt7IkNOYUBkXxvAmnNNik3uvDgWC9rAqURjaeGnMh0xv058HaVBI?=
 =?us-ascii?Q?4QVqldTL/Aako2w1s1WSUjywvv+0Lb7eNsadYJgV/je676LO3Sw8AIE+KNMI?=
 =?us-ascii?Q?NrHiAljBJNlh5oEH4N4foVuIYeo2rDWsWVIgxiMN4evZqPE0fWd15Hc//PZF?=
 =?us-ascii?Q?U1TknerllpW6rkx2rzVDrePHg64XHeuHnQ3Pvrgbt7j8BqAT/islRN8CIeQM?=
 =?us-ascii?Q?56CeRRQbOCPhGXV5UUHR6e/TCyvK0zN2UZm3sL7hNIYP92WCstYPsyJ0I0cW?=
 =?us-ascii?Q?OWC0ZQZ0VCpxRWcNjP7igPD3tVJgMkzWrj0MMZ8MB7mJmu8XLFYZWrzJmjMF?=
 =?us-ascii?Q?XWTa6f3U7X3GpowWr51HzhT/3Fg+CglY3cOZN/syFYJtliZ0ABMvm03eQp8U?=
 =?us-ascii?Q?sOmTahTHfAN4EQzRF3BJUogWDPFmQ2x/OgoWn+tNI9hx9T4Zf4tSwb3WtkJW?=
 =?us-ascii?Q?XFEwZXFwedTzVmcX+bSQmxHYXz+710wLv7CQes4V4jGfk4DuWog8u5PGbDaQ?=
 =?us-ascii?Q?19WU0fGxdEgj3SPhLqa7wX+lfIUZ0NdNfE7XLEFnVKG0yhGpG8/CUh9M4ElY?=
 =?us-ascii?Q?ETkUOUB+YqqOvdxtAZhDW+gtaebi6NF4sMoIO8JskVZGWHngToFppN9tL/67?=
 =?us-ascii?Q?FXVeGe4WHqAD3J6YEwtEVHPqtcEjVbrXjSTflhZt4XkMpiWoV9XRgG46xacC?=
 =?us-ascii?Q?3Xs3LSP9fRJCFAbrxb//LseMpW9dzqAhfG4RjxlLopEruXPUJmeLAKTIj5gt?=
 =?us-ascii?Q?vOK3lI1JV7wQplpddZl8xh9tIsADjJpcV1Am0AtPM1lGAh23vNauSQ8nYGwe?=
 =?us-ascii?Q?D2RkI/F2LrEZnrS3lK8zLBmyGRjN3nJAxOASzO/uA0uT8xeM5hEv2ECyOseW?=
 =?us-ascii?Q?NI6AxdRGqqDDFPuw2cFqrUD3MFktGgRRviUWAVSz3HVQFL/AY3ewjY668COQ?=
 =?us-ascii?Q?KnOSSMHrILe31AeNxm+UN76aW9K4wvlhlkqe/ZhhShiDQ6Qj9IsmQVLp+jf6?=
 =?us-ascii?Q?nwf+9Eh9K2zS3j98+pgOEneLCvaWaQ+5rWf6qjgHmaRGBLOkU6Lmk4+fm4gO?=
 =?us-ascii?Q?lZVPGiFAmE7maKJTXqeGnNAC5QivYr9mJD4GrytVpbp6+WzdT1eHXWODdG46?=
 =?us-ascii?Q?PnMRJw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9411666-917f-4ce4-5d23-08dd4473d200
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 16:57:19.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXcvDzPWBsX64Fj08CJnb0Ysl1KisB59DfR6AhCcbHZ8Ghuc3sK/eseronOuBTUFfhrGiH2wkz4OICAPWusdc8p/Cfaom+9KkG7wib0lYu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFA67B257C9

Hi Jonathan,
thanks for the great feedback, I tried to improve all the mentioned things,=
 just
some comments/questions inline.

Regards,
Tobi

> > +static const struct ads71x8_freq_bits ads71x8_samp_freq[] =3D {
> > +	{163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
> > +	{977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x16},
> > +	{5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833, 0x1=
1},
> > +	{31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
> > +	{125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
> > +	{500000, 0x02}, {666667, 0x01}, {1000000, 0x0}
> Format this as something like.
> 	{ 163, 0x1F }, { 244, 0x1E }, { 326, 0x1D }, { 488, 0x1C },
> 	{ 651, 0x1B }, { 977, 0x1A }, { 1302, 0x19 }, { 1953, 0x18 },
>=20
> So with more spaces and with a power of 2 entries on each line to make it=
 easy
> for people to work out the matching.
>=20
> Once you use read_avail as requested below, you may well just want to use
> the index of the array for the second field and have a simple array of va=
lue
> assuming no holes that I'm missing.

There would have been some holes, as some register values lead to the same =
frequency.
I just changed this to repeat these values then in the list. Should be fine=
 now and the
array's index can be used now.

> > +static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t=
 priv,
> > +	const struct iio_chan_spec *chan, char *buf)
> > +{
> > +	struct ads71x8_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +	u8 values[2];
> > +
> > +	switch (priv) {
> > +	case ADS71x8_STATS_MIN:
> > +		ret =3D ads71x8_i2c_read_block(data->client,
> > +			ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
> > +			ARRAY_SIZE(values));
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	case ADS71x8_STATS_MAX:
> > +		ret =3D ads71x8_i2c_read_block(data->client,
> > +			ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
> > +			ARRAY_SIZE(values));
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));
>=20
> I've no ideas what this is, so needs docs.

See comment below regarding custom ABI.

> That last bit is a get_unaligned_le16() though so use that to make it
> explicit what is going on.

> > +};
> > +
> > +static const struct attribute_group ads71x8_attribute_group =3D {
> > +	.attrs =3D ads71x8_attributes,
> > +};
> > +
> > +static const struct iio_info ti_ads71x8_info =3D {
> > +	.attrs =3D &ads71x8_attribute_group,
> > +	.read_raw =3D &ads71x8_read_raw,
> > +	.write_raw =3D &ads71x8_write_raw,
> > +	.read_event_value =3D &ads71x8_read_event,
> > +	.write_event_value =3D &ads71x8_write_event,
> > +	.read_event_config =3D &ads71x8_read_event_config,
> > +	.write_event_config =3D &ads71x8_write_event_config,
> Definitely worth thinking about whether the device can be used to
> some degree at least without interrupts.  It is annoyingly common
> for board designers to not wire them.
>=20
> If it is easy to support (without events) from the start that
> is a nice to have. If more complex we can leave it until we know
> of actual hardware.

In general, this driver could be used without interrupts. What remains
is the reading of the ADC values, which probably is sufficient most of
the time.
Is this what you had in mind?

> > +static const struct iio_chan_spec_ext_info ads71x8_ext_info[] =3D {
> > +	{"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL,
> ADS71x8_STATS_MIN},
> > +	{"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL,
> ADS71x8_STATS_MAX},
> > +	{},
> 	{ "stats_min", ...
> 	{ }
>=20
> No comma for terminating entries as we don't want it to be easy to add mo=
re
> after them.
>=20
> However, the fields in this structure are non obvious, so
> 	{
> 		.name =3D "stats_min",
> etc
> preferred.
>=20
> This is custom ABI, so I'd expect to see a file under
> Documentation/ABI/testing/sysfs-bus-iio-*
> that explains what these are.
>=20
> Adding custom ABI however is a hard thing, so provide plenty of informati=
on
> to see if these are justified or not.
> Superficially they sound like debugfs things rather than suitable for sys=
fs.

In the current configuration the IC is automatically making some statistics=
 about
the minimal and maximum value that were seen on each channel, which can be
read back by this ABI.
This as quick info, do you think it makes sense to add this as custom ABI?

Otherwise, making this part of the debugfs, I guess you are talking about
granting access via debugfs_reg_access of the iio_info, don't you?
And this then also needs docu in "Documentation/ABI/testing/debugfs-bus-iio=
-*",
doesn't it?

> > +static int ads7138_init_hw(struct ads71x8_data *data)
> > +{
> > +	int ret =3D 0;
> Always set, so don't init here.
>=20
> > +
> > +	data->vref_regu =3D devm_regulator_get(&data->client->dev, "avdd");
> > +	if (IS_ERR(data->vref_regu))
> > +		data->vref_regu =3D NULL;
> What is intent here? If you don't have a regulator you'll get a stub
> which isn't an error. If you get an error for another reason, something
> is very wrong, so error out. I may just be a deferral though so you
> may end up successfully probing later.

Changed this to devm_regulator_get_optional() as I wanted the supply to be
optionally. If available it will be used to return the actual scale value.


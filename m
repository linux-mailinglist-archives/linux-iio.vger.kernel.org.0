Return-Path: <linux-iio+bounces-4333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 275678A9E40
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC98B2614B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065516D330;
	Thu, 18 Apr 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ErrhPbxu"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2089.outbound.protection.outlook.com [40.92.23.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558516ABEE;
	Thu, 18 Apr 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453725; cv=fail; b=PmshDpP9ntQX2TMbQ9edPZjba4YtDv2TaF5vydI+rxfxxNs107NnogveV4LKNi5dTGPaxCVHkC6OSYy64RlyYQ/P5XyKf0y/4I2HxwWTJvIIhz1/m9Jm9ZsuCt5IirFthQqWwOwTO2MJFBgxJV/Naei4syGnMRCrmoxHDAvQkYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453725; c=relaxed/simple;
	bh=6nEnePp0Ld6EyteoeD6jjDNGKcySXPFzqihydlieu9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mhi0Zi3LqHbKmclgAfq55A7qQUUbsYYhodLndGVUxtahjfVqh4QZS9InYTqSenZXRAcQEiLJ5J85aMjWFqSryTlS+5WUFD4t5p1C67vsNZrK49wAAjPVGxfYbUQL7+cDpNnGcXg+n4hcVEScEsvpAYlqRv1y708ELXwCf2i/SEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ErrhPbxu; arc=fail smtp.client-ip=40.92.23.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj2cPjeHuuyZGarHYBMZYpCJ4CGv79ZVWxjHHAZuiHN4/sa6HvuXZrby5df9V9U4uJIR0w19p3EURiskXeLnuDmuzTX8opB7/PgG8GhNCfNtrgrOP7+lUsp5c45Mh4TWTv0yu8jdD5NEIX3sHmMy1hctcuCHofPItFFgihj5TlocSqhY3Zgvugen3zUtL754nE9MfRCiWoAw/JLPsetsuX6Lwz/jmkZiaMj4e1jf/OzMBTfNPbGesRA7yfmtMLFnoFFsahMzq9f7aOm/yEW6WvHDhJuerWqeJcXb7gVMwsiSU+bMA65f77nAWdnXJB5MNJcuf41Ay70/mymKcUIqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IxiV5t6usA7D9F0EmSLqND0VEC/srdFemvbh+cbZgA=;
 b=JVmzXjITmsB0bhkgVXT4C1eqUN80oPSoXFGfrSRwuF0mZjgmD9ONfAmA0iSw9mUj5TS3FvFf1xoKtifKH/oNhvTNwyvC/CC/T3rgCGpxpPs58KGkgtjDAdhlyFnSAfYP6vS6i1hMzzqlDocUkww06y8+EiJEmsQSFVsV2+aUnht9oJMyoTfgtFWbDEiAvWQJ+2ZWenb0DrTeNiuTgpbDjlBRp6p1ZlcdTcobYGyQSpORrbrbIcvuXPmdbFqir7i53j2m5J2WQZcBsbUVcy/Behlp+ezeZrFetqovPpHpGYZHPwRytKhRQ6Lzu+quYA2uU+T71MmbBdlzNHv1sbjMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IxiV5t6usA7D9F0EmSLqND0VEC/srdFemvbh+cbZgA=;
 b=ErrhPbxuvM4OcRKlzhTqUIb3wBUcF/OFOxm/qmb6kZ4IBNuit4Os6NMW4ls5zMBeMCH0HZ4emFYlt+5uPt+KzSR47lrk5EeGJXhhHbf7sESqIJod/V2UDQNLEwwbGg1IpuipjzI2F49Ky9FXV+bv+r5S83Dyef1zuH8uYlPG+8k90v7dEqp2qZqM3JgougqQGFLfrRcUe6rgi1TkzeHcFbQkLHbbuBQHtestJAs32M0mkmZNG/GzY+dYp/drydtw+bObeEsQgJyjzQN3zu2mqWkwQkmpdjQEDpnH0AVrthn9Qh/GPBq1oCTsMKS9lzzOAkHYhHZaPYnqYO4UFni1uw==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 SJ0PR05MB9302.namprd05.prod.outlook.com (2603:10b6:a03:44c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Thu, 18 Apr 2024 15:22:01 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:22:01 +0000
Date: Thu, 18 Apr 2024 10:21:58 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, p.zabel@pengutronix.de, sboyd@kernel.org,
	mturquette@baylibre.com, samuel@sholland.org,
	jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Message-ID:
 <DM4PR05MB92297515415B77F307DFB46DA50E2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
 <20240417170423.20640-3-macroalpha82@gmail.com>
 <20240417234957.2fcd14bb@minigeek.lan>
 <20240418151650.GA1824475-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418151650.GA1824475-robh@kernel.org>
X-TMN: [+xLSvDM7Y2rYkhBmdQ3RFgm+oM2MVh+Y]
X-ClientProxiedBy: DS0PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:8:191::22) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZiE6lizBcJrA28Kg@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|SJ0PR05MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c3e420-f62e-4e93-2a10-08dc5fbb4b7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vJEmduisCrWkyOcn+gr8aXQbjO4ns75JCUCala0I/FM9SWDNIPu2MHE012xnXmKpds0Fx2TKE4RVSV/LXBW4U4dqO2jEvyWDe9RlvufV9TufdUclszmOHBrSyF9TnaR7te31TAmgM2qc/Cf+g2jDxe8h3RY7x7Qfj4Xrj0wrDaKR/RTNOGG0kK++EOKTnnSPOdM70tXnOV6Fn0dVPVuiNqtbuYxUHttMfhGF7AvAHqkZ8Ufzlc22ca3nz21j4CiuRa3My5MYZKhRBM3Wt3J+4XabuuuDY34nyWrbCa6ldoOtQSjUUfSL/O71TRtaOS7ilLsOuepjZIMmCeUyCXlvh8TUMT+ENtzthbb2uwNKMmaxeFIt5R3avk1nQUhc+Jwrdil2C2E0e0/xk+Uov6xIIlP4Aizhud6qfCkW37ONXqJw9zM542UxRJUaBa2O7z/TYy0JusK79l9kThW2+aK6AT8Ehz/K3laSKnXc1OKm/SnnCqcwt5DOujCa35+DH3SX9duNPHbeMP7tACjBe1DKnCLUXIbffzwewidUharPFcd6sHDAqSP2GZ+rIIB1Z2Iz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KjlirQv1bSpsRHI6rMSr4VCXJA7G9SoGZXQCUU/79qAJ0AgqX++1qNwjPgcf?=
 =?us-ascii?Q?5Pe+n3FUyxSUYfe1tk3X0Arwn2FILsXrAcvACyQzgPmxN+p7G0y00kXQRxDp?=
 =?us-ascii?Q?jqYdFRpKZc1hphFkrlrQEcSvkJ3QtRm/3FzT1BFLf/+STn8T1kImzjm2GF0H?=
 =?us-ascii?Q?q3RkZ69gzA20lTGjEzmpTg4FECUIfrMG2hEhFX763WTey5ZKkyxedbdGQDHp?=
 =?us-ascii?Q?kSUA7as+x93pTKNZH2Y7fr8BafzY4X2GSaDFnRhu0JRNyxeWti0/tNBNm5J8?=
 =?us-ascii?Q?Ie5b8957g1szm8fXPd409T0SlsBxf7OjsoiV1LJ1r00tPPELqaJFCmeQ+/JO?=
 =?us-ascii?Q?dMO4wqMuv4suwbThhxIzqhbYZSrN0al+OuDZljHPHrI/QunxMhzlFvkybszD?=
 =?us-ascii?Q?50nJdJx/LmcezxmbmDF/06UJ7tNuLzV5n3a2iIlMC0oIF+X2o7NDtsq4cn2v?=
 =?us-ascii?Q?0zZc0cHnm4IXo/uhFQXxEJnl3Z1ffYn/5x9JR/oumerbxwNLJ749lKMkgxa+?=
 =?us-ascii?Q?tR4VX0sMBQ4RVtXOALXJWqhclmCyYHmJYSWlyhm7BWI9SYm1l/KKDQ4OAgug?=
 =?us-ascii?Q?TqkK+YWv7HAJDJdedZjnahOj0JF/lTReuZku0TlcJhzbCJ4CzspXV+SSnsvO?=
 =?us-ascii?Q?4gDOAa5mPiABwD+jgidCjey0siPvvIhTREntwpTLNqZZeSZgU1XiYZABvJGn?=
 =?us-ascii?Q?JjkZEWkvDPqpdRtwbbTN09jsSUrdvL+TXfrtulKCBQcRhujjtcyBP/8Foiyb?=
 =?us-ascii?Q?fTR3Vsc/MpRAp3PzU5de7GSFP+rehdY5Dkz2l0xKpALlGJywKRh7Z0gAA13D?=
 =?us-ascii?Q?Mh3Kh08cLr19COpM9MzEOR9a+MwObl4R9xh4DIAi0+5HzLB1CurAPDHgC/Ft?=
 =?us-ascii?Q?64j5rihv0IuOmYh+ruUJCTdKbhJXiKctKcj7haGW3v68pa0U4yzLTF8OoFpS?=
 =?us-ascii?Q?x/+MFKo19KvgAU9v5nI1/fuBwfM8goUIVf0ZjnefRaMh2N8jxgRzMASiVlkF?=
 =?us-ascii?Q?+MkxCZ3FKJT0Q8Ca5A1zgJyv1UgP368z1tlM5GsQd65Iw4gyBNaYCAvk896/?=
 =?us-ascii?Q?Wj+IQyr72DVkXB//GnY/oL4OoukSbpsJDE3hb99f4agUKFgdQdAoJR1qd2IQ?=
 =?us-ascii?Q?zZul3027QfGXAXsgXPN+1P8vm/+DKearwGgZPP4t4/+jiC7EEUXQAD7Pl4Qb?=
 =?us-ascii?Q?ehL9FZmYPfOcCxGYRP0PZrcq6Vs8v5qCnFK9svQlThuQ4Y9/0OItfVysPYo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c3e420-f62e-4e93-2a10-08dc5fbb4b7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 15:22:01.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB9302

On Thu, Apr 18, 2024 at 10:16:50AM -0500, Rob Herring wrote:
> On Wed, Apr 17, 2024 at 11:49:57PM +0100, Andre Przywara wrote:
> > On Wed, 17 Apr 2024 12:04:22 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> > 
> > Hi,
> > 
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add support for the GPADC for the Allwinner H616. It is identical to
> > > the existing ADC for the D1/T113s/R329/T507 SoCs.
> > 
> > The H616 is using the same die as the T507 and the H700, and since the
> > T507 is already mentioned in the commit message for the original
> > binding, I wonder if we actually need a new compatible?
> 
> For same die, I would say no you don't. But adding a compatible is fine, 
> too.
> 
> Rob

I've been burned before, if it's just the same to you I'd like to do a
compatible. But I will defer to the experts on this matter.

Also if there is a more compact way of expressing this while still
maintaining backwards compatibility please let me know. Otherwise,
I'm okay with this if you all are (it passes dt_binding_check,
yamllint, and checkpatch.pl so I'm okay with it if you are).

Chris


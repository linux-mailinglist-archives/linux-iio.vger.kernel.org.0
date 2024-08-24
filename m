Return-Path: <linux-iio+bounces-8762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97895DD98
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342081C212C3
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916F16BE1E;
	Sat, 24 Aug 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OcfUb6uc"
X-Original-To: linux-iio@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010068.outbound.protection.outlook.com [52.101.229.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848935894;
	Sat, 24 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724499700; cv=fail; b=Lh9yMzDCqoXwVbmbPUyYXIDiN9YpPB5Hu343OG/e/siWMJ+fchMcM7HghJP5534gXhBVJgl11ZzIkEfMRpIJludz74prNT1voHxV5jBP+kXRkCvczR5c4h+ewIh/ONDkp28Sg4DBPoMrdJifQzre/hVVFhYoEAYyTpL7pPcVDw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724499700; c=relaxed/simple;
	bh=7SpROPr9I1f319hC2hdUSrW4EPRKNzKkarUignII40g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZUVGV11MCJjUf8zUguzUzlYz62d4Wq+uCd8bb5hRt1VK/j3MY+bHt5OizUR1E5d6cjMyeUgMCwvJzv0yFAD0RXg8KbjS5QLbUC++CQ/CvcnwW3HAGbfsxqdMHOoDSlfWprrs4izAaVYTyUpA620aECmDo/cv34BtFQc6FA1LMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OcfUb6uc; arc=fail smtp.client-ip=52.101.229.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyRtTG+jlMMfyAjhko9b70ynVczgwJpJQtP61gLcWrVgdVxD8Nhe0sKZs9M8eY4atOma8VTRQ0hvFs9Z0+8P4uur39gP9DldeqzF5+U4ODpe9gQ5bbxX967fM8ueqasYoZpejZOqhEPutuhmKoYDCODjRBi8wg3SbPxx0qevuMf1jrV/PRkxlfRfCbd5Y1HoodGoqJl3bPuqse2/+rNVvkMkbNkoqlt6IUg4Jzb619qvb6N09z7vz5GoD2jmyTKF3bhydyONLfIRWCHua2edKwzVmYXxuE+BLQGEQ2UXB5c1ci/XaAT+UKe2xRIosCxOwkfnUKBLoHkytmchfklj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsOTHylJWeKKpJ1r8pSTzt95g0j72rgDW/lVWjE3qcU=;
 b=fT5WFMlJMFOF4IRieGEIRhKBmpfygBE1hfRLHO6VNgBPudD208KVBmOMxXAbqxsQZo0a/lFvKJbg5mLwEYGpZGFd+8fYhG1IU7HCck71/g079wBRy/LBknOL26cikS1rrEuDh99AP1Ood0XiaAJXt8donPCGQcMQp7cxIFEkFaTp+r1el5O5ZvxGNJqUhaMP3dD6LhDQLemKqPi1IxJORSh/pvU+GcWa3d2mOt4cEwQXI4tIhleLwsUVHEkPHDg5dvI8+Nih4G3Ov3oOOByye2TuouUuR8hw6XaF1mtneAlVFhzj8RqIFctn7BAH2RVYlOmLPSdrHEJs64g+hZ5BxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsOTHylJWeKKpJ1r8pSTzt95g0j72rgDW/lVWjE3qcU=;
 b=OcfUb6ucGIbYKzk6o82+xhr23OssroxlT5odyZg6QPnLieuI9FB8XOdoUrWkIPF/AOkkAxcx0HJJnkx/iW2u0VkN6uIHMXwYwtXdjYZikFP29Sw+fh/X6kYb9Jw/Wtc3zvHDYBRdlChSk1muiLg1deYP0cakSEpf0JtB2cNIvJY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6621.jpnprd01.prod.outlook.com (2603:1096:400:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sat, 24 Aug
 2024 11:41:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 11:41:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"ang.iglesiasg@gmail.com" <ang.iglesiasg@gmail.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"semen.protsenko@linaro.org" <semen.protsenko@linaro.org>, "579lpy@gmail.com"
	<579lpy@gmail.com>, "ak@it-klinger.de" <ak@it-klinger.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts
 for BMP3xx and BMP5xx devices
Thread-Topic: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Thread-Index: AQHa9Yi3N0/xkq9oLkegv/effaOazLI1L0eAgAEX+QCAAABXIA==
Date: Sat, 24 Aug 2024 11:41:26 +0000
Message-ID:
 <TY3PR01MB11346D61FB9088AE3C5BCE2B686892@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
 <TY3PR01MB1134611B456FEFAE4E4791CBB86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20240824113128.GE9644@vamoiridPC>
In-Reply-To: <20240824113128.GE9644@vamoiridPC>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6621:EE_
x-ms-office365-filtering-correlation-id: 8fcb664d-6df5-4216-047d-08dcc431b006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q8LjPMWT1cVj8LGph8p/Hp1tS4wL2tr/IqIIO29rDZUbLdCw2tkSFBP97TnC?=
 =?us-ascii?Q?25f8rsYkCJdYKA7oWp7hW/fXL04WodA/greM7QvFjDPzi+6cF/D0xmsNdqhh?=
 =?us-ascii?Q?pMvD3IyM/YDud4FgbNh9VR0YCWO6peodYbgZJE9dO38mzQtmxbqf7XjruTmS?=
 =?us-ascii?Q?MhoiQmEfNsqRA6CZHmVvxpEhipSx9QzXy+7UlPqzPyMVliHzeY4I4B+VPFJ6?=
 =?us-ascii?Q?PoJyiNsYX9D1yBSS6oiq4jsalgabL8S5vWZZTaPYlEM7NHRgenybvDw5wzDj?=
 =?us-ascii?Q?4+EdAtigc6aWEPZ2+yE08vgmYY5CZ/BQwYfv25U3VhADdyv2Z4Vp7wh+dufF?=
 =?us-ascii?Q?bolS8uv9WU+pxhIA1qOtz4qt4LkKzCUMGj53n7qkcYrEACblRCDWG++xBk3+?=
 =?us-ascii?Q?0FzmK/ANU3FHq4CjobldGpJBVuvxb5A67hsAXqHDZ7hzIyEh0dk2C4DikA4n?=
 =?us-ascii?Q?WJWG1cgsgwNbUh1mECM724l5QzmAsaLTaw0MQ7xlXlu0GQxO6xAwvvG+Bps6?=
 =?us-ascii?Q?FQ9MucJ1o8IKVeG2iR0w3Rw94r4xiKnKzH0BggOp4kVDEywWLAwDbQqbpz9E?=
 =?us-ascii?Q?MlzsOaIIynkY195kEdmDylByp0OwH63147IAEiAq0l1Up5VAuO25d2emrDGH?=
 =?us-ascii?Q?eazj5as321+89JYGZGGW6mXo6jbR9mgou5HER9lmMVZySwpUKwt9fpkE6VBj?=
 =?us-ascii?Q?Do5bJzvMUkF7WcSsFXQzpWJUt1t50akYuCLGwvCxuE+NNdARYfUdUCY3j1V6?=
 =?us-ascii?Q?YBLFHr1z1zNv9HZJ8RYEOOmkl4h3O02DH4ptIGK7taN8pl5APaCrgDhg71WR?=
 =?us-ascii?Q?5ayO7/WH8S3ersAONuRhBl/HavPLnciMyAPjmeUn0VS64cGzjeyDgI6Uxz2E?=
 =?us-ascii?Q?8FzQu9s5OJYs1PZrLPa7fit3SdppPROLR1FZ6Kwl8xc5iPCrQ0UbXGxz8jPm?=
 =?us-ascii?Q?dbxEe6mgv6R669bpkIvaoK0MolZu3POncTvw9IlYunK7nisGrDa34J9dz+oT?=
 =?us-ascii?Q?2gQPCVgmiLJSWM2Bly3Dczr7TGQHJbWx1U90Ne8QRdATc3YTgrcRFeye0FoJ?=
 =?us-ascii?Q?hQdSt/ryo0O+vOJDID6qgTuXzHGVK9zkyCoexxVsaVrMhvWM+6aOKfgjV0MT?=
 =?us-ascii?Q?bv+V4BRKXLU0bFNru4QCtV0MjMZ2y2jIuPYtdYwH/CxaGRytXRCw9nUx5TBE?=
 =?us-ascii?Q?GZGY+UNX9QzI75S6Lt7Mjs28cjNDKhdugv/KIZ4dUzYXQT8UES0Q0t2ELGHx?=
 =?us-ascii?Q?BI1RCnglWRZDQcNP0e0gHRKy7+lHtR1O4FNU+fI+BNsR300WpA8+8/qn0lG9?=
 =?us-ascii?Q?camwIFMq75KEJjGA/WTJB92nTeLF8Pptxdg1+gzHXx2JCxP0TSHUq38W3Txp?=
 =?us-ascii?Q?0JoNN0oBQ0dC4u6zCN4dRAxVuO+u7GV+WDK5U9jSPZ+MeQSK0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vr/vO2vWDi5BbDKzUJ2CmtSjrZ/9XbxFR+qr4MHnE/x4PTzzLENFf3aAv+d4?=
 =?us-ascii?Q?hpr2zsUHrtM7YWvqu6feJYJBeI/IxVkgTiXLtgFP6nGbbMhzHqb78B9kmvN5?=
 =?us-ascii?Q?qEKezWy7lwE6OFNd7rb31J3QAvjp1kanubtgxyCWTOt6ZAZILMUNAw4BGfWV?=
 =?us-ascii?Q?6p5ie10X2XXJ6wecFpi2Jn9I0oAKHTJUxudYqYYK/L5GToq1RW4yZmCPs2Fv?=
 =?us-ascii?Q?Z1szjmFIAhvjPpB7kopU/HljERnxYV9OTeXaLZYLt6G9O2wBQ2rQuQeCNCp0?=
 =?us-ascii?Q?r2HCe29v69wpo5d5djUwh1zseDA28uOHMpK30uaXDMAGwrqSOw++ymHKIq/Q?=
 =?us-ascii?Q?FEz9Mmqd9HDxTRsSUSucmH0khXpuw8nfvrZdhPHjt8L0YC1uCVMp7DlWW4gc?=
 =?us-ascii?Q?QFLwIV0fgHj6KLiJ5zP+f1tPT1loOLWhOBqTXHvOD6a4Q8X5VuxyzlY6U13i?=
 =?us-ascii?Q?EpIZr9NQozZHoWdqNg2EJkuAhC55Hj2XAtGG4Mt39qJ4pp+ktLdyM4XqYBSE?=
 =?us-ascii?Q?NGyM/pGCPmquQQcU0TgJNrsjFzqBUDQdXKQN2J0hWoOsArcJNdnI8wfloKcb?=
 =?us-ascii?Q?gw0j1NxPBt/uQxQjeNPqnTKdw/8aabVaU0Ez7a5UoT30i50jCEpgKTq8aInx?=
 =?us-ascii?Q?kMR/whQ0kIibO7PloIJ/HucrUVhtmdbTrstPsqAhR1sLoEmWQmaCqeRBQRii?=
 =?us-ascii?Q?rfzBPDUnNlMHVVdT2GWV7SVF2SDz6GETwa6Eknxmy0EnJQ7D+nhGj67qdbV3?=
 =?us-ascii?Q?Un4GypJityagDUMbjmSESPMVeuj6yVwHA+oWWx+SeDmflMgHyEuUSIRnrVYz?=
 =?us-ascii?Q?ppIHv2I+u9OkrtvgOwuJGFNNSJYlwuqXyCtj5D4BM/ZdzQpF77YGdq5bByBZ?=
 =?us-ascii?Q?ay02gKnnHSSkD6BHKQ1ZmAWgtoeFEye1Nzt8kB39lCaACZ5ybQNSRL6srZGS?=
 =?us-ascii?Q?aFHmednmUpMNRVGN+cJjn6zc9Q0BYonQANfhpGZZi9H/21R7W+mujpE024Kw?=
 =?us-ascii?Q?pRI08qrMeVPEYoEYdlJHj+6mkNSdUhcmfbqa1fHgDI+DrFzYjFlYjBpk9kje?=
 =?us-ascii?Q?qFXd99Dz0v9psSKRq3X51yzH34/DI0xuuIMSvdM+buDVC5scYhiYVxolikyd?=
 =?us-ascii?Q?wbTKC0hfB5qqXVRdtgZXytnUb2I6ZDO8jR2gKmci6HNbWgyshbfzgvXCenzq?=
 =?us-ascii?Q?Rz9CJluNksa/gwEMCQCRkhHI1VoV7yef2aZKlzJvH7aHUoiEmnNrh71uMTcN?=
 =?us-ascii?Q?V7JvcQHr68hccY+HFvV0t3f7x13LF+6eNBw28e6LsbvLN/JAWv6ebmju/Prr?=
 =?us-ascii?Q?GuQscOHWjWoBkpC+wlLRlIQAQoNyTw3/an0L/qbzaqNWM0L+4Ah20rQHNsno?=
 =?us-ascii?Q?siX0ZdDVvKPKhs8LGc6oFuPda33BnqQLirOR5QUTTkQHYhVrSanIjTypcHTa?=
 =?us-ascii?Q?FB0neULkQzbtnpux5+DPx8aQywr9KV/pI3qxEtlwe5+iIFJVSfJR4ebwyj4H?=
 =?us-ascii?Q?1+7FuvduRTSSHWVqbvM1od3rOKbDaiOSHioOiv4BpBJSDTXzGkHvbHhiCV23?=
 =?us-ascii?Q?0CoOXSdRTzzHN8SFM9h4R6ApBp9KOp/PX3Q2aI7X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcb664d-6df5-4216-047d-08dcc431b006
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2024 11:41:26.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMB0dXw02ux19SPyxYL44gWni41XTjohj8Fw25ZJt13GR2nTGUGwB2ZGm8kuEAExyYeb2N1iSBkdy4eo+sx/3kyanz5bS73fh/m79jvYux8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6621

Hi Vasileios Amoiridis,

> -----Original Message-----
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> Sent: Saturday, August 24, 2024 12:31 PM
> Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add inter=
rupts for BMP3xx and BMP5xx
> devices
>=20
> On Fri, Aug 23, 2024 at 06:51:55PM +0000, Biju Das wrote:
> > Hi Vasileios Amoiridis,
> >
> > Thanks for the patch.
> >
> > > -----Original Message-----
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > Sent: Friday, August 23, 2024 7:17 PM
> > > Subject: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
> > > interrupts for BMP3xx and BMP5xx devices
> > >
> > > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > >
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7
> > > ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > index 6fda887ee9d4..eb1e1ab3dd18 100644
> > > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > @@ -48,9 +48,14 @@ properties:
> > >
> > >    interrupts:
> > >      description:
> > > -      interrupt mapping for IRQ (BMP085 only)
> > > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx,
> > > + BMP5xx
> >
> > Since you have updated the description. It is better to enforce the
> > same in conditional schema?? So that dt binding check throws error if
> > interrupt used in bmp{180,280 and bme280}.
> >
> > Cheers,
> > Biju
> >
>=20
> Hi Biju,
>=20
> Thanks for the feedback! It is true that it would be good to throw an err=
or in case the IRQ is used in
> a not supported sensor. If you could point me to an example of another se=
nsor implementing it, it
> would be even more helpful, but I am sure I will find something :)

As Krzysztof Kozlowski mentioned it depends upon driver(s/w) or device(H/W)=
.

if it is driver(s/w), then you don't need conditional check as bindings des=
cribes
hardware.

There are plenty of examples for allOf:if:then:=20

Cheers,
Biju

>=20
> Cheers,
> Vasilis
>=20
> > >      maxItems: 1
> > >
> > > +  drive-open-drain:
> > > +    description:
> > > +      set if the interrupt pin should be configured as open drain.
> > > +      If not set, defaults to push-pull configuration.
> > > +
> > >  required:
> > >    - compatible
> > >    - vddd-supply
> > > --
> > > 2.25.1
> >


Return-Path: <linux-iio+bounces-8732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5695D589
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D412A1C21AE3
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27DA191F60;
	Fri, 23 Aug 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KtIUEpSX"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BF2D7B8;
	Fri, 23 Aug 2024 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439125; cv=fail; b=WPCvlygwVo8BWKXzTnCVpGnQzuODoZF4DQ7fkvm292fYWI448HBos+PBSBvlHPJLUljY2+C2p2fjPb5i/yfMzAqURNb0+mYqiowTe3hDHxcjhYwR5oPZzasWz9H1Bjel+Km4xu84wYFr0NRLo4bfS4JnWx4cpmRyn2VOw2NUgxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439125; c=relaxed/simple;
	bh=Dl5QHfMeU1Yzz8n9FNm4qwszGiFq9zzgngSyZEkX8qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adJxVj1jeNB/UFRRLNGL2bMbE0nL8O7PSNXKIpzbGeIAP1P3wuYHIGWLOIPGJCMM759Yru7oeS/yMivme1feXoR54D5Bs8r5a9GwQKFIRjo8oX8tSvUf2mCx+8rihR9iCVM3ikcRiItaFKezxOjCECp8xFfrxoz0N/CxQ+4fX1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KtIUEpSX; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN7KSfkbVMyTO5uXP/Gu2YgGVA7uzCI7hQ3rxlSQj7skfwVO3oDmp0gxhqNjMrWVWZxHz0fLY2HcerqRQYFrXt3cqht3Lzu4x+G/1kWzcPyTQds53RkrMZtJvMnqq4cD3L4Y57us+2JKpImF7WIuf3joK8PxfZenY3m4cjbk93vXcJG4vZpBwZxWiywZBpzMLbsAWkOKuNuODytADS7cvbHiA4rVAL+1tJjD/eSLfrFgYAmr8ktKtxsozYBLNQBuvk7J46d6wDkq2uPHK0+rGZ3Q83RG7q/4m5YZJmzKImlQozgYELf/EqAN6CAP7wUNKLn53Vo4N1IeO58qBzlVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmn1hejPnxTs0ueYK7JAsgLDAAvzj07544ibsfnTxAE=;
 b=rRcsE5Q/QpB3+Bt/ZUui0RcqKO9qwI21bX0wch2pHIpTj0rx/6AHRZt4jrCaTnmm18XKn7pOLncUIf4hUN74rfKI/hF1uSrWtDcAPmizAexb8aqxq2GQ6rWK81cLLEYHskHpifmqwsaq4CDB+vMzIj03epC36G+rUKCRf5dxTsHJ/1agMkuosD7K852ZVKiNv7cVxN3NckGzoXsbhJ0Z6svo4/szfMOUjZPMwOr/amuZmudZGSboBacF6QUyFvAlcKewjZ8jPxlk4lG+h9DV+3eKbDISDFZU3s0mA7AY/4J8/V/jeQcKgBASS4DimEySGdlPeCIwRHDstrguZG0mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xmn1hejPnxTs0ueYK7JAsgLDAAvzj07544ibsfnTxAE=;
 b=KtIUEpSX64zhiF+aW0uwraeV3dyd8GRrFI7+XOZJ3PlJ8CU7wCqlzRFkaUBqJ4jQIAE51F9/dOVAo+xFqqW8Z41ux1+9B5ypjKMB/VttTuxXa6/3FQzJOw8mExqvbshX3AAsr92+5SkhFiEVwEHcIwObX120cTDNyUjIE49lubQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB11437.jpnprd01.prod.outlook.com (2603:1096:604:234::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Fri, 23 Aug
 2024 18:51:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.021; Fri, 23 Aug 2024
 18:51:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "ang.iglesiasg@gmail.com" <ang.iglesiasg@gmail.com>,
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
Thread-Index: AQHa9Yi3N0/xkq9oLkegv/effaOazLI1L0eA
Date: Fri, 23 Aug 2024 18:51:55 +0000
Message-ID:
 <TY3PR01MB1134611B456FEFAE4E4791CBB86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
In-Reply-To: <20240823181714.64545-6-vassilisamir@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB11437:EE_
x-ms-office365-filtering-correlation-id: 2bdf0d23-6e83-491b-743f-08dcc3a4a91b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GOw4mZIkbr3Ke3BCjY7hZWbe9XXWzHnSZbVpvaOmgv/oGYl2iuD4f/4lkl51?=
 =?us-ascii?Q?KsWKMBAtbuJfcw9Iryo0IT3ixin3C05Bmburgmz5L2y4Plw3gFrpo8q080F6?=
 =?us-ascii?Q?TlapNNSPLJi7OMcV8sDE1BcDCRAhuAgzhXye+lChPlhxR2l3SN5YiDkkWTuw?=
 =?us-ascii?Q?l3j5kXsIGSfAyWJryR6Us0KwqkKQEC3ozleClKVAGnmBDPFubwnXiKZtXaJm?=
 =?us-ascii?Q?lpek8O6B8txXHDaMAOxnEW7fyjPePW4452paXrh6vNz59eIKjspB3yqBpGZh?=
 =?us-ascii?Q?ljxVCcfQStf1bOEHxHUfEqIujmWqmLHZfTy0YnfjakXGcDy6OCIXXX7rbvlB?=
 =?us-ascii?Q?rYi95GI5M/k9vwuilBvyQBogMPc2CT62lub1oe6LRa6GQdAuGT4eeOARp58x?=
 =?us-ascii?Q?6VG/os5MCnxLxNxhuUpLfJpqF8e8IxXQAkxhemIkMC3L8H5eojpuqLOGhup1?=
 =?us-ascii?Q?BVIMJJj+6+UbUnFnlFnKmoSs36dD0/z8D8f2Ia8tZCIwufqodr9+mWkOClEE?=
 =?us-ascii?Q?aZiAou1q/VYpbVJvU8+iX7lpcbc6VbrDQsktxG/UyrcRdK2iLGuIWD18iBwi?=
 =?us-ascii?Q?shem/k04Lyg3vGdzhu6RarMckeSEZcp/lbf8Ky+MKWMwfAuW3htdtyfyj1Hf?=
 =?us-ascii?Q?kc+eTnPXHrZDGCjN08Fs/ymBI22qoVw3zsGG9Xqo6IXy8bYf9ICazEbLkOCQ?=
 =?us-ascii?Q?18SuV7MydN7jkxSvRrgoC0Qe/DqGFY9FBfvQTYdqMhBn24DYY8Ua8LTleo83?=
 =?us-ascii?Q?HwkC9A6xllIhDAusl9bAPDKn0mt1eH7zUlPztk5m5HJVrjwnK5lKKscypgR6?=
 =?us-ascii?Q?0zfVECMzur41B/yGjoueVtNR+M2aP2ZgQMNLq9Yjkr2TcJ+UdEqYG42DBrWU?=
 =?us-ascii?Q?5wJ8F9znSM0fOY8qTHKpLcqVoyq4j2gl2hHFwHXHIbXNg76xLgv7qteBbN5H?=
 =?us-ascii?Q?QV5yZd8G+wJ0UXJUkMEZe6/wFFM9py65ftut8znOqzg/x1V+Hygraw/GFCF5?=
 =?us-ascii?Q?2jUy2c4BzsKq63oAHwsuURWAIQZELd6wkSNlpwXcU4EBHbx+r2gSgvycfdN/?=
 =?us-ascii?Q?Ht2xUx1P6eLUBvS8wGPqv/mVUG0KirjM+SD2ETpwkoP606zHR5vQ0lXAe6Yj?=
 =?us-ascii?Q?p24le4FS8D+5R8+iOyQAncEVXIqmsD8vqZFQ5uzBMOR7DalTEGGkvSOsoZcK?=
 =?us-ascii?Q?rjjip3yEu/svyp7OYef6PmWcBJ7x2V9r4n+g304HGVUh1Z3+G8+0MEDA+Bcu?=
 =?us-ascii?Q?n1JNQz5jaRNXvzr2p2Uy625LUuBT8HlzvrlRcl29JFqw1tY4HEr4Zz5aeQpd?=
 =?us-ascii?Q?yTCyCGn9OaGZ1VGpNqvoBKjAcf1BMP71DW/bgCV92sb/rrfxRx0Ky2eg3m9q?=
 =?us-ascii?Q?SVkE1IWTXNs9dG8Hf/xlC8BwWnxsJwFPxHQ3vJhJBczpOpZJJA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0j6HpZxQUoJ/i2bm/AaBPV2FtRtXp39CZgR224YpjwLLVcUnte+EQRfpMNxZ?=
 =?us-ascii?Q?hdXvO+i5Ug55n9ZpFsw08mCG9x+lDI7QQnyL2w3jBLvoqnsxzVmMTO2bNq3c?=
 =?us-ascii?Q?NT/T0wd5LDEImSDzGqrGjtoB8g146KzAeHZGSWOCMsI1UnIAxYcUDQM2YKNh?=
 =?us-ascii?Q?d+IUb2qWfdkxnhSAXyT1TmjCMkHecb2m+VGlycO1FW3exzDEl7lelF7av+Ay?=
 =?us-ascii?Q?8C7IstvAWFScpunde/4PcyDu4i07MO2KxFqw914TaFcUuD2BEeQKcHaCcnj2?=
 =?us-ascii?Q?0Z9rpG6K3pz/tYQhuQsYtecWI3q0DwMzbduqC3HVZQ4f0SnKptwJZoMHAJA/?=
 =?us-ascii?Q?o+e3GO4SOGlKwYJHw2+UDRLg3TpjFARuHUGK8Rqwxp/Pz2LKI+fTzcmM7Ofd?=
 =?us-ascii?Q?b64XX5asvdsDdeyWDAIjYD01gTl6LNQjluC0C7uymZhO+VR9OQIeJnwJ9AFV?=
 =?us-ascii?Q?p9n9bSuBu+zHDyGHQNzXDt3BHr2kirwT8eltyQMafnDpaZcOkLcg+EMuBkRF?=
 =?us-ascii?Q?+QrNM/Xf0TnImp00QXvzl0YENb4cel4sBZ+iBKPaLtDmnBtNhH7nAsXZKb+n?=
 =?us-ascii?Q?6H70RMADN0lZBrZjJRcoU26rOH3i+qc59vzpaDv1BX5C9VPVRD8fGw/9K5sr?=
 =?us-ascii?Q?OViR49gVW+4JNySt4kedtsgS/LIiou584tMnm9ktVM7vEHEBhP7tlv+qMdYW?=
 =?us-ascii?Q?CG6uxqVTwLawPA36VHw3VfpmRxyI8hOEsy6xEvq+fgRBlJFpiW5xwgfv4g1t?=
 =?us-ascii?Q?fNqJ9E3KOImsFMvCZ9yNnTHlBHsYsnUtiKBpoCzjX5AQYXa/eMImXLHrUWVW?=
 =?us-ascii?Q?8352YHVZTvjiA1P2kfjjAi6DWc/TMEf3m0/z26U7qliWzgTweUcQ6nAE2RVk?=
 =?us-ascii?Q?fblU9Oa+sn/Whs0dTpsTpI7in1gemz5HZxsOaKRbJCxNyBDc/NSuTwWZkFSs?=
 =?us-ascii?Q?MmhLZs3rNVce4ai48xE2Jl0CLtwOS8z3D34DZoSPlPaSS4DY5PvIz2Cg3dGM?=
 =?us-ascii?Q?UJ7fLwxBTaAKx1q8GnGKxK1dR/kp7bXlALw2vL8YvmM2Dlldl0TsAZA234qn?=
 =?us-ascii?Q?Vep+PT8/ECd5OLQt8GVT5cl2HeZWq2QLFa4xIc4NFCRJeuWJGS56UYraJ0Un?=
 =?us-ascii?Q?b1T09q1c9HO+5fK4MtcDK+2WCvtiurRDPb8kh50nJYAvQcVjNrD0zk5B+BkB?=
 =?us-ascii?Q?Ea5NOxYY8EheSuxS8vtCeddCvUyeTUz/SEpoAkWs8Dj0CKzywVB29FFzpnUC?=
 =?us-ascii?Q?hF7V6KeGTaANXzrkcJsAFZvWGjjvCH6EcGbTTpThhBitXvwiR4OB96WdhgnK?=
 =?us-ascii?Q?sAcppbBFUMzGF+RzIYxpMfOgGNqT7KilTkMLU519isguk+2G4az9hJov+z2J?=
 =?us-ascii?Q?yTQ2xDUFp0pSF7GjVbaozIM3qiixp7l7/Rc+II5GKTd4nsxfBp3aOiVNmXef?=
 =?us-ascii?Q?ciSowbVpspkAcQDEWbHC0sxdYSfSz4QQaAtB5AGH36SukW4HQP1S+swYDdaR?=
 =?us-ascii?Q?TAZUp+Q/aeKNDqKiWKuaSoWyf3jw2G5kdOVQFF9nICXutGhbaMVVUzifFkH6?=
 =?us-ascii?Q?09NiI9VcVZxK/48Y1xHlTSZVHkjgn3LecfR04jSphFeDw86LOmk5P7WvbCWt?=
 =?us-ascii?Q?jw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf0d23-6e83-491b-743f-08dcc3a4a91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 18:51:55.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbyYzmZnc5zRlBYcJKNUSulI6Xc/BDhQk3IBU140CHQGkExZ7E6FoVT/7e7imPcFwjJnSLRM5BOZovjKeSU9lRHZynWQtk1aP65ogrucQ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11437

Hi Vasileios Amoiridis,

Thanks for the patch.

> -----Original Message-----
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> Sent: Friday, August 23, 2024 7:17 PM
> Subject: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupt=
s for BMP3xx and BMP5xx
> devices
>=20
> Add interrupt options for BMP3xx and BMP5xx devices as well.
>=20
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..eb1e1ab3dd18 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -48,9 +48,14 @@ properties:
>=20
>    interrupts:
>      description:
> -      interrupt mapping for IRQ (BMP085 only)
> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx

Since you have updated the description. It is better to enforce the same in
conditional schema?? So that dt binding check throws error if interrupt
used in bmp{180,280 and bme280}.

Cheers,
Biju

>      maxItems: 1
>=20
> +  drive-open-drain:
> +    description:
> +      set if the interrupt pin should be configured as open drain.
> +      If not set, defaults to push-pull configuration.
> +
>  required:
>    - compatible
>    - vddd-supply
> --
> 2.25.1



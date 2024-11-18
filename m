Return-Path: <linux-iio+bounces-12377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91FA9D1278
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC7DB26922
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396F1AA1FA;
	Mon, 18 Nov 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="54VEXfs0"
X-Original-To: linux-iio@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020081.outbound.protection.outlook.com [52.101.169.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA901AE018;
	Mon, 18 Nov 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937390; cv=fail; b=D2EZqlEbmgfXaL+/8rjuHH5kI8kDyhWN2go6DuH1+4YM+Zf1teySn4i151JCuGqqRTit3Lvl7+KMo3Z4YC6CxlO/x6N5+ccVMH3yTeIDQvox6z2sKHmZ3Y0k+nPMWFCXSJzHA3UUiatxlRJrEzBVT2AnEeJQ3ShTLlpiTy1XifQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937390; c=relaxed/simple;
	bh=xoqZH0iMkpW1bDRt9SnQ7dS3ZVhtVyGTkC+gYE+3xFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TckC9GLgvjxwYUSF7v5gNjc5cvfq3Tc+oPomvOPqYbv2NPwMfTO8hLsKO09vwjg2EOceLrr9svwF/yRTliqwcxlxHA9FTTkQ3/VHtVRfE19c/FApfSFE7pRT4XxMbtX1NQE7/yhTfugBlHEweVcEfz4Lnohn2rkdLdNiJUvkJaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=54VEXfs0; arc=fail smtp.client-ip=52.101.169.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMEsNWDmnQR3HrAoQKyLXpwiPrJ6cbIodw3Dr983R69kq3S12xuLhxCad5W3DvL9YqyLSt8CZn8O+NE8puX71VqYEeeK+SDG8X00MycxS2u/06JgDr6qd6IYoQ61iF+mSwtsoykbXn0uHQ/PKSWxUjqS8OxHNZ4yYTYTHV9FDTD3WPwykytiUNQThwvx2iMPo5WPrcFZJayBmPfNsSF9ZZRLHjS1KJsdqJHqxHL21aaMuuAUdBRSxfD0b2m7uic7LKdJkEgC4H/VVEo0CgUkzcFusvpOLM940O00NFYMRpM/qjIXGUlu5SpXX8nY8gPNsSF+ABDg+t1EATAGOkm4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElFMmvEkGvLWHm3I2T4Th2gHGU0dL7dKvZFAcA8bQgg=;
 b=W5WPZjASa2umLtxUZnwI4gz3n0aJHnJKfLqIINCt/sakNEJnGW7GwGjZjdTaOiJTbWBA+EoOyhPW+mjgdIOZmtDRG8Toq35/2A7IRfodWAf0jMyZbzLUQ93hvyfW7kFIAGwqFY4K9IOOakQyEMV8O62KgUDOXpfdA+mKgorNEc3m1it5if1K3d3vEFVLV98rWhf1d9jGBeRV0X5cdNC4H+M4qE5qyjVJR/OHWXF8/AEMLwN6dgi5hotz8sNefYEiLcQTtH1m3dc/uPNu3h95JSSUYO3r4dxO0Osda7cxjhee9RCh8SFrhKs2fUH5pApIbDC/lm/L2vfT0rJRxN967Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElFMmvEkGvLWHm3I2T4Th2gHGU0dL7dKvZFAcA8bQgg=;
 b=54VEXfs07TrruSfNfNuEgeHpbbZ/NyjWZQL/HoXtUeaO37bdvSLryDUqqPqTzHy3qtZb0INzfNhe6qdPgsoj+96BSJPci9tfu4rTyndqUaGTIx7tf/IYyz3EVjOY/K9ic6qul134G1wmHaCFn2lbWuMbcsQXbrs+RYAMrd7feZ0a2Yil+589ywOp/OjY38d6cA81L4M1jbucfEkMnzJTTi9OisRRoXle6EXbIiVUsgr1smPrqSzzDMy7SJqoy+P0QtjZOL1ER6W3Vmh7NUaXEOtNwCsJEm6V2MGdzHggw/psm9EfB9+oBQeDE2F3CJj7nf0SlJD9MhaVSR8jSK+Rgg==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR2PPFA8ABE82B9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::7a) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 13:43:02 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 13:43:02 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Thread-Index: Ads12IHP2U4PDLQ0TyOYbwP76vIxkwBrHX6AAI60TzA=
Date: Mon, 18 Nov 2024 13:43:02 +0000
Message-ID:
 <BE1P281MB24200EE5C1D08DB1C330A51EEF272@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24207662EAC941780807F88BEF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20241115173657.GA3440948-robh@kernel.org>
In-Reply-To: <20241115173657.GA3440948-robh@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR2PPFA8ABE82B9:EE_
x-ms-office365-filtering-correlation-id: e0d9f0a1-f62c-4736-a27f-08dd07d6ec39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BsU3g+uo4qPM8+Frm2UqrpUCDLtgrzYZoxbxWU0/E1e91mOtQ+nNfje1pMPi?=
 =?us-ascii?Q?TBj2mwRMON6Sbau/CZyUVI+3xZ7s4QqP9JIDgXIHbLH5xt1crCOA1Cc9Xvx9?=
 =?us-ascii?Q?wRz2lAdECfMrPHo1FV106KPOUbLtawo3z06gAdaohetUqbhvsPzhkMq+OK/I?=
 =?us-ascii?Q?tv75+YuKGpWRAvWnZa93yqhAfZj2KOzN0J51prtT18VpmCjeir3WncvicPjS?=
 =?us-ascii?Q?gStYugeo4+KLU1qCVP25Ud2V3q4vMdx9Jz/2XAB+6D2w9zitshvveU5UmCnz?=
 =?us-ascii?Q?9VvE/dhFZ/a0V6jJwPidzg/ZRfdq96JRyHrsmMVgXVxnnFQQZMihsbInOyR2?=
 =?us-ascii?Q?elRsz1E7iCKDqh4rhyw9ZoRu+uOUmm21Rbz1nQYtpDt1m/lTA+Gt3ievy6z7?=
 =?us-ascii?Q?7/aqJ5EPECW4GLgSEYavP8w1XQ+M0i/8NcrJteLmJADoqxuQHAP5Y4u4w/5Y?=
 =?us-ascii?Q?SLjeLhjKIZygFP6dg5jfUmI/1IRlRrnYK1/eC3vVNGfHKvx4qLZTQ3qo/F6+?=
 =?us-ascii?Q?hv1cPk62iTaHeRwi4UGHP6RXmlUpTATZgahSZLJfQ5cFMBA5KZgw7iq9Lim5?=
 =?us-ascii?Q?pqqqnkfpUJK8SI8Dh3kSdb/g5QZhExH7Law3xCSwEb03L1+S/M1lJLswFr0R?=
 =?us-ascii?Q?kXinDMyoqbsB1hgsDwRxwmWqrlJ25bxrrDKNk+6+k8rafddSv3pF5SzxYz9I?=
 =?us-ascii?Q?hFTaqop5dz5r18Jp2MaWQskavDUQoeoc8l1KOzYxsCPM8wqAMFRDjfGeod8l?=
 =?us-ascii?Q?M33I40n9/SZa635uyJg0uNoIlYNMK/z79tPThm6wCT0JKcBfHjVWziCMuTNM?=
 =?us-ascii?Q?Zx7IntdcHOUGJw8YLjM472UMuOOSUezN0Hfd2gdbknG3B4100BO8okY5oVV/?=
 =?us-ascii?Q?jh8n6uj603EhuXMtLLgdZoTUAWXec8koGQesG4jzQxb4aKwp5RSLYL5VRmXT?=
 =?us-ascii?Q?SGNI2/uFlSnI6gi1cs867DozJXW+4sPrJWH/U2+5BIX1VdzUH8keGwKdVZzm?=
 =?us-ascii?Q?Pxy8QfWokGkL2KCzRFKkM0i5wuJch0pwiwD82vbA9cvCo6P1DTSyDK+b84I+?=
 =?us-ascii?Q?XIqHiJQBSDtWDg4L5sYBHrsvLo+flrIxzpcITEGHmgKCvRyRXWtugPcoGIsD?=
 =?us-ascii?Q?EwkV+MuJFoBq4m+XIXT4d/0jg6XhlrrsBD1jstubMp6RytSXn/fKdJV2B2a7?=
 =?us-ascii?Q?B6BkIKFLcz6B/VFFZ+53A4zJje473G1zyGTlP9vxmK3XqwkE9rbwM1C6qK9G?=
 =?us-ascii?Q?JbfU0LCnq7vvS1sTNSAMQfKaoax4OZ2ZCxzktFPtaL+85M650EJNQqxQ1Yai?=
 =?us-ascii?Q?E7twPg5x+6u73KyIy+u/dDtt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y9e+4Wzh2YDrWy82EiLjZ+P5pxNdJqJE3iVhthYnmyJZiS4wS6eIAD5GaBRH?=
 =?us-ascii?Q?f40ubJXKIzZtYVmobKIjoTO78dGnR4KToiAQKxCv9aE2rrz5kF6weIPZvDuR?=
 =?us-ascii?Q?wOEXELLzpftmcrJFbJiPw5Es4XkL4k1FWJftNCLforC/RHxaiJH0eX/NNYtC?=
 =?us-ascii?Q?rJm0xmqq+IXLEKuZX7wmE5NvS2usqlM9kYAUpH6EAIadr6I3oPAibigRM2+M?=
 =?us-ascii?Q?PgCjVLtxPFL1IPaR8wXTHWUVqYfVItGh/2tXHQNVAa0gmGNRDWlTHzSe5D4/?=
 =?us-ascii?Q?PZEvXTk6iTDPKjlMnpuKLwQEdmn/5P9hlcTwKPakQqGMdxARJ2iJgj9VeXFH?=
 =?us-ascii?Q?YbBGjBD0TBRjoDrlhWiMHyjD/TIJqNb9g1cPtICFiQx9MYQuM5WSxxZlLPTS?=
 =?us-ascii?Q?w/9qTxuyEWa2W/3Au24zFDJn/CicvAdb+iXAP6eFwaLvGiAVfgFV37kXLuqb?=
 =?us-ascii?Q?Z6I4c3BGu+h67i7h5S5iP3ZBNXutBc+Lmg3xu1VqECx7j67gvT+RikXKbluZ?=
 =?us-ascii?Q?HdWGwhAubFO95WfLje+Ls+UaIPGbiMA2+XlYJFkL99BRA873Ocy+QWaDDkSC?=
 =?us-ascii?Q?QNGzdpLxQ/T7oviqn611Ptm8Po01TFRjumdojpujOCowi3qyN34KmLemHTxZ?=
 =?us-ascii?Q?HfQ1FvmAT4r2G6abzZhQH51y/J5B2KPuseZFa9ieKpbwnDSsSsyorCTd+MIU?=
 =?us-ascii?Q?Wh3dV+6tOstuVm0hp/zh5RS8J89J/IQy8xwrUqfTgWV1qSeeHsMkTdq1vLTR?=
 =?us-ascii?Q?EzOUuGEC0FEwyl/Mg17vFfTJiK59PEcqGz2Hhaoa/PP1GjG6QjtZWVaZSLzl?=
 =?us-ascii?Q?xh4oSR6zfP3Yrz9Tcu4CyGMoq9GothyPSOwND05BhkHE8hQ8hcFt79WO40Zu?=
 =?us-ascii?Q?MMeBAeJq3UsuL/uIrntucYRzhIAogERyS7A58Nbhksi/La/5g5BpmUIVwXRb?=
 =?us-ascii?Q?ubQWMbdtjiInqU8tF1P/KZh6NG/Ffhc6zDweLIn7wntkvXNceQrpGwOAltPn?=
 =?us-ascii?Q?/FnFjJXPmwGz8f3ki9wkCfIn6IqXeYBvMRD5IMu+nCSrbfymeSKNDyXB1Ap3?=
 =?us-ascii?Q?iEt4SPqYzqRxFe8+lkc7G/v3Y/jA8h8jp5LD/Pe5eaeATcSR5RAHCmoZ9WU+?=
 =?us-ascii?Q?8UMY1EnUs1njOPDmbeY9uzw/vEcKa/vPYlnKFarPSjplm7dZ5+yvas0n0Rmv?=
 =?us-ascii?Q?gptrZ5iWKzfvVC9rrX57QDNIB18Zn+oK9QOCyTHnw6+26rn2Mz2qrYP/LT+c?=
 =?us-ascii?Q?qOiOpn/cNqpdnkveANrZlmTvF2RFmKewEtqKPDANuyQIqTKZvXxqrqV0Fn+k?=
 =?us-ascii?Q?UnJW00YBsU80HIOGam6VauEGUjAuK6c/qYN2AnO3Nz/VWw/Y//A3vBH5u+mE?=
 =?us-ascii?Q?saKTaAwWF4mwNx0wdWymtmjve+GVnGCpB2usxO0EY4JYtClkStA4NpXzlU2N?=
 =?us-ascii?Q?TiyXGRg3raAojkLkteljmkvbTen63Pc6+kruH61QU0xsD1vhvZ3avVvPPtgr?=
 =?us-ascii?Q?YWcTyziZmrinod4Ovbe1+ftMksHbmYwPk6R1eM3QLyNboYBwwOQmaI88THuA?=
 =?us-ascii?Q?gzB/f+KOMZBgTBeB5sKR5sWvGqzg2DUeFLlMJoMsBTRXKYhL7qEjqG5AABBE?=
 =?us-ascii?Q?TXI2YiBxE2OlQvwxmpTUm3GCjrkJ9sqk5jVW243PmzGgZT/t/dpnwda5W963?=
 =?us-ascii?Q?cvr2bQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9f0a1-f62c-4736-a27f-08dd07d6ec39
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 13:43:02.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +J8lEguK4LEK0b4y9Y/7GiEnP4c3ef77VJsvONfX8nEIaJSNkaKu6cROJKhcz4xFz6PRlTGo5HFOuUUlGhE9RU02YeEIUFNxEzBNK2VBn/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPFA8ABE82B9

> On Wed, Nov 13, 2024 at 02:41:08PM +0000, Sperling, Tobias wrote:
> > >From 6a06973e1023ca6a128c8d426b4c87887117c084 Mon Sep 17 00:00:00
> 2001
> > From: Tobias Sperling <tobias.sperling@softing.com>
> > Date: Wed, 13 Nov 2024 14:52:49 +0100
> > Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
>
> Your patch is corrupted.

Yeah, might look a little different from what you are usually used to see, =
as
I had to copy the patch manually to the mails body. SMTP doesn't work
for us unfortunately. Anyway, the patch applies just fine with "git apply",
doesn't it for you?

> > Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-chann=
el
> > analog-to-digital converters. These ADCs have a wide operating range an=
d
> > a wide feature set. Communication is based on the I2C interface.
> >
> > Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> > ---
> >  .../bindings/iio/adc/ti,ads7138.yaml          | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > new file mode 100644
> > index 000000000000..c70ad5747828
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> http://devicetree/.
> org%2Fschemas%2Fiio%2Fadc%2Fti%2Cads7138.yaml%23&data=3D05%7C02%7C%
> 7Cf943e3cd23dd4c28422608dd059c1cd9%7Cfe3606fad3974238999768dcd7851f
> 64%7C1%7C0%7C638672890241515102%7CUnknown%7CTWFpbGZsb3d8eyJFb
> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb
> CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DKFK6uoMuDUTlwSRv5jUd%2FQ
> mBqKRHIDCq%2Bb1nWhOkZTk%3D&reserved=3D0
> > +$schema:
> http://devicetree/.
> org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7C%7Cf943e3cd23dd4c28422608d
> d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> 241534499%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3D2Dj6PlC%2BzKkjcxWosWYMd9Wnh71dKJZfXx5af85vQf8%3D
> &reserved=3D0
> > +
> > +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (=
ADC)
> > +
> > +maintainers:
> > +  - Tobias Sperling <tobias.sperling@softing.com>
> > +
> > +description: |
> > +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converte=
r (ADC)
> > +  with an I2C interface.
> > +
> > +  Datasheets:
> > +
> https://www.ti.co/
> m%2Fproduct%2FADS7128&data=3D05%7C02%7C%7Cf943e3cd23dd4c28422608d
> d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> 241551566%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3DMtZjBaLGanD7%2BwQJZDc54CWVVkDbUV1jAv9PixBdOxk%3
> D&reserved=3D0
> > +
> https://www.ti.co/
> m%2Fproduct%2FADS7138&data=3D05%7C02%7C%7Cf943e3cd23dd4c28422608d
> d059c1cd9%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C638672890
> 241564942%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3DDlLY9HTzdOyvooQA%2FCI%2BQJu0REGlwP2mpR%2Bp6M8C
> 5yk%3D&reserved=3D0
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads7128
> > +      - ti,ads7138
>
> What's the difference between the 2?

The 7128 has some more hardware features like a root-mean-square
module and a zero-crossing-detect module. Base functionality and
therefore, what's implemented in the driver yet, is the same, however.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description:
> > +      The regulator used as analog supply voltage as well as reference=
 voltage.
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt on ALERT pin, triggers on low level.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@10 {
> > +            compatible =3D "ti,ads7138";
> > +            reg =3D <0x10>;
> > +            avdd-supply =3D <&reg_stb_3v3>;
> > +            interrupt-parent =3D <&gpio2>;
> > +            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> > +        };
> > +    };
> > +...
> > --
> > 2.34.1
> >


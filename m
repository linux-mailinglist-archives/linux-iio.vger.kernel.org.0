Return-Path: <linux-iio+bounces-22441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E94B1E526
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E038160DA0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9B265CBB;
	Fri,  8 Aug 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="UvrDxCwW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640625484D
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643574; cv=fail; b=Q5r/oDujeUJu7l+n6o9XlTkaQhiuR5ZrM5Mmw+FWBNhpczqtq23TmfzfzwYIFkQU3iuFE2xSqGGYq4O70KZIdzEa5bCCUPZWwBeqdEoMPOVbbXksmc9pY69qa2P3KWl9BCDo/WYfBe24oknUyEvWIOo21CcCwjvNAY/SUAlu4MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643574; c=relaxed/simple;
	bh=hvMHWxp+oQ2M7r6F46L0O+lIqm5CdVxqb7dSlX/3UKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8odERxWs7YUAhN5sTobA5jz+HXeT4hp6l1lV4cVgj+sQSH07iD38AwLRqauiu+HveRO1EDY3ZIwK/y6yqdjLXFiOb/f9HHFaPX5W6mATwiowuvrrsnXnLSnMOqJmFfSYP7alHB6hP7kzbGDqmLf83sXYrkeKCGvE/RbAQLQ53E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=UvrDxCwW; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577MqfGp015918;
	Fri, 8 Aug 2025 07:29:03 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010048.outbound.protection.outlook.com [52.101.169.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48bpyc2f4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 07:29:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ+3a/vlw0256ina4g9Uheqqm8ht9C0VqPNEPDJ3cbZEXTr0uBT1F4KY3vr8XPoxMu3yO0jtqGLKPg0o5thHLM3fSCPaxh7nmJqIebeSW7xrBgB7xHN17CROTWOiDxZlEBEFinkHEio4gazC8uY+F+7d8p3Gn7sSLh3tMzPi2R5w80TsMyxqFHaNB1tv2GXc9CuNeHBdSNDh7n71OWyv9R+5H9zDCxaShnKTjUe6l3xpg97+Rh0V6a1AaPaWVC9EskYnyr5qUimf7/KY9QKVeGqGruaeb7FWhQft1o613ThOtihxqPik41OrhzieBxJb1vnIxE6ixF9jB4plIAiJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPLho+6jUUFsFEYZBcosiTsYZnzzmNmdjnjZ/+zG5bc=;
 b=kVRqsZcjhqODDeuW28nnJetjzTarzm4KfMfZCnIWpGAeZgW6EGBz24OJYgmEnT1bj9AyXGWISP8X7ZeJ9eblcrQpAfIzzSKKng39pbv2V7JUv9v4a0+h/LLu83zYQ/5ixlO+FIXWGiITKgTT5woVD6saAYGmtAxklaYqcZLQ237f1U2fx4J/GS32BXIE9+JV3Lj1GQTx37TZrwJgr6iOVxr2nw9QfTVClyyDCYDTb6f4+QMiJ/EJ1t2ra41orsBnXTEtWBdwSztznUuuO68I5MowTXqu0UximMm3Ex8+r/vJ5/wypp++CDij+pkg4n8eJc23nTNtqfUG6lNCDJ133Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPLho+6jUUFsFEYZBcosiTsYZnzzmNmdjnjZ/+zG5bc=;
 b=UvrDxCwWnK5gGxP6h51HWBJaQAxD/o28T54rSMIp5dvg3y2A/ytm1forzAMyf19qgMcHwlSRZvWT+gp6mxlUVjA/TMF1f597VR+OExGIBosz7vzAVR4SpWDEA26NXIKUQLtix47KnrNDqzrSkiIC78kG0eoK6Fa4ApFW3vtEBUD20udxIr25/QiUsOFDYsNQ+RS1U5mdqw28GNbENqd2dvdCUMU8nE7w5CT0j63i3Ks3k5eeNUgKU3dtCpke38z9hDK+c6mWLq//QWZ+PDEqU9PHGX9Zd9+APQu/rDJoIb+Pkjw8My92dkpStCC0ZofgOnMskOxq1EmcxaQhaaY1pQ==
Received: from BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1c::5) by
 FR6P281MB3797.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:10d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 07:28:57 +0000
Received: from BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc55:6a50:1c8b:d2d2]) by BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc55:6a50:1c8b:d2d2%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 07:28:56 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        David Lechner <dlechner@baylibre.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Topic: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Index:
 AQHb701xWPPwUANIV0SBqYJxy5Bpk7Qm9S4igAEUKgCAABQmMoAH/PwAgAEHUgCAFS1tAIASOcaE
Date: Fri, 8 Aug 2025 07:28:56 +0000
Message-ID:
 <BE1P281MB1745F7FE698BA11132576D64CE2FA@BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
	<FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250708113508.000027fb@huawei.com>
	<FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250713144632.0cd2e88f@jic23-huawei>
	<w5ury5pubvk5iavcnu5yc44mp5lplsrvxyet4vwliv3mu3m5y4@sbfiyiy3loov>
 <20250727175302.7cb89b57@jic23-huawei>
In-Reply-To: <20250727175302.7cb89b57@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1745:EE_|FR6P281MB3797:EE_
x-ms-office365-filtering-correlation-id: 1d9b22d3-96cd-4acd-31ab-08ddd64d3c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6T5I0SAO76jPqJoXezUZLydIw9T6oZAAwhySZd4T/saUgJ6hLUf2OnpTLh?=
 =?iso-8859-1?Q?4kqwyPwLgsnjngbaadlpwOGOGlyB+lK1H23/d/pZnTVAZt8rOvbL5lhyJu?=
 =?iso-8859-1?Q?Cx6vBQt1cM5SGJUbA/TZe31/ReV7CGV8vVp8tJ3iZN4dYaJ5lL8VNpYk9f?=
 =?iso-8859-1?Q?6HpQY4oSeco5duLDaEcuiW6rSu81hfrVvyEuAarfj8/nSjwogoA932o5Zg?=
 =?iso-8859-1?Q?Er5SskUcAx0esq7AlKUfGSbWDt6A2MW+/CwfSqjV0myRO6VuC2aDY5+mTd?=
 =?iso-8859-1?Q?6TOAeUqRyI/dxWgT2puRN67udXDhMdk/FMdu9c2BFOcckaiLTb0Q/1b6J6?=
 =?iso-8859-1?Q?as8gZnRileSH6e5kYVXzld5ui5AJCd5BkxUaWdXAGtkHglP2RYtFVbw/2M?=
 =?iso-8859-1?Q?AnBjix2UA00YPQhKVzlehQmCxLWT4dFVbLQcA0aynRS5f42wISCmNEpemm?=
 =?iso-8859-1?Q?goPUoFQ02iei4lS5P/ZTyGEacKzFwdq49iZ15sjIX5oRpmTMT32Irk4zOd?=
 =?iso-8859-1?Q?G1cgIlTdHrk63rF1jY2H2T0FXnhcGvukFOFreAwgwi9Ag+/Y30i1616TgA?=
 =?iso-8859-1?Q?YwnsBuWbk4W3qrETi0B88V626eK3qMO5RoZWSD4sFnvkEtmVefym2Z+Wqw?=
 =?iso-8859-1?Q?oYAlxxh8OEA8ohTLBPGNhqxDxkHre9vS+bJt5ZtxNSnGzVG0jF+BWITdLx?=
 =?iso-8859-1?Q?hYDefntYiMufctm3uOSZ5XZ54ypbkdiwhjrZqDqzXGWyxQ7GdcqW3xjhRi?=
 =?iso-8859-1?Q?dNkAnBj9r3CA/P4iBZ4/VluitknFh7elckhVn1nkAu6dUD3IFZNB/lbX1d?=
 =?iso-8859-1?Q?1ybC0yrw4KMPSxAAbW1SjQxSHWLFktSvsPvmzxgWy8P60oMUyaW2AKQzja?=
 =?iso-8859-1?Q?IBYy8uL77uM7FfCAt/cUBo6H1XfQDSaQEJfrIXEciaUXFKvyjH1jgOoRdf?=
 =?iso-8859-1?Q?jpUMipYFEUBLG+YJvt+fO8UQrwXUbf8yKbS28byWc4ohq1Ja8w8y/vOzJ9?=
 =?iso-8859-1?Q?N0fKzFadOm9fIhCIfO0+G7Yus6urcUp3Y27rR4sddwiXEmB+qJYPlJnduc?=
 =?iso-8859-1?Q?QsFq6tpZHP/wMtYJSNSf6kiUOTYGktEoLd4mxJyEY4+FZu87S1wbCe2B6u?=
 =?iso-8859-1?Q?I1bGqrVbsH6/YZYPIJnD7YaLa3GzLIJ3QMIaaXQjc79wC0cUdQPeky/tyq?=
 =?iso-8859-1?Q?N+QgMkZOuA8CJGRhbJSsKBdgE8sJBxrWlYlhjWFLoLsb7vcIAO/NHi+c/I?=
 =?iso-8859-1?Q?Oh+/o3MTLGsJThEKDk4hotCcf3HaLSZ1a1cshQSqrxctPZ/Wmz6dk5SbsH?=
 =?iso-8859-1?Q?21ifEJdrPXwfbXEMAo0rE9Bt2CLTx7IY/H82/k+e00H0Ot+fTrHI8bjbQ1?=
 =?iso-8859-1?Q?7RDsHtmcaD/D/rte1gFunFVU1J2uf10DMsy579TZlIZpwoAGBITjASvICI?=
 =?iso-8859-1?Q?1SQD7jDjVj2ExS7QATRdVkcfQP6lfK7jDh9hfBMPk1UlUO8l9z9D/Wwyxa?=
 =?iso-8859-1?Q?Gm5tAcQSxQaMNBKBPGVKufUjaF8ZJjjQyTDnlAmycXWKO2VX2F4ySbEDb5?=
 =?iso-8859-1?Q?hXe4xc2zb4A8qVRNfhNZweV00n9u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9oe0dmQueWL0QpGBlKW6yInYTnsCMKRI/cgtotSb4ANPuBZV8eXO6ndgLR?=
 =?iso-8859-1?Q?0YgzVD5pLpOWdYmJ7Kw1nV2Zr4yWnrI8/ZSDO0AYgpN6tnPvlk2hQKPFBT?=
 =?iso-8859-1?Q?HmNtkh4OdlZZLotsfVcdeU4FF3n1T6BN7XiIOy9+3jnGRBem7pmDRlwpSb?=
 =?iso-8859-1?Q?AwtPykdXZXeLpqlxB+Ogx/kGItUEipz7welP7ZhYIkrQ0PVKkXEQLc81Ds?=
 =?iso-8859-1?Q?fuw4SCONQtEMkyYuGby41IIeavb83aRER2/5W3LOQ0IXKM219pCprF5eJk?=
 =?iso-8859-1?Q?tfhT++G8iP/svZOshjPSo3V4r/5IWPs/euS11QL36J2Id5eGQ5QeejadLx?=
 =?iso-8859-1?Q?cc6vMxcCLG1+ffye46pQhgoUGhas5cMXPlxBxTjpEpG6wXJDJZnTqg6JUO?=
 =?iso-8859-1?Q?GZs4QBjJ8TnPV7XE+9T4PyB+BYrdQ9eGQjj588VaAOoTAgQIxtsNrFV76r?=
 =?iso-8859-1?Q?i7eJ36ko5Ci4VLc/40Ophm9dCyoCmGNYsN8kbnlHTN26QHpaIClMOmKUb4?=
 =?iso-8859-1?Q?cNn9xzgWaDaq//t3Iyu3/fY7uMdybLPimfZ6aPjyiCVTGXjwJqfbNLA7yf?=
 =?iso-8859-1?Q?DvZT6KrnT2/deZ2VqRj43TAj0xEJPXlAB+9zfjqHpnztfJ4dAviM9qjmS7?=
 =?iso-8859-1?Q?BPAvlS2OObmlMCOsHUgrfCZ0HxnvrlDebqY72RcCBj6iI9fP4ycV4I8u9P?=
 =?iso-8859-1?Q?Ru6HvtgcLDAtWZbr48lzrwIDTHoQ9Um1PobPP3lRovkPZDHdXLPVhJLkoC?=
 =?iso-8859-1?Q?Qgoi5DW19AuiQJLhoFx5ToYLGQ8GGw6LAc9QD2O6/OTt1dQC0pFAIYr3Fy?=
 =?iso-8859-1?Q?aU4sxUgpqtDF02cyC6n360mX/8xD7/doeVSoPRJ2hZyNmgsV3KchImFX6r?=
 =?iso-8859-1?Q?CjuBTLyFzgkDjjJ6Z0SoZaOEXzeKUzsTVNNM9wGZPX2CnC1aeyctubKP0N?=
 =?iso-8859-1?Q?KNWvMGZSNbiNKWA8dxWpuZC8Vt0wRg2jt8z7PZ489d0JQiv869yElyvnRn?=
 =?iso-8859-1?Q?TU3ZyEeyV1qZcig1Ux797MaiHcQiZ/37dX5JvC7+cvssOE3mx2IQtcLL5V?=
 =?iso-8859-1?Q?m3IEaKGnE9r2P9GrSRKuhp45+WIBdwBTFRFDUp51Gbdom3sa0/UJaFa4I6?=
 =?iso-8859-1?Q?pXuWc8tJWDv66lDda6P08+4/XTQ45DkZmHfjr8zMLOzu1CvAMrIplUv4v1?=
 =?iso-8859-1?Q?NlKBHR15MSeV/FC8gT6PC3cAQZ5F0naw3in5gVcUR0UbswARgHutR02YlE?=
 =?iso-8859-1?Q?MEUjajEu8unf/7c3bemKYhllkSEZS71fbxUWDPP0WnfhFr9RmSS8c7Dtja?=
 =?iso-8859-1?Q?b/8MJjia/VfJ+92ebS82Gvd1ENY8oi/kEG1iiOaiEshRXG5RZkgsv+RDXO?=
 =?iso-8859-1?Q?IWhUSaIFzDSkKhSTmtcOrVFY55LdYYalGbrpTjOXC7X2DIVohWhkX6Q2HA?=
 =?iso-8859-1?Q?0ZlmTtHYh8tjYxdLeywEPKeziANaM2gcKb7BgSgJRF7rpDw4TauczdpFCy?=
 =?iso-8859-1?Q?1KC3bnKEcWe17DFJ2gYbyniyOnEPpdfvpmGU+7w8/5xZuRUxC/DcOWFVpL?=
 =?iso-8859-1?Q?xzg3rLkBsv91mUn+IIo2uOeJoDjWnncVcB8wAtFrW7NFNB41GQ6b4YFS74?=
 =?iso-8859-1?Q?NbfofCxCrjHpfqeOO1w8FJBuHGbtUdYZahnCfBkjlMK3EBvrMHB4AzaA?=
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
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9b22d3-96cd-4acd-31ab-08ddd64d3c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 07:28:56.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTdG9lBtboMrHopxUjIM9WESqc106ScgtJVgYUjVBH4viIwqvQEf4w/lL0PHMvtRY1y6IXGYTdPPHM4C314XpX9v3szEtj38S7W9BJizLV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3797
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOSBTYWx0ZWRfX0w21RUzVs6DI
 4yxHxlIuQZRXYuk8VUYWQU50dBQsfwoLuvpEUfc3I0yOvSRvBpIpCdakPxXec7UFIKXqDHvVJxs
 ZuXS046eXVgrtxF7JxXTCEa9Va6T87hx1G96ZhVXIY4VNGHbl5u3zqq1uQaudciKlhi6GMNl5UF
 X034QWfdrxxjOukjJbq18HkBZhpWfMlIuL6dGFOAZ/K8PlQ5WH34wAslASQgnUTV2BWU5zY8eh8
 8jaaErpVOooFCeFOiJUijTvjEz8AJBq2JiGBJKuWqyAX+j1jNXQ6dZ3qM2kIkPbYFbcrAH/leFe
 gzrEzwfdO26NmAv9glflZUo/OyW2mm7cphdrQZ4gdP3dhnYrgFQGDPO6Gaix4qUkyjD+dbvH/R4
 9uaYdGs/
X-Proofpoint-ORIG-GUID: -HfnGibdMPyQi4X9qsEUK3aKGaMKR1ch
X-Proofpoint-GUID: -HfnGibdMPyQi4X9qsEUK3aKGaMKR1ch
X-Authority-Analysis: v=2.4 cv=aJzwqa9m c=1 sm=1 tr=0 ts=6895a73e cx=c_pps
 a=vW0yxx0R3S/VTeG8hBLm9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=ilKATfAMAAAA:8
 a=In8RU02eAAAA:8 a=i0EeH86SAAAA:8 a=IpJZQVW2AAAA:8 a=hewBTuTpxyxd0idZjPgA:9
 a=wPNLvfGTeEIA:10 a=73awMTU50e6eLoBjGbzZ:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050129

>=0A=
>________________________________________=0A=
>From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
>Sent:=A0Sunday, July 27, 2025 18:53=0A=
>To:=A0Sean Nyekjaer <sean@geanix.com>=0A=
>Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Ca=
meron <Jonathan.Cameron@huawei.com>; David Lechner <dlechner@baylibre.com>;=
 linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Andy Shevchenko <an=
dy@kernel.org>=0A=
>Subject:=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Arg=
ument=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Mon, 14 Jul 2025 05:29:00 +0000=0A=
>Sean Nyekjaer <sean@geanix.com> wrote:=0A=
>=0A=
>> On Sun, Jul 13, 2025 at 02:46:32PM +0100, Jonathan Cameron wrote:=0A=
>> > On Tue, 8 Jul 2025 12:21:39 +0000=0A=
>> > Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
>> >   =0A=
>> > > >=0A=
>> > > >________________________________________=0A=
>> > > >From:=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
>> > > >Sent:=A0Tuesday, July 8, 2025 12:35=0A=
>> > > >To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>> > > >Cc:=A0Sean Nyekjaer <sean@geanix.com>; Jonathan Cameron <jic23@kern=
el.org>; David Lechner <dlechner@baylibre.com>; linux-iio@vger.kernel.org <=
linux-iio@vger.kernel.org>; Andy Shevchenko <andy@kernel.org>=0A=
>> > > >Subject:=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, Inva=
lid Argument=0A=
>> > > >=A0=0A=
>> > > >This Message Is From an External Sender=0A=
>> > > >This message came from outside your organization.=0A=
>> > > >=A0=0A=
>> > > >On Mon, 7 Jul 2025 18:13:33 +0000=0A=
>> > > >Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
>> > > >  =0A=
>> > > >> >Hi,=0A=
>> > > >> >=0A=
>> > > >> >I'm having some weird issues with reading the temperature of the=
 icm42605.=0A=
>> > > >> >Kernel version: 6.16.0-rc5=0A=
>> > > >> >=0A=
>> > > >> ># cat /sys/bus/iio/devices/iio:device2/name=0A=
>> > > >> >icm42605-accel=0A=
>> > > >> >=0A=
>> > > >> >When reading the temperature I get:=0A=
>> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>> > > >> >cat: read error: Invalid argument=0A=
>> > > >> >=0A=
>> > > >> >But if I read from the accelerometer first, I will go better:=0A=
>> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw=0A=
>> > > >> >-378=0A=
>> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>> > > >> >600=0A=
>> > > >> >=0A=
>> > > >> >Then after "some" time, I re-read the temperature I recieve=0A=
>> > > >> >"Invalid argument" again.=0A=
>> > > >> >=0A=
>> > > >> >I have traced the -EINVAL to inv_icm42600_temp_read() because I =
receive=0A=
>> > > >> >INV_ICM42600_DATA_INVALID.=0A=
>> > > >> >=0A=
>> > > >> >Register dump diff:=0A=
>> > > >> >--- invalid-read=0A=
>> > > >> >+++ ok-read=0A=
>> > > >> >@@ -10,14 +10,14 @@=0A=
>> > > >> > 0x1a =3D 0x00000010=0A=
>> > > >> > 0x1b =3D 0x00000000=0A=
>> > > >> > 0x1c =3D 0x00000000=0A=
>> > > >> >-0x1d =3D 0x00000080=0A=
>> > > >> >-0x1e =3D 0x00000000=0A=
>> > > >> >-0x1f =3D 0x00000080=0A=
>> > > >> >-0x20 =3D 0x00000000=0A=
>> > > >> >-0x21 =3D 0x00000080=0A=
>> > > >> >-0x22 =3D 0x00000000=0A=
>> > > >> >-0x23 =3D 0x00000080=0A=
>> > > >> >-0x24 =3D 0x00000000=0A=
>> > > >> >+0x1d =3D 0x00000002=0A=
>> > > >> >+0x1e =3D 0x00000038=0A=
>> > > >> >+0x1f =3D 0x000000fe=0A=
>> > > >> >+0x20 =3D 0x00000085=0A=
>> > > >> >+0x21 =3D 0x000000fe=0A=
>> > > >> >+0x22 =3D 0x000000df=0A=
>> > > >> >+0x23 =3D 0x000000f8=0A=
>> > > >> >+0x24 =3D 0x0000003a=0A=
>> > > >> > 0x25 =3D 0x00000080=0A=
>> > > >> > 0x26 =3D 0x00000000=0A=
>> > > >> > 0x27 =3D 0x00000080=0A=
>> > > >> >@@ -26,7 +26,7 @@=0A=
>> > > >> > 0x2a =3D 0x00000000=0A=
>> > > >> > 0x2b =3D 0x00000000=0A=
>> > > >> > 0x2c =3D 0x00000000=0A=
>> > > >> >-0x2d =3D 0x00000000=0A=
>> > > >> >+0x2d =3D 0x00000008=0A=
>> > > >> > 0x2e =3D 0x00000000=0A=
>> > > >> > 0x2f =3D 0x00000000=0A=
>> > > >> > 0x30 =3D 0x000000ff=0A=
>> > > >> >@@ -59,11 +59,11 @@=0A=
>> > > >> > 0x4b =3D 0x00000000=0A=
>> > > >> > 0x4c =3D 0x00000032=0A=
>> > > >> > 0x4d =3D 0x00000099=0A=
>> > > >> >-0x4e =3D 0x00000000=0A=
>> > > >> >+0x4e =3D 0x00000002=0A=
>> > > >> > 0x4f =3D 0x00000009=0A=
>> > > >> > 0x50 =3D 0x00000009=0A=
>> > > >> > 0x51 =3D 0x00000016=0A=
>> > > >> >-0x52 =3D 0x00000000=0A=
>> > > >> >+0x52 =3D 0x00000060=0A=
>> > > >> > 0x53 =3D 0x0000000d=0A=
>> > > >> > 0x54 =3D 0x00000031=0A=
>> > > >> > 0x55 =3D 0x00000000=0A=
>> > > >> >=0A=
>> > > >> >Will the iio core retry a read? If the -EINVAL is returned,=0A=
>> > > >> >inv_icm42600_accel_read_raw() is call once more.=0A=
>> > > >> >=0A=
>> > > >> >One more thing...=0A=
>> > > >> >When I'm removing the module, the kernel prints this:=0A=
>> > > >> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!=0A=
>> > > >> >=0A=
>> > > >> >I will continue investigate this=0A=
>> > > >> >Br,=0A=
>> > > >> >Sean  =0A=
>> > > >>=0A=
>> > > >> Hello Sean,=0A=
>> > > >>=0A=
>> > > >> this is expected behavior since the temperature returned is not t=
he external=0A=
>> > > >> temperature but the temperature of the mechanical component (MEMS=
). It will=0A=
>> > > >> only work if the chip is on, meaning accelerometer and/or gyrosco=
pe is on.=0A=
>> > > >>=0A=
>> > > >> That's why you can get temperature after reading accel data since=
 it is=0A=
>> > > >> turning the chip. But after a short while autosuspend is putting =
the chip=0A=
>> > > >> back off and you cannot read temperature anymore.=0A=
>> > > >>=0A=
>> > > >> You need to turn one sensor continuously on with a buffer, and th=
en you can=0A=
>> > > >> read temperature all the time since the chip is running.=0A=
>> > > >>=0A=
>> > > >> Temperature data are here only to do temperature compensation of =
the accel=0A=
>> > > >> and gyro data.  =0A=
>> > > >=0A=
>> > > >That is rather non-intuitive behavior.  Could we make a read of the=
 temperature=0A=
>> > > >channel turn on one of the components?  Given expected use case it =
shouldn't commonly=0A=
>> > > >happen but if not too horrendous to implement it would be better to=
 avoid the error=0A=
>> > > >seen here.  =0A=
>> > >=0A=
>> > > Hello Jonathan,=0A=
>> > >=0A=
>> > > the problem here is which sensor to turn on? Accel or gyro, or accel=
+gyro?=0A=
>> > > And the temperature reported will be completely different if it is a=
ccel=0A=
>> > > and/or gyro running, since gyro is heating much more than accel.=0A=
>> > >=0A=
>> > > This is not a classical temperature sensor, but an internal one for =
measuring=0A=
>> > > temperature of the mechanical part while running. The usual use case=
 on our=0A=
>> > > side is polling the temperature at low frequency (10Hz, 20Hz) while =
accel=0A=
>> > > and/or gyro are running to do temperature compensation on the data r=
ead.=0A=
>> > >=0A=
>> > > We generally want to avoid temperature data in the FIFO because repo=
rting=0A=
>> > > temperature at high frequency is not useful, and it is consuming spa=
ce in=0A=
>> > > the FIFO. We prefer to have more space in the FIFO for accel and gyr=
o data=0A=
>> > > and do polling of temperature.=0A=
>> > >=0A=
>> > > Temperature reporting while the chip is off makes absolutely no sens=
e that's=0A=
>> > > why it is not supported by the chip, even if it can be non-intuitive=
.=0A=
>> > >=0A=
>> > > Perhaps we can use another error returning code rather than invalid =
value?=0A=
>> > > Otherwise, tell me what you think is the best to do.  =0A=
>> > =0A=
>> > Maybe indicate it is a temporary situation that userspace can resolve=
=0A=
>> > by reporting -EBUSY?  I'm not sure what the best path forward here is.=
=0A=
>> > =0A=
>> > Your explanation seems reasonable to me.  Sean, do you still believe=
=0A=
>> > we need to make a change here?  =0A=
>> =0A=
>> I think -EBUSY would be better, returning -EINVAL required me to read th=
e driver,=0A=
>> and apply some debug printk's to see where it originated from.=0A=
>> =0A=
>> Returning -EBUSY and add a comment about the "issue" in=0A=
>> inv_icm42600_temp_read(), would be a help.=0A=
>=0A=
>Anyone want to spin a patch?  I'm marking this thread closed in patchwork=
=0A=
>in the meantime.=0A=
>=0A=
>Thanks,=0A=
>=0A=
>Jonathan=0A=
=0A=
Hello Jonathan,=0A=
=0A=
I will send a patch to change the error code to EBUSY with a Fixes tag for =
backporting to stable.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>=0A=
>> =0A=
>> /Sean=0A=
>> =0A=
>> > =0A=
>> > Jonathan=0A=
>> >   =0A=
>> > >=0A=
>> > > Thanks,=0A=
>> > > JB=0A=
>> > >  =0A=
>> > > >  =0A=
>> > > >>=0A=
>> > > >> Thanks,=0A=
>> > > >> JB  =0A=
>> > > >=0A=
>> > > >  =0A=
>> >   =0A=
>> =0A=
>=0A=
>=


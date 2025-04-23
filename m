Return-Path: <linux-iio+bounces-18554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C4A98199
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 09:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EE57ADC0C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283826B941;
	Wed, 23 Apr 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="w6ClJFcp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7026B2A3;
	Wed, 23 Apr 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394636; cv=fail; b=E36XGI6IqDSL0PLteY7aD2esYrcQ2MjzLqZXbLW3eHsdQTnuVN8P7fNQS6V5E6PYtv3f1wZX52ezf2zQbe8g/HTH53qLtlByUK05XhOquvN2HfoXn7jeOgFg3iKkIP3Q006oZdhmtiJkDpI9vTi75YnIx/Wg6eINFTNHFJ9pNSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394636; c=relaxed/simple;
	bh=Mfw0D6ntc4C3tWSaf3uRD29eFGsdrSXEFI3431qiO1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCLMft0Z4RdZ5CpxX0IvL+aHidOxfhgMhff4GwecL8YfyhGYYuyDDsGERsJrKu7bNHPgrRGlJsu4ckuLZzZgrax38MrsLBUL0IiPW29dmfwbBqrWosZPCySPoedops1lzEVM86qjGujCTutCdY31AjXopAuAFks9ikV2JXxKd4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=w6ClJFcp; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N5sSIM008157;
	Wed, 23 Apr 2025 03:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=L1h30
	uZcsPP6+ZdHS3XiSrFJ6zYXNmwtJwQTZr5g454=; b=w6ClJFcpMB+i8Yz0J6Rr8
	6Jtyt9/Ns2kAHBYM2/QJCBNnwsLj8JbTSjj4JcCwV6Q+ENO362Fbe8OMgSHp6c/Y
	vHjNmSod3+Up62Kl9ipshIRTp6FjNcAFcIB66Q4O0R8zcpVfd7CnVx/dK9l12VJD
	iP4MLih0Wg7VkoJe+z8GYZENLKdDjH3iVhW2E3PxpZp+O72Gq32qXRprDSiZcOQV
	d23hIbG8nQgXAvq3v7MXcK7lPZC+PAH771lwMG2iHrLnGSe7lezCXXTNU4bEgJ5p
	zK9bMIojseUb97rbCReLKC9NMXBpQ91UFP/Sgga6KcX9p3GiLIYBj0ASp6N+kJFG
	g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 466jmya177-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 03:50:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOH/B/Xp3kJjhKcoHOyjJqw09y034ZRNnttHqYlTsGhtrBYFyoezlHl0LYoWtYotBTofQzNfO1U4HpxjvmjJ/2YhsKJJsCugoBOri4NI8W2JW8MLDpNzL6ftU8SP5vBDAv1uFnO+7Nf1nOrA2J9uBdBGlkIuGuYvjYeTJrm4FoKip/ksC8o6ffxhDOJJHuHmHgdFlcRR8/nkamR7urnnwsu1UrfRozjXxccyqTInqlBoz0r2SXyZv8fzn+vExtNcTuvPsbFCr030nRjvzY1jtxe4NlZQtsBqq7NEqWSQjnGpjGkiNPbbXS8Dbr6eavsAGqjZMB4chExWsqNn9D1IUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1h30uZcsPP6+ZdHS3XiSrFJ6zYXNmwtJwQTZr5g454=;
 b=VebTliPlGNlaxRZYGMLzAPkc+rZlkPh2/pga1y30AZha9bIbTpMVRWi7tgMYQ7FMjiRP5LYrD9PmF58ESZPncW8RXbeSwNQsBm7Y7ipaC3OrGUG/e7iIB1PIG70PrJmwnpS1zFh54n70+79fiXOE9/WcGODERv8G6sGsRmvGmFmfJemAmjMLgKMc+a9/Q3wtMTMMUxDljf+zUEV+S+2xPl7X9srC8a3JxZe2oGdHfxsH9XqvigdCk+IZcKYGuilJbIprU9My/7XCMucp41p2HGuC44hf78UxD5sTj4Vyl5KGA0PYGil//xklTsLjmN9r4I9tRRgFJVBHjNKWlQNvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BY1PR03MB7237.namprd03.prod.outlook.com (2603:10b6:a03:523::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:50:14 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:50:14 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Lechner
	<dlechner@baylibre.com>
Subject: RE: [PATCH v5 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Topic: [PATCH v5 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Index: AQHbsnVvWkwuY7aOQ0Wi+6roI1HmBrOtl5QAgANG6OA=
Date: Wed, 23 Apr 2025 07:50:14 +0000
Message-ID:
 <PH0PR03MB71410C963D66BDEE7F5062BFF9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-2-94341574240f@analog.com>
 <174521332490.692661.11314304172212857611.robh@kernel.org>
In-Reply-To: <174521332490.692661.11314304172212857611.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BY1PR03MB7237:EE_
x-ms-office365-filtering-correlation-id: a99d2aaf-5d94-42cc-6350-08dd823b7b70
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lFsWm5dwvKz00048fGEMcDT2CZ/L2KMZcitntAc/KbccC1Z+wDHLpDZqPp?=
 =?iso-8859-1?Q?/ssdWF7+wGOzVdOAOPt/N8b7uS5xaZ40K/M4BN+uqHik7z6FIkplY99geS?=
 =?iso-8859-1?Q?jm4K5SmBeveO5wjyYH+kvyl17CFbvPX24sHL1XEm4y2Ut6jU5PrWuyHx4i?=
 =?iso-8859-1?Q?AzchCSfEaqp35KABP5HR8/DDf2HzSIlFrExyhl/7s2GHpP9F5OImFr8V40?=
 =?iso-8859-1?Q?k+G5AZIDFWbT/0A7G7VhsDOtrNqAwwFuR3qJnBwMaolqD70CCOgiEOdeeL?=
 =?iso-8859-1?Q?qkJFoYZc/t1VUPF77xJIrTYyiZ4k52uVgdYUyM/rqKP9g3xaoTA1J9K4gI?=
 =?iso-8859-1?Q?cmiUddmldfbGtQR5p9VaG2+55GSVfG7486ssiXA1I0CPlg8wWa1BVB2//e?=
 =?iso-8859-1?Q?Kd61Kxv0ZSnH8zW0pjNs2KCAqFjQMGd7F8HBrHna1unyMmEbGcGsK8Lyvl?=
 =?iso-8859-1?Q?3uRprDt43t3rP7KYKo987krJj1QAE8OVvCjqPYazzpW8lcN7rtVKuAtUfI?=
 =?iso-8859-1?Q?D3fKX3X22vir6qR/d+YV53fNSQDbDwEFNosL/O1g+tdeapZctzrIP4264X?=
 =?iso-8859-1?Q?D0XXlicPve4MVFLOgurYpUYpqUR9YTZsewwZZUKwkAtGT/YP7M3neJdmbB?=
 =?iso-8859-1?Q?aJ/ur+iJDzOl/f0Yk52wL/V9bBjlZXXxa1CA3PCvU5FM3HC7iii/yNsFUg?=
 =?iso-8859-1?Q?3b/v9MFzXJ5sNlYiK30uUCb+1D8uOsVqY8mS+Z+hiOE06GGsyd1QLWgABi?=
 =?iso-8859-1?Q?gIh36+FXW9GFXWQOC9riE0nu5RSegaVeFNJ7dE7Jhxkl1mZ9Hw1GDZwTZt?=
 =?iso-8859-1?Q?1SVwe2hsmZvwHut3fUM9o6A97OXrDUs4yOcGOZFU+GeUpGvNmPNvvDD4XG?=
 =?iso-8859-1?Q?u4aZ1cJ8tENgmegni5vpL7mxkO818cy6kRHddJ2O56mq76/n0NhASz7QbM?=
 =?iso-8859-1?Q?80B5+nkR6ZvCTAs98FwO4BoROnGyu/X1X0L8qOWonfzKJgfoFYSO4B5C4v?=
 =?iso-8859-1?Q?Ua9F8Mud7b/9eLOMgJ/y8Cx3p6M+DhrXkRqpp7s21RWAsfd6Nu2NQu4a82?=
 =?iso-8859-1?Q?V0nzbgcvQbUDGeBiDdmhDNaYE76x1xwCk6qGR/by2kI+QTuc7X38+UHX4y?=
 =?iso-8859-1?Q?g3Bh3j1TAdTcsBlw4NmslZ0hOPZTbKmo4NSScx5A8OYti/BQYUQxxL1lWi?=
 =?iso-8859-1?Q?nGdRDSKuzV1bDGS7EOT5/Z8om5QtQorBWw59PbEQVg4OHMyCdLdGCSzxwW?=
 =?iso-8859-1?Q?k2T6f1tV21SJJiA8A+yl9O9Hjpjrf2My1JeS6wqPgHpbPs0BO74kS3zAdk?=
 =?iso-8859-1?Q?3zHcqA1tTuPm+EhCYr9l2CBmMlG3gqpUdiEXBhbe/o1nU2m74DpP4MaCoK?=
 =?iso-8859-1?Q?p7RcmoUk7MBNDEGIgj8ZelqG3Nd3oPWnq+98/6Ya/Gg9W2ar/kOo90XAXH?=
 =?iso-8859-1?Q?db3tgW5uxRg2fd+UxymHPZmbjughr4/74+G3/g5NhmDRaR04A+aybJpY7A?=
 =?iso-8859-1?Q?c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4+ZwVwFBpH8k5IrS1eKW15s17fwI4TYoJpKIaTi6mrtxAISU3859q304qo?=
 =?iso-8859-1?Q?tvJXkOgdQSf9Rk1/sukRclxM4QfQ9bMS2+iiWt5cgDoYln4SpCMUvR5u6S?=
 =?iso-8859-1?Q?/oKit5luaS4AA8PiZDfr5nGT/v3Pd1WHhutuKaSdphKBEBaPmzGwxN1qIL?=
 =?iso-8859-1?Q?LK1tjOcNIGw3iA4O9NYHSJQosLCkqqRxgCTkiLmk4bOhHZpDVeObToFcJy?=
 =?iso-8859-1?Q?afI6BNF7H9FGB+pHVfEsbcjF+pjklFgLNzp6CyYYqRWC9XcVGHun6giLe1?=
 =?iso-8859-1?Q?v5d9MfJTinnbs6l8n/k4xbbUjyj+/Ld0kSVOv/4GVTfjeQ09onfLgiLFJu?=
 =?iso-8859-1?Q?YaO0D4L27whMQxuAPfPEwGjYCCe2zccxgujmrAy4lwEO++IdJ7URDLXnlw?=
 =?iso-8859-1?Q?dhIryOfM2ntwtRzl6mGbyKJKZdA0B1bHvZelF3ZFcUQJtmQqgLw4+3sL9d?=
 =?iso-8859-1?Q?GPqGqhcvTEwX3U8kc5V9C4X+Dz5/314xk2XXZ09rMtkjtCUXSINyZ+HvNl?=
 =?iso-8859-1?Q?mxfUYz7Tsfy2sbtGtUlbGV8JpDNYgpV4ZzIsfJ1t/14pK5cC3gZbhadwlM?=
 =?iso-8859-1?Q?a7ypT4h3f5RdzNSokRxG559ksgqEJq+yBET/d85Mut7nCbr/BdGKn5fqP4?=
 =?iso-8859-1?Q?BMLse0VxQPVTfpVNfvI9cfXYemE4N8zdqZzraECz8Nk3ETJK2GfcNgGJRW?=
 =?iso-8859-1?Q?PpgsDNgpEno++ZYyhlZAHl8SmR5CnfJ2oUYUZebGDUBqgIUaed7BeC0tk7?=
 =?iso-8859-1?Q?LAUigqYmnPFzwbQNelQhkrCOULgukFFeHnjZnanDZVJBOBefgsLl2Jjhwu?=
 =?iso-8859-1?Q?uMURwkJrP7/+jq0SvNELPq4WDEYAv1nmCXMZhGdUdAckoum7Rb7XSaE8xt?=
 =?iso-8859-1?Q?ZQakJYuDv73jC7258f9kW6y0OfbUlZC+Ez4ll7aASnvmyYJmS/3sJkEsme?=
 =?iso-8859-1?Q?FbBD5c7qINU4+2gf5P4zgAhc8RhicoIsMdpt3USB9qK3XImHyVZjQ6ZPWZ?=
 =?iso-8859-1?Q?aeroQayMbXqO1YZP0CSACjteajpxPUEUm89sWB5II6QBbeFkVgCNoR2G7j?=
 =?iso-8859-1?Q?G6hX7rBqbxr68NreBQcs4W5fuCFaKCAt9aVXHEkpEXGSPSb6avNPdulLxQ?=
 =?iso-8859-1?Q?LLGtSrG4zv0q54MajkihvxjlscjsRd6G50dlEtPGNzEN1ZJykQkwGrEzFW?=
 =?iso-8859-1?Q?lNnJE/QIrcwdQlZDgJJM6ipZXw2Mx/vVkUbk3fX7S8AzjxjyLxHSkLWZS9?=
 =?iso-8859-1?Q?KmxzDuGmg0YSkwie41805gqXBPx6hJsaLJgex2Xt5ORHpYmKli9XXhWgZU?=
 =?iso-8859-1?Q?2TtHt4kTAPmllmPLcqvdL/KJSEYB9Pu+YG3bAKLHxlH6E3FIdDL8NUnmfv?=
 =?iso-8859-1?Q?1WuDjnkTlrpbnom1nu8w/8mXyEDdOTrMgGMKxwsHLdmWKO5hdkMDXuI+I2?=
 =?iso-8859-1?Q?y0gNY1dNviKNrYLnewAyq+B9zrQK6ZSSAJBGv8ai8x56873/n6AiDgVDPX?=
 =?iso-8859-1?Q?YwDh9KxYer1EscA+YsiI1Qm2OzjT02d9trRGae1ar/KDKELPpaleKNnpQg?=
 =?iso-8859-1?Q?exDo8ufDV7g9hIKGy4185/xYYJRdOreXsxuJxt23yHgwAu85j33DS+G4w9?=
 =?iso-8859-1?Q?c/y2VGAFQSb7S+DhFZWiPaSsBSUp5MopHI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99d2aaf-5d94-42cc-6350-08dd823b7b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 07:50:14.1694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpBqRxZGyawx6QCpZUuLj2xU+0ZZZUpxZw72wfS0hfyOgIDriRik7zujRhecP56LFK60ybdedNNJiQKSiXDXi0SWjCEXiCfPNgqbve9Md6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7237
X-Authority-Analysis: v=2.4 cv=LrCSymdc c=1 sm=1 tr=0 ts=68089bb9 cx=c_pps a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=IpJZQVW2AAAA:8 a=WLdAmb08tD0yJPlYAzsA:9 a=wPNLvfGTeEIA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=IC2XNlieTeVoXbcui8wp:22
 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 1A_oByLSnbMgm0fuGTpsJQCqcMB1DcPt
X-Proofpoint-GUID: 1A_oByLSnbMgm0fuGTpsJQCqcMB1DcPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1MiBTYWx0ZWRfX5/ZcNMoXzi8T mp8oNE4/w0GM4q9tnKnQ7oFbgIs/S0yGjgIKHKwdPQDXVV/WhX5jQrBVV329oLhk+r2CLuLAQcH l/D50bUmc3magZctHUXroDbgXgxfRQNl+wzq9tPBs3/6K7LBd4OIBVKgN/zvSJ+xi7e8cSjOTLI
 YDi9xiI9wnaiQFxG+YswWKJtqE/jZoDScNWGRhP2OrhxQb6q0S+VvxUv8m5uJNMT3ILP2DczS7u kb/w3hncCiGmW9K96j0ewxCgRaL9E8VAmHekx68+XDTaZoymb8cK67dKrNpW1XGJnGbUjYSHiQK zR49v0HToOxUZ7AR51ZqLfnC1aw7lMWSNZect1hRR7hzjMvbYVmc/BnZ9kU2nMgxgMFHWxzSRt2
 abENC7EBpbL+ik9jfDb5zUWWRPfj1Km5rtPg+PoiqZJJhJVy22LzfaQhogPw8rdd7YtULqgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230052

> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: Monday, April 21, 2025 1:29 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Conor Dooley <conor+dt@kernel.org>; linux-kernel@vger.kernel.org; And=
y
> Shevchenko <andy@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Nuno
> S=E1 <noname.nuno@gmail.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> devicetree@vger.kernel.org; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; linux-
> iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski@linaro.org>; David Lechner
> <dlechner@baylibre.com>
> Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
>=20
> [External]
>=20
>=20
> On Mon, 21 Apr 2025 12:24:53 +0800, Kim Seer Paller wrote:
> > Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-
> channel)
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls. They provide full-scale output spans of
> > 2.5V or 5V for reference voltages of 2.5V. These devices operate on a
> > single 2.7V to 5.5V supply and are guaranteed to be monotonic by design=
.
> > The "R" variants include a 2.5V, 5ppm/=B0C internal reference, which is
> > disabled by default.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 100
> +++++++++++++++++++++
> >  MAINTAINERS                                        |   7 ++
> >  2 files changed, 107 insertions(+)
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml=
:
> maintainers:0: 'Frank Li' does not match '@'
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/base.yaml*__;Iw!!A3Ni8CS0y2Y!5_8LSBMQDGzDudUoqQnNMjX7xJUq
> nraYNchQ_A3pjbCPArrjLG-DhM4Ycsv0lSZN4dOkjYmd6_lIvBib$

This error is not related to the ad3530r DT bindings.

>=20
> doc reference errors (make refcheckdocs):
> Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`rt_link<../../networking/netlink_spec/rt_link>`
> Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
> Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`rt_link<../../networking/netlink_spec/rt_link>`
> MAINTAINERS:
> Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
>=20
> See
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/devicetr=
ee-
> bindings/patch/20250421-togreg-v5-2-
> 94341574240f@analog.com__;!!A3Ni8CS0y2Y!5_8LSBMQDGzDudUoqQnNMjX
> 7xJUqnraYNchQ_A3pjbCPArrjLG-DhM4Ycsv0lSZN4dOkjYmd60Ff7zKu$
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.



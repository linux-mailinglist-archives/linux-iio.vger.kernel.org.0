Return-Path: <linux-iio+bounces-8063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9694940E63
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5BA1F23FC4
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33340197A82;
	Tue, 30 Jul 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="laAYV2YG"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB019599C;
	Tue, 30 Jul 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333285; cv=fail; b=cXW/JopvLjPZbDmgWIjkeSgysug8LDRcESXPZn78xTmBW8owMfn3nrHtT3ge6Ca/ExLYH61kfhCRN1tLEmOb/o5JsH3ofeIV//SeOZQysmn44juljs7CoU+e1dH9KaptTJ6AucWeFF/FVUI/ZaaJyrebN2GP8MjgNMi0Oa42LKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333285; c=relaxed/simple;
	bh=/Yx13Y7TSs05VJKZi69JX0OqlXAqv8nvgptjoN844AU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPnmGZFoCjBMj/EZcK8NOyFYPLWhwUDr0D89uxGt41CvzMJ8GlynI0XxKRZyruHoXK5zLNpavEYvxpOA64u/luH8JwQ/1WfSjdtZPy39Ek/QOuuUctHBsJTMMgodG9y7aADDcosDueDBGn46rfLlKyomOUAjntdgyDfcQpWYQJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=laAYV2YG; arc=fail smtp.client-ip=40.107.103.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZV5Jmo3q+3qB5u70iJdb8vtKjSCwhBjoStnkVnJQlXz5vpg0ztX9JtG4bT6PoHX568W6pTnrDEfoNGwUd+Cx4EkpArc+kMr46LwprM47ZMiXWWKwn11/oSf4QowqcXnehhWI+5ruutBzMZeE9HJyTCFIEZ/REx6p3e59R+vIh862rw0c0aWgL5pvmMP2wChH/YU4u87tQi0/Xu0pu08KwdJMLDTd6GWQGIL60XJQ2fYTOMAs1aJ46daNIrImym8EdDIvvCoZJIPGj7njCxg+N4912DsBdlC0fJgwNkCyZcnX5jQSDcxejct74DQYohPr1ItNG63kUZHfs4uLhuVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkoX6eAnZaQAU/5TOwdVi8tlzn1Z2jN2WJfGy/iPDQA=;
 b=RC2VxdoSh5/QdbCb76UzZB+XJRBljseraV6TSInqEszEq2ojuwneVOJ0H2G2MVONUhkCiOoSH04hxfgKZnHHGx6YCIZG54T6sOepqFaNDv5+D45d2wUTSOmBJdOwT5CXI9X3F99wCq5lJ6OlGeR5NzZslb5oICjBkrtbllh6oyRSTHC3XC1pOHVhWgSxoyq+PN/6jT/+CimmGzudivxziSryK94tQKrCj7QSdiC4likT1QOhfELqnnlP9nQnxFX0l15/ie+4XmCFDMQpuV6Zu8/ZAhJfPVI3/hPja/j9xQoUb1nPq/iXgJSiI1Jkg0LUSAXQJn+GIFH8VPO+M2S2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkoX6eAnZaQAU/5TOwdVi8tlzn1Z2jN2WJfGy/iPDQA=;
 b=laAYV2YGtMzN68sH2a7ECR994oubjpoqmfdBpmB38HsbPvRM6oE4aAQ+tlEWNkG1R8q1vUXehDFftqmlZ1L6ySvNDHGfprE1ekbTOD8e7pquoYsgfAwpRW28sFw2U7mrSHuHjPyaIQUxyhqQERjMtU+Z1ouc5I/IfbE0DoqJ8JiRZIyaMbsdVIKh9W7i/WWFHY6haFqEZal8l9qEpfOVDOXPY2bnRV5RBCaLIqlFjBp4n0/UzSTvajhPrKI0wWZxKtxAGQamxx6rWCY+Ktl0feyJ3jsJEkwWH2e0UBBE2ZXdIPzXdsr3ixjcHqPbaYv2DGkUxqjjvXQdPY/AEy+zQg==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by AM7PR10MB3528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 09:54:38 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:54:38 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Thread-Topic: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Thread-Index: AQHa3chB8xxiR7i0TkqCxVScMqlaI7IF2/MAgAAOijCAABVsgIAEnx6AgARxWBA=
Date: Tue, 30 Jul 2024 09:54:37 +0000
Message-ID:
 <AM8PR10MB472120A0BF7377F4D800E165CDB02@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
	<20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
	<AM8PR10MB47219903C83BA4F0AFE2DAA3CDAA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20240724-ogle-equal-d14de4318080@spud>
 <20240727150011.019344c6@jic23-huawei>
In-Reply-To: <20240727150011.019344c6@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|AM7PR10MB3528:EE_
x-ms-office365-filtering-correlation-id: 2917c69a-a1d2-4e73-161d-08dcb07d9fe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JSNfREDAaDxfjoL7EfBCtl0N+63/5yArh5hTdUIam0/qEpoSZ7TigFnECU?=
 =?iso-8859-1?Q?5ffQn8Fs0ld/mpBfPWXt2/2XViQcKZ6N/2sA934XO7QNiBV1CcqMCCerzq?=
 =?iso-8859-1?Q?EEEnNMLlsnUq6UI30RL6yiJNdhCTfTHL6L+CMZW2oQfqyCH3ZURhzrGscv?=
 =?iso-8859-1?Q?WpfjUT03GF4mIeX5Rky1Ync5EIHE845Y/VHBGH3+mPKyY1tYThHTJpzxiu?=
 =?iso-8859-1?Q?sHKqo6MAXK/0ETgX8qrlKszeVwKJNI8MLCyDdLf8aue85LOYLs7V4zQslc?=
 =?iso-8859-1?Q?Dv351noBvsfIO25o1x3IeshIbKrbYG7MefOhJHgUgHMXUFu7MQ3SsLfwA9?=
 =?iso-8859-1?Q?zWyUflsE5C+cvTgrMvliwIfISs2es2LLKw+q2ah8YLXxuyZo+I2NnkyuUr?=
 =?iso-8859-1?Q?clxEjWTpmyVZFNFJ2CHUiQkGOOaS1FmlJpJ5bCAuE4s5x01BWDYYq2OuIM?=
 =?iso-8859-1?Q?fQ7BLSW1abbmOd+/2EUxM3SWQ5A0p9kkHR8q8PtoT2zUZX1XoI5MQHaElZ?=
 =?iso-8859-1?Q?1jRzSij6y1ZndRT/DR2EG8EzB1ecm0vVbwUWt49muxzzNYg3qGHA0gUYGc?=
 =?iso-8859-1?Q?vUYaeeXNGtLS2MXdi6vhYui2To2lkakP2tUAR1c26+S+6YmdF5OIFzXIYY?=
 =?iso-8859-1?Q?4+KwvQR9q6eu0+ZNeSm6i+CVP+NIvvYvGGuMjr5jCT/15x59XU6HyAFU7i?=
 =?iso-8859-1?Q?EZTlOJ/CUnnOTF8BGCZXqjEq+hXv5p056uc3tvSplUXPdo8GemzkL3cq1e?=
 =?iso-8859-1?Q?umyYfuCN5LgKrBe5ZZ9fQRhd3IcW/jfpqZkZBWIF3LqmxnfUcjq9utJfyB?=
 =?iso-8859-1?Q?C+LPOCdRvl3gvwWFh4zgUCsp9UaOKYFckqzRtGTYsVA0gw6YOr7bG6c7SU?=
 =?iso-8859-1?Q?Wp9voUdm32MK5RJJ9wvd/jujKqEXzSfzvHobTfezWcSCqI3AfDLs6t8Mqq?=
 =?iso-8859-1?Q?RVD8hR6XyjB5tH99q2p7OUf6uZqT5lbKGRveADDrISjd92kAvbUsiwjtaA?=
 =?iso-8859-1?Q?WeZ668XCyP7dndF9iVFZM9SoDPOCRNQX3NmOVH4eORPj6lfbkg9UEFCtfv?=
 =?iso-8859-1?Q?ARx6QzSE3nrEhZTY8BeW2FK6Oec7SG6T87ou/lCa5LTdNh4/x27Lmh9ySw?=
 =?iso-8859-1?Q?iuntd9h4z72m7Xli+AM5yyNeW5m7Jtr4kMMzK8BR7YQVcTEgF4hJOyJmeB?=
 =?iso-8859-1?Q?LiCJ7ucUwaPH7mHURtowQ0pDH4p/W4oA4Atu80xtTIngLlN9xDxb+n5Ft3?=
 =?iso-8859-1?Q?YKiMldavDAKUC3g8zBcu89zVr/iXv/3eVUtXS1jfUDElmDWUowUOgGAWkf?=
 =?iso-8859-1?Q?J7LEh5ANchultUY4iQ8G2S16mzk1tzH3v2ch9wgsIfyvYsA+yjccG1kkMn?=
 =?iso-8859-1?Q?0reW7F51ZkJZo4CbwhTq9vRe0x8PHiSRnwAhIrYbh2tqHQsIGOn2M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?flATRYw9LoMN/ZpyNhaCVxUOlTexL/fOgycH19gQfqLhkIgpkbM7DL/+kU?=
 =?iso-8859-1?Q?f2zqpxNWklWUVFBJA5KAcn2sMHpCOkDHXWgK+DEF8CK9qLxhDKiFAYy5V9?=
 =?iso-8859-1?Q?O2V0EuJkGUKlWSCvKYdu9l0MGcXqYYLe6BZ6UNNJvq3hKTfoEB+fdB/EzD?=
 =?iso-8859-1?Q?wIwvx8wUUGPOzNCOArihrso7LiYt3yT9YeZ3KsZ4NZPjbzzJYcPVj5grJM?=
 =?iso-8859-1?Q?Pc9xB6X6dYfnK321JiAFfOrbI7Pwh5L1aEnwi6THL8uGAUDJdOgmm6Z2Mg?=
 =?iso-8859-1?Q?NRWrKYlYhcr4BEqcweCgZAZB38VYEd9+zfJgkdcObYMxATz5iltUV3i4wh?=
 =?iso-8859-1?Q?xhITtMGeotEAI3Zgy4+xzF3I23x4yslDYdWold8jiRllz65dqI20/IABSR?=
 =?iso-8859-1?Q?KaNbWkvQKFbUXVtMqao3LRcjEZrWkxQpnTl5CNgKTEMftIbOAJ9q4aA7qc?=
 =?iso-8859-1?Q?o9P5QdCLSaAK8pXDxN6YTBEndTkReICsefIKTyOdcf8w7zKv5ZDpKmOHeQ?=
 =?iso-8859-1?Q?XHPLXDZeUsoN5xPvT7xUEHlAFAGbtSE/n4GAYuY4rscTgnlil22sBh/TXG?=
 =?iso-8859-1?Q?1lLNSphVc87rcnWTYHogOsYvudJVieQu0xWuEeG2vuU6cM8E/uagUsKT+M?=
 =?iso-8859-1?Q?ZxjsQCIf/1XFkazRYdI0oriSkJ31tBkMI7bbo9zNRn8Rm/W1AX6qv/jDmd?=
 =?iso-8859-1?Q?PNnjgSV0XZ0lhWXdV88ic+eP11byMzyTdhBkKj+mtWbx8rkE+u0bKiRFDB?=
 =?iso-8859-1?Q?KvViG79/yxFk60V14AwevHvMJuZsg6AgCEwEPzB6ZIuJ2E+k/rVvqtT2/c?=
 =?iso-8859-1?Q?U3dx/j7cBehbk2HS50axPl+LYZwa74Uh1E8AhpOg8tCT/U+aSYsE3QOxxG?=
 =?iso-8859-1?Q?TGC7dkCO8SpViBxa+eDmqNLkESMluonUYWN+tMn6mc6vPs3JPoXrSNVUhA?=
 =?iso-8859-1?Q?u/4Twc9iriDrbvlZphAk9+sw6cFbe0fgDuawOtXkW2BXB18lRE/TbrtOaU?=
 =?iso-8859-1?Q?VvhrZg8DBxwjbYLat6JYDpR5il06hgq+ymHsX3/rXdgjLZEAUowqL3VscD?=
 =?iso-8859-1?Q?fTuIH0Z+KzFRN2W0hzC8sYF+HN2gyMT861oo+j8d1DwkllMmUBjRlB6XM3?=
 =?iso-8859-1?Q?E4aPdxBeHBMhnF69YsbOTOsePJgCjfxG0JRSkAR+4QZf2bbMmFw+CvkFB0?=
 =?iso-8859-1?Q?Sx4OVP/FHO7BI85+UIzVA/GbDyZUHsRVf7U4jsPblU0IXZpKb8zIhKCvJi?=
 =?iso-8859-1?Q?iF3nZnTXUEU7KBOQ5UeptdPXef/PaOLHbH/TVHNMSfk7HUYiqWac6/A2dr?=
 =?iso-8859-1?Q?1AqP8lDitZiAZUWPEKmnQK8FBFDKP1IlIYPCvcHgMUsueCQJU7KNGKowW6?=
 =?iso-8859-1?Q?DFLSsacdYlznyV9HQWS8lpC5RLHt5Wky1ipDkz7CiYbR8MWiyZLbwj743F?=
 =?iso-8859-1?Q?Ydy8joFoz+/r5zORsCyhHxS0RxnckYCn2bzCkfXWC7JH8CAVlK8HGAqdoh?=
 =?iso-8859-1?Q?bXjPImuzyyJDVg6KTxReagOgWYES+Pd4iWkuZTbVBdpvQ+PXACBIia3p+2?=
 =?iso-8859-1?Q?nwJwwVHaQdB+diNfOUO2BU8pXq66eXLJJgzcjNDg7Q7ScMiuFMj3bX5UU5?=
 =?iso-8859-1?Q?YeI6lLbmgf9Ss=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2917c69a-a1d2-4e73-161d-08dcb07d9fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 09:54:37.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1rAJbo2gMCWf6fx17mlGw5lxCXXquqkrhsWy5AH98nHHhuEYTd+TXxclg7Ucj9esIlBp5gtq9ff49CEM6DbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3528

Hello Jonathan,

Thank you for the explanation !   We will construct the patch-set as you su=
ggested.=20

Since the rework of the driver still takes some time, we will send the new =
version once we finish it.

Mit freundlichen Gr=FC=DFen / Best regards

Jianping Shen

Mobility Electronics - Sensors, Engineering Advanced Development - MEMS Sol=
utions Software (ME-SE/EAD2)
Robert Bosch GmbH | Postfach 13 42 | 72703 Reutlingen | GERMANY | www.bosch=
.com
Tel. +49 7121 35-37749 | Telefax +49 711 811-509378 | Jianping.Shen@de.bosc=
h.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart, HRB 14000;
Aufsichtsratsvorsitzender: Prof. Dr. Stefan Asenkerschbaumer;=20
Gesch=E4ftsf=FChrung: Dr. Stefan Hartung, Dr. Christian Fischer, Dr. Markus=
 Forschner,=20
Stefan Grosch, Dr. Markus Heyn, Dr. Frank Meyer, Dr. Tanja R=FCckert

-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Saturday, July 27, 2024 4:00 PM
To: Conor Dooley <conor@kernel.org>
Cc: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>; Krzysztof Kozl=
owski <krzk@kernel.org>; lars@metafoo.de; robh@kernel.org; krzk+dt@kernel.o=
rg; conor+dt@kernel.org; dima.fedrau@gmail.com; marcelo.schmitt1@gmail.com;=
 linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Lorenz Christian (ME-SE/EAD2) <Christian.Lorenz3@de.bosch.com>; =
Frauendorf Ulrike (ME/PJ-SW3) <Ulrike.Frauendorf@de.bosch.com>; Dolde Kai (=
ME-SE/PAE-A3) <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml

On Wed, 24 Jul 2024 16:25:39 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jul 24, 2024 at 02:19:25PM +0000, Shen Jianping (ME-SE/EAD2) wrot=
e:
> > Anyway, please send bindings with driver in the same patchset.
> >  =20
> > -> It's fine for us. Nevertheless according to the Devicetree (DT)=20
> > -> binding submitting rules 1.1
> >=20
> > " The Documentation/ and include/dt-bindings/ portion of the patch=20
> > should be a separate patch." See ->=20
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> > w.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fdevicetree%2Fbindings%2Fsubmitt
> > ing-patches.html%23i-for-patch-submitters&data=3D05%7C02%7CJianping.Sh
> > en%40de.bosch.com%7C3d03781ae4564e7e3f7708dcae447463%7C0ae51e1907c84
> > e4bbb6d648ee58410f4%7C0%7C0%7C638576856248420833%7CUnknown%7CTWFpbGZ
> > sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%7C0%7C%7C%7C&sdata=3DOEaFoGpb%2F7CVAN2gEpNwG9I1zGBlUNYdLUy%2F7w5Dh
> > b0%3D&reserved=3D0
> >=20
> > Shall we still put the binding and driver in the same patch ? =20
>=20
> No, different patches please. Also, please fix your mail client so=20
> that it quotes emails properly.
To add a little more detail.
We are looking for a cover letter and a pair of patches.
1st adds the dt-binding docs.
2nd provides the driver.

The cover letter provides a brief summary of the whole series and provides =
a convenient name for tracking it as a whole.

Take a look at how other recent driver addition patch series have been brok=
en up.

Jonathan


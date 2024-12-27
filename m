Return-Path: <linux-iio+bounces-13819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB99FD25D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 10:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC4C3A072B
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD215532A;
	Fri, 27 Dec 2024 09:00:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021105.outbound.protection.outlook.com [40.107.51.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204A136E21;
	Fri, 27 Dec 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735290029; cv=fail; b=EUFhecg7uyR46jjnW9kmIoVp+5cjTYFxVWZcqsuMnTKGQGnwg9hKZ0nMYabi/Ma4YneiIzZ9bSngYOuD/makWfAWFt6UYrbpVVzCVPOv27N02dY+K7WyoyRSy8GUbGw3aw2+4nKnUrj3SV6dQCeoEphWnJOZ37yRv7JgEKVSZPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735290029; c=relaxed/simple;
	bh=yAI4GlgNVUlvj0HptQ3TqApM45oGW9SVyxiDGjocoxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlrJ9b8BtFb/VLgKShKvee3mwM48myTbVSPw8ziiML5OEXJLPHU2jcZEUsmo5zKVgLAVTpeqs8bhKeE9rBJOXz/8D9pTuOUqVrLbOJK1i42e7srRIh+NpT+jSQqGGkPrP/tn2a+Dx8h6jT4IxObp5vHRysmg1U3bbQrkwU+mpgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNkIBqmvIZlRGf1YpVmdgwiPH0V4uJiIM0IWG2PDe2iHczi3yQsbfkZ9wNwzlsPJKdY/g0SaT9EGz5TQzqmDkSLz+ASMpHoYGePE+RMbdP+w9GHm0fvjjqUgSZyzoliOOOvkPZKh1mH9Elx98ZWfBsquJXqLLdQq6a78NFmSDuwRUq4G3xqpWiJ1L1AGB60baSNJzpA6oA1Z6Jps0oe0vTvUri5zQJI/hJK51IJYVNyJ5vOUOFu1Eqt3Bhcj5QZADl/svwEgsmcGGkEVRQuxRY97byGEqIquUoLbTA2Ng5UEA/GDCdkvOgd5S/tcqsa/FjcCUeiBKrspx4Cq3DBwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAI4GlgNVUlvj0HptQ3TqApM45oGW9SVyxiDGjocoxg=;
 b=MWCSgxECsqG6ekA0o0PVehiJAGqq2n2GLWv4nITS/WWiE8Oo1k7yjk9ICdIo8NLWtLVeope2+VIjTxEHF2sfaslnzAKfpzFnbG+9quMu9ldHOCZMtm9FxCsuprC7V+kzjdfY1lTmDoohYsa+n/Oy+yji+Z40Mibcfx9UQYL/v/7eFw6rPInLpz6aYd5XfGYrMcqSgI6+nVt86jJowb+Y+96vqKGxyHWtIoFxKckpaRi8/9eCp+OcQyyw+RaX5k4BQ94fKEsKqJc8w8gabS2ARcm4C35bS0ZOGZtNwrGscZbFivY2WeWxdFUc2/LK+zsiojeqjAkvBMex77EpsCB2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB0328.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 09:00:24 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 09:00:24 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Topic: [PATCH v2] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Index: AQHbV5iX3ScsdPb+HkCyl9RZhNOVwbL5yBQAgAACiO0=
Date: Fri, 27 Dec 2024 09:00:24 +0000
Message-ID:
 <PN0P287MB2843C277A7139F9DD3D157A4FF0E2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241226131736.23095-1-hardevsinh.palaniya@siliconsignals.io>
 <x6rl2gmvwkn7lidilo23lxwqwwkilesymo7lxk2uygvtietemh@qhbx4lj6r7eh>
In-Reply-To: <x6rl2gmvwkn7lidilo23lxwqwwkilesymo7lxk2uygvtietemh@qhbx4lj6r7eh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN0P287MB0328:EE_
x-ms-office365-filtering-correlation-id: f541314d-0a29-4c8d-0a34-08dd2654e672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yc1ADrVRqRap5+c7S98E6X1EO7X9qjtvNP5L554WpXEiLDqBW7rCu7+otA?=
 =?iso-8859-1?Q?ykHKyb/G3D/Js9sRAFG9m+hbUJ539NwMCxTyX/o7ZoyevdxEiKGY5y3ZVD?=
 =?iso-8859-1?Q?SYOCOce+cUdI0Tdol26gGgRhlabfU9Y5T4lMrARODniM99E2Os4Xc77iB6?=
 =?iso-8859-1?Q?wlf9Jh+75RXdwOVFLoyRHInWdlUptd8isj1AUHf2iUfZm2R0UdsPWB/6KH?=
 =?iso-8859-1?Q?4YYwuo05d47MTNdc1KVZGCSPUth8oY6dFV4nR7Jznj/QRRotZANN/eET1Q?=
 =?iso-8859-1?Q?lOAhuhRoa7MQRpJVUyXiGW0++nFtx2SxdKs1/phD4PkfTIwMfMrQRQ8gQU?=
 =?iso-8859-1?Q?jRDcpl15rzXnnR/3SSqMfXzG+8HTgUq5HHGVAXmnaEs7wgZjwhD1smTZNE?=
 =?iso-8859-1?Q?I/4G91enJqMugui4nvUChzDItDq2FgltS/EjM0JawJALcLfI9dTHyPNu/W?=
 =?iso-8859-1?Q?hnaqprV/yF5IsKpBV+yVD7dh+0c02+/qc/qsTOmtMQm6azKZVKUp38afwE?=
 =?iso-8859-1?Q?YegjC+A90vbkZZpeoCXzIB+NZTC42CeJkUhTGlUppWjvkg14D6U/np5yHB?=
 =?iso-8859-1?Q?hlUKwIUdUSriwforF1Dv9zlxA3Hgb0nnAxgR8XzOFNs5bWEPx2RvxDQjTu?=
 =?iso-8859-1?Q?cttRMmbLooXbhyb8/afxtvI55wTGgSxGAG6UWHb7FjBpizTy3Z/0mGz6/0?=
 =?iso-8859-1?Q?JV8CT+wjXI4xza4IZmQAoHR82ds/rPFeHU+VLjIUz25WbN2ukQUDqkIpHa?=
 =?iso-8859-1?Q?6OuaY66hEeJCS7qrfXKPEYFrYiAKgqp3cDVYo6rL5qWCDUj9MjVQXyI7B0?=
 =?iso-8859-1?Q?2O20I90O7IEi3YegK/NXTduQYzZNa0Wkl2UzuYjWpF2kY7mgIqQVmi/Spf?=
 =?iso-8859-1?Q?vD/+nWlT676ewQj7L4XK/MytP8I++CoE6IILiVfgLpqBQJr6Lf1pE8QFI0?=
 =?iso-8859-1?Q?bHrXj6oT2hpZ8wE1gQZ4usNyNQPbUDY6qybJkiEfTnidcmn5WLttkgQi/Y?=
 =?iso-8859-1?Q?cFPC0I2R/VAc6lIrvyWBN22eWMt/ex5Eu1XhgkEUBT5L9Q3kW+T/RGItl8?=
 =?iso-8859-1?Q?P0O/iNYDoSuVIrBp0V12sQ5G5/ku4k0uIRQnJxbIpA98Mh/EFq8SOJiWG2?=
 =?iso-8859-1?Q?XJPpIbp+zQqXuAblQVsqxw1z2Ey60OOINDS6ZhNpCN2EBMLAyShijY9MbX?=
 =?iso-8859-1?Q?KsP1ys84xReqe/ST8Ag4LZZgX2CDi+gtclvW1k0vfh3DfzP5Wb23ggKJU9?=
 =?iso-8859-1?Q?10NSMTYf9fEfYRbhoW/L7g9SxLSbHvhKg2jnIKIdlcBi5cAAZQ8Mvl59PB?=
 =?iso-8859-1?Q?ycbmcLyFAiMPb1IW8LhBoZ3xt8u7zcmLrSHajZpMdlOmumnRnvIQRB5Fas?=
 =?iso-8859-1?Q?yefcFK0anQcFjJZKUFcvyyUunrIYkp5lvKFl15/8JAWzIhYWqVJrKXw95R?=
 =?iso-8859-1?Q?Q6dgcAXlKt71vwwk+hXVRBW4c9By+HtMZfYnYd18VQHudtCJoEtZ/6Ccdp?=
 =?iso-8859-1?Q?OlCTP7QSoSwp9PlOwihrQ5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vs9aSqUzJr0byqbVGlh6BcGF9kfVyXdxYua6nmlPxXX77zr1Ohq4r1nqLQ?=
 =?iso-8859-1?Q?nbKLv/dy2FxuJC4EFsuSJaKdTL9UCbT1II11ppq5WNkrDPLBdxukkwv3/0?=
 =?iso-8859-1?Q?Kgd6BSSI/ZQslUKwHKi5x+s8Wv608S2hNUcMj7lAqN/3fJqphbS2YDMbx9?=
 =?iso-8859-1?Q?pKkpk7qsMFkeYYwA6LIL93Tm5t7AFFJ8dcePjIyxzvOADF2A3t/2xXkdl0?=
 =?iso-8859-1?Q?h4mtlh1sUI5pRuVhGC9ZIUitS6vFLdA02MiYocnZzWABIbU0MzmM+lUGYV?=
 =?iso-8859-1?Q?7eQF00dLfZNDz4zTB3HIG+DSa6jQXiyE1HVdAJwg/QXMKadD4Xq6gOo7xb?=
 =?iso-8859-1?Q?obWen2qpLaxBrHhfY6KdRN27ykpu82iActQ7Y7d9+xpwg5haMrDouGEUyg?=
 =?iso-8859-1?Q?d1mTLRZKVAYr5/W2X3KzmbvLe5YDzLKJCz1Iyya/YC2FpQtc+CieecJErX?=
 =?iso-8859-1?Q?XAvyhrZFDuXbJE95Af2/820RegmYv558IEPcRhditrIuBMsUSmxvfiQGO7?=
 =?iso-8859-1?Q?955y0MoK9rtFCMl4Um77QcNK5K4Au0TLrzy65coxXguZ6mMYlQVdoGFcf0?=
 =?iso-8859-1?Q?PQeEIY1WgYleFKeTSW5aYuFuaL9wkCM61vxifVpQValOKepPnMDoRdiAqg?=
 =?iso-8859-1?Q?wzdOEaRogiK21Jfwu9pfAYdpfQPkOl9WcDWl6D9/1kI0WZuvqjT0grvJN+?=
 =?iso-8859-1?Q?a+EQpj/HL+avF8VYWSqxOinSekHYU7l+GStM6nFott4vgcE7gip8wWyplh?=
 =?iso-8859-1?Q?PPAc8hTw8aOt58ddNosXgl+ZCkJTZ6G++Vy29EjTnetzMrqhztqPWRwj7/?=
 =?iso-8859-1?Q?o+y0YMupGN7PMRIiUI6AVy8AjzUePIgRCVkzDCDaHnFW94GY0mU6n5PYau?=
 =?iso-8859-1?Q?7evCmL16b/9Tqgp0zng5vDSG1UBJv3CiJfRw5flO9Fjza6tTQpv6wC0dsv?=
 =?iso-8859-1?Q?Y3RTjVdF6W1S8Wpa0IBrifNq9Y7yhcHqtZjOV2EfpKwz5wL6ApRMDwYZ77?=
 =?iso-8859-1?Q?TjhJNowndZL3HhkAIpJM0diNhwqLv1rx8MyYAhqyMsYElvJSnNRVnHrbtA?=
 =?iso-8859-1?Q?t9AVMEiwaIuh7JiVBi71S1KE6GLcUsktJacE3LyYCn0TTyl7gvMmTGT0+K?=
 =?iso-8859-1?Q?FMHWJ9fabVa4o7E0835EqR9reTN5YiCwZZLRVkrRvVFVPlVYXcaZNJmGni?=
 =?iso-8859-1?Q?3od5nzehpndxLIDtUukWD9IySJ+r0EzxCbaj3B8nF29U6YKInWBAOJ/CQQ?=
 =?iso-8859-1?Q?gsdbuZJhIT5NdMpfR+N2XZqj2AElb6RmmkCD7Y73sDjHTn3lo5CKih2Cgg?=
 =?iso-8859-1?Q?Y+KotHk6gEHwCEqUiWqxRzg14Orebbc4xOYQhaO/tFUDUt0mv4b7OAg+pM?=
 =?iso-8859-1?Q?0ehJUiNKPSd0JfkvZrAYAgpqO703sJrYvI/O6MVHsuf263c2ofav17zP5m?=
 =?iso-8859-1?Q?t9MkdYEuvJsidhXZVe0yS9FsmneoUEEGtJu5yKVFPFTCBdioiXQbKR3vGT?=
 =?iso-8859-1?Q?JAatQQPu+CWlpCLNUmM2PjNox69xN3ymjtv8HJUR2EBs0qYPDDMsPHKS3/?=
 =?iso-8859-1?Q?n0f+UnwE8MaBDC/8GfeX26MBjVTOZ/+Y7olZf1vPLZv8809axOnkYFYHt4?=
 =?iso-8859-1?Q?XqE4aAmKSWBwqhnDsyFRdTkytyVR0KVAG93yPAUfxLmX3yJGTlRrBOtA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f541314d-0a29-4c8d-0a34-08dd2654e672
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 09:00:24.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daY22e4NMLTonjgB8l/7+9redKhStk6xOcHfIj5CqZUzS3RujTWgqS8uauqCua1Q+4d734zO48iqVp/wBPtFtiOZO2JwpgikW6HELidoSqknHLx+Q/Uvk31gCfXWrhNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0328

Hi Krzysztof,=0A=
=0A=
Thanks for the review.=0A=
=0A=
> >=A0 properties:=0A=
> >=A0=A0=A0 compatible:=0A=
> > -=A0=A0=A0 enum:=0A=
> > -=A0=A0=A0=A0=A0 - ti,opt3001=0A=
> > -=A0=A0=A0=A0=A0 - ti,opt3002=0A=
> > +=A0=A0=A0 oneOf:=0A=
> > +=A0=A0=A0=A0=A0 - enum:=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,opt3001=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,opt3002=0A=
> > +=A0=A0=A0=A0=A0 - items:=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: ti,opt3001=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: ti,opt3004=0A=
>=0A=
> 3004 is not the fallback.=0A=
=0A=
Do you mean I need to reverse the order?=0A=
=0A=
=A0items:=0A=
=A0 =A0 =A0 =A0 =A0 - const: ti,opt3004=0A=
=A0 =A0 =A0 =A0 =A0 -=A0 const: ti,opt3001=0A=
=0A=
Is it correct?=0A=
=0A=
Best Regards,=0A=
Hardev=


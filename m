Return-Path: <linux-iio+bounces-13855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE749FE349
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 08:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00B41881FFE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F4919F420;
	Mon, 30 Dec 2024 07:34:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020116.outbound.protection.outlook.com [52.101.227.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321315B99E;
	Mon, 30 Dec 2024 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735544074; cv=fail; b=kSnxebAFD0n6FnACHkC0CAZCSeDa7HxLGDx40whkiuu4NnxGx/H2DgQwYCILt57JcXCdJloQ6QLcqMLDfoI2QsLWKUOpd5UdPRFTCIeqcLKw7qIRnNqrGxuN1B7v3Yk3hNllKLfBk0HBB3MF+Y1Uax/76TZjIqaJlMuRXXzwwKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735544074; c=relaxed/simple;
	bh=OpKsaO1+/QmSlR3Zy6JK00MnFDPzPXIBTzsLw7TA0Uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTH/+T3g3IPZbNdkTMjrs9h7Fv9hAaPNSUp4z29/4jbSWZN7X3pK6LbUb/lnn5KqD9Zqx3x93g49uCNYpTR6+FCAgphE2Vp72vgA7GYt7xvLd4xYEiWsvmhXY7mhfwic8c+5CDNeyNDugI5kD0jA1RyEXoq13s6jKzP2WUmulgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgHEANP3HcL3Dd7de6ga2M3MrOhuHiq7pex6P/twmUnnO/J64SPX9nZ/GTIP9keN893olwuJk6LxEcbLpyPh33ZnvVvEMeYrfN0fn2uUlOrduhsEIX8osuqJ/okwDEBis3POULyvAZwtzDUZrdP0nyKOQgNiVmDHqI+sZ/c4bAurU2l9bpU9OhXVG5Gb051fxs2BdctFImP+bizBdVa/J7dBw+3Tcz3Xaop7oU0Mdk7D4XAaii8xpWs7R5osPUcGNNV/yfGhcG+7fSw/00dzkCv57Ka1KwH7hORFlzPGAqH9h5z6yoiaTEdSaX35ruDUtSqZoh0K4W9PJKJUkZ63Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpKsaO1+/QmSlR3Zy6JK00MnFDPzPXIBTzsLw7TA0Uk=;
 b=M6YMSg7l8pVO5YmTMCCmIUjsIkZsJiCbNZZYJNnK+ZL10XzydpAMESLVMUZc00cmJuEptYn2+Ygy3v6TLwDprRztgwiyw4UiWYMuoyJVMBCoRl8HYCsdkMCGsS3wWXewX/Sc59KKsw9pMvaLfRuq1yohA5uphFhJPLSBzxrfuifpXNKrbepJTkoeLRet1YRsJcZBOFMiFcHPYezTdIAJps0v5WoCLuSYNcuJNVzmHCCkY+XtucCK7tbxb/PWnorRMSWLEHs6KV93ZJ1CeWhWAyCDLJuqMPTtaNB15l1B7HJDAiW17XnRmNpGYScY55Rs8OFZKVzRcChqmwNJaiOANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB1263.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 07:34:27 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:34:27 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>, Andreas
 Dannenberg <dannenberg@ti.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Topic: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Index: AQHbWGDuX+oJMhxVRk2+n9xm6GhD4bL7cayAgAAKz0OAACkCgIACw9B/
Date: Mon, 30 Dec 2024 07:34:27 +0000
Message-ID:
 <PN0P287MB284355F3DD7DCF6BFC6D071FFF092@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
	<qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
	<PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
 <20241228131929.49e4a90d@jic23-huawei>
In-Reply-To: <20241228131929.49e4a90d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN2P287MB1263:EE_
x-ms-office365-filtering-correlation-id: d05aac18-2f58-4010-411d-08dd28a463fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BJPrABaDxhnqXOcTyP6rltmufCvAxpftOc71V7O2/kB5VLT+dsrLLjdwMH?=
 =?iso-8859-1?Q?pApwOvMIQDfkH78LVGZLrLeUUQq3cY9UuHlrfleL8qV2SdqIO5TZFI9+tL?=
 =?iso-8859-1?Q?iW9xPDo211xaQZXXI7GHQgosR7n4rsADehzTf+Lk5mIWAn1XVxxIa1S1Xc?=
 =?iso-8859-1?Q?q+f/KdOgb2YTrx5PvQyizlWTz2GJK+a5U5cszdhfpzRV+PaXrxAEHY/PDr?=
 =?iso-8859-1?Q?IefbCBzqVyq4t147Bo314Wf18ywLzahfB3LECORufxK1mYrMVI6NyuDXzE?=
 =?iso-8859-1?Q?V/un9XZSOSbh/rL5linG1Px+HfDfeFhbfvpIeo2UvqHPTSsdxJUELYVlxE?=
 =?iso-8859-1?Q?3BzqAAWwMPjftZSos/75g9VGYJBkv41zC4w+C3CYND3Wn5UIDHPrYVUmix?=
 =?iso-8859-1?Q?jhdQ4wkVFXfyawVj268kaN7/08C6N+jlkcymgwBEUfq1hZAehOWw2zUXuC?=
 =?iso-8859-1?Q?Rx5PlRoBbHWT+xfPlFGCcGe2Vf3l2Nq4j4rZ21Qj5gDR/aA6a75Li2Ce2d?=
 =?iso-8859-1?Q?lpkADapfLHDXPJTRwh8A7x6lRGlu36+gHw7eMNbQIGeaHHScDssxzVk1EX?=
 =?iso-8859-1?Q?LOd1mlWHhFQO2EN94HPu5Eot2guzXfJom7J/9Kw9uAvuXjgHE/B4K7NFgT?=
 =?iso-8859-1?Q?gHG63PjfZ+UlxRWHEILcr1BNy64KZPVf6836EHpt/d2+8oBxcNco4JKkGf?=
 =?iso-8859-1?Q?dXX16cPmbxB3kME+gxCB3KPKthGO7rMmxwH+hUBYeqJjuqmtMhv35QQ5/A?=
 =?iso-8859-1?Q?QK255MLPD2EeMKLV1O8KjdlTt9VI/KoxlGAabyQ/UY+6oF7UKiInxcYFAz?=
 =?iso-8859-1?Q?zJWT6Rel5EvcEOQn/XYAbRPgPFZsZaJzMBp4hG9PRh2YW1Dzxw2mPHiW+R?=
 =?iso-8859-1?Q?MhR4R+Ze59ILq4Dsh34tN7fkH8mxCiNxUIHr45IsmNjw9f2ftiW08kvhNl?=
 =?iso-8859-1?Q?xWtLs7r4VRGG/DxCyYA6OXmtWPEirjKYiVeBW8Vmluhfu8rQDChFbncZjM?=
 =?iso-8859-1?Q?QEixQO2OjZ7+LY59t0XLgKD/t2ueHf2BoyibHQ+bdQgEH212gxab84iBvs?=
 =?iso-8859-1?Q?bNgZwSxzJvMn8pOtejX6m/tke0p1UmYFbRYSaMpPpqubDn0Xg2W2ULrLFk?=
 =?iso-8859-1?Q?9ib/DnsEVfY3FDpShF88WKAxKMRSza+VwfZ7SCUb6NR+EA+BGbGBA2FkVp?=
 =?iso-8859-1?Q?UZFmPtfWgJmLBVsx+308r9yE0yyeQyC1vmhE6e2oBO2wNJ+Ywoq91fm0QU?=
 =?iso-8859-1?Q?G68pHi5XoNI7zCYJ+XKp7tr0hQlTJqLLhTSAXYWfFBTb0hXeOodbiCKR9G?=
 =?iso-8859-1?Q?O/0uqNq63iey2TBJM6lr1/PeOA356Ccg0DlIFjWYlPKkkZRJV1R9n2G7rj?=
 =?iso-8859-1?Q?SLfaSOvmoA5fY+KxebfWayZATNEfbovJHjmWSYf4ESUwes9yW02yhsr/8i?=
 =?iso-8859-1?Q?HtweoZ3gCXKyCwuaW9EWzoWn70dFELJbMLRMTg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?g1z4kzEL6aYJlz3PgPJiYrg4G8jc6CchILpbWQzrMXiIz+Hb0BxWF1WVhn?=
 =?iso-8859-1?Q?34qRtJCYJ8pfl+3ByWqou/5eRb/Uk8eTq6OowSnlFJpQAxfpk0Oe18NpHd?=
 =?iso-8859-1?Q?j/KiQroDVoPrclTmLJ/rfG6/jm614AkNydfyXcv4dcPYQfuRriCJqWpRC5?=
 =?iso-8859-1?Q?ybchFo7eAKJTZBwMqRVw9VRPzD0wYmSGN5yRoY+AbCGo9fPB/YFK+r2rhp?=
 =?iso-8859-1?Q?Kufi+X5JQfTIgBlNvuXHPgg115ZAIURn27o46zuLhzHJkRA9qLiHa524Yq?=
 =?iso-8859-1?Q?/yUXRBtsgUXGtKqF3MwW32Hdja11x5DCsRVWfLofI68oxxzT+s3TKJjQOR?=
 =?iso-8859-1?Q?T3ZVhmnJTd457/s53GNPCglfUx1yr9lIzVCEd8d7Sq9hA4eeO8Yy2IwZ1R?=
 =?iso-8859-1?Q?YeaPS/z8b2u4Z90TD+AR8g5VCPe8ycgaqPDdb5nFTIdMuuMGyDTo1yU+7H?=
 =?iso-8859-1?Q?fuQHPLq/PdhN7rC9OKbvPC3sOjE34kaPFJEdBMzuhcAOUeM5yps2eeLDHM?=
 =?iso-8859-1?Q?lkqcMp8+17Hy3fT0ZMmTVoPkGNbqgXTg+4PiWMibeYm00W1jG0Y7zxJyJn?=
 =?iso-8859-1?Q?+jqPg0INkyOBGTdV8ENyNHFeU3qDJj8X/3IaH6BV+Wum0+z4YQRvl5T1Vd?=
 =?iso-8859-1?Q?rS/Wo7D+8+SvDkniEX4Q0hfffjfzV5uCIS2Sk9n8kkHZZEVYkqA2uGXw20?=
 =?iso-8859-1?Q?JwkcwhGgFMHSS5qp4ar1gX4S23DkxnoTlX+4N01kSDP4Bo4/9bLiw3eWCh?=
 =?iso-8859-1?Q?VyIWu5jfBWpkZBRw0sPsYu6lekbQr2x2mEBPt2IPC19SG8mc0HvQAC8Ckp?=
 =?iso-8859-1?Q?pmpStr39eaJgCtpu4W+fM6YnUWJ/DBGWi2XOQPPCTnAvY5rR/vkSlzLT+6?=
 =?iso-8859-1?Q?COGJciPgC/rwnSFKvxvMk9MafEZOqAbJXPAvpdLbA0xLxPWGmWvXWMJDNA?=
 =?iso-8859-1?Q?9wI99ndb7/zmzAkDuS8LOciV3PCNzMY2TVz9WTtJYqfseZW3dP8AmEKh1s?=
 =?iso-8859-1?Q?s9ki1Oz5KJWFrIZMM9mPx+TuodRt9azl1DDh3FP59NAMoMS8eWdLTmHM/u?=
 =?iso-8859-1?Q?hJHgwEGS+WdAyIG1OTZsziRWmO7bj3R4Rvm2N6rN/1BeV3//UqCLbxufCv?=
 =?iso-8859-1?Q?0gqQeDL12+SD8euspaN7+A94Mm5Cx8UME+vWidJ2H1kGujFW2FVWFIbzIh?=
 =?iso-8859-1?Q?1YtqmvXXfUiGUu79u9CMGxRdjwpfg2P7mslAFF43RxXC5CT+tng7g5GsxR?=
 =?iso-8859-1?Q?PnNBSDikPRxPf+PJjlWNTtG5/fWGnUhgk4lJF8FjmkI5ipVbZwz8r+LEqo?=
 =?iso-8859-1?Q?7D9Q3KS5hCOMNg1Yy3Oi8pBeeQWmEaW/5Z3ngq8HB4lPjUvM6yETER0rVI?=
 =?iso-8859-1?Q?DKsYMtsWpjXpbgrRUPOjis3wSxI2V5PauFX73/JOqpdoWGB2nwFJ3vcb97?=
 =?iso-8859-1?Q?03+gARu/Ym36dJJno6TxquDiz+rfArbygnxPMPGfeyi82o8PVTPxXIl0p5?=
 =?iso-8859-1?Q?w3r0okYfvWHNsOgZr2ZnKpNiYL1+lDNoAayTdd3w5UCK0+/PBItj/QEqkj?=
 =?iso-8859-1?Q?IVaJu9AwQIT8jNUgt9WOVPboxOosBePf68Umh5Gx59vHHCUI33WsXwWdCk?=
 =?iso-8859-1?Q?FaNrc3qeVAVWEHSfSnah9/h2de8K9V0yzfuzQEFp1Iv4KoGupDi/lT5Aag?=
 =?iso-8859-1?Q?PZdxaNOToCgxJlhKitU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d05aac18-2f58-4010-411d-08dd28a463fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 07:34:27.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vvvewRIf1tH6dqt+n3ggxDLzlY5zFcyRp1TTOso754ZX2+ybXV6ouH1LwnyQbZX4KT+NQJGb7qYnaAn7GBBW7bnH9d2DIhJJ7cAV1AsQreR0jrR04uDT131gCHCoIDK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1263

Hi Jonathan,=A0Krzysztof=0A=
=A0=0A=
Thanks for your input.=0A=
=A0=0A=
> On Sat, 28 Dec 2024 10:54:33 +0000=0A=
> Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:=0A=
>=A0=0A=
> > Hi Krzysztof,=0A=
> >=0A=
> > > On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wrote:=
=0A=
> > > > Add Support for OPT3004 Digital ambient light sensor (ALS) with=0A=
> > > > increased angular IR rejection.=0A=
> > > >=0A=
> > > > The OPT3004 sensor shares the same functionality and scale range as=
=0A=
> > > > the OPT3001. The compatible string is added with fallback support t=
o=0A=
> > > > ensure compatibility.=0A=
> > > >=0A=
> > > > Datasheet: https://www.ti.com/lit/gpn/opt3004=0A=
> > > > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsign=
als.io>=0A=
> > > > ---=0A=
> > > >=0A=
> > > > v2 -> v3:=0A=
> > > >=0A=
> > > > - Reverse the order of compatible string=0A=
> > > >=0A=
> > > > v1 -> v2:=0A=
> > > >=0A=
> > > > - Use fallback mechanism for the OPT3004.=0A=
> > > > - Drop 2/2 patch from the patch series[1] as per feedback.=0A=
> > > >=0A=
> > > > Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-ha=
rdevsinh.palaniya@siliconsignals.io/T/#t=0A=
> > >=A0=0A=
> > >=0A=
> > > And where is any user of this, the DTS? We don't take bindings just=
=0A=
> > > because there is such device out there.=0A=
> > >=0A=
> > > I looked and nothing:=0A=
> > > https://lore.kernel.org/all/?q=3Dti%2Copt3004=0A=
> > >=0A=
> > I added compatibility for the OPT3004 into the driver. However,=0A=
> > based on Andy's feedback, it seems there might not be a need=0A=
> > to include this directly in the driver.=0A=
> > (Refer to Link [1] from the changelog.)=0A=
> >=0A=
> > we could follow a similar approach to how we handled the ADXL346,=0A=
> > by just adding it to the bindings, since the ADXL346 is similar to the=
=0A=
> > ADXL345.=0A=
> >=0A=
> > If I misunderstood then please let me know.=0A=
>=0A=
> Perhaps give some more information on the device in which this is found?=
=0A=
> If that's a board that you plan to support upstream in the longer term=0A=
> then that would provide more justification for this patch.=0A=
>=A0=0A=
> The note on the opt3001 page does give a hint as to how the parts are dif=
ferent=0A=
> but saying the opt3004 has better IR rejection.=A0 They also have a somew=
hat different=0A=
> sensitivity curves. However, those are details we don't expose in the ABI=
 and the=0A=
> devices unhelpfully report the same ID register value, so it is not obvio=
us that=0A=
> we need to treat them differently.=0A=
=A0=0A=
In our customer project, this sensor is utilized in the product. However,=
=A0=0A=
I acknowledge that, at present, there is no upstream user of this binding=
=0A=
in the mainline.=0A=
=A0=0A=
Additionally, it is unlikely that the custom board using this sensor will b=
e=A0=0A=
upstreamed in the future. The primary motivation for this patch is the=A0=
=0A=
absence of existing support for the OPT3004 in the mainline kernel.=0A=
=A0=0A=
I fully understand your concerns regarding the addition of bindings without=
=A0=0A=
an immediate upstream use case. I leave the decision to you regarding wheth=
er=0A=
it would be appropriate to include this binding. I am open to your guidance=
 and=0A=
will respect the outcome either way.=0A=
=A0=0A=
Best Regards,=0A=
Hardev=


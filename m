Return-Path: <linux-iio+bounces-13808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F44B9FC8E2
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 07:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C541D163248
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FD1714BE;
	Thu, 26 Dec 2024 06:15:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020098.outbound.protection.outlook.com [52.101.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7E17591;
	Thu, 26 Dec 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735193707; cv=fail; b=cBvE37L79uXlWR5rP2R65z6PqbcspqO2xgzkEMq4zMwwcLC7/+2VXlwXmVFGqGyFevvvmtA/Z+KQIW+VB2ZQmWcaAgxHEKXqImsS7PyYv95+3/V1SDJK5VyW5ztc4ISo+DMmTFbmk2hsUi5x8ZIUJV4QIPbM6T5O3/tUd38bSfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735193707; c=relaxed/simple;
	bh=cIYAgTbRDfD52F79hriYgVDqUK+/Zu7eXAN4B94xRM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRU/reEI1+8Hcdx/UxDqmVJp1/s2G0q/CKKaHzQk0G9PutyetwzpkkTDbSb00cD/IYj6dplgTK8jL/ni9derg6f6XO4yHgcGKOzmsFksN1wyWGE4lBlDbQ8q6qQ5kgl/doFSgSRCfLl12hyc5PM3+LTtBg1IHFovsJytA1xUhA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+vMpJtI4fSJjuLQMVRzX72Tu7rykGbCzU8sg7IMg1WZq315QUL7xu+mRdjMxFwe2ipaWxqcmYPncQoMnR3JxmiV5zyq9pU3QtagbQ8rmJIGUfsMKdCtKFBM3bqtIxhFKbxEo/QPpt3yMQPsW4Wmljc6HpSXOZGLN9d7+mStfe3gnBuf1qGyjwUBNimJdtO0pe4srg/MUqyCV0Jc2+zGriszAEiQ3Qj/iacTenG8UGspXLb75QzRCiRzyGxBQ27iDujcH8ho6zHPGaq9ioXlnn/okbTYoR1z/K4zePzUKyseCMiXc6nNNcust64RJIIQX0IQZX2SL7FFFcVebHjp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWOYkj4zLTTfCb/pLRYLRmEJqBDjtQz3F2co5Lz16Lw=;
 b=Q+nPCq0IbGrl3BgGEtpL3MpJkMGjKKV6Q7EfGzHEGDUQ5QX9j1v2VPR0kT7PuxusaDa2abVI5iShRTVDQRGJtMbOlP31XZYe8+mP4ZpxZCgnU9+eZ49m+N5I4BESiaUWxfY2khc8aMLoKGRpd/mmI8hujnpr3PyC0+d43nJzqVpCFsqNE2wZUux3rhF0nCurB3JLLjFwt0BpHUJW7bpeYagzmTh0dCE6i/YNk+8HzkgIyX71NWEk1Io/o6ak1NQFvIEDo80z0aDQ5SM6rrix/kit1V8yQrXWS+WiNvP/pRFIrjncrTf368vFvzSN2JScE5qSvdQcL7IVMArCDJC18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:20f::13)
 by MAZP287MB0686.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 06:14:59 +0000
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933]) by PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933%6]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 06:14:59 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil Gedenryd
	<emil.gedenryd@axis.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma
	<muditsharma.info@gmail.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Thread-Topic: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Thread-Index: AQHbVcsY35Y+fTs14EO6Y2d3pmBa7rL1g5YAgAE24a6AAD12AIABFt8A
Date: Thu, 26 Dec 2024 06:14:59 +0000
Message-ID:
 <PN3P287MB2845E6B3A390BE3741CFBF13FF0D2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
 <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
 <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
 <PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
 <Z2wJ9BLsrLeDD-zb@smile.fi.intel.com>
In-Reply-To: <Z2wJ9BLsrLeDD-zb@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2845:EE_|MAZP287MB0686:EE_
x-ms-office365-filtering-correlation-id: 99910b4d-a155-4e8c-5ad7-08dd2574a0a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?R9TQP895rzlfN9GAISWo6m/rXR/vm0GTlRdc9lq36rcPjcM1pN103Lbbwr?=
 =?iso-8859-1?Q?y3sXSzK0crqq4gb0q9XwlXefjxiDV/1mXeQQqz/uDYzYoi7lfrS+w6bAy5?=
 =?iso-8859-1?Q?Erq5RuiccQA8WnMOx92Wq+ueta7T4pK8zHW3Pb+ga28H+x0EDU1Lw3uRhb?=
 =?iso-8859-1?Q?gF5Z5Sm/ZSTNG2XMHjv+t7bIhh9x/VlI+Su0+bEaYDHdy+7Dowb94PhzfE?=
 =?iso-8859-1?Q?XNH4PU6+ClTrgQEZykOq9Sjgd+UtfUYttK0/G64L81BLdXcjXosFFgFOEw?=
 =?iso-8859-1?Q?OP5g7aWoT8wNJtM0Fl1qsrquNokC4reIgspYORqpD8msU7HXaPTyZNT7Gj?=
 =?iso-8859-1?Q?G1Aa+IP/dfRl3gPHLLyefEyWd+dJ83eXRB8s63nzNpPsx4LutAj68rPLiN?=
 =?iso-8859-1?Q?H5iz6VBX0xlkzYH/Gm6h/w35nHyP+KrsKJAhKHOpa5KQEO2ZzvUaQeWu74?=
 =?iso-8859-1?Q?IIrjASQpV03tzkO2G+zX6nqkamiF2+in6rCtvHDbaGJfiWoiA8FVbOV4pR?=
 =?iso-8859-1?Q?tWjbzBZm8e0XdppZ2Y8XZS6/iHGvnH7n+6q/NcWyxGQEhn1FozAq1DnFBW?=
 =?iso-8859-1?Q?bHV1LwkTghlywrNNxsU3i5zUjyli9AK35Y0VDy/p1BOw3tfS90vWWRe3XO?=
 =?iso-8859-1?Q?0o3t86T1S3jce+LknHg9cezUopy5xM26EjK0Q8CJxZ4jCRxuY7VEv88Fcu?=
 =?iso-8859-1?Q?Jt/avA1wR9SpgDohn3xISfLsiBwypwpvsRIlDPR4+FFIQxZy7qN8p9mTbB?=
 =?iso-8859-1?Q?xl/hpmntD+p9ahP5Kk+fMUM/IMR8FXau+0W+42CSzux611pWg9C6o1nArR?=
 =?iso-8859-1?Q?1LDL35rj3eYaiCsY3NOxc1WqF1b1Wk8gySbOG5vCcLxU0UJ+oUSSxfyXJV?=
 =?iso-8859-1?Q?DlHt21L2mB3uqTvFxta/KD+vasEipaFArPVFUO3IefXMOGDZcrRRNfFW4H?=
 =?iso-8859-1?Q?fBCAX5liGSu3u0bxHbPjEtITpyi/0HoUX5yaNlNn6X6TONKrWL/7YPPgOI?=
 =?iso-8859-1?Q?WzBKyXRrGgSlInZbpPtaTqbKz5c+xDu7kH57jvKvibTJDoJiMog8sfbhfh?=
 =?iso-8859-1?Q?GXO1j4gRd5jYRUDwWUSqHS8AywU819Tri+/WCBoOHVwDaoH8QQ62OD3hKE?=
 =?iso-8859-1?Q?eaUK1SlGDU/8QTwxtf8H51K6t6TTtNyQGCygw2xGpcZ7iLph9XfrS6Kq53?=
 =?iso-8859-1?Q?LLf+vtXC8UMvMopgxx91qV1ybckkzZ7Ij1DH9RnFCzzXZ8ks6tobecIjnO?=
 =?iso-8859-1?Q?ARKQ2dLsRIYJaPTMl7AbnweIoNGIHJxsn3plYkAPYs/qUfxjAa8k/yPqGy?=
 =?iso-8859-1?Q?5WLcFk0qWy073f+mQWE1FDuSEuUuzqUKsey912NsHrM35J9SvKfp7WWlug?=
 =?iso-8859-1?Q?kb6DmI5Agodo/6qmpiaw7HaibD/p9QFxPxRC/LPk8RyMyAFVX8Cyzts+kB?=
 =?iso-8859-1?Q?9JWDjXOGjSOhils/wH7ENZMb5fUOXTTzeb6eyjGZLAeamjEdrVKv7Y1dn3?=
 =?iso-8859-1?Q?3wvToiw7JXLOvm+MJPdShs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2845.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1uknL/faP98Qcjns1blrUKMSSaMsnl3V1op/omjnkw0ZFYxM47t62aknPs?=
 =?iso-8859-1?Q?recsC8r00HF1Py2aszc5IMfe+qt5ocGRHYzZroQ06lq8gFbx0m8F8e+jUw?=
 =?iso-8859-1?Q?AULygENtjfaAfajH4PqSHMFeqxSUBGiNMt2Rx6i5Sf3Z6hVDJW3ASOya9a?=
 =?iso-8859-1?Q?zPj6iHtJlhiWpMGyy7wnuNhxZRXJXD1gn74ZWH3rjb/lC2ByryLu+cmvub?=
 =?iso-8859-1?Q?kukMvn6iESfp3LUenZNyfu/Tq0maXu+p3GeqgWA1gdFMQwP0RNvh3dSkyn?=
 =?iso-8859-1?Q?8OhwYlfu0Evrn0qUhGLGRaOvymY5TTQn4jXtmR1ZWrq3uw7YYJjGsTXDsr?=
 =?iso-8859-1?Q?fmlAmU8fCcIhA02bs6Dvkg3OMVOVaFTdsM/IvIKbk9r+viogZyBTQ4AJig?=
 =?iso-8859-1?Q?MsYPiLXDrnByQ9Lr0HVouFGWCWpbRCSDyH+r8lWsAVwWdJYCkLY5uqAW6w?=
 =?iso-8859-1?Q?KRkEtpRCkmIAQ4icIfm7XCJZw3mnxKTJbohUkZrL+VHtUufdoe8trLcJ4/?=
 =?iso-8859-1?Q?ahBk7fahfl7b0SSpDUBgKiQ6oqT/RqcOM+AvRkx5I1z8rbo9fvBr/hlvGf?=
 =?iso-8859-1?Q?BD8GEHRuYTRhzQbMij3IN5/qOwgsM2KeO3lg2vKYwG88eHrrwentfUMkYC?=
 =?iso-8859-1?Q?QgUddnI22Ju5u9FOO9fzbUBSPKkaoebAOo8lCbYxwSuijPiWMDTK5WIQed?=
 =?iso-8859-1?Q?GRjxR9J35k4jlsRMSXv768ygpOnbG+5dAf0PO08C4eIvQO6DbT0HEuFC/I?=
 =?iso-8859-1?Q?QMIS+daXo0FoO4HoELggZ+y2htG9atqKbi86LKD92ODtnV6KpPBmd2TE3k?=
 =?iso-8859-1?Q?RITFwGEv6PuvtRIG7as4fc4h8A8lgx3pvtRlucZNs4fW7sCU1Hy1RMkDJG?=
 =?iso-8859-1?Q?S5s42qonKCrHbGcbpavDqRPtNrU+w3LVjVkZXwhbJ8aHDK6nctROdTItuS?=
 =?iso-8859-1?Q?qA2gesq2zR5FHwM4BNbcdyxZtz79Emx7raXrkiOg+pAQgsngOXcYNmh2fj?=
 =?iso-8859-1?Q?xl39KRTgdL8r/FT6j/xJVkUVf6o4bX2UxbiTsv4oflGDUJ0kiB3ZQS03Lg?=
 =?iso-8859-1?Q?ttzU5+uWf+bEcmWjxtu2eIuBw1SvDmzARsqBi/zizbYuQodbluWrbmKvQu?=
 =?iso-8859-1?Q?4Zw8KVX7b5ZGPPB67FE3+I/bz1Ammhf0qGpHuCc0CNC90Zi37Z9Oo/J7os?=
 =?iso-8859-1?Q?cTdDazO9Tt+OkAMa/Ps+OpqM7+jtepfWpxDZHoYXk87bz25Jf9KiMvES4P?=
 =?iso-8859-1?Q?G/Ky9IB42GKI2U8Zlyd24+a6jt6BxDn/pzLBErq1uBGaF1H6l4zvfqt9hF?=
 =?iso-8859-1?Q?T3PoMreANNEf3cqW7jTi+4jfrxVfHCvT3Iun5gfTRJ6Ue8fF+eJY3E7ogE?=
 =?iso-8859-1?Q?9bUTPIGr9cT59z9D9jNCgEqXz61UXoEdT7OOAaZ5yP8EtsKO5sZ0LC+SPU?=
 =?iso-8859-1?Q?BKqfn+R4vcjIhLJbuHi/FHWHCDBhl8l753HVSOZNP5T8AyaZ2txB6hiLSO?=
 =?iso-8859-1?Q?gLb0qWdO1dSEHPzYTT/ENjnhiM09fwfdB3+tPHybUxRLrelWt26aO8BtQL?=
 =?iso-8859-1?Q?OjN15RQ9LwnfNLFTv1Og72objHmTpV9F+cisQzFhBKiRxaBvGd+0sLTLC8?=
 =?iso-8859-1?Q?Ce2Nsm4/UinWVLTGl4y5cxonXXN1AfHhC2PVNbKbUV2Mvl/oKv2XQRhspU?=
 =?iso-8859-1?Q?uPIbHWNmcAHwUXZHswtjf75ULRtqn1C/HDsIdUveUeY9v4R8eqiEKynqTZ?=
 =?iso-8859-1?Q?DVB/gXTcJYkbueF9+XDjGMJ9Y=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99910b4d-a155-4e8c-5ad7-08dd2574a0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 06:14:59.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0/7Mhyv558FBeEWpYEaCLwbl5E1+9/Ys8eR+2XNq1fbgq6E7B3naCbxD70ljN+CZEH/I8ISVXZelmWulJ9ztXyohxNQs4aPnpYS03dMQ2IqxG6dYKQZtdK9NI4Im6EV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0686

Hi Andy=0A=
=0A=
> On Wed, Dec 25, 2024 at 09:56:36AM +0000, Hardevsinh Palaniya wrote:=0A=
> > > On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:=
=0A=
>=0A=
=0A=
...=0A=
=0A=
> > > > Add Support for OPT3004 Digital ambient light sensor (ALS) with=0A=
> > > > increased angular IR rejection=0A=
> > >=0A=
> > > Missing period here.=0A=
>=0A=
> > > > The OPT3004 sensor shares the same functionality and scale range as=
=0A=
> > > > the OPT3001. This Adds the compatible string for OPT3004, enabling=
=0A=
> > > > the driver to support it without any functional changes.=0A=
> > > >=0A=
> > > > Datasheet: https://www.ti.com/lit/gpn/opt3004=0A=
> > >=0A=
> > > >=0A=
> > >=0A=
> > > This blank line is not needed.=0A=
> =0A=
> You left two above comments unanswered while Acking the rest, it's a bit =
confusing.=0A=
> Are you agree on them or not?=0A=
=0A=
Apologies for overlooking those comments. They seemed straightforward, so I=
=0A=
assumed your review was accurate, and I planned to address them directly in=
 the=0A=
next version without explicitly responding.=0A=
=0A=
Regarding the second comment:=0A=
The blank line was added to differentiate between the commit message and th=
e=0A=
SoB tag. Are you sure it should be removed?=0A=
=0A=
...=0A=
=0A=
> > > >  static const struct of_device_id opt3001_of_match[] =3D {=0A=
> > > >       { .compatible =3D "ti,opt3001", .data =3D &opt3001_chip_infor=
mation },=0A=
> > > >       { .compatible =3D "ti,opt3002", .data =3D &opt3002_chip_infor=
mation },=0A=
> > > > +     { .compatible =3D "ti,opt3004", .data =3D &opt3001_chip_infor=
mation },=0A=
> > > >       { }=0A=
> > > >  };=0A=
> > >=0A=
> > > I'm always puzzled why do we need a new compatible for the existing d=
river=0A=
> > > data? Is this hardware has an additional feature that driver does not=
 (yet)=0A=
> > > implement?=0A=
> >=0A=
> > OPT3001 and OPT3004 sensors are functionally identical, and there are n=
o=0A=
> > additional features in the OPT3004 that require separate handling in th=
e driver.=0A=
> >=0A=
> > The new compatible string for the OPT3004 is being added, which will al=
low the=0A=
> > driver to recognize and support this sensor in the same way it handles =
the OPT3001.=0A=
> But why? I understand if you put two compatible strings into the DT to ma=
ke it=0A=
> explicit in case of the future developments of the driver, but new compat=
ible=0A=
> in the driver makes only sense when you have either quirk(s) or feature(s=
) that=0A=
> are different to the existing code. Since you haven't added either, what'=
s the=0A=
> point?=0A=
=0A=
Understood.=0A=
=0A=
I also found a similar case with the ADXL346, which is identical to the ADX=
L345.=0A=
In the mainline kernel, a compatible string was added as a fallback in the =
bindings=0A=
but was not added to the driver itself.=0A=
=0A=
Thanks for the insight.=0A=
=0A=
In the next version, I will drop this patch and only submit the bindings fo=
r the OPT3004.=0A=
using the fallback mechanism.=0A=
=0A=
Best Regards,=0A=
Hardev=


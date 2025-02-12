Return-Path: <linux-iio+bounces-15445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BAA325C5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 13:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582DD188A999
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91C207A15;
	Wed, 12 Feb 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="wsm0XJ7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022077.outbound.protection.outlook.com [40.107.149.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F45271829;
	Wed, 12 Feb 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363003; cv=fail; b=Ojzw0hhSltexxoKzNFDC53pmvhrEJKJClRQGykpf3Clcu3GIYMb+Y8eiUXsonsZ/1bYKT5qX35a/uuDjh2c+wyIB/e8qLdkrYxLGud7ik5Ra4gLKr4YJlzVjN/leSNDjN+x7mrZc+yyzpmZKjfAT3XhpnANvhi1RVIj+5bU2M4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363003; c=relaxed/simple;
	bh=zioQ9BMBgpf71o7SAWQhnoNXUy7WG5EOg1kr7guip74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYWtcZFQNY5WnFE9W3Ylqy34YP0ZqFBhNTV5X7ViMLL5vaP/GEUwNLOx0II2vLU4KKmub3s8ApKAwPV7Hls8ukRz7XzF7OMRERiwkb7D6H1LI76XmcVC77dtClSmEfhqxrZKgSlEosolGLVkj1T9w8c10qu4zRCGPw+k4Bn4R4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=wsm0XJ7E; arc=fail smtp.client-ip=40.107.149.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2Bjl8jcdFnusTvCkE6UT1JjEpn+0N3NfFquV0+dbincz5JFEmEr5mZNfxKVu04ifSY7MDw3Z5BRBjTS3qLPEPpLqZhjTtOwhE3FLZHdk3uUui3K7rUbF0u4m4WePXZqUr5v+FLOZfjNTNhA7jFTnbn+5XbntJt0YjgMfHtsCMXHY1aKbi2Z9pyerFcoYljtBYOtthHyUGLomJ2CJULW8SfW/VM++e57Qyy5B/0raWQEzbvqGmnSO9XyFg5vqHDYyayOo5982AOUxn5UV+9+B0XbGdE4KhVn50UvUJkbvTEhCk9kD51Y+zOV2h5LZ0dTBsSYcvf4niAVS5E6eNID9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/NJ+u03U+/FHXRNOCmOJL69enmUpJTEsrNFiPQSrdE=;
 b=s5YIgu02YSzVxkhP8zOHgHt4wcxLuDOXQvK+1PqWT3Ein88kZd9VWW95+5coDfezxGKbZDDMCd4H9viL7/rcnMeWWsHzHEjUsRnCmyAtyyZ/MIFqdjktCXmmt3dxud/YDi4eCye4w1V+xmECPpGEBFaFxdqYTaLcPwhB4U9FMoejZW26m+CFAekqux282u9xkbhbqXqtw8/OJnHWZhLKrCi9AOkRHMPqLYg8TlcsmcWUce3nTaq4dzHSfoCSgy/nfFzSmRG9VFcnLHVcP2LLP8qoLXoYdhOScttcream4BGQ0aOfSaKAMYWm4dHpR/ZrNUK0BlwgVBejI0mofDvEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/NJ+u03U+/FHXRNOCmOJL69enmUpJTEsrNFiPQSrdE=;
 b=wsm0XJ7EzYrhWKQ9EvJR25avAkffl/Oit3U9IXsRIXvUx3psbyzT7GazCJSpW2ncQoRavmzMxQA+nUbHWsXwMI1hdT6niOTXdbh6J+JYZA0WXoxOYr2Z49hdBE9ljWqwqrxCAHdjk2a25gvC/hhvFRaJm1/x1vY72sCijkwfSKKkIanBL6T8jHBHfFaUd7Y6iQr8yhT46Za3esqr6cQlVy76GsVm9G2Ko2pYSFa9zpravEJfNjVn63pPZbq+JhBIc2zG6ikkwMLYi/TX4ZYjrVJTnRjBPA/TbBXCly9w6n98jAxpP0Q3nm+MdRwXRCXYUYPDhTA1PlIH8DATRo3rtg==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR6P281MB3655.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Wed, 12 Feb 2025 12:23:15 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%7]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 12:23:15 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Topic: [PATCH v3 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Thread-Index: AQHbeK3CMpyXFO1wXUq/NSUi4G1jQ7M9hGgAgAYcA/A=
Date: Wed, 12 Feb 2025 12:23:15 +0000
Message-ID:
 <BE1P281MB24204588A273E7444E10DB20EFFC2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
	<20250206-adc_ml-v3-2-1d0bd3483aa2@softing.com>
 <20250208150526.10ee8f1c@jic23-huawei>
In-Reply-To: <20250208150526.10ee8f1c@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR6P281MB3655:EE_
x-ms-office365-filtering-correlation-id: c98b9a86-9ed3-47d7-8990-08dd4b60069e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b2sLulDVBiSoTRRaBgLQeOi4rGzTOjOl3ekK6s7qsfQfWThlsomBb32vmfwN?=
 =?us-ascii?Q?WxDriBi+MBfN2qsMDDfZZaBNer7zrziKh5i/h3wbnIK0zM67GJGbT3Xv3aaZ?=
 =?us-ascii?Q?Wixj0TfJUzClAdnj13zTbM4jehQdyffK5KK6zfq7E+CoU/Vz+a4cp3Ppq+KO?=
 =?us-ascii?Q?FMvtQP/JpCJ6dLqGjFLAWzJIEcyIsr+c/5G5Lo4i511PHB1bKyKKXIaZyY2L?=
 =?us-ascii?Q?qYW5pjq08678ByHVV312U8L4Q96z7V3G/PU7aZeprXsyP/Kfjt4nBVS5AEzy?=
 =?us-ascii?Q?QfM2mgcXRpdhrLVcrqM8toK+L33XtpDYWWLIF//TOY2238O37/DJyABxKW8g?=
 =?us-ascii?Q?n4l3Obb13+/oLCgqLL8CCv1F50p+kiZF7zMPxDhm0VrQSAvNFZ7O0Qj/Z3ZS?=
 =?us-ascii?Q?D2jSgc0/eggyoCL5OOEpq1xrkAXyKr9v6YUtfXuE+gWmdfF+GCDkqcpGlwdF?=
 =?us-ascii?Q?ynwveFRIY4D85TAqOzjWkB3xINYOwIi5n4T9V413vrCleO4+llkHEuy0haF7?=
 =?us-ascii?Q?wAy+EJRr3L3TuIZQUqNIhGkuMwhynVjlt3anXjU5OOJLHa+SRu45kG2COW0C?=
 =?us-ascii?Q?DPi/RjplRzeVBRUuEvelH0ZP8u4Rd29ci6q5oc2eY8J5yyHXS3EqqwihcD7j?=
 =?us-ascii?Q?sWl8SKG50jRF7tWc5XVz7qmkxV3jtB1Xd9KaxFxTdEuU+D/GMkbc9SlDVz3L?=
 =?us-ascii?Q?KfhC5tBA1/igbghmM96QA8DANd/lMAdlC7cWaBCBGbZQVIgEh5fjzP9zn+dG?=
 =?us-ascii?Q?qyOyHfce1uOUrgWUJjbdsOgOmnUEo4HI6HlAhPuNWFHx4T9HHYg8IAdw6cXV?=
 =?us-ascii?Q?LHxudniWArQygD8by92HYa24hUMM8bako/F4H8u091ismIo56mfbOmjA7gAB?=
 =?us-ascii?Q?u6d2HMvbUC2hJ9efk7LrZIsKQJV/vc3IBuFtOYrjBfaorH2iH5O5Sh86hDcb?=
 =?us-ascii?Q?bLmklTQj7b1+iKw05VXfUw0iFL0efzNZEbubUiTXuaVsSHiM6zY1OAT+oAAo?=
 =?us-ascii?Q?V1ul6nuJXqQ9Z/spqV06pdA7K/DRHCv2I+DjwKYz3AhiOtct7RyJp2UI2fnB?=
 =?us-ascii?Q?7jzx6EY0vVVIUiGtqZSL54Da5Vy17AP5iPT4PK4Teh3ybKqi3U3yNQ1Iz+NV?=
 =?us-ascii?Q?qfi/38Bghlbo8bOm9JDuKQyagDzNuj72ciMq1FNSvymW6PBCd7BKE1z92gEZ?=
 =?us-ascii?Q?Ioq5EaUh/NTNWg58kHjvu93Mxyiam73YLxduFXs51NPo3JWmEvtvA08tIEfP?=
 =?us-ascii?Q?wJ0g1F2P6YiTk2hCKqbl5cUXSQSc5FCT3htl8qEUnipRj37Kfvxd+p6la14w?=
 =?us-ascii?Q?4nf6sBUGwbbmHdhes2O98gaZ0v+7gcpCqOMmyAXO9tzlNA0VtcWV+LajiVWD?=
 =?us-ascii?Q?rX3X5+gf2/N/vNeiqDu+ODOgXnJub3lkfTcK/efjsnbnIL5yvyuz7uF2XO/O?=
 =?us-ascii?Q?3Q11L4c/dmKAZjc+4J6UlB3U2b/LnoLq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hw8Fi/ZU/Udj5D+UrI0lqt9CUJ31v5AKzOm2uVdVUEAMio0C2Qvnjcml9uha?=
 =?us-ascii?Q?wmkei9ILJptl83nCyqFZx3BZb5453VlGSXrCdJcGUTEDHcS1F0FWWa89yKmE?=
 =?us-ascii?Q?32io3WRAysIScoHEvWgHVaOM3yT8j8VmOmft70S6a1Q4crCeKAMXtJaIsLLV?=
 =?us-ascii?Q?OPo6TI22rmSuqFtI5Nq+rXWdSOaM4ePbR32N+REwokrVfWUzNqPWRVAJdPZz?=
 =?us-ascii?Q?Y/oUX5AHGeEB1SlBplkE+8BgDSTWNn81wxvgPK21juJm7RJiQoy96xWkhGbY?=
 =?us-ascii?Q?V2Twe9ZtEUiIuobPDagh/wXzJP/3KdBoVnv1SBI5yhtfUY8dTpJdRnpRBt26?=
 =?us-ascii?Q?u60bzrrhXt32jNdi+CyUNp5eiDDyvCz+xfQ9HDKF3yk2hBevoZko17JA8V28?=
 =?us-ascii?Q?/jAIzZjry0nVouZQVBSlBiyRf4fywhabbtFvjJDbsdj6gRb0pJMdhuR55bwg?=
 =?us-ascii?Q?B+zfOIjJvQ7t4dlfzrMoAAtfJkpiPPzqZ/T+KlOZsHwHLELCA8z96uDrVYHS?=
 =?us-ascii?Q?LGU2DwNYzd5UX0u9IGWAKszjKXIOve7RMNdcpGuZ5I/oJypyPUTHYjlkU52x?=
 =?us-ascii?Q?vf1n/5BA/X3Qonw0Xt+F6RQpMR2P0EzqJNZZn9joRHqlSpfuCtcJmBtQOWhV?=
 =?us-ascii?Q?P0/ILwO3AtOoe+VdDeZsFS3Rm4KGCImU8RPVICMRUo+SFPR8jf9lR3Titgl7?=
 =?us-ascii?Q?yhKbwoY7ykqRGuc+xz9bxmlQjwsqy8OOvsvuSyW5s/DjT1mjitVRRv9496xI?=
 =?us-ascii?Q?V/0w2BInqQ9w37VqW+IOspZGGyE2RYy5vGB8d6ETSnFboGeYMUFadlv+mSxX?=
 =?us-ascii?Q?7fU/mDFuevBrF0TTE3vQKGSI9oWD7O3X0cf/r/L3VfZeVFiHOTCf8wNYgDOQ?=
 =?us-ascii?Q?LDfD20MhTqcPtpNH5hB8bVrTTTBaFPqjKalPg7nFx0d2OpB7J2va5FhFXEEK?=
 =?us-ascii?Q?YQdunsnBVpeE8qbqTgDTXrkwQljmCq1gwpQH07ublkAaAYucsjBJT2uxi0nf?=
 =?us-ascii?Q?Pqqpli+NFEq7KvJVWSHiW4lmoXdR94Ys03FzcQE7IiZalI7ah3bQAT9NgjDX?=
 =?us-ascii?Q?JLwf28WpLumgrU9nH3WAgX1xSzxXTjsU18Etk56lNXnlIDjyaaVd3JEhV9Lf?=
 =?us-ascii?Q?6rf7AYessnq2Ow1iNxtVjDF3NzGfo2f2fePKO/o2RINVpZKGV4s10ZKWA9L9?=
 =?us-ascii?Q?q0yQlWyMLIuucj4YuxUMrHKJoP6zzqlkuzuXwe7Qmur++gqeaU5ZiWqS8Wk+?=
 =?us-ascii?Q?O0PiRIQYMvvdscidbV3VeCpw3mYyf7yqfQhHgwTN1RIG1XOq1v0/DOoPwb7u?=
 =?us-ascii?Q?yQo//P5xKwBKv4I7gLHiz6v10JYv5Xm6fdXytrWCZ4wdF8QuLTCYPaD6gBBI?=
 =?us-ascii?Q?TwVVv4MMsfmfHoWj2GhG03pcCZV/+4XO7BJYmEguzlziXujrNzn/SaRIe2we?=
 =?us-ascii?Q?1K4XrzFjwJnlzY43tdu1aFV/M03Qv64WUJ6B1XAQVbE1o6Z8vWxsASirXtK4?=
 =?us-ascii?Q?p13d3D5MZKgMX+gx4yiGSq8nEudWAM6qTbq4J6SwMfyyCLcEf3Bu9pzN2aHD?=
 =?us-ascii?Q?Ma0JLCKy/Y7ytzSgwKeCnuCOX3Wqa43wocORdSTeTIrp5kDNG3+d1miovUND?=
 =?us-ascii?Q?uQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c98b9a86-9ed3-47d7-8990-08dd4b60069e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 12:23:15.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOhZvxAtJH3uSsRPr1NYYUjTgrqICiH/oI+yaWBmkCWNlZS52iA2Mi1ItIt+edbYtPBDqz03RUSCoi04i2vqi1xjPzKM01Z7W8usDrY14o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3655

Hi Jonathan,

I'll change the things you've mentioned. Just some comments inline.

Regards,
Tobias

> Von: Jonathan Cameron <jic23@kernel.org>
> Gesendet: Samstag, 8. Februar 2025 16:05
>=20
> > From: Tobias Sperling <tobias.sperling@softing.com>
> >
> > Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
> > converters. These ADCs have a wide operating range and a wide feature
> > set. Communication is based on the I2C interface.
> > ADS7128 differs in the addition of further hardware features, like a
> > root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.
> >
> > Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
>=20
> Hi Tobias,
>=20
> Minor comments below and one question about power management
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > +static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, =
u8 value)
> > +{
> > +	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
>=20
> Maybe this should use the single register write (figure 35) rather than b=
ulk one?
> It makes no real difference though other than different opcode.

Yeah can be done, but as there's no difference I didn't want to introduce y=
et
another function just for single writes. However, as you mentioned below,
ads71x8_i2c_setclear_bit() can be used for that, too. So I'll change that.

> > +}
> > +
> > +static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u=
8 reg,
> > +				    u8 bits, u8 opcode)
>=20
> > +{
> > +	u8 buf[3] =3D { opcode, reg, bits };
> > +	int ret;
> > +
> > +	ret =3D i2c_master_send(client, buf, ARRAY_SIZE(buf));
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret !=3D ARRAY_SIZE(buf))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
>=20
> Whilst this is currently just used for setclear_bit, it is slightly more =
general
> so maybe the name should reflect that it could be used for single registe=
r
> writes for instance.  Naming is hard though and I can't immediately think
> what name covers this combination.

Having something like _write_single_reg_with_opcode() in mind.

> > +static int ads7138_init_hw(struct ads71x8_data *data)
> > +{
> > +	int ret;
> > +
> > +	data->vref_regu =3D devm_regulator_get_optional(&data->client->dev,
> "avdd");
>=20
> avdd isn't optional. We need the power!  As such I'd not paper over the l=
ack
> of it being available.  To avoid weird effects on reading the scale later=
,
> you may want to do a read here so that we can error out if a stub regulat=
or
> has been provided.

Ok, just wanted to add flexibility for the enduser to not having to define =
it
in the DTS, but right, AVDD needs to be connected physically. Will change
accordingly.

> > +
> > +static const struct dev_pm_ops ads71x8_pm_ops =3D {
> > +	RUNTIME_PM_OPS(ads71x8_runtime_suspend,
> ads71x8_runtime_resume, NULL)
>=20
> Given it's likely that the runtime pm ops are better than nothing in
> suspend and resume cases as well could we make this
> DEFINE_RUNTIME_PM_OPS() which uses the runtime ops for those
> cases as well?
>=20

Yes, looks like DEFINE_RUNTIME_DEV_PM_OPS() can be used to use
these functions for the other cases, too.

>=20
> > +};


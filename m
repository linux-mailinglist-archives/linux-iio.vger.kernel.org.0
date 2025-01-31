Return-Path: <linux-iio+bounces-14747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E283A23DC9
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C24A3A92ED
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD041B87D0;
	Fri, 31 Jan 2025 12:30:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0084.outbound.protection.office365.us [23.103.209.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4294C7C;
	Fri, 31 Jan 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738326637; cv=fail; b=A8lwx+TU73W25wggQOmYGxUc+a6Jhj7qeRxJaZTbVeyETZDsT5jmhjsjHqqbnrl9HWyrNz058PgAyYZjGCJkZ1osN5B7P32hAOxl1vAw8cj55aKDrWxNPuIOSPFmp4WwVHoofUMKBGVnrB0omLEaT8lrOrHu4dPuBrtRM5PCGnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738326637; c=relaxed/simple;
	bh=cKwWnT6UsMbDoWHB0gcVteu+cgYUZSyZMdmw0Iwm19o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzglH5Cnmhz8Iw5M1oJ08gobB1hBDSJrAho/LkVVsjJdoBxWlUi9ErrDhsT2UIu2cVxliGu7TSmceRE136dSYRRMDiGUR42YnNrjiZ3JlzG4qiYEEAzNOOnIZetR4HqlKlfITFnaENvTLblNHH8cuca22fzt3ZpzqTHaVfpyFoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.209.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=mhhAf73i3hwtL+NF/xoHdFWEB7JtJMcenYpXpAvRyL0BT4VjPIws3cgS76MHFJM02DjOTg+cRXLGgRWjgbt7mmRqIiRVhUe2qLblY0Fnx908pKqFKiTQX/puGBMDgtiCq/a3vDSVrUPAUt9zVgNRlT6y8YMJOuk91dkLamO3hCXa80BLxGsliWdPZGaTnyky9Gbys16qTVQBssEpDUmJjd3bMzpdcn6ohgkzFW5I6ioOZuhsv5b6W1kDH6ca19ji1zvshKEgEGXheahwP8FIxD4KaWJw2LwAG6lBle7ihHmCisIlgDL/fc+hs65g2nV182QkY6a9AXTi8Gst0HQyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgEuoRQS7tO27642XR1sGwDdJog4z3bSUXdxK7zn7fM=;
 b=O9ugGTLMaxow37OzOWwcmY2fTWSFpIFX82HxLZg0rg+hQ2g91lJQo2Px3uT4G7T8iG2JAEkcS95aoVAQ1+rv4Z2pm1z5GEveCmELWrKPbeCdyYqxGleuFdTD0Ewz2lgNuw74rppVGjE+tp1C9AOpTlJgEZtjrO9r8ZjWvvLuhm+Zsu5WLwqZU0gYqwqBUjo86JouZaQ2vME7Y59CB5DzjJgqI38GMnh5dv8CtgROGgycRaAAq9AaVhG+Ccnlat/gb5IfW+6X0rmihjKoDI+aeUww5JXLJNUIUrlAkt2gCTtvMFyehfKyM3d6dM/GPQG0M6pzcpAlhgvVXVcn4k+EXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1944.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 12:30:25 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 12:30:25 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>
Subject: RE: Re: iio: filter: admv8818: Force initialization of SDO
Thread-Topic: Re: iio: filter: admv8818: Force initialization of SDO
Thread-Index: AQHbc9vnXflzGkW/VE6AYzQsskqTrw==
Date: Fri, 31 Jan 2025 12:30:25 +0000
Message-ID:
 <SA1P110MB10690D050787621F1C96AE70BCE8A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References:
 <SA1P110MB1069C61BF6709D362CA86CA0BCE3A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
 <20250125122610.4d084c13@jic23-huawei>
In-Reply-To: <20250125122610.4d084c13@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1069:EE_|SA1P110MB1944:EE_
x-ms-office365-filtering-correlation-id: e66fd0a1-3bfe-45f9-535e-08dd41f309bc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?slE/4CWYk6+fMOFzFg+Y87wirm4ubaCFioqPNNdetPi8lURAazx6ocmau7J6?=
 =?us-ascii?Q?DCF6ftQfcw3qrTUl/UUsKcZ+DAu43ivf5TeiC+SEEdh8pOCRGjFPwTQimiY8?=
 =?us-ascii?Q?/ESjhH8JsEJBA++CauwUJQWVxrbt6E588tSetEsrN1u7c+BFoF+T/Vpe5TjE?=
 =?us-ascii?Q?B9xMxBBOVgUimKRoiwPrzsKTI5ZGRpYNPlMQmNtPDZ+8Qcv7+47dqRAE40g/?=
 =?us-ascii?Q?pDe/uNPxunp3izcvSdCntHsagunsxY3AhIkdIT6lXhJ0B64VjmaOTW66pM/f?=
 =?us-ascii?Q?t1h0rTJky9Ixp/RHMA3PRblsWvLgXvKI1htPUHffOGzIK5VmOemN3WXaMwL3?=
 =?us-ascii?Q?L1naBlwItYmTtSoKsEYpFqmNqmNlQmOoY3OC2toi6QqO5MbV96AKB5lxhS/8?=
 =?us-ascii?Q?NFOTLioUlkeH5yH1velh8bO9d2GlBOV5aZs9Kun1CXkoI0CHB7l/nH5zUBLx?=
 =?us-ascii?Q?VeFYdAOIJtFeq7MOJzvmed2oZlrtrVAZrXrm5g5ZeokhhM3szWhHkN4uVOPU?=
 =?us-ascii?Q?XuWUOLZpLZbZb5uRsmo6a9hIguIqiwS1UINKJNu/NcHh019w7HH906uHofIP?=
 =?us-ascii?Q?0/a32YnF9WrPw2kjztIVBS5UuLFbev8wBiDLMXOFOVPmZYe8HYwyYWVPVwUP?=
 =?us-ascii?Q?VozvfN9vsRzbKXvDvJSDPoZANVCw5rOJfrIZU/+bFe/YWEUo1WJn4b6y19wE?=
 =?us-ascii?Q?/X9X726QUGJ7OnyROwxS/7qTbnHFHiYkgbE+hGGhWNgQSrjan71fS2kz05yt?=
 =?us-ascii?Q?ly5GRPnDqSVah+IxNQqXSBYlqzYF5/jxxDYQ6VmBferDKIvmSWdp7huK4S64?=
 =?us-ascii?Q?qI62eF3etjCC2Dl/3T16lOzXr2BeB830jtJ/wor+Qu4kVuPHccFQZgA/XBsM?=
 =?us-ascii?Q?KM83ShiR4dRRlzT2/QQZeYxNMb9UABI9tdEk7ZUMyHThzQh9YPhhmtfBNh6l?=
 =?us-ascii?Q?lAeXCE0trvfzh3Pq9xUoqQB3qGhX23RGyAnyLWbbgk4r8GkJaTh8bZOsWD6b?=
 =?us-ascii?Q?Yw1n7/tH4Jpu7Fk1dqU7LljySGlgUsqbMIDTX5k2VUJNCXyNkA1b+djmqoVz?=
 =?us-ascii?Q?ByrRIemJmmaSApRRFpPCkxMxuNb20W4lBkUCpqwdp84tJfSOfphcNxWiN1yV?=
 =?us-ascii?Q?GkX/oV91cv92C3enQ6KO/csxh/7fB9I91GFUdXqyWFos41mzvra+u8DNc4iU?=
 =?us-ascii?Q?IhoKNWBUuz9RHKVDw8YYCG74C7V8zlo79iTx/dOqzDSuOe0ODm2ows8hLapL?=
 =?us-ascii?Q?UAt/9Gxl20w6l+AI+HUhaImvO4BOh1hqvrwAsK3obCDzaU1gMf1W3g1DzqK2?=
 =?us-ascii?Q?JCno8Hiq/G4O0xoBiK0tDTwxCg3uSCVEjuqNdbDJC2nA5O6EDFTA3KDuRwwH?=
 =?us-ascii?Q?PA6aJyrb2Guo9MYyRxtDDUyFL3Z4I6NSj00iUjJov53eQ/EnVTTTzi88ZtOX?=
 =?us-ascii?Q?w4fHxzNhawo4iQ+Diyhyhumj7hHzttOC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cPPW0Af0SKb12Wlr/ykj7kn3G2dPAvRUfGwZW2aozZN5KJhRmhdh9W35SLc4?=
 =?us-ascii?Q?KQfgT56xEOpmW96IaxhOJA9Zk8GLg7p3L5ZWfSLPycLMEVoaUcftSwc0DN6e?=
 =?us-ascii?Q?FbZSlQLS8id+MW9Mvq2gGjYNofrovJVzBNE02Z7HQRSzfbNExLbCjE02OZyO?=
 =?us-ascii?Q?bHre3JaXdGt6zd+aP+DsoF4+AsNCZyjh0lulngOmhFjNcrCfXOkPDI6pYec4?=
 =?us-ascii?Q?Hf2SmIZhjj7h5w2EJo3cyYqKgxgCQm5SYCvu294FI9xPp8kAmcndo/xx15wm?=
 =?us-ascii?Q?2JREHMDKXGjbQ2sMsqcBJKSz6OMn4NWrBpSE6L7cPnHgiknPmaCObbgfWBWi?=
 =?us-ascii?Q?Y2El7GqpZ/6RSaiRIKdq4IBmm6c4Am9i6Qo4fXgE+kCkNUNgm1EHsoVBGWcw?=
 =?us-ascii?Q?/0iaAy5qKa2Vhk3eR45rQT9dNKIqxsVZcP1e4Og+FeN/f9kkDOoiFMfFrHxL?=
 =?us-ascii?Q?ghalilCTS4HgmgY7m0NJ9dQ6cuZq68rdHMsYTmKu7v6u8Ka73TgRLE35w7Ws?=
 =?us-ascii?Q?Hn93cfg+WzyYR9H9dgI/iYVoBz4tQuqAu8fbCSp2wx7wX8liDmN40LVdb40e?=
 =?us-ascii?Q?oQPswWJtapM2QO8DMnT2BehJ31+zxit+KiqnwbDQZytQ5hYoYxS/BCr/ILJN?=
 =?us-ascii?Q?IqMQfX70kx4ta7t0XnwyFn3dhVJCpKJX+UY2WK0t6gxwRxd/6OYyEdd3ZZSs?=
 =?us-ascii?Q?+AKUNwQzrtk4boAwhXXpkg64/Cs9SdpKTtkoI8zuMTkyiE9cTvll/HWsc2uh?=
 =?us-ascii?Q?uFuhL47YUCGcr+fQq2vswBKTB3gYAO9pLmtKHp2lvU3MYb7JGrrdptFN5nfl?=
 =?us-ascii?Q?f5JY4GLZ6EUJFewLYdP8I6XdmquM0ZStU+8yMkpJPutrhruMHivoadgaDxlV?=
 =?us-ascii?Q?tXQPeudNB6+vfjV4+mvzBvR1rU9fwZD0jxfewbJ0pbeIy9g2jGkwzjnEY8nI?=
 =?us-ascii?Q?YQntVVKqJbDJzd7ttmL9H9NCSJtpJvbAR5tER8ZUu+uDG6FJ6TJTdatQ45Lh?=
 =?us-ascii?Q?3SlINs3DOnyv4Vg9m5Xnce232qNzXuoYbecB8eklaoxh4Z8AfnO0Sj6YIlkW?=
 =?us-ascii?Q?trG3m4gqeaEbroKScZ6auoysmuMHXAXu1tJklxE3x7gVODhH8ho5LqSyDomi?=
 =?us-ascii?Q?drFu/xNDNqiRWBueJ3FYOdKBYuIYIKo6/MC01vtjdJcUFJK5Nurm68KNcG/s?=
 =?us-ascii?Q?C731BlcD53cWzpUY1r5EasDjRiFsqmSR7wNLJolDYBT0S8ImoQUZHK3hxGi7?=
 =?us-ascii?Q?vaq3bfECzY3zY7KyP3xHHci12w08xGczHxKSbLKbQ3Nyc0jJBpneD3Xhng4B?=
 =?us-ascii?Q?K+w4aKHQI2IKiXKLPAtPH6r4h+QgMejZ79EO1xoIoA5nq5G5j1BNO1F/sfA9?=
 =?us-ascii?Q?beernn846/JMzSmWQeppt4JL8EcVBppjutQPt69Qp+yvyG29lQ3mwdIEdQ3X?=
 =?us-ascii?Q?FAX3iv7BWawo3l2s2ZfOkBaxaxh5aHXOAqnKwyMghn9GTzHdL1k5ZlfUX6qg?=
 =?us-ascii?Q?ozPk4si2EGYSkMpRIWR/v23zehl2N9XpOS6x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arka.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e66fd0a1-3bfe-45f9-535e-08dd41f309bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 12:30:25.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1944

> Hi Sam, we shouldn't be seeing the email header in the patch.
>=20
> I can tidy that up if you can't fix it though.
> >
> > When a weak pull-up is present on the SDO line, regmap_update_bits=20
> > fails to write both the SOFTRESET and SDOACTIVE bits because it=20
> > incorrectly reads them as already set.
> >
> > Since the soft reset disables the SDO line, performing a=20
> > read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line=
=20
> > doesn't make sense. This change directly writes to the register=20
> > instead of using regmap_update_bits.
> >
> Sounds like a fix, so could you send an appropriate Fixes tag in a v2 and=
/or a reply to this email.

Added the fixes tag and submitted as patch v2. Please let me know if there =
is anything else that is needed.
Thanks.

>=20
> > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > ---
> >  drivers/iio/filter/admv8818.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/filter/admv8818.c=20
> > b/drivers/iio/filter/admv8818.c index 195e58bc4..9cd1eee84 100644
> > --- a/drivers/iio/filter/admv8818.c
> > +++ b/drivers/iio/filter/admv8818.c
> > @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state *s=
t)
> >       struct spi_device *spi =3D st->spi;
> >       unsigned int chip_id;
> >
> > -     ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > -                              ADMV8818_SOFTRESET_N_MSK |
> > -                              ADMV8818_SOFTRESET_MSK,
> > -                              FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) =
|
> > -                              FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
> > +     ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > +                        ADMV8818_SOFTRESET_N_MSK |=20
> > + ADMV8818_SOFTRESET_MSK);
> >       if (ret) {
> >               dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
> >               return ret;
> >       }
> >
> > -     ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > -                              ADMV8818_SDOACTIVE_N_MSK |
> > -                              ADMV8818_SDOACTIVE_MSK,
> > -                              FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) =
|
> > -                              FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
> > +     ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > +                        ADMV8818_SDOACTIVE_N_MSK |=20
> > + ADMV8818_SDOACTIVE_MSK);
> >       if (ret) {
> >               dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
> >               return ret;



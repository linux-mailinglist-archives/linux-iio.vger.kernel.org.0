Return-Path: <linux-iio+bounces-14850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAAA24BE4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 22:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DE53A597A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C011CAA6B;
	Sat,  1 Feb 2025 21:32:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0075.outbound.protection.office365.us [23.103.208.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63F5336D;
	Sat,  1 Feb 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.208.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738445579; cv=fail; b=Abc4lweQ0vCd1eo/hy083Lh4oeMXHQWG2MzRhGsFajr+pD2sqTcig1eLHWDf+vVKVn6EmJCNgv4KXPpeEUmuKTVOfJXw01FVu6MlVkCuOB3UUUpJzijZ0Ge2CZsAdodeXUCmGKljNrpaBCwjBCLtkdzVmzou2lptcaLUUdOmu7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738445579; c=relaxed/simple;
	bh=UJhzWuiz2oD0JBVERO3gVEP56l//JfpCbJRc/petMIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kWwnu5XNYpdLj8SPbcfl4iQs5H8YlVw6Iw6WqPiFUGN9aiRWH16h689AyiXhXzlxOy31+eBuB+EzlB6yWMSx4UQQ2F5eVVCCOiPL8jE2wDZqpVkfqmClYUGIOUg+NkjG0UkpbFnFyOMRwMGV0abqOkL473iAqrkp7RWEhnEp8Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.208.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=x4l9cFIA0PFshB3WKpsx5WX98q1s7csZId6GEMgs063RuvmAPWgxGyzQhzYG4uwWXLJjFDESkKCGYbWQW0bcbr+jt+QFDcnpVYDCgehOU64cmYKpi2BNK/vHWbfLLDGJ9Kmc0YE9h9NJAN4Z++P64/tuWH63B9zVUW5u4fXGaKiH7c0V0oO9DW5gOt0cKfShKuvT8DidRjqHkds51boOIt9BuKJXDNJf113f6S7dHsKtijNcMsa21Ba7gu/V9XP+mldhQRnHNq2FUvIvEccbrphlA8+AjmGOnGhuSNmMW4VQOURr0dMvhBVXWQAkFF79r2u0D/3FBvwWJyC2kxRG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y8nNm1M/RXR9XvocNcwZyfP1ON0onqs8SvQtEbnDtA=;
 b=qxfFHxpFvW4TOzAM4MnzqkIfED+RXCWjJnJQsvNRRATx4gle2IJvxrFMFB6V7lduD4IzA8s+tIOJhUwoD/PcGxVQXPKs2RsxNAWjRVpbscAV4Wnq0kY4EdBH0H654DTEN2qW9l0cMZS6QQ5wdAboiBvyp23I0Uk11mtBKnwZSuE+kryfoT1G8CutG/R0YLhEIDyYQJrB1kYPt0DB6XXEQ1xZrfYdpTAxOng64ivyyCtI+p5NrztWITQjk8mhaw9of7pbxwlwLgP+zULyGaGt3FgymZLoyN8+fsCo8yWbqxJgtRv/edAEPMbEZhlWyOSKX0PZbCx9A0gxzijcGitYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1487.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Sat, 1 Feb
 2025 14:00:59 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8398.021; Sat, 1 Feb 2025
 14:00:59 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>
Subject: RE: Re: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Thread-Topic: Re: [PATCH v2] iio: filter: admv8818: Force initialization of
 SDO
Thread-Index: AQHbdLG4EF4mqu90fU+UqFnv+RaFfw==
Date: Sat, 1 Feb 2025 14:00:58 +0000
Message-ID:
 <SA1P110MB1069C9854F796B755E5E24C7BCEBA@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
 <20250201111813.6b8cbf5b@jic23-huawei>
In-Reply-To: <20250201111813.6b8cbf5b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1069:EE_|SA1P110MB1487:EE_
x-ms-office365-filtering-correlation-id: 7fa4a5c2-aa33-417a-49a0-08dd42c8da8d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2U4RLEyMkmXfJ3532nVu8zoZuz5p9rje32w7PtH/0XsvP4bgbrVEeBK76dh1?=
 =?us-ascii?Q?UhUyX+z6FD8LqOjjdcFYITSIU0lQqAFSbjkSZ/ETx5mBXuo3ShMrehx67i3U?=
 =?us-ascii?Q?1KX/+4H+xzeJcGdZ020FJ7mJRMRA65vk+r99oMc7ywPiLg/JTgCBCQIdbvlo?=
 =?us-ascii?Q?aZdaZ0Yb9EvA+B7eC7W43gXq7PyAYKoUVs22AKn1+rJ1yr+fc/5CA0njsQed?=
 =?us-ascii?Q?zfN/uygYoxqz0eVvl/GHF6NsAGoXgavLnQcRrtpdlH1UT/80/i8itmsjAZqQ?=
 =?us-ascii?Q?YPlXi31y8X/uDD3OpYDipthmbslErpiSOsJcGgi5QJOCBbG1fTxttUZHiNSO?=
 =?us-ascii?Q?QcRFulWgX624PM3+O0K0OdbyNEFmtqQSA6EV0ZkRXNZ4TuOc2e6wkwv4xmLB?=
 =?us-ascii?Q?hMvN3lFU7nj3IdiF+rfpdqPBaVZnoePEjU2gCL7URBQev37mhCoAtapVg3GZ?=
 =?us-ascii?Q?dhI11jkJjn1ifzd6AgFG7ZbYV5T22Fo53qVDiXQ2rVUax4iZXYComHBASI7I?=
 =?us-ascii?Q?lJQ5FeMhkBN/S3uhjTn6tA5Z2DqmaZc5JNC52dm6Bfa8r0pRcoaQBwkqgkAH?=
 =?us-ascii?Q?GJ5gEbhPoaf+cpoUY36ubjfY2rgUsM6MsAbxJXBm3w45PeX2S38MpVV/Srns?=
 =?us-ascii?Q?CWGr9gmjaTaYaBbSj4rRLeRXeM+fL9RbiQugDb7wgWwrCMTV/QPLAhsXPHQj?=
 =?us-ascii?Q?z/Wu60A6QnhC4v5QiPndp8yZPMCqiuPgKMw6lw0zX4BIj+zqYcB6ds4nTHAm?=
 =?us-ascii?Q?2T+JfpOOHJZJ85i0O2XwW7Qf57AAbzkAq0duvhHRYLDy1VI8V7JfnmLPSQdL?=
 =?us-ascii?Q?WDGISLprEgH4TE99ylc7lFDdGLxCCw+sMh1U6bQwwbe2TxoHoPvSHU35/h/V?=
 =?us-ascii?Q?dIGqCtrVmLhIlCCtE8YXTV1EWD3nGlnP1ptDvXiQw+PePWPGn2HMDTy27x2A?=
 =?us-ascii?Q?rV4k1J338Eml4MlnZOxYDM5R2EwNDIMfrf11mEMvSX/nSY5RzgjM5Ge7M/3V?=
 =?us-ascii?Q?ouUjiOs7ZGWvXqTC+L7a+FS7kZxZQ+3QHOCJd8RqAQ/IMrO6xBSSaK2gnUlU?=
 =?us-ascii?Q?E+AAu6x/bsqbRG0vo63nL6VC99OdDrmtXwQF1Z01WLWTIhsb4idwao+CuKnm?=
 =?us-ascii?Q?423K66fhvSoMxwxX3aTxAcRg2Arlv6bMA8gAgr886izkUFnpQo+QMyo6iRVl?=
 =?us-ascii?Q?nKs+gcFU7xZOperiPbUhF9vVVCGUuiBJGl0oNBTJx91/TZLukzZg7EvWI0Rs?=
 =?us-ascii?Q?GOl5OoAOjQCDSIadss2NtEMF6hUkzQr8Yk3QMhFvT4ZQXxCukEPQG9/qTRD4?=
 =?us-ascii?Q?rLAVbPsJFgB1gS+XyXQXotdajrXsSsMOyl1n3AM9o7mAlXJlj5hWIaovAVDl?=
 =?us-ascii?Q?qHtY5S4OPSyH+wXTGMIpKKOeK0ypqgSbP+65FMvXhteb6I0wOY3csvbUVuMw?=
 =?us-ascii?Q?Wru/iwfnvdmPwVYSR9iZqltvU96pKNbG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KvTGiu14WpNIlvsLCI8WYPsee5OQ97dxTyH3q+/S1Z9ppfuOwBsGAxJinM97?=
 =?us-ascii?Q?qvdLFqVHJAVaH/MW1CYJcyAv2zv9x1YXJi7plUJx8NODZPcoi03r8SbCuuOR?=
 =?us-ascii?Q?qsSyLV9MBTmbmnqmK6seNPF2Vb+wH8zLZj/W/EgQLCWVExLm4V76QHSBcwH3?=
 =?us-ascii?Q?4A0mWDl2A7pAj6I7DHjIyU/4CXuIfC2Rtz59P6gQF3iIG4KdU0vHbCiHIOcu?=
 =?us-ascii?Q?L8uDgQ0JjwyMdo6bteYBu29PMe09pYQhnFOxUewCEROoSzXOE9Bfu0K0XIwe?=
 =?us-ascii?Q?1grM1ueL1PLE3NB0gzeYaQTxOj6f44mfyHW3VS8Qt5bP5QpreEmXUeS5OUVn?=
 =?us-ascii?Q?KKOLCclFcCSc5pKJkkV+FmzOJ+id2tVEyFUkUQYV/3kj1YLcKi3I1iVUrOEj?=
 =?us-ascii?Q?y9PXEqM5TZ6KbtGDhiAyuAVQIdPAFNe1IHCQVtaBC+ruEY53CNJFWM1EE3/n?=
 =?us-ascii?Q?2aBKauwsngp/PYZ8cUCC3y1Hkq4iyvDQnQ1FtDnsSwKleA6jrtDLyb20anIt?=
 =?us-ascii?Q?YT0sMJyTQ8a36MZ/wttgGw67dVhDbL9rdqPbngUPvQ6J9dRPM5mN9yDFtKm4?=
 =?us-ascii?Q?tTSNhEl1kGRBxahlSLX4yObpy0nvcwYXW1HRvDump+26b10Z/T0zkcJC2nkQ?=
 =?us-ascii?Q?s9ngH1K3ds2d2jtBG3H8+AHXornwNDhDyT2+dKh8xT6FVWwr0bnUTNM1uLNW?=
 =?us-ascii?Q?ZxsdoIm5EfC47UCJof3Sp8ber+7bC+68N7IXdv2KuYqVI/BIN8hAUyJ6QPNM?=
 =?us-ascii?Q?kB+jukv+teVM37nzZ3g1BYynAjUvEFS6uiRyk9E92IeIzGFasg7RM0KQgovM?=
 =?us-ascii?Q?lW8ff8PkOs98Iw2RBaa1e0n2q1/kODGJ1tch4uxV06YkkASk1RWxto0VJ7GK?=
 =?us-ascii?Q?I0PjHXIOJvkS6/yKTbKLbvHGxpoMSEABWeBxJGjIn6YGIDzjLnYyYhcm/twy?=
 =?us-ascii?Q?x6S78c4Yx2cC4Ad32u3Dt0TK4s7komTUmw5H302zy04HEaB4hgVc6L2NUl9L?=
 =?us-ascii?Q?8TOfnKtWYxxNwwjiuli4lElvlCSXrcSpesHChQOBTAA3XlnZZ7Sb4FwUM3CK?=
 =?us-ascii?Q?tXCv+hKpQaTl6Q0W1DsAMz8v4OKlPKoRxHUIIH1HLp7fcTjEnxyhOPRAxQS+?=
 =?us-ascii?Q?W8j+UrMaa3rgY+6YKGKIvKAJXneiieQCclemLwS0pN+NxIeVD0Os29z+tbvk?=
 =?us-ascii?Q?k65FtAglhNoBACYRbFIMgFFPtbDwMMYNAUgb8Rq+5ibNv2W9fmKVpfemZMTm?=
 =?us-ascii?Q?pFGwpwfrXDpISXLpyHZ6Q5Wej1GL4OyrDFo0TUXwx+12DXPwQwxU3ARdm2o9?=
 =?us-ascii?Q?0zVz2IWQlu7rONDx0mySWEq41dUNmkN6mOA+zn7WQcHWDNaTkBhMODHAJhDb?=
 =?us-ascii?Q?8Mr/5b2y6SlisnhhLuUq91xuPADq/ofzoq+vV9oH7WG9I4C17quqxVgP7lq3?=
 =?us-ascii?Q?CzT5jPlQzlTlNF84relOUjbWHKI2HDBY/5ZCUlXNyG7yJe+AZlq+ixDpsLWD?=
 =?us-ascii?Q?qXAqPDLWQt0glLbAnByfokJupyHxC2ER4gti?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa4a5c2-aa33-417a-49a0-08dd42c8da8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 14:00:58.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1487

> > When a weak pull-up is present on the SDO line, regmap_update_bits=20
> > fails to write both the SOFTRESET and SDOACTIVE bits because it=20
> > incorrectly reads them as already set.
>=20
> I can see this as a valid micro optimization but I'm struggling a bit on =
how you can use the device if the pull up is weak enough that you can't rea=
d data back from it. Does the reset in some way solve that?
>=20
> Having asked for the fixes tag, I'm less sure on whether this is a fix.
>=20
> Antoniu, I'd also like your input on this one!
>=20

On power-up the device is configured without SDO enabled. This, alone, make=
s the read-modify-write during initialization incorrect - It is not possibl=
e to read from the device seeing it is not driving the output.

If the SPI bus, like in our situation, has a weak pull-up the situation is =
compounded. When the device initializes it reads backs all 1's as part of t=
he read-modify-write sequence, falsely determines that the soft-reset bit i=
s already set and skips resetting the device. The next step is to enable th=
e SDO line. It reads back all 1's, falsely determines that the SDO is enabl=
ed and then skips writing to enable it. This leaves the device in a non-fun=
ctioning state.

By writing directly to register it will always perform the reset, and it wi=
ll always enable SDO regardless of the invalid values read back during init=
ialization.

> >
> > Since the soft reset disables the SDO line, performing a=20
> > read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line=
=20
> > doesn't make sense. This change directly writes to the register=20
> > instead of using regmap_update_bits.
> >
> > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> >
>=20
> No blank line here.  Fixes is part of the tags block that various scripts=
 scan.

Is this the blank line after the fixes? I need to do some research to under=
stand the tag block.

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


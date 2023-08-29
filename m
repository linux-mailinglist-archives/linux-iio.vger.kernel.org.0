Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A278C795
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjH2OcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbjH2Oby (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 10:31:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1661FEC;
        Tue, 29 Aug 2023 07:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw4DyTjpgq7VzLcHbvlGh0ipQwR8XfwBKriBa+3fVtCuq7xSk9ZnazoDwcCfsAayB74GIORZEhewA8sQcJ3q4OSmFcX3cGkxfOUx7Yh75AkhpIRqyehTB+b9QFNcdB2mIHD/kpGu7ecstPFzIMPjc+pvwGmeO2kDVgE7l/gobfGKSiVxtz9+8HWOMSSVhV+tXbWOZa/bCSL4wW0J87p65E9iwlDmHX6c9EgzR17jIpshxGx/Pny5zLkofQ/B+inVtmluwY5eEmU+JYDZYjvstLT/ERLWO6FlC8qsCZpgaQVV+qxyqekgio0HsuiXzXXjdDG699uycgcAuIYP9/mcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ja1/QiaRaLHP1NcYzoiLrBu3pM3vY08cslKt/fldN4=;
 b=flZ74/BYqVYd4xWyZvjNc8N08h4SBq3Tu4v1asQrIv6T/3y8dRBB/mK/TX4XdcbsAN8B0q8SgaIK5Q9OPQxodNmUk08KIQuIX72xzHligWA8SNgOB23HMjSUMhUvMwTlqLrVhVPstME4+fxy8mbSg4W0pHoHvX9oklUbj8QbyEwggUpzLJdrzYEuoYTiEUPH3ev6lAdA3uoT610yuKg9wa4WGIxU1aB6upCOwkhpClxOSyeYCdGvxCZXsliytyCzVfhH6nX2DWNFUT6zakM96Ipyh8mh28SadudZduRx4bawvWw5T+2Oy0saUY4ud3bCo0LcrlAN74W5K11Tg52SaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ja1/QiaRaLHP1NcYzoiLrBu3pM3vY08cslKt/fldN4=;
 b=X5Q6PcAln4Anlv3luNewhp+wtbWcbFD9HLBeXU8MJhNmxmxduZ9esMWUjVpKS3UaB5TM7MpXLSz8b6mqXSDADmKS218X8vlt5AVOYi0KP2YH105Pq/cRBPy11TkMUmS3ORX4Dsty02W26VOwaBZ7GMTKpsVGyXdTs+ObhC1QuAk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9875.jpnprd01.prod.outlook.com (2603:1096:400:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 14:31:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:31:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] iio: accel: adxl345: Convert enum->pointer for data in
 match data table
Thread-Topic: [PATCH v2] iio: accel: adxl345: Convert enum->pointer for data
 in match data table
Thread-Index: AQHZ0f+RVC+TghUIq0qBFm0IPCGs26//pxKAgAG/stA=
Date:   Tue, 29 Aug 2023 14:31:46 +0000
Message-ID: <OS0PR01MB5922770083CB801AD06FC41986E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818181229.329055-1-biju.das.jz@bp.renesas.com>
 <20230828124817.2622d85a@jic23-huawei>
In-Reply-To: <20230828124817.2622d85a@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9875:EE_
x-ms-office365-filtering-correlation-id: 841f1299-09d3-4bf2-e986-08dba89cac36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDulna9lAfSlDX/6tGBc72e9n+4SlvuihvoH3j3ghdsSiPl3PONORnvClJjWz//6qmyEIiTgZolYKO9BxdinRDA9/FS6xFSJwyyuJfoDsxY6RZec5YJysCvvZ+ovupKszuebksndtM10LHMLG+iPQX+lEnwrETNW3VmsQOGbDlwlEL5ItitQn7VUsNypcT1/i43Xdo8R7rE9gkb6G8zmWfcZMh0SGXbPxGEQdTUv4LEG5eAnzVscJ3JQZBSJe7bb2HTy7nyUGFscnvqhD2Y9Q0kCOpe4MsNY++FBGgcdZhQieWPO7Fm4wvUB5Xyxa1NWJTwPaZB53WNTCVejXDles5kaPrnriMzOlpgFezHazRhBjprqeQ1vrcK+AR68RXaksXwvTOR6n81f92VHYFyshYErBP3deU1feqUIg1R7FxhUudiP/stF6x16seYUWjZnEqOluyhKJ+XeYUhbVg0W4WXMLJ4XG9q/GOrIaT6Yre6Y6sJ1VPmm0VYtmTWVNBS+mRYVbScltecgCMgd+EgGjw2Zxgpodx+7FAWCudglAJiq2BvzgwYkkZASCrCSVXSVW0MtWTm0a0mdFxhu8exTPEoymegwfsA5Q7NCsFWbk45RcZ5mEAMH1ri4RgDQNvd+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(54906003)(76116006)(33656002)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(316002)(6916009)(55016003)(41300700001)(8936002)(4326008)(8676002)(52536014)(71200400001)(6506007)(7696005)(9686003)(38100700002)(38070700005)(122000001)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBc1XujYIJ/V2XTZqiGMMPQSPRaOj4qSMvpp+ZrhCrNwZ51+PYMqRMtOEL0i?=
 =?us-ascii?Q?Ze5CLwpfxnfoGRNG+nEA1KpQpQ2Jiy5QVMmkAI/7B8AI5w2RjvJjWgIGXBeb?=
 =?us-ascii?Q?IC7IkZAxpYbaMlZLXKK9N6n0GM4AWyBNeiCtAygT9LQ6q2TgpgYZVUefv7ec?=
 =?us-ascii?Q?vg8wyom9bdPhaUwDTvE0HI4OaYICnrFonSEyjYZBxhuQIKtJFo5e5h2Z79zP?=
 =?us-ascii?Q?cXwya102VPGgDWo+VP+fpeemffrA7ISa/WL+eCXI4Er9E39PGY5s3zuhGn77?=
 =?us-ascii?Q?R20/4wlFcYBVcDrFsUsUyza9Ri+4Go6eelDMyaMdClaaoELsaUr+lQsR4bh3?=
 =?us-ascii?Q?t9qwJqOKR0Vg6cOtrvLMdohqYnYnPmUj45ovdBQCkZu5JiujkPeHnzHymc33?=
 =?us-ascii?Q?fqjSquUxFwAl5UoQzDWD3koUWxYFT3385KL1IgW0p8R3gMWKMXPPZr1YG+em?=
 =?us-ascii?Q?6vjwcLJSieb1ytMN1xEvClBUuc4nWBvi9P6n7d4i/AqGOt3elqHCtkMokdK3?=
 =?us-ascii?Q?I0bEZZ0VjIOhoTdCO3Geg4hlCpJAt9zv4Q45ffZGoiNfAI0+y8i2fN1TsM43?=
 =?us-ascii?Q?Jsd+tw47wnfMlbvrMBgB32uQlDA+L8ysPydXGT2HLdgxFzEVW5DqmV1MrdO2?=
 =?us-ascii?Q?yf7oq7XcQTckCJkvcT6929S+4l8IdIt+XTBSEW/yiQyiqw+DZz5f5cjAv7Os?=
 =?us-ascii?Q?eTDiOqg1PG6eq1BX1O+8FUVdGBdDpvRVo6RwCfkpsY3GCdzCPXShxF1Z0wkp?=
 =?us-ascii?Q?rfbcs9NAM7WslomfBHAYK5UdKealNJeCOiFoRhc7zY/eLrY6IDGd8GxmaeHE?=
 =?us-ascii?Q?HogmSjz/NSozwAFqE6GBb6uxTq0sng8jk3at4FBDHK/BM58J5xgMq3rn10Ka?=
 =?us-ascii?Q?aD9mvvczk4vGWOLjFrDttM706+yBRYv5tWc6jHUDCenFdWysZaG5BGo+VGrw?=
 =?us-ascii?Q?9PNOe5apZsL1o9VADjFGnxiHCUc9aEJiuzZ9IpLEDQrtWNi8eKVdPkx8sAdI?=
 =?us-ascii?Q?x5cbqrG45Ag8MTdAr0hLPaTeYKS9/JU7Dqk/+D25euUDH2A/njPJT23rXqCY?=
 =?us-ascii?Q?WrbrlURUmy3tZw34wOEewlBNSuXE/MhAQ7E+ECoNHYjAHKWZ/uxl+mhgTQyB?=
 =?us-ascii?Q?uX5MTVRTLAHAkfRKOiDBDl18UA3v3coCFFDhVNaBpU+XTD5e2nP9hCQuKXVj?=
 =?us-ascii?Q?s7HDP7dzk3xyFnjBA/op1d6mSQXPzvUMj/749Gcnt9dsshhSb8n85qb3LgCr?=
 =?us-ascii?Q?32FAmjSShpm5IQnB3HWIn1fP4niWN2dFnyWuted7fUTlUilufM18BdU9z2LY?=
 =?us-ascii?Q?nUWxEF2WrPUqhNHRsP+AwfszWrDaSNs3x7p5J51uKDm9l07cjzKJWg5lMDUf?=
 =?us-ascii?Q?c+zkMf9f7IjIcuRKXJDGMkWLFvrjCY1Xy/9x/lY9QHVr4WEH2SuN6JfbrcGt?=
 =?us-ascii?Q?/Ui2wsVmZMsAjPndOF2zpHIz03OoUjE6yWdzFxBAzpFUkWskCRRc9FuYo69D?=
 =?us-ascii?Q?Zu4sLUePvOBwqRqM+CuvbNCf+cA1OfnH1BrO2T1+oEIc3eGxcEhMIaInUE0Z?=
 =?us-ascii?Q?3eHfk2xiqgacagBsdso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f1299-09d3-4bf2-e986-08dba89cac36
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:31:46.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MN3ctlZTo4L3/eTzcP1qm+bIkLTybpmvLaT4RxRVopZ++T4cOTkt4XgK9qxIF8v+LjfdvcbHNdOBJKv3HIybFH5AbbBTyK1MPbCn8OM9io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9875
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan Cameron,

Thanks for the feedback.

> Subject: Re: [PATCH v2] iio: accel: adxl345: Convert enum->pointer for da=
ta
> in match data table
>=20
> On Fri, 18 Aug 2023 19:12:29 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Convert enum->pointer for data in match data table, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > i2c bus type match support added to it.
> >
> > Add struct adxl3x5_chip_info and replace enum->adxl3x5_chip_info in
> > the match table and simplify adxl345_probe().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi Biju.
>=20
> The enum is used for very few purposes in this driver.
> Whilst this patch is a good step in the right direction I'd like to see t=
he
> enum go away entirely by adding the remaining chip specific data to the n=
ew
> chip_info structure.
> I think that's just one scale value :)

OK.

>=20
> Jonathan
>=20
> > ---
> > v1->v2:
> >  * Replaced EINVAL->ENODEV for invaild chip type.
> >  * Kept leading commas for adxl345_*_info and adxl375_*_info.
> >  * Restored switch statement in adxl345_core_probe()
> > ---
> >  drivers/iio/accel/adxl345.h      |  5 +++++
> >  drivers/iio/accel/adxl345_core.c | 16 ++++++----------
> > drivers/iio/accel/adxl345_i2c.c  | 20 +++++++++++++++-----
> > drivers/iio/accel/adxl345_spi.c  | 20 +++++++++++++++-----
> >  4 files changed, 41 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index d7e67cb08538..8df1b7f43cb9 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -13,6 +13,11 @@ enum adxl345_device_type {
> >  	ADXL375 =3D 2,
> >  };
> >
> > +struct adxl3x5_chip_info {
> No wild cards in naming. I almost always ends up being a problem in the
> long run.
> adxl345_chip_info is fine as it's in the adxl345 file.

OK, will change it.

Cheers,
Biju

>=20
> > +	const char *name;
> > +	unsigned int type;
> > +};
> > +
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> >
> >  #endif /* _ADXL345_H_ */
> > diff --git a/drivers/iio/accel/adxl345_core.c
> > b/drivers/iio/accel/adxl345_core.c
> > index 1919e0089c11..810048099ba9 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -222,23 +222,19 @@ static void adxl345_powerdown(void *regmap)
> >
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap)  {
> > -	enum adxl345_device_type type;
> > +	const struct adxl3x5_chip_info *info;
> >  	struct adxl345_data *data;
> >  	struct iio_dev *indio_dev;
> > -	const char *name;
> >  	u32 regval;
> >  	int ret;
> >
> > -	type =3D (uintptr_t)device_get_match_data(dev);
> > -	switch (type) {
> > +	info =3D device_get_match_data(dev);
> > +	switch (info->type) {
> >  	case ADXL345:
> > -		name =3D "adxl345";
> > -		break;
> >  	case ADXL375:
> > -		name =3D "adxl375";
> >  		break;
> >  	default:
> > -		return -EINVAL;
> > +		return -ENODEV;
> >  	}
> >
> >  	ret =3D regmap_read(regmap, ADXL345_REG_DEVID, &regval); @@ -255,7
> > +251,7 @@ int adxl345_core_probe(struct device *dev, struct regmap
> > *regmap)
> >
> >  	data =3D iio_priv(indio_dev);
> >  	data->regmap =3D regmap;
> > -	data->type =3D type;
> > +	data->type =3D info->type;
> >  	/* Enable full-resolution mode */
> >  	data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> >
> > @@ -264,7 +260,7 @@ int adxl345_core_probe(struct device *dev, struct
> regmap *regmap)
> >  	if (ret < 0)
> >  		return dev_err_probe(dev, ret, "Failed to set data range\n");
> >
> > -	indio_dev->name =3D name;
> > +	indio_dev->name =3D info->name;
> >  	indio_dev->info =3D &adxl345_info;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >  	indio_dev->channels =3D adxl345_channels; diff --git
> > a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> > index e47d12f19602..219de556e81a 100644
> > --- a/drivers/iio/accel/adxl345_i2c.c
> > +++ b/drivers/iio/accel/adxl345_i2c.c
> > @@ -30,22 +30,32 @@ static int adxl345_i2c_probe(struct i2c_client
> *client)
> >  	return adxl345_core_probe(&client->dev, regmap);  }
> >
> > +static const struct adxl3x5_chip_info adxl345_i2c_info =3D {
> > +	.name =3D "adxl345",
> > +	.type =3D ADXL345,
> > +};
> > +
> > +static const struct adxl3x5_chip_info adxl375_i2c_info =3D {
> > +	.name =3D "adxl375",
> > +	.type =3D ADXL375,
> > +};
> > +
> >  static const struct i2c_device_id adxl345_i2c_id[] =3D {
> > -	{ "adxl345", ADXL345 },
> > -	{ "adxl375", ADXL375 },
> > +	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
> > +	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> >
> >  static const struct of_device_id adxl345_of_match[] =3D {
> > -	{ .compatible =3D "adi,adxl345", .data =3D (const void *)ADXL345 },
> > -	{ .compatible =3D "adi,adxl375", .data =3D (const void *)ADXL375 },
> > +	{ .compatible =3D "adi,adxl345", .data =3D &adxl345_i2c_info },
> > +	{ .compatible =3D "adi,adxl375", .data =3D &adxl375_i2c_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, adxl345_of_match);
> >
> >  static const struct acpi_device_id adxl345_acpi_match[] =3D {
> > -	{ "ADS0345", ADXL345 },
> > +	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match); diff --git
> > a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> > index aaade5808657..3acdacc07293 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -36,22 +36,32 @@ static int adxl345_spi_probe(struct spi_device *spi=
)
> >  	return adxl345_core_probe(&spi->dev, regmap);  }
> >
> > +static const struct adxl3x5_chip_info adxl345_spi_info =3D {
> > +	.name =3D "adxl345",
> > +	.type =3D ADXL345,
> > +};
> > +
> > +static const struct adxl3x5_chip_info adxl375_spi_info =3D {
> > +	.name =3D "adxl375",
> > +	.type =3D ADXL375,
> > +};
> > +
> >  static const struct spi_device_id adxl345_spi_id[] =3D {
> > -	{ "adxl345", ADXL345 },
> > -	{ "adxl375", ADXL375 },
> > +	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
> > +	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
> >
> >  static const struct of_device_id adxl345_of_match[] =3D {
> > -	{ .compatible =3D "adi,adxl345", .data =3D (const void *)ADXL345 },
> > -	{ .compatible =3D "adi,adxl375", .data =3D (const void *)ADXL375 },
> > +	{ .compatible =3D "adi,adxl345", .data =3D &adxl345_spi_info },
> > +	{ .compatible =3D "adi,adxl375", .data =3D &adxl375_spi_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, adxl345_of_match);
> >
> >  static const struct acpi_device_id adxl345_acpi_match[] =3D {
> > -	{ "ADS0345", ADXL345 },
> > +	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);


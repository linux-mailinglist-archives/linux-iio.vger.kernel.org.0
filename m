Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF178C79B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjH2OdU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjH2OdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 10:33:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62360CC;
        Tue, 29 Aug 2023 07:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+cTVn13+I2/CkFIb6XpJg4JfhvZyIKpvbDUhA/Gsho15nJOYmts8b0pKXdqWHwe33lxcJaqUYw9m1If7xfVtnHse9PaN6PsjdVP0i53tkxlKXCGDeGs18He90WBxBvjzBecRsx85kAKRb2L0rtJlSfKMUl4nEzkgd7SPjx6gnos88WRRLwQ0zgmShSPd7WzuMrXLdZl9nP+Suoq0/LnaG12aclaZk3kG22j959n0etR1po9OFkFKtWI8Nu4LIZmftQktGDWvPXHIjfXFegA1E1E8BVlm2CmzC6jdBC6V3stX0h6MUJxpLYJwe6t/bsgmeNaI5NeQAKUcEhJUKY97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=687+Kvryh8BgBtSeX3LOl/MvYC5APiCXgwtDtme2Oso=;
 b=TMWtio2mKn4vmW8q5k5tWE3Yss9QK+KPMIXSaJVl9Lk2AvPy8KNhRCHJLvzVtEz0PzovR34D0WwmPoLcV1pnI5Mz8Q73LV6VJ7Im1NzxXKB0jrxyHb8lHm5rNksshQJNGdpSKyyaUualvpFGJ/cTgAniTl4+GCzusJ/r27iIDNVbEF+ggCzGTsaqutNSmQ5TGwZgHOUk0mCKyZZGjiILiETSAkhkTtG9ueloK3xoKa3NfcpSOOFe8to4j4DcWF9n9WidB81CQqRrF2SXjIgKeivBNWhKP3+qe/kLzKX1l37TGrDUwMOZj032sMDXsgw0aD86upta8N0MLuasawI8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=687+Kvryh8BgBtSeX3LOl/MvYC5APiCXgwtDtme2Oso=;
 b=eO3rC13nbtqGE1WWmXS6b4c5XjDrlc4DfXpWXh7Mks4zkZwwSZ8tlvZRsM0OmPXec0nMFqDire+3KzC7k11gJvm36jJp4tQj19uQkF8b1c53ATPvG4TKbzn54lfQGn63Bo/cTHl2uDJCi3ZqZEZ3lwBz/oif/AIRzDMIIYJptzw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9875.jpnprd01.prod.outlook.com (2603:1096:400:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 14:32:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:32:55 +0000
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
Thread-Index: AQHZ0f+RVC+TghUIq0qBFm0IPCGs26//p8WAgAG/fcA=
Date:   Tue, 29 Aug 2023 14:32:55 +0000
Message-ID: <OS0PR01MB5922FD075ACA5C8D8C0D746786E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818181229.329055-1-biju.das.jz@bp.renesas.com>
 <20230828125047.406d667b@jic23-huawei>
In-Reply-To: <20230828125047.406d667b@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9875:EE_
x-ms-office365-filtering-correlation-id: 5148d5c4-5ee1-442a-4a38-08dba89cd5ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9Rl/8sI73HxwODpI2RqwWGvm5gp5Rk7H83Aed0CfPNIVgXT3uxMb+pPwE3GEK23tO/7rSl5x3hxXvmrk4JjllqhXv2B/+Tl4GAWomERovKNHo5CR6WS3UwTC1ITZQdTEnp0LfmqNQQZydcwMsYU95nnT5qkZabb6mdsXZMIQUDHB8HC3lt1mGS0/Il8ExflgK9t0PIM52xF6mxNBAAg60Y8qUH/Z6MjDBp3CrfKCfNZpPZtcR3Me5aOUUh5dz/Bf4rbftBS1GLrbBr3oTvSJ6gOvxyl1ZDUOsGFP+4RA8RktpQgTdy2XxoJkAHftI9mIPPHpZ0OWJ10tkln1YpV8h6ppPcDGFRvYkugQ2rvDqhAM/LMain2y6veAj1ZDzVEOarNqEPj1uMKfJXNWc7e85urXPag73Y8cSGG69CUlV0Dn8nGxYz15uHyuZluheDm9dzjNK9m2Iiw0Gam7g0sevzaxHXiqXrO8B4dxeM18uQXWGBGc7Bm/mA41y5jPL2l487X2twI9CtQL3bolqeQw6OrqIS3JWAv2kQC5z27SGIlknA+YdeYVoJ5dpzZCk/iBQc/+dGjuhyOwESUobdp5pvxHD/XLYB5pyg0pL0rsXZ3K5XgIX4XyDeX5URhONsA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(54906003)(76116006)(33656002)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(316002)(6916009)(55016003)(41300700001)(8936002)(4326008)(8676002)(52536014)(71200400001)(6506007)(7696005)(9686003)(38100700002)(38070700005)(122000001)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9W7PL9jnTE5aCJHrvyGVTY54rPccWQnVIRsaobn9/xJF+zjgoBOwPisBMvPF?=
 =?us-ascii?Q?tAEkPfV/cw9VoHkqARPdRyFkSmcCBn0eqmoChIzmH/e81x8XGydMOdTfFq0f?=
 =?us-ascii?Q?G0FJINYelxSXG8NuC2Gt+xqMhQg0dUrreECteSVVvAeZxIwG8RJfbSDyRZpH?=
 =?us-ascii?Q?I88iglfGwi+dS+msiNTvbaPDQ9bFlzibGMIjXFXiup8Zdhz1Mni21++r+chw?=
 =?us-ascii?Q?T0UiYtBmQAyFcaLlStNugcBohFZjmGjw1X3F+qP67Caovgjb247zmudLOJN0?=
 =?us-ascii?Q?hAf1CT1+sIjRtPJ+VeuWUwYDm2Z+uXY0cNeDGyI4pA2wX55FjxunaTXrMfsn?=
 =?us-ascii?Q?zothl9oB9uL9vZcCWgFaJx/rNDuLz8AcP6CBhCHKY6VTEgt7qkf1jqUbYwcZ?=
 =?us-ascii?Q?lwHczFLO/gir5y1uY895EWbLfEz0bwQtWmNVIm0zCDJ04CuO0+s/abRgP807?=
 =?us-ascii?Q?tmE/a3mvC424od0XZTvgc2E4P/OndXhrT2MDy+OR/Vq/hzfC9ygdGCY/gyeB?=
 =?us-ascii?Q?ZvQefAueftiMYoGRtTGZlOIUFCyn3z53wnnE2NbUxwcKZo4c3hMIF+si9QuG?=
 =?us-ascii?Q?xtSHddkK40EQhXk/L+PPX/9TY8iMMb7iqckujzMtw5sk0TJorwEvqgTMdQg6?=
 =?us-ascii?Q?tav8kkofqvFzRqCljiYtzG1IMihJKCw0exK/LEKU2OxEGeatiOizSVF9dLXT?=
 =?us-ascii?Q?bzrjPQWDpuVA4IoefhSqnuxSQgtotpBLu8Y034Oe7weyw/1HEJA3cu/UF/Bq?=
 =?us-ascii?Q?OOeo2ASFReVjTPf6G27QiNKvl3IrWQppgimaLCxZNeHy8xtZ6zeyJF7MEjE3?=
 =?us-ascii?Q?0R0nnQ3VFzxh1LPoYkUY+Md7Oo/PJ4vhcsep6KmJu7viqYiSC3dKK4rlcvE8?=
 =?us-ascii?Q?jlI+O3Ir+0pzSaIbITLKDGT2AS7A7Ksf70uV0QOk+rZwmzDObBFryIU2fJwV?=
 =?us-ascii?Q?SswfLi5B3ueSV4d9gad4svEQ3RJp71fc3gNKthvOFOGHYEOaMJuSW4elGVOD?=
 =?us-ascii?Q?+XIXfwAp3mjtCAIMVa49T4pTHNn6qOXDeql5l1xy1w1gY9QwR95q6UwWWPeZ?=
 =?us-ascii?Q?O5sMLHVOA4jYF76OC/T6GIZKE63jRIRSOjYJBcJhF8M0/jJ8xwxtpEmhVkrU?=
 =?us-ascii?Q?HI04GsoYDnEm/Du1Le3wNMYI2c4/9HbL7pPcUKD/C5SIh6SbF3fAlXP4ysrm?=
 =?us-ascii?Q?CWNyN8y+0fBDXZ2SH23ciAS6a0oRiQT8Gt/Fdcg5TKjfJV6q8VctFV9WPwau?=
 =?us-ascii?Q?VVGr73Kmd6HTk/0ZLiLDWdV5h8rfjxX7HMkQ0tyXmgObWU4qp/8wpgJTj7eA?=
 =?us-ascii?Q?JBjYZicmZ0ZgJ3dDQmL3HjrRhQ3j1j7ftt3P91ZrRCTCwSzSHGgq6HjeXLAS?=
 =?us-ascii?Q?isk0bFdtZrw/AosD2MBL71acg36rMNrdVu54F/gN8rCpxyGwscJNtW0PqT0w?=
 =?us-ascii?Q?O1TuBCR2icKEe6WoVVEARO5m0TMTM9o0n9MYOUcZVB0Xfb6TrMH8SrIgsNst?=
 =?us-ascii?Q?N7ltTUBFFfW1ufWJk8FttuR1BAg2PdlFujV8ei3quj15N7e+bHfahXUZHD/9?=
 =?us-ascii?Q?Ri/qeVJ8uuPjqLXdA9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5148d5c4-5ee1-442a-4a38-08dba89cd5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:32:55.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJrE8/NmLqwokd4gXGbgzk5uW5tPhHGTHrKlgssIM34B/4lkMsUt2AE8FXFDayJ8+gK6kgUjaqPupll+ZN3CV/oUKV8Bz07xNaFi/9UFZjU=
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
> > ---
> > v1->v2:
> >  * Replaced EINVAL->ENODEV for invaild chip type.
> >  * Kept leading commas for adxl345_*_info and adxl375_*_info.
> >  * Restored switch statement in adxl345_core_probe()
>=20
> One more thing inline.
>=20
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
> Why not just
> 	if (!info)
> 		return -ENODEV;
>=20
> All of the structures have one of these two types anyway, so what is the
> point in checking the type field.

Agreed.

Cheers,
Biju

>=20
>=20
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


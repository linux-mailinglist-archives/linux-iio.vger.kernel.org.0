Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3927B75DDF3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGVRhv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVRhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 13:37:50 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC92211E;
        Sat, 22 Jul 2023 10:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxAuZIXEs/SEyUie5i5tlEk4kxR8uLor5Oip8nAwrE4b3+hAq3u7jOde/TVtHKctSwcTbvA8K1i2VAnZj7MHCKnNc1xDibibYNvGAOmiiGeq6pRxMfw8rDwbm5pVDlDpbN2jgFQsSvRRhxZgppjw9t3WiRkGa+X55FoQi0Dpoe277ha+CMpa+YTQMOqcv1L4V/iTTXevGBhp+JjSg6ZnFbWvY0g9Nsq2cPk+ogq+8qxaOVQh/VG1ZUKn4i1jcM1rxWZ5eT3wDupoEBzcDS1shRKf0yRunFooiSGYq2XyeOZl6SDYnYl5nuQY9SviRW3I8VV58mTqbNZvVoIPZIvlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9hHIZE8g5bSn7xJayxmoxaLkrifQ4DeQPAc8Ybn6NY=;
 b=TbyaG/v//IJYiD6so3VwrEWci+yQQcs1u8/+OpWjceVSy0SdI/ssY1r3I0zVZJuPfu6H64d3mvNKXS427p+u7m+BB55BEjT1DbvY+OHltYRPsOPPzxUh5cYZaeqEDGqThFBxMT3SBIc0H/lvqVi7iOT1U+cIECEp/MIXcTCsjafZcHdGuJt2Iz/A/6GEPngmVeO9nnpCsibcAb3545z+nqn/kqmr+BVce+/HKsCnEN/4Jcchd96zi9X+H702DYm0hnkDceR2ON2LHcyYbpLgWEFxdMzfu9N0ONcghuhLGh4thKlFG0uOtVgTL0ekNAGjiJue0nWe8HVnHOQ5/g+EuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9hHIZE8g5bSn7xJayxmoxaLkrifQ4DeQPAc8Ybn6NY=;
 b=u5kb3K+9vqA8tBAdThHa4dY30Ri9vcGTqe4j1IYKI/hQoN38xmd7OqDUUOVf0kmhxlea5NmUpoa1sF5P+hJquKGndVITPF1bYW4Aip3xb4Y8K1+6j/3s1+ca9J2VOxV+W97Jb3jSw6rdjKNUWb4gcLCM3TWhe4Pvu28aqqTRJpc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB6312.jpnprd01.prod.outlook.com (2603:1096:604:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 17:37:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 17:37:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
Thread-Topic: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
Thread-Index: AQHZuA5L+7aKPfiYh0K2IPOTf1RpNq/GAv8AgAATDeA=
Date:   Sat, 22 Jul 2023 17:37:46 +0000
Message-ID: <OS0PR01MB5922D90733BD82FF6D3F62CB863CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
        <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
 <20230722172832.04ad7738@jic23-huawei>
In-Reply-To: <20230722172832.04ad7738@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB6312:EE_
x-ms-office365-filtering-correlation-id: 22a524aa-fc87-41ec-2e6a-08db8ada5c84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l1kGaE9/TMQHrvJ7WpgLDiBX1ypeolQe1AQYZ0tXzE3VdGdo6hik3KFvES8ddDfmLi8Me/3xesHJm31pSZkerHn7Mrm17SlEoqhQmOiQJDH5VXHnwcoOdOVGEGol3HcDufHWP5OTBI2REuvlsiAhVuwWpKRdRmDpQuMj33WIDcru77fWc8FsrZK+oI7d7pwSv0Fbr9Cy5PR18Ukqu+xvggTGmX6O6meeb/0Xy62/0VdFxTQL/Uas0o3Vc5Ar5485xeSAVaYGEFyCCGWV7zYv+/K6hR2NzkU/jwFpYsnNV5hA3twTqLtRL61yrm/YA8S5v51plQedjtZpZwgFGzIC78ta8en5azLNn+yeDQ/K9jkzMfocEBr9LCnPa00cCn+Uqq/IpeaxB4CZH8oRIweRlUQFwfBJChlwvg9Auls7ZMAoH47s3Qy5c6QIPGisKHBNDggdfcW30cN9FvQegKhLQ7InJ3PUFzLhi9cKdrh164FbvIEHyX1uADaOGFws+K3xRENKficg+4fdSkabc09LuyqI4211wyj1sGVf8z9Ox+G+ZXGhuU20smMl8hDoJpix3jI/bvl7IJysDF6YzGP4DfMjvNzrN/Tlh7NgZ0qJn7VcfK+HeOcV5Aim9rLWplHE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(83380400001)(186003)(26005)(6506007)(53546011)(5660300002)(52536014)(86362001)(8936002)(8676002)(38070700005)(33656002)(71200400001)(478600001)(7696005)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U9+rNQiLi6Ca2XuttFaGVseriFhWOID44VdPgyX8aA7XVbJ5/FJpADAh6P3o?=
 =?us-ascii?Q?PNtQ3cFFzTXi2z8L6oxA0wwjl614KYaPjjFq49h9HEsVpzi24491Xzvif54M?=
 =?us-ascii?Q?04bsER9vR5jNlC7BC67WoFkgbf7mf7H3B1hsocMn44D3SBqI3k3CtpCsw9rd?=
 =?us-ascii?Q?v5HdPWXEZr63L3P5UMAQzp+PDkk8suP6XMP+N/Gm5QYn5NdvPOldcEvOzDIY?=
 =?us-ascii?Q?IL1WG1P6Ie7hHyncS3KF0FGQeOpf5X5WbVgI1zrZk5/LglQSyTPBwpvvaC5N?=
 =?us-ascii?Q?zvU1DYxE0OWdgctbHbVRPnHA5RryFBZWkTcHbzOt2J8hlV76flY+BUX0T+2v?=
 =?us-ascii?Q?l5kOG3HAzSbu3uqcquwkWqxw4YTxNi5CCBE7m3e7bylW23Bxbp9R1507s13+?=
 =?us-ascii?Q?cIipZHGQ983a9v5cJH8pfqL1C+vRJwXIAlO5sWht0qp4tJCLrxumi6dK5N0o?=
 =?us-ascii?Q?ja9RlxSPElNmBjznF1Oj0umjG0zywImMn8W5+S5gmqr6KVBADNYajSxQvDkz?=
 =?us-ascii?Q?ObeJbWqqn3+VCTucL48CvC9YdoNov8R5f9399EjMMI+kKbJWHrNAWqN0AFHQ?=
 =?us-ascii?Q?8tIXWxmU5nI+ij88FFv7T2a/FMucINGehedZ3LbjO9UDiTixwoCKBnKm3usQ?=
 =?us-ascii?Q?9nexxcI8Ll9xQgbzXTvOiMsGryFOK4nqBAQkivQcrF+DciUJVfr9zHurCBvc?=
 =?us-ascii?Q?qOpwHbH6SXyI38CYUxA1q9L7Bu4Us61XW1bR+WsSXzjzzYP6qXtKwdSh69ET?=
 =?us-ascii?Q?5X9SYO+k15u3KpRSHcNq0chajTnnuQd/nufNRbcOyablQnUkVXuklaxY8qIT?=
 =?us-ascii?Q?KkIsZs95MTrn0z1t+he4QE7WN9AKl4q6m2rS+cz/ZPPk6EcadqcvEQwu74Ce?=
 =?us-ascii?Q?KzSwkszCT0tLmDLenkdsp/Ek02R0PbqUyS8Ezf4CZ7/DNMufWMNmJY09lnV7?=
 =?us-ascii?Q?bOs5mo77hPAkjJpCAxo1Tpn2ARFZUZ5RwrLbp2To2A8JQWi/z6C+GdUuT3f1?=
 =?us-ascii?Q?Nqves0ymJUu9Run9F01E9yMwxJHyL0wFTc98ZC1LZHclCfYhlMa0S3ernn6X?=
 =?us-ascii?Q?R3pI3i28cwPQ26KSilVxVq9TrK0HgxKk9hSgdtj0ncppb5gq7FckWIqTrOPP?=
 =?us-ascii?Q?WGNZd23JpZKvh0UgBRUNC83GP0ww5F9t55ahPURHOCFAzJyNdbfYD2noOCr1?=
 =?us-ascii?Q?EWPPC4bxDXymhw05rIZsc3HgTS5eV035X8hGGeINg0YGpf9yYdd8dFMoFmQM?=
 =?us-ascii?Q?f5AyA3y/ZlKoJG9xt4560xghBb/djMSNxy7vufEWhtA4E/4uWRR5h/XeM/nR?=
 =?us-ascii?Q?sbHxkmq0vzjtVhLh+g5v0c2ccYO/ejSYx8EKOU212Shh9X1FrwitdTVQtP/5?=
 =?us-ascii?Q?wjcl2V8agNiRX0xrdrpHl95vDkexmLpE7B5J28caNZNs6VOYSr0NXG1jx5WA?=
 =?us-ascii?Q?rlAcxntFIukDX2VxUvbBU1agm6QAVT716o18K7ctYZQsVa3sJksD41SBEZma?=
 =?us-ascii?Q?2YBzsSCg/tr9DLn/6WjxAaUbzFX7LRZq2LVQLKRMWNpVcH2fK/MwpYN5GVUQ?=
 =?us-ascii?Q?y2ONwKUVy0pjfcj986djcg6GZ3h3khpKStnAOeUg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a524aa-fc87-41ec-2e6a-08db8ada5c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 17:37:46.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sV6iOB3KT+UOQJCl5fmIBSlj/9veWF3S/Sc70qtsHlxJ4XIi8pwtSCEQ6IwqwAzHdvaVOAZ/wqLIW1w1ioHJV8Y3WRtFyXPXoJ7q0Odd/wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6312
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan Cameron,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 22, 2023 5:29 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> <Michael.Hennerich@analog.com>; Lucas Stankus
> <lucas.p.stankus@gmail.com>; linux-iio@vger.kernel.org; Geert
> Uytterhoeven <geert+renesas@glider.be>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-
> soc@vger.kernel.org
> Subject: Re: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
>=20
> On Sun, 16 Jul 2023 18:52:16 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> > _data() as we have similar I2C and DT-based matching table.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/iio/accel/adxl313_i2c.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl313_i2c.c
> > b/drivers/iio/accel/adxl313_i2c.c index 524327ea3663..6d252190207b
> > 100644
> > --- a/drivers/iio/accel/adxl313_i2c.c
> > +++ b/drivers/iio/accel/adxl313_i2c.c
> > @@ -65,9 +65,9 @@ static int adxl313_i2c_probe(struct i2c_client
> *client)
> >  	 * Retrieves device specific data as a pointer to a
> >  	 * adxl313_chip_info structure
> >  	 */
> > -	chip_data =3D device_get_match_data(&client->dev);
> > +	chip_data =3D i2c_get_match_data(client);
> >  	if (!chip_data)
> > -		chip_data =3D (const struct adxl313_chip_info
> *)i2c_match_id(adxl313_i2c_id, client)->driver_data;
> > +		return -ENODEV;
> >
> >  	regmap =3D devm_regmap_init_i2c(client,
> >  				      &adxl31x_i2c_regmap_config[chip_data-
> >type]);
>=20
> This driver looks buggy:
>=20
> static const struct i2c_device_id adxl313_i2c_id[] =3D {
> 	{ .name =3D "adxl312", .driver_data =3D
> (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
> 	{ .name =3D "adxl313", .driver_data =3D
> (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
> 	{ .name =3D "adxl314", .driver_data =3D
> (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
> 	{ }
> };
>=20
> MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
>=20
> static const struct of_device_id adxl313_of_match[] =3D {
> 	{ .compatible =3D "adi,adxl312", .data =3D &adxl31x_chip_info[ADXL312]
> },
> 	{ .compatible =3D "adi,adxl313", .data =3D &adxl31x_chip_info[ADXL313]
> },
> 	{ .compatible =3D "adi,adxl314", .data =3D &adxl31x_chip_info[ADXL314]
> },
> 	{ }
> };
>=20
> Odd that the i2c_device_id table always uses ADXL312
>=20
> That would only have previously applied if we failed to match on the of
> one (which only happens in somewhat obscure cases)
>=20
> Can we fix that first then apply this cleanup on top?

Sure. Will send V2.

Cheers,
Biju

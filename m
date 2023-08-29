Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117E78C7A9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjH2Of2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbjH2OfK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 10:35:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8E113
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 07:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3LyEFpc3G3pZQeicIM7FisdVs9hR3RjEADxvZ9YOKDestfDKCy99RFraBEc7E79SRNchttzzTIiEDtGvYdCOLbDd4gjvRlZQvqgYMfc4Sg8I1je1UplryidFblk9xDmnrQiUTw7WEtFLH6rFmMaoqcAl/QnTQRqUb5tP38YHIhipanjPQh7OXd5/fXua9RWWKYmKmA0g+ehN861HFHS6VxJYaMHVaK8bfQW/FLk0O1nxOLgI8BUuQqEKT42/osNSFmLJxKgjGnvVsJn/OV/BAMwQZHshv6Hfa7zveSaVF13fcEA59GMUZjJvVVOMWiZxJB7UGSrTHhnZzRJU+xacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAP+vf4/mSfVI0vtelv/fLhRJJtbdE20EXlGsicVhiw=;
 b=IhymzhbaILKh36RkoK7ZNI0imM+aLswzAmL5DeK6nqKxrWP9NKwf/g/5L7uJXYSYdMcfu/B4cXfQm6016LP0zZkmxXctvOBr8OfbOuVDJO5oNyVq52+o5PLF3T0UEwW9sM9NWslWR3jdoZ4Vs4Q+3wZhlDIhOJN5IcMtptBOHLR4l7rkbx2DP1Yrh1V4mgAkN1KoG6C1B/o9RUzhkb1OlMu5qkRA08+yMVhOL6TOZa53OmXkyGlrKa51ILkDWbh8T5ePssTQ4eWeqqypl9AjlqxdtcLgfNtCxUQBR1+51PgCkEc7kh8BvD6DaqrI7QDbW1Z/AbIF3kJypPzBsyWSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAP+vf4/mSfVI0vtelv/fLhRJJtbdE20EXlGsicVhiw=;
 b=fIzb1D2cwgezGQBOibWrncVPosQweNR6U04Qpkb1LmV5jmdX3+l/PxJcC4qrqS1JT8goI1MgxEKQLwc9xExSYdFw21H7231cBkAY+8yT6VAMKko213EtXkDrmeeaxtEOUzme9Pdkm2jSGLvruNChHs32wHrYJmYGrqCeMegKDE4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9875.jpnprd01.prod.outlook.com (2603:1096:400:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 14:35:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:35:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: dac: mcp4725: Use i2c_get_match_data()
Thread-Topic: [PATCH v2 2/2] iio: dac: mcp4725: Use i2c_get_match_data()
Thread-Index: AQHZ0fxQPqp/Gyp8q0qiFsmn7366aq//txGAgAGwjMA=
Date:   Tue, 29 Aug 2023 14:35:00 +0000
Message-ID: <OS0PR01MB592268F183477E30CC5E04D386E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818174905.324623-1-biju.das.jz@bp.renesas.com>
        <20230818174905.324623-3-biju.das.jz@bp.renesas.com>
 <20230828134527.412c18cf@jic23-huawei>
In-Reply-To: <20230828134527.412c18cf@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9875:EE_
x-ms-office365-filtering-correlation-id: d5ce7dbd-4bbb-44b2-c1ae-08dba89d2007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpG/vOufIC7ecKQ3oLukxi41h0coGp4Nq9DzjREqvmpYJ5xRrU8hgWR/olrUQpxzpWjmRBP30k7GnaevS9/LsLHRU3o2mZsmbitg7014yce7G3xRU/sN8JHSRSuJg+NSjzpNaHE3EIl6MHSpY47zDdR1Ewleyx42QHJJc6E2xki+q+uoZYC52BXnIsxy1Prq+h8fWrsMe+TAWQRC6l2T1a4CtrTYkeiBFKPe54yNyTHQTgqTnfEEJFaCztta/nIVlOD1GlYRKES4Dp6duQbI2eK3bs1yDFrz2MCyHLGN5OaqJKA83GGWFLhZUvFzeaMFEbBXGqWU17yDlMTZmcK9G0InW8UhCnkBBOVLpJSYDtdfGaUUbrtimKnmbZob+5PsU0IS/W1SM9T9by47X0zcohH2+Q5syoDR7VDxsCH+pr8ZvCzrkh7vc4Yh6xYrNCrzkyxBtTDe/savuTQRDNSIPiiKiMrdxQe2iA2sUcS8srVbFUUz2I6oZ2PzXilzyyEigLlY+q+px42VJscmum6uHS8wuzE4B1eHyEjFucKiU6Szf/gAl2pJh0UANCGoZK23+zK36YlVwmNxsW9+fj18PIMF2lSl9yOzyHELI4h5jOpLKIlR42n+/jhgHV91kguG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(54906003)(76116006)(33656002)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(316002)(6916009)(55016003)(41300700001)(8936002)(4326008)(8676002)(52536014)(71200400001)(6506007)(7696005)(9686003)(38100700002)(38070700005)(122000001)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KNR6JmlQnMt3Un+BduoEw4hSlLTDqfyX0EOKm1xRs7UneQZyNEX4YyZzSO?=
 =?iso-8859-1?Q?poAszl47/OAmHDDIV4SEvK07KKl+gYWbnNlzsCJ4cizMayn6NWcDhGyS1n?=
 =?iso-8859-1?Q?Z76IWCfR74DQhTtgnIsX+IMReiqm8Ox2cMwoRehV1scN1jgVZEkHjPjpun?=
 =?iso-8859-1?Q?PAvSyX7crQrSj2Ry3g01mm+DlM4u0vpKaJQYNGiyrUxgwe1qFj14BEJQph?=
 =?iso-8859-1?Q?HmkReZvHKOfRavUKz5XYVj4nmj/V2A6WY1Shml+9QL6nAia8NQz1IGgJi8?=
 =?iso-8859-1?Q?do7hzZELbmzEiG7j57xbqHNe+tpfEM4pOF8xtJmXdIHz9Z9d/Il+btw8kX?=
 =?iso-8859-1?Q?tOH1PqCIiSJQwoqtWYb8LodrHx6FF4qNxE24gC9kml31v75q8tXJCnArgB?=
 =?iso-8859-1?Q?BShhcz+jgWNQOCu0xcvEX3Ms8QD8ofbRNmkf1Kvr6nu3kU0YoGR/B1gDm6?=
 =?iso-8859-1?Q?VPWonDU9ekItBS4rotV395F21x66FXx/SwGmR0YH8+XvE2gwtK4IMQCcR/?=
 =?iso-8859-1?Q?aBjwrK7ieWEgzvnh3B3tyXHrTnoumAyXvRvBHx8/uWkOHe3SWn1lS4AcJp?=
 =?iso-8859-1?Q?2iI8Rt+ZQKCkniLIm3ofo3n+BInAAi9bzlyhu/ifqewPAoSW8gKmfrIYDt?=
 =?iso-8859-1?Q?vtl1Istx8Wd3EsIB+18EpSFiDSGg6OLhWbjcGs2fAOf2Sl2osKDv/zefgl?=
 =?iso-8859-1?Q?WjGW1bPNJkT6UbZuoPMy6Teb30AbaqM/lxkaA1pFfE+60QKMhp6cEms4/j?=
 =?iso-8859-1?Q?c+O4iW+JHNN4R3/sNRwC2vBg+MXn6T6R7JtR8jHxZGR+Ehi3Wkuq5pwIbd?=
 =?iso-8859-1?Q?4wPgzAumdbca7FGKCljJ0rTDRzd/jNjBwxovX2m+ObAAam5shoqJn+Xcke?=
 =?iso-8859-1?Q?cTACQ7g5PzMD/mgppOavE8C3fNlRmQ+DjByEMXzkay0YvVSWklzxTWvHK+?=
 =?iso-8859-1?Q?6+nsSJS6jlale9LHHpdtLxXaPDM/LzLDV9PaxD2Nzb9mMO1j4zm7qdIDYX?=
 =?iso-8859-1?Q?wMf5mBDCUtGxKA5TikJBe+SrSlWjSL9U7AdcEg/ymFKaXobfuhzuTzpm29?=
 =?iso-8859-1?Q?xBxy89/ret4r8AzN33Mw1SFICeWMZNQTPNBZieX/Kk00vnNOmNi6KgNCvh?=
 =?iso-8859-1?Q?W2eaB2elSkPtwAK5zanoR46jAOE6TuO+cmjvoib8Uya5YRId2R0HYSw5vN?=
 =?iso-8859-1?Q?nBQFF1/01sZC7BU+Uks0V0A7HwcBuufpaSd6wMcE3s8eTOG/4kge5T7v5R?=
 =?iso-8859-1?Q?XJIUk35vDq7OgwMxLUlJCjWskQhl9Rx/tZfH0H8PuETYTztwqwUV7RCs0U?=
 =?iso-8859-1?Q?CHLd/o6jAa1LyQ/8RZ9bHbgzMrSIMEuNoBpKo0DXHiS+/1d+nvKV0sQx4f?=
 =?iso-8859-1?Q?WooLCVvKP1Vl0p2cP92o0LDUIAcwWm8JtgZaiAkWUX9DvQDNDnEKtQ+nqG?=
 =?iso-8859-1?Q?1mk3DBSDNuyv0tzkbqxcaiv/UbV7YDH5xWZAJWexrz7kOQjOWkNWUtZtnJ?=
 =?iso-8859-1?Q?X8qIb2HXN7w+QW2hzDVNkVytTuXjV6yfntiKyDSWjv4YYqmHMhbbmy1DfU?=
 =?iso-8859-1?Q?RSoWfGoOPanXzM9eyTRXwMKMeHaCVM3CuPcmDRBPMOUJEBdUWRIBFgmCsN?=
 =?iso-8859-1?Q?m3/3ZDFSxcPKo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ce7dbd-4bbb-44b2-c1ae-08dba89d2007
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:35:00.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Re8zyao46+AP4o/VolurwxPT0YNpHVUHZ1WxMReW6fQygVUKzRneEzCSjgfFJQ9p7P06fTH4fnFUt11u7dpbZ8O4Umkyhzb5tZGY7tulFG0=
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

> Subject: Re: [PATCH v2 2/2] iio: dac: mcp4725: Use i2c_get_match_data()
>=20
> On Fri, 18 Aug 2023 18:49:05 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Replace local variable chip_id with struct iio_chan_spec for device
> > data and use its .ext_info for chip identification. After this replace
> > device_get_match_data() and id lookup for retrieving match data by
> > i2c_get_match_data() by converting enum->pointer for data in the match
> > table.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The use of ext_info on a channel is messy.  Please just define a clearly
> named flag in chip_info to make it simpler to maintain and extend.
OK

> Jonathan
>=20
> > ---
> > v1->v2:
> >  * No change.
> > ---
> >  drivers/iio/dac/mcp4725.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> > index 33a61f65bc25..f9ce01c4cc53 100644
> > --- a/drivers/iio/dac/mcp4725.c
> > +++ b/drivers/iio/dac/mcp4725.c
> > @@ -386,7 +386,7 @@ static int mcp4725_probe(struct i2c_client *client)
> >  	struct mcp4725_data *data;
> >  	struct iio_dev *indio_dev;
> >  	struct mcp4725_platform_data *pdata, pdata_dt;
> > -	int chip_id;
> > +	const struct iio_chan_spec *ch;
> >  	u8 inbuf[4];
> >  	u8 pd;
> >  	u8 ref;
> > @@ -398,10 +398,8 @@ static int mcp4725_probe(struct i2c_client *client=
)
> >  	data =3D iio_priv(indio_dev);
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client =3D client;
> > -	if (dev_fwnode(&client->dev))
> > -		chip_id =3D (uintptr_t)device_get_match_data(&client->dev);
> > -	else
> > -		chip_id =3D id->driver_data;
> > +	ch =3D i2c_get_match_data(client);
> > +
> >  	pdata =3D dev_get_platdata(&client->dev);
> >
> >  	if (!pdata) {
> > @@ -414,7 +412,7 @@ static int mcp4725_probe(struct i2c_client *client)
> >  		pdata =3D &pdata_dt;
> >  	}
> >
> > -	if (chip_id =3D=3D MCP4725 && pdata->use_vref) {
> > +	if (ch->ext_info =3D=3D mcp4725_ext_info && pdata->use_vref) {
>=20
> I think this will end up being hard to maintain.
>=20
> Please define a mcp4725_chip_info structure and put the channels in there
> + a flag that says if the device in question supports an external
> reference.

Agreed.

>=20
> >  		dev_err(&client->dev,
> >  			"external reference is unavailable on MCP4725");
> >  		return -EINVAL;
> > @@ -455,12 +453,12 @@ static int mcp4725_probe(struct i2c_client
> > *client)
> >
> >  	indio_dev->name =3D id->name;
> >  	indio_dev->info =3D &mcp4725_info;
> > -	indio_dev->channels =3D &mcp472x_channel[chip_id];
> > +	indio_dev->channels =3D ch;
> >  	indio_dev->num_channels =3D 1;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >
> >  	/* read current DAC value and settings */
> > -	err =3D i2c_master_recv(client, inbuf, chip_id =3D=3D MCP4725 ? 3 : 4=
);
> > +	err =3D i2c_master_recv(client, inbuf, ch->ext_info =3D=3D
> > +mcp4725_ext_info ? 3 : 4);
> >
> >  	if (err < 0) {
> >  		dev_err(&client->dev, "failed to read DAC value"); @@ -470,10
> > +468,10 @@ static int mcp4725_probe(struct i2c_client *client)
> >  	data->powerdown =3D pd > 0;
> >  	data->powerdown_mode =3D pd ? pd - 1 : 2; /* largest resistor to gnd =
*/
> >  	data->dac_value =3D (inbuf[1] << 4) | (inbuf[2] >> 4);
> > -	if (chip_id =3D=3D MCP4726)
> > +	if (ch->ext_info =3D=3D mcp4726_ext_info)
> >  		ref =3D (inbuf[3] >> 3) & 0x3;
>=20
> Add a flag to the chip_info structure for whatever we are controlling her=
e
> and then have if (info->x_is_supported)

OK.

> 	...
>=20
>=20
> >
> > -	if (chip_id =3D=3D MCP4726 && ref !=3D data->ref_mode) {
> > +	if (ch->ext_info =3D=3D mcp4726_ext_info && ref !=3D data->ref_mode) =
{
>=20
> I think this can also use the vref bool I suggest adding above.

OK.

Cheers,
Biju
>=20
> >  		dev_info(&client->dev,
> >  			"voltage reference mode differs (conf: %u, eeprom: %u),
> setting %u",
> >  			data->ref_mode, ref, data->ref_mode); @@ -511,8 +509,8
> @@ static
> > void mcp4725_remove(struct i2c_client *client)  }
> >
> >  static const struct i2c_device_id mcp4725_id[] =3D {
> > -	{ "mcp4725", MCP4725 },
> > -	{ "mcp4726", MCP4726 },
> > +	{ "mcp4725", (kernel_ulong_t)&mcp472x_channel[MCP4725] },
> > +	{ "mcp4726", (kernel_ulong_t)&mcp472x_channel[MCP4726] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, mcp4725_id); @@ -520,11 +518,11 @@
> > MODULE_DEVICE_TABLE(i2c, mcp4725_id);  static const struct
> > of_device_id mcp4725_of_match[] =3D {
> >  	{
> >  		.compatible =3D "microchip,mcp4725",
> > -		.data =3D (void *)MCP4725
> > +		.data =3D &mcp472x_channel[MCP4725]
> >  	},
> >  	{
> >  		.compatible =3D "microchip,mcp4726",
> > -		.data =3D (void *)MCP4726
> > +		.data =3D &mcp472x_channel[MCP4726]
> >  	},
> >  	{ }
> >  };


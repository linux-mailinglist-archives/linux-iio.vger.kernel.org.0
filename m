Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A275B802
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGTTbs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGTTbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 15:31:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEC1996;
        Thu, 20 Jul 2023 12:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJPQpI3FxdIOxZz2NZmnp5HmBQqRAiP7zgW0Nc9QLfCMvPRyWzZ+mqgbdT1MlsOksjw58Eam1vJI4NKTQ920NkmyUDmVhcpyFsBNPZxfpyjPWjmvQE9lZG4tQ2qTBaXqJSk6JMtsEv55WleDoQg9hDnnUlJ/9NyMU1vZ0SBm2xR11+CpdX+ubNIefjPZ6pTq0FIgHaSQtsZbLMxFUWzHJA7OPM8RYAMGJDnbxcscNBhq44NL0zIJ/gbZDKdDgzHSGNxL0RTq9jKwHTScqtucl7CeG+JE4e0oo9VwCq2dlpqJRduf5uHFzldv33ko/uSe8+LsPEFAjNiRBOV4JP3RKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7XQXZ1uxtccPanSEc2WgTi98ULSqNYoGE3Lgce+J7Y=;
 b=adzUzKra9hxoDmbjHyl4dU3ZOESbysrgCAh0Gy2xEcyu7YeZSEy9R69eU7hM18JBjubxJfeb7fDxGDVyIODomiywJuRjR5JRFoFvhHYixn3IED0f5bCdMfqTDU0X2HVRZ0RjJPnwY2NRfuN2hWjR9Oj7o/6CzOEuQTPm8HOAUH4o2CrccqXXmFw/BklvT5+q4YPBtVHR8E7Iv7elexK2DxUs7N6/ifIwu8IW8BeZ0tijoRqfv+o3FSQzJlieMqmFyouaF2MtH4osSVuRYh7iPmP/sQeVyTgkarNPF8XNwQd12YmVr9NobJMtB1QF74hhpDOTa6rMldhZOviMzkLW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7XQXZ1uxtccPanSEc2WgTi98ULSqNYoGE3Lgce+J7Y=;
 b=GC6u++EPF3mx7OFmWOBXyav9zMLvTf9SsWKfZWHeDsL0RKmoLUQjr/ZfE1lxhN8V3tpr0EoE7W+LhQma0taV12PUTDockkeCLHD20Tu90mY3TAnei7NiYBFI9CYh6HyexiQjp24iGuiIJFIOD13KFvALp6zF/1zpAD4RLB9Gynk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6127.jpnprd01.prod.outlook.com (2603:1096:400:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 19:31:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 19:31:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Thread-Topic: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Thread-Index: AQHZuA5O9QJBmy9w80alptB0AHKjnK+8sVBAgAZcGICAAANQwA==
Date:   Thu, 20 Jul 2023 19:31:40 +0000
Message-ID: <OS0PR01MB59228CB21C072759D3CB7055863EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
        <20230716175218.130557-5-biju.das.jz@bp.renesas.com>
        <OS0PR01MB592223598B7DECC648947436863AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230720201701.0fb3a948@jic23-huawei>
In-Reply-To: <20230720201701.0fb3a948@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6127:EE_
x-ms-office365-filtering-correlation-id: 93e481b9-0982-48b8-5f8e-08db8957f136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30FGXs+CXIcRsZeQBXpFD6ClM7ze3ZxI74vvTVc+vIrkev+Nj8mxtuR5egzpZ5dY/eeLB/RsRvg1t1kvavWVy09AT3+r5EfeonNCRBkpQMZObXQsLBGUmU+BqA9jmkmtofV37wBau06bBj7PtRPIdfBNvI0k2ED/corPOIAHR95bMyiHFP7XGnozopEeeT3oqXoCy+z7rRQzkeNeaaE700quXp++9V2NZOOSVPJXjOC0BLnwRVR1jpB+aHZOrqzv++V7GC9sw7Ha6Xk+3EiLz5wTeXPdsfSg1XVcfbV275Sy7vBY018vWB0pHyf5bYOb0FB4e5POYAj3FZSFv7eefVUauyAE72fcGXScLQyLqvyhKKsjW79gQD1Lc8tXhXYL1IDmJHsgilM8UXYcUd83lq82EZcblHvvxyY12wJCoLn4BPGDmSYuG3fqSEgf8hU1iWLj+g03Yf/LecEje4lkpnQcgZSk84X11Wck++9UFgVWL4Msa799CVxYix/02aiB5+bZC8XWcO02F7vUQwukVW/0AKIzZU/TVB1t9DmVebFkonRQbCPZ7XUH6oxbBu99zV2EQKKdLC7nvtaVOWBksy6XiQZ1xC3tTm8cpN84d4Hn3KmSijDHjohKvA/zKH4a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(7696005)(9686003)(54906003)(478600001)(71200400001)(53546011)(26005)(186003)(6506007)(2906002)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(316002)(66946007)(76116006)(52536014)(8936002)(8676002)(5660300002)(41300700001)(122000001)(38100700002)(33656002)(38070700005)(86362001)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8SwU2CmMg2R35kIw4RPG5D41VBhcdjVOjVthYl5rLojImGdSTkqwI6oH83A?=
 =?us-ascii?Q?MkuXymORLWXqLy8iIuokbuCMWv7IcgTEMnWeHT/08uGDcmqULi7xWhm/3E1j?=
 =?us-ascii?Q?D6aj1xvLzqZLJL8hiXjBuft4xFODJW8Z3lZhv+0Rkd7t/QkzjhBkO7D9jrSZ?=
 =?us-ascii?Q?5jcOsVZ3CnrhXZxR0NErqIW7fO34sI6sknuTz9PftsSk3sg3oe/6D2XuZ242?=
 =?us-ascii?Q?4JBd+P/4/vA6tZby83llRRvoRDwXVk6rsb/XcOgdOHQrqiBaMCuHfWF+z6RT?=
 =?us-ascii?Q?p1yQQhxNs0fuWt6qU1WPrQERjB3Haz9LHJgZEVMWTNNqEtJoMC0l249gnAW5?=
 =?us-ascii?Q?CCRi5s1BlGu3Jrah8E2s/qfyX4jyN7gA5CH6G+3IWCKBi1mXlPWPG/6Bm73Y?=
 =?us-ascii?Q?vcV1hco4L6cY33IO58YSVn2AC6llWzURd1xkgDuLkEMEyiVHGli3Os7Xh0cP?=
 =?us-ascii?Q?sDaikzPSmYyUuIyIo78BrguQXDKm9dKhw6nPEmxsCK+RTJk9JYvqA5FrKU2S?=
 =?us-ascii?Q?8cFSGW2n2TXEA65hzdhODcjhbzCJ8XSiA1u1mK0rDEZ2i+R6x4me8BDoqMvO?=
 =?us-ascii?Q?GXKHGznlR/N0H7MYSvjLKrzD0ZMZHtyZp8OMcvXMhEo2xoM1HWRuAI1rnpf3?=
 =?us-ascii?Q?kie9+t6aFHkOv9A4wEKcUJ65m6ydE+RBSvXC5VqGDVKWhn3MQBGXPckqXYOy?=
 =?us-ascii?Q?oIqgFVBI6D6uIcLrfuMKHDkWsXcVLiRYrRuEGJsqL8+w9yKlg3/tpFpRcUGJ?=
 =?us-ascii?Q?Z+1KtrUW/wkmkCC+LQRH4zVupVkZBKriMq0o7Ae6zyYx3tQMztMpnXDb8PQ2?=
 =?us-ascii?Q?zvLqn6Hu2YU/XX2AIUwyxgO8VQO5VJWG2XKYMPSeAQHFkhuUicSWC65Hz8Nn?=
 =?us-ascii?Q?0bFeejc156Btzl3WIFmAEc8eB+0Jv2r4HJLA2itEsIF4Ag/n75q/3KOOfFbZ?=
 =?us-ascii?Q?6xqXGkzy9BtohUn9dCAtcBppgeKtieZOAqfgsBsBxLWLKjaQ17aPqbqyb4id?=
 =?us-ascii?Q?2PyqmbiUlVFcr89UY4zlxF3kavOhT4JVteuNWt1TMfSLkIWkzsSOTsJ6VhTG?=
 =?us-ascii?Q?Xg71hTZkFen2gegDr/9IsSwClPhMSl1vr8LEQA+AauJQo7p0x0j9BH//uyy7?=
 =?us-ascii?Q?G0mjXr2y300CON4Vkb5Wva0mlL60YVkHu4svxeCPSUNZ8/KS5bF35/X2sdbh?=
 =?us-ascii?Q?pX2YobDUgAZ7nXQR3TEDMReoQQmcZXBwEJAgKTr4gygdQwFkcq4WGueebExt?=
 =?us-ascii?Q?NfzXF3GuJ1C7i3/ctIiBi/H+bPGeGbSCB514wJ9exIiTttmd1B1DGPNONRGd?=
 =?us-ascii?Q?1cAnFq57NMpqBTYiEEyq35gwASl/HbDnPDkBtUIRmT4KOKz/0ysetzdjt/Pi?=
 =?us-ascii?Q?LYtFde7ZzCD1QBjVrnWgY+FOAxOcLgC/PR2SODZFxxbX5bttSYpZmM0q4mbD?=
 =?us-ascii?Q?V2IA82uRvFw/aWQnCUyHEqvMeN5ERrDKrstmF3KSw6unycVeo4ycPDWFQumf?=
 =?us-ascii?Q?deiz0CCuSPikkivIN21/WuNO46+DA0BMOxfXKhqBRdgbamPK+z4KyUFUJ5Iq?=
 =?us-ascii?Q?WBbe+QdHpZyN0mrbbbkwopo1rJsDVzzcb89hzdDDMcadRJNzceFs9gu75eu1?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e481b9-0982-48b8-5f8e-08db8957f136
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 19:31:40.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToK6ObnrD0ESj9Lf1fikkrsXTVz87cEPfTzh0SFLJtb6R6A9bFllW5aHnOa1VZl4zY+hJCb9hJ4YjPFPEd/6MgxaaxT1MISwauzcEmO3jbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan Cameron,

Thanks for the feedback.

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, July 20, 2023 8:17 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Peter Rosin <peda@axentia.se>; Lars-Peter Clausen <lars@metafoo.de>;
> linux-iio@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-
> renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 4/4] iio: potentiometer: mcp4018: Use
> i2c_get_match_data
>=20
> On Sun, 16 Jul 2023 18:10:13 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi All,
> >
> > I would like to drop this patch, as this driver does not have similar
> > I2C and DT-based matching table.
>=20
> Could make it so they do ;)

OK, will create separate patch for similar I2C and DT-based matching table
and will send V2 for this driver.

Cheers,
Biju

>=20
> >
> > Cheers,
> > Biju
> >
> > > -----Original Message-----
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > Sent: Sunday, July 16, 2023 6:52 PM
> > > To: Peter Rosin <peda@axentia.se>; Jonathan Cameron
> > > <jic23@kernel.org>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>; linux-iio@vger.kernel.org; Geert Uytterhoeven
> > > <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> > > Subject: [PATCH 4/4] iio: potentiometer: mcp4018: Use
> > > i2c_get_match_data
> > >
> > > Replace of_device_get_match_data() and i2c_match_id() by
> > > i2c_get_match
> > > _data() as we have similar I2C and DT-based matching table.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  drivers/iio/potentiometer/mcp4018.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/potentiometer/mcp4018.c
> > > b/drivers/iio/potentiometer/mcp4018.c
> > > index 89daecc90305..a5d902845a1c 100644
> > > --- a/drivers/iio/potentiometer/mcp4018.c
> > > +++ b/drivers/iio/potentiometer/mcp4018.c
> > > @@ -157,9 +157,9 @@ static int mcp4018_probe(struct i2c_client
> *client)
> > >  	i2c_set_clientdata(client, indio_dev);
> > >  	data->client =3D client;
> > >
> > > -	data->cfg =3D device_get_match_data(dev);
> > > +	data->cfg =3D i2c_get_match_data(dev);
> > >  	if (!data->cfg)
> > > -		data->cfg =3D &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-
> > > >driver_data];
> > > +		return -ENODEV;
> > >
> > >  	indio_dev->info =3D &mcp4018_info;
> > >  	indio_dev->channels =3D &mcp4018_channel;
> > > --
> > > 2.25.1
> >


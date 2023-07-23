Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88675E174
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGWKlf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGWKlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 06:41:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F5171E;
        Sun, 23 Jul 2023 03:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0pmAzm6Wfzw8GZh92Z3KxJWqOozSiJsyzHRaCB4a0+VGe7uXhrMKhcdXtTDSNCt7Qttilzhv9EvDviTM4ensmxlKiNI9nqUceXzSe/Ix+ftK580IkWG4gTNuHvu+/GLJ0oH/ubsHLCCDMSrTstbfhrDYUFchxn6ud+4pULfy+mNSBOZCq35Pt2H/TBQMboXYyHYEZDW/ZpnNgx06od51iTTqbIcbeqIgm6qb7peMy91eRJMrwpJYYkT1/iCs7xntNfEx5fQxAyghG1zvsi2ZOUgSdv73s7ew4uDa0yEIUC5R76DNHzkcar5wcPpEHd4ppC+IlnIJ/ZJ0X2s78Urlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfvMlnMCkdBQiCplPG/+tXBMoZImntTlannlstFdatE=;
 b=HZaPxKVJhsRWI4fp7YC6Q4klN5oZYsz/2F4Tr6YhULJPeVtalP4LzRFzkMTwmHMaRVx+PhF3J8TOTQohQBl6R6WiHK3VWzl9GT0bzLOcplzHe0Z/qdPeG86VPkANzDKOGdZ7LW6k3qOzkCKnyBrxLhfsvjswJDmjPKS9FqnO16zN8PdUnuFSyRtobS808PVChBpLSq1RWVineKvr+EO0L1EkCE/85SZUnBmFbgn0jmmVfav38MSR71k9KeKatWacDshKicn9WjseVMJts6fLHEAUqUrL6vXIFJ9vnPVAVYylRwx0DN7dweX+Iq7gBy1eWdC6S7R7N0Kw0F9UW+Wxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfvMlnMCkdBQiCplPG/+tXBMoZImntTlannlstFdatE=;
 b=kbYoPJdct9yrBv6yQ4Q8RmGyMJugU5kpiwG1pwRuftw/Pfc4z8Xikv3RcPnyQ2IkQ12sRzdFWK8F0+Euia3tqqRVoa2HHco0tG2oRzRBEV3iN6Ms2t86FTewCPu7JpbxDZ6hCaDg8tVtRlepToF5lI6z82XrLAY5yVwbdGHRyoI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYTPR01MB11044.jpnprd01.prod.outlook.com (2603:1096:400:3a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 10:41:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 10:41:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Thread-Topic: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Thread-Index: AQHZu6M6IkY4v2bEb06FbMft+4E5nK/GUriAgACNW+CAAEurAIAAAKOw
Date:   Sun, 23 Jul 2023 10:41:23 +0000
Message-ID: <OS0PR01MB5922AB78FE88840E00885329863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
 <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
 <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <cf71c4ab-58c4-fef8-2ce3-5ca32f9f2f91@axentia.se>
In-Reply-To: <cf71c4ab-58c4-fef8-2ce3-5ca32f9f2f91@axentia.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYTPR01MB11044:EE_
x-ms-office365-filtering-correlation-id: 3aea0c01-ab2f-414d-b02c-08db8b695c2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2etKMlEdPw4VgeYEGL2b1luAVDIfd+GtRab5ubavgwk9BndNa+lP5EJzsNSOaq2oI6UZ+oY2QpC7hkIyhZgAvvWyFkD+4VM667NqKxaQV0v93/y6FvcXbQpw+UIjn9C5aEAanvW+xXOwau3uCCxEb5k/HibxYqboYa6wxvSwZVJF92rdQ7OGvI1+MmEW6/3iODWbAGDvnht95ShlTJxN00zeOQBMemq+YxsaM11GrX1ibUexxF2s6ixN27+D3p5UTQv6VLaQH+lPUfPd+Uyj6Lj/6tDw5GE/8vHxBjoATzjoxm4iIGwCKfLW5tbmFI80UV4FVJR3RR2GjpFSS1zvRqe1EHq+lAZ/oy7vl+s9a00y6VaIHnfuoxp3mVLUUwzK/f4dFKO4t7UkbU48JJLE9cM8lLrFQdGW9+hGNh2CXHZ1xWyQhQ9kn9TTDB6gn1SjX/4/GBYFB2YFBQspeIxRFZqOAdEb84ik6hs0oApJfmTmwIAdpHuZqVZMWJG385dK89jtOmjdPYQA3GEGjWhCI51BZAMtmLlqtMutRZqgXyFOw+WwVBoK7VufBKqmvt1lAf0kY8erusWESoaf2FWSxkCev11BshE6m8Ljk6AQdq/DfMdGhCkcR66PJwFuY4Pd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(966005)(7696005)(9686003)(71200400001)(45080400002)(54906003)(110136005)(478600001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(186003)(26005)(6506007)(122000001)(38100700002)(66476007)(66446008)(64756008)(66556008)(4326008)(76116006)(41300700001)(8676002)(8936002)(66946007)(316002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QdsWX1G8ObcnbTJgkJwbgNTpIg00FimbUwT1Nn6tGB4WFN5rKiTbv9HSKCT4?=
 =?us-ascii?Q?eWfYVdKzE15TXpw0doQyHPLPiK0pm8Pz2Wz25RPr28fGwowH5qUNy9WNiyh+?=
 =?us-ascii?Q?vxHqexaJG3A2hOZ7WFf4OehgLr4482Mg8Fm1ZIfa0YPtq+KSVFA9OuH0H7Qf?=
 =?us-ascii?Q?M3SRmVmsosmks2Njc8afjPCWl6B5QkccF/pTY9AuAlLR4o3NkAhj9dLENZ3D?=
 =?us-ascii?Q?KWsfHxANstCWFMK2blUTnn5LlkUrSQ9r5rFhUc1k3A1ICXH1POxq/YmI1jJR?=
 =?us-ascii?Q?69Nc8Umcwm/olZGJ0WaU7K01zC2PbbJ06V/f4RALFHFBgkNibPscjkgt/Fr4?=
 =?us-ascii?Q?knx8jl1Oi0Lm+PYuAHP6vou09Hyg1pAhgOHEnv93fvThwkuB1Pd7X3m4s1Mj?=
 =?us-ascii?Q?0MUe7F09Siekq3MNr4hPn5hYCYnk94KSNhs7YHv69JbhXg8667ZsFP9k7bPG?=
 =?us-ascii?Q?vEbwPLA8IWxZicakGrxKbeo75Exjg9eBhV+PKM5VLuQEUf8x/Z4oETVhYiMh?=
 =?us-ascii?Q?KLWVD+WeYVcEoOTLHNc02i5t1UDhRTlRSI/DPIh22bFw+yQDDhIq6Y2rCAX1?=
 =?us-ascii?Q?Rap+B6mUwZX5vzJSEIrhrNlRYywLLvBGcGCdSFUCEgZNNBOXvpXy0qfmNSA3?=
 =?us-ascii?Q?mANbvWqQAokgTTMmKw2kaB+Poaxba+LlU1u7L8LzIrGDEsFVwzXB8JV9Gf5E?=
 =?us-ascii?Q?zfRyE2P38b/sG+MGDBJFn/aCSW25XIKXfD+Fi1gOBnljRA00CzbqYUmGWq1j?=
 =?us-ascii?Q?QFWXYqXi9p1Zy918nGfpimQVfPRzsqNsAARLXcg2BycZirmo72rvE9TgAUmi?=
 =?us-ascii?Q?duKLWuS2DFmx64GHSgf1M6uadH5RJmzTbdBfrhtbSRFkyChhHcASmECuJIso?=
 =?us-ascii?Q?vFC3nd5GWaIahsDOd9HoVW45za2YmLVfzj1ErHOKCN458Ak/lth0EqoKH99S?=
 =?us-ascii?Q?ZNRCREWa+r7y11RoDQ1R0D9jW4n7+ytOmk3Y/JrQoNuWxnJE+9JQbp9Gkhl2?=
 =?us-ascii?Q?KTNfms0SMB6ruZsMnWijjd0tTtjHModqplwFjskTQSLxVP99dX2MPugh7hqs?=
 =?us-ascii?Q?N1OFTsSto9bt+99W63fPODfhLRW4ABldqn05TJfr+T7ij2fy7rv28ScnyhdB?=
 =?us-ascii?Q?R9zdV4Y7slwY6eIlCt994FTid8AEQ1QhgqiS6z3NfAblfSOj8bYc9RFap0km?=
 =?us-ascii?Q?gmyIImXJH1OxDiOp/OG0Q4GAPKeOogl1pNNFwALRaVJseXYf6Txu4LKpGC+K?=
 =?us-ascii?Q?4UDRb1AOGfqHn1Jzpjg+Wbea3FPIxdLXNsBQ1DSDIVq8+JTqpUa+BZtneYOL?=
 =?us-ascii?Q?em2p0RXbermtYy2Pk0XTupDoYT83Rl6d7vYyQgyJqoYhFMSPZuIh90QPETJ5?=
 =?us-ascii?Q?oPD2ilGJDqZiGyn/F7jo5LJxVTLylWmPWd4Q0Iq9cxus/wbcLrJZ6LVhTMhD?=
 =?us-ascii?Q?DzjDCmo7OEytnfJVsjLUXI3Cvyr6slaOBIX0LJeDL+hk5cSyihiQQMLo1p68?=
 =?us-ascii?Q?HyFZs98gfdfN+JgGsXFG0czEe9lYpCTv8vF/3BJrsPawoxfecvyVvfQ54KPg?=
 =?us-ascii?Q?I+enNSYefQT9WMLBBJ04CwvBqcBz4Amlmsb9Vkbd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aea0c01-ab2f-414d-b02c-08db8b695c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 10:41:23.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTCubM+3OpXS23lcVkbfSv/kKN4lEMV1J+bAC3qZw63n8lZzvDJdDM3TiXmdurJ91ulZrisvQLirJRam3S4N7NIwNiLF7C9Bcs+EaRODNw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter Rosin,

Thanks for the feedback.

> Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
> i2c_get_match_data()
>=20
> Hi!
>=20
> 2023-07-23 at 08:12, Biju Das wrote:
> > Hi Peter Rosin,
> >
> > Thanks for the feedback.
> >
> >> Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
> >> i2c_get_match_data()
> >>
> >> Hi!
> >>
> >> 2023-07-21 at 09:16, Biju Das wrote:
> >>> Replace of_device_get_match_data() and i2c_match_id() by
> >>> i2c_get_match
> >>> _data() by making similar I2C and DT-based matching table.
> >>>
> >>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >>> ---
> >>> v1->v2:
> >>>  * Added similar similar I2C and DT-based matching table.
> >>>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
> >>>  * Dropped error check as all tables have data pointers.
> >>>
> >>> Note:
> >>>  This patch is only compile tested.
> >>> ---
> >>>  drivers/iio/potentiometer/mcp4018.c | 34
> >>> +++++++++++++++--------------
> >>>  1 file changed, 18 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/potentiometer/mcp4018.c
> >>> b/drivers/iio/potentiometer/mcp4018.c
> >>> index 89daecc90305..b064e86ecce8 100644
> >>> --- a/drivers/iio/potentiometer/mcp4018.c
> >>> +++ b/drivers/iio/potentiometer/mcp4018.c
> >>> @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info =3D {
> >>>  	.write_raw =3D mcp4018_write_raw,
> >>>  };
> >>>
> >>> +#define MCP4018_ID_TABLE(name, cfg) {				\
> >>> +	name, .driver_data =3D (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> >>> +}
> >>
> >> It is inconsistent to have a named field for .driver_data but not for
> >> .name. Also, I dislike the cast and wonder if the trivial
> >> simplification in probe() is really worth this churn when that ugly
> cast is needed?
> >
> > It saving lines of code and better than,
> &mcp4018_cfg[i2c_match_id(mcp4018_id, client)>driver_data]; right??
>=20
> If saving lines is your goal, you have failed with this +18-16 patch,
> even with this compressed way of expressing things that could be
> expressed more clearly with an extra line. Not that a couple of extra
> lines would have mattered if the change would have otherwise been an
> improvement. And no, I don't think the cast is better than the existing
> code. We could of course argue about that, but it quickly descends into
> a bikeshed discussion.
>=20
> My point is that this patch trades one ugliness for another while
> bringing in no real change. It is thus not a clear improvement to me,
> and I question its value. What is the point?
>=20
> Why not work on something that is going to make a real difference, such
> as unifying the module device tables so that drivers don't need to add
> almost-duplicated tables, or something, instead of only doing minor
> syntax changes for expressing the same thing? With a single unified
> table, it would be very natural to have the same match data
> everywhere...

A single API for getting match data for OF/ACPI/I2C match tables.
Jonathan asked me to do this change, that is the reason I have posted this =
patch.

Cheers,
Biju

>=20
> >
> >> The
> >> reason the two tables differ and do not both have pointers already is
> >> precisely my dislike for that cast.
> >
> >>
> >> Anyway, something like this instead? Or _name instead of id?
> >> Whatever...
> >
> > OK, will use _name.
> >
> >>
> >> #define MCP4018_ID_TABLE(id, cfg) {				\
> >> 	.name =3D id,						\
> >> 	.driver_data =3D (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> >> }
> >>
> >>> +
> >>>  static const struct i2c_device_id mcp4018_id[] =3D {
> >>> -	{ "mcp4017-502", MCP4018_502 },
> >>> -	{ "mcp4017-103", MCP4018_103 },
> >>> -	{ "mcp4017-503", MCP4018_503 },
> >>> -	{ "mcp4017-104", MCP4018_104 },
> >>> -	{ "mcp4018-502", MCP4018_502 },
> >>> -	{ "mcp4018-103", MCP4018_103 },
> >>> -	{ "mcp4018-503", MCP4018_503 },
> >>> -	{ "mcp4018-104", MCP4018_104 },
> >>> -	{ "mcp4019-502", MCP4018_502 },
> >>> -	{ "mcp4019-103", MCP4018_103 },
> >>> -	{ "mcp4019-503", MCP4018_503 },
> >>> -	{ "mcp4019-104", MCP4018_104 },
> >>> -	{}
> >>> +	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
> >>> +	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
> >>> +	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
> >>> +	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
> >>> +	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
> >>> +	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
> >>> +	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
> >>> +	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
> >>> +	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
> >>> +	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
> >>> +	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
> >>> +	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
> >>> +	{ /* sentinel */ }
> >>>  };
> >>>  MODULE_DEVICE_TABLE(i2c, mcp4018_id);
> >>>
> >>> @@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client
> >> *client)
> >>>  	i2c_set_clientdata(client, indio_dev);
> >>>  	data->client =3D client;
> >>>
> >>> -	data->cfg =3D device_get_match_data(dev);
> >>> -	if (!data->cfg)
> >>> -		data->cfg =3D &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-
> >>> driver_data];
> >>> +	data->cfg =3D i2c_get_match_data(client);
> >>
> >> NULL-check here? I know the original i2c_match_id call is not checked
> >> for non-matches, but that feels like a simpler function than
> >> i2c_get_match_data. And less prone to changes.
> >>
> >> Same comments of course applies to the mcp4531 patch as well.
> >
> > Some subsystem people doesn't want error check as all tables have data
> > pointers. See [1]
> >
> > [1]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-renesas-soc%2F20230717145623.473cffca%40booty%2F&d
> > ata=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C8aeb0ccf13944b668d9908db=
8
> > b68ad17%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63825705391950373
> > 3%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DJoNl4I8FzcvgcGhppE75W2Ae=
7
> > 7bkdioKq5CjOHTtsn0%3D&reserved=3D0
> >
> > I am leaving subsystem maintainer to take final word on this.
> >
> > The new API is very simple [2]
> > [2]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
x
> > ir.bootlin.com%2Flinux%2Fv6.5-rc2%2Fsource%2Fdrivers%2Fi2c%2Fi2c-core-
> > base.c%23L124&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C8aeb0ccf1=
3
> > 944b668d9908db8b68ad17%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63
> > 8257053919503733%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DGVYVg%2Fo=
7
> > AxujITu4AvgDkRKymYw%2BGtv%2FGPDmSPBn%2FZU%3D&reserved=3D0
>=20
> I have of course read that already. Even if it is simple, the new API is
> decidedly more complex than old, since the new API wraps the old and
> adds stuff around it.
>=20
> But do note that I am not pushing hard for adding a NULL-check.
>=20
> Cheers,
> Peter
>=20
> >
> > Cheers,
> > Biju
> >
> >>>
> >>>  	indio_dev->info =3D &mcp4018_info;
> >>>  	indio_dev->channels =3D &mcp4018_channel;

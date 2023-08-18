Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C678113C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378886AbjHRRIC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378906AbjHRRH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:07:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A13AAA;
        Fri, 18 Aug 2023 10:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLw+5yO2/ipZw9CO1Rc6awwXlQ0KCYu1yhGP48QF/wXbWTRBwxIk0Paz7p5E+ZzcoBavE4g3KKI24/5IsqlnImPF++UcHP5WM9MnC1PmQS/iCAaQoNz4vhuO40dJUo4dLMnry9Ru6nB5XkX9nnbpNBT6nUTLqcZ7C2ytRrCxnbpKmmBBj2rb06OtsvsssP87pvVM46XDKI9VcluwYu87xzLdwF8mdrIamduMPMVYKUJBtV6zDoR7wcaj962etiPR3nUu0tUNVU/MiVPex8c4N45AwwCusBD1V+SlLz9p/m7J2MAiD8QZv5C0PF1/61c3by9mXjwCvXANg3oRbeZNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kllCkKjv6GEZskVzuJ/TbGhII6tqSQmLwW/0TJeSR6g=;
 b=dDpVIioItwkKG1F8ZRH6VMr1SRlA88+vEZ0c7/xP95XjDxCgwJB2TG3n2jTeC9vGMld98kiCEBmowcM6mMR39Cvr1MfgYAzxR2Efbu8hAmoWZHcvFTbuXjT0vBQydzj9jTVmlhAgXxFzSkTUVOpXwWzVltHgzxw89AOCIatXb2TfmwGWf0WKwovK6vOT4U4iTuKI5UF4cTxzOI4i49T8DoQ1n54+TYYv0gwa34Zk+woyJ1vaJFcuaasrqRwnk+TKl0Sm11OAPFnD779qHt/IOJFx/KLi9MrT2rVlFgP0b9Na0ivBd68IHcTtArgq0pjGrvzNaAo75ws3bVq/HI2Y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kllCkKjv6GEZskVzuJ/TbGhII6tqSQmLwW/0TJeSR6g=;
 b=N9Kwpn+kMM0PIyzF1c8LGo2SkH3iw1N5x38aSIBVtX83JFQjF/ZEQ/lKCr2TDUlvdR9kTM9gX/CgP0tYzWzXPmX65KmgkaruWjvEQIL96Mo2DeONxV3NzjrNiibBZyUKN5PABfYZ0TiTCMFRxkhaQQrtso4q5Kl37zVSTm2DPEM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8399.jpnprd01.prod.outlook.com (2603:1096:604:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 17:07:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:07:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Thread-Index: AQHZzO4GZ7D+A2SpqUSmNVzUIWA3Ia/q9ZeAgAU0ZGCAAAQYgIAAJBjQ
Date:   Fri, 18 Aug 2023 17:07:22 +0000
Message-ID: <OS0PR01MB59224BC97CEB18029F68799F861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
 <ZNslJ44ivDGKR6b1@smile.fi.intel.com>
 <OS0PR01MB59223B11C14FE29FEE9CF080861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN+GR5+NdUqtnM93@smile.fi.intel.com>
In-Reply-To: <ZN+GR5+NdUqtnM93@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8399:EE_
x-ms-office365-filtering-correlation-id: 7c4b748a-15dd-4e63-f116-08dba00d96b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLCrAoM+NR1I+zSh+0vIdUrfgmXIwH27p9hQhjp8DLNiAKyqEqzmoG+rsZIM9XZQDgLVQzb0iGRnqkqz7fxAMNvO/EzLohQEjSe1AlcIRscN3zLCIXY1pMq14Dp+fd/ais4mJcpxtD1aE2TNUoCX6fw27h++0o/lwGaA5TbE0jnQCwhpMgfVJy6utnFHJYrTtXWSpGhh/FpH6h8/vS3qVIW0TEDbd84vheM4yzzioc1VaKPg7PxL5zvA7uvimGxNA5vjIvxnrqV6g21su3e5VQ5IANSxLAZBNDvskztQw6yZNUUrRWR8Zr/qXU/9F5o4r0a7z9BvgLQe3bhtBu1xQumINnsyQ6QlONl99enAH0pjw1/X8Bw5c/WKQaZ9c9EACwvTNdnwEzA2pQe1kUgrqgbMpqUYZvUiZDNoDQsGDqB38hJaFBPkLHHiK2howtuah6sz139wgK+W/DZNDyb8XL9ZmqswAfvfbZSDoNhmAGoNrGFY06qK4Am/Z7YmOZhH0ifOjXpHnc8OKkvWO3q8w0bONqvWDxlrPQnXVPOY59l0gtxENVXjjApAqkYblvkFOVBidJSR1Zc+MLqOIleH03F0psu4hNSNIsK45nLt+nh32MV/7au8ErmQtV/yUP4l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(33656002)(86362001)(55016003)(122000001)(316002)(64756008)(66446008)(66476007)(66946007)(6916009)(66556008)(54906003)(478600001)(76116006)(41300700001)(38100700002)(38070700005)(26005)(6506007)(71200400001)(9686003)(7696005)(8676002)(52536014)(4326008)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iFUDdMqW2RracaTIInDnOHgR9hagFL7CYj78aJxkGDIs/47gzy9VuqKx3A?=
 =?iso-8859-1?Q?MODnKmuPMTN4LDQEWZHkaL/Bwb1VcWnJoG/qWXsHm2gv2YIAEpNI6W5UOT?=
 =?iso-8859-1?Q?BpdSe90uju7cZdNp1D8atSmzN03AK1hvTnX+qBP9R2x8AQauvqkb0oLajf?=
 =?iso-8859-1?Q?T7fipAG+6nqHLW7LZe6ENoYDBPC24RA00hzq+/j+hct3z02Haov+H/aiKr?=
 =?iso-8859-1?Q?rln7+8TdZxsZwy7GasufA1Cnds+Dt7qr0SH30Xze7FnCE2MGKPjYTGiqov?=
 =?iso-8859-1?Q?IlUWmqGlaI6xksMh3xdmODgpJ8ESNbmmfVJPWSoNzaYO/YsiMLzvBTpzBx?=
 =?iso-8859-1?Q?vXKU/UsHevqL9jkHU7nUvJ6YoLjXOh2odTSWO1c/g3E1HOK7n6ya9uaZX7?=
 =?iso-8859-1?Q?KT1MiLkN1IFtrW5lU3DAfuzIVlbp6XOpV2Qk3QHjZws1fC3+vkVhLa1+/a?=
 =?iso-8859-1?Q?tjK//TYAPyOBAepSPOSW/GZ7VrBa813F41ypcSGBfkYi0FJAVAWRs/umIl?=
 =?iso-8859-1?Q?8kZCJbnzT+JfNszjlk+8Q+wwejbAshZWjZPdHk+QSorZc6c38TIiiXsab/?=
 =?iso-8859-1?Q?smNVQOZk4TNYdsdVU9zmNIlVFNMyWxfIKxdhAzETEn+5kgBjgb4gw4pwC6?=
 =?iso-8859-1?Q?U/cwY4rPlRiwJUL0ASsCMaf4dxkEc+s7x71WYf78EF7wWQi+B3y3oRmXUq?=
 =?iso-8859-1?Q?n5KbCQZqx/gc2PGpa/Kw/Fm8MyHSJEC3DNT34ljCPnzzjm8LzBdVurl9Ww?=
 =?iso-8859-1?Q?McYK5QSPBom2DlwDSe+IHHtH2cZ+x/QxlOSxXkGeeWmrZreNR0zwchqJah?=
 =?iso-8859-1?Q?v+4l7WINGZnSqCxXuaUrHBV5WHU9u3GECi1lOg0YiWxOD/9LaPmj2F0GzI?=
 =?iso-8859-1?Q?d4E2/eL2IeKAgdX4ybo97gA7mVc8Mng3zDFi13niFHxqCQVa8R2DR9ycdM?=
 =?iso-8859-1?Q?YFBOMfCIXrrhFbzvSiURQdqHaPFwy/+PLHCCGr720ch7gAecllsvXSFRvI?=
 =?iso-8859-1?Q?mtbPNkfxFtKHqo4Vp1zIwDjPU2XZdzUOmGUo/IdT68doe+2CF54rmFTiTV?=
 =?iso-8859-1?Q?RN577kJw19+ZKrQ1ep46YOKkunuzm8LLRWvy0IMNPsRbN/glXFvzlNrFlV?=
 =?iso-8859-1?Q?nV8OXN7yZQYw5PpZIAN45d6lHvGvDpFQxE2dzH6+KVDwVP8oy/w4dUDBN1?=
 =?iso-8859-1?Q?Wqf6L8UDx8Y5IYgkak395yqzdMy87EKby+A/xd99S9+C4H/UyLul7pxrZ8?=
 =?iso-8859-1?Q?nNinYDqAjojoOncdOM0XScwR70otSks3z7jLUrlVc36EWK41xbKCOF8W+3?=
 =?iso-8859-1?Q?MZidhbv561ICTGsTKd94AIZxxTZl4IKJmq4v972EYsE7pKFGWubEVXUQG7?=
 =?iso-8859-1?Q?eWEEOs0w9jiy8qFhLKIVl0CV9CsvZCmFkPHVJXQH9jpdEqDVIbb+FWZG2F?=
 =?iso-8859-1?Q?ju5zrwANvdxQqzHs3lBNGcyBqorzn2rG2wCTlREvvji/jdmif738X48H+/?=
 =?iso-8859-1?Q?QHqEWzggmCkJEFvp39LZaAjrbwBzBddWeFkogCpXfKmPRfWruMDB1ZqmDf?=
 =?iso-8859-1?Q?VgLiHEcOpBbNCE0H2obk4mH7SncdBBylAWIRO7in9BfQfKP8xbW5VrbD4w?=
 =?iso-8859-1?Q?oFU/xm/so6W0B7CPFxtYj0WgP515dwl2iU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b748a-15dd-4e63-f116-08dba00d96b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 17:07:22.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3MLaco0LNNY6zhDJH06SQ96di1ZXiT6DyWb93qRFIhglU22vaqt95vHBYNyYoqvjoybJCAAaSy8tXngHQ7b9kgxKyMsP6XM9CNi9qYCDN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8399
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for the feedback.

> Subject: Re: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
>=20
> On Fri, Aug 18, 2023 at 02:48:45PM +0000, Biju Das wrote:
> > > On Sat, Aug 12, 2023 at 08:24:19AM +0100, Biju Das wrote:
>=20
> ...
>=20
> > > > +#define MAX1363_ID_TABLE(_name, cfg) {				\
> > > > +	.name =3D _name,						\
> > > > +	.driver_data =3D (kernel_ulong_t)&max1363_chip_info_tbl[cfg],	\
> > > > +}
> > >
> > > Just use them directly, like in 4 lines each instead of a single one.
> > >
> > > 	{
> > > 		.name =3D max1361,
> > > 		.driver_data =3D (kernel_ulong_t)&max1363_chip_info_tbl[max1361]
> > > 	},
> > >
> > > or this, but it's almost 100 characters.
> >
> > OK, will create a separate patch for this change.
> >
> > Worst case, we can drop named fields?? (.name and .driver_data)
>=20
> I wouldn't do that as the goal in kernel is to use C99 initialized more a=
nd
> not less.

Currently OF table is using macro. So for consistency, I added
macro for ID table.

I am leaving this to Jonathan as previously he mentioned
he wanted consistency among the tables.=20

Cheers,
Biju

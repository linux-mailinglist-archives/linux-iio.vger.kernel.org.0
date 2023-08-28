Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1178B3BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjH1O4b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjH1O43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:56:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BECBF;
        Mon, 28 Aug 2023 07:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjSKQg56UcRqD6XPICwkgVJhzPBoyMQtb0qLDSjoU3Wg/D8cKxIKXVWV0IOysPV5BNGTCHFjaIjsDayECmIa6Zm6J4tIyP5cFft7IGcNqT3MEnu8H6KGwvyCYDHnyIGmfH0mo6mfjop3qtR7bfjLRXGXShqOHb9jtIGTn7m/zupiQ0xUKu5GY0w6jRiI22kDeaucbs/0CyfzyY6TEq19wDg3YvioKd7XM/bAJR119U98Y85uCM123MMXMhIzNRIvRm0x+YTuuXWHyjkASjjbk69XCDlrU+RflPMS3Ytf+uOSRztFyCwlg2akpqt+y775uHPOpz+9vY3B3VWlPDuLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUjOa3VWTFJNBVzAQ3N9k38U+QaDHo6N4o5WvLCBAt0=;
 b=NC4mjeJEytLkkAjmtEcev7G31l+jSIX7vEs0qnDfcw4lhVVWfujNGa82/PRiwXQEDPuXiftA0cH96EY/TZB6K3527QwUHrKqGiqkATbKV/M9Wn8k3jn2+9QfN174EzawjT/1DA1x/EGSYWnciXTLL4coCwPDiecok29jDefRET/3OXpd8h8m0GU/5CtHhGADk+x18y+r6zZ0XIK0NLYwrJHYnWcPAznJ7LogBmRF2N0cbB57qkwNPMAMtoe+u4PZciKoWtqrfkYjgVEHkYAw/SVLvzHHLbIkWHvbDVKKv4SXJERVQC4o+wpZBI+s68Obxod9h1/3tbMStfLdLQMOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUjOa3VWTFJNBVzAQ3N9k38U+QaDHo6N4o5WvLCBAt0=;
 b=Ao8DKGxY/1fdLbOiqZZaDkeRiY1fYGYC/IEM6yrW/sbbacy40eRSgryQ2+xlCDOOA8NEmQ2vxU+v8RHTvWVcHkqIExjgwgRT7XzL9flq6ke8pdJrVwZ3ElJQZsFihuN5L8ac3KErbmceooC/z/cRhp8JzdJqYwmVnlpmpp/BgyI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5654.jpnprd01.prod.outlook.com (2603:1096:604:b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:56:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:56:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Crt Mori <cmo@melexis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: mlx90614: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: mlx90614: Use i2c_get_match_data()
Thread-Index: AQHZzTkxU3tnEzpQsUChcb0A0nZmRq/o0sOAgACi2+CAFlhpAIAAFviQ
Date:   Mon, 28 Aug 2023 14:56:21 +0000
Message-ID: <OS0PR01MB5922B91989C9F1B1E194B5C986E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812162222.200004-1-biju.das.jz@bp.renesas.com>
        <CAKv63uvEu3kPYF=idNyW4RkwVWFgixdstQyvuUhhHzc_rPgqqg@mail.gmail.com>
        <OS0PR01MB592204FC9A5A054CDFC300F38617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230828143332.48bfa4ed@jic23-huawei>
In-Reply-To: <20230828143332.48bfa4ed@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5654:EE_
x-ms-office365-filtering-correlation-id: 8c2924ca-3129-4049-180c-08dba7d6f101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+7ArABFkdeFXreqC1BgTreB/Rn2J9HGNWruJjjahxyTWEafovWo9OyGSfe70pI64164tKC2lF5dNSsp7dR6SCFS3W76ZcbHt1xd4BkP9GZYu2htp6pj+ZFRwnOVqdU5zkMLk8MPh3rktRpHzbAxgdV6CfE4IH+bw0gbbhGDL+gPMrAZQXaotbNGMSBb0o6HdwgJ8Dg7/vLsieeoLfqWndTXDVD5xwPDbE4ABw+m8W5wCWmN+dIEQ3m/JeQTLGD7m9uahZU+LxEZD8/Gtnseep1RydYouxkJckSAd4+eBF7vMHEiVFAd/ORSwRvGYKwV/v4R7Pxp3FQG7zdItYa8BloAY4ut465V2Y2IY3vcqiitmmFXe00RgwdkmakxLiDt/y2eT/MbYzZqJBERqvvVVkGxZzT7/zxc61obFBNPVeOP2wsu5nP1IYWLb2hyXiKE7gDNHR4BQ24mzOIf6BNRQYsMaG1wrtEi0xS/Jt/KHTQKLAz5lhlmPdLg/WOyVZQ3852DeISFVt38gYrMLPiIudXI6x61dQBSXs4FsGgghuzLgN1U8oMYZ71EGqo5nfTKrIJJwlXaI4nGuC5dsiAMTvM/A/O84yr6bk02aNkXZvfWQ9f9PK4PVIVvCNmxpi3Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(9686003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(55016003)(2906002)(26005)(83380400001)(478600001)(76116006)(52536014)(66476007)(66556008)(66946007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(64756008)(66446008)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ho+HwvVJ/Js2dU0d0EG5SmBZwZfq4dsHT3czGuEDURTbvE4JjYh578H4JkiR?=
 =?us-ascii?Q?NtkJWZPKEapXMpfCVM34x8G2ce58cLpqDVBvyGoT4iElpHGu6zdxNXilB2va?=
 =?us-ascii?Q?3KB1lqMa9vuuQjXe8Yo93mu+shgo4zhM30niJj+/mjaYotid4JR1GIQN83wY?=
 =?us-ascii?Q?Ms43oelDvYh4FkzIPBc6XVjgWKYoxXCjuFQcDI1PyGZOp7vYl4MZ4V1YnI4s?=
 =?us-ascii?Q?S+zScuJ4LZf2EU8cjHflmkPCM6eOA+xZVJf3Vqxwt8rXea3BO0+OyHJk9pfv?=
 =?us-ascii?Q?3wWa1TBOFAAW+W3rNBXS444od9CbU4zhxVegvpwD6+cS/LT4h3H4tDBSz+CL?=
 =?us-ascii?Q?CewIUrwozjxxNutLlfGu/2QIBPyIue0MKewEZnC6RjhJgjDtH5Y5X/KKIk5v?=
 =?us-ascii?Q?V8yQ9PS6imfGfhXjTv+jSnDID3YXLvcEPRui6hA7n1m8lMvXQ/dsX1p56H0i?=
 =?us-ascii?Q?KF7TyfTt5BdLpuN9y9kAmH+ewQqcSs80KF19gjkyk0zh+Yw7HHzHf2b5ctfq?=
 =?us-ascii?Q?/5YYxwjKeKdqTIVU2b4nrjSjAGlRugiPWvfaYVB/Ys48bhzceZnf/CC3Sdu4?=
 =?us-ascii?Q?Cj73CR0a4yGn5z/FKLRm3+GrbVgDnAhII0LtChAta0sS+3Xdw6/L7owMubPa?=
 =?us-ascii?Q?cC0u/s/2UMbIAucZ5THrf96dbiHzKa4haOZAIY2/JiO49FhX9ASjBIWIndOY?=
 =?us-ascii?Q?1x2Naxq0yyFubfD+wVEqHzqINStkCRDZqxDE8QBCqsCdBgymh2qt3zmE1RUK?=
 =?us-ascii?Q?rkyU71GCRK3YCklfNQHfcy00MFNLrhE1ij6xUAqf84ubcNBtD8pdu+UwK86+?=
 =?us-ascii?Q?f7k7/ZdMlRv8qqCM+hTKuz1NXFQXbqXsublloxp+vDx4JLqvf35OIfJ8Oymd?=
 =?us-ascii?Q?5LQGOuz0I/oD3VGtCDOJyOp0phKrpFEleuiiV76plBm94Xbu1AW+IKW28sBv?=
 =?us-ascii?Q?CXSqvuSy+7s/ANHVmpooggszKIxMe8QGVCa10nPRejKDTE+4+6Il8hy55HBO?=
 =?us-ascii?Q?mtiSE3aNitWFQh3w7nSVcjeJXIpaBwIpvOz/aCxnjURCaxFqIpYgGSyYMuWg?=
 =?us-ascii?Q?K5T8x/CPfKihMzJOOiZlUdrRdgC3UENhZUzT77NqVLfjhnqSpU/aqBjo+pfU?=
 =?us-ascii?Q?OHywWryqUnTI9JqPXCUYfsObFHXbffAmXJkqUcsziDcGmbyucoxyyv5z2nl7?=
 =?us-ascii?Q?piGkdzMZIN68x/kNwWZB9i9KqfOi2WIIg+zcTCKIfqntgnn1nfCpcSBnljMW?=
 =?us-ascii?Q?iq9TEeEuiVFD0PNyzH5trRjq7ijpqVzgAOb2uFmRFA57yMDcTETLpHWePuRS?=
 =?us-ascii?Q?2lR6Z40dpTD9eKDP6MOgQSNSmYK6lVrulkEQ3prYadFXNLQx8rZH1SrToT4T?=
 =?us-ascii?Q?ErUC9U9NM6m1L7xyjjORj5Rzdai1QzmoUZiwPg3sH3olxardNQ/luDulUu1C?=
 =?us-ascii?Q?OEVp+ONGRJn80T8GO+6J8PVJfIwRfQ6dctt1w/eEGAh1rwS05j7HxHldX6Q1?=
 =?us-ascii?Q?UH5RMRQ+wNBpWZbzrcCOSlM78C/an5ZyKbJkMqxlcJ1ULVFFMnfz8qiR0aWV?=
 =?us-ascii?Q?NLJQqvEIGM0g/3H6wugMD5unbNnsk+HZHtz4ClGHcaSOFLT40YQZBCjMf4ai?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2924ca-3129-4049-180c-08dba7d6f101
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:56:21.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcCVYZSJmJUvURz5+FNQDDj5uNSuDaseC4/h/Df+ZySU5EmeK2BRJBB0CACPcBnSOWp8xifGNdZoI245ALImMitSTx80JV+cTwRqA+jfdns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5654
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan Cameron,

> Subject: Re: [PATCH] iio: mlx90614: Use i2c_get_match_data()
>=20
> On Mon, 14 Aug 2023 08:28:28 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi Crt Mori,
> >
> > > Subject: Re: [PATCH] iio: mlx90614: Use i2c_get_match_data()
> > >
> > > It should not break some backwards compatibility so:
> >
> > You mean,
> >
> > Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and
> > constants into model specific descriptor")
> >
> > Hi Jonathan,
> >
> > Is it some thing you can do while applying Cc ing stable@kernel.org ?
>=20
> You've lost me.
>=20
> I think Crt was just saying this patch is fine, not referring to any othe=
r
> changes.

Ok,

Biju

> > Biju
> >
> > > Acked-by: "Crt Mori <cmo@melexis.com>"
> > >
> > > On Sat, 12 Aug 2023 at 18:22, Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > >
> > > > Replace device_get_match_data()->i2c_get_match_data() to extend
> > > > matching support for ID table.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > >  drivers/iio/temperature/mlx90614.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/temperature/mlx90614.c
> > > > b/drivers/iio/temperature/mlx90614.c
> > > > index 07bb5df24ab3..740018d4b3df 100644
> > > > --- a/drivers/iio/temperature/mlx90614.c
> > > > +++ b/drivers/iio/temperature/mlx90614.c
> > > > @@ -600,7 +600,7 @@ static int mlx90614_probe(struct i2c_client
> *client)
> > > >         data->client =3D client;
> > > >         mutex_init(&data->lock);
> > > >         data->wakeup_gpio =3D mlx90614_probe_wakeup(client);
> > > > -       data->chip_info =3D device_get_match_data(&client->dev);
> > > > +       data->chip_info =3D i2c_get_match_data(client);
> > > >
> > > >         mlx90614_wakeup(data);
> > > >
> > > > --
> > > > 2.25.1
> > > >


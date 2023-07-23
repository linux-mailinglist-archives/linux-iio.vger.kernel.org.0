Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3E75E166
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjGWK2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGWK2Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 06:28:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6D1BCE;
        Sun, 23 Jul 2023 03:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHGJ73cMeY6aKBoyw+gZz7uRCcfypJBkiIn1iD0fzAaqXVCSek4L4R+ifUFc2aOEvOhABXCwifnabS/dw7IZRMGraaM/Mv0aXzHsfBVjvYVPdLmtcTB58jaYUdZXOCOLwtiwX80/UmE25qrlbuXziYB+AGO//oJ6TFRZMgV+vkXU7DtmP+cPsE/jm69FlT1Y6aF+t+htKYPYpfEAFOmaflrB4n07ztFjBOvyiuYvnVZ3oGyG4nBhx/kpbqpo5VYiAiy5AfH1fxiMWs2ih4DyUaCy13z40RCmeSsYjvq3tVwSVXWL6SS+jj4nY5Z4Gg8OX2zb7TG2W38yX6unddUBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLcOnafhVEokdKFvwdEGctnz8XuLmeaau0XGrq6d6WA=;
 b=cjK0m/J6DjSq9P742NSdaytRbeaEcGvri8X9bYcDuq2oHEpFHnGD2QGiWbt2IZPQUyxiWyVFFSD37lPHSHkcSrlJ6PM6N2Wq03KA8fbHO6x1I77OIGrMbJxh+YQmf8E65Y53XsVlS4a16JCD99Sh/Kp4R+Yv1WObKonLjx9KAtHuwtk32WfcAdJWFHTX4YNvcYn+YofuEVPq/oYmJzVGkUY1PKqi4PG+X0ALTylyiStfI7EKzjXTNYVvN0dfV944GCqWYNXPzjiBCbBKVpevlZ0Nl5RiBc/nGe6Ey1xGaaw3PjrhFWo0t4RaDBMYN+Q+qPmreJ+YLogsvVxbNfJoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLcOnafhVEokdKFvwdEGctnz8XuLmeaau0XGrq6d6WA=;
 b=BMQXzpGOAXtZ2kh5RkUkoXyXjy+5nz5wyAo7TLErwfcGEbOEEioYX6PyDSl9Y5moMBrcjmK0bX+Cb26FhLY8YtYlN5jnmGQn0/artL6ORFQYg8Q1ZkJQVisbxG5ql+esnkpIxFqHfp1AvtDYS8+vmhVQXkHC3moqzZGo45P3IlE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8035.jpnprd01.prod.outlook.com (2603:1096:604:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 10:28:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 10:28:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] iio: potentiometer: mcp4531: Use i2c_get_match_data()
Thread-Topic: [PATCH v3] iio: potentiometer: mcp4531: Use i2c_get_match_data()
Thread-Index: AQHZvU9KMwe+cVIdikeT0Nset/sKe6/HJgvw
Date:   Sun, 23 Jul 2023 10:28:15 +0000
Message-ID: <OS0PR01MB59220C824F3CAC19F8504BA8863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230723102016.93738-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230723102016.93738-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8035:EE_
x-ms-office365-filtering-correlation-id: aae1ace3-3095-4379-c241-08db8b6786a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bihJhtgQfuRMgWxhrnPwZz7rh/IZKO+soL2oyNILLgnexwpeRj4Sf2pM81urgpsJJUIVtLwQI7CC2xnnv268kYhQ+0AQd8R7k0gLKYUJxTrA1PNlBaraoIYMNuKZVosBYJoImxzvZofZf1K/dmcVjg5ov1GasrYhf8MX8V7Aa43lxXFfSkIKYO0rxpdnHVKRH7SACBAHKrYCVMCxTreu9OkceIPd3Zeqib48b8kHgV7jMG2UozxdjpHdDkhGc+scqvvrNqz/wSIBvNYDcY/Im3HfjJEL8IQ/iN1nM0nyRgbWtYWB1g6xQ1Awsino6Phk+1gkYpLtewRX/cd0/vgxsfiAxO3s5/wPIV5FWc0zqV3LMnBeWQpQjTB4TVyH4BwwKg/nuJxeAOT/QktiN/jFXsx85G3fJSeGKr+EujsxsfFkoxaq3/3Z4L7rCY5j09GPNV/73+PUBnuYIHW+mPUPd2oiox+zCTJnVkyCyz9kvizzIEeW+9QJmhRrJZKSp0ubNiIC5Tvy48jmg2+fDWFwo+jn2NlWGm/MyO5ClJ24DXRf/Uj7GVZ//5Q1gnDey7mqkuMGy++A7bOK8NUg9QaOqEE3K6aWTBZ9dPmwl18FLsbeQiIAt8+bOT7i0Rowuv+7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(7696005)(54906003)(110136005)(9686003)(478600001)(71200400001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(53546011)(186003)(26005)(6506007)(38100700002)(122000001)(66446008)(64756008)(66946007)(4326008)(66476007)(316002)(76116006)(41300700001)(66556008)(8676002)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sSjtaz1rXqg7Pl1ss8wkLQ/gOKv+/78l796KImHV95bScOg1DP+I6rToo6D?=
 =?us-ascii?Q?O2v3nO4NPrRjvJd9Olz+HaEfduavfMGo6sHMUkmOpRdjv4AM4k0hqfT4IidC?=
 =?us-ascii?Q?haqd5zJ+tMpASWttJ5tNWDS7pBIx+w/yNmfcSntfG1W7Ttg4Dxpd8BDwQ5s9?=
 =?us-ascii?Q?v32eVyduJ2twCujKU0H80L1a0w8sR62ZUAYdUaTFl9lzSdVbmygcSxPXlaan?=
 =?us-ascii?Q?JliEkFtcB9rdthDwwdrABtKtzmcr9a2IrbgNMed6+0QG9cywh7KJvhwgu4sF?=
 =?us-ascii?Q?oN2LdcYAC4I8HKJzT6Ol2YYVZ0VeREIyFJwicYDd0fMHqaUHaSBs4iCmI4XG?=
 =?us-ascii?Q?9DznFyIKXYMzjXolV27aAnx+6wO83CIZuiKoignnZZNFgnOQa113hPc9AxAV?=
 =?us-ascii?Q?+846OoAyMzzlANJWVDNiiiJLP0zFFigQzIJQHKHnxiLDYMGElFjs4TOEJvXc?=
 =?us-ascii?Q?CuBNCdbMSTI3oQWs4fFL/IsBjZfqlxbYQTFmn8vIUzvjRUVf8/Sv4Y8zHKMJ?=
 =?us-ascii?Q?qO+0jOhgTsTXrKREGEodiTGSgheaPJErYYZR+J/CcQzlXFUEbxUtXRWkQn7E?=
 =?us-ascii?Q?al3cQDR9lAe5IiFDkK/aOBPvoZKU0QeL2m7L1h4KRQr9SPpLceq+B7UMwA9Y?=
 =?us-ascii?Q?a3tc8Uht4t13rwOOe4Ai16vz75x4u1JFxCm4TnaYecqsMFYIi56vlnbgMWc8?=
 =?us-ascii?Q?mbnJUx5X4aVP6mlh7TC3RS/UEtQ73fcsy973p1XFZjlr6u1ginzp+f51PNbC?=
 =?us-ascii?Q?YVT2uQTVMeHJo+Nr2Mpvb3vW2wxEwEtDN+pWYnXmowlU1q9S9BAHqvEoLFSz?=
 =?us-ascii?Q?l+yJHxQIiXJRAlhSTGbij0i5PHBwg7MkARVgO6CwTtETyKBsGk53QTpzXyQm?=
 =?us-ascii?Q?oPBpVj6NQ8hrUhhTQSZ+YrMkk6yU72W/sYykYLCM02e20q4AYrxThBM+Xdz/?=
 =?us-ascii?Q?aX8jCjMqtYXRAzejuYMQj8SFLKGADla0dr0Tz7+I+Z+cwlzsR9T8O6mlJS0p?=
 =?us-ascii?Q?R7BbdvXAiTpYnpSFwBLNsdDDEcWGFAmJ5Yq2yxbCwhx3BA3QLyYWi/dL0czE?=
 =?us-ascii?Q?0vG1mrfslIrIdEgRMcNB/NMcop7cwTOgXjh407S3SNJmPk8LI1GiCegQBIDO?=
 =?us-ascii?Q?i8bKvi97AJqodmFip1lNc4/4EZJ8bAHVOFT9fFaP0MYCLAzZZGnpEMdERpOz?=
 =?us-ascii?Q?Kkx8En6FWWEWE8Bc3FYKfKRvnZrzkPGtlLH2Bvhrku01HQpCYN/5lyBeGNpg?=
 =?us-ascii?Q?8SK3AHYhs8QNk+4Egde7TOuRh70IYHDdSa5ZwzVh9RuU1hrI97N4yrLSmFH9?=
 =?us-ascii?Q?G1zsBaRlL87yvssP0GHE88aq2mD2hbBBTd00BX9N4V2Q+bpbVwkTS4fVhjeC?=
 =?us-ascii?Q?eL12zcGjyLN7s25YhhJEwm43ia00BHASZ1nucae4fRvH3/mzd2WAKnSVoj2o?=
 =?us-ascii?Q?c/71y1uu9HlPC7X8N4XiYMt/OaXh1re+Mo27E0tInTaJJGHMwJYjMG46eLC4?=
 =?us-ascii?Q?3Il8l5iM9SCuBlv2zqDdGEKHGM40+K9NFy+tbHilrvJ8vG336Eti0jtNdU9H?=
 =?us-ascii?Q?vAUwWmpxI5p0Xp3u//KLsSM+4skijaggalaH31Ne?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae1ace3-3095-4379-c241-08db8b6786a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 10:28:15.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgiddO95dZqFU3AqyCWyJr5yY/SLh6b4TBxeBSdyBSDKjukPasExSXrt7A8xKWDozL1uPhUJZVIU5WzdTFtQLpZ2otglShQhavLSo9eIAoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

I will resend this patch. As there is a typo mistake.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Sunday, July 23, 2023 11:20 AM
> To: Peter Rosin <peda@axentia.se>; Jonathan Cameron <jic23@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH v3] iio: potentiometer: mcp4531: Use
> i2c_get_match_data()
>=20
> Replace device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() by making similar I2C and DT-based matching table.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added .name field to MCP4531_ID_TABLE macro
>  * Replaced MCP4531_ID_TABLE(name, cfg)->MCP4531_ID_TABLE(_name, cfg)
> v1->v2:
>  * Added similar similar I2C and DT-based matching table.
>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
>  * Dropped error check as all tables have data pointers.
>=20
> Note:
>  This patch is only compile tested.
> ---
>  drivers/iio/potentiometer/mcp4531.c | 139 ++++++++++++++--------------
>  1 file changed, 71 insertions(+), 68 deletions(-)
>=20
> diff --git a/drivers/iio/potentiometer/mcp4531.c
> b/drivers/iio/potentiometer/mcp4531.c
> index c513c00c8243..ed8c2c59d281 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -206,72 +206,77 @@ static const struct iio_info mcp4531_info =3D {
>  	.write_raw =3D mcp4531_write_raw,
>  };
>=20
> +#define MCP4531_ID_TABLE(_name, cfg) {				\
> +	.name =3D _name,						\
> +	.driver_data =3D (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> +}
> +
>  static const struct i2c_device_id mcp4531_id[] =3D {
> -	{ "mcp4531-502", MCP453x_502 },
> -	{ "mcp4531-103", MCP453x_103 },
> -	{ "mcp4531-503", MCP453x_503 },
> -	{ "mcp4531-104", MCP453x_104 },
> -	{ "mcp4532-502", MCP453x_502 },
> -	{ "mcp4532-103", MCP453x_103 },
> -	{ "mcp4532-503", MCP453x_503 },
> -	{ "mcp4532-104", MCP453x_104 },
> -	{ "mcp4541-502", MCP454x_502 },
> -	{ "mcp4541-103", MCP454x_103 },
> -	{ "mcp4541-503", MCP454x_503 },
> -	{ "mcp4541-104", MCP454x_104 },
> -	{ "mcp4542-502", MCP454x_502 },
> -	{ "mcp4542-103", MCP454x_103 },
> -	{ "mcp4542-503", MCP454x_503 },
> -	{ "mcp4542-104", MCP454x_104 },
> -	{ "mcp4551-502", MCP455x_502 },
> -	{ "mcp4551-103", MCP455x_103 },
> -	{ "mcp4551-503", MCP455x_503 },
> -	{ "mcp4551-104", MCP455x_104 },
> -	{ "mcp4552-502", MCP455x_502 },
> -	{ "mcp4552-103", MCP455x_103 },
> -	{ "mcp4552-503", MCP455x_503 },
> -	{ "mcp4552-104", MCP455x_104 },
> -	{ "mcp4561-502", MCP456x_502 },
> -	{ "mcp4561-103", MCP456x_103 },
> -	{ "mcp4561-503", MCP456x_503 },
> -	{ "mcp4561-104", MCP456x_104 },
> -	{ "mcp4562-502", MCP456x_502 },
> -	{ "mcp4562-103", MCP456x_103 },
> -	{ "mcp4562-503", MCP456x_503 },
> -	{ "mcp4562-104", MCP456x_104 },
> -	{ "mcp4631-502", MCP463x_502 },
> -	{ "mcp4631-103", MCP463x_103 },
> -	{ "mcp4631-503", MCP463x_503 },
> -	{ "mcp4631-104", MCP463x_104 },
> -	{ "mcp4632-502", MCP463x_502 },
> -	{ "mcp4632-103", MCP463x_103 },
> -	{ "mcp4632-503", MCP463x_503 },
> -	{ "mcp4632-104", MCP463x_104 },
> -	{ "mcp4641-502", MCP464x_502 },
> -	{ "mcp4641-103", MCP464x_103 },
> -	{ "mcp4641-503", MCP464x_503 },
> -	{ "mcp4641-104", MCP464x_104 },
> -	{ "mcp4642-502", MCP464x_502 },
> -	{ "mcp4642-103", MCP464x_103 },
> -	{ "mcp4642-503", MCP464x_503 },
> -	{ "mcp4642-104", MCP464x_104 },
> -	{ "mcp4651-502", MCP465x_502 },
> -	{ "mcp4651-103", MCP465x_103 },
> -	{ "mcp4651-503", MCP465x_503 },
> -	{ "mcp4651-104", MCP465x_104 },
> -	{ "mcp4652-502", MCP465x_502 },
> -	{ "mcp4652-103", MCP465x_103 },
> -	{ "mcp4652-503", MCP465x_503 },
> -	{ "mcp4652-104", MCP465x_104 },
> -	{ "mcp4661-502", MCP466x_502 },
> -	{ "mcp4661-103", MCP466x_103 },
> -	{ "mcp4661-503", MCP466x_503 },
> -	{ "mcp4661-104", MCP466x_104 },
> -	{ "mcp4662-502", MCP466x_502 },
> -	{ "mcp4662-103", MCP466x_103 },
> -	{ "mcp4662-503", MCP466x_503 },
> -	{ "mcp4662-104", MCP466x_104 },
> -	{}
> +	MCP4531_ID_TABLE("mcp4531-502", MCP453x_502),
> +	MCP4531_ID_TABLE("mcp4531-103", MCP453x_103),
> +	MCP4531_ID_TABLE("mcp4531-503", MCP453x_503),
> +	MCP4531_ID_TABLE("mcp4531-104", MCP453x_104),
> +	MCP4531_ID_TABLE("mcp4532-502", MCP453x_502),
> +	MCP4531_ID_TABLE("mcp4532-103", MCP453x_103),
> +	MCP4531_ID_TABLE("mcp4532-503", MCP453x_503),
> +	MCP4531_ID_TABLE("mcp4532-104", MCP453x_104),
> +	MCP4531_ID_TABLE("mcp4541-502", MCP454x_502),
> +	MCP4531_ID_TABLE("mcp4541-103", MCP454x_103),
> +	MCP4531_ID_TABLE("mcp4541-503", MCP454x_503),
> +	MCP4531_ID_TABLE("mcp4541-104", MCP454x_104),
> +	MCP4531_ID_TABLE("mcp4542-502", MCP454x_502),
> +	MCP4531_ID_TABLE("mcp4542-103", MCP454x_103),
> +	MCP4531_ID_TABLE("mcp4542-503", MCP454x_503),
> +	MCP4531_ID_TABLE("mcp4542-104", MCP454x_104),
> +	MCP4531_ID_TABLE("mcp4551-502", MCP455x_502),
> +	MCP4531_ID_TABLE("mcp4551-103", MCP455x_103),
> +	MCP4531_ID_TABLE("mcp4551-503", MCP455x_503),
> +	MCP4531_ID_TABLE("mcp4551-104", MCP455x_104),
> +	MCP4531_ID_TABLE("mcp4552-502", MCP455x_502),
> +	MCP4531_ID_TABLE("mcp4552-103", MCP455x_103),
> +	MCP4531_ID_TABLE("mcp4552-503", MCP455x_503),
> +	MCP4531_ID_TABLE("mcp4552-104", MCP455x_104),
> +	MCP4531_ID_TABLE("mcp4561-502", MCP456x_502),
> +	MCP4531_ID_TABLE("mcp4561-103", MCP456x_103),
> +	MCP4531_ID_TABLE("mcp4561-503", MCP456x_503),
> +	MCP4531_ID_TABLE("mcp4561-104", MCP456x_104),
> +	MCP4531_ID_TABLE("mcp4562-502", MCP456x_502),
> +	MCP4531_ID_TABLE("mcp4562-103", MCP456x_103),
> +	MCP4531_ID_TABLE("mcp4562-503", MCP456x_503),
> +	MCP4531_ID_TABLE("mcp4562-104", MCP456x_104),
> +	MCP4531_ID_TABLE("mcp4631-502", MCP463x_502),
> +	MCP4531_ID_TABLE("mcp4631-103", MCP463x_103),
> +	MCP4531_ID_TABLE("mcp4631-503", MCP463x_503),
> +	MCP4531_ID_TABLE("mcp4631-104", MCP463x_104),
> +	MCP4531_ID_TABLE("mcp4632-502", MCP463x_502),
> +	MCP4531_ID_TABLE("mcp4632-103", MCP463x_103),
> +	MCP4531_ID_TABLE("mcp4632-503", MCP463x_503),
> +	MCP4531_ID_TABLE("mcp4632-104", MCP463x_104),
> +	MCP4531_ID_TABLE("mcp4641-502", MCP464x_502),
> +	MCP4531_ID_TABLE("mcp4641-103", MCP464x_103),
> +	MCP4531_ID_TABLE("mcp4641-503", MCP464x_503),
> +	MCP4531_ID_TABLE("mcp4641-104", MCP464x_104),
> +	MCP4531_ID_TABLE("mcp4642-502", MCP464x_502),
> +	MCP4531_ID_TABLE("mcp4642-103", MCP464x_103),
> +	MCP4531_ID_TABLE("mcp4642-503", MCP464x_503),
> +	MCP4531_ID_TABLE("mcp4642-104", MCP464x_104),
> +	MCP4531_ID_TABLE("mcp4651-502", MCP465x_502),
> +	MCP4531_ID_TABLE("mcp4651-103", MCP465x_103),
> +	MCP4531_ID_TABLE("mcp4651-503", MCP465x_503),
> +	MCP4531_ID_TABLE("mcp4651-104", MCP465x_104),
> +	MCP4531_ID_TABLE("mcp4652-502", MCP465x_502),
> +	MCP4531_ID_TABLE("mcp4652-103", MCP465x_103),
> +	MCP4531_ID_TABLE("mcp4652-503", MCP465x_503),
> +	MCP4531_ID_TABLE("mcp4652-104", MCP465x_104),
> +	MCP4531_ID_TABLE("mcp4661-502", MCP466x_502),
> +	MCP4531_ID_TABLE("mcp4661-103", MCP466x_103),
> +	MCP4531_ID_TABLE("mcp4661-503", MCP466x_503),
> +	MCP4531_ID_TABLE("mcp4661-104", MCP466x_104),
> +	MCP4531_ID_TABLE("mcp4662-502", MCP466x_502),
> +	MCP4531_ID_TABLE("mcp4662-103", MCP466x_103),
> +	MCP4531_ID_TABLE("mcp4662-503", MCP466x_503),
> +	MCP4531_ID_TABLE("mcp4662-104", MCP466x_104),
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4531_id);
>=20
> @@ -368,9 +373,7 @@ static int mcp4531_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client =3D client;
>=20
> -	data->cfg =3D device_get_match_data(dev);
> -	if (!data->cfg)
> -		data->cfg =3D &mcp4531_cfg[i2c_match_id(mcp4531_id, client)-
> >driver_data];
> +	data->cfg =3D i2c_get_match_data(client);
>=20
>  	indio_dev->info =3D &mcp4531_info;
>  	indio_dev->channels =3D mcp4531_channels;
> --
> 2.25.1


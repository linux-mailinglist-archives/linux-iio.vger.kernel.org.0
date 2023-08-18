Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91383780E81
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377928AbjHRPBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377937AbjHRPB1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:01:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF733C3E;
        Fri, 18 Aug 2023 08:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7W3eJbtVCXumlpjZIQo3qXbNeC5bsZ/3jK8gPAq1a+f0OoPENpHcazaFzqUds85tmkPXFMLGd6gez0aK33a5VRE53biyP3dkAy4ylM1VJizpE5RDCTQ3LNWYjg+e65kM7kkL1zVDTmKu0+uGonS8vwl5jG8kmsFwqz4tEX4xU+okjP59Zm0SE2+e3eta16TFV36mk4ar0B/V4+c76Yfh+Oro818JIlRmODzm0BYNqHXxG8QIJeJ8j+gxQdRWVUp1XxQQNivXUfwFZWJysnP/OvDe2pQeFdCkAn7uwZhFWCN7qu5z1o4fQRYiYz9LdT3oJWMkcXSZehmvE2o3qv1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3Ll8rOppLj/E0LKForZgy3Nx6NnS83qtSDq0upU7so=;
 b=NTX2XERoFoWGLq2xcvR/a/2cYvrSLBFMtmJ3x76Sx5jg0nkN6bchWbzB8P04oOx75ipC955duj0iBnEpEUMdV1YEoxtEyVsXJ/cu8Au/JFFtDs1q+SCm28CdRLq1bIfxGJ7x7CahJqTdMWJVpFDlQp4+FYJl59gn8KTYax1GLT62ZRxUgdDkimHxAE8G70Ti9tE7rW+HtonVOhfUT/OJFtghlFvEf6+HW6klK8pD/Dihfr6EMkAbgeILBPbRzrBnmv4osI1nKbWQchT7zxdJJ2bkPVCUO76G9reJZiJFfMSgMgJR62G3Co6MViIOFI3hWh0tUxTRZUTppu8ViUGJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3Ll8rOppLj/E0LKForZgy3Nx6NnS83qtSDq0upU7so=;
 b=XTxd2fzw+SfTYbx0mzcBi3dRaucexQZcMRrSnOpXFjueTiU9KaBRt5SzPq/U1RkbQO1deMZsJJqnwU1dgSP730i6ANILmKwtqVyEnoyti0DDyp0IrvavJrtmQAL2RO0wvdXx4UJ63bAYCj4Ik/XDmNaYtt7Y4aUvPqWYgH2Cwsc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10631.jpnprd01.prod.outlook.com (2603:1096:400:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 15:01:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 15:01:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: pressure: ms5637: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: pressure: ms5637: Use i2c_get_match_data()
Thread-Index: AQHZzUfOauu6UXetAkKzDJyLaTSjjq/rdUsAgAS5d9A=
Date:   Fri, 18 Aug 2023 15:01:21 +0000
Message-ID: <OS0PR01MB592227AA1C7EFF4BCD660151861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812180700.246314-1-biju.das.jz@bp.renesas.com>
 <ZNuQ3s6u4ycNNIUf@smile.fi.intel.com>
In-Reply-To: <ZNuQ3s6u4ycNNIUf@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10631:EE_
x-ms-office365-filtering-correlation-id: 8856dab4-4e0a-4b61-c92c-08db9ffbfbf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymx2Y2ovhnoHS3+7ZQUDFYfnYGj6Ncgo3hf5wzhFMdG1gWM+gNoHQB9xo+stWsr7t6WwIOBFLtocx+SW6wEnnujGCwHpNYWq1fTzxoXTJBCNwFGV89CA6xlMs9fFAzuXpu6McuL5Les+FRc+2FPe24IAY4d/1p0YA2AXdu4ry3ok6Apfv+orhfpPOrc+KDbPGAlONh+OuSa09S/lsBBPqBJ1JxRmk25m566J71KmQRj8wlp0BjDvK6C5MfDXyxyC5MkkfP6hkTTkCVneQWo8zX+ArtVsDi+0WpLU4aPN4yCeAdvGoOrUjzkxwpkFPJP9qHAFAeBH7fU1u5woHulvfAkCmzmMjeUzl4K5IossnvGZUHI6uSxFp3kyWaq3ZDbjcvH9h+9r0rMQrR5ul/Jd7zZz0/WQ5+95abcgKpTUNYSrVd9XLzAOOF7pf2Awvo1QxOqlEnYCxefKKLcwf7uEW6y/JQfolHqUNZVMKWXVipclEzgTr7ZjZoehaMSg/eTbAaaRrYxHKoWhsTIWiYxjKOsAZ4XzRio8u7j6uLK31iipS3++IryXt5bq4Drys7ICf1lcry3UiNaVzqjtqHVyK2QDFVd66ljVuKDzpgHQZGSPUoIKTlY5bYipJG+HAfkk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(7696005)(38070700005)(38100700002)(9686003)(122000001)(86362001)(55016003)(26005)(83380400001)(33656002)(2906002)(54906003)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(6916009)(4744005)(41300700001)(76116006)(5660300002)(52536014)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jqkhonpRqjQ1ACZ3SVkrZZnrMjWPgD5LilL0PDIbGkf4DKx+XuHjvGW77n?=
 =?iso-8859-1?Q?opFGyrvOz5I6M1wKUC5kU515aQVBDnbDIqGR41Rqq7h/ogHsB7n/1mK+Tq?=
 =?iso-8859-1?Q?0h3sJuA5X6NwGfEFZNgMouhl9Az0W+PsqhkIIinWw6soqgcH85s8ql3RxX?=
 =?iso-8859-1?Q?HUqGiqvHekSWPU2+4xmyBKwgUniekSYQwVfyzzuDw6djiX/ISfMjPRpFeG?=
 =?iso-8859-1?Q?Robhqj+wTKHmre7qfeT/vU27nf8fVrsgbs6EyUwTT9+1QPyq2mmVCJx0ij?=
 =?iso-8859-1?Q?JqrckSEVFDjcwfioSTlqJAhSwnkpYlA4JlT39hD4UjYsXhy7jZlKyvCUXn?=
 =?iso-8859-1?Q?GZz+eTLkRJYV7K0JMkbLNogkWDITnSSJ1MK+8y86qzxvuYaqKBVCiMir29?=
 =?iso-8859-1?Q?7MV4MCXX/FdjSJneHco8Pbrdua0sdCTpVdfL1yTqdQCLZiaWcVZUBGs03R?=
 =?iso-8859-1?Q?fuZsWJeitfn7ysGBxB+Wj1yvo0wcB1Kkh6Wdxit2w9NKtDGV3Fh6i6ZVvE?=
 =?iso-8859-1?Q?cL+0WG7hJ9YDZzokzN05X6h3VO1Sxoe8OxgT2MohpuatmcYb1tbgpPUB4r?=
 =?iso-8859-1?Q?pisEhUcoItixxsyf8ERTi1TSl3rBrOeEf61pIouoswd+kMV7TujK76Okiw?=
 =?iso-8859-1?Q?yhFB0qjstLwp9h/vRmNFW1UsFWfWwMvhgp++XulW9jB0fiXTBSz0Iankiq?=
 =?iso-8859-1?Q?uLrCV3TYCzarQJe2Cemu5+Ii1d5gzU+Ydy5GCfNBvndTz+T7BQHafQ9UAN?=
 =?iso-8859-1?Q?5Twvp3Aq5NGSC8G8oE4FzweK78f5YMVUPNQxdeQlq4tfkmc/qhjCaB4foV?=
 =?iso-8859-1?Q?tP2kNbxbMeY/6k64A2yWm4Xysl0wDGk5Q0Ez7DnE2HR44XqWy1eIftCJ6l?=
 =?iso-8859-1?Q?ItnXczlsSLF73XDUndC/FYNdx9+kXN8nfNiyZWsfKXa1jzt3LIDYgDeKeN?=
 =?iso-8859-1?Q?Z4MNFGfADKCIESFotHPOwQBkZIBYTrZTl4f+5H131z4y6fTChJUrwL8DOG?=
 =?iso-8859-1?Q?Qhd3k5nQWfw7X59qSchm+FFBrBgUmJyfjn5nLt0KtA1fMxsGnLm6xin0Bw?=
 =?iso-8859-1?Q?NN9lHXAnw3CCCXNsjIAyIAL49eFBBeaRmO+trrOkKgC+ru1CdOXOM0AxvZ?=
 =?iso-8859-1?Q?0MSQsFCi2oX/tO2u5QJ3tEzfMkCk0b8vGxvRuWK9mE22HUtUYmbOpy4kiT?=
 =?iso-8859-1?Q?JoyybRiAIVhWqT9NeVaqck6fRJL/kxjwWpfpfR6VN+0lmstg5jWjhzP0To?=
 =?iso-8859-1?Q?OkiBoPnI3wKHjg3ShGMGF8RsHy10MyCj0duoyR6FRwq1GtG2dUNApaDfW6?=
 =?iso-8859-1?Q?KGgd9k668obyQDymw8zX7UIoni6ufmTAXvebclfjPW/t41KPDUImXx7WAS?=
 =?iso-8859-1?Q?dQ9o9USkDJrnty2NY1tLMALHChQwB1uUmBWMsoaZZCA2Ow0cP5Oz41B1/S?=
 =?iso-8859-1?Q?HpgXZ7D3h3DIvQzIoQFYzbk9BGzkGPn4Czhe33GSNyX5MaYmwpSO9V9N1G?=
 =?iso-8859-1?Q?ZxGnSyBgLcrCCslV5uZ0RW7b7ZVd/1crvxjB8D3UzliB4/65eKIQ03qo+M?=
 =?iso-8859-1?Q?wtQRSbhr8b+YM7zmFX4PWbK33ZTI7IXaphDbhXRcjRviaM6aLFD/4+OqOk?=
 =?iso-8859-1?Q?F14GSbKdCWG2CgDGA+pMAhRTdYx5UJMmuT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8856dab4-4e0a-4b61-c92c-08db9ffbfbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 15:01:21.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpJr+bqkb9kBHuIu0z0zyRZi+Wa/Czm8QG6ZXqfsxUwNUS3kDjUBSXcQm7okXNlYqqXMIWKRgda3N5m2K9zlpzItvQb8Crqz9Nn7fWJEU1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH] iio: pressure: ms5637: Use i2c_get_match_data()
>=20
> On Sat, Aug 12, 2023 at 07:07:00PM +0100, Biju Das wrote:
> > Replace device_get_match_data() and id lookup for retrieving match
> > data by i2c_get_match_data().
> >
> > While at it, drop ununsed variable id from probe().
>=20
> With commit message fixed,

Agreed.

Cheers,
Biju

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


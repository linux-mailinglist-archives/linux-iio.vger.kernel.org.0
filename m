Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A218677C827
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjHOGyn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjHOGy3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 02:54:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD0E45;
        Mon, 14 Aug 2023 23:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0sBK3mqj9WZBrNltBK+tCnM19DuTxJxkKh7kwD1BZy9l5xjt3gnHvtvaxqHGe8qUqFSRl1Parge9uJ7BeS+68GzhRYcOInD4mtcZMk6rBnFg4kGE67SYYnPxs4VkJd6zzuXgvx2yiUD2O7yQmp6iNDTkn7FV+svz/8Qkh4zsaoDJdSwfKIEYy/gQpi1GQCzEXzIxHJ6xAehZlmpmKJ75TbXhsUNUF9vFExzpKGlXN4E/Mtsq47Miodz39PJsevLW5+N9e0W/yKbAIAWv5gEfaLMPd7WTed/GcftacqjJsCOhPZ0auVChrkRrQLebDFPMr9PlnbuFxlGgidKSfIGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VA3cE+T2FqYTY26jc8BkoWF+XkEtnCith7ESa9boN8=;
 b=eOY1xEd1U+lyAvS05OaEh+W0l96ZIxb0nmhDqNT/1j2wLFcG3GwDh5RDwEBxfZO0upZ44Th8eYoC6+i6o7f+RdYg0fb4A1hWTuBBZ09wzJPImG2mzaYar9Ln9kXtS9fYbcA8TdL8Oi47AzK8H0sT9EAasTVKFMSmWm3StgtmQ2pDWduPTY2X/R7dfrzr9LLACLztxXRPfUMkFwjFhijZ5Q2HTicDTw/c45wrWw1Nyoqu+OZZSln+So+JACfCPQbs4Wiawgo6/pOakNlD1z4woeX/AIfzDvbEzlaDoz4Xj3MB3u5h+NCNd2QD3rI2ZHRF0BL1a8XnkA9vnir8atI1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VA3cE+T2FqYTY26jc8BkoWF+XkEtnCith7ESa9boN8=;
 b=wcIVfCxT/wzqQTgarQ9W0R9RoGDRG0zrC7kMeh20k7Y2UV8Ceex4vp1lbyz/buFlzJj7GZb3dl4kxN4ooCKhj3LZtAFKJcVCkPA+/clpSDmDuMiNmS+ZpnC7KSBNuihx4AygLFGzie3PUFjgl8lZ8Xksl4qZIFo6h/AZBQpSkhE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8507.jpnprd01.prod.outlook.com (2603:1096:604:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:54:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:54:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: accel: mma8452: Convert enum->pointer for data in
 the ID table
Thread-Topic: [PATCH] iio: accel: mma8452: Convert enum->pointer for data in
 the ID table
Thread-Index: AQHZzSmiSMxIN5JGCkyA/LCQIRZdyK/q7iUAgAAB+tA=
Date:   Tue, 15 Aug 2023 06:54:24 +0000
Message-ID: <OS0PR01MB59228696ED2EA189B7D170F88614A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812143100.159700-1-biju.das.jz@bp.renesas.com>
 <ZNsfTH3l27oJIT+W@smile.fi.intel.com>
In-Reply-To: <ZNsfTH3l27oJIT+W@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8507:EE_
x-ms-office365-filtering-correlation-id: 1f8906ab-f4dd-4f13-d7a9-08db9d5c7631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+lktFAw3Y0els4aobca4lBbm8MQkfrRsjotIneUYPiC+HE/wJdGwmIvnl5Pw2xEb6iqh7UE0/Ef3I5iB0nnFsmNDdG5DvcAqC/Olk8O32hwZsXy4YkSrpg58hhcD7VEAUIxxu9TYfyAlyqxfyWtRY8Q6FZGKsfE3qTVbxAsuPThPevQzuYa5GDkQbcyJtxMbbzoTL3pv7qRJ1fE0302r1ZknkaXRrLePDk/VNpF3yOlk+fY9FO6c9oCwpuE1lJ+svodnsGi5WJBZhujyhOUGM4GAWsN2AeYlqhIBdH7vEaJMWduiaRB8v+bYy55m3yIzgWnDmweVz7WDDuFOID/yq4D5Us6mqvYsvlknUwEEM7lGnhxHp3kMZMy7kRH/XHUAG5bQONidal3BH38RAF/ZBpN5A2ksjgRQ1Omj71Vm6bI3ZRaJozSYK1ueGSfKSoWykmK3yJ13DB4c+n/SFlD9tejMzEXDTnYGzb4X64/oU1UHtz43KK77YNguI8wm8dGEKqyA7YoD8VVl3nd0kXtQuamnNnfYNwR8E5sEUarfHAfk3dyvdH9NQQu/LoRP4Qef+2EiRK2htpFU0ewEMuiMdi2Rb2YmAirfUWi544Nu6kArZBhmDMzlsTs4byj0hp1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(1800799006)(186006)(2906002)(6506007)(26005)(55016003)(38100700002)(478600001)(38070700005)(41300700001)(52536014)(5660300002)(7696005)(8936002)(8676002)(71200400001)(33656002)(54906003)(86362001)(316002)(9686003)(66946007)(66446008)(66556008)(66476007)(64756008)(76116006)(4326008)(6916009)(122000001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4O1yA9I9cy4tEbtKyjyzXNWfusbFNW6D4wYAktWGT3nclmJd6FdfamKslX?=
 =?iso-8859-1?Q?MTqW1/8HZawhKx+K1xuCKpzeUEMccnZFAX/BXQvh5VJbOP93wVJGiNVyzz?=
 =?iso-8859-1?Q?OCzlc1s0zx3Htx/fjWneCS2JKgvalmKRwFx39s/fC4ZNm7XEN9HFxCjyDD?=
 =?iso-8859-1?Q?KvAFAbZdEWT+z9h79B/7pZis3ayHD/gpfg+3O2ZDdZZz6YdEcYkYBRz3Wr?=
 =?iso-8859-1?Q?UcjvJx3xXQaCfeyPsDewmPOmDkTvOWtc3W0DQ+HLssPSKTKLelzOL9PK5X?=
 =?iso-8859-1?Q?zXDUDMt0CCfLAR0QWmV7VBvjmR/Ve/WKUTOQo+6qTptG16RlMN+/UzWdRI?=
 =?iso-8859-1?Q?jvH9+dduDD0z9EaR0ShJ+krLHN8m6KYyOZBsvslsS3ymOkho4xwhJa2gDa?=
 =?iso-8859-1?Q?FD5GQkkR5bVn8ZOumy5CxyIyLKOOkFYFSYb/z461D90VSHylSy6crNGsrD?=
 =?iso-8859-1?Q?65yyUx5JygnRefJ6sI7wpIaxvFycwzEcg/NQD63KKD8ZRgo9ziRGrxD1fx?=
 =?iso-8859-1?Q?ob5+FLA+UIlk+nSRAWKmU7nXwN2m1Q2qDtQ4AkdMkD36JhhoahertjKtsz?=
 =?iso-8859-1?Q?emXldznecmok2zYRsPpMUj+8N/TWXquNBheipPwC57Dh45Gp6rM0yAGkPz?=
 =?iso-8859-1?Q?iOlHZTOVHvJ6VwNdJTp6oC0jDqX+O2b7XOkrfTFgtmKZP30QrBH8Km3GIE?=
 =?iso-8859-1?Q?SZ9Nv29M2HopEXaCRmFqe+gCoF/X1Vug3/xjHuXSfyiCSifE4FwYOH1AT8?=
 =?iso-8859-1?Q?R4NzLljJE0n98dmJC5yZt0qL0/mtaC4f4Px44iZu+picD5WbqLRnpAImXy?=
 =?iso-8859-1?Q?8XOfTmIxMHyxMni8moRf0kMBOGsJGJsxcaIGQb20wn8aVrpOL9vzkwVwSf?=
 =?iso-8859-1?Q?H1Ck+x2GiDb16ZXRG1vbPxKSCKUr7e2USzDgx6bdmlib4qNA5zk5gHwbbv?=
 =?iso-8859-1?Q?xKbp2wlLNydd9ghCqGp7Xi9m/pAYfrHjeH+ssCmqh+QwNEIZWonfHtwKzQ?=
 =?iso-8859-1?Q?ySzFK38rOi3XjawxhBb4asYCr6PI9SVnte870If4zLkKu59XW9STyoJp18?=
 =?iso-8859-1?Q?Efm7jMXvLXzZ6jLYY+tbCed5R7I4PT/vu0wuA0waPehmDqkP0FlJl2QmpS?=
 =?iso-8859-1?Q?maOQWRXiV6rrrNu2xv3LbaANISjppvWnHxOuBNwWkoQ+i/FT+oaWLno8Fj?=
 =?iso-8859-1?Q?I9HVn49qaCs1Nj+nNA8tqGChdYsvekIRKNMSmGP4iZ/+bSBdtyD7/TNBLH?=
 =?iso-8859-1?Q?9JWKyWIu3291eR8To1Us/2o91zE81mlDxQjsZPTujIC7Bjwie9xcRCxMX3?=
 =?iso-8859-1?Q?pTDIOgWyqf3u4LooK65qxWKj3X4tCBnlJQkBOd6/rIxNCVLJIxFP2fDeUS?=
 =?iso-8859-1?Q?sGQ7ApiikZX9ReM7UpOo7p7IGVIGeT/ffs2OEWkVWp9736bJcPQl+UvGvB?=
 =?iso-8859-1?Q?Z+k1OqiG/kLNzTHyvavRzBcJz7jRZsGJaMs/LupCbF8TbEKeiHWSBET8vH?=
 =?iso-8859-1?Q?N6lsue415sfKJHpi0aE4s3doMApFgqHETtcZEowYvRpIC5ZKMH17jhynF8?=
 =?iso-8859-1?Q?icFKskINbgOuPRklrGDdtZzBjSrCsdYStaNKV8d3Bgbil3l5s6x7gbtSmG?=
 =?iso-8859-1?Q?ybDTa/0HjqAmNsk9uBX58dkTH3FXYNb7D4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8906ab-f4dd-4f13-d7a9-08db9d5c7631
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 06:54:24.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ppSyZ15f/0thL4xmO7HXNzjYTKpwdsaUAEbht8lQoc/uof/QCMxweprvm/y+J6pRpjtZTdCO/1PkCKiKoAnktnn1lJ3x+vJ7HXaOC1VPFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8507
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

Thanks for the feedback.

> Subject: Re: [PATCH] iio: accel: mma8452: Convert enum->pointer for data
> in the ID table
>=20
> On Sat, Aug 12, 2023 at 03:31:00PM +0100, Biju Das wrote:
> > Convert enum->pointer for data in the ID table, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > i2c bus type match support added to it.
> >
> > Replace enum->struct *mma_chip_info for data in the ID table and
> > simplify
> > mma8452_probe() by replacing device_get_match_data() with
> > i2c_get_match_data().
>=20
> ...
>=20
> >  static const struct i2c_device_id mma8452_id[] =3D {
> > -	{ "mma8451", mma8451 },
> > -	{ "mma8452", mma8452 },
> > -	{ "mma8453", mma8453 },
> > -	{ "mma8652", mma8652 },
> > -	{ "mma8653", mma8653 },
> > -	{ "fxls8471", fxls8471 },
> > +	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
> > +	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
> > +	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
> > +	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
> > +	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
> > +	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
>=20
> You can also keep it sorted by name.

OK will sort by name.

Cheers,
Biju

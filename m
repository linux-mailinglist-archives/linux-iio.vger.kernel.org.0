Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D279780E72
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377926AbjHRPAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjHRO76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 10:59:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133A3C3D;
        Fri, 18 Aug 2023 07:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+UBCmsPfCzYeaT2uPREEmF7nim5pqhOJ1e2daI/6cDZuBvlEJ1Tii32NDinDLqFeoC/kW4ewDqXFFJFDwjVM6+UUP2p0puccZMdXNvC06UFjwPCj0wpWf7Iuzo0rCL2gAWSKWF4bUnj+sX0+zQKN6t47GvneSYLWPw2X/adY2Fi2YF2MuWx+h2i3T9mjK2Pt5lQX4dzSRbIl8ARpSh8/JDhgi4xexi++79TscDhwC+C7yzJo+UwbPJ62decmFhO4bgeWEebebL7lKMtO69hdXTZTNkogP6GUvmpEAaEKwz2zKqwi41RBYhIqQmUPfnQjT/C3RqUbjKYOTizA6A46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY/s5lSc6r4Af2fWKgM7/DZlR1b2XzwKfP+o6+WEnbQ=;
 b=hfvYknndfHYfGBFnV+RTfNN35Ua4Ksl2vKgOKqrKIMAJvzfnlvl/naJjBnPfwxG/DrAOglrVG5st5NYkLIgzC+Uf9IlvVJ9oOsLpsT7JYVoqMhG0yWFxsgMIv3+bm0MbTlT/4nvBZLfoO0zVBcQqViOTcEvKeY6KLAKvvHOpWssvmgiezFOygYTOmrVYwiaIzvw+rvb/lJdMn5UPk9jCvBBbGdOqpz8ve/ja/VtcdHnzu+nUJWAyEK0gYayOJ7pjFuevQrud2JoKPms3wDliSpuGD+sud2lwqHqVZOvUjyPSzzaM2gpMwrh9WqEqrxZ2jcN9V4rd8v8K1UYfmPAVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY/s5lSc6r4Af2fWKgM7/DZlR1b2XzwKfP+o6+WEnbQ=;
 b=DPxvQOWZ8NHLMlsH+9x7aK4YlbFtQlarkSOV/c9wEvMNbbA7RcOdUG27sY3yEoGXk6YT0QljA5jKDikHn7smtXnIVjKGdzE7UT5C9UgImRRXbsV9TgU5Bp+/ppbMVPKBz9Y0SxDpd91KbLB5Lnq9+luPIGtX+6xXS5xS6gE0PYs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB11118.jpnprd01.prod.outlook.com (2603:1096:400:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 14:59:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 14:59:54 +0000
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
Subject: RE: [PATCH] iio: chemical: vz89x: Convert enum->pointer for data in
 the match tables
Thread-Topic: [PATCH] iio: chemical: vz89x: Convert enum->pointer for data in
 the match tables
Thread-Index: AQHZzUJEjnNWe6FuE0Cja8wly3A62q/rdSQAgAS5emA=
Date:   Fri, 18 Aug 2023 14:59:54 +0000
Message-ID: <OS0PR01MB59229F03F97773EF5736FF66861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812172718.232718-1-biju.das.jz@bp.renesas.com>
 <ZNuQtIMqbK/74kvI@smile.fi.intel.com>
In-Reply-To: <ZNuQtIMqbK/74kvI@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB11118:EE_
x-ms-office365-filtering-correlation-id: ed89218d-f53c-4365-c8be-08db9ffbc809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xozRnJICNswPSV7eTYlurMLOzGo6MihFB1OOSF7BVHTn46o3AmqnZfnqm1Xl07DAgJPzRw1I2C1SRaJVu/6q1r85CzAatlKr9PjkG0dEjnLUwinsliGn9BaS1bA+eoTzxZ5V+l6p/ES0r8d3e2xZSyZ1+3Z32QpXmlP+is2cE1OE4JJGCFIIreCEQD5RXXYGguHZrOeOWv9wiWQp+iFh+xgcEw1SYn+9EJq5FGxwKlLPZmBSXxdCn9CURCk1Ykmb/FEz4VpztboFl64j4PtBUw36YY2NBrAmdc21ridxFEiJtKUiQOBatbdU7ES9RVuSArMKak+N+1tSajbewKO+SpmQ0PX0VxwMVADddR/jb3LB7AXlB+xZIHDhAyv59MRMtgKdETBX5MZ4G3xDlDJfA14a6r1gighv6dwsH/7y5Hz/3f/6Mc9IuBbROPdXWtivyLjdgLVBCcydj06NDl3QXwx0GIRr8Wt5QQ49f6FZMsvGQ37VDhqMX7b9ZaHD3W3Q66+cUXsn/KLpmAfdbzxnKjb2uYKV+KgWMFMRmT1lehtKZN0gpWN/ojx/NjBlKE5g+8e+srHwTxdu4tK8B/gE+7SSMox2yE8hLpzjQap8tk3p7mTdoR0el426Tn6ns2Pu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(71200400001)(26005)(6506007)(7696005)(9686003)(83380400001)(4326008)(5660300002)(8936002)(8676002)(52536014)(2906002)(4744005)(478600001)(41300700001)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(38100700002)(38070700005)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LTrU8RUGs5UGzcZuomrwAZQKxOnPEMV9rYBJw7MceBN6FmZ7OJ3iSqmBh4?=
 =?iso-8859-1?Q?WRLLBq9GIwhDVWOfjoe8nGCim2CTy3iu6vzQm9uMzE8WKYvUSrEv9Qo47m?=
 =?iso-8859-1?Q?WyXPd5E+0MiJt3hAQiMBzB41a4SuqXhP4EIXBx3x3bTbEMGuyuaowh8YIi?=
 =?iso-8859-1?Q?L93OJLFizzUj2c7G4PZ/uNqJilAIlFIYAyEwiSIiDc4Hr1ApEsTKhXrkvd?=
 =?iso-8859-1?Q?NyR7gicmw3riNgxOzZnf0D75GbUagdJ2qxINKUJOcBn74cxQEkfsTV3BsK?=
 =?iso-8859-1?Q?z+yDEAdqpnFD/1mCR3ueoo0gGtWLieELjWIgF2addtmIgnEOtx7iFkBhaL?=
 =?iso-8859-1?Q?8MPc1h+h6q9Q4cyAhMagnbtQlBvKFskybkZCw5E8NAHn1q6LdXCQSqRbog?=
 =?iso-8859-1?Q?x2xpeX66YIvNl48J2c8vmekKiOrCwN+J7cJBHl64Yn+hnU5OXroHRve1hV?=
 =?iso-8859-1?Q?JZu2N/JSmcUdN5+nC9+kskZm3ZroxtGPEhKnfKxu8QOD6T71zlvlEFXLfR?=
 =?iso-8859-1?Q?aDlPgIB0f5h5MpSMRKdvdb1kUtb7IKeP0rFviyHJ+r4Q5Dw80yJeZLd6s3?=
 =?iso-8859-1?Q?p9ujAE5cchGDnePf1We11rF5nrBPPkGQmQw67MW50+ymLyRZH2LvKcgwRD?=
 =?iso-8859-1?Q?UZNl9WgrY11CH2ir5trlzmv343TL2BC5E3bshplRzqu7rR5ps0dWZYq8XZ?=
 =?iso-8859-1?Q?yGqAKZKDTQYWYZR9eYBundjurLW3rh7m5QKHYdxfOrGnRukn0+8l+r/a2I?=
 =?iso-8859-1?Q?52+R8/wjxrUlG+1pFKbPmCSf2G9iWYfaXa+MSOvz0co+3iMkLXK1ADFuo1?=
 =?iso-8859-1?Q?zAEL3Z4b0VeUvouq9iCDAkCqzdlRcboAf7kPh76Bnl/T2INWTLUFDFW6J/?=
 =?iso-8859-1?Q?BsFsL59k0FNLjiA1+CKsmI2eyFSjGhcWC8+Nq5l1lymqx5U+GTV/PjSyDr?=
 =?iso-8859-1?Q?t/oWB05ParEw5u6Fi5po8MYFsDSwN9dKZYNBvhaiwH39tDgLUA+5OvrQ5N?=
 =?iso-8859-1?Q?H5OOl5jgptgMtTCuzUp2hMbsvJ/MwGC13RYL73L3V6Yr9mewoKgjE3hYcN?=
 =?iso-8859-1?Q?XttH9+plksXa+ymRAB82DNpqZqd6inP/cXr7yDgMOEAWAK4PCaNC572BRf?=
 =?iso-8859-1?Q?/AGk6sEGC3mFqm3nK3gM1K5KrNvLYNbwBHRLauH8rvNaKmBQplGs3oMESk?=
 =?iso-8859-1?Q?a+XP2UwiYPnocHoJei35yqKog4qD60fbbSnJQNNrrYlapxgZ27gpaf8Qwa?=
 =?iso-8859-1?Q?4W3BbibFfeFirzyfMz5QFjemjAZFRl0VHfgKXNN+t5jGAPTZTk4bq5XHu0?=
 =?iso-8859-1?Q?0yUBJWl/V/OsPQcluRnB5pE7r46eRvhgS9AfNo2tjh1yUs0Pc8XXbXYort?=
 =?iso-8859-1?Q?hkEj2zykDhowunM3na5paK/DZUCPgAxvLnyVKFbqwJu/ZqWoaiZASB5BG/?=
 =?iso-8859-1?Q?9CwYeDX1xWqIELN+geq7FbEk4H0AF5i4pAdXDUjtg01/+sMkohF/XfMX0z?=
 =?iso-8859-1?Q?AgZOnyFGF/Up3xhTL9GrtMCYKsRbKVDr09GMctVTVUUizFSWz6u+0TuNwl?=
 =?iso-8859-1?Q?zmy0uQ1KFFH3mm0C1cDQLpZJC9P2l7DlDlMTT43ygq4cOGbbgxng9qZ++q?=
 =?iso-8859-1?Q?PninnaYJb7wW8+CeCB78X1TP3+M3xg8iA7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed89218d-f53c-4365-c8be-08db9ffbc809
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:59:54.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EVRAEsjZd1ke0abg1vq9e6/r8Luu0qQxW0clZoNt7t47DiuX7WWW3f8PmmDoftl7OW/DQUaKOl5ModuRjfjvxexwQZIbU7Gzahjxk29Jw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11118
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

> Subject: Re: [PATCH] iio: chemical: vz89x: Convert enum->pointer for data
> in the match tables
>=20
> On Sat, Aug 12, 2023 at 06:27:18PM +0100, Biju Das wrote:
> > Convert enum->pointer for data in the match tables, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > i2c bus type match support added to it.
> >
> > Replace enum->struct *vz89x_chip_data for data in the match table.
> > Simplify the probe() by replacing device_get_match_data() and ID
> > lookup for retrieving data by i2c_get_match_data().
>=20
> > While at it, drop unused variables id and chip_id from probe().
>=20
> So, I'm not going to repeat, you have to fix this in all commit messages
> like this.

Agreed.

Cheers,
Biju

>=20
> Otherwise,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


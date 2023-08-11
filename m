Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C177888B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHKHuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHKHuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 03:50:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7AF2132;
        Fri, 11 Aug 2023 00:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdVMxDJfc1d78NqFTzHgWDDSA3VdZdJ3+nxv7v2wiuS707ZQoFj5W6k8l8PhO1O/p6IPRH7qu1j+3ndZ5YsKyiC6qjiQnwg1cLGm/z7SxGjpaCG2x2SdOaATnoNpq5eBm1vLIqvVXJ1J1EShpLBcKpUJ+8zUWMdSRKSVeudE2OEJpCo6FdTo0E8OKmVo7EKzJT9mm1vZu2NQ2Yy3J0b//zv3dXK0DJNCwp1ba9SYz2WDK2VNoPjIaU8Ou3jWp79OvvvUHcMivr3wnoNJaHzRNR0Qn7KzGlw/tolDJQxGy4xDDC2aTeNmt1EIiisYLwVrpi3xZMzBl9TsVeZXs47PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOhebH5u6tgvjo+45ng2vlx34y2gLM/tKeyA3cZ3hLs=;
 b=le0J/vYfgA7SD+t5H2NyHMOGLnD3SEz+pbaKIq7IqocS6TUS19+dyHyBMm3r0T46MYYAPSZrL/2fwQHCWQNd4tfxWxA+CDjYQ8CV3KtIibx3KNF0AkXt64HvepOU8cCdOWVcvhTo5E2U2BO6Tco8lAwu9gZXj/Ni8FWaKFzRdF15mKqpYhpZaxLP1H+tis+nfZ3MmsVTq6BuCt8Tk3KuqU+4MgTDS4EkH7JV2746GWG9ywfpWbXDNr/xQhmM4Td8Ns5AN7VGxU+shOmHkrFj8nKhRBEAj8z/J8fn5TthE6u8wO7L1jw8LxIPlelGltzf5Wu3Vwep22pe5zlTWQc6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOhebH5u6tgvjo+45ng2vlx34y2gLM/tKeyA3cZ3hLs=;
 b=ItGk6Mp3IVw6dTQqxcPYc6S7e02w5vGOdgqdAK7X9BoozqxpaqacJuU+whU3yXQOTw8qUrZWVRA6+eUy95G2Qps+fWE2CQCoxzM/hqWYb8u5MmYTl98dd7mXqS2cyS3AFcfk5PtcGDsImIGOvTsHaTVErnqDecWAKFT/MahZzzg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10104.jpnprd01.prod.outlook.com (2603:1096:604:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 07:49:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9%6]) with mapi id 15.20.6652.031; Fri, 11 Aug 2023
 07:49:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] iio: magnetometer: yamaha-yas530: Use
 i2c_get_match_data()
Thread-Topic: [PATCH 1/2] iio: magnetometer: yamaha-yas530: Use
 i2c_get_match_data()
Thread-Index: AQHZyVQ7wrEYDqJ6BEm2vl/9vvalIK/gXxCAgAReo8A=
Date:   Fri, 11 Aug 2023 07:49:49 +0000
Message-ID: <OS0PR01MB592251D2760884E3DCEF2EC08610A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
 <ZNI9WyNM7CZlw/ik@smile.fi.intel.com>
In-Reply-To: <ZNI9WyNM7CZlw/ik@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10104:EE_
x-ms-office365-filtering-correlation-id: 4f8612c7-7be4-4084-7848-08db9a3f8a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SG5ROa+Ro3HZ6psvn4PDyd/h0GvZkTYckwERCYXwdzasCLldy91s774ccFtPa9rKNEFn8eOztLCIGt4gOTTOwxMp3jqe15kEnuDXs7AcrVTzA+siVu7E+fwz7aSLUR6UIT/n5Ev77BLe7pduVCS6yiBtpPLuszzzPvieYYbtcbkpDrznJkSQ/3mDKwXXGG9Ct7KKcpH8L/HbpUI5zKr+t3ry21D3Cok7nkZsKhSBjRp02YTAzUCQ6ltZtYozQaKoS328nOOzs5JHs+i1U6+Vo3rMbcdTxzChndKtgTRgcqEfCFt3ILuuy0sizDT64JpVjSkBiC3FbbBBjT+6h7xH2jEbyiGbgYk1itYISDOqpF6Yw8Rp74aRbnkJ59uV+6M2nokHrqTdIOxlyBJgsg0lLnrQBzuRUTzNGGhABiye/t26AFjiMwLjsepdnAM6Ze8LbNmmTH519ll022l6l39c8HzWUCixsTgX1qc7HFJz98qbAK0mMUg4S8DZOPEbtL8FnG47IBnzy/M6YWnrMhO8HR1e59boh/xID2w97wt0tnbyJz4KJ6dODCUtbI/7MKjJodbkvQ1ZToJYWmbzuZg0ZakWvnTZbAuLBUbv5HUeFjo26B0Fad9KO0GGXwceSqZ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(1800799006)(186006)(451199021)(9686003)(55016003)(26005)(6506007)(54906003)(38100700002)(2906002)(52536014)(38070700005)(5660300002)(7416002)(86362001)(4326008)(4744005)(6916009)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(33656002)(8936002)(8676002)(41300700001)(71200400001)(316002)(7696005)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oFDQZFp2nA928dg9GrjXBUM6Lc56Lt4sTrIXvqCMWZ7I6VvpF4nDMNjnVl?=
 =?iso-8859-1?Q?MhKA6CDCHsKsSkS5JIEIBqrMPkmBMLh+AdsJ2XbZPfnmP98m6yzPqi8bgL?=
 =?iso-8859-1?Q?89vzOTN9429LsfpcYU1fNiw/glLBml0pojZhhCfuP9K0c+RwWBYwVGQ2wL?=
 =?iso-8859-1?Q?x2PB5K5+GoCQ+5XM4E+9gSN1plFQ3r0lZGX1QWd+dNZoocCCRT9bJmZRAR?=
 =?iso-8859-1?Q?w3YIVkvha7zaKjJCfTim0iXBq81VgpJq2I5i28sSEQUcu0YhQDpHtzny+K?=
 =?iso-8859-1?Q?fcqypdmQxWjZxH4uVZuCsDaTartk4BCqiEsiX1E8X8w/MfgcOWaRYcfrHB?=
 =?iso-8859-1?Q?F+nBmuSf/nzW99RSE7RrN1ruBC30NpOCPATZjKsCyK4hE9cy9JwV/qAX6o?=
 =?iso-8859-1?Q?DgoUXN0PjzcDI++NnhIne3mkhcincYWfKD45UHqqvojqm6oTuVKcZhCzpZ?=
 =?iso-8859-1?Q?Tv/nm6Yshm7OdER5GQSNc8oR8a0sRwpMIN9k3Bc5GUqjzn0G/scc/eXymS?=
 =?iso-8859-1?Q?kHxXEs9t0QHmgQ/nCfsi/+NCnOo2w6AeTwsPIUjmAm1sjpQ2xEDQtM5Dcg?=
 =?iso-8859-1?Q?EYeujJAf8PEmYqUHrlJNF/Iluc8rEQYMImLRKmo0lM7saLqzmIaNcl/NDz?=
 =?iso-8859-1?Q?DmR2yDuoBCN7IQF2nOHx/oP2/TCy1K1ojlj3OT3QSoufJ2Gw9BBW01bl07?=
 =?iso-8859-1?Q?JwqMdIcqYc7JLahP97kp38D23GsM3zSabuIjJaLS1WMKYwV/O33lRbe1yd?=
 =?iso-8859-1?Q?QG23A8jZ2mXLUWDc9y3/riyilxAq88plB4vGqZfWkbA/t74zbox7H4jRKj?=
 =?iso-8859-1?Q?Qcg2YoD0Sh+/fB6dQk9GPUN7o2VjxOfAoOs50H1cno1RWa9SLpOIG1kYIY?=
 =?iso-8859-1?Q?iY69ldBTsKvmaQwuAgO/X59VaUDBjgOW02dkBTfRUJPxZkN9iWCO9bPY84?=
 =?iso-8859-1?Q?nvMl6v7pZNhUHsugFO83knhrWGZu5UrAJu2Wz61gtVoqdYd14LRcn17VLp?=
 =?iso-8859-1?Q?UENINCrpTSDijlRVccVWLBc3InHjwqPRVTefOWkSx6IWyff5Zc3TaudbiB?=
 =?iso-8859-1?Q?kuvicvcNmF4FZXIodzyEcg4t7pHk94+/RnbiyHpyGdR6z/WRGVapt2xY5P?=
 =?iso-8859-1?Q?EmZ2+JuaZS9NOQpssaN3UJr6K+h/fGyHrU2fBfI9bX1u2J7afnrqFOQu3C?=
 =?iso-8859-1?Q?2Mxn/Y+rAOfoKJHQeAfQwoIQ1G8NtuA3p7/yi50osvXDXwRlOEFTdyZRfF?=
 =?iso-8859-1?Q?cg/6GBUcTlJglkfagDB04OjeRwN5nGWT5+SVUxN+87qRKeox3PlAjYscHh?=
 =?iso-8859-1?Q?CoYDsI1zVFn2R+iDPfbyFgM+EPZjxHX3VqXO8QirEVNFzF4uHFzoR5q+pJ?=
 =?iso-8859-1?Q?HgNsRCDCsGGwHhSUdhClba4DCq/h4E6fjRyqNyK2va1s+L4qLKPkJ+Mssl?=
 =?iso-8859-1?Q?ULyv+Qajl2J21I5RpFM6ab/oHtCvixyjOgpiMXyWklrkFaagSBZ/8tx5D3?=
 =?iso-8859-1?Q?OxH1zz/YBKDRcK7m/1VOg+Bzglc87m5m1HYn7XbcT4ZZn6qPCNCOR1c6p/?=
 =?iso-8859-1?Q?y1Ktwp7ZYggVxyj72q17o+c2gEpDyca9X8YrTln6ttKIsPVtKOUyTwf0KG?=
 =?iso-8859-1?Q?GLbNXlFyVf1V59hlEZH+YspkbSaypB5qil?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8612c7-7be4-4084-7848-08db9a3f8a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 07:49:49.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QS2PWIwbcCsFvuQbGcwoDmdrmeEaS3Gq6eATMqY61jguHjM5dNX3gAac0V4++GDoxYPt3C6gC2X92ZP4te6fXBh+cr0efdpdrO3RCezaFR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10104
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

> Subject: Re: [PATCH 1/2] iio: magnetometer: yamaha-yas530: Use
> i2c_get_match_data()
>=20
> On Mon, Aug 07, 2023 at 06:25:47PM +0100, Biju Das wrote:
> > Simplify the probe() by replacing device_get_match_data() with
> > i2c_get_match_data().
>=20
> > While at it, drop unnecessary enum chip_ids by splitting the array
> > yas5xx_chip_info_tbl[] as individual variables.
>=20
> This should be in a separate change.

OK, will make it as a separate change.

Cheers,
Biju

> Personally I see no point in doing this.



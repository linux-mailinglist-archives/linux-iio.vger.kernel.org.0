Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294C5780B44
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376346AbjHRLjV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjHRLjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:39:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A580610DF;
        Fri, 18 Aug 2023 04:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM+JcEvsyvlUnfwi/b7ADrH3/fa8CC3lPjXIk8MKlC9/EP3PXTdiPghgaJWat7VDrSufStXSUvEKSv9/pO0rNY6Mcpym2hZfQp2FAOP/uXZPiT8sRKcTcvVtSUx6MaiZnCOOBXMZifH3qFmVGZq8eRYCIi5V15Qd4YgZpE3MYFtZiahpdOK8i46aEYIqYqyqmdg+o0/qAbjRlAp5lOA7tDekqYKiZwOQISNqLRXFtM2klidbUIoCmbob5Yv0j3sfpt8EFOEkA2JfVMFFyrm8Ai3bAQif9JRxGPgINOifXdKIJ+dU6KMHmI8ED96Xb6LOFBfm+oeHfWzDkyPuuUcw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqsWe8NBBIbbf6joXdutsph5DTFHAGOA/NVmJPE9FS0=;
 b=ZGRsuqS3by7VlcjtHofjeS77julslLC03vA6pc9Ta5x411Hh3drJkcqQ8REjgmcPVCzEqJfqdOJ1AbZsnyxdgk5jP3ljghg8LW9jx2rGcw5Jfj+6de10Q6mMEh84bJYVAFxV8iwW5zgx1rEqF7smIJQDSEs9mJi04km5A1AyZPixDNQrEI5T/7jnwIgu1ccgnLSQ/K90i2SHXdhM+2uH2/7cdEhr/Mja6ZPz6x+Y+zS5+3P/DuVwPKy6lZ02OPpHnfB04wllxGZbvT4rl5Wipt3Gjyf0lnJmHdzjz8pultXXHDUDrWGK65pAYcHZN5GdHHvFy1TEL1s6DkRxHhbKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqsWe8NBBIbbf6joXdutsph5DTFHAGOA/NVmJPE9FS0=;
 b=k1V/MpaHynB3k1Wd+siXD/0xSMdx0CImAjEno7PsQyi6bAk7BsWUG7or4QZ8nVn6rZv4ngGcQHY6cxrmO+MYNIu1VsYC6nfg/RA3a0uvoJxk6EKdT5U2lSEPMj/2gUJLQRHrNCtQ8X8azU+aoObDcagLCPaleSaWt0JCusfG2Z8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB7880.jpnprd01.prod.outlook.com (2603:1096:400:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 11:39:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:39:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Topic: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Index: AQHZ0al+MNQOBUPx202UR8p64ZlFNa/v63YAgAACD9A=
Date:   Fri, 18 Aug 2023 11:39:03 +0000
Message-ID: <OS0PR01MB5922F95816931D3392CDAB8A861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
In-Reply-To: <ZN9WVvo+pixspCsw@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB7880:EE_
x-ms-office365-filtering-correlation-id: 1c5a1d16-2e2f-4189-295e-08db9fdfb900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVdYXW0XKcwPe3jWpeJnjybdSie45WrWESB62VOBsGyYgxEjhiPq8g8b01Qseb3Juyv9TzCU+n7W+mPfE3ORQx99IlGrG/V5bKRKRrLS/lQH3E6BSffD2a39XswdC6zueJuzyEhuG5y87enVFwivGcTs1FA3hlnqurWu66VClU/+dVtzBi0UFKbOC/oHvYuYts7HdjXq+G2OWu1z+X21oXwYwc/1XUnr4Rk3te1caUkLElGTRIp0zeYD/c/sz0RbHDhiO+vboYttvV4HMbupF7YWdz7zKUpqcLJj5N9ZFcDVmdmtshN8yrwujs6Jh2GaEpx6QPqALsT75xTHHGhCqEMUhXGo1+oZ4WKAr53gwTrZcIGH8KY5O9JSy9Ne7mDgz3qbbLtoRhyM66oQUh4XHR4WYrLsU40PMFufmpvHkqc+ytsVj+QRebjqaLSlzrHpGyIFyDEi6ahXC3HegAlGCoHMQHBXx4KAYyklTGe9oz7x+t073TfxwBVFe4s88ibDIl9bpsuRtx2FdUTIRQDKnzPpxoi70+ARYSyLjsJqSEGO/JMjNM4dF0uAP8J/FxlxxteKcvGpSZlTw1loRrEP5uazA/BMQh0LQyeaJQIrg+eqqMYqgLgTTHSI5MJXwp4L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(186009)(451199024)(1800799009)(33656002)(55016003)(316002)(6916009)(66476007)(64756008)(66446008)(54906003)(66556008)(66946007)(26005)(2906002)(6506007)(7696005)(4744005)(76116006)(9686003)(5660300002)(71200400001)(478600001)(4326008)(122000001)(38100700002)(38070700005)(86362001)(8676002)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wYhrKM3uVghdGxcj3AWwyY3910a7T+f8gGs2UGH6Dai75J5wePw7dIJ+tC?=
 =?iso-8859-1?Q?6N0pNJrkqaToQ6p4vQ0C6F/ijzplmTtnb21hdV9QPIfo5a/FjOqfdl3JM9?=
 =?iso-8859-1?Q?zWpx6hDeJlIJvguUeuVrYZxOCOmpHyxTPA0LlEN12hdxm5z6CPngaTQPpN?=
 =?iso-8859-1?Q?g5eSseRslnm7rm8D2ppGKtLr9W2ujuaF3Y/Wj1F+I23ZKFrwVV6FUatXyB?=
 =?iso-8859-1?Q?MHbKsw30ci8SjUK0ps8YF7VrmDOLJgexhR70BmJLB28ebLL/P6w/ELgXTW?=
 =?iso-8859-1?Q?t7Yi8ZzCeB3O9UTR9Wp1Uq9P3XUpgPOugClmGiNB3eg8WKHEfxcXypIHov?=
 =?iso-8859-1?Q?fatl5TCAx9sPIN6g01yDmsnPMlQDvUrbVrx33oHw4kD3mvRp+LCSzVJOhO?=
 =?iso-8859-1?Q?tTSj1v9l40sXYvAnZ7owP99VYV3lnChhzTRfiyGSxS7+NY/VQxmQHW866c?=
 =?iso-8859-1?Q?F0MYKKIMzw4NCAEZu13ReEV3PqeiNX6PxSqEmlQJekmuOPzn4olBlRmLXK?=
 =?iso-8859-1?Q?i2i90CV5p9RYpVu7c9dQHU3uQKADfcFnNomzLTEZCkLCtkLNs0wXsuoRVW?=
 =?iso-8859-1?Q?pR+kaYAQp96J5DRikYkBzhWTGkTbVFXQAtpkvWlwjLEMWb6wXzGryyi0Vv?=
 =?iso-8859-1?Q?B3tkyrqGRB8KpzGs9A5NdiQtVj+A8bsKMMcb1kWDTzyxXd0Z0ybbkd5omY?=
 =?iso-8859-1?Q?92h+eEpgcw6tuaXsbSnjb93JV5e0zE+Qv1jTLQPBOWE7arJ84ZDtHyM/gZ?=
 =?iso-8859-1?Q?lYRT86s29y3YUW/RT5YllanRPmp9TrbSz8eRyR5E4fNYyHn9NfdhSTFTD/?=
 =?iso-8859-1?Q?LPG8QRaoKy9X0rXvfUjuOHgMOxCR1aLZTpzYCXK2uCStwbqc1KKeXGWkrg?=
 =?iso-8859-1?Q?tq0nUDWnZRapx6B2vWrGwM+GVD69gm+sdpRP+bKDq/uw552SiEGwT1elKr?=
 =?iso-8859-1?Q?SvhJeRr3PBUws50gh4KR+PA3a19tjTsuREKg9DfvNHSC5havvLn2yB9GLu?=
 =?iso-8859-1?Q?nvWuejd+x8cc/1O1S/TFBaIWStsdKEbv1s9FuEbFPnaUa3VEmenDzkPJhq?=
 =?iso-8859-1?Q?B8Hex9QQXB5ZPTIAUV1fGEZITFiRBL8gbgKeg608Y2NA0mAFKVR4oWZsIM?=
 =?iso-8859-1?Q?uwVzrEWjyxSQ/bnXWJaLSCLUn+aatBG0mV8hVQrbGBtmRjXNWvsW2XhV9k?=
 =?iso-8859-1?Q?BnwUaayib5GAUejvn5U4PlaJczQy9adWCkvOk6InVOWNuz2JQZTJV684L1?=
 =?iso-8859-1?Q?0OmfgnRCA06PdT0oTiKp/Qvp6ru8njthuZ6kYI9znOU/sKzh5QcKr9zSW4?=
 =?iso-8859-1?Q?BUmBdZ7to3fg/MmW86J6ppl65tP/964UmKgkB7LJo8sibXiP1VBgmxRhpW?=
 =?iso-8859-1?Q?8KAxHg2Oj3gwidwEQmTEtvkF0xMsIqpFtAvexAfmdXxKulHrbhmeAzswwu?=
 =?iso-8859-1?Q?66hHgTRuG4CHk5GpS2DL+4xKEfRro3CNqqcwK5VO0C0ylFgFJwXWRqyK+y?=
 =?iso-8859-1?Q?iek1hwy2m14izwBuL9aa1y0D+HrtvqU3wpKPRQi24t/KGmH82Z1RcCA7pe?=
 =?iso-8859-1?Q?FLFcmArhlq1YSAQvtky0bf8tKUCIlq7WuREI8kDd7KEMW6KrH53+anpsSU?=
 =?iso-8859-1?Q?T/8eXS58P5/V7pBXfg+DyOsPdhhFpjgvYd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5a1d16-2e2f-4189-295e-08db9fdfb900
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:39:03.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzywQUzTOjbIhK0gmMQqCf5fuOP5m+U1/ZAtfEF+T1Wj78sw9tC0Han+c5oqPiFBSiDyn9awASkPMIOZ3aakjoabEXylkPfYuzBtSxpdgks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7880
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

Thanks for the feedback.                  =20

> Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
>=20
> On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > Sort OF table alphabetically by compatibles.
>=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Wrong, I haven't suggested that. See comment to the previous patch.
>=20
> And this is definitely wrong as Geert explained already why.
> You need to fix the code that handles the ID table first.

That rule applicable only for fallback. I checked bindings and there are no=
 fallbacks.

Cheers,
Biju

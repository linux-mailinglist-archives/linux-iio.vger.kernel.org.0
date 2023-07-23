Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A475E1A1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjGWLuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWLuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 07:50:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FE185;
        Sun, 23 Jul 2023 04:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl7BcecgdYZ20d7gaSA66AaK4ovjSXV/efd9VGhfi3a2EMGzb7J+TDgBfaYo0LFwLZ6rqpwRelPqD1P6kSs7ybGdMC+jGFyC0U3Ifz85c+bf0hMjTRhC+QprWtShqrFNL5s1tPxe7bSGTqDOls9h/nMdbdLfp+Z5W2wF5cDC9+eMy8DUa98lGw8CEDOtImP/GN1XhJaWoHLACC/eENlUwa4QBJak9AhTs+bEN9wt34QnTPGOa+hgLT9kcjMaiqAX/lBh/Yh4ZZRyYGlXxnoXneELK1omrNVhbbf2G+JQdW8wtESsnUMujL8x2GNDqvpDoIvkXT7D7b4x1NXIwd8bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv8tC9C/1sPDsDrcen9uHvXaJRdyOPmrbc6jerVxaf0=;
 b=RypQ8mFvLGS3x7qE/zsDGGP/UHIRrjagekG9anUyXfi7oTAIYTuxt+dJqr5EgLdWEOtzFeHYKquI6SNRW2B4jFc9bQ0cPtnVCHMLSWNqPdUe06ikEm3ko8oo2K5UDPfldPYi0s+c9F5FAPwfkA46ci/AXk/z2eoNECM4k0tPo2AkbMFYoy9mtCKBDTjdeqsz+rnxs73Q5cCpSvCBzDjSzIJxIsjz03xatR8qwODTaxGiQpw0TpDw5tIYf3+mWMe5Ey9xkaoY4HcjkLGE0PGBvzFTHhducibltKXjtejDwRVfOsmchwDq/PppdCfC8/5XCZdqhlXkNGdErwpHvkfdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv8tC9C/1sPDsDrcen9uHvXaJRdyOPmrbc6jerVxaf0=;
 b=S9asi7ZCKvQyqb8IUQlub5G9l5JXTNdQP/zmAjx9ctq0GfXCswPPdSfM+RTs+BdyRBxxC4epjBi6/PKRtDWbL4NhqzWX+DKo7NZ5kwezH5ZtsAkYlWUegxuHHxuC0b8NraqN7sqSkTJzsIXvTbk3Hg7mcnUf7P5KuzkYDAUXshY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9598.jpnprd01.prod.outlook.com (2603:1096:604:1d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 11:50:11 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 11:50:11 +0000
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
Thread-Index: AQHZu6M6IkY4v2bEb06FbMft+4E5nK/GUriAgACNW+CAAEurAIAAAKOwgAAS5oA=
Date:   Sun, 23 Jul 2023 11:50:10 +0000
Message-ID: <OS0PR01MB5922169A16D3F2A0380E2048863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
 <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
 <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <cf71c4ab-58c4-fef8-2ce3-5ca32f9f2f91@axentia.se>
 <OS0PR01MB5922AB78FE88840E00885329863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922AB78FE88840E00885329863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB9598:EE_
x-ms-office365-filtering-correlation-id: e16b548f-79ff-482c-252f-08db8b72f833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qd8bRUHtvN4vI+IoySRvlmmmi9mvTg7qz1pJt8J4RgmEbmkUUv/On0zLdJpgRStGmdvIDj9FtzHuEInv0XbG+A7Q0DHqYYaDYNqKeI4yH+sWipXeQzK6KpQLWcGEWL1krZP01uJZwa/pn3FdBX2yl8eFUkCEKySZ57wHauwoU/4e4gHzUfJ7OubRjhGmuDeyD68dFm8igDhE26y45ZlpRe6Onn9X+bnX9I8srmajoJfx3KdpgjPC+Y+8SDqSZWxy9w0B8LTgY+X/pNXyoIa/kxzBPrYAa3c+wDE57Qnhl9ogbbnBXggWT2u4YwY+uiJ3Drx6b4wx5cxLzA9Vo1ZQsV9A3ROpkl68olF3bbK+jQViy0x4c+D/qpclpjiHqsylgx958oTQdHnTGwlN0KhQhHeIdcb3bChB1f2PHB88FoNmf0HzJJGIeG4O3hf9ytB0PlnR4njTy56LdOUA1hkic+KBEarybKk88GmDGjOPK/fzRYwulxbV214Y8Ms94eC83G+J1EJ9q7ncpctuNN7btlrTH5eslHt6up/vvHWvBC1/IYJFVSrUu0/B8qkAglf3AcBok2RUfPbj6AzdY0mN5OnLzi3FSjjZsqLrpVqPEopOLyvafW0/3+blWvIq5jVe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(7696005)(9686003)(71200400001)(110136005)(54906003)(478600001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(2940100002)(186003)(26005)(6506007)(122000001)(38100700002)(66476007)(66446008)(64756008)(66556008)(4326008)(76116006)(41300700001)(8676002)(8936002)(66946007)(316002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4A+pg/xwFi/fTts5BinYWJHV8OBFRcZZrrYeG9mq41KnAOukmSuFx1B7S4oY?=
 =?us-ascii?Q?x1rmMFUnd4uDWVftG+V8I7/FHtCKr9xrMXD6AKdO2zbNhExuDyTEeeiM6Qg/?=
 =?us-ascii?Q?YZSPRu8fl9OlwASRWyHHMjMWVvYQq/qU2LlnsrE13bGVi6v2/0kNHvlz6sqJ?=
 =?us-ascii?Q?IkjnWDLVw0JA1lumpyQ1OnWleY0pZcb5uY+89/4nODgAbt6UilwK96HoZbdX?=
 =?us-ascii?Q?F4C/qkzKqaPjHP8FWC/R5p1KPv7a4wqLsYFBiGTgAYA/wUa5mGl4tFeRFoBT?=
 =?us-ascii?Q?qLxjNY+yr5W5etszM5daAxA/I3X0IP2OSbssra0aCGCWgq5ogQ/NYGNt3HFS?=
 =?us-ascii?Q?z8fpO/a5Ix6CtZxWc1tVrRxT1NxYj1h9JlLspUMEBJnaVZ+crnHhGXduHxZE?=
 =?us-ascii?Q?IcfGZp/47hZe+nD50s0rpY6BhHBvqwXwReC8BFbDde8pPye+vucqTLcsGdE4?=
 =?us-ascii?Q?d6TDtbmQ3S7XcqM0bxtlA/Nned49z9GjJWLWtrN3Ga2PbMTbvwLtw05OBx3E?=
 =?us-ascii?Q?VMaS4Ts0P7FNWroXmtamZodEQU3NyOMTqYf0qTwN7S+kxQK4gU4+hdtBqv3c?=
 =?us-ascii?Q?dzQp6ykmmc+EZngkDPEtPlPl4niiFybLOtJymj9OYQwoKligoE2Z10venFOC?=
 =?us-ascii?Q?QIz64VQRayWJxd8sd7KOx4NN5HjszVZjJyaqiq6sVrszJZDuXm1sYdlCFz8b?=
 =?us-ascii?Q?0ulPHeM9NsEpQJPXBFxn/Cpklz6Rs2svoFdFP/C+g2JATyrUcWnUrgwMuh9b?=
 =?us-ascii?Q?pLNDAHd4nNN1M96d+FL7/HqgLEAOQzHARqyLwffM7hoVqymuDpIHsd8qnTB+?=
 =?us-ascii?Q?q/Xt/mutfBzKGHh3wvfqCwV7WjMgpYIB4XE7nJ0fhWE6ZXQmJIDi0BElB6gn?=
 =?us-ascii?Q?+mOqpZLo6AJh1ds5W9QcOpbo66b/m5GvxRZq3tfsZP2CFSOzYTzp1VJ9lV7V?=
 =?us-ascii?Q?xwbiHiS+ba00PVf1vapcV2v7+IrprFNafvZafghKqKIJNzSjor/VpTg3I1qI?=
 =?us-ascii?Q?dQcTHD4wTLpjmek5dlaOauG6aTzQ4qk1s7WP1FAVb2bDDn0Ia+Il+3UMV9Oo?=
 =?us-ascii?Q?ZhGwq3nE9AVzjuLRHfgOn3XNCrCq7khW92q+h1N4L24aJXDGt2xZB2Fum2+6?=
 =?us-ascii?Q?1LJYwnMa1nAdfInJtJlQux39syBL9GtSVkexS3y+c1AMGdZ2kTmkEyHCIpt1?=
 =?us-ascii?Q?x9deagPcZRg9cl9ha3k5SfjkMUKBRLlidorSL8ya86V7J7GD/DMbebtKhOCQ?=
 =?us-ascii?Q?95EXn7PuQbTsKnXiMWuuTZARJj31MbxPOlinAJaUBeC/ZM/z2pE+cbKCK5Et?=
 =?us-ascii?Q?rkf25W0Hj0rwfTy1S6q25mjwToMlFesKYPM0w4hdEXf10dIsOGYREjMn+htC?=
 =?us-ascii?Q?uBHc9XtkmafiCzcAJWcqHNihh6eHldFWUljSmkSY5KUJ3aEiGw/6dyLhwdBb?=
 =?us-ascii?Q?Mz0mT1RevjLMpeegFWEl1uJ6MR1CsKKUftR5LkG7jxz8XfdvGI02PaA2FwVH?=
 =?us-ascii?Q?5F3gs2X67NvOQlunBKujSrlJw/R3S7knOKEAhf7Db+T2opMxyNiMh8aRpS9k?=
 =?us-ascii?Q?GRU++6IBnOR/qlHGqv3X5MsRnWEbC7f+IgQSLfpu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b548f-79ff-482c-252f-08db8b72f833
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 11:50:10.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pN6LRx74FTn3qut+kl+jvLoAaoqaZR1ucfC3Gw1hEiS+6iq+1Qt+nU01yssZRbzniACmHlODURhbDKe8NuHCiboTazgj6JPheZF/aoIFlso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9598
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

> Subject: RE: [PATCH v2] iio: potentiometer: mcp4018: Use
> i2c_get_match_data()
>=20
> Hi Peter Rosin,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
> > i2c_get_match_data()
> >
> > Hi!
> >
> > 2023-07-23 at 08:12, Biju Das wrote:
> > > Hi Peter Rosin,
> > >
> > > Thanks for the feedback.
> > >
> > >> Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
> > >> i2c_get_match_data()
> > >>
> > >> Hi!
> > >>
> > >> 2023-07-21 at 09:16, Biju Das wrote:
> > >>> Replace of_device_get_match_data() and i2c_match_id() by
> > >>> i2c_get_match
> > >>> _data() by making similar I2C and DT-based matching table.
> > >>>
> > >>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >>> ---
> > >>> v1->v2:
> > >>>  * Added similar similar I2C and DT-based matching table.
> > >>>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
> > >>>  * Dropped error check as all tables have data pointers.
> > >>>
> > >>> Note:
> > >>>  This patch is only compile tested.
> > >>> ---
> > >>>  drivers/iio/potentiometer/mcp4018.c | 34
> > >>> +++++++++++++++--------------
> > >>>  1 file changed, 18 insertions(+), 16 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/potentiometer/mcp4018.c
> > >>> b/drivers/iio/potentiometer/mcp4018.c
> > >>> index 89daecc90305..b064e86ecce8 100644
> > >>> --- a/drivers/iio/potentiometer/mcp4018.c
> > >>> +++ b/drivers/iio/potentiometer/mcp4018.c
> > >>> @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info =3D {
> > >>>  	.write_raw =3D mcp4018_write_raw,
> > >>>  };
> > >>>
> > >>> +#define MCP4018_ID_TABLE(name, cfg) {				\
> > >>> +	name, .driver_data =3D (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> > >>> +}
> > >>
> > >> It is inconsistent to have a named field for .driver_data but not
> > >> for .name. Also, I dislike the cast and wonder if the trivial
> > >> simplification in probe() is really worth this churn when that ugly
> > cast is needed?
> > >
> > > It saving lines of code and better than,
> > &mcp4018_cfg[i2c_match_id(mcp4018_id, client)>driver_data]; right??
> >
> > If saving lines is your goal, you have failed with this +18-16 patch,
> > even with this compressed way of expressing things that could be
> > expressed more clearly with an extra line. Not that a couple of extra
> > lines would have mattered if the change would have otherwise been an
> > improvement. And no, I don't think the cast is better than the
> > existing code. We could of course argue about that, but it quickly
> > descends into a bikeshed discussion.
> >
> > My point is that this patch trades one ugliness for another while
> > bringing in no real change. It is thus not a clear improvement to me,
> > and I question its value. What is the point?
> >
> > Why not work on something that is going to make a real difference,
> > such as unifying the module device tables so that drivers don't need
> > to add almost-duplicated tables, or something, instead of only doing
> > minor syntax changes for expressing the same thing? With a single
> > unified table, it would be very natural to have the same match data
> > everywhere...
>=20
> A single API for getting match data for OF/ACPI/I2C match tables.
> Jonathan asked me to do this change, that is the reason I have posted
> this patch.

You could split mcp4018_cfg[] as individual struct struct mcp4018_cfg and d=
rop enum mcp4018_type altogether as an optimization.

With your current macro code, dropping enum is not possible.

Cheers,
Biju


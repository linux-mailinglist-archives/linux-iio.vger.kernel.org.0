Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE674780B92
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348901AbjHRMM3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376779AbjHRMMX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 08:12:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E52705;
        Fri, 18 Aug 2023 05:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3E1TWvo71AkLZq/748twVzSod4xVt+y5ejp0aeiMfAzM1J4gFBDzb3o6k38rdCqHfozWi5G9AVsIlcRBUPdrzCRjKhta8HlIHq+lBhQpxERoVb8GtFviKTkR1U4mwklD0ebXJjokWlx+GzCALdKo2JFuoHRPJGctxlP0SICM3x0x5glJdt8qlXE5pG01ukpWJhB9JFO6Jebd67T45eh1LGnHIPUBltKEfbN8tRTucYomQqo1z22920NauJTeYOIjzRztosEgkACs6qWOqsHcXOEfOcwi7X2SKha8YrAABI5qqncPdTij4YIjiNcG4nV8tVUCeDf9XoJ0bCb3y6r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBOI08She0/WmpygN1VMxE0C65Z9p5YuDt4T4OxL7io=;
 b=XTbCajwBTwH4hb02Xrr+42NCLXTeSz3OQEw2fvTwMPZXwt5QfRN3GTkFvru373cC1XK+bAznfU1S7gdjOMTs3upE41UuW6BnYYsZoQ//yIbFA0gQ1jpHgzBUiniTY2QJHBBD+QHLNwh0K4vD4Y3QvsTOhhoMgNTO4noj0f7yHaD//mkbhF+b6ESvCMusvjqVj2AROWFl5UyabdUgWp6nwhJ5lDwxHLGvVGGGrLM7MbP3IYykdNLh9UPEtey2kxZoG4VMwQP0lAqxziIUDqy3ggHdVNikOob3iWRrkAQlE9zbmhbTqrudfzmlAINKKZnROjkNiB+YOM3aec9ZFXHrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBOI08She0/WmpygN1VMxE0C65Z9p5YuDt4T4OxL7io=;
 b=nY7ukfQNEHke0BAbdmI4idQJEVPAoH1nVlrX2TEgbmUa21wyIulEVTdwZILefBroeGxzM54DSLjFAzpE49d4X88XZLRhlNyofMgauC89jjiNz+pgkuRQGJ0C74CYzv5+I93dYu58OJ4gBvzoSZ8TxnKfsUhCCiAZ5ZfomT56anY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8794.jpnprd01.prod.outlook.com (2603:1096:604:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 12:12:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 12:12:16 +0000
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
Subject: RE: [PATCH v2 2/5] iio: magnetometer: ak8975: Sort ID and ACPI tables
Thread-Topic: [PATCH v2 2/5] iio: magnetometer: ak8975: Sort ID and ACPI
 tables
Thread-Index: AQHZ0al3lyNLquuv6EOeYsRJBEZu/a/v6smAgAAMAeA=
Date:   Fri, 18 Aug 2023 12:12:16 +0000
Message-ID: <OS0PR01MB59227C3EE920635E803C7A17861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-3-biju.das.jz@bp.renesas.com>
 <ZN9VxbKRHnoX3e+/@smile.fi.intel.com>
In-Reply-To: <ZN9VxbKRHnoX3e+/@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8794:EE_
x-ms-office365-filtering-correlation-id: b4925db1-70e0-44c4-fa35-08db9fe45d28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90LuGuFHYqhm3j/COzOlRGhKv3hgSF+s0K9xo5O+mmCTd8sjegmXgE0pGB3eLwZynK6Bz8Mp/zTxjU+2A1lNzrE0qWwmhM+TC8+Baj1utpbTZ43ZdJ1yuDij4I+UU3feS3jfkR8cYVI4EQrQEffEZPBcCcPk61nYS0ggNE3z1+NaKvJyr1npnmZKRGjBUU8l7Nb3ZaFbWsiG/uU/eJVjgYwtIYJijS34VeuKvRSUtScw43YVgUDyhrb+HwgcaaAiftwAIxtra8wbuJf54dXxJLjHc4ty8FgtUuDt9v9U56dEEsuiKOAEYYqjgHc2w9Zu7HT0LhJ6m1XNXFA4o3L/3bp9GNu7tZFAaOaHQWOnlP75EfoMXcD1VvbvVd84jk3v8cg18Kq1CragaUbkQdDOjyvoDJ1KHg9zDPQY5S73cUb4gwgstZH+eA8h+uRxEXyeCP0YOgAal+xP1OmhlAHFWExDE6aUrCM2FlYPFHq3mX1bydW3uOGJnIKwgZmUEL3Hi49+C5FsLMbce+KHQXF1in+KU0c8R8wzVTGE7dR5gztchrVpjXymtDLRo4LAdJ4239x2mH8n+fj3Ln8c8n6YvK06dNvxgytyZZTl672KKdW5L/H4HaGodM0j3+RBZW7s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(71200400001)(26005)(6506007)(7696005)(9686003)(4326008)(5660300002)(8936002)(8676002)(52536014)(2906002)(4744005)(478600001)(41300700001)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(38100700002)(38070700005)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qS/DYH89we2WpT2C87Q+Cj3zNkck/9KXSZlKH3zw26hkJEtUEjXTL4cvzW?=
 =?iso-8859-1?Q?XulRwuVU53qhNYmzaonE1QN95XpqwOpHPkTCX9Azy3gbdqcN81tDM+yaFb?=
 =?iso-8859-1?Q?qzKlG45IK1jmAbNaaf5FL17eMzqRIlesfcmumA8xL2povDwI60r6N0q/DD?=
 =?iso-8859-1?Q?PDS7sReo5DDVkdyVBgmTY0FB603WEXjScDcP/lOlTfmXdJfdSRKJkPP3Y2?=
 =?iso-8859-1?Q?/bBllbiqsMGvDXSxwuH7zv/w9+yKSBtO2U3/aSNXpEqy8uoAM7OwHxdEVk?=
 =?iso-8859-1?Q?actBovq0XB6Q+zHWWTIUJfWNy35r0k95jEjgKdU3dKw7c4y5FyN4Sz1kaV?=
 =?iso-8859-1?Q?/pD1Selaiaf9Tjii8j7ZAQWfAEGXKuAUtCWxO67G3dzr1VppDkUUWJFF+u?=
 =?iso-8859-1?Q?LjlrQRI0iYe5Lgk1obZ+XGaCwKGiw9t/IrP5L5yxe/yxU0g1kHfAe6Tvsc?=
 =?iso-8859-1?Q?ngPLt52+qozS+Zz3SE+PUlj2p0EIKEqvq9nCZoD8IPAhJtF60oDRGGWwWP?=
 =?iso-8859-1?Q?V+H+YwlNhxPUGug2vrd7onS0iHjVL0WH6XGJu8XoheyRRaocnP2jkyXFt0?=
 =?iso-8859-1?Q?B3pAJpdt7wVsqfhz6DG7VVdZxXeCm4tMDtXAoO3eEKScDyucIclFzWIeUa?=
 =?iso-8859-1?Q?QiE2y98ndiZzMfwoukPCPuRTDqXShHWTba9XwF1q0gLkKWJQAYmO6O1+2E?=
 =?iso-8859-1?Q?lI1GQl42wlEn/krjtFR7aamh0tRmJx4kUjgj7qWjjxbzfvSMs748d7O8lf?=
 =?iso-8859-1?Q?iwa/orTV/Q/CyScaqUjeozdOGJ8Xa2rrj5uElQQ07LFm+rcE+PGKDlCxlt?=
 =?iso-8859-1?Q?Wo5XXbVstQT+PwaN4l6hJ3hBMTqjFpLY9O5g5AIhuPv+qvyHKXTNldrFo+?=
 =?iso-8859-1?Q?yIQBNi/7hRjD+W5KGiNqTY7KNuAIvrd/9uwQdmhOrdjQzATV/oSXuKQnbd?=
 =?iso-8859-1?Q?FP8Gi1vcQ/3LNRsK6Ylkl4vz4j7p2j887PU4IZVXxg8HgOpNI+mmlytNTC?=
 =?iso-8859-1?Q?ATvPwPniQmrYx+DGBtpXo0YYfAKaCd/eGkXH7nu5aPXxjuIfZmxAss3cJH?=
 =?iso-8859-1?Q?/J4fmO6uwd2PjsUjrztCnBLeMhpxzdjQvg32zfgzEvIKkbtAyezHFcCPty?=
 =?iso-8859-1?Q?0GBdbcWnzKevtQhl/2mGaj+zHPbjL6SOKv2+Qw8TD6WuOqqqeVahp7+om0?=
 =?iso-8859-1?Q?Lf+ae6OsK7CmI5QvBoIaqvsxF171jH0i6I/g9Y1QQhganWE3aOGbqhAXZ7?=
 =?iso-8859-1?Q?Fct1j4MJoF4kPEaThanvn+P2lpqXBeU5sHhsyxEhAC1JU5WbIFGSvEPUL/?=
 =?iso-8859-1?Q?bpRn5JbV1JWAUd/CPRv2Qpk5C5qBq1tLg+f1A1abdA3I5lyeEvkbEPDhfR?=
 =?iso-8859-1?Q?mOO1aWEkvN7V+ySV6w/CzNLPFid7N4mwgCo9a5rPw7maZqjqR7a2QlDJBE?=
 =?iso-8859-1?Q?C9pk/tmsqykjPVs6tY4CHxUp8N7Y++z2CyF8/Q1Q7qD18HQmgwqToHrjWM?=
 =?iso-8859-1?Q?TSvV2oio5GyIB+UxVyIik8pthphAAo0M+TpPm5Q8Kx4QO0+lmMPwkW2CTl?=
 =?iso-8859-1?Q?7/6E0/bPcnJ+CHmB4xXrw4S8AqhG2u3qXKyu+s1SfKs+o1XqBxd80gs6XV?=
 =?iso-8859-1?Q?CI+ils1DPt2/Hr7zN2YrOp6LWQGlWnJ+8n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4925db1-70e0-44c4-fa35-08db9fe45d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 12:12:16.7026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG3hnjKa6/KheZWtRPVKYF+V1dznv+ZgFMk9GvuHJduyxHFaLxmxX9S//DKowTan26NuCf3S4qSkugm8y/Z245Awa+vmzsdGsLmgrf7O9eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8794
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [PATCH v2 2/5] iio: magnetometer: ak8975: Sort ID and ACPI
> tables
>=20
> On Fri, Aug 18, 2023 at 08:55:57AM +0100, Biju Das wrote:
> > Sort ID table alphabetically by name and acpi table by HID.
>=20
> ACPI

Agreed, not sure Jonathan can do this fix while applying??

Cheers,
Biju

>=20
> > While at it, drop blank line before ID table.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


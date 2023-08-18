Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9896B780B4B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbjHRLk5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376468AbjHRLkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:40:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA342723;
        Fri, 18 Aug 2023 04:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn90xcP+cLvLjQuQCSYt0yp8jcSEDtXii7S+Pd87pvMeoqqhewkxWv1jFimWw4xIXfg03+Y240EY2MzYwW8MDQgUNsqNW3jfKx0Am1k3DzVD7Xo3xpV7CfPQXj97s+MLv6EsY+5YfCJTOwvHJjss5QkZRjgIDghmo0xToSl1XchqGFGu0fAw+WoYK7EpgamaNOqo7cpupwnV8T02xgzwQeLw/mO+0h/s3mfqxUNbkYEsyMOa6l+GYONt147abjSwq6SEqcZmtfyFQIzbjlcP1+qU1mPYwg1TqYWzs0k8fOs9trv6vDIU/S2HyYL3e9NpKPRdu5g0WahNXT7hb/039w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ndjy0SqCKqvhpIn7V92a5TaA46cENYy2uCL3FMJdxY=;
 b=JHWMicbgbMmED+cWPtfhfss97AG3qEffH/1BUw0G/8EcZ0wwq3vhYRSsy0Ryf6kUr8GJ+xpHxp8jHN5PGBgbr0+3LdLt/IX/FeipyqXFTfXGYntjYhJAAqCDE729WBdGJohkWsS8M0FfjHkUxvC7kMIgk/cNpGTgpq5XfdEvIm4+RQNmLPVqMYkeH9Xm+MEeOnAxamExVHKIuLPgSEJ8QY3jc2HymNRDR4+ByN5QHYkq8ytmdkLEKRilxdI508J4Df+VcDmPfUhCmU5dJIxozL41rEe7zXUS7vkYJB+qnsABbzjTu87Z2IBca20/ATrCVsTgA9BiFNTG/lVPKalvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ndjy0SqCKqvhpIn7V92a5TaA46cENYy2uCL3FMJdxY=;
 b=llg/YwI7+kgpuo4dbB2INBtm9N1Qm+Rgbpv/8HZdK0cO51PmBzJjodkm/G5zdhE33NaSEkWPdvc79E0eYsFgXi5n7KxUQDBzT/N88MfFJJH+XUfClYfh8+aHMrkSVYZwDOKnw7G+6H1GUUGu2smjEWyAYQa6KJImVgx7MVA/p1c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8590.jpnprd01.prod.outlook.com (2603:1096:400:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:40:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:40:37 +0000
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
Subject: RE: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Thread-Topic: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Thread-Index: AQHZ0al75waOzG13YkKs2qyA0eDlaK/v6xkAgAACx7A=
Date:   Fri, 18 Aug 2023 11:40:37 +0000
Message-ID: <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
 <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
In-Reply-To: <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8590:EE_
x-ms-office365-filtering-correlation-id: 312de924-2b22-4d51-b871-08db9fdff142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMyGY1rG4Y4Gs/Zl+tjWtWk7HiUIRRm1rR72H3XgQNtQsIKJeWHccT7+1NGe9/WnCKrdDyHc2JHrrhr8fFKaAHVZkLqL2h9VW+mn3wEsKok+ECQVZ+Rl2+ekfJQdU8tJm9MUIB0Ex1hO4BMyJvux5nK2gO7127VDykBJifhtg8OdtwQZN+5fcSByMvlt8xwSWn4cbM6/Em31V6Xn6KnWj6PwZ2/BSoj1Y8KHj+Gqfgp33BdJqjbEns/gybFbkflAYV1/2iStl2ChE4fHQYVLmSWVK1EBgE0ilwY6Iob9Mfc2BCm8udQzTWHcOasmRNn2LUCdxBjhw03fbIyhku0OOQGc+7zWxnkhNfJwSIGWVaTXfn96kVDaKaYRWDNGyqO7u+iTe6CFWBUn8VoYciq+TZiROgim0tLGZnF94/tXjbM2pZxLj1U7NgPrbC4dfc/xc0Y0LNUvjaaRWcNHPpHx+isI3VaxWCO2I0pGAc9EM3J5HfKJK6aJAWNciUn2qBG1jgSonTtX/hEzfYa9z13FIKJVM7I9vB1R0Ay80ucNOuQLvdpwFUdf1we/ISRZgKaVK8ln+GiiknAQG9jn9Roqxvwk8qSqVvZK5tbTQpY7q77NaIPov6BCxBQ4/m1L67xg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(86362001)(33656002)(122000001)(38070700005)(38100700002)(55016003)(478600001)(5660300002)(52536014)(76116006)(6506007)(66446008)(6916009)(66476007)(66556008)(66946007)(7696005)(71200400001)(26005)(54906003)(316002)(64756008)(4326008)(9686003)(8676002)(8936002)(41300700001)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GgxHfXyN+OhiVcLuaEDYyr74zIH8RGBb9+H4xwi0AibGdd4go5C2qiKg3Z?=
 =?iso-8859-1?Q?12GFycaWThUzdWd2h6g8PZSqtiqGGetfsplfJEB5TQM8au+WC/yKjuhgP5?=
 =?iso-8859-1?Q?qBjFLaC6ngkuERsrxnePANZoeTxB2x32JasyEiTuch0sLkaNWwQtPcBbqO?=
 =?iso-8859-1?Q?NLRKcV07eTUowGbmlkcJ7VqpUqmYbsBPKyZm50QhWk1yvS/OpQKM5M8yjQ?=
 =?iso-8859-1?Q?KY3S7SxI+CENMFHOv1UQu1QzmZ3ymF27yp8ULf0vq9Qu/0irUby2Wz8HlS?=
 =?iso-8859-1?Q?9cMH8Q1tEPbOcFe8oWlKp9UD6VL+r/zEkAV3ikfrwFFiYqhcJZURMjp5as?=
 =?iso-8859-1?Q?c9UcClfuM8SvCJpffBalBlv/rncdSug/asFi9X+3Z3MAa1csofM9xXGptV?=
 =?iso-8859-1?Q?n49sW6lrtFM4bBUXTJSQTOoKWYNl38TT1LdpdTkQBPO/zcE1H/shJsyN05?=
 =?iso-8859-1?Q?b+56t1sqmCUH/Hj1dfVxtp67AdGqEqi3CncV/PqiOYGtb9KVxLJPXmq8My?=
 =?iso-8859-1?Q?XCM5c6UhNVu1dqLMMydAMo1ylohKl/hfZ5Rowkpw7JnxUO/+piHNiey2Rd?=
 =?iso-8859-1?Q?Ic5R9JPCpFIzxWI1CY/NGScsQVwJgMjplroQVWDRlnEH2ulNQ4S2VGN3R8?=
 =?iso-8859-1?Q?znEGP9q1Tbm4c8sgOAPLF8wvn0QIPMM3gACkbbKvBcdu+tRgnzVHdN6J67?=
 =?iso-8859-1?Q?EJk4X3hZggMekZ1dmwhj9wJ4HPPo7dpUqXAIkRpXJ7wYXm5UOQ0n16qwLq?=
 =?iso-8859-1?Q?/JXMxv+wYBI9RifSE0Qjspb/ePwZVd4O6TgsKovNfqTFjpK0sYYGf+j7ez?=
 =?iso-8859-1?Q?BlrWcC+AlmdYK+lf4cbyDNYipP05Xi+SVNwxgESGCEMet9jFt/1HE26+Kr?=
 =?iso-8859-1?Q?t9v38uIK5Bhf2jkSZpz+UDGz6ZKHEVUteADI/0/eNi+ayz2VkDRIK6Wkdt?=
 =?iso-8859-1?Q?ZjTR6BMjQRPh77EUJ7Tz4N/G/k3iD60P3qfBsB39HrIP3hyO9qd/8VC9xe?=
 =?iso-8859-1?Q?8J52CminkY0defSeBhtyfVnDd0dC+yOtspAt6zNXtGT7UUus/ldhzN2WAG?=
 =?iso-8859-1?Q?vgJ5DW2uoRruf0txLKEvxxS60UFizP2ntgUyi8R4xMLEwZRsOFbgxT/Vnr?=
 =?iso-8859-1?Q?RrUo9YWRW+OqmawAp8w9xHMyCwTPobEspcx3HsUO5giQ7NUbH4CJcQXV3j?=
 =?iso-8859-1?Q?QiRqERKGvvm4W5ARReM6tTQn8RylFnGrKcrb1Bu/zdPAh60s6C8L6GUZ/C?=
 =?iso-8859-1?Q?kZtUG+Z9jY2h1pBvMeeNYkLfKQiaTJfI66yTULXDnXTaQX8dDIelF/V8O7?=
 =?iso-8859-1?Q?pj7tG5Aj+TVI1v/ObswIzB1SxvNlzVqvAK49oOxhNuHs9szaMh3pmF7eWr?=
 =?iso-8859-1?Q?lTPqldZGpH2jlmNwqIkFG/3zaPnM/K7pPkRhFCBhsPcyIMliGhCyL+JQRn?=
 =?iso-8859-1?Q?KU2eg+l2tTeSt781FlN0Iwlf5MXN5hUgepV35rn4TvHH6Lm3QPmzDPnX/z?=
 =?iso-8859-1?Q?z9ikClS1PmsE87gIhpB1u+HaDvLRBMgWVnd3WdpolU0YIfWqCWP/uK/ZNp?=
 =?iso-8859-1?Q?TjCiEbrG/A+qFkBI2oFePZ9bUTYrTfws6BIRYO6B4buFg+CNj0U7VMKWU1?=
 =?iso-8859-1?Q?i8xtdmw4vc+Cq+rudtZ3tad6WTOlyDsWxS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312de924-2b22-4d51-b871-08db9fdff142
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:40:37.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEDiUg4xweRE2Rc3CHE+G3P9Uw2hCHkLdjMQxUx7vlSfAgynya1rrnwCrcKLln5Nz0PdasR8nJx8ewKhe7tl1afRX8SMtkADIHNMV+CU6z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8590
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

> Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated
> enums from OF table
>=20
> On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> > Drop deprecated enums from OF table as corresponding entries are
> > removed from bindings and it also saves memory.
>=20
> You can't do this.
>=20
> Only sorting by "prefixed first" criteria is possible.

The rule applies only for fallback compatible. I checked bindings
and I don't find any fallback compatibles. All compatibles are just enums. =
Am I missing anything here??

Cheers,
Biju

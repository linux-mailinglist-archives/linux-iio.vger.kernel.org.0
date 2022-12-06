Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A4644023
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLFJrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 04:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiLFJqr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 04:46:47 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBA2339F;
        Tue,  6 Dec 2022 01:45:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdEAwUFOuJHS9x2TLjvPyD3KnPO4WUbnY+dlQ0lEjNWjDnAE8rmt/Vc6RA8RX1gAEu/Fl2ejLVdzDlAvTCEy+ynwMfH8cXSziU+vZkRtlmXSRpB8cczpjZXcw+NhegDMpTbP+B3U4s1+eTuk0l+pTJFVp0zc1aRZAxA6OW/Sq0Q1QqlBveROO1aud2tTkdr2k+Zqd7swiRyJ9Zlx7FUJaQCL7K017MiSYYQPySKVRpdptRf3H3lXZnmJGpD0OSSP+o/c5uckwYfWcIGr9I1uI5iSHqTMjQz7Puu6dRRSu5hCFqeVIturp6bt9jK5ZTC2QAv0Mnz++682vAnfd7Q2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of7HOcAR6PPdUPRYrL24OB4dtqPjK3kNA6vgkkuzlak=;
 b=coTo+NoGRkyEPtNxmeHbY6ai9jSb8IqO78Az7iZymFbbMZ1KLixaWlHh/j4+kE5i/E37+W1fBUrlQ5uJop8pWC/gp1zBHeVQPKjHDrqrc+tkrV8pMXlyHbgAZYDjT2s9h8aDItUY7ZbKJ6TIScGRSxQoifpnjsgsKbbhOeTW1dP19HrFyCslFf8D1O/BJO9w0mu0CyvROA+93zXy5b0u//wohvF9yFnG+pxyAn7sgvm8zEOL6PiqPzuWY/xM0+dK9wMNHR9MuTxaxsSzAx1PZ3qd7jdEmPIibhk91qgE+UGLXZcS5cwbZVrMDgd12dZbyawbMHDXQXLb7TXZYFuo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of7HOcAR6PPdUPRYrL24OB4dtqPjK3kNA6vgkkuzlak=;
 b=S2sy7wrsWwb/uNShLmmLyF9i9us2Wc1Ar2+0+cxC+3FiEGZN/87xCL9eavqsgXF+1Hj6m5lmHjNEfTz2El86i/vfoBVmrbVYOsFbIsq1dPRsasjPmQc4Tg3Rb8aA0jvH8qompQEw0o0u6GfBbNZuVmoeV9qP9jo8ST2L1QAm22g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10319.jpnprd01.prod.outlook.com (2603:1096:400:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 09:45:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 09:45:27 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Topic: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uCAAAzJgIAABM+AgAAMe2A=
Date:   Tue, 6 Dec 2022 09:45:27 +0000
Message-ID: <OS0PR01MB59224B6915F3E2D68D06ADDA861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
In-Reply-To: <87sfhsgb9e.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10319:EE_
x-ms-office365-filtering-correlation-id: 59cfd8c9-bd2f-44d9-0211-08dad76e9b48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jegt/RiaKLObaWtfDF8pOc88YvWrWZm3c++ANv0bm8SpcArTylELqcWzOpXHOwKY5erLYBnmYaEw5H/SaOR8qdUURcLVQB5hH1R486IXy8jM5LG9nWNYWffU5ZQTzTnoKHwc9Mc5O1MtFEXNYqIoE4KBQVuUoubx0jphT5jxgQEoh89sOJlRXOGRNa8vpy8mDPrNAYBZdP+zWepiESLAK8BeEhPeqofNdRHsg2z4uHcqjOwCf1jzG/AJhhN9pSjVXMBd0WXfW8ejGimgfQBUbAflel8+uBF7dB/drz7d5PXnbW5Tl3p66mOdm2NwpDDv4nsVd89SDO4DjVn9t3ndYcBxhvPsYyqP5RNglcglBNp+lNWc7ow3lC//rJ/iNHlEnLWsbMPQLBRzJRncXFc9LPoqDNLTiClLwY4S30jk2yFL3CqEvjcVpe1boa9ZBuEqR3aGLqGVbB7wBP2IqazTCI0JcnuvqsMh8urpSc5XCv0DvmWpPX1YiNkniX61j/M6SFAVCvvzuyFHaVn9VyA3pj35yYnTcbWgij9CQAvtSKmhMPqa3psgcmk2aksZSMZJCNYmpWbByf3kofCSq8vMryKRZJtybbVsDeUU6qilL9QNMb7wTE9I0AAo1bQg8mW6ND8MlFfluDT9W/dAeN4NzXMKbt+SRVXseBNz8oGNlvmTzk2u7vxtqcaUIBy05XwcBMMUfwMnZaBnSCyAEoNLrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(55016003)(38070700005)(86362001)(6506007)(33656002)(71200400001)(53546011)(7696005)(478600001)(52536014)(66556008)(9686003)(26005)(107886003)(41300700001)(4326008)(5660300002)(8936002)(4744005)(110136005)(316002)(54906003)(2906002)(64756008)(76116006)(66476007)(66946007)(66446008)(8676002)(7416002)(38100700002)(186003)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDZ+7giEW387q0iF/g1oxpoP0gyBEnUZKhS8eH8KcqQDLSHSv6GQ13VTUgZB?=
 =?us-ascii?Q?kV5u9N73ZiGLVM4NUy+4SX1AUHrJ1mYVuz63rpa/MHJ1p0tNVMkaBIOmiMt+?=
 =?us-ascii?Q?JdW98NNQ2XFsjmZBMJD13SJZZd0QCKe56pFWFfSetxas5mO39wUnCqwcpqlk?=
 =?us-ascii?Q?/jSDiLC91sa9OnD1cNZuxvwnODH01lqOlzwQExJBfVPsRomdHNcAnv3n2kvc?=
 =?us-ascii?Q?bjkH536ZJfh/gTluDlODACruxeUy2QYJAUWtIpUjiZ42I9x6lq3ufikN59UE?=
 =?us-ascii?Q?uj8HV3ZH8l1C+ZfvaiAbQW4QCMLzHvmsYkroS9uVX0tSv82cI8NOZ82d5JcL?=
 =?us-ascii?Q?XU1CogtDo2Ua0xx8z+6/Mnw1YXPmeqKr0kWav23EVb1y8Ae/HwqPsQXi2YNb?=
 =?us-ascii?Q?o4/QASbIaOqm/7kzqUuQtabMIcEyQBjxHBnzjcnDiXGUkRcleyc5x8ArY8X4?=
 =?us-ascii?Q?dk0sX6FaDrDMo1IKcByY+hzHXSyXLNkRPTMBHJEC+BpjFCG5Hf49HxKSc7+Y?=
 =?us-ascii?Q?Thzm0mOb8oX5qfwl+z721WnTR0LxO2k5vt1Tw8Nzp1Kj9O+dnog5TdwQFg6K?=
 =?us-ascii?Q?FviISzlvW8R5l1cB7BjRgJKVGQzeeHS+3jYEsvCHQmJUhCVcu+2PNnZKUlRk?=
 =?us-ascii?Q?L87HG+k7tzCDJW5CQ9afdEAKuwzu2qXNcYs+W8iGhakeKpYg0qw1+4P0dO8M?=
 =?us-ascii?Q?wMmPEupaAhnXkVhSns48AaxLSK8MItPCBwzYazeweezDPGxr+lWbRuXdxuoS?=
 =?us-ascii?Q?U+ESXLKdH5CI6XrPimeC3qX0J0rgOOv7DrKv3v9MavGVKyY8b2mJBO1NJmbF?=
 =?us-ascii?Q?fib6ixPtMF2kWwveLR5PTQW8crsMiqinm0SOekUsExE/2AhM/xdAPkDOIN8d?=
 =?us-ascii?Q?tlOR/4ypHM7m0aEmAIaYQy13PF+W5yyWv6Dyc/jFR2ZkUOu+8Xq3uPg+OANK?=
 =?us-ascii?Q?qJnJvb2IQ7PcJ6k70wb1ewjwPJbAW5ctoa2VMi7IID88ym9nYaiD9+QSHMfC?=
 =?us-ascii?Q?M2vH08vabbDY5Z+41oe/I6CdfXQG2magv21CAlUXlYSPMYlqhXD0eMldGtqM?=
 =?us-ascii?Q?HuLEK1ZZd2keOei1V8+zrbxog51POOnVl8usK7ImrbrqvrwH7rIU6pfXI/DB?=
 =?us-ascii?Q?Bmwk2y5mWvxYsUlXlcMYBvTgo1vuZ1oOBUhYj8VMtVl8W+gxO0iL9NcEUoRl?=
 =?us-ascii?Q?i+y+56KF3hBMwN68J75NXXCV5A1fxMKYMyjRYaeKHnIhiCXyvcKSgLovp7k4?=
 =?us-ascii?Q?/qhsW0k21bT1y3ssc2eZYkgJq9a7AAm5VhBw++3l4AO4K4dB35ggkcUf+9Xf?=
 =?us-ascii?Q?tDhmEDCKFRjBvX7nwsqzOl1HNM99WIKHop/neiTvZkTXgUhW3MFRhePSUg4F?=
 =?us-ascii?Q?YDp6LrBOPNB1EUANSJxiGE4ZKO2xWYZOl0kCBktN13xQQppPec1lkF5J3dLX?=
 =?us-ascii?Q?h8PNvbTbmLdr6uwZkqBbp2yrvBtl0T98jkjrjYRe80k9Yef8wWTx01QZ3k67?=
 =?us-ascii?Q?WAYLGFnWLUrwh+4sKyOGq0MMXOVkrM/Spz823rG2tioLIAceemybKU9z6Org?=
 =?us-ascii?Q?n8lmbsT1Aon3lcZOw/tMrqrAzqaJlj5Shiff4c0l8LQH6G8G+rltZYu8ODdR?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cfd8c9-bd2f-44d9-0211-08dad76e9b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 09:45:27.7752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECTD0Rmy9lKLVLTvpjjiiV7bWMcK/af2TbbUT/UlryjlE7xXUJr/jWmhpgibHKQtqjseWWQGH8yPYzhKZqL0DHpaMZmGRA1FuppHooK/LwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10319
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>=20
> On Tue, Dec 06 2022 at 09:40, Geert Uytterhoeven wrote:
> > On Tue, Dec 6, 2022 at 9:13 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> >> > Do you have any use case to really switch. Doing so disables the
> >> > vDSO access to the clocksource.
> >>
> >> Not really. Architecture timer should be sufficient for clocksource.
> >
> > When multiple clocksources are registered, the clocksource subsystems
> > picks the best one anyway, right?
>=20
> As it does for the clock event devices. If there is an architected timer
> then that should be always preferred.
>=20
> No idea why there is a need for the extra hardware and the drivers which
> are both never utilized.

Maybe, if you use secure OS, this timer hardware can be used there.

If you use PM deep states, Maybe, it could be used as broadcast event for w=
aking up the system??

Cheers,
Biju





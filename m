Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8908643E2F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLFINl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 03:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLFINk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 03:13:40 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F715FD7;
        Tue,  6 Dec 2022 00:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+GTyFA/jY7seS595o5i+B+XCp0KpQiC1wRo9RcfmcNFUz7k6aeFMHazIcd0TlFzNSPTUpf2G7FH2j5y1HU9QJSnTG2gxU8d2iRyusU6fRPG2G/oE9BTyUfPUxEE/Bf1ulD9CQqB/Dq3KlujW5wwP92ryRrj7cpjrW5a5ndrG3wpyrj9o7sLijBVLUHBneGE3b66/9Dz/7794qqnu9GumRU3gkt1zkv/cMom0zhI6L1esV0V4D+d08OFr4Vtd+jNr6fKFO0IeTcf1dSdy9n8FUzeIys1PiuXv9ZdbDCb921grkklISSOUyqqACd08mvkcIcTaPaKRb+yerrNEQd1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul5QtiMo/8ajwls2r8tW6PPe5AuI9U2HMnW4Vzq6s2A=;
 b=iV+R+to3rNABD1SF2vCGiNr/D6XzPn1uOfCFtaZ3HrrIOHbl6H5JSRDYKOXohteeHrwA3R+KPG5i3agI0s0rhvrOnnKVQgytxxOMtQ2eNxAkSDriwPTvjtZHYdazFZcO3VHc2KkPwYHcKlYNQW+P2Em8r2EF9uhG8ihFMkDI2+6Fi6DH2cZs6pQEuvoTUoFW41DOtrrmjWd/sk/yGkf2z3/gimEZoYsALkD0PMygiUZG8fSrk++lKOQhxP2dvbRvI3V5KBslsBIxI2BdadfIdPqj8sdhCvewnOO5IePWyAKteTJ05QWJwrWyTQNmStlt9Qs3LVDaiFG9LEC4Xytx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul5QtiMo/8ajwls2r8tW6PPe5AuI9U2HMnW4Vzq6s2A=;
 b=loX8Ur6pCoAQfe6MgU25W0dTSbyv3F/+Z81sG/H81shXglQ1badv5rt/cjt9K1VWSlC43SEvCbBOe7sy8cmnQ4WC/wSCdyfrB53u6xthnPbWte68AwA5iKkxk9AjBRMYsMwrjDFh5Qi6o+qAdF7aNQ2Y4Xe4j6CsPl5IUAC7b6M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5942.jpnprd01.prod.outlook.com (2603:1096:604:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 08:13:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:13:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uA=
Date:   Tue, 6 Dec 2022 08:13:36 +0000
Message-ID: <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
In-Reply-To: <20221205225042.GA2812115-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5942:EE_
x-ms-office365-filtering-correlation-id: 554f87ef-7f76-48f8-cc6a-08dad761c65c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TlpsT4x3BqSjxxycnI4KNu44o4RkejMqATe6liaBdDQSoQO/W69bQ1IRXLIXARHCvxpyyEfvDOak3CNO9XyL01DDkliSsMxqDeTYxkhPwCFqA0msIsOBVfIOf7c6frp8pJIaVsdJGv7HN2V6iy7GsIiJXBQYphi5Kaf3waJzHFE9kWAMSubg2aFV6GpxeI3ERII/2Au38QX/mdFVXllGFCWczY3WQoHU6oDf9oKZU27ebVD1qGUxtURSHXnZYns/p67R7ew3R27rO9SSkWoZ6QOU6t35pXpm+v4LWJ9+Pshlc7CMFcjcAxc1/Vndg6/KjTVe+S/XEqw5YjCbC8s/U4j6Mddd6OlNGPmhng1e7roLkOxOSS/tLss0/xU5uRbKSlmCC9veDD4u7OzkkKx6hjKne/QMsbbKZcjgcsg7CxMdu3H8DFSJt3I0h3s7cCDIlHFENq5vhYLULbqNkDC0bMPl1H6pptc9y69JrCH4id1APjCXKwJMTIkD/p8L1kBCJx55m3ZML1rYXTv8Ilb1nzag0QEYmmS8ILVHAcHDqdW9V3Bhk0+AG+UfqrHwjUxPt4y6IQ6qZkSDai7yQx3P8ORtKuetRhZDYDbxNIYg24HCdH8jQyFVHW+SzjhOmk3rdKmQ2KvgDAK0oakgY1L9gSUi4kYBTOfDmF57kHUkst58eAuclYJC68hiTCD58H9w4iVRSlZwncSo9N+pJ8krQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(83380400001)(7416002)(52536014)(86362001)(38070700005)(2906002)(33656002)(55016003)(8936002)(71200400001)(4326008)(8676002)(5660300002)(107886003)(64756008)(26005)(9686003)(6506007)(7696005)(316002)(6916009)(54906003)(186003)(41300700001)(66556008)(66476007)(76116006)(66946007)(66446008)(478600001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CT2F4rkMULzXUztCKqevXYyHiwabNkx7FDoRBqJmIUJSqs7ukwIcpt3xaJA0?=
 =?us-ascii?Q?R6IBbR9s2WLJIojXk6/MMdajicRWUlqBXk72tkwopMNZrnykYrdhR/vvS4LO?=
 =?us-ascii?Q?G/UMsFafGKDTeHZkCOLeVv7JdXRSsKuQECmnpSucNASKpHAyIQuQ4D3Mhtpy?=
 =?us-ascii?Q?AAVhUS+9TO7GfQOWfvV5EZs6k5GrIupU/90mYDm3odBnkscNYh84UclZzfa+?=
 =?us-ascii?Q?f9fvwhBAsA0FwzR6ON8kOUJzeb/HrNKGopBOcLamwLeBo9JZRgZF5aUYo4vi?=
 =?us-ascii?Q?uFbrV5EjR2RHJtWnH3SWfZmwP6QXY986v7n6sms4pwJygKJVwMuMpSEUgcpC?=
 =?us-ascii?Q?T8Ly1suReAiv13H3INnNI/9tRO6eQodZc2K4UaSnTjV+Kkoev7m3rxI+Ye6r?=
 =?us-ascii?Q?+IsfsCPCTIcWa2fX6ri87xgdQGuMR9ELo5Px4iu8jjFq/bKIOMolLl/yU611?=
 =?us-ascii?Q?S6AfOyE5BPdnS3w8L3bsABdRPgIJzuuLa9C1tGbbkSj+dvsqssT+QjHku8b2?=
 =?us-ascii?Q?WQpCG4ABJ8krvWs2/b5WKB9E98nPr9jO+I4zQ7l2iw8XAY7WpFCID4OK4eo0?=
 =?us-ascii?Q?+96/XTpOyhPGTfZB/M9G2Q6rdC4ZjDNrAlvYqtOhM8d0pZ+UNk+q4GxzJpiV?=
 =?us-ascii?Q?Dem6HF1bw/B6+hMfUJovbddsTxR/dSJ4FxIXAGjusX2Z1DwP3SuVne5raRkJ?=
 =?us-ascii?Q?wmzE35AldP9hdobDxmeaqK9Ya8wd2DN/wloJCXtHY6gEOp6D6NWUBBcXQhn4?=
 =?us-ascii?Q?dXRzJXB0OerS6XGXir+BUwjDr1Z7hpcT4gT8rX64lIBtNRdjNN4bbrsy8vcu?=
 =?us-ascii?Q?pEXlyA8t8D7kKASIFsz1K+ZV97eV3Z3FTZLhSSzQlYGzSn5CRfDsK7ZUeAVo?=
 =?us-ascii?Q?FNCb2J8HEf2Xh+/sjouVwL2PbnyXKeWRuhl60RFzOygDUg+fWNSsafxk5PCz?=
 =?us-ascii?Q?Cr4o843xSQUy9QNrAq6K5Qm9JDHPrwdGG6HO2zLjyBtm3XWJGsCW7OH2jnlq?=
 =?us-ascii?Q?mnNedwIRNoLmUqIettWOwpmcJTZhawxebijMLpJ101F7dF04qr39jjQSPgmE?=
 =?us-ascii?Q?dm4aub2QU0fOPB1BoiwJnHIHHqaa0Eh+5hkpzww2yVJd9gkIQ25HW89IV6me?=
 =?us-ascii?Q?+LIkYUnEiNZKZFCfU855bGUnOUXIQuOVFLLthseyEUENlQEtQozlSPXeMcoW?=
 =?us-ascii?Q?aIHyoNBBBWlpKNlajXsz5oVpr+K/pIFjFWJXx9f8UXLdsRGXB3277ww8qBdq?=
 =?us-ascii?Q?gQISKo4WdZxv1feFSYWEju5edQdx/xUdYSZWtR29Sp2LrU5MErS9TvgtOKs4?=
 =?us-ascii?Q?NTQaU0mYBs+ZffeKY1vm5J9xmuy9conZ03y8e/00iLNlGjJIiGTGmDRUnZh5?=
 =?us-ascii?Q?xXxannFQTo7UTfA1MGp/keu+KEfpRdthXEzIJiPIl+wXwAd8vujgMhMBUSmK?=
 =?us-ascii?Q?dLSIOspCTXSNuEkQU0ERKFGjQzHPoPHFp4DFUgB7B5pS0vSH6AIuDSqPnroV?=
 =?us-ascii?Q?prkA3w+ev3xYBv0kchOK/7NEAORe/fb2ycBlR4dsZe8sLwBmzJ2W4+wS5TTn?=
 =?us-ascii?Q?vBRWx11pZPgv1LIW09geMB/PO/Fqyw0PWi4mjxseJ2/zBcWFRCXxdy5yG/xy?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554f87ef-7f76-48f8-cc6a-08dad761c65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 08:13:36.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejSAqJ9TmHzKkj1jls5T17Vy3hwZnJ/OrKoM0mQ/uPQWJmK+U8K34WlIH/fIk5E69vkkhTgvrPI+BR5m9nC0aVGx3xea9z8n0xnZglCzCCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5942
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>=20
> On Mon, Dec 05, 2022 at 02:59:49PM +0000, Biju Das wrote:
> > This patch series aims to add support for Compare-Match Timer (TIM)
> > module found on RZ/V2M SoC.
> >
> > it is composed of 32 channels and channels 0-7 and 24-32 are reserved
> > for ISP usage.
> >
> > Channel 22 is modelled as clock source and Channel 23 is modelled as
> > clock event driver and the rest of the channels are modelled as
> > counter driver as it provides
>=20
> Why did you pick those 2 counters for those functions?

Currently it uses architecture timer for broadcast timer, so I thought
Since TIM has 24 channels, use 1 channel for broadcast timer and 1
Channel for clock source. But having said that SoC has an aarch64 architect=
ure
clock source strictly speaking we don't need this.

>=20
> Unless the h/w blocks are different, this is an abuse of compatible
> strings. What's the h/w difference that makes you care which counter the
> OS picks? That's what the DT should describe. If any timer will do, just
> let the OS pick.

There is no HW difference. Same HW block can be used for mutually exclusive
functionality.

One is for Linux Clock source/event functionality((scheduler tick/broadcast=
 tick etc) and=20

the other purpose is to expose count and event ticks from this module to us=
er space,
so that wide range of applications can make use of it.

If it is an abuse of compatible strings for mutually exclusive functionalit=
y
, then I would like to drop clock source and use all the channels as=20
Either clock events(for broadcast ticks and real time usage??) or as counte=
rs.

If this is not OK, then I need to pick one. I will go with counters.

Please share your thoughts.

>=20
> >
> > 1) counter for counting
> > 2) configurable counter value for generating timer interrupt
> > 3) userspace event for each interrupt.
> >
> > logs:-
> > Counter driver:
> > Counter driver is tested by reading counts and interrupts tested by
> > counter-example in tools/counter/counter_example.c
> >
> > Count snapshot value:
> > 3114
> > Output from counter_example when it triggers interrupts:
> > Timestamp 0: 24142152969        Count 0: 5
> > Error Message 0: Success
> >
> > Clock source:
> > Clock source driver is tested by clock-source-switch app.
> > [ 1275.703567] clocksource: Switched to clocksource arch_sys_counter
> > [ 1275.710189] clocksource: Switched to clocksource a4000b00.timer
>=20
> Do you have any use case to really switch. Doing so disables the vDSO
> access to the clocksource.

Not really. Architecture timer should be sufficient for clocksource.

Cheers,
Biju

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD492738E5
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 04:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIVCvP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 22:51:15 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:45473
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728633AbgIVCvP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 22:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORnenh13V1l+20AMWN6dSF1W9bIu6mJoMcYkfX2o1LvHmo3IypOxoILPhWBrVDAbTv0nUgTtLUkz2fR7/CzmK4U2s1AvjuHNietNPT5os4Iqy+uFaFmW490vajKwrVASwGnQGB3mWRTWs3RUShk0KkOqEVktSHnN9DK9aXTO4TVXSv72etkQiKaazbitnrRnpnTLfIZR8nyJWRRK5hygEAV5qQkN7IWcqPsSmiJ+1U4MUWEr1O1j6C+7D4szJ04Pw2qa5jUzOPyLmgLemkqiwdcNZD5TX/b8zgBJHAjUqNrZlFdBowNlfG6BOF1OwCQ+1ORGVUfaK82zTVtd9nrB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9x6fSVaFKgld8BecHNnMt3evI5zlbqxsZiijG3SIPg=;
 b=G5ePYKTThm8hTHwJGrY7KbnFbhNz+yy3SldT8Wqkl4JprxQP6LgoHp7qnFEZrsf0s9NOPK2MXdiI097AloB+uvnire49nFe1OjP5RgAWA3lN33V5QPFWrms3GZZ5Ro28xZyox55JNdVqj27ObgULVP2pFGvHPynwUZzsAGM/KePSSCI9wIVYpz3gi78x7fg7fCVgbQYmppcqz+vvAEKBCyPxTiXHu55JMjxJJZDppCMiHXEkrDNx3WA+tRWCOXOTnClPJHTEnJT8ufbHDve/liUcY18O6ar8uWkByJ3TIyGNibgSP/crTvymC/zN0GXvisTtPBXm6gjPeI3qkTlcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9x6fSVaFKgld8BecHNnMt3evI5zlbqxsZiijG3SIPg=;
 b=VbKTAl41zrvX6tUhlh9uhd7xHoeJMxF5AcS9dMy/AehBKH9Hg33CLGe/ro/F0NHEp7H0bT30PIZz9clJudACsuEZurRI1Sb6VSZpEYSC6dixpS4OP0+RB6XsAJu0yTiZ0WuovXuiF8dFGNWZ8vCQ6rrkNlwuoQugxMue0GwTq/I=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Tue, 22 Sep
 2020 02:51:11 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3391.026; Tue, 22 Sep 2020
 02:51:11 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "maitysanchayan@gmail.com" <maitysanchayan@gmail.com>
CC:     Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Thread-Topic: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Thread-Index: AQHWkBvdNbipnuodp0KNE4gdG5TRkKlz9Jpg
Date:   Tue, 22 Sep 2020 02:51:11 +0000
Message-ID: <AM8PR04MB731594F51648126A764EA066FF3B0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200814113008.00002733@Huawei.com>    <20200920191545.4ed79276@archlinux>
        <5007153.c9bsiqU2ZW@n95hx1g2>   <20200921105703.000048b3@Huawei.com>
        <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
 <20200921143206.00006b43@Huawei.com>
In-Reply-To: <20200921143206.00006b43@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0985e185-6ed1-45cc-628b-08d85ea25d1c
x-ms-traffictypediagnostic: AM8PR04MB7331:
x-microsoft-antispam-prvs: <AM8PR04MB73316287C11FC5B2A7F5D0D7FF3B0@AM8PR04MB7331.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8FyKy+TleWk/gOPIXApFZ0oXvQS1mCVEPc3SDyd4plp1kMwF4lGt1FeKGdXSHSlBSH1HGGXO4C9/Fdqyno932bN5aNoyTw1cOpEHSHOEgu4cb6OF1UX+TlptNno4E5wTh5nvQW7e0R5vY19YnxZ2S2BiVuTvcZrFo4AVC9n6arwIJRepFMBCC2tyDt6bEpdK7SN1jJatW70b77iFrsODz9mc5KNLnCOf7HNTdTH4GszhjFSU19WnCHOJ2jpSU9g9WJ70h9BCqGK5VGL3Bsj2fGucfBziwncZkDgXQP0TANW66cvJdnZFljoTBrFXgjW7UfHWBzUMd2+QjBSTL6jCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(52536014)(86362001)(316002)(76116006)(478600001)(7696005)(8676002)(7416002)(8936002)(2906002)(26005)(186003)(83380400001)(71200400001)(66446008)(53546011)(64756008)(110136005)(54906003)(66946007)(4326008)(5660300002)(33656002)(9686003)(6506007)(55016002)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zF72zFWNPeg1zmW90Sm6SBjt0F0olyMNEdYDANZBTjMjmGUQK5sIyJPxAVoCSWBbK0HUW+kA2f9mJd2iaW2eX0sioSIWIilU6qeYpAuT3VeuYi6XLA8vXQ7fubx481T2eReMglKaMdL0eXWtlqoTKmQV3Y63CDcbdhlfWoWFoS5SVYZtO9cBVerJsbkdEPFfcSJNTfFxJlks/H/0Y5wRbCbNCw3JOGC0XvGhqNHvcpCEBIcTX4td1d9lazWL4nyBwQuPHpixr6tEvklf3hWItUORDKie10yAO4v5GXv2T0PDWcHuTFd1xCBhLHnbjuwKlOOw9FK/3zcoF58+7r0kR9Qv8aSKxlPnkRKuVjHGobH91X7/rPT0HvHnatTcspzYytVwaEVC6ZadQjD1p5XF8QYHYmPxXCZecoAEPDKES+qVwmB3ktZPiIQ0Z0B94gqslF1lNPtlTiq8PfjSEAPtq05DPaPOs/+AmUKBrXfSlV4Py57nI0Hwd1Q/SpjwthemXqj8gnKJ6VkgzG3CD4jwhCT7bQfPv1eqJgcevrWNWCy1oCv9PP3cGhA9FVmXnOl6E4VSguJGhcGDgCvjRFK6SUT7p6YZrif4eogBRxr82ExFjNMmce88I3nRYi1Sq5uF7Nh4pae2eYAeTGHm7Rfw8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0985e185-6ed1-45cc-628b-08d85ea25d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 02:51:11.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7yKVK8IDPzAT1SIRWBFWMk60yUdJ+JWwA++lCMQhr3VKXnf5GzEVNIUiW6JxJ8pP5sqGN2RTOinmITVPi8KkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> On Mon, 21 Sep 2020 14:27:28 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:
> > > So looking at this the other way, are there any significant risks
> > > associated with this change?  If not I'm tempted to queue them up
> > > and we have the rcX time to fix anything we've missed (just like
> > > every other patch!)
> >
> > I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
> > context. This is fine then.
> >
> drivers/iio/adc/vf610-adc.c
>=20
> However, there looks to be a lot more wrong in there than just this.
> So normally for a device with a data ready signal like this we would hook=
 up as
> follows.
>=20
> Data ready #1 -> IRQ chip (trigger) ->  Read sensor #1 +
> iio_trigger_notify_done()
>                                     ->  Read sensor #2 +
> iio_trigger_notify_done()
>=20
> (note that the read etc is normally in a thread - all we do in interrupt =
context is
> usually to  grab a timestamp if that makes sense for a given sensor).
>=20
> This driver does both of.
> Data ready -> Read data from itself and call iio_trigger_notify_done() IR=
Q chip
> for a different trigger -> Take a timestamp and never call
> iio_trigger_notify_done()
>   or read any data for that matter.
>=20
> Which won't do what we want at all.
>=20
> Andy, if I have a go at fixing this are you able to test the result?
> I think the simplest is probably to introduce a trigger to tie the two ha=
lves
> together.
> We can set it as the default trigger so things should keep on working for=
 existing
> users.
>=20
> For more general case, we should probably have two functions.
>=20
> iio_trigger_notify_done() which is only called from places we can sleep.
> iio_trigger_notify_done_no_action() which only decrements the counter (or
> given this is only called inside industrialio-trigger.c could just replac=
e  with
> atomic_dec(&trig->use_count)).
>=20

Sanchayan, can you help to verify the fixes that Jonathan will send out ?


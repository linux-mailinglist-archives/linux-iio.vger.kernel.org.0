Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22516780EA6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377974AbjHRPKz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377996AbjHRPKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:10:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8D3E5F;
        Fri, 18 Aug 2023 08:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXAzrqxf0ly+aTT+0fdkCBytZ7KfITeNdpzNUooL1BX0kgbQeGeNppQecZo8Ef0ZjJveO5grhxTKUXLKF46yFy7s0KDcGQd70Su3kR4c3SxsfzTDQuOq8Seci0j5NbgX91cJmfkhUVb59YMlu1I3fpwT28Bd21B3UZYHnp8tjWLc7UXRMTPjqr31ekaHtRxB95ys1ymrSQOvpi3aT5Nj7gtb0wDo+CvqB/QXY1TMRR8SYvYo1hoUlW/rGYwJ2EB4bp7VlzUeMErHM0ww2Cz8d3ei9LncPpkJuCp3sqsDDmVuBOm4/30bOs1wVldPyMt51v8qS5IF0cSaEAybEfldRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/bgROJvKHYIia7VgF7/SW+OidaYqLqqRYb8OmtZhXQ=;
 b=MnUSDg3dndShGuU+gI5JA0BB1aZUhATz/iQfDOErgRfzQqoYkfCeZMtYJTM8uS7heaQAsa56+ge6HAbCyAlUKQhqBJF9C2CmzchER4l8D7Maeqv0eqWy9Xt05AAljQ07gwR1f+ldq97D1tUjO8+hnDubrmwVrxr1tLCxpwQt4Ly4dCQvtc822/nTqN93ZWaYC5LxKpp6d3agUbRxL0FmXyLn6nNmam0pGUKKZJzeCdTlTUEyhtMPkGSA+amavsUZXO2rTTB326O6dCZOPrGNGoW6/JQlfk99qbKAvF/UUvXLEWq5cdKGyG3CMMa4sJN2/OuuCFL5pscEQFz5k0wnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/bgROJvKHYIia7VgF7/SW+OidaYqLqqRYb8OmtZhXQ=;
 b=d3j1rsmnFINOBrtIEdciJRucHzmWVgoxG584NoJ/kFRcpMRHJu1OWv0mYmjz1dXG7qDPyw1w9SzXC5RFxcMPMfJbMORtHVuYP0sY7T2ScP8jnC59DQJ+AuOk6igtK/qgc18cAJ3L8iuDy/LBMo3fupLwgIN9H8L8B7/Wz+bxdMw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8018.jpnprd01.prod.outlook.com (2603:1096:604:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 15:10:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 15:10:30 +0000
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
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Thread-Topic: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Thread-Index: AQHZ0al75waOzG13YkKs2qyA0eDlaK/v6xkAgAACx7CAADjYAIAAATBw
Date:   Fri, 18 Aug 2023 15:10:30 +0000
Message-ID: <OS0PR01MB5922470607BA618DDB6CFC4B861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
 <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
 <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
In-Reply-To: <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8018:EE_
x-ms-office365-filtering-correlation-id: 01ae7502-8abd-4df4-2ba2-08db9ffd42f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHFYG5lv8psPcc4EHW8Pamb1dZ0+NKPq2MZ7Ea28U1WVA1I7duCU3K2YyQw7DKYM+6lf38ILcFaeqowd4N8bS1PLLRdpLDugaGqpuZQXTgdkfSffo9hSuyVdp8iKWE+t2yHVed8J8AVRxAvN66OUXr3CjkVH2RY+5LKWh9FyrxMb8bIN/bYpnytWpyMFZF6lvc+7Wj/mMiCRb/BwZxo1ouU9N/xsSYchG4nosUECfiKxtfhVzAbSJpxUBEt1gIa0H6Aavy6PofN4LurNLSru8SDxDUN4n/gi6o0QoRLUxnF9CtYA0kcKMeiJ92HQt7XO0vlTFtEPVjz7Fjz+FP6/zBsn3oz9mjJZf8qDD1nV3Z50yl4v2hhOxon9yZPWio3yIt5nxT7vRCRAiPeZJeOoFwUfwy39SSCiFCnw+ttYA4lX9hs3WnFNkOsxpuImkw5v0GZAnC8NL4z2SErgOhMD8yGTrCAXpHOCa5LeIF9Zcq265jThzA1osFdPpTt9bnzeMlSQ947N5aviGA4REK7+qgtpcVb3QCvnGRYM0jZidDtqk0i3NF+H2Gmt5+LqzRbpYWLTEipIad9b3KAl4WSBWjIiK2OdML/7q7aa45325/+RBFQT0srYMdZquVBH/Iu1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199024)(1800799009)(186009)(26005)(71200400001)(7696005)(9686003)(6506007)(4326008)(5660300002)(8936002)(52536014)(8676002)(2906002)(478600001)(41300700001)(76116006)(54906003)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(6916009)(38070700005)(38100700002)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3uRhtYXZ1SNjFC9a3y2lFnSXk1cpt26lVw8hDDzCn44qUjj/NB//dpeUK?=
 =?iso-8859-1?Q?PMo1eG6D7/SpAgrsl9PRMF2AW4jcyLwsxOGiKNRseREqPTOiYjs+1HdHpE?=
 =?iso-8859-1?Q?WJLS254WimUBxHW3CwzkXQuVlmJ2aWBdORw/PNHAfn9wurGy/sClWA6w8p?=
 =?iso-8859-1?Q?lGBWK3WWwsw9OkqCANjJge5EAXzyMFF6aCR34w44lrZmS4sUbjNp4yHuNV?=
 =?iso-8859-1?Q?gIzMkeJ7+eIM7uHXPgmoJfAmbMOT44kw8e2YzX6dfzv9+5DYp7eiHx2ndJ?=
 =?iso-8859-1?Q?znrOEYYhpMjDPSJgEaEuivBP08HKakbqF6KgbUnGjicwq66QmapZYBz66f?=
 =?iso-8859-1?Q?51iDHMQsnUznABwwQPuDwDcZETj4BIbxpwGFOVF7gCrEpASbwu42tGKvNw?=
 =?iso-8859-1?Q?jk+vhlaI7MuZG/FlZ8dNn/GTkAJPvt8PH9T3LHRa4ChEJh7ecXvk5TIr1l?=
 =?iso-8859-1?Q?KPh/rqAF6tYijb3epuVD6BB3UDHSAH3kq1Ocx+R4SEEBdYnKDm3auhZoIf?=
 =?iso-8859-1?Q?ZQGV11tEK4fi4cz4WE0oAuNE2y/hSUsn39QqPPReQIo7FM/AJy365yilt2?=
 =?iso-8859-1?Q?HOOQLrg7ZCyBKArIucgNt8IpKFjdeaEmy7WZWEv1fF8diWWSZpHcSHGpiY?=
 =?iso-8859-1?Q?q6toyi7aMdKd/8Waq1S4nlDlyRntAeVrd1WtV2b5q0Irs/lYPJEmOAqEbn?=
 =?iso-8859-1?Q?5FrDqGCSrJd1lgrhGj8oZ+wTK81VElkGn+jQAWCJs1x2WH/gj8/yoTi0ja?=
 =?iso-8859-1?Q?fY8RvbJ1bNq7NSbc9ywIjEyj/T+fdBmnmfI30jS4OIYNz66xJh7oyjiwoX?=
 =?iso-8859-1?Q?jkikSkpOMjWzm0p+M05eDaOjn+DtrjjL+eG84J4chE1vMQOHPhEZA0EJFv?=
 =?iso-8859-1?Q?d2pdA6kXMkxszwp6OKwD82eSmDT5VM9Sw1HgQWqsAr0VAffZZsgRguTZS1?=
 =?iso-8859-1?Q?uez9Kg4ms1ZkirQAhcdMmFObhJkQGN4IrFd1SSCRjCADO6rAWpr/9U3lkm?=
 =?iso-8859-1?Q?Pjm1bhqYX+G2h4VBHZIj5Zh0rQr43M2ZHB1SgHU29XgHw+QTocWaz0AoEd?=
 =?iso-8859-1?Q?9U+NdSLydc4wC1h/hcKULvNW0gwxv5SupH7jo+QWILjHq82Rl1TEJdipim?=
 =?iso-8859-1?Q?LcG/TGCw7uobe8dvrQ9lO2U0xF9RDAsLVpGeu/fUqSVg/FY0W7P1jr4YmN?=
 =?iso-8859-1?Q?lURJr6A7+/P0A2q35tNNvmaxzMOEMvDRQ2QXb4c6bSHhHMMTqHU3XgMPZF?=
 =?iso-8859-1?Q?pS4Tjt8Y8dqjYf0ZsJRZaNLvIYn2ytD5r1kt5Bco6Ebzj3u4pOXGqL7mX3?=
 =?iso-8859-1?Q?2e5DaQCKPIeviVginySKoubZXiiv+rYaoNTJpgtz9bKGCMr6wKmAjF3JOt?=
 =?iso-8859-1?Q?kpycnbcwvp/b1sAlHDFqLIKh/yPxONreiYrRZ7n5sPtyXb6K393lO7aotq?=
 =?iso-8859-1?Q?qu/sVYiUIFhgt1rbCa5OKmP2YejPazifq8twfE6MK1GAfxFDgDpGcxCWUl?=
 =?iso-8859-1?Q?/rBddbcHwKZbT4Lfpfd0IupHIu2EFwmrc+Z4CIYv39vm+9JvY5p2f1nm7H?=
 =?iso-8859-1?Q?lBaZDZMANkK+mVsWViElnhxRaCdk7epmlJ4wKAR1WCTEKHCnJGWg9mW5eT?=
 =?iso-8859-1?Q?yUhcJ5ZosqxRXCVLNv/403/XK5HSu4PocE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ae7502-8abd-4df4-2ba2-08db9ffd42f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 15:10:30.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaWMoChU0FDGcWBKQ50zc2gsEwbCWO0KSKpl0UnxRVS+faWe0LOjK4x4nJ+VBoIgqmBnxKA2kjVgsg5/gk3nxy8JO6XWz2UZZNaW3fParXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8018
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
> On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote:
> > Hi Andy Shevchenko,
> >
> > > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop
> > > deprecated enums from OF table
> > >
> > > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> > > > Drop deprecated enums from OF table as corresponding entries are
> > > > removed from bindings and it also saves memory.
> > >
> > > You can't do this.
> > >
> > > Only sorting by "prefixed first" criteria is possible.
> >
> > The rule applies only for fallback compatible. I checked bindings and
> > I don't find any fallback compatibles. All compatibles are just enums.
> > Am I missing anything here??
>=20
> Yes. As per above patch. The _whole_ world is not under your / our contro=
l.
> NAK to this change, sorry.

+ device tree

All drivers that uses OF table and device tree must be based on the device =
tree documentation on the tree.

I agree the _whole_ world is not under your / our control. But we support w=
hatever available on the kernel tree right? why do we care those not in the=
 tree?

Cheers,
Biju

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738425FB9F7
	for <lists+linux-iio@lfdr.de>; Tue, 11 Oct 2022 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJKRz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Oct 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKRz4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2022 13:55:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197F62920;
        Tue, 11 Oct 2022 10:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewvqId8LHAGRI+h4r96v8Zz80CmFFS9b29FSRsjMcJYMEQa394aDjo2TRP0CAgSXQKZ+Lm7PJ98rn2WNihSDGFVNw2vKApIGOlr4h4/uaqOkDJFHf+KP5iymwYx2UoeoLe5T+UxScC7xSpduH6SR7IzZ5zwBcDfSr9WH6xjN/hH5WeJfNPhy4befCb17F/oJU5HX6r+jkPiSWRh6gEaVEnLDJmQrxfVBs2kUgi0WY/lSDlOtoxT2liYYi0iEIMEeQ3FkrWgDP91WF8YK6tPhJCihBDbGJie2b3dNZJTN/RrOZwVddSoAqZWFUug84HEbn++SPupEAangiIXZ31vbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7Ll7zcJnCOzzdYMPDkZwkiNrG+vHcD6hmJ+t32UiiY=;
 b=F4CRKE4na5HAhWxm3a6I5EPM3v3en3qD4Yt4DVel6381VZY/W6AtxNIDWDiPxD2P31mZY3JtRPkCcJO7smDojbcgL+pLpfinrI8tfr4nj2Kj4o+yW35PowLRwABPdrChIEkxv+NVYKQ2MNnlQjt3l/+77QyBb9XJm22pzbptaZAThFXHZNaUodp+DG2dN9j4VQDscG7Tq3xBszu/93uHPi/W31MZX7TfadHGm4Bszu+2R4LcL6koCjS5c8EkXAWPRBif1U1HFJweKNhVcAPB9r5H0WF51wiH+EB+xUzf0mPfns/KahSPiarFrkbIPDLc8t5F0kwCYJQrNtglKhhe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Ll7zcJnCOzzdYMPDkZwkiNrG+vHcD6hmJ+t32UiiY=;
 b=OwtOBAp8a6T24Bz8txNuD1E9TB05dTm2teajSPP1Gqb4ACTN8P41g5mZuaEU8u/FwJ3z5tAbtEyA5vdZl1IFGclzICTbTe5KBbWPk+CS9ihjYKehfyjBYtRkk+SnjUyhLSzvZsZHJkPq0gAWDr6JVa9ZbUMyAvK3VzXVYv2zwfs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10238.jpnprd01.prod.outlook.com (2603:1096:400:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 17:55:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 17:55:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY2YuZOjF5ExCDW0e8KGUbGYk53a4DudqAgABULJCABSXXgIAAHhvwgAAu4RA=
Date:   Tue, 11 Oct 2022 17:55:50 +0000
Message-ID: <OS0PR01MB5922DDC46213E925988C2C9686239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
 <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0VsWdrpoAhM2jK3@fedora>
 <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10238:EE_
x-ms-office365-filtering-correlation-id: 49fa5491-39ac-4edc-cb8f-08daabb1d5b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlE03Ea0/FNeOyiimrtGPDtOWfI5GAktE4vMl6QGRA0AWjHD5q90S6I9PV3JKOQrT3Lw9ajHzUS/TUtDGUjmtjg/lcbXx6gHTxAf4iDgKqUtpt9ZIo1AwuYtqQ0eACYHPAlQf5n/UfCRWh3RPQmfIhLNPuxJJWAhyEOy5wls7uEWp7ekTySspnEKU8FhbrQ4/BElXmYlzfMn1MqgblXWW9gAEhQwZkWUIVl6hSU5gOHB4dG5Z2gSea6j3wxjDwtgnIJQFMZPASUBiD9iYwV8YtUO+LBYR2CSVfTWRMg/JE0WAhup+w4SpwCcuCynySaZe9o9gaQKpCFMAxSBJZOF/YvQVm41iZt7tK8YQ3ZbUuSobcBxVLB179WhtHdZ2E2RVuW9GeIUW5i2ZYffEojM1RdKIHtPyTvAo1lKtUHb1OeN8NEdIaa1kb3VV4ZEkxCE6twiPDU9XiHFJTCjir471tFOTC+zWBVkcZyLz93h0Z7Kh764/yORAz65A9afp5j3/2AzME3TEZLKKF0Ae0TShVNAXAxlP+zsf8mbWoarKxb3hPUqUc/cQVA7KkNe8AejggZT1ER8vt2lo/jrbXwbMdcS3Js51BoDignTSbpDXUw7zuLPgLJKKlJtb6cyfoUDrd2czECmwwyxivdej79xk27bi3DPlqSTW8jSwq/j/HCbBgAAVBdhs1TtPyx3jAYAAOJtBpD4fJR24mbGFo4QWr5atLkou8Ljeb7xnWaGFdRwH3lpStMaswy9LJCuE0YOKtZ9JWD9D5iOzKPLxObCNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(9686003)(2940100002)(38070700005)(54906003)(316002)(6916009)(55016003)(478600001)(71200400001)(122000001)(38100700002)(86362001)(33656002)(6506007)(7696005)(26005)(186003)(66946007)(66556008)(4326008)(8676002)(64756008)(66446008)(66476007)(52536014)(8936002)(5660300002)(2906002)(83380400001)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fwYwSxFgjRQiNlrBs0TXmS5Z3wKnr86ciNxYayaHcoF3YyvQWmMsofcs4sZ?=
 =?us-ascii?Q?FjrRD4Q+CGEd8PU6LilQ3XLt+rxF7h/sS1YJ3am35qxR0a53oglFX8OvY+wx?=
 =?us-ascii?Q?q/vX+Ql1L/UoHe1WwkTDTqWVz3M/XVTEmHK/bGJ/oPM8KX0LrIe5rUbOZuA8?=
 =?us-ascii?Q?xwKJy1ESkbtXtDW32yZX8/CSKt09hWLRE0vLr4eR2b5awtrcUWmyH3XKA32m?=
 =?us-ascii?Q?zmI7nApIYSUwzNKiKVmArjhpDFBBhvJBjmIr+V7yHYPrnMDBnxiJYZpCUZ4h?=
 =?us-ascii?Q?W0pQQJ1s3paQaMBzxn53CqfLz8NegA/qo5SpQAFHrnHdfF/hMc1iKMxBHrbc?=
 =?us-ascii?Q?9P3Js7f2NZ5mf2vMTeu5X3KcOvTsBwLzX/+YAYVkH15TLZOLAhz4ulubWk1/?=
 =?us-ascii?Q?7SI31oYfGsum2YJvDwHYbF/c7JxDF7C7N8T6TGlS54e0SL8KIa9xrZljKpth?=
 =?us-ascii?Q?CKE3Q3fKh9eQDuQoMpg3q/DVuzWB92lVLi8LLCKBwGV7SskbJKlrpgftZ44z?=
 =?us-ascii?Q?M6PgQBFg1GwLpyGfZcuVfpB/c4eGoD9XWhE4kTIMYqkpwcx4ecvsyf801ZLd?=
 =?us-ascii?Q?q1zF71UxZqFr3/UBAwy4WR7bXR33AT9wS8eLsAW+/It1entXnOQhsQ3G8dpr?=
 =?us-ascii?Q?WzfbtO/hqlMswitTTifPMO8ItJ8swFICT1eRWsmRCw9LfuHacI3iayhzrBDO?=
 =?us-ascii?Q?xLCOgHBh/FwsnGGZ1eYL1Wa+R7AsaJFNLW0EBn2yvUG1R69LfBDvQHCrKnGc?=
 =?us-ascii?Q?2WJ25vA+X6jln/Ut/A44dUbvrYa+r7TLVkX5SD6eXj2M5ZMSaE16sY+Bl6hf?=
 =?us-ascii?Q?vhSkjSb5zk796dVwjutJqMmz2fgmB4Vnhy2Rc7bsOeBunYcerlRZ38/rrKXj?=
 =?us-ascii?Q?bSn2xcCMKxY1eqqGtFsn7qfTfqwXmxsIHlu7SbUm52NaBLTegZM8cAbt6OFS?=
 =?us-ascii?Q?oUD5XNNN0+4Al1ti+DI64DxuJXDKbl2ZMuN2UaCVhlJfrNZWe8H6no2ZYEPP?=
 =?us-ascii?Q?JsGYIIR9xvL+5PVCYygtbS4CMhilGdz5rqHNYr9z600sJBEIWPkj1dEPq7xT?=
 =?us-ascii?Q?2UmGD6tb8ns1et5iE3zMGdgE3D0Dlw9iIIw8eElTITM+KI4tGoMShp2L4SVm?=
 =?us-ascii?Q?aUL9QcT1YoGQ69HIPRomysLf23Tm+x+Zop+ZM+1zDSZXFJVraHD++EAbAIgT?=
 =?us-ascii?Q?+GuvGdQqVmvkUGvLaLLJy+wew0fpS8tU4wQOAcVaENbNPM99GuMg2rWNIynJ?=
 =?us-ascii?Q?zztT3KqlngbLnNLETGikttFJvU306bLBy+OEFKp42NvEjnpQsKQl/maJlcbh?=
 =?us-ascii?Q?YuiOwl1YPrXGz8Wh/pFsIiuiah6Yud5E5nYD8W8WbrPqVGpnxUGbJUiWzm1Q?=
 =?us-ascii?Q?soRV0SBAm4C0gywKvcq8UI/k4orlKgyywORUtLrK+6Gzh992kDmUVUnp63hi?=
 =?us-ascii?Q?QYe8Zh1NF6iMCxnYcGpYKYRj0S5IiaclfRtq1bTdv7W4whweOkizEIC/M05S?=
 =?us-ascii?Q?/koMuVP71DsEkX2csVE+oKlq4oEy79haosOZZwOgcu89l/W5on90RtBEpHap?=
 =?us-ascii?Q?CDO9Fh4RSXSaSrksoJYFUbD8Vu8EGtLhWNKrO1rZTKNrs5ic3U0wf7syDdba?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa5491-39ac-4edc-cb8f-08daabb1d5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 17:55:50.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyIRhxdY7lb7ZmJoV9P79HMOfb1YRJwbAAyT53JiC9AnuS11fGQu6lVrQRF8ZtZACpIrazXKkSNy7NymEmmNkXF9FAJ/6oPvSi9/oJfSuw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10238
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: RE: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
>=20
> Hi William Breathitt Gray,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
> >
> > On Sat, Oct 08, 2022 at 09:01:21AM +0000, Biju Das wrote:
> > > Hi William Breathitt Gray,
> > >
> > > Thanks for the feedback.
> >
> > Hello Biju,
> >
> > I see that you have already released a v4, so some of my comments
> may
> > no longer apply, but I want to respond here to continue our
> > discussions; I'll reiterate any relevant suggestions when I review
> v4
> > in the coming days.
> >
> > By the way, if you agree with a review comment there is no need to
> > reply with "OK"; just delete the parts you agree with from your
> > response and I'll know those are okay. Doing this will reduce the
> > amount of text we have to scroll through and thus allow us to focus
> on
> > just the questions we have remaining. ;-)
>=20
> OK.
>=20
> > > > Looks like something different is done when ceiling is set to 0.
> > > > Would you explain what's happening in this case and why it's
> > > > different that then else case below; in other words, what's the
> > > > difference between RZ_MTU3_TCR_CCLR_NONE and
> > RZ_MTU3_TCR_CCLR_TGRA?
> > >
> > > RZ_MTU3_TCR_CCLR_TGRA --> for triggering counter count using Z-
> Phase
> > signal.
> > > RZ_MTU3_TCR_CCLR_NONE --> No clearing.
> >
> > Does the Z-Phase signal trigger a reset of the counter count back to
> > the ceiling value?
>=20
> No, It resets to 0.

It reset to 0 for forward counting
and resets to U16_MAX or U32_MAX for backword counting

>=20
> Does the count loop back to 0 when it passes the
> > ceiling value,
>=20
> Yes, it loopback to 0.

Same as above.

>=20
>  or does it remain at the ceiling until the direction
> > changes?
>=20
> No.
>=20
> > By "no clearing" do you mean that the ceiling is disabled in this
> case
> > and the Counter count increases without limit?
>=20
> Counter clear source disabled. So the counter won't reset to 0 by
> applying Z-Phase signal.
>=20
> >
> > In the Counter subsystem, the "ceiling" Count extension puts an
> upper
> > limit on the Count value. This means that setting "ceiling" to 0
> would
> > put the upper limit at 0, effectively restricting the Count value to
> 0
> > until the value of "ceiling" is raised.
> >
> > If the device is unable to support a ceiling value of 0, you should
> > return -ERANGE rather than disable the ceiling.
>=20
> OK, will check this.

HW supports ceiling value of 0.

Cheers,
Biju


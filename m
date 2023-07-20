Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F775B5E6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGTRwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGTRwI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 13:52:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063626A3;
        Thu, 20 Jul 2023 10:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UomzYALhnW1pWacYStUM6DGNa185Bf3SRhepFDJB6xuYLkbnJq2NazMOBn62D/aHcAdZqxYTBYrhZU0J+Xma8n2E6E1SA7hpCYxcU1gbWoa6+Ih7DKdGpQkuSYLXIASzfYPLPLozqf7RhqUnU/ZnFSSsnY+U7/zFvmMUmRsl6d+3wtLNeiRTD37ZEC2QkyVK10XGi7D+vY11i2mVN2MRvOEtp3SoFdkIAuyIZUJlacG6InU5hs/feNG0RLe+aXgeMPS0AgVeu+Ho7FYXuiAfl77zM4308tMSeT2/SIRVHtTuZQwf/VMi/nsYMOCxla3CAcWRgI8oJ15j3gbcO7ZBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7wI8zb80QLS0CHxAetecN243oW9KDIMW7edRxrCyV0=;
 b=TOKG+iGdNkhGSzzhZm61vnkf5bjSQfY3q/ic2Y5X1WOMbl2vZ0gAzv51lil1EPdTebCTBLaOstKSCKtCa+IKwiqdjYVWoT+clj1v06ahjgzpPOnApbMYb2pa5Ywy2tYYdUIOAgo+D12qhHdHDKJtHbbuhTcQMD2vmVbs7AMJMVyZBCDu3MSD+yX5P7R+VUq7i/AQai24kUp2Vwd6BawZM3NbudGwDlKwAJlHUZT/9d7NGUmYjQHFJsCLTWjtz4dGcgUCMoAxQ5OBXois2EFHxPYLpzDgTzxruyep3JpJ80J2DyNM9NSR6HTcSwR93qGDrGBtfBOHOrx1PT6QCuSF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7wI8zb80QLS0CHxAetecN243oW9KDIMW7edRxrCyV0=;
 b=YqCHP+NA6E+NTcCsm9J7ndaEso0yTuBkN/vAhfiZffJlO9UvYbQ8xc5CwwVXtW93F01yMIfw9Smgjy+4TWltCvtKyUDk1YZ4gX+/RHAexaTUN0IP7606TtK2tKDTKBIvQd0JZBiO8Ni1fcEQQ1ZgQsih2qFF2r5iUbcfftAlgMU=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS3PR01MB8905.jpnprd01.prod.outlook.com (2603:1096:604:17d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 17:52:02 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ef83:ef86:806d:6558%7]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 17:52:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Topic: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Index: AQHZuwuSpv3gkn/1J0+wg8hRJGO8+q/C5nkAgAAItVA=
Date:   Thu, 20 Jul 2023 17:52:00 +0000
Message-ID: <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
 <20230720-clash-borax-b458480d1579@spud>
In-Reply-To: <20230720-clash-borax-b458480d1579@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS3PR01MB8905:EE_
x-ms-office365-filtering-correlation-id: 40954c9c-1cbe-4d61-b87e-08db894a04a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkaG9FaZnXNpvf/JuPP212Cfmcm5DLBIXRxQc7jOKdSTdIwWPj+aEDBHa43kzsnfMcGX0FnqliDyiXFc4bDHC3tFn5vmtK6uTcPAcUI3CDEsJ5yrnLnRoP0RfgJdRMKOwOwT7DyxBQut3NTPi1t/LSP8fKcEi92JoH/EvrOr6zbNV7kHFwJH0yKacinh+TwM4wR064UJnvt9cIpsVH6Ol40u0b73HlgSFK3uRXdeiNevR52TreOqdOBbGuX356H05aZy/cxsvEXMHakbnlZn0N0MgBJHfivympEUzbcZqOHCLLqwV39ilEnxOTRyNfg1in47IxuVLIkQpq3tnqIJJ8Q7nzpp/kazG/g7Q2KfL2mhQqzm32MnOMTIZ7+y+j+xKyT660BUVwTMI5R6NFRTfjJi5FoyRgNhpi74h9I5DM1hyV9akCEbpVvj1l0FM6lITmlkALbbNICWsFAUgIkd9VvN+k2Q2DLWDWnXfUmRKIYTGzj8a15bfHWYWohHAO2bnM4xLhfoG7yz4CJnFfz36gqxyKhFpGXWOlR0k2Stfo2nOGkQdZEHKPhXBtPjq+uzp4kwZiB9+cw3IjFdshtNCZKjIXwJxJsV00GI5mSCYYPbCVqq4SWqH6/unZizxm/v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(478600001)(122000001)(2906002)(71200400001)(41300700001)(7696005)(66556008)(76116006)(66946007)(4326008)(66476007)(38070700005)(66446008)(6916009)(64756008)(316002)(54906003)(55016003)(38100700002)(83380400001)(52536014)(6506007)(53546011)(86362001)(186003)(33656002)(8676002)(8936002)(5660300002)(9686003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VEwoiRcWlO6iKCk/rDXKq4VFi4O9xcdEnqyqBmWfpVkGoov+80z+GeVxEz1f?=
 =?us-ascii?Q?Lr4p1TBOcsbwaiSIdDvpu0ZRiHzN4V8O7XsnXJaJtgQXjGOELJp6CJHC4L/j?=
 =?us-ascii?Q?U24buge+kODPicCA51VH0IVymJddaEn55MGWKbP2W4UPMpixF1cc8TpuyfNJ?=
 =?us-ascii?Q?JXep74IHOSrvsIVMjnrqkCkAeOc4SJo5T9dqcoNOVEp1Xi9uOz4ay3Sv+Yt/?=
 =?us-ascii?Q?ZM1J5f/u1Q0euaUewapHAW5YODMmM+MGKvT0L5Fy+0z9ut+wZF7CNhea5HJF?=
 =?us-ascii?Q?isjDhwgkfJwzbMPf4bICTqrgr2fECyyfhXldO9XiznOfxMc+8DtZnVn4NbQZ?=
 =?us-ascii?Q?+GL6EbskA+Wsn/81PGd9NqnNvrZy1GE6pnspI/uH0zrgcXCYZmn92Nk1yWKY?=
 =?us-ascii?Q?dCPMnsJtE34vBDbw8fdt/6T6Gw9rAOXLWQ4MSGgputW9y1BEYLDCE1NsTVMm?=
 =?us-ascii?Q?1RyXcLts9EXgNSAkAcebhfOYXULpwkvKMmlr867Fx21p/vKutBlASejMGXzQ?=
 =?us-ascii?Q?Wbgh8SWtVsW2VETF0KcNJWZ6YneDJEsz6diH24XI4YLS2+GTBKvjbzSjwXRR?=
 =?us-ascii?Q?lZbUnLZ4nzx6yJHVWPpvMK+FnXBX5LfynIA7XoUmnTFLyjnxbpASuLUdp2zY?=
 =?us-ascii?Q?Y3FLHNo0u75oSit0J422oWOhZ9L7603WLakIqmkx2LQpqSQjsabbxYIscPGN?=
 =?us-ascii?Q?Jccz/bNH1727F5Y7FWOpaIE2nAiSKesbmOtI//18FlllZoX6A2+G6bXboDue?=
 =?us-ascii?Q?HsPFkM1hpiirI/+hwljQ1eFz/rZpiMMjopQ+RpBitJ99gWc4mJszw2oCq4Yp?=
 =?us-ascii?Q?c1cpvnzeujhvLWYSXIYwGqgp+iFRypjOxANsnngr0Vy9gv7VZl7QcgUSt7ZC?=
 =?us-ascii?Q?5apcbWcz0tHCq063e5YYESgIwN6gf9rcaheeP1tt+QyqwVfx8EUv5N8nKfgO?=
 =?us-ascii?Q?eniLe65KcnCnbtot/sASfQxZKoTwoJyYDoJV5SjuShTrMChIN+RHKl3Mtavv?=
 =?us-ascii?Q?RP+08Tk47psbtVJfqoBraqXpzLP6NpiCqdN7ukHyDczeXU2z6HZkjtnr9zJ2?=
 =?us-ascii?Q?fXAVmVFs+z+h4982dCXjvUaQ+CpvUC7JAEOKU+FMTUfYTTBTr48jRkRWdNse?=
 =?us-ascii?Q?f7aUJKoddqX++jcqNGm148GpN1bdTz6VXcY5AGQuMS99tLW3Lwny2qToTtcO?=
 =?us-ascii?Q?HmIKr2ayhm0oQM1lra2m7Ri75XOfaX3soQw15LS5Oyfcr4YKmHWy+XrTxzfD?=
 =?us-ascii?Q?5qQwBoVOPetrQgyy9NF0cHUj9BL1il2sJ7WrfTwgsLy5z7r1+SBjwll1DJ/X?=
 =?us-ascii?Q?JPBaAQbu+1Bk/+EV13pGLRJYQBDgQEcV0Ps/ljG70bfXzBxXIrH3cuzVn071?=
 =?us-ascii?Q?tgb/eheMZAUWpxaXtxa2NBNeNZ4gFC5XLG1v9cgX7sfp2V+6j80kcVQ+fWxC?=
 =?us-ascii?Q?mQXj8CXmGBvuMeJbuWZSt/y7tMYAHPQe7zTZiv523Ui9L1HUjjG9AmYXlobV?=
 =?us-ascii?Q?Btwq2Ue2iKKVUOiIl2xnWO1Qvts4/4qlSgHG0J3kYvkkHyaDWApTALQLivWE?=
 =?us-ascii?Q?KGKXTP5FJeKUNJ3hLbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40954c9c-1cbe-4d61-b87e-08db894a04a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 17:52:00.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoQ4XjEMIYrwFNWc3QAKshkZpqC8jVxrNvjiddRdmw1roL0HH0UA4d9YJiMG9RiylO2UiBs3mIGWyh0hl8KRGW29bRV9xAvshHqa60d1mZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8905
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Conor Dooley,

Thanks for the feedback.

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, July 20, 2023 6:19 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Magnus Damm <magnus.damm@gmail.com>; Lee Jones <lee@kernel.org>; linux-
> iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> devicetree@vger.kernel.org; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; stable@kernel.org
> Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> overflow/underflow interrupt names
>=20
> On Thu, Jul 20, 2023 at 02:10:12PM +0100, Biju Das wrote:
> > As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> > interrupt names starts with 'tci' instead of 'tgi'.
> >
> > Fix this documentation issue by replacing below overflow/underflow
> > interrupt names:
> >  - tgiv0->tciv0
> >  - tgiv1->tciv1
> >  - tgiu1->tciu1
> >  - tgiv2->tciv2
> >  - tgiu2->tciu2
> >  - tgiv3->tciv3
> >  - tgiv4->tciv4
> >  - tgiv6->tciv6
> >  - tgiv7->tciv7
> >  - tgiv8->tciv8
> >  - tgiu8->tciu8
> >
> > Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a
> > bindings")
> > Cc: stable@kernel.org
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I assume this means that nothing is actually using these interrupt
> names?

Yes, That is correct. Corresponding driver doesn't have interrupt support.

Cheers,
Biju

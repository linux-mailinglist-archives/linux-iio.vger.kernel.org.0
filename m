Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2975CA7E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGUOqq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGUOqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 10:46:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2910CE;
        Fri, 21 Jul 2023 07:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdhXavzYtZongg+HlSPaCUXjn/ThtBXar5OkGfRZbb10okMamRuZTv/xNFCT29UHhOy1k2N9bK5KXw/Yj1ZecH2DfZrDxQdzldudwSMGm4jlKVQn3pzyE/SJ9RvbwchcF1W5APBJahWfz1XbsUZWeLxUdlFuPwx/eyn+Qwi2InsDc2rSifU2ZOtdhiHrNhcGWt9oSBCQtEV4AkAJO0LYmA0TA3zvmkL89X1C+WaGiLKDMDwGY3EIQgmKKL4HlVFNfMKUjTBfUYwfA+hkVThJNKFxkftmArg1vfPK8T1oysTtPTyp1g7aNo4PSR/OktFgKAFUSxwDPaGyWYrX7ZNi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxKIxSnI2lCoM5KTW7r8pJa27MDOD1Vd8rR5h+Oz76I=;
 b=BS/tM+0kndun6A7WFA1orKteojx4Ik+DPBzbnJi7vy71VI/Eo2wvxSH+LhmmcaxgKFrLSatV8wcEL7Ni7Yv9mie6CoG4k5ysLJN1CfXcAN7qP9qn6zHzDa1JdOk/unSBaDKtfReISqNfX83IRvK4RgEFTv/bBHPOPLEYvKCoD7l0WLtf7E2y9qf3mil3Eoap3sCc952e0nI4Qx1UAoFuXZh4Sz2uVTIN3jiScjV+7OY42uvSWa8FpHKzvrGrxh469pucwrXOWEb+PcOhobulpwXdVpTMywTcAT9PWTYhIhLwS0k4BagLx4yDmPtM7D03NdWJhxl+CjPlTUA/FI6LEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxKIxSnI2lCoM5KTW7r8pJa27MDOD1Vd8rR5h+Oz76I=;
 b=UTIPgSBZ+Rlf4ZC6vk4mJk5TW9Nys0X0ICEClfbphqiZ3whB87J/pnI4IM83qPA3iAir/PT/t3ezA3HCCrfGGPPxJNU4B1kU42Bcn9v/UjrUufCYlE2uANlHiBqvFJyOQ7WZSnvLuaCM2X1vqo2ZZ+n2SrP1m9O2rh167RxzwYs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10841.jpnprd01.prod.outlook.com (2603:1096:400:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 14:46:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:46:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] Documentation: ABI: sysfs-bus-counter: Fix indentation
Thread-Topic: [PATCH] Documentation: ABI: sysfs-bus-counter: Fix indentation
Thread-Index: AQHZuKZR65AvC6f56UGIOwPfOcunuq/EO7+AgAAW3wA=
Date:   Fri, 21 Jul 2023 14:46:36 +0000
Message-ID: <OS0PR01MB592247928C590E19A5EF776E863FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230717120039.164804-1-biju.das.jz@bp.renesas.com>
 <ZLqGy3bEW/+xiq4Y@ishi>
In-Reply-To: <ZLqGy3bEW/+xiq4Y@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10841:EE_
x-ms-office365-filtering-correlation-id: 19814abc-4c68-4758-af5c-08db89f948d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efVFqd8BLcKtvORP4RFAPhT5wZ81Ks06RkSXQbrUMsOj6RqwKYE/726mXNs6wl97LiXvd/VW/ITVbvKeHCsWIxABeYTml0iTJVVmSZi0/rC1eV6NeijjxOgGXFo+VEwdMYf40svWTsouHmwuLNSosNFnj30exedt+pV1zfqdxyHfSgEkYJNEDyPrVa+vwNtq9PZvh0/7Mx5X+gmh70+jADKy2yMOYRoSCu0DUujJmkkx3I30yvEX9zCQ4oZV0bJDNP8oqAtj2EHrXN1kNwxL5x2/38Lx5F9SlPnadHXYELfVayE5v7vs41nz5pYTZvR2dSBPGjMWxbem5ivbRhMIgcJimWzAPxwHji6ArqulWcqdHR1OiNIudjlnIj4A57VIudy1me0pin+gs3/t79na2FoK3F4nEgs0pMj10kcLpq/oiVIQAQrBp3oqUX1cWsDNZhQiY/w63vnXoF/2UYPAGaDlXPKrvCb42PswWK5hjESHdJ2HtUfdMLgOlDlKgujyrW0HTOUODeCd6wG+9ayUPZ/HvRbIgUgjfHiBcSCDiTcE2pXtM5T3pM+QI94J8Y7+2yXog4gkJChbm52TNvAlbs5rr5bZt+ecoCCSnAq3STQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(966005)(478600001)(7696005)(9686003)(83380400001)(33656002)(55016003)(38070700005)(86362001)(2906002)(66446008)(66476007)(66556008)(186003)(26005)(6506007)(71200400001)(64756008)(38100700002)(122000001)(76116006)(4326008)(316002)(6916009)(66946007)(52536014)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJfMzgzGTEz9rIHQzvwP7Gz1RaYuw2ibKxvBayYOQHH7MG7o2JQ7pbcp75bC?=
 =?us-ascii?Q?tnUFgDPK60QT/Q8704YERAXU6jFH/d5KBFtYpVbednxb4rpInkIt60IxveZz?=
 =?us-ascii?Q?PjdtfYxTLv9IViFaUF5KvhXHsCSqtuZpljBzT6zHSMK7RktQg09HeLwr9etI?=
 =?us-ascii?Q?fc+j9iIP7Nh0h9oToKUq21/kiJOe+xVejPbZvbhuZAbn1WjCb/STaQsF9ce5?=
 =?us-ascii?Q?WyU+TFV09mpxYSdvlv7F0bEbJdc+4dmls/ZvMnK3ZFQXRKYz4s4LEaORlsjh?=
 =?us-ascii?Q?DOmVAaBSsnlkRkqjsVrglgfNXT/Dq47NVp8O47jIVWQbKg1/fkamcQqMkUXm?=
 =?us-ascii?Q?SMBXUetZdbJ+6SPxI08AVTfyxg9yHAmq7DkHwLFprMASv6UKjMQc0IUT5oSb?=
 =?us-ascii?Q?gIjxLJNVi/Vkitbh2aizPrRLIM6HMR3iKuhYkr4mRbFSfZMs0puW5eCmaRtc?=
 =?us-ascii?Q?hpcb5gQSOlC35JK9nseyJDoB+aeXgfClSGOAjxJfGOzmtgKVLSan8uVBPXPv?=
 =?us-ascii?Q?J01K+DRIvZuXYM2vpGY2ER/tCv0bq7ym/nkOvvBFHxOc56qkC43tZwMxooGx?=
 =?us-ascii?Q?16ZuzseX23yqSOxcMwzkk/5BbQu7TCu+/bIMQbNNnTcVO+60UFe+M3FKfYfm?=
 =?us-ascii?Q?m7Ri/6Fmr16pVxRT+56y4Ei43ayZ5jAYO86tUAiIv94PmL/00es5b+hC07Tk?=
 =?us-ascii?Q?mv2aywUnWqq7J1gQDzyYIjfUl03zSUkdRYJLxq5KEzYHTioHILQavIMrFf5y?=
 =?us-ascii?Q?4PjQZi8WJQij/HuKzupb5C+2agNtDXAKYJhgM67Bxfs38SVO45egEnfY2Dha?=
 =?us-ascii?Q?VBOKDfEXjU5Nx4itMbDdc769nrK8zskHaLjLBCnsNsg9WaeurVH+Vf2GrZcr?=
 =?us-ascii?Q?wBXcWHg41wcl76WpeTyftukZrzxltCk+C9D7LvAd/8o7DLSxqRdjnjSW47FW?=
 =?us-ascii?Q?4KxJytGuTbyOhQhFSwsmYynfcrXcsHb2UJU0EwexPEKlaT3kH5T4aQ5DF+I3?=
 =?us-ascii?Q?H7awjt5gUOdQ4z0aVMbMDvqgoZXrXytBRN5fvxX4TBCAdOrixzTnO4EBPq39?=
 =?us-ascii?Q?GBsZKNw5hDjxyAjMBHdQiSFuxdo5/v7M2Pl8ZDC6rWY++4ZnV/0IAW9wf2b8?=
 =?us-ascii?Q?BJiMat/Q7p9aXzEs0yJlS//HiWpCw9tKPnANuQngqHyusJigHpOwz7CJ26WP?=
 =?us-ascii?Q?grXVIFH7SBj+NPPVdLpouXurUDz8nILU2KcKfwTVSZKjm4D7H55odItSERgF?=
 =?us-ascii?Q?MkmNCFbKg0cZUmakdcTE4dHefHitbuO7RPApKtLZD4Yejr0dOgqQJaek2T0x?=
 =?us-ascii?Q?9l4cZsESlV0oM4GWDcFKk4a0Vnu/bouJQr0+GJliuXGMfso+PgIobtoUQVwz?=
 =?us-ascii?Q?ebA89EYbiFSHl3IS3ezix0Q+urQs53iTTpobVhnvPqk1cGq+7SeRss1Fcd54?=
 =?us-ascii?Q?3C4f5EnbftqFu3N0nvyBpKhs5HdEE7gZMein0kymAGEmrHdrfjKLbnJVkEhA?=
 =?us-ascii?Q?NgK602ESYfMEnu6TgZwQ1wR7LT2hAmNDJ678I4PWWOyTyx2uIsVqPJbSkWGO?=
 =?us-ascii?Q?BQ139IHkNwARYfKcdwIFb/K5qqF0fmcSXMY9CQxW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19814abc-4c68-4758-af5c-08db89f948d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:46:36.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxv33G1L7fWaJgzLOr0tvEg+5MQboTgqTQ4RdXY1w3xwT3J1A1B6GaRn98IS3JFREVJ5AlwRmsFPEOHeSvUBNl+cH809GktNJ1eUlj3B+28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10841
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH] Documentation: ABI: sysfs-bus-counter: Fix
> indentation
>=20
> On Mon, Jul 17, 2023 at 01:00:39PM +0100, Biju Das wrote:
> > Fix indentation of the KernelVersion in external_input_phase_clock_
> > select_available block.
> >
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Closes:
> > https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.1831
> > 32-5-biju.das.jz@bp.renesas.com/
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter
> > b/Documentation/ABI/testing/sysfs-bus-counter
> > index dc3b3a5c876b..7981dcbda624 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -22,7 +22,7 @@ Description:
> >  			phase clock.
> >
> >  What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_selec
> t_available
> > -KernelVersion:  6.4
> > +KernelVersion:	6.4
> >  Contact:        linux-iio@vger.kernel.org
> >  Description:
> >                  Discrete set of available values for the respective
> > device
>=20
> The Contact and Description lines also need to be fixed, don't they? It
> looks like they are indented using spaces while the other blocks use
> tabs.

OK, will fix and send V2.

Cheers,
Biju

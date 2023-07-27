Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D127648A8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjG0Hdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjG0HdN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 03:33:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58B9B;
        Thu, 27 Jul 2023 00:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE1c/yCm4cTyM/1sTJFeVxcRsWW/mQxPrRUU9ZD9uHlFS92pFyGVMXGtaDu66c4883Sd+79c7Da7G/dU3pUZ6/7SEiGCgXhn4npoFXxrpCRxUaav8dIvWgfRZ3EN3NcqAI/wEYS+sNSyWOEQ+zOcW6WGvJUAI7pbHsr5t6lY1ozMpvnWOFJQIOT1Fp4S0VOm1CUCX8zQnGe5laRxJNwAluOmMNc6aqtyCry+HauQBYRGn5VWisTDZK2iYX/WJRssXF9U0IOmQg613Q8CLQcwAhEqvjQyJTXDpEt4JWWhZXkL79z3jjFpmETzux+QzHesjsgCuKqT3wrUPBfN1vTA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3XH9FhAaAsUZjGIJPXz7aLxtKYa7JPOuVCeLc+QiUU=;
 b=HOpHJsKHk3YT9drNaOHR31F1d0LG5u1B1ki9n0yocBq4OofX8Y1BMdF0iDbRWGIjJ2QCCF11DDCZgV7lcbVoI5RlQh7yYBKePoMM6Pht76BZ5tTMSA9M5VTbCYnjlV1xTEQqTZwb4OU6chROdzs3j0TNPXr/Z2PXAxMg48Oh0DTpHVM9s7o3YjpzrPj+sGHp9UDNUNFflN3hn7oK3s9sKWyjCP2ps//jOaCsnQE75VEvm12I4Vxcs4peaRXRVolXs0jBGtJZ9HpObFloQt3bGJ36ute7kPn5McRO+1tmSbddJUPdOutb6zEOEU/BbQh+7k16dbWZNOYZG1Fenby9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3XH9FhAaAsUZjGIJPXz7aLxtKYa7JPOuVCeLc+QiUU=;
 b=sOMi2U9epp8JH1PLDeSR+QDMti3oLbyJ7vzlL8O+xTYqtyAooq8abqWW0CTXkBxErdXyATE4LGG+7glQQJgGYcASEAxF6iVQo+hPtn2zUrWBEhczM598VVo6FiJu735RHgdCq7QF58xpFjlnuZ45XEuPHljM6ZAflGP3Ubbsgoc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9574.jpnprd01.prod.outlook.com (2603:1096:400:1a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:22:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::8f98:d64b:f092:766]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::8f98:d64b:f092:766%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:22:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] Documentation: ABI: sysfs-bus-counter: Fix indentation
Thread-Topic: [PATCH v2] Documentation: ABI: sysfs-bus-counter: Fix
 indentation
Thread-Index: AQHZu+XPAXGkUlhEB0S2ZTtawRPxM6/MnfCAgACf/KA=
Date:   Thu, 27 Jul 2023 07:22:33 +0000
Message-ID: <OS0PR01MB5922DCBCD32A6CC9675DF9228601A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721151243.282435-1-biju.das.jz@bp.renesas.com>
 <ZMGUmed0JaR0dezA@fedora>
In-Reply-To: <ZMGUmed0JaR0dezA@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9574:EE_
x-ms-office365-filtering-correlation-id: 0107ec4c-1ddb-4729-8dc5-08db8e723f20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aS5nXgnqG3WHxKupVTnMbg8RQnHW2CPER11yfG0jJvjMprvGDjDrmRSB9RBawuVtz7oIYJfJ8bc1RgDR8Ghqga1s0cSHWtSvS13vFYRu8UDPaBFiLnCAi5dlJx5XWKfaIltq+GDTo7kavEy2gET0DSJ6CBNHbN+4L7jZge7f5OLgT/dxETj4qOkfcCGOtf8o4stGsGbLukhcl4cjwZE6Wwwr26Qcv7re/i8kyjYokcMSF524pQS7ATDiwGxD/XuKxd3StlFiusbS1cZCUdLo/KQTY4MWJSvQrUwkKryEMlTOf0hwb0O99L0MYUq7XkHT9AJlSG9qQJJoUgRiGi8L9j7nM6lOqcUbOsRmFQEha7WV0jYEvdhm5Ku8DZ/8MNgQVDmc/csa7bHNY2sbuLXoElRxPquVsMa+Lr6mPnfRLhGPnfqQFdR6weivfiC+HzRqjh1YLuOotMTmWRY9hmrYnrzxXnTOxYxrxR1TrUpKu7DqXVEXZKizaBFfVSYVl2yFOWNw2OXwzsLPGkL5ryZOz2gA2JVcx2T7b0BGkS18w5HEx/8qIpN/dNb4LGaosUi6PMvEjQfzYmEDlu350QDzS8OCN6GWugNEBzJQ78CyBqRCO8iavzEVV8lSJ9x5plrtK/NC6cRQCicsDpudBAnZFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(38070700005)(86362001)(33656002)(2906002)(55016003)(186003)(83380400001)(26005)(6506007)(9686003)(38100700002)(122000001)(54906003)(478600001)(7696005)(966005)(66446008)(76116006)(8936002)(4326008)(64756008)(71200400001)(6916009)(316002)(66476007)(66946007)(8676002)(41300700001)(52536014)(5660300002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w8d/NEcZVDl8uNQjaoVtcmo3YEgSEtWRzoDdXSLnoaBQDinHj9hgfvBfiv2q?=
 =?us-ascii?Q?JfouVWSi0i9MxJ+aAAQluH/bfn+huSJtiYT3qRLJclDLLMduE9Tz/Wch9UZt?=
 =?us-ascii?Q?ZE4NxSYfOYFaRyz2dOzOAIaxOMT8JgrMG5MFJjVo6ujMSUH0gyteHxqxISWR?=
 =?us-ascii?Q?stS0ghm0gU0bdxUZduAJZlpU9kFOKkv7YUS2BqTrGnDGjQWNwu35PhD47xnA?=
 =?us-ascii?Q?z6LCzIrY7H4EWw9QfL2dhoineEg0rsQmLsUAWT1v4s86jBz43hNH5eikJidj?=
 =?us-ascii?Q?9PKDzDE74b72AfukneOfeXLZg5OpmpdU8BnSGzfm/wROlp442+1Zz+ltucqj?=
 =?us-ascii?Q?LcSwp8SspmudsLkaa9wTUdvP0EC/DCmPssiOhuhaoHQC7EU6rYiOWI0QzuHy?=
 =?us-ascii?Q?bNkouoOWnwEDXlUIj0Qm7XaRUymQQc7uVZX7jL23h/RywVlpHq0kRz3WUxSE?=
 =?us-ascii?Q?n5KYixHjvjE84QGNnpf97Ba0+TDf/oDSClSLypZs+xdC999jY3dTTHwW1RWg?=
 =?us-ascii?Q?6gXilAJOeCJ57AY78GWZg+Pm5T1PiAh8iRoqR6jr6fvGr3rJih2v5tZeS3mu?=
 =?us-ascii?Q?4g4Fnyy9q4DV4DMz/zibD5r0aYC5u2bMFI5o42ChVFWdeukPvZFQtC6Z5Czs?=
 =?us-ascii?Q?jsYPuvW/50h1GZplXZZRIiLMHwDAmKpcFSiU+k8I8TQr+t9g1vXUuGp+aEZF?=
 =?us-ascii?Q?cr9xII4s7sjkAkJvVKawrhX7EnQ07VhxUnELy5PTwveVHVexGuLkjfnc1t5b?=
 =?us-ascii?Q?WAeQR4g44xqMI/dd5yuCfmgD9ciE7WcasZsPRCclqTDRVfcSeD8Q55KdbVAP?=
 =?us-ascii?Q?QYquSlMQNMNNWoleeIHj9PC3m6YjGW+BmrV+cWogxwRcwkOBshUzLxWhcNV0?=
 =?us-ascii?Q?/cWu0NR8JYZvvK0hcQW7LvL6aFZzARvXRdaJhbuebQT9VhoGv7XUs1cZaz6h?=
 =?us-ascii?Q?qEw+4R4IFNwAb6bMmuLYqOIj2YYTzliIK2u9q4hs/WCmFtZ8x1QXxPs4ZQxP?=
 =?us-ascii?Q?YIk8qduPbAXfzHgRbvqs1lj6DsQ1qiEHWCLKuu56qZRFFgQhVIHvVvAxEaW/?=
 =?us-ascii?Q?O51xjXkkWBbpJxjWlALnBhQz39oQY5TiJM01MsJIywyl6JN1VHUFl7DFh9+K?=
 =?us-ascii?Q?+G7JwZNPpZ6JSVE6gzc6wFDgYVbnEX9QXZkbkEbNBjwrdfcD/ZXem6FPKLyF?=
 =?us-ascii?Q?rXeQ/B62wXuy6W4Y5BFfwyRCV8ZsgCNAJnI1Kqvc1GG6ibWpYj1dW00hej2Y?=
 =?us-ascii?Q?lDvrHn356Wu+6eXqZ/quIw7hje/uR3m+CEPbM1AQfXycKPf+8h3gk3niYYie?=
 =?us-ascii?Q?ghLaoQIQjBgmYCMWCvBDHjO2YulCYdLydTvit8421MPiyNUsE7MdsjmA1OlZ?=
 =?us-ascii?Q?LDTruCmjSbjXnRM676SRQoeJY+0jMMOrK7OuV6atu/5Ul7oG7ZISTv9sfxIv?=
 =?us-ascii?Q?goH0a56meuiCBOSj9rUJFEyrhzV73Hx/mNqI+h2eH13nL/hADcZf3g/Yjk8e?=
 =?us-ascii?Q?V6Lk7R+N2gyImyBrXn2EyL3UUhTn/F6SqzJravJIXJiMU05bV2DiZraP4sAM?=
 =?us-ascii?Q?EHHmJlGU7yj3ZfGUf0+Qa3AlGVOOh5cuHb2ICOnr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0107ec4c-1ddb-4729-8dc5-08db8e723f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 07:22:33.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0rbBTMQhL6VFg7kHM8arOiGL6PQjw+M0/skrzmC2MLz8T6g6L9if8tcaOF/fHHiV5B72DzABhCqqBySctqqQ01aLC+Sy+PANpQih735RGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9574
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: Re: [PATCH v2] Documentation: ABI: sysfs-bus-counter: Fix
> indentation
>=20
> On Fri, Jul 21, 2023 at 04:12:43PM +0100, Biju Das wrote:
> > Fix the indentation of the KernelVersion, Contact, and Description in
> > external_input_phase_clock_select_available block by replacing spaces
> > with tabs similar to other blocks.
> >
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Closes:
> > https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.1831
> > 32-5-biju.das.jz@bp.renesas.com/
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi Biju,
>=20
> I'll queue this for counter-next with the Closes tag changed to point to
> Pavel's initial report on lore [^1] (let me know if that's not correct).

It is good to me.

Cheers,
Biju

>=20
> Thanks,
>=20
> William Breathitt Gray
>=20
> [1] https://lore.kernel.org/r/ZH8D3lCobUJP2T4K@duo.ucw.cz/
>=20
> > ---
> > v1->v2:
> >  * Updated commit description
> >  * Replaced spaces->tab for Contact and Description lines.
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter
> > b/Documentation/ABI/testing/sysfs-bus-counter
> > index dc3b3a5c876b..73ac84c0bca7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -22,11 +22,11 @@ Description:
> >  			phase clock.
> >
> >  What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_selec
> t_available
> > -KernelVersion:  6.4
> > -Contact:        linux-iio@vger.kernel.org
> > +KernelVersion:	6.4
> > +Contact:	linux-iio@vger.kernel.org
> >  Description:
> > -                Discrete set of available values for the respective
> device
> > -                configuration are listed in this file.
> > +		Discrete set of available values for the respective device
> > +		configuration are listed in this file.
> >
> >  What:		/sys/bus/counter/devices/counterX/countY/count
> >  KernelVersion:	5.2
> > --
> > 2.25.1
> >

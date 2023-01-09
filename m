Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493B66210E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjAIJLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAIJKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 04:10:16 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985B1658D;
        Mon,  9 Jan 2023 01:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P59g+cG3pUvwGuvTJNT+lGQHSMsugRLMAcgYEc5KNo14CVsfnVr2x9YAwFaL0JRSkPVp8EI/J9WCAR3tbA1nCKyjK4jPgprE7qboiOPCQDN9Seqa1GRRuShhjQgTGHkJCKXweecRyiVjmX5BkzJg5DLBlCnq9VcSsPKQ3UMNQODDdzZ//gY4h5exgea0iOfNZdT20IX5vaCIuPFt5T3PRaOy0CeARJmig6xifloa7HZR/Np5ZylpqX/4xKbEVFRGIFecCN5f9+MV3evS7df9fNX4Tob4x5q0Wdk+uaGrYxbLqR6ahru8iviJjzohkMrw64zUd4g1M2yUesJ+ZlDoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wJdEwAW1niOl62cuaTG0SjG+AiWiD1C6ucd/WAFdxo=;
 b=HTyX72POrn4nWaUq9tOyzOtUQRrrUmv8akJWu3FIQ+0zyshmAnIQu8wF3LMWZCQTB9tDHeru1FlaGKQgHpFR4uTZyYyrVern3bcYRKMIi8xt1W8ZA8gIexyShXiOM/azrm8/8ojFR9cH92Oq6NPYr56YvPIYTQ+ohytZepo8npnfL3oMkpKH3of45euxbSjt/K0syg7FA+9QxuABMLpufOW57or+/YmxxV3NR7W2kNbowj/tOZpK2ZSWDJRSrmaoElB4vqFYMl61thSGqxLJ+SMepr4dGuDPQjCzQ2D0dExWLA9TjT9gaHNxbxpyThIgZWVTm+/EjZgt+q8cF9TKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wJdEwAW1niOl62cuaTG0SjG+AiWiD1C6ucd/WAFdxo=;
 b=XB1pWtCPAaTYiputxTFZqQgoVYSOZV7CWtz9wOX/jLlO9v55SLGWCzE4U3DukDUpOYtDq6Y/yOohNQcLuiy9Y9OTF5vGY/xYXo/nmNu9NuLhW8Y/6mUtmQ+A3rIqEFAfzaTzuw8rxmr1VLCnZRBinANOTMOQYZhrdUjsLJSSbng=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6171.jpnprd01.prod.outlook.com (2603:1096:402:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 09:06:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:06:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZEZAUiq0ZEMlrLEO1YySNLLmjlK5xDEGAgCTjgxA=
Date:   Mon, 9 Jan 2023 09:06:23 +0000
Message-ID: <OS0PR01MB5922B7898630002D7423F42186FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com>
 <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
 <Y5zm78UPXQMc3gjp@fedora>
In-Reply-To: <Y5zm78UPXQMc3gjp@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6171:EE_
x-ms-office365-filtering-correlation-id: 2794c672-96d4-420e-6af8-08daf220c7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBX62eU9Sxn9nQ/KRlvU0wChPrf59V3epBHBAckdC0gJgMz52DUjnYNs6otnPKWdGTIn9rrXBMalIGgqYAWEHsj7PhfAB9/TIxyQtytFQoJzz1R4LaagjKs+5oGUgawE8YGOpjdp1qe2ZJdB8OHBCFGSKubbEvEmhGI6pq/Jf6a/y0aeJjuVDhV6Pr9Z7TgwhZ+9kQoNMtRH3uLwRH7Jq3MRm45Oyvq5N6I07pAwcMtI4wrhroLiwZSowO93CnHRg/MyElhs2BzCx5RaOT8/2HSYaTEHhOGIGpNtYncQWI+FQ1DoPt4u3ugCbqin/5wy+PUitMcjUfkTGbRdYdWc5dZY1GnMYi6KL3C8SvU+izLJrEccP9152Fp903gTMujUOQQvs5yfOemDxaq0D2Px61Cfkv6GK0pXux9UucYMzCThua6Js1xgOkNcAzGlxdskXcp50XLgGMCSPaWM8VxA5uQm5yuCFC+Qp/voQfn3Frd4Ac9l2KkPlwiMrjLpo61Y2d27eQDDAIYGUhZXP+XnLf7c2Xy0O061GivQfvVd21AkEezCT/VC23qoV7ldkt+bGOqrnsd/MfVm5whMnFvjybQ4+MGvBkGMDlHyll1fCgERip9Qu/3u+L6I57qZ71IWPdoda9rZBLT+ckfKG45R+Sxo5CKLlekRdvGg+CnomQjXOUtmm9EJMLwxVs6gGVV1VcZtTbnLT3SvXFnxhWgTLW/78DAFGyIuN0znjOQASD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(186003)(8936002)(122000001)(52536014)(26005)(6506007)(54906003)(9686003)(5660300002)(55016003)(33656002)(66946007)(66446008)(7696005)(66476007)(66556008)(64756008)(6916009)(4326008)(316002)(86362001)(38070700005)(71200400001)(38100700002)(76116006)(478600001)(41300700001)(8676002)(66899015)(2906002)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yNsitwrPpSfesz9YdHWjQRsWCSaupVrPqzN0mzwjgyGMdveZcP97P5MenPiR?=
 =?us-ascii?Q?kAD4NoJGEaKT2KVXMvUAxByQ2YShJSnB+sQhoMMj+bp91HvH52TodaEmVO5Z?=
 =?us-ascii?Q?IJz5oee9+oPxnW2a9b8GSFEyi7BrMyLRFyKPsz1NfYB85o3vqA9PHutcI788?=
 =?us-ascii?Q?G3EMBw6WvnodYd/6dgBxXL5Mq/U3hc/8cnUQKnLCyZ7QuYtdm60IfAopywsG?=
 =?us-ascii?Q?JwimDkw3R3JHJ8ff6kBdJIUIlClpU9eFC7AM0gMqY9QymW6FMqE3BWvyc9XW?=
 =?us-ascii?Q?4yO6pgp2M9kZ9cyvtdUoPhrOqGSIysxvla3CoSA/hXdOm4Hcu+u1is5+kGhl?=
 =?us-ascii?Q?xE6d2BrW9FRF29IOm5cDobMDTdt18IKAr9356AbqPQDM+bAGgptJrEIPSouP?=
 =?us-ascii?Q?ncITl4mvu6orjyzhyBuwD/UdOJiRctjEBYS8pI4W8gokJjLpq82D0rmUjaTi?=
 =?us-ascii?Q?c+RctTEovVFwY5KGEzdnp4M4EukluJ9bgZQLo032YqOQMwmS99ZB5cw+ZezQ?=
 =?us-ascii?Q?4RqVEk94B8kmaQsYKJ4jM+g5OVl0IoQxXn0TG33COsWsZMvv+iJL+vWI8sHm?=
 =?us-ascii?Q?u8vDOSE/C5z4LnIi4gwZqqZmLVXkUzRgyma3oSk72+q49pQkx2exFTxhk3ga?=
 =?us-ascii?Q?nNVSmgWvXvw/hh+wlz8yNqRKKMDSUpFKbkeCHqkGjH5WVcNJFnFHAreFDBYT?=
 =?us-ascii?Q?8HiqHuoY73GS0w0zyRf1iORaFcTh6rQotfHCYiYY71WZ9Pr1y9iQm3U1XHXj?=
 =?us-ascii?Q?5Rug0AB/fgQaOgvPtGTgFitXITd0C8faoUGqOUVuZXxSCrgAEY3IXWUGBlyW?=
 =?us-ascii?Q?fs4e/R0kMc8Ht6WyjpJQdjInhDN8Nr655387lm1iSGBI9dgZ3luzgInQ/ZBJ?=
 =?us-ascii?Q?oNihdfYnJZ7aIc5K1O5PK06BreIr4MALqf/qNbNsPBkCtHopm7WegkDGpyHg?=
 =?us-ascii?Q?p8Y7zOF1tuwKfbC013v6KtCjBArXmTOjW5UUACFjgFhLusim3ag+VY6AmOye?=
 =?us-ascii?Q?waRk79kaoEFbivzKhzgnujMWM8o1j4TAX2Tk673jqC7EggwGy+DqcZhjEzft?=
 =?us-ascii?Q?BrkJuRdrkd3EFUZ5QQpGyj2gQPO2LnueRBD0d3zYQAufj2sXAfXMEiScjAoz?=
 =?us-ascii?Q?yXeB/ZEoIuzOmUZjnpkGkfGYJ8t/oTkcvTHmJUA4cJ+DCI91iu+dcJBnoL1M?=
 =?us-ascii?Q?Az0Dp7UU14kqYVGA/0KUsd0FBv4WD+Ovx1CL7KbCGYID4O67v5Yg/xsHagcd?=
 =?us-ascii?Q?4hoWNwq/ZFtBHKZjdjSr8kasfgYPQOJqU4aZ+POSeyPdu5Toznw3i6zkk3mD?=
 =?us-ascii?Q?mUhwdO+1f8pbiG8lQMuxv/vUdlPkDj0GdxNrV3zKwZU0Wep3fFhUtFnQFDQB?=
 =?us-ascii?Q?4+VF/kJ9j2mtwvdYvnUrjyRvDOOLbEcw4bKAdPdErG/mEDlEf06R6X6NNubZ?=
 =?us-ascii?Q?HrW/TPi93t0uxmwgjs+pQsfTvjtwTobGnK0m95LcCnqLYOgMUg9Ch7iphrDK?=
 =?us-ascii?Q?y9i2CVzvQyG2uxPHxFW4uBLvbA9swZKClYUJKLQ+ZBTKWAnrhn4V/ikroH3g?=
 =?us-ascii?Q?Vy97fStnS4Hs8RdePmVIvVDpYSzgSsb/f1VErjgP6AGMH1kZ/x8DlCmWJ0J+?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2794c672-96d4-420e-6af8-08daf220c7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:06:23.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ING9qJo7v6iZW6yiyZmJQvXSN3xkB6Wm6fb7TVd7Lf4D6tYfWYFv9+0t0DOJhMJJIzb5QI12neGJR2vP7fnBMbcRRABVoOzvM2Zxbh4sgW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: Re: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter
> driver
>=20
> On Fri, Dec 16, 2022 at 08:50:27PM +0000, Biju Das wrote:
> > Add RZ/G2L MTU3a counter driver. This IP supports the following phase
> > counting modes on MTU1 and MTU2 channels
> >
> > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
> >
> > This patch adds 3 counter value channels.
> > 	count0: 16-bit phase counter value channel on MTU1
> > 	count1: 16-bit phase counter value channel on MTU2
> > 	count2: 32-bit phase counter value channel by cascading
> >                 MTU1 and MTU2 channels.
> >
> > The external input phase clock pin for the counter value channels are
> > as follows:
> > 	count0: "MTCLKA-MTCLKB"
> > 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> >
> > Use the sysfs variable "external_input_phase_clock_select" to select
> > the external input phase clock pin and "cascade_counts_enable" to
> > enable/ disable cascading of channels.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi Biju,
>=20
> You're missing an entry for this driver in the MAINTAINERS file so please
> add one. The code for this version looks good so you're welcome to add my=
 Rb
> line.

OK.

>=20
> Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> I do have a minor suggestion below.
>=20
> > +static struct counter_count rz_mtu3_counts[] =3D {
> > +	{
> > +		.id =3D RZ_MTU3_16_BIT_MTU1_CH,
> > +		.name =3D "Channel 1 Count",
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_mtu1_count_synapses,
> > +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu1_count_synapses),
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	},
> > +	{
> > +		.id =3D RZ_MTU3_16_BIT_MTU2_CH,
> > +		.name =3D "Channel 2 Count",
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_mtu2_count_synapses,
> > +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	},
> > +	{
> > +		.id =3D RZ_MTU3_32_BIT_CH,
> > +		.name =3D "Channel 1 and 2 (combined) Count",
>=20
> These channels are actually cascaded, so replacing "combined" with
> "cascaded" here would be better.

OK, will fix this in next version.

Cheers,
Biju

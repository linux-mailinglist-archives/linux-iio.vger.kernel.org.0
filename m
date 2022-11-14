Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D92D62877D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiKNRwg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 12:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbiKNRwQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 12:52:16 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BAF24BEA;
        Mon, 14 Nov 2022 09:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjpDKhtBp63ynyuV0OnY88NULyacYtEUT0PGaf3eSoFq6aNkIluX5ff33LYyF5Q9L4TvbFnzPkivYDI3H+pGewW+AmYvLy4pigK/2VpDY1UqwIkOaUW03qUmWoUDV6tM2X9OmCEWze3jSklXrXEMFp+0u26n5WPjKKjn4+0zwUJc089PmGukfhjyZCcjwa2vKusW/bY9ZijWXG11uEaEVNy0rLSe0JBlgV+JneFHLoPKmLDRuFyBKkOoNbDmHUG0WaP/VswQMmFamx8OnSfQLEbZ9GfEkZtpf5tRKrm8glJ+auQJ91LIlf2R2f2HPnt/wEJMwi6Ard6SlIvErdJiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAeE7KtGwkcbZfEXH38csgmJtxyG/osqrf4TEGeQEGY=;
 b=kvPL6Eww8P+1dzIbSXDd+MI5EcPpWzlPk1Z36N9qvK2pLb7RJO02bvZO/bojqL1PiO+HZUN9Zd6PyZZBKMULNPAk7uJRfZqPEhStgsbdZPuITnNbCPeyBjIqT91UVcLOj6X4qAej+0lJvHNJ0WeFxoGkLTWzeaZ5Qnzzbu0hK0cGNDIriWTdm8fdOYvOq5clD+cXpEXIZalnjGL3c3Qi42jh03hJVxtSxRUyef6orA6Z3uFS2aesnsHZJB1hGpZj/+tlSmtNIugVasTWrhY9zYHf+9d9ZtpgdX+ZuPHD/WKUXLPx97VGujM+7FmjD/wTGPBLCUMGFbP7uA5fb5AhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAeE7KtGwkcbZfEXH38csgmJtxyG/osqrf4TEGeQEGY=;
 b=lI6fFALCvB3r+lBHHmqs/35Qvyvrrok6VP7Ngx6z8yz7cB5j935pWUS7G52xRhfj67Jn8SRntsLeMWVGf55ZIZuE5MxdljWmwjG09uRZdR17k2XYdTzrpIWgwJwBlGqwOBjEjcFjGUy89XQ3hoYUggCRMFBLp+AqBZw1Z4ahGGE=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS3PR01MB5621.jpnprd01.prod.outlook.com (2603:1096:604:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:52:11 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::dc1d:adf8:9948:6dae]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::dc1d:adf8:9948:6dae%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 17:52:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHY94Oe/bXNEYoN9kCntehmCzyhdK49yIiAgABAWdCAAKsZ0A==
Date:   Mon, 14 Nov 2022 17:52:11 +0000
Message-ID: <TYCPR01MB59337BB8E20273468F38560E86059@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
 <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS3PR01MB5621:EE_
x-ms-office365-filtering-correlation-id: e56fa7a4-9d35-4fff-df4c-08dac668f515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjM7pq/ggMYqirBWl6t9RHh5b+N+EvKopE71OmTWxAQYY9dF+A3gPbYyhXGSd/IF1yHejR1wImF8LmQUxxsrU8gCzCpmBubVSWHC6xVl/GWtdiq0e9J9UReGnb8oYlf027XFZ1DPCK3P5Q7NeiFWh0yVbmpw8hA8b515VnoxiYWx2VJGnXgh7jRFRzsk6bqZEWsO3NMFomtQi3JziptQ8EIvYnbyJHO/EwYe6GlZGsTfPHB7S0bKekm5wY8Jj5X9XXDH5GwrdfvTSTdSSlh3KXEb/2UWck6IQE9SPXqMM/W6NDUZcZdWCegn5vr66cj24hwPvwVj+5c5rc87eL99EE2GX7b4tdWjKZ9DHiZrX7Z/Uv9t1PuYFMCkooubwhZeeMg0BG7MHfaFR5ePcpUG99pXtI3sV9tYMzxclwPaNtVFes9bxdMXT/eWNmTKYwh2918ut7p0ApCIUTvF63R982Abiq0IUMMNbS3LXrCIQqdTFOJqUoWtDhEKcoRD+3JSb8mfWzV/2uK4fKycF/csEiyWX77LR4orKvLn1tsG0YSc0M2VQ9ovVheOJ2g+wy8Trc9BvF1MBT9a6ogMlYYqbir+0CKbt9/IpnNCbdHFncZhabKiF0Ka3pPqGVVejX3p1secbnDCT6Gbu3dKB1JDJQCrYzA4mgbikXYx1dBuwZbzQ0m4jUrBSE3wNQWcAweAdZH7rWp85htoXe1cX4+gTV3SYnl973vZFmLnwNK6LIGasYk+7C1POkPmXx8HKRPadgRPNGbV2XWKCaMt9fshF0sQ0HBYhz2T/RqAGiBqzgkbahOmyrHj31MlYD+TUizj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(6916009)(71200400001)(33656002)(478600001)(38070700005)(966005)(54906003)(6506007)(7696005)(8936002)(26005)(9686003)(66946007)(316002)(66556008)(4326008)(66476007)(76116006)(66446008)(186003)(52536014)(8676002)(64756008)(53546011)(5660300002)(41300700001)(55016003)(83380400001)(2906002)(122000001)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?orQmvepEYSYSS/bPHuRUcpDpmDf9VeWeFqkxL8yvnFzGyQRcbYBQ8LvLP2UB?=
 =?us-ascii?Q?g7z402LNCnfayR3wodOZousRtAcaheM+rRO5QV0aMsKMqWuLuFlkrnfcoiok?=
 =?us-ascii?Q?kgg9pwgNm9rpPYW5EChzmKWycQx3+6Ra/K7bL+J5dWGte6H043FVHJBRLBSm?=
 =?us-ascii?Q?YLRSpURP4RUC4R9eRUz5YISl7nPuV/pvNbmxltiCedt/HPjzzvB9kwr8xcOb?=
 =?us-ascii?Q?V1JmN/MDDlUH5mPa/9C7sASrZxFkhlO5/1n5eIIl9oC1wiAhYmG8a6Xu737t?=
 =?us-ascii?Q?c7lUS3E73/CQO2Dr2gHxfZZHcp8vQAQOOQ2xSh8RStAfYKSB1SzCFtFeC7OE?=
 =?us-ascii?Q?8If/Ccf/qQh3YOgHqL6nOEGk0HJcjY3IVlL3DsEEvGu3jzjHYQ75KiQuRNf1?=
 =?us-ascii?Q?YeT0Nxav/s5JQZuWED1YwJtHFUaAtn3G4ipHLNJHYbSd6ozMZHFbqnOzBbw9?=
 =?us-ascii?Q?B8a0tXcYmKv2HTKGyLEaYSLYezcv378HgFWAcgJiu3XNfjas20WQR/sateQ1?=
 =?us-ascii?Q?J2quMfOha0q/o7YIzno1+J+WT/Gqr42UJ4c/Ayb6MzZb5NoOSH9LyesvvBpn?=
 =?us-ascii?Q?9nfTmABPSTyFlUkGfVvetci3xRJi23X8+PgHphxjbF96Fx/sUsdyafb+AGhl?=
 =?us-ascii?Q?Z/WbScKmzoZEZOekvAHUSHNWWpcMBzoTBC87CfF8hXEi1RWLPO/fdhMlECsH?=
 =?us-ascii?Q?lNLXcKrldERxRbAvrw5rKojtujGJHRU/ywTp0xLrtxRS5wnDBaMJ2IZlN59Q?=
 =?us-ascii?Q?9q73wrbbj7V8yP8FtEmLt60gqMlkgSKwi5hrj2p6fI+J4TkPqJqL7pTbL2xw?=
 =?us-ascii?Q?WNnxeVQhzuhA815D/R8VPuwcQ7eIMj/Z8Pim+NJED7asLkWFbH1hRGX3JglP?=
 =?us-ascii?Q?+K/5vKLVduAuRXjSIIFqoL7962kAHScWzViHvXcbZPXT7M44dSqKI8bV/LO+?=
 =?us-ascii?Q?ItTkkMpNsVHKPb9ZbMVk/2WhxXjpgHOzxXkCSdlCz3a2zhier51DkWtqPQ6x?=
 =?us-ascii?Q?uCCXqD+vKUmzcDXulaecAOaZ4KjfnI2VRgcHhgV6jICQ8Fyj2gkeXlf6yx37?=
 =?us-ascii?Q?F4xznoXwCspb3i/NBCkPno4hJci8x5prXWzaPpsRUffk4TZyGa38hKbmkEiB?=
 =?us-ascii?Q?MioEzaKRkAkboNxbABfIGGLPthQqj9ElUgCK+TC+YJQBca/5zWqN50rb9Ycg?=
 =?us-ascii?Q?TERKbiJsYjZbXS0I0HXC2PAITNOCM+wiCqQCjOJPjskfUTpGEB3NulqV/A5q?=
 =?us-ascii?Q?OHCU1giKD5j1kr86YCWKJwVdLLpaYMwj0q8EU1h9N0y8+6LUnm2Xp4U2CraQ?=
 =?us-ascii?Q?JAdcAQO4cFOS8GQ3xPwved1hXzsP6mc7kQg8qncXVEA1ErX5a8eZard+Nfbs?=
 =?us-ascii?Q?G88hL20pZeaIF4ZBHn97OlCXAeumnGbGzM0hKVCrWQl+FFNm3WNIKjyoO3h+?=
 =?us-ascii?Q?1aXH65clwjLt91QMmT9NKhi8gVJfh1XcP+094LMSZ+F3Z1+rfnC4lZPcugHK?=
 =?us-ascii?Q?iUd0JXvjEuJxs3YvTdLkPPv9LVy7vfQfaVvYFrQYxBQdZqrfPXUueCnsGIi0?=
 =?us-ascii?Q?PMRx3twC1nAIbqByg8X5xeD1fWKmWJgWq28azgZsxObX/0qCK8n+izX/X1lC?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56fa7a4-9d35-4fff-df4c-08dac668f515
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 17:52:11.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iJMFSq+Yn7mGagbkT0C+LbcwFci+ls9b2SoTtUIUEAW1f9Ot1hXeUngRydW4Nqf0tbryrs8d612pf6SKKu+dRRZuvxDJFUSl8R8TfLyxs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5621
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > -----Original Message-----
> > From: William Breathitt Gray <william.gray@linaro.org>
> > Sent: 14 November 2022 03:47
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: linux-iio@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > linux-renesas-soc@vger.kernel.org
> > Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter
> > driver
> >
> > On Sun, Nov 13, 2022 at 05:15:44PM +0000, Biju Das wrote:
> >
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > +#define RZ_MTU3_GET_HW_CH(id) \
> > > +({ \
> > > +	size_t _id =3D (id); _id =3D (_id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : _=
id; \
> > > +})
> >
> > I probably missed a discussion about this change in a previous thread;
> > what is the purpose of using a local size_t variable here? Is this due
> > to the "possible side-effects" mentioned in the patch changes note?
>=20
> Check patch is complaining
> "CHECK: Macro argument reuse 'id' - possible side-effects?"
>=20
> By using local size_t variable, it fixed the check patch warning.
>=20
> >
> > > +
> > > +#define SIGNAL_A_ID	(0)
> > > +#define SIGNAL_B_ID	(1)
> > > +#define SIGNAL_C_ID	(2)
> > > +#define SIGNAL_D_ID	(3)
> > > +
> > > +/**
> > > + * struct rz_mtu3_cnt - MTU3 counter private data
> > > + *
> > > + * @clk: MTU3 module clock
> > > + * @lock: Lock to prevent concurrent access for ceiling and count
> > > + * @ch: HW channels for the counters
> > > + * @mtu_16bit_max: Cache for 16-bit counters
> > > + * @mtu_32bit_max: Cache for 32-bit counters  */ struct rz_mtu3_cnt =
{
> > > +	struct clk *clk;
> > > +	struct mutex lock;
> > > +	struct rz_mtu3_channel *ch;
> > > +	u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> > > +	u32 mtu_32bit_max;
> >
> > Does the ceiling set on the device get clobbered when you change
> > between 16- bit and 32-bit phase modes (i.e. writing to TGRALW vs
> > TGRA)? You have a separate cache for the 32-bit ceiling value here,
> > but if it is getting clobbered then as a small optimization you may
> > reimplement this cache as a union such as:
> >
> >     union {
> >             u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> >             u32 mtu_32bit_max;
> >     }
>=20
> Yes, it gets clobbered when we change between 16-bit and 32-bit mode.
>=20
> For eg: 0xbe1352 value
> Split up into mtu1.TGRA=3D0xbe and mtu2.TGRA=3D0x1352.
>=20
> OK will use the union.
>=20
> >
> > > +};
> > > +
> >
> > > +
> > > +	switch (val & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
> > > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
> > > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> > > +		break;
> > > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
> > > +		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> > > +		break;
> > > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
> > > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X2_B;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> >
> > Sorry if I asked this before: what are counting modes 3 and 5, and are
> > they not supported by this device? If they are not supported, please
> > include a comment stating so in the default case block so that it is
> > clear for future reviewers as well.
>=20
> Our hardware supports 5 phase counting modes. From that list, I match up =
some
> of the functions supported by the counter driver.
>=20
> counting modes 3 and 5 are supported by the Devices, but currently counte=
r
> driver is not supported this.
>=20
> Please see the attached counting modes 3 and 5.
> https://ibb.co/3YJByG1
>=20
> OK, I will add a comment for the details for modes not supported by the
> current driver in the default block.
>=20
> > > +
> > > +static void rz_mtu3_32bit_cnt_setting(struct counter_device
> > > +*counter, int id) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > > +
> > > +	/*
> > > +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascad=
e
> > > +	 * counter.
> > > +	 */
> > > +	ch1->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> > > +	ch2->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> >
> > Can these "function" members be modified from outside this driver? If
> > so, you could have a race condition here.
>=20
> OK will add channel specific locks to avoid the races.
>=20
> Do you prefer mutex or spin lock here? As channel selection is based on
> runtime decision For both PWM and counter??
>=20
> >
> > > +
> > > +	/* Phase counting mode 1 is used as default in initialization. */
> > > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
> > > +RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > > +
> > > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> > > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
> > > +
> > > +	rz_mtu3_enable(ch1);
> > > +	rz_mtu3_enable(ch2);
> > > +}
> > > +
> > > +static void rz_mtu3_16bit_cnt_setting(struct counter_device
> > > +*counter, int id) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	struct rz_mtu3_channel *ch =3D priv->ch + id;
> > > +
> > > +	ch->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> > > +
> > > +	/* Phase counting mode 1 is used as default in initialization. */
> > > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> > > +RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > > +
> > > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> > > +	rz_mtu3_enable(ch);
> > > +}
> > > +
> > > +static int rz_mtu3_initialize_counter(struct counter_device
> > > +*counter, int id) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> >
> > No need to complicate this, just use priv->ch[0], priv->ch[1], and
> > priv->ch[id]. Same advice applies to the other functions as well.
>=20
> I get below error when I use array susbscripts. "*ch1 =3D priv->ch[0];"

> drivers/counter/rz-mtu3-cnt.c:291:32: error: incompatible types when
> initialising type 'struct rz_mtu3_channel *' using type 'struct
> rz_mtu3_channel'
>   291 |  struct rz_mtu3_channel *ch1 =3D priv->ch[0];
>=20

I could use "*ch1 =3D &priv->ch[0];" please let me know is it ok?

Cheers,
Biju

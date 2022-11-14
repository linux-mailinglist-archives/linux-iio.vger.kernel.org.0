Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD66283CE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiKNPYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNPYc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 10:24:32 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC0205FD;
        Mon, 14 Nov 2022 07:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDT4uZwBBOJdrILkl8JRvXx+1bUxMvgCglmUSmSelcGZ3wMpng1AC0GU70X7m6lMQHODKRjLfcg7+ylmqGgy46ZbmQ9sS7kxVTZu8s4oMpp7mzuliCRx4B9hXF8/COTxD/Qu3ltreT86kb/vYDaY93hRpfvSiyFlGgK9hRkuQZyrLOtMYy3teffBW9TT6KlcNkVVOfivnQEtfQaHcIqgvs/DvpW26wrXnCirNPd5tJktF8kHP4lR2QSQaPOz4m/8yuAuZ4scOqLglb9vEnULjGwI3Qju8KdnOaWdxV6eQRuYrF2gpBjFF16v0izTQJHLW/AuPfL9WLzOmiK4DY75Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSjT3mHcStN6jyBMI9q4eTlxEixEgxBWZ1DxqzNEFw8=;
 b=V5U4ShBRl4BDd5nXVffoHxlN4Uzrdt6HGoYJElM1kiXTU/vSIa1rCwqZYfd74oxQFTvsNW5REoYhEqtFFzbsSaNzN0j0kGNcVhf3JPR5rdoi7luUDBeKuaAdTmoMmOy2l/hItsFqc6HDhtfN8aCbNBrXphGgeHFKu+Sr+f4UMF5IN8MYpNT6l9wcrW2T7JbtuaAThQg7szoUHAu2QcWG+zB12Cjz4qhgt0ygdBfvKnJ0gncIPyfkU8hQN6RgtUE2vu2pFmfLgClcWXhQEFT34UXAEmPdi0b5eFalV4ccz5xuJOMkKyConRIVeTJvhqoiU7S9h9Q76J5V3YBUueympA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSjT3mHcStN6jyBMI9q4eTlxEixEgxBWZ1DxqzNEFw8=;
 b=CEi9w733SCxUTSaQew92bkXxGrXBcPZPZFLAeMMG3TafGpNB8eUJ6Bo2JnASWr7FrgLqIbEzWfT6o0hVqzjtLANJgPmfm2GsBNahcQTRx38h1/Unz4Wzbnm45FjbBVDzxh1F3AALyp9p7ZRpOdROff+U17zaf/i6VEw/RaawPHk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSYPR01MB5368.jpnprd01.prod.outlook.com (2603:1096:604:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:24:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:24:26 +0000
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
Thread-Index: AQHY94Oe/bXNEYoN9kCntehmCzyhdK49yIiAgABAWdA=
Date:   Mon, 14 Nov 2022 15:24:26 +0000
Message-ID: <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
In-Reply-To: <Y3G6Qe0KMdo2PgaG@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSYPR01MB5368:EE_
x-ms-office365-filtering-correlation-id: 88abd96d-ed0f-4a8d-fc7c-08dac65450f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQVqnlHQN7gL/8+n7J5our85eTd4F0HMWq2Sfk3G4WNF/Ro6ZB4WPuMYe/5ZaVeotAQ5Um8oKeOlfd7bnHdOVl2YnINwcmjyx6MJs+MAyCFPqO4Ya9fceeGXpU9h+KwY1MxKOfqIAvsR6inPG4g45yueTzFTKPgt/fYbZqSgEwct2B3GCWYZBZaGJyPlozq0rc8AlJP0hvsEV/NaJ1TCSrrSzGatzTMz8Vk0QqIUk2S81uYVFgkFgchy2GmH6pdBBzRt5lKHGmOSSiYMn+a9j0mKzAbq01v2WJDZhXZY5gi092fcljYAuusk1jkDBzwv32iH7XYbK4eNeV2ZHffv6Iz716+gS5EgF264MIllk1yh1XHkFI4teIrQjUGmmdkng8MkjMC9balW7ssU3+AxMXGVWKKvFtcUyBnpFhfjWfHI/UhyZmOG55d7Ab+uRCo0Cr4NegTvCB4d0SG9sv79J4i3M/KXWzuiNSxj602Cw4znjsXbTeQGMHTRKYe7Eb7TTQ0+YQlWWamXaBDGoBmfnanm2CXIetIvs7AR+by3ASBBqzlqtILjL/BtRxuEeCN/Qg1/9DRcWfob6YRpHQ7Yk5BSsvFFuShEoqA6PcKxSlP8aBQ4dkSA1W+Xg13pwIQwjU6vGupNC2m3sD0F25eFxOHM7WcASClHNorcwhhJQDWUqhUQfIbQDcj3lHhv8FiWmDUp8NhnAduaAkDGACCW61Ya4j333tTqv+8EFcWCIT8swRiRP/MifMUpEyvp7kUM5VXZoTCgOLS9IaR3igxkzxIHkXeNKVZH23t30OmtAH51g5BhhQ1SbPdWISnefAmR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(52536014)(66946007)(8936002)(38070700005)(33656002)(86362001)(6506007)(7696005)(38100700002)(122000001)(53546011)(55016003)(2906002)(71200400001)(41300700001)(83380400001)(5660300002)(30864003)(9686003)(64756008)(26005)(186003)(966005)(8676002)(4326008)(478600001)(54906003)(6916009)(66476007)(76116006)(316002)(66446008)(66556008)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoVZ8IpxS/XINYknQNvqgQQpwluqZlz9zdwgfQ3pLGrXARVI6/jZZmGUiUU2?=
 =?us-ascii?Q?GfggZT03C7W8A98PsNVePloDzOFLWPLkPj1/3xjxGbWL4l7AHK7cCEaYZPvL?=
 =?us-ascii?Q?ze4iYaxq3Pw81lWv2mHM0x1lZ605LVuRxjeIl1/DPyJwyzpoMVS5b4p3As3I?=
 =?us-ascii?Q?B8Z3qgBelT61VxaNvlquk7TyDtwGyvjPzkQ/dphx6alDJXIpyz6AgxfKzD52?=
 =?us-ascii?Q?yzVu/nLBwSlM0izzGVIusC3cV3Q79y98AcKV+Gi3qrMHQp+9SPMcDQbJrWmN?=
 =?us-ascii?Q?GYhiOwVBN1O8dbDxdLPLgz5wmdSzToCqJHsrYaZ/OktwAFFAMy8Hzknay8dT?=
 =?us-ascii?Q?6T8/Dz+WeAekirsk87y3y185/g4VJYDuOC62/v2KYsB9OELUFGYHwWmnQDGs?=
 =?us-ascii?Q?NhG2Hfx4owAq/ARJ2uXGxvbLaZ3DOiecXvnOy2Xyo0pEWViF6uj9ofEQEOAM?=
 =?us-ascii?Q?aCgCgW3GDVnqbl6mYlKacLaZ45huHev0XujAfoeJfjXoQ9UozXsU6Zs+xBkt?=
 =?us-ascii?Q?af8luHX3WfAg4j6yCTsM8apsudA8KYKsM4AI9aslddeHMhngnkfo0fd3VYjO?=
 =?us-ascii?Q?LPzgN199HZxbz31yPJD69fE6X9XxHZxp04wgKomi0cRGJ9W1MiZL4zd2dWZQ?=
 =?us-ascii?Q?EHcUJE+MX9tL7DhVLTUeGmtfwTNavg5Ja92BpEz5/2Rw53Br9WtU8+FSY6o8?=
 =?us-ascii?Q?EfiTjm5LahpwID9orVldQi00JCbCta04YjyRXqYs8kMwUsmGRQwhSXu/oz7J?=
 =?us-ascii?Q?HnOnkB0ghsu3tJ0jzU3c28Tv0QKQwUFbOXk69CkJdrhmhalLwqofHkyhM5mG?=
 =?us-ascii?Q?E6l26sOOwLR+cNU8kFCL9rVMjMUyOnBH49sQ79ozu9olKR0WfcE3DCLN2fNH?=
 =?us-ascii?Q?h3V3auSfV/eOPUJq8PSVPfYD12B/S+Sfv121mAEXVECGvofX1nGyj/X1b2oP?=
 =?us-ascii?Q?dB/mwVSXu9nIDnqhwngKXxbK4JescPUD2r+m+GpQkSaMZehD8Y23r9qqBp3y?=
 =?us-ascii?Q?R4gbTUAOqEtfJwcwqGtn7k/8OhG8w0y8DuxkJq4vipF1HS/KZ+/kzYCenXZS?=
 =?us-ascii?Q?dzzFrpI54qv6jqDeHtKE5l5ZdYObsySbhcH+Q0RAxbLtdBYKsX0IRGCtqJEE?=
 =?us-ascii?Q?wkhjJa/OKJw12Rp7k+p2Jpwr/ofGkKEzgDgtG//NeojYyh8Cwy0btqmog+Nc?=
 =?us-ascii?Q?8YUvGstP5r27NvkQY1Q0w5WfX9hiJ602kFT+aerbqUvlaAuMm6uLwswYhPvZ?=
 =?us-ascii?Q?EeNCH25/wu38lTnXuMFu6+BU3vO2p/idH+3QyHvzEo6YaG+yu4P0rGMMeFkv?=
 =?us-ascii?Q?XLknFW3/vJeYXfZ1nD97zcLD5djvDOA/Sk+iH/cd467cfkkyMZExpGL8ckIz?=
 =?us-ascii?Q?rwbFhI5F1PJuZIhFLDJsgWXQNFFm1ndrcg23R9zio+D7wEznDyoCAPUkkmr0?=
 =?us-ascii?Q?02dEhculr2EBUrghvm5m3f+Dxw11yP8Q17NjToxS3NLPt1gkSHuBH/FiisIX?=
 =?us-ascii?Q?2j87bogwIR3k0vsSx28pzqmFfyxXaO3yq3yeT49gpyzxrcwhcLJzJu8XTsmc?=
 =?us-ascii?Q?3ICdSevVLoG6hiUZpGstAyFHW+9CqPIqEnBk8d9uAQ0FglhYonCy3KluI92Q?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88abd96d-ed0f-4a8d-fc7c-08dac65450f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 15:24:26.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0CuOEO5MVaPcaex2iRGRsNpc2AOURL2schzQcFKgc3H790+Cg4rrJcP4aM33VH8PwVCgIPp2VpY3M89CpIHd4tYI/kir/KsZP7ZlgU8s34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5368
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> -----Original Message-----
> From: William Breathitt Gray <william.gray@linaro.org>
> Sent: 14 November 2022 03:47
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: linux-iio@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.b=
e>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.=
org
> Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter dri=
ver
>=20
> On Sun, Nov 13, 2022 at 05:15:44PM +0000, Biju Das wrote:
>=20
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > +#define RZ_MTU3_GET_HW_CH(id) \
> > +({ \
> > +	size_t _id =3D (id); _id =3D (_id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : _id=
; \
> > +})
>=20
> I probably missed a discussion about this change in a previous thread; wh=
at
> is the purpose of using a local size_t variable here? Is this due to the
> "possible side-effects" mentioned in the patch changes note?

Check patch is complaining=20
"CHECK: Macro argument reuse 'id' - possible side-effects?"

By using local size_t variable, it fixed the check patch warning.

>=20
> > +
> > +#define SIGNAL_A_ID	(0)
> > +#define SIGNAL_B_ID	(1)
> > +#define SIGNAL_C_ID	(2)
> > +#define SIGNAL_D_ID	(3)
> > +
> > +/**
> > + * struct rz_mtu3_cnt - MTU3 counter private data
> > + *
> > + * @clk: MTU3 module clock
> > + * @lock: Lock to prevent concurrent access for ceiling and count
> > + * @ch: HW channels for the counters
> > + * @mtu_16bit_max: Cache for 16-bit counters
> > + * @mtu_32bit_max: Cache for 32-bit counters  */ struct rz_mtu3_cnt {
> > +	struct clk *clk;
> > +	struct mutex lock;
> > +	struct rz_mtu3_channel *ch;
> > +	u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> > +	u32 mtu_32bit_max;
>=20
> Does the ceiling set on the device get clobbered when you change between =
16-
> bit and 32-bit phase modes (i.e. writing to TGRALW vs TGRA)? You have a
> separate cache for the 32-bit ceiling value here, but if it is getting
> clobbered then as a small optimization you may reimplement this cache as =
a
> union such as:
>=20
>     union {
>             u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
>             u32 mtu_32bit_max;
>     }

Yes, it gets clobbered when we change between 16-bit and 32-bit mode.

For eg: 0xbe1352 value=20
Split up into mtu1.TGRA=3D0xbe and mtu2.TGRA=3D0x1352.

OK will use the union.

>=20
> > +};
> > +
>=20
> > +
> > +	switch (val & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
> > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> > +		break;
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
> > +		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> > +		break;
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
> > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X2_B;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
>=20
> Sorry if I asked this before: what are counting modes 3 and 5, and are th=
ey
> not supported by this device? If they are not supported, please include a
> comment stating so in the default case block so that it is clear for futu=
re
> reviewers as well.

Our hardware supports 5 phase counting modes. From that list, I match up so=
me of the functions=20
supported by the counter driver.

counting modes 3 and 5 are supported by the Devices, but currently counter =
driver is not supported this.

Please see the attached counting modes 3 and 5.
https://ibb.co/3YJByG1

OK, I will add a comment for the details for modes not supported by the cur=
rent driver in the default block.

> > +
> > +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > +
> > +	/*
> > +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascade
> > +	 * counter.
> > +	 */
> > +	ch1->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> > +	ch2->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
>=20
> Can these "function" members be modified from outside this driver? If so,=
 you
> could have a race condition here.

OK will add channel specific locks to avoid the races.

Do you prefer mutex or spin lock here? As channel selection is based on run=
time decision
For both PWM and counter??

>=20
> > +
> > +	/* Phase counting mode 1 is used as default in initialization. */
> > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
> > +RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > +
> > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
> > +
> > +	rz_mtu3_enable(ch1);
> > +	rz_mtu3_enable(ch2);
> > +}
> > +
> > +static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch =3D priv->ch + id;
> > +
> > +	ch->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> > +
> > +	/* Phase counting mode 1 is used as default in initialization. */
> > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> > +RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > +
> > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> > +	rz_mtu3_enable(ch);
> > +}
> > +
> > +static int rz_mtu3_initialize_counter(struct counter_device *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
>=20
> No need to complicate this, just use priv->ch[0], priv->ch[1], and
> priv->ch[id]. Same advice applies to the other functions as well.

I get below error when I use array susbscripts. "*ch1 =3D priv->ch[0];"


drivers/counter/rz-mtu3-cnt.c:291:32: error: incompatible types when initia=
lising type 'struct rz_mtu3_channel *' using type 'struct rz_mtu3_channel'
  291 |  struct rz_mtu3_channel *ch1 =3D priv->ch[0];



>=20
> > +
> > +	mutex_lock(&priv->lock);
> > +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
> > +	switch (id) {
> > +	case RZ_MTU3_16_BIT_MTU1_CH:
> > +	case RZ_MTU3_16_BIT_MTU2_CH:
> > +		if ((priv->ch + id)->function !=3D RZ_MTU3_NORMAL) {
> > +			mutex_unlock(&priv->lock);
> > +			return -EBUSY;
> > +		}
> > +
> > +		rz_mtu3_16bit_cnt_setting(counter, id);
> > +		break;
> > +	case RZ_MTU3_32_BIT_CH:
> > +		if (ch1->function !=3D RZ_MTU3_NORMAL ||
> > +		    ch2->function !=3D RZ_MTU3_NORMAL) {
> > +			mutex_unlock(&priv->lock);
> > +			return -EBUSY;
> > +		}
> > +		rz_mtu3_32bit_cnt_setting(counter, id);
> > +		break;
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_terminate_counter(struct counter_device *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> > +		ch1->function =3D RZ_MTU3_NORMAL;
> > +		ch2->function =3D RZ_MTU3_NORMAL;
> > +		rz_mtu3_disable(ch2);
> > +		rz_mtu3_disable(ch1);
> > +	} else {
> > +		(priv->ch + id)->function =3D RZ_MTU3_NORMAL;
> > +		rz_mtu3_disable(priv->ch + id);
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +}
> > +
> > +static int rz_mtu3_count_enable_read(struct counter_device *counter,
> > +				     struct counter_count *count, u8 *enable) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH) {
> > +		mutex_lock(&priv->lock);
> > +		*enable =3D rz_mtu3_is_enabled(ch1) &&
> > +			rz_mtu3_is_enabled(ch2);
> > +		mutex_unlock(&priv->lock);
> > +	} else {
> > +		*enable =3D rz_mtu3_is_enabled(priv->ch + count->id);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> > +				      struct counter_count *count, u8 enable) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> > +	struct rz_mtu3_channel *ch =3D priv->ch + ch_id;
> > +	int ret =3D 0;
> > +
> > +	if (enable) {
> > +		pm_runtime_get_sync(ch->dev);
> > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>=20
> The "enable" Count component serves to pause/resume counting operation; t=
hat
> means the existing count should not be lost when a Count is disabled. The
> rz_mtu3_initialize_counter() function will clear the current Count, so yo=
u'll
> need to restore it before returning.

Yes, it is doing pause/resume operation only. It is using clock gating and =
PM operations.
During enable, Channel is enabled, clk is on.=20

During disable, Channel is disabled, clk is off.

Here we are not losing the count when it is disabled and then enable partic=
ular count.

But we will loss the count, after disable, if it is used by other devices s=
uch as PWM
Or we are switching to 16-bit and 32-bit and vice versa.

Maybe Will rename it to "rz_mtu3_{resume,pause}_counter" to make it clear.

Compared to PWM framework we are missing export/unexport calls here in coun=
ter subsystem.

For PWM, we have an export/unexport calls for creating runtime pwm devices =
such as pwm0, pwm1 for pwmdevice.
Here, count0, count1 and count2 are created during probe.

My current test sequence is,

1) Set phase clk
2) Set cascade_enable
3) Set enable(Since we don't have export/unexport, I am using disable calls=
 for freeing Channels for other subsystem)
4) Set count
5) Set ceiling

>=20
> Alternatively, the "enable" Count component is optional so you can remove=
 it
> if you don't want to implement it; just initialize the counter at probe t=
ime
> instead.

Let me know your opinion based on the above?

>=20
> > +	} else {
> > +		rz_mtu3_terminate_counter(counter, count->id);
> > +		pm_runtime_put(ch->dev);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int rz_mtu3_long_word_access_ctrl_mode_get(struct counter_devic=
e
> *counter,
> > +						  u32 *lwa_ctrl_mode)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u16 val;
> > +
> > +	pm_runtime_get_sync(priv->ch->dev);
> > +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > +	*lwa_ctrl_mode =3D val & RZ_MTU3_TMDR3_LWA;
> > +	pm_runtime_put(priv->ch->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_long_word_access_ctrl_mode_set(struct counter_devic=
e
> *counter,
> > +						  u32 lwa_ctrl_mode)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u16 val;
> > +
> > +	pm_runtime_get_sync(priv->ch->dev);
> > +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > +	if (lwa_ctrl_mode)
> > +		val |=3D RZ_MTU3_TMDR3_LWA;
> > +	else
> > +		val &=3D ~RZ_MTU3_TMDR3_LWA;
> > +
> > +	rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, val);
> > +	pm_runtime_put(priv->ch->dev);
>=20
> When you want to assign a bit to a buffer, you can use __assign_bit() to
> simplify your code:

OK will use and remove BIT macro for both RZ_MTU3_TMDR3_LWA & RZ_MTU3_TMDR3=
_PHCKSEL
And use bit apis.

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
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_mtu2_count_synapses,
>=20
> I'm just checking again for my benefit of understanding: in 32-bit phase
> counting mode, if ext_input_phase_clock_select is "MTCLKC-MTCLKD", is sig=
nal
> C and D used instead of signal A and B? In other words, is the
> ext_input_phase_clock_select only valid for 16-bit phase counting mode, o=
r
> does it also apply for 32-bit phase counting mode?

MTU1(16-bit mode) :-   "MTCLKA-MTCLKB",
MTU2(16-bit mode) :-   "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
32-bit mode       :- "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"

>=20
> > +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	}
> > +};
> > +
> > +static const char *const rz_mtu3_long_word_access_ctrl_modes[] =3D {
> > +	"16-bit",
> > +	"32-bit",
> > +};
> > +
> > +static DEFINE_COUNTER_ENUM(rz_mtu3_long_word_access_ctrl_mode_enum,
> > +			   rz_mtu3_long_word_access_ctrl_modes);
> > +
> > +static const char *const rz_mtu3_ext_input_phase_clock_select[] =3D {
> > +	"MTCLKA-MTCLKB",
> > +	"MTCLKC-MTCLKD",
> > +};
> > +
> > +static DEFINE_COUNTER_ENUM(rz_mtu3_ext_input_phase_clock_select_enum,
> > +			   rz_mtu3_ext_input_phase_clock_select);
> > +
> > +static struct counter_comp rz_mtu3_device_ext[] =3D {
> > +	COUNTER_COMP_DEVICE_ENUM("long_word_access_ctrl_mode",
>=20
> Cascading Counts seems like a feature that other counter devices may also
> want to expose so it'll be prudent to rename this to something more gener=
al
> that other drivers can expose. Perhaps reimplement this as a
> COUNTER_COMP_DEVICE_BOOL and call it "cascade_enable", or something simil=
ar.

OK.Will do.

>=20
> > +				 rz_mtu3_long_word_access_ctrl_mode_get,
> > +				 rz_mtu3_long_word_access_ctrl_mode_set,
> > +				 rz_mtu3_long_word_access_ctrl_mode_enum),
> > +	COUNTER_COMP_DEVICE_ENUM("external_input_phase_clock_select",
> > +				 rz_mtu3_ext_input_phase_clock_select_get,
> > +				 rz_mtu3_ext_input_phase_clock_select_set,
> > +				 rz_mtu3_ext_input_phase_clock_select_enum),
> > +};
> > +
> > +static int rz_mtu3_cnt_pm_runtime_suspend(struct device *dev) {
> > +	struct clk *const clk =3D dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev) {
> > +	struct clk *const clk =3D dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(clk);
> > +
> > +	return 0;
> > +}
>=20
> Do the current counts need to be saved and restored when the pm
> suspend/resume ops occur?

For runtime PM it is not required. But it is required for PM Sleep.

Currently we don't have any PM sleep functionality.

Cheers,
Biju

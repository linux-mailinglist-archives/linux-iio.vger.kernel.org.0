Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C5601861
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJQT7H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJQT7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 15:59:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9079EC7;
        Mon, 17 Oct 2022 12:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV1WkHKbA74Wav7BiHH3YBLg7+2xRU9I8I+VfFcKanPvFP2eqtLzltPUhvzmJ8jnDy2P/WzNw2uBRWXahA/YuZG5Vxek2TnvD06saS1jNec6xt8UWngouw6KxT0LQBJM71QHNU6CnvqwQfO4GrMpq7h7rlVKg4EEk3PPqDus5OISTf3t6seSXyBruPYMr+F3glYhajMCuBLor06ZOGfc/EW5Nh9uZIOj84zve6iTr96e/Q7PlUEtPukBW5/QImqfzccJA5iqG75HqpPSZ9cnwDjqk8URQyDtF7xPgP+5Yk631m8a7Q10We0T+zeRQsGFey3++clffcRVaaT3BVNgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrW/zcyKS68Cz5AUfbWVsWeAfX2QuVNrXFv3bSS242A=;
 b=LGwoK7Sb8R382NqT67PK394dLQVfDaKahwrWBUXlC/qZ30CFyHkohg0/KUKBXrjHyf+xV0n6coigiStzZqozOT2YZ+B8elc/14IhLmKbMMbZ3dgARv6x+JEQmWk0Yuk5MI+q7Fv//hmSHds7OFr68hmaFUL0NnfJd6dnvv48jqEnkIRuqNtPpZn44dPMCpSs9ZZsyDfL2/T/1P5Ollcc1tVem1z7WOKkWcFe9fM6cE5qxwADLtQRfYY5mHW4sNp08XensMvaUQ/qRHmnlvM5IgKkOujtMUZp0NxVL4m+Zy++ajXqLVeBJkTrCRbrcYZARwK8MFTf/x2f1TNJzAdyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrW/zcyKS68Cz5AUfbWVsWeAfX2QuVNrXFv3bSS242A=;
 b=vxagjvOAMCjiYY+t4IxTWSxFT8sjLbKzOf1RKo/utZAPC3yPdtW0BxEsb9OUVwyHrYyocoWWIQ6KjEUSLkiJj8mnJIACEyLJgRcy+WkTFo6eEIiEBovivzp5ZUlpZjaCKB8OeyJEiRaKCrOJH55bo0w9V+ZnrFAX061OItfjJXA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB10609.jpnprd01.prod.outlook.com (2603:1096:400:30b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 19:58:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:58:54 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY3LfzxAH4GWaxPkOP7/sIRCsbj64S1P4AgAA0KsA=
Date:   Mon, 17 Oct 2022 19:58:54 +0000
Message-ID: <OS0PR01MB5922E7C67CB923D67BBEFCFB86299@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
 <Y02FksmG22a03bcS@fedora>
In-Reply-To: <Y02FksmG22a03bcS@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB10609:EE_
x-ms-office365-filtering-correlation-id: 1a89087e-1502-4f35-9b19-08dab07a050c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XkHhQGWmA3GU8V+7PshE/yNSink36avYqpPNhY623no/mRIfGfVuwd0R567boUoDwQYn8gY+BOw6yywMQ8Lg9UZiWMeSjI0z9rqTgZhHmjvFMhinqXLPPsqGu4tQRzi2oWTKVBXKd0mE8dBKNMrWln6NQ5yptbhya4Cefk+ukzYcWoY/+M4r4sFK24PuBeC3xKXkiZEWRi7Dleu8qDsXY4xnaB1xYzne8gOqQyrwQ1fdBCjpkvntO7pW+HSi6QTmENkUIrwwTE1rNsUDRWcUQKUx6LZaQefNS+N8g3+f0ZWudYJ8zFI4EzNtkn2nwI9mZAgW1h094CHPglghGTutGm01fsTjlzKFWo0CMXspAs+me6utvBG6D5K0sw3XieNhkRHeOJJEm8ZNpn5FDl2h2YHg+a49OFeCUsep1GC5CZ/7OAO3OsoYYqfqtkXAzneClbSfxx0Z3dlXu2Va3bd16ex4PsYZ8hQzqr4z8j4r4f+jkFnK6ls89L/M8nvlE1t6f41Zp+xv5qG/BaovIxmse8mLtjq1KCLKmGJHVbQNCFjOqX0kTHYkwusST1NoaAIdrz2K4CfaaabWBncQamgMtU4pd79x6PPPbby04lEONuReAGUSCljWWpuFjn1Ga8Jjg29rJ2u9e9gMdHAPfOfOpp8l7UWSNB2uaywq/3K0bVFZt9BUpsd1JsCw5BQbqJbKA6YhA6bWmXD8TIcFTGZExSwAZACplmjdQEsu5otZIWF5GGThcJCB6tOazSk+FdFTUa0IHwI8vvMTP5jXGrtnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(6916009)(66476007)(64756008)(66556008)(54906003)(66946007)(66446008)(76116006)(8676002)(7696005)(316002)(33656002)(186003)(4326008)(86362001)(55016003)(83380400001)(2906002)(26005)(41300700001)(6506007)(5660300002)(9686003)(8936002)(52536014)(478600001)(38100700002)(122000001)(71200400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EwRnPl2vZsa1qssdA9zlCfaTGR0gnkd+L/pKJFeNtJJ5gShfScqLlzzIwWgZ?=
 =?us-ascii?Q?P/uZBvj8Qzp2icHhuMhNF8H9Qe/sXnCCRz4z1EBEPvKCfSjlyywmBgT27pCG?=
 =?us-ascii?Q?oa4tMeF8nSNNq6k8DUeL/etWcvomchTg4NxzHaLIN5KZ9/Lg86C+Q+07PFdW?=
 =?us-ascii?Q?7yQCo6QkyMk44nZjUDQM5cqq9I9Do0CmwWdH1BGXGolzXkne5McRAzpCGX8j?=
 =?us-ascii?Q?AnF17rIixbo2N05Cx6UPkY979thqCAge480GD0Jp+TnKL+zDG5tIHoFqTGG+?=
 =?us-ascii?Q?5zGmpTIarFt5UXnj19QTHrGNIUoAbaXAYAbJWk4J00qFbx5TWri6SRBDB3Nw?=
 =?us-ascii?Q?G4nmriEaWyDyWuWQ3WmtBzeqogelWNGpO42t5TtpAopmL0f8ob5j4tcP0ME6?=
 =?us-ascii?Q?AL3Nu0MrB7g54pF+k10IcgUqR2TqMQdHd9PpDlpWS2kr9Ipo0ANau6JPNTeN?=
 =?us-ascii?Q?E3KSptc1rzifBRPgw4/NF/BGCNTP4vdJCFliJcALqPZ0OL3SW7LQxTjlu4af?=
 =?us-ascii?Q?/h5q2i1MnBYd76kx67BGp/ItuM40LWvvp419lb8lFiPJUfA/slNcrsfLDttr?=
 =?us-ascii?Q?A0qnM/LqPm0faNv7xGk/F/fXCQfh9ydoD97AX9hXiWFBikQhqsNaQKq9/BpA?=
 =?us-ascii?Q?kFSAZH3ZsydjhELGDVRmxOaZwNlxGnke+vtXlo5QC6Nnp//8qpRDl9z4GqS+?=
 =?us-ascii?Q?szpowvLc9V5dvzM5zWzyk1mk1ds4CmxtiReXgun18htq2yqj7d7oFnFFqGNg?=
 =?us-ascii?Q?qKpAFGiOYlrZpTRH4ae429ShDTEwcPvMxPUdDMKBz5oGhfCfAF5ZAWaL++7C?=
 =?us-ascii?Q?DHCcplc/FKMKz/pl/vEUBDCfrrprn0LO8o5eMtKCNhaVdQCrIlZ/NdZZzd+2?=
 =?us-ascii?Q?38w09dtS449sFEMveH8SYoHz6v4YMT9uq8PDbwhbdZeWPaZf08g7KsT539TA?=
 =?us-ascii?Q?bFc0g3ka8u6v9nBJruDiAchAxBXTrfbsmzzYntwycgYp4BeUHTFLs7zCaghP?=
 =?us-ascii?Q?fp38CNGdy6U5hZUVzLCOedkZQ2wXDvPOVWZc5BeRgOfdhXA+DzKkrlYyfcsG?=
 =?us-ascii?Q?B0TGaQDA0QpNBhxDg2ir0dJR/s5XyS6p1urREQfkO2Xsvet/Dn5oh66hfVcN?=
 =?us-ascii?Q?ZR4KXBxnc2H8hv/hg0k0QKR/1GERQGLCF+qgVc5pN4BhpbzyHB/hRefLM9D4?=
 =?us-ascii?Q?bWnCdDJ93tQalW8C82NW4uNKbwVVEfrGcPrfKK+CUq9TqI8gnQScZRYrBrtj?=
 =?us-ascii?Q?GQ3cAXWZDaao0v6hNV8qCx7K86N6z/cT6NH4r0qW/6ndEBUjuAA9lyBY5pDc?=
 =?us-ascii?Q?+owLU4YxTRM1pbNmchw4gQ6U72zO8K7bHQjqJ9i+1e5mv/uJI6qrfZSgOhDG?=
 =?us-ascii?Q?HgreoTWEZVlNyUa/U3PXSwEa2H7RXlGAPeK38yFQFLCsxmra0bpEQbuXsgIC?=
 =?us-ascii?Q?Q0nl0QwGz4vIKg8k8p/Iclk2AXRAFaRg8kB+Usmj8BHrojG5dzFfc8550OvR?=
 =?us-ascii?Q?RM38T2irY00PVL4W9mz97DI2xw7gob6kPpTfc9UvLKww53XQFcu0CIryz+L5?=
 =?us-ascii?Q?50+qx+H3S3QEh1Kv1igwFflbYCYDEMionDxaS/RdJOJT1GsmKSkc3okk//Gv?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a89087e-1502-4f35-9b19-08dab07a050c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 19:58:54.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKqVJ1232iJw6JcwoKvU6SDIU+KS9P3MPjQUrNpuSCv9n8iFnQXYhxBbyklV556qJZnwOMh0ZvywMFElTTURhMLSpmWSaYsFBqLp2ZYlaPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10609
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: Re: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
>=20
> On Mon, Oct 10, 2022 at 03:52:21PM +0100, Biju Das wrote:
> > Add RZ/G2L MTU3 counter driver. This IP supports the following phase
> > counting modes on MTU1 and MTU2 channels
> >
> > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
> >
> > This patch adds 3 counters by creating 3 logical channels
> > 	counter0: 16-bit phase counter on MTU1 channel
> > 	counter1: 16-bit phase counter on MTU2 channel
> > 	counter2: 32-bit phase counter by cascading MTU1 and MTU2
> > 		  channels.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hello Biju,
>=20
> We discussed some changes already for v5, but I have some additional
> comments and questions below.
OK.

>=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > 7329971a3bdf..fa88056224c9 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1986,6 +1986,14 @@ config MFD_RZ_MTU3
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called rz-mtu3.
> >
> > +config MFD_RZ_MTU3_CNT
> > +	tristate "RZ/G2L MTU3 counter driver"
>=20
> This is a nitpick, but include the manufacturer name in the tristate
> string for the sake of clarity: "Renesas RZ/G2L MTU3 counter driver".
>=20
> > +	depends on MFD_RZ_MTU3 || COMPILE_TEST
>=20
> I noticed you include <linux/of.h> in the rz-mtu3-cnt.c file; do you
> need to depend on OF here in the Kconfig as well?

I will take out "of.h", as there is no compatible.

>=20
> > +static int rz_mtu3_count_read(struct counter_device *counter,
> > +			      struct counter_count *count, u64 *val) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		*val =3D rz_mtu3_32bit_ch_read(priv->ch[0], RZ_MTU3_TCNTLW);
> > +	else
> > +		*val =3D rz_mtu3_16bit_ch_read(priv->ch[count->id],
> RZ_MTU3_TCNT);
>=20
> After considering this again, I think it'll be better to match the
> structure of the rest of the functions in this driver for consistency.
> Rather than hardcoding priv->ch[0], determine the ch_id first and pass
> that instead::

OK.

>=20
>=20
>     const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
>=20
>     if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
>             *val =3D rz_mtu3_32bit_ch_read(priv->ch[ch_id],
> RZ_MTU3_TCNTLW);
>     else
>             *val =3D rz_mtu3_16bit_ch_read(priv->ch[ch_id],
> RZ_MTU3_TCNT);
>=20
> > +static int rz_mtu3_count_write(struct counter_device *counter,
> > +			       struct counter_count *count, const u64 val) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> > +	u32 ceiling;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		ceiling =3D priv->mtu_32bit_max;
> > +	else
> > +		ceiling =3D priv->mtu_16bit_max[ch_id];
> > +
> > +	if (val > ceiling) {
> > +		mutex_unlock(&priv->lock);
> > +		return -ERANGE;
> > +	}
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		rz_mtu3_32bit_ch_write(priv->ch[0], RZ_MTU3_TCNTLW, val);
>=20
> Like in count_read(), use ch_id here instead of 0 for the sake of
> consistency.
>=20
> > +static int rz_mtu3_count_ceiling_write(struct counter_device
> *counter,
> > +				       struct counter_count *count,
> > +				       u64 ceiling)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> > +
> > +	switch (count->id) {
> > +	case RZ_MTU3_16_BIT_MTU1_CH:
> > +	case RZ_MTU3_16_BIT_MTU2_CH:
> > +		if (ceiling > U16_MAX)
> > +			return -ERANGE;
> > +		priv->mtu_16bit_max[ch_id] =3D ceiling;
> > +		break;
> > +	case RZ_MTU3_32_BIT_CH:
> > +		if (ceiling > U32_MAX)
> > +			return -ERANGE;
> > +		priv->mtu_32bit_max =3D ceiling;
> > +		break;
> > +	}
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (ceiling =3D=3D 0) {
> > +		/* Disable counter clear source */
> > +		rz_mtu3_8bit_ch_write(priv->ch[ch_id], RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_NONE);
>=20
> Refer to our discussions in the v3 review thread regarding ceiling set
> to 0; in particular, don't disable the count value ceiling but rather
> limit it to a maximum value of 0.
>=20
> > +static int rz_mtu3_count_enable_write(struct counter_device
> *counter,
> > +				      struct counter_count *count, u8 enable) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> > +	struct rz_mtu3_channel *ch =3D priv->ch[ch_id];
> > +	int ret =3D 0;
> > +
> > +	if (enable) {
> > +		pm_runtime_get_sync(ch->dev);
> > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> > +	} else {
> > +		rz_mtu3_terminate_counter(counter, count->id);
> > +		pm_runtime_put(ch->dev);
> > +	}
> Refer to our discussions in the v3 review thread regarding the
> "enable"
> Count extension; in particular, "enable" pauses/unpauses counting.
>=20
> > +static int rz_mtu3_action_read(struct counter_device *counter,
> > +			       struct counter_count *count,
> > +			       struct counter_synapse *synapse,
> > +			       enum counter_synapse_action *action) {
> > +	const size_t signal_a_id =3D count->synapses[0].signal->id;
> > +	const size_t signal_b_id =3D count->synapses[1].signal->id;
> > +	size_t signal_c_id;
> > +	size_t signal_d_id;
> > +	enum counter_function function;
> > +	int err;
> > +
> > +	if (count->id !=3D RZ_MTU3_16_BIT_MTU1_CH) {
> > +		signal_c_id =3D count->synapses[2].signal->id;
> > +		signal_d_id =3D count->synapses[3].signal->id;
> > +	}
>=20
> The Signal ids are constants so you remove them from this function and
> use preprocessor defines instead to represent SIGNAL_A_ID,
> SIGNAL_B_ID, SIGNAL_C_ID, and SIGNAL_D_ID. Remember to set the Signal
> ids in the rz_mtu3_signals[] array accordingly.
>=20
> > +static struct counter_signal rz_mtu3_signals[] =3D {
> > +	RZ_MTU3_PHASE_SIGNAL(0, "MTU1 MTCLKA"),
> > +	RZ_MTU3_PHASE_SIGNAL(1, "MTU1 MTCLKB"),
> > +	RZ_MTU3_PHASE_SIGNAL(2, "MTU2 MTCLKC"),
> > +	RZ_MTU3_PHASE_SIGNAL(3, "MTU2 MTCLKD"), };
>=20
> The relationship of these Signals still has me somewhat confused so
> I'm hoping you can help me properly ironed out my understanding. This
> is how I currently understand it, so please point out any mistakes I
> have:
>=20
> MTU1 (Channel 1):
>  * Pulse-Direction mode:
>    - MTCLKA updates count
>    - MTCLKB determines direction
>  * Quadrature x2 B:
>    - MTCLKA is quadrature phase A
>    - MTCLKB is quadrature phase B
>    - Any state transition on MTCLKB updates count
>  * Quadrature x4:
>    - MTCLKA is quadrature phase A
>    - MTCLKB is quadrature phase B
>    - Any state transition on either MTCLKA or MTCLKB updates count
>=20
> MTU2 (Channel 2):
>  - Same as MTU1, but optionally can select MTCLKC and MTCLKD instead
> of
>    MTCLKA and MTCLKB respectively
>  * Pulse-Direction mode:
>    - MTCLKA(C) updates count
>    - MTCLKB(D) determines direction
>  * Quadrature x2 B:
>    - MTCLKA(C) is quadrature phase A
>    - MTCLKB(D) is quadrature phase B
>    - Any state transition on MTCLKB updates count
>  * Quadrature x4:
>    - MTCLKA(C) is quadrature phase A
>    - MTCLKB(D) is quadrature phase B
>    - Any state transition on either MTCLKA(C) or MTCLKB(D) updates
> count
>=20
> MTU3 (Channel 1 and 2 cascading):
>  - Same as MTU2 (but count is now 32-bit)
>  * Pulse-Direction mode:
>    - MTCLKA(C) updates count
>    - MTCLKB(D) determines direction
>  * Quadrature x2 B:
>    - MTCLKA(C) is quadrature phase A
>    - MTCLKB(D) is quadrature phase B
>    - Any state transition on MTCLKB updates count
>  * Quadrature x4:
>    - MTCLKA(C) is quadrature phase A
>    - MTCLKB(D) is quadrature phase B
>    - Any state transition on either MTCLKA(C) or MTCLKB(D) updates
> count
>=20
> Is my understanding correct here? Is the selection between
> MTCLKA/MTCLKB and MTCLKC/MTCLKD done in software, and should we expose
> it in sysfs?

Yes, we need to expose this to sysfs. Is it same as phase mode?
Can you please provide an example, if possible how to handle this?

Cheers,
Biju


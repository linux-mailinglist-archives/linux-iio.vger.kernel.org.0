Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A6628529
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 17:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiKNQ2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 11:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiKNQ1u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 11:27:50 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF91DDE5;
        Mon, 14 Nov 2022 08:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJhJRZR/5t/+cM2JNFvqMpQ2UmA2MQEm8EA6mENghPDvhS+AMqqQWrXPmdPZUafm/xn03ADv3Rxvs8Bbvy18zxDE1zUT56C0zVyXK7fOla3C/H0YTkP7p3WqbDm2ja1qcf61G02/7dPwWyCr9AMR03WTTz+HnKjcmrdzLYH2qiuD5A+vLISruXtj9yhKd2lMFLirlwkiKPy2KIs2SWE4csooaI3mqQpekeiufIpriWoGmLL5qsZclstROmZR3ghVP/Xoj9SSxG1UOzUQa6vzJcAVF7qs8zthOj3ojadUL7j1PFsEAZbT3tO3kVZV/5OfpU/nnn9QHmnWbKftIYft2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgN+WwQw3OacYgmv3kd74OLl0ClKdGUqOTqxqY6R+EQ=;
 b=OWwuOq/1EaseMCQ1YAefCcgZUeuCY/GO5s8mAlEp4pcZaElBhrwmjmpi4+MGVMaAZI7HZxltxKBIaN5iPnrxIBUexz5VWNzRM5Ez5V3aSL/HVKo3QHde4E0EN5fMYLmZT0+K6ExnfxfnKQSh7mzUgvJxZkgnaJFob/yTdOaMBaD0+tzaHZ8GCbZLAmSsXRcZOvQVJsO54h8iFJae0aWtc6UZwTbN05y1Vihr4j32rz0ElpxSAAQF1yEkyQweUviecDtrGuA8/SlXpv71Wg/ZqlWa58/+HTIaMF5C9URCEgtRBQ9zPEAl/jF8BKALsyZZ8zOxbLRVJ/6l1ImTbRuBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgN+WwQw3OacYgmv3kd74OLl0ClKdGUqOTqxqY6R+EQ=;
 b=a5IzsHl3yM9rOLoIvAgYTuY4StJ6u/X+YjxiZ+hQQCN/LEe+Fh0CNyO6Y1Anf1MvxF/dZj0A15obIAhaktepOc+7beB1eoS8ZsAye+53mKQ4x5psduLARm9nL3D7LCg6g04SxjPldBHtkUeJKoJux04hvTWfqtOFpqMnQBMwCAY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8894.jpnprd01.prod.outlook.com (2603:1096:604:15b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:27:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 16:27:47 +0000
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
Thread-Index: AQHY94Oe/bXNEYoN9kCntehmCzyhdK49yIiAgACpVACAACrO4A==
Date:   Mon, 14 Nov 2022 16:27:47 +0000
Message-ID: <OS0PR01MB5922AE9A84A1A59FD57B54C386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora> <Y3JITA6sMp12XJmE@fedora>
In-Reply-To: <Y3JITA6sMp12XJmE@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8894:EE_
x-ms-office365-filtering-correlation-id: cbc54bc6-bd2d-4799-57a2-08dac65d2a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCsSx3PrA+mTNbCELRvtrya1J5NO39jRvV3An1cmqGOFIwj57M1pYUCEzBsfsy2qVGpncfeaO5KQZ+65JLdMugRSGCAr0NdDRvRNnNo3wONcUY3EUfAgVEnsYNH0i83QUrkwUU+lJH5lWfWrmdvWvE2TuOEHduWPfiw27bZGyiSHMft4qAM9CoT1fDHqLMYIj4+IZIxFtIwcVmke7RfhWRnKwFdGrRKTvrYhch4/PTNJ2wz1Fc4MTON8Z+zyxhu10PMfH6RYLC2+OGO/HUYZn0rvdcpD1gh+O+WDdqQRMotpllQXEm/X+bbjec33oxObUrbB8xiHs9KhnS1zIKx5X4zSHAKAqAuqfn9VG7teDLS+zEOm9njniNdc+VA0mSvxO7lI+MkJBYqc3B2uFEqP4Bm+5mO/AS1pd/gDCfkxmi6QcTjNmkA5IxOmPImYHZi49t4E+4E/3Fnn0U7SXEEJ3ki2cGaX+axZQL1lI1ZasjtmAPAeng52P0kLNOm7hfXIpORhSLZ4r+kf/T1EiUM9QOhSVU7MeO3flZu/fyS3zR8sxv16yl65IHtdTlrDBpdtO7gThNS4MdFTQpM1ad9ct+HL41bxJzmDj6yhQ0BxaAyZOBun49lk/ozJXHzyQyfS4VOEQkfV6bpq4uo1wpHhF5Z25cdAwJGsgXrWVmMxwVndYH/LCh3e+st+CBsJgXoCYyPvUwge/Ai52jcFHRXci32LsvCC+ehsNmT6KMP6Nk0QWda/tSiKWJda0QuRKhlu7p36vuZuQNUkz5SU163O4fAFeqo4YNosbn9VjiarZ/XvCgCUYtq/LGOfSZnEcPh3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(71200400001)(478600001)(54906003)(6916009)(5660300002)(186003)(8936002)(52536014)(6506007)(41300700001)(2906002)(7696005)(26005)(66476007)(53546011)(66446008)(316002)(66556008)(4326008)(76116006)(8676002)(64756008)(9686003)(66946007)(83380400001)(33656002)(86362001)(55016003)(38100700002)(38070700005)(122000001)(32563001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9071aIsRymRFborMTonj0EsIEGwjVGxMoCz0+AT0sYcMrzfMSwg+O240CN4b?=
 =?us-ascii?Q?6U7s4f/CKXoksuUfBFHNsH4nRXCh7LRk/tXXYpsBJzuIgz091aAkuW/5If6E?=
 =?us-ascii?Q?afTzjdKileFhD2p7KgtS6jjaC5LwSPLBMAyUikbrWog2xpPKcUupgdOZeJMv?=
 =?us-ascii?Q?mudj+VrEqWFN6FW+6Zyq1HNH0gFSAQrRky1wK4MzL0j0XxU8hTK5zaP8mRGn?=
 =?us-ascii?Q?2SbGjSWhHUerb9JOc8zeiQGnp7tutcS9eh6wbjh+mBtjGk3OFT9WpgiVgTSK?=
 =?us-ascii?Q?wLii9oYc9+yhflBeQ8eSkPOdc/99V0guj+0QxDJmYZ3sw0z5SuF+BTRAbdrP?=
 =?us-ascii?Q?Xb1mnR0WP8JjYoaC5qaKiZi5Xt4MJepoCDrUzPqLe5hnD74Uuda0F9L8rOsS?=
 =?us-ascii?Q?TL1Se6/FpGbIjcxJsTLkHLH7WVf4D8Qhky4CXrPl2LrRYA1zhNGUXj28ONab?=
 =?us-ascii?Q?uTdZSf0zbkSwCMsK0nMXQBzhZLSJ6USjyGq0tdtO9TyL6q5zClj+np5grtfz?=
 =?us-ascii?Q?NlbMFsh4u3ThO2h/2HEWO0V/J9c+Urx5O7k73+bgB4iaA0cXsJ7nKAl7iziI?=
 =?us-ascii?Q?8ONHq2wxNiC5zqfOEtyZpJ32gdfTia2ZUiQ/h2yYKVQ+A2IK7XLXGDC4LEho?=
 =?us-ascii?Q?1L+1gs8SA+NG/cpFcUmkezLijCIaf8w3CaqqkEjes3JmK/jaM1MhAjHsk+Uo?=
 =?us-ascii?Q?0kskHPTBQGXk3ro1IGYlmuTx3DAHNcqByZhOv+abPRhF/VBKVbrmsCy7cp4b?=
 =?us-ascii?Q?q0J/PExldJy9ISmOEJXLYn1nzPvlNvzZyYtCz74qefSnOOJdIHvC9pPUJhb6?=
 =?us-ascii?Q?rXMCQNRzsujZsUNQj2ZysOQu4xEPU+Yn+SfqQtvDykfErQeQ2oZNNbpAx0VT?=
 =?us-ascii?Q?0QDqrSx+Bq6RT26w5tL/PRWJm60/5aaoC5JO2CGLG8wedjrOi7K6XNttDyN3?=
 =?us-ascii?Q?QcHL5cqFbybeYzkyh0DMOUg6h9BCXDtDOJBp47NCqtR/iVfcbgoPqiIDX0tL?=
 =?us-ascii?Q?TFT5uLlBb84Qq67ghperXgSUKUoBERmg6w4w3gPI7jQIF+KN1pNl6gzbUlbh?=
 =?us-ascii?Q?5Dagn1tNSN0QH41/flJr1jb7z3csrA6uTCOyj3rGIelf1ECOaXlz4mx0e6Yz?=
 =?us-ascii?Q?xKubSk1Y7HaH4ckl9KpiMwi7oS2KI/GlDa4RsY6vFWz2XhLfzCpoF9epnxzm?=
 =?us-ascii?Q?KAPRytAbgwcSYaVhg5QmJ54Wl5UaOgcPyHxrjOUEfVT2HgtRURs6Lm2kjhtn?=
 =?us-ascii?Q?NYYk6cet3uGsZLn0eRLp4YHqvQB3Y9dH7klADari01+WnKh5gMZ7M1eV46EK?=
 =?us-ascii?Q?I5b8RUqnbxlXeRg9onLcEvkKQQ64NdGCeMhQ1vcO8D+znkgJVCG0oS06ydAb?=
 =?us-ascii?Q?N3y0xWyI5LYfVgf1fD8aXsiQu5ty2ZlKLmkj5HcDTqgVYh+3GI0htNgrJoRR?=
 =?us-ascii?Q?pCKp1JQcfceiJgVxHhmnJXt0CM1ss4RS5O14k+Uj1QD/cFjCvEQLZohatGgl?=
 =?us-ascii?Q?mDnHNLWgplF0EI9k4Nq8Z5fWbFJJvAr8nvt724Ny3nSRTfyP+DQn86IYDCGR?=
 =?us-ascii?Q?e/SjlIKo5GZGhixTAqgknjCG7WD6hTabfHI+FyF3E1Gyh+XjyQIYoGtuj1xz?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc54bc6-bd2d-4799-57a2-08dac65d2a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 16:27:47.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRIZICL52+0EpTRopqmJ8rJ/bH9onn9DlgcDYgpJOSqCTgfB4/2QTZ6dKio+sh5NcMYRJ8Rbpyzq2bEeYC7C0xFOFLtMM/M2NMPrsPXxnmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8894
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
> Sent: 14 November 2022 13:53
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: linux-iio@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.b=
e>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.=
org
> Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter dri=
ver
>=20
> Hi Biju,
>=20
> I have a few follow-up comments that came to my mind.
>=20
> On Sun, Nov 13, 2022 at 10:47:13PM -0500, William Breathitt Gray wrote:
> > On Sun, Nov 13, 2022 at 05:15:44PM +0000, Biju Das wrote:
> > > Add RZ/G2L MTU3a counter driver. This IP supports the following
> > > phase counting modes on MTU1 and MTU2 channels
> > >
> > > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > > 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
> > >
> > > This patch adds 3 counters by creating 3 logical channels
> > > 	counter0: 16-bit phase counter on MTU1 channel
> > > 	counter1: 16-bit phase counter on MTU2 channel
> > > 	counter2: 32-bit phase counter by cascading MTU1 and MTU2
> > > 		  channels.
> >
> > Within the context of the Counter subsystem, the term "counter"
> > specifically refers to the device (Counts + Synapses + Signals).
> > Instead you should use "count" here to refer to the counter value chann=
els
> (i.e.
> > count0, count1, and count2).
>=20
> Include a brief description of the Signals and their relationship to the
> three Counts as well in this commit message. In particular, mention how
> "MTCLKA-MTCLKB" and "MTCLKC-MTCLKD" can be toggled for MTU2, etc.
>=20
> > > +static int rz_mtu3_long_word_access_ctrl_mode_set(struct counter_dev=
ice
> *counter,
> > > +						  u32 lwa_ctrl_mode)
> > > +{
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	u16 val;
> > > +
> > > +	pm_runtime_get_sync(priv->ch->dev);
> > > +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> > > +	if (lwa_ctrl_mode)
> > > +		val |=3D RZ_MTU3_TMDR3_LWA;
> > > +	else
> > > +		val &=3D ~RZ_MTU3_TMDR3_LWA;
> > > +
> > > +	rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, val);
> > > +	pm_runtime_put(priv->ch->dev);
> >
> > When you want to assign a bit to a buffer, you can use __assign_bit()
> > to simplify your code:
> >
> >     unsigned long tmdr;
> >     ...
> >     tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> >     __assign_bit(RZ_MTU3_TMDR3_LWA, &tmdr, !!lwa_ctrl_node);
> >     rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, tmdr);
>=20
> You should consider implementing a rz_mtu3_shared_reg_update_bits() that =
will
> perform this read =3D> assign bits =3D> write sequence so that you can re=
use this
> pattern in the rz_mtu3_ext_input_phase_clock_select_set().

It is already taken care while working on cascade_enable.

>=20
> > > +static int rz_mtu3_action_read(struct counter_device *counter,
> > > +			       struct counter_count *count,
> > > +			       struct counter_synapse *synapse,
> > > +			       enum counter_synapse_action *action) {
> > > +	enum counter_function function;
> > > +	int err;
> > > +
> > > +	err =3D rz_mtu3_count_function_read(counter, count, &function);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Default action mode */
> > > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >
> > You can exit early here depending on which ext_input_phase_clock mode
> > is currently selected: if "MTCLKA-MTCLKB" then return early if id is
> > signal C or D, while if "MTCLKC-MTCLKD" return early if id is signal A =
or
> B.
>=20
> IIUC count0 is always "MTCLKA-MTCLKB", so this exit early check won't app=
ly
> in that particular case; check count->id to see which Count we're handlin=
g.

It is already taken care.

Cheers,
Biju

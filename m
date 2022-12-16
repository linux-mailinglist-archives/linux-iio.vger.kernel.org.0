Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341A64EFEA
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLPRAf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 12:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPRAe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 12:00:34 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E541DDC7;
        Fri, 16 Dec 2022 09:00:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlYRXrlta3MSLRPG+v/BmBoMDz06JKvYLvc2DldDCz49izb5SPv4Ro4h2mevMnFS9Wz9N9j9bz99tr8l95Wac2E5TwnsmXkCiV1xxJO6O21+fMl/52NlumHtJ5eDf2vesH3Gu4N8GWVR6zwYDD4bkVX0ADo1CmrwV/eeAmDRGqm3lF73J9gTGJ4mjCZnF8N86wMhQ8PbMBOzPAde/N4b/9bFqYeXC25baGYymUv4FtQZAMB6mk5q49ChMEjr5s0ebPh1Z8AxK0jyZpnZNAkvLnpFDaiSJn0snWWaNfs4ha+B+Ra1rkK3rWFFiAYw+R8GSYTwhoLZZc8lNrZniHw+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYLjb6qKVTkq6+WMBTB5EKOryQn1FAUdcKhjcJExHDA=;
 b=NeXnR2Rm3EhmBhl5/xdIAniFg6fzD8Zrl+MM0GyNjql5z+JIL9s2V1I944j2QP0VUtQUdPIk4O4Rb2J9bqndbymc2Tx3BHFf1Ocm9+isFuAmOrUzmER70J3r/Rd1JE4yGm/GiTecxXY4jHVByfNSCtenSVZAsntq8ykq/Qm4nv93qZdlV4UfOZMqmonoooMvVKIAndk2yNlX97IZT8Ly9vSjpbSOYbegJOfJAaENgYHJZz6QZgAQG5L1urNQTFYx2lD/zMBxWicqO7uC3VRcSIjvMVz2zCchJP/r0QWH+PVvVU+L6O93ZZlyQkZabk/x7lQlBnQAFo+0MwWTFKWxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYLjb6qKVTkq6+WMBTB5EKOryQn1FAUdcKhjcJExHDA=;
 b=mVpmjzOH58VPZ8wB6B1JVMoLfpCZfszpwws+6UzMHpM5G3CTfJ+wyY/3zpK0YA5/7lxUE7vL/XoL6tz+ODlSx9puDyhdP1Yav4QNvMCMDK5K0hzlk0xs7YC8szd1xD5gFklJYAi2lJhyoNJvI+Yooajs4VC1Bxut1N6MpdUp6X4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5553.jpnprd01.prod.outlook.com (2603:1096:604:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 17:00:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::69ad:8673:1ba1:d7]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::69ad:8673:1ba1:d7%4]) with mapi id 15.20.5924.016; Fri, 16 Dec 2022
 17:00:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZD6dL1Ef+NDbgDEq2HK76E2fJf65wsCQAgAAHmtA=
Date:   Fri, 16 Dec 2022 17:00:30 +0000
Message-ID: <OS0PR01MB5922FB904619669BE9DD85A086E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221214103136.2493474-1-biju.das.jz@bp.renesas.com>
 <20221214103136.2493474-5-biju.das.jz@bp.renesas.com>
 <Y5yWdiAsMIUn9ehm@fedora>
In-Reply-To: <Y5yWdiAsMIUn9ehm@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5553:EE_
x-ms-office365-filtering-correlation-id: ecc76b32-9fda-47ca-9313-08dadf870a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ps+AuRlcfE8LIAWOt09zNVuZRv80nPboJpgQ9P2u8T6Jr4BtRTd5F07wDNmiF9UJbfy2rBW710nT2BdwE/AsvB3xxUN4pmQ+ur+2qAloMyU2lpdaK1jpFAnbINU/0S+SQdjmTaO4U/FnR2Qe3lRcxuPMH7WH2/hj9OoqC1xIhxE0J+lDhdH6TpCtQqZ4/57WJQta5cXxV6mTkdAjxXoxUsY5qaOC4s7cP+JTRWsXDPcK/wNWre/eo6mBNT/VrhXkxw0Mp6aXxKj7RFSNC4QFgsMC24JfIwP2+6LFp8EINW2vKbdxTOpRKDA+VyDrmLKBoHKIiTySiyB34fj4H1+hn8AAjrRQ7bHCaqIj/bm4wPR6XkV0H7dhXRI/tF8pru396gDt+ShgS1/H3ErhBFmgASdUT36lfL/5X4bCD+a8N0SmUTa2fFBbGKjKr2p1TUYNCqKh2NYfEhDrgbnEy1CBxb6lV4pirwE691Gfts8PUze1VIYlN9feK1g1Ks5CzFof3ryrOQFBdwvQcdZ6U3ZtOSMU+04YIzhtOfgDZc21rZ22S1FRPyMqPWUOfGP7QuvMRaoHx3gbk+yIVhyKQBCVk5EHGTSH705FM9zx4YSsH838BP6WASeEtufQqCzRI3DpoVQVeTxCA53i3yWdKGDZQoiPl0YLrs9YL+NcfuBrcnAPF74m+MQALZQPgLPQ2q54p0G1Qu6MGeTLzf1ghiAWTcBH04LsYA9gqeVVseVPV7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(478600001)(2906002)(7696005)(6506007)(38070700005)(55016003)(9686003)(186003)(71200400001)(86362001)(26005)(33656002)(6916009)(38100700002)(83380400001)(316002)(66446008)(66556008)(66476007)(4326008)(64756008)(66946007)(8676002)(54906003)(8936002)(122000001)(76116006)(5660300002)(52536014)(41300700001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LgST0TORZVBQlucV+wXp+yrwr2nhEL+rnhDC2Nre1/9MwmV2jRb62ykEF30V?=
 =?us-ascii?Q?ATi+XqzX8dRLH8h2DXYHcwb8IPZhXur/T6GVx3VFQLqzBKc1a4MrPZHrI0Y+?=
 =?us-ascii?Q?tm9GR0iRwlX6bUqz8ChPcYxLNRD0Bvg0rhXxKmZei72u8D6dh2TyiA5NSzjF?=
 =?us-ascii?Q?yfoSG2O5yxozPnt6NQe7yl6Yn/GhOLbwOahRKqY4DnbEzNPFiQjVYN2eP/7f?=
 =?us-ascii?Q?TFaJCzOMFIOiLfYaAuBIjfZ/ad4RYZD83M7OA0vCVWYFsU8HSo9dl/TrscL8?=
 =?us-ascii?Q?zDbsVTpBEqKxWzGRXZ+QqvlCVYuTpA13l2/2woQ7TjikUBpZFtoePcIs9JOF?=
 =?us-ascii?Q?IZtWUnghuXh8Rq4RqraE9v7VuEgx7Wp4gcavO262BGuf+gp1z8Dm4ex2VIUg?=
 =?us-ascii?Q?kZkIaUcnos9Mz95w+XSRy5OQFKZAcx31ZzGuUvIxiMFTNIEj1qrHdfG7JIQ8?=
 =?us-ascii?Q?RdGKuI2Qsj0Ck5oo4qlRjrgYpJCkAMFOEONSKsdVZRta8XJYWKkt8t+T9Tt+?=
 =?us-ascii?Q?3o1tvjwnDjAtRORiS06LcrdMTsJJhtQMO27Ge6Rgn6rbh73uxkd0ePZFcy77?=
 =?us-ascii?Q?scLSgjOSkN6WSQ9XSfg+BCcyjfE4DAaV5XB76H88XERRaz46bgYRVshb69qR?=
 =?us-ascii?Q?FZ8fGhAFYXmAA1ePNrxx0XnCbS5xlIohZGUbZIfRk8JVyafX5DepsFrx8Kp7?=
 =?us-ascii?Q?eo8jbbYvnFg8X2UXxrM4OD448GHnzYHTNgwojoAN0pFgwTS1NAPVZsjNAcFO?=
 =?us-ascii?Q?bI5jxeSvhMGk9PJvmN3bYpsg+DKez06t0p9v9lQ26dS6fKkSV36YeoM+qsCE?=
 =?us-ascii?Q?pMXroG7CUrS93+V/wk258wsGcfKSdJSCn9yjXw8/mN/tt472DHwjM/fdTlB1?=
 =?us-ascii?Q?YpMpcH44HhnqikeWJdy7WVnqbEckzQlGxn3xPYwRwaodxU9E2mIdNO7uCRDP?=
 =?us-ascii?Q?ZwkT2DcRC1dEoJJWRucBuDhbKZiqH4Vw+TPYVj+S1wW0mBou2niheZd8c4BK?=
 =?us-ascii?Q?GM5CrTSXh8zu6o+2EZ//cK3zC0Bbk1IbYEnzI++I689z8PSSR56EJih5haPS?=
 =?us-ascii?Q?lYHw2YKg26YciLUSnSPIf8BhIMWACw5xQKy3KN2WELJum4M4QhkoKs2dtw7A?=
 =?us-ascii?Q?KeyYWiEmw5Y5416isn7ySDbnwlM6siJoFIlL+xBZSj6ivDxHnsIFjQAkGPpS?=
 =?us-ascii?Q?extCA52vYm5QNvLesAvY7Lhyx3H8dFBGzLdqgXh4PSvHc+MQk32sZ0IwcmN/?=
 =?us-ascii?Q?v6RejlYEmqbt08WK207V63VOeZSWXlcXfSoTA37XtoSoTcow76Bc83dKe6bG?=
 =?us-ascii?Q?kzgBQZrS4lePPjS0iZn/8BgSSRP6E3p0qzl+vhR2ctCOSuDYzIbJs5TpBU49?=
 =?us-ascii?Q?34cprMjzAljk9ei44V7sG3spUWhwcrYHnpse6z6hiw/oC8k2WfcSVZ+ZX2FJ?=
 =?us-ascii?Q?tIgIuxXU4dvk+V7s7FEcmfDClaj4cnHEuSj8kH+2h5QYzDkiACgqesBZr0ZX?=
 =?us-ascii?Q?xBAKHu67BV8/NPILzCPSqgbLTkck4G/9LJNDAE38CGZNozOQRKI5SlmUvJ4O?=
 =?us-ascii?Q?ThWtrhX5S3IkL5t9xu+nylWIDEEcu0FHRJkxMcEFEp4MiclpgDg5A+m25AK6?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc76b32-9fda-47ca-9313-08dadf870a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 17:00:30.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIybi/2L+IyDQKibLelocUtRsNWE5uyxkafP3kbXBACSISonEpQYZ/NIN3DOMcNCC1XNe0EUFaBYzjS0fMS2iAngL/osfu1OQWAUMchBk/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5553
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: Re: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter dri=
ver
>=20
> On Wed, Dec 14, 2022 at 10:31:35AM +0000, Biju Das wrote:
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
> Hello Biju,
>=20
> Do you need to take the ch->lock before checking ch->is_busy to ensure it
> does not change?

priv->count_is_enabled[count->id]-> true means channel is held by counter.
So pwm won't be able to change the state ch->is_busy.

priv->count_is_enabled[count->id]-> false and if there is contention for ch=
->busy
whoever is first calling rz_mtu3_request_channel() will get the channel.
among pwm_request and counter_enable.

So I think it is safe here. Please correct me if I am missing something.

static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
{
	bool is_idle;

	mutex_lock(&ch->lock);
	is_idle =3D !ch->is_busy;
	if (is_idle)
		ch->is_busy =3D true;
	mutex_unlock(&ch->lock);

	return is_idle;
}

>=20
> Regardless, I have some race comments below.
>=20
> > +static int rz_mtu3_count_function_read(struct counter_device *counter,
> > +				       struct counter_count *count,
> > +				       enum counter_function *function) {
> > +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u8 timer_mode;
> > +
> > +	if (ch->is_busy && !priv->count_is_enabled[count->id])
> > +		return -EINVAL;
>=20

The above check is for avoiding race between pwm and counter.

> The priv->lock must be taken because count_is_enabled could change after
> it's checked here.

OK, Will add priv->lock.

>=20
> However, you'll need to spin up a helper function because you're currentl=
y
> calling rz_mtu3_count_function_read() in rz_mtu3_action_read(). So move t=
he
> implementation of this function to a new helper function and call that he=
re
> with the appropriate locks.

OK. Will add helper function.

>=20
> > +static int rz_mtu3_count_direction_read(struct counter_device *counter=
,
> > +					struct counter_count *count,
> > +					enum counter_count_direction *direction) {
> > +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->i=
d);
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u8 tsr;
> > +
> > +	if (ch->is_busy && !priv->count_is_enabled[count->id])
> > +		return -EINVAL;
>=20
> This needs to be locked for the same reason as above.

Agreed.

Cheers,
Biju

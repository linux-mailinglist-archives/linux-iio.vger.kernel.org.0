Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CA649E15
	for <lists+linux-iio@lfdr.de>; Mon, 12 Dec 2022 12:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLLLmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Dec 2022 06:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiLLLlh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2022 06:41:37 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C45256;
        Mon, 12 Dec 2022 03:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn6DYOUsLJmT4XtfH7p1ScuTe1x75MeqRCC1ii1RI6q1ju0NCo2EC6SjSDHwSLoI+m+AGFqHMkWy3tfq6KWQA5nA8UXDDm9e0xbzfQAPJz0ZvOGjizpfquNbNXpK8lsrw9yf+1DVNxaHi1NJgueB8ELK+9NwU8dtbV61ECnf0ssdysrHDNwdmgY6ieNLerkmIZC7gWfNG5oE40L1J9j7B7CCku3rqGlYbyjww4yGjK3cKzW3qSBzzl6tItu6xogNF/p1eJivqwIDWP4eYVfKDz68JP8WO3GV5csgA1FwU2fO6Ix52NSCUN/oL+JrUkdEps9mrqw0jP/YVYnACuFqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3eV915tKYLR81LxtlNmS6k2YcaDHO7Jn66K/TxjQys=;
 b=hH3dJvTWG8DW7mhWKNOFSvnG0aCsOQNSb40PEEMg0xt8NVAdrVUh05aNiaDCkKNbXini0saDKS8Fbu3DA8LaMa+VjvUXfD4/ra/bgPx+C0dt7w4/ji5IV2THPlYyIPNav2r4vHua9r3vpjjB1SRYE8FmX93gHebJA7J7Paygaol6Q9kcwFji9XcGgTSwwCfIUgnjIwkuXfpqz9IVwGa31SMNM8aVPgYub6nD+mQ2LZCWvyJoMiLZlKorP7GXdingszpYDYwTL10lVKKx2/7jZw52yLqSuG5tcUWdrGtC0XO6aYvwHDNbvncZwLKFQ1CRhECK5dCuYq+SEIDQ946n/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3eV915tKYLR81LxtlNmS6k2YcaDHO7Jn66K/TxjQys=;
 b=sJyqflAZWn1QspyIx/ohqo18R5YUSWZy7GoQtwsEPPq3lpurqSPMVGStVdG6ernUivD/5WtoOdIDTc0rSgyfr6nA4B4DJYT5jbKBTWUHeykXHSf9Sqt9O5FID0xuzqs+rLpmZvBZI9XDLwD25VAj4YRamX7Qz0zQewybcNDtKLo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6143.jpnprd01.prod.outlook.com (2603:1096:400:4b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 11:37:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 11:37:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v8 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZDIEsrYKMEeT36E+G1XejOE/ny65o5OgAgAE0G6A=
Date:   Mon, 12 Dec 2022 11:37:37 +0000
Message-ID: <OS0PR01MB5922FD8F72EDE1E5D3EACE7686E29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
 <20221210102110.443043-5-biju.das.jz@bp.renesas.com>
 <Y5YHdKvn6AY0o9Gc@fedora>
In-Reply-To: <Y5YHdKvn6AY0o9Gc@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6143:EE_
x-ms-office365-filtering-correlation-id: 1bb30a73-5001-4e13-fe66-08dadc35453a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zwgv6ISv4AZQX6TjolhVN4DVDIPfSp+0b+PFGq/RhY1nf6jEJhWtIZCxQmFThyF3gzzhknokbb2YeYkkBpjmmlkeRtiWCtPG1oX9hP3gkCN1p/VGw4EdBoAwdUu+YMsyAmipt4tYBDJydok9iEw36Hh/t35uLeuqT8AOmmpzLkfpF5/uw0jxGYFW6DtfJ9j6VXHhLkYhC2ZP42z9gyZpahswqW8j0ZFvgbbkw7tpgol0Ta/Qbrmgq7sCSXjqwwc59JPhtcMAFTn8+auykxGJHH6Dt0hTwevFGM2uqS3qmAgrvtWmXnpTA7BgNdEsFJobJrJzI9G1zNOT8sA1a5sAHdHaKJGfiKXv5GJkcmzH2vyy3kvbXWYAz6NUQnVAGtoSA4YjGHEJVfOFqUQTphmMCYIhcsmQZdyWB9G41oPe+H0T7kByL6pmEy+9ncfscx8m3TmqZOypVdNvapvnjqiIiK4317eMNsOcs+evs6GMyjytY3VkLIZxxpCQJnvjho2lvq0lc39zj5PgWH0x5SM3FjDSLA962XVuzmuUgrfwjjUUpEtGU4WEQR65eQZmfTlZ2cTlUzy8DX6HrHk4q311nVHonkQad5nUwfV4vBSOwhUCK1oR4rFTvR8SDujgUrEZfeJaEMQpVXkh/U0uqiSdA1P4Hy2cpfw9NPaCte9jjvLHeL/ayJYTMoThr2VnvPcliNahpaRNklWj0WJnzyhEXJR81QvaBvfMXdqYzN6USsc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(33656002)(64756008)(76116006)(66946007)(66556008)(2906002)(38070700005)(54906003)(66476007)(8676002)(316002)(6916009)(4326008)(41300700001)(66446008)(83380400001)(38100700002)(122000001)(55016003)(86362001)(6506007)(7696005)(26005)(9686003)(8936002)(52536014)(5660300002)(478600001)(71200400001)(186003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CZBftrYFI+lJGyfUBWKpBwlyibtpdKvx3tpkEdVAG6M7V5lyejtcfBdrpq81?=
 =?us-ascii?Q?QkyDD3sihD+LOfblariiRgYt+awBtxChkFKjHYzeRMBqwlXqvmDbQIstnb8R?=
 =?us-ascii?Q?JZ9xjK0Xa0ETx82LaenAxvBLk2h/I09qgHr/eUgGXJ3Qx9IKJAVW+L2SWQAG?=
 =?us-ascii?Q?XD8ednUDox/jOdBFshskwnSe95pm7ZNhHvq33EjEFxbhKKuoWJ/T16c94HtC?=
 =?us-ascii?Q?e15U6wrdEKteXl2uhvyvkY+BIbpwGqPLU7W8B4UaM+5VWj24fkugF2BeSOP/?=
 =?us-ascii?Q?r/IQdWKKqBfmFI7b12WUV4sCoiDidL0Yp7Trgk2rYpXqNGDK8Kpdx5DCnc25?=
 =?us-ascii?Q?eyxIQ4DtnfVklUnLqBpeB0B6dBKd9ypMFRjcph1c1uZbDKA/q/RzqcBcvm1m?=
 =?us-ascii?Q?7e2Z+g7SB9t8OIeTyB71roGXoy2Y+UaMtwd5S8ECxIp5trV4QL8fqb2bG73c?=
 =?us-ascii?Q?H7Y38JSY9wGyDONhp5XbICZUlLqe9ZYxM9kzduciIXN2Qh41eJoiKkFeMJbS?=
 =?us-ascii?Q?mrrwLLu3QRNRgY95ZojCYyeQsTW6QxDWgYYw9YrDDci/PNB2ghP2HXEQwJxt?=
 =?us-ascii?Q?Hoa5maymON26ADkIUby+QBdfAHqcn9JkrNPUvCWUUsPZV7jPmLHvcZ2Ouq0a?=
 =?us-ascii?Q?/AMg6AwkY3gjBVQWsT4NrIqgcPhyhg51ZUUOawql41/NdoungX4La2nBwFz9?=
 =?us-ascii?Q?u1LNDU8WqFQSewnb/+WuZSsQaaDFn3oVVTaPKujacrxk1nF3NcyACw0bK5qT?=
 =?us-ascii?Q?iQGvirWC9FucpIYF+n6HfYqk3AAIPMDmca7D2iEHz1YcyhUFSAhOGMxmD7Ne?=
 =?us-ascii?Q?/39S0meTTDWFZnbSlzC8zL1PIsSpSXdXTZHlT9+zBTen0OBgn+/kBvdcx/ou?=
 =?us-ascii?Q?VEs/7EyzO0NwlzL3mxxVorPeAWB04nOjoriaQCBVV4XuUgmkQs7n50HHHilN?=
 =?us-ascii?Q?TbOSv8W9as223BkppdMa/1yatiMcfycTYTy66d0lKp3RJX/c6myuISth62tG?=
 =?us-ascii?Q?SFakaWsSUI86gS+2oAcUnoZeGTrayVRqJ+doEF3o19X8sEoQ9fDEe+1IiOe/?=
 =?us-ascii?Q?a/csdw55NPbNqgSHqSeo1+GbNvuDd6BC9aAdv+g5IdNWSRSD6W89Pajdhw1T?=
 =?us-ascii?Q?vB2A4SuQ8sfNsoFtQWDNCMLHMRqdCMj1oay/PEjjHWscyzr37YLZ6u8NqemU?=
 =?us-ascii?Q?1MEKXdVj1xoFfRxjX8svbUiv3RGioUZYx5QLjbO6sAIcRBNAMa/l9jR5Wiaf?=
 =?us-ascii?Q?GA3vCWUyNNj2iJtJ+Uog+8E4Z68WX8MBuDPfPO3ujoGrTaOGA/KUyOsge45h?=
 =?us-ascii?Q?/4lHe44+mvXmlVbEwltpExUc5yUeXvdTZOpOTCqd59RUiPbqSkbBgZr/AEof?=
 =?us-ascii?Q?V/qvLxj317FVLygArSSRShPz92EdRILkujGOt62IggXCAsO5fM60eiPhb8+c?=
 =?us-ascii?Q?yl5yF7rv1NrDlfWZ1N/QgonVKwUa7K4dxJkSDYfUB0aUJi1cmg7w+y9Hx764?=
 =?us-ascii?Q?EwXjUaFVH7x8dwB+tV7hQM4fTI5Z0EZwv25j5VAx7DyxHY2mWU1ekxueEmxE?=
 =?us-ascii?Q?nZMzWEN7LQo7IBYalHShMLgPfUTZGqGjKG4zsSbI3D/f81Z75naM6BGXWUwC?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb30a73-5001-4e13-fe66-08dadc35453a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 11:37:37.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOmoqdOEcwZCv/tRyHjMHargFjq1FxwkSJ2JWOvbdARdpKyhX//Xke15bZK/aASJEWCgsQ+xWYcvzooIa8lor+DkDJX2w0a+9PbxZTYQVic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6143
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

> Subject: Re: [PATCH v8 4/5] counter: Add Renesas RZ/G2L MTU3a counter
> driver
>=20
> On Sat, Dec 10, 2022 at 10:21:09AM +0000, Biju Das wrote:
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
> I see you use rz_mtu3_request_channel()/rz_mtu3_release_channel() to shar=
e
> access to the channels between the drivers. The Counter sysfs attributes
> can still be accessed when a channel is released, so should
> ch->is_busy be checked before every Counter callback to ensure we do not
> try to access a busy channel?

OK will introduce "count_is_enabled[3]" in priv and=20

use
(ch->is_busy && !priv->count_is_enabled[count->id]) to make sure
is_busy is because of pwm acquired channel.

Also, will add pm_sync and pm_put for register_{read, write} in all callbac=
ks
So example usage is

echo "MTCLKA-MTCLKB" >  /sys/bus/counter/devices/counter0/external_input_ph=
ase_clock_select
echo 1 > /sys/bus/counter/devices/counter0/cascade_counts_enable

echo 0 > /sys/bus/counter/devices/counter0/count1/count
echo 20 > /sys/bus/counter/devices/counter0/count1/ceiling
echo 1 > /sys/bus/counter/devices/counter0/count1/enable

cat /sys/bus/counter/devices/counter0/count1/direction
cat /sys/bus/counter/devices/counter0/count1/count

> > +static inline struct rz_mtu3_channel * rz_mtu3_get_ch(struct
> > +counter_device *counter, int id)
>=20
> I'm not sure why this is split between two lines but you can put it all o=
n
> one.

It comes about 93 columns. As checkpatch is ok with this. I will make it to
one line.

>=20
> > +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter,
> > +int id)
>=20
> It doesn't look like you're using the 'id' parameter in this function so
> you might as well remove it.

Agreed.

>=20
> > +	switch (id) {
> > +	case RZ_MTU3_16_BIT_MTU1_CH:
> > +	case RZ_MTU3_16_BIT_MTU2_CH:
> > +		if (!rz_mtu3_request_channel(ch))
> > +			return -EBUSY;
> > +
> > +		rz_mtu3_16bit_cnt_setting(counter, id);
> > +
> > +		break;
> > +	case RZ_MTU3_32_BIT_CH:
> > +		/*
> > +		 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
> > +		 * cascade counter.
> > +		 */
> > +		if (!rz_mtu3_request_channel(ch1))
> > +			return -EBUSY;
> > +
> > +		if (!rz_mtu3_request_channel(ch2)) {
> > +			rz_mtu3_release_channel(ch1);
> > +			return -EBUSY;
> > +		}
> > +
> > +		rz_mtu3_32bit_cnt_setting(counter, id);
> > +		break;
> > +	default:
> > +		/* should never reach this path */
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
>=20
> Instead of the two 'break' statements in the switch block above, replace
> them both with 'return 0' and then you can get rid of this 'return 0'
> at the end.

Agreed.

>=20
> > +		if ((mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_A_ID ||
> > +				       synapse->signal->id =3D=3D SIGNAL_B_ID)) ||
> > +		    (!mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_C_ID ||
> > +					synapse->signal->id =3D=3D SIGNAL_D_ID))) {
>=20
> That's a lot of expressions to evaluate, so it's easy for someone to get
> lost in what's happening here. It'll be good to refactor by spinning off
> the signal check to a bool variable. For example:
>=20
>     const bool is_signal_ab =3D (synapse->signal->id =3D=3D SIGNAL_A_ID) =
||
>                               (synapse->signal->id =3D=3D SIGNAL_B_ID);
>     ...
>     if ((mtclkc_mtclkd && is_signal_ab) ||
>         (!mtclkc_mtclkd && !is_signal_ab)) {
>             mutex_unlock(&priv->lock
> 	    return 0;
>     }

Agreed

Cheers,
Biju

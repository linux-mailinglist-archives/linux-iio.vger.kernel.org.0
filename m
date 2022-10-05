Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA85F5290
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJEK3W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJEK3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 06:29:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2117.outbound.protection.outlook.com [40.107.114.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F6691B1;
        Wed,  5 Oct 2022 03:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmlFG5Z/TJrOTDJa8GCDqISjOrBX4RtnhPz6A3IG7GVT78YolSD/PfPIGnzPEAyGQRNvV+3im0OzDHVN59wuNyLMRJgZUHafgtPIuIA79JsxkQCLqQlrV5iC3aLpixXV3OnGZ5iKJPO4Jn+zcVyALuevrEK/+mhdeS+Nx7YjNtLaRIi4eZ9PflPbhyzOzKa+pRIJVqpr/tGj4N0vWzzSZbOglq4ggcEeNiHFo6ZvIN2QUhGsMJnkXN3QzYg+FwtHlnGXS8LZIKgjVOS/54MFRQKOwJU+iG35WZw70zMsWJqJpQY/mOUCET1mkd0mo/rAXKKZ2KlINdbhVQux6VgBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Cl/GxmPrS2CSiqgBqMnnkw1BZuvNJtgsvCVLgh5Vyg=;
 b=M5MF2xb2NHXsiwApEFVqp4ua415p9Ze0uEzaVfjr7DNvoMhemVdvoJh9nTxbB/qvwNCYLNIdN5hFT0JiwWHz4RtR/q2hh7C2CZbFco1xYt/yM6FHxE/loMBY9EFk+Q7ejco1lsMesu5W62Rjstn28dHHflxTg1waMgBVX459NH4+IENsiyueFfS8ixHQsEEd9gV/GUpVtiP/P7y7dKcGKij0VsjQhUQkKRCWn9D2VH0W3MUa+MiOno7JuonA7xEYkYaTlxkRP6Q8oDptHjIx7xaBUA6mpb95cSrYL4KgVY8WOT0L3zeua8DSK4kZWUdJbU5NvHE/PIW+5xt1hPs90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Cl/GxmPrS2CSiqgBqMnnkw1BZuvNJtgsvCVLgh5Vyg=;
 b=peP1WiQ3hStaPHNqMC5KkIXcILxcq8z+kNpuMtFQSCo/tAp5BPOFgKPoentMpXmTgtSVaKk1SeHrMF6G71D4F2moyiZQIllry7A2D1chWV02pWBdFjYrOeoBjkbYtI0vgi5O75tbFmjvpoWlRUYVs42VB73kc4POAUl8hKLq0RQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5438.jpnprd01.prod.outlook.com (2603:1096:404:8025::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 10:29:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 10:29:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 5/8] counter: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH RFC 5/8] counter: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY0arpHs/3VNKes02ni52SFatgc634tJIAgAbvIMA=
Date:   Wed, 5 Oct 2022 10:29:17 +0000
Message-ID: <OS0PR01MB59222DB035C06A9411E6DC33865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <20220926132114.60396-6-biju.das.jz@bp.renesas.com> <YzeIYLrZTHGXfcOV@fedora>
In-Reply-To: <YzeIYLrZTHGXfcOV@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5438:EE_
x-ms-office365-filtering-correlation-id: eb6c68d1-ec88-47e3-eb42-08daa6bc751c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQhRGjlNEfyaGKM8ETC9oncJO7YJMuTsPrXZbohD20Aj5YAQCR5xjbwDm48sF7tV1zWcsgKekcv9qdomPrX7eZXDF1XjSoQfN5GxuQ/LjPWZqGGY0xk90UnUg9UK46t8tyMT9cZlaNEsLJa0U9B1fOS7tvZdUzz+xZKXEen4oM33VIz84ZH4XNrmsQMsB5XdXPk8AyNeX4xtk4YMU9687z4M0GCpqNvpTl/ySZRPBKhXFl6dHglPvcPlwo1iMVQVyCsCaSYh8oih+MfhSCt7K0sHJd/slb/81/4y6l5vN3tVoA+2ZKhjnMv3Hnk9BCv3Vd7TJZtNSj4bI3wDdld/jRIlWrS4cEAZj9cJymFTewYRN9MMUmPKoKBTt+cdOOmtCeUy9vR0eVEe1z4nlzD5B3SnKKWdYrSVJ17+NLoHgCl/E8xuOdMn0OWvPJND+TAkGRTU7pNl8TTrQXrGW6QqUfZYbQG3u7DJgJXjPYE2DiHEThloZ77aOlo2M9zFWb9+bWgZjhsq6I6NcxgJwIdIXos4jMQBV7dzwYPlrrNGSzhLLGeRXgWF69NLpig6cOWgPrV/qwmHgewyg8RBIEVfbG+SxFtYFz0sUzhLcidBXvz/RH4OFLHE8imuWmkYaPd6TQqQ6dwneL+eAIe/EdHSm/gQ6RzM1zl5niZk0uVo07rkkWwzAdMBrJBm5XhOkbHN85+nHVCuQ+oU31t3x7t5A4tSiSB2O8j9Q6xPAXq2gzfSBGw5uHEV5mV+4NaBeG2YZi2z2aGNLt32kTBrrrahItsR04gRgsD91URmcUBFVwQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(71200400001)(966005)(478600001)(54906003)(186003)(26005)(66556008)(33656002)(76116006)(6916009)(66476007)(66946007)(8936002)(122000001)(38070700005)(2906002)(5660300002)(9686003)(66446008)(64756008)(8676002)(83380400001)(4326008)(7696005)(6506007)(316002)(55016003)(41300700001)(86362001)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/FetOERt7eU9YuRb+kJDjr3p6rUft5qqMLEBL3ouu9mMQHKze8zzJatQllI?=
 =?us-ascii?Q?PViOxcxJh+Gw270VdEH0VSRRSB5GeLWwaw68TFJreMMDOSVH1ID+7b5TEYmL?=
 =?us-ascii?Q?ADLmaMwlI4/lD8Q0hNahsDBALdJiOXaQCd+y5C6TkcdeUXujaUfgU2OdKEf0?=
 =?us-ascii?Q?8DGa0znLE3HzpbvZfb187uAWGbjykZU+KzkSPlbckzUHQ4iSBHjn1mS7uwQK?=
 =?us-ascii?Q?7DBFjg2Mr6/4m4CpzPqnmHJb0XIZUqUdIwuYVMGUgwsPF2mC+wg+qpNL4KXJ?=
 =?us-ascii?Q?sx/thK1zQdcLZ903ApLiJYm2Rs1OBh4VJr2EKIwTGRd8IZ+hea00FvKn+cjS?=
 =?us-ascii?Q?e5ivRu0gNzn7cfHgGzO7WiA9B1H8ToUaxmF64zeGl4Nbei2jP4fhE6FUxKIy?=
 =?us-ascii?Q?9/vNrqYsc7TV1wByT1L/8LwZxsY3nE6zo95VGYO5oZZd3wIrbpAufx1/bGoW?=
 =?us-ascii?Q?fnK/xbLF3kCd6ULEtBb8j2otSwvm2dZ6M0jBgsDBKUUwlM5Yram/1NUubYUo?=
 =?us-ascii?Q?SS1iAH5sgmQH0+KfdvwCn4r4XZfbHpoDsnCp1A15r64IBS7UR1qmw2iT/gQd?=
 =?us-ascii?Q?f9f98c2AC+u/Q8jbK+MtrTEoYpvrXSt93pD5QZ0F5+HgtTE6fTdoP0X2JwfI?=
 =?us-ascii?Q?vTvtLJBBI9PRt6y+vP/48v1lbN+5SbtwpaH0b0PBT+UnMg0TArMzLvfdEHXZ?=
 =?us-ascii?Q?++dtFw5fDcue1YlHCEWwMGFpdYJg1InWiX0zv3JJ3JQ5iNhu2kPp7/bWql4X?=
 =?us-ascii?Q?Iwm3MErgIJKSzrfzClhtGHBkQMt8i+fp1/XK0uSZkUFBRYaV5PuXYrTBZq5C?=
 =?us-ascii?Q?v3cotDORfdyIfOwqxjkLgMgOXktfogxxiqjezF+wtzXkq3QtP9rtZOpODeUJ?=
 =?us-ascii?Q?qfD4fFPmmfTq91jZsb/NQ5FR1bxZtBZrJS1QtNAYjgb5rn54MTyTE6jHXX7p?=
 =?us-ascii?Q?sW4zXozB+le8CM3L+I9RYlqMXbPjyFzyQe9oIDAP0jvYZZH7HxZox2IU5ROe?=
 =?us-ascii?Q?cheI+/+v3UPXGN1WUHWc1aW59E5UgE9hlMxZJIU2RXsljvJATm0kSFV/22wT?=
 =?us-ascii?Q?YXPwgpNoUi6b42jypDW5OkCSWBkc68aqevDCr4KSa+SxYwHUDt6NC1aoHt1D?=
 =?us-ascii?Q?YZMg1+o16MHzUFsY8ySeajl5GJHMahf2yUdXO6/YTrJW8nc1fGTO2q5rVDKS?=
 =?us-ascii?Q?MAZMA4dlEpb6e1kDfkpxksqcOA7bL9BO04Dn+OCipUn/5VR4YDpluiDnfzel?=
 =?us-ascii?Q?w98ePh79RTgWEZ3sHIrKU8yu6PVx3GudzYxi1dvTsweSw+KB6Ks5TuuA/y4n?=
 =?us-ascii?Q?nK/t6IzQyQWIOkIkotQtNJu7o3u8lS2bK6lU+mDQhNxkhaICTZsBCD9jvZkI?=
 =?us-ascii?Q?69qHfMQaurisGWVFFpliK1HN0mk+7heVNmjMSyyws8YkO8ux1b0nuAArVN4K?=
 =?us-ascii?Q?aBq4e/ACeqtyGTJDS5VYtRc98qJog8hKmJjsJ7ZB5/RpXacQg/3e+rPGM66i?=
 =?us-ascii?Q?1Qh5zkijkY54NDerAzTefRhHCd1dBAVjX2D4rLsVnLifSHTh8Mgn2C0rg+F5?=
 =?us-ascii?Q?8zcw1DqK2w7Kv0UWHhjcv2RiFOJb9rq2FNYk9Kp7tgK3oLDHj02HULM8lsrr?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6c68d1-ec88-47e3-eb42-08daa6bc751c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 10:29:17.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDkNjKSeSnkVSCtsIRPjaiKJf5MzsJy22Mwe26e4zAzi1PgnOhIp9xEfnTa/dyS20w5kYdbvq5vV82lsSR2KfgWWvnZikzKN/oht78u0oag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5438
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

> Subject: Re: [PATCH RFC 5/8] counter: Add RZ/G2L MTU3 counter driver
>=20
> On Mon, Sep 26, 2022 at 02:21:11PM +0100, Biju Das wrote:
> > Add RZ/G2L MTU3 counter driver. Currently it supports 16-bit phase
> > counting mode on MTU{1,2} channels.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi Biju,
>=20
> This driver will likely change in your next revision, but I want to
> give some feedback anyway on a few things I noticed. See the comments
> below.
>=20
> > +struct rzg2l_mtu3_cnt {
> > +	struct clk *clk;
> > +	void __iomem *mmio;
> > +	struct rzg2l_mtu3_channel *ch;
> > +};
>=20
> Add kernel-doc comments to document this structure. It seems that
> neither clk nor mmio is access in the code from this structure; what's
> the purpose of having them here?

OK, will do. mmio is not required. But clk is needed.

>=20
> > +static int rzg2l_mtu3_count_read(struct counter_device *counter,
> > +				 struct counter_count *count, u64 *val) {
> > +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 cnt;
> > +
> > +	cnt =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TCNT);
> > +	*val =3D cnt;
>=20
> The rzg2l_mtu3_16bit_ch_read() function returns a u16, so there's no
> need for the cnt variable; just return the count via val directly.

OK. Agreed.

>=20
> > +static int rzg2l_mtu3_count_write(struct counter_device *counter,
> > +				  struct counter_count *count, const u64 val) {
> > +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u16 ceiling;
> > +
> > +	ceiling =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
> > +
> > +	if (val > ceiling)
> > +		return -EINVAL;
>=20
> Return -ERANGE instead to indicate the request is outside the
> boundary.

Ok. Agreed.

>=20
> > +
> > +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TCNT, (u16)val);
>=20
> Remove the explicit cast to u16, it's already implicit in the call.
> You probably also need some sort of lock in this function to ensure
> that your ceiling value does not change before you write to the
> register.

OK agreed.

>=20
> > +static int rzg2l_mtu3_count_ceiling_read(struct counter_device
> *counter,
> > +					 struct counter_count *count,
> > +					 u64 *ceiling)
> > +{
> > +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 val;
> > +
> > +	val =3D rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
> > +	*ceiling =3D val;
>=20
> Same comment as in rzg2l_mtu3_count_read().

OK agreed.
>=20
> > +static int rzg2l_mtu3_count_ceiling_write(struct counter_device
> *counter,
> > +					  struct counter_count *count,
> > +					  u64 ceiling)
> > +{
> > +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	if (ceiling > U16_MAX)
> > +		return -ERANGE;
> > +
> > +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA,
> (u16)ceiling);
> > +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
> > +				 RZG2L_MTU3_TCR_CCLR_TGRA);
>=20
> Same comments about cast and lock as in rzg2l_mtu3_count_write().

OK agreed.

>=20
> > +static int rzg2l_mtu3_count_enable_read(struct counter_device
> *counter,
> > +					struct counter_count *count, u8 *enable)
> {
> > +	struct rzg2l_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	int ch =3D priv->ch->index;
> > +
> > +	*enable =3D (rzg2l_mtu3_shared_reg_read(priv->ch, RZG2L_MTU3_TSTRA)
> &
> > +		(0x1 << ch)) >> ch;
>=20
> A lot of operations happening in a single line; can this be broken
> down to clearer distinct steps?

OK agreed.

>=20
> > +static int rzg2l_mtu3_action_read(struct counter_device *counter,
> > +				  struct counter_count *count,
> > +				  struct counter_synapse *synapse,
> > +				  enum counter_synapse_action *action) {
> > +	enum counter_function function;
> > +	int err;
> > +
> > +	err =3D rzg2l_mtu3_count_function_read(counter, count, &function);
> > +	if (err)
> > +		return err;
> > +
> > +	switch (function) {
> > +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> > +		/*
> > +		 * Rising edges on signal A updates the respective count.
> > +		 * The input level of signal B determines direction.
> > +		 */
> > +		*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>=20
> You need to differentiate between signal A and B here: the Synapse for
> signal A will have an action mode of COUNTER_SYNAPSE_ACTION_RING_EDGE,
> but the Synapse for Signal B will have an action mode of
> COUNTER_SYNAPSE_ACTION_NONE because its not the trigger point for the
> respective Count value update.

OK, Will do.

>=20
> > +		break;
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> > +		/*
> > +		 * Any state transition on quadrature pair signal B updates
> > +		 * the respective count.
> > +		 */
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>=20
> Similar to above, you need to differentiate between signal A and B
> here as well.

OK, will do.

>=20
> > +static struct counter_count rzg2l_mtu3_counts =3D {
> > +	.id =3D 0,
>=20
> The id member is an optional way for driver authors to identify their
> own Counts; it can be set to anything your like, and if you don't use
> it in your code then you don't need to set it at all.

It is being used in the next version.

>=20
> > +static int rzg2l_mtu3_cnt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev =3D &pdev->dev;
> > +	struct counter_device *counter;
> > +	struct rzg2l_mtu3_cnt *priv;
> > +	int ret;
> > +	u32 ch;
> > +
> > +	if (IS_ERR_OR_NULL(ddata))
> > +		return -EINVAL;
>=20
> Is this actually possible? What situation would cause this, and why is
> it not handled before we reach probe()?

Theoretically not required as parent device populates child devices.
I will remove it from here.

>=20
> > +
> > +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> > +	if (!counter)
> > +		return -ENOMEM;
> > +
> > +	priv =3D counter_priv(counter);
> > +
> > +	ret =3D of_property_read_u32(dev->of_node, "reg", &ch);
> > +	if (ret) {
> > +		dev_err(dev, "%pOF: No reg property found\n", dev-
> >of_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ch !=3D RZG2L_MTU1 && ch !=3D RZG2L_MTU2) {
> > +		dev_err(dev, "%pOF: Invalid channel '%u'\n", dev->of_node,
> ch);
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv->clk =3D ddata->clk;
> > +	priv->ch =3D &ddata->channels[ch];
> > +	priv->ch->dev =3D dev;
> > +
> > +	counter->name =3D dev_name(dev);
> > +	counter->parent =3D dev;
> > +	counter->ops =3D &rzg2l_mtu3_cnt_ops;
> > +	counter->counts =3D &rzg2l_mtu3_counts;
> > +	counter->num_counts =3D 1;
>=20
> Even though you only have one Count defined, use ARRAY_SIZE here for
> consistency with the other Counter drivers as well as making the
> intention of the code clear.

OK will use array.

>=20
> > +	counter->signals =3D rzg2l_mtu3_signals;
> > +	counter->num_signals =3D ARRAY_SIZE(rzg2l_mtu3_signals);
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	/* Register Counter device */
> > +	ret =3D devm_counter_add(dev, counter);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to add counter\n");
>=20
> The Counter driver goes live with the call to devm_counter_add() so
> move it to the end after your device initialization code below.

OK. Agreed.

>=20
> > +
> > +	priv->ch->function =3D RZG2L_MTU3_16BIT_PHASE_COUNTING;
> > +	ret =3D clk_prepare_enable(ddata->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Phase counting mode 1 will be used as default
> > +	 * when initializing counters.
> > +	 */
> > +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TMDR1,
> > +				 RZG2L_MTU3_TMDR1_PH_CNT_MODE_1);
> > +
> > +	/* Initialize 16-bit counter max value */
> > +	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
> > +				 RZG2L_MTU3_TCR_CCLR_TGRA);
> > +	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA, U16_MAX);
> > +
> > +	clk_disable(ddata->clk);
>=20
> Should this be moved up near the clk_prepare_enable() call above?

OK.

>=20
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_ALIAS("platform:rzg2l-mtu3-counter");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
> > +MODULE_LICENSE("GPL");
>=20
> Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.

OK.

>=20
> Make sure you're based on top of the counter-next branch. You can find
> the Counter tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git

Agreed.


Cheers,
Biju

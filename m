Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E628462B1D1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 04:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKPD1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 22:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiKPD1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 22:27:13 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B00167EA
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 19:27:11 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id c8so11098170qvn.10
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 19:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6eIwAY8HSvwYTsmXKy1wGQnYbn7a7e06575PqF/Xl4=;
        b=ZLoHWypsmWEzh60HFrgaq1PIZfm8WqNFK0IT1AcnlkqsxWvKCCN8ItLoxhz29JeHI4
         m3T3BU1vEVHYkwdI2Tv/D2v4WrpFqkJSFS3g2t0G7lTd8eS+AupOdGeYv0h5S7cmS/04
         Hh7E3AEeFSWX2jObmerrztFd1eyM+fE9vovQycgDGeOtNc8N2abl0fxwAhT0Py8UhDq3
         OjTg3qJMhuldE+n0YvXwC7OGzlyXmgWOCxZMlf58Y75PsxkCivRjRDI8RerKFxkBWGSG
         VegMJTEOp3MC1Gv4GArXm+OtWbi0Y4JS61jm1wWK3BZF4kR7VoLXBYL+ZF4dY4vX9Us+
         83oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6eIwAY8HSvwYTsmXKy1wGQnYbn7a7e06575PqF/Xl4=;
        b=60y3wTuXVO0FyW3Hfd0it2t3HhZSDZemFyVmRjI2Jo3/OnXJbxZO0MDNa9FPKzIbrr
         wqQ2dip3t/8bslgqWv0ErGt8U65KLl7Exrew/EzKjI9lpPOl/f0m3jGr+hHx033iShRE
         QUWHrYVtNmH/on1XJ73f8D6LS7vfIc58Yg9SjJ2glea/HOnTbx4oFXclq2XgMjLZQM4k
         MMcOFOkxWDL9LJTXJkjSpI3FZgzYPXdkDFrPFaYZjIUu/z/ifR7ePJj7oyruloLY5pnm
         XldXrVcu0kvnTUing3L6fMY1VKHdPn51uU67zFQ5bzSYFCBzNvNi7CB3BdJTGSL7WrH8
         ABaQ==
X-Gm-Message-State: ANoB5pmBRIhccqMt0YqjN/rb4qNYWqE01+TAJpuV+Yq/qY1hMSpfWDoB
        lQG2ejATORlsCeLZyo+QKTm8sA==
X-Google-Smtp-Source: AA0mqf4mLRZ+JyYa3+vL4prp/khANaOcSFSAM76LJOBW2ovcRn/tw6n1PldM/+e2lmrM2R5gInvwzw==
X-Received: by 2002:a05:6214:18ce:b0:4af:b21e:168b with SMTP id cy14-20020a05621418ce00b004afb21e168bmr19877550qvb.46.1668569230594;
        Tue, 15 Nov 2022 19:27:10 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b13-20020ac86bcd000000b003a57a317c17sm8090080qtt.74.2022.11.15.19.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:27:09 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:27:07 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>, thierry.reding@gmail.com
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y3RYi7TwfprsI6G1@fedora>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
 <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HGXUypfC3fw9Hq0d"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HGXUypfC3fw9Hq0d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 03:24:26PM +0000, Biju Das wrote:
> > > +#define RZ_MTU3_GET_HW_CH(id) \
> > > +({ \
> > > +	size_t _id =3D (id); _id =3D (_id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : _=
id; \
> > > +})
> >=20
> > I probably missed a discussion about this change in a previous thread; =
what
> > is the purpose of using a local size_t variable here? Is this due to the
> > "possible side-effects" mentioned in the patch changes note?
>=20
> Check patch is complaining=20
> "CHECK: Macro argument reuse 'id' - possible side-effects?"
>=20
> By using local size_t variable, it fixed the check patch warning.

Ah, I see what you mean: 'id' could be an expression (e.g. x++) which
would be evaluated twice if passed as the macro argument. I think
there's a compiler hint that will supress this warning, but I can't
quite remember it right now.

For now, I'd prefer this to be implemented as an inline function so that
the purpose of the code remains clear:

    static inline size_t rz_mtu3_get_hw_ch(const size_t id)
    {
            return (id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : id;
    }

> > > +/**
> > > + * struct rz_mtu3_cnt - MTU3 counter private data
> > > + *
> > > + * @clk: MTU3 module clock
> > > + * @lock: Lock to prevent concurrent access for ceiling and count
> > > + * @ch: HW channels for the counters
> > > + * @mtu_16bit_max: Cache for 16-bit counters
> > > + * @mtu_32bit_max: Cache for 32-bit counters  */ struct rz_mtu3_cnt {
> > > +	struct clk *clk;
> > > +	struct mutex lock;
> > > +	struct rz_mtu3_channel *ch;
> > > +	u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> > > +	u32 mtu_32bit_max;
> >=20
> > Does the ceiling set on the device get clobbered when you change betwee=
n 16-
> > bit and 32-bit phase modes (i.e. writing to TGRALW vs TGRA)? You have a
> > separate cache for the 32-bit ceiling value here, but if it is getting
> > clobbered then as a small optimization you may reimplement this cache a=
s a
> > union such as:
> >=20
> >     union {
> >             u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> >             u32 mtu_32bit_max;
> >     }
>=20
> Yes, it gets clobbered when we change between 16-bit and 32-bit mode.
>=20
> For eg: 0xbe1352 value=20
> Split up into mtu1.TGRA=3D0xbe and mtu2.TGRA=3D0x1352.
>=20
> OK will use the union.

Be sure also to check rz_mtu3_is_counter_invalid() in
rz_mtu3_count_ceiling_read() to make sure the proper ceiling is only
returned when its valid.

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
> >=20
> > Sorry if I asked this before: what are counting modes 3 and 5, and are =
they
> > not supported by this device? If they are not supported, please include=
 a
> > comment stating so in the default case block so that it is clear for fu=
ture
> > reviewers as well.
>=20
> Our hardware supports 5 phase counting modes. From that list, I match up =
some of the functions=20
> supported by the counter driver.
>=20
> counting modes 3 and 5 are supported by the Devices, but currently counte=
r driver is not supported this.
>=20
> Please see the attached counting modes 3 and 5.
> https://ibb.co/3YJByG1
>=20
> OK, I will add a comment for the details for modes not supported by the c=
urrent driver in the default block.

Those are interesting counting modes; it looks like counting mode 5 is
pulse-direction with an inverted direction, but I'm not sure what to
call counting mode 3. I haven't come across these counting modes before
so I wonder what sort of applications they're typically used for.

Typically we would add a new COUNTER_FUNCTION_* to represent each new
counting mode. However, for the sake of keeping this patch series simple
it will be okay to leave a comment in the default block for now
describing the missing counting modes and indicating that support for
them are TODO items for the future.

> > > +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter,
> > > +int id) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > > +
> > > +	/*
> > > +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascade
> > > +	 * counter.
> > > +	 */
> > > +	ch1->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> > > +	ch2->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> >=20
> > Can these "function" members be modified from outside this driver? If s=
o, you
> > could have a race condition here.
>=20
> OK will add channel specific locks to avoid the races.
>=20
> Do you prefer mutex or spin lock here? As channel selection is based on r=
untime decision
> For both PWM and counter??

Hmm, I'm not sure yet how best to handle this because if the PWM driver
changes the function in the middle of the Counter driver's operation
(or vice versa) we'll obviously have problems.

Thierry, do you have any ideas here for how we can gracefully handle
transfer of control between the PWM and Counter driver. I think a simple
mutex in struct rz_mtu3 should be fine: one driver locks it and the
other driver can return -EBUSY until its unlocked.

> > > +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> > > +				      struct counter_count *count, u8 enable) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> > > +	struct rz_mtu3_channel *ch =3D priv->ch + ch_id;
> > > +	int ret =3D 0;
> > > +
> > > +	if (enable) {
> > > +		pm_runtime_get_sync(ch->dev);
> > > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> >=20
> > The "enable" Count component serves to pause/resume counting operation;=
 that
> > means the existing count should not be lost when a Count is disabled. T=
he
> > rz_mtu3_initialize_counter() function will clear the current Count, so =
you'll
> > need to restore it before returning.
>=20
> Yes, it is doing pause/resume operation only. It is using clock gating an=
d PM operations.
> During enable, Channel is enabled, clk is on.=20
>=20
> During disable, Channel is disabled, clk is off.
>=20
> Here we are not losing the count when it is disabled and then enable part=
icular count.
>=20
> But we will loss the count, after disable, if it is used by other devices=
 such as PWM
> Or we are switching to 16-bit and 32-bit and vice versa.
>=20
> Maybe Will rename it to "rz_mtu3_{resume,pause}_counter" to make it clear.
>=20
> Compared to PWM framework we are missing export/unexport calls here in co=
unter subsystem.
>=20
> For PWM, we have an export/unexport calls for creating runtime pwm device=
s such as pwm0, pwm1 for pwmdevice.
> Here, count0, count1 and count2 are created during probe.
>=20
> My current test sequence is,
>=20
> 1) Set phase clk
> 2) Set cascade_enable
> 3) Set enable(Since we don't have export/unexport, I am using disable cal=
ls for freeing Channels for other subsystem)
> 4) Set count
> 5) Set ceiling
>=20
> >=20
> > Alternatively, the "enable" Count component is optional so you can remo=
ve it
> > if you don't want to implement it; just initialize the counter at probe=
 time
> > instead.
>=20
> Let me know your opinion based on the above?

Okay, I think I understand, the count is only lost if another driver
takes control of that channel. In that case, you can leave the code as
it is; there is no need to rename the functions. Once another driver
such as PWM has control over the device channel, it's unreasonable to
expect the Counter driver to maintain the previous device state, so
don't worry about trying to resolve that.

William Breathitt Gray

--HGXUypfC3fw9Hq0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3RYiwAKCRC1SFbKvhIj
Kw5KAP0RnUdfG0l4GuZSgJVwjvmd84ciukQELZ/K8VQVAsC5igD/SFoSL9eAWlRK
ZUopvEzKcJbE0HabWevjj35hgxROIAQ=
=jKr6
-----END PGP SIGNATURE-----

--HGXUypfC3fw9Hq0d--

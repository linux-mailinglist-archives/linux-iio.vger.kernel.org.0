Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC75FB678
	for <lists+linux-iio@lfdr.de>; Tue, 11 Oct 2022 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiJKPFX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Oct 2022 11:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiJKPEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2022 11:04:09 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BCCA571D
        for <linux-iio@vger.kernel.org>; Tue, 11 Oct 2022 07:59:27 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso10189719ooq.6
        for <linux-iio@vger.kernel.org>; Tue, 11 Oct 2022 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1R2XHYhG7tLGMT55z9AHFkRYDYEPZkrqjvqR781+rik=;
        b=OtNlsJQCwUO0pK3lonPFFBIxSq/C/dIxlKSqoxwz0erw6PnQWbbN1hAdDBrCgqZHj7
         n12q7lirRIgIup45NkTApxHWetRL88yHJnGocM3ZUajr1kux40dEn8wcOZbUG19hixjk
         TkCOit/h/isvmZzOAsBIHCYZ3ju+qazTHuxrmQHclZP3FgPFW9dLARHIOlNWkcaWg0W3
         1n/jZzMSioNwdYTk1/ivnUyVoSSAzF+4dc2mqwhTa1esZOVs76ciA8NXb/8XoyfVYgrY
         JDtYBgYFnyJ8+IbXAtyHyN4sswVPsD8GwpMgx8FRafRQUpRbfwhD0s6LQ/MACyY2UkNq
         WcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R2XHYhG7tLGMT55z9AHFkRYDYEPZkrqjvqR781+rik=;
        b=GMfU5R7edy7CAChy/0yhxqcffYtv/mz/ONaSa84uRd1hCWLlnhEAwLUowEZOKEgkAR
         yQyt4ZZf+/ZDHa1LfWtv+wWaCg6ph2lnT5C7NyfOt6F1+El0wewyjwODjzyTxDkFogx+
         KPSUpH7wXh8/SjIwOCtjeQ8oRattA5w946JEHv+Wuir1Y3bTG0JL7OJ0bedQL9oczieJ
         lvLsXpXnyibrlKsRgas9Z962O6+h5U1CDUAs9UWfK2dNb6ys4Dit+EGUV56QUkimXZGl
         W0npeO3UcutjCiHP8r/fRYr+obx86PH7dcCgyRUFVrxD6KREwRr2SLZNj7Vo/I7krY2u
         Uxfg==
X-Gm-Message-State: ACrzQf1CmOgcsvtUdQk8/Sa0sDmsivo+UoxHEz+3Ex5yUwiwillLqAFg
        agpYFQrhLEKXYADoYn/wriEQig==
X-Google-Smtp-Source: AMsMyM7+RHeDbnNXmnCIiVEVspKqSax/L7qWP2DIt63VnePEUfBbYOEJAnsYj5N+3cp5ETgSUSi1gA==
X-Received: by 2002:a9d:4d07:0:b0:655:eab5:3c01 with SMTP id n7-20020a9d4d07000000b00655eab53c01mr10617844otf.253.1665499979446;
        Tue, 11 Oct 2022 07:52:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t20-20020a056870f21400b0013191b00f72sm6485882oao.17.2022.10.11.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:52:59 -0700 (PDT)
Date:   Tue, 11 Oct 2022 09:15:05 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Message-ID: <Y0VsWdrpoAhM2jK3@fedora>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
 <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e/hJ8wYBKKWjMEVp"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--e/hJ8wYBKKWjMEVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2022 at 09:01:21AM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
>=20
> Thanks for the feedback.

Hello Biju,

I see that you have already released a v4, so some of my comments may no
longer apply, but I want to respond here to continue our discussions;
I'll reiterate any relevant suggestions when I review v4 in the coming
days.

By the way, if you agree with a review comment there is no need to reply
with "OK"; just delete the parts you agree with from your response and
I'll know those are okay. Doing this will reduce the amount of text we
have to scroll through and thus allow us to focus on just the questions
we have remaining. ;-)

> > > +/**
> > > + * struct rz_mtu3_cnt - MTU3 counter private data
> > > + *
> > > + * @clk: MTU3 module clock
> > > + * @lock: Lock to prevent concurrent access for ceiling and count
> > > + * @rz_mtu3_channel: HW channels for the counters  */ struct
> > > +rz_mtu3_cnt {
> > > +	struct clk *clk;
> > > +	struct mutex lock;
> > > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> >=20
> > Does this need to be a pointer to an array of struct rz_mtu3_channel?
>=20
> Yes, HW has MTU{0..8} channels and MTU{1,2} supports counters
> At probe time this array is filled with *ch[0]=3D MTU1 and *ch[1]=3D MTU2

In the rz_mtu3_cnt_probe() function I see the rz_mtu3_cnt.ch elements
manually set to the address of each rz_mtu3.channels element:

    for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
        priv->ch[i] =3D &ddata->channels[RZ_MTU1 + i];
	priv->ch[i]->dev =3D dev;
    ...

The rz_mut3.channels member is a contiguous array of struct
rz_mtu3_channel. If you change the rz_mtu3_channel to a pointer to
struct rz_mtu3_channel, you can set it to the RZ_MTU1 offset address
outside of the for loop and thus avoid the double dereference because
these address are contiguous:

    priv->ch =3D &ddata->channels[RZ_MTU1];
    for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
	priv->ch[i].dev =3D dev;
    ...

> > > +	mutex_lock(&priv->lock);
> > > +	if (ceiling =3D=3D 0) {
> > > +		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> > > +				      RZ_MTU3_TCR_CCLR_NONE);
> >=20
> > Looks like something different is done when ceiling is set to 0. Would
> > you explain what's happening in this case and why it's different that
> > then else case below; in other words, what's the difference between
> > RZ_MTU3_TCR_CCLR_NONE and RZ_MTU3_TCR_CCLR_TGRA?
>=20
> RZ_MTU3_TCR_CCLR_TGRA --> for triggering counter count using Z-Phase sign=
al.
> RZ_MTU3_TCR_CCLR_NONE --> No clearing.

Does the Z-Phase signal trigger a reset of the counter count back to the
ceiling value? Does the count loop back to 0 when it passes the ceiling
value, or does it remain at the ceiling until the direction changes?
By "no clearing" do you mean that the ceiling is disabled in this case
and the Counter count increases without limit?

In the Counter subsystem, the "ceiling" Count extension puts an upper
limit on the Count value. This means that setting "ceiling" to 0 would
put the upper limit at 0, effectively restricting the Count value to 0
until the value of "ceiling" is raised.

If the device is unable to support a ceiling value of 0, you should
return -ERANGE rather than disable the ceiling.

> > > +static void rz_mtu3_16bit_cnt_setting(struct counter_device
> > *counter,
> > > +int id) {
> > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > +
> > > +	priv->ch[id]->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> >=20
> > If 16-bit phase counting is selected for one 16-bit counter, does the
> > other 16-bit counter need to be configured as well?
>=20
> Not required I guess, as it is run time decision.
>=20
> After this, if user tries to enable 16-bit on other channel,
> we will configure that channel. otherwise, we will return error,
> if user tries to enable 32-bit channel.
>=20
> Are you ok with this?=20

Because the phase mode affects how the device interprets multiple
channels rather than a specific one, maybe it's better to save this
state as an enum rz_mtu3_function member of struct rz_mtu3_cnt. Or if
this is affecting the entire device, move it to your struct rz_mut3 and
share a pointer to that for your Counter and PWM drivers.

It makes me wonder if the rz_mut3_cnt structure is necessary for this
Counter driver at all when you could pass a pointer your existing
rz_mut3 structure instead in order to access the channels.

> > > +	int ret =3D 0;
> > > +
> > > +	if (enable) {
> > > +		pm_runtime_get_sync(ch->dev);
> > > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> >=20
> > Are you using the Count's "enable" extension to switch between 16-bit
> > and 32-bit phase modes?
>=20
> No. But will use that for switching on the next version.

Sorry, I wasn't clear with my question. Please do not implement the
"enable" Count extensions as a way to toggle between the 16-bit and
32-bit phase modes. The purpose of "enable" is to provide a pause/resume
mechanism for a Count: the existing count value should be preserved when
a Count is disabled, and should continue where it left off when the
Count is enabled.

To support the phase mode selection, implement a Counter device
extension for that specific purpose. You can use DEFINE_COUNTER_ENUM()
and COUNTER_COMP_DEVICE_ENUM() to create a device extension that will
allow users to toggle between "16-bit" and "32-bit" phase modes. If you
need help with these macros, just let me know.

> > > +		.name =3D "Channel3 Count(32-bit)",
> >=20
> > We probably don't need the "(32-bit)" in the name when it's obvious
> > already from the channel id and ceiling value.
>=20
> OK will remove it.
> >=20
> > I wonder how this counter is described in the RZ/G2L user
> > documentation; is it named "Channel 3" or "Channel 1 and 2"?
>=20
> It is mentioned as MTU1 and MTU2 channels.
>=20
> These channels can be used for phase counting and PWM operations.

We should avoid calling it "Channel 3" in that case to avoid confusion.
Perhaps "Channel 1 and 2 (combined) Count" would be better; that's just
something I came up with off the top of my head, but if you can think of
a better way to phrase it then please do.

William Breathitt Gray

--e/hJ8wYBKKWjMEVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0VsWQAKCRC1SFbKvhIj
K3EpAQDdKFP5efpN2b1Pne7SW7Do5WOfP9CYPhS9SCeUqxWCmQD8C4b1baU3qrUa
1eMvvhb5i34i/3XiA2bMcxBBHlpbbAc=
=Bpq1
-----END PGP SIGNATURE-----

--e/hJ8wYBKKWjMEVp--

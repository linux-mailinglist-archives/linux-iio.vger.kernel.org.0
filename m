Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252F601B97
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJQV6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJQV6M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 17:58:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952165F23D
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 14:58:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m6so7583790qkm.4
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oucTwVbi21mAnoJqkJdLFNIMbEnQmUYAya9mkLnN1g4=;
        b=UTFV9ab/N1F9aNa1FU1GQSBPajJd3WzTjlGh4OTMLPg5IS9g57/dPsknzYEEewvH5Z
         lZfzhDyLRPvyvfD/svmjd5EspRfdj6zOD8Q67uc22+2TBH7gSvLHm4exhN5SDHGLN+Mi
         28ZjAMT3/4hubaPOMcz9ueJYeI4dGCZSTQ4Axz9P4qAoIAhRzuAZyDJaTSS/aS9JnNz8
         fmf2lWjMocgj5suRPD61xaEek8NLygn0bvajrfoGAOlCjc1XPsgvCVPgufJgf6FIzcy4
         +XIOkz8f3GFqu+ShBO3cgLzafYh57nhRG+SLiOhsTHrjujtEkAviT4TjgAKz3DwHuboN
         hiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oucTwVbi21mAnoJqkJdLFNIMbEnQmUYAya9mkLnN1g4=;
        b=vTomhEkLs70eGfinI26JirdjTRiiyMN+CYiTfZ65amzXamnxzGaap2ED3S3TBJaQYP
         TaRvURF17szLbupE8HzLQ9x+nXfLZQq8ZtVPyLNmIYHiKxadiDXlvBTzUU1Z3mLglv9O
         aY7CPIQ76NiIlnnrL/g51F3ZtoLB+a4eeXVeIJxpEifnClk8VKlwzWkFbtgH7zthzXWY
         W2O27giMo1l3jk9I71uXp1s+NEirNxlWZfoqVaubgw4WC79JtLAHIDUic1YMiadYftPn
         fccqrTkrmmeXB3PnpXXxCVZyjqZOz0CPQ7BhpsaIn4krTSg/QmlZruClqx1M9Amc+Wz2
         DUqQ==
X-Gm-Message-State: ACrzQf1+X8eAucvdmkUZTvZIRSt7AN/o90EQOfOqdNBj7/EfxZhBF6mN
        k3JixKFzM9h/XY4LGyv8eV1mwo8vTLYlpw==
X-Google-Smtp-Source: AMsMyM5i6ITyDUrtCyl1qlhi+NcOdt9XwsjgoF69IDEVuxCs4Piwag9JN87BEt8M+oq3IObkqq8TQQ==
X-Received: by 2002:a37:30c:0:b0:6ee:a5d0:e91f with SMTP id 12-20020a37030c000000b006eea5d0e91fmr9232397qkd.309.1666043882694;
        Mon, 17 Oct 2022 14:58:02 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b006ce3f1af120sm815171qkb.44.2022.10.17.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:58:01 -0700 (PDT)
Date:   Mon, 17 Oct 2022 17:57:59 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y03P55QWFkDhtqt7@fedora>
References: <Y0q7Gzh95nFdqdYK@fedora>
 <Y00nidri3TRYARiu@kb-xps>
 <Y01QPkE0E+HR7dat@fedora>
 <Y02Lkpu+NCaPo/ZF@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zQZc1ZurNEhiI1YA"
Content-Disposition: inline
In-Reply-To: <Y02Lkpu+NCaPo/ZF@kb-xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zQZc1ZurNEhiI1YA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 07:06:26PM +0200, Kamel Bouhara wrote:
> On Mon, Oct 17, 2022 at 08:53:18AM -0400, William Breathitt Gray wrote:
> > On Mon, Oct 17, 2022 at 11:59:37AM +0200, Kamel Bouhara wrote:
> > > On Sat, Oct 15, 2022 at 09:52:27AM -0400, William Breathitt Gray wrot=
e:
> > > > I was looking over the microchip-tcb-capture driver recently and no=
ticed
> > > > that the code doesn't seem to account for Signal1. In particular, it
> > > > appears that mchp_tc_count_signal_read() and mchp_tc_count_action_r=
ead()
> > > > don't check the Signal id at all and just assume they are handling
> > > > Signal0. This creates a situation where the information returned fo=
r the
> > > > Signal1 sysfs attributes are just duplicated reports of Signal0.
> > > >
> > > > What exactly is the relationship of Signal0 ("Channel A") and Signa=
l1
> > > > ("Channel B"); is SignalB only relevant when the counter device is
> > > > configured for quadrature mode?
> > >
> > > Indeed both signals are required when in quadrature mode, where the
> > > signal0 is representing the speed and signal1 the revolution or number
> > > of rotation.
> > >
> > > We have described all availables modes in details in the following bl=
og post: https://bootlin.com/blog/timer-counters-linux-microchip/
> > >
> > > Regards,
> > > Kamel
> >
> > Thank you for the link, the block diagram helps illustrate how the
> > signals correlate to the TCB channels.
> >
> > Let me check if I understand correctly. In microchip-tcb-capture.c,
> > mchp_tc_count_signals[0] is TIOA0 while mchp_tc_count_signals[1] is
> > TIOB0? In quadrature mode, are TIOA and TIOB the two phases of a
> > quadrature encoder? You mentioned one signal is speed while the other is
> > the number of rotations; does this mean one signal serves as the
> > position incrementation from a rotary wheel while the other signal is
> > the index (z-phase) indicate for each full rotation?
> >
>=20
> IIRC this is indeed both signal edges (phase A and B) are accumulated on
> channel 0 and channel 1 stores the revolution or number of rotation of
> the qdec encoder.

Ah, I think I understand now: Signal0 and Signal1 are TIOA and TIOB
respectively; channel 0 and channel 1 are data registers; channel 0
holds the Count0 count value; channel 1 holds the revolution value (but
the microchip-tcb-capture driver does not expose it).

It might be nice to expose the channel 1 revolution value as Count1 at
some point in the future. However, channel 1 seems unrelated to the
current issue we're dicussing so we can avoid it for now.

> > In particular, I'm having trouble understanding
> > mchp_tc_count_signal_read(). I suspect it is unintentionally always
> > returning the signal status for TIOA::
> >
> >     regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
> >
> >     if (priv->trig_inverted)
> >             sigstatus =3D (sr & ATMEL_TC_MTIOB);
> >     else
> >             sigstatus =3D (sr & ATMEL_TC_MTIOA);
> >
> >     *lvl =3D sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEV=
EL_LOW;
> >
> > Here we read the status register for channel 0, select between TIOA and
> > TIOB based on priv->trig_inverted, and then return the signal level.
> >
> > I don't see priv->trig_inverted referenced anywhere else so it appears
> > that priv->trig_inverted will always be 0, thus resulting in
> > mchp_tc_count_signal_read() always returning the TIOA status. I think
> > the intended behavior is to return the status of the selected signal::
>=20
> IIRC the trig_inverted shall be used when signals are inverted which
> means we read position on TIOB and revolution on TIOA.

Sure, that seems like a reasonable option to expose, but it does not
appear that trig_inverted is being set or otherwise configured in the
current code, unless I'm missing something. It might be best to remove
trig_inverted if the functionality is not supported yet by this driver.

> >
> >     if (signal->id =3D=3D 1)
> >             sigstatus =3D (sr & ATMEL_TC_MTIOB);
> >     else
> >             sigstatus =3D (sr & ATMEL_TC_MTIOA);
> >
> > As for mchp_tc_count_action_read(), we have a similar problem: no
> > distinction is made for the Synapse requested. The channel mode register
> > for channel 0 is read and then masked against ATMEL_TC_ETRGEDG to
> > determine the action mode. It appears that this code is always assuming
> > the Synapse for TIOA is requested, but the Synapse for TIOB could be
> > passed. You can determine which corresponding Signal you have by
> > checking synapse->signal->id before deciding what action mode to return.
> >
>=20
> That is indeed a good point as both signals are eligible to trigger the
> TC for both modes (capture/qdec).
>=20
> > To clarify, in COUNTER_FUNCTION_INCREASE mode, does the Count value
> > increment based on the edge of TIOA and not TIOB? In
>=20
> Yes, currently the driver only support TIOA.
>=20
> > COUNTER_FUNCTION_QUADRATURE_X4 mode, does the Count value increment
> > based on both edges of TIOA and TIOB serving as quadrature encoding
> > phase A and B signals?
>=20
> Yes as explained above.

Okay this should be simple to resolve then: return -EINVAL if Synapse is
for TIOB in mchp_tc_count_action_write(), and pass back
COUNTER_SYNAPSE_ACTION_NONE for TIOB during non-quadrature mode in
mchp_tc_counter_action_read().

I'll submit a patch fixing these changes and the signal_read() callback
mentioned previously.

By the way, I suspect there are race conditions present in
mcho_tc_count_function_write() that could be resolved by adding a lock
to the mchp_tc_data structure and acquiring it before accessing the
device state and registers. It's unrelated to the Signal1 issues so I
haven't looked any further into it, but it's something you might want to
investigate to make sure you don't get weird behavior from the driver.

Thanks,

William Breathitt Gray

--zQZc1ZurNEhiI1YA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY03P5wAKCRC1SFbKvhIj
K3aXAQDGzD5h2fu3+Qlac5IYPLNcVpcAbQIRqxTZ48DvEkirMAD6A0DQyiSd/S2x
sMb2JiZGjvy7lKZ7XDAknTU9EAHodgk=
=+PTo
-----END PGP SIGNATURE-----

--zQZc1ZurNEhiI1YA--

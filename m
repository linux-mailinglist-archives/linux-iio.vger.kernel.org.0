Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3F325052
	for <lists+linux-iio@lfdr.de>; Thu, 25 Feb 2021 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBYNWt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 08:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBYNWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 08:22:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45773C061574;
        Thu, 25 Feb 2021 05:22:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so3575884pfj.12;
        Thu, 25 Feb 2021 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dbkQpNd5Wc1Bh81qcstyrrHXrqv5XpRWDvj0O1psJbw=;
        b=QXwYFJOhkT8yELYTe4PluG9O0HQW6nlLuRYLCjSRfqgEOnYGTpRJ8WeIR8HmVytLly
         uYwbFi7yoRwLFrZ9O2Fs0sWMPlm9DWu8pIo1HB0TAgsSvIm5gaCurN2T3nKvKCO9pbXN
         U5114B7otySof1hdMyh24EBAnoRcn/GADeIC/0bTN8cY26tyfsu42X0DFEAzlChD1Exf
         vZl0y4Lv44GXNxkhpDVeefrA2fVUMk/jNLCCGTeO1tn9yYk6EjORqeg53bwa6GzjlEyr
         iNIcqq5Oo5FxiuZ16dDR8cv0IMlPaPg0snZKKwEbKMPv3dw72m6Uh7/KBhjbpzVCuL9l
         2+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbkQpNd5Wc1Bh81qcstyrrHXrqv5XpRWDvj0O1psJbw=;
        b=FcIonQGsDkp/tpdai9WwS471oI380fIFvSv9Lhw+3xntEqcrobOxQ2nhl2+/ZPqDYn
         ncL128OBngnvL73xsssT1G2MgbE1xokxoWjxKcGr3T8qdOcP1/6IMl5mqb0Mw4+ZHdTz
         Txu/teubDb6ASWgqPeKuk6y91BYzSDJ/nL9AHXkv8Y4YDtXYFF4mZsah0p3Oc362qaSZ
         G7mQ7+iBdCiN1knx07i4j4ltmR2IavmIU9vEq2bbK8Ob0Fkv2i7xlcC4C/KDORNpz5YR
         rG1OBA56rpiYksVCpwg1Muwk6N7V5pMmDKP4RL0d/hoS9LrzhcM91a9UNipJ2PU/8v9i
         wROA==
X-Gm-Message-State: AOAM533O2yO3X3zkfAIfDTmm7JiJdhpDJgVCWNYGcqlF38qShNX5ajxu
        FQuDmvBebnd/uqeZa1VrSD8=
X-Google-Smtp-Source: ABdhPJx5B2zDz1NmyernrPD2VdZbdhb3KcHlWxb8WvzeAKI+vSi5tRZbFee/JCtsAEfn4B7UccP5Hw==
X-Received: by 2002:a63:2164:: with SMTP id s36mr3017110pgm.268.1614259327859;
        Thu, 25 Feb 2021 05:22:07 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id a2sm6424041pfi.64.2021.02.25.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 05:22:06 -0800 (PST)
Date:   Thu, 25 Feb 2021 22:22:00 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: Report count function when
 SLAVE_MODE_DISABLED
Message-ID: <YDekeKfygdUht3HL@shinobu>
References: <20210219095906.220382-1-vilhelm.gray@gmail.com>
 <288929fc-6984-072b-359a-10e163056bad@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4fpeKnoH9IErCEuJ"
Content-Disposition: inline
In-Reply-To: <288929fc-6984-072b-359a-10e163056bad@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4fpeKnoH9IErCEuJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 25, 2021 at 12:19:18PM +0100, Fabrice Gasnier wrote:
> On 2/19/21 10:59 AM, William Breathitt Gray wrote:
> > When in SLAVE_MODE_DISABLED mode, the count still increases if the
> > counter is enabled because an internal clock is used. This patch fixes
> > the stm32_count_function_get() function to properly report this
> > behavior.
>=20
> Hi William,
>=20
> Thanks for the patch, that's something I also noticed earlier.
> Please find few comment below.
>=20
> >=20
> > Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-=
timer-cnt.c
> > index ef2a974a2f10..ec6d9e89c028 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -44,13 +44,14 @@ struct stm32_timer_cnt {
> >   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
> >   */
> >  enum stm32_count_function {
> > -	STM32_COUNT_SLAVE_MODE_DISABLED =3D -1,
> > +	STM32_COUNT_SLAVE_MODE_DISABLED,
> >  	STM32_COUNT_ENCODER_MODE_1,
> >  	STM32_COUNT_ENCODER_MODE_2,
> >  	STM32_COUNT_ENCODER_MODE_3,
> >  };
> > =20
> >  static enum counter_count_function stm32_count_functions[] =3D {
> > +	[STM32_COUNT_SLAVE_MODE_DISABLED] =3D COUNTER_COUNT_FUNCTION_INCREASE,
> >  	[STM32_COUNT_ENCODER_MODE_1] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2=
_A,
> >  	[STM32_COUNT_ENCODER_MODE_2] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2=
_B,
> >  	[STM32_COUNT_ENCODER_MODE_3] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> > @@ -99,9 +100,10 @@ static int stm32_count_function_get(struct counter_=
device *counter,
> >  	case 3:
> >  		*function =3D STM32_COUNT_ENCODER_MODE_3;
> >  		return 0;
> > +	default:
>=20
> I'd rather add a 'case 0', as that's the real value for slave mode
> disabled. For reference, here's what the STM32 timer spec says on slave
> mode selection:
> 0000: Slave mode disabled - if CEN =3D =E2=80=981=E2=80=99 then the presc=
aler is clocked
> directly by the internal clock.

Ack.

> > +		*function =3D STM32_COUNT_SLAVE_MODE_DISABLED;
> > +		return 0;
> >  	}
> > -
> > -	return -EINVAL;
>=20
> Other slave modes could be added later (like counting on external
> signals: channel A, B, ETR or other signals). But this isn't supported
> right now in the driver.
> Then I suggest to keep the returning -EINVAL for the default case here.
> Do you agree with this approach ?

That should be fine; we'll fill in the additional cases as the
functionalities are introduced to this driver in the future.

> >  }
> > =20
> >  static int stm32_count_function_set(struct counter_device *counter,
> > @@ -274,31 +276,36 @@ static int stm32_action_get(struct counter_device=
 *counter,
> >  	size_t function;
> >  	int err;
> > =20
> > -	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
> > -	*action =3D STM32_SYNAPSE_ACTION_NONE;
> > -
> >  	err =3D stm32_count_function_get(counter, count, &function);
> >  	if (err)
> > -		return 0;
> > +		return err;
>=20
> This makes sense, in case the error reporting is kept above. Otherwise,
> it always returns 0.

Conceptually, a nonzero value from the function_get() callback should
indicate an invalid function mode for a Counter driver. The changes in
this patch should bring us to that behavior so fortunately we won't have
to worry about remembering whether the stm32_count_function_get() return
value is valid or not.

> > =20
> >  	switch (function) {
> >  	case STM32_COUNT_ENCODER_MODE_1:
> >  		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
> >  		if (synapse->signal->id =3D=3D count->synapses[0].signal->id)
> >  			*action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		else
> > +			*action =3D STM32_SYNAPSE_ACTION_NONE;
>=20
> More a question here...
>=20
> > +		return 0;
> >  	case STM32_COUNT_ENCODER_MODE_2:
> >  		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
> >  		if (synapse->signal->id =3D=3D count->synapses[1].signal->id)
> >  			*action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		else
> > +			*action =3D STM32_SYNAPSE_ACTION_NONE;
>=20
> ..., not related to your fix: In "quadrature x2 a" or "quadrature x2 b",
> the other signal determines the counting direction.
> I feel like this isn't really represented with the "none" action.

Be careful not to confuse the Generic Counter paradigm with the hardware
description of your device. Within the context of the Generic Counter
paradigm, Synapse actions are the trigger conditions of a hypothetical
counting function evaluating Signals for an idealized Counter. In other
words, a Synapse action indicates whether a Signal triggers a change in
the Count value, not whether the Signal value is evaluated by the
counting function.

"Quadrature x2 A" and "Quadrature x2 B" are two different counting
functions. Both happen to evaluate two Signals, but only one of those
Signals is ever triggering the counting function evaluation to update
the Count value. In other words, the Signal serving as a direction can
change value as much as you like but it will never trigger a change in
the respective Count's value; i.e. that Signal's Synapse action is
"none" because it does not trigger the count function evaluation.

> I just realized if we want to extend this driver to add new signals
> (e.g. like counting on chA, chB or even by adding other signals like ETR
> on STM32 with the increase function), this may start to be confusing.
> Currently only the two signal names could give some hint (so it's rather
> obvious currently).
>=20
> Maybe there could be some change later to indicate the other signal
> (channel A or channel B) participates in quadrature encoding ?
>=20
>=20
> Thanks and best regards,
> Fabrice

Well, one thing could try is to introduce new count functions in the
future if there is some configuration you want to support with a count
function evaluation that doesn't really fit one of the ones currently
available; we can create a new enum counter_count_function constant to
represent it.

Remember that in the Generic Counter paradigm we are not necessarily
matching hardware layout of your device, but rather abstracting its
functionality. Because of that, you can associate multiple Signals to
your Count component, even if your hardware device has only two physical
lines.

For example, let's say a counter device has 3 modes: quadrature lines,
external pulses, clock source. In quadrature lines mode, a "QUADA" and
"QUADB" signal are evaluate as a quadrature x4 encoding; in external
pulses mode, a "PULSE" signal is evaluated for both falling and rising
edges; and in clock source mode, a "CLOCK" signal is evaluated for
rising edges.

Using the Generic Counter paradigm, we would construct a Count with 4
Synapes associating the four Signals: QUADA, QUADB, PULSE, CLOCK. There
would be 2 count functions: COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
COUNTER_COUNT_FUNCTION_INCREASE. The following 3 configurations would be
possible:

* Count Function: COUNTER_COUNT_FUNCTION_QUADRATURE_X4
  Synapse Actions: QUADA =3D> COUNTER_SYNAPSE_ACTION_BOTH_EDGES
                   QUADB =3D> COUNTER_SYNAPSE_ACTION_BOTH_EDGES
		   PULSE =3D> COUNTER_SYNAPSE_ACTION_NONE
		   CLOCK =3D> COUNTER_SYNAPSE_ACTION_NONE

* Count Function: COUNTER_COUNT_FUNCTION_INCREASE
  Synapse Actions: QUADA =3D> COUNTER_SYNAPSE_ACTION_NONE
                   QUADB =3D> COUNTER_SYNAPSE_ACTION_NONE
		   PULSE =3D> COUNTER_SYNAPSE_ACTION_BOTH_EDGES
		   CLOCK =3D> COUNTER_SYNAPSE_ACTION_NONE

* Count Function: COUNTER_COUNT_FUNCTION_INCREASE
  Synapse Actions: QUADA =3D> COUNTER_SYNAPSE_ACTION_NONE
                   QUADB =3D> COUNTER_SYNAPSE_ACTION_NONE
		   PULSE =3D> COUNTER_SYNAPSE_ACTION_NONE
		   CLOCK =3D> COUNTER_SYNAPSE_ACTION_RISING_EDGE

So a Synapse action isn't where the differentiation occurs between which
Signals are evaluated by a particular count function; the Synapse
actions only indicate whether a change in the respective Signal value
will trigger an update of the associated Count value.

However, I see what you mean that this does leave some ambiguity when we
have multiple Signals associated to the same Count, yet various possible
count functions that only evaluate a subsection of those Signals.

Perhaps one solution is to create a second Count component dedicated to
just those Signals: so we impose a requirement that the only Signals
associated with a particular Count component are Signals that are
evaluated by all the specified count functions. Alternatively, perhaps
we can expose a new attribute to communicate which Signals are
evaluated.

We're starting to go off on a tangent here though, so lets postpone
this discussion to a later time, perhaps when support for the ETR signal
is proposed for this driver.

William Breathitt Gray

--4fpeKnoH9IErCEuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA3pFwACgkQhvpINdm7
VJIz8xAAkNBJ9CbKbEINNZHmehMRuz8Jh0VyG8CB8730GBAcPVHiRvgt/GAO1okb
NiDnZrTpThAnA6Wq2FJqDmeMIOqgxzgogeS/XD8zSLaXxnDELC72zbZA2adyBUX1
9E7gtWPXDLiuXyt371sWSCmJFV2AnMVyNrmoY6qT7Gm5iODQvkFpiqS47r4mRSFs
cdGbBf3t1vvB15wMvs2fGT48Tf6Cxc85nx/Qfcmp1D5DPsUb1MKJwBw3EvlkExpw
qpqgacIjmIqAUitqJRS8g/8qo4BRZ/pyqP74QIMgovOfnzAffdhuD9BJ7rotHMjo
axVmrrBxZuwinvbhfmRwq4RntKpXW+oLrgcKJe/cpnKqh9IvEUyXvUNZb2szbsZD
9tbtMwMMHzVQjNnRLyLuaZG8H2LcdVtHeZtkkJL635xSLMirPv+pnpa7d4wbNtNu
BCLbGnXq17S7jAE8DeiaGATrIevkA+njaQnlxoo8Vxvtw/33mJZB1ha0S2/N1r2d
klYM/88HSgMBywGiDF6lZSbKlavX/56OfMjWyjzHy+0ZukMXySYqIatfT29koIYh
Z85TrkWz9QjdHzHt/ngq8EjkEIwdl/mjq/ZVbg5FDs2NhiLYUywOrrbjSzmgAmk6
rE3/TYDLdO1zZ9j4h9v7XfLgHkZV3Fkeq4kigsVoZa0GuSfScMw=
=Hwqs
-----END PGP SIGNATURE-----

--4fpeKnoH9IErCEuJ--

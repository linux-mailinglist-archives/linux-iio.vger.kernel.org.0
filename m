Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BF345A9D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 10:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWJSX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Mar 2021 05:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCWJSE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2021 05:18:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59006C061574;
        Tue, 23 Mar 2021 02:18:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n11so11044976pgm.12;
        Tue, 23 Mar 2021 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1nvqAVkgaDQFydcSUnCRXIK8c0AoRKCmFEGXTN9RvU=;
        b=imMX+Bt4obmiMjQ1pw0rUa4CBgpfqjndlPSFB8JzWTlI3sM+qTgZKUbIx2fblMZQMR
         gLcsjhyVW4jPgVJ7d7Se/R4Lkea5A1MqIX3/h/PSz+MNF/NaUQvP9r6HS0A/G3TdjZ8d
         HHNYyOm6LJ/W0a4zJh1ytxTc1pcey4rc6XxzkJzaZEORkiRnkkKM73iHEYV0kIl3XGwm
         alLh7Lztb8ETaoSq/NNBbPtTc12QVGIxr2mTHFO9T19wQ+CgQglNBMgVlFTuRz5STTPb
         SPAuH7xd4Wqw4qq08BOCzb8GXlctZ1V83641bUDazRR7HVhMQh6YMFEqfGO/F49dDaY0
         cDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1nvqAVkgaDQFydcSUnCRXIK8c0AoRKCmFEGXTN9RvU=;
        b=GN/x+ExEjpV30m1Vx3In8jCrWwQ/ymPKT0aUmW8j+E/2qEpj/CySdnftBkAYQjLzz1
         PPFom//GkAkaDluh0jCzM7jdL3XElSElMHZ/UtNspDajmQLvF2k0YI3Fboe97pJPTGMU
         dZUWL6jUzw4qptpEvMbo89+iooqS3Bu34q8DHOhAzkBEMaJ1voGzGA/U5G88yPeejd5w
         4vcsWl0BT01pucZQxqR23npE7suZPL0a2JJ8t1kUL0vlRAsLv3RGF2RFEwukwdm86Wuh
         akxyhQaYqiHAIZ9QFH0ikNnySB2HvhX8JVZa78vN60Gs02Uk179zEMNDDAFAONheRzN3
         iGIw==
X-Gm-Message-State: AOAM531EBO46gnyoF0zfI8FiDrYd4OeEtb065yMtZcHsfCSvHzqZPvR6
        dG7KOXuTbWyYYJ/fxlLBMsk=
X-Google-Smtp-Source: ABdhPJypx1elQysu+4xRWNCydKD+DVTWMysYHRBHuvK19CoYX5iNseo29KB2p+23FI68f1U1eSeFBA==
X-Received: by 2002:a17:902:ecc4:b029:e6:1a9f:3397 with SMTP id a4-20020a170902ecc4b02900e61a9f3397mr4484729plh.9.1616491083851;
        Tue, 23 Mar 2021 02:18:03 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z8sm1925768pjr.57.2021.03.23.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:18:02 -0700 (PDT)
Date:   Tue, 23 Mar 2021 18:17:55 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, syednwaris@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@foss.st.com
Subject: Re: [Linux-stm32] [PATCH v10 22/33] counter: Internalize sysfs
 interface code
Message-ID: <YFmyQ4bnsS1lrm27@shinobu>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <51becb2e067a4d2ee7bd99beb007831022fc4b29.1616150619.git.vilhelm.gray@gmail.com>
 <4cef2478-4093-fdef-2ae5-c27d0e8e1ccd@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cqRhoqShv7pK17zI"
Content-Disposition: inline
In-Reply-To: <4cef2478-4093-fdef-2ae5-c27d0e8e1ccd@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cqRhoqShv7pK17zI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 05:44:01PM +0100, Fabrice Gasnier wrote:
> On 3/19/21 12:00 PM, William Breathitt Gray wrote:
> >  static const struct atmel_tcb_config tcb_rm9200_config =3D {
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm3=
2-lptimer-cnt.c
> > index 13656957c45f..aef78a4217b5 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/types.h>
> > =20
> >  struct stm32_lptim_cnt {
> >  	struct counter_device counter;
> > @@ -130,32 +131,46 @@ static int stm32_lptim_setup(struct stm32_lptim_c=
nt *priv, int enable)
> >   * +---------+----------+----------+---------+----------+---------+
> >   */
> >  enum stm32_lptim_cnt_function {
> > -	STM32_LPTIM_COUNTER_INCREASE,
> > -	STM32_LPTIM_ENCODER_BOTH_EDGE,
> > +	STM32_LPTIM_COUNTER_INCREASE =3D COUNTER_FUNCTION_INCREASE,
> > +	STM32_LPTIM_ENCODER_BOTH_EDGE =3D COUNTER_FUNCTION_QUADRATURE_X4,
>=20
> Hi William,
>=20
> I'm wondering if this enum is still necessary. I noticed the enum is
> removed from the 104-quad-8 driver.

Hi Fabrice,

This enum is no longer necessary. I wanted to leave it up to the
maintainers to decide whether to remove any particular enum (or to do
any other sort of code cleanup), so that is why I didn't remove it here.

> >  };
> > =20
> >  static const enum counter_function stm32_lptim_cnt_functions[] =3D {
> > -	[STM32_LPTIM_COUNTER_INCREASE] =3D COUNTER_FUNCTION_INCREASE,
> > -	[STM32_LPTIM_ENCODER_BOTH_EDGE] =3D COUNTER_FUNCTION_QUADRATURE_X4,
> > +	STM32_LPTIM_COUNTER_INCREASE,
> > +	STM32_LPTIM_ENCODER_BOTH_EDGE,
> >  };
> > =20
> >  enum stm32_lptim_synapse_action {
> > +	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) =
*/
>=20
> Arf... I forgot to update this comment in earlier commit:
> d8ac6b4 counter: stm32-lptimer-cnt: remove iio counter abi
>=20
> "stm32_lptim_cnt_polarity" doesn't exist anymore. So, this comment can
> be updated. This should match the priv->polarity, as it's used to write
> the "CKPOL" bits (e.g. 0x0 for rising, 0x1 falling, 0x2 both).
>=20
> Or do you wish I send a separate patch ?

This is just a simple comment fix so I think it's best to send it as its
own patch to the mailing list.

> >  	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> >  	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> >  	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> >  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
> >  };
> > =20
> > -static const enum counter_synapse_action stm32_lptim_cnt_synapse_actio=
ns[] =3D {
> > -	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) =
*/
> > +static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_m=
ap[] =3D {
> > +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACTION_R=
ISING_EDGE,
> > +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACTION_=
FALLING_EDGE,
> > +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D STM32_LPTIM_SYNAPSE_ACTION_BO=
TH_EDGES,
> > +	[COUNTER_SYNAPSE_ACTION_NONE] =3D STM32_LPTIM_SYNAPSE_ACTION_NONE,
> > +};
> > +
> > +static const enum counter_synapse_action stm32_lptim_l2c_actions_map[]=
 =3D {
> >  	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_R=
ISING_EDGE,
> >  	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_=
FALLING_EDGE,
> >  	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_BO=
TH_EDGES,
> >  	[STM32_LPTIM_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> >  };
> > =20
> > +static const enum counter_synapse_action stm32_lptim_cnt_synapse_actio=
ns[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +};
> > +
>=20
> I'm getting confused with the two table entries, and the two enums that
> are very similar. Could it be simplified ?
>=20
> I'm thinking of something more straight-forward... in fact only one
> array should be enough, to convert from synapse action to CKPOL value
> before it's written to register in stm32_lptim_setup() routine.
> This should be easier now that the iio part has been removed.

Yes, this might just be a hold over from when we had to handle the
legacy IIO Counter code. But now that it is gone, this could probably be
simplified down to a single array then. If you have any idea of how to
achieve that, please do.

> > @@ -333,43 +333,39 @@ static int stm32_lptim_cnt_action_get(struct coun=
ter_device *counter,
> >  	}
> >  }
> > =20
> > -static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> > -				      struct counter_count *count,
> > -				      struct counter_synapse *synapse,
> > -				      size_t action)
> > +static int stm32_lptim_cnt_action_write(struct counter_device *counter,
> > +					struct counter_count *count,
> > +					struct counter_synapse *synapse,
> > +					enum counter_synapse_action action)
> >  {
> >  	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > -	size_t function;
> > +	enum counter_function function;
> >  	int err;
> > =20
> >  	if (stm32_lptim_is_enabled(priv))
> >  		return -EBUSY;
> > =20
> > -	err =3D stm32_lptim_cnt_function_get(counter, count, &function);
> > +	err =3D stm32_lptim_cnt_function_read(counter, count, &function);
> >  	if (err)
> >  		return err;
> > =20
> >  	/* only set polarity when in counter mode (on input 1) */
> > -	if (function =3D=3D STM32_LPTIM_COUNTER_INCREASE
> > -	    && synapse->signal->id =3D=3D count->synapses[0].signal->id) {
> > -		switch (action) {
> > -		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
> > -		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
> > -		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
> > -			priv->polarity =3D action;
> > -			return 0;
> > -		}
> > -	}
> > +	if ((enum stm32_lptim_cnt_function)function !=3D STM32_LPTIM_COUNTER_=
INCREASE
>=20
> Could COUNTER_FUNCTION_INCREASE be used directly here, to avoid casting ?

Sure, you can remove the stm32_lptim_cnt_function enum from this driver
and just use COUNTER_FUNCTION_INCREASE here.

> > +	    || synapse->signal->id !=3D count->synapses[0].signal->id
> > +	    || action =3D=3D COUNTER_SYNAPSE_ACTION_NONE)
> > +		return -EINVAL;
> > =20
> > -	return -EINVAL;
> > +	priv->polarity =3D stm32_lptim_c2l_actions_map[action];
> > +
> > +	return 0;
> >  }
> > =20
> >  static const struct counter_ops stm32_lptim_cnt_ops =3D {
> >  	.count_read =3D stm32_lptim_cnt_read,
> > -	.function_get =3D stm32_lptim_cnt_function_get,
> > -	.function_set =3D stm32_lptim_cnt_function_set,
> > -	.action_get =3D stm32_lptim_cnt_action_get,
> > -	.action_set =3D stm32_lptim_cnt_action_set,
> > +	.function_read =3D stm32_lptim_cnt_function_read,
> > +	.function_write =3D stm32_lptim_cnt_function_write,
> > +	.action_read =3D stm32_lptim_cnt_action_read,
> > +	.action_write =3D stm32_lptim_cnt_action_write,
> >  };
> > =20
> >  static struct counter_signal stm32_lptim_cnt_signals[] =3D {
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-=
timer-cnt.c
> > index 3fb0debd7425..c690b76e5dab 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/types.h>
> > =20
> >  #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
> >  #define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
> > @@ -44,21 +45,21 @@ struct stm32_timer_cnt {
> >   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
> >   */
> >  enum stm32_count_function {
> > +	STM32_COUNT_SLAVE_MODE_DISABLED =3D COUNTER_FUNCTION_INCREASE,
> > +	STM32_COUNT_ENCODER_MODE_1 =3D COUNTER_FUNCTION_QUADRATURE_X2_A,
> > +	STM32_COUNT_ENCODER_MODE_2 =3D COUNTER_FUNCTION_QUADRATURE_X2_B,
> > +	STM32_COUNT_ENCODER_MODE_3 =3D COUNTER_FUNCTION_QUADRATURE_X4,
> > +};
> > +
>=20
> Same as for the LPTIM driver above, I noticed the enum is removed from
> the 104-quad-8 driver.
>=20
> I'm fine both ways... I just feel like this could be more consistent
> later in the function read/write routines to report enum from the
> counter_function definition (e.g. like COUNTER_FUNCTION_QUADRATURE_X4
> instead of STM32_COUNT_ENCODER_MODE_3).
>=20
> Thanks,
> Fabrice

Yes, this enum is just used to alias those constants. If you think the
code will be clearer by using the COUNTER_FUNCTION_* constants directly,
then please do so.

I don't know whether this v10 revision of the patchset will be merged
or if we'll need a v11. So send your updates for stm32-lptimer-cnt.c and
stm32-timer-cnt.c to me directly and I'll squash them with this patch if
we do have a v11; otherwise you can submit them separately to the
mailing list if this v10 is merged afterall.

Thanks,

William Breathitt Gray

--cqRhoqShv7pK17zI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBZsjgACgkQhvpINdm7
VJJZDw/9H+TCABTs1cLpAbmLd2sUEyLjaI19qQOiJ8LJYXNIPuzkmYon1Aro9t6O
CV7Gb1zvpXorE+fCByANz8PXKS/IroXuGA/VVlIJzX3BVEk9rkYO+QPxJR7V7dtq
zQyLdHKpEBpoLhVgteJBXAGjQKiKw5uEP+3KZczRqAE5KFoTsZCAXjHflcb7Awci
yEjlnoIOpEVcFJf00cnjUAYx+bBRFHM3pHINag2p/Tb5rihKOJWtcxoviXM0Y00Q
bedD8D0/DkjLuRRXmrhpExTEKoLiK5FZfN+uveb/wAqrUw7Vslr17MOS396rr7Fb
DybH6m089JALYJdfRBTD3om1SYfNWvvoauC13FnS4+vuFmwGKkH2KX2bscRzRdZI
EGZytTeTN01MkvyFuon/SP2GxqsBrjJ/0s5n1erwQqSssKK15tWVw9/224ImS7b5
lwAICzePbaBKHiZ6FhXvqj7i97Gbb0BCNWlutr/ynHI+Hsf9VTbBmjvs5upUosJV
0V4I3Q7lOgfJZGTODcRjilZOYxEhT7R43dhH78Ou+wbxUwetdiYc1gWwTQvYKEqP
e1PKk8Wsk+qPz6l9cDXeaigO+mvMNRwdtWFVJmKb9erPN+O+vFiSxeX3maZadJYL
GFbSV3VYrt65t0MrPP5rm3iY5RMxrh5k21QuxikruVVFw9LWRcQ=
=axoY
-----END PGP SIGNATURE-----

--cqRhoqShv7pK17zI--

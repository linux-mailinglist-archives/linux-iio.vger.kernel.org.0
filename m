Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD513FC982
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhHaOSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHaOSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 10:18:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3D3C061575;
        Tue, 31 Aug 2021 07:17:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m26so15101583pff.3;
        Tue, 31 Aug 2021 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l3O6m8czYZqp7wpZm8blxZ2yTasaxTjn75d8hF8xhK0=;
        b=qaxDcbMKmTXG4ZunmpUByxJyYhTz3Fezif91dho/r92SmSfisTmn92fV2drZ6Hb7va
         O0rsn5FOoFRYaD/Mc0ONd2dYyXn2pibqDj8/cQK/xKO4zjbYmjsFZPxRCOqONx0RABcs
         NCx/0aWJdacCmu9OsksPBKMcaQ7ZMQc2cW2RGmNyAxpBQFZHzwdB/uWhkvoW73VJJPID
         jxap83Ue0U+P9GlPUPOQVxW7AQljfGBoS8SHBecL1GuxSM3AS1Jal1ldeugV9CZzX+pL
         eeHNf4FYZMBj0RyuhOwDmQxzw65LBfurPEt/wZqnmpdCHavb7/6aVqQ2XQVctl+66jEP
         M7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l3O6m8czYZqp7wpZm8blxZ2yTasaxTjn75d8hF8xhK0=;
        b=PpkoQ7/oaiuKN+yI6i3xEPqsvoxDh/1C1TlTACG2vpFxemTRAj5qxvnTiGwJHaOQu5
         HwBBCR6Z7L9SfrBbyyLZ7yEGtZtoBFnkW5ZSgYCnFeguwHgzu7aE9a3d/N063hw8tQfx
         xLzVyjYvwo8CaUtlHCQt3CHIrfwOhnqy+vOctF/KHEdNUB0/8SC+bEuxzn/uKoJLOCsY
         Jx6oQsXskyiC6AG8Jc5IiV2ReeCYCzskLj8esPUaNUnmI7SpJQc4dINrRtq5KqwFrYy/
         JjpnuxcHsTKwQH3VeeeZBlXE2loZQVQ2pLNpsQ5R75SMf+uOStfJeMeL+1nx+0NwF7uA
         9ZWw==
X-Gm-Message-State: AOAM533w9+br9O1llgRH+dl+G9WUFx5yuwCI+u9XCTDdWh/p2dals4ly
        hP1Yfx280KDbBOlBeYvQbes=
X-Google-Smtp-Source: ABdhPJw+5BdYoUMUvD2w2YXtkrdVMHP1Ga+bq36YeFmmT5QUruKLTcOWXN4BvzJ1mihZEuGRT0Vesg==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr19538878pgm.324.1630419429574;
        Tue, 31 Aug 2021 07:17:09 -0700 (PDT)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id u9sm21011202pgp.83.2021.08.31.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:17:08 -0700 (PDT)
Date:   Tue, 31 Aug 2021 23:16:59 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
Subject: Re: [Linux-stm32] [PATCH v16 03/14] counter: Internalize sysfs
 interface code
Message-ID: <YS452wJ+IHs9R0FC@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <c68b4a1ffb195c1a2f65e8dd5ad7b7c14e79c6ef.1630031207.git.vilhelm.gray@gmail.com>
 <fcff44a7-5ac2-a510-ee9b-85ef7e2e29ef@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lE7kExlEefptBZVZ"
Content-Disposition: inline
In-Reply-To: <fcff44a7-5ac2-a510-ee9b-85ef7e2e29ef@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lE7kExlEefptBZVZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2021 at 03:44:04PM +0200, Fabrice Gasnier wrote:
> On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> > This is a reimplementation of the Generic Counter driver interface.
> > There are no modifications to the Counter subsystem userspace interface,
> > so existing userspace applications should continue to run seamlessly.
> >=20
> > The purpose of this patch is to internalize the sysfs interface code
> > among the various counter drivers into a shared module. Counter drivers
> > pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> > module handles the translation between the sysfs interface and the
> > device drivers. This guarantees a standard userspace interface for all
> > counter drivers, and helps generalize the Generic Counter driver ABI in
> > order to support the Generic Counter chrdev interface (introduced in a
> > subsequent patch) without significant changes to the existing counter
> > drivers.
> >=20
> > Note, Counter device registration is the same as before: drivers
> > populate a struct counter_device with components and callbacks, then
> > pass the structure to the devm_counter_register function. However,
> > what's different now is how the Counter subsystem code handles this
> > registration internally.
> >=20
> > Whereas before callbacks would interact directly with sysfs data, this
> > interaction is now abstracted and instead callbacks interact with native
> > C data types. The counter_comp structure forms the basis for Counter
> > extensions.
> >=20
> > The counter-sysfs.c file contains the code to parse through the
> > counter_device structure and register the requested components and
> > extensions. Attributes are created and populated based on type, with
> > respective translation functions to handle the mapping between sysfs and
> > the counter driver callbacks.
> >=20
> > The translation performed for each attribute is straightforward: the
> > attribute type and data is parsed from the counter_attribute structure,
> > the respective counter driver read/write callback is called, and sysfs
> > I/O is handled before or after the driver read/write function is called.
> >=20
> > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Patrick Havelange <patrick.havelange@essensium.com>
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Reviewed-by: David Lechner <david@lechnology.com>
> > Tested-by: David Lechner <david@lechnology.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  MAINTAINERS                             |    1 -
> >  drivers/counter/104-quad-8.c            |  449 +++----
> >  drivers/counter/Makefile                |    1 +
> >  drivers/counter/counter-core.c          |  142 +++
> >  drivers/counter/counter-sysfs.c         |  849 +++++++++++++
> >  drivers/counter/counter-sysfs.h         |   13 +
> >  drivers/counter/counter.c               | 1496 -----------------------
> >  drivers/counter/ftm-quaddec.c           |   60 +-
> >  drivers/counter/intel-qep.c             |  144 +--
> >  drivers/counter/interrupt-cnt.c         |   62 +-
> >  drivers/counter/microchip-tcb-capture.c |   91 +-
> >  drivers/counter/stm32-lptimer-cnt.c     |  212 ++--
> >  drivers/counter/stm32-timer-cnt.c       |  179 ++-
> >  drivers/counter/ti-eqep.c               |  180 +--
> >  include/linux/counter.h                 |  658 +++++-----
> >  include/linux/counter_enum.h            |   45 -
> >  16 files changed, 1949 insertions(+), 2633 deletions(-)
> >  create mode 100644 drivers/counter/counter-core.c
> >  create mode 100644 drivers/counter/counter-sysfs.c
> >  create mode 100644 drivers/counter/counter-sysfs.h
> >  delete mode 100644 drivers/counter/counter.c
> >  delete mode 100644 include/linux/counter_enum.h
> >=20
>=20
> Hi William,
>=20
> For the STM32 drivers, you can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>=20
> Thanks,
> Fabrice

Hello Fabrice,

I noticed the stm32-lptimer-cnt.c function_write() and action_write()
callbacks do not appear to write the desired function/action
configuration to the device. Would you check whether the device actually
supports this functionality or if these callbacks should be removed from
this driver.

Thanks,

William Breathitt Gray

> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm3=
2-lptimer-cnt.c
> > index 7367f46c6f91..5168833b1fdf 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -170,28 +154,28 @@ static int stm32_lptim_cnt_read(struct counter_de=
vice *counter,
> >  	return 0;
> >  }
> > =20
> > -static int stm32_lptim_cnt_function_get(struct counter_device *counter,
> > -					struct counter_count *count,
> > -					size_t *function)
> > +static int stm32_lptim_cnt_function_read(struct counter_device *counte=
r,
> > +					 struct counter_count *count,
> > +					 enum counter_function *function)
> >  {
> >  	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > =20
> >  	if (!priv->quadrature_mode) {
> > -		*function =3D STM32_LPTIM_COUNTER_INCREASE;
> > +		*function =3D COUNTER_FUNCTION_INCREASE;
> >  		return 0;
> >  	}
> > =20
> > -	if (priv->polarity =3D=3D STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES) {
> > -		*function =3D STM32_LPTIM_ENCODER_BOTH_EDGE;
> > +	if (priv->polarity =3D=3D STM32_LPTIM_CKPOL_BOTH_EDGES) {
> > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> >  		return 0;
> >  	}
> > =20
> >  	return -EINVAL;
> >  }
> > =20
> > -static int stm32_lptim_cnt_function_set(struct counter_device *counter,
> > -					struct counter_count *count,
> > -					size_t function)
> > +static int stm32_lptim_cnt_function_write(struct counter_device *count=
er,
> > +					  struct counter_count *count,
> > +					  enum counter_function function)
> >  {
> >  	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > =20
> > @@ -199,12 +183,12 @@ static int stm32_lptim_cnt_function_set(struct co=
unter_device *counter,
> >  		return -EBUSY;
> > =20
> >  	switch (function) {
> > -	case STM32_LPTIM_COUNTER_INCREASE:
> > +	case COUNTER_FUNCTION_INCREASE:
> >  		priv->quadrature_mode =3D 0;
> >  		return 0;
> > -	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> >  		priv->quadrature_mode =3D 1;
> > -		priv->polarity =3D STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
> > +		priv->polarity =3D STM32_LPTIM_CKPOL_BOTH_EDGES;
> >  		return 0;
> >  	default:
> >  		/* should never reach this path */
> > @@ -333,43 +316,48 @@ static int stm32_lptim_cnt_action_get(struct coun=
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
> > +	if (function !=3D COUNTER_FUNCTION_INCREASE
> > +	    || synapse->signal->id !=3D count->synapses[0].signal->id)
> > +		return -EINVAL;
> > =20
> > -	return -EINVAL;
> > +	switch (action) {
> > +	case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
> > +		priv->polarity =3D STM32_LPTIM_CKPOL_RISING_EDGE;
> > +		return 0;
> > +	case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
> > +		priv->polarity =3D STM32_LPTIM_CKPOL_FALLING_EDGE;
> > +		return 0;
> > +	case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
> > +		priv->polarity =3D STM32_LPTIM_CKPOL_BOTH_EDGES;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> >  }

--lE7kExlEefptBZVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmEuOc8ACgkQhvpINdm7
VJJpXhAAuirktRZCKx+VuHLo49hlyGi/VT9WTPK3Gm+oXxRLE8rurnosrqhk1YMt
xAotuw6iEv9+EX9COWaMK5gmYzXElbSO0CS4uYyvHY5MV0/9LWEgPMwVhMQaSsVA
flbr1R45ASeUXjlgEomZEbLK/cK39QzKr5OI4VvT85t/Lj8h8UuGWyXdaD+Wpm5i
TXRA3+CzuDTwRiSREjFdEa0QF0Nt2RMHWTaEPLTpL+/InYmBVAf0D+BGbBL1hyC5
EE7uK223m1FjwY5KXU6I0bIYlufHebHEDg1saUbeR47fBvSm5hgTtBqKL6fp+J19
xhPkqIlH3Ey22n33c+b5Xplkl1tx0OtP8hSVWaDvqQTxKW2dqo2eAiWexSr5tAux
5qRTDb3DZgxIy8CF7ioLYPZUZRXGeaiWaxFRbuBmLtBhA3+bpDjKdihfZXp9mhBU
Wkd6aAWi4iwDn+avC+CV0FYGDF0VHnOP12mfbrX47O0AyoFVNfZ7CI/IPx7mHn6N
OtoPWJmb8Og5L/AEqljOBBrhmWxwBt34tx/VpdUkzmWSB4TVRmz3XNn05Xnj0ZgP
ZWGK02R5a1kUpx2pr8W3zEGTlnYODSCPvuqgqihF8MgKatKq1V50t6X4u8e2ULMx
KHiLwulh8B62cgNmQSS/R/SLGL/6CdI7W6y7GMKmSfEwcWHjx6M=
=0TI3
-----END PGP SIGNATURE-----

--lE7kExlEefptBZVZ--

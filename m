Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F73199D6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 07:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLGFU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 01:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLGFP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 01:05:15 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536D5C061574;
        Thu, 11 Feb 2021 22:04:35 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r77so7746232qka.12;
        Thu, 11 Feb 2021 22:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LyeffzdGyuXCHrmvrgrwYs9JjpMcvp912aOtxdjcOPY=;
        b=aXb6VTfvj8/zF5HAzZFOF/FVcAohWaf8Ei3t5T0tAaMZDMm0L7UTnm8tmqbYF0iEDm
         DPZ4uXhB55MY5i/eK73K1vnXSPrnU4GQr7p2BXpROcMzSpDwI3sl9JExB8fD4VBr0hiK
         7t6TEKx0EkD0pXZzY7ogQakSDxOSHB33lSvARmLqoZaDPBlJHt//gxQoZmre+hEbMiiu
         H4FzA4Etf0MKTX/ewVDPM5gGEJzwmWYkJ05VNj3yCtk+lhTrbwVQ/L0Tq2CH2HdkcMyN
         5ODd0dA5l/4tw6fRucoV7kAhZMDROToyFYtsBulbV7v09Se11LVPPyvD7SNaTsbOYx5A
         CJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyeffzdGyuXCHrmvrgrwYs9JjpMcvp912aOtxdjcOPY=;
        b=cdCh2cic7cBK+M/7PmZWJ7surMWtOyaT6Lg+6PCX5LqMKPSYo4yXxVJ3ElEL9LrGVO
         /+/nl4SbjjpYc9jH9nUIXEQ3/uzxARt05hLNPIooLjYM3PwN4zg+/sfILDM6z/C5rMgb
         a9ntpX397cRdRMBuwLlF4h/6Z35S9djDUCh/XP+0SlSwigaTt9I2O7xzMa4RlcH5DwpJ
         S7EQpdaUKk/va9FaGTSEZ6fPJ7NionkK5pcS0L/3rbt+hzQe3GGQoXxaK7HjW22XAb+X
         N2e0oLq0k68fiPiDzZtV6qjbaJEHOkeiYje6R99tAuNWw13H4NweVFHSGPJv+8+wmA43
         3LGA==
X-Gm-Message-State: AOAM53374hQhrMOh5GVJo87gLQWGoLffJXl76Rh8QgufVT6YVDhS+XVp
        pzGeH2/sBtnM/VifoDqqQuk=
X-Google-Smtp-Source: ABdhPJz8v61ZXgEMgPnaCoCgTJ5rBYvPLts9XxOaCp7O8jyaCMKvTKh3hXAjhwBkZY4lCK1D9QrrDQ==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr1312086qka.287.1613109874279;
        Thu, 11 Feb 2021 22:04:34 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id i6sm5072113qti.30.2021.02.11.22.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 22:04:33 -0800 (PST)
Date:   Fri, 12 Feb 2021 15:04:25 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Subject: Re: [PATCH v7 5/5] counter: 104-quad-8: Add IRQ support for the
 ACCES 104-QUAD-8
Message-ID: <YCYaaYb1T3lt+zAN@shinobu>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <bb2db54669ef27515da4d5f235c52e0b484b5820.1608935587.git.vilhelm.gray@gmail.com>
 <20201230153115.127067d8@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jiLVWxAToD5Ylc9I"
Content-Disposition: inline
In-Reply-To: <20201230153115.127067d8@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jiLVWxAToD5Ylc9I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 03:31:15PM +0000, Jonathan Cameron wrote:
> On Fri, 25 Dec 2020 19:15:38 -0500
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
> > When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
> > FLG1 is active. Four functions are available for the FLG1 signal: Carry,
> > Compare, Carry-Borrow, and Index.
> >=20
> > 	Carry:
> > 		Interrupt generated on active low Carry signal. Carry
> > 		signal toggles every time the respective channel's
> > 		counter overflows.
> >=20
> > 	Compare:
> > 		Interrupt generated on active low Compare signal.
> > 		Compare signal toggles every time respective channel's
> > 		preset register is equal to the respective channel's
> > 		counter.
> >=20
> > 	Carry-Borrow:
> > 		Interrupt generated on active low Carry signal and
> > 		active low Borrow signal. Carry signal toggles every
> > 		time the respective channel's counter overflows. Borrow
> > 		signal toggles every time the respective channel's
> > 		counter underflows.
> >=20
> > 	Index:
> > 		Interrupt generated on active high Index signal.
> >=20
> > The irq_trigger Count extension is introduced to allow the selection of
> > the desired IRQ trigger function per channel. Interrupts push Counter
> > events to event channel X, where 'X' is the respective channel whose
> > FLG1 activated.
> >=20
> > This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
> > numbers for the devices may be configured via the irq array module
> > parameter.
> >=20
> > Reviewed-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Immediate thought on this is that you should pull the lock type change
> out as a precursor patch that simply says we need it to be a spin_lock
> for the following patch.  That should be an obvious change to review
> and then leave a much shorter patch to focus on here.
>=20
> Jonathan

Ack.

> > ---
> >  .../ABI/testing/sysfs-bus-counter-104-quad-8  |  25 ++
> >  drivers/counter/104-quad-8.c                  | 318 ++++++++++++++----
> >  drivers/counter/Kconfig                       |   6 +-
> >  3 files changed, 276 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/D=
ocumentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > index eac32180c40d..0ecba24d43aa 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> > @@ -1,3 +1,28 @@
> > +What:		/sys/bus/counter/devices/counterX/countY/irq_trigger
>=20
> A warning on this.   The ABI docs are now built into the main kernel
> html docs build.  The snag is that it doesn't cope will with specialising
> or different devices having the same named file with different allowed va=
lues.
> You have to unify them all into one place.   It may be worth just doing t=
hat
> from the start.

Ack.

> > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > index f4fb36b751c4..7537575568d0 100644
> > --- a/drivers/counter/104-quad-8.c
> > +++ b/drivers/counter/104-quad-8.c
> > @@ -13,23 +13,30 @@
> >  #include <linux/iio/types.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/isa.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/types.h>
> > +#include <linux/spinlock.h>
> > =20
> >  #define QUAD8_EXTENT 32
> > =20
> >  static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
> >  static unsigned int num_quad8;
> > -module_param_array(base, uint, &num_quad8, 0);
> > +module_param_hw_array(base, uint, ioport, &num_quad8, 0);
>=20
> Why this change?  Perhaps a note in the patch description on why
> this is needed?

This change is unrelated to this patch so I'll move it to a precursor
patch with an explanation of the reason for the change.

> >  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
> > =20
> > +static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
> > +module_param_hw_array(irq, uint, irq, NULL, 0);
> > +MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
> > +
> >  #define QUAD8_NUM_COUNTERS 8
> > =20
> >  /**
> >   * struct quad8_iio - IIO device private data structure
> > + * @lock:		synchronization lock to prevent I/O race conditions
>=20
> Probably want to be more specific. RMW, indexed writes or what sort of ra=
ce?

Ack.

> >   * @counter:		instance of the counter_device
> >   * @fck_prescaler:	array of filter clock prescaler configurations
> >   * @preset:		array of preset values
> > @@ -38,13 +45,14 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addre=
sses");
> >   * @quadrature_scale:	array of quadrature mode scale configurations
> >   * @ab_enable:		array of A and B inputs enable configurations
> >   * @preset_enable:	array of set_to_preset_on_index attribute configura=
tions
> > + * @irq_trigger:	array of interrupt trigger function configurations
> >   * @synchronous_mode:	array of index function synchronous mode configu=
rations
> >   * @index_polarity:	array of index function polarity configurations
> >   * @cable_fault_enable:	differential encoder cable status enable confi=
gurations
> >   * @base:		base port address of the IIO device
> >   */
> >  struct quad8_iio {
> > -	struct mutex lock;
> > +	raw_spinlock_t lock;
>=20
> So it was here before but not documented.  You should fix that with a pre=
cusor patch.
> Why raw_spinlock_t rather than spinlock_t?

Ack.

> > +static int quad8_watch_validate(struct counter_device *counter,
> > +				const struct counter_watch *watch)
> > +{
> > +	struct quad8_iio *const priv =3D counter->priv;
> > +
> > +	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
> > +		return -EINVAL;
> > +
> > +	switch (watch->event) {
> > +	case COUNTER_EVENT_OVERFLOW:
> > +		if (priv->irq_trigger[watch->channel] !=3D 0)
> > +			return -EINVAL;
> > +		break;
> > +	case COUNTER_EVENT_THRESHOLD:
> > +		if (priv->irq_trigger[watch->channel] !=3D 1)
> > +			return -EINVAL;
> > +		break;
> > +	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
> > +		if (priv->irq_trigger[watch->channel] !=3D 2)
> > +			return -EINVAL;
> > +		break;
> > +	case COUNTER_EVENT_INDEX:
> > +		if (priv->irq_trigger[watch->channel] !=3D 3)
> > +			return -EINVAL;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
>=20
> I'm a great fan of early returns if nothing to be done at
> the end of a switch.  Much cleaner than having to follow the
> breaks and see where they end up (nothing in this case!)

Ack.

> > +static irqreturn_t quad8_irq_handler(int irq, void *quad8iio)
> > +{
> > +	struct quad8_iio *const priv =3D quad8iio;
> > +	const unsigned long base =3D priv->base;
> > +	unsigned long irq_status;
> > +	unsigned long channel;
> > +	u8 event;
> > +
>=20
> Take the spin lock?=20

A lock isn't necessary for this particular function. This is the only place
where the device's pending interrupt state is read and reset, so there is no
risk of stale data nor of clobbering the device state because interrupts are
currently disabled.

> > +	irq_status =3D inb(base + QUAD8_REG_INTERRUPT_STATUS);
> > +	if (!irq_status)
> > +		return IRQ_NONE;
> > +
> > +	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
> > +		switch (priv->irq_trigger[channel]) {
> > +		case 0:
> > +			event =3D COUNTER_EVENT_OVERFLOW;
> > +				break;
> > +		case 1:
> > +			event =3D COUNTER_EVENT_THRESHOLD;
> > +				break;
> > +		case 2:
> > +			event =3D COUNTER_EVENT_OVERFLOW_UNDERFLOW;
> > +				break;
> > +		case 3:
> > +			event =3D COUNTER_EVENT_INDEX;
> > +				break;
> > +		default:
> > +			/* should never reach this path */
> > +			WARN_ONCE(true, "invalid interrupt trigger function %u configured f=
or channel %lu\n",
> > +				  priv->irq_trigger[channel], channel);
> > +			continue;
> > +		}
> > +
> > +		counter_push_event(&priv->counter, event, channel);
> > +	}
> > +
> > +	/* Clear pending interrupts on device */
> > +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base + QUAD8_REG_CHAN_OP);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int quad8_probe(struct device *dev, unsigned int id)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -1510,9 +1682,10 @@ static int quad8_probe(struct device *dev, unsig=
ned int id)
> >  	quad8iio->counter.priv =3D quad8iio;
> >  	quad8iio->base =3D base[id];
> > =20
> > -	/* Initialize mutex */
> > -	mutex_init(&quad8iio->lock);
> > +	raw_spin_lock_init(&quad8iio->lock);
> > =20
> > +	/* Reset Index/Interrupt Register */
> > +	outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
> >  	/* Reset all counters and disable interrupt function */
> >  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> >  	/* Set initial configuration for all counters */
> > @@ -1542,8 +1715,8 @@ static int quad8_probe(struct device *dev, unsign=
ed int id)
> >  	}
> >  	/* Disable Differential Encoder Cable Status for all channels */
> >  	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> > -	/* Enable all counters */
> > -	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> > +	/* Enable all counters and enable interrupt function */
> > +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_O=
P);
> > =20
> >  	/* Register IIO device */
> >  	err =3D devm_iio_device_register(dev, indio_dev);
> > @@ -1551,7 +1724,12 @@ static int quad8_probe(struct device *dev, unsig=
ned int id)
> >  		return err;
> > =20
> >  	/* Register Counter device */
> > -	return devm_counter_register(dev, &quad8iio->counter);
> > +	err =3D devm_counter_register(dev, &quad8iio->counter);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> > +				quad8iio->counter.name, quad8iio);
> You probably want to do that before the counter_register above
> as I assume that's where the userspace interface gets exposed.
> Otherwise there is probably a theoretical race.
> If not then I'd expect a comment here to explain why it needs to be
> in this unexpected order.

Ack.

William Breathitt Gray

--jiLVWxAToD5Ylc9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAmGmkACgkQhvpINdm7
VJKdMQ//Xn4H9Mxgdg2uGmOnX6cSUh8ZONYdnvy9HBH226l/vpaNJRVLNwIL8B9r
bGyfmvnIH43hsn4kv7s48cJuGyOSPO8HdCepwfkeJChqp7/qwznHk3gqeq7BzJRM
gaMqWkVoi3GOtDVKWvMQ2iSEt2GE94kSFgalRk/Q/1Xfr59xDMbHIzr4MC8F5eNi
vMvw8g3KGnTqR1nMUMqw0T1zJstnF1AxmOWKIJ/9TI/R5raOFYLeIo8gWQOTuwzh
CTA2XX3Vmq2uva4FK6I4T5vsIRUFTzNOsVTWtJfZPT0JAA3ODfziDbhfkm/7eytf
Za4JiU9YN11C20fQvzu2LtsP5R24oBgoUyMcMTuAVjq7TVFr1Qgj9IDAvH9JznyB
ktrktKfstu0xtU3IWgYe27/CfBXUZrWwu4AlViHyZnCzTeWirFTxS7OUn8BFMk20
Yct1DkEoYp287zP8VNm+XsBBsE+KyaCpYSeZFDJjjN9hI/bF7p75zHER6moIsCYi
pl0nHew1F53+EdzC7hBWPvKNHhAZ3R8o1TYpmajg6ZCGpkCasms9l8i/nm0VQu4B
/tTRUhVkdBxTasKJoQxQxN4EOdy/MynTElJrL3sdWQ8L4knC2i9y0X3FKPmU4+Gb
gPJZIspry/UDWZTlo3QW61cABaqkn8h++bGQW6CsWtmeAqEYUC0=
=eAg/
-----END PGP SIGNATURE-----

--jiLVWxAToD5Ylc9I--

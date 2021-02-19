Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4085831F67A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBSJWl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 04:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBSJWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 04:22:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98884C061574;
        Fri, 19 Feb 2021 01:21:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl8so3364375pjb.0;
        Fri, 19 Feb 2021 01:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Nndt6phxjMpdHqGRbtAnjiR4ZY0bH6GBZOMbPlPKRw=;
        b=oXClbpwHrviKaqzsaF1PVu3cX39PDXSo0s0xxgCWF0x11W0CjF45/w/HHP55rEpYgF
         stLAUbXKQXCWsX0ZkVYsnc9o+L0tI5L8gwsK1C7E2klk9n8ehmfZj+Yp1lEvytBKYL3X
         uRb3eftEpUGYVJAihZpS9IUNlPADVfUjky5vBz+g/7CtUJLvX6tWs9BFoiXu9NJ7Hjns
         oHIk5aNjrHtsAF736TBq0QWag0oK4xEchTWFGXkF5Sm5O2lFuzWoFprO/klDVC3lWRQV
         9t7dX0grQahYSvF8Kw6Jj/OURmUiRYix3S5Mion8PqPPZGoZGc4Ddp5FFgYXcNkRHIyj
         iPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Nndt6phxjMpdHqGRbtAnjiR4ZY0bH6GBZOMbPlPKRw=;
        b=oQeRc69jCqXsOp4QeINlLJYpBQptZZX0pcmSn72U9C8Qb1ZNyZq8aZCqRTs9gZyElt
         47+5YvOk3azVABVnkzkc83lDdTsEts2SAxZiJBhUS4J6C02aKuUJBluedC0/xn/goVWU
         Y+aVu1Sbpx5azZsqK5gf7iawLGln140X7bXt3cTl/w1AoRvypIxw2esuCr636d4fD9Zz
         jTEJ0Zqm/Ne6bi82VODt9eEEtEd8B2VYZ/Ae3Ww4fGim9kORX8shZjSiMMiqfs7s//Qo
         Fl9BzXGLiZyhGabBIsHgINKxxMMrNN0287VNkOYMqW2uGsl+Hvp+7g3EMlHXJsmDVCnL
         npcQ==
X-Gm-Message-State: AOAM531hDibC7vuBhvjKXyk0yfnclBOST4OzQPtZc5/gckdNC/XTbxBM
        a1GRGgeiNkJ9YxRKH0whrU8=
X-Google-Smtp-Source: ABdhPJwlyGeoScjkX477Us83uDJivwce/hhn0lpepuKFijJmA6swfCuF1RlEw0LRwcQVt3e3ZubcCw==
X-Received: by 2002:a17:902:e312:b029:e2:9e5f:3ea9 with SMTP id q18-20020a170902e312b02900e29e5f3ea9mr8536035plc.3.1613726517048;
        Fri, 19 Feb 2021 01:21:57 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id e24sm7774569pjr.13.2021.02.19.01.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:21:55 -0800 (PST)
Date:   Fri, 19 Feb 2021 18:21:47 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 22/22] counter: 104-quad-8: Add IRQ support for the
 ACCES 104-QUAD-8
Message-ID: <YC+DK7nLMA1Sq/QE@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <5f86041727b47573940eb5a27c0eaf27cafff55a.1613131238.git.vilhelm.gray@gmail.com>
 <20210214182459.3177a277@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JhPrUCoJALjryNry"
Content-Disposition: inline
In-Reply-To: <20210214182459.3177a277@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--JhPrUCoJALjryNry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 06:24:59PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:46 +0900
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
> > These four functions correspond respectivefly to the following four
> > Counter event types: COUNTER_EVENT_OVERFLOW, COUNTER_EVENT_THRESHOLD,
> > COUNTER_EVENT_OVERFLOW_UNDERFLOW, and COUNTER_EVENT_INDEX. Interrupts
> > push Counter events to event channel X, where 'X' is the respective
> > channel whose FLG1 activated.
> >=20
> > This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
> > numbers for the devices may be configured via the irq array module
> > parameter.
> >=20
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> A few minor bits inline.
>=20
> Jonathan
>=20
> > ---
> >  drivers/counter/104-quad-8.c | 170 +++++++++++++++++++++++++++++++++--
> >  drivers/counter/Kconfig      |   6 +-
> >  2 files changed, 165 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > index 2b47f9991acc..45090cd9f813 100644
> > --- a/drivers/counter/104-quad-8.c
> > +++ b/drivers/counter/104-quad-8.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/isa.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -25,11 +26,15 @@ static unsigned int num_quad8;
> >  module_param_hw_array(base, uint, ioport, &num_quad8, 0);
> >  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
> > =20
> > +static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
> > +module_param_hw_array(irq, uint, irq, NULL, 0);
> > +MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
> > +
> >  #define QUAD8_NUM_COUNTERS 8
> > =20
> >  /**
> >   * struct quad8 - device private data structure
> > - * @lock:		synchronization lock to prevent I/O race conditions
> > + * @lock:		lock to prevent clobbering device states during R/W ops
> >   * @counter:		instance of the counter_device
> >   * @fck_prescaler:	array of filter clock prescaler configurations
> >   * @preset:		array of preset values
> > @@ -38,6 +43,8 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base address=
es");
> >   * @quadrature_scale:	array of quadrature mode scale configurations
> >   * @ab_enable:		array of A and B inputs enable configurations
> >   * @preset_enable:	array of set_to_preset_on_index attribute configura=
tions
> > + * @irq_trigger:	array of current IRQ trigger function configurations
> > + * @next_irq_trigger:	array of next IRQ trigger function configurations
> >   * @synchronous_mode:	array of index function synchronous mode configu=
rations
> >   * @index_polarity:	array of index function polarity configurations
> >   * @cable_fault_enable:	differential encoder cable status enable confi=
gurations
> > @@ -53,13 +60,17 @@ struct quad8 {
> >  	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
> >  	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
> >  	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
> > +	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
> > +	unsigned int next_irq_trigger[QUAD8_NUM_COUNTERS];
> >  	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
> >  	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
> >  	unsigned int cable_fault_enable;
> >  	unsigned int base;
> >  };
> > =20
> > +#define QUAD8_REG_INTERRUPT_STATUS 0x10
> >  #define QUAD8_REG_CHAN_OP 0x11
> > +#define QUAD8_REG_INDEX_INTERRUPT 0x12
> >  #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
> >  #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
> >  /* Borrow Toggle flip-flop */
> > @@ -92,8 +103,8 @@ struct quad8 {
> >  #define QUAD8_RLD_CNTR_OUT 0x10
> >  /* Transfer Preset Register LSB to FCK Prescaler */
> >  #define QUAD8_RLD_PRESET_PSC 0x18
> > -#define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
>=20
> This seems like an unrelated change...

This register has a bit to enable the interrupt functions in addition to
the counters. When I first introduced these macro defines, I ignored
mentioning the interrupt functionality because we weren't supporting IRQ
at the time. The change in this patch here is actually a rename of this
register configuration with the new respective bit now properly enabled:
QUAD8_CHAN_OP_ENABLE_COUNTERS -> QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC.

> >  #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
> > +#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
> >  #define QUAD8_CMR_QUADRATURE_X1 0x08
> >  #define QUAD8_CMR_QUADRATURE_X2 0x10
> >  #define QUAD8_CMR_QUADRATURE_X4 0x18
> > @@ -380,13 +391,103 @@ static int quad8_action_read(struct counter_devi=
ce *counter,
> >  	return 0;
> >  }
>=20
> ...
>=20
> >  static int quad8_probe(struct device *dev, unsigned int id)
> >  {
> >  	struct quad8 *priv;
> >  	int i, j;
> >  	unsigned int base_offset;
> > +	int err;
> > =20
> >  	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev)))=
 {
> >  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> > @@ -1011,6 +1157,8 @@ static int quad8_probe(struct device *dev, unsign=
ed int id)
> > =20
> >  	raw_spin_lock_init(&priv->lock);
> > =20
> > +	/* Reset Index/Interrupt Register */
> > +	outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
> >  	/* Reset all counters and disable interrupt function */
> >  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> >  	/* Set initial configuration for all counters */
> > @@ -1037,13 +1185,19 @@ static int quad8_probe(struct device *dev, unsi=
gned int id)
> >  		outb(QUAD8_CTR_IOR, base_offset + 1);
> >  		/* Disable index function; negative index polarity */
> >  		outb(QUAD8_CTR_IDR, base_offset + 1);
> > +		/* Initialize next IRQ trigger function configuration */
> > +		priv->next_irq_trigger[i] =3D QUAD8_EVENT_NONE;
> >  	}
> >  	/* Disable Differential Encoder Cable Status for all channels */
> >  	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> > -	/* Enable all counters */
> > -	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> > +	/* Enable all counters and enable interrupt function */
> > +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_O=
P);
> > +
> > +	err =3D devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> > +			       priv->counter.name, priv);
> > +	if (err)
> > +		return err;
> > =20
> > -	/* Register Counter device */
>=20
> Whilst I would agree with removing this comment as being pointless
> as it's obvious, it doesn't really belong in this patch.

I'll move this to its own patch.

William Breathitt Gray

> >  	return devm_counter_register(dev, &priv->counter);
> >  }
> > =20
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 1391e8ea64fe..b0f8fef18b51 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -23,11 +23,11 @@ config 104_QUAD_8
> >  	  A counter's respective error flag may be cleared by performing a wr=
ite
> >  	  operation on the respective count value attribute. Although the
> >  	  104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may=
 be
> > -	  set, either directly or via the counter's preset attribute. Interru=
pts
> > -	  are not supported by this driver.
> > +	  set, either directly or via the counter's preset attribute.
> > =20
> >  	  The base port addresses for the devices may be configured via the b=
ase
> > -	  array module parameter.
> > +	  array module parameter. The interrupt line numbers for the devices =
may
> > +	  be configured via the irq array module parameter.
> > =20
> >  config STM32_TIMER_CNT
> >  	tristate "STM32 Timer encoder counter driver"
>=20

--JhPrUCoJALjryNry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAvgysACgkQhvpINdm7
VJJ+iRAA2cEhkCP13heqWIP1VeT1IL15xQ6O7x7N+nAyCotlV7QGGmt/Kzq/6+bv
UcgUSeWfz3ZeKJQfZm0kxFUcwsMSDdvffLQjQUy03hrxVhSohvhEXd8PSPtGI9Bw
Ist34QTaqVQwje9KArcIZ44vFiKDsxb4HehZ0a3ZXNCPfnxmepXrzu1AtE98ZbLa
MkITmq9Xog+bbS9N5vGNOWXMLXiMyp5grzSergQkWIR6GToMVOOKHLarAcrd9Q1F
XL6dHZjjs209/FMw/zY0/xlQh3n/QEGRx2oFdzxwMHV72+T5pMmRr1zYNBfUmDa+
8hRFkUh0K0xBboIb7OKLR5LIh/8EmGCP2pUKAPY/wsLvGIoEw0Lu4b533kvneNvy
P1fMHH5VmVdWoy/GGyUBRVUps9bPpbEmc3p7PJ5Npnh8STk6ejHQdQ9YzhrM+4+D
5iCZlEOmajnjA/c5Mp7EUEKjQm4S3Xez/Y8g4reitXCEhlI1gNUvIQDIzrm/fwzK
8UU+/6QCw0lQ2MohyRervfI0uNh0a2Hip4kYcDJBp6q8i8O858K6KC7/qtz0zZMH
XZTX08cjBZk+ckR/NKLDchUVz2toctQDfayVyRCLuzAukddkukGGQZU/0pNDKhft
SZVkW++Sicy3R7hDvppWJmId1iMwY5mFcVeLG357oGQVgZ4NiLE=
=40ti
-----END PGP SIGNATURE-----

--JhPrUCoJALjryNry--

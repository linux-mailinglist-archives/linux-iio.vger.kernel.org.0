Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0673235C7
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 03:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBXCez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 21:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhBXCey (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 21:34:54 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BECC061574;
        Tue, 23 Feb 2021 18:34:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id j24so339703pfi.2;
        Tue, 23 Feb 2021 18:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OrsbIjlAeW34o/rlLGDTPIp7SUgU63NXF2+m5n1jw40=;
        b=dDXGO/bmqQ1gvvdkZzfAxHnfOY6qOOVXSkHFAJoPqM4PLDql/pflkq4ufqQ/siGVnh
         v50twmdw39Xf/I2moCMN//3LhNMWYXiV0z+rGigTW7NtyoDlrbAOFencurn9J9VdaUQ3
         nLdgNZkoljTlzYpDcNvgCxdTzlgQcLAKy+xd/tYFC2Gz0TuW/VQlVDtWedw6hGI/KyWo
         xGfj9CMuN7F43gu8C5i3enKIAhj7SzviNvZUuvmOAnHvaOS1WftP4m3zIfiBEAOWT69W
         Jn/55ek3TKtgpwSbZy8goot4WrYBDxNtoaWuN0o67BPjmA3jmG3iIIiwZQWKpYgtjeWm
         AnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OrsbIjlAeW34o/rlLGDTPIp7SUgU63NXF2+m5n1jw40=;
        b=eaM+fN0WdN4q/kOKUZIePMyDLvcc/lIono1Xe6JxyjN5TqB2DwhJv1RGjGalNhdPgv
         kdzcmkhUVcAGjwH/VCLwYft517sqP4VPJqtDj66nGSWmPhZaaEDhOvij1aYyK3+f2Zwz
         L+7rlWuXmlF8copvBzOcRNyuKe+Ac6Wvj2vPUylpQT8hbviQP2GAn7t5QUS/zlA9TKdK
         j2mHN9OH6FgWW6bcHd7ADgPosJnL9Kz3ZbKrmTpYSRb3freDxoMZOg/VE7OTJ44JQmC3
         8fps5fO+9Eek40EgEl9CCd0aRjhfbVpTBGrZ7pyzsz2g28MDBd+KP7Hz46HAnFlNSMOY
         rMKw==
X-Gm-Message-State: AOAM532OyeOWnLrlNc0ibtB7PMW1A+/c6M2sbhwEdsrfacGVfGevPwKp
        LGZzSL6MWvJlUDaCiAm+l7s=
X-Google-Smtp-Source: ABdhPJwj5ZNV1qNeGIY8GWAY5NoxW+MIIoJDEkAWjzNkUIObqaTvY1bjKonRWyrR4bR+Av/oxlXKGQ==
X-Received: by 2002:a05:6a00:15cc:b029:1ba:5282:3ab8 with SMTP id o12-20020a056a0015ccb02901ba52823ab8mr29230142pfu.77.1614134053378;
        Tue, 23 Feb 2021 18:34:13 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y12sm410616pjc.56.2021.02.23.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 18:34:12 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:34:06 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <YDW7Hihg0gGQh8UR@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gVaQzNXj3LJq+Vai"
Content-Disposition: inline
In-Reply-To: <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gVaQzNXj3LJq+Vai
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 06:45:16PM +0100, Oleksij Rempel wrote:
> Hello William,
>=20
> Here is cooled down technical answer. Excuse me for over reacting.

Hello Oleksij,

Let me apologize too if I offended you in some way in with previous
response, I assure you that was not my intention. I truly do believe
this is a useful driver to have in the kernel and I want to make that
happen; my concerns with your patch are purely technical in nature and=20
I'm certain we can find a solution working together.

> On Tue, Feb 23, 2021 at 11:06:56AM +0100, Oleksij Rempel wrote:
> > On Mon, Feb 22, 2021 at 10:43:00AM +0900, William Breathitt Gray wrote:
> > > On Mon, Feb 15, 2021 at 10:17:37AM +0100, Oleksij Rempel wrote:
> > > > > > +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> > > > > > +{
> > > > > > +	struct event_cnt_priv *priv =3D dev_id;
> > > > > > +
> > > > > > +	atomic_inc(&priv->count);
> > > > >=20
> > > > > This is just used to count the number of interrupts right? I wond=
er if
> > > > > we can do this smarter. For example, the kernel already keeps tra=
ck of
> > > > > number of interrupts that has occurred for any particular IRQ lin=
e on a
> > > > > CPU (see the 'kstat_irqs' member of struct irq_desc, and the
> > > > > show_interrupts() function in kernel/irq/proc.c). Would it make s=
ense to
> > > > > simply store the initial interrupt count on driver load or enable=
ment,
> > > > > and then return the difference during a count_read() callback?
> > > >=20
> > > > This driver do not makes a lot of sense without your chardev patche=
s. As
> > > > soon as this patches go mainline, this driver will be able to send
> > > > event with a timestamp and counter state to the user space.
> > > >=20
> > > > With other words, we will need an irq handler anyway. In this case =
we
> > > > can't save more RAM or CPU cycles by using system irq counters.
> > >=20
> > > It's true that this driver will need an IRQ handler when the timestamp
> > > functionality is added, but deriving the count value is different mat=
ter
> > > regardless. There's already code in the kernel to retrieve the number=
 of
> > > interrupts, so it makes sense that we use that rather than rolling our
> > > own -- at the very least to ensure the value we provide to users is
> > > consistent with the ones already provided by other areas of the kerne=
l.
>=20
> The value provided by the driver is consistent only if it is not
> overwritten by user. The driver provides an interface to reset/overwrite =
it.
> At least after this step the value is not consistent.

I wasn't clear here so I apologize. What I would like is for this driver
to maintain its own local count value derived from kstat_irqs_usr(). So
for example, you can use the "count" member of your struct
interrupt_cnt_priv to maintain this value (it can be unsigned int
instead of atomic_t):

static int interrupt_cnt_read(struct counter_device *counter,
			      struct counter_count *count, unsigned long *val)
{
	struct interrupt_cnt_priv *priv =3D counter->priv;

	*val =3D kstat_irqs_usr(priv->irq) - priv->count;

	return 0;
}

static int interrupt_cnt_write(struct counter_device *counter,
			       struct counter_count *count,
			       const unsigned long val)
{
	struct interrupt_cnt_priv *priv =3D counter->priv;

	/* kstat_irqs_usr() returns unsigned int */
	if (val !=3D (unsigned int)val)
		return -ERANGE;

	priv->count =3D val;

	return 0;
}

> > We are talking about one or two code lines. If we will take some
> > duplication search engine, it will find that major part of the kernel
> > is matching against it.
> >=20
> > Newer the less, this driver provides a way to reset the counter. Why
> > should we drop this functionality no advantage?
> >=20
> > > To that end, I'd like to see your cnt_isr() function removed for this
> > > patchset (you can bring it back once timestamp support is added).
>=20
> It make no sense to request an interrupt without interrupt service
> routine.
>=20
> https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L2072if
> 	if (!handler) {
> 		if (!thread_fn)
> 			return -EINVAL;
>=20
> As you can see, requesting an irq need at least handler or thread_fn.
>=20
> enable_irq: this will explode at least here:
> https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L778
>=20
> If he have no IRQ handler and some how was able to enable it, at
> some point this IRQ will be disabled by this code:
> https://elixir.bootlin.com/linux/latest/source/kernel/irq/spurious.c#L410
> 	if (unlikely(desc->irqs_unhandled > 99900)) {
> 		/*
> 		 * The interrupt is stuck
> 		 */
> 		__report_bad_irq(desc, action_ret);
> 		/*
> 		 * Now kill the IRQ
> 		 */
> 		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
> 		desc->istate |=3D IRQS_SPURIOUS_DISABLED;
> 		desc->depth++;
> 		irq_disable(desc);
>=20
> With current code, we can't request or enable IRQ without cnt_isr(). Not
> that it is not possible, but it make no sense to me.

What I'm requesting is to remove the interrupt code from this driver for
now including the cnt_enable_write() callback. Yes, we will need it when
timestamp functionality is added, but currently the Counter subsystem
does not have that functionality yet. Once the Counter character device
interface is merged, then it makes sense to add the interrupt service
routine to push timestamps to the user.

It is still useful to have this driver mainlined even without the
interrupt code: getting the body of this driver merged means a much
easier review of the timestamp code in the future, and users can start
using current Counter sysfs interface to track their GPIO interrupts.

> > Are you suggesting to enable IRQ without interrupt handler? May be i'm
> > missing some thing.. I do not understand it.
> >=20
> > > Reimplement your cnt_read/cnt_write() functions to instead use
> > > kstat_irqs_usr() from <linux/kernel_stat.h> to get the current number=
 of
> > > interrupts the IRQ line and use it to derive your count value for this
> > > driver.
>=20
> irq descriptor has 3 counters:
> - irq_count: this value can be reset any time by the kernel at least by
>   the note_interrupt()
> - irqs_unhandled: this value is increased in case of missing irq
>   handler. Or if handler has returns IRQ_NONE.
> - tot_count: this value should not be reset.
>=20
> Non of this values is suitable for cnt_read() and cnt_write(). Only
> tot_count would be suitable if cnt_write() is removed. I do not see it
> as acceptable option.
>=20
> For this driver, we still need extra counter, where only this driver is
> responsible for writing to it.

Yes, I'm sorry for not being clear before. Please use priv->count for
this; there's no need to adjust directly the system irq count.

> > I can follow the counter read way, but overwriting system wide counter
> > for local use is bad idea.
> >=20
> > > > > > +static struct counter_signal event_cnt_signals[] =3D {
> > > > > > +	{
> > > > > > +		.id =3D 0,
> > > > > > +		.name =3D "Channel 0 signal",
> > > > >=20
> > > > > You should choose a more description name for this Signal;
> > > > > "Channel 0 signal" isn't very useful information for the user. Is=
 this
> > > > > signal the respective GPIO line state?
> > > >=20
> > > > Sounds plausible. How about "Channel 0, GPIO line state"?
> > >=20
> > > Ideally, this would match the GPIO name (or I suppose the IRQ number =
if
> > > not a GPIO line). So in your probe() function you can do something li=
ke
> > > this I believe:
> > >=20
> > > 	cnt_signals[0].name =3D priv->gpio->name;
> >=20
>=20
> > to make this possible, i would need hack gpiolib framework and add
> > name/label exporter. But after endless rounds of pingponging me for
> > renaming the driver and removing interrupt handler, i feel like we are
> > not having serious discussion for mainlining this driver.
>=20
> Probably for good reason, struct gpio_desc was made local and is located
> in the drivers/gpio/gpiolib.h. It feels like additional hack to include
> it. I assume, it should be done properly so there is a function to
> provide gpio name or label.
>=20
> @Linus Walleij are there any good way to get the GPIO name? And which
> name will be actually used? A label provided over devicetree?

Perhaps one of the GPIO subsystem maintainers can provide more guidance
here, but I was under the impression that this name was provided
statically by the respective GPIO driver via their struct gpio_chip. I
think you can see the array of names via priv->gpio->gdev->chip->names.

Alternatively, we can take a more generic approach: ignore the GPIO
names and focus solely on the IRQ lines; because the GPIO lines will
always be tied to respective IRQ lines here, using the IRQ as the basis
of the name should always be valid. The "name" member of the struct
irq_chip can work for this. I haven't tested this, but I think something
like this would work:

	cnt_signals[0].name =3D irq_get_chip(priv->irq)->name;

> If I see it correctly, it would need more work to make the kernel infrast=
ructure
> suitable for this suggestions. Some of them are only needed before
> chardev support will go mainline and , in long term, not worth to
> spend time on it.

I disagree, I think there is benefit in getting this driver merged
even if we don't have the interrupt service routine. Although I
recommend we keep this initial patch simple to introduce the driver,
later on you can for example add support for other Counter sysfs
attributes such as "ceiling" and "floor" if users want to specify count
limits, or perhaps alternative count functions (maybe a user wants to
the count to decrease instead of increase with every interrupt).

These other functionalities are tangental to the your timestamp interest
for this driver, but I believe they will be useful to users at large as
a convenient way to evaluate, track, and express the interrupt counts on
their system.

William Breathitt Gray

> Probably I do not understand you and i missing some thing?
>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--gVaQzNXj3LJq+Vai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA1uxQACgkQhvpINdm7
VJI2mw//XtOjv5wcKRiuDVh3AFm/iZ8y4WOVSsLNtJYFxhLPFIhxPcKbjb4yd0gr
y3Iti9BWlG7XNUy7o+A1xyGx71SlFfyEKFx9QiB9WAuUG/MKl2kqr78diHWrMKe3
hFlIUuqCNAMcHihsym1xqt46anFOHN7sWX2AQ5Qc4g0CCNQAU3h1ZgHGCPzrnSjn
03y7Sf7lwvHx2V8/m4RVf5A8hSrZ4ycUUwxL2URZItj+P7jcILmkc7+JyiLZaj+T
xSl8woCeGHVyd3AMkwfooBFDYnnqAxVBXSPs25eDtugcGJG256WVG6kjF5xTYJGz
KdgQrqxhSgVeVHyRiiEbpEB3JSL32TTeoXXTJi0ZJ33m5v55mrYKqC6u1GvuZOQ3
YA8AG8h5GsjbqJdY8HhqKmz9GBUBFqOTNSobmMub+3tqudMRDUnSAFRUKiKSGHQu
+t91kstAwgd+Ml6MWjKT8afAGJVYGxrrj3cc9RrTDarGzToT8NeM2nCjcYO7tVf1
Kd1NEdR9ey8IiePbI5PlKyIQqekqwykln9vnbG5OesoAF3K9m+nRR0A9S+YVg+rW
Q0WUKDWmVHH9hw4hqZto6EaI4kfZNOr9qo0T/ee6NdIUGteXIlcIHPSB4rBhIT3m
xpHxV10KHm7bzBMmCFmePhnawLVytXwsYm4kEnlfiHIDYPM00aI=
=VPWh
-----END PGP SIGNATURE-----

--gVaQzNXj3LJq+Vai--

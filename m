Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A732385C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 09:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhBXIL5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 03:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhBXILx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 03:11:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C9C06178B;
        Wed, 24 Feb 2021 00:11:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so817754pjs.4;
        Wed, 24 Feb 2021 00:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ijoCzZ6b5ouVlQ++mR5Xmf5Aaf9cYGb7SNX0udXp30=;
        b=IueIvZIEs6GckT3/zRLPhiUgqVuZ3i52H9YC01UeMB7yw7GDRp0qYWXSWr58GSqEYL
         Cb9a/YoUsTh5gR1rQ03qY7zfWzJB7BE9VxMr3oDdLJyXPNvvh5j36IcvEks7dhq0sIFK
         K3F+6CVMWzUEFdlfS12BVM6F9GKZq6D86CONcyl9b9o0P+HwfPhQg9zfM5YALf0INRzL
         tNPhGln2zQuAGdbw5/sG1Vmo0o1tQph2W1LYNSo7ppEww8lMOJzcSTL5COWtLyLqfErm
         Y46zmJnEnbzSAPolSpXUxHRdgrmThdODgGE9eGN2+ZCDIZxYU1bEGOzKuD+JXGp/cJ9W
         jJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ijoCzZ6b5ouVlQ++mR5Xmf5Aaf9cYGb7SNX0udXp30=;
        b=rqIvXAOQOkOYOtVO5bMK7+vP1NgW9OU5BnNXL7g3R6CgilHOtJUO9uyC8vwGpM37oA
         5Z16iH+X34zyOmS0jcKahI+alpx3NjnLG48LxrqAn75LYQARZ9zj4XhYP4ZKS9p1Jsur
         hicVDCcFX/KPlQkwzSjghsYfCR69A6ikWCxu9ABSzOaYd7ClAUgsuw75UNZ4mjMoNvPL
         yvZvK5eWFM9NuqnqBwsKWXsTcVvciSM3FeC/26vfiEXixW+QNwLS0o6WZTrXn5bbCoh8
         zqvNoo2WC4OE+L/WhQHa77+k8xFqhqgSUzSXK5IpwPiGpGiQat27mQYtAKC+B8OduqhO
         5KCg==
X-Gm-Message-State: AOAM5331+/J6DCx5w1B7PqROBhdIBMrDfi5drg/LxXyHljRq73QosWXX
        VOBdtRJkjj1hthgTMpBpHZhF1PyubwdGYQ==
X-Google-Smtp-Source: ABdhPJzXNwOobWANnStxX5LmWakfcCZl2Yp4Z4DkxmOciDSWwQa/iamIv2TmKzIyIz00z3Rzcht5Uw==
X-Received: by 2002:a17:90b:696:: with SMTP id m22mr3314370pjz.67.1614154270566;
        Wed, 24 Feb 2021 00:11:10 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id u3sm1606020pfb.88.2021.02.24.00.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:11:09 -0800 (PST)
Date:   Wed, 24 Feb 2021 17:11:03 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <YDYKF7zdyjZX30gX@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
 <20210224073506.GA24260@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JS5AAkntRZBst3SK"
Content-Disposition: inline
In-Reply-To: <20210224073506.GA24260@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--JS5AAkntRZBst3SK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 08:35:06AM +0100, Oleksij Rempel wrote:
> On Wed, Feb 24, 2021 at 11:34:06AM +0900, William Breathitt Gray wrote:
> > On Tue, Feb 23, 2021 at 06:45:16PM +0100, Oleksij Rempel wrote:
> > > On Tue, Feb 23, 2021 at 11:06:56AM +0100, Oleksij Rempel wrote:
> > > > On Mon, Feb 22, 2021 at 10:43:00AM +0900, William Breathitt Gray wr=
ote:
> > > > > On Mon, Feb 15, 2021 at 10:17:37AM +0100, Oleksij Rempel wrote:
> > > > > > > > +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> > > > > > > > +{
> > > > > > > > +	struct event_cnt_priv *priv =3D dev_id;
> > > > > > > > +
> > > > > > > > +	atomic_inc(&priv->count);
> > > > > > >=20
> > > > > > > This is just used to count the number of interrupts right? I =
wonder if
> > > > > > > we can do this smarter. For example, the kernel already keeps=
 track of
> > > > > > > number of interrupts that has occurred for any particular IRQ=
 line on a
> > > > > > > CPU (see the 'kstat_irqs' member of struct irq_desc, and the
> > > > > > > show_interrupts() function in kernel/irq/proc.c). Would it ma=
ke sense to
> > > > > > > simply store the initial interrupt count on driver load or en=
ablement,
> > > > > > > and then return the difference during a count_read() callback?
> > > > > >=20
> > > > > > This driver do not makes a lot of sense without your chardev pa=
tches. As
> > > > > > soon as this patches go mainline, this driver will be able to s=
end
> > > > > > event with a timestamp and counter state to the user space.
> > > > > >=20
> > > > > > With other words, we will need an irq handler anyway. In this c=
ase we
> > > > > > can't save more RAM or CPU cycles by using system irq counters.
> > > > >=20
> > > > > It's true that this driver will need an IRQ handler when the time=
stamp
> > > > > functionality is added, but deriving the count value is different=
 matter
> > > > > regardless. There's already code in the kernel to retrieve the nu=
mber of
> > > > > interrupts, so it makes sense that we use that rather than rollin=
g our
> > > > > own -- at the very least to ensure the value we provide to users =
is
> > > > > consistent with the ones already provided by other areas of the k=
ernel.
> > >=20
> > > The value provided by the driver is consistent only if it is not
> > > overwritten by user. The driver provides an interface to reset/overwr=
ite it.
> > > At least after this step the value is not consistent.
> >=20
> > I wasn't clear here so I apologize. What I would like is for this driver
> > to maintain its own local count value derived from kstat_irqs_usr(). So
> > for example, you can use the "count" member of your struct
> > interrupt_cnt_priv to maintain this value (it can be unsigned int
> > instead of atomic_t):
> >=20
> > static int interrupt_cnt_read(struct counter_device *counter,
> > 			      struct counter_count *count, unsigned long *val)
> > {
> > 	struct interrupt_cnt_priv *priv =3D counter->priv;
> >=20
> > 	*val =3D kstat_irqs_usr(priv->irq) - priv->count;
> >=20
> > 	return 0;
> > }
> >=20
> > static int interrupt_cnt_write(struct counter_device *counter,
> > 			       struct counter_count *count,
> > 			       const unsigned long val)
> > {
> > 	struct interrupt_cnt_priv *priv =3D counter->priv;
> >=20
> > 	/* kstat_irqs_usr() returns unsigned int */
> > 	if (val !=3D (unsigned int)val)
> > 		return -ERANGE;
> >=20
> > 	priv->count =3D val;
> >=20
> > 	return 0;
> > }
>=20
> I understand this part. There is no need to spend extra CPU cycles if
> the interrupt was already counted. Just read it on user request and
> calculate the offset if needed.
>=20
> As soon as timestamp support is available, I will need to go back to
> local counter, because the kstat_irqs_usr() will take a lot more CPU
> cycles compared to private counter (it sums over all CPU local
> counters). So it's better to increment a single variable, then to call
> kstat_irqs_usr() from interrupt handler at IRQ rate several 10 thousands
> interrupts per second.

All right, I see what you mean. Let's keep your current implementation
then.

> > > > We are talking about one or two code lines. If we will take some
> > > > duplication search engine, it will find that major part of the kern=
el
> > > > is matching against it.
> > > >=20
> > > > Newer the less, this driver provides a way to reset the counter. Why
> > > > should we drop this functionality no advantage?
> > > >=20
> > > > > To that end, I'd like to see your cnt_isr() function removed for =
this
> > > > > patchset (you can bring it back once timestamp support is added).
> > >=20
> > > It make no sense to request an interrupt without interrupt service
> > > routine.
> > >=20
> > > https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L2=
072if
> > > 	if (!handler) {
> > > 		if (!thread_fn)
> > > 			return -EINVAL;
> > >=20
> > > As you can see, requesting an irq need at least handler or thread_fn.
> > >=20
> > > enable_irq: this will explode at least here:
> > > https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L7=
78
> > >=20
> > > If he have no IRQ handler and some how was able to enable it, at
> > > some point this IRQ will be disabled by this code:
> > > https://elixir.bootlin.com/linux/latest/source/kernel/irq/spurious.c#=
L410
> > > 	if (unlikely(desc->irqs_unhandled > 99900)) {
> > > 		/*
> > > 		 * The interrupt is stuck
> > > 		 */
> > > 		__report_bad_irq(desc, action_ret);
> > > 		/*
> > > 		 * Now kill the IRQ
> > > 		 */
> > > 		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
> > > 		desc->istate |=3D IRQS_SPURIOUS_DISABLED;
> > > 		desc->depth++;
> > > 		irq_disable(desc);
> > >=20
> > > With current code, we can't request or enable IRQ without cnt_isr(). =
Not
> > > that it is not possible, but it make no sense to me.
> >=20
> > What I'm requesting is to remove the interrupt code from this driver for
> > now including the cnt_enable_write() callback. Yes, we will need it when
> > timestamp functionality is added, but currently the Counter subsystem
> > does not have that functionality yet. Once the Counter character device
> > interface is merged, then it makes sense to add the interrupt service
> > routine to push timestamps to the user.
> >=20
> > It is still useful to have this driver mainlined even without the
> > interrupt code: getting the body of this driver merged means a much
> > easier review of the timestamp code in the future, and users can start
> > using current Counter sysfs interface to track their GPIO interrupts.
>=20
> This driver, even without timestamping support, can't work without
> interrupt code. request_irq is the core functionality of it. The kernel
> interrupt infrastructure will not enable a IRQ and it will not provide
> stats without request_irq().
>=20
> The minimal requirement to make it work is to call request_irq() with
> a handler which will return IRQ_HANDLED value.
>=20
> It makes no sense to mainline this driver without IRQ code, because it
> will not work. And if we need an IRQ handler anyway, and will need local
> count anyway, why should we go extra way around? :)

Ack.

> > > > Are you suggesting to enable IRQ without interrupt handler? May be =
i'm
> > > > missing some thing.. I do not understand it.
> > > >=20
> > > > > Reimplement your cnt_read/cnt_write() functions to instead use
> > > > > kstat_irqs_usr() from <linux/kernel_stat.h> to get the current nu=
mber of
> > > > > interrupts the IRQ line and use it to derive your count value for=
 this
> > > > > driver.
> > >=20
> > > irq descriptor has 3 counters:
> > > - irq_count: this value can be reset any time by the kernel at least =
by
> > >   the note_interrupt()
> > > - irqs_unhandled: this value is increased in case of missing irq
> > >   handler. Or if handler has returns IRQ_NONE.
> > > - tot_count: this value should not be reset.
> > >=20
> > > Non of this values is suitable for cnt_read() and cnt_write(). Only
> > > tot_count would be suitable if cnt_write() is removed. I do not see it
> > > as acceptable option.
> > >=20
> > > For this driver, we still need extra counter, where only this driver =
is
> > > responsible for writing to it.
> >=20
> > Yes, I'm sorry for not being clear before. Please use priv->count for
> > this; there's no need to adjust directly the system irq count.
> >=20
> > > > I can follow the counter read way, but overwriting system wide coun=
ter
> > > > for local use is bad idea.
> > > >=20
> > > > > > > > +static struct counter_signal event_cnt_signals[] =3D {
> > > > > > > > +	{
> > > > > > > > +		.id =3D 0,
> > > > > > > > +		.name =3D "Channel 0 signal",
> > > > > > >=20
> > > > > > > You should choose a more description name for this Signal;
> > > > > > > "Channel 0 signal" isn't very useful information for the user=
=2E Is this
> > > > > > > signal the respective GPIO line state?
> > > > > >=20
> > > > > > Sounds plausible. How about "Channel 0, GPIO line state"?
> > > > >=20
> > > > > Ideally, this would match the GPIO name (or I suppose the IRQ num=
ber if
> > > > > not a GPIO line). So in your probe() function you can do somethin=
g like
> > > > > this I believe:
> > > > >=20
> > > > > 	cnt_signals[0].name =3D priv->gpio->name;
> > > >=20
> > >=20
> > > > to make this possible, i would need hack gpiolib framework and add
> > > > name/label exporter. But after endless rounds of pingponging me for
> > > > renaming the driver and removing interrupt handler, i feel like we =
are
> > > > not having serious discussion for mainlining this driver.
> > >=20
> > > Probably for good reason, struct gpio_desc was made local and is loca=
ted
> > > in the drivers/gpio/gpiolib.h. It feels like additional hack to inclu=
de
> > > it. I assume, it should be done properly so there is a function to
> > > provide gpio name or label.
> > >=20
> > > @Linus Walleij are there any good way to get the GPIO name? And which
> > > name will be actually used? A label provided over devicetree?
> >=20
> > Perhaps one of the GPIO subsystem maintainers can provide more guidance
> > here, but I was under the impression that this name was provided
> > statically by the respective GPIO driver via their struct gpio_chip. I
> > think you can see the array of names via priv->gpio->gdev->chip->names.
> >=20
> > Alternatively, we can take a more generic approach: ignore the GPIO
> > names and focus solely on the IRQ lines; because the GPIO lines will
> > always be tied to respective IRQ lines here, using the IRQ as the basis
> > of the name should always be valid. The "name" member of the struct
> > irq_chip can work for this. I haven't tested this, but I think something
> > like this would work:
> >=20
> > 	cnt_signals[0].name =3D irq_get_chip(priv->irq)->name;
>=20
> ok, i'll take a look at it.

If that doesn't work, then use devm_kasprintf() to generate the name
based on the IRQ line number. The idea here is that the user should be
able to identify that the Signal component for this Count is the
respective IRQ.

William Breathitt Gray

--JS5AAkntRZBst3SK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA2Ce8ACgkQhvpINdm7
VJJmGhAAxhlZ24lzyc2w5T1z2fVTza1kDMq73XaGew3T8svTcfELJZEiuvGpJu6g
33B7l/y1lo0072v9UEIlQcK6Y8m9Tty0rFvT4/6C8+Rg7xPimHDsohwIxL7ahpce
SeMxWDRgD4C0G9poVcN1TGOPbGa7WjjhgTU/dMfxTZ22iWAPAA4By551PjadWsYA
R1aceoOfVQFDHGKyKxMYk4o9aKbE0VL7SsQrl7Sy44EQwu5+iGTZ62SRhqRiNVfK
BivVWwfCj8OeH001UVNzuHvkZxyZ9xfj9Z4b6QuqGd+8bUvt5R6WAJHupIHliDKX
wI3X/rp+ZSIGfpMVYqTR+q8m8k2zCIaS5W0rZqQNNAACX0AWq0Il/59Ashh3/Ov2
OCAa6nqJymANKLTmnTUPrj0FBNbbd/9kGZQTdchRCH93C9DD1c47TlddWVVM1j2p
9zgEQwxPHwdaZhyu/2BGr+bep1zQ8JMBZ/BvQTo+52RtJ0zBs4MgAlb9KzlvAZSW
E2MBV9iZgW7YHb8MW7ynGhyki4u2I+6k7adCgpiv6AgjNRPoIGTY81b0v7gWXDtv
iZ+MbHWu31QW+yZqWnWmoyFs+LGINl56HG2mB0MIN3+nb22n3NBM2hAsijuLfwMw
zQdfELiK90HkbgWflq72Igc7fZjZUFx6T+xCDt+GaPz0qpEABW4=
=3n5T
-----END PGP SIGNATURE-----

--JS5AAkntRZBst3SK--

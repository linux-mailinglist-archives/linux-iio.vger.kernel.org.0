Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF4320F39
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 02:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhBVBnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhBVBnq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 20:43:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4EC061574;
        Sun, 21 Feb 2021 17:43:06 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z5so2459393pfe.3;
        Sun, 21 Feb 2021 17:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HZ/4l65nTDhovBkbwgDTnLClUOuYmVMheRYyJCbxZxM=;
        b=h0cYF5fvpWEiRbbwRWAAqWEfqrdffeclp04xOx6AiP7i586mgB9Q5LMC2N+1DjcMC6
         qvi5rPKwNvt8Ax6OZ/+GnVN2fW3MJi6DeCPv30sBm6uK0I+1pM5ALKEHf2pxOVb6Nv3h
         2QSGxfy2koj9i8E39QpCUFPC4P5xn/QX7cs6dqp1SiGphc+F1gLbdRJigAvX8r3o40bE
         Ag5SzS1RGj9SLXFM2QcxSvGZdAkE2LJ30jArcE2PtkISXy+1UD/RfDVKb3BUuunFUWNt
         dsPVeh/M9an6AfBXoDQxzFohOExR+fyPnaSedk1W+sMDOJkmH+oWYh61bEXtUP2Y1Rlo
         U/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HZ/4l65nTDhovBkbwgDTnLClUOuYmVMheRYyJCbxZxM=;
        b=dF2MGUXYwvbTUYpqdtH5S1r9c+4Sb99WgODK1sAMm8T9hvgXDgnxtbossc946ipVYI
         wccgkHb4cCM51Cfs41EK1oVsjSD+fB9bNDxCRs+aOHRYJgA5j7Lt30AwjKbNmJ59unJO
         0U268E4c+mVBDUArDPPzmNHak9qDzftj55zATwkE1M1S2HK3ZcsVnt31sibpkkkeaaQR
         G52o90PikmoOJmQSZqfrHs0Dkg1PAyo+s4wLFiIHVCaZ4Jd3TGhbbquBH78hF0INIvBK
         g57kGzgs44LfHKboRG7vk+Vpfj3QGNGkpNIaJKIx4H/wiv5NwsP+9DKeK3k8EIe1Rirt
         kowg==
X-Gm-Message-State: AOAM5335SK0xEHQ07g5XWGSWkOMubBmL1DSCVZPQeUQGMZ50sDWpnyBn
        CB1uxmLB1Corgg7rlbvIW1M=
X-Google-Smtp-Source: ABdhPJxBiOH+r7NdzTv2bl+669/mGs+q2NSfxyJ5R/ryNclj98f75uRzTtN2b8n/uhXnJ37Tw9vsuA==
X-Received: by 2002:a63:4d41:: with SMTP id n1mr18230961pgl.147.1613958186088;
        Sun, 21 Feb 2021 17:43:06 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id lw17sm14874202pjb.11.2021.02.21.17.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 17:43:05 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:43:00 +0900
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
Message-ID: <YDMMJJ985Zq9oEOv@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wC8Tf9mEZxh/iA1u"
Content-Disposition: inline
In-Reply-To: <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wC8Tf9mEZxh/iA1u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2021 at 10:17:37AM +0100, Oleksij Rempel wrote:
> > > +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> > > +{
> > > +	struct event_cnt_priv *priv =3D dev_id;
> > > +
> > > +	atomic_inc(&priv->count);
> >=20
> > This is just used to count the number of interrupts right? I wonder if
> > we can do this smarter. For example, the kernel already keeps track of
> > number of interrupts that has occurred for any particular IRQ line on a
> > CPU (see the 'kstat_irqs' member of struct irq_desc, and the
> > show_interrupts() function in kernel/irq/proc.c). Would it make sense to
> > simply store the initial interrupt count on driver load or enablement,
> > and then return the difference during a count_read() callback?
>=20
> This driver do not makes a lot of sense without your chardev patches. As
> soon as this patches go mainline, this driver will be able to send
> event with a timestamp and counter state to the user space.
>=20
> With other words, we will need an irq handler anyway. In this case we
> can't save more RAM or CPU cycles by using system irq counters.

It's true that this driver will need an IRQ handler when the timestamp
functionality is added, but deriving the count value is different matter
regardless. There's already code in the kernel to retrieve the number of
interrupts, so it makes sense that we use that rather than rolling our
own -- at the very least to ensure the value we provide to users is
consistent with the ones already provided by other areas of the kernel.

To that end, I'd like to see your cnt_isr() function removed for this
patchset (you can bring it back once timestamp support is added).
Reimplement your cnt_read/cnt_write() functions to instead use
kstat_irqs_usr() from <linux/kernel_stat.h> to get the current number of
interrupts the IRQ line and use it to derive your count value for this
driver.

> > > +static struct counter_signal event_cnt_signals[] =3D {
> > > +	{
> > > +		.id =3D 0,
> > > +		.name =3D "Channel 0 signal",
> >=20
> > You should choose a more description name for this Signal;
> > "Channel 0 signal" isn't very useful information for the user. Is this
> > signal the respective GPIO line state?
>=20
> Sounds plausible. How about "Channel 0, GPIO line state"?

Ideally, this would match the GPIO name (or I suppose the IRQ number if
not a GPIO line). So in your probe() function you can do something like
this I believe:

	cnt_signals[0].name =3D priv->gpio->name;

Of course, you should first check whether this is a GPIO line or IRQ
line and set the name accordingly.

William Breathitt Gray

--wC8Tf9mEZxh/iA1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAzDBkACgkQhvpINdm7
VJIqnw//X6S/JF8NIH9UZTbsm1n4Yu5N6OuQoLch0ADAHI6Ei6/ntVwFPUPG0Kaz
8DoefFjwbu7ixJA/aCLo8c0dCzrztQxcz4gTB+50uoxGNk6YqvYGHtsfcalN2vae
u9ku4i3j2oDk9KZwlFs49QhxZjBIZ6BBmz/R2HbYcurhU4pa/7Y22otyPUwKhXVB
pvDTKNrQmN2PRYS1CQcwup+D0/skW/JKiG76MPCtJ1HWt+bj+Aih+7wIwqsQ1m6p
W0jyQc4Mt+tbPZ30IratIJJiO1Vsw/D9TTHCkErP7x7BEE2dIY4SJ5fJe1L8up1f
vHo2G8gFO8JdoZT4eFvEbmWKC6Lv76ClKjSDqDKgr5SYtyZOzbtqPaxjDD3GB3eY
BPU8eekZoPjdDuktFnaLP6wXVewGP87Thr7NXCwRkA7boSe+6s3IYTFAzqhtgdKw
QdE+C3154koHmyyd5kwkVm3Hzur4xCWj2wQ7fze6tjwnSiAdCMFrz6myMtj7Exg7
GBDbLVQWvv0F6uA3G8vzzT2o//hb8AD1x859o1Bxmcbsrjz3yb4/s5QwKRxq7MFK
IZYz9VAMgNUUYlD/hs21UBl2PmjEH6NGySuGvXOMTGU5EAdTdL8SopJ38l9XuzHS
ZjlHqraYQvaP9p64s7vB8taS6LnZudVgivmf/0spF5PlL5K7R1o=
=zZCZ
-----END PGP SIGNATURE-----

--wC8Tf9mEZxh/iA1u--

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644462FE4AC
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 09:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAUILR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 03:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbhAUIEC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 03:04:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4DC061575;
        Thu, 21 Jan 2021 00:03:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id lw17so4458106pjb.0;
        Thu, 21 Jan 2021 00:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bh13r2wHvQbcitjyvM1dQ9PJDj0Nb/62/ozD/OJPFnA=;
        b=Bdu4BJfoYHZa4/6zPvES1e1NpE5Sa3X+5Fe7dt+Cx3g86HHp9Gl6FzC0GqiQmO2jIz
         QT2kbaKRn6fWOyy2VBpXKwUjYjyMwjjhHTKaX1lZwTIOaUFxIGUFWy6T28M9sbHOrCpJ
         vabrkikQoTJ7+VD/zKbIp5BtPCQdVqaMPrkAS9mIgKv2YWM/7G8I32FxdNTVggnu3F5s
         mfQuGiFJuXftIMTD6V6NhkPTRjWAcEGm+3kg3FzW3mRHCH8GN9ebpdiUJ3cA+oR+0XSJ
         ixiTF9Z8Bj9Xgkpxp5kEINNzqFU3ox19YrltS/4om9cAx2XiBPhyklOqEJAFuDtPhoJk
         YBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bh13r2wHvQbcitjyvM1dQ9PJDj0Nb/62/ozD/OJPFnA=;
        b=nL6Uxqv8KRYXjC5Uxyc9OxkmiZ+ArOcKp3t+7Kpg5/JnF4tyjaSi7FWErMMoHGkorc
         /xXjvTgjHa2UCm5vMLL62TJ9DP79sf7tsSSJsAQ+g+L4PT6llY788yy/h/FgqBPgFuVr
         b0idtaKqXbW77LzJ2x96amZNwdBflE/pfYScTBVuqXHqYM/hN1FCT7Gqn1ckG29mzXS2
         7XdSLVYebEA7s5Z0q6dxvE0tm44O2yDH7yDNniAE8LQiK3Y0w7kLDreoTCB30oOGeyIc
         ybJgdoFrWXzmpKr0YdqVG2E66M5EXyY1v+G0X/GzJh1zs8xdHwTqJ5/vVoZejDScsKDh
         WDqw==
X-Gm-Message-State: AOAM531KJRLa+J6I04n/s+WY9UJ4WsKIiqtHEsl3QutH59SJ1KQneu0Q
        uC+5U1SXc+LZ0tbHACShCrw=
X-Google-Smtp-Source: ABdhPJzsjty/5oIGiORbLq3cGorBJfWIykd6mkaKqPfqopL6VBY51ktcbHb+u9QCiIF9PohiE7B5KA==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr10338364pjb.205.1611216201618;
        Thu, 21 Jan 2021 00:03:21 -0800 (PST)
Received: from shinobu (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id t8sm4676775pjm.45.2021.01.21.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 00:03:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 17:03:11 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        a.fatoum@pengutronix.de, david@lechnology.com,
        linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v6 3/5] counter: Add character device interface
Message-ID: <YAk1PzXYQaJvhGSj@shinobu>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
 <20210119092022.GA14502@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JoiEQsXQ7A8iDp7"
Content-Disposition: inline
In-Reply-To: <20210119092022.GA14502@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7JoiEQsXQ7A8iDp7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2021 at 10:20:22AM +0100, Oleksij Rempel wrote:
> On Sun, Nov 22, 2020 at 03:29:54PM -0500, William Breathitt Gray wrote:
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
>=20
> Hello William,
>=20
> the series looks quite interesting, we have some thoughts... see below:
>=20
> [...]
> > +/**
> > + * counter_push_event - queue event for userspace reading
> > + * @counter:	pointer to Counter structure
> > + * @event:	triggered event
> > + * @channel:	event channel
> > + *
> > + * Note: If no one is watching for the respective event, it is silently
> > + * discarded.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int counter_push_event(struct counter_device *const counter, const u8 =
event,
> > +		       const u8 channel)
> > +{
> > +	struct counter_event ev =3D {0};
> > +	unsigned int copied =3D 0;
> > +	unsigned long flags;
> > +	struct counter_event_node *event_node;
> > +	struct counter_comp_node *comp_node;
> > +	int err =3D 0;
> > +
> > +	ev.timestamp =3D ktime_get_ns();
> > +	ev.watch.event =3D event;
> > +	ev.watch.channel =3D channel;
> > +
> > +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> > +
> > +	/* Search for event in the list */
> > +	list_for_each_entry(event_node, &counter->events_list, l)
> > +		if (event_node->event =3D=3D event &&
> > +		    event_node->channel =3D=3D channel)
> > +			break;
> > +
> > +	/* If event is not in the list */
> > +	if (&event_node->l =3D=3D &counter->events_list)
> > +		goto exit_early;
> > +
> > +	/* Read and queue relevant comp for userspace */
> > +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> > +		err =3D counter_get_data(counter, comp_node, &ev.value);
> > +		if (err)
> > +			goto exit_early;
> > +
> > +		ev.watch.component =3D comp_node->component;
> > +
> > +		copied +=3D kfifo_put(&counter->events, ev);
>=20
> We want to calculate the frequency of some IRQ pulses in user space and
> counter values with time stamps really fits well here. As the pulses are
> from a physical system (rotating wheel), they will only change at a
> certain rate. We want to have the possibility to read from the counter
> device less often, we intentionally want to skip (meaning miss)
> events.
>=20
> When reading we're interested in the newest events. The kfifo implements
> a "tail" drop FIFO, which means new values are added at the end, and if
> the FIFO is full, they are dropped. We need a "head" drop FIFO which
> discards the oldest events, keeping only the recent ones.
>=20
> As far as we know, kfifo doesn't offer a head drop mode, but I think
> this can be added.

I'm not sure if kfifo has this kind of mode, but it seems like something
that should be there if it is not already -- I imagine this kind of
operation mode would be pretty common. Perhaps someone knows how to
achieve this and will share here.

>=20
> [...]
>=20
> >  struct counter_device {
> >  	const char *name;
> > @@ -270,12 +270,20 @@ struct counter_device {
> > =20
> >  	int id;
> >  	struct device dev;
> > +	struct cdev chrdev;
> > +	raw_spinlock_t events_lock;
> > +	struct list_head events_list;
> > +	struct list_head next_events_list;
> > +	DECLARE_KFIFO(events, struct counter_event, 64);
>=20
> Do you plan to make the size of the FIFO configurable?
>=20
> regards,
> Oleksij & Marc

I suppose it wouldn't be a problem to make this a configurable setting;
I think I can implement this via kfifo_alloc() and kfifo_free(). How
would users control this -- maybe using a sysfs attribute?

William Breathitt Gray

--7JoiEQsXQ7A8iDp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAJNTMACgkQhvpINdm7
VJIpoBAAn3DpItFgzN5v2hJbI28XhzwT7nzB7h8JHE3jm6IQ9i4QmOhWY0lE7ZQT
334CjFwj2/BrXrQiC4v1l4tVIUjbcGQyk+watPXOIqSG1jPaqR3cwqAGb8ekPJcn
/EJg8+ytI4idmiX76ilGlG59O+3Imm5lhlRX6xEqYTNeFDUUGwcD9nMFsRzSZPA4
SDVqe6Jvke0oCYiW8a3HIqki+bdyBauMF10EbAd51ZECrIVK2IHukAIQ6bea2tVN
41Uwr4yIoUnUonwPvrK4h2U+CZVHMty+Z6AxamFj8D1Ltm/hEOZunrElYfOKS9Rw
XdVvSElGkhyrNdwFfr+p4hpsEX7ingZkpZrdxZQeXbgF8AVO+FzuAaFXJIPMlzjw
mYL2HT2ClAPJNuF7IRi/sQWAYcrcNpRl9/JPfzfSz+6GpEME/xGv7c5aYKN+K+NL
gMrLLT92TGmxmR8z5P9aPL9kULTq7ZqMi+C2OK0c6ufdzX5jPpDYKe+fBv56EDDr
Sfbcd57tHK3HqILXx2cNvBLGP87Xt+FLFktXZXYyuNIA5zmhiIuovs7zkqDIwjJC
pjgF5MQAWQa2Z26gboCp3opTZYaTHEfoDG1tMqZg0I8WatAxJ3HglbgwZLJ8Er3P
0t18drOAHEhuafYYiASZ1JQcuX9NNz7tA+wBLbhJm6QGsUcYK3Y=
=841n
-----END PGP SIGNATURE-----

--7JoiEQsXQ7A8iDp7--

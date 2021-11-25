Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8245D315
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 03:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhKYCV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 21:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhKYCT1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 21:19:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A6C061191;
        Wed, 24 Nov 2021 17:58:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5306254pjb.1;
        Wed, 24 Nov 2021 17:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3psQj9uRn1N6+igZlgP67KqBscZ1ZeWmQioyP+cL8A=;
        b=czX0hZ3DxLNthKEpROko5I2eIAx01IWBG8eVLto4/aFCbFje5qmIxVWPbd4hUty3eH
         u2dFiCmaqsenyCPfQtBxhxaubxO0aocx7I/LMbhbpzslZ/L78ezkAKaftM/DEXGY9rYE
         K68N3E7jyykSRlScw98XWeJcwCijoUWpq9fWzv5lzd8Z23Em2VZI4HQd3SSxS3FHGvwf
         XxzAcahSQ9LPD/zvcNgYDJHW69Mb69b21rekEC6L58nfZuiCqwFkXF8zM051nkrgP99V
         IdFj2aznksJHvK8TH+d20f3Y908k3HHEQMZlROz04r6RLm077P466HsVvQ66LVgn0Gof
         OhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3psQj9uRn1N6+igZlgP67KqBscZ1ZeWmQioyP+cL8A=;
        b=pJF8jcMTIzzYpmNcA3tiYgVMnJxGuzASewGLyHez0QpsyRzlC6GljdoivHY8he0+ZM
         Rp+PoeFq/FDwsUKFBO5g+Jo4vsWRHJrU3ZtHj6qvp5RpHitUknJXZirHcEhgECwAru0l
         QxoOvshLhBs3Lv3wQIoG+y1rr8aQRmjqYsb6QO6OP7qOPFLOLV6ozipXL9RLz7/8FkEG
         O3Vt/VGWLRGRTPENHS2IjRJOV9BpyeKiwx09sB/AkhUVi8q45MWIpguto8hDRHNmL2QM
         vyA05QVCloVIbi8k840mxvGwqSbT1Bqa1Zut0Yp8r83acniMsPnXf4nZxJudY8BpOSYz
         Obcg==
X-Gm-Message-State: AOAM532mUEihz3W3DKQE/+PQ3NxaDeGmjdKgC30ndAT0lZm9oMgbiwDE
        xil3k8A1nBFf9HVLkB+n+Q0=
X-Google-Smtp-Source: ABdhPJzwFydv5CXDWSb7ADB2x4XY8Sc2ip75pezs6mf2BE7OZbOqWofUmesPfCqhG/m7xdI9UZ4BpQ==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr2337450pjb.75.1637805514357;
        Wed, 24 Nov 2021 17:58:34 -0800 (PST)
Received: from shinobu ([138.199.21.11])
        by smtp.gmail.com with ESMTPSA id p128sm981763pfg.125.2021.11.24.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 17:58:33 -0800 (PST)
Date:   Thu, 25 Nov 2021 10:58:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>, david@lechnology.com
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <YZ7tv79LQwLL7h3T@shinobu>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu>
 <20211124072720.GA30281@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QhPtWNvbc3Joztu6"
Content-Disposition: inline
In-Reply-To: <20211124072720.GA30281@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--QhPtWNvbc3Joztu6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:
> Hi William,
>=20
> On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:
> > On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
> > > Add counter_push_event() to notify user space about new pulses
> > >=20
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  drivers/counter/interrupt-cnt.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interr=
upt-cnt.c
> > > index 8514a87fcbee..b237137b552b 100644
> > > --- a/drivers/counter/interrupt-cnt.c
> > > +++ b/drivers/counter/interrupt-cnt.c
> > > @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void =
*dev_id)
> > > =20
> > >  	atomic_inc(&priv->count);
> > > =20
> > > +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> > > +
> > >  	return IRQ_HANDLED;
> > >  }
> > > =20
> > > --=20
> > > 2.30.2
> >=20
> > Hi Oleksij,
> >=20
> > It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
> > an interrupt is handled, which I suspect is not what you want to happen.
> > The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
> > so you'll need to check for a count value overflow before pushing the
> > event.
> >=20
> > It would be good idea to implement a ceiling extension as well (you can
> > use the COUNTER_COMP_CEILING() macro) so that users can configure the
> > particular point where the value overflows.
>=20
> Thank you!
>=20
> What would be the best and resource effective strategy for periodically
> getting frequency of interrupts/pulses? This is actual information which =
is
> needed for my use case.
>=20
> So far, I was pushing every event to the user space, which is working
> but probably not the most resource effective method of doing it.
>=20
> Regards,
> Oleskij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

We could introduce a new Counter change-of-state event type which would
trigger whenever the count value changes, but I agree with you that this
is likely not the best way for us to derive the frequency of the
interrupts due to the indirection of handling and parsing the event
data.

Instead, perhaps introducing a "frequency" or "period" Count extension
would make more sense here. This extension could report the value delta
between counts, or alternatively the time delta from which you can
derive frequency. Regarding implementation, you can store the previous
value in a variable, updating it whenever an interrupt occurs, and
compute the particular delta every time a read is requested by the user.

David Lechner is implementing something similar for the TI eQEP driver
to expose speed, so I'm CCing them here in case this is of interest to
them.

William Breathitt Gray

--QhPtWNvbc3Joztu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmGe7bQACgkQhvpINdm7
VJK0BRAAlF/X63tFON/5iQnbCUUnB1F+G6BoSoYdtyWa3it34l209vy0k/+CXtjp
hNQKViK6gek9U8a+7uwEtsxqNaZLFM3efuzCXEtQJEahpl8+DVukBsCG45abEhJ6
UQiUMABapCgmDOTgAk8zR5ItK9NjpJ8ELLpEzHm/8Zxe4KGmYGTTx0VpoxhnAW+6
WNtiyY7XO+J7Fp8bh/FsSsyPIV5kV0NOVbXSMiAhPzbKHMin+EFZZG5QmJ7CUP0l
kxKiHhdpNahqP/5KxDknxwO3+kqnuRHPxJbD06SJ2PKQDIih/CVuqQUQBpFlze5l
I5fBzONRjB/3MA9JNhp0/Qf+qDu/1ai1dXemw7KF5d9+nRZ9MJOT438clnhnGKqK
9VR/1R98ihBoUQgLpAC1jnk6KGH5Yyx20CoIHsMCTZJS4ZoN15gkiq8vzMb8rUkz
cIB0oQ1YBRw2ws4s5AV6Ooz9+CGpwS1OZ5lBudz/zyDh3GeXAzP4f9FMfFvzQNK1
ZYurZQ83lD2iXL8Y6TY9ZT30VinbAQcJWQYHlHvJJA8Z6YIhEKXocBoVxP/nNsY7
ygce+vFYQepiRN8f6bz840z8W4nbzRMfcwxbDDjOCsV1NCEXtnck+eC0TwPokX2F
uE66tF4f16xpunCuG5uaGk4wQvWPciAzZHMJXX64ZyLemgez5A8=
=Xn1H
-----END PGP SIGNATURE-----

--QhPtWNvbc3Joztu6--

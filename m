Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9621472374
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 10:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLMJEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 04:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLMJEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Dec 2021 04:04:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79FC061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 01:04:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwhGL-00049J-8V; Mon, 13 Dec 2021 10:04:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwhGL-004HSm-8N; Mon, 13 Dec 2021 10:04:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwhGK-0001co-BI; Mon, 13 Dec 2021 10:04:48 +0100
Date:   Mon, 13 Dec 2021 10:04:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC] counter: Expand API with a function for an exact
 timestamp
Message-ID: <20211213090448.mpxlxkjwhujsuobe@pengutronix.de>
References: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
 <Ybb5B0AI5EWCagOV@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75ib7hbycgegdzh2"
Content-Disposition: inline
In-Reply-To: <Ybb5B0AI5EWCagOV@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--75ib7hbycgegdzh2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Mon, Dec 13, 2021 at 04:40:55PM +0900, William Breathitt Gray wrote:
> On Tue, Dec 07, 2021 at 07:10:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > Some hardware units capture a timestamp for the counted event. To
> > increase precision add a variant of counter_push_event() that allows
> > passing this timestamp.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > the difficulty is that the captured timer value is in a unit different
> > from the one provided by ktime_get_ns(). So maybe some helper functions
> > will be needed to convert the local timer value to a ktime timestamp?
> >=20
> > So usage would be something like:
> >=20
> > 	ktime_now =3D ktime_get_ns();
> > 	local_now =3D readl(CNT);
> > 	local_event =3D readl(...);
> >=20
> > 	ktime_event =3D ktime_now - (local_now - local_event) * somefactor >> =
someshift;
> >=20
> > 	counter_push_event_ts(count, event, channel, ktime_event);
> >=20
> > This improves the precision because irq latency doesn't influence
> > the resulting timestamp. The precision then only depends on the timer
> > resolution and the delay between ktime_get_ns() and readl(CNT);
> >=20
> > I don't have a driver (yet) that makes use of this, the hardware where
> > this will matter will be stm32mp1.
>=20
> Precision logging of counter events was one of the main motivations for
> the creation of the Counter character device interface, so if we can
> reduce the jitter of the timestamp by utilizing hardware-provided
> values, I'm all for it. That being said, we should take care in deciding
> how to expose this data in the Counter interfaces because not all
> devices support such functionality and yet users should expect a
> standard data format to code against.
>=20
> Considering this, I think it better to keep the struct counter_event
> timestamp the way it is right now as ktime_get_ns() so that users have a
> consistent way to retrieve the timestamp of when the Counter event was
> pushed to the queue.

Isn't it totally irrelevant to userspace when the event was pushed to
the queue? I claim userspace is only ever interested when the event
happend and the queue is only an implementation detail of the counter
framework. The documentation for the timestamp member of struct
counter_event is

	best estimate of time of event occurrence, in nanoseconds

=2E That looks sane, and following that, the best estimate is the hw
timestamp?!

(Well, if you experience high latencies, the timestamp of the queuing
might be interesting for debugging, but in this case I'd prefer tracing
support over exposing implementation details in the API.)

> In order to support the hardware-provided
> timestamp, how about exposing local_event and local_now as Counter
> extensions? You can set a watches for the local timestamps to log them
> into the queue with each event, then perform the ktime_event calculation
> in userspace using the struct counter_event timestamp value.

An upside of your suggestion is that calculating the ktime for the event
isn't done unless userspace needs it. Still I'd prefer to use .timestamp
for an as-accurate-as-possible information for the event.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--75ib7hbycgegdzh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmG3DK0ACgkQwfwUeK3K
7An3MQf8CPmfAZyLdzK4wHwM0j3chEzJW4xnka+eMWkmelLdSrRYmXiLBZEeWphZ
E9TE/J9/gEzEPiCEpuANErg+Wx6/vtjxvbfBYKzeo+5JokGmnVJOi4hBiuCMPyqW
FofY8o1AJsIziYBYNP5TFunbv5UiNAOtH15LDQPVr6kf86a3d2SKaiWH4sW0gHmY
fEUHrox2dAQvJppbleu/wfKNqOIMVZ8jaLC/lfC424mvgS7WhfP/Nh32TwMeihfg
RSRZkVT8/vplh+ZRmeMQuEyH15uGHViHvH207lq3VWtAn47RCZicgW7vqE0eYooh
1etbysVaYGFdG/7S2ojDkR7gyeqn1g==
=a3Cn
-----END PGP SIGNATURE-----

--75ib7hbycgegdzh2--

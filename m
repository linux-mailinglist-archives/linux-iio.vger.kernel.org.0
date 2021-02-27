Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94EE326AB5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhB0AVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 19:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhB0AVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 19:21:38 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5617C061574;
        Fri, 26 Feb 2021 16:20:57 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id f19so1052572vsk.13;
        Fri, 26 Feb 2021 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDe5+O2spJHSt6JrFGkCdGoYYocliObqhGtzWKjr3VY=;
        b=BidCqg9ZIdNd1XcUAlLWvwsWoDJUE+PSJFh5ja/DAiY0yeLnijRL1NIDyEtLZ9KYyS
         BTapOMCIIcCjvpEEI3gWSYrnA/qLpM2TLVNRJHlOXRRuQ+WLd9LNEJ3Rr/KWKayjgbPx
         GYe3InfVTKvg88hc1weU4Gcl4F+iTLwKbWR2sU1DIZARNX4TKcpLK842su6EVqYyF9Xr
         cA7jEIf4Jwz8/DKl/PIuDhRb7Rsn63hUzE3gQ8tuLaTCWG6ctToQO5p0KBDJ7VVO3ojG
         JUUc/5sRw19x7C133UvnKJ/t6qZuSeZBeFvPijn++PhzC0E22esEne7CxUPBugN9Rbgt
         lqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDe5+O2spJHSt6JrFGkCdGoYYocliObqhGtzWKjr3VY=;
        b=d+cNAAOuq/A2aNMyRwE2Gt3rtr+O30W/gzGkNogoVbIpt+QWLQmdCtyvN5HBXKTFOc
         OnsoOE9PndVdJs+xfuY+CiS6G8Y061QzPCT4XD8iWTr67YEPm4/ZnjY9DHZVGFMBHhHF
         5bshcWP/l07PInOcrGbYg18JxZVkEWpTeTDpp7HqwmUbW2/T8p6YOT1xx0+XhxGYPjFx
         SSSW+oPSqegsB4+3/iQO0Anjj/aSdSdqkWQLY1gLWoc75P+Uffh+y/AV6VumcAN8Fn9a
         N2NdQOdp+cKdGA31VXyjBZNCzjZHH5WB7odOpXA2PhTXOrZyoUWifhHWCnkntRvNFEhr
         QLwg==
X-Gm-Message-State: AOAM531wSr1ciNtsBMTkcwZCYIQMUkXS6pbNZGFIkPnVLFu8MOI04DVf
        3lCIWROmmj8XlXku63WqOr5RmHnzgWYd/w==
X-Google-Smtp-Source: ABdhPJwzdyZ/ny9vR8ICikk+Ze2fTUzs1GlD+G4s/w+njrYAF+YzoIOUmTGTciaz0G/5xSWIx/6HxA==
X-Received: by 2002:a67:a85:: with SMTP id 127mr3432003vsk.16.1614385256799;
        Fri, 26 Feb 2021 16:20:56 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id t6sm1267925vke.13.2021.02.26.16.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:20:56 -0800 (PST)
Date:   Sat, 27 Feb 2021 09:20:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 20/22] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <YDmQYK1lWXl7H5lm@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181146.66d43da7@archlinux>
 <YC5CMLuKnXbkZond@shinobu>
 <20210221155140.3e1ef13c@archlinux>
 <YDg65OmLa05g53qc@shinobu>
 <37ea96a2-d4a1-7d4c-a68a-8dc82896e86c@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/fFfRNp8huk1mEVl"
Content-Disposition: inline
In-Reply-To: <37ea96a2-d4a1-7d4c-a68a-8dc82896e86c@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/fFfRNp8huk1mEVl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 06:14:12PM -0600, David Lechner wrote:
> On 2/25/21 6:03 PM, William Breathitt Gray wrote:
> > On Sun, Feb 21, 2021 at 03:51:40PM +0000, Jonathan Cameron wrote:
> >> On Thu, 18 Feb 2021 19:32:16 +0900
> >> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >>
> >>> On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote:
> >>>> On Fri, 12 Feb 2021 21:13:44 +0900
> >>>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >>>>   =20
> >>>>> The events_queue_size sysfs attribute provides a way for users to
> >>>>> dynamically configure the Counter events queue size for the Counter
> >>>>> character device interface. The size is in number of struct
> >>>>> counter_event data structures. The number of elements will be round=
ed-up
> >>>>> to a power of 2 due to a requirement of the kfifo_alloc function ca=
lled
> >>>>> during reallocation of the queue.
> >>>>>
> >>>>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> >>>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >>>>> ---
> >>>>>   Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
> >>>>>   drivers/counter/counter-chrdev.c            | 23 ++++++++++++++++=
+++
> >>>>>   drivers/counter/counter-chrdev.h            |  2 ++
> >>>>>   drivers/counter/counter-sysfs.c             | 25 ++++++++++++++++=
+++++
> >>>>>   4 files changed, 58 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Document=
ation/ABI/testing/sysfs-bus-counter
> >>>>> index 847e96f19d19..f6cb2a8b08a7 100644
> >>>>> --- a/Documentation/ABI/testing/sysfs-bus-counter
> >>>>> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> >>>>> @@ -212,6 +212,14 @@ Description:
> >>>>>   		both edges:
> >>>>>   			Any state transition.
> >>>>>  =20
> >>>>> +What:		/sys/bus/counter/devices/counterX/events_queue_size
> >>>>> +KernelVersion:	5.13
> >>>>> +Contact:	linux-iio@vger.kernel.org
> >>>>> +Description:
> >>>>> +		Size of the Counter events queue in number of struct
> >>>>> +		counter_event data structures. The number of elements will be
> >>>>> +		rounded-up to a power of 2.
> >>>>> +
> >>>>>   What:		/sys/bus/counter/devices/counterX/name
> >>>>>   KernelVersion:	5.2
> >>>>>   Contact:	linux-iio@vger.kernel.org
> >>>>> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/cou=
nter-chrdev.c
> >>>>> index 16f02df7f73d..53eea894e13f 100644
> >>>>> --- a/drivers/counter/counter-chrdev.c
> >>>>> +++ b/drivers/counter/counter-chrdev.c
> >>>>> @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_devi=
ce *const counter)
> >>>>>   	cdev_del(&counter->chrdev);
> >>>>>   }
> >>>>>  =20
> >>>>> +int counter_chrdev_realloc_queue(struct counter_device *const coun=
ter,
> >>>>> +				 size_t queue_size)
> >>>>> +{
> >>>>> +	int err;
> >>>>> +	DECLARE_KFIFO_PTR(events, struct counter_event);
> >>>>> +	unsigned long flags;
> >>>>> +
> >>>>> +	/* Allocate new events queue */
> >>>>> +	err =3D kfifo_alloc(&events, queue_size, GFP_ATOMIC);
> >>>>
> >>>> Is there any potential for losing events?
> >>>
> >>> We take the events_list_lock down below so we're safe against missing=
 an
> >>> event, but past events currently unread in the queue will be lost.
> >>>
> >>> Shortening the size of the queue is inherently a destructive process =
if
> >>> we have more events in the current queue than can fit in the new queu=
e.
> >>> Because we a liable to lose some events in such a case, I think it's
> >>> best to keep the behavior of this reallocation consistent and have it
> >>> provide a fresh empty queue every time, as opposed to sometimes dropp=
ing
> >>> events and sometimes not.
> >>>
> >>> I also suspect an actual user would be setting the size of their queue
> >>> to the required amount before they begin watching events, rather than
> >>> adjusting it sporadically during a live operation.
> >>>
> >>
> >> Absolutely agree.   As such I wonder if you are better off enforcing t=
his
> >> behaviour?  If the cdev is open for reading, don't allow the fifo to be
> >> resized.
> >>
> >> Jonathan
> >=20
> > I can't really think of a good reason not to, so let's enforce it: if
> > the cdev is open, then we'll return an EINVAL if the user attempts to
> > resize the queue.
> >=20
> > What is a good way to check for this condition? Should I just call
> > kref_read() and see if it's greater than 1? For example, in
> > counter_chrdev_realloc_queue():
> >=20
> > 	if (kref_read(&counter->dev.kobj.kref) > 1)
> > 		return -EINVAL;
> >=20
> > William Breathitt Gray
> >=20
>=20
> Wouldn't EBUSY make more sense?

Yes, EBUSY would be better here because the operation isn't necessarily
invalid, just unavailable because someone else has the cdev open.

William Breathitt Gray

--/fFfRNp8huk1mEVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA5kFEACgkQhvpINdm7
VJKsqw//XGoYUzTvd45HLoZSMeCbqIqTUfHfIWRim7jSN79aeGhCPltRc08n0OcW
23ZMcoib3ZEvpCheGx76fstTsNvWj+H+uMoB6Finr7ALskttCVzRlbYtYwk8eimX
/XyIpiF2g9I5movwM5+8AZWC5ZKnBCDhTHshzdiT8KUt4UbLSGz13kA0FUCFAk8Y
/fcF76ID+84EcC/fM/0+St6woF3nDUZ//VB50iYqOV5YPZSudDH093jsv+bNWjMr
1Y9sTajY48nSHoMeRjvul1UUxKVsagYprCD3UhlRZFCQhmF4zganDtSOcijCjPUJ
aD4ltmneDf9db1DU7WshKmQxwEyq+14J2Yvm93bowVTzcI2g3mqqDM1iCmk49AYD
tnfYCuRxCPmCRnXF1KHmb6Gfqx3tWAsTN3ArfhJE61cE8nyQxBTCbgWbrN6SC12z
1peklmfYc4aXq2bkn1/dGQvooZ6mXWJNABx7sxCBM/X9rvnBMwrdOIRuCTMFkM7U
UgenrI5Pa2pjKgpkmIQg/5+BnT3fK2q/U4vRGBTmIyxDnQwMEb4CNZPcQb4Wj2zW
9oNxnp00jD+/l41UJyFbwUAqOzgcPbymqzUaP5eOtjk1gYmnXJasVtRn9iKUjg1y
4gt+wYOnQum0khjg/a7uqEhTMEuILLBJy3tnxm6BxnvR5ieEyuY=
=P9yS
-----END PGP SIGNATURE-----

--/fFfRNp8huk1mEVl--

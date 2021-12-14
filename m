Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EC473E7D
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 09:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhLNIlz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 03:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhLNIlz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 03:41:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2DC061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 00:41:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x5so17335726pfr.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uXv/2mYh992YwH73bBYJzEStqwNTVF8aVTbvzmJTr5A=;
        b=knW2rHbVpR2ktb41ww+VHpC8UD1QtEfvrhnuiHfCNd/WBi3g586svQObsZh8xNt/j2
         PFzuNXr+ZNYEQiUKrpw4Wvo0AgVMixyadC4z6c7qCpVr9TgVT9L72ATEMU9eP01zlDbV
         ebOQS0wbIA3pTKe8h2ThWDk4FsRDvpinjZ2G+plIpfxZsZwpU+px8pQ2LrPSqzg8r1ib
         ZFCb8mGRDH9n+R51RRo3jH8WqUcgdg56/ifgoW3QZCjXwVlAlLQZpmxBRmGBKmSrRs4G
         E57UkizjETJ2bKtcJFSn7r9oVl1DSYht1gqEUxl1wJPS8j6fjo+udGadXSs39it2PrA4
         ubaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXv/2mYh992YwH73bBYJzEStqwNTVF8aVTbvzmJTr5A=;
        b=sKGh6tfwS0EilodJkSYNfUAhDFcW6g0kA3qgyTWotkfvmuD53m7z/ECvhnG+vup6v/
         TBkQYF866u1MJcYN2cr45aH93JdpKOKFl7cHw1DgvaX5fbmiw3wTECW02ItChsS9Tth/
         X+J1LBha4lXafmP/IgXz15cZBn6mwQBBBNGoQMyDPvSQEFbwuoCSezD33azfEShIed2P
         aVj+WlcKMINK5WcjBVPS8V+4t0ccSEhm7qUto1iQNf87XJtkLZUBHe3UYTtjSbJA4sU0
         nWWxJrh7ZxnU7yVh0aW52SOIznAhGanwJKdQ63JAnxq/BObEKr1KB2Uofqtb8jKWZbML
         +BsQ==
X-Gm-Message-State: AOAM530LbUxVRoEwA8Q8bBncOPgfewV3IeaNx1h/s1qUIggGQPHI7JOz
        0Dz3veh8OkAo05PIlm+qBA/H5vILyDBn1w==
X-Google-Smtp-Source: ABdhPJxMUNHP+y/REX47szrarCLLK8kWbqE2mg4avf8uCE+R3J51cT9zvenaJbc51HdG3ynni6NZCw==
X-Received: by 2002:a63:230c:: with SMTP id j12mr2772159pgj.579.1639471313369;
        Tue, 14 Dec 2021 00:41:53 -0800 (PST)
Received: from shinobu ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id s17sm14052989pfw.0.2021.12.14.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 00:41:52 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:41:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC] counter: Expand API with a function for an exact
 timestamp
Message-ID: <YbhYzG8OkJ6t88XP@shinobu>
References: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
 <Ybb5B0AI5EWCagOV@shinobu>
 <20211213090448.mpxlxkjwhujsuobe@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tIJo49bN4Yl95RwV"
Content-Disposition: inline
In-Reply-To: <20211213090448.mpxlxkjwhujsuobe@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tIJo49bN4Yl95RwV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 10:04:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello William,
>=20
> On Mon, Dec 13, 2021 at 04:40:55PM +0900, William Breathitt Gray wrote:
> > On Tue, Dec 07, 2021 at 07:10:45PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Some hardware units capture a timestamp for the counted event. To
> > > increase precision add a variant of counter_push_event() that allows
> > > passing this timestamp.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >=20
> > > the difficulty is that the captured timer value is in a unit different
> > > from the one provided by ktime_get_ns(). So maybe some helper functio=
ns
> > > will be needed to convert the local timer value to a ktime timestamp?
> > >=20
> > > So usage would be something like:
> > >=20
> > > 	ktime_now =3D ktime_get_ns();
> > > 	local_now =3D readl(CNT);
> > > 	local_event =3D readl(...);
> > >=20
> > > 	ktime_event =3D ktime_now - (local_now - local_event) * somefactor >=
> someshift;
> > >=20
> > > 	counter_push_event_ts(count, event, channel, ktime_event);
> > >=20
> > > This improves the precision because irq latency doesn't influence
> > > the resulting timestamp. The precision then only depends on the timer
> > > resolution and the delay between ktime_get_ns() and readl(CNT);
> > >=20
> > > I don't have a driver (yet) that makes use of this, the hardware where
> > > this will matter will be stm32mp1.
> >=20
> > Precision logging of counter events was one of the main motivations for
> > the creation of the Counter character device interface, so if we can
> > reduce the jitter of the timestamp by utilizing hardware-provided
> > values, I'm all for it. That being said, we should take care in deciding
> > how to expose this data in the Counter interfaces because not all
> > devices support such functionality and yet users should expect a
> > standard data format to code against.
> >=20
> > Considering this, I think it better to keep the struct counter_event
> > timestamp the way it is right now as ktime_get_ns() so that users have a
> > consistent way to retrieve the timestamp of when the Counter event was
> > pushed to the queue.
>=20
> Isn't it totally irrelevant to userspace when the event was pushed to
> the queue? I claim userspace is only ever interested when the event
> happend and the queue is only an implementation detail of the counter
> framework. The documentation for the timestamp member of struct
> counter_event is
>=20
> 	best estimate of time of event occurrence, in nanoseconds
>=20
> . That looks sane, and following that, the best estimate is the hw
> timestamp?!
>=20
> (Well, if you experience high latencies, the timestamp of the queuing
> might be interesting for debugging, but in this case I'd prefer tracing
> support over exposing implementation details in the API.)

All right your argument makes sense, the primary purpose of this
timestamp is to mark the time the event actually occurred so queue
latency debugging would certainly be secondary to that end. In that
case, providing a more accurate timestamp via a counter_push_event_ts()
call would be preferable if the hardware is capable of doing so.

> > In order to support the hardware-provided
> > timestamp, how about exposing local_event and local_now as Counter
> > extensions? You can set a watches for the local timestamps to log them
> > into the queue with each event, then perform the ktime_event calculation
> > in userspace using the struct counter_event timestamp value.
>=20
> An upside of your suggestion is that calculating the ktime for the event
> isn't done unless userspace needs it. Still I'd prefer to use .timestamp
> for an as-accurate-as-possible information for the event.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

We can additionally expose the local_event and local_now values as
Counter extensions if userspace wants to look into that data more
directly. If the objective is to reduce latency by moving the timestamp
calculation to userspace, we might need to introduce some way to adjust
the "timestamp mode" or similar to disable the automatic calculation
when the user wants to do calculate it themselves in userspace instead.

However, I suspect the effort is not worth it if you're just saving one
or two read operations on the stm32mp1; you might as well just calculate
the ktime automatically for each event and not worry about exposing the
local hardware data to userspace for now until the need arises.

William Breathitt Gray

--tIJo49bN4Yl95RwV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG4WMEACgkQhvpINdm7
VJKZYQ/+LvyOW/VjJFtioiaDeaKNIWxcPpEdCxjg+Bvi3Y+2kmEmPv3mg7wctduy
fRKFLhGf7gmSVQlV3ieaULVRoOJoF30lNrJUi1UBmh7nPFjMb95OSN20Ui8E0vOo
nZ2RjhpPxVkoZ7OPWhBoJ58ZTTxxgf+ARL11xXFbowPSKhQZShhquH2zRoSB70PL
4+c81HRCn7PdQKSXSXADYtC2be+vv1SwYoSCByOdr95k381aVH2fJVmaUOGsg3q9
Jh0u6V4S85pWgIQmJTjMoIyyJPqU2TqXV2+ihu4T5meK6f9Qdb6HoorIeUp1WjT+
7XevjHsxN7yRGHYaqXx/dnOKiLbJXB6RfdpAZiNQrfAc5sKQ80rYF7JsveeW5Xd8
OgfwUcmnCwA7SmPwZ+g5LAOywA2UNTu1pKOlzaSdqmnKobSZDo/3i2SqSpwfuwSP
XhusjT1lnbGQd29nRsU4Fy51AStMiAfQoX18rEfydNwI+iiyN5r31dP7hTKUsvNI
tW/Kj1CrjbL8Tb9WjtTPwuXk8Z8eE0vDJUwr3911uHHt1VpeVabmFB+4vScl1Wh1
eCB5HFOlMYJN/a5ED0Sv5Ah0s5xWBUaqTTVkl/n6fTrJ97cUzHDo7j6cRMBcXDNC
AtzkLeh2nMuW+3FTQTkeJR0FM8D6K0WGXlQpQfZHFQkOvXTXGG8=
=zx7K
-----END PGP SIGNATURE-----

--tIJo49bN4Yl95RwV--

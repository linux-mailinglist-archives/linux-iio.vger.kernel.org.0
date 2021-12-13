Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5594721DA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 08:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhLMHlC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 02:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhLMHlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Dec 2021 02:41:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA31CC06173F
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 23:41:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so12583291pjb.5
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0u6LajO1p3J2tBBgw4q+iQzb5TbaG9GJY9/vRjktGg=;
        b=dqPpMGHn34s3kxInI+hQm3HPF7rmHq+qbJiOUrkIUDZGVFQsVOsI5yUEfyJOIHAjuV
         ycVSle8ZotXLF3uN3aokQUpJ26rZ485JV14Yulc2PPpZa4qPUxfYqtFxFjmJ0SEy8P/1
         yVWSa6ZjWv4fjTaToPL1tVh5ZMGdbUdyR7oduZ/MMduvjDclGmwdOX/ZKm+Nk1awfFFA
         cupmTDfrLSEP/r+W5zIECA0Xm0aApYLnhj/kDg1NhP5UUXJAZJ38TAPgPruyuy6+yOpX
         lnlqg26aWUeT8Z4D9ML40XcU4ZMueMarfFU7kdPzCWR3pJdb82eqwWiYiPhjl7jCQH07
         ajwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0u6LajO1p3J2tBBgw4q+iQzb5TbaG9GJY9/vRjktGg=;
        b=d9+Db32n+4yXFMlkqMXsXG2mGmXRB8s75rWrHJWtY9HrIdK946z4h67wjW6xFFoxGo
         uJdgm45PjrNGNySKuLTG/gzryegx0uTehQJBMvw6orHKi9SNhfNrba10brVU3IT8mKKQ
         gFhfa2j2Oif9+hkTJjKic64ADnPqn7uanwzuhtBMsavDcB38K88m//rXqmcIDY78cNrZ
         le55RzSNRbpVoSa96SLnIgxNMSTr5afLu13XlRYIg2clf7sTFFbmVlieys5vI0gFVxeh
         Oaq5y3Y4nlX5dDQAYlz/eNlyZIl1M5lqWQU6tK6b6+8tT3qoo4ZJYpZ8BcV/4p4AXZIi
         YlCg==
X-Gm-Message-State: AOAM531sqCBAeCWRb0nwG7xGeukQG1W7ypbgkcb63X4SOtl9aTDs4NA7
        KEF0JFLSAslO7bcdI+NiVwcGPirbGzo=
X-Google-Smtp-Source: ABdhPJwN1yThPcr4+u74JOq9YcpFFiThq9yWs+5piNSO4dq077WW2ignhoElxbhNY8vH/7EO78GE0Q==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr42563964pjy.139.1639381261131;
        Sun, 12 Dec 2021 23:41:01 -0800 (PST)
Received: from shinobu ([37.120.154.46])
        by smtp.gmail.com with ESMTPSA id j7sm12154261pfc.74.2021.12.12.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:41:00 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:40:55 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC] counter: Expand API with a function for an exact
 timestamp
Message-ID: <Ybb5B0AI5EWCagOV@shinobu>
References: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wypLWqPf8AogrEkh"
Content-Disposition: inline
In-Reply-To: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wypLWqPf8AogrEkh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 07:10:45PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Some hardware units capture a timestamp for the counted event. To
> increase precision add a variant of counter_push_event() that allows
> passing this timestamp.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> the difficulty is that the captured timer value is in a unit different
> from the one provided by ktime_get_ns(). So maybe some helper functions
> will be needed to convert the local timer value to a ktime timestamp?
>=20
> So usage would be something like:
>=20
> 	ktime_now =3D ktime_get_ns();
> 	local_now =3D readl(CNT);
> 	local_event =3D readl(...);
>=20
> 	ktime_event =3D ktime_now - (local_now - local_event) * somefactor >> so=
meshift;
>=20
> 	counter_push_event_ts(count, event, channel, ktime_event);
>=20
> This improves the precision because irq latency doesn't influence
> the resulting timestamp. The precision then only depends on the timer
> resolution and the delay between ktime_get_ns() and readl(CNT);
>=20
> I don't have a driver (yet) that makes use of this, the hardware where
> this will matter will be stm32mp1.
>=20
> Best regards
> Uwe

Hello Uwe,

Precision logging of counter events was one of the main motivations for
the creation of the Counter character device interface, so if we can
reduce the jitter of the timestamp by utilizing hardware-provided
values, I'm all for it. That being said, we should take care in deciding
how to expose this data in the Counter interfaces because not all
devices support such functionality and yet users should expect a
standard data format to code against.

Considering this, I think it better to keep the struct counter_event
timestamp the way it is right now as ktime_get_ns() so that users have a
consistent way to retrieve the timestamp of when the Counter event was
pushed to the queue. In order to support the hardware-provided
timestamp, how about exposing local_event and local_now as Counter
extensions? You can set a watches for the local timestamps to log them
into the queue with each event, then perform the ktime_event calculation
in userspace using the struct counter_event timestamp value.

William Breathitt Gray

>=20
>  drivers/counter/counter-chrdev.c | 25 +++++++++++++++++++++----
>  include/linux/counter.h          |  2 ++
>  2 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-c=
hrdev.c
> index b7c62f957a6a..6381f7246d59 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -521,16 +521,17 @@ static int counter_get_data(struct counter_device *=
const counter,
>  }
> =20
>  /**
> - * counter_push_event - queue event for userspace reading
> + * counter_push_event_ts - queue event with a timestamp for userspace re=
ading
>   * @counter:	pointer to Counter structure
>   * @event:	triggered event
>   * @channel:	event channel
> + * @timestamp:	the ktime when the event occurred
>   *
>   * Note: If no one is watching for the respective event, it is silently
>   * discarded.
>   */
> -void counter_push_event(struct counter_device *const counter, const u8 e=
vent,
> -			const u8 channel)
> +void counter_push_event_ts(struct counter_device *const counter, const u=
8 event,
> +			   const u8 channel, u64 timestamp)
>  {
>  	struct counter_event ev;
>  	unsigned int copied =3D 0;
> @@ -538,7 +539,7 @@ void counter_push_event(struct counter_device *const =
counter, const u8 event,
>  	struct counter_event_node *event_node;
>  	struct counter_comp_node *comp_node;
> =20
> -	ev.timestamp =3D ktime_get_ns();
> +	ev.timestamp =3D timestamp;
>  	ev.watch.event =3D event;
>  	ev.watch.channel =3D channel;
> =20
> @@ -570,4 +571,20 @@ void counter_push_event(struct counter_device *const=
 counter, const u8 event,
>  	if (copied)
>  		wake_up_poll(&counter->events_wait, EPOLLIN);
>  }
> +EXPORT_SYMBOL_GPL(counter_push_event_ts);
> +
> +/**
> + * counter_push_event - queue event for userspace reading
> + * @counter:	pointer to Counter structure
> + * @event:	triggered event
> + * @channel:	event channel
> + *
> + * Note: If no one is watching for the respective event, it is silently
> + * discarded.
> + */
> +void counter_push_event(struct counter_device *const counter, const u8 e=
vent,
> +			const u8 channel)
> +{
> +	counter_push_event_ts(counter, event, channel, ktime_get_ns());
> +}
>  EXPORT_SYMBOL_GPL(counter_push_event);
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index b7d0a00a61cf..596e7e58e463 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -333,6 +333,8 @@ int counter_register(struct counter_device *const cou=
nter);
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
>  			  struct counter_device *const counter);
> +void counter_push_event_ts(struct counter_device *const counter, const u=
8 event,
> +			   const u8 channel, u64 timestamp)
>  void counter_push_event(struct counter_device *const counter, const u8 e=
vent,
>  			const u8 channel);
> =20
> --=20
> 2.30.2
>=20

--wypLWqPf8AogrEkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG2+PwACgkQhvpINdm7
VJLW9w//SKOrb+VkbQOTPMajcu96zqENqHEtaI2NKcoJ92I5OzSj7AWyzzq4GLc8
P/S4qMadjPVl129crYPyyt9/1ut+yhZFE/i4uDZhKv57Ut7LQdDBd+HZLPjqRUdp
QnkfQACro13tJrDvf3gShfxvIeGvWyNnMo57r9xKzfDdhVKnnFOKrhdeRXBv8cY/
MITvb83WvKG/cKhc6bhqUTkNWGMjGBlkUPSJUVx34EdFBAwl+tcvVae1YefEyrU0
O7YueHxTFl1LaZQW7begJE6jNjph/dSg7WkRv7AoFIEspBIeO2ZKBX4uobb2DW1F
qM5espThElOkrc8j2hkFTk+vditaeKiBfR6qIEqAcd/AbtU3+ZaBOWwSpfxAq1Gk
aRZjBvGsfw60OmrQ3e0jIs0vY0/KpYbapx2B4O3XXjHKNeYdNxjXqEvNJlygmkhk
+Ok0LEwPZFGna2YhVOjaUREL5qd4BqbWDCTWWTKVpSPTId3PlbpjjSPvJW9w6txK
+YXoZil8V3MZeal+ycdpXqIxfCTn/YAA17oPu2rP9ul+gCPCNKZLa0Xr0FxlSvIe
JhvcNwHleuERJ3t79vm1Sg/amBAwYxXXgPp55qIEhYJsBYxabl5iRkj4jx1AE9SY
WkYI22RPnTxp2exJ7BeDGIiG1epAnrJenpAwBE40z9aSnqPAp/A=
=UEH6
-----END PGP SIGNATURE-----

--wypLWqPf8AogrEkh--

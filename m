Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EF431303
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJRJQo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJRJQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 05:16:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7156C061745;
        Mon, 18 Oct 2021 02:14:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t7so1038998pgl.9;
        Mon, 18 Oct 2021 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kYLCRGYQwbvZDOnSMjJhz+H+rlEx68v/8v6wqX2AY0=;
        b=dvoDnkfrFi695/w3GV3ztggLevA1NjQw+AfPFlMz9okWVLbIViozNfMrgN/MfmOez/
         inF4tmuIV8FsjIQgJFMpKFeq05p1tEkpFvgguTazE3FOyj7YiyKJk7ktqqoLnkTmV8li
         QZaoup1UscL9iT8mGZf7BOi+qBgBHjTbBlkFKlO/J2qhN1flU5WeqvStHh43nXbtLjRY
         ksnliKuDxLI7sKdQUkBQzOZjVqqry7Sdgep0fmRn4jmtCxutNmfhzyckRclvzxu/oj6X
         gQAB2fN9eE9EcvLnGrIlWMPUgEm7fnK9gYug5g6pfVGKP5fiUxxHto8fzzSEFFAWH4kB
         qq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kYLCRGYQwbvZDOnSMjJhz+H+rlEx68v/8v6wqX2AY0=;
        b=VSctZA90II9r2FmdzAKgvsgeep7LCVo36DjWH0xQKqjtnMH7yvuPEdwwibyj7FbB3z
         vTfK3zCh63qz5vckmsRxVuo6pHSntRYq4Vj7uBx8PpLkCIKgz6dlP3z8Y8fzGfQkEwdu
         j/1ohPqfLPBpmJs6qc1zyQrsG7+lFDImI0+EnBpfx6VBAOTsyK7kzkM8U3IvLuKbcK/9
         BnopACoX1zwmTbYyo1hLVXUIHTXQ28Y9+7K+D1XCp8RkhoIr1NJO4xpTDlgNF2gh6dgM
         N6BNL6D/lIqnThuoONiT/MYgtxtDYL4RhWEt/E0cCkJhdgoUH+X+LObmFxgRExZUpJPu
         ATsg==
X-Gm-Message-State: AOAM530D20ZUQt1W4wnPKR0Y22VhiTYQsEICsZvfULVAlOYNzxKgESoT
        25NyB8svrZXIDUKDWns+6Pw=
X-Google-Smtp-Source: ABdhPJzzIbns+tiUcDIl+Ymn4ss4NuQUDPkox8w4dXKcXLtUZqXTOND0zjW63nJu7ZUwbksIhtCUDw==
X-Received: by 2002:a62:dd15:0:b0:44c:61de:537 with SMTP id w21-20020a62dd15000000b0044c61de0537mr27378560pff.57.1634548469287;
        Mon, 18 Oct 2021 02:14:29 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id j6sm12070717pgq.0.2021.10.18.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:14:28 -0700 (PDT)
Date:   Mon, 18 Oct 2021 18:14:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW0673OckeCY6Qs/@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0He9SiCcq9UvyWAQ"
Content-Disposition: inline
In-Reply-To: <20211017185521.3468640-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0He9SiCcq9UvyWAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> This removes the chrdev_lock from the counter subsystem. This was
> intended to prevent opening the chrdev more than once. However, this
> doesn't work in practice since userspace can duplicate file descriptors
> and pass file descriptors to other processes. Since this protection
> can't be relied on, it is best to just remove it.
>=20
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: David Lechner <david@lechnology.com>

Hi David,

If userspace can bypass this protection then we might as well remove the
code as moot. In agree in principle to this change, but I do have some
comments inline below.

> ---
>  drivers/counter/counter-chrdev.c |  6 ------
>  drivers/counter/counter-sysfs.c  | 13 +++----------
>  include/linux/counter.h          |  7 -------
>  3 files changed, 3 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-c=
hrdev.c
> index 967c94ae95bb..b747dc81cfc6 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -384,10 +384,6 @@ static int counter_chrdev_open(struct inode *inode, =
struct file *filp)
>  							    typeof(*counter),
>  							    chrdev);
> =20
> -	/* Ensure chrdev is not opened more than 1 at a time */
> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> -		return -EBUSY;
> -
>  	get_device(&counter->dev);
>  	filp->private_data =3D counter;
> =20
> @@ -419,7 +415,6 @@ static int counter_chrdev_release(struct inode *inode=
, struct file *filp)
>  	mutex_unlock(&counter->ops_exist_lock);
> =20
>  	put_device(&counter->dev);
> -	atomic_dec(&counter->chrdev_lock);
> =20
>  	return ret;
>  }
> @@ -445,7 +440,6 @@ int counter_chrdev_add(struct counter_device *const c=
ounter)
>  	mutex_init(&counter->events_lock);
> =20
>  	/* Initialize character device */

We can remove this comment because the purpose of calling cdev_init() is
obvious enough from the name.

> -	atomic_set(&counter->chrdev_lock, 0);
>  	cdev_init(&counter->chrdev, &counter_fops);
> =20
>  	/* Allocate Counter events queue */
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sy=
sfs.c
> index 1ccd771da25f..7bf8882ff54d 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struct c=
ounter_device *counter,
>  					   u64 val)
>  {
>  	DECLARE_KFIFO_PTR(events, struct counter_event);
> -	int err =3D 0;
> -
> -	/* Ensure chrdev is not opened more than 1 at a time */
> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> -		return -EBUSY;
> +	int err;
> =20
>  	/* Allocate new events queue */
>  	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
>  	if (err)
> -		goto exit_early;
> +		return err;
> =20
>  	/* Swap in new events queue */
>  	kfifo_free(&counter->events);
>  	counter->events.kfifo =3D events.kfifo;

Do we need to hold the events_lock mutex here for this swap in case
counter_chrdev_read() is in the middle of reading the kfifo to
userspace, or do the kfifo macros already protect us from a race
condition here?

William Breathitt Gray

> =20
> -exit_early:
> -	atomic_dec(&counter->chrdev_lock);
> -
> -	return err;
> +	return 0;
>  }
> =20
>  static struct counter_comp counter_num_signals_comp =3D
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 22b14a552b1d..0fd99e255a50 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -297,7 +297,6 @@ struct counter_ops {
>   * @events:		queue of detected Counter events
>   * @events_wait:	wait queue to allow blocking reads of Counter events
>   * @events_lock:	lock to protect Counter events queue read operations
> - * @chrdev_lock:	lock to limit chrdev to a single open at a time
>   * @ops_exist_lock:	lock to prevent use during removal
>   */
>  struct counter_device {
> @@ -325,12 +324,6 @@ struct counter_device {
>  	DECLARE_KFIFO_PTR(events, struct counter_event);
>  	wait_queue_head_t events_wait;
>  	struct mutex events_lock;
> -	/*
> -	 * chrdev_lock is locked by counter_chrdev_open() and unlocked by
> -	 * counter_chrdev_release(), so a mutex is not possible here because
> -	 * chrdev_lock will invariably be held when returning to user space
> -	 */
> -	atomic_t chrdev_lock;
>  	struct mutex ops_exist_lock;
>  };
> =20
> --=20
> 2.25.1
>=20

--0He9SiCcq9UvyWAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFtOu8ACgkQhvpINdm7
VJLXixAAoJEPgchTPO+v1oAOBslnbNaY7WKHrzMGS3jaLiM75ytFbhHjvHYIFJlr
I0qlDdKOCHurtpYoOYfUYuyfoxu3fopgi15bXB6GCKgedsZrgBiCh3lWFH2cxIRJ
a/9UQDg/RQez5CFekUGUZLmED4HgB4I9rMiUSSMU6T6ryKKynVDnO983D9mqpzhc
wqJ4Iuh+8Kgplvil5nliQN2KEc7tAwmTWYE7wIM/eO9tmoWe2eUBlcMvrcka71Bk
4hVheZvqn+TgpKqHjDsrfNW9mOUnwM/FyA/sUlsLkDhqTb+IA/bh2Su1zSkioYdc
QQcNGL7oaA9bg7JtNGc9vVdzF97VxG6XUGaaThV0p3IL8HxxhJx3b1ckNvO+T8/L
wmui7M+RBqHVDEGtx1fT6hxT3N+chB/bIzl0aqn1I1/ttMLWIVUeIij6aMKCxCKD
L/t2PnEWnAOHGC42CakF0bRRxHzBnyzgOUo1rmd9ME7L4xLVRk1eVRcy1prYpKR7
qRoIE4wXs00zrNSj8emzXwMaRKuPsT2DY4ZmLGLJHmnt/n0OO8pPr1mW1nvN4E0N
u/kfXjoDmLDtZWKwYbrS+MLRnVaH6P7blxYnoFiHDOqpf0d0d6220daAS9BLqm+H
/XjjDr1Wvwxb3ZVNHrvW20HweB1Kywo6WMDo0G+fNGotHKbg0hI=
=FITG
-----END PGP SIGNATURE-----

--0He9SiCcq9UvyWAQ--

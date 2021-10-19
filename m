Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D462432EA7
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJSGz2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 02:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJSGz2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 02:55:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEBC06161C;
        Mon, 18 Oct 2021 23:53:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so1276023pjb.2;
        Mon, 18 Oct 2021 23:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMS0KPxGVgnD0a+CIxhmnn7fpkZpY/lfr9XbohQRjfg=;
        b=lqsZawLAdxbOZgZ+pZK0pQ67Dso5/C3RV8ch673zfyJDWuyt5VS4Iy+5N/KxdkZ1uF
         ohpNayQT/w9PwlQkvhjM/79FjoGD3N7ZexqQJ7pG9HnS+YPArWipN5ENR7cQjDeY+9Zd
         x1pD068rya5wl2F10xP8f47C7VetwGwxN+0RtZfN4PYd07e9Cmf+7vmnb0vIdzTOjfdG
         3k6SdiCM8nV//1c7GXWvHD3UJ+qumXLOpp/4nD4lqfXqvWx8O4foqiVc/D/UTFgMsByb
         OjZcwkl+sL1SuHoNM0Bwom5B+ek8UX31vye9l1LoLDLCZ3WzMSmA+srcHWKbUqmDD75X
         SdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMS0KPxGVgnD0a+CIxhmnn7fpkZpY/lfr9XbohQRjfg=;
        b=4agw6Z2ynsy6x/UbIfuuphofKi6Q01t74FJ2w4QEJeeh59Hz8JgVA7JI2RDSvsyouQ
         aWB5Jtzoo61dz29E7S3bL5CbflXTe2sG/kPiLZjhYeYXYxqW0nDGAG9lh6A2GNEMnYmT
         dmx6bDSSfMFJAT3d1R25jPrs3QNeDvmGd5g83nx8pOThWhq0HNd2BZ80sOgm0IMs6r9D
         KV9Dxtf9AKFQmVs+PrkOFzz9UHAemFKQ1wIq5hrNPtsl0feSjoSe5osbGQ/3Ow5h0s/9
         V2hqE5iuhbgUy+gh0ZCLTTuDBlTG9n+mT+TQMJGh5TaqRLsJInV2s8rLyu6MFbA7twaI
         TImg==
X-Gm-Message-State: AOAM532oAU8VsXYNbS83Fjo5Pj5fgT0V7NS0fJ8VzAedvo0PFrrSdkhW
        Ut8khBaCPHEoCIfo9tF341Y=
X-Google-Smtp-Source: ABdhPJxmJ8fekmo80VwtLFDGdMibZKv+KSr9vVvps23YJVTSPzoJCiTkI0YOjoI7NBjVCWmhFDddjw==
X-Received: by 2002:a17:90a:7d0a:: with SMTP id g10mr4532165pjl.73.1634626395287;
        Mon, 18 Oct 2021 23:53:15 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id d15sm16619311pfu.12.2021.10.18.23.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 23:53:14 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:53:08 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW5rVLrbrVVJ75SY@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+K/4FCKEYwZGzrL"
Content-Disposition: inline
In-Reply-To: <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--C+K/4FCKEYwZGzrL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> >> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter=
-sysfs.c
> >> index 1ccd771da25f..7bf8882ff54d 100644
> >> --- a/drivers/counter/counter-sysfs.c
> >> +++ b/drivers/counter/counter-sysfs.c
> >> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struc=
t counter_device *counter,
> >>   					   u64 val)
> >>   {
> >>   	DECLARE_KFIFO_PTR(events, struct counter_event);
> >> -	int err =3D 0;
> >> -
> >> -	/* Ensure chrdev is not opened more than 1 at a time */
> >> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> >> -		return -EBUSY;
> >> +	int err;
> >>  =20
> >>   	/* Allocate new events queue */
> >>   	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
> >>   	if (err)
> >> -		goto exit_early;
> >> +		return err;
> >>  =20
> >>   	/* Swap in new events queue */
> >>   	kfifo_free(&counter->events);
> >>   	counter->events.kfifo =3D events.kfifo;
> >=20
> > Do we need to hold the events_lock mutex here for this swap in case
> > counter_chrdev_read() is in the middle of reading the kfifo to
> > userspace, or do the kfifo macros already protect us from a race
> > condition here?
> >=20
> Another possibility might be to disallow changing the size while
> events are enabled. Otherwise, we also need to protect against
> write after free.
>=20
> I considered this:
>=20
> 	swap(counter->events.kfifo, events.kfifo);
> 	kfifo_free(&events);
>=20
> But I'm not sure that would be safe enough.

I think it depends on whether it's safe to call kfifo_free() while other
kfifo_*() calls are executing. I suspect it is not safe because I don't
think kfifo_free() waits until all kfifo read/write operations are
finished before freeing -- but if I'm wrong here please let me know.

Because of that, will need to hold the counter->events_lock afterall so
that we don't modify the events fifo while a kfifo read/write is going
on, lest we suffer an address fault. This can happen regardless of
whether you swap before or after the kfifo_free() because the old fifo
address could still be in use within those uncompleted kfifo_*() calls
if they were called before the swap but don't complete before the
kfifo_free().

So we have a problem now that I think you have already noticed: the
kfifo_in() call in counter_push_events() also needs protection, but it's
executing within an interrupt context so we can't try to lock a mutex
lest we end up sleeping.

One option we have is as you suggested: we disallow changing size while
events are enabled. However, that will require us to keep track of when
events are disabled and implement a spinlock to ensure that we don't
disable events in the middle of a kfifo_in().

Alternatively, we could change events_lock to a spinlock and use it to
protect all these operations on the counter->events fifo. Would this
alternative be a better option so that we avoid creating another
separate lock?

As a side note, you can also remove the atomic.h includes from these
files now as well because we won't be working with an atomic_t anymore.

William Breathitt Gray

--C+K/4FCKEYwZGzrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFua0kACgkQhvpINdm7
VJL86w//SlZer095FG9pRoX+CBucmT51djupq6qVoMVeyP5z2RQN55oo1VTD3//F
8+ZgnwbyS4UBDa2U9Py6hzkA30fjtQdi2avzHR6xGtyaWFeYIFehmjtCw5OrVu2G
AREfHSui1wlW5wcGSl7uXnSJkWo+ttPf1z77aWyZVgl/cDBgifUwddcdEbbpHasv
Thac8fLe5OaeW9Ic/I+/3mycOHfG1bc3q7SrLlB1+OOgxcr6QtruPHghVppXTWEm
NBJDND/lzJaglO12pmi6/bG2uYhSB8AI6iS87cIwcVRo7wknUE4qzByfBVA77Fck
sMBlX3eqKn0EAizAmkpcoG4XYMfCUNQ4Loe9OM6Gtp4izeMmIWwbR2o45NW0tHyt
YUE+armrB7tl+RLaRbmQzglIrgDRQT1lg8YBBI+OLW9w4YUKktyAszH0YbF1vgFR
TWK9sUQpIJVQ7bW2agh5TKPBZX67VYIAMF1LauyaOcYzG9ysiulwSZQQzp90Jg92
XdZOctkjIEP7PeFeTPeTLJcceiyZaw50Dq4OY5hrlvAKXEdk2vgdXtEzr1h8rfVs
GhJ1ndYV4hos7yjs+RVlOfATZLkXMXKvogZ2iyqeY7Aej0TWyK5s0PiuDLLzIMco
MNlxoqdEEaVUbJE6ZZF7zr8zXAIW3QbwhLonhAgJOOcRqIGQ5OA=
=gcuP
-----END PGP SIGNATURE-----

--C+K/4FCKEYwZGzrL--

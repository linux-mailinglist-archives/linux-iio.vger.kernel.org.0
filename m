Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395CD432A8E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 01:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJRX6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRX6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 19:58:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032DC06161C;
        Mon, 18 Oct 2021 16:56:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so1232826pjb.5;
        Mon, 18 Oct 2021 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCQ4GlIZMf0OeQdKaOI0Ryzlg2e9xalfBTKxlGb2CDY=;
        b=dWF4g/D4FeOGCP9RwWe9ibOb+CqGp3AbSbosCBtsjrkU6Ym+7tTzfjlTzJtOVKCYGo
         UBqdDPElgL9ht6Mmwu847MddtgPTBUyGHOZu+EgXVAz6IwB9Q9rAczmPDbnWcPPD7qpZ
         RAWQ4hKBZUrUgzioMd+pMLWbhn7Pf8j1NrpyPj5uL+7qGqphz4bMDdOKg29UPOIPeRki
         OY0jAE+GJdV/6dFQNzh/TQ8DLHHJsoKyI3XXVbU+/+3Ul3UUpHCtvRq3unhqizMi68UO
         V7cWDEnzwDKll0V4i5lliTtJa6Etv9zMpcuVK5jRvP2uKEvfXePT1ogZ1BIhKJU9Amel
         5N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCQ4GlIZMf0OeQdKaOI0Ryzlg2e9xalfBTKxlGb2CDY=;
        b=p8ke4LK4hlfLE5Ft//+ek/3Y4zbqk6KOlyFv2RieifqXPfcAnT0hkPDScg1DF4J0Sq
         n0yI5jH5YK/uhrZf8CCHe94PaBDOxbHLNungwFQAlPzWaEho/RSoLfkvVdhi7B038FmP
         swHQQrRCqPHTTv8BA1SJKxSIgQa9Xf3Q+epmWjhqEWPUz4bM1jjL8zro9fOw1dUY94y8
         DHgOiDFr53ITC8Hzxq0BbQAmcBOpIXJjO1mMeAFnON6dDtRe14wTo8p9KgMRpwRTx+aH
         AOsrc6E19E0zbkK99sSpze9NLKW7/i3P/QBKg0TR2p8s0wgXE8hqDgZHAju8DWb/Om7C
         nGVA==
X-Gm-Message-State: AOAM531x/KcymjX88lK3llGAazGjchLzvv0ZoVc6P3iBGmoDMjziPxPc
        0Hy0yQnZep531FLF1TXI+IOJOqMWMWc=
X-Google-Smtp-Source: ABdhPJxLe6AyJ3leYFjWFK3SNmetjh1gEOluU2spUU9eTqkuJ42UR92A1fnZMEG9Ilr2zGVLffXguQ==
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr2416955pjl.150.1634601386546;
        Mon, 18 Oct 2021 16:56:26 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id t9sm523364pjm.36.2021.10.18.16.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:56:25 -0700 (PDT)
Date:   Tue, 19 Oct 2021 08:56:21 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW4JpTaj20j9Flus@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0PVYT/GCKAnjN9@kroah.com>
 <YW03PSmpMkMVnHdp@shinobu>
 <YW06rLixA2Uush+n@kroah.com>
 <YW1Dl7ylRqyPxH2c@shinobu>
 <6aa0e966-478c-4233-fe9b-d16c3c9d4989@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b58fb5KMbhxV/18m"
Content-Disposition: inline
In-Reply-To: <6aa0e966-478c-4233-fe9b-d16c3c9d4989@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--b58fb5KMbhxV/18m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 11:14:15AM -0500, David Lechner wrote:
> On 10/18/21 4:51 AM, William Breathitt Gray wrote:
> > On Mon, Oct 18, 2021 at 11:13:16AM +0200, Greg KH wrote:
> >> On Mon, Oct 18, 2021 at 05:58:37PM +0900, William Breathitt Gray wrote:
> >>> On Mon, Oct 18, 2021 at 08:08:21AM +0200, Greg KH wrote:
> >>>> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> >>>>> This removes the chrdev_lock from the counter subsystem. This was
> >>>>> intended to prevent opening the chrdev more than once. However, this
> >>>>> doesn't work in practice since userspace can duplicate file descrip=
tors
> >>>>> and pass file descriptors to other processes. Since this protection
> >>>>> can't be relied on, it is best to just remove it.
> >>>>
> >>>> Much better, thanks!
> >>>>
> >>>> One remaining question:
> >>>>
> >>>>> --- a/include/linux/counter.h
> >>>>> +++ b/include/linux/counter.h
> >>>>> @@ -297,7 +297,6 @@ struct counter_ops {
> >>>>>    * @events:		queue of detected Counter events
> >>>>>    * @events_wait:	wait queue to allow blocking reads of Counter ev=
ents
> >>>>>    * @events_lock:	lock to protect Counter events queue read operat=
ions
> >>>>> - * @chrdev_lock:	lock to limit chrdev to a single open at a time
> >>>>>    * @ops_exist_lock:	lock to prevent use during removal
> >>>>
> >>>> Why do you still need 2 locks for the same structure?
> >>>>
> >>>> thanks,
> >>>>
> >>>> greg k-h
> >>>
> >>> Originally there was only the events_lock mutex. Initially I tried us=
ing
> >>> it to also limit the chrdev to a single open, but then came across a
> >>> "lock held when returning to user space" warning:
> >>> https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#=
m6072133d418d598a5f368bb942c945e46cfab9a5
> >>>
> >>> Instead of losing the benefits of a mutex lock for protecting the
> >>> events, I ultimately implemented the chrdev_lock separately as an
> >>> atomic_t. If the chrdev_lock is removed, then we'll use events_lock
> >>> solely from now on for this structure.
> >>
> >> chrdev_lock should be removed, it doesn't really do what you think it
> >> does, as per the thread yesterday :)
> >>
> >> So does this mean you can also drop the ops_exist_lock?
> >>
> >> thanks,
> >>
> >> greg k-h
> >=20
> > When counter_unregister is called, the ops member is set to NULL to
> > indicate that the driver will be removed and that no new device
> > operations should occur (because the ops callbacks will no longer be
> > valid). The ops_exist_lock is used to allow existing ops callback
> > dereferences to complete before the driver is removed so that we do not
> > suffer a page fault.
> >=20
> > I don't believe we can remove this protection (or can we?) but perhaps
> > we can merge the three mutex locks (n_events_list_lock, events_lock, and
> > ops_exist_lock) into a single "counter_lock" that handles all mutex
> > locking for this structure.
> >=20
>=20
> The different mutexes protect individual parts of the counter struct
> rather than the struct as a whole (a linked list, kfifo reads, and
> callback ops), so I think it makes the code clearer having individual
> mutexes for each rather than having a global mutex for unrelated
> actions.

That's a fair point. Because these operations are independent of each
other, keeping the mutexes separate would allow users to configure the
next events watch list without necessarily stalling the current read()
of events. I doubt the difference is significant, but if the purpose of
these locks are well enough defined then independent mutex locks may not
be a problem.

William Breathitt Gray

--b58fb5KMbhxV/18m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFuCZoACgkQhvpINdm7
VJJKMQ//fTXJ04FMXKrHomD7DqIgMlq+w8uC1Mcr97R3oNBg7r6HLN321eWPz/rn
4bC1V3ww9dj3WzMOMtE7dKILJyCCmnbue/+1v694Phj3DppsZ/bN8RLo2c0K5ObF
YS6evT9LZ/frqDOMAYm0b0g6HRxg9GF1A31Td1bwK2YmN4h1mfA351n+0sqxScF0
r7qs8T9fPdB9YngI7VwIe0WAMT1C1rjl5rCVTus3Y+ojQa8Xd9Ua3OgdNOlPiAcN
l62tl4R58BFztmsqtY4DtOabeYV85n8bBnUBpF7bcptpUcB9elU2imhNYXUcUxnT
6h1rbhn+bNdq0ClVZmyAD22JVg9RyAl2iJ8XvlAg3t5CGM9N6rFMnXpH+W6YiI7q
KXYA+JBksyAfuifhsv89AogTj3maf0vzrifz6UkkYLcBmkzed9h+qDHyBGW7qirI
TApiRqQMMMV/wd6h0U5Ai5C5O4dteOnOeNhYxjul+Xm2G87bFWXtPUT4xPWkkVb1
mxV9+K6YuX/ny4MH+55B1a0oa6o2hpfga09YSeSkuX2Ci6hq/K1ZEgHd+XMNptlz
PCl+ezqsxz7FQUoi5+ne3/8+HC9qI3zk049m3GrIDuMh27E0M6Ccj5zpT+JociXs
XnPPCg8RPThi7EUEdVB5zEWTdAg3IPsV7XVLNAALHN1CyQWsSac=
=zW9x
-----END PGP SIGNATURE-----

--b58fb5KMbhxV/18m--

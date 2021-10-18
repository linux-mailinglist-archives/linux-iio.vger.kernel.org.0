Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2E4312A2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhJRJA7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJA7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 05:00:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F203C06161C;
        Mon, 18 Oct 2021 01:58:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so10733156plk.10;
        Mon, 18 Oct 2021 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJdBl2v/UZ98xFp4khbE/HvsuDRBwxaaXrlQoB5bGPg=;
        b=jsDEQjUaKvrRX/d6+Um76EoNfKi+RXm44ybGOzrXkxb91CZHLGx8mXHdm46gRfFAs0
         7j1pnQ/ZcAt1FFahd227FagRYRsWMsUwIv3h1NB/tGaALT2B5Yh2nWS7ame4eyjz3QX0
         cORtEWKxFrRooYyDFgg2BGN2UtaSdx59s6ao9KairgGRfz8NQSO3czUl5AS//OBVlWFh
         D6AsUeqEzpVuUULIPUObOQRPAKLDzlcg2pTC/b3MJECh0QmxCISE+lodCMVviDXyNZMX
         JYISwaI1XOkwm9IrHvvwHL6zqHbLIOLZdBdG2nj/cTyu13PQORh1izo5MIeGUvnlopHS
         tCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJdBl2v/UZ98xFp4khbE/HvsuDRBwxaaXrlQoB5bGPg=;
        b=WorLCVXOnvgQntExOhIfymaaQHlQt94wEz2jAf3Pq3oBHL2/loRDVGq++1JPrCLOp/
         texPzIEui9tl4lX3eDE83bwDWtYunv/yih78SCEQhF3nwLnu+Q/An8VPkIDHckItfJmY
         sXvgOecpNbFJ19IBjnwev3ZMn2Zj6xGzZiT5eTwi/BeuR8L2LK3T0DitG+TWcnr6lyC4
         MibdK60GK71s/bTyLJhpMs9cxMG7ygUViAEBvE7mhPMfHtrrrIhzX+xtkJdj7SeD6qqC
         WQbrNJUEzFSOxY9EMty8k8Nh4xiTBBCT/cGN5UMkpSAe017BHaikY1DH/DF2FwN9Sqs+
         ei3w==
X-Gm-Message-State: AOAM533y6QU1tDj2HkoHQxwC9zXt45BHCH0UoQM5YTk2vqr+prcunFXp
        doSxHZFh9l8M8Y/ROZ/K0ds=
X-Google-Smtp-Source: ABdhPJwAakzZ65vXbSJkS68z+nCqPuZXbOzqNNvlthoir8124Oug8D12HAqTBTHXYWJ/2C1ehmoVjg==
X-Received: by 2002:a17:90b:3901:: with SMTP id ob1mr31604780pjb.24.1634547528147;
        Mon, 18 Oct 2021 01:58:48 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id t1sm12284487pfe.51.2021.10.18.01.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:58:47 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:58:37 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW03PSmpMkMVnHdp@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0PVYT/GCKAnjN9@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9GLfjPH7N7YSaLAV"
Content-Disposition: inline
In-Reply-To: <YW0PVYT/GCKAnjN9@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9GLfjPH7N7YSaLAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 08:08:21AM +0200, Greg KH wrote:
> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > This removes the chrdev_lock from the counter subsystem. This was
> > intended to prevent opening the chrdev more than once. However, this
> > doesn't work in practice since userspace can duplicate file descriptors
> > and pass file descriptors to other processes. Since this protection
> > can't be relied on, it is best to just remove it.
>=20
> Much better, thanks!
>=20
> One remaining question:
>=20
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -297,7 +297,6 @@ struct counter_ops {
> >   * @events:		queue of detected Counter events
> >   * @events_wait:	wait queue to allow blocking reads of Counter events
> >   * @events_lock:	lock to protect Counter events queue read operations
> > - * @chrdev_lock:	lock to limit chrdev to a single open at a time
> >   * @ops_exist_lock:	lock to prevent use during removal
>=20
> Why do you still need 2 locks for the same structure?
>=20
> thanks,
>=20
> greg k-h

Originally there was only the events_lock mutex. Initially I tried using
it to also limit the chrdev to a single open, but then came across a
"lock held when returning to user space" warning:
https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m60721=
33d418d598a5f368bb942c945e46cfab9a5

Instead of losing the benefits of a mutex lock for protecting the
events, I ultimately implemented the chrdev_lock separately as an
atomic_t. If the chrdev_lock is removed, then we'll use events_lock
solely from now on for this structure.

William Breathitt Gray

--9GLfjPH7N7YSaLAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFtNzMACgkQhvpINdm7
VJJv+A//Y95/e0GrnVcicFqPFkUrWG98rzwge+SdEv4fTwGtyVsbHHlLaZbGOZxU
hnBMDp6d+eo3VkcgMnbrVf+wUu2RXJ9BIFrVLtK8nQhmDVrqwuxMb0RgPAOQoKpy
xQCQHODS5IS9b4PcVS5ic5vBlrDeKlE5ZC6miql+/VecD2V6B21nK83qFV32ZSru
TUcQ2eFUThFLcsu1NzLrisg5Te8LlmGASG03NoZs9YndA/M0Jh7ZivEeSFsCxJPF
8F+dbFVv0vjkclVMkvQE2qzdC9GYpuh698rkqqCAMh0qRmNU6p9RjlxSNvvkGdgd
kQzJZt0RgjtYPCL5ozW8vw8PxjJAH3kWp4lqN11pBgRtWVyecdUX+QZywQDT2pMM
0nrAA07IUR6jOorkDrSDJtVj8nS/hJegBTwXrFKpQSyqtGGNJN7+XxAiM3aaNoPF
xI4cI7B2IYWXEmfUcLsWcFhQQ5VhWqx+HEOSBuUpEVkP2pdjm4G0zm2DDYtoDlax
VmD6LNlXxvJONI7PmCisQNuVnnbbunPG9xQiFPvl4htiwThAdTCBoHK9IhSboST1
fHZop3iMSPz5wQVa5dqJHdb/o97wyM8NuQG3rUZjPncMvnHnVMMXJrH2jwQ/TSqV
z8OZ3wjLAfqTrylq6pveAJvIGJ6kMtp/xB17xtQA16CFwAtxhFo=
=O/WE
-----END PGP SIGNATURE-----

--9GLfjPH7N7YSaLAV--

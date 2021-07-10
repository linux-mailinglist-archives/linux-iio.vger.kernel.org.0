Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B213C341E
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhGJK1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhGJK1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 06:27:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B17C0613DD;
        Sat, 10 Jul 2021 03:25:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o4so6381665plg.1;
        Sat, 10 Jul 2021 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3K7cyJqM4WJugi4DmW1RD2TxhgR0DsWB9WQsLATqDc=;
        b=ZGFHnsYRUwQe5Ay7MfHDsNZfSvN/VTHWfQ94xs6Wozy8q0UU39EFODLjxHxUrTz222
         HUrJqsvW3W9qzqDnWuCfiliQDTFpLZEbJRf5bKPMIeVu/QcGXV1ymctouEv/Tug16M6+
         UupJ7OpN4uMc9u6BmXzWoPoi7X+F3mZ+tMxi307Z5Tkq0iDgcOwou7U2862lBK2tN4DD
         8WVObLr7uUQ8p2qrHT54mE5mSb/EbjBWIDGgyXvsrD7XvL3CA0OeauuDXIXkRmzUOHq5
         d51kBTWHsClyLimYIMhpUcg3WAXVhRflMfDPZqodE3RL3335wad2vTsnd/Hr5txTY586
         rWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3K7cyJqM4WJugi4DmW1RD2TxhgR0DsWB9WQsLATqDc=;
        b=TAh3wtbs2SmZsz+HicgXAR6UhS8XFgoPTfuW0pvC16tRPkmXzVupMDF1Z+BsenTAkV
         ZaO2EE+jFlXCu+m0epD0Na5JV+E0NqEEKmk0wYxJa/kn2eYhlVuiVfayyPHLOqLWrx0J
         TmlVHLr+Iv0C2JgWewUvPyNa9zooz2T8H4FKrBZTuw8zOtewn0v7rpptr7LGMU4Qhs4U
         rhKv7Z6ottoKVkhP2CUrApkdFO6N0oz+OueSeAF+e46Yrd/l2tvQLOmpgiEkpKUn8Vw0
         jvV4orS+kwQLjnFdjUP0novDHWeRafSoHHsSBLFpLeUnbEx2BqnkVyrXFB23h656kHaK
         RBrw==
X-Gm-Message-State: AOAM532vsAbNYvqKITSaRyMBlDn3qJ5FMh3IrteZEBXskwJVeenC5kF4
        nojSnX7ICazDcG36b9ZbKRo=
X-Google-Smtp-Source: ABdhPJxhut2gmoBN83bbMurV/qFa/FqRd+/9jUgBNIuzHsCcfe8rBuc7cj1+VcYwB0vmpv3WahbU/A==
X-Received: by 2002:a17:902:a983:b029:129:c270:9222 with SMTP id bh3-20020a170902a983b0290129c2709222mr17267265plb.78.1625912710273;
        Sat, 10 Jul 2021 03:25:10 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id g3sm15258021pjl.17.2021.07.10.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 03:25:09 -0700 (PDT)
Date:   Sat, 10 Jul 2021 19:25:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <YOl1frCrophjhk7y@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
 <1a624011-0b43-ac42-be53-a42f81923e5a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/692ujiEW8lbLS+a"
Content-Disposition: inline
In-Reply-To: <1a624011-0b43-ac42-be53-a42f81923e5a@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/692ujiEW8lbLS+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 02:40:13PM +0300, Jarkko Nikula wrote:
> Hi
>=20
> On 7/5/21 11:19 AM, William Breathitt Gray wrote:
> > The events_queue_size sysfs attribute provides a way for users to
> > dynamically configure the Counter events queue size for the Counter
> > character device interface. The size is in number of struct
> > counter_event data structures. The number of elements will be rounded-up
> > to a power of 2 due to a requirement of the kfifo_alloc function called
> > during reallocation of the queue.
> >=20
> ...
> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter=
-chrdev.c
> > index 92805b1f65b8..13644c87d02a 100644
> > --- a/drivers/counter/counter-chrdev.c
> > +++ b/drivers/counter/counter-chrdev.c
> > @@ -323,6 +323,9 @@ static int counter_chrdev_open(struct inode *inode,=
 struct file *filp)
> >   							    typeof(*counter),
> >   							    chrdev);
> >  =20
> > +	if (!mutex_trylock(&counter->chrdev_lock))
> > +		return -EBUSY;
> > +
> >   	get_device(&counter->dev);
> >   	filp->private_data =3D counter;
> >  =20
> > @@ -339,6 +342,7 @@ static int counter_chrdev_release(struct inode *ino=
de, struct file *filp)
> >   		return err;
> >  =20
> >   	put_device(&counter->dev);
> > +	mutex_unlock(&counter->chrdev_lock);
> >  =20
> >   	return 0;
> >   }
>=20
> I got two separate mutex warnings from counter_chrdev_open() by doing=20
> blind "cat /dev/counter0". First one due mutex being uninitialized:
>=20
> [  441.057342] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [  441.057355] WARNING: CPU: 2 PID: 366 at kernel/locking/mutex.c:1416=20
> mutex_trylock+0xf2/0x130
> ...
> [  441.217331] Call Trace:
> [  441.220062]  counter_chrdev_open+0x21/0x60 [counter]
> ...
>=20
> which I fixed trivially by (please be free to use it)
>=20
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -364,6 +364,7 @@ int counter_chrdev_add(struct counter_device *const=
=20
> counter)
>          spin_lock_init(&counter->events_list_lock);
>          init_waitqueue_head(&counter->events_wait);
>          mutex_init(&counter->events_lock);
> +       mutex_init(&counter->chrdev_lock);
>=20
>          /* Initialize character device */
>          cdev_init(&counter->chrdev, &counter_fops);

Thanks, I'll add this line in.

> and after that
>=20
> [   16.564403] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [   16.570725] WARNING: lock held when returning to user space!
> [   16.577044] 5.13.0-next-20210706+ #4 Not tainted
> [   16.582198] ------------------------------------------------
> [   16.588507] cat/331 is leaving the kernel with locks still held!
> [   16.595214] 1 lock held by cat/331:
> [   16.599103]  #0: ffff888102bb3630=20
> (&counter->chrdev_lock){+.+.}-{3:3}, at: counter_chrdev_open+0x21/0x60=20
> [counter]
>=20
> Jarkko

I'm not sure how to resolve this warning. The purpose of this lock is to
limit chrdev to a single open at a time. To accomplish this I grab this
lock in counter_chrdev_open() and hold it until counter_chrdev_release()
is called. Is there a better way to accomplish this?

William Breathitt Gray

--/692ujiEW8lbLS+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDpdX4ACgkQhvpINdm7
VJKdXg/+OTmIvRWcp6QRPVGTj4u5tXyU4dpSBNvwJhze9Dtx5IstS63x3eqVCdx9
pnzK7cfLGkCjzUS3tzjbYH/qebQ83C0awJeACn44zELCH0afP3jpN0Ewz6rYAAkn
IPNiUKtgebR8nADn5x5QiFnk0EA8SNAs6SvqDsO8NntuRmLEKgWTTOLGVLhntqaM
kOzwcjjyuv68CGvT8tc85ahJJ+7AaCSBLKBgOvPRid1GXOyX3LhN+GLVJGUbA+BG
HxpDBQ3rNEsIy0B8/v+XnlEscZM98BhhuLOPxpvoxZC/t1DWBMTqtfFLHM3v/qjx
aAupXfSmlYEidyspSWUzDHMKGWgpnMYmXd/X4fkFJy8BS/9aW+gr8emzdt/mVeuL
qz3MdcRD8+5DbBFTHH4jl/y/kaeZ9ztvnBG6Z3kGrnKkWWSDS+Ppu8R2YfuMvrtT
R3+c15C/QIc12pbpFx6OwJu9AssyYDWkQbgodIL8AUWU7F8lKXdB6n8arjuzHeYm
v4yQWQIPJ6Uv3g1Xt/KW71EEXQsHQJscC/NJU5VsKV2vxpiZLlyY1pQYz23wRVJB
iJ1OhTONcWwexJc3VLTv7yW1DTtesAnQHSOIHsRsWCDQJlZfVDgOg9koj0x89v1L
cGPfwuf8U9Nvq8sig2UMKqcoKuq2Js6gHZmV3DL8LF9PG4OGpwA=
=bdED
-----END PGP SIGNATURE-----

--/692ujiEW8lbLS+a--

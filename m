Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85B432F32
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJSHVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhJSHVH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 03:21:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F3C061745;
        Tue, 19 Oct 2021 00:18:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so18510657pgc.12;
        Tue, 19 Oct 2021 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rAB0G0ARwqLsti78vZY0XxYfvHcqD7gU+oEPuK02YvI=;
        b=ivDDp8Fn7QKPA1syYQS3xKAmyNPyRnJi7eU0ShQOhicSV1ovzA5qQLVfCrmJEQpzZk
         nPuWB6/hncHXX7htE62yQvbsJWPxLAdTsNAouX0S7RApXGR4UmbUxcftFqXtFkFbox/8
         k9xZ3nIKWxF2ru08MgsZKGDSjSDN9FVRR/G3CAx1osD/nMviLrFtNPXTOgMTLiNbq32p
         aWxM9wDm4RtphbPqTB3uFVcqEMxcAEmoMcHr524xQcXEVL6ogMr61Oq7JzhCuvAXsNsg
         PXYka2HmnqeQnjpFuReq2BrI6Bc8ultI1Qljhi4vt9oAn08DhHg9Z/v/xx68ivpHQ8X0
         aeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAB0G0ARwqLsti78vZY0XxYfvHcqD7gU+oEPuK02YvI=;
        b=39vCExFQJrqnP3KnGTlq+79ay4ynX0L5C4/xxChqJivMH7QkK1bASrkfdhSwtR5ZCt
         GhbsPw6OmFXoSn4jhIGbPY5u0AnrhpJf+FDblEY6uzIGu7pliyjXkwq6jd3Sr5NXoc63
         Ls4jozlQU/HB3SOeHztUfAsjIpvoZQ+QMx+gTa2SPi0DIOK+1FqEVlihExRCE1YUoFkp
         ah9JrdWRr6+pUWLjU21C8mCATzsdWWVXu5WjHL8pnDB42xpZS9akekUlXPI/hxTSRnoX
         zZe0X1IywNiCWsZl3ukf0i6SaDTo+BNfCJwY4+ahr2HeuQYRP4Ln4+C+SATqDGyYJ8bZ
         kZzQ==
X-Gm-Message-State: AOAM531DUv3IFpaHIP35rBa6QhG/FbeMPKqTJyoL/vPMQWmYqab3kg+v
        rIFJQimPm7Nsg8zTVKS7mQDcW1Kt4AQ=
X-Google-Smtp-Source: ABdhPJxYfzR1iCPrWzR1k8RH4xmSHuWnLHYc9V057vaE5hxYAjxvIxgL0DsMq49cMpR+J2AwS8gM4Q==
X-Received: by 2002:a63:3819:: with SMTP id f25mr2598339pga.344.1634627932494;
        Tue, 19 Oct 2021 00:18:52 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id a22sm15429694pfg.61.2021.10.19.00.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 00:18:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:18:42 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW5xUtWdvW5zHFx5@shinobu>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu>
 <YW5uxIQ1WuW66cf0@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pU3xwbQrTfe7nrrV"
Content-Disposition: inline
In-Reply-To: <YW5uxIQ1WuW66cf0@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pU3xwbQrTfe7nrrV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 09:07:48AM +0200, Greg KH wrote:
> On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wrote:
> > On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> > > On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> > > > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > > >> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/cou=
nter-sysfs.c
> > > >> index 1ccd771da25f..7bf8882ff54d 100644
> > > >> --- a/drivers/counter/counter-sysfs.c
> > > >> +++ b/drivers/counter/counter-sysfs.c
> > > >> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(s=
truct counter_device *counter,
> > > >>   					   u64 val)
> > > >>   {
> > > >>   	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > >> -	int err =3D 0;
> > > >> -
> > > >> -	/* Ensure chrdev is not opened more than 1 at a time */
> > > >> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > > >> -		return -EBUSY;
> > > >> +	int err;
> > > >>  =20
> > > >>   	/* Allocate new events queue */
> > > >>   	err =3D kfifo_alloc(&events, val, GFP_KERNEL);
> > > >>   	if (err)
> > > >> -		goto exit_early;
> > > >> +		return err;
> > > >>  =20
> > > >>   	/* Swap in new events queue */
> > > >>   	kfifo_free(&counter->events);
> > > >>   	counter->events.kfifo =3D events.kfifo;
> > > >=20
> > > > Do we need to hold the events_lock mutex here for this swap in case
> > > > counter_chrdev_read() is in the middle of reading the kfifo to
> > > > userspace, or do the kfifo macros already protect us from a race
> > > > condition here?
> > > >=20
> > > Another possibility might be to disallow changing the size while
> > > events are enabled. Otherwise, we also need to protect against
> > > write after free.
> > >=20
> > > I considered this:
> > >=20
> > > 	swap(counter->events.kfifo, events.kfifo);
> > > 	kfifo_free(&events);
> > >=20
> > > But I'm not sure that would be safe enough.
> >=20
> > I think it depends on whether it's safe to call kfifo_free() while other
> > kfifo_*() calls are executing. I suspect it is not safe because I don't
> > think kfifo_free() waits until all kfifo read/write operations are
> > finished before freeing -- but if I'm wrong here please let me know.
> >=20
> > Because of that, will need to hold the counter->events_lock afterall so
> > that we don't modify the events fifo while a kfifo read/write is going
> > on, lest we suffer an address fault. This can happen regardless of
> > whether you swap before or after the kfifo_free() because the old fifo
> > address could still be in use within those uncompleted kfifo_*() calls
> > if they were called before the swap but don't complete before the
> > kfifo_free().
> >=20
> > So we have a problem now that I think you have already noticed: the
> > kfifo_in() call in counter_push_events() also needs protection, but it's
> > executing within an interrupt context so we can't try to lock a mutex
> > lest we end up sleeping.
> >=20
> > One option we have is as you suggested: we disallow changing size while
> > events are enabled. However, that will require us to keep track of when
> > events are disabled and implement a spinlock to ensure that we don't
> > disable events in the middle of a kfifo_in().
> >=20
> > Alternatively, we could change events_lock to a spinlock and use it to
> > protect all these operations on the counter->events fifo. Would this
> > alternative be a better option so that we avoid creating another
> > separate lock?
>=20
> I would recommend just having a single lock here if at all possible,
> until you determine that there a performance problem that can be
> measured that would require it to be split up.
>=20
> thanks,
>=20
> greg k-h

All right let's go with a single events_lock spinlock then. David, if
you make those changes and submit a v2, I'll be okay with this patch and
can provide my ack for it.

Thanks,

William Breathitt Gray

--pU3xwbQrTfe7nrrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFucVEACgkQhvpINdm7
VJIVig//Rf0OyiB/6KMr3Ow3iyil3DYBR6wm1xCMH9pK6Fx4J7CQECm9+PQt6TIP
lokPsKMYtzZnKmTB1FfuTOTTpKUMj8tdRh9Hyi0P3z4JucjfmSijsEMHSruz9G1y
wFRB7pyWt7A69PLQN/VXGlklEcyar+suKbQkjoBqo6yCjMSiM9WuXThja1vvREGW
6wqn9UDL5IeZ52vpCfQvf15cLBFgqVAZkwfBl9jCdbL6GJRp0HdQY35mihZrL9kT
fkKj+RsYdSOFrkxHHwbCop4fxU/2EyLxu7AR3SkQZhsgaoNHHLIfIJ5zsJYJexdR
ymKkjy5AP0DAO10drBgEYDCOdLsvDzvzUIrc/k8YI1MrCNnuczOcwcUUpPgQnWSE
BaGjLbX0WLLRJBnW7jmHCucxVcCrO0rZtZHU2jm55ZfJ6CjjW7Ybb+uHOwOvHN95
/idxWNR8q9xZ81YfJDKjh3TKOG8+ZUvhWjd/xi1qC5xTk1Sw6Av1dolx40NHP2EM
mwRM5sqrNYgat7L/+M79GHjSb7XXag8SoT/xCJ0qFUFJOnFkUGdb8p6cxdNmlC5O
HdbwRCTBIyKuDrOSORSCf/SNtWa36CyWOY4BsCqOQMWzef5qwL4AeZUKKIlzBKNR
4uzqGH9MGdjyomyjCIedlAIYk6zJns5ZMKN14YaSGNmdyJd/dOo=
=boNY
-----END PGP SIGNATURE-----

--pU3xwbQrTfe7nrrV--

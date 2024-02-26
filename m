Return-Path: <linux-iio+bounces-3077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59315866E67
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03EA1F249B9
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0845F85C;
	Mon, 26 Feb 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnu6ICdn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDB5F852
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937295; cv=none; b=QwOZkutRE7g0p0WeOBBV8Ze8L00HjNcSDZ9RdB9aZiVDDvjB9ZWaALhyrGNfuFzzoz2WM+ojwd72QGRoT4cwdyMtRhNGwiujpiT4kMvDe8T/wZC3J9lO2+FfWnvEfIz77/mWr6UI5l+UhgwcglhNoMqVAAud46+glMM7JQjA25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937295; c=relaxed/simple;
	bh=Zw3NJ7E9I+SvVLkikEq7LMCNTiiQ0XhakSyog8QDBtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWWjUcTIKhD/G3KqZsh+lCO91wsl45pmQrN6fyQwW8gtFmUzfGQII5BzfKgwQrQUtKgbzbLju2TADsrnU71r8PYacHzrz+e1h3F8140UGxQSjhY1EjJqblWwlwOqAuPI7zVj27VhaxLdWuCQoorzHbAvHgDMDAJlKlqePKVQwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnu6ICdn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so3559444a12.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937292; x=1709542092; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68c+hyfyvEW6Wb2wmDA56s+R87CIXm/ReSraENvKSYY=;
        b=Wnu6ICdnEXGBzc+IevtUdxalrpq7lHT4u+1HVnh4Afw6p6kbtDY03pzW9rYwhgUNJT
         uels6KUndm5wAVnR7hgO1zl+XKKVfiXP8fIlhlbEZgkTBDHt7iLciVx/EeLjMoD+WA0W
         v4J246jF3MQL1h8x2VQQ3JQ9M/w/qWz5WMtEb7eJN0KFFdYKwNhDWzQUblDctz464B+R
         YIZk8+b3MvetzgzoaWbhGzS/xriroSLodw5BePV4rmIxbTZgRhqP+5cSXYVIhqV9UvFW
         5IpssIek/NB5yoDp3DcGPxhYF9rs0ObVXaIa3ixgzkch6OnNXMK3Dbs8SVEQ9yqSmggE
         pelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937292; x=1709542092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68c+hyfyvEW6Wb2wmDA56s+R87CIXm/ReSraENvKSYY=;
        b=YJmqqHuCoeKuyJu5CLbtyVzhd+2bsZa872Uwjxxn9Z/UEfiClHelEx0AKSTsFADZ4H
         ymBvVd/FyxPPkH4ACbA1xbH4pJUy442XOxdKFS+oXt9qp4Yys3QgGbtxecjF0ySe11t2
         3mpOJBrrsAq/gwxNdXxZHU2RdE1HIy9uKJ//Uprg+OtjcnwdXvPUnzY4CZZJdej3uQGc
         slPXyzjtRj5K2sxR7Pz3QHw8I8dHjJqGVPuPbf19Rw4jMPaDNXMt7QkNnXKIKkcHkbYc
         z9Qw7K35YwjaZb+5AMpMuw7ntWyL61xuj8kBJLm+vKQmqPufVY1OObQXD4UoYYU7y1DS
         q7Hg==
X-Gm-Message-State: AOJu0YwVALSI4MM3okWVlBCr7aw+OmbahYbjeUFBGK48SFgzy11IxnAb
	PrBS7UqZk9VtwQY0A5HDMy0Zd4S9VGvv8VGcyyNCk1M361+nhouAPNfMH3KI
X-Google-Smtp-Source: AGHT+IGvZxttvHc7vOK2ll+9hu8UX7tyLzkyPnnqbZXKs7Y7pRnL2BI0kFkjJSqfc6I05uB9aVj47A==
X-Received: by 2002:a17:906:3683:b0:a3e:7f54:12c1 with SMTP id a3-20020a170906368300b00a3e7f5412c1mr4419817ejc.72.1708937292371;
        Mon, 26 Feb 2024 00:48:12 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id gq7-20020a170906e24700b00a3f3d0d30c8sm2195942ejb.213.2024.02.26.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:48:12 -0800 (PST)
Message-ID: <7640e4d66d1f5c29987a7c79f68c9b2c719a6dcb.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: events: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, "Fabio
	M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Date: Mon, 26 Feb 2024 09:48:11 +0100
In-Reply-To: <20240225123531.020e875f@jic23-huawei>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	 <20240223-iio-use-cleanup-magic-v2-2-f6b4848c1f34@analog.com>
	 <20240225123531.020e875f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 12:35 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:43:45 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-event.c | 42 +++++++++++++++++----------=
-------------
> > =C2=A01 file changed, 18 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industriali=
o-event.c
> > index 910c1f14abd5..ef3cecbce915 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -7,6 +7,7 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/anon_inodes.h>
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/fs.h>
> > =C2=A0#include <linux/kernel.h>
> > @@ -146,11 +147,10 @@ static ssize_t iio_event_chrdev_read(struct file =
*filep,
> > =C2=A0				return -ENODEV;
> > =C2=A0		}
> > =C2=A0
> > -		if (mutex_lock_interruptible(&ev_int->read_lock))
> > -			return -ERESTARTSYS;
> > -		ret =3D kfifo_to_user(&ev_int->det_events, buf, count, &copied);
> > -		mutex_unlock(&ev_int->read_lock);
> > -
> > +		scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
> > +				=C2=A0 &ev_int->read_lock)
> > +			ret =3D kfifo_to_user(&ev_int->det_events, buf, count,
> > +					=C2=A0=C2=A0=C2=A0 &copied);
>=20
> > =C2=A0		if (ret)
> > =C2=A0			return ret;
> > =C2=A0
> > @@ -198,28 +198,22 @@ static int iio_event_getfd(struct iio_dev *indio_=
dev)
> > =C2=A0	if (ev_int =3D=3D NULL)
> > =C2=A0		return -ENODEV;
> > =C2=A0
> > -	fd =3D mutex_lock_interruptible(&iio_dev_opaque->mlock);
> > -	if (fd)
> > -		return fd;
> > +	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) =
{
>=20
> Maybe we want to wait for
> 	cond_guard() that Fabio has been working on to land
> https://lore.kernel.org/all/20240217105904.1912368-2-fabio.maria.de.franc=
esco@linux.intel.com/
> Not sure if it will make the merge window and I don't want to hold this a=
 whole
> cycle if it doesn't.

Oh nice, I was wondering about something like this as my first reaction was=
 also to
have something like guard().

>=20
> In many cases I find the scoped version easier to read, but sometimes it =
makes
> things
> a little messy and for cases like this where it's taken for nearly the wh=
ole
> function
> (other than some input parameter checks) the guard() form is nice and
> cond_guard() as similar advantages.

Agreed. I'll hold a bit to see if it get's merged...

>=20
> If I didn't have a few other requests for changes I'd just have picked th=
is
> and we could have coped with the slightly less elegant change set.
>=20
>=20
> > +		if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
> > +			return -EBUSY;
> > =C2=A0
> > -	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
> > -		fd =3D -EBUSY;
> > -		goto unlock;
> > +		iio_device_get(indio_dev);
> > +
> > +		fd =3D anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev, O_RDONLY | O_CLOEXEC);
> > +		if (fd < 0) {
> > +			clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> > +			iio_device_put(indio_dev);
> Given this is an error path, I think it would now be nicer to do
> 			return fd;

Alright...

- Nuno S=C3=A1




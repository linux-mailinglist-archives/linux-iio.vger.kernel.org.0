Return-Path: <linux-iio+bounces-3079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBE866E85
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5191BB25CE5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDA60273;
	Mon, 26 Feb 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmk4fysq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E645FF18
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937466; cv=none; b=SikAsTkRSe/wduC/CPwQ41zAzDjZJ5p+om3ZCnmGU4lyHI0aGbCamsaVX9X0sCotRbLXeiJq0gop1JFvOIJjiSaY7kr18zqj7wwadYXSNKCuPQWCYZJqFN65W060Ypnscwn/V8pJdQ5roAsw9CrQzKSMpEtzFlKzgszcpvVs7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937466; c=relaxed/simple;
	bh=4uu2rpZryPFH34+3IZ1lXf3SRReRhYksNl/Hy/NH7i4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRqmxtvN+r/RNjD1NpVrRz0jHCK5XQ+T8nw5Lf+v1xT6F4c+0COffM8un3Zsg7J6t2CIzegimj7KGI7lPmF3CL+9xCSpIrR21B9Bd7lK6wvBtP5I+xcwW3pbYafjy0sGJFpFjoWekAenfDD+zMSTOANJacVVsW7/MzGrH4BE+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmk4fysq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso3448895a12.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937463; x=1709542263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3mlb6pn7G5Q/FUuy56nGtPm8AxCUP/L5AjzHXlZ7J4=;
        b=fmk4fysqq5A0rwTgMI6FnXBidRNHRsyiVwKceSU17f9gbwjHmM6Gk4AkKa6qhVc3aH
         yn7cKBecpc9EKO5onOqLlEpSG/n7xqbuIoKlhxrZnmzCpZL6YFQbYWnZTecWbJP6odRA
         qZNy1n3SVj1abJUHTNbpoJCfgB9D4Y5huZhrmRXpZu93ypeHCgnV2C/6E9sG31O2fOTM
         QyHm1UQB/6AVpU/zYkA5VR0e5YqS6fCQ4s0Je0tvT2hkw/gBNag9VOPSmiL1ky4YXpeg
         J1I4pblgcKuJhaA6GnU9m9wpUmP3E4EPX69Hg44ffRpk24ldiycJCz7diQ7VcNby1GGM
         AGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937463; x=1709542263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3mlb6pn7G5Q/FUuy56nGtPm8AxCUP/L5AjzHXlZ7J4=;
        b=n52BrGMI8AwIRqlyksAlTDXwn+JA0SSCDdyfRF709/cPyk5PaDRRH6XL8SVG/l/AZp
         4NJZqRy7Jaej/OpAF5/yJ7SCdMnI60+gyOM9Gmt6SkzXV+ZrKCzoniZ0samHcbUOCi/n
         6l70DAgk+/cuRaSq8YBMS+yCU1IX6wOb/o6V3AXRDd2vATWWz60rbRjXZTDEKEd0eWyr
         Qg3m5w3pa7ae3wG8K0tSxHAhICyeil6lZiaqfsBHAs8bfJ6fgubgP1s+4WPuso2GgAyE
         D8XoeNDFfH7yZKkEFa60MXjB34Eq9PGjT1pt0sd0bBhKqiYxEJ9JF6RUd/JOH14ipCzK
         dsJw==
X-Gm-Message-State: AOJu0YzYM0bCFEdjfPBKyKZuwwSEWUJBF4peIwmpnj2oT7OyA03z8x1V
	38BdDaDChre6zGpx86a1xmtYnR+8pnmes3qbSoz1YdhMFC2680IX
X-Google-Smtp-Source: AGHT+IFc2ZgXKnkWXBa1njDRWPYPOtMSuBAGlarRIrPkk8Q4EhD27OFUDwfm8dDnkvBcCFw610YLfg==
X-Received: by 2002:a17:906:af09:b0:a43:803d:b4ab with SMTP id lx9-20020a170906af0900b00a43803db4abmr227527ejb.31.1708937462480;
        Mon, 26 Feb 2024 00:51:02 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id js18-20020a170906ca9200b00a3d665c6778sm2236695ejb.12.2024.02.26.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:51:02 -0800 (PST)
Message-ID: <794918eb98822414b88a9550150454957978ca2e.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: trigger: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 26 Feb 2024 09:51:01 +0100
In-Reply-To: <20240225124524.5f0288e1@jic23-huawei>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	 <20240223-iio-use-cleanup-magic-v2-3-f6b4848c1f34@analog.com>
	 <20240225124524.5f0288e1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 12:45 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:43:46 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Hi Nuno,
>=20
> Thanks for doing these.
>=20
> A few minor comments inline.
>=20
> Trick with these cleanup.h series (that I am still perfecting)
> is spotting the places the code can be improved that are exposed by
> the simplifications. Often we've gone through an elaborate dance with
> error handling etc that is no longer necessary.
>=20
> > ---
> > =C2=A0drivers/iio/industrialio-trigger.c | 64 ++++++++++++++++---------=
-------------
> > =C2=A01 file changed, 26 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industria=
lio-
> > trigger.c
> > index 18f83158f637..e4f0802fdd1d 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -4,6 +4,7 @@
> > =C2=A0 * Copyright (c) 2008 Jonathan Cameron
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/idr.h>
> > =C2=A0#include <linux/err.h>
> > @@ -80,19 +81,18 @@ int iio_trigger_register(struct iio_trigger *trig_i=
nfo)
> > =C2=A0		goto error_unregister_id;
> > =C2=A0
> > =C2=A0	/* Add to list of available triggers held by the IIO core */
> > -	mutex_lock(&iio_trigger_list_lock);
> > -	if (__iio_trigger_find_by_name(trig_info->name)) {
> > -		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> > -		ret =3D -EEXIST;
> > -		goto error_device_del;
> > +	scoped_guard(mutex, &iio_trigger_list_lock) {
> > +		if (__iio_trigger_find_by_name(trig_info->name)) {
> > +			pr_err("Duplicate trigger name '%s'\n", trig_info-
> > >name);
> > +			ret =3D=C2=A0 -EEXIST;
>=20
> Bonus space after =3D
>=20
> > +			goto error_device_del;
> > +		}
> > +		list_add_tail(&trig_info->list, &iio_trigger_list);
> > =C2=A0	}
> > -	list_add_tail(&trig_info->list, &iio_trigger_list);
> > -	mutex_unlock(&iio_trigger_list_lock);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0
> > =C2=A0error_device_del:
> > -	mutex_unlock(&iio_trigger_list_lock);
> > =C2=A0	device_del(&trig_info->dev);
> > =C2=A0error_unregister_id:
> > =C2=A0	ida_free(&iio_trigger_ida, trig_info->id);
>=20
>=20
> > @@ -145,18 +143,14 @@ static struct iio_trigger *__iio_trigger_find_by_=
name(const
> > char *name)
> > =C2=A0
> > =C2=A0static struct iio_trigger *iio_trigger_acquire_by_name(const char=
 *name)
> > =C2=A0{
> > -	struct iio_trigger *trig =3D NULL, *iter;
> > +	struct iio_trigger *iter;
> > =C2=A0
> > -	mutex_lock(&iio_trigger_list_lock);
> > +	guard(mutex)(&iio_trigger_list_lock);
> > =C2=A0	list_for_each_entry(iter, &iio_trigger_list, list)
> > -		if (sysfs_streq(iter->name, name)) {
> > -			trig =3D iter;
> > -			iio_trigger_get(trig);
> > -			break;
> > -		}
> > -	mutex_unlock(&iio_trigger_list_lock);
> > +		if (sysfs_streq(iter->name, name))
> > +			return iio_trigger_get(iter);
>=20
> Nice :)
> > =C2=A0
> > -	return trig;
> > +	return NULL;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void iio_reenable_work_fn(struct work_struct *work)
> > @@ -259,11 +253,10 @@ static int iio_trigger_get_irq(struct iio_trigger=
 *trig)
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&trig->pool_lock);
> > -	ret =3D bitmap_find_free_region(trig->pool,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ilog2(1));
> > -	mutex_unlock(&trig->pool_lock);
> > +	scoped_guard(mutex, &trig->pool_lock)
> > +		ret =3D bitmap_find_free_region(trig->pool,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ilog2(1));
>=20
> This presents an opportunity make this more idiomatic as a result
> 	scoped_guard(mutex, &trig->pool_lock) {
> 		ret =3D bitmap_find_free_region(trig->pool,
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> 					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ilog2(1));
> 		if (ret < 0)
> 			return ret;
> 	}
>=20
> 	return trig->subirq_base + ret;
>=20
> Getting rid of 'non-standard' error handling conditions is one of the nic=
est
> things this cleanup.h stuff enables as we don't dance around to avoid lot=
s
> of unlock paths.
>=20

Will do.

- Nuno S=C3=A1



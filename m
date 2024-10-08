Return-Path: <linux-iio+bounces-10316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F267993FD6
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 09:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF59A1F238C9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE791E105D;
	Tue,  8 Oct 2024 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Pi982Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEF190693;
	Tue,  8 Oct 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370083; cv=none; b=XJB0BZARHywReSSF+FnnwQYG9pZ5X7eCSNZNwHnBM/6Bftd9oC//rELkzYyq9GM3qH1KmlDUW5bj8ayddrpamoEbxedeJTk3EZH8zByd2P3CbeI8QkZ3No1r49j+oO1rGj1WOt86LAJdqOKmFxHH5zP8denFwHFSdmcgPld7bqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370083; c=relaxed/simple;
	bh=nZxlAHCneqI4e9kizI/zUm3syFU19pKGY6jXXH6YS2U=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=gl+hzwvcWlyhgI7Gp6ynt7Bzk8uYJiwLZh1IByKVYngAuyZzZP7MWNAPUJDmWJlfLvSKId2C68P8ELYWRp7rODaqxqLUi3e1rkkQkrywWUm935ZqyBOpYhLsumd+4m3jBUFyrLMIQ0rBt4U3GH5uCgvat8jFopeOFdMgAGsMylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Pi982Y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99422c796eso372973266b.3;
        Mon, 07 Oct 2024 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370080; x=1728974880; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE1okYUSWvc/i7hAwavz2PLjVoOSwFE1NDuC+jJpWRA=;
        b=f/Pi982Ya0q5CSsYXiUYg+7nBP3PknOR8TiWks6yH3ShbK2n6IJvFUzxNg6S+rzEZq
         PZZ2LiQxJX4AdiHIqbJcYYPjj4Tb4EvRWpulp+Ml+q/+hfu2m/JQxPzluAIyTMlXCZc7
         E+1TnHoz4UDuQ5iUno2blpI0QXmNfgUDPpsjk5AL2knjHmHxMMg/MpXhNvTk5r188zcq
         k4JZferKF9JdO3wpliaCgANRJVEBdM8dnYmWk78zaED6IQt4+Dzf5/IOhdlvmPQqsSpx
         YxFp+jFyCWFwU2W2li11iTYtLmBXIikjw3sSnUKRmA86kxdlpnNJyZNP/VwfXnXoh5mi
         9NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370080; x=1728974880;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE1okYUSWvc/i7hAwavz2PLjVoOSwFE1NDuC+jJpWRA=;
        b=qasbNI8SB4csq+km/ntac3cq4ImeK5A9pOcbabTHSfdG2UWkhySfI5rWw1v3BkYdDF
         ucBcBatCz/OkYNIQSB0pQ/JptyfWPzFpL5GZrVLW7HU8eT1BhUdnwgzGRr8oS4cNn0Jy
         mOpJfxJ8YJDLGqfCFKEoo/htLVtHFoBHhiy9aST33tXLvO9jPSWm1leCjUfGBiOtmjhz
         zkv6Xc4CHFfxVwHTV9hp35RJCljP6QcP3SCdrIRJDdbyjcVFjrDlaLshAT+JkgVzkDbf
         TsHZ2O2BtheSwTnWAOQ7MJ316W8dR0vWwdhSKQwkj/KWacFgzRvVc+Zjepey/tSVpOpV
         GwjA==
X-Forwarded-Encrypted: i=1; AJvYcCVUOGlAMT1sfGXgsGYBc+dVg0aK2Td4iugnyUqgBDTrzWC45AC3Fi2QqUe0bSCvkjPOm/8ESS0176s=@vger.kernel.org, AJvYcCWyDG65zt7yEgRE5PJHPfdQqMTW+lx2rZOcSIojYbh9yb4xi8G9tdUVJFQHk97lhws5UIOxE77uLjTrRmc=@vger.kernel.org, AJvYcCXYk2MXYKPZOVYlVNEA4OVQeX4BbtPwzwFj/XlfC0fprRf5uzY0JrpgPfsw/GtedTxTqMKh1J8F9v+VUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwftbEFM7aCvXKBCiPJI65l33NCmzpWWzJKVRKkkngato7NNHU0
	QmzTIo3gF3BR4J7A6Mb5b5cmAKkmdYh56ekPIJD760tHVw6kjHQR0Cdzz3pf
X-Google-Smtp-Source: AGHT+IHtEBTVI46CFdHFcpaPNZLxbeoPvvh9qTxtbOFekOmKVpWMl94atwJTw3JljWSF6HHx8qfVog==
X-Received: by 2002:a17:907:c14:b0:a99:5560:a84f with SMTP id a640c23a62f3a-a995560a972mr541153766b.31.1728370079698;
        Mon, 07 Oct 2024 23:47:59 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b0ee9sm465987166b.155.2024.10.07.23.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:47:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com> <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com> <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from producer
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?q?S=C3=A1?= <noname.nuno@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>
Date: Tue, 08 Oct 2024 08:47:58 +0200
Message-ID: <172837007815.3337.5869213289160447430@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)
> On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> > Consumers need to call the read_avail_release_resource after reading the
> > available info. To call the release with info_exists locked, copy the
> > available info from the producer and immediately call its release
> > callback. With this change, users of iio_read_avail_channel_raw() and
> > iio_read_avail_channel_attribute() must free the copied avail info after
> > calling them.
> >=20
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > ---
> > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 64 +++++++++++++++++++++++++++++++++-----------
> > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index
> > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e168007=
a447ffc0d91
> > 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct iio_chann=
el *chan,
> > =C2=A0     if (!iio_channel_has_available(chan->channel, info))
> > =C2=A0             return -EINVAL;
> > =C2=A0
> > -     if (iio_info->read_avail)
> > -             return iio_info->read_avail(chan->indio_dev, chan->channe=
l,
> > -                                     =C2=A0=C2=A0=C2=A0 vals, type, le=
ngth, info);
> > +     if (iio_info->read_avail) {
> > +             const int *vals_tmp;
> > +             int ret;
> > +
> > +             ret =3D iio_info->read_avail(chan->indio_dev, chan->chann=
el,
> > +                                     =C2=A0=C2=A0 &vals_tmp, type, len=
gth, info);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int), G=
FP_KERNEL);
> > +             if (!*vals)
> > +                     return -ENOMEM;
> > +
>=20
> Not a big deal but I would likely prefer to avoid yet another copy. If I'm
> understanding things correctly, I would rather create an inkern wrapper A=
PI like=20
> iio_channel_read_avail_release_resource() - maybe something with a smalle=
r name :).
> Hence, the lifetime of the data would be only controlled by the producer =
of it. It
> would also produce a smaller diff (I think). I just find it a bit confusi=
ng that we
> duplicate the data in here and the producer also duplicates it on the ->r=
ead_avail()
> call. Another advantage I see is that often the available data is indeed =
const in
> which case no kmemdup_array() is needed at all.


If I understand correctly your suggestion you would leave the inkern
iio_channel_read_avail() untouched, then add a new inkern wrapper, something
like iio_channel_read_avail_release_resource(), that would call the produce=
r's
read_avail_release_resource(). The consumer would invoke this new wrapper i=
n its
own read_avail_release_resource() avoiding the additional copy. The call st=
ack
would look something like the following:

iio_read_channel_info_avail() {
    consumer->read_avail() {
        iio_read_avail_channel_raw() {
            iio_channel_read_avail() {
                producer->read_avail() {
                    kmemdup_array();
                }
            }
        }
    }

    iio_format_list();

    consumer->read_avail_release_resource() {
        iio_read_avail_channel_release_resource() {
            producer->read_avail_release_resource() {
                kfree();
            }
        }
    }
}


I was going with the simpler solution you described, but my concern with it=
 was
that the info_exists_lock mutex would be unlocked between a iio_channel_rea=
d_avail()
call and its corresponding iio_channel_read_avail_release_resource() call.
To my understanding, this could potentially allow for the device to be
unregistered between the two calls and result in a memleak of the avail buf=
fer
allocated by the producer.

However, I have been trying to reproduce a similar case by adding a delay
between the consumer->read_avail() and the
consumer->read_avail_release_resources(), and by unbinding the driver during
that delay, thus with the info_exists_lock mutex unlocked. In this case the
driver is not unregistered until the iio_read_channel_info_avail() function
completes, likely because of some other lock on the sysfs file after the ca=
ll of
cdev_device_del() in iio_device_unregister().

Are there are other cases in which the device could be unregistered between=
 the
two calls? If the info_exists_lock mutex is not necessary for this read_ava=
il()
flow then I could switch it to the simpler solution without the additional =
consumer
copy, but at that point I would question why the info_exists_lock mutex is =
being
locked in iio_read_avail_channel_raw().

For some additional context see also my previous conversation with Jonathan=
 on
the subject [1]. I followed Jonathan's suggestion to keep the implementation
simple by letting the consumer to always copy the producer buffer, but I co=
uld
also consider different solutions.

Regarding the release function names being too long, I totally agree and I =
would also
shorten the iio_info read_avail_release_resource() callback if that remains
clear: something like read_avail_release_res() or just read_avail_release()?

Link: https://lore.kernel.org/linux-iio/20240810105411.705cb225@jic23-huawe=
i/ [1]

>=20
> - Nuno S=C3=A1
>=20
>=20

Thanks,
Matteo Martelli


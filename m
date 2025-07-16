Return-Path: <linux-iio+bounces-21709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798FB06F19
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FB31A661CB
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A994A28CF5C;
	Wed, 16 Jul 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5TKCfTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414F28DF12;
	Wed, 16 Jul 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651407; cv=none; b=LQAINbt4Y4F70SYGsnZzJ2WvLeEBbV+s5+ZVcWY3zTFa2K7fXiaTVf3noT0pzheG4rlC7rTnStklibhZ69TXFwWthpdOloU6QvQyYGQ0kNHgkiy+FGb4lnH/wIoexO13NTsPrAZQ/2gpMIYc+YDeI00a/C2MZgnwVD9GGa9eds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651407; c=relaxed/simple;
	bh=9dnEDgnMTJ9bXHxaT/3BnexyvfxP6RloMoV9u4spKjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5RZBwg3Szq/LU2okBPqX+lkTP1olGMl0Rssf80ZExvy0lTwDrwXKzzBzOvtFMbyawXH5Zl5/FR38h36xOSgA8vqt/wz0CvMT+L+5GoZn+ps/jBqWh2tw6CGwIEgjh4ciTGACQR4nRhr1WmHlqMXrj0nrPCd95sOGB6/gpEcDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5TKCfTS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454f428038eso44679415e9.2;
        Wed, 16 Jul 2025 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752651403; x=1753256203; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qFhNRfNZ4kLGA58jSt8/eAK5R98G4lTusn+THVeaaWQ=;
        b=P5TKCfTSD284lARRNDPV5tE5Q96nkcfvKEbHjLuN6mlrkcb/LiT203CZy/N/nYM0Tx
         ByvKv7xXGFCsT6PJOnNxktwHa+BRDtHDwj2mgpcRwEcPz1AkcfAmUT8U1LWxlPIQVSee
         9SQi7BtIAdzdIa/hd7UhoOBFtzhGU7oUTO3OVNa63K3KdG9E3Oe5JedCFqJBW7xcClUf
         KBXLgPi+pRZLbZ3ox1VVHXR86pO9hQZQl1cmWCNkQUV/xUC+2eGn/Tus2trOnCwtE1Cx
         Jd+8x6+tFXVcgPqyL+Xn+1qsYus2lcgGB75BrnjazC4J033mN2XhzDcSPRVLokgMY2CJ
         rL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752651403; x=1753256203;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFhNRfNZ4kLGA58jSt8/eAK5R98G4lTusn+THVeaaWQ=;
        b=PU7xq1GGlU4CxtqSMtA8Um0kGa9YZrpi6BdMM4Y8kkZfV4bqW8h6fuRwK6Nrnyz++C
         MKU4V1KDRzrrUTcrlxAm/tl0iRCHC+RQ3FD3r9LxJ68VOFXj4Rj37UcG8p60qHUaLdA5
         l2/99heko9JrJQKuFmMARcYFcuhr/QVdGLYKRkkPbDgn/p0b4NmJYwxeYiT/pN/IHSDc
         DIzNylcb/AzOEwnvNWRyO3ZUwgl97gf5cyr8kr/bYj80Od9lILwAsocFa9vQWMgoyl4K
         5K1rh9D2jm4Hul7M/kbQqgUG269ETOgpna0BomY0jKdlTJNliCwmNrX6tvFb0atUiwCf
         i/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBvdnoIYjXBKjMLtOEfZWJBo7z4rlRxk9dTei06lWWPQDQvPUXxZHvcvGlX5PeyQeHiY00inqL+mluHO5p@vger.kernel.org, AJvYcCXPegF5cfyZ/S+TYlfKnJ7nf9Nis2GBJHFn+23Z+2Re2nlnniS4i/erWz6mDEg9+2AffECg7yfCfWc8@vger.kernel.org, AJvYcCXkh/rgO6BorFEUjue9rwJh/3CJ9YtWt+LQIn+5IQh3M4eBI3xnU6+tbZk2+gjFsvJO8MsnN1Lk+6knMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXuqi+QI02eP6sJ5pcOeBe89SKoIBdP+LS6VVH7TgSOO1OcCC
	h+qeSh0Z8/uEU8s+7no1SPUX+LXMAonC6lAaSiXg+nkvoXPb2bJJ/CCb
X-Gm-Gg: ASbGncuiPm3sTmzreKyuOiNgTfLywYPNwTg60WXgOFrH7KFd75WF288d98zOIhRkq8q
	/C41KyEQyntbfacTEr39sM9Jf1cOhJK6vDMgdTsONT+jrAgdffC+WPNG0JzmKDfzRXiRqhnZZoA
	qp+/eCYnVi0XKE0Fag+wSoJ8xANsleQ6xqKBTwGmjF0pq6o4G8jYnC+LolvStEGWaAEiML/53bn
	6ygCJqvijnwnNTXvmQb9PH9G9ZQy49XqI5u4sYW1nr/cA0YNFAmKtkDu7AbS1QcyIv1CcsASGt3
	etyKsCKAMh7Kap4vA3rumb30OqBW+oaF2if02DZd9HhM5WjZUSjNETAa/s42nQGdMHJd7X4bXLD
	WqkJy1M0GifekCL0e1LUYWOA39H26JfHH1QP/QaiQ4c/e8bt77p4ZYmfHoSNuILOoUBpCgnsn
X-Google-Smtp-Source: AGHT+IGoRCH1nxiyXOTisaN3kb/a/NhWkxeQs5mp5u0K7PZnkayZwC2+ahl/EqUXouOpQNkyx4+gIg==
X-Received: by 2002:a05:600c:4e12:b0:456:2ac6:ccb7 with SMTP id 5b1f17b1804b1-4562e37123emr14764345e9.11.1752651403251;
        Wed, 16 Jul 2025 00:36:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8860cdsm12376225e9.20.2025.07.16.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:36:42 -0700 (PDT)
Message-ID: <9c6f99e022270b1b9c2f178f8f415270f11e59df.camel@gmail.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
 <jic23@kernel.org>,  Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-iio@vger.kernel.org, 
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Wed, 16 Jul 2025 07:37:20 +0100
In-Reply-To: <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	 <20250715012023.2050178-8-sean.anderson@linux.dev>
	 <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
	 <6455be16-d287-4d5e-9556-e1789d43708c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-15 at 13:02 -0400, Sean Anderson wrote:
> On 7/15/25 07:28, Nuno S=C3=A1 wrote:
> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
> > > Add alarm support based on IIO threshold events. The alarm is cleared=
 on
> > > read, but will be set again if the condition is still present. This i=
s
> > > detected by disabling and re-enabling the event. The same trick is do=
ne
> > > when creating the attribute to detect already-triggered events.
> > >=20
> > > The alarms are updated by an event listener. To keep the notifier cal=
l
> > > chain short, we create one listener per iio device, shared across all
> > > hwmon devices.
> > >=20
> > > To avoid dynamic creation of alarms, alarms for all possible events a=
re
> > > allocated at creation. Lookup is done by a linear scan, as I expect
> > > events to occur rarely. If performance becomes an issue, a binary sea=
rch
> > > could be done instead (or some kind of hash lookup).
> > >=20
> > > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > > ---
> > >=20
> > > =C2=A0drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++=
++++++-
> > > =C2=A01 file changed, 321 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> > > index 3db4d4b30022..c963bc5452ba 100644
> > > --- a/drivers/hwmon/iio_hwmon.c
> > > +++ b/drivers/hwmon/iio_hwmon.c
> > > @@ -8,6 +8,7 @@
> > > =C2=A0#include <linux/slab.h>
> > > =C2=A0#include <linux/mod_devicetable.h>
> > > =C2=A0#include <linux/module.h>
> > > +#include <linux/notifier.h>
> > > =C2=A0#include <linux/err.h>
> > > =C2=A0#include <linux/platform_device.h>
> > > =C2=A0#include <linux/property.h>
> > > @@ -15,7 +16,192 @@
> > > =C2=A0#include <linux/hwmon.h>
> > > =C2=A0#include <linux/hwmon-sysfs.h>
> > > =C2=A0#include <linux/iio/consumer.h>
> > > +#include <linux/iio/events.h>
> > > +#include <linux/iio/iio.h>
> > > =C2=A0#include <linux/iio/types.h>
> > > +#include <uapi/linux/iio/events.h>
> > > +
> > > +/* Protects iio_hwmon_listeners and listeners' refcnt */
> > > +DEFINE_MUTEX(iio_hwmon_listener_lock);
> > > +LIST_HEAD(iio_hwmon_listeners);
> > > +
> > > +/**
> > > + * struct iio_hwmon_listener - Listener for IIO events
> > > + * @block: Notifier for events
> > > + * @ids: Array of IIO event ids, one per alarm
> > > + * @alarms: Bitmap of alarms
> > > + * @num_alarms: Length of @ids and @alarms
> > > + * @indio_dev: Device we are listening to
> > > + * @list: List of all listeners
> > > + * @refcnt: Reference count
> > > + */
> > > +struct iio_hwmon_listener {
> > > +	struct notifier_block block;
> > > +	u64 *ids;
> > > +	unsigned long *alarms;
> > > +	size_t num_alarms;
> > > +
> > > +	struct iio_dev *indio_dev;
> > > +	struct list_head list;
> > > +	unsigned int refcnt;
> > > +};
> > > +
> > > +/**
> > > + * iio_hwmon_lookup_alarm() - Find an alarm by id
> > > + * @listener: Event listener
> > > + * @id: IIO event id
> > > + *
> > > + * Return: index of @id in @listener->ids, or -1 if not found
> > > + */
> > > +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *lis=
tener,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 id)
> > > +{
> > > +	ssize_t i;
> > > +
> > > +	for (i =3D 0; i < listener->num_alarms; i++)
> > > +		if (listener->ids[i] =3D=3D id)
> > > +			return i;
> > > +
> > > +	return -1;
> > > +}
> > > +
> > > +static int iio_hwmon_listener_callback(struct notifier_block *block,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long action, void =
*data)
> > > +{
> > > +	struct iio_hwmon_listener *listener =3D
> > > +		container_of(block, struct iio_hwmon_listener, block);
> > > +	struct iio_event_data *ev =3D data;
> > > +	ssize_t i;
> > > +
> > > +	if (action !=3D IIO_NOTIFY_EVENT)
> > > +		return NOTIFY_DONE;
> > > +
> > > +	i =3D iio_hwmon_lookup_alarm(listener, ev->id);
> > > +	if (i >=3D 0)
> > > +		set_bit(i, listener->alarms);
> > > +	else
> > > +		dev_warn_once(&listener->indio_dev->dev,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "unknown event %016llx\n", ev->id)=
;
> > > +
> > > +	return NOTIFY_DONE;
> > > +}
> > > +
> > > +/**
> > > + * iio_event_id() - Calculate an IIO event id
> > > + * @channel: IIO channel for this event
> > > + * @type: Event type (theshold, rate-of-change, etc.)
> > > + * @dir: Event direction (rising, falling, etc.)
> > > + *
> > > + * Return: IIO event id corresponding to this event's IIO id
> > > + */
> > > +static u64 iio_event_id(struct iio_chan_spec const *chan,
> > > +			enum iio_event_type type,
> > > +			enum iio_event_direction dir)
> > > +{
> > > +	if (chan->differential)
> > > +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
> > > +					=C2=A0=C2=A0 chan->channel2, type, dir);
> > > +	if (chan->modified)
> > > +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
> > > +					=C2=A0 chan->channel2, type, dir);
> > > +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
> > > +}
> > > +
> > > +/**
> > > + * iio_hwmon_listener_get() - Get a listener for an IIO device
> > > + * @indio_dev: IIO device to listen to
> > > + *
> > > + * Look up or create a new listener for @indio_dev. The returned lis=
tener is
> > > + * registered with @indio_dev, but events still need to be manually =
enabled.
> > > + * You must call iio_hwmon_listener_put() when you are done.
> > > + *
> > > + * Return: Listener for @indio_dev, or an error pointer
> > > + */
> > > +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_=
dev
> > > *indio_dev)
> > > +{
> > > +	struct iio_hwmon_listener *listener;
> > > +	int err =3D -ENOMEM;
> > > +	size_t i, j;
> > > +
> > > +	guard(mutex)(&iio_hwmon_listener_lock);
> > > +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> > > +		if (listener->indio_dev =3D=3D indio_dev) {
> > > +			if (likely(listener->refcnt !=3D UINT_MAX))
> > > +				listener->refcnt++;
> >=20
> > I dunno for the above to ever happen :).
>=20
> Well, I can remove it if you like.
>=20
> > And as Andy stated, let's just use proper refcount APIs.
>=20
> No point in using atomic ops if they are only accessed under a mutex.

Not the point... If there are proper APIs for handling things like this, no=
t sure why
not using and then coming up with things like the above? And the same goes =
to the
release path.

- Nuno S=C3=A1
=20
>=20
> > > +			return listener;
> > > +		}
> > > +	}
> > > +
> > > +	listener =3D kzalloc(sizeof(*listener), GFP_KERNEL);
> > > +	if (!listener)
> > > +		goto err_unlock;
> > > +
> > > +	listener->refcnt =3D 1;
> > > +	listener->indio_dev =3D indio_dev;
> > > +	listener->block.notifier_call =3D iio_hwmon_listener_callback;
> > > +	for (i =3D 0; i < indio_dev->num_channels; i++)
> > > +		listener->num_alarms +=3D indio_dev-
> > > > channels[i].num_event_specs;
> > > +
> > > +	listener->ids =3D kcalloc(listener->num_alarms, sizeof(*listener->i=
ds),
> > > +				GFP_KERNEL);
> > > +	listener->alarms =3D bitmap_zalloc(listener->num_alarms, GFP_KERNEL=
);
> > > +	if (!listener->ids || !listener->alarms)
> > > +		goto err_listener;
> > > +
> > > +	i =3D 0;
> > > +	for (j =3D 0; j < indio_dev->num_channels; j++) {
> > > +		struct iio_chan_spec const *chan =3D &indio_dev->channels[j];
> > > +		size_t k;
> > > +
> > > +		for (k =3D 0; k < chan->num_event_specs; k++)
> > > +			listener->ids[i++] =3D
> > > +				iio_event_id(chan, chan->event_spec[k].type,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 chan->event_spec[k].dir);
> > > +	}
> > > +
> > > +	err =3D iio_event_register(indio_dev, &listener->block);
> > > +	if (err)
> > > +		goto err_alarms;
> > > +
> > > +	list_add(&listener->list, &iio_hwmon_listeners);
> > > +	mutex_unlock(&iio_hwmon_listener_lock);
> > > +	return listener;
> > > +
> > > +err_alarms:
> > > +	kfree(listener->alarms);
> > > +	kfree(listener->ids);
> > > +err_listener:
> > > +	kfree(listener);
> > > +err_unlock:
> > > +	mutex_unlock(&iio_hwmon_listener_lock);
> > > +	return ERR_PTR(err);
> > > +}
> > > +
> > > +/**
> > > + * iio_hwmon_listener_put() - Release a listener
> > > + * @data: &struct iio_hwmon_listener to release
> > > + *
> > > + * For convenience, @data is void.
> > > + */
> > > +static void iio_hwmon_listener_put(void *data)
> > > +{
> > > +	struct iio_hwmon_listener *listener =3D data;
> > > +
> > > +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> > > +		if (unlikely(listener->refcnt =3D=3D UINT_MAX))
> > > +			return;
> > > +
> > > +		if (--listener->refcnt)
> > > +			return;
> > > +
> > > +		list_del(&listener->list);
> > > +		iio_event_unregister(listener->indio_dev, &listener->block);
> > > +	}
> > > +
> > > +	kfree(listener->alarms);
> > > +	kfree(listener->ids);
> > > +	kfree(listener);
> > > +}
> > > =C2=A0
> > > =C2=A0/**
> > > =C2=A0 * struct iio_hwmon_state - device instance state
> > > @@ -143,6 +329,68 @@ static ssize_t iio_hwmon_write_event(struct devi=
ce *dev,
> > > =C2=A0	return count;
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * struct iio_hwmon_alarm_attribute - IIO HWMON alarm attribute
> > > + * @dev_attr: Base device attribute
> > > + * @listener: Listener for this alarm
> > > + * @index: Index of the channel in the IIO HWMON
> > > + * @alarm: Index of the alarm within @listener
> > > + */
> > > +struct iio_hwmon_alarm_attribute {
> > > +	struct device_attribute dev_attr;
> > > +	struct iio_hwmon_listener *listener;
> > > +	size_t index;
> > > +	size_t alarm;
> > > +};
> > > +#define to_alarm_attr(_dev_attr) \
> > > +	container_of(_dev_attr, struct iio_hwmon_alarm_attribute, dev_attr)
> > > +
> > > +/**
> > > + * iio_hwmon_alarm_toggle() - Turn an event off and back on again
> > > + * @chan: Channel of the event
> > > + * @dir: Event direction (rising, falling, etc.)
> > > + *
> > > + * Toggle an event's enable so we get notified if the alarm is alrea=
dy
> > > + * triggered. We use this to convert IIO's event-triggered events in=
to
> > > + * level-triggered alarms.
> > > + *
> > > + * Return: 0 on success or negative error on failure
> > > + */
> > > +static int iio_hwmon_alarm_toggle(struct iio_channel *chan,
> > > +				=C2=A0 enum iio_event_direction dir)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, d=
ir,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE, 0, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, di=
r,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE, 1, 1);
> > > +}
> > > +
> > > +static ssize_t iio_hwmon_read_alarm(struct device *dev,
> > > +				=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> > > +				=C2=A0=C2=A0=C2=A0 char *buf)
> > > +{
> > > +	struct iio_hwmon_alarm_attribute *sattr =3D to_alarm_attr(attr);
> > > +	struct iio_hwmon_state *state =3D dev_get_drvdata(dev);
> > > +	struct iio_channel *chan =3D &state->channels[sattr->index];
> > > +
> > > +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
> > > +		u64 id =3D sattr->listener->ids[sattr->alarm];
> > > +		enum iio_event_direction dir =3D
> > > IIO_EVENT_CODE_EXTRACT_DIR(id);
> > > +
> > > +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
> >=20
> > WARN_ON() is highly discouraged... Also do we really need a "scary" spl=
at in
> > this case?
>=20
> OK, maybe dev_warn then. I don't want to propagate the error because I th=
ink
> it's more important to tell userspace that the alarm went off than if the=
re
> was a problem determining if the alarm is still active.
>=20
> > > +		strcpy(buf, "1\n");
> > > +		return 2;
> > > +	}
> > > +
> > > +	strcpy(buf, "0\n");
> > > +	return 2;
> >=20
> > As stated, sysfs_emit()
> >=20
> > > +}
> > > +
> > > =C2=A0static int add_device_attr(struct device *dev, struct iio_hwmon=
_state *st,
> > > =C2=A0			=C2=A0=C2=A0 ssize_t (*show)(struct device *dev,
> > > =C2=A0					=C2=A0=C2=A0 struct device_attribute *attr,
> > > @@ -205,6 +453,63 @@ static int add_event_attr(struct device *dev, st=
ruct
> > > iio_hwmon_state *st,
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state=
 *st,
> > > +			=C2=A0 int i, enum iio_event_direction dir,
> > > +			=C2=A0 const char *fmt, ...)
> > > +{
> > > +	struct iio_hwmon_alarm_attribute *a;
> > > +	struct iio_hwmon_listener *listener;
> > > +	ssize_t alarm;
> > > +	umode_t mode;
> > > +	va_list ap;
> > > +	int ret;
> > > +
> > > +	mode =3D iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE);
> > > +	if (!(mode & 0200))
> > > +		return 0;
> > > +
> > > +	listener =3D iio_hwmon_listener_get(st->channels[i].indio_dev);
> > > +	if (listener =3D=3D ERR_PTR(-EBUSY))
> > > +		return 0;
> >=20
> > Maybe I missed something, where can we get -EBUSY? And should we ignore=
 it?
>=20
> Oh, this was from before I refactored the notification API to allow kerne=
l
> consumers to co-exist with userspace ones. So this can't occur.
>=20
> > > +	if (IS_ERR(listener))
> > > +		return PTR_ERR(listener);
> > > +
> > > +	ret =3D devm_add_action_or_reset(dev, iio_hwmon_listener_put,
> > > listener);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	alarm =3D iio_hwmon_lookup_alarm(listener,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_event_id(st->channels[i=
].channel,
> > > +						=C2=A0=C2=A0=C2=A0 IIO_EV_TYPE_THRESH,
> > > dir));
> > > +	if (WARN_ON_ONCE(alarm < 0))
> > > +		return -ENOENT;
> > > +
> >=20
> > Again, I would drop WARN_ON_ONCE()
>=20
> This can only occur if there is a bug in the kernel. We should have retur=
ned
> 0 from iio_event_mode() before we get to this point.
>=20
> --Sean



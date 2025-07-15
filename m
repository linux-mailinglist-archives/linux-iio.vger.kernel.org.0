Return-Path: <linux-iio+bounces-21684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF8B058C6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 13:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B241892B30
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACB2DC339;
	Tue, 15 Jul 2025 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib3eX1gv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462E2D77FA;
	Tue, 15 Jul 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578922; cv=none; b=TYFfmfoFD8cFmeQBPT3a02JtQ8OZ+MYr9Ljqqk2Z1rAGGZF1u9sq4EZccqL+H0WjaQ1dkhmKwbPY8Vm3zfM+7zs5FVy7qQk+MV2iaGKTFPBVEQhNcd1wr8WEzfLcdVGYrkP02YJYdUPsf27r5oMqUiXM2qLIn9X7RQ1YW1fa+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578922; c=relaxed/simple;
	bh=OP/yxHB3whCpFT/BDrjnPkL4qg64bbUvdHdFA0F/XNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0p6ZEoLcOGrQEvk4ynwpHIKbov7oSDWyamAiAHN9rODRUOgiwBJ2TzMeUGfp0ZlRgd6S2EhVPBThnPS0wY7Ck1LQjWshFJ9NEU+764xXrbthY9LMu1Se4RWFKpoUEEslLUPg22kIj58VX2Tb00nqW2yQYTzZlYtgKRe7jqcM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib3eX1gv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so4088863f8f.1;
        Tue, 15 Jul 2025 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578918; x=1753183718; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEsLK+ghEC6eO+i2NK3f6q9c/YNeo8kIWchpLFVUniY=;
        b=ib3eX1gvdMl7JoeYbVU2ZWhgqiWjGvP7GtSa6Bilir6/UIJF4W8erBdOaXjEMqHnMM
         XR6d5xFU55eLe0FlIiKJSIRhguolQn7TS6teGqn1QfDhjdgVkOG3uBp4D08efve1gpce
         yXzz116AA3IIqE4wIG/Mk5wx6Ovusb9oy3t/BG3qIa9Dr4VBeq/I0uwYP/rUTROm0QTT
         Kk4ulEWF9uo58cOnyL3RH/4J6UPr0iAxtc7BNZ4zsf9vaXNEw0wrzOPYCLoXcfLOTvxW
         aZlhxS8SSe+/LFs3SqSOki/uJi/NyzK19GLJ6nkOo2FV8FvxDFiWBG1u2BqCxKZpIK3k
         xPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578918; x=1753183718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEsLK+ghEC6eO+i2NK3f6q9c/YNeo8kIWchpLFVUniY=;
        b=vKYDLG7itD0pBDOXzbFQvNk7u27HdSNWHjSrjGegYxaqW+sdqljxjIzGDmkGRbgQS6
         rM7qgIkWfOcHYCZXFKg1Hh8wwCmerY5WHjaD3IBOm0fZwBiUETEqDM+ZNXiZe56nuxig
         TRo2uQ1/dRsSPExXtGf8wZ7UCUE149YMAxkrEJaohTCFk/HR+UWVMNenfQy2TgmsuS92
         yozXonSE2AQ0kktlj3dxeb5x/t+RgUPkPN5Zo/0w3fRck3KWy7uxbAcHQFqsBG9tD5XI
         4raEEHhaI21bFnLOCbO4gi38WcVaBzGqyAq+CK2YHVeix0zLbHgcJyLjg4g0XEBBzbZe
         FKCg==
X-Forwarded-Encrypted: i=1; AJvYcCUSSRTn2HR52cn64PdEy2XrnFVN7aWRrubGeOL0Kazf9J3oJ6eRGEnhBAvpoPVMFYlY5IdtYkU6BQGDXhLN@vger.kernel.org, AJvYcCWVuYT7DCltWVqI0yj5tH32xzdh8/wjXHqM3lLs9MBaYscSKRrsjlP+os2jRsL1QmwNAzGpu6Y8wn7F9A==@vger.kernel.org, AJvYcCWWq0wZvll+WyMrOG9iuEP26EOg+J2lR4BqUfbl4myKKL/kQcIIHadmhZr6jBTN7qnuFtCkRTOcQYBY@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzAHxuv2pfGZpbdvwEK8DL+9igu+O2NOkWx0/9qkwjWbHjlMX
	ABudW0Lq4mmFrHvJcbLnG5NZsZTFNrtUvz7ZduM3RCj2GMxhwtqhgGBk
X-Gm-Gg: ASbGncvyBk2+9gilh2ZQ1kzXcfo5mLAyt2AoJ4s4mx6RA/wR+e41Jo7MFAmLYJyXff6
	O7m1ilKGCwnzlHsn66lLeeQQlH6NUhNnomXqLckhzZfBTrvOuksM+Sapv0qUf+DY3hlQg0JIlNt
	bP6ID5b5IohKB7ox66na9rRUEj2PTjcQKqWyZlLXGH9PPBwsUYGDkxKnk4iWDlGYlq3ShAPpxCK
	b6LqcWrjylPEw4BKoBNi9PcrQI3O8W4tLJvYASnT5b7gRQoHoiFr1XdQ3f90/oQqbrGf4brRE84
	zZB0rVhBy8W/n2kXy7kKE+ZsssHp8H4ryO3LWzC/8PJ0Xlzr323IQn7+u8ORMEzRb97t+f5+wq6
	YpWA6ca2pejnkKv/43qPZdw==
X-Google-Smtp-Source: AGHT+IGB/O5bFadZ2WlLmxAjZuj2rHDROBWg0nG1av0JI51vsPD3t2CW3Ew7VwORg9jx99cM3B93MQ==
X-Received: by 2002:a05:6000:491e:b0:3b5:e6f3:f825 with SMTP id ffacd0b85a97d-3b60a15b155mr1944745f8f.23.1752578917903;
        Tue, 15 Jul 2025 04:28:37 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2fasm14678872f8f.77.2025.07.15.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:37 -0700 (PDT)
Message-ID: <afc6aa6ad4b633f9d834acf933734985f14c5563.camel@gmail.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
 <jic23@kernel.org>,  Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-iio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Tue, 15 Jul 2025 12:28:50 +0100
In-Reply-To: <20250715012023.2050178-8-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	 <20250715012023.2050178-8-sean.anderson@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
> Add alarm support based on IIO threshold events. The alarm is cleared on
> read, but will be set again if the condition is still present. This is
> detected by disabling and re-enabling the event. The same trick is done
> when creating the attribute to detect already-triggered events.
>=20
> The alarms are updated by an event listener. To keep the notifier call
> chain short, we create one listener per iio device, shared across all
> hwmon devices.
>=20
> To avoid dynamic creation of alarms, alarms for all possible events are
> allocated at creation. Lookup is done by a linear scan, as I expect
> events to occur rarely. If performance becomes an issue, a binary search
> could be done instead (or some kind of hash lookup).
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> =C2=A0drivers/hwmon/iio_hwmon.c | 322 +++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 321 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 3db4d4b30022..c963bc5452ba 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/notifier.h>
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/property.h>
> @@ -15,7 +16,192 @@
> =C2=A0#include <linux/hwmon.h>
> =C2=A0#include <linux/hwmon-sysfs.h>
> =C2=A0#include <linux/iio/consumer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/types.h>
> +#include <uapi/linux/iio/events.h>
> +
> +/* Protects iio_hwmon_listeners and listeners' refcnt */
> +DEFINE_MUTEX(iio_hwmon_listener_lock);
> +LIST_HEAD(iio_hwmon_listeners);
> +
> +/**
> + * struct iio_hwmon_listener - Listener for IIO events
> + * @block: Notifier for events
> + * @ids: Array of IIO event ids, one per alarm
> + * @alarms: Bitmap of alarms
> + * @num_alarms: Length of @ids and @alarms
> + * @indio_dev: Device we are listening to
> + * @list: List of all listeners
> + * @refcnt: Reference count
> + */
> +struct iio_hwmon_listener {
> +	struct notifier_block block;
> +	u64 *ids;
> +	unsigned long *alarms;
> +	size_t num_alarms;
> +
> +	struct iio_dev *indio_dev;
> +	struct list_head list;
> +	unsigned int refcnt;
> +};
> +
> +/**
> + * iio_hwmon_lookup_alarm() - Find an alarm by id
> + * @listener: Event listener
> + * @id: IIO event id
> + *
> + * Return: index of @id in @listener->ids, or -1 if not found
> + */
> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listene=
r,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 id)
> +{
> +	ssize_t i;
> +
> +	for (i =3D 0; i < listener->num_alarms; i++)
> +		if (listener->ids[i] =3D=3D id)
> +			return i;
> +
> +	return -1;
> +}
> +
> +static int iio_hwmon_listener_callback(struct notifier_block *block,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long action, void *dat=
a)
> +{
> +	struct iio_hwmon_listener *listener =3D
> +		container_of(block, struct iio_hwmon_listener, block);
> +	struct iio_event_data *ev =3D data;
> +	ssize_t i;
> +
> +	if (action !=3D IIO_NOTIFY_EVENT)
> +		return NOTIFY_DONE;
> +
> +	i =3D iio_hwmon_lookup_alarm(listener, ev->id);
> +	if (i >=3D 0)
> +		set_bit(i, listener->alarms);
> +	else
> +		dev_warn_once(&listener->indio_dev->dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "unknown event %016llx\n", ev->id);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/**
> + * iio_event_id() - Calculate an IIO event id
> + * @channel: IIO channel for this event
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + *
> + * Return: IIO event id corresponding to this event's IIO id
> + */
> +static u64 iio_event_id(struct iio_chan_spec const *chan,
> +			enum iio_event_type type,
> +			enum iio_event_direction dir)
> +{
> +	if (chan->differential)
> +		return IIO_DIFF_EVENT_CODE(chan->type, chan->channel,
> +					=C2=A0=C2=A0 chan->channel2, type, dir);
> +	if (chan->modified)
> +		return IIO_MOD_EVENT_CODE(chan->type, chan->channel,
> +					=C2=A0 chan->channel2, type, dir);
> +	return IIO_UNMOD_EVENT_CODE(chan->type, chan->channel, type, dir);
> +}
> +
> +/**
> + * iio_hwmon_listener_get() - Get a listener for an IIO device
> + * @indio_dev: IIO device to listen to
> + *
> + * Look up or create a new listener for @indio_dev. The returned listene=
r is
> + * registered with @indio_dev, but events still need to be manually enab=
led.
> + * You must call iio_hwmon_listener_put() when you are done.
> + *
> + * Return: Listener for @indio_dev, or an error pointer
> + */
> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev
> *indio_dev)
> +{
> +	struct iio_hwmon_listener *listener;
> +	int err =3D -ENOMEM;
> +	size_t i, j;
> +
> +	guard(mutex)(&iio_hwmon_listener_lock);
> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> +		if (listener->indio_dev =3D=3D indio_dev) {
> +			if (likely(listener->refcnt !=3D UINT_MAX))
> +				listener->refcnt++;

I dunno for the above to ever happen :). And as Andy stated, let's just use
proper refcount APIs.
> +			return listener;
> +		}
> +	}
> +
> +	listener =3D kzalloc(sizeof(*listener), GFP_KERNEL);
> +	if (!listener)
> +		goto err_unlock;
> +
> +	listener->refcnt =3D 1;
> +	listener->indio_dev =3D indio_dev;
> +	listener->block.notifier_call =3D iio_hwmon_listener_callback;
> +	for (i =3D 0; i < indio_dev->num_channels; i++)
> +		listener->num_alarms +=3D indio_dev-
> >channels[i].num_event_specs;
> +
> +	listener->ids =3D kcalloc(listener->num_alarms, sizeof(*listener->ids),
> +				GFP_KERNEL);
> +	listener->alarms =3D bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
> +	if (!listener->ids || !listener->alarms)
> +		goto err_listener;
> +
> +	i =3D 0;
> +	for (j =3D 0; j < indio_dev->num_channels; j++) {
> +		struct iio_chan_spec const *chan =3D &indio_dev->channels[j];
> +		size_t k;
> +
> +		for (k =3D 0; k < chan->num_event_specs; k++)
> +			listener->ids[i++] =3D
> +				iio_event_id(chan, chan->event_spec[k].type,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 chan->event_spec[k].dir);
> +	}
> +
> +	err =3D iio_event_register(indio_dev, &listener->block);
> +	if (err)
> +		goto err_alarms;
> +
> +	list_add(&listener->list, &iio_hwmon_listeners);
> +	mutex_unlock(&iio_hwmon_listener_lock);
> +	return listener;
> +
> +err_alarms:
> +	kfree(listener->alarms);
> +	kfree(listener->ids);
> +err_listener:
> +	kfree(listener);
> +err_unlock:
> +	mutex_unlock(&iio_hwmon_listener_lock);
> +	return ERR_PTR(err);
> +}
> +
> +/**
> + * iio_hwmon_listener_put() - Release a listener
> + * @data: &struct iio_hwmon_listener to release
> + *
> + * For convenience, @data is void.
> + */
> +static void iio_hwmon_listener_put(void *data)
> +{
> +	struct iio_hwmon_listener *listener =3D data;
> +
> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> +		if (unlikely(listener->refcnt =3D=3D UINT_MAX))
> +			return;
> +
> +		if (--listener->refcnt)
> +			return;
> +
> +		list_del(&listener->list);
> +		iio_event_unregister(listener->indio_dev, &listener->block);
> +	}
> +
> +	kfree(listener->alarms);
> +	kfree(listener->ids);
> +	kfree(listener);
> +}
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct iio_hwmon_state - device instance state
> @@ -143,6 +329,68 @@ static ssize_t iio_hwmon_write_event(struct device *=
dev,
> =C2=A0	return count;
> =C2=A0}
> =C2=A0
> +/**
> + * struct iio_hwmon_alarm_attribute - IIO HWMON alarm attribute
> + * @dev_attr: Base device attribute
> + * @listener: Listener for this alarm
> + * @index: Index of the channel in the IIO HWMON
> + * @alarm: Index of the alarm within @listener
> + */
> +struct iio_hwmon_alarm_attribute {
> +	struct device_attribute dev_attr;
> +	struct iio_hwmon_listener *listener;
> +	size_t index;
> +	size_t alarm;
> +};
> +#define to_alarm_attr(_dev_attr) \
> +	container_of(_dev_attr, struct iio_hwmon_alarm_attribute, dev_attr)
> +
> +/**
> + * iio_hwmon_alarm_toggle() - Turn an event off and back on again
> + * @chan: Channel of the event
> + * @dir: Event direction (rising, falling, etc.)
> + *
> + * Toggle an event's enable so we get notified if the alarm is already
> + * triggered. We use this to convert IIO's event-triggered events into
> + * level-triggered alarms.
> + *
> + * Return: 0 on success or negative error on failure
> + */
> +static int iio_hwmon_alarm_toggle(struct iio_channel *chan,
> +				=C2=A0 enum iio_event_direction dir)
> +{
> +	int ret;
> +
> +	ret =3D iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE, 0, 1);
> +	if (ret)
> +		return ret;
> +
> +	return iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH, dir,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE, 1, 1);
> +}
> +
> +static ssize_t iio_hwmon_read_alarm(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> +				=C2=A0=C2=A0=C2=A0 char *buf)
> +{
> +	struct iio_hwmon_alarm_attribute *sattr =3D to_alarm_attr(attr);
> +	struct iio_hwmon_state *state =3D dev_get_drvdata(dev);
> +	struct iio_channel *chan =3D &state->channels[sattr->index];
> +
> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
> +		u64 id =3D sattr->listener->ids[sattr->alarm];
> +		enum iio_event_direction dir =3D
> IIO_EVENT_CODE_EXTRACT_DIR(id);
> +
> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));

WARN_ON() is highly discouraged... Also do we really need a "scary" splat i=
n
this case?

> +		strcpy(buf, "1\n");
> +		return 2;
> +	}
> +
> +	strcpy(buf, "0\n");
> +	return 2;

As stated, sysfs_emit()

> +}
> +
> =C2=A0static int add_device_attr(struct device *dev, struct iio_hwmon_sta=
te *st,
> =C2=A0			=C2=A0=C2=A0 ssize_t (*show)(struct device *dev,
> =C2=A0					=C2=A0=C2=A0 struct device_attribute *attr,
> @@ -205,6 +453,63 @@ static int add_event_attr(struct device *dev, struct
> iio_hwmon_state *st,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state *st=
,
> +			=C2=A0 int i, enum iio_event_direction dir,
> +			=C2=A0 const char *fmt, ...)
> +{
> +	struct iio_hwmon_alarm_attribute *a;
> +	struct iio_hwmon_listener *listener;
> +	ssize_t alarm;
> +	umode_t mode;
> +	va_list ap;
> +	int ret;
> +
> +	mode =3D iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_EV_INFO_ENABLE);
> +	if (!(mode & 0200))
> +		return 0;
> +
> +	listener =3D iio_hwmon_listener_get(st->channels[i].indio_dev);
> +	if (listener =3D=3D ERR_PTR(-EBUSY))
> +		return 0;

Maybe I missed something, where can we get -EBUSY? And should we ignore it?

> +	if (IS_ERR(listener))
> +		return PTR_ERR(listener);
> +
> +	ret =3D devm_add_action_or_reset(dev, iio_hwmon_listener_put,
> listener);
> +	if (ret)
> +		return ret;
> +
> +	alarm =3D iio_hwmon_lookup_alarm(listener,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_event_id(st->channels[i].ch=
annel,
> +						=C2=A0=C2=A0=C2=A0 IIO_EV_TYPE_THRESH,
> dir));
> +	if (WARN_ON_ONCE(alarm < 0))
> +		return -ENOENT;
> +

Again, I would drop WARN_ON_ONCE()

- Nuno S=C3=A1


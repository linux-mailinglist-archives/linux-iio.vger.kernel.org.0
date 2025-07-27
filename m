Return-Path: <linux-iio+bounces-22060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7BEB130C5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5051D1893CC4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901821C9E4;
	Sun, 27 Jul 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chejRhEN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B63987D;
	Sun, 27 Jul 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635062; cv=none; b=QFMVP57GhBgBa5UuxmCGhIhGTSN2+zIEoSF0EXPSbFIWFXPso2jAVA+3L25v/nSCJ6vgO/Vliba0Uoxc/WIJggeG4i7IA77+zpI582R6apB3kOyVpWmDXhl2rRDUqYfGVaEXTwtGDZQJGuRb9g8BFSfRO/7ZMh8wRFWNbE9o258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635062; c=relaxed/simple;
	bh=GcLotRRFKpiryxCYYUskJ/EU6iN+8JpJsTK6r+GKZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvqYQKJPdWfr3jCh4P3SoV99sc3sWOnbq1s4HgZPXEeZtkodXqMobpTRN9mmkBsU8E1xBdji/tD+bUdAXx9i1z7ni3xDNdLZk2uZoH6Y1FX3MCkMIQn75+2a1C+VCUlNJ/YcftnRkpiglbwJLiRm4N36rKqHbiHNcgBfstPPP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chejRhEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA25C4CEEB;
	Sun, 27 Jul 2025 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753635061;
	bh=GcLotRRFKpiryxCYYUskJ/EU6iN+8JpJsTK6r+GKZ9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chejRhENsqXhWyaOHak9S45wee3W1oAWCQeVRnzaym/EOxeB7o0NU/6hRrmE+3YYk
	 RFO7hLCEwNSAQxQkI6IxNJPDhDbfCqSvFSHObwtFe1s/NqFK8br7pUtnorzQuVhQYC
	 BT5AuKbHG41CG+LMSkqM5t7gaUcRLrfpRTTZsD9EI68VAJl+Z7T0dGj6PUA9A54Mdi
	 Hq2bFOxU+BegcKommdbHC1E5Liq0MHgUjvj3SQTVzTh5N5b5dPO4dXvQ4f6RkIelxF
	 G2RFzHCU4uCtRSB3lXDJnvsWvI3zqCTdlmSkcOfifuQmKBY/Sc3A1OpFQ3vEQNodz9
	 naInZ7d0wPHiw==
Date: Sun, 27 Jul 2025 17:50:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <20250727175054.54fe5629@jic23-huawei>
In-Reply-To: <20250715012023.2050178-8-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-8-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 21:20:23 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Add alarm support based on IIO threshold events. The alarm is cleared on
> read, but will be set again if the condition is still present. This is
> detected by disabling and re-enabling the event. The same trick is done
> when creating the attribute to detect already-triggered events.
> 
> The alarms are updated by an event listener. To keep the notifier call
> chain short, we create one listener per iio device, shared across all
> hwmon devices.
> 
> To avoid dynamic creation of alarms, alarms for all possible events are
> allocated at creation. Lookup is done by a linear scan, as I expect
> events to occur rarely. If performance becomes an issue, a binary search
> could be done instead (or some kind of hash lookup).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

A few minor comments inline.

Thanks,

Jonathan

> + * iio_hwmon_listener_get() - Get a listener for an IIO device
> + * @indio_dev: IIO device to listen to
> + *
> + * Look up or create a new listener for @indio_dev. The returned listener is
> + * registered with @indio_dev, but events still need to be manually enabled.
> + * You must call iio_hwmon_listener_put() when you are done.
> + *
> + * Return: Listener for @indio_dev, or an error pointer
> + */
> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev *indio_dev)
> +{
> +	struct iio_hwmon_listener *listener;
> +	int err = -ENOMEM;
> +	size_t i, j;
> +
> +	guard(mutex)(&iio_hwmon_listener_lock);

Guard + unlock.  However, in general combining cleanup.h stuff and
gotos is a bad idea.  You might better off wrapping a function
with the lock in the outer function

Alternative, use local variables for ids and alarms.  Use __free()
on those + return_ptr(listener) and no_free_ptr() as you assign
the elements of listener after there is no possibility of error.


> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
> +		if (listener->indio_dev == indio_dev) {
Deep nest.  I'd do
		if (listener->indio_dev != indio-dev)
			continue;

		if (likely(listener->refcnt != UINT_MAX)
//Needs a comment on why this make sense as opposed to returning an error.

			listener->refcnt++;
		return listener;
> +			if (likely(listener->refcnt != UINT_MAX))
> +				listener->refcnt++;
> +			return listener;
> +		}
> +	}
> +
> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
> +	if (!listener)
> +		goto err_unlock;
> +
> +	listener->refcnt = 1;
> +	listener->indio_dev = indio_dev;
> +	listener->block.notifier_call = iio_hwmon_listener_callback;
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		listener->num_alarms += indio_dev->channels[i].num_event_specs;
> +
> +	listener->ids = kcalloc(listener->num_alarms, sizeof(*listener->ids),
> +				GFP_KERNEL);
> +	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
> +	if (!listener->ids || !listener->alarms)
> +		goto err_listener;

I'd prefer this split into a pair of checks and separate labels.

> +
> +	i = 0;
> +	for (j = 0; j < indio_dev->num_channels; j++) {
> +		struct iio_chan_spec const *chan = &indio_dev->channels[j];
> +		size_t k;
> +
> +		for (k = 0; k < chan->num_event_specs; k++)
> +			listener->ids[i++] =
> +				iio_event_id(chan, chan->event_spec[k].type,
> +					     chan->event_spec[k].dir);
> +	}
> +
> +	err = iio_event_register(indio_dev, &listener->block);
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

Maybe use a kref and kref_put() with a suitable release to
do the cleanup.

> + * @data: &struct iio_hwmon_listener to release
> + *
> + * For convenience, @data is void.
> + */
> +static void iio_hwmon_listener_put(void *data)
> +{
> +	struct iio_hwmon_listener *listener = data;
> +
> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
> +		if (unlikely(listener->refcnt == UINT_MAX))
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
>


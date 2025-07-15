Return-Path: <linux-iio+bounces-21683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FAB05874
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61823A637B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319F2D6400;
	Tue, 15 Jul 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j70/9X2H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E513B7A3;
	Tue, 15 Jul 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577743; cv=none; b=e5g55Aaj+mNTtlfv0B5acwz/uwt3mEMC/BohcsPHJoIthwalfAbkfddy67AlF/fjX3ynSo/+C9hU74+BC9ILQAth106JMFLPLXWSxH2emeyAsGSEIQh3s768cwfPwIsRxFq6Zyivcdq9zNR+acPrHq5sdS7ab4DY32qeNbmOKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577743; c=relaxed/simple;
	bh=sBc/dGk2SunpuGidHnud/+ntCTOPh5h9YR2bCR8HyQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNdGoMeuySlxM7Wm8h7M8U/zkWN6RQjiW8b1HqSNyvl4nxZqCQRk2LctGfjPcS1mCNgJRExKXwm7jJYqzQJ8L/F7QY5EhoMtn2wZwUKX58qiPn+WIYYpb0zxC6iZcXKLIE8izD/Zc0R9sz2Wd9VN8d5vu3dGZrIuzM1YLrIg+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j70/9X2H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d6ade159so38333955e9.1;
        Tue, 15 Jul 2025 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577740; x=1753182540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lkoaFwC3o4Cjedw6YXHTEPphhFtNTv1QfnKgO5oWGDU=;
        b=j70/9X2HNQz/Hok4fkb2tdjoXlvSz6ESGhmlv0Q3Mcqlf0/8ataM2yYxD0mXfw9Crq
         JkM5BS/0lzWwoW+GzBI2NMuIqhJqY+etz7aapzHq0MEutGMybObBF5cZc0gK3el4Qavp
         rs08rNSz5Hq5aAQDTI0R0eIXkJRm4kdKaZwKkzpp3MNP3wcMRSWSxtf+VnBb8Y1CSuvi
         9H6SSlETcDGdJDhcRjCjRVkF6IoUX3KuqeuL9I35rVQCIPOgpWQMDmcC4PQP5B+64sf4
         JPJLAqW4gxSUM2YSJiRi+z+iLXJ5X9A8rIV2mDPDM1fYlQ3FOmbSWKU4InDtk7UFIEUf
         RY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577740; x=1753182540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkoaFwC3o4Cjedw6YXHTEPphhFtNTv1QfnKgO5oWGDU=;
        b=LSbzHWoX+/+w6gA5FiGpbroZLyYE4CHFuvbvllvIFVR6Ac+2NkT7nP298q4xNpsWyq
         Ohx7PYeMKKgdpIb6gaz+eIqwURsSsED64SNnZJUF8pKok7q9l8qUcQQmrYk94WNdNTW+
         m8p58hiUUJB94DHqwA0/Q9Ca4B1H/5J9reYNUwo0jLsqQn9uLk1iU5iVEAv00mtqECm5
         GzEvtWnXxXQfo4q3Cn6T0sZgIZSdrCkuNDvCX2HVcjk9A9OivjtL6E4yQe+L/0514J//
         Kk8WNb0SOuv+iCYEq1CQHg47JIyd47sACR7QnuD2BcLT82uFz/cms8abouN8YlFWcdJ4
         Bt9A==
X-Forwarded-Encrypted: i=1; AJvYcCUFkVpjEQSW2lmVCIy/hyQB+tjr+d168SXweaRfZfmOQW0Eawqo31oJ2bY9WvQc+2fId5Pm1JMqU172ZA==@vger.kernel.org, AJvYcCVANCPw5OZqQBW1t7rnOyi6Il6VvIG4ZJCtnHNDbcPkdwTcshoRAE7/g/zpoDHvc6W4ab8WF6FGH/2A@vger.kernel.org, AJvYcCVSz+qe8x0UIzrJx32c6LkmysQQDDCBIX0CR93Yo0rcSbCsua+DdDyAorGwPIxPhrhx2s5PMcNP/rkgfo/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VeBoUCK/dBMLDAREH6PSxRyWGpqth6sqmbqUN4Kz0oefypCL
	Q2m616qqRQiatWSZV9eE8aW2S/lSa+CA/HGVkuB7rfzMLVIoCenQ/LMp
X-Gm-Gg: ASbGncsf20p57rpMkc+yhSrtkPIKFSEfONSdWkyZh2jCtRmOuq0CLMC6/RV8gQO7Pc1
	/RM8QpURCfK1cmo0ppnGdz+E7mFhGX8R74rrms3PmjvJHPbuq1udW1lSCOVDdwnUAJo26ACbWS0
	Zsy7f4hLrtkwNBdj4ncNuSz1WYa9bpIZr6SrLdXbSrt8MnOR+oogoQ1IFOmaGYzcUbtHYrZDQTg
	88KqSP/G/9AJfSGzbZjWaT7S6Z3a7b0+tqkOY40kqh+SSmgBJ6w7nbWMZoYZMSmp3xjZi60dvlc
	VVr/B6hpQ3or3mBH1VQl324y0yI1gklrz5GJiGNYzNdHIE8BY3mCsrGUfPvmDD+ubrjFIXmhOg4
	lQsDFvC6Iihbah5xH0FlfQA==
X-Google-Smtp-Source: AGHT+IHPQ16eomMAsvWLTFfSGrzVFPzS9BZ7NSNAmDuKJKXd6lZFfmAoE/8Aq3KTCzDVhvh1HSpO6A==
X-Received: by 2002:a05:6000:2c09:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3b5f2dc2becmr12968879f8f.16.1752577739838;
        Tue, 15 Jul 2025 04:08:59 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45619fbcff8sm62963825e9.2.2025.07.15.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:08:59 -0700 (PDT)
Message-ID: <d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
 <jic23@kernel.org>,  Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-iio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Tue, 15 Jul 2025 12:09:12 +0100
In-Reply-To: <20250715012023.2050178-4-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	 <20250715012023.2050178-4-sean.anderson@linux.dev>
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
> Add an API to notify consumers about events. Events still need to be
> enabled using the iio_read_event/iio_write_event functions. Of course,
> userspace can also manipulate the enabled events. I don't think this is
> too much of an issue, since userspace can also manipulate the event
> thresholds. But enabling events may cause existing programs to be
> surprised when they get something unexpected. Maybe we should set the
> interface as busy when there are any in-kernel listeners?
>=20

Sensible question. I'm not that familiar with events but I suspect is not
trivial (if doable) to do a similar approach as with buffers? With buffers,=
 an
inkernal consumer get's it's own buffer object (that goes into a list of ac=
tive
buffers in the iio device) with all channels enabled and then we demux the
appropriate channels for each consumer.

Independent of the above, we can argue that having both inkernel and usersp=
ace
changing thresholds is ok (I mean, there's nothing stopping two userspace a=
pps
doing that) but we should likely be careful with enabling/disabling. If mul=
tiple
consumers enable the same event, one of them disabling it should not disabl=
e it
for all the consumers, right?

- Nuno S=C3=A1

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> =C2=A0drivers/iio/industrialio-event.c | 34 +++++++++++++++++++++++++++--=
---
> =C2=A0include/linux/iio/consumer.h=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++++++++=
+++++++++++++++++++
> =C2=A02 files changed, 59 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-
> event.c
> index 06295cfc2da8..b9e3ff1cd5c9 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -12,11 +12,13 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/kfifo.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/notifier.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include <linux/wait.h>
> +#include <linux/iio/consumer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/iio-opaque.h>
> =C2=A0#include "iio_core.h"
> @@ -26,6 +28,7 @@
> =C2=A0/**
> =C2=A0 * struct iio_event_interface - chrdev interface for an event line
> =C2=A0 * @wait:		wait queue to allow blocking reads of events
> + * @notifier:		notifier head for in-kernel event listeners
> =C2=A0 * @det_events:		list of detected events
> =C2=A0 * @dev_attr_list:	list of event interface sysfs attribute
> =C2=A0 * @flags:		file operations related flags including busy flag.
> @@ -35,6 +38,7 @@
> =C2=A0 */
> =C2=A0struct iio_event_interface {
> =C2=A0	wait_queue_head_t	wait;
> +	struct atomic_notifier_head notifier;
> =C2=A0	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
> =C2=A0
> =C2=A0	struct list_head	dev_attr_list;
> @@ -67,18 +71,19 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_=
code,
> s64 timestamp)
> =C2=A0{
> =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_=
dev);
> =C2=A0	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_inter=
face;
> -	struct iio_event_data ev;
> +	struct iio_event_data ev =3D {
> +		.id =3D ev_code,
> +		.timestamp =3D timestamp,
> +	};
> =C2=A0	int copied;
> =C2=A0
> =C2=A0	if (!ev_int)
> =C2=A0		return 0;
> =C2=A0
> +	atomic_notifier_call_chain(&ev_int->notifier, IIO_NOTIFY_EVENT, &ev);
> +
> =C2=A0	/* Does anyone care? */
> =C2=A0	if (iio_event_enabled(ev_int)) {
> -
> -		ev.id =3D ev_code;
> -		ev.timestamp =3D timestamp;
> -
> =C2=A0		copied =3D kfifo_put(&ev_int->det_events, ev);
> =C2=A0		if (copied !=3D 0)
> =C2=A0			wake_up_poll(&ev_int->wait, EPOLLIN);
> @@ -223,6 +228,25 @@ static int iio_event_getfd(struct iio_dev *indio_dev=
)
> =C2=A0	return fd;
> =C2=A0}
> =C2=A0
> +int iio_event_register(struct iio_dev *indio_dev, struct notifier_block
> *block)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
> +
> +	return atomic_notifier_chain_register(&ev_int->notifier, block);
> +}
> +EXPORT_SYMBOL_GPL(iio_event_register);
> +
> +void iio_event_unregister(struct iio_dev *indio_dev,
> +			=C2=A0 struct notifier_block *block)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
> +
> +	WARN_ON(atomic_notifier_chain_unregister(&ev_int->notifier, block));
> +}
> +EXPORT_SYMBOL_GPL(iio_event_unregister);
> +
> =C2=A0static const char * const iio_ev_type_text[] =3D {
> =C2=A0	[IIO_EV_TYPE_THRESH] =3D "thresh",
> =C2=A0	[IIO_EV_TYPE_MAG] =3D "mag",
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 16e7682474f3..9918e3f7af3d 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -507,4 +507,34 @@ int iio_write_event_processed_scale(struct iio_chann=
el
> *chan,
> =C2=A0				=C2=A0=C2=A0=C2=A0 enum iio_event_info info, int processed,
> =C2=A0				=C2=A0=C2=A0=C2=A0 unsigned int scale);
> =C2=A0
> +struct notifier_block;
> +enum iio_notifier_val {
> +	/** IIO_NOTIFY_EVENT: v is a pointer to &struct iio_event_data */
> +	IIO_NOTIFY_EVENT,
> +};
> +
> +/**
> + * iio_event_register() - Register a notifier for events
> + * @indio_dev: Device to be notified of events on
> + * @block: Notifier block to register
> + *
> + * Register a notifier for events on @indio_dev. @v will be a member of =
&enum
> + * iio_notifier_val. Notifiers will be called in atomic context. @indio_=
dev
> + * must stay valid until you call iio_event_unregister().
> + *
> + * Return: 0 on success, or -EEXIST if @block has already been registere=
d
> + */
> +int iio_event_register(struct iio_dev *indio_dev,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct notifier_block *block);
> +
> +/**
> + * iio_event_unregister() - Remove a previously-added notifier
> + * @indio_dev: Device to be notified of events on
> + * @block: Notifier previously-registered with iio_event_register()
> + *
> + * Remove a previously-added notifier.
> + */
> +void iio_event_unregister(struct iio_dev *indio_dev,
> +			=C2=A0 struct notifier_block *block);
> +
> =C2=A0#endif


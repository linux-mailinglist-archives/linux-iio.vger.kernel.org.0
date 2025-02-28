Return-Path: <linux-iio+bounces-16201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBCA49F32
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A973A69AE
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13460274269;
	Fri, 28 Feb 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="asT9qXR7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63447274242
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761073; cv=none; b=cCDErdkQmhO5vuA0o9zP3CnUgcFEVQejyX3P9gxSq3UIA/v1Ss4oVCshRRxNlAJwt80CSfG/5Ppd8dbGlKC8I1qnj5UF1piCa4UCbZwOIyZ62cBHQ0mAV5crZRT/qQZpuiOfQvXIRxsOr9/nCJYoE3G+3a48xbqU9+KdagkcdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761073; c=relaxed/simple;
	bh=qXA0c1IR/us4lTUTlJHNdr8KlfNpmil6daBUR0/wFb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hipF+k6i/0fFLGBB0TVe1wmdGmvXyvCxdVe6paxQxzzjH/3CIE4n4NQvfqYoU6clBH2z+4beOSji21dUANCfQc/ztK9ckiHgFpZdzb9bB6MnC4+4MQ9X/31K7m5Rcb6mIAIjX3czFDB7xfG0VtESbtZIJSrtGlHy0HG5198TS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=asT9qXR7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf48293ad0so39092966b.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 08:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740761070; x=1741365870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/pohaoVOYa7MLiqI6t3X8roTJn1qw8ViB7ehkN63Og=;
        b=asT9qXR7U3JZzYhRdsraoh14R6etU1THQJOuMlvLFxdXCJZm8yPoHxceEW+bFcZMSs
         CpOjK4UXGq3nz8u0kwuTxSMXsexLDIiss7ClwkVC1E5PfArkDqyEcvVv+GjC9N9ezMR6
         wm8Btsu/XDo4l+av7VuXrt7WvfuoHCdkZgT+v/cEmufbte6BxtMP3+nE0n+LegLEkoXy
         e3N8Vh3kHl/coMy1CNrzlqL5OqJNquLKvds0O2UmTIihKYRsWj4S6pKMDpwp3luIpcFq
         u1p+3eu0UN9A4SlzJ32tkCPda16Do0UNC3wqG6G0luZh0Om9GP3i1dD1WnMLDiDPY1Ut
         HGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761070; x=1741365870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/pohaoVOYa7MLiqI6t3X8roTJn1qw8ViB7ehkN63Og=;
        b=Ah5CH3/slObilJLIlqGKjykSvItcTNh7oiyp7Q4pRmA0mcFldFeydcYBCGzLyUcVjn
         HD75yYid6rmQ6N1XWRQ8bjtjz0KcTVo2oHocSTn+x2e8NEZINJx5AwEbrJfVfPkhoPBV
         S971LKn7e/D7Hyq2bptAbOqdCmr6n0Ei+chwOOBjUYEEFej/hSgH9rcuPnF4iKOjBltZ
         jFipRjUyRm+doEBzjuyAh4YcQ5ogn5mdJcMsKiXUQwNaUwZIwzV37fed6s3g44UZhgfe
         dfyLubSmefsOipuxk02/f9zheaRcw1uwEDm+N2p7mkR++f4EUXODlFy2NBIcjB450XAx
         GuVA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWs4bxe+yccTiXiwXg6pDZx3QAbrw+CfYKQaAf2wwPxM5jKGhzabGKbVDyknJYkWCKHvPllDScGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykttkDANbcoRnS0fBy0OAW1M/qI33RAzEs5jPWAGzMCQ8h53HX
	K9FI/Gjx3nfP8gAjqggfl27ESfwp/RyriXolkwkIfgkNsf1v+ITWTR5d1Mh9UA5QxL+ud5IzvKp
	h
X-Gm-Gg: ASbGncvDXuADNbXUiHbhGXp/QSHDXqyND+vIPPh9c5aFV3I4cy18yFeZfydNcTf3GEr
	yVGgk2ztJpb8nw2KjpgdsK4YeNKa2cN7VbM6MS+abj32RBpIVVWH7d4qYXt1bryRxxpTtwGZ/0z
	waplO2n6iQ6EAVHYKx5hZ5vQP3TGxiA+lS7sqFEg+C13cA/MLataNvbtIdqusCRW99y7MD+TUWM
	WD5qdpm4eb1dIlA2fMk4iFrQczTdNKIfpNFcC1z5W0PAsWR4SVMNlHew1+AdgHUgkWdQFtVpG9w
	1rZFziB0smfUv35CNO5Hxek3lWgUl1/vJj7MQ1ki+EwiFKgY817W7og+gd5nLVAc
X-Google-Smtp-Source: AGHT+IG+DO6MXCnzc/DlUfglyLe/ZcGADst0PEmKnrvnBgpbBQ4AnIFQT1EaCSqAAz8kPgNagFnWhg==
X-Received: by 2002:a17:906:7310:b0:abf:13cb:c411 with SMTP id a640c23a62f3a-abf25fabbaemr476729066b.18.1740761069411;
        Fri, 28 Feb 2025 08:44:29 -0800 (PST)
Received: from localhost (p200300f65f2c000400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c:4::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b92d3sm319704866b.12.2025.02.28.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:44:28 -0800 (PST)
Date: Fri, 28 Feb 2025 17:44:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3afczumwzxjy3taw"
Content-Disposition: inline
In-Reply-To: <20250227162823.3585810-2-david@protonic.nl>


--3afczumwzxjy3taw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
MIME-Version: 1.0

Hello David,

just a few highlevel review comments inline.

On Thu, Feb 27, 2025 at 05:28:17PM +0100, David Jander wrote:
> diff --git a/drivers/motion/motion-core.c b/drivers/motion/motion-core.c
> new file mode 100644
> index 000000000000..2963f1859e8b
> --- /dev/null
> +++ b/drivers/motion/motion-core.c
> @@ -0,0 +1,823 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Motion Control Subsystem - Core
> + *
> + * Copyright (C) 2024 Protonic Holland
> + *                    David Jander <david@protonic.nl>
> + */
> +
> +#include <asm-generic/bitops/builtin-fls.h>
> +#include <asm-generic/errno-base.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/container_of.h>
> +#include <linux/hrtimer_types.h>
> +#include <linux/gfp_types.h>
> +#include <linux/module.h>
> +
> +#include <linux/fs.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/major.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/kmod.h>
> +#include <linux/motion.h>
> +#include <linux/poll.h>
> +#include <linux/ptrace.h>
> +#include <linux/ktime.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "motion-core.h"
> +#include "motion-helpers.h"
> +#include <linux/time.h>
> +#include <linux/uaccess.h>
> +#include <linux/string.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/math.h>
> +#include <linux/math64.h>

Order all <...> includes over the "..." ones.

> +#define MOTION_PROFILE_VALID BIT(31)
> +
> +static LIST_HEAD(motion_list);
> +static DEFINE_MUTEX(motion_mtx);
> +static int motion_major;
> +static DEFINE_IDA(motion_minors_ida);
> +
> +struct iio_motion_trigger_info {
> +	unsigned int minor;
> +};
> +
> +static int motion_minor_alloc(void)
> +{
> +	int ret;
> +
> +	ret = ida_alloc_range(&motion_minors_ida, 0, MINORMASK, GFP_KERNEL);
> +	return ret;

This could be a one-liner.

> +}
> +
> +static void motion_minor_free(int minor)
> +{
> +	ida_free(&motion_minors_ida, minor);
> +}
> +
> +static int motion_open(struct inode *inode, struct file *file)
> +{
> +	int minor = iminor(inode);
> +	struct motion_device *mdev = NULL, *iter;
> +	int err;
> +
> +	mutex_lock(&motion_mtx);

If you use guard(), error handling gets a bit easier.

> +	list_for_each_entry(iter, &motion_list, list) {
> +		if (iter->minor != minor)
> +			continue;
> +		mdev = iter;
> +		break;
> +	}

This should be easier. If you use a cdev you can just do
container_of(inode->i_cdev, ...);

> +	if (!mdev) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +	dev_info(mdev->dev, "MOTION: open %d\n", mdev->minor);

degrade to dev_dbg.

> +	file->private_data = mdev;
> +
> +	if (mdev->ops.device_open)
> +		err = mdev->ops.device_open(mdev);
> +	else
> +		err = 0;
> +fail:
> +	mutex_unlock(&motion_mtx);
> +	return err;
> +}
> +
> +static int motion_release(struct inode *inode, struct file *file)
> +{
> +	struct motion_device *mdev = file->private_data;
> +	int i;
> +
> +	if (mdev->ops.device_release)
> +		mdev->ops.device_release(mdev);
> +
> +	for (i = 0; i < mdev->num_gpios; i++) {
> +		int irq;
> +		struct motion_gpio_input *gpio = &mdev->gpios[i];
> +
> +		if (gpio->function == MOT_INP_FUNC_NONE)
> +			continue;
> +		irq = gpiod_to_irq(gpio->gpio);
> +		devm_free_irq(mdev->dev, irq, gpio);

It seems devm is just overhead here if you release by hand anyhow.

> +		gpio->function = MOT_INP_FUNC_NONE;
> +	}
> +
> +	if (!kfifo_is_empty(&mdev->events))
> +		kfifo_reset(&mdev->events);
> +
> +	/* FIXME: Stop running motions? Probably not... */
> +
> +	return 0;
> +}
> +
> +static ssize_t motion_read(struct file *file, char __user *buffer,
> +			  size_t count, loff_t *ppos)
> +{
> +	struct motion_device *mdev = file->private_data;
> +	unsigned int copied = 0L;
> +	int ret;
> +
> +	if (!mdev->dev)
> +		return -ENODEV;
> +
> +	if (count < sizeof(struct mot_event))
> +		return -EINVAL;
> +
> +	do {
> +		if (kfifo_is_empty(&mdev->events)) {
> +			if (file->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +
> +			ret = wait_event_interruptible(mdev->wait,
> +					!kfifo_is_empty(&mdev->events) ||
> +					mdev->dev == NULL);
> +			if (ret)
> +				return ret;
> +			if (mdev->dev == NULL)
> +				return -ENODEV;
> +		}
> +
> +		if (mutex_lock_interruptible(&mdev->read_mutex))
> +			return -ERESTARTSYS;
> +		ret = kfifo_to_user(&mdev->events, buffer, count, &copied);
> +		mutex_unlock(&mdev->read_mutex);
> +
> +		if (ret)
> +			return ret;
> +	} while (!copied);
> +
> +	return copied;
> +}
> +
> +static __poll_t motion_poll(struct file *file, poll_table *wait)
> +{
> +	struct motion_device *mdev = file->private_data;
> +	__poll_t mask = 0;
> +
> +	poll_wait(file, &mdev->wait, wait);
> +	if (!kfifo_is_empty(&mdev->events))
> +		mask = EPOLLIN | EPOLLRDNORM;
> +	dev_info(mdev->dev, "Obtained POLL events: 0x%08x\n", mask);

dev_dbg

> +
> +	return mask;
> +}
> +
> [...]
> +
> +static long motion_start_locked(struct motion_device *mdev, struct mot_start *s)
> +{
> +	long ret = 0L;
> +	mot_time_t conv_duration;
> +
> +	lockdep_assert_held(&mdev->mutex);
> +
> +	if (s->reserved1 || s->reserved2)
> +		return -EINVAL;
> +	if (s->channel >= mdev->capabilities.num_channels)
> +		return -EINVAL;
> +	if ((s->index >= MOT_MAX_PROFILES) || (s->direction > MOT_DIRECTION_RIGHT))
> +		return -EINVAL;
> +	if (!(mdev->profiles[s->index].index & MOTION_PROFILE_VALID))
> +		return -EINVAL;
> +	if (s->when >= MOT_WHEN_NUM_WHENS)
> +		return -EINVAL;
> +	if (s->duration && s->distance)
> +		return -EINVAL;
> +	if (!mdev->ops.motion_distance && !mdev->ops.motion_timed)
> +		return -EOPNOTSUPP;

I would add empty lines between these ifs to improve readability. Maybe
thats subjective though.

> +	if (s->duration) {
> +		if (!mdev->ops.motion_timed)
> +			return -EOPNOTSUPP;
> +		/* FIXME: Implement time to distance conversion? */
> +		return mdev->ops.motion_timed(mdev, s->channel, s->index,
> +				s->direction, s->duration, s->when);
> +	}
> +	if (!mdev->ops.motion_distance) {
> +		ret = motion_distance_to_time(mdev, s->index, s->distance,
> +				&conv_duration);
> +		if (ret)
> +			return ret;
> +		return mdev->ops.motion_timed(mdev, s->channel, s->index,
> +				s->direction, conv_duration, s->when);
> +	}
> +	ret = mdev->ops.motion_distance(mdev, s->channel, s->index,
> +			s->distance, s->when);
> +
> +	return ret;
> +}
> [...]
> +
> +static long motion_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct motion_device *mdev = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	long ret;
> +
> +	switch (cmd) {
> +	case MOT_IOCTL_APIVER:
> +		force_successful_syscall_return();
> +		return MOT_UAPI_VERSION;

force_successful_syscall_return() is only needed if the return value is
negative but no error.

> +	case MOT_IOCTL_BASIC_RUN: {
> +		struct mot_speed_duration spd;
> +
> +		if (copy_from_user(&spd, argp, sizeof(spd)))
> +			return -EFAULT;
> +		if (!mdev->ops.basic_run)
> +			return -EINVAL;
> [...]
> +
> +static const struct class motion_class = {
> +	.name		= "motion",
> +	.devnode	= motion_devnode,

IIRC it's recommended to not create new classes, but a bus.

> +};
> +
> +static const struct file_operations motion_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= motion_read,
> +	.poll		= motion_poll,
> +	.unlocked_ioctl = motion_ioctl,
> +	.open		= motion_open,
> +	.llseek		= noop_llseek,
> +	.release	= motion_release,
> +};
> +
> +static int motion_of_parse_gpios(struct motion_device *mdev)
> +{
> +	int ngpio, i;
> +
> +	ngpio = gpiod_count(mdev->parent, "motion,input");
> +	if (ngpio < 0) {
> +		if (ngpio == -ENOENT)
> +			return 0;
> +		return ngpio;
> +	}
> +
> +	if (ngpio >= MOT_MAX_INPUTS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ngpio; i++) {
> +		mdev->gpios[i].gpio = devm_gpiod_get_index(mdev->parent,
> +				"motion,input", i, GPIOD_IN);
> +		if (IS_ERR(mdev->gpios[i].gpio))
> +			return PTR_ERR(mdev->gpios[i].gpio);
> +		mdev->gpios[i].function = MOT_INP_FUNC_NONE;
> +		mdev->gpios[i].chmask = 0;
> +		mdev->gpios[i].index = i;
> +	}
> +
> +	mdev->num_gpios = ngpio;
> +	mdev->capabilities.num_ext_triggers += ngpio;
> +
> +	return 0;
> +}
> +
> +static void motion_trigger_work(struct irq_work *work)
> +{
> +	struct motion_device *mdev = container_of(work, struct motion_device,
> +							iiowork);
> +	iio_trigger_poll(mdev->iiotrig);
> +}
> +
> +/**
> + * motion_register_device - Register a new Motion Device
> + * @mdev: description and handle of the motion device
> + *
> + * Register a new motion device with the motion subsystem core.
> + * It also handles OF parsing of external trigger GPIOs and registers an IIO
> + * trigger device if IIO support is configured.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int motion_register_device(struct motion_device *mdev)
> +{
> +	dev_t devt;
> +	int err = 0;
> +	struct iio_motion_trigger_info *trig_info;
> +
> +	if (!mdev->capabilities.num_channels)
> +		mdev->capabilities.num_channels = 1;
> +	if (mdev->capabilities.features | MOT_FEATURE_PROFILE)
> +		mdev->capabilities.max_profiles = MOT_MAX_PROFILES;
> +	if (!mdev->capabilities.speed_conv_mul)
> +		mdev->capabilities.speed_conv_mul = 1;
> +	if (!mdev->capabilities.speed_conv_div)
> +		mdev->capabilities.speed_conv_div = 1;
> +	if (!mdev->capabilities.accel_conv_mul)
> +		mdev->capabilities.accel_conv_mul = 1;
> +	if (!mdev->capabilities.accel_conv_div)
> +		mdev->capabilities.accel_conv_div = 1;
> +
> +	mutex_init(&mdev->mutex);
> +	mutex_init(&mdev->read_mutex);
> +	INIT_KFIFO(mdev->events);
> +	init_waitqueue_head(&mdev->wait);
> +
> +	err = motion_of_parse_gpios(mdev);
> +	if (err)
> +		return err;
> +
> +	mdev->minor = motion_minor_alloc();
> +
> +	mdev->iiotrig = iio_trigger_alloc(NULL, "mottrig%d", mdev->minor);
> +	if (!mdev->iiotrig) {
> +		err = -ENOMEM;
> +		goto error_free_minor;
> +	}
> +
> +	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
> +	if (!trig_info) {
> +		err = -ENOMEM;
> +		goto error_free_trigger;
> +	}
> +
> +	iio_trigger_set_drvdata(mdev->iiotrig, trig_info);
> +
> +	trig_info->minor = mdev->minor;
> +	err = iio_trigger_register(mdev->iiotrig);
> +	if (err)
> +		goto error_free_trig_info;
> +
> +	mdev->iiowork = IRQ_WORK_INIT_HARD(motion_trigger_work);
> +
> +	INIT_LIST_HEAD(&mdev->list);
> +
> +	mutex_lock(&motion_mtx);
> +
> +	devt = MKDEV(motion_major, mdev->minor);
> +	mdev->dev = device_create_with_groups(&motion_class, mdev->parent,
> +				devt, mdev, mdev->groups, "motion%d", mdev->minor);

What makes sure that mdev doesn't go away while one of the attributes is
accessed?

> +	if (IS_ERR(mdev->dev)) {
> +		dev_err(mdev->parent, "Error creating motion device %d\n",
> +				mdev->minor);
> +		mutex_unlock(&motion_mtx);
> +		goto error_free_trig_info;
> +	}
> +	list_add_tail(&mdev->list, &motion_list);
> +	mutex_unlock(&motion_mtx);
> +
> +	return 0;
> +
> +error_free_trig_info:
> +	kfree(trig_info);
> +error_free_trigger:
> +	iio_trigger_free(mdev->iiotrig);
> +error_free_minor:
> +	motion_minor_free(mdev->minor);
> +	dev_info(mdev->parent, "Registering motion device err=%d\n", err);
> +	return err;
> +}
> +EXPORT_SYMBOL(motion_register_device);
> [...]
> +struct mot_capabilities {
> +	__u32 features;
> +	__u8 type;
> +	__u8 num_channels;
> +	__u8 num_int_triggers;
> +	__u8 num_ext_triggers;
> +	__u8 max_profiles;
> +	__u8 max_vpoints;
> +	__u8 max_apoints;
> +	__u8 reserved1;
> +	__u32 subdiv; /* Position unit sub-divisions, microsteps, etc... */
> +	/*
> +	 * Coefficients for converting to/from controller time <--> seconds.
> +	 * Speed[1/s] = Speed[controller_units] * conv_mul / conv_div
> +	 * Accel[1/s^2] = Accel[controller_units] * conv_mul / conv_div
> +	 */
> +	__u32 speed_conv_mul;
> +	__u32 speed_conv_div;
> +	__u32 accel_conv_mul;
> +	__u32 accel_conv_div;
> +	__u32 reserved2;
> +};

https://docs.kernel.org/gpu/imagination/uapi.html (which has some
generic bits that apply here, too) has: "The overall struct must be
padded to 64-bit alignment." If you drop reserved2 the struct is
properly sized (or I counted wrongly).

> +struct mot_speed_duration {
> +	__u32 channel;
> +	speed_raw_t speed;

What is the unit here?

> +	mot_time_t duration;

duration_ns? That makes usage much more ideomatic and there should be no
doubts what the unit is.

> +	pos_raw_t distance;

What is the unit here?

> +	__u32 reserved[3];

Again the padding is wrong here.

> +};

Best regards
Uwe

--3afczumwzxjy3taw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfB5+gACgkQj4D7WH0S
/k5C1wf+IR16wHxTa97rqqBTKhKSRqGGyRlmIbst2s3km2q+yRD9ko9pEaBdJX/4
zsJnADhNXYnrU+ZIi08XShlMK88pz9J3Vbm53B1fLjCNSxUTOdNtIz6ARic4+XtY
PzaOtt7Zp56yD4mOdiogAO1ZMll5E1Ol/Qsx/0b8zHBznzL1AuNpHb0vGazQlpYC
55a4XT3ZBdMeFmEHtrazlwEGrYNb2d9YXe5TkA5sYBZAouwdUX8JVTWrbbnzAHAm
DE0FdbBhSQmgPalQXOoxwaWDwH0IDJd6JiDblZlawwb02vKUajAdpyl1lndEoUcs
fkBSnJnFK/COPjbcavaZ5PEke+raTg==
=z/7b
-----END PGP SIGNATURE-----

--3afczumwzxjy3taw--


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325028E8D4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Oct 2020 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgJNWkt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 18:40:49 -0400
Received: from vern.gendns.com ([98.142.107.122]:46422 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgJNWkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Oct 2020 18:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dID71IWmSuJrKqwrxHNZaTKnyffa+NbYhcw7le2zj3k=; b=k3ui0MR7qAGP6ZgXBSIje/KtYf
        Zf0cM1bxI9UsYCKky2OBNQq+FVj6SWOj7hUQ1+MLgry20PefqhYwPVrQL9t3cgdhlU7xgdFc6WASW
        Y2UHc8cenJUS3n065aCJTQ1sZ5ZyVz06O0ubRbhRpvCVbRC1DASoeVVBXBBOIwLkcdlNfgA60bGYr
        r+y7ppFGb4Fa3C7omuxtp754zYs+rQUtm9UbJ2aimE0R3Y3QroSHXyksaJ5X56Ehn6LBEEKKuEbYc
        z/5QAnFC/rutDO1KU5cCrsvbcZpOKKsC8z/uHF2AQtmpWkOOYl7ogHaGgvvnQHpZyRKIxSSKkmjzj
        l7kypjnA==;
Received: from [2600:1700:4830:165f::19e] (port=50656)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kSpRt-0001fv-W9; Wed, 14 Oct 2020 18:40:46 -0400
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <cc1f7e4d-18d1-bc28-8ce3-e3edcd91bcab@lechnology.com>
Date:   Wed, 14 Oct 2020 17:40:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
> +				   size_t len, loff_t *f_ps)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	int err;
> +	unsigned long flags;
> +	unsigned int copied;
> +
> +	if (len < sizeof(struct counter_event))
> +		return -EINVAL;
> +
> +	do {
> +		if (kfifo_is_empty(&counter->events)) {
> +			if (filp->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +
> +			err = wait_event_interruptible(counter->events_wait,
> +					!kfifo_is_empty(&counter->events));
> +			if (err)
> +				return err;
> +		}
> +
> +		raw_spin_lock_irqsave(&counter->events_lock, flags);
> +		err = kfifo_to_user(&counter->events, buf, len, &copied);
> +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +		if (err)
> +			return err;
> +	} while (!copied);
> +
> +	return copied;
> +}

All other uses of kfifo_to_user() I saw use a mutex instead of spin
lock. I don't see a reason for disabling interrupts here.

Example:


static ssize_t iio_event_chrdev_read(struct file *filep,
				     char __user *buf,
				     size_t count,
				     loff_t *f_ps)
{
	struct iio_dev *indio_dev = filep->private_data;
	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
	struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
	unsigned int copied;
	int ret;

	if (!indio_dev->info)
		return -ENODEV;

	if (count < sizeof(struct iio_event_data))
		return -EINVAL;

	do {
		if (kfifo_is_empty(&ev_int->det_events)) {
			if (filep->f_flags & O_NONBLOCK)
				return -EAGAIN;

			ret = wait_event_interruptible(ev_int->wait,
					!kfifo_is_empty(&ev_int->det_events) ||
					indio_dev->info == NULL);
			if (ret)
				return ret;
			if (indio_dev->info == NULL)
				return -ENODEV;
		}

		if (mutex_lock_interruptible(&ev_int->read_lock))
			return -ERESTARTSYS;
		ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
		mutex_unlock(&ev_int->read_lock);

		if (ret)
			return ret;

		/*
		 * If we couldn't read anything from the fifo (a different
		 * thread might have been faster) we either return -EAGAIN if
		 * the file descriptor is non-blocking, otherwise we go back to
		 * sleep and wait for more data to arrive.
		 */
		if (copied == 0 && (filep->f_flags & O_NONBLOCK))
			return -EAGAIN;

	} while (copied == 0);

	return copied;
}

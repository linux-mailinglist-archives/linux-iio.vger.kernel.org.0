Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC01EFF42
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jun 2020 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgFERlm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jun 2020 13:41:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726995AbgFERll (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2020 13:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591378899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2r/gCyDa969XA2rQ4NauoYjHnCdKt3EVlEOeUbN5vw=;
        b=fqVmIVKeGiVzlrNobgfeJ/q0sqg+hoHiiM5dTKYyBCqMJaCaBGiN2/mdZs6rUZa4JYzbz2
        z0JbodqA1Tt/jgz8l5FQBiAO4KmpSC/B2YPLDDdMsG4uFHA7hyEvuiPXebQ+LpsGzsQhbv
        4h01SzEdvkAdam7dFhRrg3sAVWJpPpo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-DbEI3fSiPLeThC_KQymjFQ-1; Fri, 05 Jun 2020 13:41:37 -0400
X-MC-Unique: DbEI3fSiPLeThC_KQymjFQ-1
Received: by mail-ed1-f69.google.com with SMTP id a21so4239798edy.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2020 10:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2r/gCyDa969XA2rQ4NauoYjHnCdKt3EVlEOeUbN5vw=;
        b=aOGffHmtYKDdBWpn1sjHcPhItR3p36cM7HiQkLsnep5vQ6qD6QA9IYnxm/yva2aock
         KmMFw/87lTITXxAUyQBCoAAdlkghG+8jUvjV5GfYGrg3FHC5pePUzEGnmqKY2m830sWn
         ItSucZ7N6PtKUVtAAL5EzOrD9F5LwAVBHtFmpagcGrzXeSU4QhU1XCDFpna1gM1sC1c1
         XbnN/jLbSJobDRwKcy0Y/HIsynxboJ2JkC+NHcOubaaH5/ppUMJ9/HE1e5qWQcAJQfcI
         7pNSVcNOBQaZkTO/K0mf2zmPjGVt/GNe315w7nRVny5itPTRv/U17rMEUXQns8dTNCDD
         TtDQ==
X-Gm-Message-State: AOAM530RnrCQsTjmu3s8AS9rnzcb3D8YBGnRVBn5Dq1X9rfSdQhGHmE0
        V2Sc+TpmDcHVf28sWU37E4gUK9OwLexDhP9xZX8WubXfWXZvk459FMmmPhAwAPjqBWQnVXfo1h8
        weDMtehLtoYig69v1H53e
X-Received: by 2002:a50:cccc:: with SMTP id b12mr10207795edj.68.1591378896028;
        Fri, 05 Jun 2020 10:41:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTp4S5gd3mVeK3aXMHwojyH5aSj9UJyV50ODAKr6Ed/qOUjsv3Y2z1hcNyqcTTAYaVlOcAvA==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr10207764edj.68.1591378895672;
        Fri, 05 Jun 2020 10:41:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j11sm4845450ejk.67.2020.06.05.10.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 10:41:34 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] Input: Add "inhibited" property
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Patrik Fimml <patrikf@chromium.org>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
 <20200605173335.13753-8-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
Date:   Fri, 5 Jun 2020 19:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605173335.13753-8-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/5/20 7:33 PM, Andrzej Pietrasiewicz wrote:
> From: Patrik Fimml <patrikf@chromium.org>
> 
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices, including not treating them as wakeup sources.
> 
> An example use case is a laptop, whose keyboard can be folded under the
> screen to create tablet-like experience. The user then must hold the laptop
> in such a way that it is difficult to avoid pressing the keyboard keys. It
> is therefore desirable to temporarily disregard input from the keyboard,
> until it is folded back. This obviously is a policy which should be kept
> out of the kernel, but the kernel must provide suitable means to implement
> such a policy.
> 
> This patch adds a sysfs interface for exactly this purpose.
> 
> To implement the said interface it adds an "inhibited" property to struct
> input_dev, and effectively creates four states a device can be in: closed
> uninhibited, closed inhibited, open uninhibited, open inhibited. It also
> defers calling driver's ->open() and ->close() to until they are actually
> needed, e.g. it makes no sense to prepare the underlying device for
> generating events (->open()) if the device is inhibited.
> 
>                uninhibit
> closed      <------------ closed
> uninhibited ------------> inhibited
>        | ^     inhibit        | ^
>   1st  | |               1st  | |
>   open | |               open | |
>        | |                    | |
>        | | last               | | last
>        | | close              | | close
>        v |     uninhibit      v |
> open        <------------ open
> uninhibited ------------> inhibited
> 
> The top inhibit/uninhibit transition happens when users == 0.
> The bottom inhibit/uninhibit transition happens when users > 0.
> The left open/close transition happens when !inhibited.
> The right open/close transition happens when inhibited.
> Due to all transitions being serialized with dev->mutex, it is impossible
> to have "diagonal" transitions between closed uninhibited and open
> inhibited or between open uninhibited and closed inhibited.
> 
> No new callbacks are added to drivers, because their open() and close()
> serve exactly the purpose to tell the driver to start/stop providing
> events to the input core. Consequently, open() and close() - if provided
> - are called in both inhibit and uninhibit paths.
> 
> Signed-off-by: Patrik Fimml <patrikf@chromium.org>
> Co-developed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>   drivers/input/input.c | 115 +++++++++++++++++++++++++++++++++++++++---
>   include/linux/input.h |  12 ++++-
>   2 files changed, 118 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 41377bfa142d..4110b5797219 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
>   	case EV_KEY:
>   		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
>   
> -			/* auto-repeat bypasses state updates */
> -			if (value == 2) {
> +			/*
> +			 * auto-repeat bypasses state updates but repeat
> +			 * events are ignored if the key is not pressed
> +			 */
> +			if (value == 2 && test_bit(code, dev->key)) {
>   				disposition = INPUT_PASS_TO_HANDLERS;
>   				break;
>   			}
> @@ -367,8 +370,13 @@ static int input_get_disposition(struct input_dev *dev,
>   static void input_handle_event(struct input_dev *dev,
>   			       unsigned int type, unsigned int code, int value)
>   {
> -	int disposition = input_get_disposition(dev, type, code, &value);
> +	int disposition;
> +
> +	/* filter-out events from inhibited devices */
> +	if (dev->inhibited)
> +		return;
>   
> +	disposition = input_get_disposition(dev, type, code, &value);
>   	if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)
>   		add_input_randomness(type, code, value);
>   
> @@ -612,7 +620,7 @@ int input_open_device(struct input_handle *handle)
>   
>   	handle->open++;
>   
> -	if (dev->users++) {
> +	if (dev->users++ || dev->inhibited) {
>   		/*
>   		 * Device is already opened, so we can exit immediately and
>   		 * report success.

It seems the comment which is part of the context here may need some
updating because of the inhibit changes ?

Otherwise this patch and the rest of the series looks good to me
now. Thank you very much for your work on this.

Regards,

Hans




> @@ -675,10 +683,9 @@ void input_close_device(struct input_handle *handle)
>   
>   	__input_release_device(handle);
>   
> -	if (!--dev->users) {
> +	if (!dev->inhibited && !--dev->users) {
>   		if (dev->poller)
>   			input_dev_poller_stop(dev->poller);
> -
>   		if (dev->close)
>   			dev->close(dev);
>   	}
> @@ -1416,12 +1423,49 @@ static ssize_t input_dev_show_properties(struct device *dev,
>   }
>   static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties, NULL);
>   
> +static int input_inhibit_device(struct input_dev *dev);
> +static int input_uninhibit_device(struct input_dev *dev);
> +
> +static ssize_t inhibited_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct input_dev *input_dev = to_input_dev(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", input_dev->inhibited);
> +}
> +
> +static ssize_t inhibited_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t len)
> +{
> +	struct input_dev *input_dev = to_input_dev(dev);
> +	ssize_t rv;
> +	bool inhibited;
> +
> +	if (strtobool(buf, &inhibited))
> +		return -EINVAL;
> +
> +	if (inhibited)
> +		rv = input_inhibit_device(input_dev);
> +	else
> +		rv = input_uninhibit_device(input_dev);
> +
> +	if (rv != 0)
> +		return rv;
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(inhibited);
> +
>   static struct attribute *input_dev_attrs[] = {
>   	&dev_attr_name.attr,
>   	&dev_attr_phys.attr,
>   	&dev_attr_uniq.attr,
>   	&dev_attr_modalias.attr,
>   	&dev_attr_properties.attr,
> +	&dev_attr_inhibited.attr,
>   	NULL
>   };
>   
> @@ -1703,6 +1747,63 @@ void input_reset_device(struct input_dev *dev)
>   }
>   EXPORT_SYMBOL(input_reset_device);
>   
> +static int input_inhibit_device(struct input_dev *dev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&dev->mutex);
> +
> +	if (dev->inhibited)
> +		goto out;
> +
> +	if (dev->users) {
> +		if (dev->close)
> +			dev->close(dev);
> +		if (dev->poller)
> +			input_dev_poller_stop(dev->poller);
> +	}
> +
> +	spin_lock_irq(&dev->event_lock);
> +	input_dev_release_keys(dev);
> +	input_dev_toggle(dev, false);
> +	spin_unlock_irq(&dev->event_lock);
> +
> +	dev->inhibited = true;
> +
> +out:
> +	mutex_unlock(&dev->mutex);
> +	return ret;
> +}
> +
> +static int input_uninhibit_device(struct input_dev *dev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&dev->mutex);
> +
> +	if (!dev->inhibited)
> +		goto out;
> +
> +	if (dev->users) {
> +		if (dev->open) {
> +			ret = dev->open(dev);
> +			if (ret)
> +				goto out;
> +		}
> +		if (dev->poller)
> +			input_dev_poller_start(dev->poller);
> +	}
> +
> +	dev->inhibited = false;
> +	spin_lock_irq(&dev->event_lock);
> +	input_dev_toggle(dev, true);
> +	spin_unlock_irq(&dev->event_lock);
> +
> +out:
> +	mutex_unlock(&dev->mutex);
> +	return ret;
> +}
> +
>   #ifdef CONFIG_PM_SLEEP
>   static int input_dev_suspend(struct device *dev)
>   {
> @@ -2131,7 +2232,7 @@ bool input_device_enabled(struct input_dev *dev)
>   {
>   	lockdep_assert_held(&dev->mutex);
>   
> -	return dev->users > 0;
> +	return !dev->inhibited && dev->users > 0;
>   }
>   EXPORT_SYMBOL_GPL(input_device_enabled);
>   
> diff --git a/include/linux/input.h b/include/linux/input.h
> index eda4587dba67..0354b298d874 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -90,9 +90,11 @@ enum input_clock_type {
>    * @open: this method is called when the very first user calls
>    *	input_open_device(). The driver must prepare the device
>    *	to start generating events (start polling thread,
> - *	request an IRQ, submit URB, etc.)
> + *	request an IRQ, submit URB, etc.). The meaning of open() is
> + *	to start providing events to the input core.
>    * @close: this method is called when the very last user calls
> - *	input_close_device().
> + *	input_close_device(). The meaning of close() is to stop
> + *	providing events to the input core.
>    * @flush: purges the device. Most commonly used to get rid of force
>    *	feedback effects loaded into the device when disconnecting
>    *	from it
> @@ -127,6 +129,10 @@ enum input_clock_type {
>    *	and needs not be explicitly unregistered or freed.
>    * @timestamp: storage for a timestamp set by input_set_timestamp called
>    *  by a driver
> + * @inhibited: indicates that the input device is inhibited. If that is
> + * the case then input core ignores any events generated by the device.
> + * Device's close() is called when it is being inhibited and its open()
> + * is called when it is being uninhibited.
>    */
>   struct input_dev {
>   	const char *name;
> @@ -201,6 +207,8 @@ struct input_dev {
>   	bool devres_managed;
>   
>   	ktime_t timestamp[INPUT_CLK_MAX];
> +
> +	bool inhibited;
>   };
>   #define to_input_dev(d) container_of(d, struct input_dev, dev)
>   
> 


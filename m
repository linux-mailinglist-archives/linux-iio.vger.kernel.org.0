Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA9174F7C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 21:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCAUPI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 15:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgCAUPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 15:15:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A80C21744;
        Sun,  1 Mar 2020 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583093707;
        bh=xtHhfpQG1yNXRNMNT7O6zsFDLkfakTVUMH4y2fI2GJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxakopvh+tUV+Eu06cPEBz16rMeAWxtnUb2ghQOQszKvCG8FWytrO8Ix8JVJOJj3m
         0gSKhdnXZWAxm3fqosod1nis+1uEwyiGyFBXiGcuS7koocNlsuV7RFAKQVbZS952J0
         CqChhPwbbOMQO8THcMqqGo4ILvG15zZIECN74I7E=
Date:   Sun, 1 Mar 2020 20:14:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Support Differential Encoder Cable
 Status
Message-ID: <20200301201458.4dcce64c@archlinux>
In-Reply-To: <20200222154340.89464-1-vilhelm.gray@gmail.com>
References: <20200222154340.89464-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Feb 2020 10:43:40 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ACCES 104-QUAD-8 series provides status information about the
> connection state of the differential encoder cable inputs. This patch
> implements support to expose such information from these devices.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,  Couple of things on the interface...

> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  | 12 ++++++
>  drivers/counter/104-quad-8.c                  | 38 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> index 46b1f33b2fce..492b3e98f369 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -1,3 +1,15 @@
> +What:		/sys/bus/counter/devices/counterX/cable_status
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Differential encoder cable status; bits 0 through 7
> +		correspond to channels 1 through 8. Writing a 0 to the
> +		corresponding bit will enable the status of the
> +		respective channel.
I'm never personally that keen on cases where a sysfs file doesn't have
inherent 'obviousness'.  In this case we have a bitmap that doesn't make that
clear and that also that doesn't have particularly obviously meaning either
on the write or read.

Hmm.  So if you wanted to keep it as a bitmap perhaps something like...

cable_test_bitmap

So a 1 (or true) would be a successful cable test on read.  However that is
still not obviously something that needs an enable.  It think you need to
split it.

*_enable
*_status 

Next question is whether it should be a map like this?  sysfs rules are usually
one value to one sysfs file.    It might seem wasteful but I'd like to see something
like

cable0_test_enable
cable0_test_status
cable7_test_enable
cable7_test_status

I haven't thought about whether this could be fit better with the counter ABI
but something along those lines!

> +
> +		Logic 0 = cable fault (not connected or loose wires)
> +		Logic 1 = cable connection good or cable fault disabled
> +
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 17e67a84777d..1cbaf7e100a3 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -56,6 +56,7 @@ struct quad8_iio {
>  
>  #define QUAD8_REG_CHAN_OP 0x11
>  #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
> +#define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
>  /* Borrow Toggle flip-flop */
>  #define QUAD8_FLAG_BT BIT(0)
>  /* Carry Toggle flip-flop */
> @@ -1268,6 +1269,42 @@ static struct counter_count quad8_counts[] = {
>  	QUAD8_COUNT(7, "Channel 8 Count")
>  };
>  
> +static ssize_t quad8_cable_status_read(struct counter_device *counter,
> +				       void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	unsigned int status;
> +
> +	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> +
> +	return sprintf(buf, "0x%X\n", status);
> +}
> +
> +static ssize_t quad8_cable_status_write(struct counter_device *counter,
> +					void *private, const char *buf,
> +					size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	u8 enable;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &enable);
> +	if (ret)
> +		return ret;
> +
> +	outb(enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> +
> +	return len;
> +}
> +
> +static const struct counter_device_ext quad8_device_ext[] = {
> +	{
> +		.name = "cable_status",
> +		.read = quad8_cable_status_read,
> +		.write = quad8_cable_status_write
> +	}
> +};
> +
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
> @@ -1304,6 +1341,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
>  	quad8iio->counter.signals = quad8_signals;
>  	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
> +	quad8iio->counter.ext = quad8_device_ext;
>  	quad8iio->counter.priv = quad8iio;
>  	quad8iio->base = base[id];
>  


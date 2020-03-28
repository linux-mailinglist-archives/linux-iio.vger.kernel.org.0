Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762BF196641
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgC1NN4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 09:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1NN4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 09:13:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF04F206F6;
        Sat, 28 Mar 2020 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585401235;
        bh=RNvam416DZwke5ka/yuaH0/64ae0LFwaJHUp++CL5HQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SR5yGLn6wVCt+T8kKvDZ+in9btkz4l3yH7xPq9oW7k+Ne51ou1WZ5f4jyc5h5JMaw
         ZYY6KWaxYO4TDHWk1wlTGwJOfxdeFHvirsEUFOfyOja0v85aAKZqjsLo+dqCvMTRDO
         w9ecQsUIXvFuA/R61pfsY6xNKk8HqxAbzT3Zu2ME=
Date:   Sat, 28 Mar 2020 13:13:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
Message-ID: <20200328131351.7be365c9@archlinux>
In-Reply-To: <20200326093012.10758-1-alexandru.ardelean@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
        <20200326093012.10758-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Mar 2020 11:30:12 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Before activating a buffer make sure that at least one channel is enabled.
> Activating a buffer with 0 channels enabled doesn't make too much sense and
> disallowing this case makes sure that individual driver don't have to add
> special case code to handle it.
> 
> Currently, without this patch enabling a buffer is possible and no error is
> produced. With this patch -EINVAL is returned.
> 
> An example of execution with this patch and some instrumented print-code:
>    root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>    0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
>    1: iio_verify_update 753
>    2:__iio_update_buffers 1115 ret -22
>    3: iio_buffer_store_enable 1241 ret -22
>    -bash: echo: write error: Invalid argument
> 1, 2 & 3 are exit-error paths. 0 the first print in iio_verify_update()
> rergardless of error path.
> 
> Without this patch (and same instrumented print-code):
>    root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>    0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer#
> Buffer is enabled with no error.
> 
> Fixes: 84b36ce5f79c0 ("staging:iio: Add support for multiple buffers")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I've added a note saying that I don't think this is suitable for
'automatic' back porting to stable.   I'm not against it being requested
for particular kernels though if someone specifically wants it.

I'd kind of count this as an interface improvement rather than
it being broken as such before :)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog v2 -> v3:
> * actually added Fixes tag; seems I forgot it in v2
>   hopefully the tag is the good one; if needed, it can be
>   dropped; this has been around for ~8 years; no idea if it's worth
>   backporting
> 
> Changelog v1 -> v2:
> * moved check in iio_verify_update()
> * added dev_dbg() message; should help some folks understand the message
> * documented steps to reproduce
> 
>  drivers/iio/industrialio-buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5ff34ce8b6a2..e6fa1a4e135d 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -686,6 +686,13 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	bool scan_timestamp;
>  	unsigned int modes;
>  
> +	if (insert_buffer &&
> +	    bitmap_empty(insert_buffer->scan_mask, indio_dev->masklength)) {
> +		dev_dbg(&indio_dev->dev,
> +			"At least one scan element must be enabled first\n");
> +		return -EINVAL;
> +	}
> +
>  	memset(config, 0, sizeof(*config));
>  	config->watermark = ~0;
>  


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D751D6BD3
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEQS5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 14:57:32 -0400
Received: from www381.your-server.de ([78.46.137.84]:58308 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQS5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 14:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rWb1QY3mi2puWksAAp1ZVv3tzV9xeexKowgPDIKwQiw=; b=BV48uItPB+LwTAu4m+rkwL6uy6
        pbAW2C4JUfyNPNgJzD9voDA7XTOpvw1wvXIhz57AIlZuUHUFlWq/FFCw4PPu63RTFvQJde7x92Ji2
        v5MSWIgqxUtZWfKUwAU88cUFuNGEYYpm54iap2Zeq+wx3GdJmGB1ErUmJtyDw26flgufQrs1lS61X
        CpEcSPDEfgz4HE3ERjfzPJJJjW6pQqTQyN6yquSySXQagQVNLI5av1SBZI2+20LaTJKqP6OAhWK91
        PVer2Gtp7rAeQrHPJqHJ+EiQRiy9KsGlbKNIbcYEOXEK1tvIiTvkQ/6YDHxmZP5MD3VEFSTRPx6Lh
        1+GImI8w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jaOTX-00040h-51; Sun, 17 May 2020 20:57:27 +0200
Received: from [82.135.68.131] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jaOTW-000Hbh-Rl; Sun, 17 May 2020 20:57:26 +0200
Subject: Re: [PATCH 02/11] iio:accel:mma8452: Fix timestamp alignment and
 prevent data leak.
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
References: <20200517173000.220819-1-jic23@kernel.org>
 <20200517173000.220819-3-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <170d718b-7ee4-ac08-c083-830c06c59f65@metafoo.de>
Date:   Sun, 17 May 2020 20:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200517173000.220819-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25815/Sun May 17 14:16:18 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/17/20 7:29 PM, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte u8 array on the stack.  As Lars also noted
> this anti pattern can involve a leak of data to userspace and that
> indeed can happen here.  We close both issues by moving to
> a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
>
> Fixes: c7eeea93ac60 ("iio: Add Freescale MMA8452Q 3-axis accelerometer driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/accel/mma8452.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 00e100fc845a..704867ffda7a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -110,6 +110,12 @@ struct mma8452_data {
>   	int sleep_val;
>   	struct regulator *vdd_reg;
>   	struct regulator *vddio_reg;
> +
> +	/* Ensure correct alignment of time stamp when present */
> +	struct {
> +		__be16 channels[3];
> +		s64 ts;
> +	} buffer;


I feel we should have a macro for this.

DECLARE_IIO_BUFFER_WITH_TIMESTAMP(buffer, __be16, 3);

The name is maybe a bit too long.

And potentially also DECLARE_IIO_BUFFER_WITH_TIMESTAMP_ON_STACK() which 
initializes it to zero.

>   };
>   
>    /**
> @@ -1091,14 +1097,13 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct mma8452_data *data = iio_priv(indio_dev);
> -	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
>   	int ret;
>   
> -	ret = mma8452_read(data, (__be16 *)buffer);
> +	ret = mma8452_read(data, data->buffer.channels);
>   	if (ret < 0)
>   		goto done;
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>   					   iio_get_time_ns(indio_dev));
>   
>   done:



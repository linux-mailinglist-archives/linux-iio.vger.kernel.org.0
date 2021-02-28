Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDA327191
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 09:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB1I3p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 03:29:45 -0500
Received: from www381.your-server.de ([78.46.137.84]:47696 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1I3o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 03:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Rnp46uHNyUiQW6a1gr96QWgGKIhkJAiSdkAgs0KFxVM=; b=Yz3sbd/QdPS03ozZx84rCHHZ50
        RmTV9+tM3+iuyL7Thop9Vi+2W5+qhRV49pF4Iv5/0m0I04uR5gc0szyoyAFJrkOtJyUgQ5hR9gT1k
        6GFcy66hH1ZBa11J37zejAuLKxTwjouktOhFU2tvDkIchGvNM0VsKN31osByqIfFD1vho3owMCwoT
        Q5oSq/eyBglVUo3nneVagwK4jnsxAEd85BwbK8YzgbCWq8GQPV1YCg2dMln8n23gNU060DqOdSm5i
        9LdUeWaoH6p7kXg9FfuVApkQ0ED+yW01eePUy6EkFQ1E9TVE3Ku3jIME++kX8DrU3bxIWvt3STR8w
        oY5gCthQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lGHRl-0006TN-Dz; Sun, 28 Feb 2021 09:29:01 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lGHRl-0001wV-8t; Sun, 28 Feb 2021 09:29:01 +0100
Subject: Re: [PATCH v6 19/24] iio: buffer: introduce support for attaching
 more IIO buffers
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-20-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d616ffac-9747-55f8-0478-dd747dba381a@metafoo.de>
Date:   Sun, 28 Feb 2021 09:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215104043.91251-20-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26093/Sat Feb 27 13:05:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
>   static ssize_t iio_show_scan_index(struct device *dev,
>   				   struct device_attribute *attr,
>   				   char *buf)
> @@ -1451,11 +1465,13 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>   	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
>   }
>   
> -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> +int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>   {
> [...]
> +error_unwind_sysfs_and_mask:
> +	for (; unwind_idx >= 0; unwind_idx--) {
> +		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +	kfree(iio_dev_opaque->attached_buffers);
> +	return ret;
>   }
>   
> -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> +void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
>   {
> [...]
> +	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +
> +	kfree(iio_dev_opaque->attached_buffers);
>   }
> [...]
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1d500ea246af..f7f785431106 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1583,7 +1583,7 @@ static void iio_dev_release(struct device *device)
>   	iio_device_unregister_eventset(indio_dev);
>   	iio_device_unregister_sysfs(indio_dev);
>   
> -	iio_buffer_put(indio_dev->buffer);
> +	iio_buffers_put(indio_dev);
We do call kfree(iio_dev_opaque->attached_buffers) before we get here. I 
think we need to keep the array around, otherwise we end of up with a 
use after free.


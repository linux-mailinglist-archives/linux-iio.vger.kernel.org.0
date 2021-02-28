Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125E3271A7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhB1IwW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 03:52:22 -0500
Received: from www381.your-server.de ([78.46.137.84]:51004 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhB1IwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 03:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=8E7c/Z1a3sjaUgQcFNKtXe/vCdCcKhkLNcrSGUpc+Dc=; b=b9CDjPxRY25Ro8Z29cvKdM1Zhq
        u4SL10j/hWm5n21f5KIfQumem74DS8D9zrmeOwSfC99+/CPAoXf/9UZec0U1WZ2XEFvn8cpmX5Rb/
        zi4k2aeZVsc0ACX3yNjZoR1cjcFFrbcc+ikpLS5oj7siHXWF2z4hS1gLQlnUqw+LlFcZEW4JLjyLL
        iPBZN5O0Wj36a+if0HS/+1fDgRrNOptynwvrvofK27oNWE5WWHsvKXz3TPTaoggsizSW8Hgc5z+9X
        mMMQmci/3yDvUpoDdJeRi79i1ZJlvAZiZN5QwByssMJkhm6+m1Tbg4MsEg8mZk7t46beplMhNX4x3
        boxMcTTA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lGHne-0009ch-KT; Sun, 28 Feb 2021 09:51:38 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lGHne-000N8B-Em; Sun, 28 Feb 2021 09:51:38 +0100
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
Date:   Sun, 28 Feb 2021 09:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215104043.91251-21-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26093/Sat Feb 27 13:05:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> With this change, an ioctl() call is added to open a character device for a
> buffer. The ioctl() number is 'i' 0x91, which follows the
> IIO_GET_EVENT_FD_IOCTL ioctl.
>
> The ioctl() will return an FD for the requested buffer index. The indexes
> are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
> variable).
>
> Since there doesn't seem to be a sane way to return the FD for buffer0 to
> be the same FD for the /dev/iio:deviceX, this ioctl() will return another
> FD for buffer0 (or the first buffer). This duplicate FD will be able to
> access the same buffer object (for buffer0) as accessing directly the
> /dev/iio:deviceX chardev.
>
> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
> index for each buffer (and the count) can be deduced from the
> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
> bufferY folders).
>
> Used following C code to test this:
> -------------------------------------------------------------------
>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <fcntl.h"
>   #include <errno.h>
>
>   #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
>
> int main(int argc, char *argv[])
> {
>          int fd;
>          int fd1;
>          int ret;
>
>          if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
>                  fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
>                  return -1;
>          }
>
>          fprintf(stderr, "Using FD %d\n", fd);
>
>          fd1 = atoi(argv[1]);
>
>          ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
>          if (ret < 0) {
>                  fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
>                  close(fd);
>                  return -1;
>          }
>
>          fprintf(stderr, "Got FD %d\n", fd1);
>
>          close(fd1);
>          close(fd);
>
>          return 0;
> }
> -------------------------------------------------------------------
>
> Results are:
> -------------------------------------------------------------------
>   # ./test 0
>   Using FD 3
>   Got FD 4
>
>   # ./test 1
>   Using FD 3
>   Got FD 4
>
>   # ./test 2
>   Using FD 3
>   Got FD 4
>
>   # ./test 3
>   Using FD 3
>   Got FD 4
>
>   # ls /sys/bus/iio/devices/iio\:device0
>   buffer  buffer0  buffer1  buffer2  buffer3  dev
>   in_voltage_sampling_frequency  in_voltage_scale
>   in_voltage_scale_available
>   name  of_node  power  scan_elements  subsystem  uevent
> -------------------------------------------------------------------
>
> iio:device0 has some fake kfifo buffers attached to an IIO device.

For me there is one major problem with this approach. We only allow one 
application to open /dev/iio:deviceX at a time. This means we can't have 
different applications access different buffers of the same device. I 
believe this is a circuital feature.

It is possible to open the chardev, get the annonfd, close the chardev 
and keep the annonfd open. Then the next application can do the same and 
get access to a different buffer. But this has room for race conditions 
when two applications try this at the very same time.

We need to somehow address this.

I'm also not much of a fan of using ioctls to create annon fds. In part 
because all the standard mechanisms for access control no longer work.


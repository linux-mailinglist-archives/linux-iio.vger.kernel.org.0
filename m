Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13509327337
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhB1Pws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 10:52:48 -0500
Received: from www381.your-server.de ([78.46.137.84]:33528 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhB1Pwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 10:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nieBiiebJb3oXYZlYeMGP6lVgw/bisqi9Ti4NzL+qMw=; b=aV/akS88Rw4BU+B4Jbxs7Ff9fD
        0MiIZBdrjPHCFESOGGm1rQNMaXc0AERgeRIGEl1spJAfXj4D367N5o3wFzoERynBM1KufagNtJOK5
        FEs+VSkbDJKuuJNG2+YLc0ws25Wau+E2axjJEu6yeSp3mBnGgff458/D6TVnvmfq5aYFOfC/Xn4lb
        xj34YD1sGRpylLr7ydi7Y9zoBsm2EAhA0w/YqzlGWHUfs+LOXfrA1bDcwGZF1SkVvVC3W0wp614g6
        trbB3ktuRPlmNwc4i4mXoGcv7emhBgWCtQ0mCIBC/NHAl8gDWWOTuEiCfhVExU2cuRYV99VkxGLCj
        NgoxbrFA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lGOMK-000Adb-7L; Sun, 28 Feb 2021 16:51:52 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lGOMK-0004iy-0P; Sun, 28 Feb 2021 16:51:52 +0100
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com>
 <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
 <20210228143429.00001f01@Huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
Date:   Sun, 28 Feb 2021 16:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228143429.00001f01@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26094/Sun Feb 28 13:14:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/28/21 3:34 PM, Jonathan Cameron wrote:
> On Sun, 28 Feb 2021 09:51:38 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
>>> With this change, an ioctl() call is added to open a character device for a
>>> buffer. The ioctl() number is 'i' 0x91, which follows the
>>> IIO_GET_EVENT_FD_IOCTL ioctl.
>>>
>>> The ioctl() will return an FD for the requested buffer index. The indexes
>>> are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
>>> variable).
>>>
>>> Since there doesn't seem to be a sane way to return the FD for buffer0 to
>>> be the same FD for the /dev/iio:deviceX, this ioctl() will return another
>>> FD for buffer0 (or the first buffer). This duplicate FD will be able to
>>> access the same buffer object (for buffer0) as accessing directly the
>>> /dev/iio:deviceX chardev.
>>>
>>> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
>>> index for each buffer (and the count) can be deduced from the
>>> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
>>> bufferY folders).
>>>
>>> Used following C code to test this:
>>> -------------------------------------------------------------------
>>>
>>>    #include <stdio.h>
>>>    #include <stdlib.h>
>>>    #include <unistd.h>
>>>    #include <sys/ioctl.h>
>>>    #include <fcntl.h"
>>>    #include <errno.h>
>>>
>>>    #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
>>>
>>> int main(int argc, char *argv[])
>>> {
>>>           int fd;
>>>           int fd1;
>>>           int ret;
>>>
>>>           if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
>>>                   fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
>>>                   return -1;
>>>           }
>>>
>>>           fprintf(stderr, "Using FD %d\n", fd);
>>>
>>>           fd1 = atoi(argv[1]);
>>>
>>>           ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
>>>           if (ret < 0) {
>>>                   fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
>>>                   close(fd);
>>>                   return -1;
>>>           }
>>>
>>>           fprintf(stderr, "Got FD %d\n", fd1);
>>>
>>>           close(fd1);
>>>           close(fd);
>>>
>>>           return 0;
>>> }
>>> -------------------------------------------------------------------
>>>
>>> Results are:
>>> -------------------------------------------------------------------
>>>    # ./test 0
>>>    Using FD 3
>>>    Got FD 4
>>>
>>>    # ./test 1
>>>    Using FD 3
>>>    Got FD 4
>>>
>>>    # ./test 2
>>>    Using FD 3
>>>    Got FD 4
>>>
>>>    # ./test 3
>>>    Using FD 3
>>>    Got FD 4
>>>
>>>    # ls /sys/bus/iio/devices/iio\:device0
>>>    buffer  buffer0  buffer1  buffer2  buffer3  dev
>>>    in_voltage_sampling_frequency  in_voltage_scale
>>>    in_voltage_scale_available
>>>    name  of_node  power  scan_elements  subsystem  uevent
>>> -------------------------------------------------------------------
>>>
>>> iio:device0 has some fake kfifo buffers attached to an IIO device.
>> For me there is one major problem with this approach. We only allow one
>> application to open /dev/iio:deviceX at a time. This means we can't have
>> different applications access different buffers of the same device. I
>> believe this is a circuital feature.
> Thats not quite true (I think - though I've not tested it).  What we don't
> allow is for multiple processes to access them in an unaware fashion.
> My assumption is we can rely on fork + fd passing via appropriate sockets.
>
>> It is possible to open the chardev, get the annonfd, close the chardev
>> and keep the annonfd open. Then the next application can do the same and
>> get access to a different buffer. But this has room for race conditions
>> when two applications try this at the very same time.
>>
>> We need to somehow address this.
> I'd count this as a bug :).  It could be safely done in a particular custom
> system but in general it opens a can of worm.
>
>> I'm also not much of a fan of using ioctls to create annon fds. In part
>> because all the standard mechanisms for access control no longer work.
> The inability to trivially have multiple processes open the anon fds
> without care is one of the things I like most about them.
>
> IIO drivers and interfaces really aren't designed for multiple unaware
> processes to access them.  We don't have per process controls for device
> wide sysfs attributes etc.  In general, it would be hard to
> do due to the complexity of modeling all the interactions between the
> different interfaces (events / buffers / sysfs access) in a generic fashion.
>
> As such, the model, in my head at least, is that we only want a single
> process to ever be responsible for access control.  That process can then
> assign access to children or via a deliberate action (I think passing the
> anon fd over a unix socket should work for example).  The intent being
> that it is also responsible for mediating access to infrastructure that
> multiple child processes all want to access.
>
> As such, having one chrdev isn't a disadvantage because only one process
> should ever open it at a time.  This same process also handles the
> resource / control mediation.  Therefore we should only have one file
> exposed for all the standard access control mechanisms.
>
Hm, I see your point, but I'm not convinced.

Having to have explicit synchronization makes it difficult to mix and 
match. E.g. at ADI a popular use case for testing was to run some signal 
generator application on the TX buffer and some signal analyzer 
application on the RX buffer.

Both can be launched independently and there can be different types of 
generator and analyzer applications. Having to have a 3rd application to 
arbitrate access makes this quite cumbersome. And I'm afraid that in 
reality people might just stick with the two devices model just to avoid 
this restriction.

- Lars


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120D4045FF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 09:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350474AbhIIHOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 03:14:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:49628 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhIIHOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Sep 2021 03:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=G7K1+ASbNAT0M15fHoSo6raThgpx63J6G5EfX8D7W2c=; b=RXk8HRD4+DsEfmn38nZK0tVtjx
        Y8LlnkSnHiuM5+AfVrGC0XE/FnAtfEk783pO+L/LSeojwD2mOBZpZvkzjs1IDQ3GN+tjHznP1wLJ4
        nA/f7FdorNcXBFOnFZtyq75uXdKQ6ibLYHaYV8/g9nth80ArrvLbKPQz8d8dORdYK+i8DNS9vwktZ
        S+lOT9E+bBut0XO57ufBGwZQx1syWcGvVc6pYl8HPhHfa6tuWaLvaJd1fKJIK1xKQSqUDmsUOiW1K
        4U37W4ti8YZ/DK0gaQPW6FA5coiwtzLBJ7czzqnwtPujfVtrZzdBeXC7SnkGH+Z40MU09KmxN15mK
        yKeed0lQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mOEEt-0005Qp-4h; Thu, 09 Sep 2021 09:12:51 +0200
Received: from [62.216.202.248] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mOEEs-000Vkn-Tt; Thu, 09 Sep 2021 09:12:51 +0200
Subject: Re: Looking for clarification on sysfs IIO devices, do _raw devices
 require both _offset and _scale?
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>,
        linux-iio@vger.kernel.org
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Ed Tanous <ed@tanous.net>, Ed Tanous <edtanous@google.com>
References: <cc74f30f-9ab8-45ce-1f44-8e55c3f9c5ce@linux.vnet.ibm.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5c79425f-6e88-36b6-cdfe-4080738d039f@metafoo.de>
Date:   Thu, 9 Sep 2021 09:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cc74f30f-9ab8-45ce-1f44-8e55c3f9c5ce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26288/Wed Sep  8 10:22:21 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/9/21 12:10 AM, Bruce Mitchell wrote:
> In reference to:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
>
> I have Temperature, Pressure, and Humidity IIO sensors.
> IIO _raw devices look like this on sysfs:
>   this happens to be a SI7020 type device with 2 sensors
>     /sys/bus/iio/devices/iio:device0/in_humidityrelative_offset
>     /sys/bus/iio/devices/iio:device0/in_humidityrelative_raw
>     /sys/bus/iio/devices/iio:device0/in_humidityrelative_scale
>     /sys/bus/iio/devices/iio:device0/in_temp_offset
>     /sys/bus/iio/devices/iio:device0/in_temp_raw
>     /sys/bus/iio/devices/iio:device0/in_temp_scale
>
> Other IIO _input devices look like this on sysfs:
>   this happens to be a DPS310 device with 2 sensors
>      /sys/bus/iio/devices/iio:device1/in_temp_input
>      /sys/bus/iio/devices/iio:device1/in_pressure_input
>
> As I read it if the IIO device was an _input type on sysfs,
> just read it (and possibly scale it for units).
>
> But if the IIO device was a _raw type on sysfs my understanding
> is that it must be accompanied by a _offset and a _scale for
> at least temperature, pressure, humidity, voltage, and current
> sensors.
> Is that correct?
>
> Further for any IIO device that is a _raw type on sysfs is it
> required to be accompanied by a _offset and a _scale as well?

Hi,

That sounds about right.

The _input name is historically and comes from hwmon framework. It means 
that the data has been processed by the kernel driver and converted to 
the right SI units for the channel type. This is usually used for sensor 
that have a non-linear transfer function. `raw` on the other hand means 
the data is just as it is reported by the hardware. The reason for this 
is that conversion to SI units is often not lossless, since we have 
finite precision. So it is up to the application to decide whether it 
wants to work on the raw data or how it wants to round the converted data.

`input` attributes never have scale and offset since they are already in 
the right unit. For raw scale and offset are optional. If scale does not 
exist assume it is 1, if offset does not exist assume it is 0. You'll 
rarely see a device with raw attributes without scale, but there are 
quite a few without offset.

- Lars



Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C5136E62C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhD2Hku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 03:40:50 -0400
Received: from first.geanix.com ([116.203.34.67]:39984 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2Hku (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Apr 2021 03:40:50 -0400
Received: from [192.168.64.189] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 2215446636B;
        Thu, 29 Apr 2021 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619682001; bh=56ciJXj0zEPbXvYjI8z9gZXwvKQykcQRAbA6bjkZZeA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hNfpozdCd3y5U+w9Dh2lPcgSHYhFC9DslnaxMfLrzv+oQfsUS8CP4hJ+fw+2pMcOM
         OpvEZcDrUI0QbHIY+K92bxSlajFssnBFIuUAYm7iCjPz1Ine46NIRJEEy8Kc9undQd
         Z+Jzyi8yV6T4HmOQ+4ceYtqrcenZchDuLvOSSI9vSb6y2iKUGHr3ehRj4WjrG23OZf
         LrHDgadUhJesl+JMlVNiLpXgSCPh9huEllkHfxET0VMv77ZH9xVM7wz0GdyzfvYmCT
         hap8bY3KR0Vq/Nkd4FYpKp50wj6+PCs/LouTnG8d/fcwIkgmyQJDUqoK1pxiPWWDAe
         oAhbgXtb/QCuA==
Subject: Re: [RFC PATCH 3/4] iio: accel: fxls8962af: add hw buffered sampling
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210428082203.3587022-1-sean@geanix.com>
 <20210428082203.3587022-3-sean@geanix.com>
 <20210428173238.0000540d@Huawei.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f679124a-4efc-c98d-49ec-dd294fe44b5a@geanix.com>
Date:   Thu, 29 Apr 2021 09:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428173238.0000540d@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/04/2021 18.32, Jonathan Cameron wrote:
>> When buffered sampling is enabled, the accelerometer will dump data into
>> the internal fifo and interrupt at watermark. Then the driver flushes
>> all data to the iio buffer.
>> As the accelerometer doesn't have internal timestamps, they are aproximated
>> between to interrupts.
> two?
>
> This tends to be a noisy approach, so people often try to apply a filter.
> However, no need to do that for an initial version.
>
> There are some things in here referring to enabling triggered modes, but I'm
> not seeing code to actually do so.  The fun question when dealing with fifos
> and triggered mode is what the interface is to switch between the two.
> One option I think we've used before is to just have 'no trigger' match
> up to fifo mode and if a trigger is set, don't use the fifo.
>
Thanks Jonathan.

Fixed the above text to:
As the accelerometer doesn't have internal timestamps,
they are approximated between the current and last interrupt.

I don't know the correct term here, the accelerometer via the watermark, 
is doing interrupts.
Is that called no-trigger / trigger ?

/Sean

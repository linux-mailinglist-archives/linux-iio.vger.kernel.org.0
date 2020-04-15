Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F041AAB10
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371127AbgDOO4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 10:56:08 -0400
Received: from www381.your-server.de ([78.46.137.84]:59296 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371077AbgDOOzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 10:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yz0l86f24qxXld0PMX62MsPf2RZVXxmRh2DJRXJDM6E=; b=fxFdIKdgV28mihHYh8iY9qHHG2
        p54PwuQp+gih3nPpoRxr5D//jlBEmngtnQJj/2SvNCVpd7I3OmXHIMZNfWkeZmmFHGHwCDQq5mkuw
        Wm8+PoTmMu1WMkyOdBxoCI4qo3FrWmW2qVmIYE8T9LVwub/ssQ8pz96/QKy8E4AND0+NAPkRWl3U6
        23jzKJvPzNTcm/D/Atj4jmFVqIgtAncuiW9Q5iv05Ml+n3v5SGKAUGyIjF/jkS7+nf+JO7V3Kg4HB
        Yqt85o/bL4rXYo1jwPDmDiIzTHQlQI63zlTsGmJZrz5GHFTYlAXcbPvPNMfZca5i+veWtOQqHNFdt
        6tLOxO9g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jOjS1-00066E-8u; Wed, 15 Apr 2020 16:55:41 +0200
Received: from [82.135.68.81] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jOjS1-000GwS-1r; Wed, 15 Apr 2020 16:55:41 +0200
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200414083656.7696-1-alexandru.ardelean@analog.com>
 <20200414190629.2d85759e@archlinux>
 <761fb0aef92e5e026df78b6679329dbbb55b6226.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5d3d6bad-934d-41c5-d167-dd69734e8015@metafoo.de>
Date:   Wed, 15 Apr 2020 16:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <761fb0aef92e5e026df78b6679329dbbb55b6226.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25783/Wed Apr 15 14:03:13 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/15/20 3:56 PM, Ardelean, Alexandru wrote:
> On Tue, 2020-04-14 at 19:06 +0100, Jonathan Cameron wrote:
>> [External]
>>
>> On Tue, 14 Apr 2020 11:36:56 +0300
>> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>>
>>> The final intent is to localize all buffer ops into the
>>> industrialio-buffer.c file, to be able to add support for multiple buffers
>>> per IIO device.
>>>
>>> We only need a chardev if we need to support buffers and/or events.
>>>
>>> With this change, a chardev will be created:
>>> 1. if there is an IIO buffer attached OR
>>> 2. if there is an event_interface configured
>>>
>>> Otherwise, no chardev will be created.
>>> Quite a lot of IIO devices don't really need a chardev, so this is a minor
>>> improvement to the IIO core, as the IIO device will take up fewer
>>> resources.
>>>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> ---
>>>
>>> Changelog v1 -> v2:
>>> * split away from series 'iio: core,buffer: re-organize chardev creation';
>>>    i'm getting the feeling that this has some value on it's own;
>>>    no idea if it needs 'Fixes' tag; it is a bit fuzzy to point to a patch
>>>    which this would be fixed by this; i'm guessing it would be fine
>>>    without one
>> I'd argue it's an 'optimization' rather than a fix :)
>>
>> Still looks good to me but I'd like it to sit for a little while to
>> see if anyone points out something we are both missing!
>>
> This is not good.
> It seems that I did not properly test all cases.
> I had to break a device to not have an event_interface to notice that the sysfs
> doesn't get instantiated either because device_add is missing.
>
> Will do another try.

I think you also have to make the `indio_dev->dev.devt = ...` 
conditional. Or conditionally use device_add() instead of device_add_cdev().

If you go for the former you need to call cdev_device_del() 
unconditionally, for the latter call device_del() or cdev_device_del() 
depending on whether the cdev was registered.

- Lars



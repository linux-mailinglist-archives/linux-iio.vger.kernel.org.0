Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9719EA3C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 11:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDEJ5K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 05:57:10 -0400
Received: from www381.your-server.de ([78.46.137.84]:43924 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDEJ5K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 05:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XQvuT3mwH58R+hyr2PXK6ydmSwf8EK//RCCsfqoyozM=; b=m9uBZ1y0fdujBBOjaDvT4oSVGP
        k9z2i/kifi/RLD1bLj9eku5XUU1RQQThfFCgZ++TZ67cw5VUwfCpTGE6RlnY8zjonHFg9TxnD8viE
        RrK1UNABxIuEX7zrgfNss0W3xi6bOjTEdmceMQ0KNcik4/O8G7Q152NYEk992drIv9Vte4x5cbRpZ
        5G39vKh+7y8w2bgxoV7NoftvfnFkrdinIhGTLB4Gtri+jTC5krDPVsVeDlnwNCwEI5EjDH+9eYn0X
        WnjrMjbdQ+ev/J/QkiA6lBcEBitP2j6cpiYs4WDXlcVCcTUVQaWnHo8g5gv9iGiEiYCUNLS31MufM
        h2ewJ93Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jL21b-0003Mx-K7; Sun, 05 Apr 2020 11:57:07 +0200
Received: from [82.135.79.250] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jL21b-000R2w-Au; Sun, 05 Apr 2020 11:57:07 +0200
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for chrdev
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
 <20200330145705.29447-4-alexandru.ardelean@analog.com>
 <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
 <20200405104939.0e220daa@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <bcdeeb9e-b225-6f6a-65f4-49023ebba169@metafoo.de>
Date:   Sun, 5 Apr 2020 11:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405104939.0e220daa@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25772/Sat Apr  4 14:56:57 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/5/20 11:49 AM, Jonathan Cameron wrote:
>>> 3. A side question is about the 'iio_buffer -> pollq' field. I was
>>> wondering if it would make sense to move that on to 'iio_dev  pollq' if
>>> adding multiple buffers are added per-device. It almost makes sense to
>>> unify the 'pollq' on indio_dev.
>>> But, it looks a bit difficult, and would require some more change [which is
>>> doable] if it makes sense for whatever reason.
>>> The only reason to do it, is because the iio_buffer_fileops has a .poll =
>>> iio_buffer_poll() function attached to it. Adding multiple buffers for an
>>> IIO device may require some consideration on the iio_buffer_poll() function
>>> as well.
>> I think we need one chardev per buffer. Conceptually that is the right
>> approach in my option since the two buffers are independent streams. But
>> also from a practical point of view we want to have the ability to have
>> the buffers opened by different applications. E.g. iio_readdev on the
>> input buffer and iio_writedev on the output buffer. And there might be
>> some other operations that wont multiplex as nicely as read/write. The
>> high speed interface for example would not work as it is right now.
>>
> Yup. Separate chardev is pretty much the only option given the poll infrastructure.
> In theory could do the anon file trick again but I'm not sure it's worth it
> - the vast majority of drivers are still going to be single buffer (I think!)
The main problem I see with the anon file trick is that we use the open 
file also as mutual exclusion so only one application can access a 
buffer at a time. This means if one application has the main chardev 
open no other application will be able to access the buffers (or events).

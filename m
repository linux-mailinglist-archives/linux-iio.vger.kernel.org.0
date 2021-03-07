Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C133010E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCGMyu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:54:50 -0500
Received: from www381.your-server.de ([78.46.137.84]:48318 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCGMyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 07:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=t2IT8969XHmUqRaazwfib8rQbdSxedTrGWGhUS4AiOM=; b=a21Nsi0GLih6NIIjw6S5nFusJk
        DKpNPpHK+IcKtrA8eWUDY1+72BMahDvZyyqvoCY+Lxu0yLiG6F8qHmspp7OCT5rDHykn0ZdsYuHvf
        Z/TgNNrMHTlHq6H2LxFQjQGh9VBTh8DNhifCmlm7Blvg9yjsRSOnxHmgFQ30SJkn/YEVtpg+CQmyS
        KXV7RAyEGFI1jMkCxyaTADBxmqNnLFF/uUg27rq0P8gkNpWqgEZNPWBj3pnDvB4vZQ0xaZwB1k79n
        seueybamjPllrZbr6/nzpXDq4iGQVEJh7NbWPpuwRjC4JMOQ0MBv6IZUDK8g25VGzuOkLoI//V+Zo
        ZZjv963g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lIsvU-000ANi-Oo; Sun, 07 Mar 2021 13:54:28 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lIsvU-000Puc-K7; Sun, 07 Mar 2021 13:54:28 +0100
Subject: Re: [PATCH] iio: buffer: fix use-after-free for attached_buffers
 array
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210306164710.9944-1-ardeleanalex@gmail.com>
 <20210307123658.3bdc0016@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a1ffef80-2f43-68bc-cb46-4f3bac326671@metafoo.de>
Date:   Sun, 7 Mar 2021 13:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210307123658.3bdc0016@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26101/Sun Mar  7 13:10:08 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/7/21 1:36 PM, Jonathan Cameron wrote:
> On Sat,  6 Mar 2021 18:47:10 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
>> Thanks to Lars for finding this.
>> The free of the 'attached_buffers' array should be done as late as
>> possible. This change moves it to iio_buffers_put(), which looks like
>> the best place for it, since it takes place right before the IIO device
>> data is free'd.
> It feels a bit wrong to do direct freeing of stuff in a _put() call
> given that kind of implies nothing will happen without some reference
> count dropping to 0.  We could think about renaming the function to
> something like
>
> iio_buffers_put_and_free_array() but is a bit long winded.
>
> Otherwise, I'm fine with this but want to let it sit on list a tiny bit
> longer before I take it as it's not totally trivial unlike the previous
> one.

Maybe to go with naming schema of iio_device_attach_buffer() call this 
function iio_device_detach_buffers(). We grab the reference in attach, 
and drop it in detach.

- Lars


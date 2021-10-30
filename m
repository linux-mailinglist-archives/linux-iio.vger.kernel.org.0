Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E294409D8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhJ3POi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 11:14:38 -0400
Received: from www381.your-server.de ([78.46.137.84]:58714 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJ3POh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 11:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=051ynGXUf8lsGhkjxVAQwHJzi1pW88P6WHqfNb6Du1U=; b=MrNcO+61lWUWaIqEtdqyz6INAH
        ySuQn4Trr9vId8nVUB3FuFcpyDo5nJkkC832kPAYYpAYXxtmtiDnkB+D48IlyNQc6hq7/A/HVAyr+
        DJOXBEx020PMM+nuweFPHcaZA7NLtKR3OkSndeAiAhGWgatFLMO6kv5yJuEjw1n1jFvimaNy3ugY2
        OZBPmRX5nLIRJiYmf0eebzQjdoF9y8bSR9IVzJ9GibAamLhNhO4r95PSeSz/AA25U20oSnmPlgRn/
        HvnqgDXdT4uoCgGYukKMPWRIknLWMknwTBQjKd7w8LwVC0syFLgLwwraMdyzpgT3tt0PsOtiTScp2
        nhY2yWog==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mgq1a-000AU7-QY; Sat, 30 Oct 2021 17:12:02 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mgq1a-000OHB-Kk; Sat, 30 Oct 2021 17:12:02 +0200
Subject: Re: [PATCH 1/2] iio: mma8452: Fix trigger reference couting
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20211024092700.6844-1-lars@metafoo.de>
 <20211028150731.753d4e40@jic23-huawei>
 <3bf78fdf-c6df-dd77-a1f1-61800c0ebe37@metafoo.de>
 <20211030160357.6191e2a8@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <86c1aa49-edc4-c02c-7ab7-4d075819a847@metafoo.de>
Date:   Sat, 30 Oct 2021 17:12:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211030160357.6191e2a8@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/30/21 5:03 PM, Jonathan Cameron wrote:
> On Thu, 28 Oct 2021 21:52:46 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 10/28/21 4:07 PM, Jonathan Cameron wrote:
>>> On Sun, 24 Oct 2021 11:26:59 +0200
>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>   
>>>> The mma8452 driver directly assigns a trigger to the struct iio_dev. The
>>>> IIO core when done using this trigger will call `iio_trigger_put()` to drop
>>>> the reference count by 1.
>>>>
>>>> Without the matching `iio_trigger_get()` in the driver the reference count
>>>> can reach 0 too early, the trigger gets freed while still in use and a
>>>> use-after-free occurs.
>>>>
>>>> Fix this by getting a reference to the trigger before assigning it to the
>>>> IIO device.
>>>>
>>>> Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Gah. I thought we'd gotten all these years ago. I guess this one slipped through
>>> the net.
>> Btw. we already have iio_trigger_set_immutable(), which handles the
>> reference counting. I was think of adding a iio(_device)_trigger_set()
>> that does the same except not setting the trig_readonly flag. And then
>> eventually move the trigger to iio_dev_opaque. Any concerns with this?
> No concerns, seems like as sensible change given how things are evolving.
> Obviously some other stuff that would need changing before we can
> actually move trig.
>
> One early step would be to modify iio_trigger_notify_done() to take
> a struct iio_dev rather than a struct iio_trigger.  A job for a coccinelle
> script I think!  That function name might need a rethink along with the
> parameter change.

That was my first idea, but then I was like why do we even have to call 
notify_done()? Can't we automate this, given all the bugs we had around 
this over the years.

Sill work in progress: 
https://github.com/larsclausen/linux/commit/d6ed694c9e512e1f7f3b40ad06b153feca8d7bb1 
but I think this will work.

>
> Hmm. Looks like we have a few drivers passing indio_dev->trig to iio_trigger_poll
> as well which is a little odd.  mma8452 is one of them and it's not using
> an immutable trigger or validate_trigger() so unexpected results if anyone
> changes the trigger...  Possibly not fatal as the interrupt will probably
> not occur but not correct either...
Yep, that's on my radar too. And one of the reasons to move the trigger 
to the opaque structure so this type of error can not happen.

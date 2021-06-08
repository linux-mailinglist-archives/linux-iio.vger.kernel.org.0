Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E332739F7B9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFHNYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 09:24:45 -0400
Received: from www381.your-server.de ([78.46.137.84]:43980 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhFHNYo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=I2cWXquZJDVou/OC1fY/cYEM6RhlJcSN5XbsU8O/Sww=; b=HtHQtSovHX1Tbq0MhyAUrGqTQU
        nlfb+lfkJf6TRq7gWbeFHVAzYuZqTCK2lKjDC6Qu0vnLmiYZjyM6LWXIUrmz8HVcaM8nSpLbwpxVc
        MMWFa+gJ8DFKFNRuSUpdKd74xF823zcogaRxsa646c5Hq7FFmhygAzln58NAIdoyFM0u52jqigo6D
        Oz5nZFECyjP5YTndE0N/fWhzRhjDrD8mTyCwutRD1o8CxEGdSQ9u8/H3IJEWW27QFaWRWWsQLcSUx
        c9aYKqaivRsxb9Mc+UMW8t8W1heaUXxS7r+y3Z8U1J68vayamvoykdVbGtjpmjViqDERNmNJ+EUqa
        7n4YwI6g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lqbgw-0006pt-D2; Tue, 08 Jun 2021 15:22:50 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lqbgw-000Pdm-9L; Tue, 08 Jun 2021 15:22:50 +0200
Subject: Re: atomic use is not atomic?
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
References: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
 <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de>
 <CAHp75VeC=trDNkhYbMpeCOYVRK124HPJNVX=tWmfy1Jh5akOzw@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b79edabf-593f-81d3-0954-0557a7f73e57@metafoo.de>
Date:   Tue, 8 Jun 2021 15:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeC=trDNkhYbMpeCOYVRK124HPJNVX=tWmfy1Jh5akOzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26195/Tue Jun  8 13:07:27 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/8/21 3:14 PM, Andy Shevchenko wrote:
> On Tue, Jun 8, 2021 at 3:44 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 6/8/21 2:35 PM, Andy Shevchenko wrote:
>>> Hi!
>>>
>>> Can anybody explain this code [1] in terms of atomicity?
>>>
>>>     if (!atomic_read(&trig->use_count)) {
>>>       atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>>>       ...
>>>     }
>>>
>>> AFAIU how atomics are supposed to work the above doesn't do anything
>>> atomically. I.o.w. use_count may be simple int with the same effect.
>>>
>> The operations here do not require atomic access, it is just operating
>> on a atomic type. The atomic access is the atomic_dec_and_test() in
>> iio_trigger_notify_done().
> So, between atomic_read and atomic_set somebody can call
> atomic_dec_and_test(), for example. Is it a problem to actually lose
> the value?
> Why are atomic types being used here when there is no atomicity guaranteed?

We know that if the value is zero that there are no more active 
consumers. Then we set the value to the number of consumers, and then 
launch the consumers, which will decrement the counter once they are done.


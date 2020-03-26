Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2D1939BE
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 08:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCZHod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 03:44:33 -0400
Received: from www381.your-server.de ([78.46.137.84]:44578 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCZHod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 03:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7QaSOnUI/EJ9EDvESN5tQ9P5eS5ryHrNNO2QCFGCfgE=; b=kIn+QipPmKOmt9KAXvkAPNMj+N
        nTaZfUZg/QRXeFcrZhVE6wy8BSDPN+0h1536BsnqNbvWn/Z2fSFULxf/smYkg2P5UX/Wkwut0Yjup
        e7ldLzIcwNvrfXrmMyyJZgrbXqLb+zpfHR4icixEcxKFtKO1z89ZctVm2/t1BnT+Kw85U2Cl3zWkN
        P2V9efiqkew0tyZNuTZbPvxtVDJT2N0AWZOyEGcVDJ3iF03oRXpKmFgF9IR17UCui3XLynZ52aQnV
        NQ8WmZ4P0Mj/Y1GtRodL/fNmPzCi0G940emMCpukffeFVKJiIFwmoVFDMJ1Slx+7cCZP6swK1tBbb
        /QqVNfag==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jHNBk-0007A6-6o; Thu, 26 Mar 2020 08:44:28 +0100
Received: from [82.135.74.79] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jHNBj-000HsL-T0; Thu, 26 Mar 2020 08:44:27 +0100
Subject: Re: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Cc:     "pmeerw@pmeerw.ne" <pmeerw@pmeerw.ne>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
 <20200325100112.85107-1-alexandru.ardelean@analog.com>
 <CAHp75VfVggWZ6WhOa=nUrxyd0dJrTbZd9NnUMhQ_S=kncrAhOw@mail.gmail.com>
 <62b90724f16fa3a2c54b7e7f2321587a328d7209.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f74263bc-5d42-db67-942e-f5970c71381e@metafoo.de>
Date:   Thu, 26 Mar 2020 08:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <62b90724f16fa3a2c54b7e7f2321587a328d7209.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25762/Wed Mar 25 14:09:24 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/26/20 8:42 AM, Ardelean, Alexandru wrote:
> On Wed, 2020-03-25 at 17:57 +0200, Andy Shevchenko wrote:
>> [External]
>>
>> On Wed, Mar 25, 2020 at 12:02 PM Alexandru Ardelean
>> <alexandru.ardelean@analog.com> wrote:
>>> From: Lars-Peter Clausen <lars@metafoo.de>
>>>
>>> Before activating a buffer make sure that at least one channel is enabled.
>>> Activating a buffer with 0 channels enabled doesn't make too much sense and
>>> disallowing this case makes sure that individual driver don't have to add
>>> special case code to handle it.
>>>
>>> Currently, without this patch enabling a buffer is possible and no error is
>>> produced. With this patch -EINVAL is returned.
>>>
>>> An example of execution with this patch and some instrumented print-code:
>>>     root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>>>     root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>>>     0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer-
>>>> scan_mask 00000000
>>>     1: iio_verify_update 753
>>>     2:__iio_update_buffers 1115 ret -22
>>>     3: iio_buffer_store_enable 1241 ret -22
>>>     -bash: echo: write error: Invalid argument
>>> 1, 2 & 3 are exit-error paths. 0 the first print in iio_verify_update()
>>> rergardless of error path.
>>>
>>> Without this patch (and same instrumented print-code):
>>>     root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>>>     root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>>>     0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer-
>>>> scan_mask 00000000
>>>     root@analog:/sys/bus/iio/devices/iio:device3/buffer#
>>> Buffer is enabled with no error.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> ---
>>>
>>> Changelog v1 -> v2:
>>> * moved check in iio_verify_update()
>>> * added dev_dbg() message; should help some folks understand the message
>>> * documented steps to reproduce
>>> * added Fixes tag; hopefully the tag is the good one; if needed, it can be
>>>    dropped; this has been around for ~8 years; no idea if it's worth
>>>    backporting
>> Where?
> stable/fixes/lts-kernels
> don't have a really good clue about where these things need backporting;
What Andy means is that there is no Fixes tag :)

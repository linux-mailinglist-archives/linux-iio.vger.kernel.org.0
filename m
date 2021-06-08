Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1474539F703
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhFHMqK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 08:46:10 -0400
Received: from www381.your-server.de ([78.46.137.84]:50362 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFHMqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 08:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=5fdPlqTSfGLGZCvNtriN+y5mWh57Y5NP/X77AY1B47c=; b=CP2S/y/YVQ1SPbs5tNrJHWMADR
        bsU0UKkCqq2Dtajv3PbdaULc96vtjZ9jkYu7zqRYtCQNSoJRyNCMhohtXIEJx1OCLzbaExGEn99kW
        K4paKBzafdHooo7l9+zaAEoSD+ACIZj6F7hdVG5tH+mfCXkx7TG9kZRy60qXgTusX6o0uLu+ohw2Y
        fp6RBAKvmfPxINVgAHQlE+dCsuqbw+wSWXaichaFOrhRlx3jnGxHyUuk2oHDqmR0dkYLz5XQFiH/4
        8lxuyZdeLv5XVCzi7j2RDS/msL8xMvdwOCgvsAKDFDvZ+YEP6vo/Qgzj2L0mhSj529G3jQjvPn6cv
        e46t/9Pg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lqb5a-000Gof-Qv; Tue, 08 Jun 2021 14:44:14 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lqb5a-0003N3-NN; Tue, 08 Jun 2021 14:44:14 +0200
Subject: Re: atomic use is not atomic?
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
References: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de>
Date:   Tue, 8 Jun 2021 14:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26195/Tue Jun  8 13:07:27 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/8/21 2:35 PM, Andy Shevchenko wrote:
> Hi!
>
> Can anybody explain this code [1] in terms of atomicity?
>
>    if (!atomic_read(&trig->use_count)) {
>      atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>      ...
>    }
>
> AFAIU how atomics are supposed to work the above doesn't do anything
> atomically. I.o.w. use_count may be simple int with the same effect.
>
The operations here do not require atomic access, it is just operating 
on a atomic type. The atomic access is the atomic_dec_and_test() in 
iio_trigger_notify_done().

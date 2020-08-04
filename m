Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6A23B6D3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHDIfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 04:35:03 -0400
Received: from www381.your-server.de ([78.46.137.84]:33268 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgHDIfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 04:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=S5HW9YqmHmV1Y/k3CNQcKpnE6tmv04nycPktPNyk1BY=; b=PjOXiOw7/ykfaOcQjQdMrJkjM6
        I39GnTow0nG6T6T/u7lxrm6gEVrStXbsD+tKkwy9OjDvESf3fH0nXsfEoxyWq3WX4GRJ8/3OEkXq9
        /qgTTPU7ebjy6JI9b4olZfRALbrfwKIKhTgVX6ji49b5AipxL5IWdk26l7ldozFZ81l7zGsW8Wrr2
        jf/UMYRYpohaMlBGNd3einTt6apXdzUZHO0c+HDJkeNp6Z70wJkTFofuaAgSPtuleCvzU0lFGtRw3
        IeF3KCa9JKk7UO946Zf7NOF1eHgA9RTWKD7eaDaao9u+Jch3L0Q99OvsMrqRMJ8pTaR9l5O5zIoLS
        m5iG12Hg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k2sPM-0001M6-0A; Tue, 04 Aug 2020 10:34:52 +0200
Received: from [2001:a61:2517:6d01:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k2sPL-0003rl-P0; Tue, 04 Aug 2020 10:34:51 +0200
Subject: Re: [PATCH v5 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200802163735.76617-1-ceggers@arri.de>
 <20200802163735.76617-3-ceggers@arri.de>
 <CAHp75Vev64E86OWm+eV=1o4ZDs0Xh_Y1z6V54GmpRwWmjD7=eA@mail.gmail.com>
 <2356337.HYKpEJ1Wej@n95hx1g2>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2e5f6884-66a4-f8e7-6579-247599183d9e@metafoo.de>
Date:   Tue, 4 Aug 2020 10:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2356337.HYKpEJ1Wej@n95hx1g2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25893/Mon Aug  3 17:01:47 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/4/20 9:40 AM, Christian Eggers wrote:
> On Sunday, 2 August 2020, 20:02:35 CEST, Andy Shevchenko wrote:
>> Thanks for an update, my comments below.
> Thanks for the review. Please see below for my questions.
>
> Best regards
> Christian
>
>> On Sun, Aug 2, 2020 at 7:40 PM Christian Eggers <ceggers@arri.de> wrote:
>>> Datasheet:
>>> https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-
>>> b302-c2fd-e30a-c98df87616df
>> Do we need the UUID after the document file name?
> I have send AMS an inquiry. Not sure whether I will get an answer. I will wait
> a few days until sending v6.
>
>>> +#define AS73211_OFFSET_TEMP (-66.9)
>>> +#define AS73211_SCALE_TEMP  0.05
>> In the kernel we don't do float arithmetic. How these are being used?
> Does this restriction also apply for compile time constants? I am quite
> sure that all calculations using these defines will be evaluated at compile
> time. If found a number of other places where probably the same is done:
>
> find . -name '*.c' | xargs grep "#define.*[0-9]\.[0-9]" | grep -v '"' | grep -v "\/\*.*[0-9]\.[0-9]"

I believe it is implementation defined. The compiler is free to generate 
floating math and do the conversion at runtime. Although it is probably 
safe to assume that no reasonable compiler will do this for your code. 
If only we had constexpr in C, then there was a way to make it 
guaranteed that the conversion happens during compile time.

But I agree with you, it would be nice to have a cleaner way of 
declaring fixed point numbers without having to pay attention to how 
many 0s you have to put after the least significant digit.


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9111ECDB3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCKiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 06:38:03 -0400
Received: from first.geanix.com ([116.203.34.67]:33140 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCKiC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 06:38:02 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id 1A38C2120BC4;
        Wed,  3 Jun 2020 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591180680; bh=I5gHF4gasLqiSW77qs/pgSIz7OjYDBi1Vnpm/ZyFd18=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WlNMLEbARr0DYUD+OeV31qTuO7fOWmtv20FHwDbnYa1+ecI4eK5h81DHDp/dm+Nun
         wphg4H0CLXBWevFyOw3D2bJSMbfyY4JNYRKmjgb055Fftch2jpY36idrWwW4sg+wPI
         jz4oUVFkg6cVwTlgnKXwMJRHgeJqvqO7XJxowyD628a3qIrQ5/l5JHckyaH71xdZz+
         xHXiW3JeJekHYQqC/HJVt048hQwCSYNYbu1GWKdWVqrGyNIKWxBtE+lvxCJwabcKVR
         4x5eZ2an2ipsu+KhW5q/7yz846GK08git8tLqOsMSfZmB54tVAnzitz6e8RffaRNMv
         O15lgZefSaEig==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
 <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
Date:   Wed, 3 Jun 2020 12:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603102841.GC544784@lore-desk.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>>
>> Hmm, suspend again for 15s.
>>
>> https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
>>
>> [  105.520634] PM: suspend exit
>> [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time
>> 1591097310641881385
>>
>> [  105.548416] ktime_get_real_ns: 1591097322928175385
>>
>> CLOCK_REALTIME isn't ready in the resume function. I think we need to link
>> it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
> 
> With latest patch it seems to me the time reported is now monotonic so it seems
> correct. What is the clocktype you set? you can check it in:
> /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock

default: realtime

In the dump above the ktime_get_real_ns(first fifo dump after suspend) - 
  ts_ref + ts is = 12,286294 sec...

/Sean

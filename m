Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8181C2AD4
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgECJIG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:08:06 -0400
Received: from www381.your-server.de ([78.46.137.84]:56340 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgECJIG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BETlCmS6FRwXGPjY7EbPU0StF1KNKBAdQE/SWk0Jk88=; b=cBYMp/cLSYq4EhCQafzfBewNXd
        hej0/vcJ+FdAIQINFlkX2CxD6njuZimBcHHoQB1/UkohfgbhAZr48fn9yETwElW5nmtQdA//Ez4yc
        Cm76EOTm3e2YXAh/hsZrfjberWLU02eZYkulAf8YVLDpysTmo2aim6zFyH+iwzCLoUCEXNb9/C9Jl
        DHQ0hSVJtGY7QHgGvEVqXeNnwViiMAXB+8Wad8npyoEU1w+voEKeBUCwrQC/SxLcIglyBIli46cZR
        cyM4mgeTrzjAB/64JjrLe9iqOG6nYPXSg76+RTRk7uRBGhSWSetFtMXs9wiorW5TqbfFUSjOwK/0Q
        SIaKIjhg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jVAbO-0000G7-Eo; Sun, 03 May 2020 11:07:58 +0200
Received: from [82.135.70.217] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jVAbO-0002ZY-1T; Sun, 03 May 2020 11:07:58 +0200
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
To:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20200413082445.17324-1-nuno.sa@analog.com>
 <20200413082445.17324-6-nuno.sa@analog.com>
 <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
 <20200502184010.134eb8b5@archlinux>
 <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
 <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
 <20200503094751.633feda1@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
Date:   Sun, 3 May 2020 11:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503094751.633feda1@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25800/Sat May  2 14:08:18 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/3/20 10:47 AM, Jonathan Cameron wrote:
> On Sat, 02 May 2020 21:52:18 +0200
> Nuno Sá <noname.nuno@gmail.com> wrote:
>
>> On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:
>>> On 5/2/20 7:40 PM, Jonathan Cameron wrote:
>>>> On Mon, 27 Apr 2020 20:06:07 +0200
>>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>    
>>>>> On 4/13/20 10:24 AM, Nuno Sá wrote:
>>>>>> [...]
>>>>>> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>>>>>> +{
>>>>>> [...]
>>>>>> +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
>>>>>> [...]
>>>>>> +
>>>>>> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf-
>>>>>>> timestamp);
>>>>> If the timestamp is enabled the IIO core might insert padding
>>>>> between
>>>>> the data channels and the timestamp. If that happens this will
>>>>> disclose
>>>>> kernel stack memory to userspace.
>>>>>
>>>>> This needs either a memset(data, 0x00, sizeof(data)) or maybe put
>>>>> data
>>>>> into the state struct and kzalloc it.
>>>> Good spot. Could simply do __be16 data[ADI..] = {0}; rather than
>>>> explicit
>>>> memset, but some form of zeroization is needed.
>>>>
>>>> I've fixed up the applied patch with the above approach.
>>> There is actually another issue. The stack data is not necessarily
>>> aligned to 64 bit, which causes issues if we try to put the 64-bit
>> Oh, this is actually more problematic. Yes, since we have an array of
>> u16, that is not guaranteed to be 64bit aligned. Doing a quick search
>> of `iio_push_to_buffers_with_timestamp()` users and I could quickly
>> find 4/5 drivers with the same problem. I guess the API should clearly
>> state that `data` needs to be __at least__ 64 bits aligned (maybe a
>> future patch). Or we could even check the address and guarantee that it
>> is properly aligned before continuing (though Im guessing this will
>> break a lot of users...)
>>> timestamp in it. I think data should really be in the state struct.
>> Yes, with a proper __aligned(8) attribute... Or couldn't we just use
>> __aligned(8) on the stack variable?
> Forcing alignment on the stack isn't terribly reliable, which is why
> we never do that for dma safe buffers.
>
> Probably better to just move it to the state structure.
> I'll fix it up to do that. Please sanity check what will shortly
> be in the testing branch.
>
> The moment Lars mentioned this I groaned. As you've noted a few other
> drivers have the same problem + the ABI doesn't clearly state
> or check this.
>
> We should certainly fix all the drivers that suffer this problem
> first then we can think about adding a runtime check.

It looks like it is actually quite a few drivers, maybe we should switch 
to put_unaligned(). We probably got lucky in most cases and the buffer 
is naturally aligned to 64 bit.

But the reason I noticed this is because I ran into the issue in the 
wild where the timestamp ended up at the wrong offset in the buffer, so 
it does happen.

The following semantic patch finds affected drivers.

@@
type T;
identifier buf;
expression N;
expression ts;
expression indio_dev;
@@
*T buf[N];
...
*iio_push_to_buffers_with_timestamp(indio_dev, buf, ts)

Matched files:

--- drivers/iio/health/afe4403.c
--- drivers/iio/health/afe4404.c
--- drivers/iio/gyro/mpu3050-core.c
--- drivers/iio/gyro/itg3200_buffer.c
--- drivers/iio/chemical/ccs811.c
--- drivers/iio/chemical/sps30.c
--- drivers/iio/chemical/pms7003.c
--- drivers/iio/proximity/isl29501.c
--- drivers/iio/proximity/mb1232.c
--- drivers/iio/accel/kxsd9.c
--- drivers/iio/accel/mma8452.c
--- drivers/iio/accel/bmc150-accel-core.c
--- drivers/iio/accel/mma7455_core.c
--- drivers/iio/adc/ti-adc081c.c
--- drivers/iio/adc/ti-adc084s021.c
--- drivers/iio/adc/ti-ads1015.c
--- drivers/iio/adc/ti-ads124s08.c
--- drivers/iio/adc/ina2xx-adc.c
--- drivers/iio/adc/ti-ads8688.c
--- drivers/iio/adc/ti-adc0832.c
--- drivers/iio/adc/ti-adc12138.c
--- drivers/iio/adc/max1118.c
--- drivers/iio/adc/ad_sigma_delta.c
--- drivers/iio/light/si1145.c
--- drivers/iio/light/vcnl4035.c
--- drivers/iio/light/max44000.c
--- drivers/iio/light/rpr0521.c
--- drivers/iio/light/st_uvis25_core.c
--- drivers/iio/light/ltr501.c
--- drivers/iio/magnetometer/ak8974.c
--- drivers/iio/magnetometer/mag3110.c
--- drivers/iio/magnetometer/ak8975.c
--- drivers/iio/humidity/hdc100x.c
--- drivers/iio/humidity/hts221_buffer.c
--- drivers/iio/imu/bmi160/bmi160_core.c
--- drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
--- drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
--- drivers/iio/pressure/ms5611_core.c
--- drivers/iio/pressure/mpl3115.c


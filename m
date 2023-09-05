Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02207926C3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbjIEQS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354625AbjIENBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 09:01:11 -0400
X-Greylist: delayed 1786 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 06:00:59 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AD127
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ACAF9ClUWwDZJwDgnuxRSVlhjhfgxu43rO1ox6huuZI=; b=E0W68D9Ls3NHOg6czl3Cw/tx+b
        1pVwDWqZRkr22JV3ljNTamHK23TTd9vww08UU/EQ1YVrqxFC5kwR94KUZOwAzIPLm57q1PUxSfeoO
        VYldlb88zR/0BJWeMu2gASAlP0hOcQuer4SMoKi9Zd2U6g1TVBu4dBM+tFI1WDyAccirGa+ajwhYD
        3fcn24eMARN0xPir1VKwjAMCOTCK5frW5Sdyfb8F1LRyFLPOPxCk3JfqzkP6BOBHgIHBXf7nFLVSt
        thHmJPO3E80O+cqT6EEwVl47kO+8NsGMaeiURDQSgSqNZg+wjXjpzZYyUChpFj4m64IBnbs+CPK1O
        HZDVNXLw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qdVCz-0002IT-CN; Tue, 05 Sep 2023 14:31:05 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qdVCz-000IH8-7L; Tue, 05 Sep 2023 14:31:05 +0200
Message-ID: <38f995ab-99de-1d88-696e-edc78e24c8b2@metafoo.de>
Date:   Tue, 5 Sep 2023 05:31:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Content-Language: en-US
To:     Tomas Melin <tomas.melin@vaisala.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com> <20230904141251.00002b7d@Huawei.com>
 <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <848d639c-43d1-bf92-2292-059dd1a019cf@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/27022/Tue Sep  5 09:59:33 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/5/23 04:43, Tomas Melin wrote:
> Hi,
>
> On 04/09/2023 16:12, Jonathan Cameron wrote:
>> On Mon, 4 Sep 2023 14:23:29 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> On Mon, Sep 04, 2023 at 01:15:22PM +0300, Tomas Melin wrote:
>>>> Support deferred probe for cases where communication on
>>>> i2c bus fails. These failures could happen for a variety of
>>>> reasons including bus arbitration error or power failure.
>>>> +out:
>>>> +	if ((ret == -EAGAIN) || (ret == -ENXIO))
>>>> +		return -EPROBE_DEFER;
>>>> +	return ret;
>>> Oh my... This looks so-o hackish.
>> Agreed.  This is a non starter.
>>
>>> If anything, it has to be fixed on the level of regmap I2C APIs or so.
>>>
>>> Maybe something like regmap_i2c_try_write()/try_read() new APIs that
>>> will provide the above. Otherwise you want to fix _every single driver_
>>> in the Linux kernel
>> Any probe ordering dependencies should be described by the
>> firmware and the driver should 'get' the relevant resource.
>> If there is anything not describable today then that is what we need
>> to fix, not paper over the holes
>>
>> So can we have specifics of what is happening here?
>>
>> If it's arbitration with some other entity then fix the arbitration
>> locking / hand over. If it's power, then make sure the relevant
>> regulator get gotten and turned on + has the right delays etc.
> Yes, right. In this use case, the ads1015 is connected to a channel of
> a i2c multiplexer. When the mux is probed, it also enumerates all the
> multiplexed buses and probes devices connected to them.
> For some reason, it behaves so that the ads1015 is not detected on the
> first attempt. Since it's a mux, connected to main i2c line, perhaps
> there really is some bus arbitration issue, or then something else.
>
> Anyways, when deferring the probe for the ads1015, and attempting later
> again it probes fine.
>
> So, it might be I've taken the wrong angle at this issue, but
> it does solve the issue at hand. Obviously, there could be some issue
> with the i2c mux driver, or then on hardware level too.
>
> Point is, that if the communication to the i2c bus has some temporary
> error like EAGAIN, why could it not be reasonable to try again at a
> later time instead of giving up completely.

The way probe deferral works, or is supposed to work, is that if a 
driver detects that it is missing a resource to initialize the device it 
can return EPROBE_DEFER to try again later. Once a new resource becomes 
available it will try again. In your case there is no resource 
dependency, but just a random failure. So there is no guarantee that 
probe will actually be called again since there might not be any new 
resources that become available.

The solution you've implemented might work on your specific platform, 
but it does not work by design, it only works by chance. Returning 
EPROBE_DEFER for things like IO errors is not the right approach. If you 
need a quick hack you can for example write a small userspace script 
that will trigger re-probe of the device at system startup.



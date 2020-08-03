Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC823ADDE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHCUA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 16:00:57 -0400
Received: from vern.gendns.com ([98.142.107.122]:41804 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgHCUA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Aug 2020 16:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UJzRmylWfjrnipPQYAhPIalbv2nKs4dkhNDQ4EPqfk8=; b=VIt3eudOyQGyXMxI2srAD0acVT
        nmex0VeQiBTzTbF/yLrQcFPWxmykkhOuoJcpQ8vsEvzWr6D86/s8QxweKjWzwo6XttlQy4aFn7PR7
        nEb5y0Si9iv8CNWwFw0NHARLykuAVnROy2oWHTByLnig6NFmPzNAORY8oWLKCuxALo4A6vzfp86r3
        qR/phht0nbWw4PqkcdEh6g6q7WQETNjhzTr3eSMfaw39FSuFlMRODZHCiw90Iu4jEbL8apMWCxTGm
        b0BqzwrHlkGJPFntwZdLTF5bDx7gWKVvwF3rWKe321EnWTGLheru0TTMcwlHz94MBOHxEME+GU4Eo
        tWSsQNPQ==;
Received: from [2600:1700:4830:165f::19e] (port=34650)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k2gde-00018T-Nf; Mon, 03 Aug 2020 16:00:50 -0400
Subject: Re: [PATCH v4 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        David.Laight@ACULAB.COM
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <e13d43849f68af8227c6aaa0ef672b459d47e9ab.1595358237.git.vilhelm.gray@gmail.com>
 <7209ac3d-d1ca-1b4c-b22c-8d98b13742e2@lechnology.com>
 <20200802210415.GA606173@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <4061c9e4-775e-b7a6-14fa-446de4fae537@lechnology.com>
Date:   Mon, 3 Aug 2020 15:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802210415.GA606173@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/2/20 4:04 PM, William Breathitt Gray wrote:
> On Tue, Jul 28, 2020 at 05:45:53PM -0500, David Lechner wrote:
>> On 7/21/20 2:35 PM, William Breathitt Gray wrote:
>>> This is a reimplementation of the Generic Counter driver interface.

...

>>> -F:	include/linux/counter_enum.h
>>> +F:	include/uapi/linux/counter.h
>>
>> Seems odd to be introducing a uapi header here since this patch doesn't
>> make any changes to userspace.
> 
> These defines are needed by userspace for the character device
> interface, but I see your point that at this point in the patchset they
> don't need to be exposed yet.
> 
> I could create temporary include/linux/counter_types.h to house these
> defines, and then later move them to include/uapi/linux/counter.h in the
> character device interface introduction patch. Do you think I should do
> so?

Since this patch is independent of the chardev changes and probably ready
to merge after one more round of review, I would say it probably makes
sense to just leave them in counter.h for now and move them to uapi when
the chardev interface is finalized. This way, we can just merge this patch
as soon as it is ready.

> 
>>>    
>>>    CPMAC ETHERNET DRIVER
>>>    M:	Florian Fainelli <f.fainelli@gmail.com>
>>> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
>>> index 78766b6ec271..0f20920073d6 100644
>>> --- a/drivers/counter/104-quad-8.c
>>> +++ b/drivers/counter/104-quad-8.c
>>> @@ -621,7 +621,7 @@ static const struct iio_chan_spec quad8_channels[] = {
>>>    };
>>>    
>>>    static int quad8_signal_read(struct counter_device *counter,
>>> -	struct counter_signal *signal, enum counter_signal_value *val)
>>> +			     struct counter_signal *signal, u8 *val)
>>
>> I'm not a fan of replacing enum types with u8 everywhere in this patch.
>> But if we have to for technical reasons (e.g. causes compiler error if
>> we don't) then it would be helpful to add comments giving the enum type
>> everywhere like this instance where u8 is actually an enum value.
>>
>> If we use u32 as the generic type for enums instead of u8, I think the
>> compiler will happlily let us use enum type and u32 interchangeably and
>> not complain.
> 
> I switched to fixed-width types after the suggestion by David Laight:
> https://lkml.org/lkml/2020/5/3/159. I'll CC David Laight just in case he
> wants to chime in again.
> 
> Enum types would be nice for making the valid values explicit, but there
> is one benefit I have appreciated from the move to fixed-width types:
> there has been a significant reduction of duplicate code; before, we had
> a different read function for each different enum type, but now we use a
> single function to handle them all.

Yes, what I was trying to explain is that by using u32 instead of u8, I
think we can actually do both.

The function pointers in struct counter_device *counter would use u32 as a
generic enum value in the declaration, but then the actual implementations
could still use the proper enum type.

> 
>>> +		device_del(&counter->dev);
>>> +		counter_sysfs_free(counter);
>>
>> Should sysfs be freed before deleting device? I think sysfs might be
>> using dev still.
> 
> I think it's the other way around isn't it? The Counter sysfs memory
> should stay alive for the lifetime of the device. Once the device is
> deleted, there's nothing left to access those struct attributes, so that
> memory can now be freed. Correct me if my reasoning is wrong here.

I think you are right. I was thinking that device_del() would free
memory, but it doesn't. It also looks like other drivers call
device_put() after this, so maybe needed here too?

>>> +static ssize_t counter_data_u8_show(struct device *dev,
>>> +				    struct device_attribute *attr, char *buf)
>>> +{
>>> +	const struct counter_attribute *const a = to_counter_attribute(attr);
>>> +	struct counter_device *const counter = dev_get_drvdata(dev);
>>> +	const struct counter_available *const avail = a->data.priv;
>>> +	int err;
>>> +	u8 data;
>>> +
>>> +	switch (a->type) {
>>
>> I don't understand the use of the word "owner" here. What is being "owned"?
>>
>> Perhaps "component" would be a better choice?
> 
> I wasn't too set on calling this "owner" either, but I'm not sure if
> "component" would make sense either because I wouldn't label a device
> attribute as belonging to any particular component (in fact it's quite
> the opposite).
> 
> Perhaps the word "scope" would be better. What do you think? Or would
> that be too vague as well.

"scope" makes sense to me.

>>> -/**
>>> - * struct counter_signal_ext - Counter Signal extensions
>>> - * @name:	attribute name
>>> - * @read:	read callback for this attribute; may be NULL
>>> - * @write:	write callback for this attribute; may be NULL
>>> - * @priv:	data private to the driver
>>> - */
>>> -struct counter_signal_ext {
>>> +enum counter_data_type {
>>> +	COUNTER_DATA_TYPE_U8,
>>> +	COUNTER_DATA_TYPE_U64,
>>> +	COUNTER_DATA_TYPE_BOOL,
>>> +	COUNTER_DATA_TYPE_SIGNAL,
>>
>> Does this mean signal name?
> 
> This represents the signal values "high" or "low". With the introduction
> of this patchset, these values are no longer strings internally so I
> gave them their own data type here.

Ah, OK. So maybe COUNTER_DATA_TYPE_SIGNAL_LEVEL would be a better name.

> 
>>> +	COUNTER_DATA_TYPE_COUNT_FUNCTION,
>>> +	COUNTER_DATA_TYPE_SYNAPSE_ACTION,
>>> +	COUNTER_DATA_TYPE_ENUM,
>>
>> Why do some enums get their own type while others use a common
>> generic ENUM type?
> 
> COUNTER_DATA_TYPE_ENUM is intended for driver-specific Counter enums.
> This allows driver authors to define their own Counter enums so that we
> don't pollute the Generic Counter interface with enums that are unique
> to individual drivers.
> 
>>> +	COUNTER_DATA_TYPE_COUNT_DIRECTION,
>>> +	COUNTER_DATA_TYPE_COUNT_MODE,
>>
>> Would be nice to group all COUNTER_DATA_TYPE_COUNT_* together
> 
> I assume you're referring to COUNTER_DATA_TYPE_COUNT_FUNCTION being
> separate from these two. That's because a "count function" is actually
> part of the Generic Counter paradigm: it's the trigger operation for the
> Synapse.
> 
> In retrospect, I should have named it "trigger operation" or something
> similar when I developed the paradigm originally, but hindsight is
> 20/20 (I'd probably rename "Synapse" to something else too if I could).
> It's unfortunately too late to rename this because we've exposed it to
> userspace already as a named sysfs attribute.
> 
> Perhaps I can rename this enum constant however to
> COUNTER_DATA_TYPE_FUNCTION, or similar, to differentiate it from the
> Count extensions.
> 

Yes, I think COUNTER_DATA_TYPE_FUNCTION would be sufficient and avoid
confusion.

>>>    /**
>>>     * struct counter_device - Counter data structure
>>> - * @name:		name of the device as it appears in the datasheet
>>> + * @name:		name of the device
>>>     * @parent:		optional parent device providing the counters
>>> - * @device_state:	internal device state container
>>> - * @ops:		callbacks from driver
>>> + * @signal_read:	optional read callback for Signals. The read value of
>>> + *			the respective Signal should be passed back via the
>>> + *			value parameter.
>>> + * @count_read:		optional read callback for Counts. The read value of the
>>> + *			respective Count should be passed back via the value
>>> + *			parameter.
>>> + * @count_write:	optional write callback for Counts. The write value for
>>> + *			the respective Count is passed in via the value
>>> + *			parameter.
>>> + * @function_read:	optional read callback the Count function modes. The
>>> + *			read function mode of the respective Count should be
>>> + *			passed back via the function parameter.
>>> + * @function_write:	option write callback for Count function modes. The
>>> + *			function mode to write for the respective Count is
>>> + *			passed in via the function parameter.
>>> + * @action_read:	optional read callback the Synapse action modes. The
>>> + *			read action mode of the respective Synapse should be
>>> + *			passed back via the action parameter.
>>> + * @action_write:	option write callback for Synapse action modes. The
>>> + *			action mode to write for the respective Synapse is
>>> + *			passed in via the action parameter.
>>>     * @signals:		array of Signals
>>
>> Why not keep the ops struct?
> 
> Defining static ops structures in the drivers seemed to have no
> advantage when those callbacks are always used via the counter_device
> structure. I decided it'd be simpler to just set them directly in the
> counter_device structure then.
> 
> I could reorganize them into an ops structure again if there's enough
> interest.

I've been working on really constrained systems lately where every byte
counts, so this stuck out to me since there would be a copy of all
functions for each counter instance. But probably not that big of a deal
in the Linux kernel. :-)


Return-Path: <linux-iio+bounces-55-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232CB7EA1CB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 18:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A648FB208B9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Nov 2023 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22646224CE;
	Mon, 13 Nov 2023 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eNO21JvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6971DA2D
	for <linux-iio@vger.kernel.org>; Mon, 13 Nov 2023 17:20:41 +0000 (UTC)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C501A5
	for <linux-iio@vger.kernel.org>; Mon, 13 Nov 2023 09:20:37 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ADB45JG014890;
	Mon, 13 Nov 2023 18:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=mp8ac9lcai3QxNF4GbTMXANEu9lHbxKJl43Vu1qOjM8=; b=eN
	O21JvUYXo0ImSpoLFHfnTmn41zMRTYI1/ZNhVXLFwRt3HkcbKmiOsZ9kgQh9hgWl
	PFa1COeFwePKLhv79aAHiSrLk9v9zGRN801P6D4eKV7u/vxOzYo0qTZFnmnpOgbI
	+CDiYHZFFHWSpJYMRSoQgroJfEvfDdCWPA7nT1MTN9CCoLhDDM9dKJfOnnBpYzf0
	w6KEMj02wGRaxH+XegLp6tX+fg9ZNKMw2IO2Vd/M5wmHaY7qBrMwO8yQenywluTK
	/m3qVLlkojcYXn8yKVnvJyMyGQ0dYLK3Dpo2yDaAgbj67UkPCBIuZeG8CbAOhoK8
	Iy5z6Do6QVSLvnWc85Yg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1ch07wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:20:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AFC6D10005B;
	Mon, 13 Nov 2023 18:20:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F7B6229A84;
	Mon, 13 Nov 2023 18:20:14 +0100 (CET)
Received: from [10.201.21.64] (10.201.21.64) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 13 Nov
 2023 18:20:14 +0100
Message-ID: <9767cd6e-5201-430a-a9e5-f6c2a4ad3de4@foss.st.com>
Date: Mon, 13 Nov 2023 18:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
	<noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
 <20230804145342.1600136-2-nuno.sa@analog.com>
 <20230830180234.00007437@Huawei.com>
 <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
 <20230903115653.5bb8c0e8@jic23-huawei>
 <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
 <20230904163114.0000681c@Huawei.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20230904163114.0000681c@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.64]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_08,2023-11-09_01,2023-05-22_02

Hi Nuno, Jonathan,

On 9/4/23 17:31, Jonathan Cameron wrote:
> On Mon, 04 Sep 2023 16:14:17 +0200
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Sun, 2023-09-03 at 11:56 +0100, Jonathan Cameron wrote:
>>> On Thu, 31 Aug 2023 11:32:54 +0200
>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>    
>>>> On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
>>>>> On Fri, 4 Aug 2023 16:53:39 +0200
>>>>> Nuno Sa <nuno.sa@analog.com> wrote:
>>>>>      
>>>>>> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>>>>>
>>>>> Hi Nuno,
>>>>>      
>>>>
>>>> Hi Jonathan,
>>>>
>>>> Thanks for the initial review...
>>>>    
>>>>>
>>>>> One general comment is that you could have stripped this back a fair bit
>>>>> for ease of understanding.  At this stage we don't care about things
>>>>> like debug or control of test patterns.  Bring those in as extra patches.
>>>>>      
>>>>
>>>> Agreed... As I mentioned (I think) in the cover, I made the RFC bigger than
>>>> needed to
>>>> kind of showcase how we can properly configure the hdl core to support
>>>> things
>>>> (interface calibration) that were very hard to do with the current
>>>> implementation.
>>>> I'll make sure to add the minimum needed API to accommodate what we have
>>>> right now.
>>>>    
>>>>> I haven't fully gotten my head around the ordering constraints on removal.
>>>>> Are there other users of the component framework that have similar
>>>>> problems?
>>>>>      
>>>>
>>>> My understanding on the component API is that one should do all the tear
>>>> down in the
>>>> .unbind() callback. As usual, I can see some drivers not really doing that.
>>>>    
>>>>> Also, I don't yet understand how a multiple front end, single backend
>>>>> setup
>>>>> would work.  Or indeed single front end, multiple backend...  Maybe we
>>>>> don't
>>>>> need those cases, but if we want this to be useful beyond adi-axi we
>>>>> probably at least want an outline of how they work.
>>>>>      
>>>>
>>>> Indeed we can have multiple (and we have it out of tree) backends on one
>>>> frontend.
>>>> Think on an ADC/DAC with fairly complex data path with more than one
>>>> channel/interface (CMOS, LVDS, etc). Typically, in those case, each of the
>>>> interface
>>>> will be connected to an instance of the hdl core (the backend).
>>>
>>> That might work out for your case, but not the stm32 one where I think we can
>>> end
>>> up with interleaved data from two front ends in the same buffer...
>>>    
>>
>> Not sure I'm following this one. But wouldn't that be something specific for
>> each system (through devicetree)? I haven't tried but I think the same backend
>> could be used in different frontend devices (using the component API). That is
>> not really a usecase for me but definitely something that could be supported (if
>> we need to start doing things like keep enable/disable counters and so on) if it
>> is a usecase for stm32.
> 
> If we are going to support both usecases, we just need to figure out what composite
> devices with N-M backend - frontend look like and make sure that doesn't
> cause problems.  I'd expect the separation between backend instances might
> reflect data storage on capture but then again that might end up like the many
> IIO devices for many buffers mess we had before the multiple buffer support
> was added.
> 

The stm32 dfsdm interleaved use case is not a problem as it is possible 
to associate several backends to a frontend.
I did some experiments based on converter framework, and did not 
identified blocking points regarding dfsdm use cases.

Some limitations where discussed in [1], about generic bindings support.
The preferred solution was to extend converter_frontend_add_matches() to 
parse also child nodes. I have added converters_get_from_fwnode() API 
and adapted converter_frontend_add_matches() to test this approach.
With this changes and an additional api to support channel attributes 
read, the framework fulfills all the needs for dfsdm.

So, I feel comfortable to drop my previous "backend framework" proposal, 
and move to the current proposal.

If we go further in converter framework adaption, I will push these updates.

[1]: 
https://lore.kernel.org/lkml/60e913e81ce67192ed0449fe7b718434fd360d97.camel@gmail.com/

BRs
Olivier

> Might need enable /disable counters as you say - I'm not quite sure without
> trying it!
>>>>>> +        * than having to tear everything down in .frontend_close() and
>>>>>> +        * .backend_close()
>>>>>
>>>>> That last bit is nasty and will be non obvious to driver authors.
>>>>>
>>>>> I wonder if we can come up with some means to make it hard to do.
>>>>>      
>>>>
>>>> Yeah, I agree. The alternative is to always bring everything down in
>>>> .frontend_close() and .backend_close(). But that can also be prone to subtle
>>>> bugs
>>>> because it's easy to mess up the ordering when not using devres.
>>>>
>>>> So, at this point, I cannot really think on a perfect solution rather than
>>>> keeping
>>>> some rules like (assuming we keep the logic we have now):
>>>>
>>>> * Using devres on frontend|backend_init() only when .remove() is provided on
>>>> the
>>>> driver.
>>>> * No mixes of devres and .frontend|backend_close()
>>>>
>>>> But yeah, would be nice if we could come up with something to make it more
>>>> obvious to
>>>> driver authors.
>>>    
>>>>
>>>> We might be able to detect that converter_backend_del() and
>>>> converter_frontend_del()
>>>> are under devres while no .frontend|backend_close() is being given. I guess
>>>> that
>>>> could be a valid indicator of likely misusage.
>>>>
>>>> Or even better (but I'm not sure it's doable with the current devres API),
>>>> detecting
>>>> that converter_backend_del() or converter_frontend_del() are under devres
>>>> while more
>>>> resources are also allocated in our specific opened groups. That would
>>>> always be a
>>>> problem (I think) because the only way for the _del() functions to be under
>>>> devres is
>>>> if someone added them (from .probe) with devm_add_action() which means that
>>>> tearing
>>>> down the aggregate will happen after some resources (which were allocated in
>>>> the
>>>> _init() function) are already freed (as even with new groups, devres will
>>>> remove
>>>> things on the reverse order). And that would defenitely be problematic. And,
>>>> in fact,
>>>> is the whole reason why I have the .del() functions on .remove() (so,
>>>> tearing down
>>>> the aggregate device is the first thing to happen and resources are freed in
>>>> the
>>>> reverse order they were allocated).
>>>>    
>>>    
>>
>> This would actually be very messy and hard to do properly. Concurrency between
>> the aggregate probing (at the component level) and unbinding (at driver core
>> level) would be very tricky if doable at all. On top that, we do have
>> devres_find() but no way to tell if a devres group has resources or not. It
>> would be easy to add one new API but likely not worth it just for this usecase.
>>
>> I also thought about an helper macro to wrap every devm_ call but your below
>> suggestion is way better and transparent to users.
>>
>>> I couldn't work out how to do anything easily and would need some experiments.
>>> Maybe some 'hidden' devres callbacks and a state flag somewhere.  If we
>>> register
>>> that very late we can perhaps detect that we entered devres cleanup before
>>> calling
>>> expected manual cleanup.  I'm thinking have the setup path register a flag
>>> checking
>>> callback and the cleanup path set a flag (devres now safe).  Then we can at
>>> least
>>> make it scream if we end up doing things in wrong way.
>>>    
>>
>> Hmm, that might actually be a good idea and something to try. It likely means
>> having a mutex (I was happy not to have one for now :) but likely inevitable
>> somewhere down the road) for the flag but it might work. At least we'll be able
>> to dump a WARN or something if we suspect something is wrong.
> 
> Careful ordering an atomic might work.
> 
>>
>>>> Other thought would be some generic helper macros to use in these type of
>>>> drivers so
>>>> a .remove() callback is always added to remove the components.
>>> I wondered if that could work but it's an ugly macro because needs to deal
>>> with
>>> different bus types.
>>>
>>>    
>>
>> We could have a macro per bus type. I'm not really seeing anything different
>> than platform, spi and i2c. But even like this, it could easily start to get
>> ugly because of accepted parameters (and any deviation would again mean a
>> different version per bus type). Another thing that crossed my mind was wrappers
>> to module_spi_driver() and friends. Maybe that could work. Anyways, as you said
>> in one of your replies, this is in kernel interface that we can easily
>> add/change. So, I will defer this to a later point in time.
> 
> Makes sense
> 
> J
>>
>> - Nuno Sá
>>
> 


Return-Path: <linux-iio+bounces-122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABC7EE486
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCA6281022
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59430F91;
	Thu, 16 Nov 2023 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wcf5HFrk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EE11D
	for <linux-iio@vger.kernel.org>; Thu, 16 Nov 2023 07:42:39 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AGEbFUn015664;
	Thu, 16 Nov 2023 16:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jFTJykrWtj7jrjiBsW236MkhAvJOdPkAdVS1nZVmQBQ=; b=wc
	f5HFrkC3THhjNEWcTWfPyF/pkD+As7iphJUHddWNtNe8IOMw5n0L+wOCaYulawSK
	iC3uXJexyuWdPKzBoNCdIlT14KiPjZ8umJ8qF2ekmQnPcLLTMXv8Mg4uXZ94KxUv
	QGAWb8cFtFSagMGCwkL133ppKci8GSG5/opWZX89T3TDDfEXqPYOX1bQClG8ARCY
	wz3Pf9WWPFmnWe4iSf5UyEg2ESXB2BwrJCF92TwuYoWymHLpm3oDYX9h6qcDJHze
	cWnHeJK4ffVKq5PtTfPXUmjNKyHa1z/1wpOPUC7RWIBhfD4GS3K1tSY+mzZlYxjJ
	Re0zn6baO2rnkIYv3Xtw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3udn0m098n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 16:42:14 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89090100056;
	Thu, 16 Nov 2023 16:42:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B2D123BE1B;
	Thu, 16 Nov 2023 16:42:11 +0100 (CET)
Received: from [10.201.21.64] (10.201.21.64) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 16 Nov
 2023 16:42:10 +0100
Message-ID: <4f205182-6651-4b09-92ef-786ab62791d1@foss.st.com>
Date: Thu, 16 Nov 2023 16:42:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
Content-Language: en-US
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
 <20230804145342.1600136-2-nuno.sa@analog.com>
 <20230830180234.00007437@Huawei.com>
 <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
 <20230903115653.5bb8c0e8@jic23-huawei>
 <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
 <20230904163114.0000681c@Huawei.com>
 <9767cd6e-5201-430a-a9e5-f6c2a4ad3de4@foss.st.com>
 <93e0af8032422491a150153285f5edb58f071d0d.camel@gmail.com>
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <93e0af8032422491a150153285f5edb58f071d0d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.64]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_16,2023-11-16_01,2023-05-22_02

Hi Nuno,

On 11/14/23 10:03, Nuno Sá wrote:
> On Mon, 2023-11-13 at 18:20 +0100, Olivier MOYSAN wrote:
> 
> Ho Olivier,
> 
>> Hi Nuno, Jonathan,
>>
>> On 9/4/23 17:31, Jonathan Cameron wrote:
>>> On Mon, 04 Sep 2023 16:14:17 +0200
>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>
>>>> On Sun, 2023-09-03 at 11:56 +0100, Jonathan Cameron wrote:
>>>>> On Thu, 31 Aug 2023 11:32:54 +0200
>>>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>>>     
>>>>>> On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
>>>>>>> On Fri, 4 Aug 2023 16:53:39 +0200
>>>>>>> Nuno Sa <nuno.sa@analog.com> wrote:
>>>>>>>       
>>>>>>>> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>>>>>>>
>>>>>>> Hi Nuno,
>>>>>>>       
>>>>>>
>>>>>> Hi Jonathan,
>>>>>>
>>>>>> Thanks for the initial review...
>>>>>>     
>>>>>>>
>>>>>>> One general comment is that you could have stripped this back a fair
>>>>>>> bit
>>>>>>> for ease of understanding.  At this stage we don't care about things
>>>>>>> like debug or control of test patterns.  Bring those in as extra
>>>>>>> patches.
>>>>>>>       
>>>>>>
>>>>>> Agreed... As I mentioned (I think) in the cover, I made the RFC bigger
>>>>>> than
>>>>>> needed to
>>>>>> kind of showcase how we can properly configure the hdl core to support
>>>>>> things
>>>>>> (interface calibration) that were very hard to do with the current
>>>>>> implementation.
>>>>>> I'll make sure to add the minimum needed API to accommodate what we
>>>>>> have
>>>>>> right now.
>>>>>>     
>>>>>>> I haven't fully gotten my head around the ordering constraints on
>>>>>>> removal.
>>>>>>> Are there other users of the component framework that have similar
>>>>>>> problems?
>>>>>>>       
>>>>>>
>>>>>> My understanding on the component API is that one should do all the
>>>>>> tear
>>>>>> down in the
>>>>>> .unbind() callback. As usual, I can see some drivers not really doing
>>>>>> that.
>>>>>>     
>>>>>>> Also, I don't yet understand how a multiple front end, single
>>>>>>> backend
>>>>>>> setup
>>>>>>> would work.  Or indeed single front end, multiple backend...  Maybe
>>>>>>> we
>>>>>>> don't
>>>>>>> need those cases, but if we want this to be useful beyond adi-axi we
>>>>>>> probably at least want an outline of how they work.
>>>>>>>       
>>>>>>
>>>>>> Indeed we can have multiple (and we have it out of tree) backends on
>>>>>> one
>>>>>> frontend.
>>>>>> Think on an ADC/DAC with fairly complex data path with more than one
>>>>>> channel/interface (CMOS, LVDS, etc). Typically, in those case, each of
>>>>>> the
>>>>>> interface
>>>>>> will be connected to an instance of the hdl core (the backend).
>>>>>
>>>>> That might work out for your case, but not the stm32 one where I think
>>>>> we can
>>>>> end
>>>>> up with interleaved data from two front ends in the same buffer...
>>>>>     
>>>>
>>>> Not sure I'm following this one. But wouldn't that be something specific
>>>> for
>>>> each system (through devicetree)? I haven't tried but I think the same
>>>> backend
>>>> could be used in different frontend devices (using the component API).
>>>> That is
>>>> not really a usecase for me but definitely something that could be
>>>> supported (if
>>>> we need to start doing things like keep enable/disable counters and so on)
>>>> if it
>>>> is a usecase for stm32.
>>>
>>> If we are going to support both usecases, we just need to figure out what
>>> composite
>>> devices with N-M backend - frontend look like and make sure that doesn't
>>> cause problems.  I'd expect the separation between backend instances might
>>> reflect data storage on capture but then again that might end up like the
>>> many
>>> IIO devices for many buffers mess we had before the multiple buffer support
>>> was added.
>>>
>>
>> The stm32 dfsdm interleaved use case is not a problem as it is possible
>> to associate several backends to a frontend.
>> I did some experiments based on converter framework, and did not
>> identified blocking points regarding dfsdm use cases.
>>
>> Some limitations where discussed in [1], about generic bindings support.
>> The preferred solution was to extend converter_frontend_add_matches() to
>> parse also child nodes. I have added converters_get_from_fwnode() API
>> and adapted converter_frontend_add_matches() to test this approach.
>> With this changes and an additional api to support channel attributes
>> read, the framework fulfills all the needs for dfsdm.
>>
>> So, I feel comfortable to drop my previous "backend framework" proposal,
>> and move to the current proposal.
>>
>> If we go further in converter framework adaption, I will push these updates.
>>
> 
> I hope you didn't had too much trouble with those patches. The reason I'm saying
> this is because, after some thought, I'm strongly considering in moving to
> normal OF/ACPI lookup. 3 mains reasons for it:
> 

No problem, this was an opportunity to discover the component framework. 
The converter API is quite simple to use once you understand the basics 
of component concepts. It does the job for stm dfsdm, but I agree that 
for the long-term, a component-based solution is probably less scalable.

> 1) That "hack/rule" for a driver to provide a .remove() callback (in order to
> devm_*) is really non obvious and might even be prune to subtle bugs (that I'm
> not seeing now :)). But my main argument is that it can become hard to maintain
> it (depending on how much people starts to use the framework).
> 
> 2) From the discussion we had about the limitations you pointed in your link, I
> started to realize that it might get harder to scale the framework. Yes, we
> found a fairly easy way of doing it but still took more code to do it when
> compared to a typical lookup.
> 
> 3) This is the most important together with 1). You mentioned something like
> cascaded designs and I just found an usercase in ADI out of tree drivers. We
> have a design where we have something like:
> 
>                     ------------------------------------------
>                     |		FPGA			    |
> --------------     |  -------------    -------------------  |
> |DAC Frontend| ->  |  |DAC Backend| -> |DAC Interpolation|  |
> --------------     |  -------------    -------------------  |
>                     |					    |
>                     ------------------------------------------
> 
> In the above design we kind of have a cascaded thing where the DAC backend is
> both a frontend and a backend and the Intrerpolation stuff just serves as
> backend to the DAC core. So, ideally the DAC frontend should not have to know a
> thing about the interpolation... I realized that having this with the component
> framework is far from straight because we would need two components/aggregate
> devices to accomplish this (DAC Front + DAC Back) and (DAC Back + DAC Interp)
> and I think we would need some extra care regarding one of the components going
> away (not sure though). One way to make it simple would be to not "respect" the
> HW configuration and just have one aggregate device with 1 Frontend + 2 Backends
> and so the frontend would need to "know" about the interpolation core. Again, I
> think that with OF/ACPI this setup with be fairly straight to get and "respect".
> 
> Anyways, all the above makes me feel that component might not be the best choice
> (even though I was eager to use it :))
> 
> I'll also get to work on this again and I might just use an industrialio-
> backend.c file in the base dir as you had in your RFC. From a quick look on your
> series, I'm no sure how much code I will reuse but we can see later if a Co-
> authored-by tag makes sense or not.
> 

The APIs in my RFC were kept minimalistic to assess the proposal's 
relevance. As you pointed out, there is room for improvement, 
particularly with regards to object releasing. If you are on the way to 
rework your framework, feel free to re-use some parts of this RFC.
At the end, what really matters is to converge towards a solution :)

Regards
Olivier

> Let me know if there's something you don't agree or if there's any concern on
> your side.
> 
> - Nuno Sá
>>>>


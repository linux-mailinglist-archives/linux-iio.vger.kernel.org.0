Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F69459122
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhKVPT2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 22 Nov 2021 10:19:28 -0500
Received: from aposti.net ([89.234.176.197]:41354 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239771AbhKVPTY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Nov 2021 10:19:24 -0500
Date:   Mon, 22 Nov 2021 15:16:06 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/15] iio: buffer-dma: Get rid of incoming/outgoing
 queues
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Message-Id: <UQBZ2R.HLXHH4QWJ0JS1@crapouillou.net>
In-Reply-To: <d542865e-2a0b-089f-e63c-b24d16c58ec6@metafoo.de>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-2-paul@crapouillou.net>
        <e2689f0d-dc16-2519-57df-d98caadb07b0@metafoo.de>
        <0COX2R.BSNX3NW8N48T@crapouillou.net>
        <332d001d-8b5a-bba2-c490-ed2e5efd0b1d@metafoo.de>
        <AMUX2R.XLGW1EZOMU9B2@crapouillou.net>
        <d542865e-2a0b-089f-e63c-b24d16c58ec6@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars,

Le lun., nov. 22 2021 at 16:08:51 +0100, Lars-Peter Clausen 
<lars@metafoo.de> a écrit :
> On 11/21/21 9:08 PM, Paul Cercueil wrote:
>> 
>> 
>> Le dim., nov. 21 2021 at 19:49:03 +0100, Lars-Peter Clausen 
>> <lars@metafoo.de> a écrit :
>>> On 11/21/21 6:52 PM, Paul Cercueil wrote:
>>>> Hi Lars,
>>>> 
>>>> Le dim., nov. 21 2021 at 17:23:35 +0100, Lars-Peter Clausen 
>>>> <lars@metafoo.de> a écrit :
>>>>> On 11/15/21 3:19 PM, Paul Cercueil wrote:
>>>>>> The buffer-dma code was using two queues, incoming and outgoing, 
>>>>>> to
>>>>>> manage the state of the blocks in use.
>>>>>> 
>>>>>> While this totally works, it adds some complexity to the code,
>>>>>> especially since the code only manages 2 blocks. It is much 
>>>>>> easier to
>>>>>> just check each block's state manually, and keep a counter for 
>>>>>> the next
>>>>>> block to dequeue.
>>>>>> 
>>>>>> Since the new DMABUF based API wouldn't use these incoming and 
>>>>>> outgoing
>>>>>> queues anyway, getting rid of them now makes the upcoming changes
>>>>>> simpler.
>>>>>> 
>>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> The outgoing queue is going to be replaced by fences, but I think 
>>>>> we need to keep the incoming queue.
>>>> 
>>>> Blocks are always accessed in sequential order, so we now have a 
>>>> "queue->next_dequeue" that cycles between the buffers 
>>>> allocated for fileio.
>>>> 
>>>>>> [...]
>>>>>> @@ -442,28 +435,33 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_disable);
>>>>>>   static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue 
>>>>>> *queue,
>>>>>>       struct iio_dma_buffer_block *block)
>>>>>>   {
>>>>>> -    if (block->state == IIO_BLOCK_STATE_DEAD) {
>>>>>> +    if (block->state == IIO_BLOCK_STATE_DEAD)
>>>>>>           iio_buffer_block_put(block);
>>>>>> -    } else if (queue->active) {
>>>>>> +    else if (queue->active)
>>>>>>           iio_dma_buffer_submit_block(queue, block);
>>>>>> -    } else {
>>>>>> +    else
>>>>>>           block->state = IIO_BLOCK_STATE_QUEUED;
>>>>>> -        list_add_tail(&block->head, &queue->incoming);
>>>>> If iio_dma_buffer_enqueue() is called with a dmabuf and the 
>>>>> buffer is not active, it will be marked as queued, but we 
>>>>> don't actually keep a reference to it anywhere. It will 
>>>>> never be submitted to the DMA, and it will never be 
>>>>> signaled as completed.
>>>> 
>>>> We do keep a reference to the buffers, in the queue->fileio.blocks 
>>>> array. When the buffer is enabled, all the blocks in that 
>>>> array that are in the "queued" state will be submitted to the 
>>>> DMA.
>>>> 
>>> But not when used in combination with the DMA buf changes later in 
>>> this series.
>>> 
>> 
>> That's still the case after the DMABUF changes of the series. Or can 
>> you point me exactly what you think is broken?
>> 
> When you allocate a DMABUF with the allocate IOCTL and then submit it 
> with the enqueue IOCTL before the buffer is enabled it will end up 
> marked as queued, but not actually be queued anywhere.
> 

Ok, it works for me because I never enqueue blocks before enabling the 
buffer. I can add a requirement that blocks must be enqueued only after 
the buffer is enabled.

Cheers,
-Paul



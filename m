Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4448F876
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 18:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiAORYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 12:24:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34118 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiAORYt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 12:24:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5273360EDC
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 17:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF91C36AE3;
        Sat, 15 Jan 2022 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642267488;
        bh=KvSjdtVUyAOBHK6y8rj5xZbgt/pVqlJ0h26SvC5poEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZZgmvT4XTPVIQ8jSCgRYeNSCjOfKk/PBDNGhQNMFVDmU1kH9rUGg3oFTQtCCN+jcS
         AG2yrsHdS1mA36ZSEjkDjmaV9xEx3CfE9R3xbkiN17y/sbpFbeQiOW+O9zvOgwzkUK
         DvyodaYfzcfRozzZdRppKm4VwngwQxo7STruLY2zkGVWI0ml7F4nizXmcK6W2DMdjy
         yZNrKjuC5P/IAYO/BheugudZ9TbbUlFmSySSnCgs1NSdCftPCkOe5KfCfU/RRXizAW
         9GzezFNKzpdvZUTgzuTzrDZL57a7G8R+mcEqF1M2elOLF+6cSZNfufqBTFr7Mb8Ggo
         BrmTiRwhFsv+A==
Date:   Sat, 15 Jan 2022 17:30:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] iio: core: Clarify the modes
Message-ID: <20220115173050.3501e20c@jic23-huawei>
In-Reply-To: <20211215151344.163036-11-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-11-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Dec 2021 16:13:44 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> As part of a previous discussion with Jonathan Cameron [1], it appeared
> necessary to clarify the meaning of each mode so that new developers
> could understand better what they should use or not use and when.
> 
> The idea of renaming these modes as been let aside because naming is a
> big deal and requires a lot of thinking. So for now let's focus on
> correctly explaining what each mode implies.
> 
> [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-huawei/
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/iio/iio.h | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d04ab89fa0c2..75b561fd63d0 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -314,7 +314,45 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
>  
> -/* Device operating modes */
> +/**
> + * Device operating modes
> + * @INDIO_DIRECT_MODE: There is an access to the last single value available.

I'd avoid 'last' as not obvious wrt to what time point.  Perhaps use something
horrible like "timely"?

> + * On most devices, this is a single-shot read. On some devices with data
> + * streams without an 'on-demand' function, this might also be the 'last value'
> + * feature. Above all, this mode internally means that we are not in any of the
> + * other modes, and sysfs reads will definitely work.

Should work ;)  They might fail for a wide variety of other reasons.

> + * Device drivers are pleased to inquire the core about this mode.
Not totally sure what you mean here.  Perhaps
Device drivers should inform the core if they support this mode.

> + * @INDIO_BUFFER_TRIGGERED: Most common mode when dealing with kfifo buffers.

Avoid "common". That may well change in future as fifos are become increasingly
common on devices over time.  Perhaps just drop this first sentence.

> + * It indicates that there is an explicit trigger that must be used. This

Indicates that an explicit trigger is required. (subtle difference from what you
wrote in that you kind of imply there is only one possible choice)

> + * requests the core to attach a poll function when enabling the buffer, which
> + * is indicated by the _TRIGGERED suffix.
> + * The core will ensure this mode is set when registering a triggered buffer.

I'd call out the function name (mostly to be inline with below where you need
to because there isn't a particularly good way to describe what it is doing).

> + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
> + * No poll function can be attached because there is no triggered infrastructure
> + * we can use to cause capture. There is a kfifo that the hardware will fill,
> + * but not "one scan at a time", just like in a continuous stream.

No real relationship to a continuous stream that I can see.  Perhaps something like
"Typically hardware will have a buffer that can hold multiple scans. Software may
 read one or more scans at a single time and push the available data to a Kfifo."

> This means
> + * the core will not attach any poll function when enabling the buffer.
> + * The core will ensure this mode is set when registering a simple kfifo buffer.

I'd call out the function name here.  The above registers a kfifo as well which is
pretty simple...

> + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use this mode.
> + * Same as above but this time the buffer is not a kfifo where we have direct
> + * access to the data. Instead, the consumer driver must access the data through
> + * side-channels 
What do you mean by side-channels here?  That term gets over used - perhaps
"non software visible channels"

 + (or DMA when there is no demux possible in software).
> + * The core will ensure this mode is set when registering a dmaengine buffer.

> + * @INDIO_EVENT_TRIGGERED: Very specific, do not use this mode.

:) That's harsh.. If you happen to be supporting hardware that works this way
it's a valid setting.  Perhaps we'd be safe to say:
"Very unusual."

> + * Triggers usually refer to an external event which will start data capture.
> + * Here it is kind of the opposite as, a particular state of the data might
> + * produce an event which can be considered as an event. We don't necessarily
> + * have access to the data itself, but to the event produced. For example, this
> + * can be a threshold detector. The internal path of this mode is very close to
> + * the INDIO_BUFFER_TRIGGERED mode.
> + * The core will ensure this mode is set when registering a triggered event.
> + * @INDIO_HARDWARE_TRIGGERED: STM32 specific mode, do not use it.

I'd avoid that comment because it'll rot when some other hardware needs something
like this.  Again, perhaps "Very rare / unusual." will be enough to put people
off using it.

> + * Here, triggers can result in data capture and can be routed to multiple
> + * hardware components, which make them close to regular triggers in the way
> + * they must be managed by the core, but without the entire interrupts/poll
> + * functions burden. All of this is irrelevant as it is all hardware mediated
> + * and distributed.

"All this" is not totally clear.  Interrupts are irrelevant as the data flow
is hardware mediated and distributed.

Nice descriptions in general.  Nature of these things is without a straw man
to poke holes in I'd never get around to documenting this very much
appreciated that you took the time to figure all the weird corners out and
write this up.

Jonathan


> + */
>  #define INDIO_DIRECT_MODE		0x01
>  #define INDIO_BUFFER_TRIGGERED		0x02
>  #define INDIO_BUFFER_SOFTWARE		0x04


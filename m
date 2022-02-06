Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407A4AB090
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiBFQDI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 11:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiBFQDH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 11:03:07 -0500
X-Greylist: delayed 2820 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 08:03:06 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0070C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 08:03:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230BF61172
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 16:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED65CC340E9;
        Sun,  6 Feb 2022 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644163385;
        bh=W2o3QnxH3xDlV2nTbecpP5KXvZ4cM/6OIt2NIIYpFhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e9HDBBEriwZCcceDci0Th2QYzlQ7ymVmcAwLi0T/vp6FNLHnLCD56YugeaW2dE5Zh
         z1r5tNqQimnm7e4pA/QrXonKNzQtjd/bJd8TdDx5kGSav1tJdx5Ok7nEXNAZ23fuga
         A2bi0aprSuB+UuSZHzaDnNEt5hACA1JR+U6P4FrKAgYH/odXpGJQNzNyyf+09VKiFl
         V3I5PNf1fQDIlmtX21wzeNBxTmg7+Susl8FAjOF8tN6JPegU0mOLAZAXcVqVHEqjHP
         KNnnHuv4WtziYcdI7A+h7GWmbFo4WJJfZoNrzEIN3a7yHaHW4CmhvDGRmalzu6xNve
         KIBy9LHdg3SOg==
Date:   Sun, 6 Feb 2022 16:09:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 12/12] iio: core: Clarify the modes
Message-ID: <20220206160937.7d77b94a@jic23-huawei>
In-Reply-To: <20220202140208.391394-13-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-13-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Feb 2022 15:02:08 +0100
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
Very nice.  One random comment on another area where our docs could do with
improvements and one trivial suggested clarification for this patch.

Thanks for your hard work tidying this up!

I've looked over all the other patches in the series and where I haven't
commented they look good to me.

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 46 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 85cb924debd9..66eccae2b9d1 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -315,7 +315,51 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
>  
> -/* Device operating modes */
> +/**
> + * Device operating modes
> + * @INDIO_DIRECT_MODE: There is an access to the timely single value available.
> + * On most devices, this is a single-shot read. On some devices with data
> + * streams without an 'on-demand' function, this might also be the 'last value'
> + * feature. Above all, this mode internally means that we are not in any of the
> + * other modes, and sysfs reads should work.
> + * Device drivers should inform the core if they support this mode.
> + * @INDIO_BUFFER_TRIGGERED: Common mode when dealing with kfifo buffers.
> + * It indicates that an explicit trigger is required. This requests the core to
> + * attach a poll function when enabling the buffer, which is indicated by the
> + * _TRIGGERED suffix.
> + * The core will ensure this mode is set when registering a triggered buffer
> + * with iio_triggered_buffer_setup().

This isn't the best place for it, but we could probably do with clear
documentation somewhere of how to set default triggers for a device and
how to restrict which device / trigger combinations are possible.
Maybe we should build on your good work here with some extra detail in the
main Documentation.  The validate case is touched on there, but I don't
see anything about defaults
indio_dev->trig = iio_trigger_get(trig); 
that's needed to ensure correct reference counting.



> + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
> + * No poll function can be attached because there is no triggered infrastructure
> + * we can use to cause capture. There is a kfifo that the hardware will fill,
Slight misleading. Perhaps better as:
There is a kfifo that the driver will fill, but not "only one scan at a time".

> + * but not "only one scan at a time". Typically, hardware will have a buffer
> + * that can hold multiple scans. Software may read one or more scans at a single
> + * time and push the available data to a Kfifo. This means the core will not
> + * attach any poll function when enabling the buffer.
> + * The core will ensure this mode is set when registering a simple kfifo buffer
> + * with devm_iio_kfifo_buffer_setup().
> + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use this mode.
> + * Same as above but this time the buffer is not a kfifo where we have direct
> + * access to the data. Instead, the consumer driver must access the data through
> + * non software visible channels (or DMA when there is no demux possible in
> + * software)
> + * The core will ensure this mode is set when registering a dmaengine buffer
> + * with devm_iio_dmaengine_buffer_setup().
> + * @INDIO_EVENT_TRIGGERED: Very unusual mode.
> + * Triggers usually refer to an external event which will start data capture.
> + * Here it is kind of the opposite as, a particular state of the data might
> + * produce an event which can be considered as an event. We don't necessarily
> + * have access to the data itself, but to the event produced. For example, this
> + * can be a threshold detector. The internal path of this mode is very close to
> + * the INDIO_BUFFER_TRIGGERED mode.
> + * The core will ensure this mode is set when registering a triggered event.
> + * @INDIO_HARDWARE_TRIGGERED: Very unusual mode.
> + * Here, triggers can result in data capture and can be routed to multiple
> + * hardware components, which make them close to regular triggers in the way
> + * they must be managed by the core, but without the entire interrupts/poll
> + * functions burden. Interrupts are irrelevant as the data flow is hardware
> + * mediated and distributed.
> + */
>  #define INDIO_DIRECT_MODE		0x01
>  #define INDIO_BUFFER_TRIGGERED		0x02
>  #define INDIO_BUFFER_SOFTWARE		0x04


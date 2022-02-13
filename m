Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3744B3CE0
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 19:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiBMSfx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 13:35:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiBMSfx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 13:35:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF157B01
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 10:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43333B80B07
        for <linux-iio@vger.kernel.org>; Sun, 13 Feb 2022 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922D0C004E1;
        Sun, 13 Feb 2022 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644777343;
        bh=3eXk3miZyecrfFgE0W8BL7rR57bmWV/X+1U9x5bzDE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PRn9xF80WLdL5mqXtNCIlnxour4PjDVECZ1Azqv+YDgdiMqsIu6qtTK1paRs+A+s4
         YLu3izJqzJvSPVbLOzwoQaA4v8DQCjdn4UtHixojQVdqOOQOc8EYsRcEtngXJXYmva
         2Dg/n42+OCrhKsibIEpPkF4RV1wsPYs6qn1glgPP53FNgtP3lEUlnugHpzXZoQeNyv
         0VhGd5P9tvqovBUAbhAPxDcQR1ak7O9o7Q/YM8E+vrDN5RUqyaR/u6/qmjMqO4DSuC
         1IScS3jGOTcXus/fF7A5t6Gnd2whZN6rEQ+hd+kRL4j0dc+Ks/asUOWOb2hMIKSFyK
         Cd6cRd34hxZrw==
Date:   Sun, 13 Feb 2022 18:42:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v3 13/13] iio: core: Clarify the modes
Message-ID: <20220213184224.1644ddbc@jic23-huawei>
In-Reply-To: <20220207143840.707510-14-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Feb 2022 15:38:40 +0100
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
One trivial thing inline as a result of edits in v3.

Otherwise, I want to let this series sit a little longer and ideally get
some eyes on the st_sensors patches.

Jonathan

> ---
>  include/linux/iio/iio.h | 49 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 85cb924debd9..e383b0d96035 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -315,7 +315,54 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
>  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
>  
> -/* Device operating modes */
> +/**
> + * Device operating modes
> + * @INDIO_DIRECT_MODE: There is an access to either:
> + * a) The last single value available for devices that do not provide
> + *    on-demand reads.
> + * b) A new value after performing an on-demand read otherwise.


> + * On most devices, this is a single-shot read. On some devices with data
> + * streams without an 'on-demand' function, this might also be the 'last value'
> + * feature.

This block duplicates what you now have as a/b above. I can drop it whilst
applying if nothing else comes up.

>  Above all, this mode internally means that we are not in any of the
> + * other modes, and sysfs reads should work.
> + * Device drivers should inform the core if they support this mode.
> + * @INDIO_BUFFER_TRIGGERED: Common mode when dealing with kfifo buffers.
> + * It indicates that an explicit trigger is required. This requests the core to
> + * attach a poll function when enabling the buffer, which is indicated by the
> + * _TRIGGERED suffix.
> + * The core will ensure this mode is set when registering a triggered buffer
> + * with iio_triggered_buffer_setup().
> + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
> + * No poll function can be attached because there is no triggered infrastructure
> + * we can use to cause capture. There is a kfifo that the driver will fill, but
> + * not "only one scan at a time". Typically, hardware will have a buffer that
> + * can hold multiple scans. Software may read one or more scans at a single time
> + * and push the available data to a Kfifo. This means the core will not attach
> + * any poll function when enabling the buffer.
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


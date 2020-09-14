Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12A268B34
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgINMkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgINMjb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 08:39:31 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9610C061354
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 05:38:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so14649449ota.10
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joOK07zUoq5UHJouopq09kOumHeQseKfettHHjU0Cb4=;
        b=ee9CzIogYlGT55OqrffP6njQ0EUdGxrPekMnlHTJQwUujji1PTRbK/wftfIU48osUv
         nXWCLQABde99BiFlnLffp60PHFvCs6qkhSA+WhyiK8dQWLfxF5meRBaY5KMMi9MA6p7/
         f4K+UW4z6J82QnGo8SSaPWRLWL2cpimu8lhyMVqSuf0Kcw5dY9mHhYSMSqG2EuN3eBPX
         seT7OBJltECQbhByx3jXDkqYRCBBsthGjApGWZjOcBTCMs2Ua5uGY/L4ej5DrErY7/uW
         vkEQtz0DDsfhn1p+70jw8psZO+L86FzFtHuc6GE4Pex5gzJOXEs/r+KFa9+TTNtGThRj
         byeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joOK07zUoq5UHJouopq09kOumHeQseKfettHHjU0Cb4=;
        b=Xn1rpjYj+nwWi4vRG470yuPydckhQ/0NLfHhTH6TZPBDSCZsyLxylltSaGfEZVXnnT
         8QsFHeuMkMf5p619hRM/BgDCNfd+t9PoHchio1qAIw1lTb+sGBS2hBMrB8Kt7u3Qa1tA
         ClHaUOrSWE5enTTfJysRRxjMrS1bLjdifCVJA2blqQUaRmEbBremPzXuPLs42lT9bYH2
         GI49aJdJYKDaB/SdgpcMi05XvczOFcesqzf+TdYCruRgIbRQz4b4YxnA0C+yCG4Tszuk
         kzfK7GvWYyDYTUS3V2aYudMgk4jvxF//0PFauCeFM91he1npJtyabmwVN9EG46BVHlU/
         ukmA==
X-Gm-Message-State: AOAM533RgVnNYZ6qenMxky/Lg+emKyudAKQL7gqmdl0+M5De/dLXGI6D
        aJu8z89ZmdDlQ9iBJo0LSZLQ9BxvpJGGT0sHhAc=
X-Google-Smtp-Source: ABdhPJyIPl3U48amSrYvmJpJCjOIOTWI8ZPioj75lLQm1DCHFkJQ+NLy9LdlGQBl7HHWSfsJU8AbiBHqJqKx+G9jB9Q=
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr9401956otm.119.1600087085972;
 Mon, 14 Sep 2020 05:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <e0822209-0010-f314-39eb-4fae33fb6661@microchip.com>
In-Reply-To: <e0822209-0010-f314-39eb-4fae33fb6661@microchip.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 14 Sep 2020 15:37:54 +0300
Message-ID: <CA+U=DsqrFziYRjVfGnfBe0nKfxs0Le3pB0iYe=-7nDsLNZfXYw@mail.gmail.com>
Subject: Re: at91-sama5d2_adc crash
To:     Eugen.Hristev@microchip.com
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 14, 2020 at 2:33 PM <Eugen.Hristev@microchip.com> wrote:
>
> Hello Alex,
>
> Sorry to disturb but we have issues again with this patch :
>
>

firstly, many apologies for the breakage;

>
> f3c034f61775 ("iio: at91-sama5d2_adc: adjust
> iio_triggered_buffer_{predisable,postenable} positions")
>
> I recently discovered a crash when using buffered trigger with DMA with
> this driver:
>
> # echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/length
> # echo 100 > /sys/bus/iio/devices/iio\:device0/buffer/watermark
> # echo 1 > /sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage4_en
> # iio_generic_buffer -n fc030000.adc -t
> fc030000.adc-dev0-external_rising -c 5
> iio device number being used is 0
> iio trigger number being used is 0
> /sys/bus/iio/devicii/iio:device0 fc030000.adc-dev0-external_risingo
> iio:device0: using dma0chan10 for rx DMA transfers
>
> Division by zero in kernel.
> CPU: 0 PID: 243 Comm: irq/182-fc03000 Not tainted 5.8.0-rc1 #1
> Hardware name: Atmel SAMA5
> [<c010caf0>] (unwind_backtrace) from [<c010a034>] (show_stack+0x10/0x14)
> [<c010a034>] (show_stack) from [<c03a892c>] (Ldiv0+0x8/0x10)
> [<c03a892c>] (Ldiv0) from [<c03a88fc>] (__aeabi_uidivmod+0x8/0x18)
> [<c03a88fc>] (__aeabi_uidivmod) from [<c03592d4>] (div_s64_rem+0x3c/0xc4)
> [<c03592d4>] (div_s64_rem) from [<c05ed344>]

which of these lines is the issue?

        sample_count = div_s64(transferred_len, sample_size);

        /*
         * interval between samples is total time since last transfer handling
         * divided by the number of samples (total size divided by sample size)
         */
        interval = div_s64((ns - st->dma_st.dma_ts), sample_count);

would a simple return like below make sense?
if (!sample_size)    // or  if (!sample_count)
    return;

Is at91_adc_dma_size_done() returning 0?
Or more closely, which variable is zero?

> (at91_adc_trigger_handler+0xcc/0x494)
> [<c05ed344>] (at91_adc_trigger_handler) from [<c014944c>]
> (irq_thread_fn+0x1c/0x78)
> [<c014944c>] (irq_thread_fn) from [<c01496dc>] (irq_thread+0x124/0x1d0)
> [<c01496dc>] (irq_thread) from [<c01325b4>] (kthread+0x138/0x140)
> [<c01325b4>] (kthread) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xde49dfb0 to 0xde49dff8)
> dfa0:                                     00000000 00000000 00000000
> 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Division by zero in kernel.
> CPU: 0 PID: 243 Comm: irq/182-fc03000 Not tainted 5.8.0-rc1 #1
> Hardware name: Atmel SAMA5
> [<c010caf0>] (unwind_backtrace) from [<c010a034>] (show_stack+0x10/0x14)
> [<c010a034>] (show_stack) from [<c03a7e24>] (Ldiv0_64+0x8/0x18)
> [<c03a7e24>] (Ldiv0_64) from [<c0359344>] (div_s64_rem+0xac/0xc4)
> [<c0359344>] (div_s64_rem) from [<c05ed360>]
> (at91_adc_trigger_handler+0xe8/0x494)
> [<c05ed360>] (at91_adc_trigger_handler) from [<c014944c>]
> (irq_thread_fn+0x1c/0x78)
> [<c014944c>] (irq_thread_fn) from [<c01496dc>] (irq_thread+0x124/0x1d0)
> [<c01496dc>] (irq_thread) from [<c01325b4>] (kthread+0x138/0x140)
> [<c01325b4>] (kthread) from [<c0100148>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xde49dfb0 to 0xde49dff8)
> dfa0:                                     00000000 00000000 00000000
> 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> sched: RT throttling activated
>
>
> It looks like crash is there since 5.8-rc1 introduced by that patch
>
> I looked in the code and it looks something is zero, probably the
> received buffer size. It is likely that the DMA starts too soon before
> the buffer is properly setup ?

I am not sure about this. See [1]

>
> Can you help with fixing this ? or you know how we can do it ?
> Also could you remind me why we enable and start the DMA on pre-enable
> of the buffer instead of post-enable of the buffer ?

[1]
So, in iio_enable_buffers(), the order is:
preenable()
update_scan_mode()
hwfifo_set_watermark()
iio_buffer_enable()    <-  this can also enable the DMA buffer if
using the IIO DMA buffer framework
[2] IIO-core-now-attaches-pollfunc via iio_trigger_attach_poll_func()
(if current mode is INDIO_BUFFER_TRIGGERED)
postenable()

I could guess maybe that hwfifo_set_watermark() is called too late?
Ideally, the driver would use the IIO DMA buffer hook to enable the
buffer via iio_buffer_enable()
That would be the ideal way to do it, and not enable DMA in preenable.

Regarding [2] it was discussed that attach/detach should be done in
that order, and it should be done in IIO core.
So, all drivers were cleaned up to respect that order.
The idea is more in the lines that repetitive/duplicated things should
be done by the IIO framework, and attach/detach-of-pollfunc is one of
them.

> In pre-enable, do we have everything ready inside IIO to be able to
> start the DMA? Or it's better to have it at post-enable time ?

This really depends on each driver.

>
> I know you want to ditch the post-enable and pre-disable hooks, but it
> looks this driver needs them, or we need to find a way to make it work
> properly

These hooks have already been dropped in favor of the IIO core doing
attach/detach.
At this point, it may be a bit more difficult to go back, than to move forward.

I think this crash should be fixable to function with this IIO core change.

Again, apologies for the breakage.

Thanks
Alex

>
> Thanks !
> Eugen

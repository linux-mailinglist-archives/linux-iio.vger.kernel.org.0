Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771F7392A2D
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhE0JEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 05:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhE0JEV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 May 2021 05:04:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4BC061574
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 02:02:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y202so77692pfc.6
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg5mjycYP/5scMLoo/p3Ae/uXE06nE41QzGpsxXvYW4=;
        b=EuS5KbT6JOKDxcWe55Eadh50Cc3fU4NkRzbJREOBvFMrxAptRkHmbkuBDtC60sHv2p
         QphFPkQ4oA52wQc8LpXTzln5b3Fkl7NoRklFthT6UrtEP4nWsfB0FJkPVG6XC/ujSIhQ
         gfn7gGkJTA7ZkaZzjvhwzon2YMnFDA1vS454VqkX4L1WL0gn8CUWkVHl31Swzs1dGAF6
         h1wJ57CQKIwMwb1ImZv+8ra6WqjCfsTenzABYHNm4huzFL2pNQzvat4LLkd2aiCSMavX
         Pru+mnkLQllRSvlFVO2mLSZv8zEd9fVrZ1h/7J5Ur1mDkytqRc+fadRdx0aL5e9wUPs+
         OkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg5mjycYP/5scMLoo/p3Ae/uXE06nE41QzGpsxXvYW4=;
        b=aXLpahm7+CwmhiGd9P36ZTE7Hd+vcmfR36djGJ4uvmsWO+MxgUwhnF7Kp3sgcxpbYw
         ti0DDSWsOlbwrQ9q+8v2VkQvYQqNQaQujNI0qtDOk3DH8j8nhA1LJpZhotbXX3Xkflha
         epB86+L42bjziHIwny/wWCyGNwe4YpeOymbXuHG4KycuRy/UgSvtsLU5jQzfx2x2lh3v
         2NQkWS3Fs6q22LtkiouABKlwaCqGoQC09FcGAElJKHD6i81Q3tVLaoPOWoXquh0T7t8S
         XIz8FE3YQFkL5znvCpLvyiq6+uom9mh0rMxPO4HM+rBJlptVUOuYrMWn25/5PWLUB3hk
         CuMQ==
X-Gm-Message-State: AOAM531uKRke1YP50ThDZgDmRgfOt1Ywom+OAWLwpOFOsza4D7hr0Awc
        XaFC52CmfoCSSyQVnxzwCnELiK+1V4eXUdXFu4U=
X-Google-Smtp-Source: ABdhPJyIiCMLk+yTzallS7vxcBZZtFp5Dsh+4KvQuqMPhDwmo5qj4ETiMfF/JaaQKJVHjBYJc/ZKYas01mVWgQLO2D8=
X-Received: by 2002:a63:5158:: with SMTP id r24mr2735561pgl.41.1622106167262;
 Thu, 27 May 2021 02:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
In-Reply-To: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 27 May 2021 12:02:35 +0300
Message-ID: <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
Subject: Re: active_scan_mask
To:     Henk <iio-developer@freedom.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 26, 2021 at 11:18 PM Henk <iio-developer@freedom.nl> wrote:
>
> Dear all,
>
> I created a custom IIO device in FPGA which in fact contains a bunch of
> ADC channels which I can acquire and stream to disk. I use analog
> devices' libiio and specifically their iio_readdev application together
> with my custom FPGA design and custom iio kernel driver.
>
> Question: what mechanism is updating the indio_dev->active_scan_mask field.

That should be happening in drivers/iio/industrialio-buffer.c in the
iio_enable_buffers() function.
The channels get enabled by writing via sysfs in
/sys/bus/iiio/devices/iio:deviceX/scan_elements  in the _en files.

libiio typically does this manipulation of files for you

>
> With the iio_readdev application I can add command arguments where I can
> activate the channels that I want to retrieve (voltage0 voltage1
> ...etc). When I use 8 channels as command argument in iio_readdev then
> the active_scan_mask seems to be updated with the enabled channels. When
> adding even more channels the field is extended. However, when trying to
> acquire new data and dropping some of the channel arguments then the
> active_scan_mask field does not seem to revert back to the less enabled
> (or requested) channels.
>
> So.. I am searching which mechanisms updates that field with the aim to
> fix that bug.

so, are you using an Analog Devices kernel?
or is this a vanilla mainline kernel? and which version?
ADI has some custom patches that deal with this some scanmask manipulation;
is this being reproduced purely with libiio? and which version of libiio?
steps to reproduce?

i'm still not sure if the issue is in kernel or in libiio;

>
> Any help is appreciated.
>
> Kind regards
>
> Henk
>

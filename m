Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1039DA47
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFGKzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFGKzk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 06:55:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C71C061766
        for <linux-iio@vger.kernel.org>; Mon,  7 Jun 2021 03:53:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y12so1672179pgk.6
        for <linux-iio@vger.kernel.org>; Mon, 07 Jun 2021 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmvQivWgCvf1XcD00QD1FbgJfSji+9MZ2Mhw1jPm9pk=;
        b=N/XzVCdEqluO1n9+8K3MplJgjDAA+5lKr5JIUKmxhog1km34ClSZZpOb85wcoLfxKs
         oD7V/PEhrerYSMks8qN1i9INHk33HcVDQwSyiCAiaB2gair6v8IJYQbmVcUxphBqQTkc
         E+0ofVhvHsD8crlPBGw2R68Hc8atkCv7v+wfxyeJY72Abis4DG+qZ81nObmTa63zNCf7
         Klqd6aYLESYpkQV63seV2MmQV75S8B+wgv8S8xghVAHCQWgSAIebm+YYpjrTCvtb/eok
         jQynwhjAMl28yLPOGthipWDJF9qEej/3MhXr7NnRIRd9fsSeQIAMtfGBOj1iVQf90Azq
         UUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmvQivWgCvf1XcD00QD1FbgJfSji+9MZ2Mhw1jPm9pk=;
        b=DLuBRmPBSP3mB90zDuqG8gjmyUjoM4VNmJsNC62Dz/260eS7SdwxkKZFJQqhNHd6bS
         nHgsOWdIjWJr0k8dhpLwkts/HTOPP5M6DWFA924rb1ioLrJ7uulDoWDi4X4IUQTFb9Wl
         qCWp971zB4mvMiGhREMEyy34ichuFY9vggN3QMQhP2bcTkMT8KHbP34ywE9ExmR1NKx8
         APyYs2Oa8pFdArBFxR8olcuO9hr4PdCZd5HVzQolnXGJg9NwBQqIwOK7wpaeYdhP9zhW
         hcLHNjxpIe8Ux5nHaJ9JKDyEMxyLgc+LOZuCl3/Op5RQDRl+u1mNSjiaaEl2lS7AC+P1
         fArQ==
X-Gm-Message-State: AOAM530m+OGZsH7ZMVDKQ2xw7fY+Al5DelUp/9z9Ps3ug4TI6zOMKBCX
        fz1xjQ28IPLx0hg+Y8lDRSnH0NeLOZ2LyHyOtrfpGKmcQguiMw==
X-Google-Smtp-Source: ABdhPJzV5e1W1CZIEoOvtqi3sPzKbIAt8Wx4IofGbnUOhOCkgVF10v7u3D/RMtigCwB8ip90Zy2BQHG4Sy/SPPmJSAE=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr17118335pgv.273.1623063212198;
 Mon, 07 Jun 2021 03:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com> <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
In-Reply-To: <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 7 Jun 2021 13:53:20 +0300
Message-ID: <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
Subject: Re: active_scan_mask
To:     Henk Medenblik <iio-developer@freedom.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 27, 2021 at 1:06 PM Henk Medenblik <iio-developer@freedom.nl> wrote:
>
> Dear Alexandru,
>
> > That should be happening in drivers/iio/industrialio-buffer.c in the
> > iio_enable_buffers() function.
> > The channels get enabled by writing via sysfs in
> > /sys/bus/iiio/devices/iio:deviceX/scan_elements  in the _en files.
> >
> > libiio typically does this manipulation of files for you
>
> I thought so too and I can confirm that when I switch back to less
> channels that the others are disabled. However the scanmask is not updated.
>
> See some logging here trying to debug:
>
> Session 1, read 8 channels:
>
> iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2
> voltage3 voltage4 voltage5 voltage6 voltage7 > /mnt/test6.bin
> 8 active channels
> [  513.529510] acq_buffer_preenable
> [  513.529521] active scan mask: 0x000000FF
> [  513.558286] acq_buffer_postenable
> [  513.716868] acq_buffer_predisable
>
> Session 2, read 16 channels:
>
> iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2
> voltage3 voltage4 voltage5 voltage6 voltage7 voltage8 voltage9 voltage10
> voltage11 voltage12 voltage13 voltage14 voltage15 > /mnt/test6.bin
> 16 active channels
> [  523.834056] acq_buffer_preenable
> [  523.834067] active scan mask: 0x0000FFFF
> [  523.880440] acq_buffer_postenable
> [  524.041383] acq_buffer_predisable
>
>
> Session3 ,  read 8 channels again:
>
> iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2
> voltage3 voltage4 voltage5 voltage6 voltage7 > /mnt/test6.bin
> 8 active channels
> [  532.002019] acq_buffer_preenable
> [  532.002030] active scan mask: 0x0000FFFF
> [  532.048375] onr_acq_buffer_postenable
> [  532.131081] onr_acq_buffer_predisable
>
>
> > so, are you using an Analog Devices kernel?
> > or is this a vanilla mainline kernel? and which version?
> > ADI has some custom patches that deal with this some scanmask manipulation;
> > is this being reproduced purely with libiio? and which version of libiio?
> > steps to reproduce?
> >
> > i'm still not sure if the issue is in kernel or in libiio;
> >
> Yes I am using a adi 4.14 kernel, git tag adi-4.14.0  15e1a16477
>
> For iio_readdev I am currently using the v0.21 zerocopy checkout

Hmm, so the "zerocopy" branch isn't  at v0.21.
It's something much older [ ~6 years ? ].
Though the kernel active scan mask is unrelated to libiio, since
iio_readdev is being used in different sessions.

The 4.14 version of the kernel, isn't quite new.
There was some recent fix with regards to active scan-mask computation.
But I am not sure if it's related to this.

Will try to make some time to do some testing on this.


>
> Henk
>
>

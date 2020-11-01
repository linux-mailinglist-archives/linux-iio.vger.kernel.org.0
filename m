Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2FB2A1CDE
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKAJ3G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 04:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgKAJ3F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 04:29:05 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043FC0617A6
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 01:29:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 9so11511866oir.5
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvTxI3DEF+IccH5dQ4JC+3lD6ghN30bDdG0cAFSVGSc=;
        b=lLbk2dSnOlH3uXXSJ/RKEntQqY8d9ejaRkZevZyakhVPx3Mupbyer395QUPUX1bh7q
         hvOGZX09DENVbNnthx7xGVJcpo2LveGQG/yoZH/aKrMbcROAA6SF+WnJdTxTt7houqKv
         DVOGKCRE+OQzC0JwDkOn/zfwLvqxg9RQx01m8voSMvym/RnaIWI+LtyDLtVARZGsUWhA
         Kq0/o6OEFlvs2/jnndTbEgJ44zxiZVJGbIefxfpDRtQPwerjEFbKq0MH7hCRFyP4pcDb
         oS8zuFIoFnXxLadlOK2+8Dj98BFcT6fiOuQp6KgdfMwydCRhgGEN3Vkq26nmGJ8I9t1X
         vXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvTxI3DEF+IccH5dQ4JC+3lD6ghN30bDdG0cAFSVGSc=;
        b=c3ePn+4Dm7X2u2kbGDo8q2+EWCdsOUWKzi/mPGkAQrKjHoWn3z4NOzHH7f4oC/1g6U
         cUA/WkDR+IoENA3jq+9jidn6RvWJeST9uUnJsKTZgAQOSH46IQfuw6hHKCPcRkveS0jA
         sw8YijvpNLAo3H5RmCfuOkLxo9+4vro1re8l0NGBb1AEGA509tdTmhU+jaUb/MMLcain
         Y2FNS3HF59kNkx72ZBS7zQs12haNxOudivXs/jIgoisjHZiEKsolANWBlw+3KUl/i+b4
         RPF4+80/EKVVLytyPxDWI5KVMWMhniiQo/4zL+2aha/lo5eBtkFoB08Qe5vF127wTAC+
         Bx8Q==
X-Gm-Message-State: AOAM532yjqEDGf1vqH6PHG78SBP6W75uzhb3kNcmZgdWMekAkI59SyHX
        Ept70JCaC1SCVsst+hTfrSw+seXmyyWvHws/PBI=
X-Google-Smtp-Source: ABdhPJxPmbUkcCYTR+2jk++xpA983EbsH4HFbb4MqO/j0QnBZttfuov7d7dJVjwrG4xUNiz+zNnjr8S0mYx/m1vcpzM=
X-Received: by 2002:a05:6808:915:: with SMTP id w21mr6139087oih.124.1604222944221;
 Sun, 01 Nov 2020 01:29:04 -0800 (PST)
MIME-Version: 1.0
References: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
In-Reply-To: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 1 Nov 2020 11:28:53 +0200
Message-ID: <CA+U=DsoMWH281+1vv8h8aZKumkM+oocrWP6XVKVQ5AoFoXpk3w@mail.gmail.com>
Subject: Re: Requirement for at91-sama5d2_adc timestamp buffer
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 30, 2020 at 2:29 PM <Eugen.Hristev@microchip.com> wrote:
>
> Hello Jonathan,
>
> I found an issue with at91-sama5d2_adc driver, namely, when using DMA
> and timestamp in the same time, the hardware provides the sample in the
> fashion (2 bytes per channel) * (number of channels) - as copied by the
> DMA master to memory.
> I compute a software timestamp , and then push to buffers with timestamp.
> However your push code will try to write this timestamp inside my buffer
> ! and overwrite my samples... I have multiple samples in the buffer
> (watermark number) and there is no space between them because the
> hardware copies the conversion data directly in this buffer.
>
> Do you have any suggestion on how to solve this, except 1) giving up the
> timestamp in this mode or 2) copy to another buffer with more space for
> timestamp storage ?

I'm assuming the issue is here:
                iio_push_to_buffers_with_timestamp(indio_dev,
                                (st->dma_st.rx_buf + st->dma_st.buf_idx),
                                (st->dma_st.dma_ts + interval * sample_index));

Can the DMA be configured to add some padding in-between the samples?
It looks like the way this is currently working, timestamps cannot
work with the DMA buffers and multiple consecutive samples.
But, it may be that this case is a bit unrealistic; or shouldn't be supported.
DMA is used to provide really-fast transfers; computing timestamps in
SW for each sample would slow things down to the point where the
transfers aren't fast anymore.

What would [possibly] be an alternative, is to do a
"iio_push_multiple_samples_to_buffers_with_timestamp(indio_dev, buffer
for 1 sample-set, n_samples, )".
That would basically mean, the DMA gets 10, 100, 1000 samples, and
adds a timestamp at the end.
Now, the only thing that I don't know here: is how userspace would be
able to determine the number of samples until the next timestamp.
I guess some mechanism could be extended inside IIO to accommodate for
this; N_samples_till_timestamp counter, with a default value of 1.
Not sure if it makes sense though.

>
> Thanks,
> Eugen

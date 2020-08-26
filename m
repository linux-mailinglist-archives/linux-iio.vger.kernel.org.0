Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59573252756
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHZGgx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 02:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHZGgv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 02:36:51 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7495C061574
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2020 23:36:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x24so658904otp.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2020 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQG8aa/mqUz/RIkX9O6qbyAY5JOzWhQQ38flclwYuBQ=;
        b=ubh006S+NfFNHOSdcOD8uKx5WdM0Uc7cQ8Jx6nGQ0/viSXHOf5iUCsAcrYvsDB5lnq
         IpbB+Ezvp2Uz9txeuozHb3EYSo8ONTGoOzuO9aQpk7k41jMlsLyyej7bJznQq0z+t2UA
         Sig0MpulllQVf/+7t3crVvYAu0sW17SVCYw+RPVy4HLXky/FZBkg+uhYoOdr9gBj763D
         rB4ZagblAkOHw86TuKqp0Hj4IHsM7nh5D4tNHwY7RWj8CUa1ld+uUsr9WVpX1F+JqbRD
         VFkcv+EHS3J67ZP584CLUmdK89BmLpA25e30IwgXh4SxkP7S8Q0fuAN9kHXw6TPTyuYm
         B1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQG8aa/mqUz/RIkX9O6qbyAY5JOzWhQQ38flclwYuBQ=;
        b=ME/4UKC5qIStDYxuHVsxi725WwQgcPscYI3UUQ6lzyjdmXEzb+dQAyeBzQjr9KSgRw
         jvDP9DNTnkJK8KyqKWbZX6PqqNWAk9uVIHFC4Hd5npylPtgmNmB6wUijfrHlSLQnk0CO
         yHgobqOWwd4jWMLEoN3ZwC6MlnyNzMECEbIzwibUxXMMsAPuPA8eynkDjOWRtPJVwo0T
         yOcNb62Tdb87uh7MPNARRtRelzB6JQjo/9hULUsGv7MmYp1+yXOUNqiEsnD1vWTpbCsN
         F9NF5JUkbB5mb2Cp4EUkc+lv+EvgMXRBgShrl4cuASv9taJURZFaKv8L46GFtoqKhXij
         Lt8A==
X-Gm-Message-State: AOAM531NlvxWZjBba/n1UCIsQs1R2w5HuAm3Ov3P/g6xxP7oib82+Q3D
        6XOzTpdFcwKui/AbF1c3My7yqVj2w7dIurfXyO4mpc5ShQyXdQ==
X-Google-Smtp-Source: ABdhPJyo4JBBIkHYypjViaRe9IkCPBKHt/BdNaWTwO982JP2/yqJQwLxm2afuQubZd3Mwfx8PPtUeI70YTZnBoLLPvw=
X-Received: by 2002:a9d:4c04:: with SMTP id l4mr8769896otf.207.1598423810960;
 Tue, 25 Aug 2020 23:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200826052011.13348-1-lars@metafoo.de>
In-Reply-To: <20200826052011.13348-1-lars@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 26 Aug 2020 09:36:39 +0300
Message-ID: <CA+U=Dsp8KXNzmVGf9N=A+h7DyC2L7Hk2A7N4ERPL4jc+-M_mFg@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer-dmaengine: adjust `bytes_used` with residue info
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 8:22 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> A transfer may fall shorter than the bytes in the block.
> This information is available in the residue from the DMA engine, so we can
> compute actual `bytes_used` with that by subtracting the residue.
>

This was in my pipeline as well [obviously].
Thanks :)

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 6dedf12b69a4..5789bda0745b 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -45,7 +45,8 @@ static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
>         return container_of(buffer, struct dmaengine_buffer, queue.buffer);
>  }
>
> -static void iio_dmaengine_buffer_block_done(void *data)
> +static void iio_dmaengine_buffer_block_done(void *data,
> +               const struct dmaengine_result *result)
>  {
>         struct iio_dma_buffer_block *block = data;
>         unsigned long flags;
> @@ -53,6 +54,7 @@ static void iio_dmaengine_buffer_block_done(void *data)
>         spin_lock_irqsave(&block->queue->list_lock, flags);
>         list_del(&block->head);
>         spin_unlock_irqrestore(&block->queue->list_lock, flags);
> +       block->bytes_used -= result->residue;
>         iio_dma_buffer_block_done(block);
>  }
>
> @@ -74,7 +76,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>         if (!desc)
>                 return -ENOMEM;
>
> -       desc->callback = iio_dmaengine_buffer_block_done;
> +       desc->callback_result = iio_dmaengine_buffer_block_done;
>         desc->callback_param = block;
>
>         cookie = dmaengine_submit(desc);
> --
> 2.20.1
>

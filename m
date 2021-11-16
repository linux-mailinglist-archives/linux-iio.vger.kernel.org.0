Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8D452D48
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhKPI7H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhKPI6S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:58:18 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5EFC061570;
        Tue, 16 Nov 2021 00:55:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id h63so10122800pgc.12;
        Tue, 16 Nov 2021 00:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wuK2JM7pYYK7PmRiy77xGnegksjiUGl/GD+82KJ9KA=;
        b=Rm01oHmLcVI99f59n7+IGw28B0Rc78Op12dy7tVzZi4kxvsJ1CAILkiXaIjkBOgtEz
         UN+SCki7wYJpTktfu9lBsi65z2SfwCUIbZ06kev5ddroesDxySGdmsFsvyJtQIRJFnAk
         wi9/LccrYn+H2BHaa4h0H0+JP8d1CKcOZVdd4pHj3Y0LkFx/Sx3BcaOE0Ea1cqxiqvhU
         MqYT9nepvdI+lUXvnof57jn/CAqjdHsk7pn/VaztRRQuQv4WxsqD0WKVmAxjckk3S/3a
         tqVOwC8fWaNGRDi59gRnt8/cNGm/svlj2WCaPBQ07WNWrMfFt4PH3AY5MeUbcKcC1ZJS
         Nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wuK2JM7pYYK7PmRiy77xGnegksjiUGl/GD+82KJ9KA=;
        b=a0kZU+7KcilIDSac5948dTrAqdaRFwUpCoWQjSEBGHtNWMxf8EoH+saBz6V7UYJUK1
         l6jvD6N+tSQtaFG4LHfKAgnbVKQTF0Y+SspwMru+hJEIGVnrtPaGAINz9wgczANOfYl6
         dndQUx3+OZXPmDCSqneDuTIZ5+qi/w005I7FoxXMXwec80RpYusn3/8I2Vgf7AySwzKv
         IaIc63D58CfbgAF7cdUXfkL77Z8JvkHFgkwCoK8Q9Le4Xvn3SrMKwxoDRfLctkXRagRC
         VYza3NcT1jbIRjkucZkDdtUN0OEYrRueHL06ukOcwNHjcaZ9x/+NWasHzvut+UadejBL
         iJgQ==
X-Gm-Message-State: AOAM530dZLD8jdo+3/bETsO4QboqpUkODjm7pF5ZDSpEVL+cenWqLCCG
        ZxkC5tzoAZyZ0ufinCZ+g02znriU0rnCXMzfzDQ=
X-Google-Smtp-Source: ABdhPJxz7J/5wr41dIgVdELYoASUX5KoLZMfrsXOIXE58Qew4a7xLyrP4bWVXmWoM2xBev3puPrNe9Un7aMisw7bZX8=
X-Received: by 2002:a63:584e:: with SMTP id i14mr3798329pgm.356.1637052915589;
 Tue, 16 Nov 2021 00:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-7-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-7-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:55:04 +0200
Message-ID: <CA+U=DspKfDmLhSg6fqz44w-BmmuP1Ju_RuMhS5+ZJXRUzq97fg@mail.gmail.com>
Subject: Re: [PATCH 06/15] iio: buffer-dmaengine: Enable write support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 4:20 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
> functions provided by the buffer-dma core, to enable write support in
> the buffer-dmaengine code.
>

This is a bit related to the comment about
iio_dma_buffer_space_available() in patch 4

But otherwise:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index ac26b04aa4a9..5cde8fd81c7f 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
>
>  static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
>         .read = iio_dma_buffer_read,
> +       .write = iio_dma_buffer_write,
>         .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
>         .set_length = iio_dma_buffer_set_length,
>         .request_update = iio_dma_buffer_request_update,
>         .enable = iio_dma_buffer_enable,
>         .disable = iio_dma_buffer_disable,
>         .data_available = iio_dma_buffer_data_available,
> +       .space_available = iio_dma_buffer_space_available,
>         .release = iio_dmaengine_buffer_release,
>
>         .modes = INDIO_BUFFER_HARDWARE,
> --
> 2.33.0
>

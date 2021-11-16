Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D30452CB2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhKPI32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhKPI31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:29:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C0C061570;
        Tue, 16 Nov 2021 00:26:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 188so16940932pgb.7;
        Tue, 16 Nov 2021 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUkyXCVCQcML8mU+bt8DD4FB+5QBSOVSc/yYB2EHpFc=;
        b=Vv3cuUmrlkKpggK0A4S5Fw/fpL1GdDa4UJDK9d/JH7khq5ddZBUjqjkf8N5ZohL3Bd
         sAeX5g08DfWLVDHOZN1gI0lAl5hlJmyNHOnCdrtKGqpD3rPmJvMDIA2fc9Nprx7ZL4fo
         M+fTefDtyvEPGq5XrnzrqEdg2bfwTvRxEEoXCBEZyspVzL/DanuBVDQxpUjoRQMIMenv
         IZTf1yqUPxj5XYcVeqcHWToOgHOWTR/D5iSLSk/8+qufzQ+s3ljX+q6084X9q9POjYFR
         XwBjJE4Mchaxh7QcPq1ZTvd5IhqqT9GRJwLqaN/FT5RNMSmsE/75A5Xg7W0F9D5lUb+O
         eBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUkyXCVCQcML8mU+bt8DD4FB+5QBSOVSc/yYB2EHpFc=;
        b=65faLpNjrtKkIzk0+hug3lkPB0a5InX/5qIbWbrt+HQF4/pFhqPq0qkGk2dAm3SDCS
         vfloOnilkSg/D0vjgffcUhueOyNbFLIf0l0c+3B8GJ6MjvUGUVw3czuQD12BA5gDW6Z5
         vReo2XIKb01BHrb84r7gGOaoZR+46LQXwSAEOU7tEiCjYh8JDzjiWR2ioc5htwxQZxLz
         0YthcReztEOVTDe3AmTfKGHpq53V3zKiJN1YZx9gDl3DZkIsTE6ufXIsIPCxXACz0Oko
         h4GC2sYKeoxSxi1jji+WeqEmMuCVq4fYBKAPvZbG3iKAyT0d64vmpYhcsv4mnw0MLFMe
         pxCQ==
X-Gm-Message-State: AOAM533fFK70Bv15y17AHmvlWITp54GQdnQT2n4H77lH8soUEnHM/Dc5
        HqmgjP7wNjWZiV6kfDo/1PYeKjpr6bilcBAd36I=
X-Google-Smtp-Source: ABdhPJxgfh6Xgrp/tq7DgShkG7qFpZU22bNGSqLPVGAEnulBw2EuhE/eTEwyZUerfoJCNVCNPaICArCt8bkbPVRtYK4=
X-Received: by 2002:a63:4a63:: with SMTP id j35mr221510pgl.409.1637051190106;
 Tue, 16 Nov 2021 00:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-4-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-4-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:26:18 +0200
Message-ID: <CA+U=DsrCPQhe4pqC4RReDFno1pazJYq9D89wuMnsLubUz-ytTw@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: buffer-dma: Use round_down() instead of rounddown()
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

On Mon, Nov 15, 2021 at 4:19 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> We know that the buffer's alignment will always be a power of two;
> therefore, we can use the faster round_down() macro.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 1ac94c4e9792..f8ce26a24c57 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -67,7 +67,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>         dma_cookie_t cookie;
>
>         block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -       block->bytes_used = rounddown(block->bytes_used,
> +       block->bytes_used = round_down(block->bytes_used,
>                         dmaengine_buffer->align);
>
>         desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> --
> 2.33.0
>

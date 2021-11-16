Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E123B452D37
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhKPI44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhKPI4y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:56:54 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC3C061746;
        Tue, 16 Nov 2021 00:53:57 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 8so5629093pfo.4;
        Tue, 16 Nov 2021 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y9YeuCW8eOOLIcu5yD/PfqnnbmLxrZV0z1wmw4Pn3w=;
        b=gyzei4Avsij3HhAjJpCgZX9P7D4ljhzeYeLP1HN1Gi37X+O/Bamt9X6HJaKTKBk/m4
         oZdCvKVrdYHcV5LrcDq6aK7Aq0ZLbUz8OWMeNFB20/yGQceuG6KytOI1e4KL0tiAihDR
         mim4rj28ayYKY8sPPjcn24k+prv5s0mmWeB0W7hVdh7E/ZggeKKdSfFjOoxK4jMOg46S
         dfoDSwVpqCTlq6tL9Miw4eH64Q5YCeLSIqJp6tAhxIoPwovgA81+7AldV5TW3t4GIkKs
         dxpY2fdfSwIjgG9YC/McUsGtyLsHYXu3/enfmvqFO2M1GPemDB47h4IqEDjRNKrBPp3t
         dX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y9YeuCW8eOOLIcu5yD/PfqnnbmLxrZV0z1wmw4Pn3w=;
        b=uwWOR/pHeaCpbgiYTlrYYSqmHKd5hh6qEo2FQENTU3Q3qpgUWFEItS7peTEjEQDiwI
         5bMWnHN1vdFwdPhSbFZxC51kmkrATQjKg9VuIX7YChCphr+mKSxkAiZvLtDugLDbFGBg
         o0vWyD8/0GCQoGlIfGCHftwjkBuVwHKDYm3imKXkwnvDXZEgbPVcKGwj7Ra83PXuh/yw
         rRlwIqqDcABFPJkBHxmPVvrC4TvuRxCLRC2VGkf0vaVhOZbs8dZ5U4YZV519IRnhOyu+
         re9BGcKQ/CTsV58JXVveAE1es3zV24ex1aTqmuBjtHGsJp/9FeMyUiU5UJfPo0QGmPYd
         OjTg==
X-Gm-Message-State: AOAM533MIzggpM7zhfPbBvvJkl/8riB2XUX28b3jzl7ElKw1e/YuTG8q
        Tuz1rRloCTn1BNglLELeQc0zvYGXSipyyrg4TU4=
X-Google-Smtp-Source: ABdhPJx/cTDPSyzMW08pTOFtQdCPjm1pjXeUGXvBoLAkg+6Epn9RG5s9fWv7pooDAqPySAVqHbAZaN58Gv6ir8EWSx8=
X-Received: by 2002:a65:6411:: with SMTP id a17mr3865937pgv.54.1637052837099;
 Tue, 16 Nov 2021 00:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-6-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-6-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:53:45 +0200
Message-ID: <CA+U=DsrXFTZa0cTe1ZtLM_JDxcQU=bQ1TFzam83XaD=whA5pmw@mail.gmail.com>
Subject: Re: [PATCH 05/15] iio: buffer-dmaengine: Support specifying buffer direction
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
> Update the devm_iio_dmaengine_buffer_setup() function to support
> specifying the buffer direction.
>
> Update the iio_dmaengine_buffer_submit() function to handle input
> buffers as well as output buffers.
>


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/adc/adi-axi-adc.c                 |  3 ++-
>  .../buffer/industrialio-buffer-dmaengine.c    | 24 +++++++++++++++----
>  include/linux/iio/buffer-dmaengine.h          |  5 +++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index a73e3c2d212f..0a6f2c32b1b9 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -113,7 +113,8 @@ static int adi_axi_adc_config_dma_buffer(struct device *dev,
>                 dma_name = "rx";
>
>         return devm_iio_dmaengine_buffer_setup(indio_dev->dev.parent,
> -                                              indio_dev, dma_name);
> +                                              indio_dev, dma_name,
> +                                              IIO_BUFFER_DIRECTION_IN);
>  }
>
>  static int adi_axi_adc_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index f8ce26a24c57..ac26b04aa4a9 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -64,14 +64,25 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>         struct dmaengine_buffer *dmaengine_buffer =
>                 iio_buffer_to_dmaengine_buffer(&queue->buffer);
>         struct dma_async_tx_descriptor *desc;
> +       enum dma_transfer_direction dma_dir;
> +       size_t max_size;
>         dma_cookie_t cookie;
>
> -       block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -       block->bytes_used = round_down(block->bytes_used,
> -                       dmaengine_buffer->align);
> +       max_size = min(block->size, dmaengine_buffer->max_size);
> +       max_size = round_down(max_size, dmaengine_buffer->align);
> +
> +       if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
> +               block->bytes_used = max_size;
> +               dma_dir = DMA_DEV_TO_MEM;
> +       } else {
> +               dma_dir = DMA_MEM_TO_DEV;
> +       }
> +
> +       if (!block->bytes_used || block->bytes_used > max_size)
> +               return -EINVAL;
>
>         desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -               block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
> +               block->phys_addr, block->bytes_used, dma_dir,
>                 DMA_PREP_INTERRUPT);
>         if (!desc)
>                 return -ENOMEM;
> @@ -275,7 +286,8 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
>   */
>  int devm_iio_dmaengine_buffer_setup(struct device *dev,
>                                     struct iio_dev *indio_dev,
> -                                   const char *channel)
> +                                   const char *channel,
> +                                   enum iio_buffer_direction dir)
>  {
>         struct iio_buffer *buffer;
>
> @@ -286,6 +298,8 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
>
>         indio_dev->modes |= INDIO_BUFFER_HARDWARE;
>
> +       buffer->direction = dir;
> +
>         return iio_device_attach_buffer(indio_dev, buffer);
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_setup);
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index 5c355be89814..538d0479cdd6 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -7,11 +7,14 @@
>  #ifndef __IIO_DMAENGINE_H__
>  #define __IIO_DMAENGINE_H__
>
> +#include <linux/iio/buffer.h>
> +
>  struct iio_dev;
>  struct device;
>
>  int devm_iio_dmaengine_buffer_setup(struct device *dev,
>                                     struct iio_dev *indio_dev,
> -                                   const char *channel);
> +                                   const char *channel,
> +                                   enum iio_buffer_direction dir);
>
>  #endif
> --
> 2.33.0
>

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84927BE5C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI2Hs2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 03:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgI2Hs2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 03:48:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EDC061755;
        Tue, 29 Sep 2020 00:48:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so3186062pgf.5;
        Tue, 29 Sep 2020 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cB5LlZwyATx3IbiMyEseL5EpOMoLqG0eCQBkSlYQVOs=;
        b=e7oU7+wyUsaxcKD1alcjs93UUqANuwvDb+ykR81C3+GQkaESuFLDn0S8n0wRiuN3iG
         t7ZQdvTz8mc7uvG4NjcHQX7UuNuulca3GIB89PesySPTASGX4f0n3jPo6qlMxr/0WOjg
         o/7UpmXfFz3SzUE+3kjUa/FlBbrfbDt+gJzmRrjehOd8qJ3rhfpnwAdFXVm73ISKwvNS
         4oq60H+tFKbA4q75LzUnkukXzr0h1vdH5Ka1hwRN3ZZM118nigC7xI4SqQEIvq9mWh53
         agF+OePPWrF4LWqzavkaoud+7G1UVSiUylO0QnvMTEbprJ77hyYstANe/vyNTnOxBj+6
         RHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cB5LlZwyATx3IbiMyEseL5EpOMoLqG0eCQBkSlYQVOs=;
        b=nWV9PiG1vZqatAcuBBHWSsKWtIIO7nLBVdcI2xaR93Mx9mGg8FmdjArjb+Z/LwWEPg
         qjchYKnLg7qAMSdd/37aH7W3sEKShbsdZciIXmJxBCIngUqQGrkLL1lP7Kdub2dElaFT
         OJRJbMQv3yJoxYvpCMlGwPV5TA/eWD1QHKDM4+3c7NQGG3V1sPkYwQjRRkAyuzqnAkis
         MzoIuXIc12iCdZ3KDTmK3wh7fWd/jkawuRwFWvmssAs2A4abVMYhwnF8OjAnALdn3/Qy
         YU9GqzqfICxsQsEO0qLNNPqzct8euf3ihg2gNLqml3hqPYmHpn56s29j+wOsOHFnsuKj
         KF8Q==
X-Gm-Message-State: AOAM53331DJ2PVf6NNnmuUf+VWP8pwfNbr11cHKdquGFc1HsMqozpJZK
        QHQOvuVMLjEHOWQP+fpWxEQShXNjeL8Vk3bm/XM=
X-Google-Smtp-Source: ABdhPJzy8yoTjJV4fVJxL4+fg9cfC3eH2bevrkjGuWVFYNqE5SyQkYbg3AGUUQWQefgrKn4Gj2ZrexDXMX+E7pE3JUI=
X-Received: by 2002:a63:d648:: with SMTP id d8mr2297018pgj.4.1601365707643;
 Tue, 29 Sep 2020 00:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200929070908.10456-1-alexandru.ardelean@analog.com> <20200929070908.10456-2-alexandru.ardelean@analog.com>
In-Reply-To: <20200929070908.10456-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 10:48:11 +0300
Message-ID: <CAHp75Ve_A_9ejG=sQKeLwEWWviLhZq1_L+WcTFk+=u8UGydKZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 10:09 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The iio_buffer_set_attrs() helper will be removed in this series. So, just
> assign the attributes of the DMAEngine buffer logic directly.
>
> This is IIO buffer core context, so there is direct access to the
> buffer->attrs object.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 93b4e9e6bb55..becea9f68181 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -200,8 +200,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>
>         iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
>                 &iio_dmaengine_default_ops);
> -       iio_buffer_set_attrs(&dmaengine_buffer->queue.buffer,
> -               iio_dmaengine_buffer_attrs);
> +       dmaengine_buffer->queue.buffer.attrs = iio_dmaengine_buffer_attrs;
>
>         dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;

A nit: can we group assignments together, like
init()
...blank line...
attr = ...
access = ...

?

>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko

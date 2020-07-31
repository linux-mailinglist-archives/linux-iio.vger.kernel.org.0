Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A53234B97
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGaTZF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTZF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 15:25:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA3C061574;
        Fri, 31 Jul 2020 12:25:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so4781684plb.12;
        Fri, 31 Jul 2020 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pK9YxNDC0/VTWpHCG22pJNOCDuzWfEcGOr/zEEo8BE=;
        b=XBd+OOexs2Z8ND+gERscZBxLz213YJLlec75OS6XoV9oYuBZyefnW4FsZ7oSkTNqsC
         Njzmi5cfhT14ZSJu22lnFcmQcewBjythBILINDLxtKku50PqDk+sgOu94WtvAIefZYVh
         jaPeXjDWlgpvzWjY32EEq+D0GYJyUdmiaUZBZDgtpiFQ4CdFis2GYNdBR+O7f3DMUUwh
         IjMNjSOHx3otvZScyWLhPKQTIdLSfPWgIWzxLIdV7EYY8UJFZQMpM68bWPyZqxj1LdQn
         5yCIVj74Rxant6fyq25OlY8mhmPfU/qndyvUYUSpG5wPHDWITvEVwKbaTViSKlGzYY/4
         ie6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pK9YxNDC0/VTWpHCG22pJNOCDuzWfEcGOr/zEEo8BE=;
        b=N92oHOe8RZsDFs7paXCWGb7jn2BskZzP5Nyrt0B5Y0a3svTKxpdKNKLOD78Zqe7xuB
         3hrb3INprlcCKF2uDWpomo90bMCv8uPeYb9LqxyWrz6YT5G2SJmm5+VWXyMF1ueYHSzY
         Tz+EkCMprr8Hz9Eto7709W+UBrSnd2Dp0BBmPlgPFmV3HabXguijjSJuWyyAXU7iNOT/
         I7xH1DvkkWFeeeeQQwsFi1UJ4PtUOK620r8wNHrmDPL0bcAfXU83b4mmifkX/hNtJFmp
         LXYvDQ05nK+tdHZcscv1hVEnMtRMSTgYmmegs5aGz5p9HwnVtTO783PK+T6xIQuQGA2O
         QhZQ==
X-Gm-Message-State: AOAM532Y2yCMjUZL9iJna2zWOpX6EK10ucqu+f8I6FhoQF/y6X4rY5J7
        08yM76WeNAW597bjC+2t/Qf8oF1mxC90hwDTecU=
X-Google-Smtp-Source: ABdhPJzldNWSlk3wi4UR9LswD7any2VUHzu8VTDpg8lxslzUz6fFySQbukK9E9DDQ6KhSM7g6PtQXVMiwnwUWWDBXmI=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr5018619pla.18.1596223504622;
 Fri, 31 Jul 2020 12:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
In-Reply-To: <20200731104555.v3.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 22:24:47 +0300
Message-ID: <CAHp75VeMGtnhCEuMODNO3K6JfFTbm=gLr4yZdZHV-JsBW0eS_A@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] iio: sx9310: Fixes various memory handling
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 7:49 PM Daniel Campello <campello@chromium.org> wrote:
>
> Makes use __aligned(8) to ensure that the timestamp is correctly aligned
> when we call io_push_to_buffers_with_timestamp().
> Also makes use of sizeof() for regmap_bulk_read instead of static value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
> Changes in v3:
>  - Changed buffer to struct type to align timestamp memory properly.
>
> Changes in v2:
>  - Fixed commit message from "iio: sx9310: Align memory"
>
>  drivers/iio/proximity/sx9310.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 2ed062d01634bc..c46584b4817b4a 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -132,8 +132,11 @@ struct sx9310_data {
>          */
>         bool prox_stat[SX9310_NUM_CHANNELS];
>         bool trigger_enabled;
> -       __be16 buffer[SX9310_NUM_CHANNELS +
> -                     4]; /* 64-bit data + 64-bit timestamp */
> +       /* Ensure correct alignment of timestamp when present. */
> +       struct {
> +               __be16 channels[SX9310_NUM_CHANNELS];
> +               s64 ts __aligned(8);
> +       } buffer;
>         /* Remember enabled channels and sample rate during suspend. */
>         unsigned int suspend_ctrl0;
>         struct completion completion;
> @@ -346,7 +349,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
>         if (ret < 0)
>                 return ret;
>
> -       return regmap_bulk_read(data->regmap, chan->address, val, 2);
> +       return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
>  }
>
>  /*
> @@ -697,10 +700,10 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>                 if (ret < 0)
>                         goto out;
>
> -               data->buffer[i++] = val;
> +               data->buffer.channels[i++] = val;
>         }
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer.channels,
>                                            pf->timestamp);
>
>  out:
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


--
With Best Regards,
Andy Shevchenko

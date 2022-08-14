Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678B592619
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiHNTKV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiHNTKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 15:10:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53083CD2
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:10:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v27so4312050qkj.8
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jAEysnNYmeCbaDAdFtRYNDgpiBvQ4/SysADkVoFqV/A=;
        b=hLAk6fDA99ApWAKQx7KCyNzF5BQD7sviOJaZfGD1gwTVdBei7IUywfNHj6wlYYwtfg
         SyA7KIMRdURuqA4RzCVVwW/rHvTsiXQNCJGcGCICT+GM5qsjkfxwrpho9RUJ0HoiaRIP
         ZQB9c9uqOeIVwt7KBwB6DU4YO4vy+jgCU6WnIL+mpfC1YWsXxYt/+R6iJuvv4VDVF9sj
         e1ftR1M/UcwZjodnhTygP5kP1XqgqIL24QyEEI9AcRo1xdLVHXthfheoeG5dvOQ/1QZG
         cPwqPVBLpHoUgP/4GUu4RaGO66vZTWLZ0Q+0J8JKVxx//CRWm1GKEZwmiEGqPU7vQAYV
         dHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jAEysnNYmeCbaDAdFtRYNDgpiBvQ4/SysADkVoFqV/A=;
        b=7r5zBjCe0/uebfDJ5ouF/c6FT0Q0OZ9X8rI85lTzLajsvQqzuXrYRLOp8TMnASGV+0
         qlQje6in5V1E3rq9WCfQWK02FNS0Uykoh4PomqCk0m9lBlK/OO1JjmLi3pnCK3p88PVr
         QumGMyRmzXZBmY8ZwhX3AN8W1q7TngVkIb+0XXJqKVZh/krGRp5ImUXZCbteyUy9IlH2
         w9/MGzObTmaTH44b3xT0fC+k+x1LkPRI03Wlh00/CCQuXELT8FE7bge0LUqhq1wdGjpo
         0yDZ4mJKHT+Aw/IX2nx6PGl0idC2GoZn/YsIdhogLHOsgFcOVpzADrS+oH8vVZTt1Fjh
         8IXA==
X-Gm-Message-State: ACgBeo1+kgTT88tX2fzqtjvLwYGmpecD3Hv4Xe2/BVonbuUzwIcJ4XG6
        so6ZCYcyC6d8GuqDwxv4Y8Q7mlFFx0YnvX/GWpQ=
X-Google-Smtp-Source: AA6agR4Ym2qNMbJ0nu1gUQJPrFguZNceewGdEPrAl9p1jU9coQWLFnESs0fZ6OsfNSxZWqjb4DAsXD8IoQPxIxaS0mk=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr9233295qko.383.1660504217345; Sun, 14
 Aug 2022 12:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220813160600.1157169-1-jic23@kernel.org>
In-Reply-To: <20220813160600.1157169-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 22:09:41 +0300
Message-ID: <CAHp75VeOAE81E3SZRbC8amvwF2yNOYv4XT+EsserOFZg+iQKWg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832: Fix alignment for DMA safety
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 6:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_DMA_MINALIGN definition.  Whilst here, move the marking to cover
> the whole union. That has not functional affect, but makes it slightly

not --> no ?

> easier to see what is going on.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v2: Move the alignment marking to the union rather than an element in the
>     union. (Andy Shevchenko)
>  drivers/staging/iio/frequency/ad9832.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index f43464db618a..6f9eebd6c7ee 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -112,10 +112,10 @@ struct ad9832_state {
>          * transfer buffers to live in their own cache lines.
>          */
>         union {
> -               __be16                  freq_data[4]____cacheline_aligned;
> +               __be16                  freq_data[4];
>                 __be16                  phase_data[2];
>                 __be16                  data;
> -       };
> +       } __aligned(IIO_DMA_MINALIGN);
>  };
>
>  static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko

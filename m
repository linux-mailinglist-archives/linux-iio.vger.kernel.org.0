Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76D50FB9E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiDZLBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 07:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiDZLBx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 07:01:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D22152486
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 03:58:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e23so808110eda.11
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDy5lX1+WJcizyo1B7AEWgzEIzi/95F+8se/3UhQk7c=;
        b=TcnU++zA4Z8EN/Hp+TSo4HmBVp7VNoRzTOLef+mffC/tB9a2ePlHMWC6gGtMQW4zQD
         fpK3QW0MmOG+sgWnl0koxpO8O5uXF+lkMAo9ke/58u5nEgSrd6xiLt09Snh9wwjJdY80
         FcAV99qAc71EP5LPuXrmzHXl8WlYzlXRGQVgcPcdIBQlLOT6bij0VAvW6OEhSypSk4lM
         a9jdupHKiURfKXNo6MjBNtTmlzAnzC6rqCdLp0KlaQJxhEadRNB13HH7V5SJXJ/TW3un
         olLtPfrHJXipe4rwgeMfyqEeggsxfpXYrto0WciQRRaYs2XsR+yPi0GV7X5m+oU/OjxH
         dpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDy5lX1+WJcizyo1B7AEWgzEIzi/95F+8se/3UhQk7c=;
        b=vg5i7GMErMiVD7wezPmI2KUqPoAiP6FFD9/Y8dxjhkLTfWHNcpoB+EoYDHCpu0+K0B
         M5+6qwyDSb9C1kznh+zOvwT0zVFifC63QcklVGUw58HRQyVMu7HtkEdA3ILwsn/b3AdE
         M4iPpjMWO3cWwAPxeQ3SwYQ055F3ethNWrnIEJNIxP766LK5JSV0EhXQTzvNd0DeA1uD
         6/RPP3v6YaulNrLoedOYb8P4z3DWkUy1JBKqTjVZnftnrtGiYSvbll4vykeaZISQhN8Q
         bycLKK9zBx9fIgxUKVYCqM53KP3Of2kniXPsWbXgJE+qP27/yaE7DEkDY48ozwQVjxuV
         Kpew==
X-Gm-Message-State: AOAM531KK3RGhqdiHN9fay4K+IE/+CXjquCbX+yNUOSlKTmNW/qW9olH
        +fYt3ZLIXh19eAi6BjHQarFlGVN5hc55Yi3PV6EahIybcLMdqkmv
X-Google-Smtp-Source: ABdhPJyUSxPGu4IBm5irG+CxUgYvibzcKnV781wzqAVYmIx5b/renSkSWUS/2VCWMMZsBAXQxlMXEzCkc0AEKElxyZU=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr23658242edu.158.1650970725110; Tue, 26
 Apr 2022 03:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220418192907.763933-1-jic23@kernel.org> <20220418192907.763933-4-jic23@kernel.org>
In-Reply-To: <20220418192907.763933-4-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:58:05 +0200
Message-ID: <CAHp75VctPO5JUWsXGoOVOQ4YE0Y3TdmvCMsdKv0bDUJwOOgxsg@mail.gmail.com>
Subject: Re: [PATCH 03/17] staging: iio: cdc: ad7746: Use explicit be24 handling.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 20, 2022 at 11:23 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Change from fiddly local implementation of be24 to cpu endian conversion
> by reading into a 3 byte buffer and using get_unaligned_be24()
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 71c709771676..1f510610ed32 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -95,10 +95,7 @@ struct ad7746_chip_info {
>         u8      capdac[2][2];
>         s8      capdac_set;
>
> -       union {
> -               __be32 d32;
> -               u8 d8[4];
> -       } data ____cacheline_aligned;
> +       u8 data[3] ____cacheline_aligned;
>  };
>
>  enum ad7746_chan {
> @@ -547,12 +544,12 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>
>                 ret = i2c_smbus_read_i2c_block_data(chip->client,
>                                                     chan->address >> 8, 3,

At the same time it makes now sense to use sizeof() here.

> -                                                   &chip->data.d8[1]);
> +                                                   chip->data);
>
>                 if (ret < 0)
>                         goto out;
>
> -               *val = (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
> +               *val = get_unaligned_be24(chip->data) - 0x800000;
>
>                 switch (chan->type) {
>                 case IIO_TEMP:
> --
> 2.35.3
>


-- 
With Best Regards,
Andy Shevchenko

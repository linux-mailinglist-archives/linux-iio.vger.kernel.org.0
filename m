Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7511758C57F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiHHJXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiHHJXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:23:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0B13FA4
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:23:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a2so6015986qkk.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5xxNv4THnoKYdZUi//D9yp5NXMQ/THvqi0lKhTRQNY4=;
        b=mBmpWgfpwGR4/ejiz5A9V5Gvtl4a89sB2WC8EpbuOBdsx6ZDHXOtjB3nvofGPpm0Bs
         LqRHPuewVFSSDsy3QeAQ934jlt8Cv8fQghkfGa8WsSSzCbedGub9TqWIInWTludxAlY7
         pzy12mFz6uZfkiO/yR/iFDo9+qmO0yM7nRXrpzu1Cb7mXeJl1XdLR17E3QLWyLpMnhq8
         /MKqClfyhOeVh2BI7KjeZ2nQc6NV6Q1WNeziin757vxnreMqOfJDSweMp7nJ/EOjPIc7
         606Mpg7btZ5PIm/HWkIZJNIXMisQfu4vSUZV5H3J2BsSyPvl0PG/o5rLyl83TkwTW+zp
         ewEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5xxNv4THnoKYdZUi//D9yp5NXMQ/THvqi0lKhTRQNY4=;
        b=BMFJVgNYcrU2yKSN4UnCUGhTp8+6YIGjUjXDqAbE5/JoyZj55dcDJ2WPqoaUjKnJp2
         7NRGwDCaHSrWMfIjg9iqxd4Xhy0G83eGARDj0fO45KoUBfnmogZh0WF8oh1skpshCUV6
         43SiF2NpMSJJrnaboiwig2QTksj7D9yz+V02rrn2mgUuMfjOss8Hzz0FymYBIZVjXEkP
         2cO/w1w0CiQjEiQtvGIj+FuA/HVeBoDhtMAJeP0rWC8i4wUpz1ujSOKKCDiTX203Twqo
         okfJHWav6t8qkHr8Q3QlayWD5tTVP908iRtT5dutXJ3U3Z5aMe91kzJrsTNrWx39mBB2
         4+tg==
X-Gm-Message-State: ACgBeo2ynFWM+/3bQE6A39k2YCDtoDmZED/oohfDmUlsdKwNPYCMrR3E
        DlWnYz/rAoUbDpjMSLR0Tg6dmIWUZB4Cyc947MU=
X-Google-Smtp-Source: AA6agR543z/Q5diqxH5JoFM5aK7/9UXOLQTCxsfncJNiY/GMZ0USww9TGXmpplS3/B/fLSbFIcKvAGR6VFr03xkFKgo=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr3163149qkg.748.1659950593384; Mon, 08
 Aug 2022 02:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220807162121.862894-1-jic23@kernel.org>
In-Reply-To: <20220807162121.862894-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:22:37 +0200
Message-ID: <CAHp75VcJ6wX4+f9TG-WhiXDu+qrxf+BOfOyDQmJHjYTM8LXP1Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: mt6360: Drop an incorrect __maybe_unused marking.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gene Chen <gene_chen@richtek.com>
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

On Sun, Aug 7, 2022 at 6:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given the struct platform_driver has one of it's elements assigned to
> point to the of_device_id table, it is never going to be unused.
>
> Drop the marking.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/iio/adc/mt6360-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 35260d9e4e47..3710473e526f 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -353,7 +353,7 @@ static int mt6360_adc_probe(struct platform_device *pdev)
>         return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>
> -static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
> +static const struct of_device_id mt6360_adc_of_id[] = {
>         { .compatible = "mediatek,mt6360-adc", },
>         {}
>  };
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko

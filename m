Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4473A2D88
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJN5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJN5o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:57:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB8C061760;
        Thu, 10 Jun 2021 06:55:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x19so1064446pln.2;
        Thu, 10 Jun 2021 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcN5nycQAzGDrCsVQ2BM1FkWy/RLoUaBa5W7TTToANo=;
        b=eeAm4TaR2FUN8vqZN4+/1KX8VUYVuE21aUUvGQ5UoPUvc5BXR0LTNkgsR2F+DPTA8h
         kFimaP1TVcZX2/xdOmzdhGvZ+G0JZwoojHiUL7/oj/P22tLIc0hddHmXHndkEaRxPDNY
         KrVqrjgdzP8DmlfzGfjWK2TRRqSoYjaXQ6YRHlqZT52S1Cko1SPymGYDXNyNX15XeDVN
         JqIje8i0MfiptekaAkXS2rJ7D3Oe6soteX1b0WT88nSToJYoCyim2FiwDrsEeZQjoz1Q
         PI0TIOQZnmxRwG9t2d0oiYAnsArJcNJ04jZ7wLQULOPLqGD2UvS1xkgt7pIPNFi8tQY0
         eiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcN5nycQAzGDrCsVQ2BM1FkWy/RLoUaBa5W7TTToANo=;
        b=btD/MEWbygPYimEBUH2YWMyKac4oOMF63m/KapPz+Te2jruGLErizHD1WkFxHE4ItW
         KUF54iWPj3fVl0ZT/SeAITLR8fK+om1UWExYE/j/4QvlWgs64LZF0ir2P/1xx0pwl36P
         OWnqqdx+Dp9ogxCHimyAA/ufL5C7BgHE30qirDFWriJQFKrKDWWkiXIz170ID4DDepoW
         ZfUAE2GLYd/ZXYA5jNl/DFNANGHOmp/9ZZWSi1oaRplfZgU/T+et8pvD+nCJl/ax0m02
         tp+eYRNEMRV2So2CXJgUQWecr1EmF5iyn36ujHj9Jk90+dCd6rFYMDz1MrYT1dWqh/2O
         hWtQ==
X-Gm-Message-State: AOAM531bEoRDwJqRj9CrJ4irEM++9mFtlXjwI55RP35LIzuq7LckD/32
        VwgeCpInPpXvQ3VB1oslF7EdX6GvcshZyWn0A0M=
X-Google-Smtp-Source: ABdhPJydQXgSbk2KfoKkutj1agdL+SbP8nEwK0VGj5d/kzzmoXSIVmTI+2aEVvKAIR5y7Cu83EBKtROFtkKokjptOKM=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr3551961pjw.129.1623333336880;
 Thu, 10 Jun 2021 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210610104136.00002e4e@Huawei.com> <20210610134432.1752842-1-chris.lesiak@licor.com>
In-Reply-To: <20210610134432.1752842-1-chris.lesiak@licor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:55:20 +0300
Message-ID: <CAHp75VdBHdqFDqnZc2Ow2Muc_fHk_PZuSqEXMJcxJE6_YEL8gw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add margin to the conversion time
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 4:47 PM Chris Lesiak <chris.lesiak@licor.com> wrote:
>
> The datasheets have the following note for the conversion time
> specification: "This parameter is specified by design and/or
> characterization and it is not tested in production."
>
> Parts have been seen that require more time to do 14-bit conversions for
> the relative humidity channel.  The result is ENXIO due to the address
> phase of a transfer not getting an ACK.
>
> Delay an additional 1 ms per conversion to allow for additional margin.

This is crucial and not so visible in the code, see below.

> Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
> Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 2a957f19048e..91790aa8beeb 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -166,7 +166,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
>                                    struct iio_chan_spec const *chan)
>  {
>         struct i2c_client *client = data->client;
> -       int delay = data->adc_int_us[chan->address];
> +       int delay = data->adc_int_us[chan->address] + 1000;

+ 1 * USEC_PER_MSEC;

>         int ret;
>         __be16 val;
>
> @@ -316,7 +316,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>         struct iio_dev *indio_dev = pf->indio_dev;
>         struct hdc100x_data *data = iio_priv(indio_dev);
>         struct i2c_client *client = data->client;
> -       int delay = data->adc_int_us[0] + data->adc_int_us[1];
> +       int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2000;

+ 2 * USEC_PER_MSEC

>         int ret;
>
>         /* dual read starts at temp register */

Above might require to add #include <vdso/time64.h>.

-- 
With Best Regards,
Andy Shevchenko

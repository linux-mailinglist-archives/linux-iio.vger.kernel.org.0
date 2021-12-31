Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407FB482259
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhLaFuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:50:20 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494DC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y70so31912406iof.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEOEjDfVk1S8AdEfGRVogruqply+cj9SqXNSjy58rxw=;
        b=PTK8jbXitpSM2EPpb1pXe9g7A0yvbQnGg9pE35EG3YRQTW6f+OagEh+ksvifMohEfw
         DOqMyFyWTPYU4aJMZzh3N6sbN95h5LOHQcQOtcRjvgOJxANSGdW/6XxL+r13GTDVMipE
         tsbEvYIH/kWVuqfQujUEcSgYoUODcbnWsS89Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEOEjDfVk1S8AdEfGRVogruqply+cj9SqXNSjy58rxw=;
        b=SRprFJF7CUnL9On6D4es6KSvYCDVlXORDV/0r1/GAkst+784QvX7A42J9xq5DmuGpf
         r6G2TokStSRdieWWq9g/TxIY1ZR8M2KtJClQQMUrl1PnXeCp5jq+bseTZp3w7255jCTy
         v7CoLAnVzoDCOrGWpVDl/zC3n1fAw7l+gns/xPWcIzNSEbQ9O9WD2d0AijqQRBeIgMSE
         +NtWZ5Akp4uawuLIzgDqgpvNHnJQqASJwYH/30FOStfkGl5iDGcxOsQxNoREusLbPqsP
         jl2sxufsjq3+vVqfRlCkJuh029mdYvlw0i4M3Eygy61RhLM9rbccJAXU70JZit4lyjwb
         2Yuw==
X-Gm-Message-State: AOAM53166bweMCKp6/RJTshT8Wc+sP7mx0f70vZV+jOwx6S0ppEmy0H8
        gA1Hwd37wV/uFEjbLA2ZYbY1y6Wn8sWby4yHNx8izQ==
X-Google-Smtp-Source: ABdhPJyv4QUMjHaKIO0GuDmJkYYhMw8gZ+5yF9x36SJDtCbXnDEvxmR3bLTGmPFoKCKUtU25bSsFUfjS4W1a0uyHya8=
X-Received: by 2002:a05:6638:23a:: with SMTP id f26mr15573168jaq.222.1640929819676;
 Thu, 30 Dec 2021 21:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-14-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-14-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:50:08 -0800
Message-ID: <CAPUE2uvGn7sBG=untPhUzhWrWea2FhJVFmnRC6U9MoCQiGgfPw@mail.gmail.com>
Subject: Re: [PATCH 13/16] iio:adc:ti-adc084s021: Tidy up white space around {}
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously inconsistent with a space after { but not before }.
> Tidy that up to avoid providing an example to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/adc/ti-adc084s021.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index ce3f5a3814f9..c9b5d9aec3dc 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -248,7 +248,7 @@ static const struct of_device_id adc084s021_of_match[] = {
>  MODULE_DEVICE_TABLE(of, adc084s021_of_match);
>
>  static const struct spi_device_id adc084s021_id[] = {
> -       { ADC084S021_DRIVER_NAME, 0},
> +       { ADC084S021_DRIVER_NAME, 0 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, adc084s021_id);
> --
> 2.34.1
>

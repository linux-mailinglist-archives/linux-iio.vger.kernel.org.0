Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4752A20EF14
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgF3HNF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgF3HNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:13:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F268BC061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:13:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so9001990pfi.13
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngYLSi++jBo1Rn3bej5PZ7eMwYMXWD6gFVN9ZdQycCc=;
        b=cvSct6MY7gQ7HCGPZA4W/Q540rCFTA5eNdcSELtbZxjR8NMmy5mhMp6zMpGLvaTtqr
         v91fyj2it2qWrvWk7XZ9XFiY2rLuVE8iiO62Yhh8vwNj5eEyAznis29K0F/bfy++Qn/0
         jOgxXwYgkn7bTn0g7CB0WorLKo0YR//QY0iltLcYOocZRhe6NO2o6mqVaZscGx1Eskyi
         u4Dc6vHTolN5Y1s52DukKenGlCT0xjbhhanHW4c2bt8dpjTF/FZBX8lHSlDASwpr+q0t
         YzRNmbgS8bgAh4TVUtfnXc4mdfbQN9DEvzDEIwDQyr0PEihhCRQkYtAul9V+gjGtzb20
         nLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngYLSi++jBo1Rn3bej5PZ7eMwYMXWD6gFVN9ZdQycCc=;
        b=cAL0yht4+QWrYxESiA4MoEgEpyD5g/qSQCnj30iqvs6cNV7ImmEzsBOgyKcRst4XnU
         +N93GPw7A4wr3Ffe4yzISbjfcKumk5NLKYMMH4qm7+XNC/Tg1qAQwyF+HOA2Wovee/C/
         9pzyqxtpdVuZZjO6anHRpS+3hPL9a33HO/yQKDXYMRQ8YXsdLFL5tWdutCUJCEyW9SQN
         +M0qEvT5s0gNW4ikp2DdBZ/zNZBYH1WVBdmsIeQiwdKL3cCmrGYx76Xqr8aD1CstJlU+
         XVWhKdaFYJfS7W9vTA8PMKl5Vsu4jMthZA9HfFN5GiFZd5X41sXn02ubSnidvOlyxKoh
         a+CQ==
X-Gm-Message-State: AOAM531rABzXuNjkPFOAfzohBD/Ys5txeKHf9RpK6uWotWqDmUi6vBnj
        RxmdocudxV+9v2rZUtElpm3E5KU5L6SB272lb1s=
X-Google-Smtp-Source: ABdhPJzrwgdfehMqvTuKp8AauDLjuVsJHXQrcX2T/xz6EBesNHNz2pD9uo4bazIIZjpN53m/kGImDgyJcUnitwSLUnY=
X-Received: by 2002:a63:924b:: with SMTP id s11mr13331253pgn.74.1593501184495;
 Tue, 30 Jun 2020 00:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-16-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-16-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:12:51 +0300
Message-ID: <CAHp75VfMdv-VzHcbS75psjdWGOnR8bkO3vmE5Z82vAMiGZJYtQ@mail.gmail.com>
Subject: Re: [PATCH 15/23] iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst this driver already supports explicit ACPI bindings we
> might as well also allow for PRP0001 based binding.
>
> I'm also keen to remove of_match_ptr from IIO drivers to avoid
> this (now) anti-pattern getting coppied into new drivers.
>

Code LGTM, but see below.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/ti-adc081c.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 82e524b3db88..e00350e6503f 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -18,7 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/acpi.h>
>
>  #include <linux/iio/iio.h>
> @@ -230,7 +230,6 @@ static const struct i2c_device_id adc081c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id adc081c_of_match[] = {
>         { .compatible = "ti,adc081c" },
>         { .compatible = "ti,adc101c" },
> @@ -238,7 +237,6 @@ static const struct of_device_id adc081c_of_match[] = {
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> -#endif
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id adc081c_acpi_match[] = {

These IDs seem to me artificial (and non-official). Perhaps in a
separate patch remove them?
Or do we have confirmation (in writing) from TI that these are okay?

> @@ -253,7 +251,7 @@ MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
>  static struct i2c_driver adc081c_driver = {
>         .driver = {
>                 .name = "adc081c",
> -               .of_match_table = of_match_ptr(adc081c_of_match),
> +               .of_match_table = adc081c_of_match,
>                 .acpi_match_table = ACPI_PTR(adc081c_acpi_match),
>         },
>         .probe = adc081c_probe,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko

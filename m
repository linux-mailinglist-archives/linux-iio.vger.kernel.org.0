Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D504202B0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJCQac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQac (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Oct 2021 12:30:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D4C0613EC
        for <linux-iio@vger.kernel.org>; Sun,  3 Oct 2021 09:28:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so56109331edb.5
        for <linux-iio@vger.kernel.org>; Sun, 03 Oct 2021 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6vEZVm3LyODo1zKYqsn1T6r4nB/pd39J+d0my8fj/M=;
        b=oShw9k+wAZMXQVD846SMd+xGNgZ2IU7mTkxiBCPLwIsSJLW/+Re1uqwwrN1Tw+qSZW
         SNJCK47+cXJNHgsDQkEoy5FQRwoV1cEVCEkdWbyegF+2IpmN1Js4y/e3YMNRiClWVC7O
         SU+nidIrkFBPTvWvb3C6BXV/VbfaakdLhONFyH3SQthwxYd8tX0YnxcIHudc3XEG1+7M
         7dkkmmnONLCiXytYcAMiapotJ5SNkt46Hf0zsoPDkPqrLL4qiVKwxOBz88CzOQ6PeATL
         8MZI1dRp88t2ki2TkpRSqVQhPHwmfHADK0xKtCX4aYutYr2J6F2Q/kU9bRfLTQnJoeLX
         gsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6vEZVm3LyODo1zKYqsn1T6r4nB/pd39J+d0my8fj/M=;
        b=v59meUcqfgON52MyqYpIQR2USfRrPaQkyXFXuLGTfAyUSN0uMbISrPdUMSrJ/sUaJG
         JfSryL8BhHf3wljUL2fZnRzs/yPwAsmWuvKbI9eU3wS40t9O7u0wyIuLB8PoDSamxek1
         DJdlYuUgWMZV8soxPIdYlLfg0LbRKqF/QWWylsl9yqU9b5ok+6K2zC/gpVASMa3YWSpg
         dDEHcuvRvp3wIFM+ACi+WRkJiEqJfCK8d6QkXThNVggWkckcSOzQUzr0q8BY6++fRxsP
         UXWk0Fp/v5CtlQHm9N9cbi1+IyJCdmySDLsM8PUgBXjQkowC3s/Dvmpj2CgXzLgwEjLJ
         xZxQ==
X-Gm-Message-State: AOAM531UhajHnuMhLUBhaufZ0BtasLXEOAApo+cbmef7ZWneeh8UBwx4
        K3Yqolm7B4sRZLn59XfUTnbjK/F4FsvlQ9DC28QfLbn4M6agrg==
X-Google-Smtp-Source: ABdhPJy0+DNNKGbfRo+qeeQwhf40/s+sn8lwnPwBvi97aaNKUy60kKwJS1zGG0aztnlOBIZeAng9n+k9V9yYapQthPQ=
X-Received: by 2002:a50:e188:: with SMTP id k8mr12370786edl.119.1633278523521;
 Sun, 03 Oct 2021 09:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211003162417.427260-1-jic23@kernel.org>
In-Reply-To: <20211003162417.427260-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 19:28:06 +0300
Message-ID: <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 3, 2021 at 7:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Unfortuanately a non standards compliant ACPI ID is known to be

Unfortunately

> in the wild on some AAEON boards.
>
> Partly revert the removal of these IDs so that ADC081C will again
> work + add a comment to that affect for future reference.

affect?! Okay, you are native speaker.

...

> +#include <linux/acpi.h>

> +       if (ACPI_COMPANION(&client->dev)) {
> +               const struct acpi_device_id *ad_id;
> +
> +               ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
> +                                         &client->dev);
> +               if (!ad_id)
> +                       return -ENODEV;
> +               model = &adcxx1c_models[ad_id->driver_data];
> +       } else {
> +               model = &adcxx1c_models[id->driver_data];
> +       }

Can we please use device_get_match_data() instead (with corresponding
property.h inclusion instead of acpi.h)?
This may require adding driver_data to OF IDs.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D084312B01
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBHHMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 02:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBHHMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:12:18 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E0C06174A
        for <linux-iio@vger.kernel.org>; Sun,  7 Feb 2021 23:11:33 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y15so11807464ilj.11
        for <linux-iio@vger.kernel.org>; Sun, 07 Feb 2021 23:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtdVayBX6UDjQtmEyy8z/vQZLYAXfGsvcdYsRYL7i+A=;
        b=HsATA8BUgGSkKmvQzhNL2KUUQkazNMh7CvRkXUsvHcRUc31oM/ZM7tSHOr/tASzNzZ
         6ozs5QEg3GCxoHBx7nZvxfHGD2eX3dN4pikX458C8MRak7tAFvMN/sdDYiiOMnfCEelm
         uBlL6WwSRnByoNIl8EHDMPrsa7dd0lQ5Nf7pOuNCk1ROQtH1GrkWQC1joQuQBzkLkKH6
         Lwznclb8EX7D5dXy5Us+fx49uj5P/8C/2Kw0N9w9hFr7RO080NjnOzk04hFy7/FmXfE2
         1EXE4ALH1RpoILjsfinxtwasYzJnTXeSxH59kmyRXK8ju6T+U2yC10rJQ3h1G2U8adqw
         6eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtdVayBX6UDjQtmEyy8z/vQZLYAXfGsvcdYsRYL7i+A=;
        b=HQwc6WZ1BEs6bnnHL1Ur19sMraTlTZVTdUVt0tz03RUked/gyZKwMV4Pl/IayDT3KN
         4zO2H/GGnJYzRDaqm0d4jkB3fbcoXHV/ys2i2wt4HMISnXqkZzgOdD47gM+jCH+B4jHv
         xe5g05nXbf9DogfNvcM4gaFQqHr4PmD8QsYCy9CRwArFf54pOgk0ci6Il32M/1FktDE9
         z6Ji+DHiR6Ooway/p3fSd1myMbPa/ghtc0I9IRVrezN45j5cvRic3cfjJK3JM+G/EOTq
         NpvSfrubfK1sq5cJ7NZOyeFbhvw42z7xlOOeCmvRrCO81RxRAqaUYXw6pBlEeR/mmTfv
         uEqA==
X-Gm-Message-State: AOAM532ZkXo/mrqrPxAQ+2SXu9CTBenUCdJLfG0NSJwTWexxTm4TsEu4
        0bY1qcqbaf/4T73bA4ZQOUdHQpoHEDl3EjNoQtUWAmcwuMw=
X-Google-Smtp-Source: ABdhPJxwanPIKjWAEb2mdk81izxTrL2Bpe4lwhW2kRvE21kNXluzZEDzCHMBZqRy6zdBjFhgGHDVrJiIA0Pyoc+6lIU=
X-Received: by 2002:a92:d30d:: with SMTP id x13mr14343562ila.217.1612768292981;
 Sun, 07 Feb 2021 23:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20210207154623.433442-1-jic23@kernel.org> <20210207154623.433442-21-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-21-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Feb 2021 09:11:21 +0200
Message-ID: <CA+U=Dsowq14DJ0Dw7LBpbfeSf8BuqFJiWC12DeasKFB9=LtkhA@mail.gmail.com>
Subject: Re: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 7, 2021 at 5:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Rather than using the fallback path in the i2c subsystem and hoping
> for no clashes across vendors, lets put in an explicit table for
> matching.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 0bc8c7a99883..33c8a78c076f 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -12,6 +12,7 @@
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
> @@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
>
>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
>
> +static const struct of_device_id ad7150_of_match[] = {
> +       { "adi,ad7150" },
> +       { "adi,ad7151" },
> +       { "adi,ad7156" },

Is this missing some match_driver_data logic?
Something like this:
https://patchwork.kernel.org/project/linux-iio/patch/20210207154623.433442-7-jic23@kernel.org/
?

> +       {}
> +};
>  static struct i2c_driver ad7150_driver = {
>         .driver = {
>                 .name = "ad7150",
> +               .of_match_table = ad7150_of_match,
>         },
>         .probe = ad7150_probe,
>         .id_table = ad7150_id,
> --
> 2.30.0
>

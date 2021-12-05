Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75E8468BA2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhLEPQr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhLEPQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:16:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D7CC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:13:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so32549678edc.6
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwsleTtE9ITFe3Oa1mbrmgGj3KKxC/irpm9JBB9ac8g=;
        b=epKl9T6qXOLVDkxZNhikXXZrxZPGx6LBovXmjRPOg/wi9QRhUrDzAMKFgJukdNp/lG
         2SX1wtMaszJAzJAgJdTF02b1KGepvPz/IqYkI5G8hAMMAh6vF581KSk/4P1gmDMh2Qgd
         C7fkquuZIGJ90w1+8r91//g53Tb4BI5hamDRVRa0y3NxZgA8ZeENF0S4LbcIZ63c/XL/
         bj6UZnH1RSxB3/7/oiQvp8/b5NGIdQLCLK8VboG0fQOtN7xS6f4GIhVpDw91B+SUBxUb
         t4NHGD7l+YX0W8LYzgLJ1VOKgp+czZQSKQV4SvbVC1QD1zNcDo8jAYqjXwGBpIOXZLR3
         VxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwsleTtE9ITFe3Oa1mbrmgGj3KKxC/irpm9JBB9ac8g=;
        b=JdffI4VVFRrTcwLbmX2KbT3iuxfa9OGAYFZOcIUYezZ2tLuMtI/HwZZzGFZ9TBicbH
         z/EOgpc4c4PcDlsxYDyv+FJwrV63h18LOQUbl30J9cOi1EJGib5IOKFlrpB38az/yXkW
         rK4o0DqzbdFSx+HCtYJ1NfxD3Nh8rsGUuynHm2fPPjC9WSPnf84ZwH/wkyKyVe75HkeJ
         2UELx9vA40xcxD7Rddg0EtDDYqh5mnIgT2f3YPP4EpI/ugJ4wFdF7KjxwPAVdd8JqN0j
         1uUFjUhlKPztFPBCuYzd96znLfU0uemcABdfek9WRDNQpuPFeBuZtyruNMFaq4VJVmXI
         x5CA==
X-Gm-Message-State: AOAM530q6ltoKdPT+WkznuYnFYwRD2fYh/5PpMl2Ipfw75wSsvWaoVSF
        hQ98+O8wB2EWzftOcpAqimmKYEZiQnhmeeEOJmM=
X-Google-Smtp-Source: ABdhPJxp8xgEL/EaYBM/7hYV1WKX6inkD9XkWkpLi8Onvn8upFV7oAKCkE7j6nhCZLbJ61iBDsS6oequZgZhj0Putv0=
X-Received: by 2002:a50:d741:: with SMTP id i1mr46022554edj.37.1638717197074;
 Sun, 05 Dec 2021 07:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-10-jic23@kernel.org>
In-Reply-To: <20211204171237.2769210-10-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:12:41 +0200
Message-ID: <CAHp75VdsDsG98d4zwSTdVrcD9yiiag82yssLrLB0ehzAiNiRyQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] iio:adc:ti-adc12138: Switch to generic firmware properties.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This enables using the driver with other firmware types such
> as ACPI via PRP0001.
>
> Also part of a general attempt to move IIO drivers over to generic
> properties to avoid opportunities for cut and paste.

...

> -#ifdef CONFIG_OF
> -

It's a sign that somewhere should be of_match_ptr().
Please, double check that you remove that as well in all conversion patches.

>  static const struct of_device_id adc12138_dt_ids[] = {
>         { .compatible = "ti,adc12130", },
>         { .compatible = "ti,adc12132", },

-- 
With Best Regards,
Andy Shevchenko

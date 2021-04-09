Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD53598FB
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDIJSH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJSH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 05:18:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631FC061760
        for <linux-iio@vger.kernel.org>; Fri,  9 Apr 2021 02:17:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s11so3847129pfm.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Apr 2021 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TymJdk6ziJnMH6cQYQ9jodn5wWE+0I6x4+piRvfP4m4=;
        b=vBrgnjHXl8+9ETMVW3wrE0ml3q5DKhzLeDftQpsZ8tcrjCYh/YSw+12yXwPowQqerS
         Q6NHtzHQBfGKS6ZROVm6LTgmRoajIbLYPfyYv5CWMr8wMXsf/KDssJVgHZtISVpQXQ8H
         uWYRe1UQ37Zp9GplbxSQ9grhmJPHO0gce9Mp1lM661mtPW/GtPAyO+/Zl9CUzltBGPNp
         CCWCXM2ETJ3JDEBtf25+d/vFoenVBsfX+9MwAFSd7VOEfsQkLesNxIsCfSJJ2csgRxBO
         QTjYHekKfHv0siZg9ywE3lcDrjOUUVtizNi+ibrgr99o71edahNbHmYWJSDO7OVmLIut
         DXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TymJdk6ziJnMH6cQYQ9jodn5wWE+0I6x4+piRvfP4m4=;
        b=DNWGWlWDau7gKLxNuEOjRDkXqRl6ESvPLGPnNja77arP58CS3ZY0dUS5owOsZ4/FCO
         9nCVnFNEkjQVLqV7k2XjrX4yLo9Ra68TH2xlSIVSv+j9rOSMLP5EIh0R7Y7tOYzSO4tj
         xLqZ7Ww8IqmGnTD7Ez7LKWZH+nrYBGF0NojlfXXlz4tBjTiYbUMj1rjXHAsKkPay+ZcW
         O147Z+sGQSa8CrluIoOHPH3ZvVpOTBBYnrWhh0JySkYP4yosCl1L873zgzYOcyfcuo5d
         s90Cf4GFe5sl13XhMfH3yUGC8nLmwVywUwZVMYnp2q5vWeQnAUOku9Y0cGNw1MzzWxJO
         VtrA==
X-Gm-Message-State: AOAM531WVoS5KtUWhwrUvvR3HvgwXI/85oav7dEbKCBFJ+uEkUXjBNKd
        tIZ8qknBeb4PSmrE/9nNOU/B4LlyNaH3o4rfVuE=
X-Google-Smtp-Source: ABdhPJzhiOjtoFwGqO1hyEISIyXcHx3xbXx6qzD8Hs8I35wUeMV//koss6uqm8INr2y0hJV3nktWYeJpCOqtrlbz+oY=
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr12029458pga.203.1617959874349;
 Fri, 09 Apr 2021 02:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 12:17:38 +0300
Message-ID: <CAHp75Vc0TG=ENrN0B0j4--g6+cAdg74552a=90Q=-bE6CEP2GA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>, prime.zeng@huawei.com,
        Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Some devm variants are implemented with devres_alloc() and devres_add()
> manually to only manage a single pointer. This can be simplified with
> devm_add_action_or_reset() which works the same. Simplify these functions.

Thanks, I saw similar patches you have done for other subsystems, this
also LGTM!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Yicong Yang (7):
>   iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
>   iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
>   iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
>   iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
>   iio: core: simplify some devm functions
>   iio: trigger: simplify __devm_iio_trigger_register
>   iio: inkern: simplify some devm functions
>
>  drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
>  drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
>  drivers/iio/industrialio-core.c                    | 43 ++++++---------
>  drivers/iio/industrialio-trigger.c                 | 18 ++-----
>  drivers/iio/inkern.c                               | 61 ++++++++--------------
>  7 files changed, 78 insertions(+), 132 deletions(-)
>
> --
> 2.8.1
>


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94383446215
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKEKUh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhKEKUg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 06:20:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B16C061714;
        Fri,  5 Nov 2021 03:17:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w1so31571414edd.10;
        Fri, 05 Nov 2021 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyyVRKB6cv7Dpcxq0OeevcwnVbCku7+tmKuiTb15Tsg=;
        b=qiPluPEnRkRXDXFaWN1mkUHFaTcuU8ANTSBD6UozvjumjPUtI7zH5PSaJEV2LXgee4
         h7ILvQm9A/abS02xBs0W3mvtCDYsbPHcC4H0k/as//CmKqmLpsUlnOMGwdbZHkiw92j6
         38M/5cGlWDS7jGqHMe8LGY1ZqYX1A9BSV/VagqVlPL3dS7JzlSi0mQn+H0O0tarjjTcw
         liozsPGEPh+x9ybf+xLPn256pldrkheEw1YKcEdGzQnp3O8njReKjUzgDPFqsMcYwZcJ
         cxNPO7oRkKM1t7h+KyB7bgpnFyitTahQ8DpWmsONDcAyvrK6k1DfXoExl36uU3WYhNP4
         qnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyyVRKB6cv7Dpcxq0OeevcwnVbCku7+tmKuiTb15Tsg=;
        b=QwZOpLeewBpUwrsxGDkGjzu+3xqQVt5WM83E+I+s31M7ltflQF/K/5DX2VUrafnrW2
         +Qn0MOzH4iTU5AfXlWieO2iLm78mQXW0rMG4GJ9XDJcAetxC5I/nFXIgCxxJvpYNf560
         X3RgZEIZakPddWQQV7ApaWVIHtlRYvYdPpdkDFB3jtOHLVW3aYqIGeM1h33XpAxTf2DJ
         pbgRmq20c2LUhjEuFU7aUkVXyOGxybUyuVHPyTQYnS7bKH7tHfbm8pcgmxz1K4Z3057+
         wkEUpclqXnu/2xsW1H06hOvQzSBYl5dnFKmVzGaZVSD43lqR8Xtx4AzqvUqGH4/0fjn7
         HMHQ==
X-Gm-Message-State: AOAM532si2l2trHUJmRNCVmPuhtLCGGV5QW694qRHmTotMjcJsAVQonh
        Mn10lLkioZJ5uBywGMhONdCHnKaOi+JlH2pNfpU=
X-Google-Smtp-Source: ABdhPJysCXdrsLzWwVBK2IrP1qs/1hMOWkii+/ZO2e0UOHCjGvMUr23c1u6sWYXxA1KP5YSLpa7Mn+AckxYFDUGENLk=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr12401661ejb.377.1636107475994;
 Fri, 05 Nov 2021 03:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Nov 2021 12:17:20 +0200
Message-ID: <CAHp75VfrfH5Oro6cp3yGPKBLn=9x7wg6ucs2GA0_USff=ay0Cg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] iio: test: Add test for IIO_VAL_INT_64.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 5, 2021 at 12:05 PM Andriy Tryshnivskyy
<andriy.tryshnivskyy@opensynergy.com> wrote:
>
> Add test for IIO_VAL_INT_64.
> Add check against NULL for buffer in tests.
> Use ARRAY_SIZE(values) where it is possible.

With or without splitting, for the entire series
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Andriy Tryshnivskyy (2):
>   iio: test: Add check against NULL for buffer in tests.
>   iio: test: Add test for IIO_VAL_INT_64.
>
>  drivers/iio/test/iio-test-format.c | 123 ++++++++++++++++++++++-------
>  1 file changed, 96 insertions(+), 27 deletions(-)
>
>
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36D332285
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIKDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCIKDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 05:03:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCEEC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 02:03:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id jx13so628681pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 02:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETUGv6CYuiytrnH3sn7sakmpLqhAC3IZgq6PRq233So=;
        b=luXJngsg+2Zwm7GK8NvpVWeaouqBZVKHSelHZ4maYr57s+piEuCUj/U3goEyEY9nPn
         UFSUlRrOfUxWo2dKTXJwKw1UOK01gVhZrBAL+IO55bMKRdl+8C+ENMI5JqJBDipsHH5N
         6b3xuMztTAIRoNYdJWDFke7lzwZQKs7nZTHZVQPH8d1vZzWcxuOwjhNT5MkhQU0d6eIC
         58Xm2dg8Ma7S6LyCv27uGjQjNYfAtpgGC4BepKwc2cGG7cPzEirbP7tonSx0rJQX+8EM
         rqZEwL+BhFOjQj8g+pb52uBmys46BRdiglsPRSshdV3x2Admu70vEXqdaHxP574uLK0O
         IjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETUGv6CYuiytrnH3sn7sakmpLqhAC3IZgq6PRq233So=;
        b=GOFZ+THoYN3qObjsSeCFa7Akjgmjj3ng3/jmsoN0XTph0TbaXxRntpwk/fg5tJtkAq
         pPw3mGg9qUZhxkiGsJzRJfx5gTCYQjzfLAUZCQLgTi8j0u0LXiGu43OtDaERa30si5/q
         ODLJ2ZpyqmgMB55iVr80qg6bf0YHwjuxX9BFKaoejGUkz5ZBAK6e1NtXT5YGfgulTt9t
         cygeI8HTTndTKkTdr17XU2ZmEtvgblgBKXa2LbQP2HZPh2qCEBsyiG2dzktm0QRMaG4u
         xDcRIDR8Sn58nBjfQkSpbeR1e2DC5XbNgZkWTU9iEdIKeEtnEfTSOnOjJaZRfmv6DEUM
         yEEA==
X-Gm-Message-State: AOAM5302HFUem/lDqRx74nfZ+UVyws54KvvIqYYqcsHld51WuMf1s1wQ
        fNQ5dDk9dLw6Kf5puN5jshVr9h2m8h1qeHxEUgU=
X-Google-Smtp-Source: ABdhPJwV5Q/Gzkdy5Oj/7ANBeysTJ1LJJrwX8dpvpI1THN9EbfE88thd/6/d90UhL+iLKS+VcYvDuIIvIlCm2cDH0fg=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr475932pjb.129.1615284186228;
 Tue, 09 Mar 2021 02:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20210309011816.2024099-1-gwendal@chromium.org> <20210309011816.2024099-4-gwendal@chromium.org>
In-Reply-To: <20210309011816.2024099-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 12:02:50 +0200
Message-ID: <CAHp75VcFdEWHUYDxVATLTnVNACJ-t4A_=YG1KjowtmT13NMyzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iio: adis_trigger: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Already done in boiler plate code.

What exactly? Please, be more verbose in the commit message
independently on the subject line.

Hint: you may fix all commit messages at once by using `git
filter-branch --msg-filter ...`

-- 
With Best Regards,
Andy Shevchenko

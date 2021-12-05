Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F0468BAD
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhLEPRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbhLEPRr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:17:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C1C061751
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:14:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so32558498eds.10
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miydVed1NCVyipACKqkAttETsk6/XMGzZpr2eaT8+IM=;
        b=ADjGZjwjCnvh7udXjnsX5Q3s8VSU5wCjW+tlneODlssLOiOUKiq/tHWD2bzmoKtvHa
         MBbfFIkH5JaZWtg4PRFT3WR0aQg545HlBraiuh7dMaqLw0s/E1FB8qrgPprIc9hNEfZt
         FJCWoq/N8KVOsmIshO1Cw5Rr1j167DsBaZQCaSEih2r7tW6NFW4ncJGxTuNYRFeSiXjG
         oQA7iYICw52k4udAEzIRCDUG5GeNQLyGxaWeJE1tlnkIyrXDZgYAAd2DO335XREMuTH8
         v1+jg323TbgZEQU9XrOhPDNtxxC199bvIqkfMqOzh4sz86LIlCK89gvlajsAGtzImWa8
         zLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miydVed1NCVyipACKqkAttETsk6/XMGzZpr2eaT8+IM=;
        b=8CvaAq2f01ZcAa+RdCgBPqlB/G+GBJvjz0AsC9Hjo0lviPGNVfREIEZgj7GrTalota
         v+m7+ruUkGZsAiy3nHnPmnsxJZEWkhzCh2oMSBX9kEjvyu/L09iDafxd4UinNseL6fsq
         pDARRjWBkv1camdnN97z8yja4/rNb5n2PIitTscFkyb2a4txRt/N+ajAYcrRTGg8XXxc
         AdbbS4oTzcu4gQHO6fmJaVgMxwSjTvRymNMzHJzsS5tNbQvsVXE/q+Beu/5N2nBVBj9K
         CGiLY28oaxHX+vI6/Mja/jQLH7GeaoP3pE7Wolx3IxvFhLeJ1+I0MkZWazEO6inZLmKB
         3VCQ==
X-Gm-Message-State: AOAM5325wramGdOZg41zAdP+67eiDWkAVp4CNW7BttNaNjMOSZTzUNq+
        GuUBkfS2sK9hxs9JZ7jdaP9z22YMlj0D13Wkj8k=
X-Google-Smtp-Source: ABdhPJxSjmFfu943BfWzbxhYaUyq4+l8GfW1DIfMXT3LBMYpYuVSX1VBlriiYmZE06S7hFTcKKys8+eSzur1/U/8XCs=
X-Received: by 2002:a50:c35b:: with SMTP id q27mr44835820edb.154.1638717258900;
 Sun, 05 Dec 2021 07:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <20211204171237.2769210-10-jic23@kernel.org>
 <CAHp75VdsDsG98d4zwSTdVrcD9yiiag82yssLrLB0ehzAiNiRyQ@mail.gmail.com>
In-Reply-To: <CAHp75VdsDsG98d4zwSTdVrcD9yiiag82yssLrLB0ehzAiNiRyQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:13:42 +0200
Message-ID: <CAHp75VcHiX+DzxTSu7HtymtJ9CSZeVmtimK16wMOMQ44FS_=9A@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] iio:adc:ti-adc12138: Switch to generic firmware properties.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 5, 2021 at 5:12 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > -#ifdef CONFIG_OF
> > -
>
> It's a sign that somewhere should be of_match_ptr().
> Please, double check that you remove that as well in all conversion patches.

Also, check that you drop OF dependencies (where it's the case) from a
certain Kconfig.

> >  static const struct of_device_id adc12138_dt_ids[] = {
> >         { .compatible = "ti,adc12130", },
> >         { .compatible = "ti,adc12132", },

-- 
With Best Regards,
Andy Shevchenko

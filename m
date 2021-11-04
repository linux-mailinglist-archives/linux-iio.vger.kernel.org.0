Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F425445196
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 11:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhKDKgw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKDKgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 06:36:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC15C061714;
        Thu,  4 Nov 2021 03:34:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o8so19588611edc.3;
        Thu, 04 Nov 2021 03:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WAWxekwAKEg4Lw/OjAqf1ORTwsGFlNLlSZUUC7fMDU=;
        b=hCHscLzPNc3U9u1IlLXalt2HQLye2L9/UL21RPk57m1rLafutXaPgR7DxaMoqu2uoR
         tu9aIVrpPZO7rJXebgeSeadjTfsZUlrdD+Z9RSMTs/5IJmbDu00JzMbL+znhP+4CNue8
         3WDTwETrZP1MBhGwvC22IzR3KDRar+7hvFxZHGsOeBvXlRQMUNyEqy8bvFjEgIzOjX11
         mZ32WzJXSpkOKVk9hdcV0svDEA2cUfJPAsJgPE88rL0UQXr/+d8Ud9pi8U8k/ebcoNfa
         NcT6lDHc6T3L1894F48C2Y3KrhfGpB2QWp7fcayeolUACgOic15eoIqqyceOYgTgnkq0
         lELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WAWxekwAKEg4Lw/OjAqf1ORTwsGFlNLlSZUUC7fMDU=;
        b=lign4qNe06yY+REwhfq/+zkkqcPAfoTQ0JLkxluEa1B8xl469vkGAPJXUzfMCE4elN
         4Ac3DvTZxDMC6m7mGslNNi8aQ536mVEQyH4J9bB2XHgwiCRKtDwNSdVKRGyF8pDngAec
         qFREawbq6QjGIb4M0FXVI2tjI9Ql3Mdbdk3WJeHxujkGjwCYRLdRUIBlhTP0LnE73+T5
         NnqidKFwybzGCHhFAoWX9rlg7Bb58yk161qNGIn83oSsvmnC6EtHqo6ANRow7zxfTwVi
         2OIpipEDV/cioz4HuZsxzxrsGjGGSok+TBkJAnkFbUjwsMr1Gi+mk+3bGAXicMZJ58wv
         SFsA==
X-Gm-Message-State: AOAM533EpnMBaYpo0HrKIXbzFcFduXbyC7aDO19mrpPA0+fNEFqYRLGU
        G4mSkq8MvIW+Zmfg0EifmH1EdZ3eG3KcUJM+zhoRvuoQqVcoSQ==
X-Google-Smtp-Source: ABdhPJy0yy674rnN0APF1AkrSGhwyl+rpns1tjiL5+G/9PtnnwkRZZgZu6C1cJl9uKCMdSLl/EGpHXKIXASbPoP30qo=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr35321924ejc.141.1636022047528;
 Thu, 04 Nov 2021 03:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211104062032.1505899-1-yang.guang5@zte.com.cn>
In-Reply-To: <20211104062032.1505899-1-yang.guang5@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Nov 2021 12:33:19 +0200
Message-ID: <CAHp75VedwDcBoz=dOGf_-7aOHC1mdvT8+hyvyK+hbK-5soJoYw@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: use swap() to make code cleaner
To:     davidcomponentone@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 4, 2021 at 8:21 AM <davidcomponentone@gmail.com> wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

Same as per other patches. Don't be a dump addon to the robot, think
about the code a little bit more.

>  void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
>  {
> -       struct iio_channel_info temp;
>         int x, y;
>
>         for (x = 0; x < cnt; x++)
>                 for (y = 0; y < (cnt - 1); y++)
>                         if (ci_array[y].index > ci_array[y + 1].index) {
> -                               temp = ci_array[y + 1];
> -                               ci_array[y + 1] = ci_array[y];
> -                               ci_array[y] = temp;
> +                               swap(ci_array[y + 1], ci_array[y]);
>                         }

Name of the function suggests it's a sort, we have the sort_r() API,
use it instead.

>  }

-- 
With Best Regards,
Andy Shevchenko

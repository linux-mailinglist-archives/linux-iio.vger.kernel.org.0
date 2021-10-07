Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646842597E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhJGRck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhJGRck (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 13:32:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A8C061570;
        Thu,  7 Oct 2021 10:30:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d9so2051685edh.5;
        Thu, 07 Oct 2021 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkF9Z8gioCbTvoDnOvqn/n7sYyLCrn0gcPhgSbw+to8=;
        b=PpXoqoVKK5DVlD8743ZCxDp+4+GbpjPDX5Cl0AKLePo/QCf21H8vAHmdhsNIKoDOiE
         JLWDXYyx0zz1YPaMMBr+XydiGDD/xunA0JRsygTDsYKDT/8GveenNuGVcriq0P7hIRdY
         NBQrt0LQNhtqybT8590rcr4csQmgi91btqeTnIlyuLIcfTbG2i2UlMbR0nGK9YrSCwK4
         oBPMdbC8SYyBGOztxlK8VEKZ/TvnU1mOalqtGjrQIgPURDG+ZegjGD+6z2qNcv8o61ue
         9w8+09CP/YYf614Nw/P6fZs17/Q8Uh1WBssx149gT1gQk/LbXBhLkjd9BSccT4cfXA92
         /gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkF9Z8gioCbTvoDnOvqn/n7sYyLCrn0gcPhgSbw+to8=;
        b=a9CG1uGZS/QCggmVZDPSiSVQGa7naxAZfNNJgHJnNU67RhosL5y+xc3NrtPDELdlrJ
         B9oURyi5JqxZkd2+DwL5wmbdS4ktxJ8bp4QcBpn4AWjKw7hKkvUvSiPz6Z0jV0YrQP0v
         ZrIoyPMhu7udSeanHxA/4blxaJ41ZCYrCGjjApWFohQ/AZLhNpIMWrfw5AKS5pTIm8O9
         tCjvEwlWF/o7hA0J3RGVqoGUiEo+HEMpDiUh8P+rVz9LdBRojLTIB0TZjs+d/ZLohLMk
         5zQKRg6YkzLZCWkRAjMMOZEEOI2jk3T1w9JuG3of/jAIQf6k6H8rPspfFYUIQ3QOptD7
         oxMA==
X-Gm-Message-State: AOAM530Av5YGVTMw1a8QEZp4ZOauPuu9o95HIB5bTZHsxXO3cpybQJ78
        MzvIGmnJaBvK7WtXv+wiP7HzYNY/FG/YRbn7EzQ=
X-Google-Smtp-Source: ABdhPJzWSrOmPvNyFYHJwtvD/8gvZBkXct7cJdihU5En1U9VvvrUAIXeaBiGYLNig9ZGs1Lfr031F9wcUW+ANvFYvbI=
X-Received: by 2002:a17:906:7016:: with SMTP id n22mr7062476ejj.567.1633627844830;
 Thu, 07 Oct 2021 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210928014055.1431-1-caihuoqing@baidu.com> <20210928014055.1431-2-caihuoqing@baidu.com>
 <20210929180638.6ddb313b@jic23-huawei> <20211007183052.66be899b@jic23-huawei>
In-Reply-To: <20211007183052.66be899b@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 20:30:08 +0300
Message-ID: <CAHp75VfiV26WhXL20uyOiKJU5J=eB5PnQkV48=tDZ5xda9MvJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: st_lsm9ds0: Make use of the helper function dev_err_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 7, 2021 at 8:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 29 Sep 2021 18:06:38 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 28 Sep 2021 09:40:54 +0800
> > Cai Huoqing <caihuoqing@baidu.com> wrote:
> >
> > > When possible use dev_err_probe help to properly deal with the
> > > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > > in the devices_deferred debugfs file.
> > > Using dev_err_probe() can reduce code size, and the error value
> > > gets printed.
> > >
> > > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>
> +CC Andy who wrote this particular driver.

Thanks, Jonathan!

> Change looks simple enough I'll apply it though and at least get 0-day building it.
>
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
> work it's magic,

...

> > > +           return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd),
> > > +                                "unable to get Vdd supply\n");

> > > +           return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd_io),
> > > +                                "unable to get Vdd_IO supply\n");

I prefer seeing them as one liners, but I've no strong opinion.

-- 
With Best Regards,
Andy Shevchenko

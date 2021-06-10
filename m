Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8603A2CDB
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFJN0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:26:17 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:55947 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFJN0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:26:17 -0400
Received: by mail-pj1-f43.google.com with SMTP id k7so3645280pjf.5
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk2i3yoW5ftIn8onxSnXFaa82I00B/NbfBOXojsnTfM=;
        b=rOXb3B7XsOQkLNB23qYelCSWiO9kRtRiDheLP67NEOKPYuM+pOVVsfz9ez3nOLzttS
         BvxvoQuhS/H4Q0ycOQRfc+mlIK6BdVysphRCfUHkhhumuHCBaRbo+XQ2XnxClLMSlPxI
         u+L7aTAPJbVUABjvdBZBjqdnP3MncQaLptQhpsocRkD+j55k+nnh9wPLh+ewx5onAqon
         W0ZiQ4OGusv0MZASdv7cQvmhe8y9j0g3BxmfHqzvTOWqGZ7NQO9koPTRKXEfSkhG/Fzx
         JheYgdSi1b8WcDKFnm2/MJX8uKhOKkVbzeWs8Nc4nott5sEJob5ch913FRtI14Q3Zm09
         cRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk2i3yoW5ftIn8onxSnXFaa82I00B/NbfBOXojsnTfM=;
        b=d0h/6XbqRJNBtnYIAYhpW4IAKTkae/corYTsZGz+xV1MLcum15eqDkJ5MLs9fShUMs
         ONSUSuaZwYItPDp0dd8K+RzBL+9PKjXjnwKzTDiVYC39+NVXR2tdJn0SZoGEKHbe7Lnx
         sEdhUEnHtzBoGPqMo8/H1WcxsASbI0WnTyCqm58nnfmS6s4QGJ36a9YhsqHW0+MSKV6j
         +ljqXsOnEgEy357xylNBmObkOo+WTyNc3+5lrIF6aJjYRoddBb8y7Ur/8a5vR9znK5v3
         6Y5nt/PbmDfHFK1Qfu4CibGdxYAp7dY1rPMZr2H0/EA+9jyCRU7BiTM67/sFdhPykUte
         6dwg==
X-Gm-Message-State: AOAM532ipC/F3+WEshvH/JmacMcs8DmF+Kq/Y9JYipyeFNxI71YGky0k
        GhkivFB6s0rhp/wVJneLaopi+we0RCTcl74NegU=
X-Google-Smtp-Source: ABdhPJy7ajQ6PYggTMSq34Gfbv36uxpMHaZ4CmFD85+aWOjN1IOij7pJggdk3Cb03dJAUcXTx6DKaSWFSv7FnYCZ+AY=
X-Received: by 2002:a17:902:b190:b029:105:cb55:3a7a with SMTP id
 s16-20020a170902b190b0290105cb553a7amr4991333plr.17.1623331385693; Thu, 10
 Jun 2021 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125358.2096497-1-mkl@pengutronix.de>
In-Reply-To: <20210610125358.2096497-1-mkl@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:22:49 +0300
Message-ID: <CAHp75VffrayzwN+uTTdZBgMQ=G04Tbfi=PypFZ8AB6qwy3HTTg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: ltr501: fix regmap, initialization of ltr559,
 endianness and mark structs as const
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:55 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> here are 3 bug-files (probably stable material) and 1 enhancement for
> the ltr501 driver.

After addressing comment to patch 3, feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to the entire series.

Thanks for fixing the issues!

-- 
With Best Regards,
Andy Shevchenko

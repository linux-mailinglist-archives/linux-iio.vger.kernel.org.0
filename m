Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA1468BBB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 16:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhLEPVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 10:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhLEPVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 10:21:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A21C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 07:18:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so32842514edv.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKxL+VrMa0ocGluh3GeEq+7qedDqqmJc8xRYxJcDJB8=;
        b=gBW8d+hGm/NIHcu6DKAl1qpX75zeeA11bc6k/aE1oyEeYu4/XUWRhU7ufd5wYNURMI
         mrYSKGfdgPi/yzO3waLEZgQmjm9yBzzSSJqUg3EFSjMQ6vlBahTwamGybUwcZKDAn4nk
         SOdwTmPh5NGKXeGOY3lbi6CwGRW7jzAQ2AxUpLXhG6N+slS8efyw2utp/0xH7ntQ567B
         S3FvKrd6PNARDOAt2xXyhN0lCNA4T+dJlZe+oBaa2AHtxVUUoFprQ/SYprCgE6TPizF8
         B4qOcrXwp3yMwwZkoybn+Q3Q4HnkKw/XtzvzCF63FUsFYcyt6tGereFajymmVsU5c831
         Rfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKxL+VrMa0ocGluh3GeEq+7qedDqqmJc8xRYxJcDJB8=;
        b=bNyuMFTFn2ADkSx8DSfZKjR6CNRcRhHIPqyveuD7kFtOn0niXPXyD3O7yD7CaKqKNa
         doEHCLKTTnN6FazyKcpGQ1IC542/e7xJIGAzLrK+tsivcilZeXmQiCXlDJpkTkGP5/GA
         i75wc/YLJwrbzRbkjTTrwS/oVK0E7HLhiceRk5r0wLWU8E7ldmXWax0T73LCEoHOfpIO
         cOs+fw8QHRSrJYuUUZM/KJUC6jg6DnQOSL5YGqae9Gc7dT5EEN/FDdNbIiTtQdLbdMIo
         WJuIxWRvIcomJMCziwg2kLqwH1M0aNDnIFlez5b6Xz+RAzhbWRGmzPhAe3INeHngBPgG
         slsw==
X-Gm-Message-State: AOAM532fwCVzftwfzlNELyIHe8E6Ip+wp3YeW7be0zAneGbKZytFQwST
        eMyo0485VG8UJhh9+5ykygHfk2kYE+ZvZJW8aDY=
X-Google-Smtp-Source: ABdhPJydiE1shWKnbAsC/nvm0l0doZMlf0IhRTNMX/9EMk6OeF+ey/Bej5eswwvv4fQqQFaD6ovAU7R4+jdVuFjf7OQ=
X-Received: by 2002:a50:c35b:: with SMTP id q27mr44863931edb.154.1638717505349;
 Sun, 05 Dec 2021 07:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20211204171237.2769210-1-jic23@kernel.org> <CAHp75Vc5Lk=2HrzsQu4rNtJEYbj90FbD3xChjtG5MKmv1qkeYQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc5Lk=2HrzsQu4rNtJEYbj90FbD3xChjtG5MKmv1qkeYQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 5 Dec 2021 17:17:48 +0200
Message-ID: <CAHp75Vfh9FWYYfgaP68cSPaoa+RoGwZvavKkMiLXhU=7wa5MHA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] IIO: More of to generic fw conversions.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 5, 2021 at 5:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > Any feedback welcome.
>
> I like the series!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmial.com>

corrected email
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> But see some (important in patch 9 and 12) comments to address.



-- 
With Best Regards,
Andy Shevchenko

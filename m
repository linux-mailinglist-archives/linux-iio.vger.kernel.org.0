Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799992ECD7F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jan 2021 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbhAGKJZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jan 2021 05:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGKJZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jan 2021 05:09:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5EC0612F6;
        Thu,  7 Jan 2021 02:08:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z12so1174325pjn.1;
        Thu, 07 Jan 2021 02:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HSOsLBQe2nt/WraeHugrwri6BliaMtp4Brv1T4xWVM=;
        b=I40kSrCHvS6KIBhuZ/m2vFCQxA+3XOimoRHbjU3Ypd2BKJgVDMpDHNaI1gJcYoxeEG
         GWL4KScPqUD5y22oygEXYtMKW5O34qBXrmZrR+VCa9KEUmjRkaGdAh05ohAexNdcs4Pr
         HhojJ+40202Czg3OLz7FkgNy9a3+EdLqnAF9yQJ68Kd/rfYV1lGO6EoJm/tRBwE3q8hp
         s8mVEUQklMvzJfTZtMCXDK2j7ocffHcNIjQUJ6nKrx6L/vsqL9fnycD4IC2isb5BID7h
         4BvHOkISXQAAd2rsrAmz5XdIqwIjnBO8nK2RyB05YRByNqN/G3vGUZJQD8FuTZ4FgCm1
         8qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HSOsLBQe2nt/WraeHugrwri6BliaMtp4Brv1T4xWVM=;
        b=q5qy3CqHOM+frgSXeimAg/voP21kypmLMPKTCx1sLYdYOKw3lubWpMVAsouk7zqO7y
         14gstAqmJ7NttnCjffuSQIa6FFhQFol7WG0zU1+R7zt/fQgn7IBj0UyZFKIz+0zx+5HP
         szSZ87suWbXWPZMClocGnEu21He59LSzEFFOJSf9QMxcF6YfHOr+Lwodn311EMOjkyEx
         A33dJk7buSH1As9cNI8CJeiZ3TwLSpFBjNBCouBOVr+97clCARLabNIAdXHqBx3bjcU6
         g09lPilOeMLXnDLG1txke0hoMUVEIjYySbrvfgeTR/Tu9r6DCbtujND2BVO9mBYuHDrg
         LvBA==
X-Gm-Message-State: AOAM531a5cDzODPunrPY6709O9kShJGH1dGfQvCaHfqm+bK3grZE0s86
        mcptTk3SQEWIte970mteTyUZwP8qgir3rv5xaIY=
X-Google-Smtp-Source: ABdhPJzCyebVUsqrmKw49ykwoxpO/L7XmLhFpoKxdLZvcJTPsnjvmUD0I0ky2gxLJpnnEXhQIk9ZCc66NiKe/lwirzI=
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr8679750pjd.181.1610014123931;
 Thu, 07 Jan 2021 02:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20210107084434.35283-1-alexandru.ardelean@analog.com>
In-Reply-To: <20210107084434.35283-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Jan 2021 12:09:32 +0200
Message-ID: <CAHp75Vd0+r+Yo1+mLbKcHqjfjEUtVoSEX7Kvjj4DO4osu44Wyw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] lib/string.c: add __sysfs_match_string_with_gaps() helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 7, 2021 at 10:41 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The original docstring of the __sysfs_match_string() and match_string()
> helper, implied that -1 could be used to search through NULL terminated
> arrays, and positive 'n' could be used to go through arrays that may have
> NULL elements in the middle of the array.
>
> This isn't true. Regardless of the value of 'n', the first NULL element in
> the array will stop the search, even if the element may be after a NULL
> element.
>
> To allow for a behavior where we can use the __sysfs_match_string() to
> search over arrays with NULL elements in the middle, the
> __sysfs_match_string_with_gaps() helper is added.
> If n > 0, the search will continue until the element is found or n is
> reached.

...

> If n < 0, the search will continue until the element is found or a NULL
> character is found.

And this is what I think is not needed.

...

> FWIW (from my side): I am not fully sure yet that implementing a
> new helper is the best idea. It's also not a bad idea.
> It's one of those "this could be useful for others as well later", but
> right now we would have only one user (IIO) for this.

Taking into account the failure of bitmap_set_clump() promotion, I
suggest to reduce scope to IIO for now.

> I'm also fine with just implementing it in IIO first, and the someone
> else can move it to lib/string.c if needed.

Yes, please do.

...

> + * If n < 0, then the search will continue until the element is found or
> + * until the first NULL element.

...

> +                       if (n < 0)
> +                               break;

And drop these.

-- 
With Best Regards,
Andy Shevchenko

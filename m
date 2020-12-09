Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CA2D45C0
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgLIPqB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgLIPqB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:46:01 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B4DC061793;
        Wed,  9 Dec 2020 07:45:21 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n4so2048316iow.12;
        Wed, 09 Dec 2020 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06Y3p4pFgwU8f+X60rwMLY/HKPxnBiWvgG/RLlTl2BE=;
        b=GDomIyC9M9rnoB4CURLuz8vYpZAbsZjiLOHhEdncxBic28IauotV8cpQohn+4xGAkU
         TZvBt7FAo7IgKOZI1GqXMzCiXNbcg2p86vvYBJQ4KUrKreXNHBnpXqetE+qDZVq4cIjm
         m89qoB8apcQgNaYsxjQIjpohvA30ZhjlmKCQYA25WtxHqVxPUNZnNQ9uNOK33xjHRHaZ
         JEC+92OG7HTZZmllNHcrnr+bppbYtEcm9IeyIk1lFWTPD/qMA/BHZSVMR+aVPMcCBSyU
         cqV2El1g3ORZwVo43rSkiTX4CichAwU9F/q/b+C96l0GjGDSODwwWedGgjmBiDbCQgrH
         40UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06Y3p4pFgwU8f+X60rwMLY/HKPxnBiWvgG/RLlTl2BE=;
        b=FMy0v/pLb2ZWsfzKfb2xsZM7FHQoii0+d0XTk1JyPssGjBkJg4zPftzjlqfdt5d/Mk
         xqyBpwzqi7xPeCi09gaf3W7HvRBtpjYr8iIIrHqlA1hxGwof4JJct+ZsyszoHSH/LqTv
         BfPsroURhMrjZCNmwbYGNf8bV0VK310bKg2cPD/FpjUp3GNGd9ZfPnUBamoPD2XJH0b3
         dR46FdQk9DCtCR1+Zi3qhRK2Ukb/Sk8rN561UqTNBBKhgEVTVdnstadfTxaD5zeTh9sj
         QJOS70iDoi+aVgFHhAX/yC25AsOkzRoQvNFUYkRdM9RLBHA0xJfhkpSl1e6xofaCqJ1h
         gvHA==
X-Gm-Message-State: AOAM532uFPp6quhqSSuUBj1INJZXX7BIlMHYXjyDwPPengc1Q8PE1r5h
        tAhfQp1Aw/J3p65SwYIYoz+iRTSeGlBOeMiMPcs=
X-Google-Smtp-Source: ABdhPJxSWDbBxLeai2a8Nlg7PX5hOf0KE4P98MHitmgzdHjDi0D4r0xYCYXQAbpi/rBgm6iRilyCzBb3vGuqAuplFMU=
X-Received: by 2002:a02:3213:: with SMTP id j19mr3842018jaa.79.1607528720593;
 Wed, 09 Dec 2020 07:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20201203095342.73591-1-alexandru.ardelean@analog.com> <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
In-Reply-To: <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 9 Dec 2020 17:45:09 +0200
Message-ID: <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 5:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > We only need a chardev if we need to support buffers and/or events.
> >
> > With this change, a chardev will be created only if an IIO buffer is
> > attached OR an event_interface is configured.
> >
> > Otherwise, no chardev will be created, and the IIO device will get
> > registered with the 'device_add()' call.
> >
> > Quite a lot of IIO devices don't really need a chardev, so this is a minor
> > improvement to the IIO core, as the IIO device will take up (slightly)
> > fewer resources.
> >
> > In order to not create a chardev, we mostly just need to not initialize the
> > indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()
>
> un-initialized -> uninitialized
>
> > behaves like device_add().
>
> Are you sure there is no user space application that doesn't rely on
> character device to be always present?

Nope.
I'm not sure.
I'm also not completely sure how Jonathan feels about this patch being
added now [so late].

Though, technically if the chardev was already there, without all the
control in place [to enable IIO buffers and other stuff through the
chardev] then it's technically just a "marker" file.
Which arguably is a lot to have (i.e. chardev that should be unusable).

If it is usable with no control in place for buffers or other stuff
(i.e. I missed something), then I also don't know.

So, this patch on it's own can still be interpreted as an RFC.
See:
https://lore.kernel.org/linux-iio/20201121180246.772ad299@archlinux/

>
> --
> With Best Regards,
> Andy Shevchenko
